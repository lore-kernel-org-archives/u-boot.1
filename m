Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F50FC25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 16:15:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BABF88373;
	Thu, 16 May 2024 18:15:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sRkPSrAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3909D88375; Thu, 16 May 2024 18:15:26 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABF4C8837B
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 18:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-620314aa1d7so89548717b3.2
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 09:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715876122; x=1716480922; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tukWq5XCwxc5BDRr4Zdd+055GbTaB61b6M9IAH1nbt0=;
 b=sRkPSrAVsv7q2ymB0Tp/DR2vUA+mnlOva5VDdUvbtLBZ7tdr8qrLN4QuZnUqPzJb11
 /TmmLyCJmVwvI31ZWte9/RsEXQ9sZ0OgOTtCrz4VQh8zKejj8MfsKQQUEpiCnCIpyTXe
 UQDm+yN6osJJFi4NNMJsEimw+fhAYqvy6HTl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715876122; x=1716480922;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tukWq5XCwxc5BDRr4Zdd+055GbTaB61b6M9IAH1nbt0=;
 b=aGJ3G23ydW6IotZDCSv2FT+itJFN28xm0/Z3EzjIQa8eNiomvsrh7ihBn5WACrENIx
 NlX/wLk602/JC1L3HaLHuWfHzPuRrc8MwTG1/l4OpOL8OaogcfYfALL023BhZvTEl6Bf
 3kMEUCubLJiiBMSbrSZafXH3mJHZWEAU1D3CPSdgqrz/K7HtPW2eC/hNAR0aeA2jF8z7
 l7xsfMGIaKGmSmqQdGbnD77soU9yeDGwmG+U2qYe8MixWYEXUkhRkZQwJ/QTOw893rY4
 gAUtlVpZ/Ydq1VSDETAXjHj7ybmJTtbGU0GYoAdHJ9ubKfrKY7PA+y3ARdNLbc7LSeKT
 +qiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqSZozc/MRaKF94eRHr3wPHLH3nGoxUje0v06fqg1HxAVan6LzvO0b1P5bS6k0iQb4d85NNP07gP3K2k0ZL8D/FWKU7A==
X-Gm-Message-State: AOJu0YyzxXGF05nf+1Ba0CvFWyFbHxBJ2WlZASyKuylyymxCdl5f5+Rr
 X+onVTXVGM8lUUVJl5e2kV7FDVKKNGGNibxc5beEkKgA//Tll52DPiwVa5V+3Vk=
X-Google-Smtp-Source: AGHT+IHJyEtrfPPMq1/dRd/Ew04/662SibI/C8mjIAbHSYywlXqDtiPr+9Caro/G27/nUDPJYImmrg==
X-Received: by 2002:a05:690c:f83:b0:61a:d2d9:5488 with SMTP id
 00721157ae682-622aff920e2mr244443597b3.7.1715876122400; 
 Thu, 16 May 2024 09:15:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf2fc789sm812464285a.93.2024.05.16.09.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 09:15:22 -0700 (PDT)
Date: Thu, 16 May 2024 10:15:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de,
 Nitin Yadav <n-yadav@ti.com>, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 2/2] configs: add defconfigs for the am625-lp-sk
Message-ID: <20240516161519.GC2568172@bill-the-cat>
References: <20240429-am62q-wip-v3-0-17dcfdb1075a@ti.com>
 <20240429-am62q-wip-v3-2-17dcfdb1075a@ti.com>
 <20240515182123.GY2568172@bill-the-cat>
 <098126c3-ac13-46b1-8983-dc6bfcd284f6@ti.com>
 <20240516154158.3vg7qdjmfnddrraa@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="61tHpyyOAtOpAZ/B"
Content-Disposition: inline
In-Reply-To: <20240516154158.3vg7qdjmfnddrraa@bryanbrattlof.com>
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


--61tHpyyOAtOpAZ/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 10:41:58AM -0500, Bryan Brattlof wrote:
> On May 15, 2024 thus sayeth Andrew Davis:
> > On 5/15/24 1:21 PM, Tom Rini wrote:
> > > On Fri, May 03, 2024 at 11:44:29AM -0500, Bryan Brattlof wrote:
> > >=20
> > > > The am62x-lp-sk is a package and reference board spin of the am62x-=
sk to
> > > > showcase the low-power features of the am62x SoC family. Because it=
 so
> > > > closely resembles the am62x-sk board, use the preprocessor to inher=
it
> > > > its configuration making the needed changes for this board where
> > > > necessary.
> > > >=20
> > > > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > > > ---
> > > >   configs/am62x_lp_sk_a53_defconfig | 3 +++
> > > >   configs/am62x_lp_sk_r5_defconfig  | 2 ++
> > > >   2 files changed, 5 insertions(+)
> > > >=20
> > > > diff --git a/configs/am62x_lp_sk_a53_defconfig b/configs/am62x_lp_s=
k_a53_defconfig
> > > > new file mode 100644
> > > > index 0000000000000..904b2142b2f53
> > > > --- /dev/null
> > > > +++ b/configs/am62x_lp_sk_a53_defconfig
> > > > @@ -0,0 +1,3 @@
> > > > +#include <configs/am62x_evm_a53_defconfig>
> > > > +CONFIG_DEFAULT_DEVICE_TREE=3D"ti/k3-am62-lp-sk"
> > > > +CONFIG_OF_UPSTREAM=3Dy
> > >=20
> > > So, there's a problem here. The #include trick for defconfig files is=
n't
> > > working as intended, exactly. The example here doesn't work right.
> > > First, it shows up as a variant of "sandbox" (as buildman will show a=
nd
> > > leads to https://source.denx.de/u-boot/u-boot/-/jobs/835067#L119)
> > >=20
> > > And this becomes clearer if you look at configs/am69_sk_r5_defconfig
> > > which has to set some symbols already found in
> > > configs/j784s4_evm_r5_defconfig in order to work. This is seemingly v=
ery
> > > not equivalent to invoking "make foo_defconfig bar.config" to combine
> > > things.
> > >=20
> >=20
> > This is equivalent when running make. The issue is with buildman which
> > manually checks the content of the defconfig to find what ARCH it should
> > run the defconfig with. buildman doesn't understand the #include yet.
> > Until buildman can be fixed, you'll need to do what we did with
> > am69_sk_r5_defconfig and redefine the ARCH/SOC/TARGET info in the
> > defconfig file so buildman can find it without following the #include.
>=20
> Ah Okay, I'll take a stab at the buildman fix. Also noticed in the logs=
=20
> I didn't add the configs to a MAINTAINERS entry.

Thanks. And re MAINTAINERS, I just fixed that up in-place before seeing
this bigger problem.

--=20
Tom

--61tHpyyOAtOpAZ/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZGMRcACgkQFHw5/5Y0
tyw4bAwAqRKEkDeEXI0Vfh+pmqq2zBm3byNcWRoxDr3jDPgnwlysR33IexSxk7f/
CyIXdQNnvAudpIWqGOPxIZLIKTofkm6vA0d5uB+uuNJX4WGzCwK4K++AQ/h3IeDV
TVJtnlx41N9S3CBJVvDOoWQjAlq9ROLHDAXRVOkIgdg0ZM6Ikc3Oyb7nkZwI2eGl
/3wYb8n2AGihW+x0offI2KkDjv6MMdTkV6vjnt55SO0Ql1w343ODbSNVc6VnZYt/
l/d3CENDuOI2nVd00NFqlJPhV50BAhLOvivevYrIplRrEKYumRru0n+fe/P20xmF
zZrL4M+RQ9HJPQOUwGyemMLSKzAQWVMy8jjKflxW3DWw9MqZDfLdvsnlMhBb/bRT
G3hsqmIl7/+lxpLCEThK8umG5WCbV49NHBpqkL+lGwBGkOATmA2nPF/4zXb2gYQG
HDkZR667UoaxAeir7o4OxwvQIczUdKNyUPC3HIs094xqZ6fkGc/czx8eV4efeK0B
w64KK/g3
=A1X5
-----END PGP SIGNATURE-----

--61tHpyyOAtOpAZ/B--
