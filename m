Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F590EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 22:31:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F84E870CD;
	Tue, 22 Aug 2023 00:30:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="dNAOoSXt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB7787209; Tue, 22 Aug 2023 00:30:34 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66A3F87141
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 00:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=QjnP9ZDypdvf/ns9fbkuiA4uM2AaukWAi8h/9c2wx94=;
 b=dNAOoSXtDmt1/xIM4wTSjM2QpGJmwOrdzs886z9jF1x2qH3tKS7J2OKxrFmEmeYjKFvl
 J49pkVejpWVNECKJ4zDqnz8yZr8s8aRzNdCW4pE+P3DcpqT0hTt6Frv8gK8+9NeNYxw7qa
 2CnbWD02Z7G+X9cLYSXhQhciA1flKd51rhxVkQ0yu5YYkrJA0OCMfYvZqK8BB0il2VaGm4
 Wu+m32doZTYujM1q9QuL9LV+WzResslvT+V2oJUtwjTMLemHnjVb/jxQPlS33x0wo+5uFs
 gSnHENXAfrKe0FF9xLCr8NLH0qmQL6Gttx8B+BCEjHXlBQ2uIuVaMXvdcZCiKtsg==
Received: by filterdrecv-7765c6879f-lmsb8 with SMTP id
 filterdrecv-7765c6879f-lmsb8-1-64E3E585-6E
 2023-08-21 22:30:29.765458756 +0000 UTC m=+973634.025498045
Received: from bionic.localdomain (unknown) by geopod-ismtpd-7 (SG) with ESMTP
 id zNqzaoFMTiCo6j6a85TH4g Mon, 21 Aug 2023 22:30:29.537 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 5/5] rockchip: board: Add minimal generic RK3566/RK3568
 board
Date: Mon, 21 Aug 2023 22:30:29 +0000 (UTC)
Message-ID: <20230821223020.3918620-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821223020.3918620-1-jonas@kwiboo.se>
References: <20230821223020.3918620-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h1q5v9Td8snGyW867?=
 =?us-ascii?Q?ieH1TSkEG0v78q1iFrPLDHPq4YnTPWSvP3JEAGy?=
 =?us-ascii?Q?EzIhA7L2LLMoyaZTDC6T6boGnWGV2qGLkDZWumn?=
 =?us-ascii?Q?1Vy31P83a=2FqE53tRjrumaEtA2k9ZZaDAl2dk0Lj?=
 =?us-ascii?Q?TPYZXtdXlsZJH2a7rzfqOhzsNVCpjelDCCkvFn?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Jonas Karlman <jonas@kwiboo.se>,
 Joseph Chen <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

Add a minimal generic RK3566/RK3568 board that only have eMMC and SDMMC
enabled. This defconfig can be used to boot from eMMC or SD-card on most
RK3566/RK3568 boards that follow reference board design.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- New patch

 arch/arm/dts/rk3568-generic-u-boot.dtsi | 14 ++++++
 arch/arm/dts/rk3568-generic.dts         | 38 +++++++++++++++
 board/rockchip/evb_rk3568/MAINTAINERS   |  7 +++
 configs/generic-rk3568_defconfig        | 64 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  1 +
 5 files changed, 124 insertions(+)
 create mode 100644 arch/arm/dts/rk3568-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3568-generic.dts
 create mode 100644 configs/generic-rk3568_defconfig

diff --git a/arch/arm/dts/rk3568-generic-u-boot.dtsi b/arch/arm/dts/rk3568-generic-u-boot.dtsi
new file mode 100644
index 000000000000..90022580a13b
--- /dev/null
+++ b/arch/arm/dts/rk3568-generic-u-boot.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x-u-boot.dtsi"
+
+/ {
+	chosen {
+		stdout-path = &uart2;
+	};
+};
+
+&uart2 {
+	bootph-pre-ram;
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm/dts/rk3568-generic.dts b/arch/arm/dts/rk3568-generic.dts
new file mode 100644
index 000000000000..1006ea55bb98
--- /dev/null
+++ b/arch/arm/dts/rk3568-generic.dts
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Minimal generic DT for RK3566/RK3568 with eMMC and SD-card enabled
+ */
+
+/dts-v1/;
+#include "rk356x.dtsi"
+
+/ {
+	model = "Generic RK3566/RK3568";
+	compatible = "rockchip,rk3568";
+
+	chosen: chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd>;
+	status = "okay";
+};
+
+&sdmmc0 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	disable-wp;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index cc9eb432a8b5..fa8d1190931d 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -7,6 +7,13 @@ F:	configs/evb-rk3568_defconfig
 F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
 F:	arch/arm/dts/rk3568-evb.dts
 
+GENERIC-RK3568
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/generic-rk3568_defconfig
+F:	arch/arm/dts/rk3568-generic.dts
+F:	arch/arm/dts/rk3568-generic-u-boot.dtsi
+
 LUBANCAT-2
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
diff --git a/configs/generic-rk3568_defconfig b/configs/generic-rk3568_defconfig
new file mode 100644
index 000000000000..8f0a9c8c449f
--- /dev/null
+++ b/configs/generic-rk3568_defconfig
@@ -0,0 +1,64 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00a00000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=2
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
+CONFIG_DEFAULT_DEVICE_TREE="rk3568-generic"
+CONFIG_ROCKCHIP_RK3568=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_SPL_STACK=0x400000
+CONFIG_DEBUG_UART_BASE=0xFE660000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-generic.dtb"
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_SPL_PAD_TO=0x7f8000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x4000000
+CONFIG_SPL_BSS_MAX_SIZE=0x4000
+# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_ATF=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_MMC=y
+# CONFIG_CMD_SETEXPR is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_OF_LIVE=y
+CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_MISC=y
+# CONFIG_ROCKCHIP_IODOMAIN is not set
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index de9fe8e642b1..183a9e4aa699 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -104,6 +104,7 @@ List of mainline supported Rockchip boards:
      - EmbedFire LubanCat 2 (lubancat-2-rk3568)
      - FriendlyElec NanoPi R5C (nanopi-r5c-rk3568)
      - FriendlyElec NanoPi R5S (nanopi-r5s-rk3568)
+     - Generic RK3566/RK3568 (generic-rk3568)
      - Hardkernel ODROID-M1 (odroid-m1-rk3568)
      - Radxa E25 Carrier Board (radxa-e25-rk3568)
      - Radxa ROCK 3 Model A (rock-3a-rk3568)
-- 
2.41.0

