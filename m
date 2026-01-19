Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BFCCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:08:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB9AC83A91;
	Mon, 19 Jan 2026 20:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bZ9ktEz9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 441628313B; Mon, 19 Jan 2026 20:07:26 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50D21839E4
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:07:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AC4B144477;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D005C2BC9E;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768849640;
 bh=ZIi17L5q5CL30WxOibrwh5ayHE3WtLovC0j97Wk6btQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bZ9ktEz9wMgbMfaJ1w7KFV2/242EP+NSNVAw/yB6gU6oXWZDor/fDagq96VVTgo12
 bfjdWDA+iJR3CeK6Icx0s8/IPMi7evFsl7wPsViOoKMBREU7pSW3zGkT03C3H44RRA
 SA26pJwmmuYLX47iGEXyfIb9lEWuJj3IZK/omuZwQWpdGVR2pLbWld1k5tRKluHnQS
 T9Lzd50dh2MwDJBsWu134A2dYTNIU08Z7//uolg+tM6Xj3CIxpChirHKxwV/PMu4oG
 cf7s5YdYJ9ZJ6vqythaYb02wH8CghtiIel0NzgtjCbmpdmn9xInkuf8rgUcSNF5UNE
 T8NDG4WIgLKDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 86C55CCF2DE;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Jan 2026 03:07:23 +0800
Subject: [PATCH v3 6/6] test: clk: add test for CLK_LAZY_REPARENT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-clk-reparent-v3-6-0d43d4b362ac@outlook.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768849639; l=7495;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=29coQw/9sTw6zhIgySMsjVjVCKHrMx8v8fa/ab+1boo=;
 b=m3wBzAVLO3bj9dOgE5VqOVZIsc3H9KNgVMUWsbWNW4vQTsvNNXP8HqU0xOaHlwUuSUVcQzNAc
 jjzlWsP9W3VAjlgXss+PbuXTk7h44YfrqZbs1DzJ9pY3aEEDaqFcwpC
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=qOD5jhp891/Xzc+H/PZ8LWVSWE3O/XCQnAg+5vdU2IU=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230724 with
 auth_id=67
X-Original-From: Yang Xiwen <forbidden405@outlook.com>
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
Reply-To: forbidden405@outlook.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Yang Xiwen <forbidden405@outlook.com>

Add a test for the newly introduced CLK_LAZY_REPARENT feature.

Modify clk_sandbox_ccf driver to register two clocks(i2s and i2s_root)
in reversed order.

The test function then try to acquire the clocks and asserts that their
internal states are maintained correctly.

Ensure clk->parent_name is NULL in all "normal" cases so existing
drivers are not broken by this feature.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk_sandbox_ccf.c | 10 ++++++++++
 include/sandbox-clk.h         |  2 ++
 test/dm/clk_ccf.c             | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
index 9b8036d41aac..86f75132d548 100644
--- a/drivers/clk/clk_sandbox_ccf.c
+++ b/drivers/clk/clk_sandbox_ccf.c
@@ -229,6 +229,7 @@ static const struct udevice_id sandbox_clk_ccf_test_ids[] = {
 
 static const char *const usdhc_sels[] = { "pll3_60m", "pll3_80m", };
 static const char *const i2c_sels[] = { "pll3_60m", "pll3_80m", };
+static const char *const i2s_sels[] = { "pll3_60m", "pll3_80m", };
 
 static int sandbox_clk_ccf_probe(struct udevice *dev)
 {
@@ -277,6 +278,15 @@ static int sandbox_clk_ccf_probe(struct udevice *dev)
 	dev_clk_dm(dev, SANDBOX_CLK_I2C_ROOT,
 		   sandbox_clk_gate2("i2c_root", "i2c", base + 0x7c, 0));
 
+	/* Register i2s_root(child) and i2s(parent) in reverse order to test CLK_LAZY_REPARENT */
+	dev_clk_dm(dev, SANDBOX_CLK_I2S_ROOT,
+		   sandbox_clk_gate2("i2s_root", "i2s", base + 0x80, 0));
+
+	reg = BIT(29) | BIT(25) | BIT(17);
+	dev_clk_dm(dev, SANDBOX_CLK_I2S,
+		   sandbox_clk_composite("i2s", i2s_sels, ARRAY_SIZE(i2s_sels),
+					 &reg, CLK_SET_RATE_UNGATE));
+
 	return 0;
 }
 
diff --git a/include/sandbox-clk.h b/include/sandbox-clk.h
index c2616c27a44a..0cd735e3ad5f 100644
--- a/include/sandbox-clk.h
+++ b/include/sandbox-clk.h
@@ -21,6 +21,8 @@ enum {
 	SANDBOX_CLK_USDHC2_SEL,
 	SANDBOX_CLK_I2C,
 	SANDBOX_CLK_I2C_ROOT,
+	SANDBOX_CLK_I2S,
+	SANDBOX_CLK_I2S_ROOT,
 };
 
 enum sandbox_pllv3_type {
diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index 9c06aadb7ed3..8bbb79bec2ac 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -35,12 +35,14 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_ECSPI_ROOT), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("ecspi_root", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_SET_RATE_PARENT, clk->flags);
 
 	/* Test for clk_get_parent_rate() */
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_ECSPI1), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("ecspi1", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_SET_RATE_PARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
@@ -50,6 +52,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_ECSPI0), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("ecspi0", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_SET_RATE_PARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
@@ -59,6 +62,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_USDHC1_SEL), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("usdhc1_sel", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_SET_RATE_NO_REPARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
@@ -71,6 +75,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq_64(60000000, rate);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_PLL3_80M), &pclk);
+	ut_assertnull(clk->parent_name);
 	ut_assertok(ret);
 
 	ret = clk_set_parent(clk, pclk);
@@ -82,6 +87,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_USDHC2_SEL), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("usdhc2_sel", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_SET_RATE_NO_REPARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
@@ -98,6 +104,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq_64(80000000, rate);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_PLL3_60M), &pclk);
+	ut_assertnull(clk->parent_name);
 	ut_assertok(ret);
 
 	ret = clk_set_parent(clk, pclk);
@@ -110,6 +117,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("i2c", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_SET_RATE_UNGATE, clk->flags);
 
 	rate = clk_get_rate(clk);
@@ -124,11 +132,13 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_index(test_dev, SANDBOX_CLK_TEST_ID_I2C_ROOT, &clk_ccf);
 	ut_assertok(ret);
 	ut_asserteq_str("clk-ccf", clk_ccf.dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(CLK_ID(clk_ccf.dev, SANDBOX_CLK_I2C_ROOT), clk_ccf.id);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C_ROOT), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("i2c_root", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 	ut_asserteq(SANDBOX_CLK_I2C_ROOT, clk_get_id(clk));
 
 	ret = clk_enable(&clk_ccf);
@@ -138,6 +148,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq(1, ret);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C), &pclk);
+	ut_assertnull(clk->parent_name);
 	ut_assertok(ret);
 
 	ret = sandbox_clk_enable_count(pclk);
@@ -156,6 +167,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_USDHC1_SEL), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("usdhc1_sel", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 
 	pclk = clk_get_parent(clk);
 	ut_assertok_ptr(pclk);
@@ -169,6 +181,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 
 	ret = clk_get_by_id(CLK_ID(dev, clkid), &pclk);
 	ut_assertok(ret);
+	ut_assertnull(clk->parent_name);
 	ret = clk_set_parent(clk, pclk);
 	ut_assertok(ret);
 	pclk = clk_get_parent(clk);
@@ -179,6 +192,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C_ROOT), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("i2c_root", clk->dev->name);
+	ut_assertnull(clk->parent_name);
 
 	/* Disable it, if any. */
 	ret = sandbox_clk_enable_count(clk);
@@ -209,3 +223,29 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	return 1;
 }
 DM_TEST(dm_test_clk_ccf, UTF_SCAN_FDT);
+
+#if CONFIG_IS_ENABLED(CLK_LAZY_REPARENT)
+/* Test CLK_LAZY_REPARENT feature */
+static int dm_test_clk_lazy_reparent(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	struct clk *clk_i2s, *clk_i2s_root;
+
+	/* Get the device using the clk device */
+	ut_assertok(uclass_get_device_by_name(UCLASS_CLK, "clk-ccf", &dev));
+
+	ut_assertok(clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2S_ROOT), &clk_i2s_root));
+	ut_assertok(clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2S), &clk_i2s));
+
+	ut_asserteq_str(clk_i2s_root->parent_name, "i2s");
+	ut_assertnull(clk_i2s_root->dev->parent);
+
+	ut_assertok(clk_enable(clk_i2s_root));
+
+	ut_assertnull(clk_i2s_root->parent_name);
+	ut_asserteq_ptr(clk_i2s_root->dev->parent, clk_i2s->dev);
+
+	return 0;
+}
+DM_TEST(dm_test_clk_lazy_reparent, UTF_SCAN_FDT);
+#endif

-- 
2.43.0


