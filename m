Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9154CC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93BB687AFA;
	Tue, 31 Oct 2023 07:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="nTgRvtIn";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ccOUnFWV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF67987510; Tue, 31 Oct 2023 07:40:55 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F100887AF6
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:40:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
 by mailout.west.internal (Postfix) with ESMTP id B5A673200684;
 Tue, 31 Oct 2023 02:40:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute7.internal (MEProxy); Tue, 31 Oct 2023 02:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698734447; x=
 1698820847; bh=Qi/BM0NmQ3DoVz89j53uhrdufky7idppg7YatcKnEBY=; b=n
 TgRvtIn6e5uIeqblis6WAgEmrGWe4NRH7jX9MJer4v1LTDlkRXxMjEa7YMZRX6Ac
 X1itUDTECaXlFWrGXg0UZOULPe9nNnruww1UvY5mJTD6NWHDnNEFYESyXxyRUVoR
 bwz6yToVA1agtDq081LUR9vaiVl0aWCaE0y9+J893R/nR4/sZMgeOQA51F5heYT3
 rvqi7BIYnnub+yCkGu0C10R1c49T9wiFA6gO1Cl8VvGshCKH4sob8prrEpurKPMQ
 XlJY/PYYGhGALYuAOAbDt5RG0OfUEiAy9jOROgfWISCs1sdd4DQ82/7vY6vhtR8s
 q72jBuGTB7jAbvE4ZKk8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698734447; x=
 1698820847; bh=Qi/BM0NmQ3DoVz89j53uhrdufky7idppg7YatcKnEBY=; b=c
 cOUnFWVSk32ni2KklhErDpZYqb3RLlnqGtU8sFn5yzJZdqf3Jgb20qxQGzKXuLqq
 t2nt2cHiIFO70z5Td2PKCalkJl2cIH8rhqUvMqZH+211D2nrTAsmJ0iCkL7q8vdH
 zXWWweVuQYdi/KriNRwsKRkGU4oUExoma9wya+X1bhJBGfMIGc5Hye1bO6m0rx4d
 AOyZezWvc3ng9rIQa2W7oOLie0cvdGoxmCW9a4qXSS2mmwx2kqzfDbAzxWG7WnA+
 DUYlrJXxTs6UspYNNo2dPmry6R9V2G+r+zWc9xh7r/KD0UehhLaUZMXVKQ5i9Z07
 emKPsjC08uQ2cbl+uOGAQ==
X-ME-Sender: <xms:b6FAZVmRrjc-5uRN1btnNiT-RJcfSlEI9tVGO5PrC89okClc7yHjVQ>
 <xme:b6FAZQ316_9-UbJqnW4jVnTpeTFOHxKaZHwAf4ibkAJLlcWSH8ESE_AhBK94J4Ut9
 aZ6Q-YvTEUEG317nA>
X-ME-Received: <xmr:b6FAZbpc_Ro1VJaQ-K00O5Q4sZWqAmCKtHcAY2En98PNrC8zYcUrmwxTVDNHYkzC23H7BxWzQHu6Nsw4hd_GBPsERaQe22EqS6ZGKOdrU_oFrXehNGPFprsLU_3L7hjC24pH1A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleeiucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:b6FAZVkDiyusnTgEIXKEYGpoml9rkQDoc9IPdVT0KZsOcwQ-fY8ixw>
 <xmx:b6FAZT0ngu-w-NcHDjgbEwSFBD6F-t2bT_o-X4NNSqIn-5ay5XbuOw>
 <xmx:b6FAZUsfznyQtpzo4ShpNomKXUNHMGFmg27umO_MrK5aMWywVSZjXA>
 <xmx:b6FAZVysuyXc-VzsYFMsNuilD8URyR9GY7PCo5SFrqSLcmQqStdMPQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:40:46 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Adam Sampson <ats@offog.org>,
 Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 2/5] sunxi: Enable PMIC drivevbus regulator support for USB
 supplies
Date: Tue, 31 Oct 2023 01:39:52 -0500
Message-ID: <20231031064039.50942-3-samuel@sholland.org>
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

On many boards, the USB ports are powered by the PMIC's "drivevbus"
regulator. In preparation for switching the USB PHY driver to use the
regulator uclass instead of a virtual GPIO pin, ensure these boards
have AXP PMIC regulator support enabled.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 configs/A33-OLinuXino_defconfig           | 1 +
 configs/Cubieboard4_defconfig             | 1 +
 configs/Cubietruck_plus_defconfig         | 1 +
 configs/MSI_Primo81_defconfig             | 1 +
 configs/Merrii_A80_Optimus_defconfig      | 1 +
 configs/Sinovoip_BPI_M3_defconfig         | 1 +
 configs/Yones_Toptech_BS1078_V2_defconfig | 1 +
 configs/colorfly_e708_q1_defconfig        | 1 +
 configs/ga10h_v1_1_defconfig              | 1 +
 configs/gt90h_v4_defconfig                | 1 +
 configs/iNet_D978_rev2_defconfig          | 1 +
 configs/inet86dz_defconfig                | 1 +
 configs/inet_q972_defconfig               | 1 +
 configs/polaroid_mid2407pxe03_defconfig   | 1 +
 configs/polaroid_mid2809pxe04_defconfig   | 1 +
 configs/q8_a23_tablet_800x480_defconfig   | 1 +
 configs/q8_a33_tablet_1024x600_defconfig  | 1 +
 configs/q8_a33_tablet_800x480_defconfig   | 1 +
 configs/tbs_a711_defconfig                | 1 +
 19 files changed, 19 insertions(+)

diff --git a/configs/A33-OLinuXino_defconfig b/configs/A33-OLinuXino_defconfig
index df4acaf33e2..705c869c19f 100644
--- a/configs/A33-OLinuXino_defconfig
+++ b/configs/A33-OLinuXino_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_BL_EN="PB2"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DCDC1_VOLT=3300
 CONFIG_USB_MUSB_HOST=y
diff --git a/configs/Cubieboard4_defconfig b/configs/Cubieboard4_defconfig
index d3678ad5c75..c8adabe0a0a 100644
--- a/configs/Cubieboard4_defconfig
+++ b/configs/Cubieboard4_defconfig
@@ -11,5 +11,6 @@ CONFIG_USB1_VBUS_PIN="PH14"
 CONFIG_USB3_VBUS_PIN="PH15"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP809_POWER=y
diff --git a/configs/Cubietruck_plus_defconfig b/configs/Cubietruck_plus_defconfig
index 29f4df2b81c..f349d9bc49f 100644
--- a/configs/Cubietruck_plus_defconfig
+++ b/configs/Cubietruck_plus_defconfig
@@ -21,6 +21,7 @@ CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO3_VOLT=2500
 CONFIG_AXP_DLDO4_VOLT=3300
diff --git a/configs/MSI_Primo81_defconfig b/configs/MSI_Primo81_defconfig
index d60eedb482a..709d27d342e 100644
--- a/configs/MSI_Primo81_defconfig
+++ b/configs/MSI_Primo81_defconfig
@@ -12,6 +12,7 @@ CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 CONFIG_VIDEO_LCD_PANEL_MIPI_4_LANE_513_MBPS_VIA_SSD2828=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/configs/Merrii_A80_Optimus_defconfig b/configs/Merrii_A80_Optimus_defconfig
index a26677e1c05..c7a3af7a8d1 100644
--- a/configs/Merrii_A80_Optimus_defconfig
+++ b/configs/Merrii_A80_Optimus_defconfig
@@ -11,5 +11,6 @@ CONFIG_USB1_VBUS_PIN="PH4"
 CONFIG_USB3_VBUS_PIN="PH5"
 CONFIG_AXP_GPIO=y
 CONFIG_SYS_I2C_SUN8I_RSB=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP809_POWER=y
diff --git a/configs/Sinovoip_BPI_M3_defconfig b/configs/Sinovoip_BPI_M3_defconfig
index ad41dbd26a1..fcdd7ded82d 100644
--- a/configs/Sinovoip_BPI_M3_defconfig
+++ b/configs/Sinovoip_BPI_M3_defconfig
@@ -17,6 +17,7 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
 CONFIG_INITIAL_USB_SCAN_DELAY=500
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DCDC5_VOLT=1200
 CONFIG_AXP_DLDO3_VOLT=3300
diff --git a/configs/Yones_Toptech_BS1078_V2_defconfig b/configs/Yones_Toptech_BS1078_V2_defconfig
index de69ebe9956..67fef2a6202 100644
--- a/configs/Yones_Toptech_BS1078_V2_defconfig
+++ b/configs/Yones_Toptech_BS1078_V2_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_USB_MUSB_HOST=y
diff --git a/configs/colorfly_e708_q1_defconfig b/configs/colorfly_e708_q1_defconfig
index 07bda049665..201b7425573 100644
--- a/configs/colorfly_e708_q1_defconfig
+++ b/configs/colorfly_e708_q1_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_AXP_DLDO2_VOLT=1800
diff --git a/configs/ga10h_v1_1_defconfig b/configs/ga10h_v1_1_defconfig
index 935071d61ac..5d083742f1f 100644
--- a/configs/ga10h_v1_1_defconfig
+++ b/configs/ga10h_v1_1_defconfig
@@ -16,6 +16,7 @@ CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/gt90h_v4_defconfig b/configs/gt90h_v4_defconfig
index 205eab29293..6502ac8cf43 100644
--- a/configs/gt90h_v4_defconfig
+++ b/configs/gt90h_v4_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/iNet_D978_rev2_defconfig b/configs/iNet_D978_rev2_defconfig
index ed6a6038424..70be98030a0 100644
--- a/configs/iNet_D978_rev2_defconfig
+++ b/configs/iNet_D978_rev2_defconfig
@@ -15,6 +15,7 @@ CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 CONFIG_VIDEO_LCD_PANEL_LVDS=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 # CONFIG_REQUIRE_SERIAL_CONSOLE is not set
diff --git a/configs/inet86dz_defconfig b/configs/inet86dz_defconfig
index d215a8375e2..3405bc423a3 100644
--- a/configs/inet86dz_defconfig
+++ b/configs/inet86dz_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/inet_q972_defconfig b/configs/inet_q972_defconfig
index 24ff6c0062e..a70a83ebcd0 100644
--- a/configs/inet_q972_defconfig
+++ b/configs/inet_q972_defconfig
@@ -13,6 +13,7 @@ CONFIG_VIDEO_LCD_DCLK_PHASE=0
 CONFIG_VIDEO_LCD_BL_EN="PA25"
 CONFIG_VIDEO_LCD_BL_PWM="PH13"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/polaroid_mid2407pxe03_defconfig b/configs/polaroid_mid2407pxe03_defconfig
index 6ec7c83be5b..2155fe6646f 100644
--- a/configs/polaroid_mid2407pxe03_defconfig
+++ b/configs/polaroid_mid2407pxe03_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/polaroid_mid2809pxe04_defconfig b/configs/polaroid_mid2809pxe04_defconfig
index 1aefc50588e..1faf78f1b54 100644
--- a/configs/polaroid_mid2809pxe04_defconfig
+++ b/configs/polaroid_mid2809pxe04_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/q8_a23_tablet_800x480_defconfig b/configs/q8_a23_tablet_800x480_defconfig
index 0f8c30ec853..08ba34e08ee 100644
--- a/configs/q8_a23_tablet_800x480_defconfig
+++ b/configs/q8_a23_tablet_800x480_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/q8_a33_tablet_1024x600_defconfig b/configs/q8_a33_tablet_1024x600_defconfig
index b3b5cc704f4..6efbd84f7c3 100644
--- a/configs/q8_a33_tablet_1024x600_defconfig
+++ b/configs/q8_a33_tablet_1024x600_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/q8_a33_tablet_800x480_defconfig b/configs/q8_a33_tablet_800x480_defconfig
index 37ee08fa629..bf5dcd0d018 100644
--- a/configs/q8_a33_tablet_800x480_defconfig
+++ b/configs/q8_a33_tablet_800x480_defconfig
@@ -14,6 +14,7 @@ CONFIG_VIDEO_LCD_POWER="PH7"
 CONFIG_VIDEO_LCD_BL_EN="PH6"
 CONFIG_VIDEO_LCD_BL_PWM="PH0"
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DLDO1_VOLT=3300
 CONFIG_CONS_INDEX=5
diff --git a/configs/tbs_a711_defconfig b/configs/tbs_a711_defconfig
index 9a70b6bee52..c17815382ec 100644
--- a/configs/tbs_a711_defconfig
+++ b/configs/tbs_a711_defconfig
@@ -13,6 +13,7 @@ CONFIG_USB0_ID_DET="PH11"
 CONFIG_AXP_GPIO=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FASTBOOT_CMD_OEM_FORMAT=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_REGULATOR_AXP_USB_POWER=y
 CONFIG_AXP_DCDC5_VOLT=1200
 CONFIG_USB_EHCI_HCD=y
-- 
2.41.0

