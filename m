Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240D0C624D0
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 10:32:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 202CA80874;
	Wed,  2 Sep 2026 10:32:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y-jctoxiF2JC; Wed,  2 Sep 2026 10:32:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788345125;
	bh=cXiaFU0eM31o+lHdklXsZ8xT4+6Su36WExCaEqpjRms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mriKY3PFTEcT/N5KKqSICkFWtDkOTaP3ndWdkfy1bLooMdf15yHdzYlFC1qOl/2+N
	 zxKzlGtZU0PEu+fiyfnLEJTJyEAWg7HH3YSJdfZR164SsGQoBNRTkCKYCg6lYvofkP
	 p63KBNck8j4gDYQdd8ccCLvTzqQ6E0K3sTsZGW02NuPvIyegUaf6Uq3aS0ga+hFZVX
	 JCUeSX34q8WM906+sBRcAP0GICVvQguw2yWihsSEZuEh60T/++vnMhhWnl7YyrHLd9
	 z/0Gj+fJSwmUcy4tvuqR6KTvYo5sbanjDBGD0jl90/JY1LZ+Pw8s2PQzUvvt6AA8v3
	 MlkhXnPpPgg2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1B1D80798;
	Wed,  2 Sep 2026 10:32:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F5E0118
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 10:06:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 916AF80F2F
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 10:06:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q4Z8mgPZrpRi for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 10:06:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=45.254.49.197;
 helo=mail-m49197.qiye.163.com; envelope-from=amadeus@jmu.edu.cn;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com
 [45.254.49.197])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7F08A80F28
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 10:06:18 +0000 (UTC)
Received: from Vostro-3710.. (unknown [14.220.232.127])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4c4222fea;
 Wed, 2 Sep 2026 18:01:10 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Chukun Pan <amadeus@jmu.edu.cn>, Quentin Schulz <u-boot@0leil.net>,
 Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH 2/2] board: rockchip: add HINLINK H28K
Date: Wed,  2 Sep 2026 18:01:01 +0800
Message-Id: <20260902100101.2001026-2-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902100101.2001026-1-amadeus@jmu.edu.cn>
References: <20260902100101.2001026-1-amadeus@jmu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa06190bcda03a2kunm8c6ed80d1e7f34
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSUxNVh1ITk8dSBoeH0hJGVYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKT1VJSUtVSUhJVUpJTFlXWRYaDxIVHRRZQVlPS0hVSktJT0
 9PS1VKS0tVS1kG
X-Mailman-Approved-At: Wed, 02 Sep 2026 10:31:56 +0000
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

The HINLINK H28K is a single board computer based on the
RK3528 SoC. Add support for the HINLINK H28K board.

Features tested on HINLINK H28K:
- SD-card boot
- eMMC boot
- Ethernet

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi | 11 ++++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 ++
 configs/hinlink-h28k-rk3528_defconfig        | 64 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 4 files changed, 82 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
 create mode 100644 configs/hinlink-h28k-rk3528_defconfig

diff --git a/arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi b/arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
new file mode 100644
index 000000000000..3e2fbd81da17
--- /dev/null
+++ b/arch/arm/dts/rk3528-hinlink-h28k-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&vdd_arm {
+	regulator-init-microvolt = <953000>;
+};
+
+&vdd_logic {
+	regulator-init-microvolt = <900000>;
+};
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index 111fe0270dfd..95543b40dd3e 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -4,6 +4,12 @@ S:	Maintained
 F:	arch/arm/dts/rk3528-generic*
 F:	configs/generic-rk3528_defconfig
 
+HINLINK-H28K-RK3528
+M:	Chukun Pan <amadeus@jmu.edu.cn>
+S:	Maintained
+F:	arch/arm/dts/rk3528-hinlink-h28k*
+F:	configs/hinlink-h28k-rk3528_defconfig
+
 NANOPI-ZERO2-RK3528
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/hinlink-h28k-rk3528_defconfig b/configs/hinlink-h28k-rk3528_defconfig
new file mode 100644
index 000000000000..bcd87bc02381
--- /dev/null
+++ b/configs/hinlink-h28k-rk3528_defconfig
@@ -0,0 +1,64 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-hinlink-h28k"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-hinlink-h28k.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_BOARD_RNG_SEED=y
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_ROCKUSB=y
+CONFIG_CMD_USB_MASS_STORAGE=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+# CONFIG_USB_FUNCTION_FASTBOOT is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_DM_MDIO=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_DOWNLOAD=y
+CONFIG_USB_FUNCTION_ROCKUSB=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de2df3046e28..2c0232d36a0b 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -105,6 +105,7 @@ List of mainline supported Rockchip boards:
      - ArmSoM Sige1 (sige1-rk3528)
      - FriendlyElec NanoPi Zero2 (nanopi-zero2-rk3528)
      - Generic RK3528 (generic-rk3528)
+     - HINLINK H28K (hinlink-h28k-rk3528)
      - Radxa E20C (radxa-e20c-rk3528)
      - Radxa ROCK 2A/2F (rock-2-rk3528)
 
-- 
2.34.1

