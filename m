Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88251FCB63B
	for <u-boot@archiver.kernel.org>; Sun,  8 Mar 2026 14:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FE7B83BC8;
	Sun,  8 Mar 2026 15:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WbWczLyM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C3AD83952; Sun,  8 Mar 2026 15:12:45 +0100 (CET)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CF538063E
 for <u-boot@lists.denx.de>; Sun,  8 Mar 2026 15:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82985f42664so1977893b3a.0
 for <u-boot@lists.denx.de>; Sun, 08 Mar 2026 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772979161; x=1773583961; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScvkNvF6HGkwHy4e7jd+t2c/BPyOyX9ijm2vSKrX2gM=;
 b=WbWczLyMxMxpT9uNP1Vt2LX4OTMGUXzZIusceoLXe1tmeqaZfN4a0OKtFa/u2YatQe
 o11X7myaOh7ttyZzqPyo6HAAaWhl4WCdCaha/Mkv/aUUpks7d/QePiAOAAKvzKD/rOf5
 Zw/3vpdROtMEsBK8PGVXmecLSZdvKR845Ub71a/W8HGyHt7y1WZky2pbuzYeCphFuazt
 S0TbKnXMdTH/0RPHxNVkPRJA+u93/0Vc509z/1tdXAskwC0pXhBOriPHZgTMtO1THRkd
 FITF09SzfmrxOWIZwLHdUbHjKr944nE+/Yuz0S1zSRNelyDIvHDglWce2qHFIPCw99lO
 Fv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772979161; x=1773583961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScvkNvF6HGkwHy4e7jd+t2c/BPyOyX9ijm2vSKrX2gM=;
 b=E2T8ndU7uTxeRYnspdwyInbCyj2VqyflO5ynrcxLE5MjrjIp0EOIusZffD27yFebST
 ni5rfu5nwOM/K8paCs+VapQE4WmWvVoUdFWiQk0p4Fw/V/HpkHl7Zj3367PMXPlILweU
 3wEqTP2doqW91ONjZSP+xRPu83twWYijgWjclpIMI7xJyOzFMlBAGc36sKwH8uYAVwbj
 mzaokX596leKxObP/38mTRWVuZCxlFEZh+pVmD0l8c1HpkgWqoM8R1yOO9yVRxJAhkBK
 9vVdghgsPBt7SWpqgYAOBwLIjo4Oz66aIBW5NTpotZBpM8yDOaYyQwZlRDUu2+X1X6oD
 DJ3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdIW81wPWUpkck7RvzLLS326Gg5dVmpo5IN/k7ugyOwscxdxPD8oo6ChRhVDeOAgmXQXIE7gY=@lists.denx.de
X-Gm-Message-State: AOJu0YzyLQgMhtzadoeHR5PlSFJnR7R4ZaNg49dEmMmebLxV9kEQdVTR
 0IQrFBOS16P0Pwcbf64Ntc+8P4fGGke/yVUwGq58MFhpoW9ZSa9N5TRT
X-Gm-Gg: ATEYQzznJeLtc/6/lsidhaJOBfrff1ihDnawzrq4Ak4OhWy9HqVgMxTFWMvspJ0CCnr
 +BdV/Xx0y9aX8hruLlXEHV1UGiEYaa0hT8hmF4c4McHVhGH+7X/ByM51mZ1hqrWoDcIFFIwBzXB
 30P3k0Jq9d8XuHIH8dmARr7iHpo+5FICImLOKvLiXFW8cY5cqfB1NPFjSzM2iM95rdOee9AsNQL
 zlD5fHUnn2y4j/4PS3mdQsagLgDnSJuEiuIevlXIDdDlK/9etlvQ4u1kpJ3Qv+3cjEXF41iSW3F
 t2iSwOG9ylhtMZ2HmMuhvst58Y1wGV/7itxacMtahV7a6AZQe0jfIfoPAIl6DwUArEuPdid1dC3
 pnaaf1kCmc0oxuV9Z2hkQ50aHpSub3n8qcAuoGNyAFzt5c3rxEiRH+vFRbtJhaVkts6+JDAPwI6
 iZ8De5lZ8Vuw7SqDOeY0bm688Vz+a65mEoJEESHRJmyv6QWyi0BhPB1rEjMAImIj92tDZkMXpH3
 3xRoXTxdn3yexstSGRXXA==
X-Received: by 2002:a05:6a00:12d2:b0:829:7b15:848 with SMTP id
 d2e1a72fcca58-829a2f90a6fmr7205215b3a.48.1772979160749; 
 Sun, 08 Mar 2026 07:12:40 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a463a1adsm7273605b3a.11.2026.03.08.07.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 07:12:40 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, tommy.shih@airoha.com,
 lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v2 1/2] phy: add common PHY properties support
Date: Sun,  8 Mar 2026 22:06:13 +0800
Message-Id: <20260308140614.50489-2-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260308140614.50489-1-lucienzx159@gmail.com>
References: <20260308140614.50489-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 08 Mar 2026 15:16:22 +0100
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

Add a new PHY_COMMON_PROPS library that provides helper functions for
PHY drivers to read standardized polarity properties from the device
tree node:

  - phy_get_rx_polarity() / phy_get_tx_polarity()
  - phy_get_manual_rx_polarity() / phy_get_manual_tx_polarity()

The dt-bindings/phy/phy.h header with PHY_POL_NORMAL, PHY_POL_INVERT,
and PHY_POL_AUTO constants is provided via dts/upstream/include, which
is already in the build include path.

Ported from Merge tag 'phy-for-7.0':
  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy

Link: https://git.kernel.org/linus/e7556b59ba65179612bce3fa56bb53d1b4fb20db
Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/phy/Kconfig                  |   8 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++
 include/linux/phy/phy-common-props.h |  70 +++++++
 4 files changed, 365 insertions(+)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/linux/phy/phy-common-props.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 09810b62b51..18419c1d490 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -339,4 +339,12 @@ source "drivers/phy/qcom/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 
+config PHY_COMMON_PROPS
+	bool "Common PHY properties support"
+	help
+	  Enable support for common PHY properties defined in the device tree,
+	  such as rx-polarity and tx-polarity. This provides helpers for PHY
+	  drivers to read polarity and other standard PHY properties from the
+	  device tree node.
+
 endmenu
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 83102349669..91610692cc0 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
 obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
+obj-$(CONFIG_PHY_COMMON_PROPS) += phy-common-props.o
 obj-y += cadence/
 obj-y += ti/
 obj-y += qcom/
diff --git a/drivers/phy/phy-common-props.c b/drivers/phy/phy-common-props.c
new file mode 100644
index 00000000000..e02051e53b4
--- /dev/null
+++ b/drivers/phy/phy-common-props.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * phy-common-props.c  --  Common PHY properties
+ *
+ * Copyright 2025-2026 NXP
+ * Ported to U-Boot 2026
+ */
+#include <dm/ofnode.h>
+#include <log.h>
+#include <malloc.h>
+#include <linux/phy/phy-common-props.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+
+/**
+ * ofnode_count_u32_prop - Count number of u32 elements in a property
+ * @node: Device tree node
+ * @propname: Property name
+ *
+ * Return: number of u32 elements, or negative error code
+ */
+static int ofnode_count_u32_prop(ofnode node, const char *propname)
+{
+	int size;
+
+	size = ofnode_read_size(node, propname);
+	if (size < 0) {
+		pr_debug("%s: property '%s' not found (err=%d)\n",
+			 __func__, propname, size);
+		return size;
+	}
+
+	pr_debug("%s: property '%s' has %zu bytes (%zu elements)\n",
+		 __func__, propname, (size_t)size, (size_t)(size / sizeof(u32)));
+
+	return size / sizeof(u32);
+}
+
+/**
+ * ofnode_get_u32_prop_for_name - Find u32 property by name, or default value
+ * @node: Device tree node; if invalid or @props_title is absent, -ENOENT is returned
+ * @name: Property name used as lookup key in @names_title (must not be NULL)
+ * @props_title: Name of u32 array property holding values
+ * @names_title: Name of string array property holding lookup keys
+ * @default_val: Default value if @props_title exists but is empty
+ * @val: Pointer to store the returned value
+ *
+ * This function retrieves a u32 value from @props_title based on a name lookup
+ * in @names_title. The value stored in @val is determined as follows:
+ *
+ * - If @node is invalid or @props_title is absent: -ENOENT is returned
+ * - If @props_title exists but is empty: @default_val is used
+ * - If @props_title has exactly one element and @names_title is empty:
+ *   that element is used
+ * - Otherwise: @val is set to the element at the same index where @name is
+ *   found in @names_title.
+ * - If @name is not found, the function looks for a "default" entry in
+ *   @names_title and uses the corresponding value from @props_title
+ *
+ * When both @props_title and @names_title are present, they must have the
+ * same number of elements (except when @props_title has exactly one element).
+ *
+ * Return: zero on success, negative error on failure.
+ */
+static int ofnode_get_u32_prop_for_name(ofnode node, const char *name,
+					const char *props_title,
+					const char *names_title,
+					unsigned int default_val,
+					unsigned int *val)
+{
+	int err, n_props, n_names, idx;
+	u32 *props;
+
+	if (!name) {
+		printf("Error: Lookup key inside \"%s\" is mandatory\n",
+		       names_title);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: looking up '%s' in props='%s' names='%s' default=%u\n",
+		 __func__, name, props_title, names_title, default_val);
+
+	n_props = ofnode_count_u32_prop(node, props_title);
+	if (n_props < 0) {
+		/* property is absent */
+		pr_debug("%s: '%s' is absent, returning -ENOENT\n",
+			 __func__, props_title);
+		return -ENOENT;
+	}
+	if (n_props == 0) {
+		/* property exists but is empty, use default */
+		pr_debug("%s: '%s' is empty, using default value %u\n",
+			 __func__, props_title, default_val);
+		*val = default_val;
+		return 0;
+	}
+
+	n_names = ofnode_read_string_count(node, names_title);
+
+	pr_debug("%s: '%s' has %d elements, '%s' has %d entries\n",
+		 __func__, props_title, n_props, names_title, n_names);
+	if (n_names >= 0 && n_props != n_names) {
+		printf("Error: mismatch between \"%s\" and \"%s\" property count (%d vs %d)\n",
+		       props_title, names_title, n_props, n_names);
+		return -EINVAL;
+	}
+
+	idx = ofnode_stringlist_search(node, names_title, name);
+	if (idx >= 0) {
+		pr_debug("%s: found '%s' at index %d in '%s'\n",
+			 __func__, name, idx, names_title);
+	} else {
+		pr_debug("%s: '%s' not found in '%s', trying 'default'\n",
+			 __func__, name, names_title);
+		idx = ofnode_stringlist_search(node, names_title, "default");
+		if (idx >= 0)
+			pr_debug("%s: 'default' entry found at index %d\n",
+				 __func__, idx);
+		else
+			pr_debug("%s: 'default' entry not found in '%s'\n",
+				 __func__, names_title);
+	}
+	/*
+	 * If the mode name is missing, it can only mean the specified property
+	 * is the default one for all modes, so reject any other property count
+	 * than 1.
+	 */
+	if (idx < 0 && n_props != 1) {
+		printf("Error: \"%s\" property has %d elements, but cannot find \"%s\" in \"%s\" and there is no default value\n",
+		       props_title, n_props, name, names_title);
+		return -EINVAL;
+	}
+
+	if (n_props == 1) {
+		pr_debug("%s: single-element '%s', reading directly\n",
+			 __func__, props_title);
+		err = ofnode_read_u32(node, props_title, val);
+		if (err) {
+			pr_debug("%s: failed to read '%s' (err=%d)\n",
+				 __func__, props_title, err);
+			return err;
+		}
+		pr_debug("%s: resolved value %u for name '%s' from '%s'\n",
+			 __func__, *val, name, props_title);
+		return 0;
+	}
+
+	/* We implicitly know idx >= 0 here */
+	props = calloc(n_props, sizeof(*props));
+	if (!props)
+		return -ENOMEM;
+
+	err = ofnode_read_u32_array(node, props_title, props, n_props);
+	if (err >= 0) {
+		*val = props[idx];
+		pr_debug("%s: resolved value %u at index %d for name '%s' from '%s'\n",
+			 __func__, *val, idx, name, props_title);
+	} else {
+		pr_debug("%s: failed to read u32 array '%s' (err=%d)\n",
+			 __func__, props_title, err);
+	}
+
+	free(props);
+
+	return err;
+}
+
+/**
+ * phy_get_polarity_for_mode - Get polarity for a specific PHY mode
+ * @node: Device tree node
+ * @mode_name: The name of the PHY mode to look up
+ * @supported: Bit mask of supported polarity values
+ * @default_val: Default polarity value if property is missing
+ * @polarity_prop: Name of the polarity property
+ * @names_prop: Name of the names property
+ * @val: Pointer to returned polarity
+ *
+ * Return: zero on success, negative error on failure.
+ */
+static int phy_get_polarity_for_mode(ofnode node, const char *mode_name,
+				     unsigned int supported,
+				     unsigned int default_val,
+				     const char *polarity_prop,
+				     const char *names_prop,
+				     unsigned int *val)
+{
+	int err;
+
+	pr_debug("%s: querying '%s' for mode '%s' (supported=0x%x, default=%u)\n",
+		 __func__, polarity_prop, mode_name, supported, default_val);
+
+	err = ofnode_get_u32_prop_for_name(node, mode_name, polarity_prop,
+					   names_prop, default_val, val);
+	if (err) {
+		pr_debug("%s: '%s' lookup failed for mode '%s' (err=%d)\n",
+			 __func__, polarity_prop, mode_name, err);
+		return err;
+	}
+
+	pr_debug("%s: '%s' for mode '%s' = %u\n",
+		 __func__, polarity_prop, mode_name, *val);
+
+	if (!(supported & BIT(*val))) {
+		printf("Error: %d is not a supported value for '%s' element '%s'\n",
+		       *val, polarity_prop, mode_name);
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
+/**
+ * phy_get_rx_polarity - Get RX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_rx_polarity(ofnode node, const char *mode_name,
+			unsigned int supported, unsigned int default_val,
+			unsigned int *val)
+{
+	return phy_get_polarity_for_mode(node, mode_name, supported,
+					 default_val, "rx-polarity",
+					 "rx-polarity-names", val);
+}
+
+/**
+ * phy_get_tx_polarity - Get TX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_tx_polarity(ofnode node, const char *mode_name,
+			unsigned int supported, unsigned int default_val,
+			unsigned int *val)
+{
+	return phy_get_polarity_for_mode(node, mode_name, supported,
+					 default_val, "tx-polarity",
+					 "tx-polarity-names", val);
+}
+
+/**
+ * phy_get_manual_rx_polarity - Get manual RX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs which do not support protocols with automatic RX polarity
+ * detection and correction.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_manual_rx_polarity(ofnode node, const char *mode_name,
+			       unsigned int *val)
+{
+	return phy_get_rx_polarity(node, mode_name,
+				   BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				   PHY_POL_NORMAL, val);
+}
+
+/**
+ * phy_get_manual_tx_polarity - Get manual TX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs without any custom default value for the TX polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_manual_tx_polarity(ofnode node, const char *mode_name,
+			       unsigned int *val)
+{
+	return phy_get_tx_polarity(node, mode_name,
+				   BIT(PHY_POL_NORMAL) | BIT(PHY_POL_INVERT),
+				   PHY_POL_NORMAL, val);
+}
diff --git a/include/linux/phy/phy-common-props.h b/include/linux/phy/phy-common-props.h
new file mode 100644
index 00000000000..77158f3e5f1
--- /dev/null
+++ b/include/linux/phy/phy-common-props.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-common-props.h -- Common properties for generic PHYs
+ *
+ * Copyright 2025-2026 NXP
+ * Ported to U-Boot 2026
+ */
+
+#ifndef __PHY_COMMON_PROPS_H
+#define __PHY_COMMON_PROPS_H
+
+#include <dt-bindings/phy/phy.h>
+#include <dm/ofnode.h>
+
+/**
+ * phy_get_rx_polarity - Get RX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_rx_polarity(ofnode node, const char *mode_name,
+			unsigned int supported, unsigned int default_val,
+			unsigned int *val);
+
+/**
+ * phy_get_tx_polarity - Get TX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @supported: Bit mask of PHY_POL_NORMAL, PHY_POL_INVERT and PHY_POL_AUTO
+ * @default_val: Default polarity value if property is missing
+ * @val: Pointer to returned polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_tx_polarity(ofnode node, const char *mode_name,
+			unsigned int supported, unsigned int default_val,
+			unsigned int *val);
+
+/**
+ * phy_get_manual_rx_polarity - Get manual RX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs which do not support protocols with automatic RX polarity
+ * detection and correction.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_manual_rx_polarity(ofnode node, const char *mode_name,
+			       unsigned int *val);
+
+/**
+ * phy_get_manual_tx_polarity - Get manual TX polarity for PHY differential lane
+ * @node: Pointer to the PHY's device tree node.
+ * @mode_name: The name of the PHY mode to look up.
+ * @val: Pointer to returned polarity.
+ *
+ * Helper for PHYs without any custom default value for the TX polarity.
+ *
+ * Return: zero on success, negative error on failure.
+ */
+int phy_get_manual_tx_polarity(ofnode node, const char *mode_name,
+			       unsigned int *val);
+
+#endif /* __PHY_COMMON_PROPS_H */
-- 
2.34.1

