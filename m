Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E33BC47DA2
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 16:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A208D87957;
	Tue, 16 Jan 2024 17:59:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d6McbjgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B07D987977; Tue, 16 Jan 2024 17:59:10 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE36C87078
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 17:59:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e7e55c0f6so12117198e87.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 08:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705424348; x=1706029148; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dnkzRpQ2N6H8qQpuWinn7KXN3DsNubqEkOx69xXVO/A=;
 b=d6McbjgRoQN5RHxoewqAyAhYZnmBjOQ0VOp1T+9l6FC1GB1YOzMPSAchY49rtPxCSW
 O6CSDEgBvNxlK/7w8q97CeXNRgu6Im5kRt8L+irPrbqGX4yMQ6B1+tZTfOefF8Mr7QTW
 gtzlZfGEvqCuXNntaj2zn4jYnWyke04xySYQ5cAAGhcfvfOnVkBH7guYeP5WtUNmkrlw
 D2l+LDf/Vu4A1jq+Xp3GshGuepKt92tLYErT+PZNe/AVJxmfXVBodnVUJiGJouRaifA9
 2IJ2jNo5AIvhjHN1drBV7qFLZY8y9pdfCsRjmHNouLI8+q3MdYB+8a3mfZm174LFtQ4V
 ujBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705424348; x=1706029148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dnkzRpQ2N6H8qQpuWinn7KXN3DsNubqEkOx69xXVO/A=;
 b=ilPVjx7OFwW8jFMRggxYPsj+mbAsd8jKKlTKWPACDI7LV92vKmXmOzeYD0Pf25rear
 VGjjYkBIw8efNLAJTHoUYneimPs/DRr4PpPpEoNfhRfCdjrm94jQjQ0HB+uFPnnblUzX
 pZLM16Xq5bRNWOLVuWiLlv/FBzpNjZpAj1vBGvyu+n1UX/B61ZD2r7+vpl+z9oKgOVzP
 P7JHqnDRLJ6SwXWVVL+8NNCYg0mV/JfFY5cFaFzUtK3v1+hXPeuw88+NX2NEve3TnJK4
 PjdTaumPlsUU1EJ1C5IxkmhTWDUDRZl2FpnR9d4MBizAa5H9u5DYYfHztbOsqLeP8ndY
 fEQQ==
X-Gm-Message-State: AOJu0YyvpP7kEqBf/KPTFeuHwHmLnY2CEpfdl9757vjrmIHIulsvIUCv
 bZ0U/FFxqhwrjKdhrgzIgIyb3QxCrn/fgJRX8Sg=
X-Google-Smtp-Source: AGHT+IFpt84M+SXm7ZTtjg/wiREHfy9XlvupOk/u+6O4T3mvqucPVndMT3dVEosZQrxR23fX+64ryJS7Vle76Hp4RXY=
X-Received: by 2002:a05:6512:3e7:b0:50e:e3e5:40f8 with SMTP id
 n7-20020a05651203e700b0050ee3e540f8mr1674978lfq.1.1705424347631; Tue, 16 Jan
 2024 08:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20230614214405.1038301-1-bigunclemax@gmail.com>
 <20240116001735.7c48ea88@minigeek.lan>
In-Reply-To: <20240116001735.7c48ea88@minigeek.lan>
From: Maxim Kiselev <bigunclemax@gmail.com>
Date: Tue, 16 Jan 2024 19:58:56 +0300
Message-ID: <CALHCpMg2atqadF4Kxt8E=+dh015sq4uN39TQbeOSWPkUkuMM8g@mail.gmail.com>
Subject: Re: [PATCH v1] net: sun8i-emac: Add support for fixed-link phy
To: Andre Przywara <andre.przywara@arm.com>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
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

=D0=B2=D1=82, 16 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 03:18, And=
re Przywara <andre.przywara@arm.com>:
>
> On Thu, 15 Jun 2023 00:44:06 +0300
> Maxim Kiselev <bigunclemax@gmail.com> wrote:
>
> Hi Maxim,
>
> > From: Maksim Kiselev <bigunclemax@gmail.com>
> >
> > Based on dt-specs fixed-link doesn't require phy-handle to be used.
>
> Do you have such a board?

Yes, I had a custom board with T113 SoC which has fixed phy eth.

> And where is that written down? I don't see
> it explicitly mentioned as optional in ethernet-controller.yaml or in
> the DT spec PDF.

Sorry for that commit description. I just found the similar commit, that
fixes the same problem for zynq_gem
3888c8d1979289efe685fe29276aed4d4b685975 ("net: zynq_gem: Add support for
fixed-link phy") and copied the description from there.

> The sun8i EMAC binding lists phy-handle as required,
> so that would need to be relaxed there then.

Oh, indeed. So it will require to send dt-binding changes to Linux first...

Therefore, I think we can live without fixed-phy support for sun8i EMAC.
At least until some device with such a configuration appears on the
market :)

> > Fix driver to only read phy related setting when phy-handle is found.
>
> The patch itself looks fine, we already specify -1 as the default when
> the PHY DT node does not contain a reg property, so that looks like it
> would work.
>
> Cheers,
> Andre
>
> > Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> > ---
> >  drivers/net/sun8i_emac.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
> > index 04c3274fbe..0e339d69e0 100644
> > --- a/drivers/net/sun8i_emac.c
> > +++ b/drivers/net/sun8i_emac.c
> > @@ -834,11 +834,8 @@ static int sun8i_emac_eth_of_to_plat(struct udevic=
e *dev)
> >       priv->use_internal_phy =3D false;
> >
> >       offset =3D fdtdec_lookup_phandle(gd->fdt_blob, node, "phy-handle"=
);
> > -     if (offset < 0) {
> > -             debug("%s: Cannot find PHY address\n", __func__);
> > -             return -EINVAL;
> > -     }
> > -     priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset, "reg", -1)=
;
> > +     if (offset >=3D 0)
> > +             priv->phyaddr =3D fdtdec_get_int(gd->fdt_blob, offset, "r=
eg", -1);
> >
> >       pdata->phy_interface =3D dev_read_phy_mode(dev);
> >       debug("phy interface %d\n", pdata->phy_interface);
>

Best wishes,
Maksim
