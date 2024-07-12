Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DC4C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:24:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E92885F5;
	Fri, 12 Jul 2024 10:24:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF97388754; Fri, 12 Jul 2024 10:23:58 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E824988176
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id A1F6A6195FD7;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id ZGDanwqaLyVT; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 504886195FE0;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 1OHawQTdK0Oh; Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 0D2676195FC4;
 Fri, 12 Jul 2024 10:23:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com, trini@konsulko.com,
 upstream+uboot@sigma-star.at, Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/4] squashfs: Fix integer overflow in sqfs_resolve_symlink()
Date: Fri, 12 Jul 2024 10:23:41 +0200
Message-Id: <20240712082344.8655-1-richard@nod.at>
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

A carefully crafted squashfs filesystem can exhibit an inode size of 0xff=
ffffff,
as a consequence malloc() will do a zero allocation.
Later in the function the inode size is again used for copying data.
So an attacker can overwrite memory.
Avoid the overflow by using the __builtin_add_overflow() helper.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/squashfs/sqfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 1430e671a5..16a07c0622 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -422,8 +422,10 @@ static char *sqfs_resolve_symlink(struct squashfs_sy=
mlink_inode *sym,
 	char *resolved, *target;
 	u32 sz;
=20
-	sz =3D get_unaligned_le32(&sym->symlink_size);
-	target =3D malloc(sz + 1);
+	if (__builtin_add_overflow(get_unaligned_le32(&sym->symlink_size), 1, &=
sz))
+		return NULL;
+
+	target =3D malloc(sz);
 	if (!target)
 		return NULL;
=20
@@ -431,9 +433,9 @@ static char *sqfs_resolve_symlink(struct squashfs_sym=
link_inode *sym,
 	 * There is no trailling null byte in the symlink's target path, so a
 	 * copy is made and a '\0' is added at its end.
 	 */
-	target[sz] =3D '\0';
+	target[sz - 1] =3D '\0';
 	/* Get target name (relative path) */
-	strncpy(target, sym->symlink, sz);
+	strncpy(target, sym->symlink, sz - 1);
=20
 	/* Relative -> absolute path conversion */
 	resolved =3D sqfs_get_abs_path(base_path, target);
--=20
2.35.3

