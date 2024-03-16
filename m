Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37BBC54E68
	for <u-boot@archiver.kernel.org>; Sat, 16 Mar 2024 22:58:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31C058809C;
	Sat, 16 Mar 2024 23:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="u4+ixFDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A597D8809D; Sat, 16 Mar 2024 23:57:45 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CD42880A2
 for <u-boot@lists.denx.de>; Sat, 16 Mar 2024 23:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8b2e=KX=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1710629851; bh=888c41V02Br7uNx/L25uHDKX2NByprdGw3F+Cm4L2ao=;
 b=u4+ixFDQB0vwLRZ75/ds+8pRtczc7xS6zrpy7X+WheYQ79HRWuVM7JbhSp1I99/LE1irN0GCz
 rDDvu4vOtwZddfI/SVak1zeNfvUitooV8iT4HTnQ+hMvZnFGCVZP14pNsjuDFXgJNY9xx4XSnsY
 JuU1hUhb5oOuynhD5Vqp4BsO04wYZnH74VHZ3WEqbhOguSpQP98EVsknIyydSgw+t7p9GU/s5+J
 BYjo+XuYPVHuDGNFXKDt/5Fne34c1y4mGmbIu4enU/D80wVjTx/PkH7QeSMY/Tbz8hGWQWQOIwX
 8D1LNhspEfx0Ti+j/KtQe/6aiq1dreVX30cbOfd0JJgQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 09/13] phy: rockchip-inno-usb2: Add support for RK3308
Date: Sat, 16 Mar 2024 22:56:35 +0000
Message-ID: <20240316225655.3244348-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240316225655.3244348-1-jonas@kwiboo.se>
References: <20240316225655.3244348-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65f623db0957eaab7babfd1d
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

Add clkout_ctl and phy_sus regs to support USB2PHY for RK3308.

Based on linux commit 31f840e7ff3e ("phy: phy-rockchip-inno-usb2: add
support for RK3308 USB phy").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index d392aed2d4de..43f6e020a6a0 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -329,6 +329,22 @@ bind_fail:
 	return ret;
 }
 
+static const struct rockchip_usb2phy_cfg rk3308_phy_cfgs[] = {
+	{
+		.reg = 0x100,
+		.clkout_ctl	= { 0x0108, 4, 4, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0100, 1, 0, 2, 1 },
+			},
+			[USB2PHY_PORT_HOST] = {
+				.phy_sus	= { 0x0104, 1, 0, 2, 1 },
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3328_usb2phy_cfgs[] = {
 	{
 		.reg = 0x100,
@@ -442,6 +458,10 @@ static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 };
 
 static const struct udevice_id rockchip_usb2phy_ids[] = {
+	{
+		.compatible = "rockchip,rk3308-usb2phy",
+		.data = (ulong)&rk3308_phy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3328-usb2phy",
 		.data = (ulong)&rk3328_usb2phy_cfgs,
-- 
2.43.2

