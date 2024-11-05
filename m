Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9536CD40CE0
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 23:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 522C08917B;
	Wed,  6 Nov 2024 00:08:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1730848081;
	bh=EUw5yxhyr29yC2btaaS2IwWZ9yzqPxVoh2BEe393AC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N2Lcpyg70Nj15LFpwdoQBSWEjsaLGF3x87HRLC1WjTAB6Uuk2Y0/TuNFTmyCJ6FyI
	 6NMqZQ0vD4FZ15fGU8VvNRX3gTYawLaucgNZKpPi+wE4Vc/ieTGC97DyXmqDl5pR4A
	 HhAjt/Xr6dcv7PE3rzv0woqtrbvH4y49M4+ioPDKNWMYbcer9NTon302bBbta/fpSQ
	 8Umn6ZYTrhvvFrc1gdf1wwh+WdR+DVo58S/YzA3nm797+WqcUatb3ncUNglGBatn5k
	 VBvbc0RUrgCJQ6DYXlk6updcZ1XOVXbelV4xYgZyQ6ZfMfeue4VXapnU/A7wMWh5bU
	 BGE15/MQkPm6w==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A290688E96;
 Wed,  6 Nov 2024 00:07:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1730848080;
 bh=EUw5yxhyr29yC2btaaS2IwWZ9yzqPxVoh2BEe393AC8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=itvLqIrVsDYuOCufgAAGKcgFMzjuywvHHOd9X0lOM4OddEMKQ/0ZSWPRyjL3GmwWP
 MxYtecY9N8Z0piZ7U+1ZwczMzUgx7OQRt8ftgsZaQtU8BkE1eybkmhcNyBwRo8KVZx
 S1j9jmK286uNl63diCG9YE37on8c9nh13MnLhXkftzO3cWLSIA2ETz+QKYRffvZfFE
 pKM6pr963B1wftRg9YrJh3RO0U2RH1IS4MTQmSASwoTPIsUWm0hr2s9JWmsa2Q8+r5
 lrZn9/gyVh+gMsVfbVKq4tPM7a9SePIcQMIlpnqAIfOzzf3BITMx8BHyPcUQWCfB6p
 4NTUF9JdCVAOw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Andreas Geisreiter <ageisreiter@dh-electronics.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
Subject: [PATCH 2/2] ARM: dts: imx: Switch to using upstream DT on DH i.MX6
 DHCOM
Date: Wed,  6 Nov 2024 00:06:53 +0100
Message-ID: <20241105230724.159755-2-marex@denx.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105230724.159755-1-marex@denx.de>
References: <20241105230724.159755-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enable OF_UPSTREAM to use upstream DT and add nxp/imx/ prefix to the
DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Andreas Geisreiter <ageisreiter@dh-electronics.de>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@dh-electronics.com
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/Makefile                 |  6 +-----
 arch/arm/dts/imx6dl-dhcom-pdk2.dts    | 15 --------------
 arch/arm/dts/imx6dl-dhcom-picoitx.dts | 20 ------------------
 arch/arm/dts/imx6q-dhcom-pdk2.dts     | 25 ----------------------
 arch/arm/dts/imx6s-dhcom-drc02.dts    | 30 ---------------------------
 configs/dh_imx6_defconfig             |  5 +++--
 6 files changed, 4 insertions(+), 97 deletions(-)
 delete mode 100644 arch/arm/dts/imx6dl-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx6dl-dhcom-picoitx.dts
 delete mode 100644 arch/arm/dts/imx6q-dhcom-pdk2.dts
 delete mode 100644 arch/arm/dts/imx6s-dhcom-drc02.dts

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index aeccfa93fc5..6ecc7bbdf25 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -778,8 +778,6 @@ dtb-y += \
 	imx6dl-cubox-i.dtb \
 	imx6dl-cubox-i-emmc-som-v15.dtb \
 	imx6dl-cubox-i-som-v15.dtb \
-	imx6dl-dhcom-pdk2.dtb \
-	imx6dl-dhcom-picoitx.dts \
 	imx6dl-gw51xx.dtb \
 	imx6dl-gw52xx.dtb \
 	imx6dl-gw53xx.dtb \
@@ -811,8 +809,7 @@ dtb-y += \
 	imx6dl-sabreauto.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-sielaff.dtb \
-	imx6dl-wandboard-revd1.dtb \
-	imx6s-dhcom-drc02.dtb
+	imx6dl-wandboard-revd1.dtb
 
 endif
 
@@ -824,7 +821,6 @@ dtb-y += \
 	imx6q-cubox-i.dtb \
 	imx6q-cubox-i-emmc-som-v15.dtb \
 	imx6q-cubox-i-som-v15.dtb \
-	imx6q-dhcom-pdk2.dtb \
 	imx6q-display5.dtb \
 	imx6q-gw51xx.dtb \
 	imx6q-gw52xx.dtb \
diff --git a/arch/arm/dts/imx6dl-dhcom-pdk2.dts b/arch/arm/dts/imx6dl-dhcom-pdk2.dts
deleted file mode 100644
index d59687490cf..00000000000
--- a/arch/arm/dts/imx6dl-dhcom-pdk2.dts
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: (GPL-2.0+)
-/*
- * Copyright (C) 2019 DH electronics GmbH
- */
-
-/dts-v1/;
-
-#include "imx6dl.dtsi"
-#include "imx6qdl-dhcom-som.dtsi"
-#include "imx6qdl-dhcom-pdk2.dtsi"
-
-/ {
-	model = "Freescale i.MX6 Duallite/Solo DHCOM Premium Developer Kit (2)";
-	compatible = "dh,imx6dl-dhcom-pdk2", "dh,imx6dl-dhcom", "fsl,imx6dl";
-};
diff --git a/arch/arm/dts/imx6dl-dhcom-picoitx.dts b/arch/arm/dts/imx6dl-dhcom-picoitx.dts
deleted file mode 100644
index 038bb002555..00000000000
--- a/arch/arm/dts/imx6dl-dhcom-picoitx.dts
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2021 DH electronics GmbH
- *
- * DHCOM iMX6 variant:
- * DHCM-iMX6DL-C0800-R102-F0819-E-SD-RTC-T-HS-I-01D2
- * DHCOM PCB number: 493-300 or newer
- * PicoITX PCB number: 487-600 or newer
- */
-/dts-v1/;
-
-#include "imx6dl.dtsi"
-#include "imx6qdl-dhcom-som.dtsi"
-#include "imx6qdl-dhcom-picoitx.dtsi"
-
-/ {
-	model = "DH electronics i.MX6DL DHCOM on PicoITX";
-	compatible = "dh,imx6dl-dhcom-picoitx", "dh,imx6dl-dhcom-som",
-		     "fsl,imx6dl";
-};
diff --git a/arch/arm/dts/imx6q-dhcom-pdk2.dts b/arch/arm/dts/imx6q-dhcom-pdk2.dts
deleted file mode 100644
index d4d57370615..00000000000
--- a/arch/arm/dts/imx6q-dhcom-pdk2.dts
+++ /dev/null
@@ -1,25 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2015-2021 DH electronics GmbH
- * Copyright (C) 2018 Marek Vasut <marex@denx.de>
- *
- * DHCOM iMX6 variant:
- * DHCM-iMX6Q-C0800-R102-F0819-E-SD-RTC-T-HS-I-01D2
- * DHCOM PCB number: 493-300 or newer
- * PDK2 PCB number: 516-400 or newer
- */
-/dts-v1/;
-
-#include "imx6q.dtsi"
-#include "imx6qdl-dhcom-som.dtsi"
-#include "imx6qdl-dhcom-pdk2.dtsi"
-
-/ {
-	model = "DH electronics i.MX6Q DHCOM on Premium Developer Kit (2)";
-	compatible = "dh,imx6q-dhcom-pdk2", "dh,imx6q-dhcom-som",
-		     "fsl,imx6q";
-};
-
-&sata {
-	status = "okay";
-};
diff --git a/arch/arm/dts/imx6s-dhcom-drc02.dts b/arch/arm/dts/imx6s-dhcom-drc02.dts
deleted file mode 100644
index 4077b607c29..00000000000
--- a/arch/arm/dts/imx6s-dhcom-drc02.dts
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright (C) 2021 DH electronics GmbH
- *
- * DHCOM iMX6 variant:
- * DHCM-iMX6S-C0800-R102-F0409-E-CAN2-RTC-I-01D2
- * DHCOM PCB number: 493-400 or newer
- * DRC02 PCB number: 568-100 or newer
- */
-/dts-v1/;
-
-/*
- * The kernel only distinguishes between i.MX6 Quad and DualLite,
- * but the Solo is actually a DualLite with only one CPU. So use
- * DualLite for the Solo and disable one CPU node.
- */
-
-#include "imx6dl.dtsi"
-#include "imx6qdl-dhcom-som.dtsi"
-#include "imx6qdl-dhcom-drc02.dtsi"
-
-/ {
-	model = "DH electronics i.MX6S DHCOM on DRC02";
-	compatible = "dh,imx6s-dhcom-drc02", "dh,imx6s-dhcom-som",
-		     "fsl,imx6dl";
-
-	cpus {
-		/delete-node/ cpu@1;
-	};
-};
diff --git a/configs/dh_imx6_defconfig b/configs/dh_imx6_defconfig
index 468ec3805f6..43ac5a567ba 100644
--- a/configs/dh_imx6_defconfig
+++ b/configs/dh_imx6_defconfig
@@ -5,11 +5,12 @@ CONFIG_ARCH_MX6=y
 CONFIG_MX6QDL=y
 CONFIG_TARGET_DHCOMIMX6=y
 CONFIG_SPL_SYS_L2_PL310=y
-CONFIG_DEFAULT_DEVICE_TREE="imx6q-dhcom-pdk2"
+CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-dhcom-pdk2"
 CONFIG_MX6_DDRCAL=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_OF_LIBFDT_OVERLAY=y
-CONFIG_OF_LIST="imx6q-dhcom-pdk2 imx6dl-dhcom-pdk2 imx6s-dhcom-drc02 imx6dl-dhcom-picoitx"
+CONFIG_OF_LIST="nxp/imx/imx6q-dhcom-pdk2 nxp/imx/imx6dl-dhcom-pdk2 nxp/imx/imx6s-dhcom-drc02 nxp/imx/imx6dl-dhcom-picoitx"
+CONFIG_OF_UPSTREAM=y
 CONFIG_FIT_VERBOSE=y
 CONFIG_MULTI_DTB_FIT=y
 CONFIG_LTO=y
-- 
2.45.2

