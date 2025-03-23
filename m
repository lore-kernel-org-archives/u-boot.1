Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6142EC36005
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 16:04:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7A3A82160;
	Sun, 23 Mar 2025 17:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742745730;
	bh=j25Cvjpl3pyYGecR3ZpUWH8k8+zj6iy717itEC8tQpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0PVhi7CRJiOpl7FP6udsuJ3tFLhbigWEldT2ink1Pgi9CgTc5Be0Ve9TvOW25eOVn
	 ME8CCruMdUCNDwmEnsIPVkqt6HzONbBB4BclS2CdQJnxSrrO9cqOkKbUW+gZQ9oBPF
	 EfIvqJK8dRkA/MXFpXUm+dPIAA5NX9yHOadadgpFsrDJW9yk6qP4Y0E57KkVY+1Vz5
	 7q6xEJAT2y/0krmyad+gUf01fgw3tU0I6P7o2w0niVltPWgV4mBsFsAElLcIkdRZqC
	 ZtMjbQIU3B54TbS6R1gIgGjNZAaEifwNBbdq4fxGFk1KPokNxA71TVj3bO8d3/lNe1
	 uHTxXfYjkm2Zw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F52482107; Sun, 23 Mar 2025 17:02:09 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 280DA82114
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 17:02:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Yq1yE1PI"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id CDA791029024F; Sun, 23 Mar 2025 17:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742745726; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=j25Cvjpl3pyYGecR3ZpUWH8k8+zj6iy717itEC8tQpo=;
 b=Yq1yE1PI2f9HB/WIxItkJ+MYjeBi/RUGVQaUW1H71CkGTm31WCaU2cetpx/WfwgMCg0Uno
 XXeKbJcMd1YJqI2jriNbXOMd9W00B8+ExCOiMcYxynMj5n7vS1yPsPFwpNHnAuv6DEf2ff
 pk2mfzTldxwL6x92E6g8K5+sJ0NL7M10iJBEZAf9G0vqDh1/13crbNFpof6zEw4Yxa5grC
 8vlnVj6qGwiVhozlHq/gElpeVtCMpY0mvmOfbxfmJf/riMafFfQmCmKGwvB3hkp683YoKk
 Tmem4CRAGEnCpyehN9Ii/XvZwyXL9UFJBe5YDbsH0cHdFoFSG/0TsSf9dsFnGg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Adam Ford <aford173@gmail.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@denx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH v2 14/24] clk: clk-composite: Resolve parent clock by name
Date: Sun, 23 Mar 2025 16:58:43 +0100
Message-ID: <20250323160107.145749-15-marex@denx.de>
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
 drivers/clk/clk-composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 1191bdf87df..9e3b5191767 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -149,7 +149,7 @@ struct clk *clk_register_composite(struct udevice *dev, const char *name,
 	clk = &composite->clk;
 	clk->flags = flags;
 	ret = clk_register(clk, UBOOT_DM_CLK_COMPOSITE, name,
-			   parent_names[clk_composite_get_parent(clk)]);
+		clk_resolve_parent_clk(dev, parent_names[clk_composite_get_parent(clk)]));
 	if (ret) {
 		clk = ERR_PTR(ret);
 		goto err;
-- 
2.47.2

