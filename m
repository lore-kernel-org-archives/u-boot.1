Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABD1D73E83
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 18:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 336F584082;
	Thu, 29 Jan 2026 19:40:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="RZkubVbv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 692FF84090; Thu, 29 Jan 2026 19:40:19 +0100 (CET)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5147983FFF
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 19:40:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1769712015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hSyPi7jxxO0gdl7s0ctwR8jI1vq8Qg6mUKze1Pbxwn0=;
 b=RZkubVbv7MVJ4d7VZySXGqF9B/n/VvvaVoVM32i+7WmRTykjqgSSQAb4N+sS1izEgzz0BJ
 9LvTb2tlzefuRcpgI2xPpAC+fs1wVuuCxW+Zt7uamMx7EqvVEQp+OGoGtVs9+LlgTU2Ne5
 qHOhFzEUOmJlBWJgn1T9iEBFJYhb/aA=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de
Cc: Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH v2] pinctrl: zynqmp: Add SPL support
Date: Thu, 29 Jan 2026 13:40:11 -0500
Message-Id: <20260129184011.3932790-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Although the pinctrl pm requests are implemented in the PMU firmware,
PM_QUERY_DATA is actually implemented in ATF. In SPL (or when running in
EL3), ATF is not yet running, so we need to implement this API
ourselves. Do the bare minimum, allowing SPL to enumerate functions, but
don't bother with groups. Groups take up a lot of space, and can be
emulated with pins. For example, a node like

	display-port {
		mux {
			groups = "dpaux0_1";
			function = "dpaux0";
		};
	};

can be replaced by

	display-port {
		mux {
			pins = "MIO34", "MIO35", "MIO36", "MIO37";
			function = "dpaux0";
		};
	};

While this isn't backwards-compatible with existing devicetrees, it's
more than enough for SPL where we may only need to mux one or two pins.

Add SPL_PINCTRL_ZYNQMP to ensure there's no SPL size growth when pinctrl
is enabled in U-Boot but isn't necessary for SPL. The only config this
would affect is Kria, but SPL_PINCTRL_GENERIC is disabled so
SPL_PINCTRL_ZYNQMP is not selected.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

Changes in v2:
- Move some defines into zynqmp_firmware.h so they can be reused
- Calculate a few more constants instead of using literals
- Add SPL_PINCTRL_ZYNQMP to avoid size growth in SPL

 drivers/firmware/firmware-zynqmp.c | 101 +++++++++++++++++++++++++++++
 drivers/pinctrl/Kconfig            |   8 +++
 drivers/pinctrl/Makefile           |   2 +-
 drivers/pinctrl/pinctrl-zynqmp.c   |   8 +--
 include/zynqmp_firmware.h          |   5 ++
 5 files changed, 117 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f8a9945c1da..fb583580ebe 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -427,6 +427,104 @@ U_BOOT_DRIVER(zynqmp_power) = {
 };
 #endif
 
+static const char *const pinctrl_functions[] = {
+	"can0",
+	"can1",
+	"ethernet0",
+	"ethernet1",
+	"ethernet2",
+	"ethernet3",
+	"gemtsu0",
+	"gpio0",
+	"i2c0",
+	"i2c1",
+	"mdio0",
+	"mdio1",
+	"mdio2",
+	"mdio3",
+	"qspi0",
+	"qspi_fbclk",
+	"qspi_ss",
+	"spi0",
+	"spi1",
+	"spi0_ss",
+	"spi1_ss",
+	"sdio0",
+	"sdio0_pc",
+	"sdio0_cd",
+	"sdio0_wp",
+	"sdio1",
+	"sdio1_pc",
+	"sdio1_cd",
+	"sdio1_wp",
+	"nand0",
+	"nand0_ce",
+	"nand0_rb",
+	"nand0_dqs",
+	"ttc0_clk",
+	"ttc0_wav",
+	"ttc1_clk",
+	"ttc1_wav",
+	"ttc2_clk",
+	"ttc2_wav",
+	"ttc3_clk",
+	"ttc3_wav",
+	"uart0",
+	"uart1",
+	"usb0",
+	"usb1",
+	"swdt0_clk",
+	"swdt0_rst",
+	"swdt1_clk",
+	"swdt1_rst",
+	"pmu0",
+	"pcie0",
+	"csu0",
+	"dpaux0",
+	"pjtag0",
+	"trace0",
+	"trace0_clk",
+	"testscan0",
+};
+
+/*
+ * PM_QUERY_DATA is implemented by ATF and not the PMU firmware, so we have to
+ * emulate it in SPL. Just implement functions/pins since the groups take up a
+ * lot of rodata and are mostly superfluous.
+ */
+static int zynqmp_pm_query_data(enum pm_query_id qid, u32 arg1, u32 arg2,
+				u32 *ret_payload)
+{
+	switch (qid) {
+	case PM_QID_PINCTRL_GET_NUM_PINS:
+		ret_payload[1] = 78; /* NUM_PINS */
+		ret_payload[0] = 0;
+		return 0;
+	case PM_QID_PINCTRL_GET_NUM_FUNCTIONS:
+		ret_payload[1] = ARRAY_SIZE(pinctrl_functions);
+		ret_payload[0] = 0;
+		return 0;
+	case PM_QID_PINCTRL_GET_NUM_FUNCTION_GROUPS:
+		ret_payload[1] = 0;
+		ret_payload[0] = 0;
+		return 0;
+	case PM_QID_PINCTRL_GET_FUNCTION_NAME:
+		assert(arg1 < ARRAY_SIZE(pinctrl_functions));
+		memset(ret_payload, 0, MAX_FUNC_NAME_LEN);
+		strcpy((char *)ret_payload, pinctrl_functions[arg1]);
+		return 0;
+	case PM_QID_PINCTRL_GET_FUNCTION_GROUPS:
+	case PM_QID_PINCTRL_GET_PIN_GROUPS:
+		memset(ret_payload + 1, 0xff,
+		       sizeof(s16) * NUM_GROUPS_PER_RESP);
+		ret_payload[0] = 0;
+		return 0;
+	default:
+		ret_payload[0] = 1;
+		return 1;
+	}
+}
+
 smc_call_handler_t __data smc_call_handler;
 
 static int smc_call_legacy(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
@@ -493,6 +591,9 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
 
 	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
+		if (CONFIG_IS_ENABLED(PINCTRL_ZYNQMP) &&
+		    api_id == PM_QUERY_DATA)
+			return zynqmp_pm_query_data(arg0, arg1, arg2, ret_payload);
 #if defined(CONFIG_ZYNQMP_IPI)
 		/*
 		 * Use fixed payload and arg size as the EL2 call. The firmware
diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 48119694031..06f3dce99b3 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -385,6 +385,14 @@ config PINCTRL_ZYNQMP
 	  Generic Pinctrl framework and is compatible with the Linux driver,
 	  i.e. it uses the same device tree configuration.
 
+config SPL_PINCTRL_ZYNQMP
+	bool "Xilinx ZynqMP pin control driver in SPL"
+	depends on SPL_DM && SPL_PINCTRL_GENERIC && ARCH_ZYNQMP
+	default PINCTRL_ZYNQMP
+	help
+	  Support pin multiplexing control in SPL on Xilinx ZynqMP. Only "pins"
+	  can be muxed; "groups" are not supported.
+
 endif
 
 source "drivers/pinctrl/broadcom/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 33ff7b95ef2..4fb6cef3113 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -36,5 +36,5 @@ obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
 obj-y				+= broadcom/
-obj-$(CONFIG_PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
+obj-$(CONFIG_$(PHASE_)PINCTRL_ZYNQMP)	+= pinctrl-zynqmp.o
 obj-$(CONFIG_PINCTRL_STARFIVE)	+= starfive/
diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index 7c11ac4c8b8..0b936684f8a 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -19,15 +19,11 @@
 #include <linux/compat.h>
 #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
 
-#define PINCTRL_GET_FUNC_GROUPS_RESP_LEN	12
-#define PINCTRL_GET_PIN_GROUPS_RESP_LEN		12
-#define NUM_GROUPS_PER_RESP			6
-#define NA_GROUP				-1
-#define RESERVED_GROUP				-2
+#define PINCTRL_GET_FUNC_GROUPS_RESP_LEN	(sizeof(s16) * NUM_GROUPS_PER_RESP)
+#define PINCTRL_GET_PIN_GROUPS_RESP_LEN		(sizeof(s16) * NUM_GROUPS_PER_RESP)
 #define MAX_GROUP_PIN				50
 #define MAX_PIN_GROUPS				50
 #define MAX_GROUP_NAME_LEN			32
-#define MAX_FUNC_NAME_LEN			16
 
 #define DRIVE_STRENGTH_2MA	2
 #define DRIVE_STRENGTH_4MA	4
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 05df49f292a..f5e72625e53 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -185,6 +185,11 @@ enum pm_query_id {
 	PM_QID_CLOCK_GET_MAX_DIVISOR = 13,
 };
 
+#define NUM_GROUPS_PER_RESP			6
+#define NA_GROUP				-1
+#define RESERVED_GROUP				-2
+#define MAX_FUNC_NAME_LEN			16
+
 enum pm_pinctrl_config_param {
 	PM_PINCTRL_CONFIG_SLEW_RATE = 0,
 	PM_PINCTRL_CONFIG_BIAS_STATUS = 1,
-- 
2.35.1.1320.gc452695387.dirty

base-commit: 38ace442b630c5ddf049af83e8db229c012ed355
branch: pinctrl_zynqmp_spl
