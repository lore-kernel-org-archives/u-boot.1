Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06772FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:05:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A77D844EC;
	Sat, 25 Apr 2026 20:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UNQ/O/Nr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72F7C84405; Sat, 25 Apr 2026 19:11:03 +0200 (CEST)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68E84843FB
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 19:10:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lucienzx159@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so5751345a12.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777137056; x=1777741856; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzmyrpCYex2tY8DOgtQkOh0s+SIhupNDdSQ08fBkU78=;
 b=UNQ/O/Nrbr6OwOFmqLAgNnYO+GkOxqRKf088aKWeM3y4NQZCCV2/rX2YPT740QKgC6
 skRxnxoyPTKFrELXoJ60hkIlu0J3jVg996KHYpNAk/zZTpuawZF8VJnE3qrEnDamXmTy
 qP8mzyBQ0JGSrBZsvwNkwFH2U2OlfNa/hgCw4exvufgyprJgMg4X458AvmnUbX0qew1x
 uI8w3iSrj2NAFQz3RTrbB/yffaIUyWWVY5cRnxdWwUVhpOOqpdkCwY32j9KDWJ8OTkOg
 mFgkXQcP10SJdJ2kPmVZovP6bGH4/ea1PFWqjgRfe5B3A8NyKCAIzmg8vUOGp8nfENLi
 +AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777137056; x=1777741856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uzmyrpCYex2tY8DOgtQkOh0s+SIhupNDdSQ08fBkU78=;
 b=Xkr64p5YuZUXIyjVwRMhSX9je5PlGLtp1rzOd4BMdoRZjiObH7b4t4TH7P1UWncdiw
 DAW+pc5+E5oJk+KX4F4MvlbUKjhyzl1kteU/uBdYWxO4wz0z8UH+GJEoQhToOogf2HLI
 NoGzfLxZVsUZq6voYbKStlpvbPk/V2ZL3ZqoD3SoQopSfdCoRTOtth5sqjivdeMV2cFU
 JpalHgfY9+v1XhpS86iePPoLH+3N5uuAJbbBHU6KsxCRGNfkGCTO+eT3nLWV9a80a6C9
 GJMb2LNcVG39HxjGMutTSK+u9QNRIAQE6ZF6MzobztHnaydMWYKPnF49A8n+gsjfyIpd
 UTNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fXooZ2XDvavZkuf9Hv4/0RAZLL8G3401gKPKfQ6RG3BtPAwwgIXtP43WYuExSzDYN42yuksA=@lists.denx.de
X-Gm-Message-State: AOJu0YyXs+fE8b1hZRtNRzrTeSCCntG49nWcKLJt+Ct7w6MedWi6InH4
 uWWlWsrLrU9b1Jl+RQ5/gM3d8978BankT4TBmH5rJJ2AOyUAZ38Kr6OUUSoCew==
X-Gm-Gg: AeBDiet311EWoCJ8YWRQ4fKDHNO2PipslzEp7VjQTosUGGQdY0YUiEpYCBPFAUTeC/v
 FF+6l2er8SngcPgik/AuPh08hzbKfz8A9QQhqfWxer4cC79oloBLgTzZJmmkTUFT+ZWLR18XQWM
 /NTS+/4uxZZeeHdyfyw2HzS5b3+kbAEzgzv57n5UNzryiuZlTpi3r5Fln3D6FdJTkkTrkrVctFq
 QOn4m8rC8gG09qBLocLYX8an+M/MKngwQT2ylmU2JVtUzsLnrRr+yzUePtoh/VY1cA/zpvmGB6m
 3rYFm+AD8uOdnbvFosu+vTkaXtDKWbpjSR7RvGpOnY5P7by65bPW7pjwNWMaT/SNvCJ3nmj7HIJ
 OGTwNv67alCTPv3Y066dDvEZPfHmU/KHgrdJuilE7gjCeh2p8tpGbdLVzrlZpQLoJamTAW9l5tu
 nLKXbYcIWMuWmuMEaMcVkMoGFImHizikK8Z+52BlYXIWL3jDtpLletjzS2k0QPgwyZtXiDGlsCW
 +0l22j2XB9uIKyvroONY6F0StN7odRz
X-Received: by 2002:a17:902:f551:b0:2b7:9ed0:4f92 with SMTP id
 d9443c01a7336-2b79ed0505amr117759775ad.32.1777104460886; 
 Sat, 25 Apr 2026 01:07:40 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw.
 [124.218.201.66]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm250916935ad.54.2026.04.25.01.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 01:07:40 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: trini@konsulko.com, jerome.forissier@arm.com, sumit.garg@kernel.org,
 marek.vasut+renesas@mailbox.org, vladimir.oltean@nxp.com
Cc: ericwouds@gmail.com, kabel@kernel.org, frank-w@public-files.de,
 daniel@makrotopia.org, ansuelsmth@gmail.com, mkorpershoek@kernel.org,
 skylake.huang@mediatek.com, lucien.jheng@airoha.com, u-boot@lists.denx.de,
 "Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v4 1/3] phy: add common PHY properties support
Date: Sat, 25 Apr 2026 16:06:47 +0800
Message-Id: <20260425080649.75688-2-lucienzx159@gmail.com>
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
 include/linux/phy/phy-common-props.h |  69 +++++++
 4 files changed, 364 insertions(+)
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
index 00000000000..0a0b4439430
--- /dev/null
+++ b/drivers/phy/phy-common-props.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * phy-common-props.c  --  Common PHY properties
+ *
+ * Copyright 2025-2026 NXP
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
+ * @node: Device tree node; if invalid or @props_title is absent, @default_val is used
+ * @name: Property name used as lookup key in @names_title (must not be NULL)
+ * @props_title: Name of u32 array property holding values
+ * @names_title: Name of string array property holding lookup keys
+ * @default_val: Default value if @node is invalid, @props_title is absent, or empty
+ * @val: Pointer to store the returned value
+ *
+ * This function retrieves a u32 value from @props_title based on a name lookup
+ * in @names_title. The value stored in @val is determined as follows:
+ *
+ * - If @node is invalid or @props_title is absent: @default_val is used
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
+		pr_err("Error: Lookup key inside \"%s\" is mandatory\n",
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
+		pr_debug("%s: '%s' is absent, using default value %u\n",
+			 __func__, props_title, default_val);
+		*val = default_val;
+		return 0;
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
+		pr_err("Error: mismatch between \"%s\" and \"%s\" property count (%d vs %d)\n",
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
+		pr_err("Error: \"%s\" property has %d elements, but cannot find \"%s\" in \"%s\" and there is no default value\n",
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
+		pr_err("Error: %d is not a supported value for '%s' element '%s'\n",
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
index 00000000000..9158851f2e1
--- /dev/null
+++ b/include/linux/phy/phy-common-props.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * phy-common-props.h -- Common properties for generic PHYs
+ *
+ * Copyright 2025-2026 NXP
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

