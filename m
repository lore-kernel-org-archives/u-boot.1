Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 198DED29C4D
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 19:07:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86479839D5;
	Mon, 19 Jan 2026 20:07:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iqtQC5ud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3195E83A2D; Mon, 19 Jan 2026 20:07:24 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0CC38389A
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 20:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BD89F6014E;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73F05C19425;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768849640;
 bh=NH8aetcHJ34C4NinACWpylRfUtCMBI/STOgW4x0mdJ0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=iqtQC5udho39BK+Ai5tuuUV8TtHmGQ0PAz/L6Rn1oiY7xyttA1LTPMsMXqv23zcSF
 7UB5hWlBGE0pYz5x1M+61dylC4X0d1fmWCzrg5uth2ZjKiNK/7Yh52gZJa2lowBBWk
 00P56WX+E+E2GgvMllT30rSPkWG30funrd5kUVyZZFzfSkqwC8xy24k3MbINKt0Lpx
 3747OQBa/M8gxQH69WEP/tk4BjA/UvMNwNfWRJWrVrRWuyD99yyu+j+U4LCB1jMd8F
 ksBC2E2KBhtz69UI8xwTxlCiwhpaDYs+Kwhhio26S/HLq550GUVPjsvbrt3PHycPDW
 ubuU/NlqMmkew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5CFCCF2EE;
 Mon, 19 Jan 2026 19:07:20 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Tue, 20 Jan 2026 03:07:21 +0800
Subject: [PATCH v3 4/6] clk: use clk_get_parent() helper in clk_en(dis)able()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-clk-reparent-v3-4-0d43d4b362ac@outlook.com>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
In-Reply-To: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>, 
 Simon Glass <simon.glass@canonical.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768849639; l=1956;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=xk4wveIHG+QGUJr69UksHUufRiFvbzXYy5E94JU7VIw=;
 b=qo5rw5MvQDshzPFD84wPaImglPDFEnWzK1AHLpZHek+vPtuTMtgjVu6uT+/ZqCVE6j4ypCBOM
 oiX3LGXsAA7CscUqeopRmVbrLgj3JbAr+RSPVPcuZm+Beq2TmQVlDep
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

Update clk_enable() and clk_disable() to use clk_get_parent() instead of
manually accessing clk->dev->parent.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 drivers/clk/clk-uclass.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
index 559420c85056..297d4d63a579 100644
--- a/drivers/clk/clk-uclass.c
+++ b/drivers/clk/clk-uclass.c
@@ -663,7 +663,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 int clk_enable(struct clk *clk)
 {
 	const struct clk_ops *ops;
-	struct clk *clkp = NULL;
+	struct clk *clkp = NULL, *clk_parent;
 	int ret;
 
 	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
@@ -679,9 +679,10 @@ int clk_enable(struct clk *clk)
 				clkp->enable_count++;
 				return 0;
 			}
-			if (clkp->dev->parent &&
-			    device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
-				ret = clk_enable(dev_get_clk_ptr(clkp->dev->parent));
+
+			clk_parent = clk_get_parent(clkp);
+			if (!IS_ERR_OR_NULL(clk_parent)) {
+				ret = clk_enable(clk_parent);
 				if (ret) {
 					printf("Enable %s failed\n",
 					       clkp->dev->parent->name);
@@ -754,13 +755,16 @@ int clk_disable(struct clk *clk)
 				return ret;
 		}
 
-		if (clkp && clkp->dev->parent &&
-		    device_get_uclass_id(clkp->dev->parent) == UCLASS_CLK) {
-			ret = clk_disable(dev_get_clk_ptr(clkp->dev->parent));
-			if (ret) {
-				printf("Disable %s failed\n",
-				       clkp->dev->parent->name);
-				return ret;
+		if (clkp) {
+			struct clk *clk_parent = clk_get_parent(clkp);
+
+			if (!IS_ERR_OR_NULL(clk_parent)) {
+				ret = clk_disable(clk_parent);
+				if (ret) {
+					printf("Disable %s failed\n",
+					       clkp->dev->parent->name);
+					return ret;
+				}
 			}
 		}
 	} else {

-- 
2.43.0


