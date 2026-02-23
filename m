Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3796BEEC287
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 21:32:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5223383BC9;
	Mon, 23 Feb 2026 22:32:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rl5s0kqs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3451183C39; Mon, 23 Feb 2026 22:32:15 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1808483935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 22:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d195166b2cso3394558a34.3
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 13:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771882332; x=1772487132; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZBvxsxxKVS5Tcd/pKKu5JaZR2R8tI55mXL5glsDqOA=;
 b=Rl5s0kqsik2lSfLmWQbzaNveVe9KtlZUtwX1NZK/6h4msM+E2ONQzriaHxvRrrk1k/
 9WDvsXnYGqM4Hreht8XNjaf2v4IjlfKjl8T01cnR52GxFW9a1anc8wpc7KMYc75I80oy
 qGnXUvd9ei+Ngy/mb6bapDb1Hes7R9cug03uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771882332; x=1772487132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2ZBvxsxxKVS5Tcd/pKKu5JaZR2R8tI55mXL5glsDqOA=;
 b=iAo77eovYMK4sWdHhIgn+KYqyI9yl0bVbepR82xC0MM7Hius58rAVT/Iiy7eviuPK5
 FSDxiDWyoXoxGDgQtu1DllMyYr6QXSO/SDFCfhpAllMhBpRy6ELO7ZSGhVMQvfq3xaFB
 bibqmpDpIhjbqF7FV0BHlmawBgEmdcaAf8R7KH+o942KUprT4ltrLxI9KSHdrCfnU/Ex
 KYLwxE+vJcfSSTG+28KmIczDtWQvIdaYfSxa8DcVifCKRjIvhdaCnbgZyx5xDvVwwVtn
 axd21aYEGhPbQugoMhxfR8aPYv3PXD5xixzbo2t6+AcxAOMsvSVw0wjN1iWQvl2sKRLW
 Vwmw==
X-Gm-Message-State: AOJu0YyQ1N59X5NHWk6PLbhF+jgifRasAWEPINaQAS3gvcQ3jsrHcgdB
 VWJlpycjFKy/YjV8/1obFeHdn9rb510H2iwDntzkNm+NNh4SbtbdlqbGgBEQsS/vzHg=
X-Gm-Gg: ATEYQzwK8iXhzbMcBy7qR0FtS7SnQZ8LNnUxNKzbovY68RxOgyLlLjvtJql8VZvSk0h
 OgwFP6nK2Dh1F7x2BV8+AltsCRz8oFUQant2/Rk5q+XHRn3zrwSpPLktB+bjePcBHNP90ocZoyM
 q24C1qV6AUO/GN5eF4DF7WF0/hsVOujYHAWihdoX8qjb70ygh8yOjvWzlQsMtXSwmVBkteL8yhJ
 lV6nGuvJXy6Za2qcXht46FSApH4OI0nqTt8mwtgf1kEudRIlzqoKfEUTwXpQ0GsePJXMsmexPky
 a6nSz0HThKCzZll0d34PJxnxY/zr7KV91gddd0Y5i+QKb9n8kuGHLHt1jQIv29PX0mYLzIWxjIq
 BXSDxZ2XHGza2YHrkkJo4x6OULQBNktbF1qp2D1FjHI4+YR9vl38I2+nAQs8LGcaJxum3q++kM9
 YV2QVz/+N36E0S+rMHUnzafk//LbmJgFjK0bs9IaoxMxAqGFv2svxHu7j5LZV2OaipHlmh5Xoxw
 GRdudAymkP496YqTrAnQ4gAEg36htKDxlp5rq4ojMScmhfRupjVdx9UFgX4vQ==
X-Received: by 2002:a05:6870:9452:b0:409:77d1:f91d with SMTP id
 586e51a60fabf-4157b1ccb63mr5084357fac.47.1771882331806; 
 Mon, 23 Feb 2026 13:32:11 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4157cf9a388sm8434923fac.6.2026.02.23.13.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 13:32:10 -0800 (PST)
Date: Mon, 23 Feb 2026 15:32:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Ethridge <jcethrid@gmail.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Greg Malysa <malysagreg@gmail.com>,
 "caleb.ethridge@analog.com" <caleb.ethridge@analog.com>,
 "linux@analog.com" <linux@analog.com>,
 Philip Molloy <philip@philipmolloy.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>
Subject: Re: [PATCH v2] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
Message-ID: <20260223213208.GA4003066@bill-the-cat>
References: <CAA=Y9tY1pJV5O=23YSgM-1TnRQNpg9zrPJsSn6YaL_uAPxUo=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vspsuQkzHKAHiO6j"
Content-Disposition: inline
In-Reply-To: <CAA=Y9tY1pJV5O=23YSgM-1TnRQNpg9zrPJsSn6YaL_uAPxUo=A@mail.gmail.com>
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


--vspsuQkzHKAHiO6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 10:03:57AM -0500, Caleb Ethridge wrote:

> From: Caleb Ethridge <caleb.ethridge@analog.com>
> Date: Mon, 9 Feb 2026 10:00:10 -0500
> Subject: [PATCH v2] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
>=20
> Updates the polarities for the GPIOs on the sc594
> EZKIT carrier board for the newest revision, Rev D.
> The new carrier board revision has different polarities
> for some GPIOs. This patch updates the sc594 entries
> to match the sc598 entries that were updated in a previous
> commit, as both SOMs can utilize the EZKIT.
>=20
> Note that these updates are for the EZKIT carrier
> board used by both sc598 and sc594 SOMs, not the SOMs themselves.
>=20
> Fixes: be79378 ("board: adi: Add support for SC594")
> Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
> ---
> Changes in v2:
> - Updated commit message with more detail according to reviewer feedback

Please resend this, the spacing in the patch was mangled by your mailer,
thanks.

--=20
Tom

--vspsuQkzHKAHiO6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZzHTQAKCRAr4qD1Cr/k
CvcRAQC6nfJYpnSpe5QHMvLiVhnZ9WytAiIJJ3aho+4boAuxeQD/bAPsgdLVTYen
zTMNnNPkCXR4mRaYzhTb2Qr8rw5aygk=
=nWh9
-----END PGP SIGNATURE-----

--vspsuQkzHKAHiO6j--
