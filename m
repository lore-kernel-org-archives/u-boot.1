Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F04BC3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 14:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F35C58006D;
	Fri, 16 May 2025 16:58:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PxbbSuaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0BE8059D; Fri, 16 May 2025 16:58:37 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BA6780050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 16:58:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2dfe2913a4bso102517fac.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 07:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747407514; x=1748012314; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7MIQfGQ7hJM2uC2xDYJaVl2LDIbf9h3g0iGWuvXA91Y=;
 b=PxbbSuajBaCTT0r/1SThfWOE5VUqXqmyxVts0bsJ1scYMoZpXJAs570cNgkhPILG7j
 qNIw/dcKWrjO+viulm0U0o4JiQX0BDIn+KeJvdRyYEpcR7a0W7rq00yLd57hq9KQqLta
 gdalawQVtfr3eRYbkTtf5WyXMUZIGFmDnrjOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747407514; x=1748012314;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MIQfGQ7hJM2uC2xDYJaVl2LDIbf9h3g0iGWuvXA91Y=;
 b=JZAX29HCmmvOFZrjOqXuSmYc5HKpc1nagvhdOY5cKqOlXDJrR4kdYdDtZ4j8SF2lxC
 iHMM5of5pwtev+WkcVyy5YinNb2BkpJBXieClfsa5HEd1B7XEfDqeTz2dd9nG/IoG5yF
 khHOQI8NEFgkcfMo++eDax2uP/0FUm8SkIStAkRY+7rFs/K1U3N3de3v053L+ULF803i
 3hqBXP/OKicQUUkN4QTGPvmPfhph6upGRFn6A20T30HElUGZ81Ze3P9ppVu2N1r037/A
 TBT1UXPtJSjCOGPo7s7WXHklCbtFRJrfIcPWdZA9zG+Wws8Uw2PySdsCnVFuB+WlbZvZ
 mXCQ==
X-Gm-Message-State: AOJu0YwVvzdlJtxSd4ihJJyuO0RFqdfysfUxY9UZ0ofC/QdQNnw99SOx
 6pxfGb0m2WCWdzxWwiSxoZuKOlIrG4pRLy9nbAFiSxwcuvRUVI05vLBjuSLzqU4YCEM=
X-Gm-Gg: ASbGncsamcRHTPNfm7A7urGDRko14j3vvDBIbQoyqj77VimqxACLme5NlXFRS8CF1tX
 afmFPEe5K5rMhR2rT0S3xu+4ZMDBmbH3/GRX75hlCwQKuMveAZ+aqDXEt11RTzgKLlFizCTmF/H
 EkBccw1lk6csgJexs9kPldaaKds9C6yx1Islt4Tj/ETHEleFDe27n1VPsXXTpf79xc0YerUpHLZ
 9rUDsf5KEel+xd2dCpCda/kKCry9b2pwad1IAfSexUuW0nWHA1uO0X35W2sJnitiLqebO1dbkbx
 5xn8ut9cCYrAX1ueSUyAweJAGc53gJExzvi7hVXRS3lVuIu216C0erHXDDTgMCkHtN5k8eA/Ver
 TOYaYHw/e6j+H
X-Google-Smtp-Source: AGHT+IF1Z60qBQVwLXk8GJpfKquV0k3alJKNgEkFM9FiWrgiJBxbkeymWjcDRTOooHoR6J5OQde46g==
X-Received: by 2002:a05:6870:2f13:b0:2bd:456c:92a with SMTP id
 586e51a60fabf-2e3c8209afdmr1585722fac.10.1747407513819; 
 Fri, 16 May 2025 07:58:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-609f3031f29sm397807eaf.36.2025.05.16.07.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 07:58:32 -0700 (PDT)
Date: Fri, 16 May 2025 08:58:30 -0600
From: Tom Rini <trini@konsulko.com>
To: ant.v.moryakov@gmail.com
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] scripts: kconfig: fix deref after null in menu.c
Message-ID: <20250516145830.GH100073@bill-the-cat>
References: <20250516145611.67022-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wAZSiPFeimQ1PIao"
Content-Disposition: inline
In-Reply-To: <20250516145611.67022-1-ant.v.moryakov@gmail.com>
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


--wAZSiPFeimQ1PIao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 05:56:11PM +0300, ant.v.moryakov@gmail.com wrote:

> From: Anton Moryakov <ant.v.moryakov@gmail.com>
>=20
> Static analyzer detected a potential NULL pointer dereference when 'sym'
> pointer is passed to for_all_prompts() and other functions after being
> checked for NULL earlier in the function.
>=20
> The issue could occur when called from gstr get_relations_str() with
> NULL symbol pointer.
>=20
> Changes made:
> 1. Added early return if sym is NULL or has no name
> 2. Added NULL checks before all sym pointer dereferences
> 3. Maintained existing functionality for valid symbols
>=20
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  scripts/kconfig/menu.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Since this comes from the linux kernel, please see if it's a problem
there still (and report it please) or backport the fix, thanks.

--=20
Tom

--wAZSiPFeimQ1PIao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgnUpEACgkQFHw5/5Y0
tyyWvQwAjTw4EUbFxUsZpIOH4ZRJFfcFtSttjv2ipDlMgeuAeePGjX98rTXbvhm7
EO5Q1qtVdsBCIbHP3dwGa8ZcKmL/FU9f5yN8ZK+sjUpDmNJh2GAgP3S/W4hEmE/k
ZiBF2OhMtk3J3Afmqy4TMTPXI3fP/FZhbx6tcdZXLgQWEv/XOzoXeoCwnflc1p+Z
Bq7MJmvBBcsk3oQWQ7SpaZVabbR9Z1LUuXz/TwBx3SXlh6WwH5CZsYAj2vKcUAZg
AbfNdHO0COIuJwthqCCf+t/Ph2KzT4Qnmi1PWeGFjZUAGiZLCamcnBqI2vF5B7ZT
KwwEUJr2twKgIa27BInLFsvVM8EDyFnh1gtCbINjRS6FfajviyAZt593LGUDCHt4
P5+KpXTUHplv/cOeWm+pWMbyKagFfbdRyGV6nANdOpja5vKxedPsWYNrPhKbwmVa
3FCU8FZKS/Ntt/NvFUhv5GjWFioCUMru7D448CJZN7aon9BdQFBR3KoxJ7/2kgQx
eTS1+qKX
=zctp
-----END PGP SIGNATURE-----

--wAZSiPFeimQ1PIao--
