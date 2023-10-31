Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA1C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 06:41:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF5C587B07;
	Tue, 31 Oct 2023 07:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sholland.org header.i=@sholland.org header.b="CVL8PfQt";
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASsWU1Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD56487B0A; Tue, 31 Oct 2023 07:41:04 +0100 (CET)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com
 [64.147.123.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F0687559
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:40:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sholland.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=samuel@sholland.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.west.internal (Postfix) with ESMTP id EFAB83200A42;
 Tue, 31 Oct 2023 02:40:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute6.internal (MEProxy); Tue, 31 Oct 2023 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm1; t=1698734455; x=
 1698820855; bh=1QJKhepAVt61ztA9Q/JgKFMmMaeNBD+Lah0Rxi4GZVM=; b=C
 VL8PfQtCnnhu3XTsAGzpBBVL0oA+GJJp8R2WmA5kz/tyWNMItBUjvRUkSpQePdDC
 mhUKqFEifBf5PBdFCQsbQwatJcQQqGbZ2vlTW78oXW8mRUSBHyBjM40k8V4X0AHb
 WhG7/pguIbpZsJtA+kMDwoWPWi3qxvjTaOOejWYrwVpkYTu5jPeC09kO3Vxt+x0y
 ZjakcYA0U9VJuI2r6vm+vmhOM1/rXmlZ82AgtvSmFfExshvVv1r+/gmRr9OLlp5G
 ZoGsGHcZt2feJfea4KgrosdeBoTH8vLM3SAZ4KlKcEffFNX8/0vbPXEazzD/Ds83
 DDh3JuO3ngfDRM79j6VFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698734455; x=
 1698820855; bh=1QJKhepAVt61ztA9Q/JgKFMmMaeNBD+Lah0Rxi4GZVM=; b=A
 SsWU1DgOHclnxY+PUr2B18JjvQ44i0AUwe85ZUI1YVCj7ykthzUs2TjxBcy10CRz
 t99JbbtJoYgQgkfVZaNN5afbay47ooBTY1CfDyiSrUiKeOw4t/gCMALgzpjTuyWj
 mVIfX4IRnkRtElTIIg30WzqP1Kq1A7ECSbqDSRSKf1O2gVlaGNjNDcTcBZG7+ZPu
 lc/Iu925neD4JAlfiXLlmhZKXkEiF5DvASCW8BAqAaZCovgltgCB4Bafe0f1nhd6
 MoeYlvRrqtQ7A7qCFaQC7rrxlpvMEI37DJuQz5vodTjxYdL/6HtHZCecZiOxJYEy
 IwT7Ny+dulNtZW8sRN52g==
X-ME-Sender: <xms:d6FAZRmk-3ZHyld0QkFNo3qIdfPX5KgYCegWo9bNI_puRgp97ZYsdA>
 <xme:d6FAZc1wlfsT9cG46IQe-1_wCsypngs-h2Q1mUGgWISRQlgYpr8SK-N3wtHH8vn7G
 i--u-9K2EqXSLgNLw>
X-ME-Received: <xmr:d6FAZXqNVRwo19Zm0aVS9M8WLjxded8K_vr7dz25VtQ7jM-ILzsZq0_iwqxvoXxyISsCyG0iUXerXbUg1B15rw0AdlY-M81AGgrXcsAUsQ3ftfD5ayAQxFodPvZjUSGEMZjDBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtuddgleehucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
 vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
 ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
 udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:d6FAZRlF5Go7d5xBIjpLFbyj5E-n2oRcjy-NfIFNP3W3PaGTp0E2Pw>
 <xmx:d6FAZf2llTZZK1xk-5gz__TemVd8acyuNxvZqdtIb4W7TnU41q9Ywg>
 <xmx:d6FAZQuX-5x5CSpqa4cwjCvXdHuN33IJAWNUh70tLEaC2aAa8rgFzg>
 <xmx:d6FAZRze6LjmRbkJM_ossK9moSXRNF-Tw3DszacdnKnSvZ3Q_vCG9Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 02:40:54 -0400 (EDT)
From: Samuel Holland <samuel@sholland.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>
Cc: Icenowy Zheng <icenowy@aosc.xyz>, Hans de Goede <hdegoede@redhat.com>,
 Chen-Yu Tsai <wens@csie.org>, Adam Sampson <ats@offog.org>,
 Stefan Roese <sr@denx.de>, Maxime Ripard <mripard@kernel.org>,
 u-boot@lists.denx.de, Samuel Holland <samuel@sholland.org>,
 Joe Hershberger <joe.hershberger@ni.com>
Subject: [PATCH 5/5] gpio: axp: Remove virtual VBUS enable GPIO
Date: Tue, 31 Oct 2023 01:39:55 -0500
Message-ID: <20231031064039.50942-6-samuel@sholland.org>
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

Now that this functionality is modeled using the device tree and
regulator uclass, the named GPIO is not referenced anywhere. Remove
it, along with the rest of the support for AXP virtual GPIOs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/gpio/axp_gpio.c   | 75 +++++++++++----------------------------
 drivers/gpio/sunxi_gpio.c |  8 -----
 include/axp221.h          |  4 ---
 include/axp809.h          |  4 ---
 include/axp818.h          |  4 ---
 include/sunxi_gpio.h      |  8 -----
 6 files changed, 21 insertions(+), 82 deletions(-)

diff --git a/drivers/gpio/axp_gpio.c b/drivers/gpio/axp_gpio.c
index af6631697f5..b10c3fe1934 100644
--- a/drivers/gpio/axp_gpio.c
+++ b/drivers/gpio/axp_gpio.c
@@ -16,6 +16,9 @@
 #include <errno.h>
 #include <sunxi_gpio.h>
 
+#define AXP_GPIO_PREFIX			"AXP0-"
+#define AXP_GPIO_COUNT			4
+
 static int axp_gpio_set_value(struct udevice *dev, unsigned pin, int val);
 
 static u8 axp_get_gpio_ctrl_reg(unsigned pin)
@@ -47,28 +50,14 @@ static int axp_gpio_direction_input(struct udevice *dev, unsigned pin)
 static int axp_gpio_direction_output(struct udevice *dev, unsigned pin,
 				     int val)
 {
-	__maybe_unused int ret;
 	u8 reg;
 
-	switch (pin) {
-#ifdef AXP_MISC_CTRL_N_VBUSEN_FUNC
-	/* Only available on later PMICs */
-	case SUNXI_GPIO_AXP0_VBUS_ENABLE:
-		ret = pmic_bus_clrbits(AXP_MISC_CTRL,
-				       AXP_MISC_CTRL_N_VBUSEN_FUNC);
-		if (ret)
-			return ret;
-
-		return axp_gpio_set_value(dev, pin, val);
-#endif
-	default:
-		reg = axp_get_gpio_ctrl_reg(pin);
-		if (reg == 0)
-			return -EINVAL;
+	reg = axp_get_gpio_ctrl_reg(pin);
+	if (reg == 0)
+		return -EINVAL;
 
-		return pmic_bus_write(reg, val ? AXP_GPIO_CTRL_OUTPUT_HIGH :
-						 AXP_GPIO_CTRL_OUTPUT_LOW);
-	}
+	return pmic_bus_write(reg, val ? AXP_GPIO_CTRL_OUTPUT_HIGH :
+					 AXP_GPIO_CTRL_OUTPUT_LOW);
 }
 
 static int axp_gpio_get_value(struct udevice *dev, unsigned pin)
@@ -76,25 +65,16 @@ static int axp_gpio_get_value(struct udevice *dev, unsigned pin)
 	u8 reg, val, mask;
 	int ret;
 
-	switch (pin) {
-#ifdef AXP_MISC_CTRL_N_VBUSEN_FUNC
-	/* Only available on later PMICs */
-	case SUNXI_GPIO_AXP0_VBUS_ENABLE:
-		ret = pmic_bus_read(AXP_VBUS_IPSOUT, &val);
-		mask = AXP_VBUS_IPSOUT_DRIVEBUS;
-		break;
-#endif
-	default:
-		reg = axp_get_gpio_ctrl_reg(pin);
-		if (reg == 0)
-			return -EINVAL;
+	reg = axp_get_gpio_ctrl_reg(pin);
+	if (reg == 0)
+		return -EINVAL;
 
-		ret = pmic_bus_read(AXP_GPIO_STATE, &val);
-		mask = 1 << (pin + AXP_GPIO_STATE_OFFSET);
-	}
+	ret = pmic_bus_read(AXP_GPIO_STATE, &val);
 	if (ret)
 		return ret;
 
+	mask = 1 << (pin + AXP_GPIO_STATE_OFFSET);
+
 	return (val & mask) ? 1 : 0;
 }
 
@@ -102,25 +82,12 @@ static int axp_gpio_set_value(struct udevice *dev, unsigned pin, int val)
 {
 	u8 reg;
 
-	switch (pin) {
-#ifdef AXP_MISC_CTRL_N_VBUSEN_FUNC
-	/* Only available on later PMICs */
-	case SUNXI_GPIO_AXP0_VBUS_ENABLE:
-		if (val)
-			return pmic_bus_setbits(AXP_VBUS_IPSOUT,
-						AXP_VBUS_IPSOUT_DRIVEBUS);
-		else
-			return pmic_bus_clrbits(AXP_VBUS_IPSOUT,
-						AXP_VBUS_IPSOUT_DRIVEBUS);
-#endif
-	default:
-		reg = axp_get_gpio_ctrl_reg(pin);
-		if (reg == 0)
-			return -EINVAL;
+	reg = axp_get_gpio_ctrl_reg(pin);
+	if (reg == 0)
+		return -EINVAL;
 
-		return pmic_bus_write(reg, val ? AXP_GPIO_CTRL_OUTPUT_HIGH :
-						 AXP_GPIO_CTRL_OUTPUT_LOW);
-	}
+	return pmic_bus_write(reg, val ? AXP_GPIO_CTRL_OUTPUT_HIGH :
+					 AXP_GPIO_CTRL_OUTPUT_LOW);
 }
 
 static const struct dm_gpio_ops gpio_axp_ops = {
@@ -135,8 +102,8 @@ static int gpio_axp_probe(struct udevice *dev)
 	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
 
 	/* Tell the uclass how many GPIOs we have */
-	uc_priv->bank_name = strdup(SUNXI_GPIO_AXP0_PREFIX);
-	uc_priv->gpio_count = SUNXI_GPIO_AXP0_GPIO_COUNT;
+	uc_priv->bank_name = AXP_GPIO_PREFIX;
+	uc_priv->gpio_count = AXP_GPIO_COUNT;
 
 	return 0;
 }
diff --git a/drivers/gpio/sunxi_gpio.c b/drivers/gpio/sunxi_gpio.c
index e4463a223f7..b5e74a0da94 100644
--- a/drivers/gpio/sunxi_gpio.c
+++ b/drivers/gpio/sunxi_gpio.c
@@ -247,15 +247,7 @@ int sunxi_name_to_gpio(const char *name)
 {
 	unsigned int gpio;
 	int ret;
-#if !defined CONFIG_SPL_BUILD && defined CONFIG_AXP_GPIO
-	char lookup[8];
 
-	if (strcasecmp(name, "AXP0-VBUS-ENABLE") == 0) {
-		sprintf(lookup, SUNXI_GPIO_AXP0_PREFIX "%d",
-			SUNXI_GPIO_AXP0_VBUS_ENABLE);
-		name = lookup;
-	}
-#endif
 	ret = gpio_lookup_name(name, NULL, NULL, &gpio);
 
 	return ret ? ret : gpio;
diff --git a/include/axp221.h b/include/axp221.h
index 32b988f3a9c..8a4a3cca82f 100644
--- a/include/axp221.h
+++ b/include/axp221.h
@@ -53,10 +53,6 @@
 #ifdef CONFIG_AXP221_POWER
 #define AXP_POWER_STATUS		0x00
 #define AXP_POWER_STATUS_ALDO_IN		BIT(0)
-#define AXP_VBUS_IPSOUT			0x30
-#define AXP_VBUS_IPSOUT_DRIVEBUS		(1 << 2)
-#define AXP_MISC_CTRL			0x8f
-#define AXP_MISC_CTRL_N_VBUSEN_FUNC		(1 << 4)
 #define AXP_GPIO0_CTRL			0x90
 #define AXP_GPIO1_CTRL			0x92
 #define AXP_GPIO_CTRL_OUTPUT_LOW		0x00 /* Drive pin low */
diff --git a/include/axp809.h b/include/axp809.h
index 71a7cb2aaa1..3bd71b3d1a3 100644
--- a/include/axp809.h
+++ b/include/axp809.h
@@ -47,10 +47,6 @@
 #ifdef CONFIG_AXP809_POWER
 #define AXP_POWER_STATUS		0x00
 #define AXP_POWER_STATUS_ALDO_IN		BIT(0)
-#define AXP_VBUS_IPSOUT			0x30
-#define AXP_VBUS_IPSOUT_DRIVEBUS		(1 << 2)
-#define AXP_MISC_CTRL			0x8f
-#define AXP_MISC_CTRL_N_VBUSEN_FUNC		(1 << 4)
 #define AXP_GPIO0_CTRL			0x90
 #define AXP_GPIO1_CTRL			0x92
 #define AXP_GPIO_CTRL_OUTPUT_LOW	0x00 /* Drive pin low */
diff --git a/include/axp818.h b/include/axp818.h
index 08ac35d15fa..b3a9686e0e5 100644
--- a/include/axp818.h
+++ b/include/axp818.h
@@ -61,10 +61,6 @@
 #ifdef CONFIG_AXP818_POWER
 #define AXP_POWER_STATUS		0x00
 #define AXP_POWER_STATUS_ALDO_IN		BIT(0)
-#define AXP_VBUS_IPSOUT			0x30
-#define AXP_VBUS_IPSOUT_DRIVEBUS		(1 << 2)
-#define AXP_MISC_CTRL			0x8f
-#define AXP_MISC_CTRL_N_VBUSEN_FUNC		(1 << 4)
 #define AXP_GPIO0_CTRL			0x90
 #define AXP_GPIO1_CTRL			0x92
 #define AXP_GPIO_CTRL_OUTPUT_LOW	0x00 /* Drive pin low */
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index db3742c0397..31783e08732 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -82,7 +82,6 @@ enum sunxi_gpio_number {
 	SUNXI_GPIO_L_START = 352,
 	SUNXI_GPIO_M_START = SUNXI_GPIO_NEXT(SUNXI_GPIO_L),
 	SUNXI_GPIO_N_START = SUNXI_GPIO_NEXT(SUNXI_GPIO_M),
-	SUNXI_GPIO_AXP0_START = 1024,
 };
 
 /* SUNXI GPIO number definitions */
@@ -99,8 +98,6 @@ enum sunxi_gpio_number {
 #define SUNXI_GPM(_nr)	(SUNXI_GPIO_M_START + (_nr))
 #define SUNXI_GPN(_nr)	(SUNXI_GPIO_N_START + (_nr))
 
-#define SUNXI_GPAXP0(_nr)	(SUNXI_GPIO_AXP0_START + (_nr))
-
 /* GPIO pin function config */
 #define SUNXI_GPIO_INPUT	0
 #define SUNXI_GPIO_OUTPUT	1
@@ -185,11 +182,6 @@ enum sunxi_gpio_number {
 #define SUNXI_GPIO_PULL_UP	1
 #define SUNXI_GPIO_PULL_DOWN	2
 
-/* Virtual AXP0 GPIOs */
-#define SUNXI_GPIO_AXP0_PREFIX "AXP0-"
-#define SUNXI_GPIO_AXP0_VBUS_ENABLE	5
-#define SUNXI_GPIO_AXP0_GPIO_COUNT	6
-
 struct sunxi_gpio_plat {
 	void			*regs;
 	char			bank_name[3];
-- 
2.41.0

