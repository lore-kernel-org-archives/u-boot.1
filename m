Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D97CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D75A883BB;
	Wed,  3 Apr 2024 14:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ismhyZR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDC32883B3; Wed,  3 Apr 2024 14:08:02 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7A9883A7
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so1522862a12.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146079; x=1712750879; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w2IoZleQFmWAeQEyW4JHzoO3O7JYnf70UC0Z9/INMRQ=;
 b=ismhyZR+BMslNB5X37kfgImb5x6PIU9MPF5jtM7xtA494C4Z69TH/7MbRyk8RrSHSJ
 Ly2G65jmUSdlKzAsm+qWnaVKVkW19gqkSFb7Ob2wwzrFWRcqdXTHiyAw9gFfuRQdsbAR
 A4ki+Z+IE/xPEmTaQPcqyhpaZFbxDNrj6C95QPQYEXCoZvknxqc+K4cTWG/sS+T3idgv
 ne2w/gfrApfrNVPK8R+AcrrP/0QfBbLUOY2rUb4FPk2STCE/FcQaHTMxZ/YgSDAaOuC4
 XWVwxSbUu8+LYiR5Tuih99pKE/RJDazp0EPnjCDmBp5OuCdUDYpzsGQJ/t+nt6LS2+ce
 sBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146079; x=1712750879;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w2IoZleQFmWAeQEyW4JHzoO3O7JYnf70UC0Z9/INMRQ=;
 b=aEfNYlb/vfO2pqUeW1ivWlxdbJvBXhZpg6DJevBCFc1LrKa+ex9HDSg60XXIZQ2C+x
 9zSl+2+PdN08jIDgaeir5qrlm0157GujDRVHZEQhf8rb/b/dZATEqo32ygeJFy7RCINR
 LMM2joLQqL1J38mpuHVUU5EK/L11hT4FejSendDAz5tXHzhikj7ufXlI1liA2mf9+rHH
 5IB0CEjoJnkLv+rdMhqVp1vWdXWtodTD7q+wF/Iilckj1fhSnJj5tKmYWY8x9sPc8lxd
 tU8swLKGYqn05ZiCAWPx9x2uPCym8FGotdxsMSWcIMCho8FajlCuSwGbPaMrDA+qlWdy
 lnDg==
X-Gm-Message-State: AOJu0YxM5bGpTC8Dl4BXd59/rMA0W3l2s9CBCFyHKRhRqkzaV6yIuoAE
 QIOQxq5QL5mTd4qjN2qRRrUtVaJ8/nem+2UGE6XuA9Ed5yNJJW8/X64ePMGIZ2s=
X-Google-Smtp-Source: AGHT+IHuJNX4EkCy5Qh19SVQCtLJmdwCqsDZmj2Aye0bY8oP/beJQ+JWbVDjyaa8uiFt1FgWu4tNmw==
X-Received: by 2002:a17:906:b058:b0:a47:1f61:4d02 with SMTP id
 bj24-20020a170906b05800b00a471f614d02mr1911874ejb.36.1712146079519; 
 Wed, 03 Apr 2024 05:07:59 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:59 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:45 +0200
Subject: [PATCH v6 10/16] mach-snapdragon: fixup USB nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-10-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=6975;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=1hpSGa/6NmcAEUCxy7k7ir1TnSOYsoVZZz4LMLguGzU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaRuqLaab/d7DkPptfaDcFzak0BeIqe1jYRj
 ef+ipnQs4WJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkQAKCRAFgzErGV9k
 tuuTD/9bwaAKTJy1ZrcmykgXzwVPJQp+vIQIWzsoCEUuLapkVhR3kf5y/ne209dUq2RVC4GTySv
 lOc1thLJcDVbSK/YOyqclyI0uYOMEoC/pNrol9k2XKXBoui+DBk9AZWNqa7QY8mvof4iK4B4HLK
 w8jjdwnhVbUguW0qBVGXO134VzQfl5n1kd3w4XPn/sxE4x3RoZbeo/c+P4gUErOj9fuVBhmZLvY
 Zu3yEScIssxyMknWfUuBli1hrVmkU6KBdicMZz7AQqT3xbVipCJ9H529EVtbyaGyTWKDCoTacQZ
 zofMgNTSYYZPzHWM8Fgu4lQllrLxXgYqQpqTGV231YYwqo2uLn+PISX3zZ9lZ3EmhXa2q7pB7qr
 IUxJgH0pvxvI8k3MMr2MgSFUGxHB6+biq/+Ch+vNQaBg/h61IatuWv+4OCrYPpJ9qEqYTqi9vNp
 G6FRsIeJ5YHdcy/TEfAoVoQuU6qTNNItmHONHJvLToOj3QwnxfiSPSjvr9caCPQLdLT4mC60FUj
 DK9H8dlx79QLdrT934SZuVFq1oAejkSNkl4AUTaQ85r9FA/k/IguqCKZVolSdoqvlGQ/Wt6WzD9
 k8bF8cKFnCZR5p1u3bAXMknJMnVHypERT1q481ck4zufNFrKjKnoZmMU+hgbtMMJuTamqs9ZWlN
 UMemak1iO0FysOQ==
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

Acked-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
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

