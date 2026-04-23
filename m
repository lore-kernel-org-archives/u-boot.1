Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0503FF885C
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:09:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CC708435B;
	Sat, 25 Apr 2026 20:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IIf7J8oK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4AB58442A; Sat, 25 Apr 2026 20:09:50 +0200 (CEST)
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com
 [IPv6:2607:f8b0:4864:20::943])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D64A984324
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ua1-x943.google.com with SMTP id
 a1e0cc1a2514c-953ad5a55b7so4866224241.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777140586; x=1777745386; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=69R0NXFf7v36yjPNnVSCE8im1bBPk+1J3ssj/eEed1Q=;
 b=IIf7J8oK54T0+M0bBUgegBGiMAdOuaB1H7SLHFtUog/lrAI8DKUxxme31RJTy1DGjq
 iY9CXXE7Ct2/AJA1r/aSBfFk0GoIOa+q7BeOska/3/JqK1xRSg0n7kag7AvIhsuNwPQL
 UCotREppTTRryqOOojKAPlvCgDIbSic25LrPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140586; x=1777745386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69R0NXFf7v36yjPNnVSCE8im1bBPk+1J3ssj/eEed1Q=;
 b=FETWt52L82Ky1sRHf7VoNtl0G0aqU7VSUvqMq0hxwxS95Y0evSYuDWSw9zmhJmsSnJ
 94PLq300DYF6xTYGGhAd1tH+3wWId1wVyOt7yWNj+jD9tp/1kcdhR/Wi44En+Wjc8Emt
 GquU6RWzhbrKp3nC71akgLjxHkCQcVRAVNArCadeFSTeYJPWqSwox06V4OevlcJOWHhV
 0qh9gt5echwYaoCECuKjA9aC3nFgzbzgf/kBHZZWYcGPuxDadl8I9DjmeybvW9OMESeb
 OQ4C7ppyjQJoukrO2EUjDqSWzyHB5h0B4HBzC6nYBdn1VpflqooyfDntu51PT8KHWAFL
 av+A==
X-Gm-Message-State: AOJu0Yyu/Dy/FDkKMK6XmoOLMumJtH0jkOz5cX7dKTjmuY8XWwV2nfwS
 AFbCE0GQpgo4AYsA3gNJx+JK8IhXEu6BXpgKGAf4u+p7vmGRbr4c9YSNZAYyZgQO2giQpUvXtk+
 iZPSLPmpCNVMY
X-Gm-Gg: AeBDiesvbk5pJZzW0zOEPwAZ+EHO16va9jOs3aIWfc2HIKbQ0jS7Jhyw6x11FtGDiLw
 yjI14KBuEjHl4oTExvDRwM3bPHpvCdqENqIjoZhzrBOfK+5P7orOzBX9USjfP7IkRHSi13GtuW0
 +O0qcDAiFGRqTvGzXUHtZ1BeDndaEYdKleXsVHHaE8KN9ws6ZhwDDzwfix8BnX/fRDv4WwbUxfJ
 IAeDCjupa4qqnntMxkVINlG/kOVuucMjngcABMu9S160WHhF+tuFfSI3Xjp720TEF2octkPKraA
 dMNVXikY3zHXVXr9/0Jl0ZKlxPzFVSypp6GgVqileLm+HKzqAD+kGhzbBfhLLF5s5ezK60mDKFL
 V32+J/hQz+eIftw3U11e0F1Yu/6vt6iSWTrSSd5xxKxVYtD1e8ELq/DTJ+gNe6nXe3857d5UYz7
 DoYXpmZT7xGiTAorWif5379eLJOv8HDEuwQsoQySz29+JyHU9v9hUMqI2IhGrn60sxLizuBDAe0
 A6mZMdMBqXpixHKi11s6V7iS20ONV7LoFPlO3ny2lDX05UkqjpFPgANNjhS+w==
X-Received: by 2002:a05:6870:f215:b0:417:529c:1b20 with SMTP id
 586e51a60fabf-42abeeb0cd2mr16664150fac.0.1776972979493; 
 Thu, 23 Apr 2026 12:36:19 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42feebc3556sm2256006fac.17.2026.04.23.12.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:36:18 -0700 (PDT)
Date: Thu, 23 Apr 2026 13:36:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Dmitrii Sharshakov <d3dx12.xx@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Couple of clang warnings for Rockchip boards
Message-ID: <20260423193616.GI41863@bill-the-cat>
References: <f8f4e639-0e73-4d14-828a-92dbfe5526ba@cherry.de>
 <20260422175116.GF41863@bill-the-cat>
 <8567b07e-61df-4bdc-9309-c8e893da790d@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rQZPO0lh829t9SIg"
Content-Disposition: inline
In-Reply-To: <8567b07e-61df-4bdc-9309-c8e893da790d@cherry.de>
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


--rQZPO0lh829t9SIg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 23, 2026 at 11:04:56AM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 4/22/26 7:51 PM, Tom Rini wrote:
> > On Wed, Apr 22, 2026 at 03:25:55PM +0200, Quentin Schulz wrote:[...]>>
> > Some platforms couldn't be built due to hitting the max TPL
> limit (e.g.
> > > PX30).
> >=20
> > I've also run in to this over the years trying to test clang and having
> > LTO not work, or be very much larger than expected. Just FYI.
> >=20
>=20
> We do document that the image is bigger in
> https://docs.u-boot.org/en/latest/build/clang.html:
>=20
> """
> The biggest problem when trying to compile U-Boot with Clang is that almo=
st
> all archs rely on storing gd in a global register and the Clang 3.5 user
> manual states: =E2=80=9CClang does not support global register variables;=
 this is
> unlikely to be implemented soon because it requires additional LLVM backe=
nd
> support.=E2=80=9D
>=20
> The ARM backend can be instructed not to use the r9 and x18 registers usi=
ng
> -ffixed-r9 or -ffixed-x18 respectively. As global registers themselves are
> not supported inline assembly is needed to get and set the r9 or x18 valu=
e.
> This leads to larger code then strictly necessary, but at least works.
> """
>=20
> so I wasn't surprised (also, TPL on PX30 is *very* close to the limit
> already so much so that adding a printf is sometimes enough to hit that
> limit, making debugging... interesting :) ).

That particular page really needs some updating, it was written forever
ago and is very out of date. I do wonder if there's a more general
clang+SPL problem in that I recall things like SPL for am335x_evm
growing to like 4x the size, which doesn't make that much sense.

--=20
Tom

--rQZPO0lh829t9SIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaep0rQAKCRAr4qD1Cr/k
Cq+dAP9CU1Oclevlee0UVdYxJsrYVQd/TrdxRjsRSgwfriMp/gD/bIS/sVh5SO4D
F8apz1BaWCx+K1Wb3Id8+wRik6vz6gU=
=rDE/
-----END PGP SIGNATURE-----

--rQZPO0lh829t9SIg--
