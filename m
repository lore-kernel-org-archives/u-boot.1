Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E82C3ABBC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 15:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E36B8210D;
	Tue,  6 May 2025 17:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="XcxzBgfn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8F58210D; Tue,  6 May 2025 17:31:52 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C4A820EB
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 17:31:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e7311e66a8eso5293953276.2
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1746545507; x=1747150307; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mJMPsb2rLLUH78FYmkLHx0OZF9/neV4ybQepfBOmSAU=;
 b=XcxzBgfnzo3oq58yf6/HV5CKtIgN6oJH+fXKqynaP5Y7ro8GnLpVhGrYLFt/KaZrl5
 wX2zoVOTNU7D8Uo5g+tAgc5zzDhAkqtowznSvg3700WoJSkMdpcbmqld4t/8H/kMmbaq
 rdBnrhRC3GWD19LUExwBNb8GkclKD7MiPRQ5dnBsHdoE75sAnt5VdBAWpDiZcnmWgklB
 8KyLfXqXTBSQEA42h56nXlljj6BcYlcLryemlCTceNpwwrCJTFGajkY9TWnnadF65VFE
 Fte90FYgvTynp9joOkbEAZhFC8fbzkgcMnJeFsM+3jSk9Xzp7RtysS+7n00RnYAHAZZ3
 Khvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746545507; x=1747150307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mJMPsb2rLLUH78FYmkLHx0OZF9/neV4ybQepfBOmSAU=;
 b=qzjEQBM5hBXmfJRrd8apDG3VNfrMzRhrQeYl2MZIzYCxmE6a8UEZOBz03izzGgKEkw
 QijdnOaZPzVrJ1/TPLvI/DgVegWmw3ofGOg87Fmfbl4nteccDoOtA4HhZMORxtbQwZeA
 E2P1+hh8S0wddrl1IKMMSp7IJIL4F1QF/UFwnYlbhILQVs+PCxExWSHOapFeki8EHZXN
 +25QN2O4omCTbgQtMk4ZTrRwF3kRMDdBlBUh1OyaO8eTVoOh79vYiI4AnDOif/KW5bJS
 kfeET9l+yiCU1+yrUI1fowpI81bXZq9yt7vzI8TznroYjYuMRZ5n65Y6bYWR+2suoiOb
 n+6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPqOFd1X/6RClAnut0yAgPjDPCi2YLq/0ndmb2ZK4/N3pixI5NBILMAGczfFFKXu3SFdLDuYc=@lists.denx.de
X-Gm-Message-State: AOJu0YwEWC60CiVLs68YHwrCRusnhmxlnFy0fn81z2KnqM7KkeU/jT6v
 bl3ewnSwwYlE9Qg/qExOYfB+hNCLmCDjndy94A2lt3El4bdPTvee6oJwyH/PDZ28UfZ5WyMTMWg
 SbIcSpMDYXBtKYWaav64blAIEb6NDOtSQ0uhcxw==
X-Gm-Gg: ASbGncvV3vPoBUm03iasMS27eQxq6AyZrw6X70H875kDze4d2RpuDFkMyGyphn6pP85
 50kpThEEtiX91/XlB1edtqn+FKgsupD6cK9MFWEXzos3Uf9YWIRgJzbaLN2dYKEMI1/TbnwpzxK
 tgIfOUPgc5D64HwKMfq7ZDNg==
X-Google-Smtp-Source: AGHT+IGmtPmwQg5i4k6J674pqSCPyOh4IybostEoS281YaLSQ/1Z1YL7ZRDNh82120pVL7b7l/HEC7CXURuOL4aZD3w=
X-Received: by 2002:a05:690c:6a02:b0:6fb:277f:f022 with SMTP id
 00721157ae682-708eaee7098mr157526587b3.15.1746545506843; Tue, 06 May 2025
 08:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250428095945.1432389-1-heiko.thiery@gmail.com>
 <D9I6S5PD32TJ.3AGU7UM3EUOF6@kernel.org>
 <20250428142316.geminnotbfmbkpxs@skbuf>
 <PAXPR04MB85100048CC9987A31C4B578A88802@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <CAEyMn7b3DXKY7QETfxd0Lsi-3HwXL1E8QpD1SdyHnq0s3A5x1g@mail.gmail.com>
In-Reply-To: <CAEyMn7b3DXKY7QETfxd0Lsi-3HwXL1E8QpD1SdyHnq0s3A5x1g@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 6 May 2025 08:31:35 -0700
X-Gm-Features: ATxdqUEETlSMeXX6nLLClTpXBjK10PiFzjdD3vZMyVtmHuBBCh_0p23Zovs8Zzo
Message-ID: <CAJ+vNU3wan-_EKX7oC04sa2Oc726D9OjquoCDtby+t_SwN9XGw@mail.gmail.com>
Subject: Re: [PATCH] net: fsl_enetc: fix imdio register calculation
To: Heiko Thiery <heiko.thiery@gmail.com>
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

On Tue, May 6, 2025 at 2:33=E2=80=AFAM Heiko Thiery <heiko.thiery@gmail.com=
> wrote:
>
> Hi Alice, Hi Marek,
>
>
>
> Am Di., 29. Apr. 2025 um 03:19 Uhr schrieb Wei Fang <wei.fang@nxp.com>:
>>
>> > > > With commit cc4e8af2c552, fsl_enetc register accessors have been
>> > > > split to
>> > >
>> > > With 'commit cc4e8af2c552 ("net: fsl_enetc: Split register accessors=
")'
>> > >
>> > > > handle different register offsets on different SoCs. However, for
>> > > > internal MDIO register calculation, only ENETC_PM_IMDIO_BASE was
>> > > > fixed without adding the SoC specific MAC register offset.
>> > > >
>> > > > As a result, the network support for the Kontron SMARC-sAL28 and
>> > > > probably other boards based on the LS1028A CPU is broken.
>> > > >
>> > > > Add the SoC specific MAC register offset to calculation of
>> > > > imdio.priv to fix this.
>> > > >
>> > > > Fixes: cc4e8af2c552 ("net: fsl_enetc: Split register accessors")
>> > > > Signed-off-by: Thomas Schaefer <thomas.schaefer@kontron.com>
>> > > > Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
>> > >
>> > > With the nitpick above:
>> > >
>> > > Reviewed-by: Michael Walle <mwalle@kernel.org>
>> > >
>> > > > ---
>> > > >
>> > > > But the question that now arises is, does this code path work on t=
he
>> > > > imx SoCs as well. Now the imx specific offset 0x5000 is added here
>> > > > and was not used before.
>> > >
>> > > Maybe the imx9 doesn't use the internal MDIO controller or the board
>> > > which was this tested on doesn't use the PCS?
>> > >
>> > > -michael
>> >
>> > The imx specific offset 0x5000 should be correct.
>> >
>> > In downstream, the ENETC_PM_IMDIO_BASE macro is used in common code, b=
ut
>> > defined twice - there is a conditional include of either fsl_enetc.h, =
or fsl_enetc4.h,
>> > depending on whether CONFIG_ARCH_IMX9 is defined. Thus,
>> > ENETC_PM_IMDIO_BASE is replaced either with 0x8030 or 0x5030 in
>> > downstream.
>> > https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/f=
sl_enetc.
>> > c#L25
>> > https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/f=
sl_enetc.
>> > h#L76
>> > https://github.com/nxp-qoriq/u-boot/blob/lf-6.12.3-1.0.0/drivers/net/f=
sl_enetc
>> > 4.h#L126
>> >
>> > I guess Marek fell into the pitfall when upstreaming.
>> >
>> > > > Can someone please test this on an imx9 and confirm?
>> > > >
>> > > >  drivers/net/fsl_enetc.c | 4 +++-
>> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > > >
>> > > > diff --git a/drivers/net/fsl_enetc.c b/drivers/net/fsl_enetc.c ind=
ex
>> > > > 52fa820f51..97cccda451 100644
>> > > > --- a/drivers/net/fsl_enetc.c
>> > > > +++ b/drivers/net/fsl_enetc.c
>> > > > @@ -473,13 +473,15 @@ static int enetc_init_sxgmii(struct udevice
>> > > > *dev)
>> > > >  /* Apply protocol specific configuration to MAC, serdes as needed
>> > > > */  static void enetc_start_pcs(struct udevice *dev)  {
>> > > > + struct enetc_data *data =3D (struct enetc_data
>> > > > +*)dev_get_driver_data(dev);
>> > > >   struct enetc_priv *priv =3D dev_get_priv(dev);
>> > > >
>> > > >   /* register internal MDIO for debug purposes */
>> > > >   if (enetc_read_pcapr_mdio(dev)) {
>> > > >           priv->imdio.read =3D enetc_mdio_read;
>> > > >           priv->imdio.write =3D enetc_mdio_write;
>> > > > -         priv->imdio.priv =3D priv->port_regs + ENETC_PM_IMDIO_BA=
SE;
>> > > > +         priv->imdio.priv =3D priv->port_regs + data->reg_offset_=
mac +
>> > > > +                            ENETC_PM_IMDIO_BASE;
>> > > >           strlcpy(priv->imdio.name, dev->name, MDIO_NAME_LEN);
>> > > >           if (!miiphy_get_dev_by_name(priv->imdio.name))
>> > > >                   mdio_register(&priv->imdio);
>> > >
>> >
>> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> > Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com> # LS1028A
>> >
>> > +Fang Wei to confirm/test for i.MX95.
>>
>> Hi Alice,
>>
>> Can you help check this patch on i.MX95?
>
>
> Friendly reminder, are you able to confirm that?
>
>
> BR,
> Heiko

Hi Heiko,

I was able to test this on top of master with an imx95_19x19_evk -
enetc (1gb) interface works before and after the patch. Was there
something more specific that needs testing?

Tested-by: Tim Harvey <tharvey@gateworks.com> # imx95_19x19_evk

Best Regards,

Tim
