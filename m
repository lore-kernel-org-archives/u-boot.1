Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97FB9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DA8887B0B;
	Tue, 31 Oct 2023 07:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="LscErLSf";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="mdEpH9e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7F0E87AEE; Tue, 31 Oct 2023 07:40:57 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB4087AF9
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 8E093320097A;
 Tue, 31 Oct 2023 02:40:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Tue, 31 Oct 2023 02:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698734450; x=
 1698820850; bh=XJv19FkZ0xLYX7z1eyQEg75KIGbv1D0+A/5MHSFB77U=; b=L
 scErLSfp6Ck/q/yk8AorM4cShpwO1A9n+Jx7mNkVdxwFEzf9gVyS2EyBQ0gQ7PIV
 89BVdj92WJQJwwe6USxNFZw/wfp9VW2F2AWmYH3WJz6hZoDBFV2FOXsiCe9j2Ip3
 TktobxuuGtN6Wlm2MiAsARqx2fY1+0RVvw4gSDn0aZZab7MCANTMTdLKIz8QATq/
 iOJzUgpWzvfO0YllhhOBceMJfT2Mka5ed5X7D9C29/+uXW4YWDuRivZYfO1Yj436
 qURCQtBs/wFgXs8J+dMbMY7S2QAspDjn4oGPBYU5NQuiHHkpQhLCIw586VRCXKi+
 RRdjzljmC0lioJ1CMcctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698734450; x=
 1698820850; bh=XJv19FkZ0xLYX7z1eyQEg75KIGbv1D0+A/5MHSFB77U=; b=m
 dEpH9e6FbiV6CvLrTVKZBj3gdJsH60K7nwkA7jWIRBatg+HnSNys7mSOhouvwOhI
 lVE+yzBh0MfI65ydYLQFRONxlwK74ipvr7z7MD1ppa6HsXWcx40ZuhwL3GDS2+6l
 igZkBI+vC1ipte3DyA+DTpr9jKo5GywWw3rK203erkTHXqOfdiyZqo/tHGHtdUOY
 xCKphQnnTv0Wsb3R3BYq9bGi/HYPr/nfUUfeA1EvmrTW1uJxjaLMimloP1dwWiK/
 d+ZtQVGaLiJUbRYr5qee0qneINf/ZYp2zR1amnESVtSkUVdr6cZQRD1KJkuECFG2
 EXvgHwZIo+FVH01PJI2Yg==
X-ME-Sender: <xms:caFAZQ3XLFolsQk_iN_JUTR7g_xc9voYXz5fN9ETQYop2SCASK4hHQ>
 <xme:caFAZbFaP3xxhVqcHHh3vs50S7XTvhDqAD7zfQcqsjd6ynovdi2KfU9DSm5Kw8j0K
 TLzXT9aD-O-YTwCzA>
X-ME-Received: <xmr:caFAZY77AOOtWnA5VT2D6eXOgDJvDRlHvvSgFPEq1hJbov09L06uKpdskGBAiSntOvZcleyXRKjCjJm2YpCd0AqdjM539nucY_DNF7uknDXb9TvA5Zo3FuGokfHCjqVf1GgDYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:caFAZZ0bONm1oSEJtenqDhBA2OqcXyLLJg1GOlnTLU_byMuedlxttg>
 <xmx:caFAZTGUsrwJL7JdHCqafVILcXrbrEWawm_SzndZlOoC930p4dCg8g>
 <xmx:caFAZS-7P2WQjSax97cikL8bcTlDZaTp7HHlQ-AqbXxUjc1dNXZZsA>
 <xmx:cqFAZaBdrxedoSvxTWI0jvImxXLGi4sEQhJHMCuAwLellnSDjkhURA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:40:49 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Adam Sampson <ats@offog.org>,
 Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 3/5] phy: sun4i-usb: Control supplies via the regulator uclass
Date: Tue, 31 Oct 2023 01:39:53 -0500
Message-ID: <20231031064039.50942-4-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031064039.50942-1-samuel@sholland.org>
References: <20231031064039.50942-1-samuel@sholland.org>
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

The device tree binding for the PHY provides VBUS supplies as regulator
references. Now that all boards have the appropriate regulator uclass
drivers enabled, the PHY driver can switch to using them. This replaces
direct GPIO usage, which in some cases needed a special DM-incompatible
"virtual" GPIO from the PMIC.

The following boards provided a value for CONFIG_USB0_VBUS_PIN, but are
missing the "usb0_vbus-supply" property in their device tree. None of
them have the MUSB controller enabled in host or OTG mode, so they
should see no impact:
 - Ainol_AW1_defconfig / sun7i-a20-ainol-aw1
 - Ampe_A76_defconfig / sun5i-a13-ampe-a76
 - CHIP_pro_defconfig / sun5i-gr8-chip-pro
 - Cubieboard4_defconfig / sun9i-a80-cubieboard4
 - Merrii_A80_Optimus_defconfig / sun9i-a80-optimus
 - Sunchip_CX-A99_defconfig / sun9i-a80-cx-a99
 - Yones_Toptech_BD1078_defconfig / sun7i-a20-yones-toptech-bd1078
 - Yones_Toptech_BS1078_V2_defconfig /
   sun6i-a31s-yones-toptech-bs1078-v2
 - iNet_3F_defconfig / sun4i-a10-inet-3f
 - iNet_3W_defconfig / sun4i-a10-inet-3w
 - iNet_86VS_defconfig / sun5i-a13-inet-86vs
 - iNet_D978_rev2_defconfig / sun8i-a33-inet-d978-rev2
 - icnova-a20-swac_defconfig / sun7i-a20-icnova-swac
 - sun8i_a23_evb_defconfig / sun8i-a23-evb

Similarly, the following boards set CONFIG_USB1_VBUS_PIN, but do not
have "usb1_vbus-supply" in their device tree. Neither of them have USB
enabled at all, so again there should be no impact:
 - Cubieboard4_defconfig / sun9i-a80-cubieboard4 (also for USB3)
 - sun8i_a23_evb_defconfig / sun8i-a23-evb

The following boards use a different pin for USB1 VBUS between their
defconfig and their device tree. Depending on which is correct, they
may be broken:
 - Linksprite_pcDuino3_Nano_defconfig (PH11) /
   sun7i-a20-pcduino3-nano (PD2)
 - icnova-a20-swac_defconfig (PG10) / sun7i-a20-icnova-swac (PH6)

Finally, this board has conflicting pins given for its USB2 VBUS:
 - Lamobo_R1_defconfig (PH3) / sun7i-a20-lamobo-r1 (PH12)

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/phy/allwinner/phy-sun4i-usb.c | 41 +++++++++++++--------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 6624e9134f4..dc34b828a3a 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -87,27 +87,22 @@ struct sun4i_usb_phy_cfg {
 };
 
 struct sun4i_usb_phy_info {
-	const char *gpio_vbus;
 	const char *gpio_vbus_det;
 	const char *gpio_id_det;
 } phy_info[] = {
 	{
-		.gpio_vbus = CONFIG_USB0_VBUS_PIN,
 		.gpio_vbus_det = CONFIG_USB0_VBUS_DET,
 		.gpio_id_det = CONFIG_USB0_ID_DET,
 	},
 	{
-		.gpio_vbus = CONFIG_USB1_VBUS_PIN,
 		.gpio_vbus_det = NULL,
 		.gpio_id_det = NULL,
 	},
 	{
-		.gpio_vbus = CONFIG_USB2_VBUS_PIN,
 		.gpio_vbus_det = NULL,
 		.gpio_id_det = NULL,
 	},
 	{
-		.gpio_vbus = CONFIG_USB3_VBUS_PIN,
 		.gpio_vbus_det = NULL,
 		.gpio_id_det = NULL,
 	},
@@ -115,12 +110,12 @@ struct sun4i_usb_phy_info {
 
 struct sun4i_usb_phy_plat {
 	void __iomem *pmu;
-	struct gpio_desc gpio_vbus;
 	struct gpio_desc gpio_vbus_det;
 	struct gpio_desc gpio_id_det;
 	struct clk clocks;
 	struct clk clk2;
 	struct reset_ctl resets;
+	struct udevice *vbus;
 	int id;
 };
 
@@ -209,6 +204,7 @@ static int sun4i_usb_phy_power_on(struct phy *phy)
 {
 	struct sun4i_usb_phy_data *data = dev_get_priv(phy->dev);
 	struct sun4i_usb_phy_plat *usb_phy = &data->usb_phy[phy->id];
+	int ret;
 
 	if (initial_usb_scan_delay) {
 		mdelay(initial_usb_scan_delay);
@@ -221,8 +217,11 @@ static int sun4i_usb_phy_power_on(struct phy *phy)
 		return 0;
 	}
 
-	if (dm_gpio_is_valid(&usb_phy->gpio_vbus))
-		dm_gpio_set_value(&usb_phy->gpio_vbus, 1);
+	if (usb_phy->vbus) {
+		ret = regulator_set_enable(usb_phy->vbus, true);
+		if (ret && ret != -ENOSYS)
+			return ret;
+	}
 
 	return 0;
 }
@@ -231,9 +230,13 @@ static int sun4i_usb_phy_power_off(struct phy *phy)
 {
 	struct sun4i_usb_phy_data *data = dev_get_priv(phy->dev);
 	struct sun4i_usb_phy_plat *usb_phy = &data->usb_phy[phy->id];
+	int ret;
 
-	if (dm_gpio_is_valid(&usb_phy->gpio_vbus))
-		dm_gpio_set_value(&usb_phy->gpio_vbus, 0);
+	if (usb_phy->vbus) {
+		ret = regulator_set_enable(usb_phy->vbus, false);
+		if (ret && ret != -ENOSYS)
+			return ret;
+	}
 
 	return 0;
 }
@@ -483,22 +486,16 @@ static int sun4i_usb_phy_probe(struct udevice *dev)
 	for (i = 0; i < data->cfg->num_phys; i++) {
 		struct sun4i_usb_phy_plat *phy = &plat[i];
 		struct sun4i_usb_phy_info *info = &phy_info[i];
-		char name[16];
+		char name[32];
 
 		if (data->cfg->missing_phys & BIT(i))
 			continue;
 
-		ret = dm_gpio_lookup_name(info->gpio_vbus, &phy->gpio_vbus);
-		if (ret == 0) {
-			ret = dm_gpio_request(&phy->gpio_vbus, "usb_vbus");
-			if (ret)
-				return ret;
-			ret = dm_gpio_set_dir_flags(&phy->gpio_vbus,
-						    GPIOD_IS_OUT);
-			if (ret)
-				return ret;
-			ret = dm_gpio_set_value(&phy->gpio_vbus, 0);
-			if (ret)
+		snprintf(name, sizeof(name), "usb%d_vbus-supply", i);
+		ret = device_get_supply_regulator(dev, name, &phy->vbus);
+		if (phy->vbus) {
+			ret = regulator_set_enable(phy->vbus, false);
+			if (ret && ret != -ENOSYS)
 				return ret;
 		}
 
-- 
2.41.0

