Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F1BE9D812
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 20:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59E04840BE;
	Sun,  5 Apr 2026 22:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KwI6sQo0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 911628352B; Sun,  5 Apr 2026 16:51:08 +0200 (CEST)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC368341A
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 16:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35d9827661bso1551963a91.3
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 07:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775400664; x=1776005464; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xYHCR7KKs1F3PTp/+hbSZtkNbzPHb+6RNFweXTPGT4=;
 b=KwI6sQo0h0CNEqRwbXL5ScrcxWyKwmxBD177D3b3/xHnKnQIbKHKn9Y0pjZEoPL/80
 GsFmXsVqge26diRf/OjP+KzCc/avIV5lcOeVLwJOjVp6TmHsowCl9MQHyU/13JmeYAss
 vZ7N7fQZCvUSRlP5CVCaguWVhrYyf4CUORhwUdMSIchNwwJRjjx56f6lnzOL0lLSnJtj
 jIvW9fx87kuchbfVfrLAh+AlntJHEO7ykk79WibYi9u57iw3+MtJ7dY5A8TmRPc4Oda5
 7jRLbU8Cgph8cayOvY8XZVZl+cE0n3FDLPeuvxksye7PKNxabfEhlnauTuIbAkwO2hoQ
 EzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775400664; x=1776005464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0xYHCR7KKs1F3PTp/+hbSZtkNbzPHb+6RNFweXTPGT4=;
 b=nO9sSQfQZlF0dg5+LOmnyMrm4mUtjo5TKQz22f/+VY6ADyzV65Jv6F+NHGiiQAttBu
 b9XH9vd6PdKO6I2cUYs5/cpxCQtX4u30c6UO+jz5gu4XIgJTvQbJEU2QmmSpY+K2M03K
 LlwwBQYCuRHhlHa+Jz+HMfGT1uOMvV1wSAR8YWxkxw6uaL6RpO+89Vt/MY7Xc7+ubfP7
 H9qDMvN6sSok1CwTErxCyxbg4HyKyNqRxPLAhuvQhE0KGhSOAbJ2BNBCcWWML3JpG7TY
 4YxdmExWNKp4b4HXett8ex1QMqSdsQ8Ey72uiNlsdIelAWeYkLEEPKE48ldhyhr7l9x3
 RFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJbmqEomnS005hl4V3F6InKH1FKtm98spEnNzAvjuCI/vy60RaVdr7RBjWgmitnxMvgS++eH0=@lists.denx.de
X-Gm-Message-State: AOJu0YwR1ADvpw+JMMdLNkkdF7TbmUbA10pb4Qb6BP6cGikgnkJ6A9Mp
 2FlrYird1fmuFvwUcye26WHLblgWM92HqTTLZGNoXhz/HXYY3gQltJJY
X-Gm-Gg: AeBDieuCtjqV9kHViL2GGZCD6G6uNiQ+7q6D1dL3GgGMQs83wmmqu8G40EIDcgrTfQc
 gkeeXw1Oz3ixNQH2b9+bPHaFSMQ9PIX8/nrW9KRqbfumMI0LId26WAXy4Zkwb5oG5Wx7L4KxjQV
 phB1x3GMTx7Kt5sxC7dIyDN55WyvWDBaS9pvwGxCQEWliSbQoD6YOoqVdvETnCB42ri9T6RS198
 lKI1uWKC4JIzEF8ZHOlTTaPqOXVV16pvQsXV9g+oaIeCemrX65k1XYjDWqvfP/BqjPunrEID7DV
 2FiDFbXUT2YzY3dwEVhyV17muImNuS9g7l9WOQ2QGKCDd4z02wr3RwcVZvzCfvyAxd5meAEAxNa
 Plg2Y9lyPWKbgRvE2e97vH2Khfvqda6Vu4lYokxnUbTo0a9qQnyzoDsJp0kp7K224anB1cWICx7
 DzAccCZ5w4gIu5wTAOwUO/Z6MHEK004QzvU7SkDN5GiN0CjSaONebWopYJ2gNRCF4VbozKwiXTc
 FZgBakALwEMrR0zzUAn5w==
X-Received: by 2002:a17:90b:1e44:b0:35b:e56e:b58b with SMTP id
 98e67ed59e1d1-35de6940d3bmr9558488a91.15.1775400664459; 
 Sun, 05 Apr 2026 07:51:04 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe959358sm15333261a91.13.2026.04.05.07.51.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 07:51:04 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v3 3/4] test: dm: add PHY common props unit tests
Date: Sun,  5 Apr 2026 22:49:43 +0800
Message-Id: <20260405144944.41074-4-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260405144944.41074-1-lucienzx159@gmail.com>
References: <20260405144944.41074-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 22:17:12 +0200
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

Add obj-$(CONFIG_PHY_COMMON_PROPS) build entry in test/dm/Makefile and
sandbox DM unit tests for the PHY common properties library, covering
rx/tx polarity lookups for all relevant cases:

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

```test log```
執行 phy common props 測試...
Bloblist at 100 not found (err=-2)
pinctrl_select_state_full() sandbox_serial serial: pinctrl_select_state_full: uclass_get_device_by_phandle_id: err=-19


U-Boot 2026.01-rc5--g11ad53c5213e-dirty (Mar 22 2026 - 22:31:17 +0800)

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
Tests run: 16, 37 ms, average: 2 ms, failures: 0

 test/dm/Makefile           |   1 +
 test/dm/phy_common_props.c | 319 +++++++++++++++++++++++++++++++++++++
 2 files changed, 320 insertions(+)
 create mode 100644 test/dm/phy_common_props.c

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

