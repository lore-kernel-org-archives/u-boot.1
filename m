Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85590E95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 15:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA5358667A;
	Sun,  8 Oct 2023 17:42:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iQSuK5Sl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E010586ACA; Sun,  8 Oct 2023 17:42:02 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02848667A
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 17:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a21ea6baccso45633507b3.1
 for <u-boot@lists.denx.de>; Sun, 08 Oct 2023 08:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696779719; x=1697384519;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=um0z4aYYn/St/9hHHxPsgsiVssFxIynRFNS+DJIpGxc=;
 b=iQSuK5SlLKgsgSOIuUBDcSmfke5fgTRIBkMnp0YOyT1aL/Um5wXqZjJmArjH9RyHZ7
 yzwgTw3JmH4dznWTjTdGSsgzR3q/BnIHyB/Laksq7l74fKZAjKcWlXYo4K3komn5EQju
 71NcexBZQ/jJ92+d9Tn9tT2OdxO83DreDqdBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696779719; x=1697384519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=um0z4aYYn/St/9hHHxPsgsiVssFxIynRFNS+DJIpGxc=;
 b=mfYQ60P7gYInqOwnYFkCzGn4Cax9fR2mVNswi6B+1ke7lKOLXchI1yb2EYRyhXV8OD
 6GNMJ7DUb6/Uy82eb52ayIuUG7fv8oUn+wOOWo3dp2ch3bs0Oh981i2CYUuUyiWWvhJh
 EgwyVrUC4uoBdlcjVANu9aF7SEz4MCr4mbDoqH8O0bAo9w0xZC3wzm/DellJpi2iqUC1
 2pjwVnwFPCEmvykRjWAJ7m5xMgqYq9S0HKeO6fqiIdl9aYrASefzIu3R7PeS9wkyO7gP
 v1oRMsalLiA0nRPTxqrenNSDKNDElFlBvTiPVb3ZZjzgAa+QqVlwpQAeZ+6DHnP4uAsN
 qeiA==
X-Gm-Message-State: AOJu0Yxk9lE5j5uV1phDIxAWpjMeu/SCZEx/AuHAIWFWfS0DVfftZ3TL
 LRHHXPw/5X6XkeM3pO42R1qQenPN5aggqRrbw1GnkA==
X-Google-Smtp-Source: AGHT+IF3TF0X0D4MA+65rLxXoeE+TtLSFgJzKpue+BF0hSPXK8b3wIb40DJQtp+EmTiaHIgykTU8jVr/SdODkt0rxXY=
X-Received: by 2002:a5b:4d2:0:b0:d81:504f:f879 with SMTP id
 u18-20020a5b04d2000000b00d81504ff879mr11191882ybp.28.1696779719284; Sun, 08
 Oct 2023 08:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230903205703.662080-1-dario.binacchi@amarulasolutions.com>
 <20230903205703.662080-5-dario.binacchi@amarulasolutions.com>
 <cc943366-406a-463d-cc77-b67e9d258799@foss.st.com>
In-Reply-To: <cc943366-406a-463d-cc77-b67e9d258799@foss.st.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Sun, 8 Oct 2023 17:41:48 +0200
Message-ID: <CABGWkvpbv5=eHxyjuZ4Kf9-xggunM--AJJ3NvAwhzpXJQ0cL3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] ARM: dts: stm32: support display on
 stm32f469-disco board
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 Anatolij Gustschin <agust@denx.de>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hello Patrice,

On Wed, Sep 27, 2023 at 8:19=E2=80=AFAM Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 9/3/23 22:57, Dario Binacchi wrote:
> > Add support to Orise Tech OTM8009A display on stm32f469-disco board.
> >
> > It was necessary to retrieve the framebuffer address from the device tr=
ee
> > because the address returned by the video-uclass driver pointed to a me=
mory
> > area that was not usable.
> >
> > Furthermore, unlike Linux, the DSI driver requires the LTDC clock to be
> > properly probed. Hence, the changes made to the DSI node in
> > stm32f469-disco-u-boot.dtsi.
> >
> > Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> > ---
> >
> >  arch/arm/dts/stm32f469-disco-u-boot.dtsi |  4 +++
> >  configs/stm32f469-discovery_defconfig    | 13 +++++++++
> >  drivers/video/stm32/stm32_ltdc.c         | 37 +++++++++++++++++++++++-
> >  3 files changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/dts/stm32f469-disco-u-boot.dtsi b/arch/arm/dts/st=
m32f469-disco-u-boot.dtsi
> > index 8e781c5a7b23..47ba9fa4a783 100644
> > --- a/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> > +++ b/arch/arm/dts/stm32f469-disco-u-boot.dtsi
> > @@ -92,7 +92,9 @@
> >
> >  &dsi {
> >       clocks =3D <&rcc 0 STM32F4_APB2_CLOCK(DSI)>,
> > +              <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>,
> >                <&clk_hse>;
> > +     clock-names =3D "pclk", "px_clk", "ref";
> >  };
> >
> >  &gpioa {
> > @@ -140,6 +142,8 @@
> >  };
> >
> >  &ltdc {
> > +     bootph-all;
> > +
> >       clocks =3D <&rcc 0 STM32F4_APB2_CLOCK(LTDC)>;
> >  };
> >
> > diff --git a/configs/stm32f469-discovery_defconfig b/configs/stm32f469-=
discovery_defconfig
> > index 35d18d58be6f..9796b8f2d9a5 100644
> > --- a/configs/stm32f469-discovery_defconfig
> > +++ b/configs/stm32f469-discovery_defconfig
> > @@ -21,6 +21,7 @@ CONFIG_CMD_GPT=3Dy
> >  # CONFIG_RANDOM_UUID is not set
> >  CONFIG_CMD_MMC=3Dy
> >  # CONFIG_CMD_SETEXPR is not set
> > +CONFIG_CMD_BMP=3Dy
> >  CONFIG_CMD_CACHE=3Dy
> >  CONFIG_CMD_TIMER=3Dy
> >  # CONFIG_ISO_PARTITION is not set
> > @@ -40,3 +41,15 @@ CONFIG_SPI_FLASH_STMICRO=3Dy
> >  CONFIG_SPI=3Dy
> >  CONFIG_DM_SPI=3Dy
> >  CONFIG_STM32_QSPI=3Dy
> > +CONFIG_VIDEO=3Dy
> > +CONFIG_BACKLIGHT_GPIO=3Dy
> > +CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=3Dy
> > +CONFIG_VIDEO_STM32=3Dy
> > +CONFIG_VIDEO_STM32_DSI=3Dy
> > +CONFIG_VIDEO_STM32_MAX_XRES=3D480
> > +CONFIG_VIDEO_STM32_MAX_YRES=3D800
> > +CONFIG_BMP_16BPP=3Dy
> > +CONFIG_BMP_24BPP=3Dy
> > +CONFIG_BMP_32BPP=3Dy
> > +CONFIG_DM_REGULATOR=3Dy
> > +CONFIG_DM_REGULATOR_FIXED=3Dy
> > diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm=
32_ltdc.c
> > index f48badc517a8..428b0addc43c 100644
> > --- a/drivers/video/stm32/stm32_ltdc.c
> > +++ b/drivers/video/stm32/stm32_ltdc.c
> > @@ -494,6 +494,34 @@ static void stm32_ltdc_set_layer1(struct stm32_ltd=
c_priv *priv, ulong fb_addr)
> >       setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
> >  }
> >
> > +#if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
>
> We want to avoid this kind of #define specific to a particular target

If the framebuffer is allocated by the video-uclass module, it is
mapped to the address 0xe00000, which does
not appear to be a correct memory zone. Therefore, for the
stm32f469-disco board, a different method for
framebuffer allocation is required, and this seemed to me the most
suitable way. I have submitted the series
as an RFC, and this is one of the points for which I did it. So, I am
open to considering any suggestions you
may have.

Output in case of applied patch:
stm32_display display-controller@40016800: 480x800 16bpp frame buffer
at 0xc0e00000

Otherwise:
stm32_display display-controller@40016800: 480x800 16bpp frame buffer
at 0xe00000

>
> > +static int stm32_ltdc_get_fb_addr(struct udevice *dev, ulong *base, ui=
nt size,
> > +                               uint align)
> > +{
> > +     phys_addr_t cpu;
> > +     dma_addr_t bus;
> > +     u64 dma_size;
> > +     int ret;
> > +
> > +     ret =3D dev_get_dma_range(dev, &cpu, &bus, &dma_size);
> > +     if (ret) {
> > +             dev_err(dev, "failed to get dma address\n");
> > +             return ret;
> > +     }
> > +
> > +     *base =3D bus + 0x1000000 - ALIGN(size, align);
>
> Why adding 0x1000000 ? avoid to insert const whithout any description and=
 use a #define instead.

Right, I will add it in version 2.

>
> > +     return 0;
> > +}
> > +#else
> > +static int stm32_ltdc_get_fb_addr(struct udevice *dev, ulong *base, ui=
nt size,
> > +                               uint align)
> > +{
> > +     /* Delegate framebuffer allocation to video-uclass */
> > +     *base =3D 0;
> > +     return 0;
> > +}
> > +#endif
> > +
> >  static int stm32_ltdc_probe(struct udevice *dev)
> >  {
> >       struct video_uc_plat *uc_plat =3D dev_get_uclass_plat(dev);
> > @@ -504,7 +532,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
> >       struct display_timing timings;
> >       struct clk pclk;
> >       struct reset_ctl rst;
> > -     ulong rate;
> > +     ulong rate, fb_base;
> >       int ret;
> >
> >       priv->regs =3D dev_read_addr_ptr(dev);
> > @@ -604,6 +632,13 @@ static int stm32_ltdc_probe(struct udevice *dev)
> >       priv->crop_h =3D timings.vactive.typ;
> >       priv->alpha =3D 0xFF;
> >
> > +     ret =3D stm32_ltdc_get_fb_addr(dev, &fb_base, uc_plat->size,
> > +                                  uc_plat->align);
> > +     if (ret)
> > +             return ret;
> > +
> > +     uc_plat->base =3D fb_base;
> > +
>
> It breaks display on stm32f746-disco and also on stm32f769-disco.

You are right, I will fix it in version 2.

Thanks and regards,

Dario

>
> Thanks
> Patrice
>
> >       dev_dbg(dev, "%dx%d %dbpp frame buffer at 0x%lx\n",
> >               timings.hactive.typ, timings.vactive.typ,
> >               VNBITS(priv->l2bpp), uc_plat->base);



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com
