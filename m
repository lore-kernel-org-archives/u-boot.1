Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723A8D3C928
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 16:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D26B083869;
	Wed, 10 Dec 2025 17:12:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kzN6OH9r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 067B98389A; Wed, 10 Dec 2025 17:12:54 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4D8B8367F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 17:12:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-45392215f74so1782767b6e.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765383170; x=1765987970; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXcMS8FgfBX52js1VN9vgoeCcddBsG5Rx9We0hPP044=;
 b=kzN6OH9rzN4wZTZAnYYRsarqaNRk3MIUZhF1zF0TqhZbp5sMlg8T7CjSx5kxpsklpQ
 p3L0LEmJ9etyRgZmtKAgttVtOS+iSi+XZxB/zjLWJDk0Pn127IHCABRua2sfSI4gwj1T
 Sg7OJcFR3n8Ot7BeeNV7hhaB+fzzku55wP+48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765383170; x=1765987970;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uXcMS8FgfBX52js1VN9vgoeCcddBsG5Rx9We0hPP044=;
 b=sk6+2GV0lhdsdRQYyUWBuy31MDKCxflxdGjy0XVLb22iJNRhI1TyU/yYTp+RFInDiP
 fvNocuqCXQqacAU1IVB4Dg74gh6lK1feW/8KfBHhqvyLAEyu51+V3qydqNxbyeoF3pgn
 AFLZehD/bBpS6+Vp9Vz6IpzC0Mq4NCCznF6l7scwKK6NVKn4NjhnidlsKqwuDHdAOLau
 g8eSsaWaI0EW4JsYiEcHVsL+rklo4cBator1YCbNKoy6yWnMceDr8G23H+wGTOPl/ie3
 3yhzMLeBnTvP9rVYZbOCLpdorZF+tVutPtrWhPc4SMVynJ0sS8cdtv8eEYIb0knmYx9P
 EQaw==
X-Gm-Message-State: AOJu0YzBpsHLSCK/d/NLTaeUD6GGWNSN5mxUXfJghAIsx9iMh2rut504
 BvuD5p53vfPZNfrhEde9T11XwVL7rg2De9RzPMcoJpTsOPh5Xyr3uU8HYWDgH1JBmeXjsAKmkfG
 3vamJnVc=
X-Gm-Gg: ASbGncup0Q0fO8gomf3ybscaw2JXUE4AKm2Yu9PW4CDpNzXJ/Go/uV+d1TtONdNd3KV
 R/s8PA2OypFMOjWknbsPKTTjyu+84uyyP+ON/5fS8dl9+CZt+6NUjcCmHTiz7vQzhIpPFI/sIzq
 LHxyG5Yxqh+nC1V0B9GrJrWZEOht8z0jWYaDkWrbhGrSbLn1j0PgVZOrfM2v/VbZUXvIZhiGdpD
 qyR3h5RipCnIftjFmA3Gpq89rWorz3j8+Sp6xZbQgNoAEiIqVqPWgL0JlsfX917AWzL67CrS7tL
 BEB9BBNIN3Bd/3DzZXUNYsQfKnLhUzQDLFMNuvspqCLPez1st20Pk2nxbiey/RWeaCsQgafkEvo
 60VuxMKFUd1HbQsAomgPIoH9TXqPpfAHMA+jHA9ModidgomKj9T6wSmo6uEvNQW8h2wIN1etK0z
 fPMdid5Ol9rDefADvIShAwpV68bo8Mvm0VDHSvjIWYf6UehGZ9iA==
X-Google-Smtp-Source: AGHT+IHHik0aAfqMVlDeZHlwXGY47NGJOcwT0eo5hAioyhM+Q8GWRO1vfTDkkR0JawHYLNjQCIWvRQ==
X-Received: by 2002:a05:6808:13d6:b0:453:7404:e4b9 with SMTP id
 5614622812f47-4558651610emr1841669b6e.49.1765383170606; 
 Wed, 10 Dec 2025 08:12:50 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4538011c67bsm9331523b6e.15.2025.12.10.08.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 08:12:50 -0800 (PST)
Date: Wed, 10 Dec 2025 10:12:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Vishal Mahaveer <vishalm@ti.com>
Cc: u-boot@lists.denx.de, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH 0/6] board: ti: Add 32k crystal initialization
Message-ID: <20251210161247.GH303283@bill-the-cat>
References: <20251210154845.3852231-1-vishalm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SNGobfUOsYKIgdnh"
Content-Disposition: inline
In-Reply-To: <20251210154845.3852231-1-vishalm@ti.com>
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


--SNGobfUOsYKIgdnh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2025 at 09:48:38AM -0600, Vishal Mahaveer wrote:

> Add 32k crystal initialization support for am62x, am62ax and
> am62px TI boards.
>=20
> Vishal Mahaveer (6):
>   board: ti: am62x: Add basic initialization for 32k crystal
>   board: ti: am62ax: Add basic initialization for 32k crystal
>   board: ti: am62px: Add basic initialization for 32k crystal

These three functions look identical at first glance, and if so, we need
to figure out a better abstraction.

>   configs: am62x_evm_a53_defconfig: Enable SPL_BOARD_INIT
>   configs: am62ax_evm_a53_defconfig: Enable SPL_BOARD_INIT
>   configs: am62px_evm_a53_defconfig: Enable SPL_BOARD_INIT

And then, the config change should go with the code change. Thanks.

--=20
Tom

--SNGobfUOsYKIgdnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTmb+AAKCRAr4qD1Cr/k
Cpp+AP9pYWB4SyBi4nq8bvXLm25GkChELVJGMeOl16DYLvmPFAD/XLnT91OX5ZkN
1/M76AyCWJ7y2NzpgvxUZXO2agUTogI=
=tymC
-----END PGP SIGNATURE-----

--SNGobfUOsYKIgdnh--
