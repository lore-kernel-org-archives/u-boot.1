Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C9BC4345F
	for <u-boot@archiver.kernel.org>; Sat,  4 May 2024 19:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D39988596;
	Sat,  4 May 2024 21:45:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZZP5MlcI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6CF6885A3; Sat,  4 May 2024 21:45:27 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 779AE88596
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 21:45:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=fdac=MI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1714851902; bh=Fgg2sVJIOtg+BeI/kS2JyyBosITnGfZNVAXaG6x6uns=;
 b=ZZP5MlcIgOM4apcxiwVz5UisKt9nNcBbpcv08pNlrzrqniyRggMIsT2rSnJFtBmJhMg+wdnd7
 rfhromVh0OT9adgNrhaGT430Vnxnw5fDS427slD3OfVGpHC4heNPSz0YqGrgw+o8H6IjdximoSz
 ThBqcDft0tudC8Sso8a415JMukmMBt0Xx17+h3GbEZKLA09RY0iYTD1KTeu6D6OT6BEmFNUn/Nr
 GaM8PyFtraSC2L0a7nbxw25CEskzVifmIGLGcsMcuiWZJcHsk7cwgqL2Ujg/ZqTk/MCDNOlI+55
 2cu5/EtqRaALe2QJQRqMpwmnq2uHwQq6rKPe2vmDqVBA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 12/16] phy: rockchip: usbdp: Adopt driver to work with
 upstream DT
Date: Sat,  4 May 2024 19:43:04 +0000
Message-ID: <20240504194346.2462489-13-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6636903d2b8e4dad13276e3b
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

The upstream DT binding added in linux-phy next commit a75d8056e9fe
("dt-bindings: phy: add rockchip usbdp combo phy document") does not
define subnodes for the type of PHY, instead it is expected that phandle
args are used for setting the type of the PHY.

  phys = <&usbdp_phy0 PHY_TYPE_USB3>

Adopt the usbdp phy driver to work with upstream DT binding targeted for
Linux kernel v6.10.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/phy/rockchip/phy-rockchip-usbdp.c | 63 ++++++-----------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index bf0fb6d8288f..18e76402799b 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -21,7 +21,7 @@
 #include <reset.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-
+#include <dt-bindings/phy/phy.h>
 #include <linux/usb/phy-rockchip-usbdp.h>
 
 #define BIT_WRITEABLE_SHIFT	16
@@ -585,10 +585,21 @@ static int udphy_power_off(struct rockchip_udphy *udphy, u8 mode)
 	return 0;
 }
 
+static int rockchip_u3phy_of_xlate(struct phy *phy,
+				   struct ofnode_phandle_args *args)
+{
+	if (args->args_count == 0)
+		return -EINVAL;
+
+	if (args->args[0] != PHY_TYPE_USB3)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int rockchip_u3phy_init(struct phy *phy)
 {
-	struct udevice *parent = phy->dev->parent;
-	struct rockchip_udphy *udphy = dev_get_priv(parent);
+	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
 
 	/* DP only or high-speed, disable U3 port */
 	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs) {
@@ -601,8 +612,7 @@ static int rockchip_u3phy_init(struct phy *phy)
 
 static int rockchip_u3phy_exit(struct phy *phy)
 {
-	struct udevice *parent = phy->dev->parent;
-	struct rockchip_udphy *udphy = dev_get_priv(parent);
+	struct rockchip_udphy *udphy = dev_get_priv(phy->dev);
 
 	/* DP only or high-speed */
 	if (!(udphy->mode & UDPHY_MODE_USB) || udphy->hs)
@@ -612,6 +622,7 @@ static int rockchip_u3phy_exit(struct phy *phy)
 }
 
 static const struct phy_ops rockchip_u3phy_ops = {
+	.of_xlate	= rockchip_u3phy_of_xlate,
 	.init		= rockchip_u3phy_init,
 	.exit		= rockchip_u3phy_exit,
 };
@@ -671,40 +682,6 @@ static int rockchip_udphy_probe(struct udevice *dev)
 	return 0;
 }
 
-static int rockchip_udphy_bind(struct udevice *parent)
-{
-	struct udevice *child;
-	ofnode subnode;
-	const char *node_name;
-	int ret;
-
-	dev_for_each_subnode(subnode, parent) {
-		if (!ofnode_valid(subnode)) {
-			printf("%s: no subnode for %s", __func__, parent->name);
-			return -ENXIO;
-		}
-
-		node_name = ofnode_get_name(subnode);
-		debug("%s: subnode %s\n", __func__, node_name);
-
-		/* if there is no match, continue */
-		if (strcasecmp(node_name, "usb3-port"))
-			continue;
-
-		/* node name is usb3-port */
-		ret = device_bind_driver_to_node(parent,
-						 "rockchip_udphy_u3_port",
-						 node_name, subnode, &child);
-		if (ret) {
-			printf("%s: '%s' cannot bind its driver\n",
-			       __func__, node_name);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static int rk3588_udphy_refclk_set(struct rockchip_udphy *udphy)
 {
 	/* configure phy reference clock */
@@ -869,17 +846,11 @@ static const struct udevice_id rockchip_udphy_dt_match[] = {
 	{ /* sentinel */ }
 };
 
-U_BOOT_DRIVER(rockchip_udphy_u3_port) = {
-	.name		= "rockchip_udphy_u3_port",
-	.id		= UCLASS_PHY,
-	.ops		= &rockchip_u3phy_ops,
-};
-
 U_BOOT_DRIVER(rockchip_udphy) = {
 	.name		= "rockchip_udphy",
 	.id		= UCLASS_PHY,
 	.of_match	= rockchip_udphy_dt_match,
 	.probe		= rockchip_udphy_probe,
-	.bind		= rockchip_udphy_bind,
+	.ops		= &rockchip_u3phy_ops,
 	.priv_auto	= sizeof(struct rockchip_udphy),
 };
-- 
2.43.2

