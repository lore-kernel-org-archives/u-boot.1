Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1E2C7115C
	for <u-boot@archiver.kernel.org>; Sat, 21 Jun 2025 10:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6118E82D6F;
	Sat, 21 Jun 2025 12:54:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U6U6WARZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78A6782D5E; Sat, 21 Jun 2025 12:54:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DDDA82CF4
 for <u-boot@lists.denx.de>; Sat, 21 Jun 2025 12:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AE5656112A;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64621C4CEF2;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750503260;
 bh=xuuiPBWhXSQgtO28bRF3dwPQsnmPIoGqpR0hk4Dhilg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U6U6WARZZWMUwWlj3SPCI1nSVXY8aj4TSWD8G6PSgc2uu+EiTHIr6ZEXqyJ4MenKo
 Sly4YmydZHS27HI7PO/ZLL32d6XN8PvghsCFZ1WFEM2CQ7DzPTYZdz8FJHqROgbC0H
 i+PsXJUkQ8x4DyPjdCrNrLVfqqS6BaAty1W2iMy9ML30DmodgH+VpZ8/kWCj4cIBnt
 jRAjy4P/fmxSfwglguzy4LFDxhTI3g3Cl5JA7KKkvD1iFnLeX78hlGJcDI1JuEJBeE
 u4YgjIZCZvPTeQaBNZr6k84xC7oL8JBcwrts2eEb0egtsWSQQJEGI5JL2J7ze7GpMq
 FRJr8hbvH6oFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 57A8AC7115C;
 Sat, 21 Jun 2025 10:54:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 21 Jun 2025 18:54:20 +0800
Subject: [PATCH RFC 3/3] clk: sandbox: reverse the order to register clk
 i2c_root and i2c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250621-clk-reparent-v1-3-48a7f2f31c59@outlook.com>
References: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
In-Reply-To: <20250621-clk-reparent-v1-0-48a7f2f31c59@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750503259; l=1071;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=aQSA7Q7r1hkmSAHzG9f5x6P95Gk/sYDULKCIbOSFSDQ=;
 b=5QdURyUI0hcXo3SAFd6XUQWtJVWJ1gMobrMRm7eaWRaRe5zmkPDBYlnmZxzS0T1ixGMfQLRon
 jegfYlKcRTrBop8QcH63rNOAO0b1e//eYSAdwFJyZTSUsXDK7Y88f7/
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

Reverse the clk_register() order of i2c_root and i2c to test the feature
that allows register clocks in a less strict order.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk_sandbox_ccf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk_sandbox_ccf.c b/drivers/clk/clk_sandbox_ccf.c
index f96a15c30b3a..ed4f69807644 100644
--- a/drivers/clk/clk_sandbox_ccf.c
+++ b/drivers/clk/clk_sandbox_ccf.c
@@ -269,14 +269,14 @@ static int sandbox_clk_ccf_probe(struct udevice *dev)
 	       sandbox_clk_mux("usdhc2_sel", &reg, 17, 1, usdhc_sels,
 			       ARRAY_SIZE(usdhc_sels)));
 
+	clk_dm(SANDBOX_CLK_I2C_ROOT,
+	       sandbox_clk_gate2("i2c_root", "i2c", base + 0x7c, 0));
+
 	reg = BIT(28) | BIT(24) | BIT(16);
 	clk_dm(SANDBOX_CLK_I2C,
 	       sandbox_clk_composite("i2c", i2c_sels, ARRAY_SIZE(i2c_sels),
 				     &reg, CLK_SET_RATE_UNGATE));
 
-	clk_dm(SANDBOX_CLK_I2C_ROOT,
-	       sandbox_clk_gate2("i2c_root", "i2c", base + 0x7c, 0));
-
 	return 0;
 }
 

-- 
2.43.0


