Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486F8C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD1B81F74;
	Wed, 19 Mar 2025 04:19:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742354385;
	bh=ffYzXJrzb4h06t6CDnmA1NyQiPzoqanDDvvtGVR2Kdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jpN8iKfs1Z2C8lTpkRUEMxR6rHx6GiSGDdBz5p9orAkZ7PgKPmyk56dJmVinuzWTT
	 lZ6Ef9IZfLtWRryEIXZfIvM2jBqjg1RWVp7jFAQd4TVTLEfVpRk5M3pFj1GUcNWbay
	 8rWaZAdY50Yy4vHjMzxkggmMvNbpNeRPhQjWI1EebzeaOo4lbMszbGYvnccvVQEWw/
	 PKyyNCrGb/0XLsSV11XIsd1ger6YbiRTkucHNvraZyTq/00hmln30DxEpRXeSVQX2+
	 K2MP0y4vYWcBAiVi5ifS8l+4qNkuX1Rj7H99+3SMV7/25s6K/fwlRGkxW+w9jOo1or
	 dfQnT6skir/JA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC7DF81FE6; Wed, 19 Mar 2025 04:19:41 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4F1481026
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ZrPNQV7O"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 61295101E91C4; Wed, 19 Mar 2025 04:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742354379; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ffYzXJrzb4h06t6CDnmA1NyQiPzoqanDDvvtGVR2Kdg=;
 b=ZrPNQV7OV7Yv+2JprV2JG9Tb1jMGhNTQPuhNOB23vjZcgDjp9pgp3dbC3R2VGeXTKRMFGM
 TiQzzx5qhUb/Kx2VhasD7A0qkCqb9vWjfMcDgCYcx5XGqXM4AqkV6HKU+PyDZ/VQRS2Krj
 o9LuwrLuTvjClH5gtRTXdjsJ14N/lRB3tBlFePbPK9EdTQo3AfKeWUPvKoLvN5SL8cuvMn
 r+SAlafF//dXTk9pfeq/k7ivcK0VAPq+hA8OLRaJj7y1PlDnNdqthvaO4L8fh1Szt47GbZ
 tUVdgXRybMm/0YjRp3PAdhv/hCPjadPLaJgh3pYiGYgA/bs5697C3Td4oUstpw==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 Dong Aisheng <aisheng.dong@nxp.com>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peng Fan <peng.fan@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, uboot-imx@nxp.com
Subject: [PATCH 23/24] clk: clk-fixed-factor: Resolve parent clock by name
Date: Wed, 19 Mar 2025 04:17:33 +0100
Message-ID: <20250319031852.233537-24-marex@denx.de>
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

