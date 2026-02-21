Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B71C61DE3
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 17:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 242FA83DBF;
	Sat, 21 Feb 2026 18:32:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JgMrRMmF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2307F83936; Sat, 21 Feb 2026 17:32:32 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCAD0801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 17:32:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a871daa98fso20816385ad.1
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771691547; x=1772296347; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJEIUbaiJbu423esZVw26Ck2Lda8RwYSyUcMasYoxJw=;
 b=JgMrRMmFZgfj4cx41hb1EaDHiCn8aboLDVVe3eiJIFpmJ18DQq8f/9gRUJtlq/gvd8
 Q+oFI4LHAhukjaf4Zu6DIr8X260eeZf70v+Z6VpZhJ2oAFHb/1GPAyJ/JXJ2wqisZAjk
 9j4fzZhBBABPsnR4rqilqGyAM+a6BbB+zGLBo7X9+/CL/pUszrItD2C398G+fsR4HI4k
 tBSoVBHbkqR91Kp2sXXV/D9+jxHOXSNT2Y5o+IpQRVD0yLyHOJYsVJNTE2SF8zjai0/C
 nEZDtS1bTy+kW1czxMftS+dnyIDNdnpXFxrxuAhggKfEQ9QcEjhXpOafYXPuioX4ugW/
 MLHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771691547; x=1772296347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJEIUbaiJbu423esZVw26Ck2Lda8RwYSyUcMasYoxJw=;
 b=kQAagEr4BtkTU28x+9zEk7IMpbJ18S9sIEjjPTNXycGtKvaxporis6Z24GQ217ij35
 mjKc7FeFYBx5YHNIvDgtRBhRykqx+1548Nw8VkucXslBXCbZijTp2ttBnB7pk7Dmv0ER
 eKKyKBmDuVUdSzoBqeXuzFBTLrGV4Bjk9cxk+cVapjEvRuYoxpFlTZ7W8TUSQrDtrj2p
 ygkrze2me76NdFFCt3JFXBFnxDrCCGIio5RlZMfP5D+s6LEydRqGXb3zF8YmxTOuhFR1
 YHwt34JSqneXsfb1LvD15ltwXUPJQnR+HVfahUo4dvczQROlNP+SCOULmM1/kKT8DSEs
 8LhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF0U9YQBREC3lAj2ixNN6jwhk7vni9S6A/hhO8Pj9JGvaXtCUJo8i1+JB1lbcuvqLnBy3URkE=@lists.denx.de
X-Gm-Message-State: AOJu0YwFKMIP7u1lTwvCC1ITNEKkfKv7sV86qVcxXGBCGnik8oc/LcGN
 2fgTf53YgM4yoPuLFAwkgx+gwO9dYywR2fq7UXaaes9FPn4/ND4hdmXP
X-Gm-Gg: AZuq6aJ1dCv6AOtXMZXcPuyVM7qKQqllkXq8ZW+MU7zvGtk1kngoUYfo9F/uMYEf/7D
 Ohe9U2lkzaPeoxUqW34XTC603I8eO/Ne3wxVL8I1vMd8qIGjgUbaheYub1/xx0i1UPxQrqcmHko
 oqfrVjywpB43xnN92lqh7B4BuLKNK2++36AxJYVH6oDKOEXyrWANhyRqbvF/eRhw0j/9Nt5XR9X
 gSYC5D7NY31H6EO+eWMTiS8AVggVkcomu+FjxCLb7iju7ftIup96ODUAAsm8a8iUfN+7aQ/O99s
 /MwaWmFakyOs4LkNEbT8qdVQTXuP2AYIh0mdz8SNbrXcmZlnGFSK48B/yAvv7wYfku0lBdj350u
 tf6KNX7ylz8wXg8us/M5SV2Mh5vaqqC7QoPtmhyD0MiKkwAK0GxpdG77vZxzmsklR3keGzjbIwZ
 L+yMFyjPLNP1er9JfMW0NhAXv5Wmr7Qvleaa46zlx+EeYq952fI+KSY5gFoKwHXyp6YkQRG95ys
 kIEro34PByWF9y4Saye5w==
X-Received: by 2002:a17:903:18b:b0:2aa:f9d7:68af with SMTP id
 d9443c01a7336-2ad74419eb9mr33742415ad.4.1771691547216; 
 Sat, 21 Feb 2026 08:32:27 -0800 (PST)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad7500e062sm36868365ad.48.2026.02.21.08.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Feb 2026 08:32:26 -0800 (PST)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org
Cc: ericwouds@gmail.com, kabel@kernel.org, vladimir.oltean@nxp.com,
 frank-w@public-files.de, daniel@makrotopia.org, ansuelsmth@gmail.com,
 mkorpershoek@kernel.org, skylake.huang@mediatek.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1 2/4] phy: add common PHY properties support
Date: Sun, 22 Feb 2026 00:31:12 +0800
Message-Id: <20260221163114.87553-3-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260221163114.87553-1-lucienzx159@gmail.com>
References: <20260221163114.87553-1-lucienzx159@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 21 Feb 2026 18:32:49 +0100
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

Also add include/dt-bindings/phy/phy.h with PHY_POL_NORMAL,
PHY_POL_INVERT, and PHY_POL_AUTO constants for use in device trees.

Ported from Merge tag 'phy-for-7.0':
  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy

Link: https://git.kernel.org/linus/e7556b59ba65179612bce3fa56bb53d1b4fb20db
Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/phy/Kconfig                  |   8 +
 drivers/phy/Makefile                 |   1 +
 drivers/phy/phy-common-props.c       | 286 +++++++++++++++++++++++++++
 include/dt-bindings/phy/phy.h        |  32 +++
 include/linux/phy/phy-common-props.h |  70 +++++++
 5 files changed, 397 insertions(+)
 create mode 100644 drivers/phy/phy-common-props.c
 create mode 100644 include/dt-bindings/phy/phy.h
 create mode 100644 include/linux/phy/phy-common-props.h

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 87729b479bd..9a6d56a7fdc 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -329,4 +329,12 @@ source "drivers/phy/qcom/Kconfig"
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
index 5a6df0ecfeb..bbf795bd478 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
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
diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
new file mode 100644
index 00000000000..56b5c57a84c
--- /dev/null
+++ b/include/dt-bindings/phy/phy.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ *
+ * This header provides constants for the phy framework
+ *
+ * Copyright (C) 2014 STMicroelectronics
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
+ */
+
+#ifndef _DT_BINDINGS_PHY
+#define _DT_BINDINGS_PHY
+
+#define PHY_NONE		0
+#define PHY_TYPE_SATA		1
+#define PHY_TYPE_PCIE		2
+#define PHY_TYPE_USB2		3
+#define PHY_TYPE_USB3		4
+#define PHY_TYPE_UFS		5
+#define PHY_TYPE_DP		6
+#define PHY_TYPE_XPCS		7
+#define PHY_TYPE_SGMII		8
+#define PHY_TYPE_QSGMII		9
+#define PHY_TYPE_DPHY		10
+#define PHY_TYPE_CPHY		11
+#define PHY_TYPE_USXGMII	12
+#define PHY_TYPE_XAUI		13
+
+#define PHY_POL_NORMAL		0
+#define PHY_POL_INVERT		1
+#define PHY_POL_AUTO		2
+
+#endif /* _DT_BINDINGS_PHY */
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

