Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C336C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:22:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5D0381FC8;
	Wed, 19 Mar 2025 04:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354381;
	bh=zg65mmbuN8OfcfJHRC3JWUjNTs9QvwyrkHzrYyjfjFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y0KfFmUVcbONczQD2grHVuNcbxZ62DHiONUrN2Lf9Ypyq4jup9RMwSO6yG4XwRgkG
	 uTFBJGXFneB99aYX2FnIX/tyK+zE865233IBm9YRbOEvUW/a4JlqNU3XfSL+8jm1oZ
	 Begth+TPTZBJWf1pFJXfZpp4QOTXnQJPEPXQb3EPo7IwSxuTPBhii7mRT81C4Gop6r
	 CeGlPOvxnPaBZk3DSekDlKOMGVBFQTkfEyyFehUKZSfHHweRSFDGGdaC/mOCxs5bST
	 E34m2Ca/uslfesSJAiPzOwas9Q4cX9k95YeBBWqXgvDym/vZcDAZw0ye/0apvuZIK+
	 d01lpTJN+OU5A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B11881E13; Wed, 19 Mar 2025 04:19:39 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8956A81E5A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ddo/ocG7"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3BB58101E91C2; Wed, 19 Mar 2025 04:19:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354377; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=zg65mmbuN8OfcfJHRC3JWUjNTs9QvwyrkHzrYyjfjFc=;
 b=Ddo/ocG7H2zu9TT8Kx6G+/dFZw59SD1ln9hEQQKYEKx6hYY1zieX9eDyhtvtAIVv1HcfxM
 KA8OL+sYjPHAYDGOBlWvRy1gNEo1VIngFTk78AIdHg9tf97gM88QYEUbPh3P4cMTpVz3Xh
 gPzEydDArdBXrQkgJ72j4KI7oX49SJguhbIeJJhLZE3nLQguZLVVNI8VeHHO6T/4WkIJri
 jHGa4vGhbrnUz0DlXrGfwZH5SKLEBbPTRa86jsxmWvfT0UFWLwz7ImGBsVtc1ogRmqhTMj
 zCCxY5ducURYYTPJRwzUC3thhtjfCXUphxgK4FtXaWLBh05WdpEJsX54LLREZg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 21/24] clk: clk-divider: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:31 +0100
Message-ID: <20250319031852.233537-22-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031852.233537-1-marex@denx.de>
References: <20250319031852.233537-1-marex@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Use clock-names property which is accessible via parent clock OF node
to look up the parent clock by name instead of depending on unreliable
global clock name to perform look up.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
 drivers/clk/clk-divider.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 3b4b3c4fa5f..e692b9c2167 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -218,7 +218,8 @@ static struct clk *_register_divider(struct udevice *dev, const char *name,
 	clk = &div->clk;
 	clk->flags = flags;
 
-	ret = clk_register(clk, UBOOT_DM_CLK_CCF_DIVIDER, name, parent_name);
+	ret = clk_register(clk, UBOOT_DM_CLK_CCF_DIVIDER, name,
+			   clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(div);
 		return ERR_PTR(ret);
-- 
2.47.2

