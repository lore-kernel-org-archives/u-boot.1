Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D4FEDF172
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 14:50:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADF0B82A9E;
	Fri, 13 Feb 2026 15:50:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DSw2mSmV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37CDF83015; Fri, 13 Feb 2026 15:50:06 +0100 (CET)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DC8480B98
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4094b31a037so633986fac.1
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770994203; x=1771599003; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wbwra38uoIkw3ZMjQr4SCzaVv79CBC9jJuY95pqh3js=;
 b=DSw2mSmV2zEnxFrvxigE9UuPcTt2XCgOnEEG1JOTShAJG76Q8gTfuyQD8M3LHYqy2L
 pn0c+Vu6FNqVQ8IW1oI/0Rjlv3NrZ+/QI1pXIk9YSOQobO2Zjvo8ObndV+mO88TxcUGF
 50kVmCHPq9yI9V/tH8uEc9U4vSf5Qyflgvqow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770994203; x=1771599003;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbwra38uoIkw3ZMjQr4SCzaVv79CBC9jJuY95pqh3js=;
 b=WpL40mGEDfjHA8mE0Z75h7rJUY86TGaCHX32uZm8diWepK4Zt+qDs+jN30FVfOVOva
 2apQNiq2ughpoBee8OCwTufvasxXhgGbUVpVJ7J2uxOvdLWjo1wPUjEM5EgA017qW60K
 pVqzSxgPqFcEf4ytM/sweGLeAhioj+w9D07wch397JM14rrArk4ygrZc60DprxzKGJtE
 jd9fNFPrnHjtA0lz6XMDAJhE0Ut3BLq2o68L/HYZAIlKRKXbBqN37u5JXrsgEcjYZa3V
 8SJAP5780GyHFCV7k+Z9nDO7EALxDryOe9CLRR5m7eWvHNjWcChCQ3/01Hj21GaPNm5j
 2uZg==
X-Gm-Message-State: AOJu0YzCJBzx8JAY3dvXKZpPkKqnsK3y8axd0c27Ov/xQqEOvMmi/Jl0
 Vcz6HRB2Q35RtWIX8LiXBvZb9m5tJPFn6FVNyeMULo/NhiPGawRouYg1x06y00ksGEc=
X-Gm-Gg: AZuq6aIMatC+Xdp90lb6NhzWYHz70Bm9NpSufVDeJ2fwc1vDTBOWNivLjWi3TTTl7HU
 f1hMG6iHHI0lMCes3q9Ul4C14dbL69xEgPfO6mV/RXftdIFUFTyRriSCrec0D63jLGvrDzUbJ8E
 2Zg1bd6/6oWx4Wgp8wBsRCL4x8lcQkOuKajkEynnHfnnPaz12zavcT8wMyNl305cju0Ih9oRCpd
 rff+8SqAd1W3gw2fBebt3QTnsXlbynmQQmH3zbP/8KwZSDRrSvDtPvYRGZhbZr4Jylt2U27Kn0x
 nrxyK60a42AQ4YLrEjGeDW6IzamI54JK+ZTKENtfXrUmpfHJhNOgJre4SkiqEvCOasiubKGB/NL
 MYSyo/b0ysIkGPAuhQYQKWeA72mgRFQkqXeQO1YACOz2pnWrpHfMwTbdE9g9JdhHFNPCmjfe7CH
 +HtdDsKOZRKf9dmosOaeiVYbLtZ+bGvLNCN0TkSd+Xln9TICpg6KFlVDRer+8VZDG6v+gia5O4k
 SCY8zpQLPIWHii1Ih/rc/r7nlTulgwdDP8odZse2AAvxCx9/qE=
X-Received: by 2002:a05:6870:e386:b0:3ec:89da:3958 with SMTP id
 586e51a60fabf-40ef42830bamr1235140fac.55.1770994202751; 
 Fri, 13 Feb 2026 06:50:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf16c383sm6636938fac.14.2026.02.13.06.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 06:50:02 -0800 (PST)
Date: Fri, 13 Feb 2026 08:50:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH] menu: Move shortcut-key handling to bootmenu_loop()
Message-ID: <20260213145000.GH2747538@bill-the-cat>
References: <20260213133922.1431006-1-simon.glass@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0fJxAOm/5JyeDX09"
Content-Disposition: inline
In-Reply-To: <20260213133922.1431006-1-simon.glass@canonical.com>
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


--0fJxAOm/5JyeDX09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 13, 2026 at 06:39:09AM -0700, Simon Glass wrote:

> The bootmenu_conv_key() function is shared with expo subsystem for key
> input. Adding alphanumeric-to-BKEY_SHORTCUT conversion there causes expo
> to swallow typed characters instead of inserting them as text, since
> BKEY_SHORTCUT falls in the range that expo treats as a command key
> rather than passing through.
>=20
> Move the shortcut-key detection into bootmenu_loop() where it is
> only used in the bootmenu context.
>=20
> Fixes: 8c986521c3c9 ("cmd: bootmenu: permit to select bootmenu entry with=
 a shortcut")
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--0fJxAOm/5JyeDX09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaY86FwAKCRAr4qD1Cr/k
ClGJAQDaQa5VTeDKN/2gBdTKHgh7RB/UspPTT6lK7e1Ru8NjZgEA3CIh7+xuil4h
QLMJqAnULRPaE65SsSR6NPwZFJ6EdAA=
=3/ve
-----END PGP SIGNATURE-----

--0fJxAOm/5JyeDX09--
