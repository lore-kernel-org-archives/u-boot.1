Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EB78D59D78
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 16:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34B9483981;
	Fri, 12 Dec 2025 17:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="MeyZqEZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97D398367F; Fri, 12 Dec 2025 17:23:49 +0100 (CET)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CAB5835B3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 17:23:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kory.maincent@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id D6A21C19361;
 Fri, 12 Dec 2025 16:23:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F1539606DF;
 Fri, 12 Dec 2025 16:23:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 690C8103C8D8E; Fri, 12 Dec 2025 17:23:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1765556625; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=U/fuMnduR2s18od0LK3fQCHYowvBPNd5AkcfaCS1zHA=;
 b=MeyZqEZlBlOFre41VKlBykDNPtjRL6t/0ZnjwNBVU/teugav2Mwrm3cL+HVWhqwU5D5YI/
 VEZlT5O8aQ/XEktSj2Dqx6Yfeiswbu8lhelBItd0MA4oYPBZf3de3rGGIDmvyWx7YuCRCI
 C2aCpX8Zd8Xkb+icd/lx5X5f4XANo8IF04j1XWbOEkr2pZudERvCdDNhVhIbw/KEkxEHzb
 M4A75eMf1D8d+24rBOdxTxYlYvI31BpBRtggUSPMf3WhQqNTCz6LHaO9vMzfujjDG8p6Jq
 Ld7HPhdkrhzNzuFy622D8gmwjFG5xFpWwlfuwtkYHHwNLNgeLaZ2f41pcAi0Aw==
From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 12 Dec 2025 17:23:27 +0100
Subject: [PATCH v2 2/6] tools: Reorganize mkfwumdata tool into fwumdata_src
 directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-feature_fwumdata-v2-2-ad51572fbe79@bootlin.com>
References: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
In-Reply-To: <20251212-feature_fwumdata-v2-0-ad51572fbe79@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Greg Malysa <malysagreg@gmail.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
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

