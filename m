Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65296C3DA45
	for <u-boot@archiver.kernel.org>; Fri, 12 Jul 2024 08:11:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFC6C88119;
	Fri, 12 Jul 2024 10:11:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0EF4885F5; Fri, 12 Jul 2024 10:11:26 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF2087FF7
 for <u-boot@lists.denx.de>; Fri, 12 Jul 2024 10:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 97F1D6196A74;
 Fri, 12 Jul 2024 10:11:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id yvz0zytINutY; Fri, 12 Jul 2024 10:11:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 0D22E6196A67;
 Fri, 12 Jul 2024 10:11:24 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id qaBxq3kKo_nu; Fri, 12 Jul 2024 10:11:23 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 9C6AB6196A40;
 Fri, 12 Jul 2024 10:11:23 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: patrick.delaunay@foss.st.com, yangshiji66@outlook.com,
 raymond.mao@linaro.org, n-jain1@ti.com, eugeneuriev@gmail.com,
 ilias.apalodimas@linaro.org, devarsht@ti.com, bmeng.cn@gmail.com,
 sjg@chromium.org, trini@konsulko.com, upstream+uboot@sigma-star.at,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH] reloc_bootstage: Fix out-of-bounds read
Date: Fri, 12 Jul 2024 10:11:18 +0200
Message-Id: <20240712081118.29189-1-richard@nod.at>
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

bootstage_get_size() returns the total size of the data structure
including associated records.
When copying from gd->bootstage, only the allocation size of gd->bootstag=
e
must be used. Otherwise too much memory is copied.

This bug caused no harm so far because gd->new_bootstage is always
large enough and reading beyond the allocation length of gd->bootstage
caused no problem due to the U-Boot memory layout.

Fix by using the correct size and perform the initial copy directly
in bootstage_relocate() to have the whole relocation process in the
same function.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 common/board_f.c   | 6 ------
 common/bootstage.c | 7 ++++++-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 039d6d712d..f4d87692b9 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -683,12 +683,6 @@ static int reloc_bootstage(void)
 	if (gd->flags & GD_FLG_SKIP_RELOC)
 		return 0;
 	if (gd->new_bootstage) {
-		int size =3D bootstage_get_size();
-
-		debug("Copying bootstage from %p to %p, size %x\n",
-		      gd->bootstage, gd->new_bootstage, size);
-		memcpy(gd->new_bootstage, gd->bootstage, size);
-		gd->bootstage =3D gd->new_bootstage;
 		bootstage_relocate();
 	}
 #endif
diff --git a/common/bootstage.c b/common/bootstage.c
index 0e6d80718f..aea5a318df 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -58,10 +58,15 @@ struct bootstage_hdr {
=20
 int bootstage_relocate(void)
 {
-	struct bootstage_data *data =3D gd->bootstage;
+	struct bootstage_data *data;
 	int i;
 	char *ptr;
=20
+	debug("Copying bootstage from %p to %p\n", gd->bootstage,
+	      gd->new_bootstage);
+	memcpy(gd->new_bootstage, gd->bootstage, sizeof(struct bootstage_data))=
;
+	data =3D gd->bootstage =3D gd->new_bootstage;
+
 	/* Figure out where to relocate the strings to */
 	ptr =3D (char *)(data + 1);
=20
--=20
2.35.3

