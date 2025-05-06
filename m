Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F92C3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 09:33:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DB280BAE;
	Tue,  6 May 2025 11:33:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Izi1Ztzj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB09882076; Tue,  6 May 2025 11:33:02 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C386800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 11:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-30ddad694c1so57565451fa.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 02:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746523979; x=1747128779; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VvBupOc1kt9G4LF+ltgz0jSle1WPVBBvBQUc8QkHm2Q=;
 b=Izi1ZtzjNSvWXbSixZEPHMAK/A6wxVpDFTrZrnN+UVlxnVqvzts8euPtXm3/xE4Ktz
 1rss7GlnYRplit6LgO2nJk1KJ1DaFjIKAG4Mz2xY1yFCoghyl5JttK/1UN6PQsodKZGF
 JLYTg1A4K5b0VvokYNz23TC7V5VIsZW5j/IX2dmFwWBEixcvwBS9/mrDJ2WUMJPusn6E
 JR9e+KMuqcOl+8bJflKqinVe3hrnOIxdhNFhoUo+TWEEv/fkI+Nqnn3PiXr9gmn/SEKv
 nabpZj/O46mCyN6K18pXAwRmH3cbItIXLHsyWo8rG4l+I16tJf2kfYHoFp6wV36TUo9x
 hBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746523979; x=1747128779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VvBupOc1kt9G4LF+ltgz0jSle1WPVBBvBQUc8QkHm2Q=;
 b=XI74GkVOFP5oYUaZwAUVEkasZemhT0V/Bmxhc3AVAmvYz4Oz77yXZq4fuTzMpuIVPt
 8oq1bqh6k0Oaz1k96zW4qOter52a+fkhmXqs0xhpF8ytG6SO3DnGAKp4PIF5hI9Zyepj
 nzteCghKepONrML16wco7T/8+DdMwI4Dr9s6vRH3cvwmfe5Bop2Lct5GmgdrQSQStGT0
 PQ6wCF/uIWFqzPVPnDdDABvtoLHHeVk2LX8loebVgCMItrhF/aHCyuEMicnhFq20rykm
 Hy5tL4ob6NKb/BmiGtodemz1RK4sPa+n9Ho0pTj+yBm4S0/iiop0gFBgVEyFav2Wl75x
 +cKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViQF184Ku+hCkUeYzlToEUuBlmDqJJvpkzzGhyvlVXll0epFAn9iePiOqt6LomambzowIcFYw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz6Hnj1C4mKob55vSbh71+zqR5d7rxmf3ne25bNMq4EW0t3XXoo
 rwUQbCvuZs59NeW66Mh0baTeH0lW5uS2aCMVbILAjri/muYysXkJy7sqzqIjSyR4sX+7GnUvEBw
 uxV1YGwR/l+He8BlSWyAUcMU8nEY=
X-Gm-Gg: ASbGncv0+adWf3+QCVVxqbqivAACZg+stbwagRN+huQo+lc/BAj3cwpvlejt0RMHfq8
 RPuMpPXQzMipT6KIf3PjkdzJZWYnW3qYpJPT3xsBFBj/bY6c86Ht3o2NAFy1BycShCnAuzvp3nK
 T5MSNstIoQVMx/5pRVbPwQkhM=
X-Google-Smtp-Source: AGHT+IF0EAtj5IQ3itf62sgimz6wksN8MBUxEpBpzHMlNbhs6811Kpz5Ub9PjpE23azzcklVFOASurbqTiPuHMhtZGI=
X-Received: by 2002:a2e:b88c:0:b0:30b:cc6a:ffd9 with SMTP id
 38308e7fff4ca-3233ebe4f14mr37692671fa.0.1746523979061; Tue, 06 May 2025
 02:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
 <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
 <20250428142316.geminnotbfmbkpxs@skbuf>
 <PAXPR04MB85100048CC9987A31C4B578A88802@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB85100048CC9987A31C4B578A88802@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Tue, 6 May 2025 11:32:47 +0200
X-Gm-Features: ATxdqUG3pkUq_onytF58gC4Q81QfKcFYv-9z-no_xq5yE-fa6zKsub5PH0yGpho
Message-ID: <CAEyMn7b3DXKY7QETfxd0Lsi-3HwXL1E8QpD1SdyHnq0s3A5x1g@mail.gmail.com>
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
To: Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Michael Walle <mwalle@kernel.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 =?UTF-8?Q?Thomas_Sch=C3=A4fer?= <thomas.schaefer@kontron.com>, 
 Wei Fang <wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Alice, Hi Marek,



Am Di., 29. Apr. 2025 um 03:19 Uhr schrieb Wei Fang <wei.fang@nxp.com>:

> > > > With commit cc4e8af2c552, fsl_enetc register accessors have been
> > > > split to
> > >
> > > With 'commit cc4e8af2c552 ("net: fsl_enetc: Split register accessors")'
> > >
> > > > handle different register offsets on different SoCs. However, for
> > > > internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was
> > > > fixed without adding the SoC specific MAC register offset.
> > > >
> > > > As a result, the network support for the Kontron SMARC-sAL28 and
> > > > probably other boards based on the LS1028A CPU is broken.
> > > >
> > > > Add the SoC specific MAC register offset to calculation of
> > > > imdio.priv to fix this.
> > > >
> > > > Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> > > > Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> > > > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> > >
> > > With the nitpick above:
> > >
> > > Reviewed-by: Michael Walle <mwalle@kernel.org>
> > >
> > > > ---
> > > >
> > > > But the question that now arises is, does this code path work on the
> > > > imx SoCs as well. Now the imx specific offset 0x5000 is added here
> > > > and was not used before.
> > >
> > > Maybe the imx9 doesn't use the internal MDIO controller or the board
> > > which was this tested on doesn't use the PCS?
> > >
> > > -michael
> >
> > The imx specific offset 0x5000 should be correct.
> >
> > In downstream, the ENETC_PM_IMDIO_BASE macro is used in common code, but
> > defined twice - there is a conditional include of either fsl_enetc.h, or
> fsl_enetc4.h,
> > depending on whether CONFIG_ARCH_IMX9 is defined. Thus,
> > ENETC_PM_IMDIO_BASE is replaced either with 0x8030 or 0x5030 in
> > downstream.
> >
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_enetc
> .
> > c#L25
> >
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_enetc
> .
> > h#L76
> >
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_enetc
> > 4.h#L126
> >
> > I guess Marek fell into the pitfall when upstreaming.
> >
> > > > Can someone please test this on an imx9 and confirm?
> > > >
> > > >  drivers/net/fsl_enetc.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c index
> > > > 52fa820f51..97cccda451 100644
> > > > --- a/drivers/net/fsl_enetc.c
> > > > +++ b/drivers/net/fsl_enetc.c
> > > > @@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevice
> > > > *dev)
> > > >  /* Apply protocol specific configuration to MAC, serdes as needed
> > > > */  static void enetc_start_pcs(struct udevice *dev)  {
> > > > + struct enetc_data *data = (struct enetc_data
> > > > +*)dev_get_driver_data(dev);
> > > >   struct enetc_priv *priv = dev_get_priv(dev);
> > > >
> > > >   /* register internal MDIO for debug purposes */
> > > >   if (enetc_read_pcapr_mdio(dev)) {
> > > >           priv->imdio.read = enetc_mdio_read;
> > > >           priv->imdio.write = enetc_mdio_write;
> > > > -         priv->imdio.priv = priv->port_regs + ENETC_PM_IMDIO_BASE;
> > > > +         priv->imdio.priv = priv->port_regs + data->reg_offset_mac +
> > > > +                            ENETC_PM_IMDIO_BASE;
> > > >           strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
> > > >           if (!miiphy_get_dev_by_name(priv->imdio.name))
> > > >                   mdio_register(&priv->imdio);
> > >
> >
> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1028A
> >
> > +Fang Wei to confirm/test for i.MX95.
>
> Hi Alice,
>
> Can you help check this patch on i.MX95?
>

Friendly reminder, are you able to confirm that?


BR,
Heiko
