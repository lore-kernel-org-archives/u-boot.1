Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD3DC87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 16:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 042C684612;
	Thu,  7 Aug 2025 18:21:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AsYesj3+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 512AD8464E; Thu,  7 Aug 2025 18:21:22 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 193658460E
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 18:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-401c43671ecso656460b6e.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754583679; x=1755188479; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o5JWnjBLfWlx9ZXVj7EQuRFVeXjafAXsvhoH+nLeoQM=;
 b=AsYesj3+ZCmB4BI0Cjm/d/DYPVlPtsf7dMTLjms6Arjb8aYUKYF/JFk49UCPb3lMbQ
 laUS8sOrU0yuJKyxwPqDAXQmQk3V3Ovj3X86YH3URHCHxnQgbgJdQvyru4nacMx0AUrT
 ys88U7eVAFbVkY52n2HaCEuBD/fOtBSn58DJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754583679; x=1755188479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5JWnjBLfWlx9ZXVj7EQuRFVeXjafAXsvhoH+nLeoQM=;
 b=HQiXZ29sbrfuGAW9nmfeXy95mQvdD7oayIuBfhDFNnUzYA33o2ja3ivRNzE9Qovpyf
 b5xCIAHBFXPl/0Ffz42yzCgN9Ty3FN2YEDSatalJXSNuyLzO9+p0jTf8C2H9HS+dvoyu
 j3bcNt8AArCGAgaH3Bh9Z7GYuVSPHxDkqWFtAUebVKEoNksxmkGoiT4oHbFzrxVwEMAd
 ZWLoyLypJPMriRE4/3FA4sfEBfCcfCtQmNU4Qw/OxFVPFgkxmX/+87Tr/qzJvayWPagP
 WGjy12Ej5+pLrLC6n1HEl8y6+Sehcg6oIlfhIczJqrzfXn1RSo2X6Ro1Pothz3HdhKQ8
 QQcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu8Ry34cbgq1h6YqA8GPDnJe8hKiReUhjKU42wW6b4+/ttUJ/xHAQLuKy/h1tve6xU3AzdM+0=@lists.denx.de
X-Gm-Message-State: AOJu0YyVCWgS5yvEzn8mqbfji6TUAZR7Q5D/pf6TkEG6/aY8Kcm5QKD7
 dUQxuZjJaNvGW04uHH4wifLrRTKEgGkGPgIdjL2MchKIpOBuKij2uwYEYfFbFaMuaDX3JFE27T3
 F+aVS3ms=
X-Gm-Gg: ASbGncsa2OPWtdHDoqTnq9zDjAVHqhio3otN2aAl6PRtu7v/+pQ2BqrCfspZqnuSI6k
 JWH6g0yalbK4/aeS84iAX70GXNb51ucBKAljwAFay6nmeZM6AgIZzdJNO5iuhVhYBqK71Q2WUoY
 clU2UBNS++2EBEe5GPMrK+2REiTAyxA/0SPb+TIzSj5/gzEtHguaOM8VnWRHW27M4PKP1X3r4yh
 NFOTvNiYYnwMWruU6NAf8W2rVfkNP1PRiIyk7b347Ers9Pw7UHokOHJZsn24RuwEJ25F+YbVimK
 SsSVBl4V95rJE0Yq/lGuqR9NHqgufjnEjuL3YvbqoHB/iDcmim8Y60ueas5uw826bg/cwMYPd24
 9iNdAJHRyOhR+LPrPBJy9ZqVpu1zUs0lafZzi1z00dvthxHwbE6MtAPuA
X-Google-Smtp-Source: AGHT+IETWzFMR7efVMNUoEU7JIppHsd0pjgCaDG8QdfMNeLXOTgIWwmxxFFMpRGob6jI8llZJlmdoA==
X-Received: by 2002:a05:6808:2386:b0:433:ff4c:2644 with SMTP id
 5614622812f47-43587cd86f4mr2299269b6e.5.1754583678624; 
 Thu, 07 Aug 2025 09:21:18 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-434e9a5bf00sm1543453b6e.10.2025.08.07.09.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:21:17 -0700 (PDT)
Date: Thu, 7 Aug 2025 10:21:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Philip Oberfichtner <pro@denx.de>, u-boot@lists.denx.de,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michael Walle <michael@walle.cc>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] Image size checks: Remove HAS_BOARD_SIZE_LIMIT
Message-ID: <20250807162115.GZ124814@bill-the-cat>
References: <20250807102436.452691-1-pro@denx.de>
 <20250807102436.452691-2-pro@denx.de>
 <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kRfI7Lpse0NpErJg"
Content-Disposition: inline
In-Reply-To: <eac8672f-e90b-42e9-9efd-d94fcc8c1f17@mailbox.org>
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


--kRfI7Lpse0NpErJg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 07, 2025 at 03:41:38PM +0200, Marek Vasut wrote:
> On 8/7/25 12:24 PM, Philip Oberfichtner wrote:
> > CONFIG_HAS_BOARD_SIZE_LIMIT is obsolete, if we interpret the value
> > "zero" as "unlimited".
>=20
> This sentence makes no sense. Is the variable not obsolete if its value is
> non-zero ?

This is phrased oddly, yes. How about:
By making the code treat a size limit of 0 as unlimited we no longer
need to guard asking about having a size limit on the platform.

> [...]
>=20
> > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > index c2aa88f59fb..36eed766d31 100644
> > --- a/lib/efi_loader/Kconfig
> > +++ b/lib/efi_loader/Kconfig
> > @@ -74,7 +74,7 @@ config EFI_SIGNATURE_SUPPORT
> >   config EFI_DEBUG_SUPPORT
> >   	bool "EFI Debug Support"
> > -	default y if !HAS_BOARD_SIZE_LIMIT
> > +	default y if BOARD_SIZE_LIMIT =3D 0
> This looks wrong, no board size limit does not imply EFI anything.

This is however preserving the existing functionality. Saying that no,
we shouldn't enable EFI debug support by default in any cases would be a
stand alone patch.

--=20
Tom

--kRfI7Lpse0NpErJg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJTSdwAKCRAr4qD1Cr/k
CoEEAP9QSQ2gICzBXI2KUMWQBhr3fJPPzWUUSC4+TgbMVmKsjwEAvapY19mhAkPn
we08hKA3Ul0FKBRh57/wCBqjs3datw4=
=ubKz
-----END PGP SIGNATURE-----

--kRfI7Lpse0NpErJg--
