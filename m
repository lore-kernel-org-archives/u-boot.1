Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BCC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 975DE80792;
	Sat, 18 Jan 2025 07:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="VzabcJ3S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="j61P7beT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A379D80778; Sat, 18 Jan 2025 07:54:34 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B19B80312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4YZnQc2Nydz9sqH;
 Sat, 18 Jan 2025 07:54:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTxZhd02bILZp/SxXbYFRTOJRcLffxE/yefpawez+7U=;
 b=VzabcJ3SgalZvZcMHRJoWh8lCRB0L+RVcbz+CBro77U66QK58ROEsrRFIPLm39SoNWBZd3
 9tZoeoI0jbM1D8CSU2gzd70h7G6a8GhPqgVtjNE+5KAIKVZsLA1pdvi8CBPoEcwCFkXtNg
 dgJKXELGl4+c+Lu5QAZJ94cSR0wUMRnxDK+KVKONuGdXr8ZV3ww2AzBdIof+8KYvJiPzuG
 UCGwf9ZviSDi+aVuduNZEcQFblOoGwatKiFMzcuiJtaDbw558QYV5DafpBkLINKItkHQZf
 RQWzYkX3O4Tm7seJXNZQ2RGr1iMADc2cMyuYuyW60YVdWP6fSWz43/Fvx4kr/A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iTxZhd02bILZp/SxXbYFRTOJRcLffxE/yefpawez+7U=;
 b=j61P7beTGl0BLx6517KHy6+OwaA28Lf3idESoD/IEE8B+X0P3aRT/52rAXXiWL92HOLMKf
 92rS5vT/Rfu+CMdolgYiF8CzwbKn4hRMR6SavSzc+7kA2F4YpAddKQxnnxQiR8unxrVdGB
 VqA4DBaJEZ5y++GLVp7SM8l3kmIWrRw6HZmJkDePI9YlcLg5lENxScJmsBCX+TNDALCAd0
 873hpSPvmIwmpXkKrgNolt9C/ynrFz2sywwTVXf+13xYVv4uqnBN3rIx8KL+6mfzBFWURz
 mJH+8tpblNEeWub2fnhY/zt47EwBClgY0Mi93gMYh7wAA4mG1Jt3qDXbjMcYtA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Mario Six <mario.six@gdsys.cc>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/17] net: ravb: Reorder bb_miiphy functions
Date: Sat, 18 Jan 2025 07:53:07 +0100
Message-ID: <20250118065402.172253-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 792980f555d58283f08
X-MBO-RS-META: fni9swe1hbkzje8tacedxf17ssbqi648
X-Rspamd-Queue-Id: 4YZnQc2Nydz9sqH
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

Move the bb_miiphy functions before MDIO registration. This is a
preparatory patch, the functions will be referenced around the MDIO
registration in the follow up patches. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Evgeny Bachinin <EABachinin@salutedevices.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome.forissier@linaro.org>
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
 drivers/net/ravb.c | 117 +++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index f9c27f0f370..6e4baff658f 100644
--- a/drivers/net/ravb.c
+++ b/drivers/net/ravb.c
@@ -490,6 +490,65 @@ static void ravb_stop(struct udevice *dev)
 	ravb_reset(dev);
 }
 
+/* Bitbang MDIO access */
+static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
+
+	return 0;
+}
+
+static int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
+
+	return 0;
+}
+
+static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	if (v)
+		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
+	else
+		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
+
+	return 0;
+}
+
+static int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	*v = (readl(eth->iobase + RAVB_REG_PIR) & PIR_MDI) >> 3;
+
+	return 0;
+}
+
+static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+{
+	struct ravb_priv *eth = bus->priv;
+
+	if (v)
+		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
+	else
+		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
+
+	return 0;
+}
+
+static int ravb_bb_delay(struct bb_miiphy_bus *bus)
+{
+	udelay(10);
+
+	return 0;
+}
+
 static int ravb_probe(struct udevice *dev)
 {
 	struct eth_pdata *pdata = dev_get_plat(dev);
@@ -560,64 +619,6 @@ static int ravb_remove(struct udevice *dev)
 	return 0;
 }
 
-static int ravb_bb_mdio_active(struct bb_miiphy_bus *bus)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
-
-	return 0;
-}
-
-static int ravb_bb_mdio_tristate(struct bb_miiphy_bus *bus)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MMD);
-
-	return 0;
-}
-
-static int ravb_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	if (v)
-		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
-	else
-		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDO);
-
-	return 0;
-}
-
-static int ravb_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	*v = (readl(eth->iobase + RAVB_REG_PIR) & PIR_MDI) >> 3;
-
-	return 0;
-}
-
-static int ravb_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
-{
-	struct ravb_priv *eth = bus->priv;
-
-	if (v)
-		setbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
-	else
-		clrbits_le32(eth->iobase + RAVB_REG_PIR, PIR_MDC);
-
-	return 0;
-}
-
-static int ravb_bb_delay(struct bb_miiphy_bus *bus)
-{
-	udelay(10);
-
-	return 0;
-}
-
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "ravb",
-- 
2.45.2

