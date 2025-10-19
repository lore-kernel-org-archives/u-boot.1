Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC02CCD1A5
	for <u-boot@archiver.kernel.org>; Sun, 19 Oct 2025 05:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F304F8381D;
	Sun, 19 Oct 2025 07:26:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="jeiTyx8Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FF2E83631; Sun, 19 Oct 2025 07:26:35 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 805AE83869
 for <u-boot@lists.denx.de>; Sun, 19 Oct 2025 07:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 4D6EA2640A;
 Sun, 19 Oct 2025 07:26:31 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lz2LCFekJDCT; Sun, 19 Oct 2025 07:26:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760851590; bh=cJpj2EzdIm/sjDAouXQurOOGUoCCe70cI6b3y10XWLc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jeiTyx8Q6TSqSiJD2lUrhO1zuVpEf2yssllltHfLR0DcHTt6zbJy75vKE/aiJ9CzF
 znaUQBauYrCGRTKJkHMftz6VnSvKljnLxHrwrG68eO0HF6b7srucukyzFIvlWILmqm
 jZrRqTjBNy3GVfhvfpHE0AhNDyq7htrAmPiwZ4ZbUyuk5vQfJP5ykQYpOItexgHo/s
 xPgGm5fc55P1TzugQu6L7C5+lbBC640jjfukk/O/1ihJn9mLwIlbjZzALPuvRxnaql
 bsibu7SjMCmneTEzaaCh1P3Tf1NwyJbGnrczkXKaEP0VgZeOsM+KthKGXF0RcOQoOU
 vGQUXNgs9rO7g==
From: Yao Zi <ziyao@disroot.org>
To: Yao Zi <ziyao@disroot.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Heiko Stuebner <heiko@sntech.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH 2/2] board: rockchip: Add FriendlyElec NanoPi Zero2
Date: Sun, 19 Oct 2025 05:26:07 +0000
Message-ID: <20251019052607.61702-3-ziyao@disroot.org>
In-Reply-To: <20251019052607.61702-1-ziyao@disroot.org>
References: <20251019052607.61702-1-ziyao@disroot.org>
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

FriendlElec NanoPi Zero2 is a super-tiny development board based on
RK3528A SoC. Add board-level configuration and U-Boot-specific
devicetree piece for it.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi | 11 +++++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS    |  6 +++
 configs/nanopi-zero2_defconfig               | 46 ++++++++++++++++++++
 doc/board/rockchip/rockchip.rst              |  1 +
 4 files changed, 64 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
 create mode 100644 configs/nanopi-zero2_defconfig

diff --git a/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
new file mode 100644
index 00000000000..3f65d2e1ff1
--- /dev/null
+++ b/arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi
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
+	regulator-init-microvolt = <901000>;
+};
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index f343f71cf7f..853480a58ce 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -9,3 +9,9 @@ M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	arch/arm/dts/rk3528-radxa-e20c*
 F:	configs/radxa-e20c-rk3528_defconfig
+
+NANOPI-ZERO2
+M:	Yao Zi <ziyao@disroot.org>
+S:	Maintained
+F:	arch/arm/dts/rk3528-nanopi-zero2*
+F:	configs/nanopi-zero2_defconfig
diff --git a/configs/nanopi-zero2_defconfig b/configs/nanopi-zero2_defconfig
new file mode 100644
index 00000000000..af14589568c
--- /dev/null
+++ b/configs/nanopi-zero2_defconfig
@@ -0,0 +1,46 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-nanopi-zero2"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-nanopi-zero2.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de3aa79cb5c..b2b7de4e43a 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -100,6 +100,7 @@ List of mainline supported Rockchip boards:
      - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
 
 * rk3528
+     - FriendlyElec NanoPi Zero2 (nanopi-zero2)
      - Generic RK3528 (generic-rk3528)
      - Radxa E20C (radxa-e20c-rk3528)
 
-- 
2.50.1

