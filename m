Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88FC1C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2916688099;
	Tue, 19 Mar 2024 13:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xHm1h9De";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A48388076; Tue, 19 Mar 2024 13:22:53 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B900C88065
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso1797438f8f.0
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850966; x=1711455766; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=emZL/Pfipg7qjmq7o32OJOw4T2ZC+SaQMSZYB0NanLk=;
 b=xHm1h9DeNE31hEzRBqW8biM54+sY5ptbUrI7Ugl05EdJwYdMOv4jzfgvlVhe6FXKjj
 myjUNLkWN8MTMiKW5D8gLtNJLhC8WLkCiTiYxPkxthSlHx6zx8ATfHs5i8941Zqnm40m
 incR9XW4KatwD0NoP2akLg6fXpsDH9hXnnNPX0gdyP4TS2FjUCwhpKPmJNgOuQHw5rBz
 GjiEjNhgzYldbCgsytTgNTwScUbxefuNOdISf2DKix6x2/XgnTzk9U4tclMUsY295pWW
 HlHWKOHySXzgygGb7Vge6PIfwgfhnnwO2LOgrmXU5EqR1/MuUyHfrih75RtbLnDTtDC8
 TA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850966; x=1711455766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emZL/Pfipg7qjmq7o32OJOw4T2ZC+SaQMSZYB0NanLk=;
 b=lSGvXZ8JgaZ7roxUspVq3mzi7P0KphigIimGDQ765f75kv+lR1dqIQomWFrD1jNbM7
 1xZPkZG52Y7CNa7LOU45UhedLLfqSCjZjG5CtlRsHnNpTDrGnYC2gP1bk9CBgFnetqxT
 jeGn4eVd9Eluxebvdg08ZlyHEU6FIRpSjPPLHl/I6nAeSOlMLqxQm/nn7yOAcLQ6z1Pn
 ozSShySUcAPPx50aP+p9t5xdkmOMycKtxCqDngMWfuhzVgh40rvBD+jD4X8IHIJIg6gl
 ch0A71Svi5s5rOGGG4fqychnO6JBlvXM0L80jmbxUiiRUsJowcUfhz6qjGBlfi9cb2iw
 DY5g==
X-Gm-Message-State: AOJu0YyFRJNVqGxtr/+I7SnNBHrBiDbtQgjQGOnb2/1cYtoJvca1E2yp
 4Wwn0Cz6BxRtB5cnXqKSA+Bn6+H/5wpWRxheQTwNsq7r12PxDwW58xf1dPLxhQNvuiaVpUF1g7J
 J
X-Google-Smtp-Source: AGHT+IECS0bx3zLnK4xl94AB/oOWsBsNyj8HgYTMYMbX1oZ2PUIY/mDj/PqiCj1pGYt87JlVp2rnmg==
X-Received: by 2002:a5d:6b0d:0:b0:33e:c2ea:5e1f with SMTP id
 v13-20020a5d6b0d000000b0033ec2ea5e1fmr9338435wrw.0.1710850965990; 
 Tue, 19 Mar 2024 05:22:45 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:09 +0000
Subject: [PATCH v3 10/14] mach-snapdragon: fixup USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-10-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6569;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SuUOZRINgUKmOWJx0MCOzS4+PECzt4IomG1G76WK1cc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzV0ftQLydNc8vJz54FBY1i1mFil5M9MAljWTvn3Qv
 jqZ5X5yRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiIcjIjw+qUWU/urjNyeKlw
 PuityqEqnwsb5u/SElP9cnj9EbMlTTuAKtzKlsx5J/Gp5/CTpGPnDdy70sx9j6iq2ugIi63WOKb
 zAQA=
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
 arch/arm/mach-snapdragon/of_fixup.c  | 115 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h |  19 ++++++
 4 files changed, 138 insertions(+)

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
index 000000000000..6810c8617cc0
--- /dev/null
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -0,0 +1,115 @@
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
+void qcom_of_fixup_nodes(void)
+{
+	fixup_usb_nodes();
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

