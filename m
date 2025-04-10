Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5E3C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 10:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEB1282A71;
	Thu, 10 Apr 2025 12:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XKWdXYvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE16583B7E; Thu, 10 Apr 2025 12:44:27 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7DE8091A
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 12:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DFE7B6843D;
 Thu, 10 Apr 2025 10:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F14EC4CEDD;
 Thu, 10 Apr 2025 10:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744281863;
 bh=K2BEju9G5YHc+f6AyrJbYLEq1bCyrs0rYEUYPByV/t4=;
 h=Date:From:To:Subject:Cc:References:In-Reply-To:From;
 b=XKWdXYvtEyeEZihqSTLptK0omRg/lsnyedtqugcMRV1o0ycpjiubjpspq72+ILT6b
 lOYE0sVnlNbMmI0pFLk9RgdWXUNpVeWdX1yKFQREX5XloMqrHXD2mxRahID6mXlG4O
 mdX4kCHaCHc8d2kywqo3AZqLQ6rvnNJP54XTC9yNZRK8mQkHiQX+6wuIyhaPzFv9Z/
 8VPc3XhaJfXP31ylKN9DpGHfAE6xpWcBywMXD12EOeLVOM1wSUu9LGlrOe4AwHyk72
 onqIUxri428GSU2Lc1x9ONYBBDKXTRSjsdqZ2efTKb9DM4+6dJwIsD4+q0vqzeX1Cr
 sP+PI2LdNMXrA==
Content-Type: multipart/signed;
 boundary=25b7a820cb6b1628d3f18a1ca4dc54d62c4e343cffcd5268ab77fc620c38;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Thu, 10 Apr 2025 12:44:19 +0200
Message-Id: <D92WBC4OYQXK.37TYATBFVRRD8@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Tom Rini" <trini@konsulko.com>
Subject: Re: [PATCH] tiny-printf: Handle formatting of %p with an extra Kconfig
Cc: "Christoph Niedermaier" <cniedermaier@dh-electronics.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Simon Glass"
 <sjg@chromium.org>, "Quentin Schulz" <quentin.schulz@cherry.de>, "Marek
 Vasut" <marex@denx.de>, "Benedikt Spranger" <b.spranger@linutronix.de>,
 "Jerome Forissier" <jerome.forissier@linaro.org>, "John Ogness"
 <john.ogness@linutronix.de>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.16.0
References: <20250407085614.126626-1-cniedermaier@dh-electronics.com>
 <20250408205826.GZ5495@bill-the-cat>
 <063948ec5d3845daae97d4b9bc97c901@dh-electronics.com>
 <D92403LVTRRP.3CEQ0LEVJHTXS@kernel.org>
 <20250409152207.GF5495@bill-the-cat>
In-Reply-To: <20250409152207.GF5495@bill-the-cat>
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

--25b7a820cb6b1628d3f18a1ca4dc54d62c4e343cffcd5268ab77fc620c38
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 9, 2025 at 5:22 PM CEST, Tom Rini wrote:
> On Wed, Apr 09, 2025 at 02:33:08PM +0200, Michael Walle wrote:
> > Hi,
> >=20
> > > >> The formatting with %pa / %pap behaves like %x, which results in a=
n
> > > >> incorrect value being output. To improve this, a new fine-tuning
> > > >> Kconfig XPL_USE_TINY_PRINTF_POINTER_SUPPORT for pointer formatting
> > > >> has been added. If it is enabled, the output of %pa / %pap should
> > > >> be correct, and if it is disabled, the pointer formatting is
> > > >> completely unsupported. In addition to indicate unsupported format=
ting,
> > > >> '?' will be output. This allows enabling pointer formatting only
> > > >> when needed. For SPL_NET and NET_LWIP it is selected by default.
> > > >> Then it also supports the formatting with %pm, %pM and %pI4.
> > > >>
> > > >> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.=
com>
> > > >> ---
> > > >> Cc: Tom Rini <trini@konsulko.com>
> > > >> Cc: Simon Glass <sjg@chromium.org>
> > > >> Cc: Michael Walle <mwalle@kernel.org>
> > > >> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > > >> Cc: Marek Vasut <marex@denx.de>
> > > >> Cc: Benedikt Spranger <b.spranger@linutronix.de>
> > > >> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> > > >> Cc: John Ogness <john.ogness@linutronix.de>
> > > >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >> ---
> > > >>  Kconfig            |  1 +
> > > >>  common/spl/Kconfig |  1 +
> > > >>  lib/Kconfig        |  8 ++++++++
> > > >>  lib/tiny-printf.c  | 45 +++++++++++++++++++----------------------=
----
> > > >>  4 files changed, 29 insertions(+), 26 deletions(-)
> > > >>
> > > >> diff --git a/Kconfig b/Kconfig
> > > >> index 6379a454166..4d13717294c 100644
> > > >> --- a/Kconfig
> > > >> +++ b/Kconfig
> > > >> @@ -757,6 +757,7 @@ config NET
> > > >>
> > > >>  config NET_LWIP
> > > >>  	bool "Use lwIP for networking stack"
> > > >> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINT=
F || TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
> > > >>  	imply NETDEVICES
> > > >>  	help
> > > >>  	  Include networking support based on the lwIP (lightweight IP)
> > > >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> > > >> index 94e118f8465..72736dbecf5 100644
> > > >> --- a/common/spl/Kconfig
> > > >> +++ b/common/spl/Kconfig
> > > >> @@ -1096,6 +1096,7 @@ config SPL_DM_SPI_FLASH
> > > >>  config SPL_NET
> > > >>  	bool "Support networking"
> > > >>  	depends on !NET_LWIP
> > > >> +	select XPL_USE_TINY_PRINTF_POINTER_SUPPORT if SPL_USE_TINY_PRINT=
F || TPL_USE_TINY_PRINTF || VPL_USE_TINY_PRINTF
> > > >>  	help
> > > >>  	  Enable support for network devices (such as Ethernet) in SPL.
> > > >>  	  This permits SPL to load U-Boot over a network link rather tha=
n
> > > >> diff --git a/lib/Kconfig b/lib/Kconfig
> > > >> index 1a683dea670..62e28d4a1f3 100644
> > > >> --- a/lib/Kconfig
> > > >> +++ b/lib/Kconfig
> > > >> @@ -253,6 +253,14 @@ config VPL_USE_TINY_PRINTF
> > > >>
> > > >>  	  The supported format specifiers are %c, %s, %u/%d and %x.
> > > >>
> > > >> +config XPL_USE_TINY_PRINTF_POINTER_SUPPORT
> > > >> +	bool "Extend tiny printf with the pointer formatting %p"
> > > >> +	depends on SPL_USE_TINY_PRINTF || TPL_USE_TINY_PRINTF || VPL_USE=
_TINY_PRINTF
> > > >> +	help
> > > >> +	  This option enables the formatting of pointers %p. It supports
> > > >> +	  %p and %pa / %pap. If this option is selected by SPL_NET or NE=
T_LWIP
> > > >> +	  it also supports the formatting with %pm, %pM and %pI4.
> > > >=20
> > > > This isn't quite what I'd like to see. I don't want to start using =
the
> > > > literal XPL namespace as that will lead to confusion down the line.
> > >
> > > OK, in V2 I will only support SPL.
> > >
> > > > Since we only have SPL_NET, I think we should name this symbol
> > > > SPL_USE_TINY_PRINTF_POINTER_SUPPORT, not ask about it (so bool with=
out
> > > > "prompt text" following), and select from SPL_NET if
> > > > SPL_USE_TINY_PRINTF.
> >=20
> > IIRC, the old one also enabled the pointer support if DEBUG is
> > enabled. I don't think this will work with Kconfig.
>
> I was looking around for, but didn't quite see, a good existing option
> to "if .." around the prompt text for.

What I meant was that you normally do -DDEBUG on a file (or
equally a #define DEBUG). Thus you cannot add it to Kconfig.

> > > Now you will get the output '?' when using formatting with %p or %pa.
> > > If someone wants to use the pointer support e.g. %pa in pinctrl-singl=
e.c
> > > and is restricted to use tiny printf, then it would be good to have
> > > the option to enable it manually and not be forced to enable SPL_NET =
or
> > > NET_LWIP to have the pointer support enabled. In this case, it makes
> > > sense to allow switching it on in menuconfig.
> >=20
> > FWIW, I'm also fine with enabling full printf support as long as the
> > tiny one doesn't print misleading values.
>
> I'm not sure if the one non-debug %pa print in pinctrl-single.c is
> really triggered within SPL, and I do hope that the way this patch is
> otherwise done will make it easier if someone needs %pa to work when
> debugging a problem in SPL, and can't enable full printf due to space.

Yes, but the dev_dbg() triggered it because of the same reason as
above, DEBUG isn't defined if you do it on a per-file basis. Or I'm
getting that logic wrong, as I don't understand why _DEBUG (commit
c091f65234cf introduced it but doesn't tell the reason).

-michael

--25b7a820cb6b1628d3f18a1ca4dc54d62c4e343cffcd5268ab77fc620c38
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZ/ehBBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/gyxwGAoS7HCAMdvaiTBE0Hjb0v8xfd/wl2A0du
YuM3BuC7MNC4Am3wPlGJmAJPS9lKBY0uAX9zMzvhauZHwgl5CIG+ioaHjUhJzu4N
eotlyqHARAZQ+kIkMAyCShYtYxNk7gCWxCc=
=G6xv
-----END PGP SIGNATURE-----

--25b7a820cb6b1628d3f18a1ca4dc54d62c4e343cffcd5268ab77fc620c38--
