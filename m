Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6348CC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4E8381A0E;
	Wed, 19 Mar 2025 15:20:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a1wvh6yZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7026081D5A; Wed, 19 Mar 2025 15:20:46 +0100 (CET)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2938C8193A
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22403cbb47fso130586565ad.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742394042; x=1742998842; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bqmmQMrAhqt9XQqNaN9gsIpD0NEGu/higblhVEoJTKk=;
 b=a1wvh6yZqlP/o9AgnssdnZ6Lon2NZqstWI/5AXSmZPBL525Kuccurcu8exevrfUorU
 Umrqb21EICz6Tv3C1befpTCLg9/wCYTNBTdyJ1A73QZoW9Dk7KBDbjIvlTIhCzeVzJLW
 lajxgYGrSz+Z+LkO7aeXkfcYcLHI5w18BmQvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742394042; x=1742998842;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqmmQMrAhqt9XQqNaN9gsIpD0NEGu/higblhVEoJTKk=;
 b=Wkn1fPAds3jwxry9NKeBi7IEzQJOZsoi0r7gXkvrn3/3TlOY88Lb6fmtl57F5Iqnsk
 F1NA/gW6lSHOGB4dxDV2H36I/Jm2vp9zDAx++no3j9SHIuCniZnGH8N3uBEhVsVsqrbo
 FLCelUUVhwTDuttUIoxlrRrSiOn+hjndajybWXhH11YPtOeSOUAVttzwsa/GKb+7NwcL
 qvC28mZN16OC3CfqDtvG63m96l77k+jFWzyF6rZ1t2CZxHfEyTcor7NGfohy2Oip8m6i
 ZS4SZFUDLzu5uD+4Mmjju/BII6DALzyANaf483mE2BjgfldS0Szb8JJuGYSeyK5gcZTq
 NCeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtbXTMS3qM6Vm+NbiTEmdgfIGuz7XgOSx8NHPAWNRO36dHX8znosnTiUnw//6ukzu2zpIFU8M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9+IEnGxnkAGPbr4pxwLlnk2V+yJwKD0FoRCUuBy2FaYp38V3D
 MbgdV+OLq3I+GBMGXHwd2yhYSiiCGPOfyXpZ9mksfwd1p0TlF9uvRp9nHPRyrBk=
X-Gm-Gg: ASbGncuPkrh3BByfxI63BFQzJDTUgwQrJBkr4aTc7cGbB01LMCUpFgz3sGntBXg6T4W
 5bELZ493HRCESw6u4rrsGkqZjI8Wuh4lfJkZJKzAlfKmW6kyji1g7cIM8/5stUK3qgk8REzPhI0
 QU0TuMzDSVMbL9DXak19S/5fROrrX7gS/eUEt9tZWm6yly9BVRjpV2cnplpqt5BS4Yp/hrcoIJK
 A0lqEATbC11dMY1P/Ipp6ZkTR6PbVQz0HEngqQqyNNiQ13NaC47uwVksh8enQzt7Lf5/2XoaIc1
 4pROkMHgYywfS7q57pjM2kawfUm1d6RHTyJXtNEu+/TtwA==
X-Google-Smtp-Source: AGHT+IFb8+lFaltgPjWMvYnRFn6tdNk95l/jBcepMTT6Oyjjsy1jPwqKFoiQo6KxhxO0rqO0S+B3ZA==
X-Received: by 2002:a05:6a00:3cc3:b0:736:4b6d:82dd with SMTP id
 d2e1a72fcca58-7376d5f26c5mr3860351b3a.2.1742394042390; 
 Wed, 19 Mar 2025 07:20:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711695493sm11978107b3a.137.2025.03.19.07.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:20:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 08:20:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH 6/6] lib: Provide a signed version of simple_itoa()
Message-ID: <20250319142038.GE2640854@bill-the-cat>
References: <20250319115911.2204045-1-sjg@chromium.org>
 <20250319115911.2204045-7-sjg@chromium.org>
 <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gYsP2tCsJ5k3V4Z5"
Content-Disposition: inline
In-Reply-To: <ABCF9413-6C51-4EBA-9907-95C5097A8D86@gmx.de>
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


--gYsP2tCsJ5k3V4Z5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 01:12:30PM +0100, Heinrich Schuchardt wrote:
> Am 19. M=E4rz 2025 12:59:08 MEZ schrieb Simon Glass <sjg@chromium.org>:
> >In some cases we want to show a signed value to the user without needing
> >to use the full printf() implementation. Add a new version of the
> >simple_itoa() function to handle this.
>=20
> Where will this be used?
> Why can't printf be used?
> Why would this fit into this series which is about test improvements and =
not about functional changes?

It would be more fair to say that only one patch in this series is about
testing and 5 are adding otherwise unused changes to functions that
presumably are used in some later as yet to be posted series.

--=20
Tom

--gYsP2tCsJ5k3V4Z5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa0q8ACgkQFHw5/5Y0
tyx2sQv/SgNRbYy5EvdOqB4VAnNVeCTrmv7cPGrwDqCsUJ3Mn8GQ2M4AdaLFpOpS
r88AIuuz08LpGeX4COJgyllSI3TBcmSGPo4HDOVLkLIv/dc6IymYNJQFu1DqKlx5
S6veudmOe/dYTrTqHtsI3NbdDdi7y25HS+CJnrw/9rGOxoB+idgE6ABy+PCoLJoC
xXB4zXRZ2OzPbWcbEl6vAYc2aKPGy2ZpPIAt4z/o2LjBa3XexmUYxzW+sxdTtMIK
M16jh2CGWrd+UsizVLSfobLDPI8ug+mcvt7dZyL/djLqKsQiavcinKe3kWEOE5sC
Q8a/BO/zUSSEYez2nsakiIdENCznuVhGYrH2Vt9ORAbEk2caODfgyakOEkDaNYt6
ml9PeLkYtA3QVQn5MRNWeWf0LtK/a9uHw3BLf7Yx7QwL5KklLvmZQRMkMVZaLP0W
GL+RZVyVgphtZf4/aX2SuOVv1DMI1uTGsrleBm3MXgaHqWhFWMk/Lzep1uKF6iD0
wZc+ueRd
=PH/m
-----END PGP SIGNATURE-----

--gYsP2tCsJ5k3V4Z5--
