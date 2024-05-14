Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B55C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCD288365;
	Tue, 14 May 2024 18:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NwaT66R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD28888365; Tue, 14 May 2024 18:15:58 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 992478835E
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6f0f5633a45so1978904a34.3
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703355; x=1716308155; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OoqKIx9288BAZYEPqxWejWZ7a+4fUw5ZA304lYbCF1I=;
 b=NwaT66R+FHnqIvsS90rP8z2nQ0kXVlSVE5Zk28SWeKFbVKGYjIfqpIdfATga71rg95
 kRnu0yvPjA8RdwDp9WyQ9M3jwGd7Aabeqygy/A8sfISD/2rmumYjXb1zPkLToovRQ9mY
 o3uoSoL9AOCjlgsSBkvIYS7jaOx4y4qsqFgjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703355; x=1716308155;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OoqKIx9288BAZYEPqxWejWZ7a+4fUw5ZA304lYbCF1I=;
 b=Dd6Uj+Gx8/HspEkS8+uDXBpjGXr1Zs0Ufe9QLkT3CcWTo4AGSkt234+amyPGPNhA6G
 61AjwwM/aHf0v+mnkAUc4yi5JJSqhXb1aY85JX3bTerBCkFC7byWC80j9ZrKNF2X1qH0
 9iQfuOZu07/kMWZUjsc+UWh257yHz1IMvICyn/WCzciAXA4mo5im56jq9mtpD0KiN6IG
 FiuOeNGu7JVdSY32/246sUmhi7RDYYDbSuYXsRWWf3fBkl2ccTiT45s3RmzD/IPcJO+m
 P2Rcz7FhmbXJs0K6nxtW7e2QdcsohfKAwA3p6mgFV0TLNV0HKsLNqt7RPokHgn+ycSm7
 ps6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKhjUoEtpYizHaDbicWjRFATKhQdjLKaLOAGAfhOx35bV3fXUCFaUuCwB9Ay+5xpflSJHqxCTDJ1VZOlCAb+wxpAsngg==
X-Gm-Message-State: AOJu0YwWiY+cSAdK804k4DY37Cht7mW3TMvzRNEtmTHuHleGkuvFN9cc
 BiINxUV6aB8N1EJ41An2h3xi74G5cZELRH9FKQeADY1tLgebb+NrSIYXnoBBg24=
X-Google-Smtp-Source: AGHT+IHXOS2PpReHQvtrc+VZWeaJk/AVOAUoxxcS1hsRC5aY7Q6Y6wGl2vWD13Ry8hW1/qGd1ckEJg==
X-Received: by 2002:a05:6830:138b:b0:6f0:5c48:edc6 with SMTP id
 46e09a7af769-6f0e9115aabmr14920059a34.1.1715703355282; 
 Tue, 14 May 2024 09:15:55 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf27f8e1sm578052485a.34.2024.05.14.09.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:54 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Brandon Maier <brandon.maier@collins.com>,
 Joao Marcos Costa <jmcosta944@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] scripts: gen_compile_commands: fix invalid escape
 sequence warning
Message-ID: <20240514161552.GS2568172@bill-the-cat>
References: <20240503152000.2819669-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yWOaOh4LSifpSD2e"
Content-Disposition: inline
In-Reply-To: <20240503152000.2819669-1-caleb.connolly@linaro.org>
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


--yWOaOh4LSifpSD2e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 05:18:36PM +0200, Caleb Connolly wrote:

> Since Python 3.12 unrecognised escape sequences trigger a SyntaxWarning.
> Convert the '\#' string to a raw string so the backslash is correctly
> used as a literal.
>=20
> Ported from Linux commit dae4a0171e25 ("gen_compile_commands: fix invalid
> escape sequence warning").
>=20
> This updates the script to be in-line with Linux 6.9-rc6.
>=20
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> Reviewed-by: Jo=E3o Marcos Costa <jmcosta944@gmail.com>

Applied to u-boot/next, thanks!

--=20
Tom

--yWOaOh4LSifpSD2e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjjgACgkQFHw5/5Y0
tyxk1gwAsXzjmiA8OOjYs4ldTs7U24597TvT9Oj82e6gQGY4AGH9YuqcDKhNo9wj
eaMi+HzJSvQG2OIbb9AWMDRZYOWj4WxZPkGDqNpchoPwHd4EiGLfNyA5mBmAu91T
kI6g3LCWr/s+8PLgEXwNIqu7A5ynHtwbBjgEVZHiyu4hedSQwx1feRRIp5cnbJbC
DIulU0MNP2VS0N9HEqEHry7utEH+e3OiqqGyc8KUou/brZWDqte6KtPDKKP81VoM
CYdZgLQxppbxGGI7Qu0T6Huo43EQNZ6XHN3BLCg90CIpKUBMiSPIww7IfOtfKfOC
mpVFD7oS4tq7BBmJ8qWRnA4THrwSXoS9mxNfQ9oe7DdynDIP/Tck3f191ayp47Q3
Kql+LATU0evlN0wU9KKpv+OtLmwzvwfMzNkTfYhItvYQ+PXG5kAK0g+gtw3/Gx1t
DayCBUkW94c+QiSChCUUpwSQcE+SEpefzKDWbAWLo1pO0LGNywplfJjVK3Ww8gln
PcTLHC0F
=t1H9
-----END PGP SIGNATURE-----

--yWOaOh4LSifpSD2e--
