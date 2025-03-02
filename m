Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85854C021B8
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 01:29:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72CBD81249;
	Sun,  2 Mar 2025 02:28:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="A8tWMyGn";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OHP0fHZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 673668141D; Sun,  2 Mar 2025 02:28:45 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2B088123D
 for <u-boot@lists.denx.de>; Sun,  2 Mar 2025 02:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Z548l2MLLz9smP;
 Sun,  2 Mar 2025 02:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOKoEf34DYRLkygAwJr0sO4LTb66oAnYteh+CD4so7M=;
 b=A8tWMyGnABXDBcVP2n8bgkslGwu5jlT2z91vhMwDCPa3dm6qNOvYmpHngdt/Oek/0kt+wd
 DxggwysN3BjW13UnssOW2qBKgIn28Go0Gk774xcWb76fGzkeg5lVA0njwpGSaQuPbdb6lb
 9bcXMAKWDG+5oJSc1i6TaYxDrtLCvAuI9qYaGVYSr1/4fvkIzaE/XN/aYptN73zAoSboT7
 W9Aa8Kh3El31iG7I0Wz7MeEYMVyE6Ttz4t3TLUmz3+uysUuwganbiQiAnz9HsqhBRadnQ6
 yz4bND1021qNGwmFsqPoPX0f6LHcT+i+rbQJuh76Tv3Uu9IamSDQFXUohpkGdg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740878917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mOKoEf34DYRLkygAwJr0sO4LTb66oAnYteh+CD4so7M=;
 b=OHP0fHZoHazW8Q1s2cn4TC0tii7zoWOcMSvWMEzI/N67g4j5kv3ywxhuuEsBHn+BRKHWZ7
 5mD15A2+OAydPCpEs/VsMWz4L951wIYZXlUJak/SuWagvwN7OHouEZPM/EASZPUj+MKrIl
 ieR2G1qA5QWfUceQRMq0ZcMZZkSK0WTWa/DpRoEckoSEyB4fK3FBP5SX2kv1KErmC8v4kR
 BQhztDloPWVn9RbK827RrO8i/U8MnIl8givE2a8haUH8ZUsEmQsfAf1TsjPY+GOrSbW0TZ
 7Nb0Oe1pHH9QctB6MDIJvsOw7Ek4CQUHBRRd1LbKLWdS+3nRdBHOlwEJSbixnA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jim Liu <jim.t90615@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Mario Six <mario.six@gdsys.cc>, Michael Chang <zhang971090220@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Parvathi Bhogaraju <pbhogaraju@microsoft.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/11] net: miiphybb: Drop bb_miiphy_alloc()/bb_miiphy_free()
 and struct bb_miiphy_bus
Date: Sun,  2 Mar 2025 02:24:51 +0100
Message-ID: <20250302012752.393608-10-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
References: <20250302012752.393608-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: xsoodzsqjns8ccmyswdsz3paiww7q4h6
X-MBO-RS-ID: 4b3150533e7d0a2d7a4
X-Rspamd-Queue-Id: 4Z548l2MLLz9smP
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

These functions are no longer necessary, remove them.
The struct bb_miiphy_bus is no longer necessary either,
remove it as well.

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
 drivers/net/phy/miiphybb.c | 19 -------------------
 include/miiphy.h           |  9 ---------
 2 files changed, 28 deletions(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 60c791b707b..76463da7299 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -14,28 +14,9 @@
 
 #include <ioports.h>
 #include <ppc_asm.tmpl>
-#include <malloc.h>
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-struct bb_miiphy_bus *bb_miiphy_alloc(void)
-{
-	struct bb_miiphy_bus *bus;
-
-	bus = malloc(sizeof(*bus));
-	if (!bus)
-		return bus;
-
-	mdio_init(&bus->mii);
-
-	return bus;
-}
-
-void bb_miiphy_free(struct bb_miiphy_bus *bus)
-{
-	free(bus);
-}
-
 /*****************************************************************************
  *
  * Utility to send the preamble, address, and register (common to read
diff --git a/include/miiphy.h b/include/miiphy.h
index 097c46c27bf..5930fa1b1c9 100644
--- a/include/miiphy.h
+++ b/include/miiphy.h
@@ -64,8 +64,6 @@ void mdio_list_devices(void);
 
 #define BB_MII_DEVNAME	"bb_miiphy"
 
-struct bb_miiphy_bus;
-
 struct bb_miiphy_bus_ops {
 	int (*mdio_active)(struct mii_dev *miidev);
 	int (*mdio_tristate)(struct mii_dev *miidev);
@@ -75,13 +73,6 @@ struct bb_miiphy_bus_ops {
 	int (*delay)(struct mii_dev *miidev);
 };
 
-struct bb_miiphy_bus {
-	struct mii_dev mii;
-};
-
-struct bb_miiphy_bus *bb_miiphy_alloc(void);
-void bb_miiphy_free(struct bb_miiphy_bus *bus);
-
 int bb_miiphy_read(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
 		   int addr, int devad, int reg);
 int bb_miiphy_write(struct mii_dev *miidev, const struct bb_miiphy_bus_ops *ops,
-- 
2.47.2

