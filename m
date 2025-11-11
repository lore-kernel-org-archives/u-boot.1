Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EE6CCFA18
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 21:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8977A83B8C;
	Tue, 11 Nov 2025 22:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="GCRcjvCK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA72F83BC7; Tue, 11 Nov 2025 22:17:45 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 868AA83B8A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 22:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-37a34702a20so997931fa.3
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1762895863; x=1763500663; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18VaMK3ONlIM9AG9I8VoBLa/u/rjeo2Gd3CzpacwVEE=;
 b=GCRcjvCKkhY3LEhMaQAjiMXGgmvqCRuNUoSvRhUwGpMPUAU/G66UL4sM7YsaVWakQK
 pHE7Il7b9KNbs0Wwiw128ALdeQNkBjdTeAJHFkYeBR8bt42iQpOtlOEp2VQtzXYE6WQe
 SSjyfKZLZ0gp2269BkkpAxbXbe6UV+PuQWmJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762895863; x=1763500663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=18VaMK3ONlIM9AG9I8VoBLa/u/rjeo2Gd3CzpacwVEE=;
 b=jMd0k/QFe4qAtGWxaWUSyzqk8Td7cLO70b+1Y8jGWkklWgAqTM73ZwBgOPnNAbcWgG
 +mf4we+SKa3XMwfLoGEB9C13yamy/5MBeafgzhBEt58IzCwuNO0ujh6OvaG7PwpgfM1a
 eg6kJ8u7xE86oy6ETYS+2VVAdskmOKQFMzJppG0wW8ebo6pbVyuu5BJWPmgxjfxjfP2H
 LQkxbIGdMhwenisMauChQMLnakXD3zBr057iy/9nfKDvwexZOBQZ4Utm0LRdHUVHKL2g
 BveqCayvZnV1cq6vtDAOXMsLVGNdHFucE+F7qS3RuP8MHLfp6LTCcEjkCLMzUGEVrP5s
 atFg==
X-Gm-Message-State: AOJu0YyyZfgFOZG3PHN+KhwFXiv6Xk3Anm8OBxxmbvz5U3GbjN0yunf1
 0wyJmmqQZPzGgyBL0bz221SRjt2xkxtHebkRJWiTEKNBHm8Qk2rErQu42zWvG3YLaqCTurdjwtP
 olOwdH7kw97kruNUvlNfSkhsuFbETfS1iNtDdBDOy1UZiyqRiDSG3bEVRr0qca7jtUjtq+UzFEy
 az41AlVbJ1eS01L2P09sn5qA==
X-Gm-Gg: ASbGncvkuDtHGGqewkpOgTs5a78iQ33TKPwktrFaG57i0Uz/bRNW8VmDBokh/BWFDW1
 DVecM8NZO1yzNcNjsyEIdRuJWx+GnBr/uLWoUETqc94eWs8ABAR/zYSvlxERW1sCop8qZfTDRSf
 VPQ0kzMyAcyApQOjXTqmeGStRBbDcGn99ZEzY9XTnQkjL3GER5YbDuiulhirlebfUnYIJKdYAO6
 FM6d5ZKXZw0D0MOVczQpcjJCNCs+mh1bB1PKBe8dNvzJbghce6jySN3NacDQ6JWo8bB
X-Google-Smtp-Source: AGHT+IEPj2SVDdQxEe+2S+hNBaBcW3rzD0fyChN5wn4jN/b/T1tuEx7cWcelkeKIn5gtWsj2EI7WJ69kNebCYHugRiQ=
X-Received: by 2002:a2e:98d2:0:b0:37a:9558:5bf8 with SMTP id
 38308e7fff4ca-37b8c3dca00mr1628531fa.32.1762895862711; Tue, 11 Nov 2025
 13:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20251110112426.534118-1-cibil.pankiras@egym.com>
 <b637c777-d4aa-47ad-baf8-1f825dd379b8@suse.com>
In-Reply-To: <b637c777-d4aa-47ad-baf8-1f825dd379b8@suse.com>
From: Cibil Pankiras <cibil.pankiras@egym.com>
Date: Tue, 11 Nov 2025 22:17:30 +0100
X-Gm-Features: AWmQ_bndMMj1058zDSh2rndV_8rq8umFAms-SOu4hugFfnc8Qmu-K-a2jelFfPQ
Message-ID: <CAK3EG+mu-Q05KiusOhe16vYPGHopWPGi_o1_8kzQbHDGWQyb-A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm283x: Add GPIO pull-up/down control for
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

On Mon, Nov 10, 2025 at 4:42=E2=80=AFPM Matthias Brugger <mbrugger@suse.com=
> wrote:
>
>
>
> On 10/11/2025 12:24, Cibil Pankiras wrote:
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
> > ---
> >   arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
> >   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 102 ++++++++++++++++++++=
-
> >   2 files changed, 109 insertions(+), 3 deletions(-)
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
> > index cf9350c151e..c588015905d 100644
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
> > @@ -62,8 +123,9 @@ static int bcm2835_gpio_get_func_id(struct udevice *=
dev, unsigned int gpio)
> >   int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice *co=
nfig)
> >   {
> >       u32 pin_arr[MAX_PINS_PER_BANK];
> > +     u32 pull_arr[MAX_PINS_PER_BANK];
> >       int function;
> > -     int i, len, pin_count =3D 0;
> > +     int i, len, pin_count =3D 0, pull_len =3D 0, pull_count =3D 0;
> >
> >       if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
> >           len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_arr,
> > @@ -82,8 +144,42 @@ int bcm283x_pinctrl_set_state(struct udevice *dev, =
struct udevice *config)
> >               return -EINVAL;
> >       }
> >
> > -     for (i =3D 0; i < pin_count; i++)
> > +     /* Check if brcm,pull property exists */
> > +     if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len > 0=
) {
> > +             if (pull_len & 0x3) {
>
> We should check for arbitrary values, so check should be, pull_len > 0x2

In the current version of the patch, I validate each element in
pull_arr[] as follows:
    for (i =3D 0; i < pull_count; i++) {
        if (pull_arr[i] > 2) {
            debug("Invalid pull value %d for pin %d in pinconfig %s\n",
                  pull_arr[i], pin_arr[i], config->name);
            return -EINVAL;

Could you please clarify? Did you mean to replace the alignment check
`if (pull_len & 0x3)` with `pull_len > 0x2` ?

Regards,
Cibil



        }
    }

>
> With that change:
> Reviewed-by: Matthias Brugger <mbrugger@suse.com>
>

--=20
EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
Gesch=C3=A4ftsf=C3=BChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509=C2=A0|=C2=A0USt.-Id. DE2=
75313632
