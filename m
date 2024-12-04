Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B56E77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FB7489741;
	Wed,  4 Dec 2024 17:32:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=riseup.net header.i=@riseup.net header.b="kG16Bau/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C0E689384; Wed,  4 Dec 2024 14:34:41 +0100 (CET)
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D700893A3
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 14:34:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rhs@riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx0.riseup.net (Postfix) with ESMTPS id 4Y3JR02JT3z9wF2;
 Wed,  4 Dec 2024 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
 t=1733319276; bh=A4o2iDjc869SdIAxqNIugq0OFdRwlZ/tXcCZYMqd8G0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kG16Bau/MHzdMzqnSHBnF3fHTYll6ffNyESVh/3e3BVK1YYzDoKKZAi427o0sjVRr
 EPudSRz9HJpQGN8UPbsMiYGPaQaWpGTyP+8yJ/tmcOL8Uy9W1Nv55AIxnPgMKPeyNh
 DIWNsv37gnbtw+LUrjgt4aFCDn6imC9b2luJeMZk=
X-Riseup-User-ID: 90438B7DE89A38255B20F0EE75B203C3E0C52F97F6ECD7A52991707EB7D02497
Received: from [127.0.0.1] (localhost [127.0.0.1])
 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Y3JQy4pYCzJnBM;
 Wed,  4 Dec 2024 13:34:34 +0000 (UTC)
From: Rufus Segar <rhs@riseup.net>
To: u-boot@lists.denx.de
Cc: mario.six@gdsys.cc, PHIL.EDWORTHY@renesas.com, rufus.segar@carallon.com,
 trini@konsulko.com, Rufus Segar <rhs@riseup.net>
Subject: [PATCHv2] Revert "net: phy: marvell 88e151x: Fix handling of bare
 RGMII interface type"
Date: Wed,  4 Dec 2024 13:34:30 +0000
Message-ID: <20241204133430.3152261-1-rhs@riseup.net>
In-Reply-To: <20241203220105.GB2457179@bill-the-cat>
References: <20241203220105.GB2457179@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 04 Dec 2024 17:31:58 +0100
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

This reverts commit 431be621c6cbc72efd1d45fa36686a682cbb470a.

Section 3.3 of Reduced Gigabit Media Independent Interface (RGMII)
Version 2.0 (4/1/2002) details that a PHYs using a ~2ns internal delay
are referred to as RGMII-ID. This internal delay is optional.

Page 147-148 of the Marvell Doc. No. MV-S107146-U0 Rev. F details
timings of the RX/TX delays. We see that with the TX/RX_CLK delay
enabled, our RX/TX_CTL signal is shifted w.r.t CLK to reflect the delay
added.

In 431be62 there is no timing difference between RGMII and RGMII-ID, and
so programmers wanting to explicitly set their PHY to RGMII will find
that delay added anyway. This could throw off timing if that internal
delay is undesired.

We should be handling all 4 possible RGMII cases of PHY_INTERFACE_MODE:
RGMII, RGMII_ID, RGMII_TXID, and RGMII_RXID. Reverting 431be62
implements this.

See also m88e1111_config_init_rgmii_delays in the equivalent driver in
Linux (drivers/net/phy/marvell.c), which does not set these delays in
RGMII mode.

68e6eca was tested out on an 88E1512 PHY in RGMII-ID mode. This
reversion has been tested by myself on an 88E1518 in RGMII-ID mode. This
patch affects boards using this driver in "rgmii" mode, as the internal
delay will no longer be enabled. Namely kikwood-nsa310s.

Signed-off-by: Rufus Segar <rhs@riseup.net>
---
V2: add justification for why this commit should be reverted.

Additional info: From reading the commit message of 431be62, its not
clear what the problem being fixed was. My guess is their use case
should have been fixed by simply changing to RGMII-ID mode in their
configuration.

 drivers/net/phy/marvell.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index b0a0b7fcb3..08608a99b9 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -461,8 +461,7 @@ static int m88e151x_config(struct phy_device *phydev)
 
 		reg = phy_read(phydev, MDIO_DEVAD_NONE, MIIM_88E151x_PHY_MSCR);
 		reg &= ~MIIM_88E151x_RGMII_RXTX_DELAY;
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII ||
-		    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
+		if (phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
 			reg |= MIIM_88E151x_RGMII_RXTX_DELAY;
 		else if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID)
 			reg |= MIIM_88E151x_RGMII_RX_DELAY;
-- 
2.47.0

