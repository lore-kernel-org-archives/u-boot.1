Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C682DCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 14:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAFA5801BE;
	Mon, 18 Aug 2025 16:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uOcUY5yy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C20D801DD; Mon, 18 Aug 2025 16:57:26 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED7BD80107
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 16:57:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-61bd4c6de5cso2281346eaf.1
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755529042; x=1756133842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nq4oNw4eiUUEveAFFdXZakBf3KrHFip8PHvP7R+gZys=;
 b=uOcUY5yyFjltwJwD6ErP243m5VPTs004Dhz5K/b8QaaJ0GfMOK2F7foqAROAR6oKzf
 +Xmixt9gV/o8rbtHCB7wvkr4nguXQX8t1Lnpk4NKMHGo1ZkOEmfJ94PrzPAlGTHKae4f
 fggyQFRMdYuHLr0dSDMMmCogf9pnPHiAPwiMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755529042; x=1756133842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nq4oNw4eiUUEveAFFdXZakBf3KrHFip8PHvP7R+gZys=;
 b=pDWYI9hywoc1GTQ41FcWmPlHZ7MC1mf4SWPjMgVEK665giTg5iHKijlWvWfRnap9zF
 Xa5YHDK3lYoxff0Xif3LepNOHJH0uu3g2cRRl92lSWBShu16RBd+L+zumFrVuKOkEqqI
 vRtQ4LzQgwcV6BT7lpVRwzdPiqyDSMJubhMnfWqzZC6p6/CHwVdP5zsxR02sEncThKve
 CYES40c5Fe8RJTVC2rSX7OI335JLlaB/yjVl4TJrRWBOa91xIINyiK5eNTu0ACorK3En
 sRAtzC7h40a0sf5jwZcnvNA9WX7Mi4MpW5k3gI6FO13Q2z/b93pUTrmLnBtvXDeofEwe
 8Kiw==
X-Gm-Message-State: AOJu0YzVTMTN/YLgm8EL7Oz18jpyIBpVBNWqEF7klc2uU//BAV/MjKjG
 2T1AbF23oROdaBXf0nJ5ajmA87eokyQrIiIxTzs8HnWRfNpRmjY3CPlQ0fmhv6pnYHo=
X-Gm-Gg: ASbGnctBxYNWEXY32Q/ieAYGNM1tzzPUzWj9QKXLEw6d7h1X9KJsEowVazeSPng49mG
 udb2K0zwNzCE3QNttt4TbxK2KtwdSmsRWbtgDjqro4SESe/ATsqUtqFag7L2v9W2rGPGSs622bK
 1msAYMFmY9wvaGM8nSiTX4sBKLCabcyQ0Efs3Wz2FZ9zLGAcodAcoT/UTQmUIt999ezayCe8wtC
 J7Cf65YbLFZluwea4cNEl7z9g7fe14aMCNiY0/nMq9EV99w72AiCGs1GDDZWHzntTMeBwKMRyHV
 3zkrZF5Qgk69Kvo+3IhX1E0M8qc+SpfpexHPNXSR9fxQBwVEyjWc1aDHY5yulz9I6XyT1zPrlt4
 X7ctSICmaXolYENIwtHGjUsHM39xWuWvdzvqnqq+weDmCvt4s5zf+XQGr
X-Google-Smtp-Source: AGHT+IElJFU8nplVCIBLjU+5ZCpmBdR76TW0Jmv/hp6DnBt4PHYrEkx1pFvkqpslSIUT5yjFyjGqLQ==
X-Received: by 2002:a05:6808:151f:b0:433:ff53:1b7e with SMTP id
 5614622812f47-435ec3637eemr7790678b6e.11.1755529042442; 
 Mon, 18 Aug 2025 07:57:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-435ed118964sm1795269b6e.8.2025.08.18.07.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 07:57:21 -0700 (PDT)
Date: Mon, 18 Aug 2025 08:57:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] net: Add SYS_FAULT_MII_ADDR to Kconfig
Message-ID: <20250818145719.GX124814@bill-the-cat>
References: <20250812175633.3056595-1-trini@konsulko.com>
 <43827d75-e2ad-4c78-b540-112c1cde68e9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5Rs0GN72ZDcLI0IE"
Content-Disposition: inline
In-Reply-To: <43827d75-e2ad-4c78-b540-112c1cde68e9@linaro.org>
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


--5Rs0GN72ZDcLI0IE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 03:58:13PM +0200, Jerome Forissier wrote:
> Hi Tom,
>=20
> On 8/12/25 19:56, Tom Rini wrote:
> > The support found under SYS_FAULT_ECHO_LINK_DOWN requires that the
> > SYS_FAULT_MII_ADDR symbol also be set. This wasn't previously found in
> > Kconfig, so add it now.
> >=20
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > This was found as part of testing "allyesconfig". I'm not sure if
> > there's anything useful that could be put in the "help" text here.
> > ---
> >  README      | 3 ---
> >  net/Kconfig | 4 ++++
> >  2 files changed, 4 insertions(+), 3 deletions(-)>
> > diff --git a/README b/README
> > index 65305e6a0371..7808af528625 100644
> > --- a/README
> > +++ b/README
> > @@ -1249,9 +1249,6 @@ Note: once the monitor has been relocated, then i=
t will complain if
> >  the default environment is used; a new CRC is computed as soon as you
> >  use the "saveenv" command to store a valid environment.
> > =20
> > -- CONFIG_SYS_FAULT_MII_ADDR:
> > -		MII address of the PHY to check for the Ethernet link state.
> > -
> >  - CONFIG_DISPLAY_BOARDINFO
> >  		Display information about the board that U-Boot is running on
> >  		when U-Boot starts up. The board function checkboard() is called
> > diff --git a/net/Kconfig b/net/Kconfig
> > index 24508026200d..6d5de9a675e4 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -60,6 +60,10 @@ config SYS_FAULT_ECHO_LINK_DOWN
> >  	  this option is active, then CONFIG_SYS_FAULT_MII_ADDR also needs to
> >  	  be configured.
> > =20
> > +config SYS_FAULT_MII_ADDR
> > +	hex "MII address of the PHY to check for the Ethernet link state"
> > +	depends on SYS_FAULT_ECHO_LINK_DOWN
> > +
> >  config TFTP_PORT
> >  	bool "Set TFTP UDP source/destination ports via the environment"
> >  	help
>=20
> This breaks qemu_m68k in CI [1].
>=20
> [1] https://source.denx.de/u-boot/custodians/u-boot-net/-/jobs/1224987
>=20
> More specifically:
>=20
> $ tools/buildman/buildman -o /tmp/build -w -E -W -e --board M5208EVBE
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>       m68k:  +   M5208EVBE
> +.config:598:warning: symbol value '' invalid for SYS_FAULT_MII_ADDR
> +
> +Error in reading or end of file.
> +make[3]: *** [scripts/kconfig/Makefile:75: syncconfig] Terminated
> +make[2]: *** [Makefile:647: syncconfig] Terminated
> +make: *** [Makefile:198: sub-make] Terminated
> +(** did you define an int/hex Kconfig with no default? **)
>     0    0    1 /1              M5208EVBE
> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25

Oh hunh, OK, sorry about that. This is one of those odd symbols then. I
hesitated on adding the full dependencies which were also
CONFIG_LED_STATUS and CONFIG_LED_STATUS_RED, which no one has, and I
guess I should have. The platforms which set SYS_FAULT_ECHO_LINK_DOWN
today (44 of them) don't actually do anything here because the only
caller of miiphy_link requires all of the above. I'll respin this patch
all the same, soon. Thanks!

--=20
Tom

--5Rs0GN72ZDcLI0IE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKM/SwAKCRAr4qD1Cr/k
ChUjAQCNSd2eBWQnXXQ+IYhUpUE4o1QdYsQTmO9H11JIzfBmrQEAymqkF0bL/UB/
no5RICpZcql+djYFjk+fnILt7FDeVww=
=brz0
-----END PGP SIGNATURE-----

--5Rs0GN72ZDcLI0IE--
