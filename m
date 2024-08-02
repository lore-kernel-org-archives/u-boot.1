Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853C6C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 20:05:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF50F88BE4;
	Fri,  2 Aug 2024 22:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF63D88BF3; Fri,  2 Aug 2024 22:05:18 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C73E88622
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 22:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id BF8996196A6A;
 Fri,  2 Aug 2024 22:05:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id jnZI6phIC3LK; Fri,  2 Aug 2024 22:05:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 6BF9564C3B23;
 Fri,  2 Aug 2024 22:05:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id RJBJq0d3zmxa; Fri,  2 Aug 2024 22:05:16 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 29E396195FD3;
 Fri,  2 Aug 2024 22:05:16 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, trini@konsulko.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 jmcosta944@gmail.com, Richard Weinberger <richard@nod.at>
Subject: [PATCH] squashfs: Fix heap corruption in sqfs_search_dir()
Date: Fri,  2 Aug 2024 22:05:09 +0200
Message-Id: <20240802200509.2471-1-richard@nod.at>
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

res needs to be large enough to store both strings rem and target,
plus the path separator and the terminator.
Currently the space for the path separator is not accounted, so
the heap is corrupted by one byte.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/squashfs/sqfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index af7ff80a7b..b9314019b1 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -567,8 +567,11 @@ static int sqfs_search_dir(struct squashfs_dir_strea=
m *dirs, char **token_list,
 				ret =3D -ENOMEM;
 				goto out;
 			}
-			/* Concatenate remaining tokens and symlink's target */
-			res =3D malloc(strlen(rem) + strlen(target) + 1);
+			/*
+			 * Concatenate remaining tokens and symlink's target.
+			 * Allocate enough space for rem, target, '/' and '\0'.
+			 */
+			res =3D malloc(strlen(rem) + strlen(target) + 2);
 			if (!res) {
 				ret =3D -ENOMEM;
 				goto out;
--=20
2.35.3

