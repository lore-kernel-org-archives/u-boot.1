Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3924FC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 22:09:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 836B887626;
	Wed, 31 Jan 2024 23:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0JpMbfRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 688378760D; Wed, 31 Jan 2024 23:09:11 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC4C87732
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 23:09:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8890=JK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1706738941;
 bh=8Xnvm98uquRHvAdUHBmu33WdTxVSLZl8zhJkXOrkaU0=;
 b=0JpMbfRnY4L58slqLKS8QzsVQ45spLaxlxjEZkS/1NBfGeneNJxtO9WeVCXRvY3u2HkWN9qgh
 w8fRM1bDVZP3MHTQwB1QawyBzvMFUP/j5xQK+b2mBqqyCp1fs6CI6GVb/7vGl4kiEUIg0qp38T4
 /7QkatLPSNf4psJYN+bnkHGuDup+ZzCkwc35R5ncIpt/uU94tBNXPqzdOS9rsiMpGYP/ewbhYRS
 C86aaWjggErGubhrxoqkR2YAgYc1HeFRYORoDhF64QBsOKyb13sK4IqufzqIoBYnEBRVzs57PP0
 Yp8IwLO2y9dr3x7OosiVexuskWYpwM9ybv0iXrZzxylA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH] rockchip: board: Add minimal generic RK3588S/RK3588 board
Date: Wed, 31 Jan 2024 22:08:51 +0000
Message-ID: <20240131220854.117650-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65bac4fc619a1500cde84e11
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

Add a minimal generic RK3588S/RK3588 board that only have eMMC and SDMMC
enabled. This defconfig can be used to boot from eMMC or SD-card on most
RK3588S/RK3588 boards that follow reference board design.

Also fix the alphabetical order of RK3588 boards listed in Makefile and
documentation.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
This patch depend on the series "rockchip: rk35xx: Sync device tree
with linux v6.8-rc1" [1].

[1] https://patchwork.ozlabs.org/cover/1891669/
---
 arch/arm/dts/Makefile                   |  5 +-
 arch/arm/dts/rk3588-generic-u-boot.dtsi |  3 ++
 arch/arm/dts/rk3588-generic.dts         | 44 ++++++++++++++++
 board/rockchip/evb_rk3588/MAINTAINERS   |  7 +++
 configs/generic-rk3588_defconfig        | 68 +++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst         |  3 +-
 6 files changed, 127 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-generic-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3588-generic.dts
 create mode 100644 configs/generic-rk3588_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0fcae77cefe3..6361bc5abc37 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -193,13 +193,14 @@ dtb-$(CONFIG_ROCKCHIP_RK3588) += \
 	rk3588-edgeble-neu6a-io.dtb \
 	rk3588-edgeble-neu6b-io.dtb \
 	rk3588-evb1-v10.dtb \
+	rk3588-generic.dtb \
 	rk3588-nanopc-t6.dtb \
 	rk3588s-orangepi-5.dtb \
 	rk3588-orangepi-5-plus.dtb \
 	rk3588-quartzpro64.dtb \
-	rk3588-turing-rk1.dtb \
 	rk3588s-rock-5a.dtb \
-	rk3588-rock-5b.dtb
+	rk3588-rock-5b.dtb \
+	rk3588-turing-rk1.dtb
 
 dtb-$(CONFIG_ROCKCHIP_RV1108) += \
 	rv1108-elgin-r1.dtb \
diff --git a/arch/arm/dts/rk3588-generic-u-boot.dtsi b/arch/arm/dts/rk3588-generic-u-boot.dtsi
new file mode 100644
index 000000000000..853ed58cfe58
--- /dev/null
+++ b/arch/arm/dts/rk3588-generic-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588s-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3588-generic.dts b/arch/arm/dts/rk3588-generic.dts
new file mode 100644
index 000000000000..e4721d97a87d
--- /dev/null
+++ b/arch/arm/dts/rk3588-generic.dts
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Minimal generic DT for RK3588S/RK3588 with eMMC and SD-card enabled
+ */
+
+/dts-v1/;
+#include "rk3588s.dtsi"
+
+/ {
+	model = "Generic RK3588S/RK3588";
+	compatible = "rockchip,rk3588";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
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
+&uart2 {
+	status = "okay";
+};
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index 2bd44bc58728..eb771da7b7a0 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -7,6 +7,13 @@ F:	configs/evb-rk3588_defconfig
 F:	arch/arm/dts/rk3588-evb1-v10.dts
 F:	arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
 
+GENERIC-RK3588
+M:	Jonas Karlman <jonas@kwiboo.se>
+S:	Maintained
+F:	configs/generic-rk3588_defconfig
+F:	arch/arm/dts/rk3588-generic.dts
+F:	arch/arm/dts/rk3588-generic-u-boot.dtsi
+
 ORANGEPI-5-RK3588
 M:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
diff --git a/configs/generic-rk3588_defconfig b/configs/generic-rk3588_defconfig
new file mode 100644
index 000000000000..4755b27c1dea
--- /dev/null
+++ b/configs/generic-rk3588_defconfig
@@ -0,0 +1,68 @@
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
+CONFIG_DEFAULT_DEVICE_TREE="rk3588-generic"
+CONFIG_ROCKCHIP_RK3588=y
+CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_STACK_R_ADDR=0x600000
+CONFIG_TARGET_EVB_RK3588=y
+CONFIG_SPL_STACK=0x400000
+CONFIG_DEBUG_UART_BASE=0xFEB50000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_SYS_LOAD_ADDR=0xc00800
+CONFIG_DEBUG_UART=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_SPL_FIT_SIGNATURE=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_LEGACY_IMAGE_FORMAT=y
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-generic.dtb"
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
+CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_REGMAP=y
+CONFIG_SPL_SYSCON=y
+CONFIG_SPL_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_MISC=y
+CONFIG_SUPPORT_EMMC_RPMB=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_SPL_MMC_HS200_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SDMA=y
+CONFIG_MMC_SDHCI_ROCKCHIP=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_RAM=y
+CONFIG_BAUDRATE=1500000
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_ERRNO_STR=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 9fe69fc9422f..393c84a1309c 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -116,10 +116,11 @@ List of mainline supported Rockchip boards:
      - Edgeble Neural Compute Module 6A SoM - Neu6a (neu6a-io-rk3588)
      - Edgeble Neural Compute Module 6B SoM - Neu6b (neu6b-io-rk3588)
      - FriendlyElec NanoPC-T6 (nanopc-t6-rk3588)
+     - Generic RK3588S/RK3588 (generic-rk3588)
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
-     - Turing Machines RK1 (turing-rk1-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
      - Radxa ROCK 5B (rock5b-rk3588)
+     - Turing Machines RK1 (turing-rk1-rk3588)
      - Xunlong Orange Pi 5 (orangepi-5-rk3588s)
      - Xunlong Orange Pi 5 Plus (orangepi-5-plus-rk3588)
 
-- 
2.43.0

