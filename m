Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008CFCD1288
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 14:32:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C34888233;
	Wed,  3 Apr 2024 16:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qb6hsrzJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4321388240; Wed,  3 Apr 2024 16:32:18 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A9E88822A
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 16:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9701DCE2AFD;
 Wed,  3 Apr 2024 14:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F33C43390;
 Wed,  3 Apr 2024 14:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712154730;
 bh=5ud4eBPXr9zqi9MgqNmN7yOeF4CccfbYspqHkN3Xb1Q=;
 h=From:To:Cc:Subject:Date:From;
 b=qb6hsrzJDJilL0wFnCv8/QRV7uHmyJ9U0d8YUQAIg4ou9kycbQuDOFC5BIzvA88ZG
 ElrDuR9AWyp2cw5x5fXbyO9DLdqBfAJZIaJA/Zt2ho2G2nQrMUKuwpYtMqXmIsk0wx
 32PvGPk98q7d57qaU7veJsoeXOWNI7rdZMXKsEboZO7JtRreAZhRejCtYWFEm+tUw1
 9SoJw189QF1xI2M0SuuZXljpoVaBfvu7JDpgh3u8kHOa8icPJXnZzUvi+5+5I4N4FO
 twr60MMDRBUciezKPf3ZoCpXBFpWf4NGL6so0z2VwnLeT3LTLGpkDKNCpPgQmlO7Cr
 IDZ7TA1vHN/Ag==
From: Michael Walle <mwalle@kernel.org>
To: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH] net: ti: am65-cpsw: Fix buffer overflow
Date: Wed,  3 Apr 2024 16:31:55 +0200
Message-Id: <20240403143155.3995102-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The device name is a concatenation of the device node name of the cpsw
device and of the device node name of the port. In my case that is

  ethernet@8000000
  port@1

First the buffer is really too small, but more importantly, there is no
boundary check. Use snprintf() and increase the buffer size.

Fixes: 38922b1f4acc ("net: ti: am65-cpsw: Add support for multi port independent MAC mode")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/ti/am65-cpsw-nuss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ti/am65-cpsw-nuss.c b/drivers/net/ti/am65-cpsw-nuss.c
index d68ed671836..b151e25d6a4 100644
--- a/drivers/net/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ti/am65-cpsw-nuss.c
@@ -664,7 +664,7 @@ static int am65_cpsw_port_probe(struct udevice *dev)
 	struct am65_cpsw_priv *priv = dev_get_priv(dev);
 	struct eth_pdata *pdata = dev_get_plat(dev);
 	struct am65_cpsw_common *cpsw_common;
-	char portname[15];
+	char portname[32];
 	int ret;
 
 	priv->dev = dev;
@@ -672,7 +672,7 @@ static int am65_cpsw_port_probe(struct udevice *dev)
 	cpsw_common = dev_get_priv(dev->parent);
 	priv->cpsw_common = cpsw_common;
 
-	sprintf(portname, "%s%s", dev->parent->name, dev->name);
+	snprintf(portname, sizeof(portname), "%s%s", dev->parent->name, dev->name);
 	device_set_name(dev, portname);
 
 	ret = am65_cpsw_ofdata_parse_phy(dev);
-- 
2.39.2

