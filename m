Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CEBC369AB
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 13:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD15819FC;
	Mon, 21 Apr 2025 15:24:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="arjsfUR9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F9EE81B4B; Mon, 21 Apr 2025 15:24:28 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6D158144A
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 15:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2cc36b39545so1602585fac.1
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745241864; x=1745846664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=URKPjSqeCNDBUDOX+2eDC7HA7WJ9gjDZdEIdxZNdvls=;
 b=arjsfUR92lGnb+RiiWQlE1zz2/B4PqGrua6eYIF1uxA4tL0Rq/L9LtET6NKJa+P5xi
 CxEuTVT48FTeYF+Zf0c/FM4n23SvumPVJ1GmkNXctCRjih4whX3uy4CoBAx0XuQDpjEL
 YdqB3loczNfhLLTearuYnNFS+gVRZYQcCI6Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745241864; x=1745846664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URKPjSqeCNDBUDOX+2eDC7HA7WJ9gjDZdEIdxZNdvls=;
 b=FFivLmtT0XwlGQmDye0+Qx3CgAXRFQgY7aWt/wlxyp/LvWAn9pmine/TtzvmgZwXlB
 GiEBE0G4uJu8akRmOs6pxbvonNr5qHa6UwjMaPIj+T1wN+P5oIbELPUaHshKfGnMC8na
 cOZB9JaBj6KkY5DGYr5wf4n+QcL135MmJ9MTIHYnWSzootJO2OFmatlb3jS9RGIGYNcq
 cydiC/it6eUQtCKCwUATmFGJRFDZJ1qkq2t110QwBrQNTMA1LBPPrie3ObX2iYUdBnvn
 nzKKNLhHUF//MYVMx+Mp4P78EgiLi+QTm3w/HlxTj7OUHRGUkDJGFCc0aT0GiuWTIO3y
 D5dQ==
X-Gm-Message-State: AOJu0YwULaJwq8gJHDptaki6lJdqdvy1vROduIBIFbgwHDJ2v6hD2wJJ
 BmNrhUfQFtBAVz14buzWGePdK6FWUJ1SQ5JrMWuv0+NGQQHRpQ7HiW+HQMaX0l4=
X-Gm-Gg: ASbGncv3/FyQ2/gBpfGaOr+w+kpI1nHfe1Gqzg8wdNyoObSVABYBQ+DZ8DQ0QslioMy
 Mc0s/CAITdxPM39E3P7YXfm81lADf7ZoPIxGcwUXLRu/FE4LAHzJ+OXcqRNDVt3DNxmmosLLrj9
 6U8TrwKokClSbX6WY8xp28fY//jcA70RV40AimylOBZ6htOvuAww3AzKuzVJ7La03qbKQ+nnfbF
 O3E1IRiFaKrQ+yJQ7JYLyRPLvAUqFJVjkl17h+2xbStLfXajyPw6jgufzo0kGVBWwk4rUSjYtFA
 gYC38LmVMYRBPNZFeoNHfBCLGzlZNTeW1Mf8H7W3ByUprWExWPPznZrYbnWenmiF52PmDVMEwZZ
 qhDSwmuGBOwFh
X-Google-Smtp-Source: AGHT+IHlNJu1uKLurOePv0+35+2SwpbaCSbKFXxYckkKsECmiH5Dz8pZpp8Z9pMerq7ZyNgD3BwFTQ==
X-Received: by 2002:a05:6871:7429:b0:2d5:97d0:c03c with SMTP id
 586e51a60fabf-2d597d0c4fdmr1956013fac.18.1745241864576; 
 Mon, 21 Apr 2025 06:24:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7300478c51asm1465947a34.8.2025.04.21.06.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 06:24:23 -0700 (PDT)
Date: Mon, 21 Apr 2025 07:24:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request efi-2025-07-rc1-2
Message-ID: <20250421132421.GT5495@bill-the-cat>
References: <2d5d24b1-a5c8-4608-b654-ffcb9756bfa5@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aDuhpE5S0wybPu9p"
Content-Disposition: inline
In-Reply-To: <2d5d24b1-a5c8-4608-b654-ffcb9756bfa5@gmx.de>
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


--aDuhpE5S0wybPu9p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 20, 2025 at 09:19:59AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> I have added:
>=20
> * mips: malta: set MIPS_RELOCATION_TABLE_SIZE=3D0xc000
>   because the maintainer did not review since last year
>=20
> * riscv: dts: jh7110: add bootph-pre-ram for &pllclk
>   which is reviewed by the maintainer to unbrick my test lab
>=20
> The following changes since commit 71f497a6d3908574a1b1c3813c2a1385910f76=
bd:
>=20
>   Revert "power-domain: Add refcounting" (2025-04-18 09:35:39 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2025-07-rc1-2
>=20
> for you to fetch changes up to ed16466966447b95d402376035217633ee5098ad:
>=20
>   mips: malta: set MIPS_RELOCATION_TABLE_SIZE=3D0xc000 (2025-04-19 12:50:=
04
> +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/25819
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--aDuhpE5S0wybPu9p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgGRwEACgkQFHw5/5Y0
tyzhfgwAknpYqr2TJFkVSBnnL0XdEZ401zBgf2TpG20sS7WMND7Gbwehzp6q7koW
FUKOPmAnF/ilRNJhop989zfDso6aoMjdMn930yLDe1ii3YKaisEd9Bb5aVd3aqtb
l/KgzuoJ+nSmaEdydIkJ8Oru6pDSFTutE/1S4B5jk3/hbydxFg9IiXpD+8JYsU/1
4reybe3dG4J+ICTLDCwjjqniaPsSSgZVhdPb4Xe5YWq5mKTXH++eLbmjUAtB19nJ
2DCfcsjmqon0hHY0+Kim2q0ih2hblHg/4a0t3NQ4uvW4yA9bQOz8JRJ9gw/uRJyR
VF20XU47BcydW8Ts2d05CFcn+adx+oF1akkFqhrMwiJ2DLqLPqQKRVVcUB2XtojW
ZLWXy8qoLwkY047QMgmImy4SjWndel4tufq+DhrbxRX8iBuDYQnN4NZDXz5b30l4
WAfpy7kqeOl0Pc7Dxx2D4XPbEUhBXMrvPZVMy+gyhKKKlgBs9MfCkGkvdr9f0YUr
DGbLp67V
=PZNL
-----END PGP SIGNATURE-----

--aDuhpE5S0wybPu9p--
