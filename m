Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11EDC87FD3
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 15:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40BC9842F7;
	Wed,  6 Aug 2025 17:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QL9yJtPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D413784355; Wed,  6 Aug 2025 17:49:21 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A0C1842EE
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 17:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-741a254d4a0so1127779a34.1
 for <u-boot@lists.denx.de>; Wed, 06 Aug 2025 08:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754495358; x=1755100158; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UkA5W+gU4F1weQUTrWH3vqQto1gZzdM9W0I5MwKV6mk=;
 b=QL9yJtPRa2sZiNwCjU59pnYcy9ujgFqrRX+UMPp/w62ZJsoTduZ0WAHilHkiTyzhfa
 +akE2PAyDuhomupSR31HicIM7ZvgW/AL4JVvKVJo5g6uSpOi7CT7sh57fm8z7QNWqVyv
 S2/vXEA9ZML0cuWmd8exjv1Nllvyk2tU6br2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754495358; x=1755100158;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkA5W+gU4F1weQUTrWH3vqQto1gZzdM9W0I5MwKV6mk=;
 b=kEgTCu23eGled+mEXWmbERlx0VczOIykaTsz5uO1yi7XXPWJsbHCJKPCZi2lLS3dk9
 Q1xjtcCkw/bXxmM8PyJhyoEgRDKogOFCOWZ0va9xazZpe26A5wrG5TE/T9KzX2oQqPzJ
 TBQCWSdQ5AUqvtv6hFMw1Tv7XzKh372wMIm020K+tv9RyjkWNd2Jr4bAlbr3UVENe1B8
 pTXZ3QkYS5lvEJ0Op51ahrsrYSq7mZyemoEVliA5PiKVhf6AADLcdq0CgSLJxL2dfxB/
 bfmN4FRIpGhLzOWX0s1+HDumW4xoXz/zUu0kBjofsRRwn1+gPYaXrRC2v+KuxOBIz0zX
 x4LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBaUYHyieWd3GS5Qq5mTLABGdZYUu6oKn9EIQvdZPzMDcBV0nZx++TnBv8iYGBjxDY+W40zmk=@lists.denx.de
X-Gm-Message-State: AOJu0YzfNGRWZOH1mCcgJ3SAyJRp7LiSPyh26kwNC5WqKgACsa38VmDK
 SEBNLJASQN5yO2zPjVW8LXrm2u167lfggIf4ZH6m7589oND5uaXr1AE9B6AmUWzCTrA=
X-Gm-Gg: ASbGnctUqDOrRJrdpa31ZZq6iBxBEyKZ/nhxx+hN74FNAFlW68xkX+op/GKeTCVhUD6
 bxQMqoqWg0YlSNCkNo1sZ4UMFvY4FXUNpV14FqZifKg0RNyHrDj1Dy8eUCt3eWnmGj4sYa8nQhg
 K4A3tYwRwWYeDdInI1KvL4qBkPwKiLsKn3H7M7m9vH40cEp4YRJfIvfd8jfilgGkgCGd7ACzmud
 Ehu2X5cn2fGJmjYE+52eE/o0EarUDxF5c6J3JQiJAQMr7ceikp/lMVAAA1765Z6+VSwiytAfN3g
 9Nh6cUUI00DqlY9uCIFIoZz2lJuvmLpnAcwmKLT/EbzB31KlfvbX8GsO/YtGHwPf0PWNTZqQx1h
 Ep7d8Igq7Tm/PxssSPdORekA9EmjFefzzIXiRTwUu87/3LbLSvjXRN7WiJxfpwYJQkBg=
X-Google-Smtp-Source: AGHT+IHzXp0TFreT2LEQ3K1kQutTC92Evi+71voWeGpIVLxw1tXlbXV4/kDUegFAAVdEFH1xCm6LVQ==
X-Received: by 2002:a05:6808:1924:b0:434:13f6:d386 with SMTP id
 5614622812f47-43587d6c32fmr24182b6e.16.1754495358246; 
 Wed, 06 Aug 2025 08:49:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-434131af52dsm1103454b6e.18.2025.08.06.08.49.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 08:49:17 -0700 (PDT)
Date: Wed, 6 Aug 2025 09:49:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/2] soc: soc_ti_k3: Add support for AM62P variants
Message-ID: <20250806154915.GP124814@bill-the-cat>
References: <20250805161419.1781935-1-jm@ti.com>
 <20250805161419.1781935-2-jm@ti.com>
 <20250805223947.GL124814@bill-the-cat>
 <bd800d84-9a3e-45bd-ab5f-788110181dc6@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sS6vPoWgOjpLMBx9"
Content-Disposition: inline
In-Reply-To: <bd800d84-9a3e-45bd-ab5f-788110181dc6@ti.com>
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


--sS6vPoWgOjpLMBx9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2025 at 10:45:29AM -0500, Judith Mendez wrote:
> Hi Tom,
>=20
> On 8/5/25 5:39 PM, Tom Rini wrote:
> > On Tue, Aug 05, 2025 at 11:14:18AM -0500, Judith Mendez wrote:
> > > This adds a support for detecting AM62P SR1.0, SR1.1, SR1.2.
> > >=20
> > > On AM62P, silicon revision is discovered with GP_SW1 register instead
> > > of JTAGID register, so introduce GP_SW register range to determine SoC
> > > revision for AM62P.
> > >=20
> > > Signed-off-by: Judith Mendez <jm@ti.com>
> > > ---
> > >   drivers/soc/soc_ti_k3.c | 70 ++++++++++++++++++++++++++++++++++++++=
---
> > >   1 file changed, 65 insertions(+), 5 deletions(-)
> > [snip]
> > > @@ -130,17 +184,23 @@ static const struct soc_ops soc_ti_k3_ops =3D {
> > >   int soc_ti_k3_probe(struct udevice *dev)
> > >   {
> > >   	struct soc_ti_k3_plat *plat =3D dev_get_plat(dev);
> > > -	u32 idreg;
> > > +	u32 gp_sw1_val =3D 0;
> > >   	void *idreg_addr;
> > > +	u32 idreg;
> > > -	idreg_addr =3D dev_read_addr_ptr(dev);
> > > +	idreg_addr =3D dev_read_addr_index_ptr(dev, 0);
> > >   	if (!idreg_addr)
> > >   		return -EINVAL;
> > >   	idreg =3D readl(idreg_addr);
> > > +#if IS_ENABLED(CONFIG_SOC_K3_AM62P5)
> > > +	if (soc_ti_k3_variant_in_gp_sw(idreg))
> > > +		gp_sw1_val =3D soc_ti_k3_get_variant_alternate(dev, idreg);
> > > +#endif /* CONFIG_SOC_K3_AM62P5 */
> >=20
> > This isn't quite what I meant, as it will generate warnings about unused
> > variables for the tables, on other platforms, yes? What I was thinking
> > was:
> > if (IS_ENABLED(CONFIG_SOC_K3_AM62P5) && soc_ti_k3_variant_in_gp_sw(idre=
g))
> > 	gp_sw1_val =3D soc_ti_k3_get_variant_alternate(dev, idreg);
> > which shouldn't. And then can we check the other platforms similarly to
> > save space or no? Or am I unclear with what I'm thinking (or it's not
> > possible, I didn't dig at the rest of the code much)? Thanks.
> >=20
>=20
> It is not very clear, but let me clarify:soc_ti_k3_get_variant_alternate
> should only get called for AM62P and get_rev_string should get called
> for all SoCs.
>=20
> So it only makes sense to do this then:
>=20
> if (IS_ENABLED(CONFIG_SOC_K3_AM62P5) && soc_ti_k3_variant_in_gp_sw(idreg))
> 	gp_sw1_val =3D soc_ti_k3_get_variant_alternate(dev, idreg);
>=20
> plat->revision =3D get_rev_string(idreg, gp_sw1_val);

Right, then the linker should normally be able to discard all of the
am62p5 stuff on non-am62p5 platforms. Looking at the driver more now,
OK, there's not anything we can save on the other cases that I was
thinking about.

--=20
Tom

--sS6vPoWgOjpLMBx9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJN5eAAKCRAr4qD1Cr/k
Cs0VAQCkh6F6hZyjotug9pSpFIjYJhJE0xNZUyOSWaGGLizLpgD/RueVWEQtZyWv
afzD3RN3OhTJyp+FdJceLjtghrt29AM=
=8UWR
-----END PGP SIGNATURE-----

--sS6vPoWgOjpLMBx9--
