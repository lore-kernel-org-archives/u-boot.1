Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B0BC369A1
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0E083291;
	Tue,  8 Apr 2025 00:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WAiFbkkJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1E9B8324C; Tue,  8 Apr 2025 00:49:45 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F58B83290
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066179; bh=HBoQrZmI+B+YzkDNJghSNK6ao7ZN09E2gIm5HJT4+20=;
 b=WAiFbkkJIwU3aujtTB+Vm+XudrFOGHwD3haSTmCWvJ4diySHIhbp8qIXnM84jDNP2m6JOc6Zf
 sFF1Qh5GXy1dJioBGC1DGr47gMcbzV1mDQUCSqR1agXpvImg+qOa/MZG1nISitPCZbK1M2a4BEh
 9EX+gAh4N4XUgIpLdnk53lb0kPahsaS4FXC2AMJezbhXO2OsNyWWsj1qbklu9awSw26tysN9wax
 ymea4fmTVUi5i5cNqjA+84o+hMJls5z6xCuimEyp/i9dPrjWjYokLL3dKAtTsPhQwP4qOo4HPxo
 4myOBh2XU4d3XQeXRZqJtJHOvivJiMf9R+zHV1xblXog==
X-Forward-Email-ID: 67f456819fd75b9b965129eb
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
Subject: [PATCH v2 29/30] board: rockchip: Add minimal generic RK3528 board
Date: Mon,  7 Apr 2025 22:47:02 +0000
Message-ID: <20250407224743.2423921-30-jonas@kwiboo.se>
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

Add a minimal generic RK3528 board that only have eMMC and SD-card
enabled. This defconfig can be used to boot from eMMC or SD-card on most
RK3528 boards that follow reference board design.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Move sdhci node to main .dts-file
- Enable meminfo cmd

Tested on:
- FriendlyElec NanoPi Zero2
- Radxa ROCK 2A
- Radxa ROCK 2F
---
 arch/arm/dts/rk3528-generic-u-boot.dtsi   | 12 +++++++
 arch/arm/dts/rk3528-generic.dts           | 31 ++++++++++++++++++
 arch/arm/mach-rockchip/rk3528/MAINTAINERS |  5 +++
 configs/generic-rk3528_defconfig          | 40 +++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           | 12 +++++++
 5 files changed, 100 insertions(+)
 create mode 100644 arch/arm/dts/rk3528-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-generic.dts
 create mode 100644 arch/arm/mach-rockchip/rk3528/MAINTAINERS
 create mode 100644 configs/generic-rk3528_defconfig

diff --git a/arch/arm/dts/rk3528-generic-u-boot.dtsi b/arch/arm/dts/rk3528-generic-u-boot.dtsi
new file mode 100644
index 000000000000..cc830b514567
--- /dev/null
+++ b/arch/arm/dts/rk3528-generic-u-boot.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3528-u-boot.dtsi"
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3528-generic.dts b/arch/arm/dts/rk3528-generic.dts
new file mode 100644
index 000000000000..792d3e04a4cb
--- /dev/null
+++ b/arch/arm/dts/rk3528-generic.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Minimal generic DT for RK3528 with eMMC enabled
+ */
+
+/dts-v1/;
+#include "rk3528.dtsi"
+
+/ {
+	model = "Generic RK3528";
+	compatible = "rockchip,rk3528";
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3528/MAINTAINERS b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
new file mode 100644
index 000000000000..cfdc92d770c1
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3528/MAINTAINERS
@@ -0,0 +1,5 @@
+GENERIC-RK3528
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3528-generic*
+F:	configs/generic-rk3528_defconfig
diff --git a/configs/generic-rk3528_defconfig b/configs/generic-rk3528_defconfig
new file mode 100644
index 000000000000..e19c7bc4801d
--- /dev/null
+++ b/configs/generic-rk3528_defconfig
@@ -0,0 +1,40 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rk3528-generic"
+CONFIG_ROCKCHIP_RK3528=y
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART_BASE=0xFF9F0000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3528-generic.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
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
+# CONFIG_OF_UPSTREAM is not set
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_NO_NET=y
+# CONFIG_ADC is not set
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 5a029afae305..c636d33b47c1 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -99,6 +99,9 @@ List of mainline supported Rockchip boards:
      - Rockchip Evb-RK3399 (evb_rk3399)
      - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
 
+* rk3528
+     - Generic RK3528 (generic-rk3528)
+
 * rk3566
      - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
      - FriendlyElec NanoPi R3S (nanopi-r3s-rk3566)
@@ -260,6 +263,15 @@ To build rk3399 boards:
         make evb-rk3399_defconfig
         make CROSS_COMPILE=aarch64-linux-gnu-
 
+To build rk3528 boards:
+
+.. code-block:: bash
+
+        export BL31=../rkbin/bin/rk35/rk3528_bl31_v1.18.elf
+        export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3528_ddr_1056MHz_v1.10.bin
+        make generic-rk3528_defconfig
+        make CROSS_COMPILE=aarch64-linux-gnu-
+
 To build rk3568 boards:
 
 .. code-block:: bash
-- 
2.49.0

