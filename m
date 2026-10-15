Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92872CC6B2F
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:28:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40E1E810ED;
	Thu, 15 Oct 2026 08:28:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R0XmmFSCLy2m; Thu, 15 Oct 2026 08:27:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6C41C810C1
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052879;
	b=LvIdhg8wUe3PF+NXcBPbNn7OvpgKfxHVFi8gWiwUdB3sYXm/RBpm6J01VqTcbRZe/Ic9
	 jXfUPxJ+rZ5KaOC4W7uZR1s8NwbdWtA6CGDsRk2V5MYku7pXnpebEbiMZO/M039COONEk
	 ymQ+yL3QB+vwhul/x9H0qSlhX03lEJ1BZGxTxyWnWfVo/bB6SwZ8o3zSeoYfEXjQ/2ojR
	 dWkLg4c/5jSGUOqK0Urs//EdtAuPz/E+g8sBHeljwmSueoe63AG0E5cYCG0g/HvkSjTnR
	 thh+rnM4P7wGi9VCYYGMUm/OF5lADECmk9W2OHHVoeqzTmGlKgb2KT1F9nedmh2rpUA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052879;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Virus-Scanned:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=89grcu2n6vLYWTEeYSx7kkUe18o1oaRu5cOWx2/LT78=;
	b=IqK+hd7yh0j1wxQksHQ4wo7rRsSmT3/lRZbnsEW1rU5+MnaW1j68OPmnZ71UQvwpNbjt
	 eCfHuozOhz+MyQHqEWwZlR4KPlx4zbI7av6E0wIQrtQ9cA71bxqdiYOy6buAZUe5ZtmCX
	 IejzN3kEYIMwWOm0dfCk5vE3Hz6tqBf3iC9GUOcdIjqQrMDv1DusvExX5Yi22NQ0ERfQV
	 Dh0Uhl8sItxgAQaOg/1wnM+MCE6mqWOe6enHWfVIFSvcM4B/ugxKf9yKo60QRLMhYmwWQ
	 k92K++pMVec37ZcDxsRp7AR0KsKPuirIzN8vRXC2sKBzOVtn5wdyso+vLex2m6/HLbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052879;
	bh=89grcu2n6vLYWTEeYSx7kkUe18o1oaRu5cOWx2/LT78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZrUmkyq67Ao2Y+uvmxvjeRNVmWHBPl2rrxoGMouRFOt20SjIbaWst0U2IaC0SmF96
	 +YeGaAxkUxU1pz8x9ro5UqMJ6/lCDvAgJmjFxiGhgT1HNbohjqVt4awW5Whyz5Xucv
	 4HoUVAL5cC4SCk6IL/r5qzEzusatVLCgdOwgVz6EyIx8B5U0m9p85gmOQ8q4g/wxXy
	 Soojj5Y9xbRsI0lHtPWbqHUoLqwQWChB8ukuNGY6sdYW9u01RciexicSWfL2Pov0aW
	 mZi9v7rriwrc1jZNjQEnt721YEEUjNlH7oM6XWfavZN9ewnTZsnzDWeQ5bLF3+pads
	 eXAwv/Vb8VLcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6C41C810C1;
	Thu, 15 Oct 2026 08:27:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 48BD7769
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2BBA440376
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aovJVUk_N4i8 for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 05:49:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 423C040053
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=92.121.34.21
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792043351;
 b=GArixXvgJsgQbEH06lIAikqSVhwtipaq2pHZc6WZOYeMk/1+6jzuxlt+X9oEZPFTfOvT
 IJLYWmw2JYLjk2JRiKdp77KSWU507nfZjV4Si/umxXJ21yxMsRQqEWQzMNzdiTR0bRLm3
 Qlcrp/vUh1p/+j+mAVoeG+YUo8MoY6Qrh/fdYZbOZd6umImeJDxsr5SFnD4jg2Exhcs2Q
 xwlcx8TcTaQQBfvDZ///hXFyu2JoPSVcv1mNza3HIgrVqHGhy2UA9vS41HWcSBSQINc5V
 gWIdkyc2WaQDDTlQDyqeUn42qBOdvAfSb64Kp9cRKaAGp+cC08H2NUTko/ECaYgFTOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792043351;
 h=Received-SPF:Received:Received:Received:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-Virus-Scanned;
 bh=89grcu2n6vLYWTEeYSx7kkUe18o1oaRu5cOWx2/LT78=;
 b=JhjV7KqVB3qjvgXXfKFS6+woaTNVVzPGKQ6HlfspQGauUhsCbTHkEa8wBJOfq+vgduSs
 CACP1h/wUeoBs1VZ20PbjnGo0xyY5wzD52/mXCYksgMqFujmqsn8dz6uMVK+Avd6WD5fv
 H+clHjruRTKqDdDV+wvH6EG2jbaWdOot9N8zp+hq/vbUu3O8ObDPQ18fHvg2tDvytWYsC
 Im++tFmNajZI9ufNLjGw/mTqLZFfV39pSAAJa7mvhxP54PsolmZV6+0xdmWurXDWcmojb
 HP5dUoGK+f7VTXqeGlgereq/lnBUrsvcxM3dA91fY9hzAUMoDHbsw3G5aPTHUtvItTg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oss.nxp.com;
 arc=none smtp.remote-ip=92.121.34.21
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=92.121.34.21;
 helo=inva021.nxp.com; envelope-from=qijian.guo@oss.nxp.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 423C040053
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 05:49:10 +0000 (UTC)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0212A20013B;
 Thu, 15 Oct 2026 07:39:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C14E1200053;
 Thu, 15 Oct 2026 07:39:54 +0200 (CEST)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id BC4F518000B5;
 Thu, 15 Oct 2026 13:39:52 +0800 (+08)
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
Date: Thu, 15 Oct 2026 14:39:49 +0900
Subject: [PATCH 2/2] imx: Add FRDM-IMX95-PRO initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-frdm-imx95-pro-v1-2-d354da03ca68@nxp.com>
References: <20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com>
In-Reply-To: <20261015-frdm-imx95-pro-v1-0-d354da03ca68@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, Lei Xu <lei.xu@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simona Toaca <simona.toaca@nxp.com>, 
 Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792042789; l=10403;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=AfOdqFHG/iZydTy61gRTt6tULySwPLYKwWeZUIuUbO4=;
 b=vX7RxDt7ORUN/ospGUcxliLkbhE2GVUp7Zb8WCAfCGwCKZqF1D5AN0Lil7XEXVyQtpjLPONdV
 4s3qW1V20WIBXknwPdMBVMH4TiGJgHglxs914Fxign15jv/MAToGX3f
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Virus-Scanned: ClamAV using ClamSMTP
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:27:54 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Joseph Guo <qijian.guo@nxp.com>

Add boot support and peripherals like eMMC/SD, UART, I2C, GPIO, ENETC0/1
and PCIE0/1 for iMX95 19x19 FRDM PRO board.
Updated imx95_frdm doc to include build instruction for FRDM-IMX95-PRO.

Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
Note: boot phase properties upstream have been sent [1]. These properties
can be removed in imx95-19x19-frdm-pro-uboot.dtsi after upstream changed.

[1] https://lore.kernel.org/all/sashiko-outbox-167770@kernel.org/
---
 arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi |  65 +++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   8 ++
 board/nxp/imx95_frdm/Kconfig                  |   2 +-
 board/nxp/imx95_frdm/MAINTAINERS              |   1 +
 configs/imx95_19x19_frdm_pro_defconfig        | 153 ++++++++++++++++++++++++++
 doc/board/nxp/imx95_frdm.rst                  |  29 ++++-
 include/configs/imx95_frdm.h                  |   4 +
 7 files changed, 260 insertions(+), 2 deletions(-)

diff --git a/arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi b/arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..f1fcd3630102e002a715af2d2798d75726041b96
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-frdm-pro-u-boot.dtsi
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d66d4193906f8bf4b84494f1e64428efda3acd75..1630695e1cd27293eac18a605dc736230e78e329 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -192,6 +192,14 @@ config TARGET_IMX95_15X15_FRDM
 	imply BOOTSTD_BOOTCOMMAND
 	imply OF_UPSTREAM
 
+config TARGET_IMX95_19X19_FRDM_PRO
+	bool "imx95_19x19_frdm_pro"
+	select OF_BOARD_FIXUP
+	select IMX95
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
+	imply OF_UPSTREAM
+
 config TARGET_IMX943_EVK
 	bool "imx943_evk"
 	select OF_BOARD_FIXUP
diff --git a/board/nxp/imx95_frdm/Kconfig b/board/nxp/imx95_frdm/Kconfig
index 0da9a56adadec661792c38b1258e4eb914af5aa5..c0d85f421fd83710826bafa0b249346ede821f80 100644
--- a/board/nxp/imx95_frdm/Kconfig
+++ b/board/nxp/imx95_frdm/Kconfig
@@ -1,4 +1,4 @@
-if TARGET_IMX95_15X15_FRDM
+if TARGET_IMX95_15X15_FRDM || TARGET_IMX95_19X19_FRDM_PRO
 
 config SYS_BOARD
 	default "imx95_frdm"
diff --git a/board/nxp/imx95_frdm/MAINTAINERS b/board/nxp/imx95_frdm/MAINTAINERS
index 33870f054e7452ed3af36f19236163d451c93665..01a200169e9e4ff5e8f6296e0a0631c06868f3a1 100644
--- a/board/nxp/imx95_frdm/MAINTAINERS
+++ b/board/nxp/imx95_frdm/MAINTAINERS
@@ -4,3 +4,4 @@ S:	Maintained
 F:	board/nxp/imx95_frdm/
 F:	include/configs/imx95_frdm.h
 F:	configs/imx95_15x15_frdm_defconfig
+F:      configs/imx95_19x19_frdm_pro_defconfig
diff --git a/configs/imx95_19x19_frdm_pro_defconfig b/configs/imx95_19x19_frdm_pro_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..14ff08d5d34ae92e463345a39bb5d2831fb1824b
--- /dev/null
+++ b/configs/imx95_19x19_frdm_pro_defconfig
@@ -0,0 +1,153 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_frdm"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-frdm-pro"
+CONFIG_TARGET_IMX95_19X19_FRDM_PRO=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-frdm-pro.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_REMOTEPROC=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_SM_CPU=y
+CONFIG_IMX_SM_LMM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REMOTEPROC_IMX=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_WDT=y
diff --git a/doc/board/nxp/imx95_frdm.rst b/doc/board/nxp/imx95_frdm.rst
index 85ef9022e76fc0d8f2a5524128309939f22f4715..a0a5422bf8a7ba574f38dc19898f19f4dc4a6f8a 100644
--- a/doc/board/nxp/imx95_frdm.rst
+++ b/doc/board/nxp/imx95_frdm.rst
@@ -3,7 +3,7 @@
 imx95_frdm
 =======================
 
-U-Boot for the NXP i.MX95 15x15 FRDM board
+U-Boot for the NXP i.MX95 15x15 FRDM board & i.MX95 19x19 FRDM PRO board
 
 Quick Start
 -----------
@@ -73,6 +73,13 @@ i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
    $ make board=mx95lp4x-15 oei=ddr DEBUG=1 r=B0 all
    $ cp build/mx95lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
 
+i.MX95 B0 silicon version on 19x19 LPDDR5 FRDM PRO Board
+
+.. code-block:: bash
+
+   $ make board=mx95lp5-19 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp5-19/ddr/oei-m33-ddr.bin $(srctree)
+
 Get and Build System Manager Image
 --------------------------------------
 
@@ -88,9 +95,21 @@ branch: master
    $ export TOOLS=$PWD
    $ git clone -b master https://github.com/nxp-imx/imx-sm.git
    $ cd imx-sm
+
+i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
+
+.. code-block:: bash
+
    $ make config=mx95evk all
    $ cp build/mx95evk/m33_image.bin $(srctree)
 
+i.MX95 B0 silicon version on 19x19 LPDDR5 FRDM PRO Board
+
+.. code-block:: bash
+
+   $ make config=other/mx95frdm-pro all
+   $ cp build/other/mx95frdm-pro/m33_image.bin $(srctree)
+
 Get and Build the ARM Trusted Firmware
 --------------------------------------
 
@@ -119,6 +138,14 @@ i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
    $ make imx95_15x15_frdm_defconfig
    $ make
 
+i.MX95 B0 silicon version on 19x19 LPDDR5 FRDM PRO Board
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_frdm_pro_defconfig
+   $ make
+
 Copy imx-boot-imx95.bin to the MicroSD card:
 
 .. code-block:: bash
diff --git a/include/configs/imx95_frdm.h b/include/configs/imx95_frdm.h
index e64294a2bb15a025351b9bc9f2c8a0ee0a7e9224..78a28d7a5a137070c29ac25a0b219599866f6923 100644
--- a/include/configs/imx95_frdm.h
+++ b/include/configs/imx95_frdm.h
@@ -18,7 +18,11 @@
 
 #define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
 
+#ifdef CONFIG_TARGET_IMX95_19X19_FRDM_PRO
+#define PHYS_SDRAM_2_SIZE		0x380000000UL /* 14GB (Totally 16GB) */
+#else
 #define PHYS_SDRAM_2_SIZE		0x180000000 /* 6GB (Totally 8GB) */
+#endif
 
 #define CFG_SYS_SECURE_SDRAM_BASE   0x8A000000 /* Secure DDR region for A55 */
 #define CFG_SYS_SECURE_SDRAM_SIZE   0x04000000

-- 
2.34.1

