Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B2EC54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:49:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12280837B6;
	Tue, 27 May 2025 15:49:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t8Kagaob";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 902AB837E2; Tue, 27 May 2025 15:49:13 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 413D983754
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3f6a92f234dso1977319b6e.3
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748353750; x=1748958550; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UB0tBrhuuDlTJ1LN6lnGZnLyScNSib5dxKC5f5Z7/Zk=;
 b=t8KagaobC5u8fD5YXoCWJ0ZfS1lNa7HmrghQ680Tqhbn7diFN76NNs8RaLFQodcbTn
 ll91NvTdUr1OoHgxy+FmbxcDjvPVxKLP4sGv/3hcNEbZluOAQveofBJPVZ2iMPChyQpN
 5I91PdcSCBXGgFgrP9zaccgeU6HTzHYejt0kU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748353750; x=1748958550;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UB0tBrhuuDlTJ1LN6lnGZnLyScNSib5dxKC5f5Z7/Zk=;
 b=UrAzHuGwqinaRQ5vk6UlykhTRmXa1xSqbgS/2mWbOD6lbdixiBXBS0SnCs6QaBLIOC
 cIE1TqwCRmWC7hTY8imnJnkU6aoL1EN5n8dyY4psVXrTx+3sZq+ckSexnSnXTV46NFY4
 Rt5THpge0lIjb5wdeodfYCOvGTkWLA4KgpvK8U4wEDi/JWiD0Uk0jItwAfmXOEahi0eA
 YEMveR/MymtvINueAGn6snoAJwYey9c32vTmABi42FvLew+JX+wCTn+ypjsxSB18Y74+
 SuZfYIdOzgSg7V3LaGCbM/DZX4Nl4KnxsfpZxEWai9LqrB7AmyzF0fkSvMU0/syq3qCk
 zlZw==
X-Gm-Message-State: AOJu0YzTB6d4IlNvm+U2Xy6gV9cqNKJANjK8iOC7SjCPsXTGpoeyVwVK
 m2vmoF/d9AgS6wLLkGr7wSmWEPqJZwmcLeUgAMc4fURrqRzBwi8y0vwg0cYkcRdM3GnjmJqSIN+
 onW9q5O4=
X-Gm-Gg: ASbGnctYeAYj9Df9sVNRneXpRNM1Zvjb2Zv0OuNIvlOBWdohS+jFpOu6uo2HOU2gdea
 ls6VYqe5jKZjgJgJZJKzeJAriTlNAQ8JnMRNoiWyDWtn1Pw5KR4v3qQ93eCTAZ1bn01y2w5+zvX
 Jjj1ClBwVqvIM1edGjOOqcdapNCf9KHw2DKkZT1Z3PkYhe8tfdd3Rw3yl+CX6u/0F8KUNKdQ4BN
 zgWZCbgXRCBLC+p64SW8CU/u0i5EcMOi682pGM4rx14/WPNBgR44qitBsGgSD1ru8cgaHqz2fUl
 KcrEfxDS3809s4XfSk82cCqyjmJL0+pbc203U7nsZyzG2arCLDxQBPxTJxDmMHi0Mo9FO31MpvW
 pQccBUN1mZ+HX
X-Google-Smtp-Source: AGHT+IGCGtwI68lr4J62MB9Kyf14kkG7gVDbGJd+gpXW1Nb1OxMnPIMDMtwQySOUKsOIkarfI6FX/A==
X-Received: by 2002:a05:6870:3908:b0:2c1:b58c:c0c with SMTP id
 586e51a60fabf-2e8620ef0b5mr7357994fac.34.1748353749989; 
 Tue, 27 May 2025 06:49:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c0a9ed10sm5516289fac.32.2025.05.27.06.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:49:09 -0700 (PDT)
Date: Tue, 27 May 2025 07:49:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/2] spl: Add size check for u-boot-with-spl.bin
Message-ID: <20250527134906.GI100073@bill-the-cat>
References: <20250527121049.106825-1-pro@denx.de>
 <20250527121049.106825-2-pro@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E8ifFimbnuoDlPmf"
Content-Disposition: inline
In-Reply-To: <20250527121049.106825-2-pro@denx.de>
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


--E8ifFimbnuoDlPmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 02:10:48PM +0200, Philip Oberfichtner wrote:

> Introduce another SIZE_CHECK macro for u-boot-with-spl.bin.
>=20
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>=20
> Notes:
>     Changes in v2: none
>=20
>  Makefile           | 7 +++++++
>  common/spl/Kconfig | 7 +++++++
>  2 files changed, 14 insertions(+)

So, for u-boot-with-spl.imx we use BOARD_SIZE_CHECK and
CONFIG_BOARD_SIZE_LIMIT. I think for consistency it would be better to
re-use that option here and expand the help text on
CONFIG_BOARD_SIZE_LIMIT to note which build targets make use of it.

--=20
Tom

--E8ifFimbnuoDlPmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg1wskACgkQFHw5/5Y0
tyyquAv+KyIG4bqV5sRKn/yR+e6lYcxLI/GorJyzAzNbM2/fzoYatcUiWB8VEwDT
ojyhaFBbLEPX7XdJA0I6fdj9+0znoezPqNqil1SWrU+yfhSaAO/gnrZsn02vjzbP
vH3fK05xWDq2cvxfAq9D3Cywe6Ezy1/sPw1df3l7VZY/WN+Y939W7SzERx8hWFWL
hjgLOF/LTc9pyG6gbxXqD8m5WwjzKv6xuCTo1D3/okAzCeZGmf96isTYPtQr1GLy
C1jggWRCKd+i8njHqaGxn/DrrH3uwIGap7lFIog/2YK5n/9VbL5OsqAVu+6WzQkr
7YayDEaO70/lA0Ko6kMxNokA/hramM2fA7uDHu8cVfaQxTClyrIMB5ViltFOq3jy
Gv/CO3uamepk0yt1WO4v9eJhpKLp/4sPw1Y0D+y0rD4xjq4DQ5ys+XQPJk93iSSe
fPonC1vP/Jn/AIEAqwSXI/B9ueFnoChzp7dgKxf9FJOcSoD1Ep8WHXDl4Xh+tM/S
tdQ4YABF
=SWtl
-----END PGP SIGNATURE-----

--E8ifFimbnuoDlPmf--
