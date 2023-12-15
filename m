Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA742C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CFA487C64;
	Fri, 15 Dec 2023 19:28:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k0WF6Mz/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B75B687C44; Fri, 15 Dec 2023 19:28:56 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C356387C50
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:28:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 53879B82A89;
 Fri, 15 Dec 2023 18:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB734C433C9;
 Fri, 15 Dec 2023 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702664933;
 bh=pcAGpvm/mkkw/VXt3hkuT7m7AbKztsWNfwb2D6j4Zn8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=k0WF6Mz/C5/rIhB3ROcHicA+GAsNdy4v81BacbfAGiGeOE2bh3GxI6a/1U7fZI3uK
 JuXonbmbxnA89v3zpyTShYX8/nhvBgSzA8mJG/2N3gRwZDqzgbTdPnN1lD9Uja5NIX
 0H5Vnw56AZPmZyuZUUL3EWVTLGH91Fv31nBQdbV6S0vZN2NaqpNjvll+pvhmp6G0aS
 PjApRkHNeTybhE16wrBl4QAh4xAj/haqohtguE09zZqxTdQIrm6yzdc6oYh2EOitgf
 mgvLAqtiAwy48wOGVxD3zClZ5uU9TwIgarRoe+6pPr0+ppXEm43DgNDhNRb4DH/a0l
 EEXfxoPaKZUTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 93C3FC46CA2;
 Fri, 15 Dec 2023 18:28:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 16 Dec 2023 02:28:52 +0800
Subject: [PATCH v3 2/2] test: dm: clk_ccf: test ccf_clk_ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v3-2-08a821892fa9@outlook.com>
References: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
In-Reply-To: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702664931; l=4095;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=xkLwbswSd9yLC9pHs+IXaFwvSpaLH5hsTUHW/xM9Jhc=;
 b=XYHi1ozdb1XcBbG/7Zl77CI4bVTgo171eIh429wzQu23SSEqfBZl9d6MFG8gx6BEGoUDAIMen
 fVSfbPBsBRYAzJnfZ5V4u6qjcFgeYAk17moY9q+WyrbT5Az55ZcQaqU
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

Assign ccf_clk_ops to .ops of clk_ccf driver so that it can act as an
clk provider. Also add "#clock-cells=<1>" to its device tree node.

Add "i2c_root" to clk_test in the device tree and driver for testing.

Get "i2c_root" clock in CCF unit tests and add tests for it.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/sandbox/dts/test.dts      |  4 +++-
 arch/sandbox/include/asm/clk.h |  1 +
 drivers/clk/clk_sandbox_ccf.c  |  1 +
 drivers/clk/clk_sandbox_test.c |  1 +
 test/dm/clk_ccf.c              | 14 +++++++++++---
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index c7197795ef..a3a865d65c 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -631,9 +631,10 @@
 		clocks = <&clk_fixed>,
 			 <&clk_sandbox 1>,
 			 <&clk_sandbox 0>,
+			 <&ccf 11>,
 			 <&clk_sandbox 3>,
 			 <&clk_sandbox 2>;
-		clock-names = "fixed", "i2c", "spi", "uart2", "uart1";
+		clock-names = "fixed", "i2c", "spi", "i2c_root", "uart2", "uart1";
 	};
 
 	clk-test2 {
@@ -654,6 +655,7 @@
 
 	ccf: clk-ccf {
 		compatible = "sandbox,clk-ccf";
+		#clock-cells = <1>;
 	};
 
 	efi-media {
diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index df7156fe31..1daf2e7ac7 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -39,6 +39,7 @@ enum sandbox_clk_test_id {
 	SANDBOX_CLK_TEST_ID_FIXED,
 	SANDBOX_CLK_TEST_ID_SPI,
 	SANDBOX_CLK_TEST_ID_I2C,
+	SANDBOX_CLK_TEST_ID_I2C_ROOT,
 	SANDBOX_CLK_TEST_ID_DEVM1,
 	SANDBOX_CLK_TEST_ID_DEVM2,
 	SANDBOX_CLK_TEST_ID_DEVM_NULL,
diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
index fedcdd4044..38184e27aa 100644
--- a/drivers/clk/clk_sandbox_ccf.c
+++ b/drivers/clk/clk_sandbox_ccf.c
@@ -284,6 +284,7 @@ static int sandbox_clk_ccf_probe(struct udevice *dev)
 U_BOOT_DRIVER(sandbox_clk_ccf) = {
 	.name = "sandbox_clk_ccf",
 	.id = UCLASS_CLK,
+	.ops = &ccf_clk_ops,
 	.probe = sandbox_clk_ccf_probe,
 	.of_match = sandbox_clk_ccf_test_ids,
 };
diff --git a/drivers/clk/clk_sandbox_test.c b/drivers/clk/clk_sandbox_test.c
index 5807a454f3..c695b69321 100644
--- a/drivers/clk/clk_sandbox_test.c
+++ b/drivers/clk/clk_sandbox_test.c
@@ -15,6 +15,7 @@ static const char * const sandbox_clk_test_names[] = {
 	[SANDBOX_CLK_TEST_ID_FIXED] = "fixed",
 	[SANDBOX_CLK_TEST_ID_SPI] = "spi",
 	[SANDBOX_CLK_TEST_ID_I2C] = "i2c",
+	[SANDBOX_CLK_TEST_ID_I2C_ROOT] = "i2c_root",
 };
 
 int sandbox_clk_test_get(struct udevice *dev)
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

