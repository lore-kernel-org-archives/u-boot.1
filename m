Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D08C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 14:51:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4141182E8C;
	Mon, 26 May 2025 16:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r1b2JY9J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BBE082EA3; Mon, 26 May 2025 16:51:34 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4676882A76
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 16:51:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c0b4a038fso1358023a34.0
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748271091; x=1748875891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ntzLAq0XLj6hw6gKdzwwcAZj2DHZYJC/7YXjS9Uj9js=;
 b=r1b2JY9JJzA1NyOb/mpgERiZBbMLFpc7std0w/MyDyn1IGGCsmwUEkh00Wi+yvyy7K
 f3IQLlv4eCDIz/GgdI0bPLH081PSOUl4CVV5gF0Iq8A5Kw3BtG4U9b32lds02L1kHXZv
 9BkgssHez3Nc2fM5KfJblhTYOOWTKnjLuMwcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748271091; x=1748875891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntzLAq0XLj6hw6gKdzwwcAZj2DHZYJC/7YXjS9Uj9js=;
 b=Z/QqTrSK0bwTFGQBZx9WcC5JuhLksfi9ZTl1qAfHAC3kLbyxRSkye9hV4U/UOEstRr
 zilMpIT3V5o1doJx5Hp3QiWPvUr36HCoAK86Mulyep0x0wrWudh8u/t93mZrTlvmUOXm
 5hd0+8VgghmglkhXgNDSwucAFuba2cErGrRKYT/87lKRx4lsWYymtQBCsSPMYkPACHxM
 OwmWdNX5PKvkUPy4vNLJvChEAQ3srBTjpBEvLdHyf3Pj0/brxD+mnhbVf30EJoEzMeod
 ZUwzzmaFwfNBL8uin9PKLeoVXAZViVDX4ZwEK3Os+Duvy4m+uXFQdrk9/VmwOB4O/sDE
 65Zg==
X-Gm-Message-State: AOJu0YwJb0VpMxKcshG34Dp3JU45RJDyLjSyCHCr0JVysc8PkpEFnci1
 4eVTuhylcB/vhqeK6jRJu/SL+DJAZe21jSADBxAajfwFYP6MPF0k3y41WD30hUHkBJ4=
X-Gm-Gg: ASbGncsSbZdUoy3qDenwlLjwL+jBZmr1289NZraqsL8f3rDzFZJFoNRh+t61QNy7qI3
 D3eNq65ieNgs8xyZ5uKqwaNk9dmISg2v1/05eYMOD1PSeP8G2yCv5avgLN9FCOhFvAmmk2KcZZv
 D+WSpTeYSr+d3NmNGxe5UY4Yk+h2ZO+YKkcs/WNUCTeDk5cbxcJnDShPY/AGoAhVOjrNnr8wuUb
 vc+7x5WXm91v6Ul04l8aGijB3Ka9LZPkHlnP+Wh0SfDLkLZnF9NIEcce3S1eBwSiEGr5kL4rKwF
 WG7St/TF0F62XPEWqucj7Gbi54SyMU8I6tA3qGCTMEytGZ+iWU1WRj8fM0Rnp1Ccq1QTxBxZ00e
 lVRkH7Iq9/Vkw
X-Google-Smtp-Source: AGHT+IEZt7iaIdzZeMcMDq6rKdgoxQ6j+GY22pE2DTgp0I6wnor12bWX11je112wm1eniiCqgsQNfA==
X-Received: by 2002:a05:6830:6997:b0:727:39d7:b0d5 with SMTP id
 46e09a7af769-7355cf52423mr5974725a34.15.1748271090970; 
 Mon, 26 May 2025 07:51:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a9a53csm4027611a34.29.2025.05.26.07.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 07:51:30 -0700 (PDT)
Date: Mon, 26 May 2025 08:51:28 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: Booting distros in CI
Message-ID: <20250526145128.GW100073@bill-the-cat>
References: <CAFLszTjtw8s2NnrS+B6-K8i_YF0ZGU9JB+O_vNYmT+AD7Km_AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T+advAfPG41QexGa"
Content-Disposition: inline
In-Reply-To: <CAFLszTjtw8s2NnrS+B6-K8i_YF0ZGU9JB+O_vNYmT+AD7Km_AA@mail.gmail.com>
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


--T+advAfPG41QexGa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 03:10:49PM +0100, Simon Glass wrote:

> Hi Tom,
>=20
> What do you think about having a Linux distro in the docker image so
> we could run a 'boot' test in CI without needing my lab?
>=20
> Alpine Linux has an image which is about 250MB.

I did say we should be doing this in some other thread we had, so yes, I
think it's a good concept. Ilias I believe has been telling me about
some HTTP (or HTTPS) boot pipeline Linaro has for a while, and with
Adriano's patch to add a simple web server to CI too, yes, a pytest
doing that would be a good next step forward. I'm sure we can find some
sufficient and small stock images to fetch and use.

--=20
Tom

--T+advAfPG41QexGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg0f/AACgkQFHw5/5Y0
tyyohQv/fuaO0izaa5nvN3luC5O02bebg+0XJAVe5PWLnww7Z4oFV8B5xXOl1sNi
+JP7hmlQRenL9cBtnAMKltICR4o4lEVtj0aao1ewB72xFbfloSzPxwZNQ/knajk0
KyF+WmoaV899krsWvaLFaYnXmxISI/tYAXTsgD1Qyrn36u2Oc24H/Z2TK+9Hqx3R
YFC4AnyhJIM8CLMjPUeV2FgT27aWhWPw5q2XPgmwdKbyR26JrNwy30g3xtKxhR/8
qf3VcfWDiLZiO51dylf/za2yltXSqxUnu1vJ4R1MOym6BMjv8OTQASbKb+764o4O
eSPIUjapsdRISO0JRDpYL66nMNfBb+t0+ai77Q3VriRdRrj2oU7MDIW3yK9x3MFz
nQaAkK5QXpmev15+vULC5oVCE1uUWRC/fAFK7V/2BT1SAr4xtm08UmRkLz12KqFm
0LUqKRNRMNf75cR97qjeaL0Q8xCwqe3hvHZeBwqbMYCeC0/mFWQhSSz3Q2rgjJCP
UKMk9flZ
=ERVU
-----END PGP SIGNATURE-----

--T+advAfPG41QexGa--
