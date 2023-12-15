Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D37C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:29:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE1B87C30;
	Fri, 15 Dec 2023 19:28:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e4iozIrd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D9E787C2C; Fri, 15 Dec 2023 19:28:59 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEFD187C50
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:28:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6D5DDCE30C8;
 Fri, 15 Dec 2023 18:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0010C433C8;
 Fri, 15 Dec 2023 18:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702664933;
 bh=+c1LM4HFOZ8qTloEWF6tRtMn3Bl3QdyIxkB3jslCims=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=e4iozIrdxLcRSj67MrUq6V6AJ//uvwzt8SSaqOpAyjnRqzGAzgg6TiKEAb3bpBiOo
 iGesHXuzAiiFhuGd3GvJ/Ev6jb1luMgNBJWDjnbxgAcNfxzr3zrkeSP/Odq/v0SxSx
 //lEVTf4mhYBBbMGgdq89D0b/3dOR+jjU/6vLPCLpQ89t/AupQI9TxfF4eoLDdF0Xn
 gVGI3NQvXbvdR6qT2WYwdpy9qTDe0UTAcUcE2XhjVKdfIefHelIrN/pR4aUAwuaSxO
 CAGZqLsvE7qpmp6lupORV+2OJ2JuORh0HsIWDqbf0zvJFk7XVSRag8D+fe17tkT8nd
 wVh1mi2Rb/99g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 883CBC35274;
 Fri, 15 Dec 2023 18:28:53 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sat, 16 Dec 2023 02:28:51 +0800
Subject: [PATCH v3 1/2] clk: get correct ops for clk_enable() and clk_disable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v3-1-08a821892fa9@outlook.com>
References: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
In-Reply-To: <20231111-enable_count-v3-0-08a821892fa9@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702664931; l=1187;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=lkdm+vGFt2P1kjUtpjLgf/OGQ+pcAmah4UJq3vZOUKo=;
 b=u12vzkE9QuN3ZZXQtTBniKgdXhe++J0aMWLWLQtVMWTzn978jWpRKO1/zAh31UG27eRuEdkOP
 /aF4/s/o+xaDc6+ELs9aPSqzeW8xW99iEElwu5iQXZi+EjouJrDUVJV
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

Reviewed-by: Sean Anderson <seanga2@gmail.com>
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

