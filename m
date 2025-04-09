Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064D1C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 15:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E65A83898;
	Wed,  9 Apr 2025 17:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uiDYhjH3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18A0C838AA; Wed,  9 Apr 2025 17:22:16 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85CBE83886
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 17:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2c2dc6c30c2so1983142fac.2
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744212131; x=1744816931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rJBjtNOBubRRNfnVQqBVXgyPeUzBeal1W2Iqaz+JM7I=;
 b=uiDYhjH3IvUOOqjWDgvYQjANxEAIIodpB9fDBUIwsMY1vjd3QJsrgDN3kH0t91ovkN
 on6zNHnzL9zlrSAzsGHiF9M7VwlnnD31SQ4aSXwrKil9iNQGSJm1fP4cWSQgsuewgO1u
 rjQrS67zszVp+EaPNRvijezpWU+Hx9GeynkbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744212131; x=1744816931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJBjtNOBubRRNfnVQqBVXgyPeUzBeal1W2Iqaz+JM7I=;
 b=JoPCBA783Pzv+r63Ps+RZS7lT05ynbv2MsbqL4AoSeWOtUKnH30US2WF/dj6dtyWcb
 CyrLtZg1Hb4EFirjiX5DJxZedrS712paUwTNOD9TwVoU1xRWAHQ8ef14LgzCyv1D2XCd
 0hEANEeJFnT/ozuDFeoQAw4leitAWoyBUZ0KzdnXU6BKwtsT2WwAd834/9vlAMqQ3+PW
 jZsdLLjBqPVe5o3zDyPMREy7gML5wFVBxwpUZGmj4xTp7G4mv/PvJyZ7NBYeuPAgX9pv
 rcDSuWRKxEN6fARdKgg8CxaWCKZIuhGoMPsg3+pKiZo0vkk4gKBT6UuIS2/G3w9KyF6c
 HxPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0/K0hFOd6eibWsOdA1Wts9vIRHD3IoLQLa2tMyS4xF8bncgP3f6WgYMFvVySbXJRZKAgagnQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yzv1EczxP5mwJUZ9OX6TvUNknZL9BKzf3dJbNagOXxiBMGsFIq/
 ANazxqQXiAnTDMSziFE31gXOq7NgWyhw77WWTPCZnyxIFpPbQcqoZRX53QHTNqC3jUETffPRM0P
 P
X-Gm-Gg: ASbGnctnzsIeQ1HIxfmwoH+cCGsu9UyztJm1Gy4IUyBNtlUH77wmgDov6olOysv6dut
 /60ZVTGRpaV+66laRTOIB/snuBUoYx09JV9TsomRTmuIpoFmtTWjnpH00tNiaKzbZw7QL7vyCdy
 jg0eyHL/SaRA/jm6P7HBLrbeDVDjAiotlZ3VRDYeG5pvM6GPhq18/CPyweE6AGoNikusaA2kEgL
 m17AwbaqTDAGY7TE4qRiefuyzPK/fru1EbhAXQMiy9xhVY7yEM/DbjE08eQlXrJYBwBE/U2qlAN
 gB8g5NYRI/yz/PTWgKLUBgL6ifuSp8jVuysibZ/QMblvcM/rKPPIO0n3aXAXGHb3DoGd4iBFw/p
 Lig==
X-Google-Smtp-Source: AGHT+IFOVUyahfQCwR8rSQGPwr2eduUpuqU1XZx/gm85kHdl3mftvA98xQ8OPPDUQXhWZsZoJRufyg==
X-Received: by 2002:a05:6870:71cb:b0:2c2:416e:cf43 with SMTP id
 586e51a60fabf-2d08dd755c1mr1649765fac.12.1744212130226; 
 Wed, 09 Apr 2025 08:22:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d51fa1sm207945a34.6.2025.04.09.08.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 08:22:09 -0700 (PDT)
Date: Wed, 9 Apr 2025 09:22:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marex@denx.de>, Benedikt Spranger <b.spranger@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 John Ogness <john.ogness@linutronix.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tiny-printf: Handle formatting of %p with an extra Kconfig
Message-ID: <20250409152207.GF5495@bill-the-cat>
References: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
 <20250408205826.GZ5495@bill-the-cat>
 <063948ec5d3845daae97d4b9bc97c901@dh-electronics.com>
 <D92403LVTRRP.3CEQ0LEVJHTXS@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="leSKjg+KkVzXCssp"
Content-Disposition: inline
In-Reply-To: <D92403LVTRRP.3CEQ0LEVJHTXS@kernel.org>
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


--leSKjg+KkVzXCssp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 02:33:08PM +0200, Michael Walle wrote:
> Hi,
>=20
> > >> The formatting with %pa / %pap behaves like %x, which results in an
> > >> incorrect value being output. To improve this, a new fine-tuning
> > >> Kconfig XPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> > >> has been added. If it is enabled, the output of %pa / %pap should
> > >> be correct, and if it is disabled, the pointer formatting is
> > >> completely unsupported. In addition to indicate unsupported formatti=
ng,
> > >> '?' will be output. This allows enabling pointer formatting only
> > >> when needed. For SPL_NET and NET_LWIP it is selected by default.
> > >> Then it also supports the formatting with %pm, %pM and %pI4.
> > >>
> > >> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.co=
m>
> > >> ---
> > >> Cc: Tom Rini <trini@konsulko.com>
> > >> Cc: Simon Glass <sjg@chromium.org>
> > >> Cc: Michael Walle <mwalle@kernel.org>
> > >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > >> Cc: Marek Vasut <marex@denx.de>
> > >> Cc: Benedikt Spranger <b.spranger@linutronix.de>
> > >> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > >> Cc: John Ogness <john.ogness@linutronix.de>
> > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >> ---
> > >>  Kconfig            |  1 +
> > >>  common/spl/Kconfig |  1 +
> > >>  lib/Kconfig        |  8 ++++++++
> > >>  lib/tiny-printf.c  | 45 +++++++++++++++++++------------------------=
--
> > >>  4 files changed, 29 insertions(+), 26 deletions(-)
> > >>
> > >> diff --git a/Kconfig b/Kconfig
> > >> index 6379a454166..4d13717294c 100644
> > >> --- a/Kconfig
> > >> +++ b/Kconfig
> > >> @@ -757,6 +757,7 @@ config NET
> > >>
> > >>  config NET_LWIP
> > >>  	bool "Use lwIP for networking stack"
> > >> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF =
|| TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
> > >>  	imply NETDEVICES
> > >>  	help
> > >>  	  Include networking support based on the lwIP (lightweight IP)
> > >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > >> index 94e118f8465..72736dbecf5 100644
> > >> --- a/common/spl/Kconfig
> > >> +++ b/common/spl/Kconfig
> > >> @@ -1096,6 +1096,7 @@ config SPL_DM_SPI_FLASH
> > >>  config SPL_NET
> > >>  	bool "Support networking"
> > >>  	depends on !NET_LWIP
> > >> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF =
|| TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
> > >>  	help
> > >>  	  Enable support for network devices (such as Ethernet) in SPL.
> > >>  	  This permits SPL to load U-Boot over a network link rather than
> > >> diff --git a/lib/Kconfig b/lib/Kconfig
> > >> index 1a683dea670..62e28d4a1f3 100644
> > >> --- a/lib/Kconfig
> > >> +++ b/lib/Kconfig
> > >> @@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
> > >>
> > >>  	  The supported format specifiers are %c, %s, %u/%d and %x.
> > >>
> > >> +config XPL_USE_TINY_PRINTF_POINTER_SUPPORT
> > >> +	bool "Extend tiny printf with the pointer formatting %p"
> > >> +	depends on SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_T=
INY_PRINTF
> > >> +	help
> > >> +	  This option enables the formatting of pointers %p. It supports
> > >> +	  %p and %pa / %pap. If this option is selected by SPL_NET or NET_=
LWIP
> > >> +	  it also supports the formatting with %pm, %pM and %pI4.
> > >=20
> > > This isn't quite what I'd like to see. I don't want to start using the
> > > literal XPL namespace as that will lead to confusion down the line.
> >
> > OK, in V2 I will only support SPL.
> >
> > > Since we only have SPL_NET, I think we should name this symbol
> > > SPL_USE_TINY_PRINTF_POINTER_SUPPORT, not ask about it (so bool without
> > > "prompt text" following), and select from SPL_NET if
> > > SPL_USE_TINY_PRINTF.
>=20
> IIRC, the old one also enabled the pointer support if DEBUG is
> enabled. I don't think this will work with Kconfig.

I was looking around for, but didn't quite see, a good existing option
to "if .." around the prompt text for.

> > Now you will get the output '?' when using formatting with %p or %pa.
> > If someone wants to use the pointer support e.g. %pa in pinctrl-single.c
> > and is restricted to use tiny printf, then it would be good to have
> > the option to enable it manually and not be forced to enable SPL_NET or
> > NET_LWIP to have the pointer support enabled. In this case, it makes
> > sense to allow switching it on in menuconfig.
>=20
> FWIW, I'm also fine with enabling full printf support as long as the
> tiny one doesn't print misleading values.

I'm not sure if the one non-debug %pa print in pinctrl-single.c is
really triggered within SPL, and I do hope that the way this patch is
otherwise done will make it easier if someone needs %pa to work when
debugging a problem in SPL, and can't enable full printf due to space.

--=20
Tom

--leSKjg+KkVzXCssp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf2kJ8ACgkQFHw5/5Y0
tyzyMQv/b5eeGUqwHi8icG/PCwdA1ztdWuL9Cmg8kWCjPdEL6CdCkBNRk4fFjecT
okJvB2e0bI7KrVFiN3iyvewaj7aKC6Dqrt3+450E2FhjpZfRJrPkGse2nz8jtzOL
cXITdv30sXFCgRukaHODodyZelP5XMUYoJkQ7igHWjwGvtJxbiPDjk/N6dI83mOt
yRIp0I5JY3Zn5bdgstdBW/EQZOvNJGfbrTvin7aH0Oy2Eb0c61Gce2BXD23NMtwz
47L+/wdyKLf4aRl9ct10+CDlWZsnbYXH0Pdly/99kglwRnuUl8wTS5f+17Rh9mFa
OTSAkXZfEMtt7+UvRnNIl1TmR/Pu+C1ruXcNBExLiHBMO8jqynURHzEunKmoUxBg
YzVila9+B+PZiN+i0jqrmGjmwszdAhKOnGm7F5VNa2aF5MRo3LquV9p6fOoaC7nI
Zr7hnmKaPrfIjzfhVqwwKSfVgJZSFAOyKlNjPNv6QLNkZIKdFeGeUtgulNyTyNJP
n80nPEdO
=wBYj
-----END PGP SIGNATURE-----

--leSKjg+KkVzXCssp--
