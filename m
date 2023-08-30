Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDC9C6FA8F
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 21:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9466886529;
	Wed, 30 Aug 2023 23:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t2zyLasf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B432C86521; Wed, 30 Aug 2023 23:32:09 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 575A48654B
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 23:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-58caaedb20bso3016467b3.1
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693431124; x=1694035924; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BYCPHnZX4Sg8/q8AG44cDfoIrbw6B5kxbDNfCbbXpzM=;
 b=t2zyLasfcwu0hnLZ7ZIFWEW+8JDFEjV/wJQmjCi3nPXHHwSzFAR1gNJ2sgpxYqit3V
 MIo5XDvjRklZOsXuxihuOdDlC3aSR14IPb8e7aM15D7dWzIrWFP4rWesDSHORYzyWJaL
 P/0n15COqTiAcI5rPtzwGg/04CLujzBl9QXXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693431124; x=1694035924;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BYCPHnZX4Sg8/q8AG44cDfoIrbw6B5kxbDNfCbbXpzM=;
 b=Rknyh6AniYl+edfUQeec2ClELxdRCwNd+yC1QcIUGaw2yfwJbJtgnhBhLqRdGvW4cl
 LAQvYnrCRwvOtVqUuNoQHoVfCzMvAJ3yfIKmJNa7RYfTvKjqKwhg3wciUHqJyL3XW5La
 rfTTSlu066ShtWvY1SkO4txz8LLcCuay12mLLgMgAzJfayt8BR1sSDptSNxwoaYuMgkk
 H+Dn1mWbcDREZZsPJgrg3wPIKQIZ3Fo3U0XKYIA9BIMEttJ8Zvvk2yaLffalJfFOvLnd
 d1AjEXtOg9SrcUprXFCxxnbDtVTmLGnV2jlEmfqXme8Kfv+jHJAR510nLqxyO1rF6a/x
 np0Q==
X-Gm-Message-State: AOJu0YwtG8zRLDvEdSPrm2+LuDOOwMTvFUATjFSxDbbt7+S7FKMVSvvW
 DZuK7AfXfoXZdBIvk0+YINNlzw==
X-Google-Smtp-Source: AGHT+IFYlWQqPRJE2cf9I7Qf6zD/uBH9H+Kck9jl0zszvY5+tMdiyjPlPX/jDn374ivawebFhzfwxg==
X-Received: by 2002:a05:6902:562:b0:d78:15ab:58d3 with SMTP id
 a2-20020a056902056200b00d7815ab58d3mr3620138ybt.0.1693431124057; 
 Wed, 30 Aug 2023 14:32:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-39b1-0d8a-4eb9-f110.res6.spectrum.com.
 [2603:6081:7b00:6400:39b1:d8a:4eb9:f110])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a056902134900b00d712798a09bsm4470ybu.64.2023.08.30.14.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 14:32:02 -0700 (PDT)
Date: Wed, 30 Aug 2023 17:32:00 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>
Subject: Re: [PATCH 04/32] spl: Avoid #ifdef with CONFIG_SPL_SYS_MALLOC
Message-ID: <20230830213200.GI3101304@bill-the-cat>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HGgTtdvZNRglIlvp"
Content-Disposition: inline
In-Reply-To: <20230830180524.315916-5-sjg@chromium.org>
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


--HGgTtdvZNRglIlvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 12:04:35PM -0600, Simon Glass wrote:

> Use IF_ENABLED_INT() to avoid needing to use the preprocessor.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
>  common/spl/spl.c           | 12 ++++++++----
>  include/system-constants.h |  5 ++++-
>  2 files changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 27266b393ea..78db9ef5318 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -754,10 +754,14 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> =20
>  	spl_set_bd();
> =20
> -#if defined(CONFIG_SPL_SYS_MALLOC)
> -	mem_malloc_init(SPL_SYS_MALLOC_START, CONFIG_SPL_SYS_MALLOC_SIZE);
> -	gd->flags |=3D GD_FLG_FULL_MALLOC_INIT;
> -#endif
> +	if (IS_ENABLED(CONFIG_SPL_SYS_MALLOC)) {
> +		ulong size;
> +
> +		size =3D IF_ENABLED_INT(CONFIG_SPL_SYS_MALLOC,
> +				      CONFIG_SPL_SYS_MALLOC_SIZE);
> +		mem_malloc_init(SPL_SYS_MALLOC_START, size);
> +		gd->flags |=3D GD_FLG_FULL_MALLOC_INIT;
> +	}
>  	if (!(gd->flags & GD_FLG_SPL_INIT)) {
>  		if (spl_init())
>  			hang();
> diff --git a/include/system-constants.h b/include/system-constants.h
> index f0a191be590..aa02c48f49d 100644
> --- a/include/system-constants.h
> +++ b/include/system-constants.h
> @@ -24,9 +24,12 @@
>   */
>  #ifdef CONFIG_SPL_HAS_CUSTOM_MALLOC_START
>  #define SPL_SYS_MALLOC_START		CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR
> -#else
> +#elif defined(CONFIG_SPL_BSS_START_ADDR)
>  #define SPL_SYS_MALLOC_START		(CONFIG_SPL_BSS_START_ADDR + \
>  					 CONFIG_SPL_BSS_MAX_SIZE)
> +#else
> +/* feature not enabled: this value avoids compiler errors but is not use=
d */
> +#define SPL_SYS_MALLOC_START	0
>  #endif
> =20
>  #endif

Does this become relevant later?  It decreases, rather than increases
readability of the code to me.

--=20
Tom

--HGgTtdvZNRglIlvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTvtVAACgkQFHw5/5Y0
tywj2wv9GCj5ijy8d+T8g8OQT2djgbBHHsX4+EsOuPYGb18bQi3EVzlUWzMGJw+z
b3yTWdt8kSVlr0dV958FgKKfYofxoWPznp7XHGH4o9wc07RFKPa0rn/i1NiNEGIb
995ajjAXJCe7jYEroclqTRqZIgV5AUYUfkINHfhueoWU0CqTfzFWnMXyn/YFWLlC
MtXqQ/JlTuFKskaA4rYFQKRJE3vFPAXvAk7PhrA7+G7WOZcKVQctBQmbTtDyyUiJ
hYARbUful1Vfo3AAAHId687AyQuk4dUqiG1iMBI47rrbYX7klfnkx5CLEGGiu7lh
vjrrWv4U11PA8CeVmvZnrMG95kcQisvNoA4m1OiyPV+EZIye9cnpQLAFR3djnMxM
pPcQ3n0kxlU4TzcCme15eWxBx2gchl1SMa3wSpww/Z8n6hN21k79K3fruv3OvL+2
uWoNbVpZgMkRfjH1RZGBVM2LFmc6s+UDjA4YQgjvFDk1jcY61FYvPSsvlaoCCU75
ymcIoVh3
=OYmd
-----END PGP SIGNATURE-----

--HGgTtdvZNRglIlvp--
