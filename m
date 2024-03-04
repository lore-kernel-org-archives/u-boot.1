Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A200DC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B9F8813F;
	Mon,  4 Mar 2024 16:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G9S8vYrA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB52F8813F; Mon,  4 Mar 2024 16:28:57 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A7D880A7
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-42ef605f8e5so2934741cf.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566134; x=1710170934; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IOHDWE3u/immNs/NJ2q/N51CabmzM7HOqHq9zrtKjcQ=;
 b=G9S8vYrAohCRbikWLe1mfD6sSPogLzvNnCRKZVu2WxiK6NToeH4FkVUy3PCY4Mv8lR
 Kp8CShqouu4O7ahAkrl7lXHzmWZAV95F6vxAvjpQ8v8hCbnTVKxy6o8A3E+g9YvDauOH
 OX1qE/jDJCfGuTEOr6/jACgltoqkwgDPH4YdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566134; x=1710170934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IOHDWE3u/immNs/NJ2q/N51CabmzM7HOqHq9zrtKjcQ=;
 b=wbBnZtFRbwtatOuXKT5mbaU/tm28XnprbNSnzbHuKkBBKr47MVijR2hhcVmHHaCvSz
 XUS61BMhPuHAmeQs4HFm2dA/K4lg6CdR5VxBBZdzPIsJwTjs2MbePqOAr2+gitKeopBS
 aTLRFoElO6fucXXh303kS0ByMVwvf+7HBNWVrc2dmOpp+5a009bUzo3cGXJ4FwJ6Otoj
 Hjcpn4f5zCiL0P12jgI5sB4exmESt8AM8s6xqGexSOdksPUfUtyuN0Xr0z2AFdiKyqit
 J71DbxYDedhyPeACSXymjNik0joZ1xsmmy7BYogtdqKd3Vv3C7iAI/r9+9109rHPGprh
 De3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTfPeIjFUSefZgWC2ZtSwGVKRhGlZIsqByJLlbtZgeDfrSFDYQQbynVfSeXIY0LtYx5A06WQThClljcye5BqgFkw8uuw==
X-Gm-Message-State: AOJu0YwrSfyLhs6gJr85s5T3so0vRdT+OvMzEfQGWwcBgJHva+ObQZVB
 jXCWXIdb3qbY9KmgnDZvbZsz5Kg8rZlU7HcTQvpdwoM+OND/fisd2kIXpmg2scQ=
X-Google-Smtp-Source: AGHT+IE6rmv6UTobN3ewQXzu/2fZSoliFUq9JDMjX0myctV7dUreXDHNLNLXRKlzGfsOzGwSWxbL1g==
X-Received: by 2002:ac8:5d8a:0:b0:42e:eba2:fac9 with SMTP id
 d10-20020ac85d8a000000b0042eeba2fac9mr5501151qtx.19.1709566134624; 
 Mon, 04 Mar 2024 07:28:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05622a04cd00b0042ed1f20e61sm2895905qtx.24.2024.03.04.07.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:28:54 -0800 (PST)
Date: Mon, 4 Mar 2024 10:28:52 -0500
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] pinctrl: Check pinconfig nodes pre-reloc status
 recursively
Message-ID: <20240304152852.GH1523872@bill-the-cat>
References: <20240217120842.2381465-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VHv5DdbbtDkjdyXm"
Content-Disposition: inline
In-Reply-To: <20240217120842.2381465-1-jonas@kwiboo.se>
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


--VHv5DdbbtDkjdyXm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 12:08:40PM +0000, Jonas Karlman wrote:

> Pinconfig nodes normally bind recursively with PINCTRL_FULL and
> PINCONF_RECURSIVE enabled. However, during U-Boot proper pre-relocation
> any node marked with e.g. bootph-all will not bind unless its parent is
> also marked for pre-reloc.
>=20
>   group1 {
>       pinconf1 {
>           bootph-all;
>       };
>   };
>=20
> This cause the following warning message to be shown during U-Boot
> proper pre-reloc stage on Rockchip devices, e.g on RK3568:
>=20
>   ns16550_serial serial@fe660000: pinctrl_select_state_full: uclass_get_d=
evice_by_phandle_id: err=3D-19
>=20
> and on RK3328:
>=20
>   ns16550_serial serial@ff130000: pinctrl_select_state_full: uclass_get_d=
evice_by_phandle_id: err=3D-19
>=20
> Check pinconfig nodes pre-reloc status recursively to fix this and to
> make pinconfig_post_bind work same at both U-Boot proper pre-reloc and
> at TPL/SPL stage.
>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied to u-boot/next, thanks!

--=20
Tom

--VHv5DdbbtDkjdyXm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6LQACgkQFHw5/5Y0
tywQLQwApmOW8hLGy5GjhLPpmMk0vvpITJzzmnKMoiwejVWDtV8ieX7f6u0+QXfh
WKw+ypMNmLxClEDsjDg2Zjl3eKr/iTYLBngIDQ8YPKdZQNAJIrvIFqLY/JYkUvUV
dAVHv+CXo8JTboAs1oA4HOrocO8Y6FnnbIKNffjjZSIvn0r2qgqDu8PlwC6eqg2+
a8upvIyGlTg3v+hEL4fQ2z6a0qZfztcV6Ujni2+s5BtNJdAJrUJZ59SdojrStZK2
YDmamXzsc8ETyobKscrnO7yK3hM1rGDNaUUOLyUFH82TtEMv+vTKG99xS0Y9oVBy
p58dvbG6CX02RQ2jqbnSWij1OfbQA25Eq9OAJOPvjfPmr+TVRIt4Hk52tXaMTLV6
v2kM3uIasx4zcfPI6SeBGr/6JMg7sX2l1pn5hJsFPfh3qdeDFCZqeqXLhFnAFeZ1
3h4K7gITefDglFzsEkI7Ke6wynYjadllClbJpkfHqfDYp9lVB9Q4vVyUTLhnbRi5
BMEzYSIi
=xWaB
-----END PGP SIGNATURE-----

--VHv5DdbbtDkjdyXm--
