Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FA0E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 15:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1EB98031E;
	Wed, 18 Dec 2024 16:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ub4QSCN8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 332DD802B4; Wed, 18 Dec 2024 16:48:10 +0100 (CET)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 074AD8022B
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 16:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b6c3629816so292346885a.1
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 07:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734536887; x=1735141687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E1HzaV6Au22vNxjTgzSz7wSPLd+fKSGaURCzrLZupz8=;
 b=ub4QSCN8hwMJN2OMgpRlJPhWmqTwSwfjblaQi7uC6cqcq9LRANrDZ5qmMtuUha0i1a
 oOAfvqNMMQlVPiulWqKpdIVpvSv80LvZGoxeVcPn+zXO3BMpC6ZTLmKCP1ivCn0b+0HH
 y3ItFmKZlq/4l+CP8/kQBzCcPqHhT2goO2bnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734536887; x=1735141687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1HzaV6Au22vNxjTgzSz7wSPLd+fKSGaURCzrLZupz8=;
 b=sluR5+YrnI6ddtfAT67+Bp0tMwdN8Cls9+choAfSUL1i5ZklKFokcfs8ha9ufXYBwE
 XOexf/9HZvrhwhXaVV6H3fgecjq67XeJ5M2jFUQD1nFx3DvwT3a2TTZ4Knt2LPeWdxJb
 wzaGTqa8Ggi0wyyamTmb46oAcVtzS0PX/k9oUdMAJcL7sfQKa8qj34eMsHs+SX8zlHAN
 zYyDvsCMzb4po4JWwuvfTshRKt/0zRp6kzI4vdFppMJwyKro48eOXMfE07ttfOdlnudz
 YQMtQ+4FX+bSr2C+ca5iTzDAWauoM9kVwoajYE4lDLMYWhapztL+Hl4UYp7doU0q4kha
 dcYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP3gQGgeuLUFmsM0O+5kgCP5ZvuztluFeJXAm/ZRuDSLw5Sie31rkZWbQC4CO2Gkee8cc5p68=@lists.denx.de
X-Gm-Message-State: AOJu0YxIiqFoq6pOxn42cx9urcKmL8BjP6Sc7ih4f/3R0hFV3JiMjVsh
 BiheF9CVkDVuYOuZXev98STvnWnfAuTk61Z6Hn1Ngi5M/RaPtkMyhHgXwWyb+Of4W7cZ9twOoZ6
 m
X-Gm-Gg: ASbGncufhKprWAdFwlpu8CbYphb9wKK9VmavnEWM+ackiB97OwtbcxsbjZI22ECOW6B
 N60gqMtVvgTw/HE807m9zQGEwa+2RlmyGpbaeN1J8x+ZfWFPMo+wdWXUKBMti2Iv/YRp6BJ9Zr5
 Wxyzl/444zWr3ZcuVUYhfKfj4haWkHRBKNC90iMiZjqUL1w1CC5AnjstGiRTM0EIcyFEfrKVKbT
 S9jsYV1rgBTUytM04zemutMX7++siLrns6LkBw9wdRrZ+imzQ5TbE7Z
X-Google-Smtp-Source: AGHT+IGYQz48qR1RNomq7Wgzko/7TL8KjDbKYIdS6lE3yRrG7yU94iSiWcs9nKjIVOUYH6c6rPztYg==
X-Received: by 2002:a05:6214:2263:b0:6d8:d5f6:8c72 with SMTP id
 6a1803df08f44-6dd091c8f5bmr61553916d6.19.1734536886929; 
 Wed, 18 Dec 2024 07:48:06 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd22f284sm51192736d6.24.2024.12.18.07.48.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 07:48:06 -0800 (PST)
Date: Wed, 18 Dec 2024 09:48:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/4] bloblist: fix typo in code comments
Message-ID: <20241218154803.GE1505244@bill-the-cat>
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-2-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q/XlrQllRZwbFccM"
Content-Disposition: inline
In-Reply-To: <20241218153933.37649-2-harrison.mutai@arm.com>
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


--Q/XlrQllRZwbFccM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 03:39:28PM +0000, Harrison Mutai wrote:

> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> ---
>  common/Kconfig     | 2 +-
>  include/bloblist.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Please add a short commit message body "Fix the two typos in ...",
thanks. With that:

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Q/XlrQllRZwbFccM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdi7rMACgkQFHw5/5Y0
tyw/RQv/XKiXiKunbpFseEW3yPhrYbbWtfwHIfxPGjgmjLxKlv/VgucBMEmgA/N6
4upDhnqP0nn9g4967HZ1YGeXWKQygdv0+IYOvnIK/P0Nb3fXwtcm0a5u9sFUjtSo
YrtAd9O6T0vx9nwhkL+Kvp7zxFJPI/NMj9aPO/f3P6OpLi3efIrYPjKVvPDUSIo2
omEhFjZqKASkZK/lpQvgvu/8NziaDwv7trQ16FzIfaImkDGqtFvDUu9RH/i0KIL5
cJvE3EnhOFCj8VcJmZ21BJT46vJGnZl41lTrnOsoOQ17wauvH+bv52zC1E/OgKdo
vrD1G0v2VDd3Ux/mTKHJUKXeclmTHn8rUO5kNivfQ7jeli5F3e9JZarcHY4G1h8f
v48ndNr82PgJ+1bxrUUKIEU/yVlrocqmqOUOJsUCdxanNY79NCL4M7fz+UijX+j8
hZ6Ifk29AlXgiijCGPmPrV8Rm4oLC9KS7ZzxLqx0xzQh2PQRZ3QlGcJgSwi+VJSe
UnnBPB51
=HIY9
-----END PGP SIGNATURE-----

--Q/XlrQllRZwbFccM--
