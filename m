Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC7BCCF9EE
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 16:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DDBE8394A;
	Mon, 27 Oct 2025 17:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sXfqsdnt";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kSO2iF+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA1BD838FA; Mon, 27 Oct 2025 17:47:03 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4541838FA
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 17:47:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cwKD5490Jz9sW6;
 Mon, 27 Oct 2025 17:47:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NzNKFrVVcCVpa8jdj3iHdGygkrwV4dtIod94i/9xLg=;
 b=sXfqsdnt2qZn2oNtMgTNJsCMOzw24HDmI++6le5l4HdMHum6SmXE4Kxywd74VwcPwKZMnq
 fsv7WnVk1pxChac6GrftEXB1u0fohyfhAv46EDkBcRWkLvzM+1cyGH6WDlCpob9kuGJ75Q
 JHy4WIVqdsVgJMHdVs75/60iV9xgwBrNLTs3ubMWUJ/uGpskCPfG0CX4qnmVbtL5iiHD3Q
 Dcyfs0BlS/FJwrVib6ZQZgC2CDg5FAJvwr+04XPVk/sLafS82oziFsLYdZTBB4192Cjbow
 /QrhsKIx8q9jrVUdUaixAELNqwY5YCkZmmMUDiBUJBeKuoSEuSfArRp++E4o1g==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761583619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0NzNKFrVVcCVpa8jdj3iHdGygkrwV4dtIod94i/9xLg=;
 b=kSO2iF+byihmygXl1yqjXjPgVaQXh23SCbAPJ4m3hJAz2e0lx3NnN5KssqNu9AhFgL98Lf
 wTK7ijZKjrUewSER2IEQUDHXK7yrV2kRrwas3gqcLIL3068xb3GK1tuRfabcPzXwS5WsVd
 5WZuVgMxKBLezV63eUy1v25fb+1BqIoyZyFzBP5COMIHeLX/2TDgCDyk9mceQ2K90IFL37
 iuxHLz/rBzJln3js1bA8IHfvqrgy3NnY9ZNJAFjsjlRwSUV0A7i9qNd9u6CM0hlithB1Tg
 6ATb2BFYlcT9EGujLZOf5pkMEXzMggVQdsLuh/781srGX1aJKtEVnAyiWNxe0g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/12] net: rswitch: Use bulk clock operations
Date: Mon, 27 Oct 2025 17:45:34 +0100
Message-ID: <20251027164643.12443-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
References: <20251027164643.12443-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: emfoq6wixqezw4genpdcf5asjxkwxahf
X-MBO-RS-ID: a6b26866f3822cb3f83
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

The new version of RSwitch3 in Renesas R-Car Gen5 uses multiple
clock to supply the IP. Convert the driver to bulk clock API to
cater for both single clock of R-Car S4 and multiple clock of
R-Car Gen5. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/rswitch.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/rswitch.c b/drivers/net/rswitch.c
index f787aa4180d..3048db365db 100644
--- a/drivers/net/rswitch.c
+++ b/drivers/net/rswitch.c
@@ -272,7 +272,7 @@ struct rswitch_port_priv {
 
 struct rswitch_priv {
 	void __iomem		*addr;
-	struct clk		*rsw_clk;
+	struct clk_bulk		rsw_clk;
 };
 
 static inline void rswitch_flush_dcache(u32 addr, u32 len)
@@ -1101,13 +1101,11 @@ static int rswitch_probe(struct udevice *dev)
 	if (!priv->addr)
 		return -EINVAL;
 
-	priv->rsw_clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(priv->rsw_clk)) {
-		ret = PTR_ERR(priv->rsw_clk);
+	ret = clk_get_bulk(dev, &priv->rsw_clk);
+	if (ret < 0)
 		goto err_map;
-	}
 
-	ret = clk_prepare_enable(priv->rsw_clk);
+	ret = clk_enable_bulk(&priv->rsw_clk);
 	if (ret)
 		goto err_map;
 
@@ -1122,7 +1120,7 @@ static int rswitch_remove(struct udevice *dev)
 {
 	struct rswitch_priv *priv = dev_get_plat(dev);
 
-	clk_disable_unprepare(priv->rsw_clk);
+	clk_disable_bulk(&priv->rsw_clk);
 	unmap_physmem(priv->addr, MAP_NOCACHE);
 
 	return 0;
-- 
2.51.0

