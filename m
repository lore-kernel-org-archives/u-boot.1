Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49C8CEFD19
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 22:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E765D83C4B;
	Tue,  6 Jan 2026 23:42:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="c27pK1em";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1E0883C62; Tue,  6 Jan 2026 23:42:48 +0100 (CET)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D42283BC4
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 23:42:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767739364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mz3f5Zl5uXoy6pG+2NSszzTCOIU7u9XCvqyln9AldQM=;
 b=c27pK1emkKyXdhPPFrT5yEUScMsQg+QNrWzK4I/7/tcKPzqOnoBxVWMgdJTc4i3rN41eKp
 9J6nFujLUN2YcLbPkHVk4La03XKrfqARt7yAZXwTeM861ve9T9yNM6vNPcb5ZJ2LjZcn2A
 sQM5GP9i8iIngcYvm8ArRbVZtgJugNk=
From: Sean Anderson <sean.anderson@linux.dev>
To: Michal Simek <michal.simek@amd.com>,
	u-boot@lists.denx.de
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] pinctrl: zynqmp: Add SPL support
Date: Tue,  6 Jan 2026 17:42:02 -0500
Message-Id: <20260106224202.754923-1-sean.anderson@linux.dev>
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

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/firmware/firmware-zynqmp.c | 100 +++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index f8a9945c1da..77911757177 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -427,6 +427,102 @@ U_BOOT_DRIVER(zynqmp_power) = {
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
+		ret_payload[1] = 78;
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
+		memset(ret_payload, 0, 16);
+		strcpy((char *)ret_payload, pinctrl_functions[arg1]);
+		return 0;
+	case PM_QID_PINCTRL_GET_FUNCTION_GROUPS:
+	case PM_QID_PINCTRL_GET_PIN_GROUPS:
+		memset(ret_payload + 1, 0xff, 12);
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
@@ -493,6 +589,10 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 	      __func__, current_el(), api_id, arg0, arg1, arg2, arg3, arg4, arg5);
 
 	if (IS_ENABLED(CONFIG_XPL_BUILD) || current_el() == 3) {
+		if (IS_ENABLED(CONFIG_ARCH_ZYNQMP) &&
+		    IS_ENABLED(CONFIG_PINCTRL_ZYNQMP) &&
+		    api_id == PM_QUERY_DATA)
+			return zynqmp_pm_query_data(arg0, arg1, arg2, ret_payload);
 #if defined(CONFIG_ZYNQMP_IPI)
 		/*
 		 * Use fixed payload and arg size as the EL2 call. The firmware
-- 
2.35.1.1320.gc452695387.dirty

base-commit: 38ace442b630c5ddf049af83e8db229c012ed355
branch: pinctrl_zynqmp_spl
