Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B95E64015
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 21:18:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76B818941A;
	Thu, 21 Nov 2024 22:18:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EfkByfJx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C210896ED; Thu, 21 Nov 2024 22:18:00 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A8E89382
 for <u-boot@lists.denx.de>; Thu, 21 Nov 2024 22:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALLHtMl088355
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Nov 2024 15:17:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732223875;
 bh=7vjD6xaRcIotfJfoKr8p1apMqtRZDA+QOkbSGMMYs3c=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=EfkByfJxcRW7dHuorITSVcIojXYIdoXB3fjMDlP7tG2r8LoiX8mQrioon0iH5QEiD
 9VdJcsm6T1/S0tziHd4nYLi070/z6Pok8aE8qoV+vP7Bs355cqLWrSshmk/Qf2v1Gq
 FqClzWtELefNJY4qF4L+tzxp5IR+cVSfwKEvpSgg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ALLHtYH079599
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Nov 2024 15:17:55 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Nov 2024 15:17:54 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Nov 2024 15:17:55 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ALLHt9T122435;
 Thu, 21 Nov 2024 15:17:55 -0600
From: Bryan Brattlof <bb@ti.com>
Date: Thu, 21 Nov 2024 15:17:49 -0600
Subject: [PATCH 1/3] board: ti: am65x: migrate to OF_UPSTREAM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241121-am65x-v1-1-fe87aff1b5fc@ti.com>
References: <20241121-am65x-v1-0-fe87aff1b5fc@ti.com>
In-Reply-To: <20241121-am65x-v1-0-fe87aff1b5fc@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jan Kiszka <jan.kiszka@siemens.com>, Baocheng Su
 <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>, Bryan
 Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Rather than rely on manual updates from the arch/arm/dts directory,
enable CONFIG_OF_UPSTREAM to receive automatic device tree updates for
the am65x reference board.

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/dts/Makefile             | 4 +---
 arch/arm/dts/k3-am65x-binman.dtsi | 4 ++--
 arch/arm/mach-k3/am65x/Kconfig    | 1 +
 configs/am65x_evm_a53_defconfig   | 3 ++-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 042282f372354..0c8e84aca3e1e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1156,9 +1156,7 @@ dtb-$(CONFIG_STM32MP25X) += \
 	stm32mp257f-ev1.dtb
 
 dtb-$(CONFIG_SOC_K3_AM654) += \
-	k3-am654-base-board.dtb \
-	k3-am654-r5-base-board.dtb \
-	k3-am654-icssg2.dtbo
+	k3-am654-r5-base-board.dtb
 
 dtb-$(CONFIG_SOC_K3_J721E) += k3-j721e-r5-common-proc-board.dtb \
 			      k3-j7200-r5-common-proc-board.dtb \
diff --git a/arch/arm/dts/k3-am65x-binman.dtsi b/arch/arm/dts/k3-am65x-binman.dtsi
index d0cd4889cdefa..350775e42c2ab 100644
--- a/arch/arm/dts/k3-am65x-binman.dtsi
+++ b/arch/arm/dts/k3-am65x-binman.dtsi
@@ -95,10 +95,10 @@
 
 #ifdef CONFIG_TARGET_AM654_A53_EVM
 
-#define SPL_AM654_EVM_DTB "spl/dts/k3-am654-base-board.dtb"
+#define SPL_AM654_EVM_DTB "spl/dts/ti/k3-am654-base-board.dtb"
 #define AM654_EVM_DTB "u-boot.dtb"
 
-#define AM654_EVM_ICSSG2_DTBO "arch/arm/dts/k3-am654-icssg2.dtbo"
+#define AM654_EVM_ICSSG2_DTBO "ti/k3-am654-icssg2.dtbo"
 
 &binman {
 	ti-spl {
diff --git a/arch/arm/mach-k3/am65x/Kconfig b/arch/arm/mach-k3/am65x/Kconfig
index f17b641e1366d..72a8298aebf94 100644
--- a/arch/arm/mach-k3/am65x/Kconfig
+++ b/arch/arm/mach-k3/am65x/Kconfig
@@ -16,6 +16,7 @@ config TARGET_AM654_A53_EVM
 	select BOARD_LATE_INIT
 	select BINMAN
 	imply TI_I2C_BOARD_DETECT
+	select OF_UPSTREAM
 
 config TARGET_AM654_R5_EVM
 	bool "TI K3 based AM654 EVM running on R5"
diff --git a/configs/am65x_evm_a53_defconfig b/configs/am65x_evm_a53_defconfig
index cf7a2114883c5..b6df8b428c65f 100644
--- a/configs/am65x_evm_a53_defconfig
+++ b/configs/am65x_evm_a53_defconfig
@@ -14,7 +14,7 @@ CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0x680000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
-CONFIG_DEFAULT_DEVICE_TREE="k3-am654-base-board"
+CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am654-base-board"
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
@@ -76,6 +76,7 @@ CONFIG_CMD_UBI=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_OVERLAY_LIST="ti/k3-am654-icssg2"
 CONFIG_SPL_MULTI_DTB_FIT=y
 CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
 CONFIG_ENV_OVERWRITE=y

-- 
2.46.0

