Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D100E7108F
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 15:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FB9C86466;
	Thu, 21 Sep 2023 17:43:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GbWBj7v9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27A42864AA; Thu, 21 Sep 2023 17:43:19 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10B0A8642C
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 17:43:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-59e7fb87f1cso14162117b3.2
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695310996; x=1695915796; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QpzON6IagT1zSY96gsHe2l8FYeET4UgspmiPTs/L51M=;
 b=GbWBj7v9kUhkGCOVx/oxo1mPwIrt684T9H/kEjME7zMqoVCfCPqwV3LjjU5tp5GHM5
 HINygqrIp6dEU5Ent1wP71QI/N3d8DIKKiJYliX1X8AqhyX0/Zcximkyo8Nn4htouwaR
 KwJHu3NlFeDvtCUEcm+fEFe12J9zcHDygLSUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695310996; x=1695915796;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpzON6IagT1zSY96gsHe2l8FYeET4UgspmiPTs/L51M=;
 b=AY9tYXT8nsd1R7NN5rA6uK1tnaG+UPBbkuuYC+hvHzyyahGArmcF/uY0Xp/Phntozz
 CIkyVh2idDWMAVHYOZIZ4qTze6nC1XkzmQKjFYvAqRdEeJ5OY40koZNhwhN//1GeeI3N
 s8LKufP7KK5kMEbDT1umD0BoeK681hO8Xr8idoaM1YVWd/+ggx8Eap5omSMa5ADuGF91
 Qd3gI73VjHe9Ok4fHiF77ditefDeh4OOzQLTm+PbJmqUsuX9us7EtZm8VWrEIA3SyDgv
 ER8J5viPY2CB7GABJezkjfkmQl+JVwKVdjSiJghp2NlGfCTZ+j2fr3mQpwvWHWpZOmFA
 +Y2Q==
X-Gm-Message-State: AOJu0YyxQrmtzOl/g0/Iy9lyPC3X+0Jz22Ost8HDCFxvAJDsmAl/DUbG
 /ZavbXI0L9gA6VCD2hTSpIPYBg==
X-Google-Smtp-Source: AGHT+IGzd9bLlE9PYLBCZhv7EOSLvCWBPIuvwFQ8U/dAuY6hG3lwKU9RtmdHEHIEM/YILLz1Q5OVIg==
X-Received: by 2002:a81:9445:0:b0:586:a684:e7ba with SMTP id
 l66-20020a819445000000b00586a684e7bamr5518787ywg.39.1695310995783; 
 Thu, 21 Sep 2023 08:43:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-46ac-83a0-07b5-e9a6.res6.spectrum.com.
 [2603:6081:7b00:6400:46ac:83a0:7b5:e9a6])
 by smtp.gmail.com with ESMTPSA id
 v134-20020a81488c000000b00570253fc3e5sm380175ywa.105.2023.09.21.08.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 08:43:15 -0700 (PDT)
Date: Thu, 21 Sep 2023 11:43:13 -0400
From: Tom Rini <trini@konsulko.com>
To: mchitale@ventanamicro.com
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v1 2/2] spl: Add support for booting from ESP
Message-ID: <20230921154313.GT305624@bill-the-cat>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
 <20230914100821.755904-3-mchitale@ventanamicro.com>
 <20230914162924.GA305624@bill-the-cat>
 <06ea71aab661cf0535bcef98dad2aba61d1884f1.camel@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q/G/qFSC2U3qXEbD"
Content-Disposition: inline
In-Reply-To: <06ea71aab661cf0535bcef98dad2aba61d1884f1.camel@ventanamicro.com>
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


--q/G/qFSC2U3qXEbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 05:03:37PM +0530, mchitale@ventanamicro.com wrote:
> On Thu, 2023-09-14 at 12:29 -0400, Tom Rini wrote:
> > On Thu, Sep 14, 2023 at 03:38:21PM +0530, Mayuresh Chitale wrote:
> >=20
> > > Some platforms as described by EBBR specification may store images
> > > in
> > > the FIRMWARE directory of the UEFI system partition(ESP). Add
> > > support
> > > to boot from the EFI system partition if it is enabled for a
> > > platform.
> > >=20
> > > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > [snip]
> > > +config SPL_ESP_BOOT
> > > +	bool "Load next stage boot image from the UEFI system
> > > partition"
> > > +	select SPL_PARTITION_TYPE_GUID
> > > +	help
> > > +	  When enabled, first try to boot from the UEFI system
> > > partition as
> > > +	  described in the Ch.4 of the EBBR specification.
> >=20
> > We need to select this by perhaps BOOT_DEFAULTS or BOOTMETH_DISTRO,
> > whatever is supposed to signify that yes, this is going to be a
> > SystemReady IR (or higher) compliant build.
> I am not sure about the SystemReady compliance but I think the config
> option can be enabled for those platforms which require it.

It's "nearly everyone" that needs the option, which is why I'm saying it
needs to be part of the high level options that a board selects to say
they want to be compliant.

> > [snip]
> > >  int spl_blk_load_image(struct spl_image_info *spl_image,
> > >  		       struct spl_boot_device *bootdev,
> > >  		       enum uclass_id uclass_id, int devnum, int
> > > partnum)
> > >  {
> > >  	const char *filename =3D CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
> > > -	struct legacy_img_hdr *header;
> > [snip]
> > > @@ -63,24 +88,26 @@ int spl_blk_load_image(struct spl_image_info
> > > *spl_image,
> > >  	}
> > > =20
> > >  	blk_show_device(uclass_id, devnum);
> > > -	header =3D spl_get_load_buffer(-sizeof(*header),
> > > sizeof(*header));
> > > -
> > [snip]
> >=20
> > Is this an artifact of Sean's patch series where "header" is no
> > longer
> > actually used?  As-is this won't compile on top of next (which is
> > where
> > given Sean's feedback, the series needs to be rebased upon anyhow).
> Yes, I will rebase on the latest next without Sean's series and resend
> the patch.

OK.

> > > +	/*
> > > +	 * First try to boot from EFI System partition. In case of
> > > failure,
> > > +	 * fall back to the configured partition.
> > > +	 */
> >=20
> > I don't know that this is the right behavior.  If we're configured to
> > boot from partition X, we boot from partition X.  If we're configured
> > to
> > find the ESP and use that, we find and use that.
>=20
> This is to maintain compatibility and make more attempts to boot. So
> the same SPL binary can load images from devices with or without the
> ESP.

Yes, I don't think that's what we want.  It should be an either/or not a
a then b.

--=20
Tom

--q/G/qFSC2U3qXEbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUMZJEACgkQFHw5/5Y0
tyyQqgv/cgelHy6HKhV6YbJJRqmq1uYqWvYKCS3vG7xCWZfxqgElqYdnC+VqXiUX
LEO8IeXak+ofFscB10bpfwTm47ABgeoqUCNqk3mkS/1J4mCpA74ssYU1wc3gRnqL
wkTzNrR2XH6FZBvPiXjk7xHp6zsVo6K85CHGWUNl6BFakq5jXPdIwRfpNfCTonGB
w0DLLUTEF7f+PC8S1IuwmzD+RukwTVXfi+U2MjGU4Aq9s62z+3Unh1HBIFQjsd75
0KSbPi++4Q8FiPMbAc+uqTSQYQWit4aV9GmVelIr/vXJ+ejYOTaw9soKeEOLalUc
kB2qRZwHsXQMnEtb56nwbJhBdL59noh55kOEuaCADOZxLghhHucehIebHQBYV8eD
qsEs4VSJv9tQ54eWMyZZonsobgBOugQcwhgVmsY8EmT8BDMQ5b6XvOxR7+pLpATa
y+qLrx/XrNyv5l5PErgDxmoZEuuJn8BunTlmphkBIZ11sXUC3tfEbJ8B3B5jkcaV
ODDb2HGI
=R2wU
-----END PGP SIGNATURE-----

--q/G/qFSC2U3qXEbD--
