Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20864C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 14:19:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85C3881FEE;
	Mon, 19 May 2025 16:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BIX0b9Be";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05F582B0E; Mon, 19 May 2025 16:19:12 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9118C8003E
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 16:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c2ada8264aso2100924fac.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747664349; x=1748269149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHJKbB6OrRN+pWzlUx60YBhWxswLaK5gSzv983Xllwc=;
 b=BIX0b9BevsnuBlZ3Mx8LFrVHdzX7h4qvecKggbthp3S1O9A2RPC/H64Polx4yOf/rl
 cZvYPSbgxeJCEI/ogKk/wQACUPNy2nQODkba4ZiNMyR4d5/FoTr0EwdU1WKeEtf5XDWd
 E2K12mxrCZQ0KEe7jPbSUW2pOAsGjIYzAHSUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747664349; x=1748269149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZHJKbB6OrRN+pWzlUx60YBhWxswLaK5gSzv983Xllwc=;
 b=PT0bCzvIiv45CCw40XL0lfRGQCaBtCJQvSE+CqxbYoNJdiPckQuAgHK8BIEJn+5XLU
 tFB99/TiXk3fUXJ4ZhNM7XuzaPa88l4P7vACt//7mw+OUWVPNpSCaYjurtByicDs0RsF
 0GK16jmCq/ldTFTIYZYlBx/BJZvAIcmeJq6Xam/WB5A6DZERM0suBLDZcgkEDnecyC5/
 nckhRlFskkHdSnXDSHA96xoyOsQvbRZP2GdIrdXmPKSqwFwjqVVEWLtiqU1zAWlgGCnO
 YelHjUP4//67E0zApkjr/g5LcvtikWDUAagd+aUHJ3s7U2lfrGxHO2C4TqjTaWwwtGLm
 7Qjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWcGuW1Xw3kKp7KzlQinN9Lq2L9jds4nQLtkQZcq3/C0ADr64uL0xJ8FiJZqs576MY5/Heotg=@lists.denx.de
X-Gm-Message-State: AOJu0YxW+4mGXSVhOGbo8HE1S4cCzUB4MeXnj/IdGokpauezVEX7iVFs
 v4g9f1fv8DerN1aajvItJnP6MTuOOAIltuSZTxTVt7l6zswiiPj9ica7LMiNu2UbKn4=
X-Gm-Gg: ASbGncu43Tpc8+Fv+Ge8GlrAPwmLLtDj4nZKVTa7o3bt+f9OvmCZ/PgL5/gwujFkIlA
 F6PGoW2xHQ6owVMlDgh0lJkECI0b4Lyf8XTcVUYVURYqWSstblo7erD8PHZK/pT67k86CvploCB
 z3Lfr6ptNPARsCE2xO56idYvo+OqVetnJA4tenFCPeGFZCEvxAoiTIAtI4ElYwoZyRKe24NZu3q
 nOVb3Xyc6Yre5hWKUg99tkoC8kwSucKtsRGQTj9YCxg/GGtxV44PNFmbdeveseH7gVzgAh9IWFt
 /OUtjhepE6B5PGxs278NAhGJa58PtHwO/MqPK75bEkna7d4h9UxFGVo4PrX45HJ25nKn+ostkQR
 6EUHPb7Ce0e38
X-Google-Smtp-Source: AGHT+IELF2uk5u26iSKW80XE6LNDgeie1DnBMom2mS24jB2SruHWVTusWAM6kx1pOz6bBsW1maqRig==
X-Received: by 2002:a05:6870:1e84:b0:2c2:3fad:760f with SMTP id
 586e51a60fabf-2e3c1f6f15dmr7684401fac.37.1747664348847; 
 Mon, 19 May 2025 07:19:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-734f6a82109sm1425696a34.28.2025.05.19.07.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:19:07 -0700 (PDT)
Date: Mon, 19 May 2025 08:19:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: marek.vasut+renesas@mailbox.org, sjg@chromium.org,
 di.gerasimov@gmail.com, quic_vkarunam@quicinc.com, u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: Flush destination buffer only if it is available
Message-ID: <20250519141905.GO100073@bill-the-cat>
References: <20250519064935.3832233-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jOzwvMb21jyWbp6e"
Content-Disposition: inline
In-Reply-To: <20250519064935.3832233-1-quic_varada@quicinc.com>
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


--jOzwvMb21jyWbp6e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 19, 2025 at 12:19:34PM +0530, Varadarajan Narayanan wrote:

> From: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
>=20
> There are code paths in do_imgextract(), where 'dest' could be zero.
> Hence, avoid cache flush of 'dest' doesn't point to any data buffer.
>=20
> Signed-off-by: Vandhiadevan Karunamoorthy <quic_vkarunam@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  cmd/ximg.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/cmd/ximg.c b/cmd/ximg.c
> index 29d7c3279b3..8907b579d4c 100644
> --- a/cmd/ximg.c
> +++ b/cmd/ximg.c
> @@ -265,7 +265,8 @@ do_imgextract(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>  		puts("OK\n");
>  	}
> =20
> -	flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
> +	if (dest)
> +		flush_cache(dest, ALIGN(len, ARCH_DMA_MINALIGN));
> =20
>  	env_set_hex("fileaddr", data);
>  	env_set_hex("filesize", len);
>=20
> base-commit: 1b5e435102aa29a665119430196cb366ce36a01b

A memory base of 0x0 is valid and not that uncommon, is there more going
on here that lead to this patch?

--=20
Tom

--jOzwvMb21jyWbp6e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrPdUACgkQFHw5/5Y0
tywMbwwAo0vRAgPqgRqpZITvS4fSJPy74JD7xa68VsbmLlHytxiKIHnw+c+RMcYC
B5FaUUgo12ivGnbNPvtWLw4vvMytJeQZUzKCHVhTQe5FzYa22pb+njt2YaQqxUnQ
EgHYRuVVKaSHK9z97Dc+kNOaMPN6Nf7KhKFfjsqOCzjjJm8kLgfe+4zHygvNTALp
mrswLAuY/DP0pk6uGuux00cYdeJKdrpsXSMXYuU2BqJZP9lQdU1rmF195rrXi4eO
HePZ/ci+t1jSAQVLRyyX4kNPrKJjZDpa84taUevP5iaqupufQ8mijVNBfhfl2rho
MaREVKDS80DpDHA3Qf1JyKWEtyPT4OBO5ZLEt/4a/NOvO853r9ZSX1siqkuEC+O2
MgtA2TSAS4Usb4BkWWqY0VcV3S1pkwS5q6kM2aSSbtdQ1gM/INSlADnoOVLX8kmD
yybld3o3/OiqZUUZPjuDm9IOa/7enivTDZ4+Ec0rfHh3GRa8xu87hSCp5XWyufAV
nAPXSLg6
=D+uO
-----END PGP SIGNATURE-----

--jOzwvMb21jyWbp6e--
