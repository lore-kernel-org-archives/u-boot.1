Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A288C83F25
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 22:07:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6E578329C;
	Tue, 22 Jul 2025 00:07:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="kHmOV8S2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B6E8328F; Tue, 22 Jul 2025 00:07:50 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01262830C8
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 00:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1753135667; bh=sctXTNjKMNRVX8yHIKacd94GDkb0ukSuQYlMmVhhHJ4=;
 b=kHmOV8S2HhDDMvoHIDoX11+s5yQTLz4cidBTmPsvaDtG89Z711yB85ojH9aOpjRsGTA37mzPt
 feK79I/MxUB1vM+drdheA3CnhHtu15EOTo/L5h3oxIDjdgGO3hbYrUpjhWeKY8yv3N0Y2QAWVWa
 7lIh8PRYL9FiWPukuoa61awLLrEzg2msGtwSb0dn/mPJnUzGund+brvYV6FR4mEA4e3ppfrJ2dl
 MSplAkc7+wa0CqkCo7d4vwQDD3S2UCd1ZqQLoqTy7pHyuNvVktsZxs/361BBhyh2FgnsaeacAy+
 ccgsnNtTrHeQsUXif0y/ruI/NBSwOZL/SAj8qj7si22A==
X-Forward-Email-ID: 687eba30285c5226412894ca
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/10] phy: rockchip: usbdp: Fix Generic PHY reference counting
Date: Mon, 21 Jul 2025 22:07:10 +0000
Message-ID: <20250721220734.1617117-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721220734.1617117-1-jonas@kwiboo.se>
References: <20250721220734.1617117-1-jonas@kwiboo.se>
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

Generic PHY reference counting helps ensure driver ops for init/exit and
power on/off are called at correct state. For this to work the PHY
driver must initialize PHY-id to a persistent value in of_xlate ops.

The Rockchip USBDP PHY driver does not initialize the PHY-id field, this
typically lead to use of unshared reference counting among different
struct phy instances.

Initialize the PHY-id in of_xlate ops to ensure use of shared reference
counting among all struct phy instances.

E.g. on a ROCK 5B following could be observed:

  => usb start
  starting USB...
  [...]
  Bus usb@fc400000: 2 USB Device(s) found
         scanning usb for storage devices... 1 Storage Device(s) found

  => usb reset
  resetting USB...
  [...]
  rockchip_udphy phy@fed90000: cmn ana lcpll lock timeout
  rockchip_udphy phy@fed90000: failed to init usbdp combophy
  rockchip_udphy phy@fed90000: PHY: Failed to init phy@fed90000: -110.
  Can't init PHY1
  Bus usb@fc400000: probe failed, error -110
         scanning usb for storage devices... 0 Storage Device(s) found

With shared reference counting this is fixed:

  => usb reset
  resetting USB...
  [...]
  Bus usb@fc400000: 2 USB Device(s) found
         scanning usb for storage devices... 1 Storage Device(s) found

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index 9deec47ae462..56963c87183e 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -587,12 +587,16 @@ static int udphy_power_off(struct rockchip_udphy *udphy, u8 mode)
 static int rockchip_u3phy_of_xlate(struct phy *phy,
 				   struct ofnode_phandle_args *args)
 {
+	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
+
 	if (args->args_count == 0)
 		return -EINVAL;
 
 	if (args->args[0] != PHY_TYPE_USB3)
 		return -EINVAL;
 
+	phy->id = udphy->id;
+
 	return 0;
 }
 
-- 
2.50.1

