Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C2CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 19:11:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9764F846CF;
	Tue, 19 May 2026 21:11:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XqNfT3Eh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25684846CF; Tue, 19 May 2026 21:11:04 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A297C84659
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 21:11:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479d9b155deso1212792b6e.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779217860; x=1779822660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7tupG069V4ZbjqpZfMajz5SCkhiVCbCa1saec+FAOuI=;
 b=XqNfT3Eh1OCDCOAEHkM7EE2nPNiE8mDXUTgSb87CKpYIbrizPbTFUV7cd4jnDxcpqF
 sthmEMskDfU15Cr2ddez23IBE9b7Zu9C/oa/O95HU1uyz08VzbcMKiVj+X9c2xEuPDDY
 ggvp+fNyoKQ5PB9JTFpQN9eyj1s8R0GBiyUEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779217860; x=1779822660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7tupG069V4ZbjqpZfMajz5SCkhiVCbCa1saec+FAOuI=;
 b=KeXYdIJXdDsgubexDyAClD+OtX48wjUjQRcEc4RW/aCs4lm8DiGdjYzMZojPknwhfZ
 TuHewEBUwgkQDNObWn9M0rVpqjrkvWO8Jx5jyviRbf+s+NETD9Oklvd62xXB/VPeM0cE
 T9EvlTpW8Gn60FkibubW8lBMKTEaP8kY/I/UM3+U3bIg12fwJ19xXZ3z5E/wOm/u402I
 A0jtFgDPTeZqOckMNblmU8C3Cmz9ihlBYnLulzPBiJnQDjpdY5CllemhW+xW9/v1BbZo
 ypgbAfJtxVsttEBzfxQbDRUMfoKB8295PW/ZLaFXMUzwMN5mo+xVeDIJogLc29eIyAbT
 eA/w==
X-Gm-Message-State: AOJu0Ywj2Ka7fm5pNL2oMBVWeT5aoAeQuCHibMHY2QB54YNN63lpcEWJ
 I1r+1JqUtjyL2phktnkK00yyycg3obTHzdvIqnBys+rPBXVcQwPH54ewB/aDCTHBz0hi0OXzp5C
 +Mc0qwd+KdkBk
X-Gm-Gg: Acq92OHMpP6MRqK60+IPSc/PxHLPD2VvcvrHm9evvOVUCkj3SJJzoc+ykEyTRg2jR6r
 82jGpaKRT+kd9JZ3GRivDf8QIkxkkcZ+qk6F/EUGX0uhPTl3wCRXi1n2alhQsVjjSj8n/kmA/23
 s5gVlHEGXQztD7VMOvy2pf2bg+E8Wa0DHmN+ZjlbxAZUhHOb1j+jWsg+Za/Okaf3htoZ3G9Nhba
 DERGs//5m8oNnk+YvFXanMbB8YPsq9MkLpaMKzkWVclN9wBk5ydy1z7x8Z/aPUOs5lIJ8Ct6CjL
 e4UeI0X89MNfGy6wEVSi03+kotUmH4hBrbjWaXz9UTS/4MsEkmrOr5vd1GkqK3cKuu8CXhGD1jr
 jJkc+PmuUErdpdJX7ZMiC/ZiuHOXMf/5xmw2+UULiZdPU8ZJ/OKH7L16ly3nkww7wp+vYYMV2oF
 r6tgKoi/yEV5MVHbxjtw4ZO4Dy/C8rWUBhQds430hMY3DqE1Ov+X8ccYGZXiiQQnC4EivWbEQvs
 /F6XvuNRopVr86zycmk7+M7kz8Yp/P8VYmkSdbSJW6sey6a9x0=
X-Received: by 2002:a05:6808:22a8:b0:479:e7c7:dc71 with SMTP id
 5614622812f47-482e57987e7mr13572231b6e.38.1779217860295; 
 Tue, 19 May 2026 12:11:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee333d00sm7168508b6e.3.2026.05.19.12.10.59
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 12:10:59 -0700 (PDT)
Date: Tue, 19 May 2026 13:10:54 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] event: Guard more of the prototypes with an EVENT
 check
Message-ID: <20260519191054.GE1858239@bill-the-cat>
References: <20260519182856.865924-1-trini@konsulko.com>
 <20260519182856.865924-2-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gwKvvdIqbxudPR3w"
Content-Disposition: inline
In-Reply-To: <20260519182856.865924-2-trini@konsulko.com>
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


--gwKvvdIqbxudPR3w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 12:28:56PM -0600, Tom Rini wrote:

> To make sure we cannot encounter the case where code is written to use
> the event framework, but EVENT is not enabled, guard most of the header
> with a build-time check. This will promote the case in question to a
> build time failure and not a runtime debug issue.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  include/event.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/include/event.h b/include/event.h
> index 3ce5f992b04e..71fb14391f25 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -308,6 +308,7 @@ static inline const char *event_spy_id(struct evspy_i=
nfo *spy)
>  #endif
>  }
> =20
> +#ifdef CONFIG_EVENT
>  /*
>   * It seems that LTO will drop list entries if it decides they are not u=
sed,
>   * although the conditions that cause this are unclear.
> @@ -348,6 +349,7 @@ static inline const char *event_spy_id(struct evspy_i=
nfo *spy)
>  	__used ll_entry_declare(struct evspy_info_simple, \
>  		_type ## _3_ ## _func, \
>  		evspy_info) =3D _ESPY_REC_SIMPLE(_type, _func)
> +#endif
> =20
>  /**
>   * event_register - register a new spy

This was really my v0 of the changes, I have made this more general and
will post a v2, of what I had intended, shortly.

--=20
Tom

--gwKvvdIqbxudPR3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagy1ugAKCRAr4qD1Cr/k
CvbwAQDcGf0qRh/o29Ct16rJbq01VU/yVDKCcy6Ox6nL6DbpqQEAtGu/6ZVKdDcD
uOT/cRG43YWuDVg9a/eA8p1qXQcOfgs=
=oQxf
-----END PGP SIGNATURE-----

--gwKvvdIqbxudPR3w--
