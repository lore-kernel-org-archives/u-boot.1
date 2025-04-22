Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42927C369C2
	for <u-boot@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98B29810EB;
	Tue, 22 Apr 2025 23:12:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0Khk43bi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2D380FF7; Tue, 22 Apr 2025 23:12:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DC8D809D4
 for <u-boot@lists.denx.de>; Tue, 22 Apr 2025 23:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e320=XJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1745356356; bh=Fsfzn1hTFppRstwtZ+3RuoFbGKXQJhgcuzR5PZ8GRfk=;
 b=0Khk43biOnPIYicpFg7vA12fFRPDZnv2Z1EKeaJ9tXx1s3xaZaZj400bSjtRWIXX0GVQu9oGy
 1zNe3KOf1RcE7qjTu8rxbqp/HQhn9AWNhybzW1rSZI5N9tPHFrtzePPLl/NHRHsjseqpsk0pCag
 IFmNvORLoisVlGBXtz4jIY1CycWw+eUp1wTBBgIEB4gPC6D3WDdF7LLw80fIXSXdthkeorzE/M+
 EDaO3sL236FLoxuG/67wowKh2mTdF4uzTSlDIQ/1my9ck05kD3+obz7PN6Fzebnzr0zu60Bg7vj
 vEOWURFEmRVHeZdaIWUXyJpcrt2e4Bu0f/n3RBegWPMA==
X-Forward-Email-ID: 68080641305f69a6701c59bf
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.0.2
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, u-boot@lists.denx.de
Subject: [PATCH 3/4] board: rockchip: Add minimal generic RK3576 board
Date: Tue, 22 Apr 2025 21:12:08 +0000
Message-ID: <20250422211216.3727559-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422211216.3727559-1-jonas@kwiboo.se>
References: <20250422211216.3727559-1-jonas@kwiboo.se>
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

Add a minimal generic RK3576 board that only have eMMC and SDMMC
enabled. This defconfig can be used to boot from eMMC or SD-card on most
RK3576 boards that follow reference board design.

eMMC and SD-card boot tested on:
- ArmSoM Sige5
- Toybrick TB-RK3576D

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3576-generic-u-boot.dtsi   |  3 ++
 arch/arm/dts/rk3576-generic.dts           | 45 +++++++++++++++++++++++
 arch/arm/mach-rockchip/rk3576/MAINTAINERS |  5 +++
 configs/generic-rk3576_defconfig          | 41 +++++++++++++++++++++
 doc/board/rockchip/rockchip.rst           |  1 +
 5 files changed, 95 insertions(+)
 create mode 100644 arch/arm/dts/rk3576-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3576-generic.dts
 create mode 100644 arch/arm/mach-rockchip/rk3576/MAINTAINERS
 create mode 100644 configs/generic-rk3576_defconfig

diff --git a/arch/arm/dts/rk3576-generic-u-boot.dtsi b/arch/arm/dts/rk3576-generic-u-boot.dtsi
new file mode 100644
index 000000000000..632fabb6af56
--- /dev/null
+++ b/arch/arm/dts/rk3576-generic-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3576-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3576-generic.dts b/arch/arm/dts/rk3576-generic.dts
new file mode 100644
index 000000000000..c4d64307ee99
--- /dev/null
+++ b/arch/arm/dts/rk3576-generic.dts
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Minimal generic DT for RK3576 with eMMC and SD-card enabled
+ */
+
+/dts-v1/;
+#include "rk3576.dtsi"
+
+/ {
+	model = "Generic RK3576";
+	compatible = "rockchip,rk3576";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial0:1500000n8";
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	no-mmc;
+	no-sdio;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0m0_xfer>;
+	status = "okay";
+};
diff --git a/arch/arm/mach-rockchip/rk3576/MAINTAINERS b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
new file mode 100644
index 000000000000..b5190c818468
--- /dev/null
+++ b/arch/arm/mach-rockchip/rk3576/MAINTAINERS
@@ -0,0 +1,5 @@
+GENERIC-RK3576
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	arch/arm/dts/rk3576-generic*
+F:	configs/generic-rk3576_defconfig
diff --git a/configs/generic-rk3576_defconfig b/configs/generic-rk3576_defconfig
new file mode 100644
index 000000000000..8a688b775d1c
--- /dev/null
+++ b/configs/generic-rk3576_defconfig
@@ -0,0 +1,41 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_DEFAULT_DEVICE_TREE="rk3576-generic"
+CONFIG_ROCKCHIP_RK3576=y
+CONFIG_SYS_LOAD_ADDR=0x40c00800
+CONFIG_DEBUG_UART_BASE=0x2AD40000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3576-generic.dtb"
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
+CONFIG_SYSRESET_PSCI=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b06f87b137cd..69c8fbf3b948 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -134,6 +134,7 @@ List of mainline supported Rockchip boards:
 
 * rk3576
      - Firefly ROC-RK3576-PC (roc-pc-rk3576)
+     - Generic RK3576 (generic-rk3576)
 
 * rk3588
      - ArmSoM Sige7 (sige7-rk3588)
-- 
2.49.0

