Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0188BC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 16:08:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FAB188A08;
	Wed, 31 Jul 2024 18:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FAA988A2A; Wed, 31 Jul 2024 18:08:02 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79DA08897F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 18:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=richard@nod.at
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id 29F0F61966C1;
 Wed, 31 Jul 2024 18:08:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id NYHuqLkWPPdn; Wed, 31 Jul 2024 18:07:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by lithops.sigma-star.at (Postfix) with ESMTP id A75E564A3D10;
 Wed, 31 Jul 2024 18:07:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
 by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id XWPERpSG2Lsu; Wed, 31 Jul 2024 18:07:59 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
 by lithops.sigma-star.at (Postfix) with ESMTPSA id 45E3061966C1;
 Wed, 31 Jul 2024 18:07:59 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: u-boot@lists.denx.de
Cc: upstream+uboot@sigma-star.at, patrick.delaunay@foss.st.com,
 marek.vasut+renesas@mailbox.org, yangshiji66@outlook.com,
 xypron.glpk@gmx.de, eugeneuriev@gmail.com, raymond.mao@linaro.org,
 devarsht@ti.com, bmeng.cn@gmail.com, sjg@chromium.org, trini@konsulko.com,
 Richard Weinberger <richard@nod.at>
Subject: [PATCH v2] bootstage: Fix out-of-bounds read in reloc_bootstage()
Date: Wed, 31 Jul 2024 18:07:54 +0200
Message-Id: <20240731160754.16263-1-richard@nod.at>
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
Changes since v1:
- Pass gd->new_bootstage to bootstage_relocate()
---
 common/board_f.c    | 8 +-------
 common/bootstage.c  | 8 ++++++--
 include/bootstage.h | 4 ++--
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/common/board_f.c b/common/board_f.c
index 29e185137a..21a8944e2b 100644
--- a/common/board_f.c
+++ b/common/board_f.c
@@ -683,13 +683,7 @@ static int reloc_bootstage(void)
 	if (gd->flags & GD_FLG_SKIP_RELOC)
 		return 0;
 	if (gd->new_bootstage) {
-		int size =3D bootstage_get_size();
-
-		debug("Copying bootstage from %p to %p, size %x\n",
-		      gd->bootstage, gd->new_bootstage, size);
-		memcpy(gd->new_bootstage, gd->bootstage, size);
-		gd->bootstage =3D gd->new_bootstage;
-		bootstage_relocate();
+		bootstage_relocate(gd->new_bootstage);
 	}
 #endif
=20
diff --git a/common/bootstage.c b/common/bootstage.c
index b6c268d9f4..49acc9078a 100644
--- a/common/bootstage.c
+++ b/common/bootstage.c
@@ -54,12 +54,16 @@ struct bootstage_hdr {
 	u32 next_id;		/* Next ID to use for bootstage */
 };
=20
-int bootstage_relocate(void)
+int bootstage_relocate(void *to)
 {
-	struct bootstage_data *data =3D gd->bootstage;
+	struct bootstage_data *data;
 	int i;
 	char *ptr;
=20
+	debug("Copying bootstage from %p to %p\n", gd->bootstage, to);
+	memcpy(to, gd->bootstage, sizeof(struct bootstage_data));
+	data =3D gd->bootstage =3D to;
+
 	/* Figure out where to relocate the strings to */
 	ptr =3D (char *)(data + 1);
=20
diff --git a/include/bootstage.h b/include/bootstage.h
index f4e77b09d7..57792648c4 100644
--- a/include/bootstage.h
+++ b/include/bootstage.h
@@ -258,7 +258,7 @@ void show_boot_progress(int val);
  * relocation, since memory can be overwritten later.
  * Return: Always returns 0, to indicate success
  */
-int bootstage_relocate(void);
+int bootstage_relocate(void *to);
=20
 /**
  * Add a new bootstage record
@@ -395,7 +395,7 @@ static inline ulong bootstage_add_record(enum bootsta=
ge_id id,
  * and won't even do that unless CONFIG_SHOW_BOOT_PROGRESS is defined
  */
=20
-static inline int bootstage_relocate(void)
+static inline int bootstage_relocate(void *to)
 {
 	return 0;
 }
--=20
2.35.3

