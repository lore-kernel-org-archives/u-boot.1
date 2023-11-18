Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285A5C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A1BC8716D;
	Sat, 18 Nov 2023 23:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gOENkVZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1304874F0; Sat, 18 Nov 2023 23:07:18 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 284B3874A3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 43E8A60B24;
 Sat, 18 Nov 2023 22:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF903C433CB;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345232;
 bh=mFHtODJh3QtG9/aRPvRjaNixeOyzPIHz60slwqq88HQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=gOENkVZFywXpF0/7B292fI1HAAAy2UdPtin/u7qAClR9c4u4Iv6uFTL9m15+cHCSL
 aMYX7E0XJRv8JMUCxVPCf6vPMcBQCpZMlR3bG0KnyoHGftbuzHGx+z5nTtB5iTFNSO
 ohqMlf7QRArhepHJFd62iHfGEUWFoL08FxouS0MyHT3ohhvTVsips6UEo1ykHvgAoy
 rDDXNMmd/sEMI0VjEypWEf0dPLro5Mjc/O3cX+PZ4hnFH5+32CvHaYw/10gfz3xlrj
 t/fGku+AD25OK4v/6W3V34/dvRQ2X/1hpQzlrLEeVceURawu1vPqcMqwv5EGqtzm06
 XvttVaxx5mNnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C8EA0C54E76;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 19 Nov 2023 06:07:06 +0800
Subject: [PATCH 3/4] clk: clk_sandbox: get devm clock i2c_root
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v1-3-509f400a99cb@outlook.com>
References: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
In-Reply-To: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345230; l=1883;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=NV6lQRVixnIUlPN940DJuyvXA1K8ViHVEEbIhr+SFt8=;
 b=t+BSBQdTipWYhTDxktYwj/lmcUyb8vE4x3hgDEuMXHozFBy5t6DNTE8los+daKxjXZrbUmWvS
 aQF8VmOWtNyChiABnKKVS6YQvy2tGji1k02kjna3M/tobngX2NfrAsS
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

This clock is added to dts. Get it in the devm group in the driver or
the testcases will fail.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 arch/sandbox/dts/test.dts      | 5 +++--
 arch/sandbox/include/asm/clk.h | 1 +
 drivers/clk/clk_sandbox_test.c | 5 +++++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b1773f1bc2..f99397c528 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -632,8 +632,9 @@
 			 <&clk_sandbox 1>,
 			 <&clk_sandbox 0>,
 			 <&clk_sandbox 3>,
-			 <&clk_sandbox 2>;
-		clock-names = "fixed", "i2c", "spi", "uart2", "uart1";
+			 <&clk_sandbox 2>,
+			 <&ccf 11>;
+		clock-names = "fixed", "i2c", "spi", "uart2", "uart1", "i2c_root";
 	};
 
 	clk-test2 {
diff --git a/arch/sandbox/include/asm/clk.h b/arch/sandbox/include/asm/clk.h
index df7156fe31..597bc528dc 100644
--- a/arch/sandbox/include/asm/clk.h
+++ b/arch/sandbox/include/asm/clk.h
@@ -41,6 +41,7 @@ enum sandbox_clk_test_id {
 	SANDBOX_CLK_TEST_ID_I2C,
 	SANDBOX_CLK_TEST_ID_DEVM1,
 	SANDBOX_CLK_TEST_ID_DEVM2,
+	SANDBOX_CLK_TEST_ID_I2C_ROOT,
 	SANDBOX_CLK_TEST_ID_DEVM_NULL,
 
 	SANDBOX_CLK_TEST_ID_COUNT,
diff --git a/drivers/clk/clk_sandbox_test.c b/drivers/clk/clk_sandbox_test.c
index 5807a454f3..c0623dee10 100644
--- a/drivers/clk/clk_sandbox_test.c
+++ b/drivers/clk/clk_sandbox_test.c
@@ -53,6 +53,11 @@ int sandbox_clk_test_devm_get(struct udevice *dev)
 		return PTR_ERR(clk);
 	sbct->clkps[SANDBOX_CLK_TEST_ID_DEVM2] = clk;
 
+	clk = devm_clk_get_optional(dev, "i2c_root");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	sbct->clkps[SANDBOX_CLK_TEST_ID_I2C_ROOT] = clk;
+
 	sbct->clkps[SANDBOX_CLK_TEST_ID_DEVM_NULL] = NULL;
 	clk = devm_clk_get_optional(dev, "not_an_existing_clock");
 	if (IS_ERR(clk))

-- 
2.39.2

