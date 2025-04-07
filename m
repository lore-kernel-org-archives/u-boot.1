Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD13C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:53:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B278310C;
	Tue,  8 Apr 2025 00:49:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MHg8VCY6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F490830E3; Tue,  8 Apr 2025 00:49:48 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37633831B0
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066184; bh=AhJRDP4U+p6OtsEz03MmAYwF0oHrbG0PRoh7EYmgPqc=;
 b=MHg8VCY6AoT29tz9h/b3TSlWRXv1FcnLwELK83GdT4wjTfJo4XTIR2GLJ8C4KPZcybupxnObj
 5PKZy92ISMxKjkC/iX/n7MdEEREXJbssnhWuolg6LifCiFluy1vb8mpiQRqWqN0PKOsBN4UTqH/
 G5G+Z7hPEdpHMK6iAewg2N2NqJGYArv9HRu8mQ8ybU18QfUj9qJnZY/TXmuQgiZGnkHTJSollJw
 bt6YmLy0B2UhGzbst4JOhdoiHaT/gHmggOWBAME05bIJW5bLEEb7U0EL8KeONjFcqi6vUqMKb7E
 8MKWR0P/hqOTuG/7uiNT0eOFg36kYZ1vwiqXYOfJm5Og==
X-Forward-Email-ID: 67f456849fd75b9b96512a00
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de
Subject: [PATCH v2 30/30] board: rockchip: Add Radxa E20C
Date: Mon,  7 Apr 2025 22:47:03 +0000
Message-ID: <20250407224743.2423921-31-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

The Radxa E20C is an ultra-compact network computer with a RK3528A SoC
that offers a wide range of networking capabilities.

Features tested on a Radxa E20C v1.104:
- SD-card boot
- eMMC boot

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Drop sdhci from board u-boot.dtsi
- Update sdmmc node to latest mainline Linux patch
- Enable options for DT nodes added to dts/upstream DT

This also enables options for GMAC, PWM-regulators and USB 2.0. Features
that have been tested but are currently missing the necessary DT nodes.
---
 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi | 12 +++++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS  |  6 +++
 configs/radxa-e20c-rk3528_defconfig        | 56 ++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst            |  1 +
 4 files changed, 75 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
 create mode 100644 configs/radxa-e20c-rk3528_defconfig

diff --git a/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
new file mode 100644
index 000000000000..9c2f03a786cf
--- /dev/null
+++ b/arch/arm/dts/rk3528-radxa-e20c-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	disable-wp;
+	vmmc-supply = <&vcc_3v3>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
index cfdc92d770c1..f343f71cf7f6 100644
--- a/arch/arm/mach-rockchip/rk3528/MAINTAINERS
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -3,3 +3,9 @@ M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	arch/arm/dts/rk3528-generic*
 F:	configs/generic-rk3528_defconfig
+
+RADXA-E20C
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3528-radxa-e20c*
+F:	configs/radxa-e20c-rk3528_defconfig
diff --git a/configs/radxa-e20c-rk3528_defconfig b/configs/radxa-e20c-rk3528_defconfig
new file mode 100644
index 000000000000..08f3a13af3b2
--- /dev/null
+++ b/configs/radxa-e20c-rk3528_defconfig
@@ -0,0 +1,56 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3528-radxa-e20c"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-radxa-e20c.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_CMD_ADC=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MISC=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_BUTTON=y
+CONFIG_BUTTON_ADC=y
+CONFIG_BUTTON_GPIO=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_LED=y
+CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_USB2=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_USB=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_GENERIC=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index c636d33b47c1..f7d4f2a66860 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -101,6 +101,7 @@ List of mainline supported Rockchip boards:
 
 * rk3528
      - Generic RK3528 (generic-rk3528)
+     - Radxa E20C (radxa-e20c-rk3528)
 
 * rk3566
      - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
-- 
2.49.0

