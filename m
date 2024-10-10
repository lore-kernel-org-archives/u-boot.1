Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BA5CF07A8
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 05:56:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13129890DF;
	Thu, 10 Oct 2024 07:56:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="Yig4ItyG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BADC089139; Thu, 10 Oct 2024 07:56:02 +0200 (CEST)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D6F890D9
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 07:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20241010055557d237393343c7ec92e2 for <u-boot@lists.denx.de>;
 Thu, 10 Oct 2024 07:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=3CnbBnAJpo2ALBM54FfN0FsU8PrZRfh/F8rNW9hrPJw=;
 b=Yig4ItyG4clLU9noUgGBMlbsIHZ17CF7GIhydfyBAeCSi+sMVlANMeBHUMo1B16EkCBy9Y
 FY1dRaw0aUl7MdYIrh2eeiGINSBC6SQrTz3O24/3MkplZxczCasBnJ8S35qJ7EXQNcWUPAVF
 xiYaOEKvUEkjupSfgywguzAG/v66eCUzmah90qwb+GjQZJKI71+mPUVN6i0afnPlnDpqyM+Z
 fMFB7A9B7tPbHUzuTyOfuHkondXXT+t7juNa9B1Ko8ym6lAiPec7T62pwHCMb2bL75xNH47c
 9v3zJCtHP31qfwcjILLksgcBlSTQDYqXZSh71gkhIUPvyQB2dFC2n4KA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bryan Brattlof <bb@ti.com>,
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/11] board: siemens: iot2050: Stop using special spl DT
 sources
Date: Thu, 10 Oct 2024 07:55:50 +0200
Message-ID: <2e514f94f6366f4446ef5b681c16e633e3f4a54b.1728539755.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
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

From: Jan Kiszka <jan.kiszka@siemens.com>

We can simply use the default DT, Basic PG1, because no nodes that are
different between the variants play a role for SPL. Will help with the
migration to OF_UPSTREAM.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 arch/arm/dts/Makefile                        |  1 -
 arch/arm/dts/k3-am65-iot2050-boot-image.dtsi |  4 ++--
 arch/arm/dts/k3-am65-iot2050-spl.dts         | 17 -----------------
 configs/iot2050_defconfig                    |  1 -
 4 files changed, 2 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/dts/k3-am65-iot2050-spl.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 65176c8fb83..ab7705e5ed9 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1180,7 +1180,6 @@ dtb-$(CONFIG_STM32MP25X) += \
 dtb-$(CONFIG_SOC_K3_AM654) += \
 	k3-am654-base-board.dtb \
 	k3-am654-r5-base-board.dtb \
-	k3-am65-iot2050-spl.dtb \
 	k3-am6528-iot2050-basic.dtb \
 	k3-am6528-iot2050-basic-pg2.dtb \
 	k3-am6548-iot2050-advanced.dtb \
diff --git a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
index 3a6db91e132..e17cd78e56c 100644
--- a/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
+++ b/arch/arm/dts/k3-am65-iot2050-boot-image.dtsi
@@ -84,12 +84,12 @@
 				};
 
 				fdt-0 {
-					description = "k3-am65-iot2050-spl.dtb";
+					description = "k3-am6528-iot2050-basic.dtb";
 					type = "flat_dt";
 					arch = "arm";
 					compression = "none";
 					blob-ext {
-						filename = "spl/dts/k3-am65-iot2050-spl.dtb";
+						filename = "spl/dts/k3-am6528-iot2050-basic.dtb";
 					};
 				};
 			};
diff --git a/arch/arm/dts/k3-am65-iot2050-spl.dts b/arch/arm/dts/k3-am65-iot2050-spl.dts
deleted file mode 100644
index 4e668fa3e03..00000000000
--- a/arch/arm/dts/k3-am65-iot2050-spl.dts
+++ /dev/null
@@ -1,17 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) Siemens AG, 2018-2021
- *
- * Authors:
- *   Jan Kiszka <jan.kiszka@siemens.com>
- */
-
-/dts-v1/;
-
-#include "k3-am65-iot2050-common.dtsi"
-#include "k3-am65-iot2050-common-u-boot.dtsi"
-
-/ {
-	compatible = "siemens,iot2050", "ti,am654";
-	model = "Siemens IOT2050";
-};
diff --git a/configs/iot2050_defconfig b/configs/iot2050_defconfig
index 401e57adeca..22990ba1f96 100644
--- a/configs/iot2050_defconfig
+++ b/configs/iot2050_defconfig
@@ -80,7 +80,6 @@ CONFIG_CMD_TIME=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_SPL_MULTI_DTB_FIT=y
-CONFIG_SPL_OF_LIST="k3-am65-iot2050-spl"
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
-- 
2.43.0

