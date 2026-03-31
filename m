Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E57FF60F4
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 18:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10E5583E7A;
	Tue, 31 Mar 2026 20:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E5/Jh5Gs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA0783F5B; Tue, 31 Mar 2026 20:11:30 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A166B83AA9
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 20:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-40423dbe98bso2345952fac.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774980687; x=1775585487; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwLpC7ZhbtcAGf2z/XjHJuW1ZcfG3GD7cCr1OoKFTUs=;
 b=E5/Jh5GsbzLsQgqZchONJaxLXQkVxp4cEiQRkATzW1dLyOVt8z/Wp6jly6GD1Fk7tn
 sGiujA+amBf8UO5TUx4077RFc14L6tiaThkJchHip7EjsY/x0zLpuLdtBeLsZYzrcFPX
 PIeQTbV/vEZz8YvCD3fBo0SQ3EfJZniUEfonk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980687; x=1775585487;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwLpC7ZhbtcAGf2z/XjHJuW1ZcfG3GD7cCr1OoKFTUs=;
 b=nqh0X6f7RujGGWiDS9/agL5jWxXR2VNrXWRUX6nf7e6ROadZ/QbgyxQzz2QnI+pmhE
 HWKTM+AtYfsSL97exR7F+vObgVZQPBxpfk4N+B/eMmms3MKAta/2PgBGf/lU2OIpDCb8
 nnG0FAa2r5o3vTwuOo8sjJHOwBAsLQsHm4By6Doo5h3kKHS8m6H/L8tUAi8nhOKto1Q2
 5O7bTIOFLpEW7kySkfMOOQKvwGYEm7z7yrZrDWEjH+KOKLAixMZ2c+Xd87/fJrQwN2fV
 Z0+0oYbFcRhxcZCvopnH0c1rF02p492AoBzc/1ZAlXGAKD5OqigYlp+aMi7pPgPI8FoN
 yr1A==
X-Gm-Message-State: AOJu0YwZ2sQB6XZNC0TRWvCEnK+ByW307rxv3Tl6HGPD9uI06RN0fHke
 z2YXs1xF9KTitK+fc5p6P0K3BD2LxTr9gp3ngKfOt3e9aJNwo5m8UIMyuyzMDIEayYI=
X-Gm-Gg: ATEYQzzcj8aI2SeE5nF/lJZj077lsmKh7nWb/UQvMWdPAXvrBHE/GiADmN5/tUjLVn7
 C/JQzObalwsgwhe0z9kQltHjWonrmJHimpTOjgg76CIEVHFSx7wsjlsW10jJhX+pZeupbOFnjeC
 EiV/Wc2/GeShZNFgl9rRCChl8onVZbIJYyQeyxNQoe6cO+x6uTGYJg8/FT4iVFwTROwAD7bI/9E
 +mrOuO5h4CUOnHm1bxgAIbMp1fl19bQreaFTC/yORYJnQXo/agt4cDJ/71Mhga7HbAZDzn/XpKk
 Z2Caw653wzoz8XLZo010iahyDstv3zJQnDb4tNq+IMz40VBR7LKLs50tBxj2PJbEDxLVBLf6Qs9
 9CR08ZqTQn6YP2L8UiMV/oUr8CYBKeCZqX7v5cRdG8k60ZJ4O4dh82t97bZWlCfUC7NakYX+FtU
 cF4wIWCdcQrRaPkP55Kr91iJn26J8BhjJO3bWLp7wh6FnzdGYGGVzYA+5/wDyVyMQW0Plbr6y3b
 xcL+3O9AEf/kNBsAtVlbUchx7CN4j/0ikT8X+/zGk3nMFcv1fEn9B7N7us=
X-Received: by 2002:a05:6820:1508:b0:67b:b77d:70aa with SMTP id
 006d021491bc7-67fabbf8fb9mr206410eaf.15.1774980687131; 
 Tue, 31 Mar 2026 11:11:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67e231ea41dsm7374653eaf.15.2026.03.31.11.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 11:11:26 -0700 (PDT)
Date: Tue, 31 Mar 2026 12:11:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] cli: flush stdin before enabling cli
Message-ID: <20260331181124.GD41863@bill-the-cat>
References: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lVV4QHf8cKpIFLsM"
Content-Disposition: inline
In-Reply-To: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
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


--lVV4QHf8cKpIFLsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 01:03:08PM +0200, Gregor Herburger wrote:
> Currently there is no possibility to flush stdin after autocommands are
> executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> serial, it could happen that junk characters sit in the fifo and appear
> on the cli.
>=20
> Add a option to clear stdin before starting the CLI.
>=20
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Conceptually, good idea, thanks for doing it.

>=20
> ---
>=20
>  cmd/Kconfig  | 7 +++++++
>  common/cli.c | 6 ++++++
>  2 files changed, 13 insertions(+)
>=20
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 322ebe600c5..e08fbf27358 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -47,6 +47,13 @@ config HUSH_SELECTABLE
>  	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
>  endmenu
> =20
> +config CMDLINE_FLUSH_STDIN
> +	bool "Enable flushing input before starting cli"
> +	default n

We don't need default n as that's the default.

> +	help
> +	  When this option is enabled the stdin buffer will be flushed before
> +	  starting the CLI.
> +
>  config CMDLINE_EDITING
>  	bool "Enable command line editing"
>  	default y
> diff --git a/common/cli.c b/common/cli.c
> index 4694a35cd0e..42d27ed87e7 100644
> --- a/common/cli.c
> +++ b/common/cli.c
> @@ -295,6 +295,12 @@ err:
>  void cli_loop(void)
>  {
>  	bootstage_mark(BOOTSTAGE_ID_ENTER_CLI_LOOP);
> +
> +	if (IS_ENABLED(CONFIG_CMDLINE_FLUSH_STDIN)) {
> +		while (tstc())
> +			(void)getchar();
> +	}
> +
>  #if CONFIG_IS_ENABLED(HUSH_PARSER)
>  	if (gd->flags & GD_FLG_HUSH_MODERN_PARSER)
>  		parse_and_run_file();

This is flush_stdin() from common/autoboot.c, but that's a static
function. We should find a better spot for that perhaps and then call it
when required.

--=20
Tom

--lVV4QHf8cKpIFLsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacwOQQAKCRAr4qD1Cr/k
Ch31AP904voRMoXqG6vlMlrgtT0qJjAXIc0yMk7FevCDp/5A2gEA03esbgCykF1F
8G/24w+Fkjmq2vnvvZuVPeBan4tEMQQ=
=C4cy
-----END PGP SIGNATURE-----

--lVV4QHf8cKpIFLsM--
