Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89216D232C6
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 00:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C99B184337;
	Fri,  9 Jan 2026 01:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="zAAigP/+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 586A884332; Fri,  9 Jan 2026 01:50:43 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 156FC84144
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 01:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d19=7O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1767919839; bh=NoTpN7dKu+NApR+/WvWR0vx+glmjSthUHhEFURBMPfM=;
 b=zAAigP/+XOD858H9I9OXIoHZRk6bGq/pa1o6d+0kG9UhY3/5PXLC9yiWZwKqq/pXPOuvKPedt
 IHh1LwzdgpZPfk/0sIrpsUJiWH0TVTusZbmoMQxEhrGgerCKykIBMfZpMot3pEfgoMgf6+od0Ef
 tyOgqILWY3pPuD4z0WjHgnxonsIE2BbEmWn7DSNP1kitY+C7pRkFue2wA8sNGBnT5b61GrgmhjM
 4gIo+gEDjePIua1X8iPzKj9LzxpRzEeJv9i27COUQ32+XSB9EgRkxuz73EdQn3R6AjFyWd99Agl
 DQX0yOsHbAeiqEk31SukoT1kZ/792ni7RMOnapuBgyDg==
X-Forward-Email-ID: 696050deabab7b035309fba9
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 08/10] phy: rockchip-inno-usb2: Add support for RK3506
Date: Fri,  9 Jan 2026 00:49:49 +0000
Message-ID: <20260109005008.101506-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109005008.101506-1-jonas@kwiboo.se>
References: <20260109005008.101506-1-jonas@kwiboo.se>
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

Add support for the two USB2.0 PHYs use in the RK3506 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 4ea6600ce7f5..f80b2789333d 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -421,6 +421,22 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3506_phy_cfgs[] = {
+	{
+		.reg		= 0xff2b0000,
+		.clkout_ctl_phy = { 0x041c, 7, 2, 0, 0x27 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0060, 1, 0, 2, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0070, 1, 0, 2, 1 },
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3528_phy_cfgs[] = {
 	{
 		.reg		= 0xffdf0000,
@@ -540,6 +556,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
 		.compatible = "rockchip,rk3399-usb2phy",
 		.data = (ulong)&rk3399_usb2phy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3506-usb2phy",
+		.data = (ulong)&rk3506_phy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3528-usb2phy",
 		.data = (ulong)&rk3528_phy_cfgs,
-- 
2.52.0

