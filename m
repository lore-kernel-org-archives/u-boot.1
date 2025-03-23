Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E3CBC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:05:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55875820EA;
	Sun, 23 Mar 2025 17:02:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745745;
	bh=GqIgMu5XCvFJsfaugeg7pD4qpKcZUd8sT82tqXRli40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AHhpoOMsHUlQJuAqEYuwcWGrT/0XfwuYLONiCOkgUVHIF2E9Y5+AfULXK3iI8RmyT
	 MR4FwqSO7MmF13MvW78frliGXm6TLohKyD8T5vkxVrS+Z6Y269VPoLy3QXyTrBWHCU
	 SforxpLUOSjb/A92LuW2mzIm8UX6+iRCM4ypLERQCYRFUe5KmHbpcy2YP2JcB5xzPZ
	 VPi7RjOVy86ZLB/7zQYESAN4iW7i/Cge5Lu+oz9yaIjuta/aS8Clg6MfFKgoUNzpG9
	 GguqvadD/6UE35UgGIl2MWC34u59oBXe8TGyRIpRi6kLCMHO87VkYR0Xv33LfIFPBT
	 FQy3GtlkFjg3w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFE098210E; Sun, 23 Mar 2025 17:02:21 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FA1982757
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZN14JBsP"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2161D1029024F; Sun, 23 Mar 2025 17:02:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745735; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=GqIgMu5XCvFJsfaugeg7pD4qpKcZUd8sT82tqXRli40=;
 b=ZN14JBsPdq2ALmyfHgn9lCOEYPKDIoZrNh4aF+Rn8YrqaaWcXixkvrFOY3uwhO9FGnNNGF
 Ejzscj5L5nLP0AqHXBt41cWXn9wTOQeOA+JSs+zKpzQRs8RlYxt8Meg4VK8nBNB6RYTOMC
 zgLgW+FwVyeP7TqRIR+yHt+PVa1NAlQo0Wk4ZIrFRhH5oBsCCdCMwqoZaEXPiRNO8sI+TD
 wOTM9vLllhmZ10yIwdlfEqkqNmXNc/4D0ZJCNtD67jtPv4kuo3X59IXchmyKt70fZSroYc
 7mXlVgBQdimqwBmcXmcMcG5r6Yq6bYjtB5dcuJ1NBIpRXXr3EWvxHztylQX5Wg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 23/24] clk: clk-fixed-factor: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:52 +0100
Message-ID: <20250323160107.145749-24-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250323160107.145749-1-marex@denx.de>
References: <20250323160107.145749-1-marex@denx.de>
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
Cc: Adam Ford <aford173@gmail.com>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tim Harvey <tharvey@gateworks.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Cc: uboot-imx@nxp.com
---
V2: Rebase on u-boot/next with additional clock patches
---
 drivers/clk/clk-fixed-factor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
index ff61fb4d706..4eb8be728e6 100644
--- a/drivers/clk/clk-fixed-factor.c
+++ b/drivers/clk/clk-fixed-factor.c
@@ -56,7 +56,7 @@ struct clk *clk_hw_register_fixed_factor(struct udevice *dev,
 	clk->flags = flags;
 
 	ret = clk_register(clk, UBOOT_DM_CLK_IMX_FIXED_FACTOR, name,
-			   parent_name);
+			   clk_resolve_parent_clk(dev, parent_name));
 	if (ret) {
 		kfree(fix);
 		return ERR_PTR(ret);
-- 
2.47.2

