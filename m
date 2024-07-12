Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E42C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:24:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E52E8875D;
	Fri, 12 Jul 2024 10:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA62C88176; Fri, 12 Jul 2024 10:23:58 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 035DA886DB
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:23:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id CA9FC61966A4;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id t7QVMd0TI8EQ; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 78C666195FF7;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id NwuqzD3X8Uh7; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 4339F6195FD7;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/4] squashfs: Fix integer overflow in sqfs_inode_size()
Date: Fri, 12 Jul 2024 10:23:42 +0200
Message-Id: <20240712082344.8655-2-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240712082344.8655-1-richard@nod.at>
References: <20240712082344.8655-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

A carefully crafted squashfs filesystem can exhibit an extremly large
inode size and overflow the calculation in sqfs_inode_size().
As a consequence, the squashfs driver will read from wrong locations.

Fix by using __builtin_add_overflow() to detect the overflow.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/squashfs/sqfs_inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index d25cfb53e7..bb3ccd37e3 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -78,11 +78,16 @@ int sqfs_inode_size(struct squashfs_base_inode *inode=
, u32 blk_size)
=20
 	case SQFS_SYMLINK_TYPE:
 	case SQFS_LSYMLINK_TYPE: {
+		int size;
+
 		struct squashfs_symlink_inode *symlink =3D
 			(struct squashfs_symlink_inode *)inode;
=20
-		return sizeof(*symlink) +
-			get_unaligned_le32(&symlink->symlink_size);
+		if (__builtin_add_overflow(sizeof(*symlink),
+		    get_unaligned_le32(&symlink->symlink_size), &size))
+			return -EINVAL;
+
+		return size;
 	}
=20
 	case SQFS_BLKDEV_TYPE:
--=20
2.35.3

