Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7098ED5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:01:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC1489221;
	Sat,  9 Nov 2024 19:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDXvrJkY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2A8A8922D; Sat,  9 Nov 2024 19:01:18 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 570C6892CD
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4316e9f4a40so27369625e9.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175276; x=1731780076; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0I1mybIdFpOKZF3x127Qh19DI3I90HbPEpXw4hxphcA=;
 b=MDXvrJkYzBiURU9Nsi8dPxguMgB5zV7jvhuYsMZvuaLmCpLIROSm2PPHLEwkTBNbMV
 DSmAgDqoPitjj8JO1w7oXyIxkRZ+DWbPXmC7L90vs6i+6VCvhMquoRVWAYhazYFGNiY2
 Ql13gJ9GLkjOO352dyAbvwp24UVYIpl54rRYiSDndY9/Y2dZD0K5SyqQkLLDp3hom5wX
 tpCUW4qxcbP/iQx+Qj7M6TRvqGWN/VucWVSA0lY00BXY75VokIDTBlelfxDD0OqdG+eE
 9BDHkv0u4it/23P9JzzwlrGkSIWyjMTiMyKrBTpxvX4N3kITkqyTp8ievVikU15HX4Uy
 bM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175276; x=1731780076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0I1mybIdFpOKZF3x127Qh19DI3I90HbPEpXw4hxphcA=;
 b=e6qFJS8oce+pwB7L77HEGspSXOhhTj76duSyj8IEo8PKtxvt2r0ohynQnEr3marcHd
 +5HWADC1KBlK7RFs9r9AL/2O4nC+tIfU4o+OyjS18hyRtTkRKlt6yl9e6jp0Q7SMUroM
 +Oq2K03btT91P7mEqetaTmcO/YYwEuOsgd1izUsdY6G9Rfw7NYF69ULD/mphiBELhhss
 z1dEB4E/j67RrOoQI0FOPaD417TUtxmuwo7QwMSSPIVeUiIPf8gCtE7HW4E4q85x/wbE
 K8uxtNxRwbNH+XsCm7aWY4I8wIUDwi7LytI7ZEQ1/k7cJSBRzngvT9rAzAAmqkaMi8jX
 w0ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUvUkulT8OI67lOxuCZOftpFWIo75R2Uwt3cWpTaIwwqBToKhGq7nOuXnkGPheCS+Mojwbmxs=@lists.denx.de
X-Gm-Message-State: AOJu0YwFg2jE7Tl+PVelhQ04/GVxu4P92xVTNZiGVOfj605U8tYlteXy
 /PWqYfqsF+07YPczMqg0g8khwOU+SSBqD43cDtJzDptXXZ2zfNNc
X-Google-Smtp-Source: AGHT+IFEg8/+llLZX8SMCYRZj+HJl60mst4T9dsFuIr4UkO/cQ1YM3ZAhtg+8PPclN0P/2WGsX5mRQ==
X-Received: by 2002:a05:600c:870d:b0:431:4fa0:2e0b with SMTP id
 5b1f17b1804b1-432b7519708mr56192675e9.28.1731175275432; 
 Sat, 09 Nov 2024 10:01:15 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:14 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sean Anderson <seanga2@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Marek Vasut <marex@denx.de>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, u-boot@lists.denx.de
Subject: [PATCH 4/8] test: dm: Expand dm_test_ofnode_phandle(_ot) with new
 ofnode/tree_parse_phandle
Date: Sat,  9 Nov 2024 19:00:29 +0100
Message-ID: <20241109180038.10344-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241109180038.10344-1-ansuelsmth@gmail.com>
References: <20241109180038.10344-1-ansuelsmth@gmail.com>
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
index 110063fa1c6..226226e3020 100644
--- a/arch/sandbox/dts/other.dts
+++ b/arch/sandbox/dts/other.dts
@@ -30,6 +30,7 @@
 			<&other_gpio_b 5 GPIO_ACTIVE_HIGH 3 2 1>,
 			<0>, <&other_gpio_a 12>;
 		other-phandle-value = <&other_gpio_c 10>, <0xFFFFFFFF 20>, <&other_gpio_a 30>;
+		other-phandle-nodes = <&other_phandle_node_1>, <&other_phandle_node_2>;
 	};
 
 	other_gpio_a: other-gpio-a {
@@ -44,6 +45,12 @@
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
index 5e36a228395..c05de1c54ca 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -273,15 +273,16 @@ static int dm_test_ofnode_read_ot(struct unit_test_state *uts)
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
@@ -345,20 +346,38 @@ static int dm_test_ofnode_phandle(struct unit_test_state *uts)
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
@@ -422,6 +441,23 @@ static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
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

