Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0087C2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 22:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 169A8874E8;
	Sat, 18 Nov 2023 23:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uoXw+a5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F390C874E8; Sat, 18 Nov 2023 23:07:16 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 999B6870E2
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 23:07:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1FBF6B8058E;
 Sat, 18 Nov 2023 22:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D34B4C433CA;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700345232;
 bh=xWoT7WebLTL0Y+VABnw+iyN1WgBpRjLyx4Pd/vpDTqI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=uoXw+a5I7qEt1eLutwZjehc4e/7rt9wQAR2MCtTCwjkoY18rTCV+Qr2nF6GZ+HVsJ
 YByCLyL97NZsYGe5fMI/DkUxrF+XkJysBomNR163MorQPJljd9Ea5yosYDVSFG3g6l
 LfNbtmHACg8VTUPWgfgXZFXUls0NrWcQpPqts3aHqYs93uKlZ0KN5daNFnZ1JE8jw1
 1Xl+IkAMhx1j2TAmE/wkR7GWgicle8H1R99lBvHKWryW5jZpmUj3O5F4KDHiXKT1lz
 q14xL6SigKDZk+sI5NW+aHcuLmk5ftBiNlAOonJd/X79PK0maPcBNxPGGmTfX+dcje
 LTcFft4cfaOhg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BE56BC5AE5B;
 Sat, 18 Nov 2023 22:07:12 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Sun, 19 Nov 2023 06:07:05 +0800
Subject: [PATCH 2/4] clk: get correct ops for clk_enable() and
 clk_disable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231111-enable_count-v1-2-509f400a99cb@outlook.com>
References: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
In-Reply-To: <20231111-enable_count-v1-0-509f400a99cb@outlook.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700345230; l=1139;
 i=forbidden405@outlook.com; s=20230415; h=from:subject:message-id;
 bh=AnAh3PLkdIwcY96zMqQqGxKzLY2UH8ifWEJiVBEhqyc=;
 b=JsQHXlnG9H0AC86q2lIcHbT0rGwFFbIkJ0+NLOUFoxs+GB+YOHddhPbLjq08LE8whXB7/i9tw
 Q9xr9P+VgcUDz2eV/emy5H9TMqZCJVq2U90YWMq7ya0wxsW3My3pIre
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

