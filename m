Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE55EE49A3
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E42864C0;
	Tue, 22 Aug 2023 14:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JQIwk7CC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467D6864C0; Tue, 22 Aug 2023 14:14:09 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE55483F7A
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 699A665543;
 Tue, 22 Aug 2023 12:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40BF7C433C9;
 Tue, 22 Aug 2023 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692706444;
 bh=VvVBUfXRVioF2uL00GmCI/gy2DLOBR1S8PsANxyQDdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JQIwk7CC5WmC+eCha2ofxs7kexP/zMsZQ1VO31CngCTDBfiIVAt35BVWHfhQWBuqM
 jJEzFt91zh3chYJIdbFgASZfvRb47Qt0nOnpi2ilrdyPeU4+A0vysUK0Wix3KygJIJ
 PRBByn20TabdP5iIHWclHXHsYvxkpS5+W6XGig4/qA+fZXOxQz+NO7R3M17HCBfQVW
 C89SchaKU+o/zos74KwcRhk4/5DGX49m1xfeC6pTAcY6peMyvjHQaWQkU5HmX2PKMe
 CXdfRWVS7h75eRmCVZHz8tHJRlOrD/RGozoQiJAFmUv/hWeFX/p8Wdg2FSwIZRciac
 ayo2C1uCh+60A==
From: Roger Quadros <rogerq@kernel.org>
To: nm@ti.com,
	joe.hershberger@ni.com
Cc: robertcnelson@gmail.com, jkridner@beagleboard.org, r-gunasekaran@ti.com,
 s-vadapalli@ti.com, srk@ti.com, trini@konsulko.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 2/2] net: phy: Change "PHY not found" message to debug()
Date: Tue, 22 Aug 2023 15:13:50 +0300
Message-Id: <20230822121350.51324-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822121350.51324-1-rogerq@kernel.org>
References: <20230822121350.51324-1-rogerq@kernel.org>
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

Some boards (e.g. Beagleplay) need multiple attempts to detect the PHY
and the multiple "PHY not found" prints are not nice.

Change them to debug().

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index ae21acb059..3a524bcd81 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -928,7 +928,7 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
 	if (phydev)
 		phy_connect_dev(phydev, dev, interface);
 	else
-		printf("Could not get PHY for %s: addr %d\n", bus->name, addr);
+		debug("Could not get PHY for %s: addr %d\n", bus->name, addr);
 	return phydev;
 }
 
-- 
2.34.1

