Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26B2CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 10:17:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 109CE83AEF;
	Mon, 17 Nov 2025 11:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m5NswZkD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CF8383A64; Mon, 17 Nov 2025 11:17:07 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E96B83A64
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 11:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so6726247a12.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 02:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763374624; x=1763979424; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBi7AbeLeTPgAOT73xgcOvAy51kbSjg8pvdE5xUoHkE=;
 b=m5NswZkDs8d0NE+79M538+KcYl4tBsvq4dRH6cjCdGuxluj6dsbEr3CVII3Uls2ukq
 IlPkc4iZf8gmN2scFxBfNfm7w3zEAmd4MLPIhMXkspQ/z3oTDlysIbt98xqoAXY1dpl6
 AifC0x9OdSlegzkEOf6fJF4APU01yBDaHaWH2/FRIfsLhzzAGKcMwS+CYUCl9a4CqCiM
 NvztQCO4OxQjczrKVebEVBMwMnZ8JxXFqriHz4ADrrnk7B1mKdFvv6t5IVdekdZksVdL
 02rnA/rYk/Lv2KSHa4jvTA4lEvdhUYPHt2oOnQNIAbdS64YC0Y3wQjs5fAk9PeITfUa+
 VuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763374624; x=1763979424;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gBi7AbeLeTPgAOT73xgcOvAy51kbSjg8pvdE5xUoHkE=;
 b=w36HAum/sUZFLgNPBCuYpl0FU/Lin5ADKEK2OBz1zE7f2YpJUVDj7shzwzZqJuC95L
 0TcENanNrmZjwB3bNGAsbfyQwDb8Thni6R+OJ056MLw5urXB4pbvOO5yPdGelcUNPiLN
 CWZjdHeykQaHM1G5M3p5dYIAI/2168aNrnXJigtR+bDh+1sEKDrItZvP2QmE05IPK0uU
 4XGJmXccXLHjeWURirypQi9H4tcHCY/Rr9V8udoDT72zj+d7sMAgQTps6tcYFaVFd5If
 bVTr6VRndloh9k1yz13QUbXoOfQ1RKHGti44l30MX1WrRAlVnoxVa/ZTXEPnvSyGkbmm
 hEtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyl1GAzlQVJO3+n7dPfcAF0mVq7yavd2Gv2apkGi93P4cvqm+xkuJiJddppM0R3r0QhiTupdw=@lists.denx.de
X-Gm-Message-State: AOJu0YzAyefZyQboC2v3aZpXLlxXxU0vTY7h26Dm3e9gaCGTTdeRkztH
 MpzKB79BFWJmv1hI1NKnTD4gFgq5JwMSsck8QYUr0svs/uJJX2RWymnSDiHShrItSxRygkGid0U
 eDXwq0BE/pJqj4fFpycvUgRCtxx5pjt8=
X-Gm-Gg: ASbGnctFwKGHLit2XeVxIKLfP6o5RreW5xXFInQTJVmY6+Wm34V3tQcL4VAhRIXKgZ4
 VKTHCaFUzobepYZcHt4mEd6mEAoou0iFKm7z8JrivupCn5PryoF5hlBsRstGICFppsa9brYESzb
 H42NiC3LYALfnROcQ3/HxOOdOAA+AFAkRhcqCx1s8z8wduO8wgUW3OD9KxYzz7P5zLDIaLUe33F
 tK0Va3uYi1GWQcP0H0ICyxWCBVl41yXrSDHnf6PBI+XfBESy+tNhv93vXIS0J83QxhrG+1/iAcg
 +VKZsWT9FvJUpr3C+wUNGRI/T9BEUoomKYjuF2pVkBf8Vs5zrrJ5rg9VlLE2HpmN3gaPd8jz3nk
 Km9pSeA2BPI1iwNcBVzbXcHdYNVoTLoqQ+QR4oLWliO2tFJ1CsTv/ow==
X-Google-Smtp-Source: AGHT+IFjCDhfgOuUmE9YWYlFhHepO7r9cWNHG7bZKTrkD5iKdWxnvI/0O5MOk4MdD7fmfDEsYl2l+bL82/2pgIzyoY4=
X-Received: by 2002:a05:6402:4308:b0:640:c062:8bca with SMTP id
 4fb4d7f45d1cf-64350e75eadmr10557438a12.18.1763374624194; Mon, 17 Nov 2025
 02:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20251113234532.22653-1-cibil.pankiras@egym.com>
 <0ee621ec-ae27-4452-913f-44372b97ca30@suse.com>
 <CAK3EG+mtr9bZLbi9T5AF3790HprsD8vLrBZ_j4wC1Wc27QkJbw@mail.gmail.com>
In-Reply-To: <CAK3EG+mtr9bZLbi9T5AF3790HprsD8vLrBZ_j4wC1Wc27QkJbw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 17 Nov 2025 10:16:52 +0000
X-Gm-Features: AWmQ_bnNq7T5hmF-0uREl7ZJYkyj62ZzemDUs7Ol7TRRdbRkDq8eIYhCLEZ9mEM
Message-ID: <CALeDE9PVFEtsKCJoWGoJsBz15rcCKLV8j_XHafMZPTwdA+=WKQ@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: bcm283x: Add GPIO pull-up/down control for
 BCM2835 and BCM2711
To: Cibil Pankiras <cibil.pankiras@egym.com>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, 17 Nov 2025 at 09:26, Cibil Pankiras <cibil.pankiras@egym.com> wrot=
e:
>
> Hi Matthias,
>
> On Fri, Nov 14, 2025 at 9:51=E2=80=AFAM Matthias Brugger <mbrugger@suse.c=
om> wrote:
> >
> >
> >
> > On 14/11/25 00:45, Cibil Pankiras wrote:
> > > This patch adds support for configuring GPIO pull-up and pull-down
> > > resistors in the BCM283x pinctrl driver. It implements the brcm,pull
> > > device tree property to control pin bias settings.
> > >
> > > The implementation follows the hardware-specific pull control
> > > mechanisms:
> > > - BCM2835: two-step GPPUD register sequence
> > > - BCM2711: direct per-pin control registers
> > >
> > > This enables device tree configurations to specify pull-up, pull-down=
,
> > > or no bias for individual GPIO pins.
> > >
> > > Tested on Raspberry Pi boards with both BCM2835 and BCM2711 SoCs.
> > >
> > > Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
> >
> > We check the brcm,pull byte lenght to be on par with the DT binding.
> > That's not something I would expect normally to be done in a driver. Bu=
t
> > as this is also done for brcm,pin in this driver and also done in the
> > kernel: let's not bike-shed.
> >
> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
> Thanks for reviewing my patch
> Should I resend the patch with the Reviewed-by tag, or will it be
> added when the patch is applied to the tree?
> Is there anything else needed from my side?

Nope, will be added automatically by patchwork, I'm just testing all
the rpi bits now.

> Regards,
> Cibil
> >
> > > ---
> > > Changes in v2:
> > > - If brcm,pull contains a single value, apply it to all pins listed i=
n brcm,pins
> > > ---
> > >   arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
> > >   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 105 ++++++++++++++++++=
++-
> > >   2 files changed, 112 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-bcm283x/include/mach/gpio.h b/arch/arm/mac=
h-bcm283x/include/mach/gpio.h
> > > index 4aeb48eeb20..c54414a012c 100644
> > > --- a/arch/arm/mach-bcm283x/include/mach/gpio.h
> > > +++ b/arch/arm/mach-bcm283x/include/mach/gpio.h
> > > @@ -26,6 +26,16 @@
> > >   #define BCM2835_GPIO_FSEL_BANK(gpio)        (gpio / 10)
> > >   #define BCM2835_GPIO_FSEL_SHIFT(gpio)       ((gpio % 10) * 3)
> > >
> > > +/* BCM2835 GPIO Pull-up/down register offsets */
> > > +#define BCM2835_GPPUD                37
> > > +#define BCM2835_GPPUDCLK0    38
> > > +
> > > +/* BCM2711 GPIO Pull-up/down control */
> > > +#define BCM2711_GPPUD_CNTRL_REG0     57
> > > +#define BCM2711_PUD_REG_OFFSET(gpio) ((gpio) / 16)
> > > +#define BCM2711_PUD_REG_SHIFT(gpio)  (((gpio) % 16) * 2)
> > > +#define BCM2711_PUD_2711_MASK                0x3
> > > +
> > >   struct bcm2835_gpio_regs {
> > >       u32 gpfsel[6];
> > >       u32 reserved1;
> > > diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pin=
ctrl/broadcom/pinctrl-bcm283x.c
> > > index cf9350c151e..4ecc8bac645 100644
> > > --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > > +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > > @@ -21,6 +21,8 @@
> > >   #include <asm/system.h>
> > >   #include <asm/io.h>
> > >   #include <asm/gpio.h>
> > > +#include <dt-bindings/pinctrl/bcm2835.h>
> > > +#include <linux/delay.h>
> > >
> > >   struct bcm283x_pinctrl_priv {
> > >       u32 *base_reg;
> > > @@ -54,7 +56,66 @@ static int bcm2835_gpio_get_func_id(struct udevice=
 *dev, unsigned int gpio)
> > >   }
> > >
> > >   /*
> > > - * bcm283x_pinctrl_set_state: configure pin functions.
> > > + * bcm2835_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2835
> > > + * @dev: the pinctrl device
> > > + * @gpio: the GPIO pin number
> > > + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_P=
UD_UP)
> > > + */
> > > +static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int =
gpio, int pull)
> > > +{
> > > +     struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
> > > +     u32 bank =3D BCM2835_GPPUDCLK0 + BCM2835_GPIO_COMMON_BANK(gpio)=
;
> > > +     u32 bit =3D BCM2835_GPIO_COMMON_SHIFT(gpio);
> > > +
> > > +     /* Set required control signal */
> > > +     writel(pull & 0x3, &priv->base_reg[BCM2835_GPPUD]);
> > > +     udelay(1);
> > > +
> > > +     /* Clock the control signal into the GPIO pads */
> > > +     writel(1 << bit, &priv->base_reg[bank]);
> > > +     udelay(1);
> > > +
> > > +     /* Remove the control signal and clock */
> > > +     writel(0, &priv->base_reg[BCM2835_GPPUD]);
> > > +     writel(0, &priv->base_reg[bank]);
> > > +}
> > > +
> > > +/*
> > > + * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
> > > + * @dev: the pinctrl device
> > > + * @gpio: the GPIO pin number
> > > + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_P=
UD_UP)
> > > + */
> > > +static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int =
gpio, int pull)
> > > +{
> > > +     struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
> > > +     u32 reg_offset;
> > > +     u32 bit_shift;
> > > +     u32 pull_bits;
> > > +
> > > +     /* Findout which GPIO_PUP_PDN_CNTRL register to use */
> > > +     reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSE=
T(gpio);
> > > +
> > > +     /* Findout the bit position */
> > > +     bit_shift =3D BCM2711_PUD_REG_SHIFT(gpio);
> > > +
> > > +     /* Update the 2-bit field for this GPIO */
> > > +     pull_bits =3D pull & BCM2711_PUD_2711_MASK;
> > > +     clrsetbits_le32(&priv->base_reg[reg_offset],
> > > +                     BCM2711_PUD_2711_MASK << bit_shift,
> > > +                     pull_bits << bit_shift);
> > > +}
> > > +
> > > +static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int =
gpio, int pull)
> > > +{
> > > +     if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
> > > +             bcm2835_gpio_set_pull(dev, gpio, pull);
> > > +     else
> > > +             bcm2711_gpio_set_pull(dev, gpio, pull);
> > > +}
> > > +
> > > +/*
> > > + * bcm283x_pinctrl_set_state: configure pin functions and pull state=
s.
> > >    * @dev: the pinctrl device to be configured.
> > >    * @config: the state to be configured.
> > >    * @return: 0 in success
> > > @@ -62,8 +123,10 @@ static int bcm2835_gpio_get_func_id(struct udevic=
e *dev, unsigned int gpio)
> > >   int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *=
config)
> > >   {
> > >       u32 pin_arr[MAX_PINS_PER_BANK];
> > > +     u32 pull_arr[MAX_PINS_PER_BANK];
> > >       int function;
> > > -     int i, len, pin_count =3D 0;
> > > +     int i, len, pin_count =3D 0, pull_len =3D 0, pull_count =3D 0;
> > > +     int pull_value;
> > >
> > >       if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
> > >           len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_ar=
r,
> > > @@ -82,8 +145,44 @@ int bcm283x_pinctrl_set_state(struct udevice *dev=
, struct udevice *config)
> > >               return -EINVAL;
> > >       }
> > >
> > > -     for (i =3D 0; i < pin_count; i++)
> > > +     /* Check if brcm,pull property exists */
> > > +     if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len >=
 0) {
> > > +             if (pull_len & 0x3) {
> > > +                     debug("Invalid pull array length for pinconfig =
%s (%d)\n",
> > > +                           config->name, pull_len);
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             pull_count =3D pull_len / sizeof(u32);
> > > +
> > > +             if (pull_count !=3D 1 && pull_count !=3D pin_count) {
> > > +                     debug("Pull array count (%d) must be 1 or match=
 pin count (%d) for pinconfig %s\n",
> > > +                           pull_count, pin_count, config->name);
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             if (dev_read_u32_array(config, "brcm,pull", pull_arr, p=
ull_count)) {
> > > +                     debug("Failed reading pull array for pinconfig =
%s\n", config->name);
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             /* Validate pull values */
> > > +             for (i =3D 0; i < pull_count; i++) {
> > > +                     if (pull_arr[i] > 2) {
> > > +                             debug("Invalid pull value %d for pin %d=
 in pinconfig %s\n",
> > > +                                   pull_arr[i], pin_arr[i], config->=
name);
> > > +                             return -EINVAL;
> > > +                     }
> > > +             }
> > > +     }
> > > +
> > > +     for (i =3D 0; i < pin_count; i++) {
> > >               bcm2835_gpio_set_func_id(dev, pin_arr[i], function);
> > > +             if (pull_count > 0) {
> > > +                     pull_value =3D (pull_count =3D=3D 1) ? pull_arr=
[0] : pull_arr[i];
> > > +                     bcm283x_gpio_set_pull(dev, pin_arr[i], pull_val=
ue);
> > > +             }
> > > +     }
> > >
> > >       return 0;
> > >   }
> >
>
> --
> EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
> Gesch=C3=A4ftsf=C3=BChrende Direktoren:
> Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
> Gerichtsstand
> M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509 | USt.-Id. DE275313632
