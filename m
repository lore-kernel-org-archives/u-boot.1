Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E2F3C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF7080F88;
	Sat, 22 Feb 2025 21:36:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="fpdpCO+a";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZdhaHtZx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610A680FBC; Sat, 22 Feb 2025 21:36:07 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1541B80FAA
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Z0f0M5djKz9tSh;
 Sat, 22 Feb 2025 21:36:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQBh8YKEFE1ni+oD/+dr5uV5+AJgGSDDyfUu+7ExyTo=;
 b=fpdpCO+awps6wSeqAn7Pjfvt6asZVL6t01lpArPSwHVrtS8u5sxebxQmKioFBE4dsYQ9ib
 hK32AyZiZ6+R0xcdoPkbwPGpfWfnTY3hGTRy0EAwNi0WDv9h2KXFAu7QOE9XTmYB/d8WCH
 BotgfyYTKd+YHqwdnLKxa/UZo5QaGXSq9zm5ZXj+QtinI3gKVAiq9CAbnlOn6VWeEKfDrM
 ZD0GjHJXVsYGgmLsVnF6sZM9sP7Zt2c6+Vmhe4EsUtUWCusEknX0dD6ituDEC4SuSmnWqB
 9tw8WoZypAyleiTE+eTWlO/gJqxoLexQhsbGDjuaWaw8EmsAzKs6/w/E5oTEQg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iQBh8YKEFE1ni+oD/+dr5uV5+AJgGSDDyfUu+7ExyTo=;
 b=ZdhaHtZxCS2L84oRt6dGMTHa6xjgPDzXa8g3d9p6qHrnDwH+/sq2VRFo1fjfsqqyhMM/6k
 iT0JBdDDBScuup7Psp9Q2/ML9MpP7BJCLPRUqx3SequAXjaberNWHWyaSyFPNjjXG0H1Kk
 CGArOopAjoq55CuhCGuKvmja1HiDNs4Ax3tCHyRziaVDyCRfHMT5w1D5PJvjDtRrF24OH9
 fXhtPOkO93+6jks3krIXOf/5m7vxQjaSVYKA1B/dMiLMzw1mV4oZcZwJW1+QvngaoLo6Ow
 iOmGeLjLpD2rz69Uki7DaN1v9Tu6CHLKDNgseUbV3G2CwVcW/T3h/TRjR45OvQ==
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
Subject: [PATCH v3 04/23] net: ravb: Reorder bb_miiphy functions
Date: Sat, 22 Feb 2025 21:33:14 +0100
Message-ID: <20250222203511.195437-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: sjag6bffyxqzxoybq7byq9xdgt3zk1ey
X-MBO-RS-ID: 1065981969ad3aa1337
X-Rspamd-Queue-Id: 4Z0f0M5djKz9tSh
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
V2: No change
V3: Add RB from Paul
---
 drivers/net/ravb.c | 117 +++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/net/ravb.c b/drivers/net/ravb.c
index 5df557da7da..381cf250ea2 100644
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
2.47.2

