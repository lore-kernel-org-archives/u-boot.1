Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB4C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8DD387522;
	Sat, 18 Nov 2023 23:10:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ocXE/qgA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 781CB80310; Sat, 18 Nov 2023 23:10:28 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DA3B87535
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id CF8A760B28;
 Sat, 18 Nov 2023 22:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02530C433CB;
 Sat, 18 Nov 2023 22:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345408;
 bh=xWoT7WebLTL0Y+VABnw+iyN1WgBpRjLyx4Pd/vpDTqI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=ocXE/qgA28HvXcBm6vkFtiWnxmuOkeXM5BeVEk89bxycB/ERCBL+QwlVwgz7LDKrO
 qvUL5M9+eolcDiYgybLN4m2OoImAc4Kyiyi7B49s5XRzemb57eovN+ZQj6Qo28P8Mk
 zqB/oXqhRhKvs1DQwIkrTXesf554Wfxtgkc4MFTp590U9uhlRIkYRxIOjEJabZEvOB
 mdA/7u0/5aFtO6fwEUjERR+QeHbpDJyy+Gl6ycl/wNCbXmMPNk8hh2PyoqB0TF0aEA
 X2Z41Ea/FEbGNv0uizrH6rMk462MW8sV5j460SIs+6GP2RaWYwl/4i8wtdXIvRQAHk
 8Ea+Zn4RwV1QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DA04AC54E76;
 Sat, 18 Nov 2023 22:10:07 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 19 Nov 2023 06:10:06 +0800
Subject: [PATCH v2 2/4] clk: get correct ops for clk_enable() and clk_disable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v2-2-20e3728600b5@outlook.com>
References: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
In-Reply-To: <20231111-enable_count-v2-0-20e3728600b5@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345405; l=1139;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=AnAh3PLkdIwcY96zMqQqGxKzLY2UH8ifWEJiVBEhqyc=;
 b=ztblI32rvGm1l+7dyNgBHQg8ICrsYggmpijyGzHVF3fQl4jEdcbGzYKIxIrIkaKIa8qazK6ZJ
 I/nCVxrOTN/CUA4bydtRVhWPawSRlp7xNiP/qHSeOEyTZtiZ/c7CHxd
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

assign clk_dev_ops(clkp->dev) to ops to ensure correct clk operations
are called on clocks.

This fixes the incorrect enable_count issue as described in [1].

[1]: https://lore.kernel.org/all/SEZPR06MB695927A6DEEEF8489A06897396A7A@SEZPR06MB6959.apcprd06.prod.outlook.com/

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk-uclass.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 3b5e3f9c86..3e9d68feb3 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -640,6 +640,7 @@ int clk_enable(struct clk *clk)
 	if (CONFIG_IS_ENABLED(CLK_CCF)) {
 		/* Take id 0 as a non-valid clk, such as dummy */
 		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
+			ops = clk_dev_ops(clkp->dev);
 			if (clkp->enable_count) {
 				clkp->enable_count++;
 				return 0;
@@ -699,6 +700,7 @@ int clk_disable(struct clk *clk)
 
 	if (CONFIG_IS_ENABLED(CLK_CCF)) {
 		if (clk->id && !clk_get_by_id(clk->id, &clkp)) {
+			ops = clk_dev_ops(clkp->dev);
 			if (clkp->flags & CLK_IS_CRITICAL)
 				return 0;
 

-- 
2.39.2

