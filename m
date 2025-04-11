Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0629C36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 12:48:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F88683FF8;
	Fri, 11 Apr 2025 14:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J2f4z/eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE53983FEC; Fri, 11 Apr 2025 14:47:55 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A0082B72
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 14:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4394a823036so19610625e9.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744375673; x=1744980473; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1h7BUdmcue13UJ0vp9B5ZrdDJLLgHjxw10Rmee9iI9o=;
 b=J2f4z/eU/3f+b16hrgdlhNMvnwqtj5LHo0I1ZrKfl/HDBUxdM863CzyZfEdbFXOIOY
 6iZgnFoiOMEr0+NLzecCdVfhX8L+HTlILohm60KZmBqaHZyYJKlaET/1ZOeIl8reJR/1
 gmK1Dgx8jDethPfRmIkLVUP8hJLKS1XK20gSYdiglwAagyFkYpwGcodIGRij00FedR5+
 BiCEfLRPOUbQCo1fVmNShXym6AYEXe/Mq3HzpLzzRKdiWs5vY9+Il4aVyH+X36HIp6uo
 2TpMXKKBoDGqdQdozNcJFeeJkSwpvh1kQAZYpuDvSSBP0uRcpLv8nyefG4/hoCtXfWRQ
 YyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744375673; x=1744980473;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1h7BUdmcue13UJ0vp9B5ZrdDJLLgHjxw10Rmee9iI9o=;
 b=hSTpw0DbGZmgazqVtUACIOKDjyA61m8ZK0VA8wnLJVMylQtd2GxSliJUS3KZkmAjui
 d0tiyZrBS1joo0oXsQOeKi7XrDgYJOB2WUpMFgF3EdfT5TtAji/mHD+yDe2u8EngBvGx
 LK4lRndOzDDUCwqt5kKfDICMJ3ao+JEGRSh0UZhN4NdDG/DMMK98X78RHIX6R6ZLg9kQ
 MLKj4MtaWaxNz1a2CD87b7tWdXmHNP3nZh2M3Vj9nWxzLOpzHTn8VCDd9m2FrIPpW+RM
 5FEdhE1kTFEvMmR7MJTVPM6icafC5N/NQ33eGMU7ozMKWaimg3gW7c7Jnyk1HRfXNr4d
 oV8g==
X-Gm-Message-State: AOJu0YxJagA2tWkCs6A3e6tKoc5LCb44G6xwx5YDHLrPTNA9i1b7a7X1
 2PtMhcRRRcGabJibV6qx3zBftab0J526ggwdHt5RpwQDgSK/p53fgo3CAJ6LHpk=
X-Gm-Gg: ASbGnctZVGu3V5Z2Qo9C7uScMu8IDRwuCDAoNE6uzJClqRb4ivwoF73jw3a7WihgN5v
 6Gm3IE+5kLva7xrQyVU1/FJnCqQtbHf81ObVfWEJgFFgYK+ZXeMHtYMIdnIdZvEmCmZhMHRBpX7
 vyAqGWSyFQAMdQ0idPkCmXpQDACFQMerMNScsr1vZ2wHjn20qr15ROjjfaJnHmb/pqR11l2qLtF
 +Sy8f4nnRy1xAF1IJBlAkb5uFBNV4d2DnHOXKKXIhJo4XZV5a80YzBcbEhgrmIRZVrSCvP2yONd
 6va2ZgkEQ3J3vLAIKioji2pIdB0kkLVh4IxOWsWsgIY9gqMDVyDXtr6G9THMeOI/JmE5ToqS7co
 mD5TR6/6bAwcjOUwtPQ==
X-Google-Smtp-Source: AGHT+IFx8BplvOsbAdHRwzKOwyzh0iUO9FtFhzRQNh/0Dq2HG5bQXvs3owPrQrMGjdoSL4951bycYg==
X-Received: by 2002:a05:600c:574b:b0:43c:fc04:6d35 with SMTP id
 5b1f17b1804b1-43f3c7857b2mr15731735e9.4.1744375673094; 
 Fri, 11 Apr 2025 05:47:53 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f206264a1sm88299695e9.9.2025.04.11.05.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 05:47:52 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 14:47:39 +0200
Subject: [PATCH v2 2/8] mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT
 fixups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-livetree-fixup-v2-2-1236823377bb@linaro.org>
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
In-Reply-To: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4696;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ohlFA5WFbA+SNNitmNisDSZRuDqe1fL9TwcO6CTQbNw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+Q9z+23OL7uTb7BEj+uVsSseeqN7I97Ze/70J
 z5KPXOvkxSJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kPcwAKCRAFgzErGV9k
 tq1hD/0aXVqxSPy3PQQIAyyh6B9pPFAxFKfjwi17/dQUg6+mSesx8n1SpfwUjUQzFafGXuqQqEC
 QaGz9uWJIWIaA/8YNXL/6Emrp1pm/Qlzvut+r/VXdsYA4QeDZDIHLvXQnAWZ0urPDo0Q3l1FRts
 qdt9ZbfNyWppZ8dodlcRrm+dsZSsauYrKsE7bBCwad1DPkyG8J1QuPoDGFGZidANyTRahONRIEa
 qK7p8YvOBjmvD4H942bXQOxULhzAJWb4evsRh8Id7LjGZeBdYuCgkxLPEtrfH8BNWAPZzBxtfqS
 RoFsK4mxwqO4Uln+6oOiuvy0HxfcWz7fIej+rwji1GPGN1Wb2CDE9qMCz17HsCzh7EoEiI5sbhj
 R8pBJ5kesf3AYdISy/kITFgPDa6A7OKvGTCgHvIlxwyUICoZ8okeC/FTGR7J1F5zl4vNrxtIF9m
 38Bhsr5yhzZsZ6H0b8Y7RdqyVE/6ZXp9t61lH4z+ZRZAlrgpK9rNKkJtzEnc5ZCg1ELwm8qZwrd
 st4xWWF1QLjDf/coZ/zsCQQlftZfe8zD0tqDnHp0GeYRAFAB6HOSF+vVgLhbioSBQAEztklEzAo
 i06RgbsP2QGtrxGEyo6n2hSUGze4s4mir1eAAOqn8HKDBIE0Ui83ox2Tcy6LGDiAaA35jDQvQfH
 aLcg85eJfzDOhEQ==
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

This will now apply fixups prior to devices being bound, which makes it
possible to enable/disable devices and adjust more properties that might
be read before devices probe.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c     |  1 -
 arch/arm/mach-snapdragon/of_fixup.c  | 25 ++++++++++++++++---------
 arch/arm/mach-snapdragon/qcom-priv.h | 14 --------------
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d323789eab75d5fe735159b4cd820c02c45..3ab75f0fce02ecffd476ebe2aa606b1a9024bbec 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -305,9 +305,8 @@ void __weak qcom_board_init(void)
 
 int board_init(void)
 {
 	show_psci_version();
-	qcom_of_fixup_nodes();
 	qcom_board_init();
 	return 0;
 }
 
diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
index 1ea0c18c2f2789a8aa054cd95bb9e4308d6b3384..70399307bcbda1e067230f00af6ba859a98c7ac0 100644
--- a/arch/arm/mach-snapdragon/of_fixup.c
+++ b/arch/arm/mach-snapdragon/of_fixup.c
@@ -21,8 +21,9 @@
 
 #include <dt-bindings/input/linux-event-codes.h>
 #include <dm/of_access.h>
 #include <dm/of.h>
+#include <event.h>
 #include <fdt_support.h>
 #include <linux/errno.h>
 #include <stdlib.h>
 #include <time.h>
@@ -31,9 +32,9 @@
  * USB controllers. Rather than requiring source level DT changes, we fix up
  * DT here. This improves compatibility with upstream DT and simplifies the
  * porting process for new devices.
  */
-static int fixup_qcom_dwc3(struct device_node *glue_np)
+static int fixup_qcom_dwc3(struct device_node *root, struct device_node *glue_np)
 {
 	struct device_node *dwc3;
 	int ret, len, hsphy_idx = 1;
 	const __be32 *phandles;
@@ -100,11 +101,11 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
 
 	return 0;
 }
 
-static void fixup_usb_nodes(void)
+static void fixup_usb_nodes(struct device_node *root)
 {
-	struct device_node *glue_np = NULL;
+	struct device_node *glue_np = root;
 	int ret;
 
 	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
 		ret = fixup_qcom_dwc3(glue_np);
@@ -113,16 +114,16 @@ static void fixup_usb_nodes(void)
 	}
 }
 
 /* Remove all references to the rpmhpd device */
-static void fixup_power_domains(void)
+static void fixup_power_domains(struct device_node *root)
 {
 	struct device_node *pd = NULL, *np = NULL;
 	struct property *prop;
 	const __be32 *val;
 
 	/* All Qualcomm platforms name the rpm(h)pd "power-controller" */
-	for_each_of_allnodes(pd) {
+	for_each_of_allnodes_from(root, pd) {
 		if (pd->name && !strcmp("power-controller", pd->name))
 			break;
 	}
 
@@ -132,9 +133,9 @@ static void fixup_power_domains(void)
 		return;
 	}
 
 	/* Remove all references to the power domain controller */
-	for_each_of_allnodes(np) {
+	for_each_of_allnodes_from(root, np) {
 		if (!(prop = of_find_property(np, "power-domains", NULL)))
 			continue;
 
 		val = prop->value;
@@ -149,14 +150,20 @@ static void fixup_power_domains(void)
 		func(__VA_ARGS__); \
 		debug(#func " took %lluus\n", timer_get_us() - start); \
 	} while (0)
 
-void qcom_of_fixup_nodes(void)
+static int qcom_of_fixup_nodes(void * __maybe_unused ctx, struct event *event)
 {
-	time_call(fixup_usb_nodes);
-	time_call(fixup_power_domains);
+	struct device_node *root = event->data.of_live_built.root;
+
+	time_call(fixup_usb_nodes, root);
+	time_call(fixup_power_domains, root);
+
+	return 0;
 }
 
+EVENT_SPY_FULL(EVT_OF_LIVE_BUILT, qcom_of_fixup_nodes);
+
 int ft_board_setup(void *blob, struct bd_info __maybe_unused *bd)
 {
 	struct fdt_header *fdt = blob;
 	int node;
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 74d39197b89f4e769299b06214c26ee829ecdce0..4f398e2ba374f27811afd2ccf6e72037d0f9ee7f 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -8,19 +8,5 @@ void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-#if CONFIG_IS_ENABLED(OF_LIVE)
-/**
- * qcom_of_fixup_nodes() - Fixup Qualcomm DT nodes
- *
- * Adjusts nodes in the live tree to improve compatibility with U-Boot.
- */
-void qcom_of_fixup_nodes(void);
-#else
-static inline void qcom_of_fixup_nodes(void)
-{
-	log_debug("Unable to dynamically fixup USB nodes, please enable CONFIG_OF_LIVE\n");
-}
-#endif /* OF_LIVE */
-
 #endif /* __QCOM_PRIV_H__ */

-- 
2.49.0

