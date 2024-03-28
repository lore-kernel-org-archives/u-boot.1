Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A95BC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 15:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DEB881B3;
	Thu, 28 Mar 2024 16:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfdaBGI0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C06D881B3; Thu, 28 Mar 2024 16:09:30 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B618881BA
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 16:09:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78a5580333bso67083785a.2
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711638567; x=1712243367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nKtniT7XcaRYfBOkkvgds3gFlzEPsV65mEs4SFuO04U=;
 b=kfdaBGI0Qnz++wOCBGo9XIgFJB2rjdNycSxQQFiyqXVoTlf8tXNfwYuVWD7zbLJfF2
 ZKfzpQUuDGinw1e6kMCpThLZDlDzNcD6IE9zNklpRDgknCewuVeBZ68ZpHq48EIN9uR5
 tqoq37DPACDEYugxxMXf8eOW9Y4ytB3US8St8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711638567; x=1712243367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nKtniT7XcaRYfBOkkvgds3gFlzEPsV65mEs4SFuO04U=;
 b=hnHIOotuEZODWM3uqEq4BYGv1Pn5u5eoSc/HlGkmLF9b3QdW3s/njXIAJKqwzOIQ50
 UO6J7uKzt2SeWYwt+BcSdBXx4fTPKCQ9dXwJWii3gJmSLC9E0+Bw5ttQTOTlz+bPi9aQ
 IcH+YMthnj7MA/y66UnX7LbPElIZmBuybxijGiRaKIWnGGpQqhkTXImQTrGWuYs0udV7
 TMQLDnmmvaQgfkP6ibh2Vw0ba+0zB2hbck3kmOowkdYOFsornIQrijShDwMZlcZFTTFo
 wVM139Im99Qt/Nd3m9i4jF+j/CV5T8cp3HpJggX/5ydDub285nbLsdWDHoivwoXGkhk/
 bQtw==
X-Gm-Message-State: AOJu0Yyk9Z7NO82FNxSpJOWYeVoXgQrc/WlYINadjXM/tZHG+vOS1359
 ZtIJR0SgLT5fyNQE3bCxkV8lD4wH74HjchkRfvVMKRuBee58WatkTZ4B2lqknvZbpKurbP9CGhP
 z
X-Google-Smtp-Source: AGHT+IEX2/tzhLBLuazuEfq6IFKJI+upANJaPMYtTFOfbfCrcXPIXAwysceJE4iAct1WCm0kqLdthQ==
X-Received: by 2002:a05:620a:991:b0:788:2fe2:3ae6 with SMTP id
 x17-20020a05620a099100b007882fe23ae6mr2899211qkx.13.1711638567157; 
 Thu, 28 Mar 2024 08:09:27 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 m7-20020ae9f207000000b00789e72b27fbsm587111qkg.120.2024.03.28.08.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 08:09:26 -0700 (PDT)
Date: Thu, 28 Mar 2024 11:09:24 -0400
From: Tom Rini <trini@konsulko.com>
To: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] e1000: add support for i225-IT
Message-ID: <20240328150924.GA3442575@bill-the-cat>
References: <20240304152338.93453-1-marjolaine.amate@odyssee-systemes.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zwCOuqL8y9TWbKwp"
Content-Disposition: inline
In-Reply-To: <20240304152338.93453-1-marjolaine.amate@odyssee-systemes.fr>
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


--zwCOuqL8y9TWbKwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 04:23:38PM +0100, Marjolaine Amate wrote:

> This patch adds support for i225-IT in e1000 driver.
> Add e1000_phy_igc.
>=20
> Signed-off-by: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>

Applied to u-boot/next, thanks!

--=20
Tom

--zwCOuqL8y9TWbKwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFiCQACgkQFHw5/5Y0
tyxZIwwAjx49TQfVa28nO0aPKoJOFmWXkZYkFwIzLg9uEtlJkXElbsVFonl73x9T
PiJ5WDvHJfJ9EJp2FV/Ihag51ThQjmjPJhlWRGu39XKwES7PusPJy+zNDhEZza5o
iKb1etgyDhqp1Mu6CQFRuYO64arkW7wSznMH7URnuNQ6sz8XAXcdkJVLB6yiLNhW
R6/obFNh3vyte/1FHmZnQ/zRooE5ujnSLIqTO6eV8bFx2mB+p9Y6hZG8/3sOGL2P
WXqxLOOxEniB8x3+FvP9ygfpW8RvToROGIUwvhi1NS1oy/VDhO1j6fhm8zW0JB9i
pFpbR2xYWeLi7UI9zioXQTWsJgLfFTX23R7d27+UiKT25NmLQnjDzaiNW4WFeIG/
fYSZOCfau6Mharo41YGlgcLq91ruOZLn/GZHS6bNu4TZ2ZGbpo8l/IJBhYAGOQM3
numuezEcL43h7bH7WeKf2eoSJKZR9alQTT06lP467WsA/LrCLneTdoFEQ8CRhts6
mEVsRkdO
=aPFY
-----END PGP SIGNATURE-----

--zwCOuqL8y9TWbKwp--
