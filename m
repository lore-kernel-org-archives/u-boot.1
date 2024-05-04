Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF11C4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9552588263;
	Sat,  4 May 2024 21:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="CmMLoxYV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77538858F; Sat,  4 May 2024 21:45:25 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8DF88585
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851902; bh=PnhaPssvZvX2ylcTg4dwVrrBfz/imUU/pkTApsA9b9s=;
 b=CmMLoxYV/UZxruTp8x8i+7zAMNQHiCpLsTyPC2B6BUaiUTDLspFjOD0jLwicICQNn9XlcYQvk
 gfHCcHZLwW45o6ylMbgcj7/pJDFJGjDx+OxP130qF1O8lQO+F0cXLyo5Y+edsJ5WcqsYkpmtEyU
 WXlqUxIe7OTxOLeUPiJyItV4FypsRfGsLTqNjdp6Zzeh36768Bl1gOEa/+Bl3kabzwHgyG7wYZU
 qIqHW7frl36IcTyaHYcXV3hn2q88j0UiclhuOJmlAlf8FwTUUEUur1ZzWmwxGrIKk0mGnISKweF
 KkUSzVhN+UXPReQzDkb4vc3f3yiIyVboOBqjwYLOQMPA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 11/16] phy: rockchip: usbdp: Drop rockchip_u3phy_uboot_init()
Date: Sat,  4 May 2024 19:43:03 +0000
Message-ID: <20240504194346.2462489-12-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240504194346.2462489-1-jonas@kwiboo.se>
References: <20240504194346.2462489-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663690392b8e4dad13276e29
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

Remove the rockchip_u3phy_uboot_init() function, it has no caller and is
not needed with proper driver model use.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 24 -----------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 8e5821069757..bf0fb6d8288f 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -616,30 +616,6 @@ static const struct phy_ops rockchip_u3phy_ops = {
 	.exit		= rockchip_u3phy_exit,
 };
 
-int rockchip_u3phy_uboot_init(void)
-{
-	struct udevice *udev;
-	struct rockchip_udphy *udphy;
-	int ret;
-
-	ret = uclass_get_device_by_driver(UCLASS_PHY,
-					  DM_DRIVER_GET(rockchip_udphy_u3_port),
-					  &udev);
-	if (ret) {
-		pr_err("%s: get u3-port failed: %d\n", __func__, ret);
-		return ret;
-	}
-
-	/* DP only or high-speed, disable U3 port */
-	udphy = dev_get_priv(udev->parent);
-	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs) {
-		udphy_u3_port_disable(udphy, true);
-		return 0;
-	}
-
-	return udphy_power_on(udphy, UDPHY_MODE_USB);
-}
-
 static int rockchip_udphy_probe(struct udevice *dev)
 {
 	struct rockchip_udphy *udphy = dev_get_priv(dev);
-- 
2.43.2

