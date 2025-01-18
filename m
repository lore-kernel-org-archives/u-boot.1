Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C81CAC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE9D980756;
	Sat, 18 Jan 2025 07:54:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="M9j7hTd5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="BueOEZ5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9731807B1; Sat, 18 Jan 2025 07:54:36 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90E780312
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4YZnQf2bw0z9sTM;
 Sat, 18 Jan 2025 07:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Eq3AFeiYsqRUpOA214yZxQVLfyghgGY6wl8TmGyCwc=;
 b=M9j7hTd5eDiIUevQf4YwmISi3e1Pk9VzKMxim7YCjkUr99jA7znBakUwStTC+gt1bY3pOM
 ui+Nhrkkhfdh2kNhX3DWxrlikM9pGW1Aopo1qdRrqiOr0ljoPSEb6RWMhD7bUFhVya+6ND
 aH6q7+oAG+7isM+f0+8VWXFFwt2F8Ar/8vkjSHliMkAPBNrHhUjm0zpwamCJUy8o341rP1
 JLoEzA/pDlspCi9sPfKfzEyiLG1pjQbGm1aP5KRaGU41lqFtTqTU9qzXrzj4LbsgU4Vc5B
 F/LEEAOysZOjbQrGY3+T7UnsNB6qISQ9xDJn/zW6ajIDNZyTGYdkKaKvX+BgXw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Eq3AFeiYsqRUpOA214yZxQVLfyghgGY6wl8TmGyCwc=;
 b=BueOEZ5tsrw0ZZXfMDUTWCrDMIe2msC5BynIDN0Yk6o/tW+Fam+03TUbD7XvWjCqUDo02Q
 jt5gLhGd/oPAWuJ4ui3EjvlsYGNzgEil8lFSqzrl6scvMznFODdeeydHeMKgj2qSKg2ayw
 GqfnxX1jdNqnO/+G91eAYucI/VtK3w1KcVVSS9k6PpQk0YWw18+14nGuTuX/ZC+WAKjv9j
 O3Whj2K3i7YTnzSKuyJIHyNEXlI94enfaovg0tpmoyvxZ7wvRAJNOQ0Z7mfBNUJYZdgZd6
 W8KDdfBUnE5ziThjBEoCHJqOWDkR1XuzZ56Lglx4VR8yLJl8H2snTw68Mj6h1Q==
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
Subject: [PATCH 04/17] net: sh_eth: Reorder bb_miiphy functions
Date: Sat, 18 Jan 2025 07:53:08 +0100
Message-ID: <20250118065402.172253-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4796f216f401dd45ec9
X-MBO-RS-META: 9jwt7y33mqubcg4471m3k99z3bua9o5a
X-Rspamd-Queue-Id: 4YZnQf2bw0z9sTM
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
 drivers/net/sh_eth.c | 136 +++++++++++++++++++++----------------------
 1 file changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 8654f1b8085..45dc79c4309 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -643,6 +643,74 @@ static void sh_ether_stop(struct udevice *dev)
 	sh_eth_stop(&priv->shdev);
 }
 
+/******* for bb_miiphy *******/
+static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	sh_eth_write(port_info, sh_eth_read(port_info, PIR) | PIR_MMD, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	sh_eth_write(port_info, sh_eth_read(port_info, PIR) & ~PIR_MMD, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	if (v)
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) | PIR_MDO, PIR);
+	else
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) & ~PIR_MDO, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	*v = (sh_eth_read(port_info, PIR) & PIR_MDI) >> 3;
+
+	return 0;
+}
+
+static int sh_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
+{
+	struct sh_eth_dev *eth = bus->priv;
+	struct sh_eth_info *port_info = &eth->port_info[eth->port];
+
+	if (v)
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) | PIR_MDC, PIR);
+	else
+		sh_eth_write(port_info,
+			     sh_eth_read(port_info, PIR) & ~PIR_MDC, PIR);
+
+	return 0;
+}
+
+static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
+{
+	udelay(10);
+
+	return 0;
+}
+
 static int sh_ether_probe(struct udevice *udev)
 {
 	struct eth_pdata *pdata = dev_get_plat(udev);
@@ -776,74 +844,6 @@ U_BOOT_DRIVER(eth_sh_ether) = {
 	.flags		= DM_FLAG_ALLOC_PRIV_DMA,
 };
 
-/******* for bb_miiphy *******/
-static int sh_eth_bb_mdio_active(struct bb_miiphy_bus *bus)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	sh_eth_write(port_info, sh_eth_read(port_info, PIR) | PIR_MMD, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_mdio_tristate(struct bb_miiphy_bus *bus)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	sh_eth_write(port_info, sh_eth_read(port_info, PIR) & ~PIR_MMD, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_set_mdio(struct bb_miiphy_bus *bus, int v)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	if (v)
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) | PIR_MDO, PIR);
-	else
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) & ~PIR_MDO, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_get_mdio(struct bb_miiphy_bus *bus, int *v)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	*v = (sh_eth_read(port_info, PIR) & PIR_MDI) >> 3;
-
-	return 0;
-}
-
-static int sh_eth_bb_set_mdc(struct bb_miiphy_bus *bus, int v)
-{
-	struct sh_eth_dev *eth = bus->priv;
-	struct sh_eth_info *port_info = &eth->port_info[eth->port];
-
-	if (v)
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) | PIR_MDC, PIR);
-	else
-		sh_eth_write(port_info,
-			     sh_eth_read(port_info, PIR) & ~PIR_MDC, PIR);
-
-	return 0;
-}
-
-static int sh_eth_bb_delay(struct bb_miiphy_bus *bus)
-{
-	udelay(10);
-
-	return 0;
-}
-
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name		= "sh_eth",
-- 
2.45.2

