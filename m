Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9551D3C931
	for <u-boot@archiver.kernel.org>; Sun, 10 Nov 2024 11:51:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C81DF890D8;
	Sun, 10 Nov 2024 12:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZQeSmBzA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F81989116; Sun, 10 Nov 2024 12:51:32 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EC3E890BC
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 12:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-37d4821e6b4so2594075f8f.3
 for <u-boot@lists.denx.de>; Sun, 10 Nov 2024 03:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731239489; x=1731844289; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JHbUjESrBhGpfCcnCj8/8F3tqxJNGQF3SkkIhOZxPyQ=;
 b=ZQeSmBzASYcA1IVr7blbZsTs+LyHpAOq79+t8KhqUuTeTdD/IMwhh8ywIt7W7x+8JC
 3sDJaP6rGNFiPHgQ1KOkLi5E48t5tAvsEmjTW/5eooy43EzYzxM0l+Zh9D97EAHRrlIV
 a+1wT4BKqhsilueYDMtrIpF/z0YWjrIhUVZ5yh4+FD/w524w2iQ7jSZ/fYK4Us+RXBjf
 pJ4mxXimiQc8h5N+TdPNB2jQ/f4ssH/YjpWPD3DQho6L3BQBicG0wmVs9Kj6GnLDjB78
 Ep+JCzLCUGGnkB9VIrUr0zYG+ZLCKAJPtJtXsQsOLRqjuG7BFjNZgcYa33YiIuR4HGcK
 AC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731239489; x=1731844289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHbUjESrBhGpfCcnCj8/8F3tqxJNGQF3SkkIhOZxPyQ=;
 b=VeYPvlkjsOux1rXQhglRl+bOVX6/Kwpepft068Sh9fAVsCmmqFWRa5cIDfni2HDfpn
 7LAG7iV2BPPV8TpfBM0OwNvwK9fbSorlmgi0l/UpOZRItBLokZNQLM7mA2f/8mLKCd1I
 NhR3/bo07d+Q/fVM+8Cw5q+EYmJYaDKOkA/cOq4S/7QKWDZgmlqxThn/A/S1cSHoORiB
 VfRpgvnzKxWfu2QQsPqqmsbAl7SVhC0IFIU0JC4J8U0MVZgBOVA/vtCXZlKv4c+1MXs5
 EE/aewxqA7ejHkAv2eM6lMmwk5Hfem4CL0xKIMdy2peVCYORdClmy0gJ+/Wa+DY9NYZd
 nOzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi+j74FFkhF8YyfAmm876BzodwlrwaO9epfZTtTOS7l5cF+utTylHOXGb+w97JIYY5r29BtBc=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp9zTY4P0umLE8R+SxujFp7YZt25WQ/ByjGqhCZNdJy2SZom/k
 QZ6uJjK41xd8qnIlD70AqXYDnSjKnyQKqEFGhxFGPeF6+uIXzSAk
X-Google-Smtp-Source: AGHT+IHVdcZxGO2lMjQSeIDS1ttmWsr9Iuf2s02SLg5YessrnIrv6BBnwFBlN09740Le+bM+gqrPyA==
X-Received: by 2002:a5d:5847:0:b0:37d:5405:817b with SMTP id
 ffacd0b85a97d-381f186724cmr7743333f8f.7.1731239489238; 
 Sun, 10 Nov 2024 03:51:29 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5fb1sm181423745e9.8.2024.11.10.03.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 03:51:28 -0800 (PST)
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
Subject: [PATCH v2 2/8] test: dm: fix broken dm_test_ofnode_phandle_ot and
 get_by_phandle_ot
Date: Sun, 10 Nov 2024 12:50:21 +0100
Message-ID: <20241110115054.2555-3-ansuelsmth@gmail.com>
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

Fix broken dm_test_ofnode_phandle_ot test. They never actually worked
and were passing test by pure luck by having the same phandle index of
test.dts that coincicentally had #gpio-cells in the same index node.

It was sufficient to add a phandle to test.dts to make the test fail.

To correctly test these feature, make use oif the new OPs oftree to
parse phandle.

For consistency with the dm_test_ofnode_phandle, rework the test and
other.dts to use the same property with the other- prefix to every
node.

Also fix dm_test_ofnode_get_by_phandle_ot by making it more robust and
renaming the phandle property to other-phandle.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/other.dts | 24 ++++++++++-
 test/dm/ofnode.c           | 83 +++++++++++++++++++++++++++++++-------
 2 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/arch/sandbox/dts/other.dts b/arch/sandbox/dts/other.dts
index 395a7923228..b32158c6569 100644
--- a/arch/sandbox/dts/other.dts
+++ b/arch/sandbox/dts/other.dts
@@ -8,13 +8,15 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	compatible = "sandbox-other";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
 	node {
-		target = <&target 3 4>;
+		other-phandle = <&target>;
 
 		subnode {
 			compatible = "sandbox-other2";
@@ -25,9 +27,27 @@
 		};
 	};
 
+	other-a-test {
+		other-test-gpios = <&other_gpio_a 1>, <&other_gpio_a 4>,
+			<&other_gpio_b 5 GPIO_ACTIVE_HIGH 3 2 1>,
+			<0>, <&other_gpio_a 12>;
+		other-phandle-value = <&other_gpio_c 10>, <0xFFFFFFFF 20>, <&other_gpio_a 30>;
+	};
+
+	other_gpio_a: other-gpio-a {
+		#gpio-cells = <1>;
+	};
+
+	other_gpio_b: other-gpio-b {
+		#gpio-cells = <5>;
+	};
+
+	other_gpio_c: other-gpio-c {
+		#gpio-cells = <2>;
+	};
+
 	target: target {
 		compatible = "sandbox-other2";
-		#gpio-cells = <2>;
 		str-prop = "other";
 		reg = <0x8000 0x100>;
 		status = "disabled";
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index ce996567c3c..24b67bbe2b9 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -141,9 +141,16 @@ static int dm_test_ofnode_get_by_phandle_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
 	ofnode node;
+	u32 idx;
+	int ret;
 
-	ut_assert(ofnode_valid(oftree_get_by_phandle(oftree_default(), 1)));
-	node = oftree_get_by_phandle(otree, 1);
+	node = oftree_path(otree, "/node");
+	ut_assert(ofnode_valid(node));
+
+	ret = ofnode_read_u32(node, "other-phandle", &idx);
+	ut_assertok(ret);
+
+	node = oftree_get_by_phandle(otree, idx);
 	ut_assert(ofnode_valid(node));
 	ut_asserteq_str("target", ofnode_get_name(node));
 
@@ -349,30 +356,78 @@ static int dm_test_ofnode_phandle(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_ofnode_phandle, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
-/* test ofnode_count_/parse_phandle_with_args() with 'other' tree */
+/* test oftree_count_/parse_phandle_with_args() with 'other' tree */
 static int dm_test_ofnode_phandle_ot(struct unit_test_state *uts)
 {
 	oftree otree = get_other_oftree(uts);
 	struct ofnode_phandle_args args;
 	ofnode node;
 	int ret;
+	const char prop[] = "other-test-gpios";
+	const char cell[] = "#gpio-cells";
+	const char prop2[] = "other-phandle-value";
 
-	node = oftree_path(otree, "/node");
+	node = oftree_path(otree, "/other-a-test");
+	ut_assert(ofnode_valid(node));
 
-	/* Test ofnode_count_phandle_with_args with cell name */
-	ret = ofnode_count_phandle_with_args(node, "missing", "#gpio-cells", 0);
+	/* Test oftree_count_phandle_with_args with cell name */
+	ret = oftree_count_phandle_with_args(otree, node, "missing", cell, 0);
 	ut_asserteq(-ENOENT, ret);
-	ret = ofnode_count_phandle_with_args(node, "target", "#invalid", 0);
+	ret = oftree_count_phandle_with_args(otree, node, prop, "#invalid", 0);
 	ut_asserteq(-EINVAL, ret);
-	ret = ofnode_count_phandle_with_args(node, "target", "#gpio-cells", 0);
-	ut_asserteq(1, ret);
+	ret = oftree_count_phandle_with_args(otree, node, prop, cell, 0);
+	ut_asserteq(5, ret);
+
+	/* Test oftree_parse_phandle_with_args with cell name */
+	ret = oftree_parse_phandle_with_args(otree, node, "missing", cell, 0, 0,
+					     &args);
+	ut_asserteq(-ENOENT, ret);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, "#invalid", 0, 0,
+					     &args);
+	ut_asserteq(-EINVAL, ret);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 0, &args);
+	ut_assertok(ret);
+	ut_asserteq(1, args.args_count);
+	ut_asserteq(1, args.args[0]);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 1, &args);
+	ut_assertok(ret);
+	ut_asserteq(1, args.args_count);
+	ut_asserteq(4, args.args[0]);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 2, &args);
+	ut_assertok(ret);
+	ut_asserteq(5, args.args_count);
+	ut_asserteq(5, args.args[0]);
+	ut_asserteq(1, args.args[4]);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 3, &args);
+	ut_asserteq(-ENOENT, ret);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 4, &args);
+	ut_assertok(ret);
+	ut_asserteq(1, args.args_count);
+	ut_asserteq(12, args.args[0]);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 5, &args);
+	ut_asserteq(-ENOENT, ret);
+
+	/* Test oftree_count_phandle_with_args with cell count */
+	ret = oftree_count_phandle_with_args(otree, node, "missing", NULL, 2);
+	ut_asserteq(-ENOENT, ret);
+	ret = oftree_count_phandle_with_args(otree, node, prop2, NULL, 1);
+	ut_asserteq(3, ret);
 
-	ret = ofnode_parse_phandle_with_args(node, "target", "#gpio-cells", 0,
-					     0, &args);
+	/* Test oftree_parse_phandle_with_args with cell count */
+	ret = oftree_parse_phandle_with_args(otree, node, prop2, NULL, 1, 0, &args);
 	ut_assertok(ret);
-	ut_asserteq(2, args.args_count);
-	ut_asserteq(3, args.args[0]);
-	ut_asserteq(4, args.args[1]);
+	ut_asserteq(1, ofnode_valid(args.node));
+	ut_asserteq(1, args.args_count);
+	ut_asserteq(10, args.args[0]);
+	ret = oftree_parse_phandle_with_args(otree, node, prop2, NULL, 1, 1, &args);
+	ut_asserteq(-EINVAL, ret);
+	ret = oftree_parse_phandle_with_args(otree, node, prop2, NULL, 1, 2, &args);
+	ut_assertok(ret);
+	ut_asserteq(1, ofnode_valid(args.node));
+	ut_asserteq(1, args.args_count);
+	ut_asserteq(30, args.args[0]);
+	ret = oftree_parse_phandle_with_args(otree, node, prop2, NULL, 1, 3, &args);
+	ut_asserteq(-ENOENT, ret);
 
 	return 0;
 }
-- 
2.45.2

