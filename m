Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2617FC43458
	for <u-boot@archiver.kernel.org>; Fri, 26 Jun 2026 21:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D467384A0B;
	Fri, 26 Jun 2026 23:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="uggDDQKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4FFB84105; Fri, 26 Jun 2026 22:17:57 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA5B83FEE
 for <u-boot@lists.denx.de>; Fri, 26 Jun 2026 22:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6300e006a=Charles.Perry@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1782505074; x=1814041074;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PoNYinGhJxIQJ3tKL5ZlmujCsG79IBuprV+19Q4GVu4=;
 b=uggDDQKj6as8IS7nQzxrxL4h4G6FbjS5yf9o4xR8KAiOKrwLbF6+yOev
 2LJzcZh8h/x1LsedkN0j0VHizCUL9dTJBCkEDFCD2d84ZmeMDBaXwgFNk
 HWZMqhxPyloQZXLyu8dFaAoSNHr5Im8MvRSK3sYOFWI1eLwvHgH9jMrja
 f/YBbLvvC+q3n29+YiZn9wVmfqQ9LbWu+cPC9jznQZresiEAq5VfaVZtj
 vvKT86oR4MvREW/XcdVXq2Yp76Av8JtulS9smP4JWT3kF+WSWclS3uf7b
 60KGW0mUNFcaWiLF8tNurMopuFiha4Hb4MkTe2HyVKIggRXMB+m2xTLmA w==;
X-CSE-ConnectionGUID: AF+uA1IuSXyT8lQyigN+Mg==
X-CSE-MsgGUID: 0IAOh+a5SMenNeEYDAPAjg==
X-IronPort-AV: E=Sophos;i="6.24,227,1774335600"; d="scan'208";a="68970190"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 26 Jun 2026 13:17:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 26 Jun 2026 13:17:53 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 26 Jun 2026 13:17:52 -0700
From: Charles Perry <charles.perry@microchip.com>
To: <u-boot@lists.denx.de>
CC: Rahul Pathak <rahul@summations.net>, Anup Patel <anup@brainfault.org>,
 Charles Perry <charles.perry@microchip.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Heiko Schocher
 <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>, "Markus
 Schneider-Pargmann (TI.com)" <msp@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Lucien.Jheng <lucienzx159@gmail.com>, "Martin
 Schwan" <m.schwan@phytec.de>, Michal Simek <michal.simek@amd.com>, Peng Fan
 <peng.fan@nxp.com>, Pieter Van Trappen <pieter.van.trappen@cern.ch>, "Dinesh
 Maniyam" <dinesh.maniyam@altera.com>
Subject: [PATCH 7/7] firmware: rpmi: add a test and sandbox for device power
Date: Fri, 26 Jun 2026 13:15:48 -0700
Message-ID: <20260626201613.1035208-8-charles.perry@microchip.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626201613.1035208-1-charles.perry@microchip.com>
References: <20260626201613.1035208-1-charles.perry@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 26 Jun 2026 23:20:19 +0200
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

Add a simulation of the device power service group using code from
librpmi [1] and adapted.

[1]: https://github.com/riscv-software-src/librpmi/blob/3f3c4ca47339a8795432e260f17e1fc5091c9a3a/lib/rpmi_service_group_device_power.c

Signed-off-by: Charles Perry <charles.perry@microchip.com>
---
 arch/sandbox/dts/test.dts                  |  11 ++
 configs/sandbox_defconfig                  |   1 +
 drivers/firmware/rpmi/Makefile             |   2 +-
 drivers/firmware/rpmi/rpmi-sandbox-power.c | 174 +++++++++++++++++++++
 drivers/firmware/rpmi/rpmi-sandbox.c       |   2 +
 drivers/firmware/rpmi/rpmi-sandbox.h       |   1 +
 test/dm/rpmi.c                             |  21 +++
 7 files changed, 211 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/rpmi/rpmi-sandbox-power.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index e5d6f398fb35..7e25053851f4 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -886,6 +886,12 @@
 			#clock-cells = <1>;
 			clocks = <&rpmi_clock 0>, <&rpmi_clock 1>, <&rpmi_clock 2>, <&rpmi_clock 3>;
 		};
+
+		rpmi_dpwr: rpmi-power-domain {
+			compatible = "riscv,rpmi-device-power";
+			mboxes = <&rpmi 0x9>;
+			#power-domain-cells = <1>;
+		};
 	};
 
 	fpga {
@@ -1927,6 +1933,11 @@
 		regul1-supply = <&regul1_scmi>;
 	};
 
+	rpmi-power-domain-test {
+		compatible = "sandbox,power-domain-test";
+		power-domains = <&rpmi_dpwr 1>;
+	};
+
 	pinctrl {
 		compatible = "sandbox,pinctrl";
 
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index f1637e1ff09c..59967bd2ee0f 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -289,6 +289,7 @@ CONFIG_PINCONF=y
 CONFIG_PINCTRL_SANDBOX=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
+CONFIG_RPMI_POWER_DOMAIN=y
 CONFIG_SANDBOX_POWER_DOMAIN=y
 CONFIG_SCMI_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
diff --git a/drivers/firmware/rpmi/Makefile b/drivers/firmware/rpmi/Makefile
index 150e98a72df9..c73ad92baec1 100644
--- a/drivers/firmware/rpmi/Makefile
+++ b/drivers/firmware/rpmi/Makefile
@@ -1,4 +1,4 @@
 obj-y	+= rpmi-uclass.o
 obj-$(CONFIG_RPMI_SBI_MPXY) += rpmi-sbi-mpxy.o
 obj-$(CONFIG_RPMI_SHMEM) += rpmi-shmem.o
-obj-$(CONFIG_SANDBOX)	+= rpmi-sandbox.o rpmi-sandbox-clock.o
+obj-$(CONFIG_SANDBOX)	+= rpmi-sandbox.o rpmi-sandbox-clock.o rpmi-sandbox-power.o
diff --git a/drivers/firmware/rpmi/rpmi-sandbox-power.c b/drivers/firmware/rpmi/rpmi-sandbox-power.c
new file mode 100644
index 000000000000..aba0ecdda0a6
--- /dev/null
+++ b/drivers/firmware/rpmi/rpmi-sandbox-power.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Ventana Micro Systems Inc.
+ * Copyright (C) 2026 Microchip Technology Inc. All rights reserved.
+ */
+
+#define LOG_CATEGORY UCLASS_RPMI
+
+#include <asm/types.h>
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <rpmi.h>
+#include "rpmi-sandbox.h"
+
+struct rpmi_dpwr {
+	const char *name;
+	u32 trans_latency;
+	enum rpmi_dpwr_state state;
+};
+
+struct rpmi_dpwr dpwr_simulation[] = {
+	{ "DPWR0", 0, RPMI_DPWR_STATE_ON },
+	{ "DPWR1", 0, RPMI_DPWR_STATE_OFF },
+};
+
+static u32 dpwr_count = ARRAY_SIZE(dpwr_simulation);
+
+static struct rpmi_dpwr *rpmi_get_dpwr(u32 dpwrid)
+{
+	if (dpwrid >= ARRAY_SIZE(dpwr_simulation))
+		return NULL;
+
+	return &dpwr_simulation[dpwrid];
+}
+
+static enum rpmi_error_codes
+rpmi_dpwr_get_num_domains(struct rpmi_transport *trans, u16 request_datalen,
+			  const u8 *request_data, u16 *response_datalen,
+			  u8 *response_data)
+{
+	u32 *resp = (void *)response_data;
+
+	resp[1] = cpu_to_le32(dpwr_count);
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	*response_datalen = 2 * sizeof(*resp);
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes
+rpmi_dpwr_get_attributes(struct rpmi_transport *trans, u16 request_datalen,
+			 const u8 *request_data, u16 *response_datalen,
+			 u8 *response_data)
+{
+	u16 resp_dlen = sizeof(u32);
+	u32 *resp = (void *)response_data;
+	struct rpmi_dpwr *dpwr;
+
+	u32 dpwrid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	dpwr = rpmi_get_dpwr(dpwrid);
+	if (!dpwr) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	if (dpwr->name)
+		strlcpy((char *)&resp[3], dpwr->name, RPMI_DPWR_NAME_LEN);
+
+	resp[2] = cpu_to_le32(dpwr->trans_latency);
+	resp[1] = cpu_to_le32((u32)0x0);
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	resp_dlen = 3 * sizeof(*resp) + RPMI_DPWR_NAME_LEN;
+
+done:
+	*response_datalen = resp_dlen;
+
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes rpmi_dpwr_get_state(struct rpmi_transport *trans,
+						 u16 request_datalen,
+						 const u8 *request_data,
+						 u16 *response_datalen,
+						 u8 *response_data)
+{
+	u16 resp_dlen = sizeof(u32);
+	u32 *resp = (void *)response_data;
+	u32 dpwr_state = 0;
+	struct rpmi_dpwr *dpwr;
+
+	u32 dpwrid = cpu_to_le32(((const u32 *)request_data)[0]);
+
+	dpwr = rpmi_get_dpwr(dpwrid);
+	if (!dpwr) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	dpwr_state = dpwr->state;
+
+	resp[1] = cpu_to_le32((u32)dpwr_state);
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	resp_dlen = 2 * sizeof(*resp);
+
+done:
+	*response_datalen = resp_dlen;
+	return RPMI_SUCCESS;
+}
+
+static enum rpmi_error_codes rpmi_dpwr_set_state(struct rpmi_transport *trans,
+						 u16 request_datalen,
+						 const u8 *request_data,
+						 u16 *response_datalen,
+						 u8 *response_data)
+{
+	u16 resp_dlen = sizeof(u32);
+	u32 *resp = (void *)response_data;
+	struct rpmi_dpwr *dpwr;
+
+	u32 dpwrid = cpu_to_le32(((const u32 *)request_data)[0]);
+	u32 dpwr_state = cpu_to_le32(((const u32 *)request_data)[1]);
+
+	dpwr = rpmi_get_dpwr(dpwrid);
+	if (!dpwr) {
+		resp[0] = cpu_to_le32((u32)RPMI_ERR_INVALID_PARAM);
+		goto done;
+	}
+
+	dpwr->state = dpwr_state;
+
+	resp[0] = cpu_to_le32((u32)RPMI_SUCCESS);
+
+	resp_dlen = sizeof(*resp);
+
+done:
+	*response_datalen = resp_dlen;
+	return RPMI_SUCCESS;
+}
+
+static struct rpmi_service rpmi_dpwr_services[RPMI_DPWR_SRV_ID_MAX] = {
+	[RPMI_DPWR_SRV_GET_NUM_DOMAINS] = {
+		.service_id = RPMI_DPWR_SRV_GET_NUM_DOMAINS,
+		.min_a2p_request_datalen = 0,
+		.process_a2p_request = rpmi_dpwr_get_num_domains,
+	},
+	[RPMI_DPWR_SRV_GET_ATTRIBUTES] = {
+		.service_id = RPMI_DPWR_SRV_GET_ATTRIBUTES,
+		.min_a2p_request_datalen = 4,
+		.process_a2p_request = rpmi_dpwr_get_attributes,
+	},
+	[RPMI_DPWR_SRV_SET_DPWR_STATE] = {
+		.service_id = RPMI_DPWR_SRV_SET_DPWR_STATE,
+		.min_a2p_request_datalen = 8,
+		.process_a2p_request = rpmi_dpwr_set_state,
+	},
+	[RPMI_DPWR_SRV_GET_DPWR_STATE] = {
+		.service_id = RPMI_DPWR_SRV_GET_DPWR_STATE,
+		.min_a2p_request_datalen = 4,
+		.process_a2p_request = rpmi_dpwr_get_state,
+	},
+};
+
+const struct rpmi_service_group rpmi_sandbox_dpwr_sg = {
+	.name = "dpwr",
+	.max_service_id = RPMI_DPWR_SRV_GET_DPWR_STATE,
+	.servicegroup_version = RPMI_MKVER(1, 0),
+	.services = rpmi_dpwr_services,
+};
diff --git a/drivers/firmware/rpmi/rpmi-sandbox.c b/drivers/firmware/rpmi/rpmi-sandbox.c
index 5597c27067eb..c34c61da5d9e 100644
--- a/drivers/firmware/rpmi/rpmi-sandbox.c
+++ b/drivers/firmware/rpmi/rpmi-sandbox.c
@@ -29,6 +29,8 @@ const struct rpmi_service_group *rpmi_sandbox_sg(u32 servicegroup_id)
 	switch (servicegroup_id) {
 	case RPMI_SRVGRP_CLOCK:
 		return &rpmi_sandbox_clock_sg;
+	case RPMI_SRVGRP_DEVICE_POWER:
+		return &rpmi_sandbox_dpwr_sg;
 	default:
 		return NULL;
 	}
diff --git a/drivers/firmware/rpmi/rpmi-sandbox.h b/drivers/firmware/rpmi/rpmi-sandbox.h
index 132d1e9e8be6..7dea5035929e 100644
--- a/drivers/firmware/rpmi/rpmi-sandbox.h
+++ b/drivers/firmware/rpmi/rpmi-sandbox.h
@@ -43,5 +43,6 @@ struct rpmi_service_group {
 };
 
 extern const struct rpmi_service_group rpmi_sandbox_clock_sg;
+extern const struct rpmi_service_group rpmi_sandbox_dpwr_sg;
 
 #endif
diff --git a/test/dm/rpmi.c b/test/dm/rpmi.c
index 1ea29780a480..e886b9ab2da4 100644
--- a/test/dm/rpmi.c
+++ b/test/dm/rpmi.c
@@ -9,6 +9,7 @@
 #include <stdio.h>
 #include <dm/device-internal.h>
 #include <dm/test.h>
+#include <asm/power-domain.h>
 #include <test/ut.h>
 
 static int dm_test_rpmi_clock(struct unit_test_state *uts)
@@ -46,3 +47,23 @@ static int dm_test_rpmi_clock(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_rpmi_clock, UTF_SCAN_FDT);
+
+static int dm_test_rpmi_dpwr(struct unit_test_state *uts)
+{
+	struct udevice *rpmi_dev, *dpwr_dev, *dpwr_consumer;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_RPMI, "rpmi", &rpmi_dev));
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_POWER_DOMAIN,
+					      "rpmi-power-domain", &dpwr_dev));
+
+	ut_assertok(uclass_get_device_by_name(
+		UCLASS_MISC, "rpmi-power-domain-test", &dpwr_consumer));
+
+	ut_assertok(sandbox_power_domain_test_get(dpwr_consumer));
+	ut_assertok(sandbox_power_domain_test_on(dpwr_consumer));
+	ut_assertok(sandbox_power_domain_test_off(dpwr_consumer));
+
+	return 0;
+}
+DM_TEST(dm_test_rpmi_dpwr, UTF_SCAN_FDT);
-- 
2.47.3

