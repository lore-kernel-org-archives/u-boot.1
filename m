Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D16C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A493681273;
	Sun,  2 Mar 2025 02:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="awl0D3G7";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="GaleyAiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21CC58058A; Sun,  2 Mar 2025 02:28:37 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A7CD806FC
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Z548c0J6gz9ssS;
 Sun,  2 Mar 2025 02:28:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RkpzoYKAf9jRJ9nSOE4XlLtmG6yWbp4WkRzgBW46OU=;
 b=awl0D3G7N3URVq9wi2gRm/nngDDaJa3WjbWTx48ii94QTnK1WVo37P8E7EbFLypgPnYvlr
 61Fff79ao4wNVepEbMXt+n7+fHud42Ug3++kkXvfRZBQSKnwz4Bd5J+pTmnXQiBW9v1pZP
 AMGTgr2iYa7ykUdo1MEnFyXj5MnpEeeYshZfmAuHFAbOzRHzjH+EHflGG6AiwIkbnDg58z
 H0RjHAr+EdSRQQh6HrMH7ov1Nv8j8Ny/WYFC9fDg2Wdw6ZLkvrqBe8m0kiaZdHf7cjw4/T
 czNq9sP1pn62rXFGW7JT4nr6gJm2Wiw6II+m36Wg4sUILFFg0PwvM4TjhWjZmg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/RkpzoYKAf9jRJ9nSOE4XlLtmG6yWbp4WkRzgBW46OU=;
 b=GaleyAiuq4lSNOf0O0OAJLG8lvAK3iOR5baC4MrAX1wdY96APumKqxK+BAcRzPD0gMJRuc
 g6QMmNjUn6Ck7T535FJqvrTYiJwUPqSMHOpQhad4bC5+NMq3e7M9IUDcZc4TL7I8GJMIFi
 PpyTy1qKOfDR51pu1KAXCF6gOcaghBhsYJrbp9+NYF6dcH83EJnWWeWGrExvkc+Wg+0cSO
 fxU1mlN3GVnZANEfwyjsLXNLpLVzexUHzpRMiY3vzVoaIVaAD5/xLZwQ44vcqziw/tZDRI
 ps+k/zhq50maWO+4PD/EINlcfe2KHtfhmaLMLFSXfJQjzIlAABMU6xQwtiA3qQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/11] net: miiphybb: Drop priv from struct bb_miiphy_bus
Date: Sun,  2 Mar 2025 02:24:46 +0100
Message-ID: <20250302012752.393608-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: k1ceeasssdq9jkp6b665o6nyahyhdddp
X-MBO-RS-ID: acc1772a13f4fa16493
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

Remove the priv member from struct bb_miiphy_bus and its assignment
from drivers. This turns struct bb_miiphy_bus int struct mii_dev
wrapper, to be cleaned up next.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Jim Liu <jim.t90615@gmail.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Michael Chang <zhang971090220@gmail.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Parvathi Bhogaraju <pbhogaraju@microsoft.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/gdsys/a38x/ihs_phys.c | 3 ---
 drivers/net/ravb.c          | 3 ---
 drivers/net/sh_eth.c        | 3 ---
 include/miiphy.h            | 1 -
 4 files changed, 10 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 86a4049238b..7aa427e0312 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -257,9 +257,6 @@ int register_miiphy_bus(uint k, struct mii_dev **bus)
 	mdiodev->write = mii_bb_miiphy_write;
 	mdiodev->priv = &gpio_mii_set[k];
 
-	/* Copy the bus accessors and private data */
-	bb_miiphy->priv = &gpio_mii_set[k];
-
 	retval = mdio_register(mdiodev);
 	if (retval < 0)
 		return retval;
diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 52547b27aff..dcd8ba9283f 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -601,9 +601,6 @@ static int ravb_probe(struct udevice *dev)
 	mdiodev->priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), dev->name);
 
-	/* Copy the bus accessors and private data */
-	bb_miiphy->priv = eth;
-
 	ret = mdio_register(mdiodev);
 	if (ret < 0)
 		goto err_mdio_register;
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index c898a2204d8..c2e2f3fc6c6 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -763,9 +763,6 @@ static int sh_ether_probe(struct udevice *udev)
 	mdiodev->priv = eth;
 	snprintf(mdiodev->name, sizeof(mdiodev->name), udev->name);
 
-	/* Copy the bus accessors and private data */
-	bb_miiphy->priv = eth;
-
 	ret = mdio_register(mdiodev);
 	if (ret < 0)
 		goto err_mdio_register;
diff --git a/include/miiphy.h b/include/miiphy.h
index c9128a641dd..097c46c27bf 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -76,7 +76,6 @@ struct bb_miiphy_bus_ops {
 };
 
 struct bb_miiphy_bus {
-	void *priv;
 	struct mii_dev mii;
 };
 
-- 
2.47.2

