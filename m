Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CBBC07545
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0AC287A42;
	Wed, 25 Oct 2023 01:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AY6MN8KC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F0F186FB9; Wed, 25 Oct 2023 01:17:35 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C33C287A08
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59e88a28b98so2816227b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189440; x=1698794240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8LUHhh48VP8atFtTcluKmkbWx6cTbwvKlw4y3lKfEx0=;
 b=AY6MN8KCRqbY+RtNWGxVWQCUNqVKkUchRX2GxhmpxJRQ3nbzuLrkyjuUheI1FxLx2L
 HsThtZukSxLDo+eo+dINn8tsHI2bBQk4vrzJhz4l27/ACkp7Jk9Gb0XbWGSC9qry3RS4
 wXiIzgNoZXp8NKha9TwnxdPV7SOpXbBbrnTjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189440; x=1698794240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8LUHhh48VP8atFtTcluKmkbWx6cTbwvKlw4y3lKfEx0=;
 b=O4yvkD6JufJwH6RR8RPqxanXia/gqZ/ltG6eNU3V5tMVgPoVQjSGED8+njxE3gfCam
 oWQ3sSBrfEVFTBw7HPI/AxeUSdIMIU3YOy6E60xb4x7VBiyPqWSD1EcWZgrz7Y6VgSRp
 O9EL2Cv8kHfejgShP3tvu3sjvfyNtJtdDe2TB2kuYKpQ05RyLdWPSQgenhLL7bSd56HO
 NYAZRFkLHZrBNXytsyu6oAAlIdnI+y9zwRqMkQzsIvvpNYuP4wN7CW2i9jMI+eZZpXnT
 le2jxElpYDHBrVDPgXggPZuefIkAsFpucl/fdnyRgkaXOFxac4t4IUOksJ2pFGpMTugT
 zptg==
X-Gm-Message-State: AOJu0Yz8+Ez0rSoM+8q0V9ZoJL9aXx8hdHCXTqGn7kZYF5QMptzxQtcF
 SHq7vxsPyYXfKRKv/gLPrg3qIA==
X-Google-Smtp-Source: AGHT+IGNGpkHjCWvmsljh7zO4QidxOEAL2m/ggQ8DKeIjr5txFaZ0TVxZYf8rAs84fez7wM91KiR6w==
X-Received: by 2002:a0d:cc48:0:b0:5a7:fcaf:c1c0 with SMTP id
 o69-20020a0dcc48000000b005a7fcafc1c0mr15432477ywd.8.1698189440497; 
 Tue, 24 Oct 2023 16:17:20 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 o188-20020a8173c5000000b005a7dd6b7eefsm4471625ywc.66.2023.10.24.16.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:17:20 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:17:18 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] test: dm: add SCMI power domain protocol test
Message-ID: <20231024231718.GI496310@bill-the-cat>
References: <20231016053946.470458-1-takahiro.akashi@linaro.org>
 <20231016053946.470458-5-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dVSXa0GaXkz+mrfJ"
Content-Disposition: inline
In-Reply-To: <20231016053946.470458-5-takahiro.akashi@linaro.org>
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


--dVSXa0GaXkz+mrfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 02:39:46PM +0900, AKASHI Takahiro wrote:

> This ut has tests for the SCMI power domain protocol as well as DM
> interfaces for power domain devices.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--dVSXa0GaXkz+mrfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UH4ACgkQFHw5/5Y0
tywKVAv/YYe5iTdjQSjI7Ecp/4694MSwO7VIpz2mjVITWzwTzYUOJsjcIUdxCgRN
mJm78X0MIQiOaV8iVY5h63A7sA/QAHAvsNdcKdlKXHH7YIbVo6I0DIPq9+Myrk5X
W7Wv21WzkXxNg9iHj3nMCFgZTde9zXYxX9Kj/fvucsaB7T+TmJLhS95z39MVPTlv
hBNCAFxK4CUjpuYO1H8SKmwwWBMYzcc3ZPpsnZTRtT8EL4sU3vdJPyzQ06Q96Xh4
NEVpZSDBjY8iaqOt//F2L7b0vN5/y4oO9nFK4iKh+AjnGgNfsHBhACg52MWRMoP9
4ZnFJACzFI67HfpfZCPP9e5CwUbSBxZHpEwN869PwkPVg/Wh3D7llb8/A6XftED0
Aezn+cQnEgF2jnI0d0wp8crBR9YUmBrdCiXEOdhU6iOScUcyQxHy9a4Jvk7+hcYg
xU8Wh3aWHSKjdAD50ybvnLFFaEC1FAzgb8fkKLYuJ8nhLSUum73+ShqJTivdXXJb
75f2tnft
=38Jw
-----END PGP SIGNATURE-----

--dVSXa0GaXkz+mrfJ--
