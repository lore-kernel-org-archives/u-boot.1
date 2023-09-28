Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144B4E82CB7
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 00:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B63586A3A;
	Thu, 28 Sep 2023 02:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SrKiqIMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18F5986C5D; Thu, 28 Sep 2023 02:58:07 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AB06868BB
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 02:58:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5041cc983f9so20032202e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 17:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695862684; x=1696467484; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IClRjSJhvfTZm5j6M3HULjIyIHiGCzJQxLKhpJbGk0I=;
 b=SrKiqIMrI/XUEemrW+X9N72QHM9CPVa4QgH2SmP0wLKPOIwfN8/4bky0fXmys1Lz4j
 Yg2E3XYQ78JXTYmRogk5QvC9FB+Z5Ch4Ro+iWrGceq78++7ZjXeLtuEqQNUO2868Y7VS
 FwfHHTbuddNQDFBJd9G5dIfUKIBvfUobedt3GT/+05Dff4WaUB66oUV220yksLAYiKhI
 xcyLHsp26VFP0HwUGBnvetaOBWXDDQpnaNmo/VvgDDlWEY2vS19SYGqI9xrydmxtdpbJ
 2WXOJKBitsf25QQoG0UbqlyPABRFXjNL6Pe9n9E208m0nMA4q/2UJE1PgO18n3+wDY6X
 uWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695862684; x=1696467484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IClRjSJhvfTZm5j6M3HULjIyIHiGCzJQxLKhpJbGk0I=;
 b=h+4FYuHtkb0ArXCfhNfxzXcawFPpDRUaFl1OoEvpk4c2OhGob9gGyoXPdtsHyfTcH0
 olcii9rMQW9oiDAyC00vLQjCYMYoR5UydiW5E13M6/Bc2/d3ABlJzXOWTPk1Fw7p0jFh
 qtMIBy9XOzm5QueHcNw9tn7LPFzAgurrukYQXXR8GXeKGel/buAiKoy76TcwtycJE+H5
 IUULaBCKZ1GcDf3aV2SpNOHmA4k61Les9qqL77XrLb0QtZYZonc8jpDZT1+PKzpOkFDB
 wvnqK+8TeBt44EJTSTGl8JJyxKE6Y2SQJVlkPW+1PBNck0YL30TLFhdOcoq/gt0n2m5A
 CTQw==
X-Gm-Message-State: AOJu0Yy2qqYghDYWwB0mzQvmzICx0ad8LM4vMVOiN68tugx5CFU8wy8l
 eatoZLetFzltqbq88aWsmsU+TXknwl0Fd/Te5x+FBjUjAQU=
X-Google-Smtp-Source: AGHT+IG/jrZlBFStlbuii0kjW6wh49LO757Cntg5E5AbTFuSqZwoTviTf8yYCYygE1UHAl5L67frKDGgV7rPZMaqq9M=
X-Received: by 2002:a05:6512:314e:b0:503:eae:4896 with SMTP id
 s14-20020a056512314e00b005030eae4896mr2722034lfi.39.1695862683612; Wed, 27
 Sep 2023 17:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926090407.407769-1-JJLIU0@nuvoton.com>
 <79d9b3ac-2ec9-df94-312d-065fd9792f3e@denx.de>
In-Reply-To: <79d9b3ac-2ec9-df94-312d-065fd9792f3e@denx.de>
From: Jim Liu <jim.t90615@gmail.com>
Date: Thu, 28 Sep 2023 08:57:52 +0800
Message-ID: <CAKUZ0+H4gE5E31N8n55jZagj-XZTgt1peJu7p=-zKTyetH98pg@mail.gmail.com>
Subject: Re: [PATCH v1] wdt: nuvoton: fix reset/expire function error and add
 dts
To: Stefan Roese <sr@denx.de>
Cc: JJLIU0@nuvoton.com, KWLIU@nuvoton.com, trini@konsulko.com, 
 u-boot@lists.denx.de
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

Hi Stefan

Thanks for your quick review.

i will followed your suggestions to update V2


Best regards,
Jim

On Tue, Sep 26, 2023 at 5:30=E2=80=AFPM Stefan Roese <sr@denx.de> wrote:
>
> Hi Jim,
>
> On 9/26/23 11:04, Jim Liu wrote:
> > Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
>
> Please provide a short commit summary, explaining what this patch
> does. Starting with a reasoning for this change and a short dscription
> of what was changed.
>
> More comments below...
>
> > ---
> >   arch/arm/dts/nuvoton-common-npcm8xx.dtsi | 24 +++++++++++++++++++++++=
+
> >   drivers/watchdog/npcm_wdt.c              | 12 ++++++++----
> >   2 files changed, 32 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi b/arch/arm/dts/nu=
voton-common-npcm8xx.dtsi
> > index fabe5925b7..87c77dcb2c 100644
> > --- a/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
> > +++ b/arch/arm/dts/nuvoton-common-npcm8xx.dtsi
> > @@ -154,6 +154,30 @@
> >                               clock-names =3D "refclk";
> >                       };
> >
> > +                     watchdog0: watchdog@801c {
> > +                             compatible =3D "nuvoton,npcm750-wdt";
> > +                             reg =3D <0x801c 0x4>;
> > +                             clocks =3D <&clk NPCM8XX_CLK_REFCLK>;
> > +                             interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     watchdog1: watchdog@901c {
> > +                             compatible =3D "nuvoton,npcm750-wdt";
> > +                             reg =3D <0x901c 0x4>;
> > +                             clocks =3D <&clk NPCM8XX_CLK_REFCLK>;
> > +                             interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> > +                     watchdog2: watchdog@a01c {
> > +                             compatible =3D "nuvoton,npcm750-wdt";
> > +                             reg =3D <0xa01c 0x4>;
> > +                             clocks =3D <&clk NPCM8XX_CLK_REFCLK>;
> > +                             interrupts =3D <GIC_SPI 49 IRQ_TYPE_LEVEL=
_HIGH>;
> > +                             status =3D "disabled";
> > +                     };
> > +
> >                       serial0: serial@0 {
> >                               compatible =3D "nuvoton,npcm845-uart", "n=
uvoton,npcm750-uart";
> >                               reg =3D <0x0 0x1000>;
> > diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
> > index e56aa0ebe1..d6792bab35 100644
> > --- a/drivers/watchdog/npcm_wdt.c
> > +++ b/drivers/watchdog/npcm_wdt.c
> > @@ -69,17 +69,21 @@ static int npcm_wdt_stop(struct udevice *dev)
> >   static int npcm_wdt_reset(struct udevice *dev)
> >   {
> >       struct npcm_wdt_priv *priv =3D dev_get_priv(dev);
> > +     u32 val;
> >
> > -     writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
> > +     val =3D readl(priv->regs);
> > +     writel(val | NPCM_WTR, priv->regs);
> >
> >       return 0;
> >   }
> > -
> >   static int npcm_wdt_expire_now(struct udevice *dev, ulong flags)
> >   {
> > -     return npcm_wdt_reset(dev);
> > -}
> > +     struct npcm_wdt_priv *priv =3D dev_get_priv(dev);
> >
> > +     writel(NPCM_WTR | NPCM_WTRE | NPCM_WTE, priv->regs);
> > +
> > +     return 0;
> > +}
> >   static int npcm_wdt_of_to_plat(struct udevice *dev)
>
> Hmmm. This will result in npcm_wdt_of_to_plat() not having an empty line
> before its declaration. Please fix.
>
> Thanks,
> Stefan
