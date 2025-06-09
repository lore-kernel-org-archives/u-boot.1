Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC2BC5B552
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 14:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1BD98144A;
	Mon,  9 Jun 2025 16:59:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aW4ZzC4q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B777882B00; Mon,  9 Jun 2025 16:59:25 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90E1B811AC
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-407a6c6a6d4so1291289b6e.1
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 07:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749481162; x=1750085962; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8YnccE1Vwv+M/sgQM+rL3xXVFB+Nql1VQM3KDJDvVtA=;
 b=aW4ZzC4qquzp5AHNwIC30Y3Mz5/OpEyWcCNcbDnmUYtihV166vSf0F4pLiOHGQ3KA9
 V3QzuPeNtXlORWHJGre/N67HNFpbH9meesTnyNR+NIasbSXYuqdo+71sKOstwnAQJ0UH
 UnIZxNxk7vXRJjTZJPQ81iQIZxfo/YQFWjl1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749481162; x=1750085962;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8YnccE1Vwv+M/sgQM+rL3xXVFB+Nql1VQM3KDJDvVtA=;
 b=BJu6K2WGG0XKwTgBNCWxb4kF9FBW9RG//Lxp1qyVdBsoIJGlIGD0fLylUCv9YtMFPN
 FbIA/WsftFQfmj+USZZ4+uIXBt3qPu1Echsi2IMqhhmsmCq6UNy++9HNNALfFNFQfpWQ
 cU2NrnJcFOYn4SZGrYOLZzREoMQmvwxlqIxU4S0z/veT7QSIRMMWzXPiYLIfbyjnnV44
 Q9cnSRH/Hfjvp7o2tnKW1iir8/e/10XmahKMwHT08KOpxP85elnR+AUOOZ+2/+dkDQLE
 2pJC61AN1XPkOD8hj80hPpTG4IiJn4MFuSR9jlmXL/TfxXJJIUZRenkyuzDrssXFJppm
 w4jA==
X-Gm-Message-State: AOJu0YztPgDhhXyQngRhrREV6ja9mx7r79b8jc5ab8xTpy37i8r0jafd
 K5eHMNc6AjPEsAl3rQMF6NTxRQBaeVFRFITT+NZdrvOTkcRwiWUHvoGqVSc7QM/XHNc=
X-Gm-Gg: ASbGncuqonUrXjfN59ij8t9rPhgpAePKnbC2p/Lb5c9VuvHqEqbobprsosT26+mzzcr
 gPQhZ3UiMPqUMT4opgxrUkmO5wDUnf5jYWA5qi5d9psVIxNxU1qMHQNwBXO5mBLXvnCsgdIgeMH
 6sKtkUYQnwxIAQQFeaXwX2SGd0tZMGELOTccqiIeeoEbkYl724RR7PKFkFl+hsC3bm0x1lO2/gD
 tH6YmjX8M6YrrpXfBjKHJNS/YI2E+o4n31OdSlne8G3nAJDwTHMgbGe/wtOOJpz4lAvEU/ODloP
 5Myu8NvwgnhCY5xw4JnWWzqchzFAlV8XRPk7UqiN0ahhRIpS7oT+QwtB2xYoWZ2Jj3xkGqwBhkz
 ED3uY2O997h4D4UOk0RjxJAY=
X-Google-Smtp-Source: AGHT+IH1bPI3ZYMfAMxqwqGU6drDErCGWeQyi94A6isxM6HcLAmj1BL/IKu6yYw4ElnWF3gzlbahCg==
X-Received: by 2002:a05:6808:4fe3:b0:404:e102:f682 with SMTP id
 5614622812f47-409050de0d0mr8371656b6e.22.1749481162225; 
 Mon, 09 Jun 2025 07:59:22 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7388a08979csm1609625a34.62.2025.06.09.07.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 07:59:21 -0700 (PDT)
Date: Mon, 9 Jun 2025 08:59:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v7 01/10] spl: Kconfig: allow K3 devices to use falcon mode
Message-ID: <20250609145919.GN1382132@bill-the-cat>
References: <20250603142452.2707171-1-anshuld@ti.com>
 <20250603142452.2707171-2-anshuld@ti.com>
 <20250606190625.GZ1382132@bill-the-cat>
 <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7PCgSEeUWj2X9m7B"
Content-Disposition: inline
In-Reply-To: <DAHZOKDJ7QAM.2MKJ1WRFIJPAD@ti.com>
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


--7PCgSEeUWj2X9m7B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2025 at 05:38:37PM +0530, Anshul Dalal wrote:
> On Sat Jun 7, 2025 at 12:36 AM IST, Tom Rini wrote:
> > On Tue, Jun 03, 2025 at 07:54:41PM +0530, Anshul Dalal wrote:
> >
> >> Falcon mode was disabled for TI_SECURE_DEVICE at commit e95b9b4437bc
> >> ("ti_armv7_common: Disable Falcon Mode on HS devices") for older 32-bit
> >> HS devices and can be enabled on K3 devices.
> >>=20
> >> For secure boot, the kernel with x509 headers can be packaged in a fit
> >> container (fitImage) signed with TIFS keys for authentication.
> >>=20
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >>  common/spl/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>=20
> >> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> >> index 77cf04d38ed..bc5a334a1c5 100644
> >> --- a/common/spl/Kconfig
> >> +++ b/common/spl/Kconfig
> >> @@ -1190,7 +1190,7 @@ config SPL_ONENAND_SUPPORT
> >> =20
> >>  config SPL_OS_BOOT
> >>  	bool "Activate Falcon Mode"
> >> -	depends on !TI_SECURE_DEVICE
> >> +	depends on !TI_SECURE_DEVICE || ARCH_K3
> >>  	help
> >>  	  Enable booting directly to an OS from SPL.
> >>  	  for more info read doc/README.falcon
> >
> > I wonder if overloading ARCH_K3 like this isn't a great idea. Or perhaps
> > TI_SECURE_DEVICE is too generic a name. I kind of want to introduce
> > something that means TI Secure Boot is supported but also Falcon is
> > supported, and then use that as how we disable in Kconfig various
> > insecure options. And I assume that it's a matter of effort not
> > technical restrictions for supporting falcon mode on older HS parts?
>=20
> I second your opinion here, the falcon boot flow we do have in K3
> devices is quite different from existing platforms but still enabled by
> the same SPL_OS_BOOT config. Perhaps adding a config like K3_FALCON
> makes sense here.
>=20
> And yes, older HS *K3* parts should be able to support a similar falcon
> style boot flow with not much changes to the k3_falcon_prep function.

Maybe we need a common symbol for things that are common to all TI
secure devices, and other symbols for K3 or AM33xx (or whatever is most
appropriate for that overall era of parts).

--=20
Tom

--7PCgSEeUWj2X9m7B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhG9scACgkQFHw5/5Y0
tyy27Av+Mp7u3IOPc+y3mi7aR6a+GPT7rNmbpqBRwMb8zzT7lhMBsr4Z5+fIgScu
Q4GS42rYxgcBwvjPVbRHGGKtg2KbFvVeoEjqSx2Y+I+qjWm8aybHax7OQD7FntU5
USv+/uJDBZ9IJxJU+ZAAzOWjXX7h060qxPGNozMQ/KwRsWnXfrRuwIpSDo+U6rTC
k+T8nSgY/QJpQZxaAUZj/FuwX0NaC/0DWkx5AKjUI7SU3dqusxJT+F9rKvfA2vpJ
RaP9Tp9+1ObQSrGE/2hZoL9Qjs9p+vhYOrPZVxvr2bu5sPt2kOIhplrCFp5XIja3
UjNmDd6s/i7tt/KeeP1kAUT1/kYrlZmCJgy+73EDTFPmN/EQcyqJT6Z/IzdYgw7L
w/KNqqqZ365m+P+kFTk1xHWHt3HycCCLAJ/UJyyIcJiEyxWOjvF6WzutwP1/usxk
MbGHlEO2j9N7uMGIJ6tsPnDM7sl0W8O9YUj2eL4n2mWEzOL/sKQMv2XmeycTiblf
hSMOM0F8
=nVy8
-----END PGP SIGNATURE-----

--7PCgSEeUWj2X9m7B--
