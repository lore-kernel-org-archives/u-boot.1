Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EFDC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 14:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A028763A;
	Sat,  9 Dec 2023 15:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qcbHI++4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D79848764D; Sat,  9 Dec 2023 15:10:52 +0100 (CET)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A95487635
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 15:10:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-db7d198e791so2649378276.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 06:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702131049; x=1702735849; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U0iRBgYGTI1FyZqtidCMjdSWUTO/wwvVQHdKKzKXxGg=;
 b=qcbHI++48e9rNa03lfdfNLbJkWi7Bcj3Taadfoz7ZBVtEc7zYCFkdBF9w2YidZ1gBt
 n5K/aw6nSJ8Zxh9UQAOxuh/d00JCdR99sD4Pb/x5h7EgKA7YTRteMO2Fx/AP/Y2MR76q
 q6tGO2L1K+mXqId69pPIBNbEVJip6o1Kj77qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702131049; x=1702735849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0iRBgYGTI1FyZqtidCMjdSWUTO/wwvVQHdKKzKXxGg=;
 b=vXhGQoo162Xr0w2v1JGkdvFSpr+P7Snq/V/YnY+am+oHifAjVIzbuWOvZd4zVyhI+X
 KGElzhFwLSkWtJXeg65yoofymHi+nD2Bf1Zc+CTxu1b2UUq7gj/Pb4QcCsacnCWWzV9N
 5QviE0PpAMHNaZ+Kf9sdwzUU3qZ6E/RaqUjgT1gWbxsfIaf3g8nf0y8591PNFDPcDPSn
 0iUvVCcVIG35vtpyDMVyIq1BbbCgHK7dYhiKgQQWERI4LtdlQ468f8W649ov9DOf2Twt
 u5ZgCY/CjFH4z14zk9T8ZvZPoPX1LFNUNwtic7IzjTT1SqNfhIACT1WwH/RCADrf9SiU
 1Crg==
X-Gm-Message-State: AOJu0Yz0DyyApI98Fey7hLncpH3GTum9XGftFkT7IKOSjl+xu1j4FC/d
 +sfqFK9sCpQ5QCzp7bEUGT5S3ybbTeFTd+C1AszriA==
X-Google-Smtp-Source: AGHT+IFr6nKBNFcEDCNMNA/JGl0BZo15cCaXikBb1/sf1iHRLMtkHZG6/YiIMY7DhAPjkAbsAiCrFA==
X-Received: by 2002:a25:e7d3:0:b0:dbc:6e8d:3f0a with SMTP id
 e202-20020a25e7d3000000b00dbc6e8d3f0amr94935ybh.13.1702131049283; 
 Sat, 09 Dec 2023 06:10:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 h3-20020a259743000000b00db41482d349sm1268054ybo.57.2023.12.09.06.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 06:10:48 -0800 (PST)
Date: Sat, 9 Dec 2023 09:10:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-gitdm PATCH 2/2] Add some more employers
Message-ID: <20231209141046.GE2513409@bill-the-cat>
References: <20231203044719.667116-1-sjg@chromium.org>
 <20231203044719.667116-2-sjg@chromium.org>
 <c949346c-228a-4733-87ce-14a8e62d6ca2@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SGqU73f9VDwwCidP"
Content-Disposition: inline
In-Reply-To: <c949346c-228a-4733-87ce-14a8e62d6ca2@gmx.de>
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


--SGqU73f9VDwwCidP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 09, 2023 at 03:06:05PM +0100, Heinrich Schuchardt wrote:
> On 12/3/23 05:46, Simon Glass wrote:
> > This looks at the top unknowns:
> >=20
> >     git log --pretty=3D%ae v2023.01.. |sed 's/.*@//' |sort |uniq -c |
> >        sort -nr |
> >     (while read count email; do
> >         if ! grep -q $email u-boot-config/domain-map; then
> >            echo "$count $email";
> >         fi; done )
> >=20
> > It reduces the (Unknown) count from a third to a fifth.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
[snip]=20
> As I have a .mailmap entry maybe you need to add:
>=20
> # Heinrich Schuchardt
> xypron.glpk@gmx.de		Canonical

Please send this on its own, or if you're feeling empowered, update all
of the Canonical people / aliases. Thanks.

--=20
Tom

--SGqU73f9VDwwCidP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0dWMACgkQFHw5/5Y0
tyx8Mgv+IrBJUoBkOdQU9s41Qv0w5aZC/scn5E4L7p33ckTmHYh0/ZVWy/xfDxoC
drUPt47NNAYag6mLDavEeTkMT+dQiMcwi6Ku+ZOz5ianijV/PSwaPS1ijQxuZxX0
CFrb6F86nqFrcKjgjWSDo5ha6A1GZzra60pW0lRa0PmB+NFOgUfiM8krn0FY6Wq7
DbGSwI4CKjZM0GDSqsneBVlX2sYDLDoRklI5w8rBTqg7nD+Xn7vGQNCvXgAVe7a6
xIREDmOb5hOUovUoZVwL1SMFmQxf8OUv5WD4Pyk0NQd/dC+w0RpedKoeF/n2Z/Si
8g5ww0rL8jWoZANbEHF0S7VKZrmpAj91F4BPkyscOt1Fkvmc9xTDoq9bdInz2bFK
90nTWOuhHZs8Wub/kuZ/6rBP3AI4yFFR2D3biq++YI0fse4l3Bpk5ok6B4t3UO9D
urrYtDGjyEpV91/Q/a3RGq64sJh0RcZbpJpou/wr/Ze+LdzstDMTNDPI8CdynAsQ
SGjgudLI
=YC0h
-----END PGP SIGNATURE-----

--SGqU73f9VDwwCidP--
