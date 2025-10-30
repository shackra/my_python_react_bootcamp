"""shackra: Create monster table

Revision ID: 297da840f380
Revises:
Create Date: 2025-10-30 15:38:35.757107

"""

from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision: str = "297da840f380"
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    op.create_table(
        "monster",
        sa.Column("id", sa.Integer, primary_key=True),
        sa.Column("index", sa.Integer, unique=True, nullable=False),
        sa.Column("data", sa.JSON, nullable=False),
    )


def downgrade() -> None:
    """Downgrade schema."""
    op.drop_table("monster")
