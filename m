Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED1FCF428F5
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 20:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391F38407D;
	Wed, 15 Apr 2026 22:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Man+8qOO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9CB8407E; Wed, 15 Apr 2026 22:56:31 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAB983B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 22:56:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-662f30d3f1fso4139192eaf.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 13:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776286587; x=1776891387; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5QvlajjKIiOAipAYL4AKUMRw74HxcSCGaCNdQ7nNjnw=;
 b=Man+8qOOLloT/uuDV3N2PkuE57xlNbyxi3e5eFs+IPmrd3nQTtEOMPVHkv6rW7iS9b
 +TTMvnTDuITM2fKKq8S5GEI/zNgzBMHMsm0pyCVOyR7ZwA63SyNp1SxXB96WGzhzarB9
 isEA3CYzEutrUIcTxQDvrQ4j0JVH7c4Ckf4Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776286587; x=1776891387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QvlajjKIiOAipAYL4AKUMRw74HxcSCGaCNdQ7nNjnw=;
 b=FusNwbAOGmRTwzi0cYgVUjyn2VQzUzHY3RFoTFpKEQ5XpFqYxw9/Wb8plHF+pk9V3f
 cm/4IHK3HI62cLkP735jh2mccLty8pta7bTFwPLjO1j0rMaWh9NkxG/Yj0cSZmflGNeK
 7iOCdIKlbovFQaPBo6UCa2DhEFt6zamb0k5Uysvs3Y3zFCDCo+f/5Xva6P+P5bpkWQO7
 Zbf7EXJmRSQIe61jdtuHFqZjOvikXqOCcgSUi3n6rS4r60ZUbhZDyW1WNqvyt7JWcQss
 hkHazeKYJombaP2BamiIxJC1zJXhIvo+l71PdDszVOpFsoLQNNDVDLrme9OgwJ2f+hu/
 zsaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+w912RzDHxDphz0xUW4zRXLHf4fTyiOJ89jQw8UJLxzW72y5IxzBuxW0+nEpLgRK+/+ci/NMQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yw30LJBvCdpfkM2aNYh4c/4lc1/rlBf4SiBsPGvztQD5I67vbKj
 OdFRbcLs5vAE5DeJGAt2jK6Kx5TqoXRpsT57MWLMY6kCLAtvD6Tfcdg8Uu5oE8OxRY4=
X-Gm-Gg: AeBDies3P47J/xr/B2YJMAj4Pno36roMbTdLIKJ+z50dGS16R7OzcCSbDXvU9Tml53b
 giRak0PQUmIE/ujpb5fiasOCE7olMB5BxQ/A/539kkIo7aZTovJap3wNAczO2jM1pyiTPLJ2/zq
 0pvN0oRliOSZgOcnsg0YMDNixAZQj8GCDOkmeTaTfi8IPgMaJdDCh6JizklG+rVdrfDHoetaWD9
 jIwy+MW4jcKBNi4iGxBgbzft2QJfHW39OslEapJMEWNMgFLJVwALc1MtletLqcr/M8qLQZuDN+7
 5gAT/uPYGYvXu6KU+uwMx6dCwh+OF1T4uyMltrpELMmoOFa8RhGLzm6ifVkBc8aP0qxcqd7H8HK
 dd69rjwc+FCWpWgqA8vbByjzZusH9B++rKqFp8CJe/OBcyovL+avMT9iNZyiAqG72LRxc8coo6B
 qo/Ggs4ctP6VHSJgQDCGuBzdgwHlEfZIKMJqPPo4U9cKGPHL2OIeIqa2NQWXJlIH28Y2A6xRF6l
 Zkv69/zg/px6tP0eUMq/Kvgi8JQiSLLzxLM0Qtq6nfbC7wDd9Q0O7Coaxgo4f3aYuxQsn/m
X-Received: by 2002:a05:6820:1519:b0:67d:e78f:38d2 with SMTP id
 006d021491bc7-694235fbd9emr568633eaf.25.1776286587226; 
 Wed, 15 Apr 2026 13:56:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6932b374a0dsm1497544eaf.5.2026.04.15.13.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 13:56:26 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:56:24 -0600
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] arm: mediatek: enable fw loader support
Message-ID: <20260415205624.GP41863@bill-the-cat>
References: <20260410015311.4066075-1-weijie.gao@mediatek.com>
 <d23fec41-0eeb-489f-8c1e-5bb4b974139b@baylibre.com>
 <0d7ba570-335e-4de7-b272-7152b540def2@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4BNZA1cJYNJnQ2ut"
Content-Disposition: inline
In-Reply-To: <0d7ba570-335e-4de7-b272-7152b540def2@baylibre.com>
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


--4BNZA1cJYNJnQ2ut
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 02:27:39PM -0500, David Lechner wrote:
> On 4/15/26 10:02 AM, David Lechner wrote:
> > On 4/9/26 8:53 PM, Weijie Gao wrote:
> >> Enable SUPPORTS_FW_LOADER to allow the mediatek platform to use ethern=
et PHY
> >> drivers with fw loading.
> >>
> >> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> >> ---
> >>  arch/arm/Kconfig | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> >> index 03416c55265..aee8e74dace 100644
> >> --- a/arch/arm/Kconfig
> >> +++ b/arch/arm/Kconfig
> >> @@ -868,6 +868,7 @@ config ARCH_MEDIATEK
> >>  	select SPL_LIBGENERIC_SUPPORT if SPL
> >>  	select SPL_OF_CONTROL if SPL
> >>  	select SUPPORT_SPL
> >> +	select SUPPORTS_FW_LOADER
> >=20
> > I don't think this is how this config option is meant to be used.
> >=20
> > Based on [1], it sounds like we just need to make sure CMDLINE and
> > ENV_SUPPORT are enabled in any config that also enables PHY_MEDIATEK_2P=
5GE.
> >=20
> > I don't see any defconfig that enables PHY_MEDIATEK_2P5GE though, so
> > I'm not sure there is anything to do here. Unless it makes sense to
> > enable this in one of the existing defconfigs or add a new defconfig?
> >=20
> > [1]: https://lore.kernel.org/u-boot/20260310162610.1163833-1-trini@kons=
ulko.com/
> >=20
> >>  	help
> >>  	  Support for the MediaTek SoCs family developed by MediaTek Inc.
> >>  	  Please refer to doc/README.mediatek for more information.
> >=20
>=20
> I thought about this some more and I wonder if we need to do something
> like this to make it actually work correctly though...
>=20
> ---
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4e6a0c6a1b6..ed37daa28b8 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -73,6 +73,7 @@ config DYNAMIC_CRC_TABLE
> =20
>  config SUPPORTS_FW_LOADER
>  	bool
> +	default y
>  	depends on CMDLINE
>  	depends on ENV_SUPPORT

That would be "def_bool y" in practice. And yes, that looks right, and
should have a Fixes.

--=20
Tom

--4BNZA1cJYNJnQ2ut
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad/7cAAKCRAr4qD1Cr/k
CgPwAQCVW8nklALBqTFglC4+YmVo5YZcv/XeEctkGLIgjZ3h6gEAtcfEQrb+Sd8O
rvlHWnVW942Q40+WW1UXJqoXCbSR/wo=
=29Lu
-----END PGP SIGNATURE-----

--4BNZA1cJYNJnQ2ut--
