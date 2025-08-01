Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F80BC87FCA
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 17:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D408E83AD1;
	Fri,  1 Aug 2025 19:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="pOM6BIyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DE583AAD; Fri,  1 Aug 2025 19:09:55 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C466A83AE9
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 19:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754068191; bh=emRlogJEajskU7NP9rGTXtvRsF4EcY7IpYtZ3nVQ34E=;
 b=pOM6BIyosVKUNJ6bBXY445cILlyfqQvXX9K+dXdL308Qu+xzBo7mugntBFIJNwHqMuvHVZ3jV
 RgYjeQeNCDuP2sXAgKxsQgR7coFaJFjQRfWQgHp2B3zybjJKT4GAOnLq2MPDbzAdxKRy31dN/56
 /vIJPuKNLknZjw2hBc3xdtlRTE/2s90CUcSMrx+yWabNU4nmN+wJCEHOy3VOfX3HDebvh0pWwvP
 hZi48e8t1ETVaWmWQpwbOob9S4LSyvLkgF+EzUn/GZp8k6danCYMIIvaAd22ixcM00P+y2cfSdH
 46nS4GlpIKiZSq0I9X5yU6+GFk71q+jKgWSPluvxCHgg==
X-Forward-Email-ID: 688cf4dbba56726f0787e082
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Subject: [PATCH v2 2/2] rockchip: rock5b-rk3588: Add support for ROCK 5B+
Date: Fri,  1 Aug 2025 17:09:28 +0000
Message-ID: <20250801170933.2530191-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801170933.2530191-1-jonas@kwiboo.se>
References: <20250801170933.2530191-1-jonas@kwiboo.se>
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

Include FDTs for both ROCK 5B and 5B+ in the FIT and add board selection
code to load the 5B+ FDT when the DRAM type is LPDDR5 and ADC channel 5
value is close to 4095.

  U-Boot 2025.07 (Jul 14 2025 - 21:28:20 +0000)

  Model: Radxa ROCK 5B+
  SoC:   RK3588
  DRAM:  8 GiB

Features tested on a ROCK 5B+ v1.2:
- SD-card boot
- eMMC boot
- SPI flash boot
- PCIe/NVMe
- Ethernet
- USB/TCPM

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Add DRAM type check in addition to SARADC check
---
 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 +
 arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
 board/radxa/rock5b-rk3588/Kconfig            |  5 ++
 board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
 board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 63 ++++++++++++++++++++
 configs/rock5b-rk3588_defconfig              |  1 +
 doc/board/rockchip/rockchip.rst              |  2 +-
 7 files changed, 79 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi

diff --git a/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
new file mode 100644
index 000000000000..c07696c83913
--- /dev/null
+++ b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
@@ -0,0 +1,3 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk3588-rock-5b-u-boot.dtsi"
diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
index d51fbf51cb88..e07b549c767f 100644
--- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
@@ -46,6 +46,11 @@
 	};
 };
 
+&saradc {
+	bootph-pre-ram;
+	vdd-microvolts = <1800000>;
+};
+
 &sdhci {
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
diff --git a/board/radxa/rock5b-rk3588/Kconfig b/board/radxa/rock5b-rk3588/Kconfig
index 41dfe2402b12..98d630117836 100644
--- a/board/radxa/rock5b-rk3588/Kconfig
+++ b/board/radxa/rock5b-rk3588/Kconfig
@@ -9,4 +9,9 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "rock5b-rk3588"
 
+config BOARD_SPECIFIC_OPTIONS # dummy
+	def_bool y
+	select ADC
+	select SPL_ADC
+
 endif
diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
index 4460c9971a96..c8a43769105e 100644
--- a/board/radxa/rock5b-rk3588/MAINTAINERS
+++ b/board/radxa/rock5b-rk3588/MAINTAINERS
@@ -5,5 +5,4 @@ S:	Maintained
 F:	board/radxa/rock5b-rk3588
 F:	include/configs/rock5b-rk3588.h
 F:	configs/rock5b-rk3588_defconfig
-F:	arch/arm/dts/rk3588-rock-5b.dts
-F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
+F:	arch/arm/dts/rk3588-rock-5b*
diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
index fc2f69db2241..6bf4497ce3ae 100644
--- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
+++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
@@ -3,8 +3,71 @@
  * Copyright (c) 2023-2024 Collabora Ltd.
  */
 
+#include <adc.h>
+#include <env.h>
 #include <fdtdec.h>
 #include <fdt_support.h>
+#include <asm/arch-rockchip/sdram.h>
+#include <linux/errno.h>
+
+#define PMU1GRF_BASE		0xfd58a000
+#define OS_REG2_REG		0x208
+
+#define HW_ID_CHANNEL		5
+
+struct board_model {
+	unsigned int dram;
+	unsigned int low;
+	unsigned int high;
+	const char *fdtfile;
+};
+
+static const struct board_model board_models[] = {
+	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
+};
+
+static const struct board_model *get_board_model(void)
+{
+	unsigned int val, dram_type;
+	int i, ret;
+
+	dram_type = rockchip_sdram_type(PMU1GRF_BASE + OS_REG2_REG);
+
+	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
+	if (ret)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
+		unsigned int dram = board_models[i].dram;
+		unsigned int min = board_models[i].low;
+		unsigned int max = board_models[i].high;
+
+		if (dram == dram_type && min <= val && val <= max)
+			return &board_models[i];
+	}
+
+	return NULL;
+}
+
+int rk_board_late_init(void)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model)
+		env_set("fdtfile", model->fdtfile);
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const struct board_model *model = get_board_model();
+
+	if (model && !strcmp(name, model->fdtfile))
+		return 0;
+
+	return -EINVAL;
+}
 
 #ifdef CONFIG_OF_BOARD_SETUP
 int ft_board_setup(void *blob, struct bd_info *bd)
diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
index 6349e8791456..967cebc2054f 100644
--- a/configs/rock5b-rk3588_defconfig
+++ b/configs/rock5b-rk3588_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
 # CONFIG_SPL_DOS_PARTITION is not set
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIVE=y
+CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus"
 CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
 CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_SPL_REGMAP=y
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index b88299cbba23..7a1385789c20 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -152,7 +152,7 @@ List of mainline supported Rockchip boards:
      - Pine64 QuartzPro64 (quartzpro64-rk3588)
      - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
      - Radxa ROCK 5A (rock5a-rk3588s)
-     - Radxa ROCK 5B (rock5b-rk3588)
+     - Radxa ROCK 5B/5B+ (rock5b-rk3588)
      - Radxa ROCK 5C (rock-5c-rk3588s)
      - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
      - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
-- 
2.50.1

