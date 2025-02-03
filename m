Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656EDC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 21:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89FCD80087;
	Mon,  3 Feb 2025 22:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="A1qWexH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47365800CF; Mon,  3 Feb 2025 22:48:13 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E3B80050
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 22:48:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7be6fdeee35so776826185a.1
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 13:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738619290; x=1739224090; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FQhWQ/fzVQ3SPZpv00w1j0dCYsiCsd8GJcdKyUQt4zc=;
 b=A1qWexH828m45PnpSoFBGsba0LQHeuLOlEeSZHTAJe5/iC24kp6QdecZ6FP7N8YfKo
 e9YCOSZYNfeBY0E8KbdNgYgJcERQA3xer6/bNwT/KzlYaGC8WuSNpRPplz6GnBi23r+e
 nGmmEH9xAatTubpSilDH1UIWFNJshQAKxKVUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738619290; x=1739224090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQhWQ/fzVQ3SPZpv00w1j0dCYsiCsd8GJcdKyUQt4zc=;
 b=g+RVV2YX1IGVALzy7Whr43lcyomAxPrXDru5t26Ykw4diduTJEFXjkf3vGfa65Zgu8
 PIQxX9qb2Ug9d7gus/e7dPQ95j1ILS7ZE7RmhzMI7WLq3F/8iXWfv9qipl0k+uVCc2pT
 mL6cA0hvEjrblMK0tVirnMpygsUxkjxhLBkEIJRi4eW1RMN9f+YQtPgwqLZcF/CWM93s
 sWxsRRCQ051dxze+ufoH/Rp0JZgLu4eooXNVLqbmSoFaQ4i/ca7ufrFhOnNoxD2XjxoP
 J7Z0JVUXg9y5pz2jyvr2YX5IuLKatGllY0oOTnNDeB4KjlkXCMHMYENuElsnUxVQHDGY
 fP0A==
X-Gm-Message-State: AOJu0YxC7vL4D/m1N5VpS0xm27suRxdHx4wjgypddQP9pBVqfvvWV82I
 hPctnbcoPoTTYBzGX3xpNdB2isChP+xhwgJAAEEXH6eg+gzC7Raoj5jfYCVnR6c=
X-Gm-Gg: ASbGncuQ1cHs9AgbvBYs7SMJsE95JglSiNa10to6Tt5r6zNGkwj5toySD7w8guMrfQ4
 VEO5yBcZT6/gSXLxqgtxkUM5xZuvDneSsA6cql8gH5JO5GuBtzzeZQMhp22F7SNeceUaCIhvPx5
 I294Jab7mizcZrSZcxnATv11TjgBVb6x2tBq5WhnPzmULJ0C2er3n5D7WES9HiB3FNbvfrtcDTT
 mtweS6abzebqjN26QrgAzml6PdMfw27WKhCCVPL/FD/3UK7O1BxzE3CY+XE98zKKpw8HIVGaiQ0
 tz4OJm9Efxcr3+s=
X-Google-Smtp-Source: AGHT+IHpKiuGRz3zLo2vCgqauH/pIFaEjXPwaxDnsVpKYt2kFqAJtQKIEvehNj1Ex/GhKW0/oj/7rQ==
X-Received: by 2002:a05:620a:c4a:b0:7bd:bafc:32a8 with SMTP id
 af79cd13be357-7bffcce0b74mr2612090585a.24.1738619289970; 
 Mon, 03 Feb 2025 13:48:09 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8c8f3asm570457585a.34.2025.02.03.13.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 13:48:09 -0800 (PST)
Date: Mon, 3 Feb 2025 15:48:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] scripts: Fix potential null-deref
Message-ID: <20250203214805.GZ1233568@bill-the-cat>
References: <20250203165008.4088496-1-maks.mishinFZ@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Sq7+POaE8z0EHlzB"
Content-Disposition: inline
In-Reply-To: <20250203165008.4088496-1-maks.mishinFZ@gmail.com>
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


--Sq7+POaE8z0EHlzB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 07:50:08PM +0300, Maks Mishin wrote:

> After having been compared to a NULL value at menu.c:799,=20
> pointer 'sym' is dereferenced at menu.c:812.
>=20
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  scripts/kconfig/menu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/kconfig/menu.c b/scripts/kconfig/menu.c
> index 0fe7f3255a..c823719dfd 100644
> --- a/scripts/kconfig/menu.c
> +++ b/scripts/kconfig/menu.c
> @@ -809,8 +809,10 @@ static void get_symbol_str(struct gstr *r, struct sy=
mbol *sym,
>  			}
>  		}
>  	}
> -	for_all_prompts(sym, prop)
> -		get_prompt_str(r, prop, head);
> +	if (sym) {
> +		for_all_prompts(sym, prop)
> +			get_prompt_str(r, prop, head);
> +	}
> =20
>  	prop =3D get_symbol_prop(sym);
>  	if (prop) {

Has this been fixed already in the Linux Kernel, where we get this code
=66rom? Thanks.

--=20
Tom

--Sq7+POaE8z0EHlzB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehOY4ACgkQFHw5/5Y0
tywKEwv/ffoQkACelg9zSAqO3gEuJSFqKPU8fB00xnqRydHvZBAteLT6XNRgSTbb
2mcVj0uLqtE25JRsAJtrO1XKfREXAnV9rtZgH08I+Rf+Xvm9QW+sqvc6V3GK2HTH
Q9QicgojZFLYrj3cbqKQb0X+aTw/jxv++0eZEFYibESkoM8w9hVnZ9Fl0rkK2Wq6
Ybg3g7FBRP1Vlr1ahwdvS4k/mGU1ESw/JbnDXj2vQLXRiDbRVlmznNIDAorHsmBs
gG3ZAdKASNvuP/jLHxzGCsxH5jj5436HbX5eh9lv2uD5MQU7PO+GdNIm207N2Ygd
ts45MqFiFHKZovRegnJfZUKdBhTR14Zx2dZtzeCLrQ0WAOi9Ba9/XRWpT40Y1Qmh
jp0+rv/pv86RQh4rpfPsBN4zoY/m74HUN9UCBwDAdPuufLEFp3lu6xt4XrO+Nu9C
op9vyS1So51l5xPk9tLpRr+dzF0+UxBj3n1eHspMQpi88/6tas8CAmPVnk5FLLtm
5A42EB4m
=McZv
-----END PGP SIGNATURE-----

--Sq7+POaE8z0EHlzB--
