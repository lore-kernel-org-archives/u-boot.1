Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFA4CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 09:26:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0156683A3D;
	Mon, 17 Nov 2025 10:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="HGXFdASl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82C5983A3D; Mon, 17 Nov 2025 10:26:27 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 327C38398C
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 10:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-37a4e329a90so31242821fa.0
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 01:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1763371584; x=1763976384; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=We/uOa4gt5GR5QAAkAoX9VeBqL+HB6iE+iDDs6qu8hs=;
 b=HGXFdASljS2klz/MGZow12WoiY42O3BnYjqnHU0XY4ST+rEixhL52phtUDEZDB+f5Y
 CA8pkmtTGgqm6eDLCSgDj8iX/P4uXYV1LMcET/WFCT9Rah96NWKxCOt8PGrRSXhkddn/
 9f7A+4ySeHJDUfcszBmAnzZLnqBIc5+JxDrVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763371584; x=1763976384;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=We/uOa4gt5GR5QAAkAoX9VeBqL+HB6iE+iDDs6qu8hs=;
 b=dDWV2YmHs8UzWgi62sFnbiZo2j2uRPxrl5ww5RTP+dZfJ3f+XZ6KMuakw6i1vVTC29
 CgVylspzsvGyE6kPZRCMBX00HjXwlsPFIygSdqCpnWB4Cr1jJFrnR+UN5nHphn/v+bgL
 0L+gY8MUC4UmdJ2BvEIuN85ovKrnPL1Ib0cUZQxyPAPHrwM6FG9Nqf2+kiOtvIXvjbS8
 P/wvqXAYL3lq4qBSocb47Edh2+SsLU37rkAeBR9LbqkRCMDqynE/N9DhgFREEXRWg1gx
 ef2utALd0qvT392VvVWZUXVcc1G47YazIf3kbuZnShAoammGoCD9ACc2tZ/PmrhYCCZw
 I3OQ==
X-Gm-Message-State: AOJu0Yzz6Zq1GooBGmlc0jrZl7jT26ADEByKgIt7146V8dY92NdiedDk
 hRxC1/APTK7QuYO9+1eigHGMJOMaG+4KGmyb27iAbv9fwIJauLp2WlXeEZqGIXWTFTEb1LsSf8Q
 31FGR3VAWbZ6yjxdb38ld6klxhkuS6S4G7529nJ/Enr5Hf85kP7ZX0sBt8Q0u+FCM9gfGCfrlEl
 d6qdO3PXraWKyZ4bCPeAY9q4vmDBlEFCeCSiw=
X-Gm-Gg: ASbGncuDoChK67QBhyOVmKCorx6E/yWNo7W9vw2CAY3Plv9zQmMbY4iOos4YIA7MpML
 npxwXSgc70NEe1ay/EYWjZxMRyfoWINfdpioz8M67qvNcesZ4H+gHXyVb9YvKhuCk9ctq8/8aBg
 iPjHzWIMhD4t/pC7P+s9UIOAXRvRMvIJwAGDGUPMyYJKOKeK3xjw2EiJxf/zqzOpRdXOpPTPU59
 aUovaYXK+cGPS8DawfUnRRvBEtO792TINTuqj5FGpWs+85NaGyUgKGokhM2u1YBiyuQyXv8N6V6
 LVA8pQ==
X-Google-Smtp-Source: AGHT+IGPkCrFXjtqWBqWtCe5DJ68G8IrLclsnwpkjBVD8x7X/K/DyZInVrfQXHtGaFLM5+42WHuY344osyUGT4FkhSw=
X-Received: by 2002:a05:651c:31c8:b0:373:a465:292c with SMTP id
 38308e7fff4ca-37babb7643fmr30462011fa.21.1763371584375; Mon, 17 Nov 2025
 01:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20251113234532.22653-1-cibil.pankiras@egym.com>
 <0ee621ec-ae27-4452-913f-44372b97ca30@suse.com>
In-Reply-To: <0ee621ec-ae27-4452-913f-44372b97ca30@suse.com>
From: Cibil Pankiras <cibil.pankiras@egym.com>
Date: Mon, 17 Nov 2025 10:26:13 +0100
X-Gm-Features: AWmQ_blfQM06nuLi7Xpls1XiSglqq6tm6DXzDov7ZXvCUIgH-jqts-vKi1x1Gz4
Message-ID: <CAK3EG+mtr9bZLbi9T5AF3790HprsD8vLrBZ_j4wC1Wc27QkJbw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: bcm283x: Add GPIO pull-up/down control for
 BCM2835 and BCM2711
To: Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
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

Hi Matthias,

On Fri, Nov 14, 2025 at 9:51=E2=80=AFAM Matthias Brugger <mbrugger@suse.com=
> wrote:
>
>
>
> On 14/11/25 00:45, Cibil Pankiras wrote:
> > This patch adds support for configuring GPIO pull-up and pull-down
> > resistors in the BCM283x pinctrl driver. It implements the brcm,pull
> > device tree property to control pin bias settings.
> >
> > The implementation follows the hardware-specific pull control
> > mechanisms:
> > - BCM2835: two-step GPPUD register sequence
> > - BCM2711: direct per-pin control registers
> >
> > This enables device tree configurations to specify pull-up, pull-down,
> > or no bias for individual GPIO pins.
> >
> > Tested on Raspberry Pi boards with both BCM2835 and BCM2711 SoCs.
> >
> > Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
>
> We check the brcm,pull byte lenght to be on par with the DT binding.
> That's not something I would expect normally to be done in a driver. But
> as this is also done for brcm,pin in this driver and also done in the
> kernel: let's not bike-shed.
>
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
Thanks for reviewing my patch
Should I resend the patch with the Reviewed-by tag, or will it be
added when the patch is applied to the tree?
Is there anything else needed from my side?

Regards,
Cibil
>
> > ---
> > Changes in v2:
> > - If brcm,pull contains a single value, apply it to all pins listed in =
brcm,pins
> > ---
> >   arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
> >   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 105 ++++++++++++++++++++=
-
> >   2 files changed, 112 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-bcm283x/include/mach/gpio.h b/arch/arm/mach-=
bcm283x/include/mach/gpio.h
> > index 4aeb48eeb20..c54414a012c 100644
> > --- a/arch/arm/mach-bcm283x/include/mach/gpio.h
> > +++ b/arch/arm/mach-bcm283x/include/mach/gpio.h
> > @@ -26,6 +26,16 @@
> >   #define BCM2835_GPIO_FSEL_BANK(gpio)        (gpio / 10)
> >   #define BCM2835_GPIO_FSEL_SHIFT(gpio)       ((gpio % 10) * 3)
> >
> > +/* BCM2835 GPIO Pull-up/down register offsets */
> > +#define BCM2835_GPPUD                37
> > +#define BCM2835_GPPUDCLK0    38
> > +
> > +/* BCM2711 GPIO Pull-up/down control */
> > +#define BCM2711_GPPUD_CNTRL_REG0     57
> > +#define BCM2711_PUD_REG_OFFSET(gpio) ((gpio) / 16)
> > +#define BCM2711_PUD_REG_SHIFT(gpio)  (((gpio) % 16) * 2)
> > +#define BCM2711_PUD_2711_MASK                0x3
> > +
> >   struct bcm2835_gpio_regs {
> >       u32 gpfsel[6];
> >       u32 reserved1;
> > diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinct=
rl/broadcom/pinctrl-bcm283x.c
> > index cf9350c151e..4ecc8bac645 100644
> > --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > @@ -21,6 +21,8 @@
> >   #include <asm/system.h>
> >   #include <asm/io.h>
> >   #include <asm/gpio.h>
> > +#include <dt-bindings/pinctrl/bcm2835.h>
> > +#include <linux/delay.h>
> >
> >   struct bcm283x_pinctrl_priv {
> >       u32 *base_reg;
> > @@ -54,7 +56,66 @@ static int bcm2835_gpio_get_func_id(struct udevice *=
dev, unsigned int gpio)
> >   }
> >
> >   /*
> > - * bcm283x_pinctrl_set_state: configure pin functions.
> > + * bcm2835_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2835
> > + * @dev: the pinctrl device
> > + * @gpio: the GPIO pin number
> > + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD=
_UP)
> > + */
> > +static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int gp=
io, int pull)
> > +{
> > +     struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
> > +     u32 bank =3D BCM2835_GPPUDCLK0 + BCM2835_GPIO_COMMON_BANK(gpio);
> > +     u32 bit =3D BCM2835_GPIO_COMMON_SHIFT(gpio);
> > +
> > +     /* Set required control signal */
> > +     writel(pull & 0x3, &priv->base_reg[BCM2835_GPPUD]);
> > +     udelay(1);
> > +
> > +     /* Clock the control signal into the GPIO pads */
> > +     writel(1 << bit, &priv->base_reg[bank]);
> > +     udelay(1);
> > +
> > +     /* Remove the control signal and clock */
> > +     writel(0, &priv->base_reg[BCM2835_GPPUD]);
> > +     writel(0, &priv->base_reg[bank]);
> > +}
> > +
> > +/*
> > + * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
> > + * @dev: the pinctrl device
> > + * @gpio: the GPIO pin number
> > + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD=
_UP)
> > + */
> > +static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int gp=
io, int pull)
> > +{
> > +     struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
> > +     u32 reg_offset;
> > +     u32 bit_shift;
> > +     u32 pull_bits;
> > +
> > +     /* Findout which GPIO_PUP_PDN_CNTRL register to use */
> > +     reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSET(=
gpio);
> > +
> > +     /* Findout the bit position */
> > +     bit_shift =3D BCM2711_PUD_REG_SHIFT(gpio);
> > +
> > +     /* Update the 2-bit field for this GPIO */
> > +     pull_bits =3D pull & BCM2711_PUD_2711_MASK;
> > +     clrsetbits_le32(&priv->base_reg[reg_offset],
> > +                     BCM2711_PUD_2711_MASK << bit_shift,
> > +                     pull_bits << bit_shift);
> > +}
> > +
> > +static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int gp=
io, int pull)
> > +{
> > +     if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
> > +             bcm2835_gpio_set_pull(dev, gpio, pull);
> > +     else
> > +             bcm2711_gpio_set_pull(dev, gpio, pull);
> > +}
> > +
> > +/*
> > + * bcm283x_pinctrl_set_state: configure pin functions and pull states.
> >    * @dev: the pinctrl device to be configured.
> >    * @config: the state to be configured.
> >    * @return: 0 in success
> > @@ -62,8 +123,10 @@ static int bcm2835_gpio_get_func_id(struct udevice =
*dev, unsigned int gpio)
> >   int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *co=
nfig)
> >   {
> >       u32 pin_arr[MAX_PINS_PER_BANK];
> > +     u32 pull_arr[MAX_PINS_PER_BANK];
> >       int function;
> > -     int i, len, pin_count =3D 0;
> > +     int i, len, pin_count =3D 0, pull_len =3D 0, pull_count =3D 0;
> > +     int pull_value;
> >
> >       if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
> >           len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
> > @@ -82,8 +145,44 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, =
struct udevice *config)
> >               return -EINVAL;
> >       }
> >
> > -     for (i =3D 0; i < pin_count; i++)
> > +     /* Check if brcm,pull property exists */
> > +     if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len > 0=
) {
> > +             if (pull_len & 0x3) {
> > +                     debug("Invalid pull array length for pinconfig %s=
 (%d)\n",
> > +                           config->name, pull_len);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             pull_count =3D pull_len / sizeof(u32);
> > +
> > +             if (pull_count !=3D 1 && pull_count !=3D pin_count) {
> > +                     debug("Pull array count (%d) must be 1 or match p=
in count (%d) for pinconfig %s\n",
> > +                           pull_count, pin_count, config->name);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             if (dev_read_u32_array(config, "brcm,pull", pull_arr, pul=
l_count)) {
> > +                     debug("Failed reading pull array for pinconfig %s=
\n", config->name);
> > +                     return -EINVAL;
> > +             }
> > +
> > +             /* Validate pull values */
> > +             for (i =3D 0; i < pull_count; i++) {
> > +                     if (pull_arr[i] > 2) {
> > +                             debug("Invalid pull value %d for pin %d i=
n pinconfig %s\n",
> > +                                   pull_arr[i], pin_arr[i], config->na=
me);
> > +                             return -EINVAL;
> > +                     }
> > +             }
> > +     }
> > +
> > +     for (i =3D 0; i < pin_count; i++) {
> >               bcm2835_gpio_set_func_id(dev, pin_arr[i], function);
> > +             if (pull_count > 0) {
> > +                     pull_value =3D (pull_count =3D=3D 1) ? pull_arr[0=
] : pull_arr[i];
> > +                     bcm283x_gpio_set_pull(dev, pin_arr[i], pull_value=
);
> > +             }
> > +     }
> >
> >       return 0;
> >   }
>

--=20
EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
Gesch=C3=A4ftsf=C3=BChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509=C2=A0|=C2=A0USt.-Id. DE2=
75313632
