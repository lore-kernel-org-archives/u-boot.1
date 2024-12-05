Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CC69E7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 01:30:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EA88904D;
	Thu,  5 Dec 2024 02:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EX6msRDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 98BFF89089; Thu,  5 Dec 2024 02:30:27 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A7958903C
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 02:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-46695478d03so5423621cf.1
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 17:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733362224; x=1733967024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/f2fg/ZStm5aHyBNHwWP+kiUApI/GJNj/ncQ75Jl4aQ=;
 b=EX6msRDaOo7fjEcWfLwPgKftQ72r7Q4tnWOy/XBJr/QNzmmAmcv6QwuMjU3Cula25f
 Q0/O+8LqQR2z2+g9pIrALLljxGQN0ImjyVa81CI4Bj8wOuX1FPxd7lh35GgS5I2U6s1W
 7HCfC6hHLFL0SgxOjrhpZKl5N+5nY1lefZdv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733362224; x=1733967024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/f2fg/ZStm5aHyBNHwWP+kiUApI/GJNj/ncQ75Jl4aQ=;
 b=cBhJ77rcf73dij1Ef53qsphPkcGwkO9q8YGKwsjqvebelJxKHtdyvX6lBhOY+nb/5Q
 71tYroC+Y4xMOCDaijV7y8oZWnGaf9SDUZmw/r6USJwJsoaVMQoyoVWaHJUbWSJowK7m
 Fk3OzEp+wY8ZbtMn5wR8I2C+TL81LAOM54IsE2hMVUBsw2H4HWNYFxhTRoAsYGi0h4ol
 7Yxnt8/IfjvsypSGr9gokaVFHE3SV/ckZ3QQdXmL77Xo7u5kAJC4Tz4o4ZjaM/0urL/Y
 SSLUmBUNS/DPd1eDVMAIogaaEgpulZ1yGmG7RGSV88NvD5uj1IlI1/x8B83CHVVoH4YX
 jiFQ==
X-Gm-Message-State: AOJu0YyZTEH+caQYj6FvJw4KIL1VID4TEjP41dq8bE52tLjE+mSO8ltL
 KqlseMlvc6XOlX4VxjD/4KhZp0PtQUs0VsyRJIhEEZJBuCymPof6ZBai/Uq9yAs=
X-Gm-Gg: ASbGncslUvjTVBi9aiMcPcJMMvgXpz+Wii7OnjK8InBM0XmDwJGGnH2AwdcABRyazZi
 1rvwmYD5pzA2q93m5mfM6tsIIVPApW/E4Z4Jxp8NyhpwGch+XajPejfrNJZQ15EJwR/9/nEydTL
 Jnl580WQtSktjk08ty7yGNyONKPe8sgCUtsZBRXLcTIbDNlnAqupNCqJU4tiRnay5zmE6pZe11I
 1S1SYoW7Q6U2ZwNNnc/+POseUnHsD/R1yLeMz6CUI4SAleB7Q==
X-Google-Smtp-Source: AGHT+IHyGcg85F9xn1+k52isAVPrSeX98N86AaSwlqDa+RqDkTAFI0kdxkSVH5Q+UP1pNnKVwA2miQ==
X-Received: by 2002:a05:622a:1486:b0:466:a4f4:8957 with SMTP id
 d75a77b69052e-4670c141278mr119678211cf.21.1733362223893; 
 Wed, 04 Dec 2024 17:30:23 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297be1ffsm2264391cf.73.2024.12.04.17.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 17:30:22 -0800 (PST)
Date: Wed, 4 Dec 2024 19:30:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jerome.forissier@linaro.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Subject: Re: [PATCH v7 08/14] efi_loader: net: set EFI bootdevice device path
 to HTTP when loaded from wget
Message-ID: <20241205013018.GA1377816@bill-the-cat>
References: <20241204030530.2099776-1-adrianox@gmail.com>
 <20241204030530.2099776-8-adrianox@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lSY4QgoYU3EmfOTJ"
Content-Disposition: inline
In-Reply-To: <20241204030530.2099776-8-adrianox@gmail.com>
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


--lSY4QgoYU3EmfOTJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2024 at 12:05:23AM -0300, Adriano Cordova wrote:

> Set the device path of the efi boot device to an HTTP device path
> (as formed by efi_dp_from_http) when the next boot stage is loaded
> using wget (i.e., when wget is used with wget_info.set_bootdev=3D1).
>=20
> When loaded from HTTP, the device path should account for it so that
> the next boot stage is aware (e.g. grub only loads its http stack if
> it itself was loaded from http, and it checks this from its device path).
>=20
> Signed-off-by: Adriano Cordova <adrianox@gmail.com>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

I know this is applied now, but after re-checking some things in one of
my labs, this breaks test_efi_helloworld_builtin on rpi_3 at least (and
possibly others). There is no output from "bootefi hello".

--=20
Tom

--lSY4QgoYU3EmfOTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdRAicACgkQFHw5/5Y0
tywojQv8DeDvA51aKbu98hWHcMmWxxvU9jIFh+AOgRwzUfy5y5V8yoM2lxMCrzPH
n0RUMoNNgBzfPw+B0HVJKuGdOvPk98dTIxp4CE1gmlvJZ4CvUntgK60bDhz9rFgf
K+pJ48HmdPXgd9ogW1oGVZzKpMmMy8JUqQMtgfbymlW2zH1KzCFEpsvdfR6ubpBH
fflUr2OLg8qpKwQNsmKXl19Ph94n/gKANQ5zDILxKX4j3n+D+jsH2rUggJ8zuMBw
eV4AsS68yZB1JLwwT86EKyFbvq7SIm93PGFBZtYwpJD+NRCQJgapNas2pYimLTPu
mwEAuIJJ0A0y3Rw/Wbb8V7KY4egG5MfLGeFDTy4oM10mDCnFK4SUJardQBOBh0Jb
WKpuOL2HzgKoxWgzGsr+qsZ5NxeIUsX3jToWD6jLaegGqgH0COsCJbiVPFDuM43H
Px4gq45txajBPbCu+F7P1ckAkOA0ic3oEOSgyiTmpmSzAHzN88Le49+YYNz4LPqa
Yfp0MREW
=lcXr
-----END PGP SIGNATURE-----

--lSY4QgoYU3EmfOTJ--
