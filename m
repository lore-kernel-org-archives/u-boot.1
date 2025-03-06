Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7D8C282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 14:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D15E80F9E;
	Thu,  6 Mar 2025 15:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EfB65E0e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A24FB8141D; Thu,  6 Mar 2025 15:03:12 +0100 (CET)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78AC680756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 15:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-474fba180cfso5345711cf.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741269774; x=1741874574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TY2pZIYXuVDtMzonC+KPFMG7109nwwg+J+VvhzT1C+0=;
 b=EfB65E0e/ysbBfhhLc/flr2JtBTABU5MJxgxFYjtRe/eupdgaTQsJdJSdFEa80AEpf
 4DWADvOvErzYgmvgcmRcxDbl2hjzv7QaHZe9Jq3sFeAxOq5jjr9jVD+dbcQM2E98ubNp
 BI8aG8Wqqcs/DuSOWSw9zoaDQsAT+2CJ8/a/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269774; x=1741874574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TY2pZIYXuVDtMzonC+KPFMG7109nwwg+J+VvhzT1C+0=;
 b=A+8hR2wPPQOMSVBsLzWc7hagY3gNU05MgH/Cdkp4FQvK2tEYnXfocXc64+zARecOMJ
 tLDdSnchx1oeYbIMiToEjO3JkqKpwlnoWgOhavXyjZa0+DC3HPIsoslNM26uoHMUl8g5
 lwv2OTJEjptemo0YoaTMS5dKv55g0fxljNteDJbI9sX2XnV2va/tBCTVrD0Q0I7xIlBE
 RmxfT/mdBnzPp+WCp4rXLp3pdgP79cKQ55D01ffdJsjaw8zl1Vma9+psYImzfayiFp3b
 DCax+U7pZl7yqtX6/dmtloysxik1Kx8ztEegg/76YgL6kcTSEzBHWCwfm/vQBkdUGLEL
 WA2A==
X-Gm-Message-State: AOJu0YxuYvPE78qx+JntXcf3x10ONSzOiHT1U9Y2w/9F0jA3gDRhbe5d
 Zo2qlq8GzKX61jibKQKwumCVnExLrESs9i3CDc5zkUB1CglPBgzyDFPoLyc5r5w=
X-Gm-Gg: ASbGnctlYtSWFKpQzR4t/nepUk09o6baKgPjLUJXB+D3nzRijzQV4YSSENSOHhLDCep
 TrwJQCDFmCGL/t3eogeGamqD3t9aToK5n+mmEwPGkldVQYteIRP0/YUtfQqVdIVJIjg3Az5yzV9
 w9aL0UPWlVVaNQV/M2Ppfk9//ZpFbJT78kngIjaXcZxHpeGltKrDO1pzg9mduFKpu+lHW3inL/Z
 TK38rp5hri82c9FMOHK+qbIctxbXVHA+SJ90z7gs7tVoeps9kAKJM4kxF8Klvf3K9jvJAE+3vij
 4wwoP6g1nR7Arw+iuxj5TIeZNiJKZAG99iATqKs6kiqz0A==
X-Google-Smtp-Source: AGHT+IGKyDkoL51GUaHuMPAZXVrH4EHu8vQQLsqvy4zexIhCscQ8k9VScL0QJyW4Vw0YqbyJso2Cyg==
X-Received: by 2002:ac8:5f83:0:b0:474:f35a:b305 with SMTP id
 d75a77b69052e-4750b4bf18cmr82413141cf.36.1741269773535; 
 Thu, 06 Mar 2025 06:02:53 -0800 (PST)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e634b85493esm313727276.26.2025.03.06.06.02.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 06:02:52 -0800 (PST)
Date: Thu, 6 Mar 2025 08:02:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com
Subject: Re: [PATCH] cmd: version: Get information about GCC and LD back
Message-ID: <20250306140250.GX2640854@bill-the-cat>
References: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uyqMtRhVnCzwokve"
Content-Disposition: inline
In-Reply-To: <59827eccb8a90957e3d4f09059e43cc7fe6c92dc.1741255948.git.michal.simek@amd.com>
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


--uyqMtRhVnCzwokve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 06, 2025 at 11:12:30AM +0100, Michal Simek wrote:
> U-Boot version command is no longer showing information about GCC and LD.
> The reason is that version.h has been removed that's why CC_VERSION_STRING
> and LD_VERSION_STRING are not pass.
> Values are generated to generated/version_autogenerated.h which is sourced
> in version.h.
>=20
> Fixes: 54ecce2cbf90 ("version: Separate our version string from the versi=
on command")
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>=20
> Tom: Not sure if this has been done on purpose or not but this issue has
> been reported by our regression team.

It wasn't on purpose, no. Did you put this through CI / confirm
sandbox_nocmdline still builds?

--=20
Tom

--uyqMtRhVnCzwokve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfJqwMACgkQFHw5/5Y0
tyzfGgwAq5cxkkyJQXyn0k6mJmwF7tauqnK+vVoj59f26B3kBq8qYvPiqX9IER9u
TZx1JjdVfvH5ybzB952AJ26i+b6obmrfVosUIeZMQb9TOs/nOTdaPXZ/qy+p25hq
bmTnnwtRHijFVXpqV8+YPsnbBSfK3ChinC6cIXTmGr9O/Bn1BWgo7VB65oang2WM
7g7qpWvQZ+F9+WiG/43pls5DlrouY1SKy3sXPtAgzmGGq993XjBxAg+IG/RyST/0
Cde6XrDBCPj5hhYOZ3CxhkvBwQEvqmmTxN8K7jCfNZg9Sadsbuw85x4PW8UWpA8G
kbQAFROafJLlo7MpSUDV7AHPhZq2Knj9sGrkPzv8SVjnWwOUbxLP9hXyHAQjq5to
N+HfGkbooNHMHcTeWwd7RagVss08abL0YZ6dr7xpJztso6/o6Mhaw/7nax1YdxjM
iQW1SEhdBHGDSwQUjODI1PVq4Ku7JnIP0Djx0Raqbc3kJkufg5p+j0TbXILbphWC
GIfmfLdT
=uqMn
-----END PGP SIGNATURE-----

--uyqMtRhVnCzwokve--
