Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B694FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D40484399;
	Sat, 25 Apr 2026 20:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C8yyNJH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75AB384399; Sat, 25 Apr 2026 18:57:45 +0200 (CEST)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E080C84368
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-56f660d9a51so5701486e0c.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777136262; x=1777741062; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/Ji6+fUIxG6lrpt0itctV9+ASA6Jmt96Isv9Fnp3T8=;
 b=C8yyNJH8mnbmqHMsHa65KOyMIpvO0msCsCf4HbQbdjqnxUSRmLtmNb9IDcSOZzl9j+
 OwSxr2eqMRCCNw8va+wd+7cG9zLbKD/IVwSW/LoamHlOsbfWmgDSa3yKo7IbQ/3r3/4m
 HWW71NaoB6r7VvLNUiZ4Yc6DTR50xWVJNFT3XQiEJR9hfKGbKM09ifrT93EFYmfw4vSm
 2qBvMiczmtTR6nPMiCAkqi9JnJmPAzQ6JYRrzcB/Ugvyfszza99kcdDEEz2/spA6F5B9
 AULZYZpyt3RxADcJGQ/XT5gsk74Pp0mK7nW+9tIy9Q/TydE/Kw54hmkH/b4a3eeOWvnR
 5HJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777136262; x=1777741062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W/Ji6+fUIxG6lrpt0itctV9+ASA6Jmt96Isv9Fnp3T8=;
 b=lokqGZcwdAeLhN2oe771nkXJjyHCokMwK8p+qrSjC4pjEk0Z8Clk82JbJo/ASMA0LU
 i+rt0X0wuQaSOmff42oWIvrU4YEASm5AorQGfO2my2aeL6Mknve9n24gw3xJ/PIxsKsV
 FasmhGiYkbCDgTvhOZiVWnBYtfTqK4YT5BsaBnKhBuV+smrSQzwB7qhdGPzERbIDXwZV
 pXnnqhK7fHpCOhUsENpZnNQi+jVy1lKOSUsk4Eh4T70djf7gZ3Tnjy6ro45RvWMPnuNH
 PLipZBjxskdPz3RfpaMADtybsoUq1QyoLqalj4BwiruPQCsoP0VZXXKGmrPZxeREHhNK
 H6Ow==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HubFcVmZNWCQfz9l4hu7cvgSr/ywXsS2lCbvn2DqPW8aUFHTOsqAXFygDl0aWm0wO25ebabA=@lists.denx.de
X-Gm-Message-State: AOJu0YzIaEshnALmpQovF+qsLe2rLP51WNBU3xr6pjO+xfXPMlgwv3xA
 dYWmPVGZnfVDquSvJ5H8fz/V7ONmbwmZpSGXxYeqHUjIBYppZqRxgAIutanS3A==
X-Gm-Gg: AeBDies30UJt+CFeX7+3WaiIZyZWs05oDhek+TfvdIRQsWbTH8C4hcVx/WEajHsrRJ8
 n0G8AL2tAShlr3NHwWdKU4OtgmJKM3vxVP05JZEV7JdJ5Q8EEwscaE904pdATv26t5OR32bdd+2
 CykZxhHPAiyUdcuxoFF3lwbQWc7rGLVY7ecsq1pWdCS23TLSTWJkfqItbShkFjp2dq54oQCDx5u
 7rh39tRXrPC1SAC62yS7yRbot8QPgnaiTTO/qwMLE3qhTI92Qfd85DeuwAm+SPvDG51ZcB8ilFL
 A5fdyzwqKXcT7Yvi5d4S0oROFRn/HY32UB//HVrQ1eNXk79S6TOdeVQNdc23mYt3jPq4WPj4l8N
 15xrPBecWJYBraupaqqw01PU9WBEAuCOMm4t7gkpYxvcvi8BHZxBmOH3M4zP8KiWtSLMeyAY7V0
 HGZ6Mvk265TNN/TvT+ahj4lsAyV80OIaxfIy66OOh4qF0b43mNY/SklJ1+4oNuB+075B6Ct6hY/
 +tH5YxMhOkjKOftjxY2Wcagf5bv7OdR
X-Received: by 2002:a17:903:1a45:b0:2b2:65db:8c5f with SMTP id
 d9443c01a7336-2b5f9f4f562mr374049365ad.27.1777104524951; 
 Sat, 25 Apr 2026 01:08:44 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm250916935ad.54.2026.04.25.01.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 01:08:44 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v4 3/3] test: dm: add PHY common props unit tests and sandbox
 DT nodes
Date: Sat, 25 Apr 2026 16:06:49 +0800
Message-Id: <20260425080649.75688-4-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425080649.75688-1-lucienzx159@gmail.com>
References: <20260425080649.75688-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:02:44 +0200
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

Add sandbox DM unit tests for the PHY common properties library and the
corresponding device tree test nodes to arch/sandbox/dts/test.dts.
Also enable CONFIG_PHY_COMMON_PROPS in configs/sandbox_defconfig so
the tests are built and run in the sandbox environment.

The test file covers rx/tx polarity lookups for all relevant cases:

  - missing property (defaults to PHY_POL_NORMAL)
  - single value without names array (applies to all modes)
  - count mismatch between values and names arrays (-EINVAL)
  - name found by exact match
  - name not found with no "default" fallback (-EINVAL)
  - name not found with a "default" entry (uses fallback value)
  - unsupported polarity value (-EOPNOTSUPP)

Ported from Linux KUnit test:
  linux/drivers/phy/phy-common-props-test.c

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
``` execute phy common props tests in sandbox:
Bloblist at 100 not found (err=-2)
pinctrl_select_state_full() sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19


U-Boot 2026.01-rc5--gd1a76e2e4a64-dirty (Apr 25 2026 - 15:40:39 +0800)

Reset Status: WARM Reset Status: COLD
Model: sandbox
DRAM:  256 MiB
Core:  294 devices, 105 uclasses, devicetree: board, universal payload active
WDT:   Not starting wdt-gpio-toggle
WDT:   Not starting wdt-gpio-level
WDT:   Not starting wdt@0
NAND:  4100 MiB
MMC:   Can't map file 'mmc1.img': Invalid argument
   sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
Can't map file 'mmc1.img': Invalid argument
   sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
           mmc_probe() mmc1 - probe failed: -1
mmc2: 2 (SD)Can't map file 'mmc1.img': Invalid argument
   sandbox_mmc_probe() mmc1: Unable to map file 'mmc1.img'
, mmc0: 0 (SD)
Loading Environment from nowhere... OK
In:    serial
Out:   serial,vidconsole
Err:   serial,vidconsole
Model: sandbox
Net:   eth0: eth@10002000, eth5: eth@10003000, eth3: sbe5, eth6: eth@10004000, eth8: phy-test-eth, eth4: dsa-test-eth, eth2: lan0, eth7: lan1

Test: phy_common_props_rx_find_by_name: phy_common_props.c
Test: phy_common_props_rx_find_by_name: phy_common_props.c (flat tree)
Test: phy_common_props_rx_missing: phy_common_props.c
Test: phy_common_props_rx_missing: phy_common_props.c (flat tree)
Test: phy_common_props_rx_more_names: phy_common_props.c
Test: phy_common_props_rx_more_names: phy_common_props.c (flat tree)
Test: phy_common_props_rx_more_values: phy_common_props.c
Test: phy_common_props_rx_more_values: phy_common_props.c (flat tree)
Test: phy_common_props_rx_no_default: phy_common_props.c
Test: phy_common_props_rx_no_default: phy_common_props.c (flat tree)
Test: phy_common_props_rx_single_value: phy_common_props.c
Test: phy_common_props_rx_single_value: phy_common_props.c (flat tree)
Test: phy_common_props_rx_unsupported: phy_common_props.c
Test: phy_common_props_rx_unsupported: phy_common_props.c (flat tree)
Test: phy_common_props_rx_with_default: phy_common_props.c
Test: phy_common_props_rx_with_default: phy_common_props.c (flat tree)
Test: phy_common_props_tx_find_by_name: phy_common_props.c
Test: phy_common_props_tx_find_by_name: phy_common_props.c (flat tree)
Test: phy_common_props_tx_missing: phy_common_props.c
Test: phy_common_props_tx_missing: phy_common_props.c (flat tree)
Test: phy_common_props_tx_more_names: phy_common_props.c
Test: phy_common_props_tx_more_names: phy_common_props.c (flat tree)
Test: phy_common_props_tx_more_values: phy_common_props.c
Test: phy_common_props_tx_more_values: phy_common_props.c (flat tree)
Test: phy_common_props_tx_no_default: phy_common_props.c
Test: phy_common_props_tx_no_default: phy_common_props.c (flat tree)
Test: phy_common_props_tx_single_value: phy_common_props.c
Test: phy_common_props_tx_single_value: phy_common_props.c (flat tree)
Test: phy_common_props_tx_unsupported: phy_common_props.c
Test: phy_common_props_tx_unsupported: phy_common_props.c (flat tree)
Test: phy_common_props_tx_with_default: phy_common_props.c
Test: phy_common_props_tx_with_default: phy_common_props.c (flat tree)
Tests run: 16, 41 ms, average: 2 ms, failures: 0

 arch/sandbox/dts/test.dts  |  60 +++++++
 configs/sandbox_defconfig  |   1 +
 test/dm/Makefile           |   1 +
 test/dm/phy_common_props.c | 319 +++++++++++++++++++++++++++++++++++++
 4 files changed, 381 insertions(+)
 create mode 100644 test/dm/phy_common_props.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index ac92ebf1afd..0887de4333b 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -16,6 +16,7 @@
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/sandbox-pinmux.h>
 #include <dt-bindings/mux/mux.h>
+#include <dt-bindings/phy/phy.h>

 / {
 	model = "sandbox";
@@ -502,6 +503,65 @@
 		phy-names = "phy1";
 	};

+	/* PHY common props test nodes */
+	phy_common_props_missing: phy-common-props-missing {
+		/* empty: no rx-polarity or tx-polarity properties */
+	};
+
+	phy_common_props_more_values: phy-common-props-more-values {
+		/* 3 values but only 2 names => count mismatch */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_NORMAL>;
+		rx-polarity-names = "sgmii", "2500base-x";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_NORMAL>;
+		tx-polarity-names = "sgmii", "2500base-x";
+	};
+
+	phy_common_props_single: phy-common-props-single {
+		/* 1 value, no names array => value applies to all modes */
+		rx-polarity = <PHY_POL_INVERT>;
+		tx-polarity = <PHY_POL_INVERT>;
+	};
+
+	phy_common_props_more_names: phy-common-props-more-names {
+		/* 2 values but 3 names => count mismatch */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		rx-polarity-names = "sgmii", "2500base-x", "1000base-x";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		tx-polarity-names = "sgmii", "2500base-x", "1000base-x";
+	};
+
+	phy_common_props_find_by_name: phy-common-props-find-by-name {
+		/* valid 3-element arrays, lookup by mode name */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_AUTO>;
+		rx-polarity-names = "sgmii", "2500base-x", "usb-ss";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT PHY_POL_NORMAL>;
+		tx-polarity-names = "sgmii", "2500base-x", "1000base-x";
+	};
+
+	phy_common_props_no_default: phy-common-props-no-default {
+		/* name not in array, no "default" entry => -EINVAL */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		rx-polarity-names = "2500base-x", "1000base-x";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		tx-polarity-names = "2500base-x", "1000base-x";
+	};
+
+	phy_common_props_with_default: phy-common-props-with-default {
+		/* name not in array, but "default" entry exists */
+		rx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		rx-polarity-names = "2500base-x", "default";
+		tx-polarity = <PHY_POL_NORMAL PHY_POL_INVERT>;
+		tx-polarity-names = "2500base-x", "default";
+	};
+
+	phy_common_props_unsupported: phy-common-props-unsupported {
+		/* PHY_POL_AUTO is not supported for manual-only modes */
+		rx-polarity = <PHY_POL_AUTO>;
+		rx-polarity-names = "sgmii";
+		tx-polarity = <PHY_POL_AUTO>;
+		tx-polarity-names = "sgmii";
+	};
+
 	some-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index b681b91c3f9..487bb3ec03c 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -284,6 +284,7 @@ CONFIG_PCI_REGION_MULTI_ENTRY=y
 CONFIG_PCI_FTPCI100=y
 CONFIG_PCI_SANDBOX=y
 CONFIG_PHY=y
+CONFIG_PHY_COMMON_PROPS=y
 CONFIG_PHY_SANDBOX=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 771b703b737..d69b0e08d66 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -88,6 +88,7 @@ obj-$(CONFIG_P2SB) += p2sb.o
 obj-$(CONFIG_PCI_ENDPOINT) += pci_ep.o
 obj-$(CONFIG_PCH) += pch.o
 obj-$(CONFIG_PHY) += phy.o
+obj-$(CONFIG_PHY_COMMON_PROPS) += phy_common_props.o
 ifneq ($(CONFIG_PINMUX),)
 obj-$(CONFIG_PINCONF) += pinmux.o
 endif
diff --git a/test/dm/phy_common_props.c b/test/dm/phy_common_props.c
new file mode 100644
index 00000000000..21f5042b7a0
--- /dev/null
+++ b/test/dm/phy_common_props.c
@@ -0,0 +1,319 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * U-Boot sandbox DM tests for PHY common props
+ *
+ * Ported from Linux KUnit test:
+ *   linux/drivers/phy/phy-common-props-test.c
+ *
+ * Copyright 2025-2026 NXP
+ */
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <dm/test.h>
+#include <linux/bitops.h>
+#include <linux/phy/phy-common-props.h>
+#include <dt-bindings/phy/phy.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* --- RX polarity tests -------------------------------------------------- */
+
+/* Test: rx-polarity property is missing => default PHY_POL_NORMAL */
+static int dm_test_phy_common_props_rx_missing(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-missing");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_NORMAL, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_missing, UTF_SCAN_FDT);
+
+/* Test: rx-polarity has more values than rx-polarity-names => -EINVAL */
+static int dm_test_phy_common_props_rx_more_values(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-more-values");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_more_values, UTF_SCAN_FDT);
+
+/* Test: rx-polarity has 1 value and rx-polarity-names does not exist */
+static int dm_test_phy_common_props_rx_single_value(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-single");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_INVERT, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_single_value, UTF_SCAN_FDT);
+
+/* Test: rx-polarity-names has more values than rx-polarity => -EINVAL */
+static int dm_test_phy_common_props_rx_more_names(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-more-names");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_more_names, UTF_SCAN_FDT);
+
+/* Test: valid arrays, find polarity by mode name */
+static int dm_test_phy_common_props_rx_find_by_name(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-find-by-name");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_NORMAL, val);
+
+	ret = phy_get_manual_rx_polarity(node, "2500base-x", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_INVERT, val);
+
+	/* "usb-ss" has PHY_POL_AUTO; auto is supported here */
+	ret = phy_get_rx_polarity(node, "usb-ss", BIT(PHY_POL_AUTO),
+				  PHY_POL_AUTO, &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_AUTO, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_find_by_name, UTF_SCAN_FDT);
+
+/* Test: name not found, no "default" entry => -EINVAL */
+static int dm_test_phy_common_props_rx_no_default(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-no-default");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_no_default, UTF_SCAN_FDT);
+
+/* Test: name not found, "default" entry exists => use default polarity */
+static int dm_test_phy_common_props_rx_with_default(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-with-default");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_INVERT, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_with_default, UTF_SCAN_FDT);
+
+/* Test: polarity value found but not in supported set => -EOPNOTSUPP */
+static int dm_test_phy_common_props_rx_unsupported(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-unsupported");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_rx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EOPNOTSUPP, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_rx_unsupported, UTF_SCAN_FDT);
+
+/* --- TX polarity tests -------------------------------------------------- */
+
+/* Test: tx-polarity property is missing => default PHY_POL_NORMAL */
+static int dm_test_phy_common_props_tx_missing(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-missing");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_NORMAL, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_missing, UTF_SCAN_FDT);
+
+/* Test: tx-polarity has more values than tx-polarity-names => -EINVAL */
+static int dm_test_phy_common_props_tx_more_values(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-more-values");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_more_values, UTF_SCAN_FDT);
+
+/* Test: tx-polarity has 1 value and tx-polarity-names does not exist */
+static int dm_test_phy_common_props_tx_single_value(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-single");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_INVERT, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_single_value, UTF_SCAN_FDT);
+
+/* Test: tx-polarity-names has more values than tx-polarity => -EINVAL */
+static int dm_test_phy_common_props_tx_more_names(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-more-names");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_more_names, UTF_SCAN_FDT);
+
+/* Test: valid arrays, find polarity by mode name */
+static int dm_test_phy_common_props_tx_find_by_name(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-find-by-name");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_NORMAL, val);
+
+	ret = phy_get_manual_tx_polarity(node, "2500base-x", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_INVERT, val);
+
+	ret = phy_get_manual_tx_polarity(node, "1000base-x", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_NORMAL, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_find_by_name, UTF_SCAN_FDT);
+
+/* Test: name not found, no "default" entry => -EINVAL */
+static int dm_test_phy_common_props_tx_no_default(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-no-default");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EINVAL, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_no_default, UTF_SCAN_FDT);
+
+/* Test: name not found, "default" entry exists => use default polarity */
+static int dm_test_phy_common_props_tx_with_default(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-with-default");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(0, ret);
+	ut_asserteq(PHY_POL_INVERT, val);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_with_default, UTF_SCAN_FDT);
+
+/* Test: polarity value found but not in supported set => -EOPNOTSUPP */
+static int dm_test_phy_common_props_tx_unsupported(struct unit_test_state *uts)
+{
+	ofnode node = ofnode_path("/phy-common-props-unsupported");
+	unsigned int val;
+	int ret;
+
+	ut_assert(ofnode_valid(node));
+
+	ret = phy_get_manual_tx_polarity(node, "sgmii", &val);
+	ut_asserteq(-EOPNOTSUPP, ret);
+
+	return 0;
+}
+
+DM_TEST(dm_test_phy_common_props_tx_unsupported, UTF_SCAN_FDT);
--
2.34.1

