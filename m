Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25BEC54E49
	for <u-boot@archiver.kernel.org>; Sun, 25 Feb 2024 22:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC90A87DF4;
	Sun, 25 Feb 2024 23:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Bv1sBawV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 445F387E21; Sun, 25 Feb 2024 23:10:51 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C54487DF4
 for <u-boot@lists.denx.de>; Sun, 25 Feb 2024 23:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=31c0=KD=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1708899040; bh=DyusC9ORAR+XZuJiPJ/3cQGjPsGAIRRpa763lcRm9QI=;
 b=Bv1sBawVhXXIyoD7RTT7PpAz6+xCx17DjVExzdjGWsgUube7Xho69mue9hWqeTSU0bCFYYtv7
 HD7t7qbOmnYD+L0UVg+SHdibpC38eSbz+ucYsZrMhZL1IiRJNWWlFyb0IZacRz+AeagLdc75goJ
 qTiFcN9xKXoHBJKpyqXiwsuJJMOXWwg9aOhGc9HZ91jwYEXSai2WfZYxtzx23bl5U4pDvpDuJd9
 ijrjK7DdsrJyRm4ALrkvjlr2/gZguEXEzOiHrFbbIZn+QIZjKhbbSdTQOScvPdvnFFKG8F3wZsX
 rdxXOykD/CZU8ni3ZAYh20CBo6kwKIBdthaDsbYR18nw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/2] phy: rockchip-inno-usb2: Limit changes made to regs
Date: Sun, 25 Feb 2024 22:10:20 +0000
Message-ID: <20240225221024.1974853-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240225221024.1974853-1-jonas@kwiboo.se>
References: <20240225221024.1974853-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65dbbade46c899733a83b3fe
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

The USB2PHY regs already contain working default reset values for RK3328
and RK35xx as evidenced by the fact that this driver never has changed a
single value for these SoCs.

Reduce to only configure utmi_suspend_n and utmi_sel bits similar to
what is currently done on RK3399. Also add missing clkout_ctl for RK3588.

When enabled utmi_suspend_n is changed to normal mode and utmi_sel to
use otg/host controller utmi interface to phy. When disabled
utmi_suspend_n is changed to suspend mode and utmi_sel to use GRF utmi
interface to phy.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 117 +++---------------
 1 file changed, 14 insertions(+), 103 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 7317128d135e..d392aed2d4de 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -35,16 +35,6 @@ struct usb2phy_reg {
 
 struct rockchip_usb2phy_port_cfg {
 	struct usb2phy_reg	phy_sus;
-	struct usb2phy_reg	bvalid_det_en;
-	struct usb2phy_reg	bvalid_det_st;
-	struct usb2phy_reg	bvalid_det_clr;
-	struct usb2phy_reg	ls_det_en;
-	struct usb2phy_reg	ls_det_st;
-	struct usb2phy_reg	ls_det_clr;
-	struct usb2phy_reg	utmi_avalid;
-	struct usb2phy_reg	utmi_bvalid;
-	struct usb2phy_reg	utmi_ls;
-	struct usb2phy_reg	utmi_hstdet;
 };
 
 struct rockchip_usb2phy_cfg {
@@ -131,7 +121,6 @@ static int rockchip_usb2phy_init(struct phy *phy)
 {
 	struct udevice *parent = dev_get_parent(phy->dev);
 	struct rockchip_usb2phy *priv = dev_get_priv(parent);
-	const struct rockchip_usb2phy_port_cfg *port_cfg = us2phy_get_port(phy);
 	int ret;
 
 	ret = clk_enable(&priv->phyclk);
@@ -140,14 +129,6 @@ static int rockchip_usb2phy_init(struct phy *phy)
 		return ret;
 	}
 
-	if (phy->id == USB2PHY_PORT_OTG) {
-		property_enable(priv->reg_base, &port_cfg->bvalid_det_clr, true);
-		property_enable(priv->reg_base, &port_cfg->bvalid_det_en, true);
-	} else if (phy->id == USB2PHY_PORT_HOST) {
-		property_enable(priv->reg_base, &port_cfg->bvalid_det_clr, true);
-		property_enable(priv->reg_base, &port_cfg->bvalid_det_en, true);
-	}
-
 	return 0;
 }
 
@@ -351,27 +332,13 @@ bind_fail:
 static const struct rockchip_usb2phy_cfg rk3328_usb2phy_cfgs[] = {
 	{
 		.reg = 0x100,
-		.clkout_ctl	= { 0x108, 4, 4, 1, 0 },
+		.clkout_ctl	= { 0x0108, 4, 4, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
-				.phy_sus	= { 0x0100, 15, 0, 0, 0x1d1 },
-				.bvalid_det_en	= { 0x0110, 3, 2, 0, 3 },
-				.bvalid_det_st	= { 0x0114, 3, 2, 0, 3 },
-				.bvalid_det_clr = { 0x0118, 3, 2, 0, 3 },
-				.ls_det_en	= { 0x0110, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0114, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0118, 0, 0, 0, 1 },
-				.utmi_avalid	= { 0x0120, 10, 10, 0, 1 },
-				.utmi_bvalid	= { 0x0120, 9, 9, 0, 1 },
-				.utmi_ls	= { 0x0120, 5, 4, 0, 1 },
+				.phy_sus	= { 0x0100, 1, 0, 2, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
-				.phy_sus	= { 0x104, 15, 0, 0, 0x1d1 },
-				.ls_det_en	= { 0x110, 1, 1, 0, 1 },
-				.ls_det_st	= { 0x114, 1, 1, 0, 1 },
-				.ls_det_clr	= { 0x118, 1, 1, 0, 1 },
-				.utmi_ls	= { 0x120, 17, 16, 0, 1 },
-				.utmi_hstdet	= { 0x120, 19, 19, 0, 1 }
+				.phy_sus	= { 0x0104, 1, 0, 2, 1 },
 			}
 		},
 	},
@@ -385,19 +352,9 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0xe454, 1, 0, 2, 1 },
-				.bvalid_det_en	= { 0xe3c0, 3, 3, 0, 1 },
-				.bvalid_det_st	= { 0xe3e0, 3, 3, 0, 1 },
-				.bvalid_det_clr	= { 0xe3d0, 3, 3, 0, 1 },
-				.utmi_avalid	= { 0xe2ac, 7, 7, 0, 1 },
-				.utmi_bvalid	= { 0xe2ac, 12, 12, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
-				.phy_sus	= { 0xe458, 1, 0, 0x2, 0x1 },
-				.ls_det_en	= { 0xe3c0, 6, 6, 0, 1 },
-				.ls_det_st	= { 0xe3e0, 6, 6, 0, 1 },
-				.ls_det_clr	= { 0xe3d0, 6, 6, 0, 1 },
-				.utmi_ls	= { 0xe2ac, 22, 21, 0, 1 },
-				.utmi_hstdet	= { 0xe2ac, 23, 23, 0, 1 }
+				.phy_sus	= { 0xe458, 1, 0, 2, 1 },
 			}
 		},
 	},
@@ -407,19 +364,9 @@ static const struct rockchip_usb2phy_cfg rk3399_usb2phy_cfgs[] = {
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus        = { 0xe464, 1, 0, 2, 1 },
-				.bvalid_det_en  = { 0xe3c0, 8, 8, 0, 1 },
-				.bvalid_det_st  = { 0xe3e0, 8, 8, 0, 1 },
-				.bvalid_det_clr = { 0xe3d0, 8, 8, 0, 1 },
-				.utmi_avalid	= { 0xe2ac, 10, 10, 0, 1 },
-				.utmi_bvalid    = { 0xe2ac, 16, 16, 0, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
-				.phy_sus	= { 0xe468, 1, 0, 0x2, 0x1 },
-				.ls_det_en	= { 0xe3c0, 11, 11, 0, 1 },
-				.ls_det_st	= { 0xe3e0, 11, 11, 0, 1 },
-				.ls_det_clr	= { 0xe3d0, 11, 11, 0, 1 },
-				.utmi_ls	= { 0xe2ac, 26, 25, 0, 1 },
-				.utmi_hstdet	= { 0xe2ac, 27, 27, 0, 1 }
+				.phy_sus	= { 0xe468, 1, 0, 2, 1 },
 			}
 		},
 	},
@@ -432,24 +379,10 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
-				.phy_sus	= { 0x0000, 8, 0, 0x052, 0x1d1 },
-				.bvalid_det_en	= { 0x0080, 2, 2, 0, 1 },
-				.bvalid_det_st	= { 0x0084, 2, 2, 0, 1 },
-				.bvalid_det_clr = { 0x0088, 2, 2, 0, 1 },
-				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
-				.utmi_avalid	= { 0x00c0, 10, 10, 0, 1 },
-				.utmi_bvalid	= { 0x00c0, 9, 9, 0, 1 },
-				.utmi_ls	= { 0x00c0, 5, 4, 0, 1 },
+				.phy_sus	= { 0x0000, 1, 0, 2, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
-				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d1 },
-				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
-				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
-				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
-				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
-				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
+				.phy_sus	= { 0x0004, 1, 0, 2, 1 },
 			}
 		},
 	},
@@ -458,20 +391,10 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 		.clkout_ctl	= { 0x0008, 4, 4, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
-				.phy_sus	= { 0x0000, 8, 0, 0x1d2, 0x1d1 },
-				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
-				.utmi_ls	= { 0x00c0, 5, 4, 0, 1 },
-				.utmi_hstdet	= { 0x00c0, 7, 7, 0, 1 }
+				.phy_sus	= { 0x0000, 1, 0, 2, 1 },
 			},
 			[USB2PHY_PORT_HOST] = {
-				.phy_sus	= { 0x0004, 8, 0, 0x1d2, 0x1d1 },
-				.ls_det_en	= { 0x0080, 1, 1, 0, 1 },
-				.ls_det_st	= { 0x0084, 1, 1, 0, 1 },
-				.ls_det_clr	= { 0x0088, 1, 1, 0, 1 },
-				.utmi_ls	= { 0x00c0, 17, 16, 0, 1 },
-				.utmi_hstdet	= { 0x00c0, 19, 19, 0, 1 }
+				.phy_sus	= { 0x0004, 1, 0, 2, 1 },
 			}
 		},
 	},
@@ -481,49 +404,37 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg		= 0x0000,
+		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
 				.phy_sus	= { 0x000c, 11, 11, 0, 1 },
-				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
-				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
 			}
 		},
 	},
 	{
 		.reg		= 0x4000,
+		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_OTG] = {
-				.phy_sus	= { 0x000c, 11, 11, 0, 0 },
-				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
-				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
+				.phy_sus	= { 0x000c, 11, 11, 0, 1 },
 			}
 		},
 	},
 	{
 		.reg		= 0x8000,
+		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_HOST] = {
 				.phy_sus	= { 0x0008, 2, 2, 0, 1 },
-				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
-				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
 			}
 		},
 	},
 	{
 		.reg		= 0xc000,
+		.clkout_ctl	= { 0x0000, 0, 0, 1, 0 },
 		.port_cfgs	= {
 			[USB2PHY_PORT_HOST] = {
 				.phy_sus	= { 0x0008, 2, 2, 0, 1 },
-				.ls_det_en	= { 0x0080, 0, 0, 0, 1 },
-				.ls_det_st	= { 0x0084, 0, 0, 0, 1 },
-				.ls_det_clr	= { 0x0088, 0, 0, 0, 1 },
-				.utmi_ls	= { 0x00c0, 10, 9, 0, 1 },
 			}
 		},
 	},
-- 
2.43.0

