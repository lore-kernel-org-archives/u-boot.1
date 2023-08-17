Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F03FC3DA58
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 17:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24C2C86BBF;
	Thu, 17 Aug 2023 19:04:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Inpvj879";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A39F86B9A; Thu, 17 Aug 2023 19:04:21 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D792086B99
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 19:04:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+forbidden405.outlook.com@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 62DDB65271;
 Thu, 17 Aug 2023 17:04:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8092C433CC;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692291853;
 bh=tM1aYllxcPhGjnSsU4nxGUN3TQPcYe2TbwDmTngls4c=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Inpvj879v85O2xnQd75OQMuYffYRUb2BfIuHCk3j12IreUpOgz23btDXyBHQEpHoq
 MGLcwTTvF//M/RKZUzZlRtBMCUyPO+QE/32MYmBqF4U5oYS43PdzbbNxT8Pw9MC2+E
 LcwYoK7GniKgvh3ilqzxwzlYmE1e2uwK/U0WkROa+JyQsBWeKTMVU/J7wDYPjHMIPv
 cp5wRN32yOUIIFoBS+1c5NtrZ4AFSqsA5oS5skduo+uU7jiNYdD7iV7jJVR5j12/mx
 LbRHzzZKK3HZwZeVl5gfGnCYMlld0dx9Lz0MZkqvHj1AIjOeB8G5V0mpZbv66TD1Zr
 r5FxW0b5tUxqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id B8FD6C41513;
 Thu, 17 Aug 2023 17:04:13 +0000 (UTC)
From: Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Fri, 18 Aug 2023 01:04:02 +0800
Subject: [PATCH RESEND 3/5] clk: also handle ENOENT in *_optional functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-clk-fix-v1-3-49ec18f820bf@outlook.com>
References: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
In-Reply-To: <20230818-clk-fix-v1-0-49ec18f820bf@outlook.com>
To: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Yang Xiwen <forbidden405@outlook.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692291852; l=1405;
 i=forbidden405@outlook.com; s=20230724; h=from:subject:message-id;
 bh=Ya3s56yb/uYzBObmNpjkiNoe6oNIwyGOQ0sokgx66Jo=;
 b=I09kKcG7TodYECmhEd/9wUPheTbxQILBk4u18UtMuyakf9HYnbxB6D86jlfWndXlFrgLv9slZ
 nXVhbTrBeOVDBCuGs/mGmaFwoA8DbmyhlJPpiKciQzj88HyeVxCFZzU
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

If the device does not specify any clocks in device tree, these
functions will return PTR_ERR(-ENOENT). This is not the intended
behavior and does not comply with linux kernel CCF. Fix that by
returning NULL under such circumstances instead.

Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
---
 include/clk.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/clk.h b/include/clk.h
index d91285235f..f95da0838d 100644
--- a/include/clk.h
+++ b/include/clk.h
@@ -223,9 +223,11 @@ struct clk *devm_clk_get(struct udevice *dev, const char *id);
 static inline struct clk *devm_clk_get_optional(struct udevice *dev,
 						const char *id)
 {
+	int ret;
 	struct clk *clk = devm_clk_get(dev, id);
 
-	if (PTR_ERR(clk) == -ENODATA)
+	ret = PTR_ERR(clk);
+	if (ret == -ENODATA || ret == -ENOENT)
 		return NULL;
 
 	return clk;
@@ -335,7 +337,7 @@ static inline int clk_get_by_name_optional(struct udevice *dev,
 	int ret;
 
 	ret = clk_get_by_name(dev, name, clk);
-	if (ret == -ENODATA)
+	if (ret == -ENODATA || ret == -ENOENT)
 		return 0;
 
 	return ret;
@@ -359,7 +361,7 @@ static inline int clk_get_by_name_nodev_optional(ofnode node, const char *name,
 	int ret;
 
 	ret = clk_get_by_name_nodev(node, name, clk);
-	if (ret == -ENODATA)
+	if (ret == -ENODATA || ret == -ENOENT)
 		return 0;
 
 	return ret;

-- 
2.34.1

