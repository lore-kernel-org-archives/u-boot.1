Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43245C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 05:26:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BD9E87AD8;
	Tue, 31 Oct 2023 06:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="BW5JTEGh";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EijmZmqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D637387ADD; Tue, 31 Oct 2023 06:25:59 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3E0187AB6
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:25:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 9BD6932009E1;
 Tue, 31 Oct 2023 01:25:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Tue, 31 Oct 2023 01:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm1; t=1698729955; x=1698816355; bh=Fl49moqFX5
 4cYtUM7dlAQml5qwlxh9mv72oeUC5/e04=; b=BW5JTEGh4SJ5JBOEa1xQu1XkAm
 +oT5DLjBFufdUuVYCbCOJwUXr138LC05+vKyc1jHZ88fi281jELfBU9PutkUN24/
 4DLsnVu2AaFqbnISxpK4u5M1sQK9IwZSLvC01+gZhh0atZ61yybIU0KR+xrhymQ/
 BsX6Ce4KurAwP5OnfYBNtHnhsuBocZprCOdiZFS+j0ytWYY38/SmOboaAlhJMq0H
 j7dnJgP7b5CSTjiJOBhz1kO7TIbHV2tjTwchY1S9nH/u8aNyoxT+AeOuT8o/XFkD
 xezwwCFxrnEmQEP3hQTHnRxS+4s3PvNpcsPGF5m94q+xOk/sSuzvZLxDqIMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1698729955; x=1698816355; bh=Fl49moqFX54cY
 tUM7dlAQml5qwlxh9mv72oeUC5/e04=; b=EijmZmqoHWQmDzlGQavki+iNkPeUF
 oj67Og6a8/GhpPeY6QZW0Yi+xqjUrW4oWSDc9SiAOI+niS1ig/+7wavoc+oTdiCK
 ANsO+Png5LUDVVm62OQvxBqHEZmOMupzsLZH0/vVzsDCa8ZIZ9cxM+dHw8hGKYrk
 mdO1HHi5yUxn5SdGHZDf7I9VKvNbor4J3QQgdZzQ3P3+eDmZxek+f+H6gpXIsby5
 IyxuaYp/RUrV8r6ABlYS9p/2A1CmOaIagTF6CEcV+kXltBQlfCkUOhTKoNBMjDzv
 PtcK80jBTYu7cnKWeLbCFZgUCa6VvhtPA757QjrvbpsiPHcYMvbXQuSOg==
X-ME-Sender: <xms:449AZX369t94dcaJ3LM4ESwq99QX2w-QBXbzo5YSHCn8h3Qn7J0ONg>
 <xme:449AZWERZ9ofgqJqCl1g_7KwcTHfn7Mt4x05V9GWBIwpF5AU7NcrHUqAQRwKbzAxF
 dhwMO4Z9y0ek6oq8w>
X-ME-Received: <xmr:449AZX7kS7LVlK1-Xmp3LXiezH-QR7Hjvfi9s1fMxHo88XJAJRP9Vgbi_fraMEMdsAMv-YKlBTwjlN1wQjW1AnwhmpemZkMn0BvutrSdyG1ArnPvZO4pOqG7wwLjs24zWLrR2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgkedtucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
 ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
 grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
 hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:449AZc3ppEbMvMjGv4GIWNTqkyZ4wrRECkon28cTKa67ici2Qkmktw>
 <xmx:449AZaF-hcnmT2E-3uWoE4s3cGWCZYM6igW4IhuaHrPL_qgQ5k78ew>
 <xmx:449AZd8s7phaLzpyW2n3h-hVVtbIjjSzcy42iN1G1IC_P4czj0YGDQ>
 <xmx:449AZWiLvy1D9yTBPFb-qf0XIOm-TM-b--Zq1spUSzEOMoG8q19PRA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 01:25:54 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Subject: [PATCH] net: sun8i_emac: Drop DM_GPIO checks
Date: Tue, 31 Oct 2023 00:25:46 -0500
Message-ID: <20231031052554.63319-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
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

DM_GPIO is always enable in U-Boot proper for ARCH_SUNXI, and this
driver is never enabled in SPL, so the condition is always true.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/net/sun8i_emac.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 4ba9ee1529e..a12f7e32e8f 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -168,9 +168,7 @@ struct emac_eth_dev {
 	struct clk ephy_clk;
 	struct reset_ctl tx_rst;
 	struct reset_ctl ephy_rst;
-#if CONFIG_IS_ENABLED(DM_GPIO)
 	struct gpio_desc reset_gpio;
-#endif
 	struct udevice *phy_reg;
 };
 
@@ -617,7 +615,6 @@ err_tx_clk:
 	return ret;
 }
 
-#if CONFIG_IS_ENABLED(DM_GPIO)
 static int sun8i_mdio_reset(struct mii_dev *bus)
 {
 	struct udevice *dev = bus->priv;
@@ -649,7 +646,6 @@ static int sun8i_mdio_reset(struct mii_dev *bus)
 
 	return 0;
 }
-#endif
 
 static int sun8i_mdio_init(const char *name, struct udevice *priv)
 {
@@ -664,9 +660,7 @@ static int sun8i_mdio_init(const char *name, struct udevice *priv)
 	bus->write = sun8i_mdio_write;
 	snprintf(bus->name, sizeof(bus->name), name);
 	bus->priv = (void *)priv;
-#if CONFIG_IS_ENABLED(DM_GPIO)
 	bus->reset = sun8i_mdio_reset;
-#endif
 
 	return  mdio_register(bus);
 }
@@ -783,9 +777,7 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
 	const fdt32_t *reg;
 	int node = dev_of_offset(dev);
 	int offset = 0;
-#if CONFIG_IS_ENABLED(DM_GPIO)
 	int reset_flags = GPIOD_IS_OUT;
-#endif
 	int ret;
 
 	pdata->iobase = dev_read_addr(dev);
@@ -872,7 +864,6 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
 		printf("%s: Invalid RX delay value %d\n", __func__,
 		       sun8i_pdata->rx_delay_ps);
 
-#if CONFIG_IS_ENABLED(DM_GPIO)
 	if (fdtdec_get_bool(gd->fdt_blob, dev_of_offset(dev),
 			    "snps,reset-active-low"))
 		reset_flags |= GPIOD_ACTIVE_LOW;
@@ -887,7 +878,6 @@ static int sun8i_emac_eth_of_to_plat(struct udevice *dev)
 	} else if (ret == -ENOENT) {
 		ret = 0;
 	}
-#endif
 
 	return 0;
 }
-- 
2.41.0

