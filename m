Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FE0D3B996
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 21:51:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ECD883C8C;
	Tue,  9 Dec 2025 22:51:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LPINOISp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E150B83C94; Tue,  9 Dec 2025 22:51:42 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB5D83C08
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 22:51:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 6500F403C5; 
 Tue,  9 Dec 2025 21:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1765317099;
 bh=3prZFr+jZVINs6Al6/0hMPfwTR8zhT03HDLhvZWRIOM=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LPINOISpz7NvFJwjlxBuI8yhtqbqfOHavPCNch6cWYEzObLXbDv58xBfk+fIZCBn+
 eFGgUAOboVghptPJ2F7EmRuSS/34GOYSd2rOcrEsRGlm+EjSzGpEp6kUDuh1ZLa3BR
 8ZAalto7NygR0hT5IqixyK6+l4q5NWOykSLVcZKB9+ev9BkvwycoeP4I4p8L8t+tLr
 FmW23uxRLtyTJs2n4FfKak1VO36tVV7VT0AK3dfcdV3wx4HaVD95v4yVLWXPMAVPjg
 BzRw37j26eKJgC6iW4GPRz7xr8QV0+T/B63AeS2FaMCihC1uBlrJpY1my5F/1zYMXb
 uQFHjI/BFAmr3sG803/pd+Q5H/W1rgtqn4QGqX5ncCQV89ZSvBCGcPzp8GSTUsZXsG
 X5c/XM2OzmqTT5Gji3vYwbcDf0pyHqlC3yYgcV5W5wZhM2DAAH/15+cAWqvuoryzpb
 RCRcA8HaKIw2znMn0FFVRBAUySYhGaOx21V0cWsvvAStrhjEBnG86vqaneTJwZiUtU
 idXX6X0AOOWT7Fb75Aj2jLLaQ9oj/Rpq61YUGelDce/PcyrV45PkPMcw63M7tQV2UC
 41G5Mtt+S08BFJpcbGOSEchPPKqlppXpeIfd1Il5Fh1QjBo8cqXda/jkCL6LnFyr+N
 jtH0DbABi8nS6UD6YKTAmi4U=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Simon Glass <sjg@chromium.org>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: dm: clk_ccf: clean up assert statements
Date: Tue,  9 Dec 2025 22:51:35 +0100
Message-ID: <20251209215135.403732-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

* Expected values must always be the first arguments.
* Long values on 64 bit systems require ut_asserteq_64() for checking

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/dm/clk_ccf.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index 64c21b10c3e..9c06aadb7ed 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -44,7 +44,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq(CLK_SET_RATE_PARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
-	ut_asserteq(rate, 20000000);
+	ut_asserteq_64(20000000, rate);
 
 	/* test the gate of CCF */
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_ECSPI0), &clk);
@@ -53,7 +53,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq(CLK_SET_RATE_PARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
-	ut_asserteq(rate, 20000000);
+	ut_asserteq_64(20000000, rate);
 
 	/* Test the mux of CCF */
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_USDHC1_SEL), &clk);
@@ -62,13 +62,13 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq(CLK_SET_RATE_NO_REPARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
-	ut_asserteq(rate, 60000000);
+	ut_asserteq_64(60000000, rate);
 
 	rate = clk_set_rate(clk, 60000000);
-	ut_asserteq(rate, -ENOSYS);
+	ut_asserteq_64((u64)-ENOSYS, rate);
 
 	rate = clk_get_rate(clk);
-	ut_asserteq(rate, 60000000);
+	ut_asserteq_64(60000000, rate);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_PLL3_80M), &pclk);
 	ut_assertok(ret);
@@ -77,7 +77,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_assertok(ret);
 
 	rate = clk_get_rate(clk);
-	ut_asserteq(rate, 80000000);
+	ut_asserteq_64(80000000, rate);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_USDHC2_SEL), &clk);
 	ut_assertok(ret);
@@ -85,17 +85,17 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq(CLK_SET_RATE_NO_REPARENT, clk->flags);
 
 	rate = clk_get_parent_rate(clk);
-	ut_asserteq(rate, 80000000);
+	ut_asserteq_64(80000000, rate);
 
 	pclk = clk_get_parent(clk);
 	ut_asserteq_str("pll3_80m", pclk->dev->name);
 	ut_asserteq(CLK_SET_RATE_PARENT, pclk->flags);
 
 	rate = clk_set_rate(clk, 80000000);
-	ut_asserteq(rate, -ENOSYS);
+	ut_asserteq_64((u64)-ENOSYS, rate);
 
 	rate = clk_get_rate(clk);
-	ut_asserteq(rate, 80000000);
+	ut_asserteq_64(80000000, rate);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_PLL3_60M), &pclk);
 	ut_assertok(ret);
@@ -104,7 +104,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_assertok(ret);
 
 	rate = clk_get_rate(clk);
-	ut_asserteq(rate, 60000000);
+	ut_asserteq_64(60000000, rate);
 
 	/* Test the composite of CCF */
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C), &clk);
@@ -113,10 +113,10 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ut_asserteq(CLK_SET_RATE_UNGATE, clk->flags);
 
 	rate = clk_get_rate(clk);
-	ut_asserteq(rate, 60000000);
+	ut_asserteq_64(60000000, rate);
 
 	rate = clk_set_rate(clk, 60000000);
-	ut_asserteq(rate, 60000000);
+	ut_asserteq_64(60000000, rate);
 
 #if CONFIG_IS_ENABLED(CLK_CCF)
 	/* Test clk tree enable/disable */
@@ -124,33 +124,33 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_get_by_index(test_dev, SANDBOX_CLK_TEST_ID_I2C_ROOT, &clk_ccf);
 	ut_assertok(ret);
 	ut_asserteq_str("clk-ccf", clk_ccf.dev->name);
-	ut_asserteq(clk_ccf.id, CLK_ID(clk_ccf.dev, SANDBOX_CLK_I2C_ROOT));
+	ut_asserteq(CLK_ID(clk_ccf.dev, SANDBOX_CLK_I2C_ROOT), clk_ccf.id);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C_ROOT), &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("i2c_root", clk->dev->name);
-	ut_asserteq(clk_get_id(clk), SANDBOX_CLK_I2C_ROOT);
+	ut_asserteq(SANDBOX_CLK_I2C_ROOT, clk_get_id(clk));
 
 	ret = clk_enable(&clk_ccf);
 	ut_assertok(ret);
 
 	ret = sandbox_clk_enable_count(clk);
-	ut_asserteq(ret, 1);
+	ut_asserteq(1, ret);
 
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_I2C), &pclk);
 	ut_assertok(ret);
 
 	ret = sandbox_clk_enable_count(pclk);
-	ut_asserteq(ret, 1);
+	ut_asserteq(1, ret);
 
 	ret = clk_disable(clk);
 	ut_assertok(ret);
 
 	ret = sandbox_clk_enable_count(clk);
-	ut_asserteq(ret, 0);
+	ut_asserteq(0, ret);
 
 	ret = sandbox_clk_enable_count(pclk);
-	ut_asserteq(ret, 0);
+	ut_asserteq(0, ret);
 
 	/* Test clock re-parenting. */
 	ret = clk_get_by_id(CLK_ID(dev, SANDBOX_CLK_USDHC1_SEL), &clk);
@@ -188,7 +188,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	}
 
 	ret = sandbox_clk_enable_count(clk);
-	ut_asserteq(ret, 0);
+	ut_asserteq(0, ret);
 
 	clk->flags = CLK_IS_CRITICAL;
 	ret = clk_enable(clk);
@@ -197,13 +197,13 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 	ret = clk_disable(clk);
 	ut_assertok(ret);
 	ret = sandbox_clk_enable_count(clk);
-	ut_asserteq(ret, 1);
+	ut_asserteq(1, ret);
 	clk->flags &= ~CLK_IS_CRITICAL;
 
 	ret = clk_disable(clk);
 	ut_assertok(ret);
 	ret = sandbox_clk_enable_count(clk);
-	ut_asserteq(ret, 0);
+	ut_asserteq(0, ret);
 #endif
 
 	return 1;
-- 
2.51.0

