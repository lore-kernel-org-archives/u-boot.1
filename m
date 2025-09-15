Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FE4CAC597
	for <u-boot@archiver.kernel.org>; Mon, 15 Sep 2025 15:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0599A830CA;
	Mon, 15 Sep 2025 17:52:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZm238Gq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD2A830CA; Mon, 15 Sep 2025 17:52:41 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9371180B9B
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 17:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45decc9e83eso47976555e9.3
 for <u-boot@lists.denx.de>; Mon, 15 Sep 2025 08:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757951559; x=1758556359; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nE95SRHM5WsxxyZLbDkZ5n2nrtTjMwmv21OqVrMDAkU=;
 b=JZm238GqyhfiKahRZHSNLs6Nmn/ptdnd6zki6J+J/uYcTINlzQ2fyiV/I+9olp+9T3
 RjgInVOSD0d6NNjso6DC4Qz+p5Aael/Cs6Rdfkl8UxakRbIZv6euGMkPtlvQVgqqKIrT
 hDnVNP+lqiY5uGorvr6zkatq3mdXlsXfNm0oUY9A1neWsaGSOedTapRSFcHLBNUgSf6T
 pdoXbUdhSpGnihg647ztNb3OWJDsdcMa0gBzLDzNi8tzqkBQVQPVkaXyRJFuIuTa94n9
 DD47cNedADJNx08YM8qSFa07Dle4YLiNtyVH5GzyCZtA1/YoLeWDbxIn7o0d896UOqun
 mttw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757951559; x=1758556359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nE95SRHM5WsxxyZLbDkZ5n2nrtTjMwmv21OqVrMDAkU=;
 b=h7eFzBNC+wvI81YbNN0vkUw+0r6DQK2p0NgiCJsc/w26V908KtBlDZXT19Xmcc2k44
 v0gHQNS+91FZO/nWxpbmrCFB9LpLYNJyj0dwxo2YsXeX2DGfJi1KbWu/qbh4ciOlxsaQ
 qL7wc2niKU2LbWzHWGpN1RFZ0foAeyHPhyV/EJMFxFJFRKNhFTWYKLYqkMnSXu/LrcH/
 q132YyNITlVTKvDYMK8kCFTGxpeaQWo+dXeyuXZ2mv8VcfYh7A4t8zJOA2MzdI6fPsvG
 x9Jb3X1ddSPplR3kcB7H/jwfjx7LDqw8Rh6I1BJkTriWKLY08DzTA485zEQ/GgC5OOVB
 Uxgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjIVL9OQL64DPFESwBszD5cuKFVjgGHs+g2woLATDW4+tPeQwznISeNs+SlocET89bamlyOBY=@lists.denx.de
X-Gm-Message-State: AOJu0YwiyNb3GlBsynkSCddFv3TkYj2im9SWvWqMsNaXQdZj38EhHfFM
 COYeIwz3D22u5Gi4d1YkIhC6qOucisLBucvtdcK4fFNKjtM2yGLDkQEC
X-Gm-Gg: ASbGncsvwZAtYwi1Y/JARNllag3dIW7vD2x9j9/GzUyUtUb3IU3QXocIiGHDZ2quMP8
 cc1QkARAzdjwkLv0j2HYZMqEA5mkvz0RH3y83hckVhWvwcDQG9D6cWSFWHU0DvMn0gbnEDmR1/V
 rCKEeBAOdx8jIcs3OwCUZQcMH9p5taPWF2f+vbkU4Qfj1IKxjPb0NUvq2RVZFBUdKN/tbAip/Hw
 3Lgm+7yPtP5z/FWFe8HYwyvHiSmI65h8UL+a4uONB5jdbxWK9y7YAhIzwhn3rnTa3eX2RcU8BQe
 P6NRZvPmgSHR4H7jvt9O83IZL6cmqdFUQCbp7M/Qg+xmL7UYejp8q3WDERAhelp9uj88aGkh3kr
 fwym/uRpOOY3TApn0/iVishehp9zk8uJiTKcdUn1q307RV5DzsOzAWNIj5w5GgrRlrnIpElXZiz
 JsgDezwKDARw==
X-Google-Smtp-Source: AGHT+IFQYIUacefjsyaIJ/5D5w+dubs5MGw17v+/xqIxvPCKvLjZRz3vRqy9EdisyU6FhzG6jSfmiw==
X-Received: by 2002:a05:600c:4e92:b0:45f:286e:49a8 with SMTP id
 5b1f17b1804b1-45f286e4c58mr74069425e9.30.1757951558614; 
 Mon, 15 Sep 2025 08:52:38 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45f27f44624sm107457145e9.3.2025.09.15.08.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 08:52:38 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Lukas Schmid <lukas.schmid@netcube.li>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 "linux-sunxi@lists.linux.dev" <linux-sunxi@lists.linux.dev>,
 =?UTF-8?B?QW5kcsOhcyBTemVtesWR?= <szemzo.andras@gmail.com>
Subject: Re: [PATCH v1 1/1] sunxi: extend R528/T113-s3/D1(s) DRAM
 initialisation
Date: Mon, 15 Sep 2025 17:52:37 +0200
Message-ID: <3006634.e9J7NaK4W3@jernej-laptop>
In-Reply-To: <20250915163637.38d05aab@donnerap>
References: <20250914144411.157826-1-lukas.schmid@netcube.li>
 <20250915163637.38d05aab@donnerap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne ponedeljek, 15. september 2025 ob 17:36:37 Srednjeevropski poletni =C4=
=8Das je Andre Przywara napisal(a):
> On Sun, 14 Sep 2025 16:44:11 +0200
> Lukas Schmid <lukas.schmid@netcube.li> wrote:
>=20
> Hi Lukas,
>=20
> thanks for the patch!
>=20
> CC:ing the sunxi list and Andr=C3=A1s, who I think has some T113-s4 devic=
e as
> well.
>=20
> It would be good to see some Tested-by: tags, but otherwise the patch
> looks good, I'd say.
>=20
> Also I hear that awboot uses 0x6800 as the chip ID for the -s4, can
> someone shed some light on this?
>=20
> Cheers,
> Andre
>=20
> > Extend the DRAM initialisation code to add support for the T113-S4 aka
> > T113M4020DC0 by checking the SoC's CHIPID.
> >=20
> > Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
> > ---
> >  drivers/ram/sunxi/dram_sun20i_d1.c | 13 ++++++++++++-
> >  drivers/ram/sunxi/dram_sun20i_d1.h |  7 +++++++
> >  2 files changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.c b/drivers/ram/sunxi/dra=
m_sun20i_d1.c
> > index a1794032f3b..01d19d5feaa 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.c
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.c
> > @@ -54,6 +54,11 @@ static void sid_read_ldoB_cal(const dram_para_t *par=
a)
> >  	clrsetbits_le32(0x3000150, 0xff00, reg << 8);
> >  }
> > =20
> > +static u32 sid_read_soc_chipid(void)
> > +{
> > +	return readl(SUNXI_SID_BASE + 0x00) & 0xffff;
> > +}
> > +
> >  static void dram_voltage_set(const dram_para_t *para)
> >  {
> >  	int vol;
> > @@ -663,6 +668,7 @@ static void mctl_phy_ac_remapping(const dram_para_t=
 *para,
> > =20
> >  	fuse =3D (readl(SUNXI_SID_BASE + 0x28) & 0xf00) >> 8;
> >  	debug("DDR efuse: 0x%x\n", fuse);
> > +	debug("SoC Chip ID: 0x%08x\n", sid_read_soc_chipid());
> > =20
> >  	if (para->dram_type =3D=3D SUNXI_DRAM_TYPE_DDR2) {
> >  		if (fuse =3D=3D 15)
> > @@ -675,7 +681,12 @@ static void mctl_phy_ac_remapping(const dram_para_=
t *para,
> >  			switch (fuse) {
> >  			case 8: cfg =3D ac_remapping_tables[2]; break;
> >  			case 9: cfg =3D ac_remapping_tables[3]; break;
> > -			case 10: cfg =3D ac_remapping_tables[5]; break;
> > +			case 10:
> > +				if (sid_read_soc_chipid() =3D=3D SUNXI_CHIPID_T113M4020DC0)
> > +					cfg =3D ac_remapping_tables[0];
> > +				else
> > +					cfg =3D ac_remapping_tables[5];
> > +				break;

This is similar thing to what has been done in H616 DRAM driver, so FWIW:

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> >  			case 11: cfg =3D ac_remapping_tables[4]; break;
> >  			default:
> >  			case 12: cfg =3D ac_remapping_tables[1]; break;
> > diff --git a/drivers/ram/sunxi/dram_sun20i_d1.h b/drivers/ram/sunxi/dra=
m_sun20i_d1.h
> > index 91383f6cf10..7bd8f67a77a 100644
> > --- a/drivers/ram/sunxi/dram_sun20i_d1.h
> > +++ b/drivers/ram/sunxi/dram_sun20i_d1.h
> > @@ -19,6 +19,13 @@ enum sunxi_dram_type {
> >  	SUNXI_DRAM_TYPE_LPDDR3 =3D 7,
> >  };
> > =20
> > +enum sunxi_soc_chipid {
> > +	SUNXI_CHIPID_F133A =3D 0x5C00,
> > +	SUNXI_CHIPID_D1S =3D 0x5E00,
> > +	SUNXI_CHIPID_T113S3 =3D 0x6000,
> > +	SUNXI_CHIPID_T113M4020DC0 =3D 0x7200,
> > +};
> > +
> >  /*
> >   * This structure contains a mixture of fixed configuration settings,
> >   * variables that are used at runtime to communicate settings between
>=20
>=20
>=20




