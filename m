Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F8E5C52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:55:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EEA988BF0;
	Fri,  9 Aug 2024 11:55:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EF9887B4; Fri,  9 Aug 2024 11:55:05 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A31A885B3
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:55:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 9FB1761966A0;
 Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id gSz17Hbb66AH; Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 1050C6196A56;
 Fri,  9 Aug 2024 11:55:02 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id o-2qfNQl8Mhn; Fri,  9 Aug 2024 11:55:01 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id AF2C361966A0;
 Fri,  9 Aug 2024 11:55:01 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, Jixiong.Hu@mediatek.com, marek.vasut+renesas@mailbox.org,
 patrick.delaunay@foss.st.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, seanga2@gmail.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH v2 1/3] ext4: Fix integer overflow in ext4fs_read_symlink()
Date: Fri,  9 Aug 2024 11:54:28 +0200
Message-Id: <20240809095430.3656-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
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

While zalloc() takes a size_t type, adding 1 to the le32 variable
will overflow.
A carefully crafted ext4 filesystem can exhibit an inode size of 0xffffff=
ff
and as consequence zalloc() will do a zero allocation.

Later in the function the inode size is again used for copying data.
So an attacker can overwrite memory.

Avoid the overflow by using the __builtin_add_overflow() helper.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/ext4/ext4_common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 52152a2295..36999b608f 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -2181,13 +2181,18 @@ static char *ext4fs_read_symlink(struct ext2fs_no=
de *node)
 	struct ext2fs_node *diro =3D node;
 	int status;
 	loff_t actread;
+	size_t alloc_size;
=20
 	if (!diro->inode_read) {
 		status =3D ext4fs_read_inode(diro->data, diro->ino, &diro->inode);
 		if (status =3D=3D 0)
 			return NULL;
 	}
-	symlink =3D zalloc(le32_to_cpu(diro->inode.size) + 1);
+
+	if (__builtin_add_overflow(le32_to_cpu(diro->inode.size), 1, &alloc_siz=
e))
+		return NULL;
+
+	symlink =3D zalloc(alloc_size);
 	if (!symlink)
 		return NULL;
=20
--=20
2.35.3

