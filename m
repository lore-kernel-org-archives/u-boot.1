Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F70DC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 393E98809C;
	Wed, 20 Mar 2024 15:57:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oHHPMWQ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFA1C88105; Wed, 20 Mar 2024 15:57:23 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FB8880FA
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33ed4dd8659so647913f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946641; x=1711551441; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EOTH2MzXPRqmvHk6eQIeOAc6DHHcg/asIhGEvZg5+1Q=;
 b=oHHPMWQ9SYlqz7n5Jgepx/8yCAvilcUS/FpakiDIAyuxQzgF2+BygLwJd4a2b5l2Qg
 ZxviiTnKeerroueTCmgGPAiMi/5kPSP4p5Ud4C8NlbptRfc4aDyUSBinKCvcMAUS6C62
 s20dQXslL+hk0zK+oMw+FHVW68fFk1LySYS/dbFUmQCB3jbJ7BfCnPkAqwkDvJoCefIy
 46/MnbxVt717yeu/FP6ouB07zwsZ1W+APvgwf0PGrZ3/2wG00ftORQsbmkYo0hcDG4dd
 FpYw3rkHJbTiGBGqb6GfviqPFWAExJGed6QaIeoZUZPTg59d5zba1aXktZOMlygZHrmG
 uvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946641; x=1711551441;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EOTH2MzXPRqmvHk6eQIeOAc6DHHcg/asIhGEvZg5+1Q=;
 b=Pci1MAqfr3/D9DA2r9m6ih2nkeAPVoaFd5/e0J6U21UaM+bU1h34SOiO6tfkkA43x3
 tQx4GJnnNsFCpH6x+xa+PCa/fAAx7q6DwRixlF4RuMCZQFrUMRsGH5G51QmDbZAVMCdA
 7Lp15ne5bmMXvoehAtCnU6K1dLpIZ39tgAfIEnbFZA20rLG/CUbif6u2Hg6tONbaJwlh
 vRGLjSivViIWbtJ2HNY54BMlnMohEFpIsS/As/5jbEtbPUoiVAcs/xLWc2LozDV7X6Qs
 P5sJEyMm5A2/VTc0XaSDsZJzLwMDU0AKboxSt9d1Ka3yTrzXp1HBZXrLGPE5rJcRbjyA
 lcFQ==
X-Gm-Message-State: AOJu0YxjXtV4OGY+g21H1huH+/vUdWDfSjN8gMaKLsmTQ/TgdGyEUjZ5
 3+ytYfcYGDZMwgBRrr8qdmxi2YpK2vJOsNWvroVCKmWmcYU9CA2JacuVkOCU/c0=
X-Google-Smtp-Source: AGHT+IGuXqg2u2GsFPoXP7xwhXuRWE3q04klytGWSq/GFwnqGQr0zYYsajy+LQU2fh4TQFkVpYLTnA==
X-Received: by 2002:a05:6000:1817:b0:33e:c2f6:96e1 with SMTP id
 m23-20020a056000181700b0033ec2f696e1mr35378wrh.25.1710946640988; 
 Wed, 20 Mar 2024 07:57:20 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:20 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:13 +0000
Subject: [PATCH v4 10/14] mach-snapdragon: fixup USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-10-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6779;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=YxkFOQHDNGZDj0qmX7fJBA3hY1BOGEBtcj3yM3m6snM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfP51++t+flFWqls/9tsygNvS/xBajme52/ydaMy4tc
 nQw997UUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbS0sTwh0NguuitPV2vJ6Qs
 +9NbsuGC5qN5ItbvRb+buD1q4ig4cJCRYUqvyT73pHsdP6qdGeZK5PF9ehEod3pmUkShddmh72n
 BOwA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

We don't support USB super-speed in U-Boot yet, we lack the SS PHY
drivers, however from my testing even with a PHY driver there seem to be
other issues when talking to super-speed peripherals.

In pursuit of maintaining upstream DT compatibility, and simplifying
porting for new devices, let's implement the DT fixups necessary to
configure USB in high-speed only mode at runtime. The pattern is
identical for all Qualcomm boards that use the Synaptics DWC3
controller:

* Add an additional property on the Qualcomm wrapper node
* Remove the super-speed phy phandle and phy-name entries.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile    |   1 +
 arch/arm/mach-snapdragon/board.c     |   3 +
 arch/arm/mach-snapdragon/of_fixup.c  | 123 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  19 ++++++
 4 files changed, 146 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 857171e593da..7a4495c8108f 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -2,4 +2,5 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
 obj-y += board.o
+obj-$(CONFIG_OF_LIVE) += of_fixup.o
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 6f762fc948bf..65e4c61e866a 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -27,8 +27,10 @@
 #include <fdt_support.h>
 #include <usb.h>
 #include <sort.h>
 
+#include "qcom-priv.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
@@ -159,8 +161,9 @@ void __weak qcom_board_init(void)
 
 int board_init(void)
 {
 	show_psci_version();
+	qcom_of_fixup_nodes();
 	qcom_board_init();
 	return 0;
 }
 
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
new file mode 100644
index 000000000000..4fdfed2dff16
--- /dev/null
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * OF_LIVE devicetree fixup.
+ *
+ * This file implements runtime fixups for Qualcomm DT to improve
+ * compatibility with U-Boot. This includes adjusting the USB nodes
+ * to only use USB high-speed, as well as remapping volume buttons
+ * to behave as up/down for navigating U-Boot.
+ *
+ * We use OF_LIVE for this rather than early FDT fixup for a couple
+ * of reasons: it has a much nicer API, is most likely more efficient,
+ * and our changes are only applied to U-Boot. This allows us to use a
+ * DT designed for Linux, run U-Boot with a modified version, and then
+ * boot Linux with the original FDT.
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *   Author: Caleb Connolly <caleb.connolly@linaro.org>
+ */
+
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dm/of_access.h>
+#include <dm/of.h>
+#include <fdt_support.h>
+#include <linux/errno.h>
+#include <time.h>
+
+/* U-Boot only supports USB high-speed mode on Qualcomm platforms with DWC3
+ * USB controllers. Rather than requiring source level DT changes, we fix up
+ * DT here. This improves compatibility with upstream DT and simplifies the
+ * porting process for new devices.
+ */
+static int fixup_qcom_dwc3(struct device_node *glue_np)
+{
+	struct device_node *dwc3;
+	int ret, len, hsphy_idx = 1;
+	const __be32 *phandles;
+	const char *second_phy_name;
+
+	debug("Fixing up %s\n", glue_np->name);
+
+	/* Tell the glue driver to configure the wrapper for high-speed only operation */
+	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
+	if (ret) {
+		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
+		return ret;
+	}
+
+	/* Find the DWC3 node itself */
+	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
+	if (!dwc3) {
+		log_err("Failed to find dwc3 node\n");
+		return -ENOENT;
+	}
+
+	phandles = of_get_property(dwc3, "phys", &len);
+	len /= sizeof(*phandles);
+	if (len == 1) {
+		log_debug("Only one phy, not a superspeed controller\n");
+		return 0;
+	}
+
+	/* Figure out if the superspeed phy is present and if so then which phy is it? */
+	ret = of_property_read_string_index(dwc3, "phy-names", 1, &second_phy_name);
+	if (ret == -ENODATA) {
+		log_debug("Only one phy, not a super-speed controller\n");
+		return 0;
+	} else if (ret) {
+		log_err("Failed to read second phy name: %d\n", ret);
+		return ret;
+	}
+
+	if (!strncmp("usb3-phy", second_phy_name, strlen("usb3-phy"))) {
+		log_debug("Second phy isn't superspeed (is '%s') assuming first phy is SS\n",
+			  second_phy_name);
+		hsphy_idx = 0;
+	}
+
+	/* Overwrite the "phys" property to only contain the high-speed phy */
+	ret = of_write_prop(dwc3, "phys", sizeof(*phandles), phandles + hsphy_idx);
+	if (ret) {
+		log_err("Failed to overwrite 'phys' property: %d\n", ret);
+		return ret;
+	}
+
+	/* Overwrite "phy-names" to only contain a single entry */
+	ret = of_write_prop(dwc3, "phy-names", strlen("usb2-phy"), "usb2-phy");
+	if (ret) {
+		log_err("Failed to overwrite 'phy-names' property: %d\n", ret);
+		return ret;
+	}
+
+	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed"), "high-speed");
+	if (ret) {
+		log_err("Failed to set 'maximum-speed' property: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void fixup_usb_nodes(void)
+{
+	struct device_node *glue_np = NULL;
+	int ret;
+
+	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
+		ret = fixup_qcom_dwc3(glue_np);
+		if (ret)
+			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
+	}
+}
+
+#define time_call(func, ...) \
+	do { \
+		u64 start = timer_get_us(); \
+		func(__VA_ARGS__); \
+		debug(#func " took %lluus\n", timer_get_us() - start); \
+	} while (0)
+
+void qcom_of_fixup_nodes(void)
+{
+	time_call(fixup_usb_nodes);
+}
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
new file mode 100644
index 000000000000..d18fd1883b7f
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -0,0 +1,19 @@
+
+#ifndef __QCOM_PRIV_H__
+#define __QCOM_PRIV_H__
+
+#if CONFIG_IS_ENABLED(OF_LIVE)
+/**
+ * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
+ *
+ * Adjusts nodes in the live tree to improve compatibility with U-Boot.
+ */
+void qcom_of_fixup_nodes(void);
+#else
+static inline void qcom_of_fixup_nodes(void)
+{
+	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
+}
+#endif /* OF_LIVE */
+
+#endif /* __QCOM_PRIV_H__ */

-- 
2.44.0

