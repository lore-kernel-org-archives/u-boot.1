Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9EBBC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81E8F83249;
	Tue,  8 Apr 2025 00:49:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="D5xqpQQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06D2F82FB4; Tue,  8 Apr 2025 00:49:37 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 479318309A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:49:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab18=W2=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1744066171; bh=Kq5ka47SJVresG0fGjcfsHpOZlPLeWSmlEhh6uxwdY4=;
 b=D5xqpQQoi2pMr3eRkcfnnuzljcLJMc7C4v21RvfTTJzY18AP1v5vZ/flu+gYsbgOIIqpiJ59o
 DGkoDlCd5szPvyVZjKnZ9GkXtpvbhKxYnrgo3fzSC2gmy02gT8/3UqULTH0BawjlKbG3AfEt/8Y
 6cR1uBktWz2r+szdYTt/JhOymJhsOXSXM5bjDcuR6rkakPYH+CNonIgHSMzQvkijt+eqNHAvRga
 vXerxfH2vErAvlBjN0dxeF4Foty2OZ7PGrSvxN4cIABW4cEGfE2H0azKGfBALi1dN3sh4g4cmTo
 kybyPm6FrVeqVp4umf011HHfcLtjG3hO4b79tYzE2+aA==
X-Forward-Email-ID: 67f456799fd75b9b965129c1
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>,
 u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 27/30] phy: rockchip-inno-usb2: Add support for RK3528
Date: Mon,  7 Apr 2025 22:47:00 +0000
Message-ID: <20250407224743.2423921-28-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250407224743.2423921-1-jonas@kwiboo.se>
References: <20250407224743.2423921-1-jonas@kwiboo.se>
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

Add support for the two USB2.0 PHYs use in the RK3528 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index f40a86bc9dae..88b33de1b2a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -412,6 +412,22 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3528_phy_cfgs[] = {
+	{
+		.reg		= 0xffdf0000,
+		.clkout_ctl_phy	= { 0x041c, 7, 2, 0, 0x27 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x004c, 1, 0, 2, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x005c, 1, 0, 2, 1 },
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 	{
 		.reg		= 0xfe8a0000,
@@ -493,6 +509,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
 		.compatible = "rockchip,rk3399-usb2phy",
 		.data = (ulong)&rk3399_usb2phy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3528-usb2phy",
+		.data = (ulong)&rk3528_phy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3568-usb2phy",
 		.data = (ulong)&rk3568_phy_cfgs,
-- 
2.49.0

