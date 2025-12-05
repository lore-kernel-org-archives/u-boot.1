Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EA6D3748E
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 19:33:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26C6284213;
	Fri,  5 Dec 2025 20:33:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="i9UTbnjy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC5184218; Fri,  5 Dec 2025 20:33:16 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03B24839E8
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 20:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7c75b829eb6so1886219a34.1
 for <u-boot@lists.denx.de>; Fri, 05 Dec 2025 11:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764963193; x=1765567993; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AEUxsuiH62Gs5mWvUITmJopoecpKl/NIPUNIKeUcZuo=;
 b=i9UTbnjyglzwbBZNyF7rQWVlvuw4QYjwxI6xjUhFtUF/+PEogBIUAX2fN1tmLPRElj
 TYEl/9QLdwy6gmv2QLODqXqnDZTimtNLg4zmlZUsADY+VFSgvXFVeOosW82w80uaCJL/
 ofnhrTKQaHzw8y8ZLemCHHPd49SNM1lAl67Mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764963193; x=1765567993;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AEUxsuiH62Gs5mWvUITmJopoecpKl/NIPUNIKeUcZuo=;
 b=ApCQq2vYAfH+YfbUL4Cg+4SRIwLawp9W6Jvx8BcL1oriog1kaaXz4r+TQ8z42OFS4m
 AP31HN1NuLVnazFxk14mFI5uzulmjvYj6lc9uRZd77LGCYX9SO4jFbVBGwzZ6BLi7mlX
 tRE3KznEQ8Vg/xexU5DAbkKZliItUArPESs9K/9G09zJ+siiKuwjzEvg72PY9NDc0AwJ
 H6izuNlVe5syvyZwfaEc8P74oaDf6JO1qczTSpYFVJ5W97BhffmiudQfhY63yOoBFoCb
 Abwm34EXr/Jnk8Iqd2HspcB/PzlX4dzAeBRifa6jhte5EXyOIqAOAdC4m5ZQvTVXj4+h
 I28A==
X-Gm-Message-State: AOJu0Yx9TL6WqVSXc+2upZY1HyzRr5UnrviKi2zjNdlvq24C05hSX/9F
 pa8jc3Ve6z2rEATJBzJon9OmpeXljAU4J8hPrT2DmVHll6lD13wTeVIZUIHjDCOY8dU=
X-Gm-Gg: ASbGncukRCILgZtMNAhJW8VoAEftYcJneB/r2otqSb+BxSwHqyNHK6SpSsGAv1n8n09
 OwYyun+i66h+Pn+jTbRrDAj9nOypPG6RMK8n0yw8tuXbtaXA7xJ7lbhU+PoxRgqJf/FAE7MuY7d
 S44ItioRuNRKhiThgWexDiNoBG32WI+V5b2EATrlVTE/sryu4Tap22tW7eZAGsF/Dryyz5vt8+c
 2qCaUfi78ZpVjpxtB/trFFAryYALGEDYzWT6w/30QzEIK99+T6AWzD28TCOp/QtGoi/2C+eUgtZ
 nHU4BcaR4ktR0IdN7/z2nhXicMBzkattZwOZsRGgzJdkKmUZ40iaCDdfo/veBAErGcsZAtskcu2
 vAQ5600SYLhOqw0wbaj0i4NMMvknbfrr9kVoFfbrSYzYwkCblrTtarxk3oYwO7ERcdbKjcVk0Hr
 mrc8B/5CbVsaMemSZsw1EXRMLF5K5SbMKzBlbvjbkGvtOqI+k0zQ==
X-Google-Smtp-Source: AGHT+IGCJic0Xc+EjTTDwYd2poSQbvutuWSWN8ho297FcdwWkosVvPUfLLNKwtw5PwPKliqSgsdqgg==
X-Received: by 2002:a05:6830:4424:b0:7c6:cedd:8bf8 with SMTP id
 46e09a7af769-7c97083d09emr82828a34.27.1764963192729; 
 Fri, 05 Dec 2025 11:33:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c95ac833d3sm4483836a34.17.2025.12.05.11.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 11:33:12 -0800 (PST)
Date: Fri, 5 Dec 2025 13:33:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Robinson <pbrobinson@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Weijie Gao <hackpascal@gmail.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Max Merchel <Max.Merchel@ew.tq-group.com>, Mario Six <mario.six@gdsys.cc>,
 =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>,
 Sinan Akman <sinan@writeme.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 1/5] led: remove code guarded by always false conditions
Message-ID: <20251205193309.GA2316762@bill-the-cat>
References: <20251119-legacy-led-unused-code-v1-0-bc0ae1235baa@cherry.de>
 <20251119-legacy-led-unused-code-v1-1-bc0ae1235baa@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3h3q0Wvw+R7s63NO"
Content-Disposition: inline
In-Reply-To: <20251119-legacy-led-unused-code-v1-1-bc0ae1235baa@cherry.de>
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


--3h3q0Wvw+R7s63NO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 05:43:45PM +0100, Quentin Schulz wrote:

> From: Quentin Schulz <quentin.schulz@cherry.de>
>=20
> The last CONFIG_MVS in code was removed almost 12 years ago in commit
> 3b98b57fa796 ("include: delete unused header files").
>=20
> STATUS_LED_PAR was last seen 8 years ago when removed in commit
> 5b8e76c35ec3 ("powerpc, 8xx: remove support for 8xx").
>=20
> If CONFIG_LED_STATUS_BOARD_SPECIFIC is not defined, the build will fail
> so we won't even reach this part of the code.
>=20
> Let's simplify the if block to actually possible configurations.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Tom Rini <trini@konsulko.com>

For the series (git pw series doesn't grab the cover letter), applied to
u-boot/next, thanks!

--=20
Tom

--3h3q0Wvw+R7s63NO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTMzcQAKCRAr4qD1Cr/k
CjT3AQDihDGubdolrlguEQV7eFm9DI+DjlE/CbomkM84Iaw4GAD+NHh5bEKdy+Qf
vBalVo54MepYTchXhVF028BCO6jldg4=
=66Ac
-----END PGP SIGNATURE-----

--3h3q0Wvw+R7s63NO--
