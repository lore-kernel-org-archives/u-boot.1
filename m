Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF32C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 20:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E10084514;
	Thu,  7 Aug 2025 22:11:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ujzzFjC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F4173845B0; Thu,  7 Aug 2025 22:11:48 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DA2B83C65
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 22:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-30b947772c5so864683fac.1
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 13:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754597505; x=1755202305; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JxHkxEYKqgtdnp03LpHTAuP5yC+kfdjc8sClEuNHmj0=;
 b=ujzzFjC8TSJOoGRumic4geZHnS/UjZkOMvnfWXX8WGOKqQpT8SeF2KJXg+29LHEfs0
 qaA3ljYV3cRxUoZ+cH590TrhxADogCaKraPW2Tg4m94OmCHRMBbkvadOiHFQk9/1FABc
 6owyFHXRh1ekxCDUN4DPvVu/uyFsrnHT0Pxd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754597505; x=1755202305;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxHkxEYKqgtdnp03LpHTAuP5yC+kfdjc8sClEuNHmj0=;
 b=iFcSiZo5p8ooFbRkAO+EPBpNjpmt+IiXe6Ps9kMwOvCuVqKLktEWyRlqN1C8LKLSxh
 eOo5ORrXTE7NJKuce2P59ZAr2CTb3uGZ4TCaP6kVSZf7iAJoWG0dG6I2RW37Y8fhNHFN
 mCabzfXgJFlpE4TIugU6cLccIgMRtdOA2gCltVMeSpDLS3rVoIkkLo23Cu3UHIyfI1DX
 I/DtNaJh4QgstzKRuNPji7dInKnyGAjrowmZjRunN3TP/tqCMlzldpWBbK0pG9iHZEov
 fmGjKrAi9WMueLT9njZbDH2zQQ2eM1erIXFiD14o2/Z971xMBAD3IbopBOcgXrY2rLN2
 HwTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuQ+OXMCp2NV0zeJczoTHFWplImEZaJ06lFBhIJ3zhbPniHJpmoDM/VZPWppf+ZlUZCGRIYv8=@lists.denx.de
X-Gm-Message-State: AOJu0YwMDR0+Im0MaUljJvpLUJRkL8b7qVEqnekFPNNTxc0FpP7r2o80
 4mSjkUNJLhlrLCaELIt9I2xM1oa8URQwM93Y8XJ1APtYkefEuSfuD1COkyeTk5KQkdI=
X-Gm-Gg: ASbGncsY48WsL+Gfbp0KEiOmDZ7EiW/k3vdeuEr6YNkd1ZXZ+pghVELqZlYdKThAw3L
 4nTMV6fGXP3PJUz5ewjLGcvpVMUSfznyCkclKOzt6I3P/JSz5fqaQGbQ9jpAQHEqlvVmfccubx1
 kF2/liQoaY3qOuKiK9id1Aaezt22T2XLh/CKlYoCZGVQmIU55/EjUgINdFIzxE71OMTglafMmo+
 ti95lnld1U9rf01oyupuK78CiQLsLSyJUrwbi32Qj3yVWKu2cWdj/lWlUKM6HoDtsxkyei10XDt
 HWlDTqxctl+PeDFMpXDPzO0JvgH/acycEdcGa4+X+W6CNS3/Wq+Xhs4IXdnISUoznXfdt43kkog
 BYArHqgMINtJnaullnp1vE9icrgGWMyejijTsXeDzjFxffsf2XZ55Nbfx
X-Google-Smtp-Source: AGHT+IFmKV07d6g5RVUMKdGZCFOxcWqCkxY2gk/AHKXiGTBFW4PiWFBOuikK1m/L0cGD2Xtz+eUFfg==
X-Received: by 2002:a05:6870:b529:b0:2d5:2955:aa58 with SMTP id
 586e51a60fabf-30c20b4fc61mr490040fac.0.1754597505169; 
 Thu, 07 Aug 2025 13:11:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-742fcd407ebsm1678970a34.34.2025.08.07.13.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 13:11:44 -0700 (PDT)
Date: Thu, 7 Aug 2025 14:11:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <20250807201142.GC124814@bill-the-cat>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
 <20250807162115.GZ124814@bill-the-cat>
 <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="igX851Rmz6Amzxa3"
Content-Disposition: inline
In-Reply-To: <06dd9037-af3d-48a3-974e-80db481c7121@mailbox.org>
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


--igX851Rmz6Amzxa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 09:41:34PM +0200, Marek Vasut wrote:
> On 8/7/25 6:21 PM, Tom Rini wrote:
> > On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
> > > On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > > > CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
> > > > "zero" as "unlimited".
> > >=20
> > > This sentence makes no sense. Is the variable not obsolete if its val=
ue is
> > > non-zero ?
> >=20
> > This is phrased oddly, yes. How about:
> > By making the code treat a size limit of 0 as unlimited we no longer
> > need to guard asking about having a size limit on the platform.
>=20
> 0 shouldn't mean unlimited, that is just fragile ...

That's a standard unix thing? ulimit -c 0 is unlimited.

> > > [...]
> > >=20
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index c2aa88f59fb..36eed766d31 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -74,7 +74,7 @@ config EFI_SIGNATURE_SUPPORT
> > > >    config EFI_DEBUG_SUPPORT
> > > >    	bool "EFI Debug Support"
> > > > -	default y if !HAS_BOARD_SIZE_LIMIT
> > > > +	default y if BOARD_SIZE_LIMIT =3D 0
> > > This looks wrong, no board size limit does not imply EFI anything.
> >=20
> > This is however preserving the existing functionality. Saying that no,
> > we shouldn't enable EFI debug support by default in any cases would be a
> > stand alone patch.
> ... fragile and confusing. HAS_BOARD_SIZE_LIMIT is at least clear about w=
hat
> it does.

I don't know how one is more or less clear than the other, sorry.

--=20
Tom

--igX851Rmz6Amzxa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJUIfgAKCRAr4qD1Cr/k
Ch2QAQCi7qiN655sjrr9J8b6GDMW3aTU/F7h/Snfk938R8VaBwEA8CG4kMb25q1w
2uZRIpHT0Qn2YjhixwDhpgDuSs1Mkwg=
=H10P
-----END PGP SIGNATURE-----

--igX851Rmz6Amzxa3--
