Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CCC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D11BC86F27;
	Sat, 18 Nov 2023 23:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u+PK5cgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF242874BA; Sat, 18 Nov 2023 23:10:27 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AD0287538
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:10:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C4BD960A0F;
 Sat, 18 Nov 2023 22:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAD5AC433C9;
 Sat, 18 Nov 2023 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345408;
 bh=7iF0rgTXq7dsQkp/1vdqqoRGqUUkzhJ6dcu6W71yXQY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=u+PK5cgDhcVTi1QH899vNSS7Ul4z5gbftQkFQd/wi4b4ovIrthaC6VNTinTFlfesE
 RaiCKuvg/badyKqOz+pVYlUvKqPZRGQxXLKYVKE60seztuXFIRZNK1flMkRY9Y/czb
 Id3OlGNvsxp4jaqHWMyiFpvlbcNQM5wprQgIKSluxXzwKUVXG+VGY7MCfhv+LgtVrR
 KifxaRiwPN4MHGLQKG+ZhURup8vM8eWaXXL5XJu7L2lZk7Y0+YeWfJMpGlgYh6pNoe
 cJ+K/bQkZU2imeNNWmhxgThQeeM9De8BQaDbFCWouNmpvWmxipMMawwZmzNpl+yv12
 OoAlbg758F3+A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CCB6AC54FB9;
 Sat, 18 Nov 2023 22:10:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 19 Nov 2023 06:10:05 +0800
Subject: [PATCH v2 1/4] clk: clk_sandbox_ccf: assign ccf_clk_ops to .ops of
 the driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v2-1-20e3728600b5@outlook.com>
References: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
In-Reply-To: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345405; l=1054;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=dE5cf8UrBn62M8y3lOb4IWNCRjPGOte1KTe6hOHO/4Y=;
 b=mJQL4QR9DeI/Np2cgcT1uSDWesZnLNOzf78lg2tNTD+aIwiJtaBvUUBsUqY0jENtbb9pDQQnI
 VFAAXmC19b8Ay/5txAGzzbS+fA36oC4eAX7LuA+NZx2ZIN/4GIMAU5r
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

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
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

