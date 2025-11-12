Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63502CD4843
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 21:06:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F5ED83CEA;
	Wed, 12 Nov 2025 22:06:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="NZV0AKEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EE2A83D0B; Wed, 12 Nov 2025 22:06:02 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC12983B1A
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 22:05:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-37a5bc6b491so803041fa.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 13:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1762981559; x=1763586359; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FFDbvhZBisWzr4CSLEgZELA0TO7XG8Bog/Ddr7tGATA=;
 b=NZV0AKEJwMUo/Fxwl/DcJ1qh+4R/FUKE+YCqmpGk7Mmq6Tzc8s/DV8H4oDYUywmWQv
 bzHY2w1CWoyFSjfJaz/FaA+dyW8VhJnj7SRTIJa+ixr/T76CcKEMho8/jQLy/2LCQIYN
 qSJg7mHPveuXdGh7GCYS7a+7cqt9v1iRRFMko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762981559; x=1763586359;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FFDbvhZBisWzr4CSLEgZELA0TO7XG8Bog/Ddr7tGATA=;
 b=pUWUntVvPTHfVH8rF1Jbsh1NxKEKbCiCEvN0SxehUsATYVHXtH7FEmssj5KrNaizBo
 kC4zu/vb4lHIK1uB4RY2fZVFUNR0oMOVoYrE/X9rmzkz/ei4z0IkkF64NG+gphi0/iJO
 eymGQgFwBt2x94LxRN219o45D3VWRRjsaFw4e2yc46hP1pKBZ9PxIYCFDTRkJqHUpB7R
 sGJ7jw9gc1fF+ZXTah10QuEx5qLnIVUwwoixQi89hziu+YebazEO0dq68q9fA8KOHME5
 rC3GHPbTrtCI+2X3e3JAgrBhEDZNMr5cA1V6Z4RwkjcZcFHFvspXXlXCFt4jKACkodmy
 lqUg==
X-Gm-Message-State: AOJu0Yzx7jykMuc9O+jCaFlws6/rQrgT3fMZElAXPZvZ/EvXQrQ5S8sk
 P7FsKbxxN1l64rIMS4X4DFWyjrzjAZtvfAYZ2zqIt1LBsBFqdKPNgbTPo0lYQE/qv7o5xMDJWHa
 hp09//LiWmmIuMqLkNihdoxbBth8cl1RlDqxGZIWO+kufMsG5Qbr0Sulsjaf1Bn8N+OYwtOFQCe
 /wu3Zq31AHZrTFDhjlJoxe9w==
X-Gm-Gg: ASbGncvpAbJyPVz4pe13H9FAbmZdz8C27WmQDCy4mjcNFQSsedpOwpLPlfxefEMflf+
 qoODqHCp8Wxvv/EsZlRRZ7E1LRJJOLIKI4mwDN1YhcNH8JfQmXO3GWIsfOiteWQA7yqLiBX2RJC
 PV39VTyR1gPYVdPnfkoD8pjWXOdxLQCKOrLSX1N2alOX5PR3FhKlJgKT+vEa7xBrxfOJtoA1glb
 mMecp0JbX1ngdW+ovPO6LuvLkK3eqJR4uerGdEpMvuNJ6AXo3tKQS80FQ==
X-Google-Smtp-Source: AGHT+IHT19q6/ll4fjvZw5Vnzx+JAsF2cdTPjafalFMcXEwGsKf0/GlsJNhauBrwJ4GCsowRWy2qZqB9CBJ2grawZXQ=
X-Received: by 2002:a05:651c:3244:b0:378:dc57:edb8 with SMTP id
 38308e7fff4ca-37b8c2b546cmr13630981fa.10.1762981558946; Wed, 12 Nov 2025
 13:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20251110112426.534118-1-cibil.pankiras@egym.com>
 <b637c777-d4aa-47ad-baf8-1f825dd379b8@suse.com>
 <CAK3EG+mu-Q05KiusOhe16vYPGHopWPGi_o1_8kzQbHDGWQyb-A@mail.gmail.com>
 <f46e987a-c1b9-45f2-9086-0a0584c9b130@suse.com>
In-Reply-To: <f46e987a-c1b9-45f2-9086-0a0584c9b130@suse.com>
From: Cibil Pankiras <cibil.pankiras@egym.com>
Date: Wed, 12 Nov 2025 22:05:46 +0100
X-Gm-Features: AWmQ_bl8fS3_Y837d7348tkWRnWUWU-CzRIGHLlsHpIVsfg472ZLWoKg8tyhJeU
Message-ID: <CAK3EG+k1LTP5m7UO9ikBpBBcHahxCC0gcfa_P_YhFRaW5KUeAA@mail.gmail.com>
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

On Wed, Nov 12, 2025 at 8:06=E2=80=AFPM Matthias Brugger <mbrugger@suse.com=
> wrote:
>
>
>
> On 11/11/2025 22:17, Cibil Pankiras wrote:
> > Hi Matthias,
> >
> > On Mon, Nov 10, 2025 at 4:42=E2=80=AFPM Matthias Brugger <mbrugger@suse=
.com> wrote:
> >>
> >>
> >>
> >> On 10/11/2025 12:24, Cibil Pankiras wrote:
> >>> This patch adds support for configuring GPIO pull-up and pull-down
> >>> resistors in the BCM283x pinctrl driver. It implements the brcm,pull
> >>> device tree property to control pin bias settings.
> >>>
> >>> The implementation follows the hardware-specific pull control
> >>> mechanisms:
> >>> - BCM2835: two-step GPPUD register sequence
> >>> - BCM2711: direct per-pin control registers
> >>>
> >>> This enables device tree configurations to specify pull-up, pull-down=
,
> >>> or no bias for individual GPIO pins.
> >>>
> >>> Tested on Raspberry Pi boards with both BCM2835 and BCM2711 SoCs.
> >>>
> >>> Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
> >>> ---
> >>>    arch/arm/mach-bcm283x/include/mach/gpio.h  |  10 ++
> >>>    drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 102 +++++++++++++++++=
+++-
> >>>    2 files changed, 109 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-bcm283x/include/mach/gpio.h b/arch/arm/mac=
h-bcm283x/include/mach/gpio.h
> >>> index 4aeb48eeb20..c54414a012c 100644
> >>> --- a/arch/arm/mach-bcm283x/include/mach/gpio.h
> >>> +++ b/arch/arm/mach-bcm283x/include/mach/gpio.h
> >>> @@ -26,6 +26,16 @@
> >>>    #define BCM2835_GPIO_FSEL_BANK(gpio)        (gpio / 10)
> >>>    #define BCM2835_GPIO_FSEL_SHIFT(gpio)       ((gpio % 10) * 3)
> >>>
> >>> +/* BCM2835 GPIO Pull-up/down register offsets */
> >>> +#define BCM2835_GPPUD                37
> >>> +#define BCM2835_GPPUDCLK0    38
> >>> +
> >>> +/* BCM2711 GPIO Pull-up/down control */
> >>> +#define BCM2711_GPPUD_CNTRL_REG0     57
> >>> +#define BCM2711_PUD_REG_OFFSET(gpio) ((gpio) / 16)
> >>> +#define BCM2711_PUD_REG_SHIFT(gpio)  (((gpio) % 16) * 2)
> >>> +#define BCM2711_PUD_2711_MASK                0x3
> >>> +
> >>>    struct bcm2835_gpio_regs {
> >>>        u32 gpfsel[6];
> >>>        u32 reserved1;
> >>> diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pin=
ctrl/broadcom/pinctrl-bcm283x.c
> >>> index cf9350c151e..c588015905d 100644
> >>> --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> >>> +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> >>> @@ -21,6 +21,8 @@
> >>>    #include <asm/system.h>
> >>>    #include <asm/io.h>
> >>>    #include <asm/gpio.h>
> >>> +#include <dt-bindings/pinctrl/bcm2835.h>
> >>> +#include <linux/delay.h>
> >>>
> >>>    struct bcm283x_pinctrl_priv {
> >>>        u32 *base_reg;
> >>> @@ -54,7 +56,66 @@ static int bcm2835_gpio_get_func_id(struct udevice=
 *dev, unsigned int gpio)
> >>>    }
> >>>
> >>>    /*
> >>> - * bcm283x_pinctrl_set_state: configure pin functions.
> >>> + * bcm2835_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2835
> >>> + * @dev: the pinctrl device
> >>> + * @gpio: the GPIO pin number
> >>> + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_P=
UD_UP)
> >>> + */
> >>> +static void bcm2835_gpio_set_pull(struct udevice *dev, unsigned int =
gpio, int pull)
> >>> +{
> >>> +     struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
> >>> +     u32 bank =3D BCM2835_GPPUDCLK0 + BCM2835_GPIO_COMMON_BANK(gpio)=
;
> >>> +     u32 bit =3D BCM2835_GPIO_COMMON_SHIFT(gpio);
> >>> +
> >>> +     /* Set required control signal */
> >>> +     writel(pull & 0x3, &priv->base_reg[BCM2835_GPPUD]);
> >>> +     udelay(1);
> >>> +
> >>> +     /* Clock the control signal into the GPIO pads */
> >>> +     writel(1 << bit, &priv->base_reg[bank]);
> >>> +     udelay(1);
> >>> +
> >>> +     /* Remove the control signal and clock */
> >>> +     writel(0, &priv->base_reg[BCM2835_GPPUD]);
> >>> +     writel(0, &priv->base_reg[bank]);
> >>> +}
> >>> +
> >>> +/*
> >>> + * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
> >>> + * @dev: the pinctrl device
> >>> + * @gpio: the GPIO pin number
> >>> + * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_P=
UD_UP)
> >>> + */
> >>> +static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int =
gpio, int pull)
> >>> +{
> >>> +     struct bcm283x_pinctrl_priv *priv =3D dev_get_priv(dev);
> >>> +     u32 reg_offset;
> >>> +     u32 bit_shift;
> >>> +     u32 pull_bits;
> >>> +
> >>> +     /* Findout which GPIO_PUP_PDN_CNTRL register to use */
> >>> +     reg_offset =3D BCM2711_GPPUD_CNTRL_REG0 + BCM2711_PUD_REG_OFFSE=
T(gpio);
> >>> +
> >>> +     /* Findout the bit position */
> >>> +     bit_shift =3D BCM2711_PUD_REG_SHIFT(gpio);
> >>> +
> >>> +     /* Update the 2-bit field for this GPIO */
> >>> +     pull_bits =3D pull & BCM2711_PUD_2711_MASK;
> >>> +     clrsetbits_le32(&priv->base_reg[reg_offset],
> >>> +                     BCM2711_PUD_2711_MASK << bit_shift,
> >>> +                     pull_bits << bit_shift);
> >>> +}
> >>> +
> >>> +static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int =
gpio, int pull)
> >>> +{
> >>> +     if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
> >>> +             bcm2835_gpio_set_pull(dev, gpio, pull);
> >>> +     else
> >>> +             bcm2711_gpio_set_pull(dev, gpio, pull);
> >>> +}
> >>> +
> >>> +/*
> >>> + * bcm283x_pinctrl_set_state: configure pin functions and pull state=
s.
> >>>     * @dev: the pinctrl device to be configured.
> >>>     * @config: the state to be configured.
> >>>     * @return: 0 in success
> >>> @@ -62,8 +123,9 @@ static int bcm2835_gpio_get_func_id(struct udevice=
 *dev, unsigned int gpio)
> >>>    int bcm283x_pinctrl_set_state(struct udevice *dev, struct udevice =
*config)
> >>>    {
> >>>        u32 pin_arr[MAX_PINS_PER_BANK];
> >>> +     u32 pull_arr[MAX_PINS_PER_BANK];
> >>>        int function;
> >>> -     int i, len, pin_count =3D 0;
> >>> +     int i, len, pin_count =3D 0, pull_len =3D 0, pull_count =3D 0;
> >>>
> >>>        if (!dev_read_prop(config, "brcm,pins", &len) || !len ||
> >>>            len & 0x3 || dev_read_u32_array(config, "brcm,pins", pin_a=
rr,
> >>> @@ -82,8 +144,42 @@ int bcm283x_pinctrl_set_state(struct udevice *dev=
, struct udevice *config)
> >>>                return -EINVAL;
> >>>        }
> >>>
> >>> -     for (i =3D 0; i < pin_count; i++)
> >>> +     /* Check if brcm,pull property exists */
> >>> +     if (dev_read_prop(config, "brcm,pull", &pull_len) && pull_len >=
 0) {
> >>> +             if (pull_len & 0x3) {
> >>
> >> We should check for arbitrary values, so check should be, pull_len > 0=
x2
> >
> > In the current version of the patch, I validate each element in
> > pull_arr[] as follows:
> >      for (i =3D 0; i < pull_count; i++) {
> >          if (pull_arr[i] > 2) {
> >              debug("Invalid pull value %d for pin %d in pinconfig %s\n"=
,
> >                    pull_arr[i], pin_arr[i], config->name);
> >              return -EINVAL;
> >
> > Could you please clarify? Did you mean to replace the alignment check
> > `if (pull_len & 0x3)` with `pull_len > 0x2` ?
> >
>
> I think I miss some basic understanding here. Please help me with that. F=
rom
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.yaml?h=3Dv6.18-r=
c5#n88
> <snip>
>          brcm,pull:
>            description: >
>              Legacy pull setting for the pins (0=3Dnone, 1=3Dpull-down, 2=
=3Dpull-up).
>            $ref: /schemas/types.yaml#/definitions/uint32-array
>            maximum: 2
> </snip>
>
> So if I understand correctly you are reading the number of bytes in brcm,=
pull,
> which should be either one or two u32 values.
The brcm,pull property is a u32 array that defines the pin bias for
each pin listed in brcm,pins.

> But you error out only if the pull_len is 0x3. How is that? My gut feelin=
g tells me it should be either 0x2 or
> 0x4 everything else is an invalid DTB. But as I said I think I miss some
> fundamental understanding here. Can you please elaborate.
I read the number of bytes in pull_len and perform a 4 byte alignment
check (pull_len & 0x3). This ensures the
array length is always aligned to 4 bytes. This pattern is similar to
how brcm,pins array is validated in the same function.

I just realized I missed one detail, "brcm,pull may contain either a
single value which will be applied to all pins in brcm,pins,
or 1 value for each entry in brcm,pins."
Reference,
https://www.kernel.org/doc/Documentation/devicetree/bindings/pinctrl/brcm,b=
cm2835-gpio.txt
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/pinctrl/pinctrl-rp1.c?h=3Dv6.18-rc5#n1225

I will send a v2 patch implementing this behavior.

>
> By the way, I suppose we implement the deprecated binding because the RPi=
 FW
> still uses this, correct?
Yes, the dtb blobs passed from RPi firmware still uses it the deprecated bi=
nding

Regards,
Cibil

--=20
EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
Gesch=C3=A4ftsf=C3=BChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509=C2=A0|=C2=A0USt.-Id. DE2=
75313632
