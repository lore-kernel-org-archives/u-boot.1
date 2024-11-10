Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29CBD3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:52:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63402890B1;
	Sun, 10 Nov 2024 12:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDwHsIF/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C728910C; Sun, 10 Nov 2024 12:51:36 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11BC58911A
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4315e9e9642so29691665e9.0
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239493; x=1731844293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hEVWHcmTEzDceWKrIQy67wAPwlCK5RtA9qzT4iCWfIw=;
 b=hDwHsIF/3oZ5vsFGyw0ap48iMB/y9sSHKcqd5FqZ33cJFbQZgebgToy0jTmHnGOT4b
 mZvAgOKPPoQx2gj14AayOlGwrJEA6ARu1FUh2ANRnYEr9vcLLvySU1sqUDqLoOL30wrC
 sRTS9MSIR7uY1GoRo1idpL2HMT5dzPXElhSTmHZWpg9FhZzp1X1XIPgHNEaY0rDQK94l
 GMI9qTtW6gzHSXV9VsLiO5Ht6Wa7obM/cVhkC+vOqjEqbItn3dyNHEOhQ0WuGUCeexu9
 gAWO3PGZet1M6NprYMW8WC6tQ40oL4RL+d+BznCXH9oOp3Fvb6ukkbfz+79QB0BMNoCy
 1kIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239493; x=1731844293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hEVWHcmTEzDceWKrIQy67wAPwlCK5RtA9qzT4iCWfIw=;
 b=H58J9LzVEX4XwmTNqD5DzFAR9iatVLVpXo0234kz++srq7CEtQ/0I3IElgFWuw0GAh
 tJsphrFZPYI4iCaUiecHOXdgxHq+Aqv1Fostk2Csa/GCRDERAwoJoqqcYbu5lp8U5ILd
 3GUWf6mCuweDICA0ieZv1s9zqBo82rcCP3Ua+7AaDYV4RdeNnBrlFi8Drk9MEb/gw2V9
 DjmwBlUV4drf1cBo7jsW5cGDbgP/uqm4uryOn1q1+UG6npiFRaiV6DGsel72fTXxyLwM
 e65vn4k/vFcxVIhSL4pldJmUlyic2eMrGUiT0GgfwlPkQuktAWh4yI1poRp/tUDvF9Et
 owkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9sj39T3rRnprCap7dEewnwTwP4gU0v/ipi1DowKNO63jVrdmZMnNjSQBjyQBBtjYA1Hjw4yo=@lists.denx.de
X-Gm-Message-State: AOJu0YwsJLBbkyLgtr1RAgJYa84AM48fJNXtnYnxSowr2NIzyuuprBXJ
 NheBfBc0FRA3XJg6iiV/fSDtPK9vXeTR/7cWuXuP0dMSzWQk1lSg
X-Google-Smtp-Source: AGHT+IHRoDf84GqMZ/er4P8I/ZwtuiU9PXFTIb9y3CWAvYquB+HZtm/LYsft36q+jyUKcXS7yTlcwA==
X-Received: by 2002:a05:6000:1f86:b0:381:cffc:d40b with SMTP id
 ffacd0b85a97d-381f183f7c7mr7270145f8f.39.1731239493323; 
 Sun, 10 Nov 2024 03:51:33 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:32 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH v2 4/8] test: dm: Expand dm_test_ofnode_phandle(_ot) with new
 ofnode/tree_parse_phandle
Date: Sun, 10 Nov 2024 12:50:23 +0100
Message-ID: <20241110115054.2555-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110115054.2555-1-ansuelsmth@gmail.com>
References: <20241110115054.2555-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Expand dm_test_ofnode_phandle(_ot) with new ofnode/tree_parse_phandle() op.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/other.dts |  7 ++++++
 arch/sandbox/dts/test.dts  |  7 ++++++
 test/dm/ofnode.c           | 44 ++++++++++++++++++++++++++++++++++----
 3 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/other.dts b/arch/sandbox/dts/other.dts
index b32158c6569..515d6348b3f 100644
--- a/arch/sandbox/dts/other.dts
+++ b/arch/sandbox/dts/other.dts
@@ -32,6 +32,7 @@
 			<&other_gpio_b 5 GPIO_ACTIVE_HIGH 3 2 1>,
 			<0>, <&other_gpio_a 12>;
 		other-phandle-value = <&other_gpio_c 10>, <0xFFFFFFFF 20>, <&other_gpio_a 30>;
+		other-phandle-nodes = <&other_phandle_node_1>, <&other_phandle_node_2>;
 	};
 
 	other_gpio_a: other-gpio-a {
@@ -46,6 +47,12 @@
 		#gpio-cells = <2>;
 	};
 
+	other_phandle_node_1: other-phandle-node-1 {
+	};
+
+	other_phandle_node_2: other-phandle-node-2 {
+	};
+
 	target: target {
 		compatible = "sandbox-other2";
 		str-prop = "other";
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 3017b33d67b..b8a46463158 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -296,6 +296,12 @@
 		compatible = "sandbox,dsi-host";
 	};
 
+	phandle_node_1: phandle-node-1 {
+	};
+
+	phandle_node_2: phandle-node-2 {
+	};
+
 	a-test {
 		reg = <0 1>;
 		compatible = "denx,u-boot-fdt-test";
@@ -334,6 +340,7 @@
 		interrupts-extended = <&irq 3 0>;
 		acpi,name = "GHIJ";
 		phandle-value = <&gpio_c 10>, <0xFFFFFFFF 20>, <&gpio_a 30>;
+		phandle-nodes = <&phandle_node_1>, <&phandle_node_2>;
 
 		mux-controls = <&muxcontroller0 0>, <&muxcontroller0 1>,
 			       <&muxcontroller0 2>, <&muxcontroller0 3>,
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 24b67bbe2b9..cf10e698d9e 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -280,15 +280,16 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_read_ot, UTF_SCAN_FDT | UTF_OTHER_FDT);
 
-/* test ofnode_count_/parse_phandle_with_args() */
+/* test ofnode_count_/parse/_phandle_with_args() */
 static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 {
 	struct ofnode_phandle_args args;
-	ofnode node;
+	ofnode node, phandle, target;
 	int ret;
 	const char prop[] = "test-gpios";
 	const char cell[] = "#gpio-cells";
 	const char prop2[] = "phandle-value";
+	const char prop3[] = "phandle-nodes";
 
 	node = ofnode_path("/a-test");
 	ut_assert(ofnode_valid(node));
@@ -352,20 +353,38 @@ static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 	ret = ofnode_parse_phandle_with_args(node, prop2, NULL, 1, 3, &args);
 	ut_asserteq(-ENOENT, ret);
 
+	/* Test ofnode_parse_phandle */
+	phandle = ofnode_parse_phandle(node, "missing", 0);
+	ut_assert(ofnode_equal(ofnode_null(), phandle));
+
+	target = ofnode_path("/phandle-node-1");
+	ut_assert(ofnode_valid(target));
+	phandle = ofnode_parse_phandle(node, prop3, 0);
+	ut_assert(ofnode_equal(target, phandle));
+
+	target = ofnode_path("/phandle-node-2");
+	ut_assert(ofnode_valid(target));
+	phandle = ofnode_parse_phandle(node, prop3, 1);
+	ut_assert(ofnode_equal(target, phandle));
+
+	phandle = ofnode_parse_phandle(node, prop3, 3);
+	ut_assert(ofnode_equal(ofnode_null(), phandle));
+
 	return 0;
 }
 DM_TEST(dm_test_ofnode_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
-/* test oftree_count_/parse_phandle_with_args() with 'other' tree */
+/* test oftree_count_/parse/_phandle_with_args() with 'other' tree */
 static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
 	struct ofnode_phandle_args args;
-	ofnode node;
+	ofnode node, phandle, target;
 	int ret;
 	const char prop[] = "other-test-gpios";
 	const char cell[] = "#gpio-cells";
 	const char prop2[] = "other-phandle-value";
+	const char prop3[] = "other-phandle-nodes";
 
 	node = oftree_path(otree, "/other-a-test");
 	ut_assert(ofnode_valid(node));
@@ -429,6 +448,23 @@ static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
 	ret = oftree_parse_phandle_with_args(otree, node, prop2, NULL, 1, 3, &args);
 	ut_asserteq(-ENOENT, ret);
 
+	/* Test oftree_parse_phandle */
+	phandle = oftree_parse_phandle(otree, node, "missing", 0);
+	ut_assert(ofnode_equal(ofnode_null(), phandle));
+
+	target = oftree_path(otree, "/other-phandle-node-1");
+	ut_assert(ofnode_valid(target));
+	phandle = oftree_parse_phandle(otree, node, prop3, 0);
+	ut_assert(ofnode_equal(target, phandle));
+
+	target = oftree_path(otree, "/other-phandle-node-2");
+	ut_assert(ofnode_valid(target));
+	phandle = oftree_parse_phandle(otree, node, prop3, 1);
+	ut_assert(ofnode_equal(target, phandle));
+
+	phandle = oftree_parse_phandle(otree, node, prop3, 3);
+	ut_assert(ofnode_equal(ofnode_null(), phandle));
+
 	return 0;
 }
 DM_TEST(dm_test_ofnode_phandle_ot, UTF_OTHER_FDT);
-- 
2.45.2

