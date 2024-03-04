Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DBDC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 13:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9A187E63;
	Mon,  4 Mar 2024 14:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SIUudn7i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7533E87EBB; Mon,  4 Mar 2024 14:16:27 +0100 (CET)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54F17876E4
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 14:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-36523b9fa11so19481695ab.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709558184; x=1710162984; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CaSxdoVdRKDXJYWCt+6yE376WTtTrNAjZB+dfl8Rn4c=;
 b=SIUudn7iCVhXRLu36c/BZ/HjMkgxhfBYE3g4vvGpFGWrdwP//YNarVoRqM/nuU4gtx
 P2+1Plnivu26NAPuPUd+ht6fi79Rxu0YzQKpK52YojR286Q3VfHuach7SAf1CVclSPJB
 5aFQegaLOM9e96vDmd+VuAZ0LVC+qkHxSuNEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709558184; x=1710162984;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaSxdoVdRKDXJYWCt+6yE376WTtTrNAjZB+dfl8Rn4c=;
 b=Ee0cGaS9CVFATK1HIeZJ319+ooADzQBMOdpAm+yiC3gyftJEkutexXcQeCtWK3hVIv
 Mx44uSMmG+9UFZQr4ag9RiTycaNa1Quwc8ePE0ZbV+uwjU9V6xzzT9aM25RCsdlANi/j
 wOZLPp3wfvhnu+rPx9l+H64rZQPjR2uZnhpoPT/ewrNGCrZfbR77Qkwr/ZHuo4a9Sm36
 wSto7xGwD8dGIZ7+eupixSGPNbkYbROy7A/Fk+njVCfvkDjwbm0bu1e4IFLX8/o57s6t
 X2GCCNjaGxPQOiAG2EKiUDCDcgi3aAo2voNTU5yJduDiF69rtEuSdIF4xLB0kGKuH4cu
 UxIA==
X-Gm-Message-State: AOJu0YzGhjPRVdy+uHD84+a502DB3G9PX1O2P0tp/ag+xpSghex2l6fz
 E+RH/PGwAU9/eb5Gk8brlzbKYT4TrsbJYBeOdPAhNFHYXNU8kdE71TxT3IkF3Z4=
X-Google-Smtp-Source: AGHT+IF1hep7hf08Bpj6xUBVcdIFvUe+dBAIzORDuGSBVgs491UpTLhemNDeysLTorMzYRd5CNHFdw==
X-Received: by 2002:a05:6e02:1687:b0:365:b506:509e with SMTP id
 f7-20020a056e02168700b00365b506509emr14184717ila.17.1709558183992; 
 Mon, 04 Mar 2024 05:16:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 p8-20020a05622a00c800b0042ef3d1934asm730747qtw.60.2024.03.04.05.16.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 05:16:23 -0800 (PST)
Date: Mon, 4 Mar 2024 08:16:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: invalid escape sequences in
 maintainers_include.py
Message-ID: <20240304131621.GD1523872@bill-the-cat>
References: <20240303134022.33062-1-heinrich.schuchardt@canonical.com>
 <20240303141447.GC1523872@bill-the-cat>
 <06628723-2b72-4398-9068-a29ece9eb4df@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KJpi2M1a9O6saE+D"
Content-Disposition: inline
In-Reply-To: <06628723-2b72-4398-9068-a29ece9eb4df@canonical.com>
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


--KJpi2M1a9O6saE+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 10:34:50AM +0100, Heinrich Schuchardt wrote:
> On 03.03.24 15:14, Tom Rini wrote:
> > On Sun, Mar 03, 2024 at 02:40:22PM +0100, Heinrich Schuchardt wrote:
> >=20
> > > Update maintainers_include.py from Linux next-20240202.
> >=20
> > Is there no better upstream tag/commit to base this from?
> >=20
>=20
> The relevant changes in Linux were in 2023 and 2021:
>=20
> 86a0adc029d3 ("Documentation/sphinx: fix Python string escapes")
> 4217e5074f33 ("Docs: drop Python 2 support")
>=20
> We could also refer to Linux v6.7.
>=20
> So maybe we better copy these patches instead of only a single file.

We can sync the whole file, that's fine, but just do it vs one of Linus'
releases and not a -next tag, thanks.

--=20
Tom

--KJpi2M1a9O6saE+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXlyaIACgkQFHw5/5Y0
tyw6yQwAtjpSlasqVdsYfTuV13QLKjym/ChIUq+7Kt6UmayH1zcR0S7pdDoXbEKA
3SDVpRUjfZVfgMdiMWmdWaABsctTYsFzQBW4TzAHIvYy5T9fuBnR+3N/rw/LKOYi
bNVitj1sqeZUHEIg585NaUrZqtCTHxNMOuhe6d13yAuFR5NVBYJQBNwEfXQzgl6e
tvJlbWVFTmN7siVQWXWefiQEtz9msWdZjgk7YTdnykqLg0fercLMIRrjyVGaIcJd
PpzkjhMTaxXZZth/J6rlFysYYiTigCGo7CyHPiYicu+GEJtk864RK9UqBq7yR59e
in/Vd3ns7/+KGugJe+umnQbyXQCMMkwVDFu4TsbhNZKPyPHHBobfElqBYPlvsyxn
rEcxsrsYQHw40MFuL/HrVSXFXoFo+Rs7NeB0cufpYFHRpY/gv08REgSooavC1aQZ
e8YI7ESonL/jEPNYjDm2V2jkO2Ue85aal/7f5Y8lZWv9j1+TicV/acdZLBf1HOdc
PAKBDYDr
=rbDP
-----END PGP SIGNATURE-----

--KJpi2M1a9O6saE+D--
