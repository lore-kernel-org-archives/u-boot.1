Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC4CC02187
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 06:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376A280657;
	Sat, 18 Jan 2025 07:54:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aP/oaWeX";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y/a90Li4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03536807B1; Sat, 18 Jan 2025 07:54:39 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A493B8073D
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 07:54:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZnQh2tt2z9sbl;
 Sat, 18 Jan 2025 07:54:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI/fYPGBzPY3xgBynIgfcZQhzoJ1AmfwItKJbgtdCO4=;
 b=aP/oaWeXlP85Am14NqKrwE6oA0/TG6Fz2GRVrBlvjSeui3v6QjMwR4ecm6pujAz0Tuqy+f
 4/diiTZddQztDu1NoP+xZ99pHCkzm+RVwF6ZOY/WsVIPlri2vs5G59JKfVoOW0hr4vumLb
 E4yBKGxGpW2gxDVvOYfwvQyoN6TUhIO9xtAzd7jwHbowoCffwWLNV0X9UjHQpJhbVMC8gq
 yUSTBnAI0z6JspRAEUT5XEbTQ3XT/KzWaPlX/Z9G6vQOaUqHwJl9wBknOzTfNAfrQtEdWD
 Miy0wE/2sKoqQEAsFPZBMkvEdIGGQqJx7htbvVA/REo/9Oe6OmiFmDi0jVAokA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737183274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI/fYPGBzPY3xgBynIgfcZQhzoJ1AmfwItKJbgtdCO4=;
 b=Y/a90Li4mht3qSD45piOVWtA5RKeO3So7yz4gAiRc9lY9FWDjJqiSSDGOOTf/z6fNX/d7k
 NawXZC7a0akVux2YG3zfIwN9d9LDslP3hxKRhQ4rZKwHMvyvViWBFposCJXOtwadZsUnFD
 gLVzctKbVtwv8Xowwcq0kfr4KexkWftgULpZbpvj9xQJE6JJ2pgl9YUKj8juM2tVWjnDrs
 xaAy6qrNdDM/6W2guneYP1ZL5bttS4YlFe99pYFr6fm1jzobJc6C8Cgd3mbIKlmTjBj5N6
 Ht+9iPtU2AdBWnWiuC+d7ReazP6B0Fk3sT5NRpglebCRxrs3XSLyDX0ZsMbslw==
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
Subject: [PATCH 05/17] arm: mvebu: a38x: Reorder bb_miiphy functions
Date: Sat, 18 Jan 2025 07:53:09 +0100
Message-ID: <20250118065402.172253-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
References: <20250118065402.172253-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: b41oyzyyyebqxdyuq8dcjz443na1f7ps
X-MBO-RS-ID: 634978d1654e760c970
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
 board/gdsys/a38x/ihs_phys.c | 192 ++++++++++++++++++------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/board/gdsys/a38x/ihs_phys.c b/board/gdsys/a38x/ihs_phys.c
index 690a29690b9..3370a4fa1a3 100644
--- a/board/gdsys/a38x/ihs_phys.c
+++ b/board/gdsys/a38x/ihs_phys.c
@@ -102,102 +102,6 @@ uint calculate_octo_phy_mask(void)
 	return octo_phy_mask;
 }
 
-int register_miiphy_bus(uint k, struct mii_dev **bus)
-{
-	int retval;
-	struct mii_dev *mdiodev = mdio_alloc();
-	char *name = bb_miiphy_buses[k].name;
-
-	if (!mdiodev)
-		return -ENOMEM;
-	strlcpy(mdiodev->name, name, MDIO_NAME_LEN);
-	mdiodev->read = bb_miiphy_read;
-	mdiodev->write = bb_miiphy_write;
-
-	retval = mdio_register(mdiodev);
-	if (retval < 0)
-		return retval;
-	*bus = miiphy_get_dev_by_name(name);
-
-	return 0;
-}
-
-struct porttype *get_porttype(uint octo_phy_mask, uint k)
-{
-	uint octo_index = k * 4;
-
-	if (!k) {
-		if (octo_phy_mask & 0x01)
-			return &porttypes[PORTTYPE_MAIN_CAT];
-		else if (!(octo_phy_mask & 0x03))
-			return &porttypes[PORTTYPE_16C_16F];
-	} else {
-		if (octo_phy_mask & (1 << octo_index))
-			return &porttypes[PORTTYPE_TOP_CAT];
-	}
-
-	return NULL;
-}
-
-int init_single_phy(struct porttype *porttype, struct mii_dev *bus,
-		    uint bus_idx, uint m, uint phy_idx)
-{
-	struct phy_device *phydev;
-
-	phydev = phy_find_by_mask(bus, BIT(m * 8 + phy_idx));
-	printf(" %u", bus_idx * 32 + m * 8 + phy_idx);
-
-	if (!phydev)
-		puts("!");
-	else
-		ihs_phy_config(phydev, porttype->phy_invert_in_pol,
-			       porttype->phy_invert_out_pol);
-
-	return 0;
-}
-
-int init_octo_phys(uint octo_phy_mask)
-{
-	uint bus_idx;
-
-	/* there are up to four octo-phys on each mdio bus */
-	for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; ++bus_idx) {
-		uint m;
-		uint octo_index = bus_idx * 4;
-		struct mii_dev *bus = NULL;
-		struct porttype *porttype = NULL;
-		int ret;
-
-		porttype = get_porttype(octo_phy_mask, bus_idx);
-
-		if (!porttype)
-			continue;
-
-		for (m = 0; m < 4; ++m) {
-			uint phy_idx;
-
-			/**
-			 * Register a bus device if there is at least one phy
-			 * on the current bus
-			 */
-			if (!m && octo_phy_mask & (0xf << octo_index)) {
-				ret = register_miiphy_bus(bus_idx, &bus);
-				if (ret)
-					return ret;
-			}
-
-			if (!(octo_phy_mask & BIT(octo_index + m)))
-				continue;
-
-			for (phy_idx = 0; phy_idx < 8; ++phy_idx)
-				init_single_phy(porttype, bus, bus_idx, m,
-						phy_idx);
-		}
-	}
-
-	return 0;
-}
-
 /*
  * MII GPIO bitbang implementation
  * MDC MDIO bus
@@ -315,6 +219,102 @@ static int mii_delay(struct bb_miiphy_bus *bus)
 	return 0;
 }
 
+int register_miiphy_bus(uint k, struct mii_dev **bus)
+{
+	int retval;
+	struct mii_dev *mdiodev = mdio_alloc();
+	char *name = bb_miiphy_buses[k].name;
+
+	if (!mdiodev)
+		return -ENOMEM;
+	strlcpy(mdiodev->name, name, MDIO_NAME_LEN);
+	mdiodev->read = bb_miiphy_read;
+	mdiodev->write = bb_miiphy_write;
+
+	retval = mdio_register(mdiodev);
+	if (retval < 0)
+		return retval;
+	*bus = miiphy_get_dev_by_name(name);
+
+	return 0;
+}
+
+struct porttype *get_porttype(uint octo_phy_mask, uint k)
+{
+	uint octo_index = k * 4;
+
+	if (!k) {
+		if (octo_phy_mask & 0x01)
+			return &porttypes[PORTTYPE_MAIN_CAT];
+		else if (!(octo_phy_mask & 0x03))
+			return &porttypes[PORTTYPE_16C_16F];
+	} else {
+		if (octo_phy_mask & (1 << octo_index))
+			return &porttypes[PORTTYPE_TOP_CAT];
+	}
+
+	return NULL;
+}
+
+int init_single_phy(struct porttype *porttype, struct mii_dev *bus,
+		    uint bus_idx, uint m, uint phy_idx)
+{
+	struct phy_device *phydev;
+
+	phydev = phy_find_by_mask(bus, BIT(m * 8 + phy_idx));
+	printf(" %u", bus_idx * 32 + m * 8 + phy_idx);
+
+	if (!phydev)
+		puts("!");
+	else
+		ihs_phy_config(phydev, porttype->phy_invert_in_pol,
+			       porttype->phy_invert_out_pol);
+
+	return 0;
+}
+
+int init_octo_phys(uint octo_phy_mask)
+{
+	uint bus_idx;
+
+	/* there are up to four octo-phys on each mdio bus */
+	for (bus_idx = 0; bus_idx < bb_miiphy_buses_num; ++bus_idx) {
+		uint m;
+		uint octo_index = bus_idx * 4;
+		struct mii_dev *bus = NULL;
+		struct porttype *porttype = NULL;
+		int ret;
+
+		porttype = get_porttype(octo_phy_mask, bus_idx);
+
+		if (!porttype)
+			continue;
+
+		for (m = 0; m < 4; ++m) {
+			uint phy_idx;
+
+			/**
+			 * Register a bus device if there is at least one phy
+			 * on the current bus
+			 */
+			if (!m && octo_phy_mask & (0xf << octo_index)) {
+				ret = register_miiphy_bus(bus_idx, &bus);
+				if (ret)
+					return ret;
+			}
+
+			if (!(octo_phy_mask & BIT(octo_index + m)))
+				continue;
+
+			for (phy_idx = 0; phy_idx < 8; ++phy_idx)
+				init_single_phy(porttype, bus, bus_idx, m,
+						phy_idx);
+		}
+	}
+
+	return 0;
+}
+
 struct bb_miiphy_bus bb_miiphy_buses[] = {
 	{
 		.name = "ihs0",
-- 
2.45.2

