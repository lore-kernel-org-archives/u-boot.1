Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A22DC87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 20:38:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A01F83B0E;
	Fri,  1 Aug 2025 22:38:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="W43SxNim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2F0583B0E; Fri,  1 Aug 2025 22:38:15 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7242483B07
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 22:33:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=984e=2O=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1754080427; bh=lL6vhK0lDCWL75uO7s+BKGZAWgFWvwfSrEWtLUjQ/qI=;
 b=W43SxNimdzvrhOxuUl1CQYEfr65gCzARFpDUfx8RdrN/ko5f4ZRtKnefBqycClHT5vdHcLkyE
 h8lxhz5qMTp8oGXrryX2fCHiPA5zJ4ExAfw+E1naIbB8e5FNBhNo+5lnca1IoN9YiYmka50xq9c
 rMFkX66oevYklWZLS1WGn2K9jsb4bkwfwIrebLSbYUHJeXJPx6iRBbWCjB0cLTIyR1ohl4ziFlC
 rEW5saSSy5Ljzqshtc6UowO/TwF8x+6I9rkUq/edPJ11IShGEyY0noi+0Q0J92Zt8FlKvnibFZs
 xTQZLhIji2vf7k2n/IKATpqAzLBeJogkiZGoe+HhrLpQ==
X-Forward-Email-ID: 688d249303c11ad401760963
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>,
 Frank Wang <frank.wang@rock-chips.com>
Subject: [PATCH v3 7/8] phy: rockchip-inno-usb2: Add support for RK3576
Date: Fri,  1 Aug 2025 20:32:43 +0000
Message-ID: <20250801203255.2590535-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801203255.2590535-1-jonas@kwiboo.se>
References: <20250801203255.2590535-1-jonas@kwiboo.se>
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

From: Frank Wang <frank.wang@rock-chips.com>

Add support for the USB2.0 PHYs used in the RK3576 SoC.

Config values are taken from vendor U-Boot linux-6.1-stan-rkr5 tag.

Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v3: New patch
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index a3222138b9d0..4ea6600ce7f5 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -465,6 +465,28 @@ static const struct rockchip_usb2phy_cfg rk3568_phy_cfgs[] = {
 	{ /* sentinel */ }
 };
 
+static const struct rockchip_usb2phy_cfg rk3576_phy_cfgs[] = {
+	{
+		.reg		= 0x0000,
+		.clkout_ctl	= { 0x0008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x0000, 1, 0, 2, 1 },
+			}
+		},
+	},
+	{
+		.reg		= 0x2000,
+		.clkout_ctl	= { 0x2008, 0, 0, 1, 0 },
+		.port_cfgs	= {
+			[USB2PHY_PORT_OTG] = {
+				.phy_sus	= { 0x2000, 1, 0, 2, 1 },
+			}
+		},
+	},
+	{ /* sentinel */ }
+};
+
 static const struct rockchip_usb2phy_cfg rk3588_phy_cfgs[] = {
 	{
 		.reg		= 0x0000,
@@ -526,6 +548,10 @@ static const struct udevice_id rockchip_usb2phy_ids[] = {
 		.compatible = "rockchip,rk3568-usb2phy",
 		.data = (ulong)&rk3568_phy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3576-usb2phy",
+		.data = (ulong)&rk3576_phy_cfgs,
+	},
 	{
 		.compatible = "rockchip,rk3588-usb2phy",
 		.data = (ulong)&rk3588_phy_cfgs,
-- 
2.50.1

