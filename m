Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92740C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 14:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0583C81FEE;
	Mon, 19 May 2025 16:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XCguZ7PB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C8AB82B53; Mon, 19 May 2025 16:48:33 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596D781E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 16:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-72c3b863b8eso3438694a34.2
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747666110; x=1748270910; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m3gq/zgMCK/qmY3kd31TaF4j9lgDjafujQp3wsou+TM=;
 b=XCguZ7PBTAPogd9oDfdYcWE62agZnYB7p3/aGLGabgEtM6GfBo/oFyA9L0TaI3puSP
 vv09SMeOivQ7LQFMK6URZS4yz7j3M/Qg/BNcwO37CGqNntErMfZ3zIWK2DM0cSO5cMgG
 rR/j6UxIJTti6g0QcG/99uh6Z2qUuqmvp5+7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666110; x=1748270910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m3gq/zgMCK/qmY3kd31TaF4j9lgDjafujQp3wsou+TM=;
 b=Ni98CXyPIJvA4ekMc5o55vf/a8JpAcTlhrIILzvBBQ+lanRjxU6ZE5hPlN1k0U67kT
 6vrKrrr65jnMXzAyzZmKJECUdvegxvaYejsUOMFq0UaTsvxUAEDF+HoghASIY/rbFSNX
 eFPLwHfZpzI6+TS3Wro0lxnz0Yi5OpW1CcfF+OcIlwSMjHs6qSA/9a54kQV9aZqiFl6G
 TWR+kK+UZVZVoXcwLnoD98l4MB3tRojTOU/CO29mXYSAaktcbriGFcAH+SKhVsEyuktw
 mpY56Og/Lj0PaD+paf+SuaMClTk16ORgSxhncFRLKuvvAoTSzejT4qvnrH7Agg2l8XeH
 q2wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9l6YNJu8u4MUuMUZ+JRLsRYsQYS2W4hlVioWKkRqooAX7eKV56lFGuGjtct8u8/SsPgd/Q+w=@lists.denx.de
X-Gm-Message-State: AOJu0YxONGwQWpOzcDSvJNb+fOlPtH/syYChF9AIdYP8PAaQISvnW0E9
 MvuWdkYOaCgzVejpdV6rBwfkl0cH7W6FVZcTD5lUZzV+S+g3D9HEtMpqQBo9z4xiYQk=
X-Gm-Gg: ASbGnctJcAoRjQQ6oiJQ7PXM8D+H3N//ZHJTN9mh+s1vNY5r0MATclhkvcupcumXl8H
 d8JOZAcLErCpZ99RStqpmT/8R/squ+VT9YgMGke35xFV50xdW5p5koG0eQaF0R3qHQYekBC/iWM
 +ihJLpRtMf/4HlrNe4VNzs/hS6UE1Jz0cPTjyxLOOudgVjh1xYpLzsl0a1S3CfRd/NHuKF20YWu
 oaV70vCPksXeoxdU676hv/xAMmycvpVRRxF6GGK5dNIRuSRVIl53dcCHze05YRCwIB2DhSfKX+W
 mp0bZT66XPglsnWETkdvzjAnKPmKm3rEkJMcORG96jYGvz9BVWwy8Fc46qmWtDfnBFXk3tQLh+T
 4kQ+dQHedFN66VswbeUNE5/8=
X-Google-Smtp-Source: AGHT+IHi/6FygJ+Q5Re110UbkVNc07yWumqAedGFIHCaTOXUt/vZOB74Y7++yI2HsJnZOzK3hKx06g==
X-Received: by 2002:a05:6871:a4c7:b0:2d6:6688:a625 with SMTP id
 586e51a60fabf-2e3c1f45c2emr8098504fac.37.1747666109929; 
 Mon, 19 May 2025 07:48:29 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0178134sm1771181fac.0.2025.05.19.07.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:48:29 -0700 (PDT)
Date: Mon, 19 May 2025 08:48:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 2/5] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
Message-ID: <20250519144827.GA3396848@bill-the-cat>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9kWV1S5RQWF1VMnx"
Content-Disposition: inline
In-Reply-To: <20250515-silent_console-v4-2-dec6c8391f01@thaumatec.com>
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


--9kWV1S5RQWF1VMnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 05:55:45PM +0200, Lukasz Czechowski wrote:

> In case DEBUG UART is not used, define dummy macros replacing
> the actual function implementations that will not be available.
> This allows to compile code and avoid linker errors.
> Redefine the DEBUG_UART_FUNCS macro if DEBUG UART is not available,
> to avoid compilation errors.
>=20
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

After looking over the current state of the whole thread, this makes
sense to me as-is.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--9kWV1S5RQWF1VMnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgrRLcACgkQFHw5/5Y0
tyxFvgv/ZT7PBXo0LUzNWFSskUqxklgeg0cHifDwRh5CdQzZMwpTFPkoIrcus3IV
MoqJQ5a3T0lz4RLTdkUU2O2GvdT/pA2mUQq2VF1PoCTNbku7dioldOIsHfvqOlGh
7U00Je/8bUHSlnBVkOJj7xLTjTXfcBiR4xRRMoj/8Q6sKhlgB/vkaYNIQFWgHms/
7RUahWSjb9MMs2YjiTTiuFI79WJ2Auv9ouMUZ2WupH65Vbmtvm6+bc27Qk+KYN29
7qzUqDyz6IdEJSX/wZuhBVG7xQzOje9m5QIZ9LeWxS4wET/zXTK3fpDKw6ub3pNK
jfqKgiaYmNS2xEADHKKQXq4IIaibdDix/VHZxQpFVXGdfbqMkmNOPic20/JoEaNw
YkvG0xCDw467xUWVZwYl1FLCVtJ2rVJg91tNCHac9+cqXHRGttAg5bKikFP+vxlu
q0lOtiIuV8REhDia0rsGaUG2uVwllX1wvde89XiXZGAztR6pZgMsrsY7vYb1jkjn
FRhcsrhY
=KwRo
-----END PGP SIGNATURE-----

--9kWV1S5RQWF1VMnx--
