Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0490CC021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9F4B80FA4;
	Sat, 22 Feb 2025 21:36:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kGU0Z3y9";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="a5UJZvSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5A64806FE; Sat, 22 Feb 2025 21:36:01 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4E5280F3F
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:35:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z0f0H3Hntz9sTc;
 Sat, 22 Feb 2025 21:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5qjNgdxBIlSSRzwuWUwi81FTDCZ8bSyYK4zzXHmoYs=;
 b=kGU0Z3y9JyYx80NIrNgHxS4HPOnF88tWm8pYMooa3RQSjRwLBnwwPHmHRAKRmso+knLKwT
 uDmjxzwJa4AOxVA6L+vHORD8K9oEHTq36E4XTlopKzUnCAVZsShWL4SpS4CiXDFti5wvL2
 nFGQw8gUrS006JG0tfcjuQWtNXt0NWIdAXdzmSw89lcN4S6egBJe6HlY+MAqBmwQp3FBrw
 aVYa5h/ap0WAwjaI1QihfC8T34OQPfu7C2kzZKJLawCByCnjf4GnBCNkPNS/z/uJBXp9J1
 tarZicT+tt5oWLo2bKXMmty17+mPVUHvXOFW7QG03OZDTopBSZ/6mmVLBQtAlA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5qjNgdxBIlSSRzwuWUwi81FTDCZ8bSyYK4zzXHmoYs=;
 b=a5UJZvSLYj0dfXE+b5ulxW4ry7cr7RUH/4dCvW+ViOXEHct1edXnDI57Z6Al+immr8gyXN
 HkCVOZugdaXtABeRfEAdiOTItlgHkj7fziBcuOjRk2hUTNdJ8PrXr/zT+iyQcm0OfrE+z3
 nxM+jBgEZgAGwB4d4fyO8g5m9jY87SilbzQgOI6mHRyVWUR6tFW1fSGiURYX9SQwMXQmVQ
 Y2dig/8gHLXMZEJNQbKuC08D8I5XMiA5H1DcyRJw8mFdl9/b8iDp135xeEzEWJ7yH7RjXB
 bg57sBto2gxDSsEZVRrD9FoUXsuYGcqhOXk6YN1J3NjQE4DnVMi164JVlbecZA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jim Liu <JJLIU0@nuvoton.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/23] net: sh_eth: Drop empty init callback
Date: Sat, 22 Feb 2025 21:33:12 +0100
Message-ID: <20250222203511.195437-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 39658930681b54e2a65
X-MBO-RS-META: f6t3oxbj3fkxqtt5d89qyx7z57kpcnz5
X-Rspamd-Queue-Id: 4Z0f0H3Hntz9sTc
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

The init function does nothing, the bb_miiphy_init() already checks
whether the .init callback is assigned, and if not, skips calling it.
Remove the empty init function. The entire init callback will be
removed in follow up patches.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Jim Liu <JJLIU0@nuvoton.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Drop the = NULL assignment early in here.
V3: Add RB from Paul
---
 drivers/net/sh_eth.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index f1ce994cfd5..b607b9a3a43 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -777,11 +777,6 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 };
 
 /******* for bb_miiphy *******/
-static int sh_eth_bb_init(struct bb_miiphy_bus *bus)
-{
-	return 0;
-}
-
 static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
 {
 	struct sh_eth_dev *eth = bus->priv;
@@ -852,7 +847,6 @@ static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "sh_eth",
-		.init		= sh_eth_bb_init,
 		.mdio_active	= sh_eth_bb_mdio_active,
 		.mdio_tristate	= sh_eth_bb_mdio_tristate,
 		.set_mdio	= sh_eth_bb_set_mdio,
-- 
2.47.2

