Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6476ACD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 18:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14D85881CA;
	Thu, 28 Mar 2024 18:59:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cSq4qb26";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FE778083F; Thu, 28 Mar 2024 18:59:55 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1066583348
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 18:59:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-341c7c8adf3so793154f8f.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711648791; x=1712253591; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8kYov/liTQ82x2KMJHf3ZjJBU6Bbzvx3nDiFsfzeCZs=;
 b=cSq4qb26sl0l65WVYKhhyYeccRsyrZslG1dsWunS+KZruEGvVl95kYbeKMn5BSkpXh
 HajfQoGl7MXDhcnynBB08EpSttrOIBj5vZXH0x8Lb4GXJEiWY2ztc9cbcWSbmEF4F9yN
 yILz4gJaSuz7aFpn0vMSRDza2Zaa21W/KGVHshKdnpR/boxaACVLplmALlvgw/aUkBVy
 wVAJnNY8NkKwpLBIo8nUNzhb/dPyCnJMDkSQuh/PbFddO1PCergEWoTLJnOECUGxHfck
 P+MLgfBE2B/YceWi0oNIRA/D/NslY23kVUhZuxc+FSyBp+Yeeg3NGEanWWDvbWKZ9YgN
 DPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711648791; x=1712253591;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kYov/liTQ82x2KMJHf3ZjJBU6Bbzvx3nDiFsfzeCZs=;
 b=nc4Lt8Ac1AfntRKR1RKhREUnWy3W2bmWF9Rtv5qjUmWvkJTTOp5SZgcbv8YKGKIBiE
 KJs/+t/Pl/l1QsAmqtJDxeQrL3Njf30R3E9jBEoWtVtF+58Nlngai3dErfICgQfsGxuN
 NLbBOmbqHKF8AcpcVctM75HGrDtdb654r/U8waSDHwBtDMFV3oEzykBSZpN+wIowYNNl
 Mb+MCvO1uzDmh6XMiVxpY0v4eC+KFlIfnRSoxn/zdlJnoQnHq/J27nDdYjTLup06SpyJ
 Gd0JoE9Ddj7D7292DdIYPZIFjbQD8IXh+H7lW8YmDVqVdQJqL2lY7i8W5RuVsDl56b0r
 gm3A==
X-Gm-Message-State: AOJu0YxmfqGmRfKR5IPIczo4V3YXUirF5Mahe4oO3GSzncnfuc4vvabM
 CqP2j8RreyT4OVQ/hLi9lLTeKWaioGfWGZvhmUqI+PbIj1AzoPgcgCzk2uPMA/8=
X-Google-Smtp-Source: AGHT+IFer9Eq9IWBIjK5jStGuqqP4E2elgvtBDoqnY1EOdny6QRrfhlZ2mMZ8eEyiR8c9t58WPCr6Q==
X-Received: by 2002:adf:f44f:0:b0:33e:9dff:a3f7 with SMTP id
 f15-20020adff44f000000b0033e9dffa3f7mr2780826wrp.62.1711648791649; 
 Thu, 28 Mar 2024 10:59:51 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00341e5f487casm2292237wrs.46.2024.03.28.10.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 10:59:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 28 Mar 2024 17:59:16 +0000
Subject: [PATCH v5 10/16] mach-snapdragon: fixup USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-qcom-livetree-v5-10-4e98228b3d03@linaro.org>
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6817;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gK9Jwt3hMxnTPj7O/O0mZ0f7yso4mriyeJANT7O7crM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTWDVxX8oITV6T9nOaweO2LCyIm66UK4vRKt199sylx+
 kHxqy8nd5SyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJNCQz/PeU5epQXSJRsTap
 8xLP5ZgDs79L6bvaGk6IZ9i07hHbCVFGhraio48q08Oe5kZy2FStNw/7vIJr+fqPsf/UDD0tlp/
 gbgYA
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
 arch/arm/mach-snapdragon/qcom-priv.h |  20 ++++++
 4 files changed, 147 insertions(+)

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
index 000000000000..0a7ed5eff8b8
--- /dev/null
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
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

