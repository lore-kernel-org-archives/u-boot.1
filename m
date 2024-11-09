Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD989D5E37A
	for <u-boot@archiver.kernel.org>; Sat,  9 Nov 2024 18:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78BC78920B;
	Sat,  9 Nov 2024 19:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X6FjRdQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21B8289232; Sat,  9 Nov 2024 19:01:14 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191BA89043
 for <u-boot@lists.denx.de>; Sat,  9 Nov 2024 19:01:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43159c9f617so25131025e9.2
 for <u-boot@lists.denx.de>; Sat, 09 Nov 2024 10:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731175271; x=1731780071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Oe+mSRWmszNTJyXM2MHyLWm07qc4gVk0kuOSPQO53WY=;
 b=X6FjRdQzFlX5tb5om75C8qhl1QvIJM6ny58TooaUIcHL5/VoI5X0IFQ0sYMeh5azs3
 aMu8gCLVtmuFOVHBNbd9wvBT5K2wePAEdSVDtuHAM9fDZQCZcFsr/UOkQeWjD4klU+CQ
 1vAnRvJzsgmbMYk4V7F83QbRxGH1XudXD5GOyJg7GDtn6/EjekyOFMeHc3qUSLFYz1+n
 WKKGuJUUUVj+hnaTdWtAiJqGerTULvR/lxXV4Jv8nxSFJkV6qvKhkXYQxtwTaEMBeYTY
 008CrNH4XISquwpDPXws2wEyyEzjMHYwDSfJ9+BiExx7AdRwXGBu+ERHyzmhN5vahAo3
 f0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731175271; x=1731780071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oe+mSRWmszNTJyXM2MHyLWm07qc4gVk0kuOSPQO53WY=;
 b=TLbiR8BOosSE1zbaErEba9N0OKvBp+KI5/DJ2zG10mUPVIgKzwMioDuLrOFUO810pu
 bb4VUoYPpASy2l27v1YvcJccQOpoo04Gj70pAdDMG/omq2fnzUNEzWxF58ba8J5o0alk
 t5k1yEHtSboziqLe+JE/2C3zxqnsfAOUn3uSx16GwvyY8G0ynOccjhTuNIGmSLGt9u+C
 aLIpyDkRruN8MHMg3tMtDohCKiW9el6IJj9x3yracIGwXGQIrztfCBTwTteLERp7iFEL
 nvXxv62ZptJcQpi4QzWXZFW6AuHpy6G1bChLkCoBS6H65WN3z4ND1E3d39BqD+cuVVic
 OC6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7x9Q7IN8dbi6GH+ik1DKrAOzcatd0qar55LYwcJ63H/qkiNkS6rZe4eMYLMkxxUnUP1bo8K4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw8xvUuFxsLvZUB9c3b+DpgiFrwUjqFXuj9TLJcBoJHOU4ymBE1
 dPAwPy8KUVslSFiED/veyib7IMNGz2fFyyvcPpgarLxvw7sBVhAW
X-Google-Smtp-Source: AGHT+IFnLNDNlNH6DAqNYzhdvFnUtTHswpMYTWyw/+Bj/ubtYsjDecjkBMekaFa2Ga1Er7BYfJGRMA==
X-Received: by 2002:a05:6000:2d11:b0:381:f443:21e9 with SMTP id
 ffacd0b85a97d-381f4432614mr3674668f8f.0.1731175271296; 
 Sat, 09 Nov 2024 10:01:11 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it.
 [93.34.91.161]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432aa73a2d8sm146095025e9.41.2024.11.09.10.01.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Nov 2024 10:01:10 -0800 (PST)
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
Subject: [PATCH 2/8] test: dm: fix broken dm_test_ofnode_phandle_ot
Date: Sat,  9 Nov 2024 19:00:27 +0100
Message-ID: <20241109180038.10344-3-ansuelsmth@gmail.com>
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

Fix broken dm_test_ofnode_phandle_ot test. They never actually worked
and were passing test by pure luck by having the same phandle index of
test.dts that coincicentally had #gpio-cells in the same index node.

It was sufficient to add a phandle to test.dts to make the test fail.

To correctly test these feature, make use oif the new OPs oftree to
parse phandle.

For consistency with the dm_test_ofnode_phandle, rework the test and
other.dts to use the same property with the other- prefix to every
node.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/sandbox/dts/other.dts | 26 +++++++++++---
 test/dm/ofnode.c           | 72 +++++++++++++++++++++++++++++++-------
 2 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/arch/sandbox/dts/other.dts b/arch/sandbox/dts/other.dts
index 395a7923228..110063fa1c6 100644
--- a/arch/sandbox/dts/other.dts
+++ b/arch/sandbox/dts/other.dts
@@ -8,14 +8,14 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 / {
 	compatible = "sandbox-other";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
 	node {
-		target = <&target 3 4>;
-
 		subnode {
 			compatible = "sandbox-other2";
 			str-prop = "other";
@@ -25,10 +25,28 @@
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
-		str-prop = "other";
+
 		reg = <0x8000 0x100>;
 		status = "disabled";
 	};
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index ce996567c3c..5e36a228395 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -349,30 +349,78 @@ static int dm_test_ofnode_phandle(struct unit_test_state *uts)
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
 
-	ret = ofnode_parse_phandle_with_args(node, "target", "#gpio-cells", 0,
-					     0, &args);
+	/* Test oftree_parse_phandle_with_args with cell name */
+	ret = oftree_parse_phandle_with_args(otree, node, "missing", cell, 0, 0,
+					     &args);
+	ut_asserteq(-ENOENT, ret);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, "#invalid", 0, 0,
+					     &args);
+	ut_asserteq(-EINVAL, ret);
+	ret = oftree_parse_phandle_with_args(otree, node, prop, cell, 0, 0, &args);
 	ut_assertok(ret);
-	ut_asserteq(2, args.args_count);
-	ut_asserteq(3, args.args[0]);
-	ut_asserteq(4, args.args[1]);
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
+
+	/* Test oftree_parse_phandle_with_args with cell count */
+	ret = oftree_parse_phandle_with_args(otree, node, prop2, NULL, 1, 0, &args);
+	ut_assertok(ret);
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

