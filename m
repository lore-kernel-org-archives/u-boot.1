Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEF8CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:16:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8882488155;
	Mon,  8 Apr 2024 20:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nEWqDyvY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7729388118; Mon,  8 Apr 2024 20:15:21 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91C3C8814A
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600105; bh=NpZCnrGuHk/xuY4YEiKMqRkJijbnC7HP8sE7c2ueaYc=;
 b=nEWqDyvYDgx5dQ0amPrU2PHltFe5m/wIFCKpI+xlM2pweIGk7XsCziSaFP+XQhrAI4sZSx+cN
 emeqHbrRfoUaXLFveoUnYevMURM4MXyETyIhG/Tc44OuwuykoHQNToAqlKVcaOiAV39hoQWl464
 QrGf2v7AOD1lEQikYgzwiBC2g8pIl7eNBlEGTHgt6n2Ld0QMegt3YkqHnbfLWZLoy/0PJfRYuB3
 YTP/mMRLEibbRj4Xv8h78O6OoKDwxOUjQidgWF+hLAYOQbJEvKTdhXIbM0XbrjxaA7+QcOtB4WL
 Ah59Zv2UoPCYDZ85oD5D9qpcuT5N2CieidJ9BeGH04gQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar
 <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v2 09/14] phy: rockchip-inno-usb2: Add support for RK3308
Date: Mon,  8 Apr 2024 18:14:06 +0000
Message-ID: <20240408181429.3676856-10-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6614342845fff4c2aa5b4a9c
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
v2: No change
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

