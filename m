Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574DFEED618
	for <u-boot@archiver.kernel.org>; Thu,  1 Jan 2026 16:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B287F83BC4;
	Thu,  1 Jan 2026 17:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="h0Luv412";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="AlNVTe5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5827883BC9; Thu,  1 Jan 2026 17:53:28 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86E5D83BB1
 for <u-boot@lists.denx.de>; Thu,  1 Jan 2026 17:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dhtF01pmGz9tQG;
 Thu,  1 Jan 2026 17:53:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767286404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+86Cxy5EelADaalcVL45zePxgjBNGWrin8ipTQ8vEC8=;
 b=h0Luv412HgRgKk+0lCqsJotYgBgF9tVrg+yT3QFkJKaexL6jClKLlQW7Cqjplm4FJHR8jq
 ml3fvQABw9wyIcVCrbEb6jbn6Qdq80SWPyYk8rl9XZprg7YAyiMSdJ+6Y7I11gVbkgYFj2
 v5Wjl1xFoQ2s0kCgEtbMKv7KlsM2Dnj8Wb9MvH6iEeg9RFAZtP1L+EYFo+9+ApR30djtu2
 evRU4nUdFD3sYc51BfuBEZPCO9ziDaVcGxNbZJjjAWTG+IwLWQT/ZjhzrQa+r6lPVAqHdN
 VPkVW25x5TOYFEw9YgNRVqcSaVWKU8DOnRgSV2Z69WKVcJSrN0ezEUretg0F/Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767286402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+86Cxy5EelADaalcVL45zePxgjBNGWrin8ipTQ8vEC8=;
 b=AlNVTe5j/nU1IHhqrbqCPwxVx5anDpx6y3ee2gHAaQ0gCpGVQc0bfcnyAXICaPJ5nVyiHs
 c5LSd0/4oXrCpe+R9h5ErCCZaIanFgL4MxKYiOpmCznLTsaBcvy9wnjq9w1008nlnMZ7AR
 tD3aZopxTyI7ropDazQ6KSQSQH6EoH2N/yEW0zzwc9lpxjD0jIveSTZdlSmV9qlNmo8Htk
 JpDx31e6KwctRJ53frF4TjxCgTNaKhQGxCF/m23JDvlv6ucUFMTMUq2nYoXDPWZl7bd8HE
 9Mtvl5BcbPcDXZQymZrdRJhd5ZqqTdxDcIDLsZcK5xw6BNC0wSVYt4RX0Hkrxg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Marek Behun <kabel@kernel.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: phy: marvell10g: Fix PHY mode bitmap handling
Date: Thu,  1 Jan 2026 17:51:44 +0100
Message-ID: <20260101165317.25595-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: dz7zpfitetpe37x6ed5dehisbmgn83ff
X-MBO-RS-ID: dcfd67a9fe407c3f8dc
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

Replace PHY interface mode bitmap handling with comparison test to match
U-Boot PHY subsystem behavior. U-Boot currently implements only single PHY
interface mode for each PHY. Linux currently uses bitmap of PHY interface
modes for each PHY.

The reason why in Linux uses bitmap of supported interface modes is so
that Linux can select the best serdes mode switching behavior for the PHY.

For example if the host only supports 10gbase-r serdes mode, then the PHY
must always talk to the host in 10gbase-r mode, even if the RJ-45 copper
speed was autonegotiated to lower speed (i.e. 1Gbps).

If the host supports both 10gbase-r and sgmii serdes modes, we want the
PHY to switch to sgmii if the RJ-45 speed is 1000/100/10, and to switch
to 10gbase-r if the RJ-45 speed is 10000.

U-Boot does not implement this functionality yet, therefore remove modes
which cannot be currently supported and switch mv_test_bit() to plain
mode comparison.

Fixes: b6fcab0728cb ("net: phy: marvell10g: Adapt Marvell 10G PHY driver from Linux")
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
This is a follow up to this discussion thread:
https://lore.kernel.org/u-boot/bxuuwcj7jm33go7yj4jnafoowrttu2qvbxej7nvdn3pm5az4sj@6xpf3ym2s2ek/

Large chunk of the commit message is also adapted from the
aforementioned thread and explanation from Marek Behun, which
is excellent.
---
Cc: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>
Cc: Marek Behun <kabel@kernel.org>
Cc: Ramon Fried <rfried.dev@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 drivers/net/phy/marvell10g.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/phy/marvell10g.c b/drivers/net/phy/marvell10g.c
index 8c95bcbb9ad..d6115eea025 100644
--- a/drivers/net/phy/marvell10g.c
+++ b/drivers/net/phy/marvell10g.c
@@ -342,8 +342,7 @@ static int mv2110_select_mactype(struct phy_device *phydev)
 {
 	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII)
 		return MV_PMA_21X0_PORT_CTRL_MACTYPE_USXGMII;
-	else if (phydev->interface == PHY_INTERFACE_MODE_SGMII &&
-		 !(phydev->interface == PHY_INTERFACE_MODE_10GBASER))
+	else if (phydev->interface == PHY_INTERFACE_MODE_SGMII)
 		return MV_PMA_21X0_PORT_CTRL_MACTYPE_5GBASER;
 	else if (phydev->interface == PHY_INTERFACE_MODE_10GBASER)
 		return MV_PMA_21X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH;
@@ -381,15 +380,6 @@ static int mv3310_select_mactype(struct phy_device *phydev)
 {
 	if (phydev->interface == PHY_INTERFACE_MODE_USXGMII)
 		return MV_V2_33X0_PORT_CTRL_MACTYPE_USXGMII;
-	else if (phydev->interface == PHY_INTERFACE_MODE_SGMII &&
-		 phydev->interface == PHY_INTERFACE_MODE_10GBASER)
-		return MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER;
-	else if (phydev->interface == PHY_INTERFACE_MODE_SGMII &&
-		 phydev->interface == PHY_INTERFACE_MODE_RXAUI)
-		return MV_V2_33X0_PORT_CTRL_MACTYPE_RXAUI;
-	else if (phydev->interface == PHY_INTERFACE_MODE_SGMII &&
-		 phydev->interface == PHY_INTERFACE_MODE_XAUI)
-		return MV_V2_3310_PORT_CTRL_MACTYPE_XAUI;
 	else if (phydev->interface == PHY_INTERFACE_MODE_10GBASER)
 		return MV_V2_33X0_PORT_CTRL_MACTYPE_10GBASER_RATE_MATCH;
 	else if (phydev->interface == PHY_INTERFACE_MODE_RXAUI)
@@ -542,7 +532,7 @@ static bool mv3310_has_downshift(struct phy_device *phydev)
 }
 
 #define mv_test_bit(iface, phydev)	\
-	({ if ((phydev)->interface & (iface)) return 0; })
+	({ if ((phydev)->interface == (iface)) return 0; })
 
 static int mv3310_mv3340_test_supported_interfaces(struct phy_device *phydev)
 {
-- 
2.51.0

