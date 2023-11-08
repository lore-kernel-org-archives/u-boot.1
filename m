Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F35C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25AEF8772D;
	Wed,  8 Nov 2023 17:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r2qSjW8S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BBA5874D5; Wed,  8 Nov 2023 17:49:38 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C639887729
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso79438367b3.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699462163; x=1700066963; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RMxFbpwNm55dBI6n6vnV4je4qYBtqmhlPd0WkxCfKKA=;
 b=r2qSjW8SYIWwVMC/2Oz11i7S3yZftefhGwyPQ/qdbE42AsFMLdSj+eEFmvJC+KChtj
 +7UxvlIkqu/h/u9DCqIwbVF13hEiPy2BsiJOuwA8YaEQaZk8Rnj0G3cgfQvxb/e3Qjtj
 BtpT7DDI+9P+QK/mINrGScF3svmFmH1fVFBp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462163; x=1700066963;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RMxFbpwNm55dBI6n6vnV4je4qYBtqmhlPd0WkxCfKKA=;
 b=Hv3M1YI5EhlYeJZY60F1YzJzbM1lamwAATxsjlY+rkzihy2UMVoEY2DFNAtEmr1EfL
 Q1zvoxQ1ZBHnrL52s0DFldxzuRIdtfjgbwS/TQ1voGl4IvcNUAWChZLfGGYJTRo0OSFj
 NHKmZWmScuvb7kO3x3s33v7m4JmmhGx7j9ijU+shshG2eiiy2UNBAnrRmNA4u7GKTm4y
 ckwFctyD9Huv0k1sGaszDoqjDDUVpjM7zCd7WEvksBuSGvuJxC03g85XYBbwdAaCL2AT
 Wmb5C0Xf0EH/f8bKDA8p2ZDH1vSDsFrYSmPb8oIsoohlg9H867hXTGKq5tiskY6HwK3+
 i3Ng==
X-Gm-Message-State: AOJu0YySIb2KX5dvku+/IdZ/h5e7yBdwRby45T0Piy1OA2ya/EYvECL9
 lXbvJKQswvIFYbFbhyb2hRy9bQ==
X-Google-Smtp-Source: AGHT+IHuvygvi8aMkWRk5R1ETK0pXrcP0JqYJYZX2l9/rnuw5esuYdLpwCC/y/obvOTrd/Nv4gWNzQ==
X-Received: by 2002:a81:9c43:0:b0:5ae:f116:48c4 with SMTP id
 n3-20020a819c43000000b005aef11648c4mr2506562ywa.37.1699462163254; 
 Wed, 08 Nov 2023 08:49:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5409-8f3c-5603-0314.res6.spectrum.com.
 [2603:6081:7b00:6400:5409:8f3c:5603:314])
 by smtp.gmail.com with ESMTPSA id
 u82-20020a816055000000b0059c0629d59csm7128652ywb.115.2023.11.08.08.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 08:49:22 -0800 (PST)
Date: Wed, 8 Nov 2023 11:49:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Andrew Davis <afd@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] board: ti: common: add rtc setup to common folder
Message-ID: <20231108164921.GR6601@bill-the-cat>
References: <20231107232139.2839534-5-bb@ti.com>
 <20231107232139.2839534-6-bb@ti.com>
 <20231107233052.GX6601@bill-the-cat>
 <20231108154634.jozi4cw5fm7v2lls@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2EYMppAJKK23vzrK"
Content-Disposition: inline
In-Reply-To: <20231108154634.jozi4cw5fm7v2lls@bryanbrattlof.com>
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


--2EYMppAJKK23vzrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 08, 2023 at 09:46:34AM -0600, Bryan Brattlof wrote:
> On November  7, 2023 thus sayeth Tom Rini:
> > On Tue, Nov 07, 2023 at 05:21:41PM -0600, Bryan Brattlof wrote:
> >=20
> > > All of the starter kit boards for the am62xxx extended family utilize
> > > the same 32k crystal oscillator for a more accurate clock for the RTC
> > > instance. Add the setup the clock mux and debounce configuration to t=
he
> > > common board directory so the entire am62xxx extended family can util=
ize
> > > it.
> > >=20
> > > Signed-off-by: Bryan Brattlof <bb@ti.com>
> > [snip]
> > > diff --git a/board/ti/common/Kconfig b/board/ti/common/Kconfig
> > > index 49edd98014ab7..56a65c0a402bb 100644
> > > --- a/board/ti/common/Kconfig
> > > +++ b/board/ti/common/Kconfig
> > > @@ -1,3 +1,11 @@
> > > +config BOARD_HAS_32K_RTC_CRYSTAL
> > > +	bool "Enable the 32k crystial for RTC"
> > > +	help
> > > +	   Some of Texas Instrument's Starter-Kit boards have
> > > +	   an onboard 32k crystal. Select this option if you wish Uboot
> > > +	   to enable this crystal for Linux
> > > +	default n
> >=20
> > No "default n" as that is the default. And we (a) need some depends on
> > for what families this is found on and then (b) how, if at all, does
> > this match up with the 32k crystal used on other TI reference platforms
> > over the years? If this is specific to the K3 families of reference
> > platforms, the help needs re-phrasing and the filename is too generic.
> > It's also not a "RTC" in terms of something we can talk to via
> > drivers/rtc/rtc-uclass.c and drivers/rtc/davinci.c, or in this case
> > porting the kernel's drivers/rtc/rtc-ti-k3.c over, yes?
> >=20
> > Oh, and "U-Boot" not "Uboot". Should see if the checkpatch typo list
> > can be easily expanded by us, one of these days.
>=20
> Yeah I'll work on the wording.
>=20
> We just need to toggle a few bits for Linux to get the crystal muxed=20
> properly for the RTC driver in Linux.

This sounds a whole lot like what AM33XX_ENABLE_RTC32K_OSC symbol (which
could be badly named, too!) is about, and hence some of my other
questions. So please keep in mind the am33xx case here, and also how
likely or not every custom K3 platform is also going to be doing this,
or not. On am33xx, it does look like a few do disable it, but it's in
common code since most custom platforms want it.

> We also toggle a few bits for the debouce settings that apparently I=20
> didn't separate out from this series.

Please keep in mind if these too are essentially generic changes for the
SoC family as well (or just how board specific they might be and how
wrong they could be before a problem is seen, ie technical vs
practical considerations).

--=20
Tom

--2EYMppAJKK23vzrK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVLvBEACgkQFHw5/5Y0
tyxCvwv+IdQ5bYvSIJRyZDjkAB7/BtLPNCqTA7W0hb7AVgecfo0LUnuvth5WXN0V
fUiEhMfT5NrVkxOvegBwWWvh99YTn8e4uEbV2qZnsOoueEorY4UiEF4dmG+fTejq
6mG0dqL4Uowt4AfuY7BWlVa8yUBMOh+OjhR9RVPsg+AYnet54CSQA67Z8fHKOfad
H/lqO47xy0pmH2623oxmLGp2VZveaaM+MQChcpDrIy94dSTteqCkUspnMCCFgoSD
UAYYzx/SnkjK47K6JvvRxqcJyoPATFrGZnSMZBaaW7MvgtkzF5MvQWfDZvTjlSsS
X3bpzcAYEAlpm2EedmPAwcTMYiWzq7NqlySrQ+7B+Q4cVm5rtWrM9RcCIENIwSIR
FLcsHHdyr4tfTOEav0alo9v3iyZmmryeU334G1X7Dhky+ucIoeBYvZ82Oh1Q1JYW
lhqB5GKZsnTZY5c52/TxIwaF/dNm4B+QliKWdwTpJmaM0c6NrR0ISBMvqDVagD88
TDJkDuCC
=xq4t
-----END PGP SIGNATURE-----

--2EYMppAJKK23vzrK--
