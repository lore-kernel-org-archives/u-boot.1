Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E597BD2F7E5
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 03:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5197788E5C;
	Thu, 17 Oct 2024 05:45:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sX1sBlNk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45B7388E14; Thu, 17 Oct 2024 05:45:18 +0200 (CEST)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE1688E78
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 05:45:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6cbd12b38b4so3742376d6.2
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 20:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729136712; x=1729741512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KfxnRqlPBXogdr+dgqhYzopCD8yfM9F6y9iTjo6/8do=;
 b=sX1sBlNkD3Jd96buKVKl0ev6WIhXI6iEUgVn7Acmmv2mN/aKTzY4WZ41ai26WXt3Yn
 G4G1liZ9nXVmjNbd5j/wfIMhzt3oz0hK7XIt6aR8J2qFGjgVr68RUWAS1+DBmR2qURHo
 TluNEY0SPhUCWNzd9XkQhrOBcm1Kv+RCq1r+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729136712; x=1729741512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KfxnRqlPBXogdr+dgqhYzopCD8yfM9F6y9iTjo6/8do=;
 b=qNxGueiyThjQaAn9EerEjWsqqDtBmt8Us0DfeAyn+D7UaA8uHBDu9X+mltowoEAH8b
 Ge3+tLrGI34hYvG6+4RafhI7eEByxXK5t5E/BGkNxFx/Wz59vy6RU/wJScF+9hCxRhtO
 wMsiS/MQed/ckdKDtvs0H1D5fvWHgTNYg86BKHa0pkHYUtHE/64SfOg2Zc831pC1O9hM
 p0C8zt8M4fP6RRBV1CmVWaeSz2mcqlN6WPLkT4qQ+yIwQ0PfIAJi6iv1R5ixYlXlM7tb
 fIAteTJ4vazrfyO2NsAKqrMQZWQ33lVnbljvwLfYy39i1HIRMJ8wwE4R40ZO5IdkAjHh
 k8WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+6/fDuCxL7zsglhT5gHPMY3R0P4o3I+tnT/byGUk6zf38fASlMnBlqw2tJ3j2CGSWb5chbcw=@lists.denx.de
X-Gm-Message-State: AOJu0Yzr1tDOIxS1WFShtB3dQfYQeFEn2jDjVZlgg7xARuonU61XE5zy
 bvZt343WW4yG0IbtplCaQY6amPqMRTtzXFNjT9SPpyAwJRx7ZBV1J4HELYRIuW8=
X-Google-Smtp-Source: AGHT+IF/9ySJ6/g/KRTkA0DMh2crxn6uOTW/c+RmvbcM2r7dknTH0Ddzv6xfMrtswSJz7acA1SFeGw==
X-Received: by 2002:a05:6214:3b84:b0:6cb:c54c:b782 with SMTP id
 6a1803df08f44-6cc2b91a5d2mr77298056d6.32.1729136711910; 
 Wed, 16 Oct 2024 20:45:11 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2299043dsm24332036d6.136.2024.10.16.20.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 20:45:10 -0700 (PDT)
Date: Wed, 16 Oct 2024 21:45:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "sbabic@denx.de" <sbabic@denx.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 dl-uboot-imx <uboot-imx@nxp.com>, Gilles Talis <gilles.talis@nxp.com>
Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device tree
Message-ID: <20241017034507.GJ4959@bill-the-cat>
References: <20241011105827.7729-1-peng.fan@oss.nxp.com>
 <20241017031106.GA55137@bill-the-cat>
 <PAXPR04MB845984549FD1762C0A3AC90888472@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0+R8s9qIqIPt9KbP"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB845984549FD1762C0A3AC90888472@PAXPR04MB8459.eurprd04.prod.outlook.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--0+R8s9qIqIPt9KbP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 03:14:46AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] cpu: imx8_cpu: Avoid revision to corrupt device
> > tree
> >=20
> > On Fri, Oct 11, 2024 at 06:58:27PM +0800, Peng Fan (OSS) wrote:
> >=20
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > U-Boot device tree is padded just after U-Boot proper. After the
> > whole
> > > stuff loaded to DRAM space, the device tree area is conflict with BSS
> > > region before U-Boot relocation. So any write to BSS area before
> > > reloc_fdt will corrupt the device tree. Without the fix, there is
> > > issue that =E2=80=9Cbinman_init failed:-2=E2=80=9D on i.MX8MP-EVK boa=
rd.
> > >
> > > Move the variable to data section to fix the issue
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/cpu/imx8_cpu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c index
> > > 6c0a8c0cbe4..19c65c7ce47 100644
> > > --- a/drivers/cpu/imx8_cpu.c
> > > +++ b/drivers/cpu/imx8_cpu.c
> > > @@ -71,7 +71,7 @@ static const char *get_imx_type_str(u32
> > imxtype)
> > >
> > >  static const char *get_imx_rev_str(u32 rev)  {
> > > -	static char revision[4];
> > > +	static char revision[4] __section(".data");
> >=20
> > After my last mail, I pulled up the patch itself and started looking at=
 the
> > driver. Why is "revision" being done like this? This is not a good
> > common practice.
>=20
> Since the function returns a pointer to a string, so ...
> We could move it to malloc area.

Yes, something like that sounds better, thanks.

--=20
Tom

--0+R8s9qIqIPt9KbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcQiD8ACgkQFHw5/5Y0
tyx2sgwAirCjFKDm2uUG1+jgRPWckqcv69uFkhxSP/+Rb6DOTTjmmJRmUXqHfisZ
PdCPzg8XZAx0dk1eN/lAJ+sq2aUrajEdj5IaWdRVu+U0MC+ZB3jjmWYNbH9kMkFq
WiIjuvwiBfgLasEQWWx1e/vZ/X40v0LYtfL8c4/caLJ/v6+cyBQrI2dwqAM9Dl1S
qnCW2TiJyXl1EcG6ZSYfqW4G8xPUznntFW36xEVFmJjRMFwZN2IQhDRP5PI8ZJy0
jgsAzSbkfjJd2/wUJM9C/cl37wbyqQ+lRsrGLuoSRMzF10iyJ+Nf5a7pAXV/wixL
KEy7gcQoJLkH8UrB4WcMK7OClnZivPqOLS/HILXALa4d9k/j1P3CUPtjS5BzkZ2l
YBR3UPTstxPZCpXFcvKa+OsaIMSd6giOBhHKgbYrfmOBg9RhO+uEXwKSdgtowF3u
S3V5idKG2pzIhjEF1e/p4HtuaCHVHBTclGs9nPheDimAAzMA2+4sFxU8A6y08Cz3
ShopZ6jh
=4V5n
-----END PGP SIGNATURE-----

--0+R8s9qIqIPt9KbP--
