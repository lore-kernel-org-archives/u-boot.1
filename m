Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D593AC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 13:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5758B8657F;
	Thu, 31 Aug 2023 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U51IhChV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24F198657F; Thu, 31 Aug 2023 15:31:09 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4315481FA8
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 15:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3a850f07fadso463306b6e.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 06:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693488665; x=1694093465; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KKyo1zGnkcJAuP9EE8VB7Iuiam5gjTj4iBhNO8YptIg=;
 b=U51IhChVA1cjmFYJ/JbLc4wAvbU7pYY51qbJPezbf40jBr3rbRDqbrTOuJMeZ6ZI7T
 +Mce7akThZ0AzRZUfPNa3XYYwXONQjGWvOS4UcslHZwfuE6HD7Rd0stXGsHcXkbSEaWC
 stJi8l/kPEC+wHgDP+iP7MXLc1FKnwaGntK0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693488665; x=1694093465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKyo1zGnkcJAuP9EE8VB7Iuiam5gjTj4iBhNO8YptIg=;
 b=Uf5L08j+jffKJO/wGDRmLAdILLTvEre+Fnf01DyTWom7XPYFemAVaPHzdy5v8IheBg
 Q7pv6tnCzkv51bDMNIOOQZ7SD1TWGNGXEAyj67aKbfP0vf+GSIMqso6BHc9Kn0PO1LW9
 YSPRwXl+DPAFrWSjehc28wiuL43ucZ6Ae6z0+XI2Z2PEfH4OAbtCtNG/zlK34RQ9i+D+
 mG7f2g0fBmHZ/LwsYHEFtZjEAW7OmR2s9kJoapaH1Se3UA7OWaLyfdlQnQmLNE5e6ILt
 Fr6CFd9Z4NMKv8aUXY2PWn0qU/5f2onrtzZg9rqyTMxnp2d/ArgmncutAnGdorlpWd1v
 6q3Q==
X-Gm-Message-State: AOJu0Yx29xx3zHRf03WZGYFodTEh2B6ed9cEV6i7dYfqU/b4HGXz2X+Q
 zhv6iu8mASODwRXpvko+XuGTdA==
X-Google-Smtp-Source: AGHT+IEAlXtPT3ZPV1CpMlD3abMDOcu3/vn7HQpV9l7AAT8INwGFM2qKLvZsAfCCE7CMufKz6Gkkpw==
X-Received: by 2002:a05:6358:4404:b0:134:c650:cc0a with SMTP id
 z4-20020a056358440400b00134c650cc0amr5312227rwc.15.1693488664832; 
 Thu, 31 Aug 2023 06:31:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a25fc0d000000b00d6861b49f01sm307527ybd.65.2023.08.31.06.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:31:04 -0700 (PDT)
Date: Thu, 31 Aug 2023 09:31:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, bhupesh.linux@gmail.com,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 2/2] armv8: Disable SYS_DCACHE_OFF & SYS_ICACHE_OFF
 for ARM64
Message-ID: <20230831133102.GO3101304@bill-the-cat>
References: <20230822075112.717992-1-bhupesh.sharma@linaro.org>
 <20230822075112.717992-3-bhupesh.sharma@linaro.org>
 <20230830185205.GA1149416@bill-the-cat>
 <0de1f4aa-a8be-805e-8260-6178b1368ab4@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qdybElYzg1SuzlZ9"
Content-Disposition: inline
In-Reply-To: <0de1f4aa-a8be-805e-8260-6178b1368ab4@amd.com>
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


--qdybElYzg1SuzlZ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 10:24:07AM +0200, Michal Simek wrote:
>=20
>=20
> On 8/30/23 20:52, Tom Rini wrote:
> > On Tue, Aug 22, 2023 at 01:21:12PM +0530, Bhupesh Sharma wrote:
> >=20
> > > Ideally SYS_ICACHE_OFF and SYS_DCACHE_OFF should never be set for
> > > ARM64 (ARMv8) platforms, as it makes booting u-boot slower on these
> > > platforms.
> > >=20
> > > However, if some platforms require ICACHE or DCACHE  to be disabled
> > > only for the smaller SPL stage, we should support such configurations
> > > in u-boot as well.
>=20
> I am missing the reason why this change should be accepted.
>=20
> > >=20
> > > Compile-tested for:
> > > - qemu arm64
>=20
> qemu doesn't model caches that's why I don't think it is relevant here.
>=20
> > > - imx8
> > > - stm32
> > >=20
> > > and run-tested on:
> > > - Qualcomm RB3 platform
> > >=20
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Simon Glass <sjg@chromium.org>
> > > Cc: Peng Fan <peng.fan@nxp.com>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > Reviewed-by: Tom Rini <trini@konsulko.com>
> > > ---
> > >   arch/arm/Kconfig            | 2 ++
> > >   arch/arm/cpu/armv8/Makefile | 4 ++--
> > >   2 files changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 36ee1e9a3c..92bff715e3 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -141,6 +141,7 @@ config THUMB2_KERNEL
> > >   config SYS_ICACHE_OFF
> > >   	bool "Do not enable icache"
> > > +	depends on !ARM64
> > >   	help
> > >   	  Do not enable instruction cache in U-Boot.
> > > @@ -153,6 +154,7 @@ config SPL_SYS_ICACHE_OFF
> > >   config SYS_DCACHE_OFF
> > >   	bool "Do not enable dcache"
> > > +	depends on !ARM64
> > >   	help
> > >   	  Do not enable data cache in U-Boot.
> > > diff --git a/arch/arm/cpu/armv8/Makefile b/arch/arm/cpu/armv8/Makefile
> > > index bba4f570db..0d0c1728e4 100644
> > > --- a/arch/arm/cpu/armv8/Makefile
> > > +++ b/arch/arm/cpu/armv8/Makefile
> > > @@ -5,13 +5,13 @@
> > >   extra-y	:=3D start.o
> > > +obj-y	+=3D cache_v8.o
> > >   obj-y	+=3D cpu.o
> > >   ifndef CONFIG_$(SPL_TPL_)TIMER
> > >   obj-$(CONFIG_SYS_ARCH_TIMER) +=3D generic_timer.o
> > >   endif
> > >   ifndef CONFIG_$(SPL_)SYS_DCACHE_OFF
> > > -obj-y	+=3D cache_v8.o
> > > -obj-y	+=3D cache.o
> > > +obj-y  +=3D cache.o
> > >   endif
> > >   ifdef CONFIG_SPL_BUILD
> > >   obj-$(CONFIG_ARMV8_SPL_EXCEPTION_VECTORS) +=3D exceptions.o
> >=20
> > I'm adding Michal here because this changes the behavior on xilinx
> > platforms that had the icache off.  I was under the impression that at
> > the levels U-Boot runs at on aarch64, we just couldn't have
> > icache/dcache off, but I guess that's wrong?
> >=20
>=20
> yes. We are using icache off for mini u-boot configurations for quite a l=
ong
> time. I tried to find out any commit why we started to use it but didn't
> find any record. But will ask team to retest that use cases to see if that
> is working or not.
> In our case we are using small full U-Boot not any SPL variant.
>=20
> My biggest issue with the patch is that it is not clear what issue it is
> trying to solve as I have mentioned above.
> It just says that ideally icache/dcache should be on. If you want to enfo=
rce
> it on your platform you can select it when that platform is selected and
> don't need enforce it for other platforms.

Thanks Michal. Bhupesh, I was wrong in v1, having caches off is allowed,
so you just need to fix issues like part one does where code doesn't
compile when the options are disabled, and then are there further
changes needed for your usecase?

--=20
Tom

--qdybElYzg1SuzlZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTwlhYACgkQFHw5/5Y0
tyz2Cgv+IHErhjkcN+opgclR/E9f47bjGDahgMTllTB/7UvEHowe4iFuh9/8Rp1c
yw1tbE1ocAtVU+G/EM8PGYj6EhXMvJZWuvbUouPAR/nbClbQei61tW7yQZwE55YV
9eQM03oeVHbEBhkZxZh85GT2qNYfvt6NV1G8R8JEQSIn7j/wkjEw8Zu8/oaBqWPg
76ITdpmmf2xHsw6wL3oYLLobgxERiq7dI5vmNhXePkY8MbWw0iUH63CE41RyVRlD
7+6v/G+PtdMb8N6P0IfHfkcZ4KDzYX8xGqSSrOBBKGfFFiRi1/fjAg10yIBbtP0h
NNV2rDsi7G80CLGVdaBUQdqpMz7CyGCvj7O4uv3gMH9GBYt9/ckaVy35WWpw/hJb
3H9ygGF/DOmEgy36nky9FhBOtOUTf5BQ/iMoBDYoinG0+8Y+TJV86qw7YAj/504M
9cHoS87hElA/RKTf1s2lJzMNpDKJx1//Ti5kKzF+RCrcXzaKPqb5oubuTcjOAXKZ
YGGeNWMV
=tgbj
-----END PGP SIGNATURE-----

--qdybElYzg1SuzlZ9--
