Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EC0C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAEDF8750C;
	Sat, 18 Nov 2023 23:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bLy+tCfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F5F874F0; Sat, 18 Nov 2023 23:07:26 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E80874A3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1A20EB80471;
 Sat, 18 Nov 2023 22:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA592C433C8;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345232;
 bh=KJgrqeXYMzDasFzWbFrxgodTexO7oOX/05HXpKFkPdc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bLy+tCfS62KFJfq1acpiQaM4eBBbkIsQKTAs68G1MJg3GVNSAMdFqTlep/XfoueP0
 vOUtTJUdDeZayUSWXinrNWEoltRwGvXmmc7V2EXXNuEnQw2fK7hnscwmCC4HDodmm5
 eMaYzgyNOOUeACO42AuanxZ70Tqlt9+mNk6azW9/Szdvw3LybBrdR5MVirI5CdVL+a
 R9Vgoa6EhHhQoKkGNYvyNxSA/gKP7sz+ICi29xod+wyRWLKtUKj3aXyWyjsx/T0NN1
 GRmKYEj8oQJyi1IRECZxQRneikFn6R6zEkmoKSQ4mQK6NK7s5DY0wG6BVb6WShFwQE
 9e22pzm/+Z4nQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B2AC1C54FB9;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 19 Nov 2023 06:07:04 +0800
Subject: [PATCH 1/4] clk: clk_sandbox_ccf: assign ccf_clk_ops to .ops of
 the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v1-1-509f400a99cb@outlook.com>
References: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
In-Reply-To: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345230; l=998;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=gmuzR4eJI1KUYMY38xt5/Yd52PFA/UhL54qyPp/btBw=;
 b=DVrB/egGvBg5F41qrFsSuy8ntlz0eT+Y8wsMKKR6o35wLBp6OlTieOVXpmDjDWPpzFuJlAPn0
 ukACNBAzmv7BvjfkqUHpme2pLT5hfAha/YxquyyM1pU7ZL9mgeGv5mK
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

It can now act as an clk provider on which ccf_clk_ops can be tested.
Also add "#clock-cells=<1>" to test.dts.
---
 arch/sandbox/dts/test.dts     | 1 +
 drivers/clk/clk_sandbox_ccf.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index c7197795ef..b1773f1bc2 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -654,6 +654,7 @@
 
 	ccf: clk-ccf {
 		compatible = "sandbox,clk-ccf";
+		#clock-cells = <1>;
 	};
 
 	efi-media {
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

-- 
2.39.2

