Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3316EC02194
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 23:24:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98C6780F3F;
	Fri,  7 Feb 2025 00:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jZ3U5oFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D8880F42; Fri,  7 Feb 2025 00:24:21 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8889A80F1A
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 00:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2f9d3d0f55dso2343206a91.1
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 15:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738884257; x=1739489057; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cii1RPh7Xsiy9cXbzLrSnU1l2wodjdq7qiSiuf650Nk=;
 b=jZ3U5oFOnkENRIZdPu9o1cocDHXrUeXFc/aW1YqQe9CjpxAqRvZ0DeDAdZdXJt2RJW
 EcrDSQD2LWjy5xf+hjPQXbHhEmm/MmDdSGlQ3hVSBN4/JC9DPTLo6A1FARxJB9+PQCLg
 wKfSZbw7Ld5v3fksiRozS/1NZbYECnDVf7Z2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738884257; x=1739489057;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cii1RPh7Xsiy9cXbzLrSnU1l2wodjdq7qiSiuf650Nk=;
 b=MKkVug94cpiq+QaEf4O3wD2DEFGzniYtJgyEfwPlmk7hT1K4o76bOUT/EUbJfTXcoe
 64EBqhUjtypq6G7/c0v4AIbZpBGwvGzd3luy0NDJB7A8JbSp6iDCO+VttrjPmqcfMSDk
 k5DMc0ZfvxIN4yJnZrXzrn7jfUKNlZzjL0Qm3FDyaRBpVb3noHxCDzPh1fD+QD9qhq7I
 xltVft815v9l810eVnz4DuZns9f2RdJWm2OPB99v1feuZab/ZNnV7che1pXq9O4FHbJI
 5r3haV7w4QaMQFZehR+/716B8LRW2JgGKn+YvY6wpfDkY65YimygzYhHvSwkttEadvo3
 3upQ==
X-Gm-Message-State: AOJu0Yx23GcCO4QYL3NOSC83l+arSrI7ByA5GsufN0E0I4VIevIFjHcF
 23MSZBaRhSZmbgPFUeYNBVYkGk/+1uI90/6ln8Q//rKLjCO4jN9O9LYJfjS6kNg=
X-Gm-Gg: ASbGncsCZmuJnhEtjllb3D9vz7/o6kjY9LwSiLqU8r+envXJdn/3Q5AaKfrPJ/2OgRL
 imTBOCkODxaIN37HjNB1/F5OuFJRUNcZev/Q95X10Eyl8/+2HyT8UcTq8OYsCT2UlnIE7bOausN
 o14CBYBTiEOUD9RMcSq+waIqBgbgmOQtEkGGjkdD1c9wk9D0fzIpYRIN3Zlym+IDRc+csw5QMFr
 w70+dIOPx0NnG/mFCEBsIYM1vyXVIB+kLh9pR/TFrF606Dbgdhdr5dfMUsIjO1CnYax5gmVaqbL
 HUR3j3pSP6qniDU=
X-Google-Smtp-Source: AGHT+IH9Q4JIWYCdQmyHcX93SXiPQYjKx/h7WSdrCA6AXbrekIjZ+7cwNQmDMWGPz/xuqLZw+OtA7A==
X-Received: by 2002:a17:90b:184d:b0:2ee:fdf3:38dd with SMTP id
 98e67ed59e1d1-2fa242e5d0dmr1144187a91.23.1738884256967; 
 Thu, 06 Feb 2025 15:24:16 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa099f4d6asm1990851a91.6.2025.02.06.15.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 15:24:16 -0800 (PST)
Date: Thu, 6 Feb 2025 17:24:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo <ycliang@andestech.com>, Matthew Garrett <mgarrett@aurora.tech>,
 Richard Henderson <richard.henderson@linaro.org>,
 Rick Chen <rick@andestech.com>, Sam Edwards <CFSworks@gmail.com>
Subject: Re: [PATCH 14/32] efi: Rename ImageBase to image_base
Message-ID: <20250206232413.GQ1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-15-sjg@chromium.org>
 <20250203200902.GH1233568@bill-the-cat>
 <CAFLszTgR==OvRFb-FBF4OHfr9zAjM8mz9G6ts8Md7vNuv7oqkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rNgnZRnWZwBBmt05"
Content-Disposition: inline
In-Reply-To: <CAFLszTgR==OvRFb-FBF4OHfr9zAjM8mz9G6ts8Md7vNuv7oqkw@mail.gmail.com>
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


--rNgnZRnWZwBBmt05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 02:27:30PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 13:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 10:42:07AM -0700, Simon Glass wrote:
> >
> > > It is confusing to have a camel-case indentifier in the link scripts.
> > > Rename it to fit with U-Boot's snake-case style.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This isn't the linker script, it's the crt0 file.
>=20
> Yes, it's referred to in the x86 linker scripts. Probably we should
> rationalise some of these names.
>=20
> > Given that this is intended to match up with
> > https://learn.microsoft.com/en-us/windows/win32/debug/pe-format (which I
> > got from looking at the commit message on commit 216459d2cf36
> > ("efi_loader: correct SizeOfCode, SizeOfInitializedData") and
> > include/pe.h I don't think this is a good change. Heinrich?
>=20
> Well, pe.h is a file format so I don't believe we need to use the same
> code style. We had that discussion when the EFI code was coming in,
> and decided that it wasn't a good idea (as I recall).

I really don't think our linker script for making a specific output type
should deviate from how the output type talks about things. Deviation is
confusing.

--=20
Tom

--rNgnZRnWZwBBmt05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmelRJ0ACgkQFHw5/5Y0
tywRKwv/dWRrmgHpoJgFULEkWIHefE/aYOucM5uYZcoRCx6gMFYSffE0mobjo1hL
ZSnhv0MYnOP7Mv4Itlow9nmrlG2KN46U9/bLaWSnutAgwytkUixt775ajWh+0q6b
8IDjKWVsnboKfMA7fID+jz5Lckk/FSR1tSgGJ6eggO269oQTMLC4JpeyTWsSE5cu
OfSksl7dSEeVzfiFYGAyHyaNGOLnhl9YvM43IQdFi5Hj5fX5EXKbm1arKV9gH27q
IE+sdQzZVLfja/SVawQp+Y8ky1CAgJy/7OQdyeOxBChe29WLUmJgRLOHZJNDPavb
6EIELWck0FaZRMsRo+ZTWFEHlUCNL1JpOyzstUN/d9diNdTYSsnClUJdQuqxHshA
QR7pVSKUPRk4J03+A3OyC+biIry8eevDYaVO/fvEI71qkkBvvbknvKHVcDrHjgY7
LZh2qMtwlV1Ho2cutV96rG1ur4923olXmgqpfHl5i1M4fYWmBNgRKxBo+nQqQkoA
OBDeEhyY
=eIV5
-----END PGP SIGNATURE-----

--rNgnZRnWZwBBmt05--
