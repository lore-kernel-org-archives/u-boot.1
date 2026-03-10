Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780FFFCC9A5
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 00:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32828401F;
	Tue, 10 Mar 2026 01:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Ttkt4bH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF8FA83F75; Tue, 10 Mar 2026 01:55:28 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E242783FA3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 01:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=2964=BK=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1773104120; bh=KXNRRII8ojtz/lNDLWfULEhrWkDiHTew+Y5kB/WJ8Ig=;
 b=Ttkt4bH2ZLBbAkO5/fdcEMAYbd6QmOKsmP2CvtvBmeT6y3MjnRlzC78npvH/rW/vo3dFVRRTu
 1jgka6dRSPh3LLfTD9AvSiUR/vxfubNC1SNH5KbAi4yqeTzOlkB5a1fgRlQOWlBc294Kh/mvRSk
 qZfDys2TTvvvu0hSBtMxq1BXUFwo8WGt9HyN6v2Tlh1O3C0mrSGXTujOJ5k0YmAMZ1WF85vsFGi
 O10oGBOTyVTEX8XMmrK5lbQ9VZqOzQaBY8OfaBkiAToitykrAYkKzYd+aqsMG650foXUOKEn1fu
 ZnGSxHbYR5PAAYQ5d3ljcdEP/HnhpN37K/PruQ8hik0Q==
X-Forward-Email-ID: 69af6bf873a8189bec32783c
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.6.49
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v3 10/12] phy: rockchip-inno-usb2: Add support for RK3506
Date: Tue, 10 Mar 2026 00:53:05 +0000
Message-ID: <20260310005326.606079-11-jonas@kwiboo.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005326.606079-1-jonas@kwiboo.se>
References: <20260310005326.606079-1-jonas@kwiboo.se>
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

Add support for the two USB2.0 PHYs used in the RK3506 SoC.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Tested-by: Aaron Griffith <aargri@gmail.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v3: Collect r-b tag
v2: Collect t-b tag
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
2.53.0

