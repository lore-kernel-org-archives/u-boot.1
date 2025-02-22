Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D6AC021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 20:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B4D810EA;
	Sat, 22 Feb 2025 21:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Wu8o8ZOe";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bFoW00x3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F9F810E6; Sat, 22 Feb 2025 21:36:37 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BA088104B
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 21:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Z0f0y6m1Mz9svd;
 Sat, 22 Feb 2025 21:36:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2RmjNuS2Z/mcHjlU5wYf3NDce+vAD2bPTnkMXdwWFU=;
 b=Wu8o8ZOeKW8Da9LC05LQq4CswLXaj22dkJdqoDzhwidUfeMeA4GchujLtrJizHrhBy1EAR
 w+93OBxxRkvpCya9HqoSgnWy9MaGlgbviYzrHM9mhjiC6TAJTbxMQmUYjMue9ab9j37A//
 3wH3GtuBbor8KH4K9gbqMZlf8lzmlso3SkLA4fXeZHBR6k31imWUAWaxF8g8mwGxAFmKTv
 0wHidKNaeD4hi4PFiBEmmX/A1u2fnmxX2GDbMLzGeVhNI066v+/5IJ2NmD2AB+UrlpPYqW
 v5wzypSZj5q5L5YG+c/wRuMvL3BIq+pn8Zy6HZ2PCeLnkQsdbLlxc2SMRNqR0A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1740256593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z2RmjNuS2Z/mcHjlU5wYf3NDce+vAD2bPTnkMXdwWFU=;
 b=bFoW00x3ydBP66N4Ic3QqqBs1ePndpsdkteahtYhq9yH7wm97MBh1ScMk3wcbdPIxbdtGQ
 QZVmVhj003eoM+JenUDAnZfABcCYCjeKpf+WPyVaFU16nIIgC3rSrenrOs7owkgJOfIR3h
 628mFiuqbf1Vf8WgAciT3UkRMhw9uj+XocUU04evsQnfb5F3nEc+DwdyydaOpyCEAa1Rkg
 LjQr/bm5ofW11ULLVe2RUUZI6fWtCGug59ha1yRf/qq9tvTMpPAVePAW5u3krFXgA+p+R4
 VXKWDPCSTn3KcrJnsCTHJolQztLuTnmGD42cw2rHAxL4mz2e7VjSdYLLi6XhZQ==
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
Subject: [PATCH v3 18/23] net: miiphybb: Use container_of() in
 bb_miiphy_getbus()
Date: Sat, 22 Feb 2025 21:33:28 +0100
Message-ID: <20250222203511.195437-19-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
References: <20250222203511.195437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: i6o5dqz5iie6ax3hyzhon7ibcsdp9q8u
X-MBO-RS-ID: 93370db8da9ecf52a1a
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

Replace the name based look up in bb_miiphy_getbus() with trivial
container_of() call. This works because the struct bb_miiphy_bus
always embeds the matching struct mii_dev . This also makes the
code much simpler and more efficient.

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
 drivers/net/phy/miiphybb.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/miiphybb.c b/drivers/net/phy/miiphybb.c
index 66d98d6cc26..553af2c1032 100644
--- a/drivers/net/phy/miiphybb.c
+++ b/drivers/net/phy/miiphybb.c
@@ -18,17 +18,9 @@
 #include <miiphy.h>
 #include <asm/global_data.h>
 
-static inline struct bb_miiphy_bus *bb_miiphy_getbus(const char *devname)
+static inline struct bb_miiphy_bus *bb_miiphy_getbus(struct mii_dev *miidev)
 {
-	int i;
-
-	/* Search the correct bus */
-	for (i = 0; i < bb_miiphy_buses_num; i++) {
-		if (!strcmp(bb_miiphy_buses[i].name, devname)) {
-			return &bb_miiphy_buses[i];
-		}
-	}
-	return NULL;
+	return container_of(miidev, struct bb_miiphy_bus, mii);
 }
 
 struct bb_miiphy_bus *bb_miiphy_alloc(void)
@@ -141,7 +133,7 @@ int bb_miiphy_read(struct mii_dev *miidev, int addr, int devad, int reg)
 	int j; /* counter */
 	struct bb_miiphy_bus *bus;
 
-	bus = bb_miiphy_getbus(miidev->name);
+	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		return -1;
 	}
@@ -209,7 +201,7 @@ int bb_miiphy_write(struct mii_dev *miidev, int addr, int devad, int reg,
 	struct bb_miiphy_bus *bus;
 	int j;			/* counter */
 
-	bus = bb_miiphy_getbus(miidev->name);
+	bus = bb_miiphy_getbus(miidev);
 	if (bus == NULL) {
 		/* Bus not found! */
 		return -1;
-- 
2.47.2

