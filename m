Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB464C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:47:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FDEB87A99;
	Fri, 12 Jan 2024 14:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="d3aPPkO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E03C987A9F; Fri, 12 Jan 2024 14:46:26 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2CA887A98
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5f15a1052b3so60711207b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067183; x=1705671983; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SLoSF6z/1hwPpnzTBVbwB8ne9/Sysp42emvroEYxTww=;
 b=d3aPPkO+jrEWmTFHvpMDK5jv/dUUnSlq36gmncCUl/TYpEwPCAtdnxZT3GYwEvwy5t
 fYGAfiUKJyjcLl3vGDUWtCX2e4VOgDd6D+vVnUpfE06HuTDWvnpP/Z3E8vMtw/5DyRHa
 D4tDGc4IfjErm/X9pauIDRcUf4yJQwKAjJ+08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067183; x=1705671983;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SLoSF6z/1hwPpnzTBVbwB8ne9/Sysp42emvroEYxTww=;
 b=puIg2c+AXwP1cgnItVY30qpwIS3dm42PoUlnz91tThyam+Xj7FLmDpXQGXdFyqF9R/
 Deczvra0IKySQkZqRFa8j99Noc58C3Ho41ackjOlh2HaKTj59VtSBkNL3AWw0LV4nwyc
 xtMr93L7OsLnVU/vMKIWA4hZqrMcZpaP1wvO8NxU7vsAr+7aAkBX5N9BaqTE3h/3Ul6P
 3CdSJl6WrvdLov5qmZRJRBAFsDgkE6VoNPltnp6UxwKfGH2UzO3+rA1xtBsrp1M6vHvC
 HVAnuD/FTMsKxfIsa/DwrnQegUZzyXBce17Y8Fo8x5rE5+a8GCjq5LpHmc1r743qJT0Y
 ACCQ==
X-Gm-Message-State: AOJu0Yzwc1iKRnRHB4gDdSFeQJGKgkw7K4qks8k8ncbc/Jos53yqii3z
 24IpciWGS8TbwwIGo1hx3rjofDUdtvGYkQ==
X-Google-Smtp-Source: AGHT+IH7XACYS6mXHoCSVf6zRk7nGeFWJCDOYf7MOMIB6kF+L6W3rNE16JMG7pYu1/SwNNs6/+z75w==
X-Received: by 2002:a81:9894:0:b0:5f8:cf76:e571 with SMTP id
 p142-20020a819894000000b005f8cf76e571mr1038266ywg.93.1705067183547; 
 Fri, 12 Jan 2024 05:46:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 gr1-20020a05690c448100b005fb4f8256e1sm1171628ywb.96.2024.01.12.05.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:23 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] test: CONFIG_UT_BOOTSTD must depend on CONFIG_BOOTSTD
Message-ID: <20240112134621.GU1610741@bill-the-cat>
References: <20231216154631.87789-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mQ1dU+JPeebDf2dB"
Content-Disposition: inline
In-Reply-To: <20231216154631.87789-1-heinrich.schuchardt@canonical.com>
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


--mQ1dU+JPeebDf2dB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 04:46:31PM +0100, Heinrich Schuchardt wrote:

> Building sandbox_defconfig with
>=20
>     CONFIG_BOOTSTD=3Dn
>     CONFIG_UT_BOOTSTD=3Dy
>=20
> leads to an error
>=20
>     /usr/bin/ld: test/cmd_ut.o:(.data.rel.cmd_ut_sub+0xc0):
>     undefined reference to `do_ut_bootstd'
>=20
> Add the missing dependency.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--mQ1dU+JPeebDf2dB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQq0ACgkQFHw5/5Y0
tywIRQwAoNIdxh6iAfohrVkvSe1B81yu/jDtmSwXqBHhZfVurHeWjsT350AYxWcN
cN4Ppc56N41tswgOYBnkikULsoWDilmX4j+nrmkqSZeSrYxAXKDgf1gGekUuQ0aP
oFkt5ETo++uSzYq/udPBCt2bg72WZEP82N6t41ZbhiiXUxcCv6Md06ErHoC+Un5E
2BHIadGHMmxvsY+zoTR+rTnTfLM6r5RBoO49Bj3kSHSyuH7CDpLggjkK7EEUFize
0CsTgFzTBc6pqeeWlhKWcb2hTlKldYycrCkGWt1l0dzhj752W6dmGqd5l3dMkfzm
qfH478A06OPbP8vV3SzWa6bqX8dy1y/b7Y+yCBpagFNNN/GaMv6dUVsPqCC61WPj
cZnuOxRGj2yrH3qtPNo4dKL13FUNuZfNXMa1nx/I2L7JbLITtxiV3L65sbkdf/3W
mbQ8+xek73qxlHgGqlikkza+nOnA/mEA/vBVdnsDz3Z14blsw2juxiKX1nge+DAl
Uwvsx3YA
=2tWj
-----END PGP SIGNATURE-----

--mQ1dU+JPeebDf2dB--
