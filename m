Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCC0CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 13:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C3983AA4;
	Mon, 10 Nov 2025 14:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="KwwAeCNW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 875E6839C6; Mon, 10 Nov 2025 12:24:40 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F6A98392C
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b72e43405e2so265006566b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 03:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1762773877; x=1763378677; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TKEJpVM91ZvhzdUj4KvOUS08hc3y00Dc921VIR+k7DU=;
 b=KwwAeCNW7/Vc/ECjirQ36HqThR0DGThL77/HRRgtJPp6cOOmStEFLQdIVdZvW6d5eL
 Etenl4E6vE8SpqwpG2v/+HUtBI4Wl5ur8NmRtLr901ZH4Cqb/SQVp6n3LeznDmmgfeap
 Xe1AjzVPo4boqsqZM1abOqWBoML3Ps42ECMng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762773877; x=1763378677;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TKEJpVM91ZvhzdUj4KvOUS08hc3y00Dc921VIR+k7DU=;
 b=ZImCH3KK/UBdtaHQVsoo0xI103y/xNw+Phr2s1XwDzuo6HDBnSfFfH8hBdDy1JRF+8
 sQvsPJ8y/YbrB2AZfOrRIUS/Imm4G/gXy4I+Et7TCBTlXKslZS0iTMt77mczNjpPVDsg
 UjouFybZp+F7crTbritcljbHvAxnVEidDO9puEJb7eiOEEUzAOtA7jJGSk6Pl1efDjOo
 H2+mNLcTIiuF7rjnnbppIi6OxfNkZnJ8g1/+w/HbBTnRxOJiOH7oQD7zPe1rsDZ+cNXc
 6uekSalue5t5NYPS56Pow7Jneq75TlHGuXtzfUUsQnoiABdNdxBaInqcbMMnQNBUjOvv
 vruw==
X-Gm-Message-State: AOJu0Yy+Xr8XWJiSJ0JstoEnsN8NGTe3Iq7WQtxVVqfxiVRkTtGeW0JB
 HcbU8HknyvhHDeexUDg/yNASezxBEqqnFBaVa7tjCLAotyqkQKCt8Q2DYcjcxdUBQQUQOGa75fF
 OAvgZGbbaV6EkDPSmss7H0QxHeHphSqizAkmEYcnaiJdSi2Y1bFKZfeWVvFeD
X-Gm-Gg: ASbGncswqWK04p+BAjV+La0U6grFjImwV0eJY65RZr8KZl0WqWDdCLsu55FqIELJGHS
 +y2JfE8406gLhPgDNcA/50J/6QqEtHxUtspBWa9Ly4Wjc8XGw/204B4v2m5cr5ROB8SZ73N8/76
 a7941QvVGw8pNusUHdt/vV3VaAytF6LzcoDtNXE5hqt9D85GRHJRSZn64uwOEdux0DYBJuVPGJX
 zOHGeky+dAW50drkxWPfS7eY0+nL7jyy/pt16XIXLAe0kb+EUkzHAvBV5+FvqPNyrHUhT7UrhwH
 7bhAhPtiwzdUfYsck+f5/ZJCjaCcPx112wEMyAVpI4cvt6b8XFFaRnt9h0wbEwMGCTw/YmTOyHy
 4Q3CmNM9jvyp1hNdQtfqEXnBeIqBlJpUr4Szfmb03YElWGA0cx6RpnxVeZ7+fAySFcYJxm69DV3
 7ddwcwD7et4Zsah5PYs8ob28nJ5Alj
X-Google-Smtp-Source: AGHT+IHHT8+h2q9QhiGkhyZjwaLlRpy5aKnBSPBIZlAqZu+arwHcutl4BSPUV/si5Qxe+nM4Sbqldg==
X-Received: by 2002:a17:907:7f28:b0:b72:1d00:ad32 with SMTP id
 a640c23a62f3a-b72d0c6522bmr1073294666b.32.1762773877273; 
 Mon, 10 Nov 2025 03:24:37 -0800 (PST)
Received: from cibil-Precision-5570.. ([217.111.51.126])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bfa24d1fsm1049780266b.73.2025.11.10.03.24.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 03:24:37 -0800 (PST)
From: Cibil Pankiras <cibil.pankiras@egym.com>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] pinctrl: bcm283x: Add GPIO pull-up/down control for BCM2835
 and BCM2711
Date: Mon, 10 Nov 2025 12:24:26 +0100
Message-ID: <20251110112426.534118-1-cibil.pankiras@egym.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:11:49 +0100
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

This patch adds support for configuring GPIO pull-up and pull-down
resistors in the BCM283x pinctrl driver. It implements the brcm,pull
device tree property to control pin bias settings.

The implementation follows the hardware-specific pull control
mechanisms:
- BCM2835: two-step GPPUD register sequence
- BCM2711: direct per-pin control registers

This enables device tree configurations to specify pull-up, pull-down,
or no bias for individual GPIO pins.

Tested on Raspberry Pi boards with both BCM2835 and BCM2711 SoCs.

Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
---
 arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 102 ++++++++++++++++++++-
 2 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-bcm283x/include/mach/gpio.h b/arch/arm/mach-bcm2=
83x/include/mach/gpio.h
index 4aeb48eeb20..c54414a012c 100644
--- a/arch/arm/mach-bcm283x/include/mach/gpio.h
+++ b/arch/arm/mach-bcm283x/include/mach/gpio.h
@@ -26,6 +26,16 @@
 #define BCM2835_GPIO_FSEL_BANK(gpio)	(gpio / 10)
 #define BCM2835_GPIO_FSEL_SHIFT(gpio)	((gpio % 10) * 3)
=20
+/* BCM2835 GPIO Pull-up/down register offsets */
+#define BCM2835_GPPUD		37
+#define BCM2835_GPPUDCLK0	38
+
+/* BCM2711 GPIO Pull-up/down control */
+#define BCM2711_GPPUD_CNTRL_REG0	57
+#define BCM2711_PUD_REG_OFFSET(gpio)	((gpio) / 16)
+#define BCM2711_PUD_REG_SHIFT(gpio)	(((gpio) % 16) * 2)
+#define BCM2711_PUD_2711_MASK		0x3
+
 struct bcm2835_gpio_regs {
 	u32 gpfsel[6];
 	u32 reserved1;
diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinctrl/b=
roadcom/pinctrl-bcm283x.c
index cf9350c151e..c588015905d 100644
--- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
+++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
@@ -21,6 +21,8 @@
 #include <asm/system.h>
 #include <asm/io.h>
 #include <asm/gpio.h>
+#include <dt-bindings/pinctrl/bcm2835.h>
+#include <linux/delay.h>
=20
 struct bcm283x_pinctrl_priv {
 	u32 *base_reg;
@@ -54,7 +56,66 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev,=
 unsigned int gpio)
 }
=20
 /*
- * bcm283x_pinctrl_set_state: configure pin functions.
+ * bcm2835_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2835
+ * @dev: the pinctrl device
+ * @gpio: the GPIO pin number
+ * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
+ */
+static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int gpio, =
int pull)
+{
+	struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
+	u32 bank =3D BCM2835_GPPUDCLK0 + BCM2835_GPIO_COMMON_BANK(gpio);
+	u32 bit =3D BCM2835_GPIO_COMMON_SHIFT(gpio);
+
+	/* Set required control signal */
+	writel(pull & 0x3, &priv->base_reg[BCM2835_GPPUD]);
+	udelay(1);
+
+	/* Clock the control signal into the GPIO pads */
+	writel(1 << bit, &priv->base_reg[bank]);
+	udelay(1);
+
+	/* Remove the control signal and clock */
+	writel(0, &priv->base_reg[BCM2835_GPPUD]);
+	writel(0, &priv->base_reg[bank]);
+}
+
+/*
+ * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
+ * @dev: the pinctrl device
+ * @gpio: the GPIO pin number
+ * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD_UP)
+ */
+static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gpio, =
int pull)
+{
+	struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
+	u32 reg_offset;
+	u32 bit_shift;
+	u32 pull_bits;
+
+	/* Findout which GPIO_PUP_PDN_CNTRL register to use */
+	reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(gpio);
+
+	/* Findout the bit position */
+	bit_shift =3D BCM2711_PUD_REG_SHIFT(gpio);
+
+	/* Update the 2-bit field for this GPIO */
+	pull_bits =3D pull & BCM2711_PUD_2711_MASK;
+	clrsetbits_le32(&priv->base_reg[reg_offset],
+			BCM2711_PUD_2711_MASK << bit_shift,
+			pull_bits << bit_shift);
+}
+
+static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int gpio, =
int pull)
+{
+	if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
+		bcm2835_gpio_set_pull(dev, gpio, pull);
+	else
+		bcm2711_gpio_set_pull(dev, gpio, pull);
+}
+
+/*
+ * bcm283x_pinctrl_set_state: configure pin functions and pull states.
  * @dev: the pinctrl device to be configured.
  * @config: the state to be configured.
  * @return: 0 in success
@@ -62,8 +123,9 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev,=
 unsigned int gpio)
 int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	u32 pin_arr[MAX_PINS_PER_BANK];
+	u32 pull_arr[MAX_PINS_PER_BANK];
 	int function;
-	int i, len, pin_count =3D 0;
+	int i, len, pin_count =3D 0, pull_len =3D 0, pull_count =3D 0;
=20
 	if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
 	    len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
@@ -82,8 +144,42 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, stru=
ct udevice *config)
 		return -EINVAL;
 	}
=20
-	for (i =3D 0; i < pin_count; i++)
+	/* Check if brcm,pull property exists */
+	if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len > 0) {
+		if (pull_len & 0x3) {
+			debug("Invalid pull array length for pinconfig %s (%d)\n",
+			      config->name, pull_len);
+			return -EINVAL;
+		}
+
+		pull_count =3D pull_len / sizeof(u32);
+
+		if (pull_count !=3D pin_count) {
+			debug("Pull array count (%d) doesn't match pin count (%d) for pinconfig=
 %s\n",
+			      pull_count, pin_count, config->name);
+			return -EINVAL;
+		}
+
+		if (dev_read_u32_array(config, "brcm,pull", pull_arr, pull_count)) {
+			debug("Failed reading pull array for pinconfig %s\n", config->name);
+			return -EINVAL;
+		}
+
+		/* Validate pull values */
+		for (i =3D 0; i < pull_count; i++) {
+			if (pull_arr[i] > 2) {
+				debug("Invalid pull value %d for pin %d in pinconfig %s\n",
+				      pull_arr[i], pin_arr[i], config->name);
+				return -EINVAL;
+			}
+		}
+	}
+
+	for (i =3D 0; i < pin_count; i++) {
 		bcm2835_gpio_set_func_id(dev, pin_arr[i], function);
+		if (pull_count > 0)
+			bcm283x_gpio_set_pull(dev, pin_arr[i], pull_arr[i]);
+	}
=20
 	return 0;
 }
--=20
2.43.0


--=20
EGYM SE, Einsteinstra=DFe 172, 81677 M=FCnchen
Gesch=E4ftsf=FChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=FCnchen | Amtsgericht M=FCnchen HRB 303509=A0|=A0USt.-Id. DE275313632
