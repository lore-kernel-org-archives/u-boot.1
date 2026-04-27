Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D314FF8868
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 16:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21A9183BC4;
	Mon, 27 Apr 2026 18:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="MoZV5GJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1114683BC4; Mon, 27 Apr 2026 18:44:18 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C1B83AA9
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 18:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-678a1642a81so5346785a12.0
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 09:44:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777308255; cv=none;
 d=google.com; s=arc-20240605;
 b=Qi7h3/6BXOGX1Oy8JM9vaoOBGncKbeIslt8vpAs7F88MxS0sVvtasS5JndsNiNKtF0
 J2jmywUcK3xYmRaozPvzAJSYl2kG+3TDdFNuWycMXrX+0dL1HMooYNG6vD6IUhxlULtb
 aC9eAuY9z7F9AhHcGYFPrPv60M2Em6M5i1sFxbICQmwNFZqiXh7h2OytIZXY1yFY3L7J
 xCcVOuont6Zou3NjRpaE+4dcPywcd2Rklsgv3sUAorfHt6WhQr1Lv51aZVHvUnNqSKbl
 qloKk5UeIl4YdDLjPtiYgzCLzvbdBfusenvGfyf09TXwDlRvOapxgontT4kuQimSLJ6/
 3M6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IcMOk0bQs3fFZ2f1sxpPzneKF9uvZiSLfYZax3BRaX0=;
 fh=+e7v11kZUJPEr6vVUwChYaU7WaWjk8k8IRERu/pygqg=;
 b=iItYbIcB12hyh++Vn5RaF5oA5Bdj3rTNKjjY8xO9f84SOOd50N9GFgP797IqVTh15E
 8NrW8DLxUDkzDTDRk3cawrZ24qqol/pgXbx3Cj1ACx1DrFrjcq+trQtoWxmgKDmsHwGz
 zhokQqaOTO/QGzdI8tIIIqmRUpdFgFEC7KCSsS9cXzkYAHitVLUnGca1auzSMvxAoRSf
 +2vEJRz1uFqpFWApjeV5OBcNj4B7z2BEecS3zZpB9tgHbkamUFAcbMe0BpGMGRpLbixl
 7KkHeIXk9dvpsPbEzSl6y/TL1xSczYpW2cjHqie2n7x3BBcAdThWBgkOLKarSSyxabrd
 nZaA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1777308255; x=1777913055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcMOk0bQs3fFZ2f1sxpPzneKF9uvZiSLfYZax3BRaX0=;
 b=MoZV5GJX+qS4WKhQQXBsgRolA0A9PijimAqBVOzjFmV0GwHFsSiUGatOOPG3w1zQVh
 pb8zYBfAcvGe4b1huiyr5lyWNy3xQYrfG5rG1zy83Mm2Sx9eCGp1W+36nKPKWhSCnvYV
 9v11o5y9G1xI6+YJztJQsNT5gh9VlNmXAPXa3NJL8vhTiJxC2kjXkNL8b36MANGUBdms
 c5/ZlBZW2MIPdiGGVkZLxY42SZpKgJCzwVdTV1ioKHrHmSsEDOEzrar57ptQeuDgmpoB
 xzy/f7MD+X/WPdb5jrtRObTC3YdpcyJdmBUE15pXtreeBcp5MJcUoIMR99cJlyEoCKNR
 vsng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777308255; x=1777913055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IcMOk0bQs3fFZ2f1sxpPzneKF9uvZiSLfYZax3BRaX0=;
 b=Ab3bkqBCdhaejFGWOn9H/Z1VSJ9gnVnP9joVvUjhsFqAwJBMySnta++XY7Iekrf+9m
 HNNLIB4X/52O757Ardn1+8ZCwB5cnqMHLFegrQH1xZZzdlRvO7A4TP1nx/prRmmilUhD
 BR8LQev7mOj6vW6y5C63E613bOIsFnM1AuxinCKrsagV4JM8fDDygzjLgzY/7uMxs9ng
 TXFC3jNYZi9b7EmWi7sdnz+3Rjw59kFLlxxpkMAF0upz//iEPr5+GvlukyUZ3/yo2b3C
 DV4nko2Pth4UKMw3MTwLxFIUjxpv79beIboB8N8e8acIyVX0Q9gAHgOqOqcNagKWvPry
 wPbQ==
X-Gm-Message-State: AOJu0Yw1DTXydXJMy7yQS6ihtoB7I0IuQkhGSYR/TqSbL4ZtZ26FL/Q0
 uSlGYvCFkXePvZbxFye7zXSk20ObslrBw1hNvGqt9oob8wGSTPuZv3sK2XKeBMXeioNbfKqEZL1
 hz7GNvI0RrRGwf8gIJHM/yWImTyutk5l4xnLDS522EQ==
X-Gm-Gg: AeBDieujQ/tWhDJykkH5KFXz8TOTiqeC/S0llmgAXPWqpqkiP+4dMOGOalaZ/1e+XP6
 FBY2UemKA04YOIM3RmKvizI+9rIqg7Pct9/Dw2dvGezh9aNuE5IdJLOsQr04sqYg/sSthvSsTZE
 9NWwBYVZH3HWd6XdIwZriVS8nSNR/6VVcnJHrKwnLqH+IeGG/fnJvWaWJ+hw8JocMQKSE6/bnlc
 jUs2+qym3QihH9qA7DrptiUEcoFs75No7afxWmUNxD5Ylh9T8hNm7wbpMOXVIzuFav804vfXq0b
 K65EiIi6spJFT9F5VQ==
X-Received: by 2002:a17:907:7213:b0:bae:5939:e5c8 with SMTP id
 a640c23a62f3a-bae5939e60cmr602879566b.36.1777308254913; Mon, 27 Apr 2026
 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260427-rk3576-usb-gadget-v1-1-982fd1de08db@flipper.net>
 <c2d737f0-a17e-44e4-8e07-53ce3fa0e543@cherry.de>
In-Reply-To: <c2d737f0-a17e-44e4-8e07-53ce3fa0e543@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 27 Apr 2026 20:44:02 +0400
X-Gm-Features: AVHnY4IqH_CjNPXihM07AGICUUu0-nhlL_GyR0GkFCbv7o3gg7xNoABv4SuKJoc
Message-ID: <CAKTNdwGo434ShEsP=e=uUAbJzVxfQPPfNPeTxOOqwbuoCyzRjw@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3576: Properly handle USB controller takeover
 from BootROM
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Anton Burticica <mouse@ya.ru>, Marek Vasut <marex@denx.de>
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

Hi Quentin,

On Mon, Apr 27, 2026 at 6:43=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 4/27/26 2:53 PM, Alexey Charkov wrote:
> > From: Anton Burticica <mouse@ya.ru>
> >
> > When booting via USB download mode (Maskrom), the BootROM leaves the
> > USB3OTG0 controller in an active state. U-Boot must properly reset
> > the controller before reinitializing it for fastboot or other USB
> > gadget functions.
> >
> > Without this change, USB gadget mode commands such as fastboot and ums
> > fail when U-Boot is loaded via Maskrom USB download because the
> > controller state is inconsistent.
> >
> > Signed-off-by: Anton Burticica <mouse@ya.ru>
> > [Removed unrelated changes, adjusted the commit description]
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   arch/arm/mach-rockchip/rk3576/rk3576.c | 18 ++++++++++++++++++
> >   1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm/mach-rockchip/rk3576/rk3576.c b/arch/arm/mach-roc=
kchip/rk3576/rk3576.c
> > index c17ba418ced5..84618ad5acb7 100644
> > --- a/arch/arm/mach-rockchip/rk3576/rk3576.c
> > +++ b/arch/arm/mach-rockchip/rk3576/rk3576.c
> > @@ -7,6 +7,8 @@
> >
> >   #include <dm.h>
> >   #include <misc.h>
> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> >   #include <asm/armv8/mmu.h>
> >   #include <asm/arch-rockchip/bootrom.h>
> >   #include <asm/arch-rockchip/hardware.h>
> > @@ -39,6 +41,10 @@
> >   #define USB_GRF_BASE                0x2601E000
> >   #define USB3OTG0_CON1               0x0030
> >
> > +#define TOP_CRU_BASE         0x27200000
> > +#define TOP_CRU_SOFTRST_CON47        0x0abc
> > +#define SOFTRST47_ARESETN_USB3OTG0   BIT(5)
> > +
> >   enum {
> >       BROM_BOOTSOURCE_FSPI0 =3D 3,
> >       BROM_BOOTSOURCE_FSPI1_M1 =3D 6,
> > @@ -189,6 +195,18 @@ int arch_cpu_init(void)
> >        */
> >       writel(0xffffff00, SYS_SGRF_BASE + SYS_SGRF_SOC_CON20);
> >
> > +     /* If the controller was left running by the boot ROM, reset it *=
/
> > +     if (read_brom_bootsource_id() =3D=3D BROM_BOOTSOURCE_USB) {
> > +             /* Assert USB3OTG0 reset */
> > +             writel(RK_SETBITS(SOFTRST47_ARESETN_USB3OTG0),
> > +                    TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
> > +             udelay(1000);
> > +             /* De-assert USB3OTG0 reset */
> > +             writel(RK_CLRBITS(SOFTRST47_ARESETN_USB3OTG0),
> > +                    TOP_CRU_BASE + TOP_CRU_SOFTRST_CON47);
> > +             udelay(1000);
> > +     }
> > +
>
> Uh... Wouldn't the issue rather be that the U-Boot driver doesn't
> actually reset the device?
>
> Can you try with
>
> diff --git a/drivers/usb/dwc3/dwc3-generic.c
> b/drivers/usb/dwc3/dwc3-generic.c
> index 22b9ef0b24e..1b7d845bc75 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -604,6 +604,9 @@ static int dwc3_glue_reset_init(struct udevice *dev,
>                  * have slower sleep clocks so we'll play it safe.
>                  */
>                 udelay(500);
> +       } else if (device_is_compatible(dev, "rockchip,rk3576-dwc3")) {
> +               reset_assert_bulk(&glue->resets);
> +               udelay(1000);
>         }
>         ret =3D reset_deassert_bulk(&glue->resets);
>         if (ret) {
>
> maybe? Hunch is that every variant of this driver actually needs to do
> this to avoid to rely on the device being out of reset already, but the
> delay is likely silicon-implementation-specific? The driver in the Linux
> kernel doesn't actually assert it either before deasserting it, so who
> knows. Adding Marek in Cc.

This snippet doesn't work unfortunately, I'm getting the following
(the same result as without any patches):

=3D> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x3a63e00
rockchip_udphy phy@2b010000: cmn ana lcpll lock timeout
rockchip_udphy phy@2b010000: failed to init usbdp combophy
rockchip_udphy phy@2b010000: PHY: Failed to init phy@2b010000: -110.
rockchip_udphy phy@2b010000: cmn ana lcpll lock timeout
rockchip_udphy phy@2b010000: failed to init usbdp combophy
rockchip_udphy phy@2b010000: PHY: Failed to init phy@2b010000: -110.
No USB device found
Couldn't init USB controller.

> Otherwise, for sure we do not want to de-assert the signal in the rk3576
> SoC C file, we don't know if the driver is even built and we should let
> it do it if need be.

Indeed, dropping the de-assertion (or rather leaving it to the driver)
still gets it to work properly, thanks!

Best regards,
Alexey
