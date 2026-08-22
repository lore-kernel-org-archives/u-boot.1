Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B02C5B572
	for <u-boot@archiver.kernel.org>; Sat, 22 Aug 2026 11:30:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5B25D606EB;
	Sat, 22 Aug 2026 11:30:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vb5R6tMR4uBA; Sat, 22 Aug 2026 11:30:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787398243;
	bh=ugmIi8Zi0Ybfo8gEchGvADWMKcCetyRX6jH3Xu8REXI=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X7PWip/PMGzdukoLc7BCJdoRhf7VFK9Mv2sgck26bCpeZ6RwwGLQc2ce0fKRRXYsg
	 hJzLjHMy1rTc2lCVDmcT3Z12WW6yul+uHLffWlV7T1NmbZPC8oh3RJb8BwzpQV4hSj
	 KnjHkXTHwZ45Brgu5u1H2yRUk8F3LDjXAZQc7vfhblaCw6I2KieAQOj7BmEpTGDvLr
	 FBEBbI/M+eMNMfvqGuHacMDxQWjZjlPiD4FOAF1tWNDKRXEV1vkKGQ5fZrQAZ8PdWs
	 dLuHeAYsP8fCRDuopT+KMCUUgMru8l084M93xg7sdI4ub9hElMp4ap12Syd6t1wnVo
	 GCo63gQyQoWig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 72FE26069A;
	Sat, 22 Aug 2026 11:30:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E6FEB476
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 11:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CCB9B6069A
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 11:30:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id y6rg6ZYhQOqO for <u-boot@lists.u-boot-project.org>;
 Sat, 22 Aug 2026 11:30:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=M5evrGu8
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07F9D6064D
 for <u-boot@lists.u-boot-project.org>; Sat, 22 Aug 2026 11:30:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F66E41710;
 Sat, 22 Aug 2026 11:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C071F000E9;
 Sat, 22 Aug 2026 11:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787398239;
 bh=ugmIi8Zi0Ybfo8gEchGvADWMKcCetyRX6jH3Xu8REXI=;
 h=From:Date:Subject:To:Cc;
 b=M5evrGu8f4OgBL+hspxByuqUPNn6y+nCDTU4Z9hxvZbPYjsX1oV7UFcBauNjfMl6t
 HWITQzfYswZf3jlI5OeU+UKvYR3RsQ3L2bAnrQJBW5ukPflE0R1bn9TyHyOEwnAVXG
 1eS+2r0kt2xZXoCDXuyzkhwVcLQY9OHiWxSDWwUkiVSJ+4+DyepRQNI2EAus2A74AQ
 KvjjOqlb4qfVDx3vLf75p6LqYXXgA5mLK1nRijg0qpwQjyM/yIN0TPoZj0TIYNHjOI
 MSKsr5zLGKfSY1GgarXl/5EoAykDGf4bCZLRNOJdg+8vgqGr1uVD9klozVGT1Me1Dh
 uAWeA/ox/ahKQ==
From: Yixun Lan <dlan@kernel.org>
Date: Sat, 22 Aug 2026 11:30:28 +0000
Subject: [PATCH] gpio: spacemit: add support for K3 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-01-gpio-pinctrl-support-v1-1-6be2f4c71c5d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFOIiWoC/yXMQQrCMBBA0auUWTuQRGqsVxEXJh3riCRhJpVC6
 d0bdfkW/6+gJEwKl24FoQ8r59RgDx3E5z1NhDw2gzPuZLxzaCxOhTMWTrHKG3UuJUvFsx99sP2
 xH4YArS5CD15+5+vtb53Di2L97mDbdgt0AIB7AAAA
X-Change-ID: 20260722-01-gpio-pinctrl-support-87d7b153599b
To: u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io
Cc: Tom Rini <trini@konsulko.com>, Johan Jonker <jbx6244@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6976; i=dlan@kernel.org;
 h=from:subject:message-id; bh=BkX2FFxY3q4UB6+VCChVZR1pOg15+s6hDKUGCuD8I2A=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqiYharm9FmFG4oghdGw9fO5q+0vLYPaA29p+7Z
 7cErO/J59yJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaomIWhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3KBw//U0dnpEv83Fmg0vRSpzDx2S5E4VgSS8iURgYqQMUzPEtWsjN/xB7Ki
 skw5OtkTsrJtlq34UJul67pKwT0lnXmJoMaXjx28y6YWSVCh/NwFIsLD6hPVbh9HYj6j27cMZ3G
 ++i1uRV8RB7sAWtnCjh4dqqCWsm2Tcv0C/ENfW0kT3S0QJeg6yHKWP+8f+FkxU5bxzXzECw9AyQ
 wRW7jzhwkMQRU1F+7RvBSvZRc1CZeSKVoYZOdXVk+r9LqlgXomvdRtbAk+R4FagXenOEDwAB5Kz
 f1kRyDfnWvrQEH4MJK3HcXaSkJro/nDQpHXIvFpcJxQxyyhn/BeOVgCO0LtvGHz3yTElTN5shvo
 jNsrJ5gcJKXvrrHNIFzLBevNQKkvM8EuYe+Qug4gp5+gFWT902qI4eyVy5/f2SIEL5zH9fxBcW7
 HHigjoeQLPo6TMdkBj5X+WLQRgAs3Z0bod7yugGUxwnCxva5ppMCj6VDB0BlCa06eVFbdc0jUHf
 ZcKx4pOEB22oGXOsb9hRyfMydRcl5GJEv6GKlW3P4DhcTJ+zJa+/UZwgl1mFuG15WHTnoRb6DFg
 mFFp64UgA8Cxdqz0yjfJ26Hs4BOeF2bMrx2qUpTCNrou6CnSoHLuF0SEYJyCxQgBj97+dOboP1L
 A81MilnlBanARsTlVK9DJ5GsUZIDOg=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Based on upstream Linux:
  da64eb51595b ("gpio: spacemit: Add GPIO support for K3 SoC")

SpacemiT K3 SoC uses different GPIO register and bank layout compared
to old K1 generation. Refactor the driver by moving hard-coded register
offsets into per-SoC tables and locating them via driver data.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/gpio/Kconfig         | 11 ++---
 drivers/gpio/spacemit_gpio.c | 97 ++++++++++++++++++++++++++++++--------------
 2 files changed, 72 insertions(+), 36 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index a11f3043670..78b4b45be87 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -450,12 +450,13 @@ config SANDBOX_GPIO_COUNT
 	  Select a suitable value depending on your needs.
 
 config SPACEMIT_GPIO
-	bool "Spacemit K1 GPIO driver"
-	depends on DM_GPIO && TARGET_SPACEMIT_K1
+	bool "Spacemit K1/K3 GPIO driver"
+	depends on DM_GPIO && (TARGET_SPACEMIT_K1 || TARGET_SPACEMIT_K3)
 	help
-	  Support the GPIO device in Spacemit SoCs. The GPIOs are arranged
-	  into a number of banks (different for each SoC type) each with 32
-	  GPIOs.
+	  Support the GPIO device in Spacemit K1 and K3 SoCs. The GPIOs are
+	  arranged into a number of banks (different for each SoC type) each
+	  with 32 GPIOs.
+
 
 config SUNXI_GPIO
 	bool "Allwinner GPIO driver"
diff --git a/drivers/gpio/spacemit_gpio.c b/drivers/gpio/spacemit_gpio.c
index de71880df15..e0716a84dfc 100644
--- a/drivers/gpio/spacemit_gpio.c
+++ b/drivers/gpio/spacemit_gpio.c
@@ -19,37 +19,28 @@
 #define GPIO_TO_BANK(pin)	((pin) / GPIO_BANK_SIZE)
 #define GPIO_TO_BIT(pin)	((pin) % GPIO_BANK_SIZE)
 
-static inline int gpio_to_reg_offset(unsigned int pin)
-{
-	unsigned int bank = GPIO_TO_BANK(pin);
-
-	if (bank == 0)
-		return 0;
-	else if (bank == 1)
-		return 4;
-	else if (bank == 2)
-		return 8;
-	else if (bank == 3)
-		return 0x100;
-	log_warning("Use default GPIO bank for an invalid GPIO[%d].\n", pin);
-	return 0;
-}
-
-#define REG_PLR(pin)		(0x00 + gpio_to_reg_offset(pin))
-#define REG_PDR(pin)		(0x0c + gpio_to_reg_offset(pin))
-#define REG_PSR(pin)		(0x18 + gpio_to_reg_offset(pin))
-#define REG_PCR(pin)		(0x24 + gpio_to_reg_offset(pin))
-#define REG_SDR(pin)		(0x54 + gpio_to_reg_offset(pin))
-#define REG_CDR(pin)		(0x60 + gpio_to_reg_offset(pin))
+#define to_spacemit_gpio_regs(priv, reg)	((priv)->data->offsets[reg])
+
+enum spacemit_gpio_registers {
+	SPACEMIT_GPLR,
+	SPACEMIT_GPDR,
+	SPACEMIT_GPSR,
+	SPACEMIT_GPCR,
+	SPACEMIT_GSDR,
+	SPACEMIT_GCDR,
+};
 
 struct spacemit_gpio_data {
 	u16	gpio_base;
 	u16	gpio_count;
 	u8	num_banks;
+	const u16	*bank_offsets;
+	const u16	*offsets;
 };
 
 struct spacemit_gpio_priv {
 	void __iomem *regs;
+	const struct spacemit_gpio_data *data;
 };
 
 static int spacemit_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
@@ -85,10 +76,12 @@ static int spacemit_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
 static int spacemit_gpio_get_value(struct udevice *dev, unsigned int offset)
 {
 	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
-	void __iomem *addr;
+	void __iomem *base, *addr;
 	u32 value, mask;
 
-	addr = priv->regs + REG_PLR(offset);
+	base = priv->regs + priv->data->bank_offsets[GPIO_TO_BANK(offset)];
+
+	addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPLR);
 	value = readl(addr);
 	mask = 1 << GPIO_TO_BIT(offset);
 	return !!(value & mask);
@@ -97,10 +90,12 @@ static int spacemit_gpio_get_value(struct udevice *dev, unsigned int offset)
 static int spacemit_gpio_get_function(struct udevice *dev, unsigned int offset)
 {
 	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
-	void __iomem *addr;
+	void __iomem *base, *addr;
 	u32 value, mask;
 
-	addr = priv->regs + REG_PDR(offset);
+	base = priv->regs + priv->data->bank_offsets[GPIO_TO_BANK(offset)];
+
+	addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPDR);
 	value = readl(addr);
 	mask = 1 << GPIO_TO_BIT(offset);
 	if (value & mask)
@@ -130,23 +125,25 @@ static int spacemit_gpio_set_flags(struct udevice *dev, unsigned int offset,
 				   ulong flags)
 {
 	struct spacemit_gpio_priv *priv = dev_get_priv(dev);
-	void __iomem *addr;
+	void __iomem *base, *addr;
 	int value;
 
+	base = priv->regs + priv->data->bank_offsets[GPIO_TO_BANK(offset)];
+
 	value = (flags & GPIOD_IS_OUT_ACTIVE) ? 1 : 0;
 	if (flags & GPIOD_IS_IN) {
-		addr = priv->regs + REG_CDR(offset);
+		addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GCDR);
 		writel(1 << GPIO_TO_BIT(offset), addr);
 	}
 	if (flags & GPIOD_IS_OUT) {
 		if (value) {
-			addr = priv->regs + REG_PSR(offset);
+			addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPSR);
 			writel(1 << GPIO_TO_BIT(offset), addr);
 		} else {
-			addr = priv->regs + REG_PCR(offset);
+			addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GPCR);
 			writel(1 << GPIO_TO_BIT(offset), addr);
 		}
-		addr = priv->regs + REG_SDR(offset);
+		addr = base + to_spacemit_gpio_regs(priv, SPACEMIT_GSDR);
 		writel(1 << GPIO_TO_BIT(offset), addr);
 	}
 	return 0;
@@ -207,6 +204,7 @@ static int spacemit_gpio_probe(struct udevice *dev)
 
 	data = (struct spacemit_gpio_data *)dev_get_driver_data(dev);
 	priv = dev_get_priv(dev);
+	priv->data = data;
 	priv->regs = dev_read_addr_ptr(dev);
 	if (!priv->regs) {
 		dev_err(dev, "Fail to get base address\n");
@@ -232,14 +230,51 @@ out:
 	return ret;
 }
 
+static const u16 spacemit_gpio_k1_offsets[] = {
+	[SPACEMIT_GPLR] = 0x00,
+	[SPACEMIT_GPDR] = 0x0c,
+	[SPACEMIT_GPSR] = 0x18,
+	[SPACEMIT_GPCR] = 0x24,
+	[SPACEMIT_GSDR] = 0x54,
+	[SPACEMIT_GCDR] = 0x60,
+};
+
+static const u16 spacemit_gpio_k1_bank_offsets[] = {
+	0x0, 0x4, 0x8, 0x100,
+};
+
+static const u16 spacemit_gpio_k3_offsets[] = {
+	[SPACEMIT_GPLR] = 0x00,
+	[SPACEMIT_GPDR] = 0x04,
+	[SPACEMIT_GPSR] = 0x08,
+	[SPACEMIT_GPCR] = 0x0c,
+	[SPACEMIT_GSDR] = 0x1c,
+	[SPACEMIT_GCDR] = 0x20,
+};
+
+static const u16 spacemit_gpio_k3_bank_offsets[] = {
+	0x0, 0x40, 0x80, 0x100,
+};
+
 static const struct spacemit_gpio_data k1_gpio_data = {
 	.num_banks	= 4,
 	.gpio_count	= 128,
 	.gpio_base	= 0,
+	.bank_offsets	= spacemit_gpio_k1_bank_offsets,
+	.offsets	= spacemit_gpio_k1_offsets,
+};
+
+static const struct spacemit_gpio_data k3_gpio_data = {
+	.num_banks	= 4,
+	.gpio_count	= 128,
+	.gpio_base	= 0,
+	.bank_offsets	= spacemit_gpio_k3_bank_offsets,
+	.offsets	= spacemit_gpio_k3_offsets,
 };
 
 static const struct udevice_id spacemit_gpio_ids[] = {
 	{ .compatible = "spacemit,k1-gpio", .data = (uintptr_t)&k1_gpio_data, },
+	{ .compatible = "spacemit,k3-gpio", .data = (uintptr_t)&k3_gpio_data, },
 	{ /* sentinel */ }
 };
 

---
base-commit: 36c377b9859ffb53eb1e39ea31e8d96d1e0fe1e5
change-id: 20260722-01-gpio-pinctrl-support-87d7b153599b

Best regards,
--  
Yixun Lan <dlan@kernel.org>

