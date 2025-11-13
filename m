Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B55C7CDB463
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 23:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B02583E8E;
	Fri, 14 Nov 2025 00:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="DbkGesBA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603C783EE4; Fri, 14 Nov 2025 00:45:47 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0880883E86
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 00:45:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47755a7652eso9895905e9.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1763077544; x=1763682344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7TYjrFAIOmuYzHWip5xRWoA2dPjR5OpbVkOoMGFm03U=;
 b=DbkGesBAklwwy/NJ9HmGVmvVmTCYdzooN5KvwFU2AxQ/Hs2Hf9dJBnwECHNR+RsXfu
 0eAyivqPziDnRsqDSSTwLq/mES8j+8N9zq8rrpa6+HCYrD1PKwhkyu7JXOfDx/v/0KuZ
 n2/CMoscZbiLrS23NLceDI851SWk3zlWwj4Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763077544; x=1763682344;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TYjrFAIOmuYzHWip5xRWoA2dPjR5OpbVkOoMGFm03U=;
 b=SnJYmhbFf7/G8z5ctrRnEsCRTZ2jxoKfl8V3LPr9mXKbFjzuHhfjNR3B250G9yvVft
 5XfLRtK4NlBFgUNgvuMIp+1ZjWAB8f4tD41rHzEf8TN/EMhuTGnCcHHaMAfkeDWZRjlp
 5gBReNGfdln3ySyUpG1siP3oN3w0vjN+FD1r+DlObKzmb4q1UBVoh+SZ4wcxzUZW7sXu
 WYOhEtlGs8YaeMN9aoz7WSjaY0JrUmBmo30hD0Rs4sATUvNsxoZX5pvsF5vg7Visw8a3
 e20tyv2ehb8pwnlcV+gyCZ2hg+KMSew+1lvjVdBZPhVHILJDh3wkHfrgO4MP/PNaCp8g
 tbPg==
X-Gm-Message-State: AOJu0YybXK7V4oRqs6w5HSsz2haR7onJsYsdzMV63G6SEMskJLRDie2p
 r4EAU5zR/DQgvZXJvEg4wb/ljERyaQ1cB0tfRRDTmQdl5P9QrekPCpN9+UG5jUWwtD2R6QIbRPo
 C4E/B3YZedGlYxo9OVTz8ueY6Jo7OrD7J16oxrmmg5EEiyifvHDMO7akPjQfV
X-Gm-Gg: ASbGnctc5iX6/fvaRb2TYonI6eRQkyvlXVecu92i3UXbb0SEEZxuSpLiizPGmoxxa3J
 9LN1vIxbb/dt5f9fXA7yXDGX8b4vVCzOQ7EYm98ojCHQ5iesNs2Wo8ZMuX61Z60LB916Qn7SYf5
 75Y09LK23CK+L6NRi2LlIdVC24HNGwJpCoKdoN0fTBmF0sQDL9+BnKD+p3VEcdAfWxoyAGrGWZD
 mxs2UkvpAFMo3ey1+c7r4VESJ9kzG/eZ0ofUfiW1pyrLuT8ou5PJ/33GcDTOw4oshHMFbxXx67t
 7I1aae/Xo1GdrFOjXElNRZ99YktKo55cQEFC2BoZzLbokypp+PLpznJ91BNPB4NjRfw95FirXiD
 JpCAVjFLORe8SMCtTIEBdXV9v4ODInLzJ3U157GC+KEjJygS/hso4jfSBxjb/+N/+qeTHojUwXV
 gGZtzSb20CkNVPTAdGn2n+vgu4tQ4qw2UYWIBJsjRsSYDcUFTvR2/3xAHF
X-Google-Smtp-Source: AGHT+IF3GB003kF3oaReFvf9UHa6cdJPYZ5XIWODYXe2an9IWwY1+ZVSnp2ZoUXQP+vZXfxv42XBhg==
X-Received: by 2002:a05:600c:8b22:b0:475:dd89:abc with SMTP id
 5b1f17b1804b1-4778fe583f0mr9310255e9.11.1763077544082; 
 Thu, 13 Nov 2025 15:45:44 -0800 (PST)
Received: from cibil-Precision-5570.. (p4fdb371f.dip0.t-ipconnect.de.
 [79.219.55.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778c8479b7sm65582475e9.3.2025.11.13.15.45.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 15:45:43 -0800 (PST)
From: Cibil Pankiras <cibil.pankiras@egym.com>
To: u-boot@lists.denx.de
Cc: Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] pinctrl: bcm283x: Add GPIO pull-up/down control for
 BCM2835 and BCM2711
Date: Fri, 14 Nov 2025 00:45:32 +0100
Message-ID: <20251113234532.22653-1-cibil.pankiras@egym.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
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
Changes in v2:
- If brcm,pull contains a single value, apply it to all pins listed in brcm=
,pins
---
 arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
 drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 105 ++++++++++++++++++++-
 2 files changed, 112 insertions(+), 3 deletions(-)

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
index cf9350c151e..4ecc8bac645 100644
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
@@ -62,8 +123,10 @@ static int bcm2835_gpio_get_func_id(struct udevice *dev=
, unsigned int gpio)
 int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 {
 	u32 pin_arr[MAX_PINS_PER_BANK];
+	u32 pull_arr[MAX_PINS_PER_BANK];
 	int function;
-	int i, len, pin_count =3D 0;
+	int i, len, pin_count =3D 0, pull_len =3D 0, pull_count =3D 0;
+	int pull_value;
=20
 	if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
 	    len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
@@ -82,8 +145,44 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, stru=
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
+		if (pull_count !=3D 1 && pull_count !=3D pin_count) {
+			debug("Pull array count (%d) must be 1 or match pin count (%d) for pinc=
onfig %s\n",
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
+		if (pull_count > 0) {
+			pull_value =3D (pull_count =3D=3D 1) ? pull_arr[0] : pull_arr[i];
+			bcm283x_gpio_set_pull(dev, pin_arr[i], pull_value);
+		}
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
