Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E1AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 12:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D082286FED;
	Thu,  9 Nov 2023 13:53:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VY/+jFoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE99087108; Thu,  9 Nov 2023 13:53:50 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C138B86F7E
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 13:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7789aed0e46so53797585a.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699534427; x=1700139227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CVq2vrqz/XVntNMNQ+NpAohUQUb0P+xsy1GjUTcOYMU=;
 b=VY/+jFoh5unTXezKArae0mczhH+tDmuXqt9pHyWJ3Y6To6UlmScpKim8j+XpoTgUol
 BAllFQamk7U0S8K2l+qhoHn9n6g9D/UjiAlj3Uf20Dp1IOFHGVUzx+VVH3RW+1AtB1TJ
 IVeSA2sHz1/N6Ck9O3E+8qQmkNL+5bprtnPbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699534427; x=1700139227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CVq2vrqz/XVntNMNQ+NpAohUQUb0P+xsy1GjUTcOYMU=;
 b=ijLU/k7iGODLFUZVn17hmHhqZ4NXKLuBX6ZBHLbXtUlkFYrkywXSAgxLgbpGWDuix1
 owG1JBVOJdoxk85rxoK6qsLF3l8w8oklkkf/6W1YFGttiDNgJQKNQ9gBt1lBY1jal6J1
 z4puoD3c8pJIcxopP4B5FHxTv38q2UUUfqZL/Zxc9wqpmAZPrt/zuPg+kEWqfzqf3IVS
 JOgxubeK7KqCj5aMXZ6G5ighoZqR7dvoWY6HzvBe72UBauvljZ1tklvei8hX7XH6+LJd
 G8vVfq++aV5SLriAm0w01lKBeNQgHRike7EPecRun2or0gFEyoUeBdTerGIJDH/5e+Hy
 JLtg==
X-Gm-Message-State: AOJu0YxGmQBIK1sPhXAXyKO8Bx7hmsino8eAs6UUf5lO9WhYswmKXGlu
 Wq3lcmq50Knv6mZ7D3bh4p/lIw==
X-Google-Smtp-Source: AGHT+IH41i7Syedt5eYWScYqPe5qAm+gAxzPno87LmfFFKXIst2qtT52xR2yOwoT4l3FdISOQhB+Xw==
X-Received: by 2002:a05:620a:46ac:b0:777:659d:7fcb with SMTP id
 bq44-20020a05620a46ac00b00777659d7fcbmr5082322qkb.36.1699534427441; 
 Thu, 09 Nov 2023 04:53:47 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-58a3-ea36-c2a1-60cb.res6.spectrum.com.
 [2603:6081:7b00:6400:58a3:ea36:c2a1:60cb])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a05620a24cc00b007770673e757sm1978186qkn.94.2023.11.09.04.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Nov 2023 04:53:46 -0800 (PST)
Date: Thu, 9 Nov 2023 07:53:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Dzmitry Sankouski <dsankouski@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] board: samsung: Remove incorrect SYS_CONFIG_NAME in
 axy17lte Kconfig
Message-ID: <20231109125345.GA6601@bill-the-cat>
References: <20231020184253.21915-1-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hHTHoHoExPrFhX+M"
Content-Disposition: inline
In-Reply-To: <20231020184253.21915-1-semen.protsenko@linaro.org>
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


--hHTHoHoExPrFhX+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 01:42:53PM -0500, Sam Protsenko wrote:

> The global SYS_CONFIG_NAME in axy17lte Kconfig overrides SYS_CONFIG_NAME
> for all boards specified after this line in
> arch/arm/mach-exynos/Kconfig:
>=20
>     source "board/samsung/axy17lte/Kconfig"
>=20
> Right now it's the last 'source' line there, so the issue is not
> reproducible. But once some board is moved or added after this line the
> next build error will happen:

Good spotting on this one.

[snip]
> diff --git a/board/samsung/axy17lte/Kconfig b/board/samsung/axy17lte/Kcon=
fig
> index a018547ff5d4..209394a8a5a8 100644
> --- a/board/samsung/axy17lte/Kconfig
> +++ b/board/samsung/axy17lte/Kconfig
> @@ -1,11 +1,3 @@
> -config SYS_CONFIG_NAME
> -	string "Board configuration name"
> -	default "exynos78x0-common.h"
> -	help
> -	  This option contains information about board configuration name.
> -	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
> -	  will be used for board configuration.
> -
>  if TARGET_A5Y17LTE
>  config SYS_BOARD
>  	default "axy17lte"

But this isn't right as Minkyu points out because SYS_CONFIG_NAME isn't
set for these platforms now. The fix is to do as
board/freescale/lx2160a/Kconfig does for example and have
SYS_CONFIG_NAME under each if TARGET_... stanza, even if we're repeating
the value. It may or may not look cleaner to do:
config SYS_CONFIG_NAME
	default "exynos78x0-common.h" if TARGET_A5Y17LTE || \
		TARGET_A7Y17LTE || TARGET_A3Y17LTE

In the file directly, instead.

--=20
Tom

--hHTHoHoExPrFhX+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVM1lAACgkQFHw5/5Y0
tyw7qQv/VPZ+E5RHcnRGpAi2RIZkLoh6WnDdiG1phoEpc1WJUQPyqtrFH6uJ7Gq2
+sEKlCo+lZzjP98OS0WX5KLMd4jG/1X4FhA3zSF8IEvqxuKjR0di5FmvfomERTwv
EBhEkqomthXwysG0CSGoi1iuC/7UlXQo6st/n7X+mlXx9yhZsd9gm1NcZWPAOu1+
Ddjd/jvd/PVa58/jnlQpWQYIm+1js9jZGRQ6tad2vSToljGLsSUtAU41frWkY/ph
/EUTtHt9r19a3+HPfc1oRcRgmvXlyKEveZbqSClbeFYz6rDZq/StidTQzF3gCfr5
EAQeIE52v8iYHanqCeQqrQipt4ZAEnvN+9p/tF+tYsOrpkh/qb5+0KrbNwmVy5IF
to677ZEGcIboPoB+cKv7ukdvnLX/Pt1Kg6q7AEBV+ibd4jHmW3g3Iy8mqRYMEgPo
9cmmZ/zrxJUumf+NxpPH1XXVYhdI3zPl/O/Hb2g90CiLOSPx9rLJF0rY2h+2azkF
JGGOKx1x
=RZ4k
-----END PGP SIGNATURE-----

--hHTHoHoExPrFhX+M--
