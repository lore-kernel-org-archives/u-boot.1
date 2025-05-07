Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 430EBC369DC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 05:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7535F81F66;
	Wed,  7 May 2025 07:12:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cj3nHzZi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E649781FAB; Wed,  7 May 2025 07:12:53 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308938007D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 07:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=heiko.thiery@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30bf5d7d107so52270061fa.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 22:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746594770; x=1747199570; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2IQ/rItXgKbo6wBGNcvIw0xrIDYfNwAVoVX7OBxJtN8=;
 b=Cj3nHzZiBhUX3d9lLW9tO6XGbxiYvokRNC8cz7tH48NdH27xNwaIWtoKocT2/X2pj6
 UgppIbA5q4nWBccpbHARdNtWivRAPkoLJjYr1rGyf974ILn4wPVHjxWSrDC0e0XNZmow
 +iseXBTBADdvXWz10bs3NBnTsPZ2ASANnMeRlefXb6TeabJoKzUMFJN/eSjQpN5KkMWD
 j2FU0ecyXQbz+lHqs8wPKET0zYAmHjms6pdxBhzH27fvXLgTithNqS4rQMyfZClJoctJ
 HUUF7z1UFQybpRk5ZcvwqGhFqfgPS15oxZwb3a6tkZkrH4M1ZDWp4i5d5Gkp0W7x5n19
 eETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746594770; x=1747199570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2IQ/rItXgKbo6wBGNcvIw0xrIDYfNwAVoVX7OBxJtN8=;
 b=h7cYA9U3TAbRBjRSpJRhJ9O6tq48MGb1l9gOfG9NBxTJO0OV3md/tVvalR7miSlDm5
 ylO3sbZMl2Agk4QHJx1vl//bzYFqaPH96yjaY37n/ts3TxKoe1j11aUUEtyVOTk4C/cQ
 zaGT56seki7UOgrSFrUsLwgRDDYg1M+xFwavSAKv0e17y/u1/8gfZSTUC5ahMfFw51dJ
 sEM861t0LilzsDEEUIdKFQAuelgKADYz75VIuoHZ38DqFo9wH11lUHR51Fv27ADbbFrS
 seM8lncHWzHI/eGJ1EB5B3Er3zqH9c7ZWJ31UvvnbazaM/OFfI3t+gji81u0f1EUp1BP
 qJAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVARy62DhF71eBEwAdcGA5VvWlIGOTM520f2KjWWPuEuYgkbe1tA8F88MDusAU/XjVmirLhto=@lists.denx.de
X-Gm-Message-State: AOJu0YzjhoEkF/StBeYTJNFvdPbJFFLdNzzcXMMCKKVYijqjCp8vRVhL
 NvitDr3W/ss6F3tflczHYLAsftOON/HVBfbectmXeRsaqexd2OE1ossX+yTU3Rm+8Hwydm83fDp
 VAqGTU1asyUlOoXisE0j0Wh+wvU8=
X-Gm-Gg: ASbGncubkGMG7Apc4xAC1IwkSBobIdo8ZLagyC4xSyFlL8sxIjv518XEkwV5UuysPqX
 WAneHoGI5LCRrQv83mr9K0ZMdUPT2fwPJYeKrSeQfVEaaioaDRnqEm+NMJrwlr68kBMSVgb9Vie
 RiEQ0zY2IfJfKaDgwnRD04d1xmiAb5WX04uw==
X-Google-Smtp-Source: AGHT+IGX9LssiMPy5Y1VEu/hq//TDS66nTUBmEx9v377UvRYx1oPDF4Vc7dvoSAiS9t6Dzz+2DejG5GczCPwYIoUhcg=
X-Received: by 2002:a2e:b891:0:b0:30c:f60:6c6 with SMTP id
 38308e7fff4ca-326ad15318fmr5684971fa.6.1746594770103; 
 Tue, 06 May 2025 22:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
 <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
 <20250428142316.geminnotbfmbkpxs@skbuf>
 <PAXPR04MB85100048CC9987A31C4B578A88802@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <CAEyMn7b3DXKY7QETfxd0Lsi-3HwXL1E8QpD1SdyHnq0s3A5x1g@mail.gmail.com>
 <CAJ+vNU3wan-_EKX7oC04sa2Oc726D9OjquoCDtby+t_SwN9XGw@mail.gmail.com>
In-Reply-To: <CAJ+vNU3wan-_EKX7oC04sa2Oc726D9OjquoCDtby+t_SwN9XGw@mail.gmail.com>
From: Heiko Thiery <heiko.thiery@gmail.com>
Date: Wed, 7 May 2025 07:12:36 +0200
X-Gm-Features: ATxdqUGP-TJbhDk06HExy2U1aSiCBV3-X6caZaGN5Zvixqfnd4UHQxCgSlBAtrA
Message-ID: <CAEyMn7Yt_1GD+esTiAziAcUKL6SuQXi7Mj__g=hszFdJoD_dhw@mail.gmail.com>
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
To: Tim Harvey <tharvey@gateworks.com>
Cc: Alice Guo <alice.guo@nxp.com>, Marek Vasut <marex@denx.de>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Michael Walle <mwalle@kernel.org>, 
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>, 
 =?UTF-8?Q?Thomas_Sch=C3=A4fer?= <thomas.schaefer@kontron.com>, 
 Wei Fang <wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Tim,

Am Di., 6. Mai 2025 um 17:31 Uhr schrieb Tim Harvey <tharvey@gateworks.com>=
:

> On Tue, May 6, 2025 at 2:33=E2=80=AFAM Heiko Thiery <heiko.thiery@gmail.c=
om>
> wrote:
> >
> > Hi Alice, Hi Marek,
> >
> >
> >
> > Am Di., 29. Apr. 2025 um 03:19 Uhr schrieb Wei Fang <wei.fang@nxp.com>:
> >>
> >> > > > With commit cc4e8af2c552, fsl_enetc register accessors have been
> >> > > > split to
> >> > >
> >> > > With 'commit cc4e8af2c552 ("net: fsl_enetc: Split register
> accessors")'
> >> > >
> >> > > > handle different register offsets on different SoCs. However, fo=
r
> >> > > > internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was
> >> > > > fixed without adding the SoC specific MAC register offset.
> >> > > >
> >> > > > As a result, the network support for the Kontron SMARC-sAL28 and
> >> > > > probably other boards based on the LS1028A CPU is broken.
> >> > > >
> >> > > > Add the SoC specific MAC register offset to calculation of
> >> > > > imdio.priv to fix this.
> >> > > >
> >> > > > Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
> >> > > > Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
> >> > > > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> >> > >
> >> > > With the nitpick above:
> >> > >
> >> > > Reviewed-by: Michael Walle <mwalle@kernel.org>
> >> > >
> >> > > > ---
> >> > > >
> >> > > > But the question that now arises is, does this code path work on
> the
> >> > > > imx SoCs as well. Now the imx specific offset 0x5000 is added he=
re
> >> > > > and was not used before.
> >> > >
> >> > > Maybe the imx9 doesn't use the internal MDIO controller or the boa=
rd
> >> > > which was this tested on doesn't use the PCS?
> >> > >
> >> > > -michael
> >> >
> >> > The imx specific offset 0x5000 should be correct.
> >> >
> >> > In downstream, the ENETC_PM_IMDIO_BASE macro is used in common code,
> but
> >> > defined twice - there is a conditional include of either fsl_enetc.h=
,
> or fsl_enetc4.h,
> >> > depending on whether CONFIG_ARCH_IMX9 is defined. Thus,
> >> > ENETC_PM_IMDIO_BASE is replaced either with 0x8030 or 0x5030 in
> >> > downstream.
> >> >
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_=
enetc
> .
> >> > c#L25
> >> >
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_=
enetc
> .
> >> > h#L76
> >> >
> https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/fsl_=
enetc
> >> > 4.h#L126
> >> >
> >> > I guess Marek fell into the pitfall when upstreaming.
> >> >
> >> > > > Can someone please test this on an imx9 and confirm?
> >> > > >
> >> > > >  drivers/net/fsl_enetc.c | 4 +++-
> >> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> > > >
> >> > > > diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c
> index
> >> > > > 52fa820f51..97cccda451 100644
> >> > > > --- a/drivers/net/fsl_enetc.c
> >> > > > +++ b/drivers/net/fsl_enetc.c
> >> > > > @@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevic=
e
> >> > > > *dev)
> >> > > >  /* Apply protocol specific configuration to MAC, serdes as need=
ed
> >> > > > */  static void enetc_start_pcs(struct udevice *dev)  {
> >> > > > + struct enetc_data *data =3D (struct enetc_data
> >> > > > +*)dev_get_driver_data(dev);
> >> > > >   struct enetc_priv *priv =3D dev_get_priv(dev);
> >> > > >
> >> > > >   /* register internal MDIO for debug purposes */
> >> > > >   if (enetc_read_pcapr_mdio(dev)) {
> >> > > >           priv->imdio.read =3D enetc_mdio_read;
> >> > > >           priv->imdio.write =3D enetc_mdio_write;
> >> > > > -         priv->imdio.priv =3D priv->port_regs +
> ENETC_PM_IMDIO_BASE;
> >> > > > +         priv->imdio.priv =3D priv->port_regs +
> data->reg_offset_mac +
> >> > > > +                            ENETC_PM_IMDIO_BASE;
> >> > > >           strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
> >> > > >           if (!miiphy_get_dev_by_name(priv->imdio.name))
> >> > > >                   mdio_register(&priv->imdio);
> >> > >
> >> >
> >> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> >> > Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1028A
> >> >
> >> > +Fang Wei to confirm/test for i.MX95.
> >>
> >> Hi Alice,
> >>
> >> Can you help check this patch on i.MX95?
> >
> >
> > Friendly reminder, are you able to confirm that?
> >
> >
> > BR,
> > Heiko
>
> Hi Heiko,
>
> I was able to test this on top of master with an imx95_19x19_evk -
> enetc (1gb) interface works before and after the patch. Was there
> something more specific that needs testing?
>
>
No, this should be ok, I think it is good to know that the fix does not
influence the behavior on the imx9.


> Tested-by: Tim Harvey <tharvey@gateworks.com> # imx95_19x19_evk
>
> Best Regards,
>

> Tim
>


Thanks,
Heiko
