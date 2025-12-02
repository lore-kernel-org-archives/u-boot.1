Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7232ED1171E
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 17:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 565FB83EC0;
	Tue,  2 Dec 2025 18:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="0JAgBuVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3297883EC0; Tue,  2 Dec 2025 18:29:00 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A816383C64
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 18:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2842DC15D72;
 Tue,  2 Dec 2025 17:28:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 63C1B606D6;
 Tue,  2 Dec 2025 17:28:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EEE2911919E27; Tue,  2 Dec 2025 18:28:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1764696534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=U/fuMnduR2s18od0LK3fQCHYowvBPNd5AkcfaCS1zHA=;
 b=0JAgBuVjnIs/9ELKij4JgkBgxuxHd7Q4Qc8HTU/PHt+7flLnBXKnuRrDnP9NDmlj4mFuue
 XX9fdTrdkcvPMXCxOXdD4GPNDHwGc96r+gSCsg0hAYNAzhtalUHRZN3cidygVTEPjInARK
 xdVHbAVy5bcSng1kOHF4EaO8TJZUvIiFIjl1jH1FNq9YPKUgTFLf/Vk9hy5VJzXWXCkUps
 IsHCeX8Co/gR6BnLzngsLRb02U7NtimaWkxAEjO0Hmq2+xu4SK6icc17z3fCUrvfFblc96
 xCIkAQ1SmCqGxkD1CK8maZKVIbvUE+Z0ua16r3Pr0GVBmoS1bLNAF4TCjoZwcg==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue, 02 Dec 2025 18:28:27 +0100
Subject: [PATCH 2/6] tools: Reorganize mkfwumdata tool into fwumdata_src
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251202-feature_fwumdata-v1-2-d55154de4103@bootlin.com>
References: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
In-Reply-To: <20251202-feature_fwumdata-v1-0-d55154de4103@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Heiko Schocher <hs@nabladev.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 E Shattow <e@freeshell.de>, Raymond Mao <raymondmaoca@gmail.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Shiji Yang <yangshiji66@outlook.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Yao Zi <ziyao@disroot.org>, 
 Leonard Anderweit <l.anderweit@phytec.de>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

Update FWU metadata-related tools by moving mkfwumdata.c into a new
tools/fwumdata_src/ directory structure. This refactoring prepares for the
addition of the fwumdata runtime tool, which will allow editing FWU
metadata directly from the target.

The Kconfig and Makefile entries are also moved into separate files within
the new directory (Kconfig and fwumdata.mk respectively) to keep all FWU
metadata tool configurations together and improve maintainability.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 MAINTAINERS                           | 3 ++-
 tools/Kconfig                         | 9 +--------
 tools/Makefile                        | 4 +---
 tools/fwumdata_src/Kconfig            | 8 ++++++++
 tools/fwumdata_src/fwumdata.mk        | 7 +++++++
 tools/{ => fwumdata_src}/mkfwumdata.c | 0
 6 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b43dae882b3..5f560f4a94e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,9 +1250,10 @@ FWU Multi Bank Update
 M:	Sughosh Ganu <sughosh.ganu@linaro.org>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-efi.git
+F:	doc/mkfwumdata.1
 F:	lib/fwu_updates/*
 F:	drivers/fwu-mdata/*
-F:	tools/mkfwumdata.c
+F:	tools/fwumdata_src/mkfwumdata.c
 
 GATEWORKS_SC
 M:	Tim Harvey <tharvey@gateworks.com>
diff --git a/tools/Kconfig b/tools/Kconfig
index 652b0f22557..9fe8b0f87d8 100644
--- a/tools/Kconfig
+++ b/tools/Kconfig
@@ -194,13 +194,6 @@ config LUT_SEQUENCE
 	help
 	  Look Up Table Sequence
 
-config TOOLS_MKFWUMDATA
-	bool "Build mkfwumdata command"
-	default y if FWU_MULTI_BANK_UPDATE
-	help
-	  This command allows users to create a raw image of the FWU
-	  metadata for initial installation of the FWU multi bank
-	  update on the board. The installation method depends on
-	  the platform.
+source tools/fwumdata_src/Kconfig
 
 endmenu
diff --git a/tools/Makefile b/tools/Makefile
index ae6a3052646..1c58bac3033 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -271,9 +271,7 @@ mkeficapsule-objs := generated/lib/uuid.o \
 	mkeficapsule.o
 hostprogs-$(CONFIG_TOOLS_MKEFICAPSULE) += mkeficapsule
 
-mkfwumdata-objs := mkfwumdata.o generated/lib/crc32.o
-HOSTLDLIBS_mkfwumdata += -luuid
-hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
+include tools/fwumdata_src/fwumdata.mk
 
 # We build some files with extra pedantic flags to try to minimize things
 # that won't build on some weird host compiler -- though there are lots of
diff --git a/tools/fwumdata_src/Kconfig b/tools/fwumdata_src/Kconfig
new file mode 100644
index 00000000000..c033c560e8d
--- /dev/null
+++ b/tools/fwumdata_src/Kconfig
@@ -0,0 +1,8 @@
+config TOOLS_MKFWUMDATA
+	bool "Build mkfwumdata command"
+	default y if FWU_MULTI_BANK_UPDATE
+	help
+	  This command allows users to create a raw image of the FWU
+	  metadata for initial installation of the FWU multi bank
+	  update on the board. The installation method depends on
+	  the platform.
diff --git a/tools/fwumdata_src/fwumdata.mk b/tools/fwumdata_src/fwumdata.mk
new file mode 100644
index 00000000000..2ce618ef2ed
--- /dev/null
+++ b/tools/fwumdata_src/fwumdata.mk
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# (C) Copyright 2025, Kory Maincent <kory.maincent@bootlin.com>
+
+mkfwumdata-objs := fwumdata_src/mkfwumdata.o generated/lib/crc32.o
+HOSTLDLIBS_mkfwumdata += -luuid
+hostprogs-$(CONFIG_TOOLS_MKFWUMDATA) += mkfwumdata
diff --git a/tools/mkfwumdata.c b/tools/fwumdata_src/mkfwumdata.c
similarity index 100%
rename from tools/mkfwumdata.c
rename to tools/fwumdata_src/mkfwumdata.c

-- 
2.43.0

