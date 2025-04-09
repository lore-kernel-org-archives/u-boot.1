Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C58AC36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 12:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A24D3836D2;
	Wed,  9 Apr 2025 14:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZoOH8qIn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB770836EE; Wed,  9 Apr 2025 14:33:16 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49CB782006
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 14:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AC781A48650;
 Wed,  9 Apr 2025 12:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39B9C4CEE3;
 Wed,  9 Apr 2025 12:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744201993;
 bh=B8/oGljzk3GSvI4N3jhBrydOWYw212OwAOcSpVsCPkU=;
 h=Date:To:Subject:Cc:From:References:In-Reply-To:From;
 b=ZoOH8qInrujyZbIf9YXG/q+XGV9TChdBzNzkva85YOnS8EAjLAGngpcQ/1hlg6CBv
 Y1YZt5C2gnVyoRgmBzuQXUqeVpCvTd2EWVUIxwb9/oHwvMMlvm41xy3mIJn1IG56pd
 Ci4ctHaJ9BgcndE1pKmQ3vgd9K4KP+PcKQYnY6tzwWpw9oNJzwDLG+/jlJpnIsO1Tt
 qlL4zvGW97oMROLI1a2tjtacouNCHzARkl5fceSrLOeOdydez5YkK/aB6N10gER2S4
 oCOxVPxti+nbq9jPd+bY7SKa0EEgC50768c115jvsuN7chKFkgD6cpQ2VmV3i5SMUY
 Widx9EHezgrbg==
Content-Type: multipart/signed;
 boundary=607c84b86a587dd82445f72773f92c3d9de48ae241278cb80e35f07b85b2;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 09 Apr 2025 14:33:08 +0200
Message-Id: <D92403LVTRRP.3CEQ0LEVJHTXS@kernel.org>
To: "Christoph Niedermaier" <cniedermaier@dh-electronics.com>, "Tom Rini"
 <trini@konsulko.com>
Subject: Re: [PATCH] tiny-printf: Handle formatting of %p with an extra Kconfig
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simon Glass"
 <sjg@chromium.org>, "Quentin Schulz" <quentin.schulz@cherry.de>, "Marek
 Vasut" <marex@denx.de>, "Benedikt Spranger" <b.spranger@linutronix.de>,
 "Jerome Forissier" <jerome.forissier@linaro.org>, "John Ogness"
 <john.ogness@linutronix.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
From: "Michael Walle" <mwalle@kernel.org>
X-Mailer: aerc 0.16.0
References: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
 <20250408205826.GZ5495@bill-the-cat>
 <063948ec5d3845daae97d4b9bc97c901@dh-electronics.com>
In-Reply-To: <063948ec5d3845daae97d4b9bc97c901@dh-electronics.com>
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

--607c84b86a587dd82445f72773f92c3d9de48ae241278cb80e35f07b85b2
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> >> The formatting with %pa / %pap behaves like %x, which results in an
> >> incorrect value being output. To improve this, a new fine-tuning
> >> Kconfig XPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> >> has been added. If it is enabled, the output of %pa / %pap should
> >> be correct, and if it is disabled, the pointer formatting is
> >> completely unsupported. In addition to indicate unsupported formatting=
,
> >> '?' will be output. This allows enabling pointer formatting only
> >> when needed. For SPL_NET and NET_LWIP it is selected by default.
> >> Then it also supports the formatting with %pm, %pM and %pI4.
> >>
> >> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> >> ---
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Cc: Simon Glass <sjg@chromium.org>
> >> Cc: Michael Walle <mwalle@kernel.org>
> >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> >> Cc: Marek Vasut <marex@denx.de>
> >> Cc: Benedikt Spranger <b.spranger@linutronix.de>
> >> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> >> Cc: John Ogness <john.ogness@linutronix.de>
> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>  Kconfig            |  1 +
> >>  common/spl/Kconfig |  1 +
> >>  lib/Kconfig        |  8 ++++++++
> >>  lib/tiny-printf.c  | 45 +++++++++++++++++++--------------------------
> >>  4 files changed, 29 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/Kconfig b/Kconfig
> >> index 6379a454166..4d13717294c 100644
> >> --- a/Kconfig
> >> +++ b/Kconfig
> >> @@ -757,6 +757,7 @@ config NET
> >>
> >>  config NET_LWIP
> >>  	bool "Use lwIP for networking stack"
> >> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF ||=
 TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
> >>  	imply NETDEVICES
> >>  	help
> >>  	  Include networking support based on the lwIP (lightweight IP)
> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> >> index 94e118f8465..72736dbecf5 100644
> >> --- a/common/spl/Kconfig
> >> +++ b/common/spl/Kconfig
> >> @@ -1096,6 +1096,7 @@ config SPL_DM_SPI_FLASH
> >>  config SPL_NET
> >>  	bool "Support networking"
> >>  	depends on !NET_LWIP
> >> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINTF ||=
 TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
> >>  	help
> >>  	  Enable support for network devices (such as Ethernet) in SPL.
> >>  	  This permits SPL to load U-Boot over a network link rather than
> >> diff --git a/lib/Kconfig b/lib/Kconfig
> >> index 1a683dea670..62e28d4a1f3 100644
> >> --- a/lib/Kconfig
> >> +++ b/lib/Kconfig
> >> @@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
> >>
> >>  	  The supported format specifiers are %c, %s, %u/%d and %x.
> >>
> >> +config XPL_USE_TINY_PRINTF_POINTER_SUPPORT
> >> +	bool "Extend tiny printf with the pointer formatting %p"
> >> +	depends on SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE_TIN=
Y_PRINTF
> >> +	help
> >> +	  This option enables the formatting of pointers %p. It supports
> >> +	  %p and %pa / %pap. If this option is selected by SPL_NET or NET_LW=
IP
> >> +	  it also supports the formatting with %pm, %pM and %pI4.
> >=20
> > This isn't quite what I'd like to see. I don't want to start using the
> > literal XPL namespace as that will lead to confusion down the line.
>
> OK, in V2 I will only support SPL.
>
> > Since we only have SPL_NET, I think we should name this symbol
> > SPL_USE_TINY_PRINTF_POINTER_SUPPORT, not ask about it (so bool without
> > "prompt text" following), and select from SPL_NET if
> > SPL_USE_TINY_PRINTF.

IIRC, the old one also enabled the pointer support if DEBUG is
enabled. I don't think this will work with Kconfig.

> Now you will get the output '?' when using formatting with %p or %pa.
> If someone wants to use the pointer support e.g. %pa in pinctrl-single.c
> and is restricted to use tiny printf, then it would be good to have
> the option to enable it manually and not be forced to enable SPL_NET or
> NET_LWIP to have the pointer support enabled. In this case, it makes
> sense to allow switching it on in menuconfig.

FWIW, I'm also fine with enabling full printf support as long as the
tiny one doesn't print misleading values.

-michael

--607c84b86a587dd82445f72773f92c3d9de48ae241278cb80e35f07b85b2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ/ZpBBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/ibjwF/ayV65nzQvKzUPr5N9pH/sO2sCsoZamPK
dpt7wFHwovjBMoqyW9ZnNvCoxVTZanDYAXwKvd7rJ+G5UuJDt69S/KI1VohRI4X3
zBNWFCaFwsuBbpOs1Ol3N/k4K9+1A9+gP2I=
=fu2x
-----END PGP SIGNATURE-----

--607c84b86a587dd82445f72773f92c3d9de48ae241278cb80e35f07b85b2--
