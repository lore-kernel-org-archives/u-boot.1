Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F772F47CA6
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 18:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0A3383E81;
	Thu,  5 Mar 2026 19:07:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hY2hvCgZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA69083F2D; Thu,  5 Mar 2026 19:07:26 +0100 (CET)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C361E839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 19:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4648447e29bso3367477b6e.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 10:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772734043; x=1773338843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fQ1ETp7v5/LPcFCofo2J8UViolpWM7LyaOxmKzsu53s=;
 b=hY2hvCgZAkwSiRDnwv+7uvuZYnzsATWCd4jn0w3lr7PPcmMFOTcktWHpwz/h3uSfYi
 Ny3LGRLSdRel4j+wgOyYgb1leOsX00tg6uBmVN/edr98jIbeEQR6NYCkJwI6S8InmERi
 WGPkw0cUXBA+NQABaEM1oE9SAmHBvv0hWkOoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772734043; x=1773338843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQ1ETp7v5/LPcFCofo2J8UViolpWM7LyaOxmKzsu53s=;
 b=dfmCP3eY8hKbk6hpA5S8dyrUQkEUppAMb5HRnBDbYQa8jR9rbF7TtrF8TwXT0Nk9B4
 MfDLCQs7lLf6J+c0KexU9+XDAXnB4Tv9HNyIR9GzBXGtZK3bQ7kqnGORxQZw/QRwNho/
 4wTRL6pNav7hQYxU9bKoQWjHGJljcQlqmG4NW837h1dKLc1VDsvWcGzNKdMbiaixmJAs
 ET6VGyq7VUsmfGYdVcDRgvHjUNxL2t1OCVr23i12L0vWxZN9abu1oeBs1JyhpK+1n44V
 5tGCvIYK6reUnIQILiKcrLqbGjRgQzT8ZR59pkI34S/VbxV2dlXH3UaH+MgFO1K8+bot
 m6rg==
X-Gm-Message-State: AOJu0YytZSFz4igcB6YeBl4JdAb41tW61Cw0vUQ1RDqjUy1niIRLJM+s
 Hk+6Wg0zR7n2IRTXIPu38IofbUAKHhoOGN0tyH+REzcTZy9vzLnlGlF1tbPJdU5u6+i2Yg9+uD9
 qL8UOXFg=
X-Gm-Gg: ATEYQzzRWSHlMDodwmzMZYhetOaXO/1p2+J3W3mvnYLbECYSEOyXbC7dWIN8C1wT57f
 YSuVZ0Lel6xjvj7tWWHSwI5WuoDfx5evffz8OucnxcHJnApor7o88p2pxWcqc9aOzAYodcmvlyG
 dBJm69H7/2uIE1ooIaLYrsEeqJmBsiOPrdxtlKe8+px6iQnvRLDMQ0MiXzNHVWy4G/8C+X2wdl4
 PBOtHFQHm+igXn53cD3sQdF5Nsl2NDaYrCnFkAbLtTPu4RfmpdVG/5/jqQcisKAp/KAe5gg1G7/
 Px0f8+TtVbvrIYKxlEhOIuE6p+RVxzkfRLJWygoDNHJKGx5REnvMNM41RzomtIHIVgoiEsZaCHS
 2YQqOkbfNLaENz/A4QG1noq4apqppwSN8IWZPTSHvsOYp6wT/WsNJKIvZchto+BK16JFAswFtes
 MtttW6HsFVq1z0EAAY2IbxmnxDRfzRVV9J4ow3tPL01YKJy64R5ofW8BvIKq7hsZogdFmebiVmt
 i8C39Zi4caJ4YXF+O/n71Tpm+7m8LHSwX3WllespFtdGLGCgrs=
X-Received: by 2002:a05:6808:bc3:b0:44d:ae36:dd86 with SMTP id
 5614622812f47-4651ad35211mr3042876b6e.59.1772734043404; 
 Thu, 05 Mar 2026 10:07:23 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb5e417fsm13505690b6e.16.2026.03.05.10.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 10:07:22 -0800 (PST)
Date: Thu, 5 Mar 2026 12:07:20 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>, Simon Glass <sjg@chromium.org>,
 "Nussel, Ludwig" <ludwig.nussel@siemens.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Message-ID: <20260305180720.GG1388590@bill-the-cat>
References: <20260302220937.3682128-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D3wt+fBvBVK5ZAI3"
Content-Disposition: inline
In-Reply-To: <20260302220937.3682128-1-trini@konsulko.com>
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


--D3wt+fBvBVK5ZAI3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 04:09:37PM -0600, Tom Rini wrote:

> There is a flaw in how U-Boot verifies and generates signatures for FIT
> images. To prevent mix and match style attacks, it is recommended to
> use signed configurations. How this is supposed to work is documented in
> doc/usage/fit/signature.rst.
>=20
> Crucially, the `hashed-nodes` property of the `signature` node contains
> which nodes of the FIT device tree were hashed as part of the signature
> and should be verified. However, this property itself is not part of the
> hash and can therefore be modified by an attacker. Furthermore, the
> signature only contains the name of each node and not the path in the
> device tree to the node.
>=20
> This patch reworks the code to address this specific oversight.
>=20
> Thanks to Apple Security Engineering and Architecture (SEAR) for
> reporting this issue and then coming up with a fix.
>=20
> Reported-by: Apple Security Engineering and Architecture (SEAR)
> Signed-off-by: Tom Rini <trini@konsulko.com>

I just want to thank everyone who has looked in this and worked out
another solution to the problem. This is why our policy is to have
things disclosed in public and worked out in public, and has been an
excellent demonstration of how open source is supposed to work.
Thank you all!

--=20
Tom

--D3wt+fBvBVK5ZAI3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaanGVQAKCRAr4qD1Cr/k
CrbiAQCDMiagpwze82lFSFp1X29hlFTeFPl0Z5MCoTRuNckkXQD/Qq2xU2O0uNQG
RoMsMlUPVoJFA1kcp6UjOzO67bEYAQg=
=Uf0/
-----END PGP SIGNATURE-----

--D3wt+fBvBVK5ZAI3--
