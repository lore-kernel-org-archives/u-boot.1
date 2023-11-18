Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38CAC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:08:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 770AC8749D;
	Sat, 18 Nov 2023 23:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oHPBBCSO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C42D8700D; Sat, 18 Nov 2023 23:07:23 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882EB874DA
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 5A7ACCE01BE;
 Sat, 18 Nov 2023 22:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E51F9C433CC;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345232;
 bh=pQ+GNte601L0HGtk48blnIWTb55J9TffsZkBhVQB0AQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oHPBBCSOb43DYDDFrVQZ5foStOvoF7KSXX0hk/PdAs4+z0zur83I/bvq6WTuPkuOl
 5VRakyD5pznjEFjOzskSbHzBFSuDtugYCfdnRmW+NcHSkfqowOFHq7l8V/NZu5881j
 1LTsgPVma1zhxKqL0Rr+fTzLK6hhXoVvyEL3mF0ETA+K2mseOT4X012u/DDkhJWz1O
 oDEZ11cWKsmRxG2Vv62UnfvlQOy5B2HTUfJiWXlheLIYplI3qOo0QCbAO7TM3AFbTC
 dBH5jF2z/fXVl3Jntsfz++jvDeYk1pLuN6ekSsv7NwmxJx+CDeCHPP2T95vN5EEZH5
 DNkSMDJ8h+zsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D3170C5AE5E;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 19 Nov 2023 06:07:07 +0800
Subject: [PATCH 4/4] test: dm: clk_ccf: get "i2c_root" clock from &clk_ccf
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v1-4-509f400a99cb@outlook.com>
References: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
In-Reply-To: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345230; l=1735;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=kEgPFJ4X6SdN9/xo6Bpw8Z8sY9qknlOpf5kLOse5840=;
 b=WZeT5/D5PDKUSNmnpm+pLyroi9u5B2uHyuiGPckM0BwlCfADW3pipr4Lmi5d0GwyT9n2lX17S
 nRKeNHcTfxgBpJn288X6QwOSwIyifkHkNqOLnDy+R+fzQSLwOKTql/6
X-Developer-Key: i=forbidden405@outlook.com; a=ed25519;
 pk=hfdpPU3AXR+t7fdv58tXCD4UzRNq+fop2TMJezFlAhM=
X-Endpoint-Received: by B4 Relay for forbidden405@outlook.com/20230415 with
 auth_id=44
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

get i2c_root clock from device tree. In this way we get an CCF clock and
also test ccf_clk_ops.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 test/dm/clk_ccf.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/test/dm/clk_ccf.c b/test/dm/clk_ccf.c
index e4ebb93cda..b8be6d6572 100644
--- a/test/dm/clk_ccf.c
+++ b/test/dm/clk_ccf.c
@@ -18,8 +18,8 @@
 /* Tests for Common Clock Framework driver */
 static int dm_test_clk_ccf(struct unit_test_state *uts)
 {
-	struct clk *clk, *pclk;
-	struct udevice *dev;
+	struct clk *clk, *pclk, clk_ccf;
+	struct udevice *dev, *test_dev;
 	long long rate;
 	int ret;
 #if CONFIG_IS_ENABLED(CLK_CCF)
@@ -29,6 +29,7 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 
 	/* Get the device using the clk device */
 	ut_assertok(uclass_get_device_by_name(UCLASS_CLK, "clk-ccf", &dev));
+	ut_assertok(uclass_get_device_by_name(UCLASS_MISC, "clk-test", &test_dev));
 
 	/* Test for clk_get_by_id() */
 	ret = clk_get_by_id(SANDBOX_CLK_ECSPI_ROOT, &clk);
@@ -110,11 +111,18 @@ static int dm_test_clk_ccf(struct unit_test_state *uts)
 
 #if CONFIG_IS_ENABLED(CLK_CCF)
 	/* Test clk tree enable/disable */
+
+	ret = clk_get_by_index(test_dev, SANDBOX_CLK_TEST_ID_I2C_ROOT, &clk_ccf);
+	ut_assertok(ret);
+	ut_asserteq_str("clk-ccf", clk_ccf.dev->name);
+	ut_asserteq(clk_ccf.id, SANDBOX_CLK_I2C_ROOT);
+
 	ret = clk_get_by_id(SANDBOX_CLK_I2C_ROOT, &clk);
 	ut_assertok(ret);
 	ut_asserteq_str("i2c_root", clk->dev->name);
+	ut_asserteq(clk->id, SANDBOX_CLK_I2C_ROOT);
 
-	ret = clk_enable(clk);
+	ret = clk_enable(&clk_ccf);
 	ut_assertok(ret);
 
 	ret = sandbox_clk_enable_count(clk);

-- 
2.39.2

