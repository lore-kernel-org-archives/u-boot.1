Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B01BC48260
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 23:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38D2E879CC;
	Sun, 11 Feb 2024 00:41:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AjMjOpb5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263B587AEC; Sun, 11 Feb 2024 00:41:22 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90BD8799D
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 00:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78574840242so86372985a.0
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707608478; x=1708213278; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PzpnAr4tVfS15iCSht28fkhCQOO0sXMLTE/IYJnq5+c=;
 b=AjMjOpb5hAAor7Za0x70L7iEJ1JWkV2MYuqrs0L9YOCxLhLE8KF9Jf9uYDfhWojIAu
 +okXAmHXCxUQIIm5UQFwCvbI0bCmqo43sJPneHWBVThOWM/QknZ+tH5MXY6AhuZHi5Dz
 Qi3Do2t6mUNPTRuYegep4f2cUV7cOaLBIG0+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707608478; x=1708213278;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzpnAr4tVfS15iCSht28fkhCQOO0sXMLTE/IYJnq5+c=;
 b=pEoNsg3w7EvdzvbK4nOlfPkDqueQLiu47jgFXqAoleiJgfu/LWogcZz16VxXmZGrTF
 MoF6ZdVGot5ZmdvQ4JztFe2yRm9HA90N172SpoL6dGQoQmmwXTKcXkQDATFhuHeElf7M
 RSegJ1wNtCywKs0+XvISJKeWRVI1NOlvuBtmQA2mFTKvnBo75eZmRjZ6ee2lifBYKEUa
 6Q3zeYlRXch14mk2hoTtX8yfh2ZXjY08BWYENlpMfV1fM47yq9JuDeJRZwYpDjYXgkHh
 xRl1TYywjAXOptz8kFaFBXk4wxrbBjWZIpISriGexTx10gP7H0dqM84uw/Nw5bvd1u+s
 qgZQ==
X-Gm-Message-State: AOJu0Yx4FHADJpyGbYXMPkSNzR9SAwS9ChrnhD6eLLGy0SsanTwdXeqy
 dC+uvwmnNrLtbTsUe3w+A/C7hIOQdP7YOs36SZUrSrJRhuIN293D72YUIX9brsY=
X-Google-Smtp-Source: AGHT+IFNOPRUQvlqBSRaMoo963+30uegIpWFoMiCAX8B2C7cyCTP4lYml3avV2EGsErQO0nYJSUrBA==
X-Received: by 2002:a05:620a:4511:b0:785:3da4:58a5 with SMTP id
 t17-20020a05620a451100b007853da458a5mr4192545qkp.37.1707608478379; 
 Sat, 10 Feb 2024 15:41:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXe7VQAfI6X8HDdfDM9BwIXOjhDW32KYCn6jaL7cilDevA4WbaReC/UCmzHr9XnVkoNS+MxJ36MDy6UtH1IKYB8txfgB0ugPYioW1O3bmwo2K0zdnwhmkpEsZurA+3sD9BB2AYgxLhMbL9sE+IRlwGW0yku43wRVCnuWH6YWhgxexP4LZLhPA2vs49jA5qHFo6rkZZq
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 w25-20020a05620a095900b00785bfd82ba2sm895650qkw.66.2024.02.10.15.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Feb 2024 15:41:17 -0800 (PST)
Date: Sat, 10 Feb 2024 18:41:15 -0500
From: Tom Rini <trini@konsulko.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, massimo.pegorer+oss@gmail.com
Subject: Re: [PATCH] doc: rockchip: Clarify the rkspi image format further
Message-ID: <20240210234115.GA3040305@bill-the-cat>
References: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p3mkKSwnUApbEpBg"
Content-Disposition: inline
In-Reply-To: <cd0b002cacfd40ac294b1583c1769718e94e869f.1707588872.git.dsimic@manjaro.org>
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


--p3mkKSwnUApbEpBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 07:18:10PM +0100, Dragan Simic wrote:

> As discussed on the U-Boot mailing list, [1][2] only some Rockchip SoCs
> suffer from a bug in their BROMs that requires a specific format for their
> SPI images, which was the reason for the rkspi format to be introduced.
>=20
> Improve the description of the rkspi format a bit to mention this, for
> future reference and to make understanding it easier.
>=20
> [1] https://lore.kernel.org/u-boot/c32129ba-db25-4b9d-9a4a-032d88dfb9cd@k=
wiboo.se/
> [2] https://lore.kernel.org/u-boot/CACdvmAjfCWicRd=3DLKKyob7fZo79AFkUQKy0=
e1HBb0zyJuoO70g@mail.gmail.com/
>=20
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  doc/README.rockchip | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Can we please convert this content to rst under doc/board/rockchip/ then
enhance it?

--=20
Tom

--p3mkKSwnUApbEpBg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXICZgACgkQFHw5/5Y0
tyzqjgv/fd5Wttf3ooiY6KiefO+xmqZ6Cb7qe3PA9ftPQGBxzy55zXWyTC/PvDcK
sivKqpP1aB5IqzKOB/ZmUtmFj2eZe0J8/7z7a3+0F/yQ8QcJZE72D9tNFFDjakSg
0ZE9DGuryuTOmkSQbKpIYw/IxfJy1oCBh9fQTVswv/AOF49TSLoBVXguz7mNOskj
WiJfe81xGUkase41wqEzslYXT6hGGGaMOIIewEGVBHhM+UnCmrGxmkGjq2+YivXV
v5r0emn84FQ25sE96FF8HqtApIR7G60fw+y63BbvJ/tSfKZEokoJGkHqCXCwCJSA
M2hnIUViNHF1la7+MYsg911r+eCyX/KP5afYN3JZdZFqoWvflbbgQpKGhYdWIuWG
k+takgYmVRmFv0OO651B7q5uiOLmf4ntz77fRo0uYf/dCfV4mAWAfBzLCGKhN5TA
e/HH9+lKkpntKAlX0vpHGt4h4RUONOqu2N1qkCXAn4VNNuqbYla8HKIr+ILz+a8/
BjxSDw8Z
=w9SS
-----END PGP SIGNATURE-----

--p3mkKSwnUApbEpBg--
