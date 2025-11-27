Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DE0CFD2F6
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 18:41:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E53088430C;
	Thu, 27 Nov 2025 19:41:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Vyk/jUnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0E78430C; Thu, 27 Nov 2025 19:41:05 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BABD5842A7
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 19:41:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3ec31d2b7f8so289475fac.3
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 10:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764268862; x=1764873662; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vLGWEFwekip+co2GDpIKUvnlKh4QKC7t5T8AfA9uSTY=;
 b=Vyk/jUnnyIlTpYJxI01luwxRe//6qBhcNDJ2t8m/v/v04J0+fAhxUSeE239skzOOnz
 FrnGHyFULX2ILtuvARL4HC0G+spK/t3PWj2nUiOtjc8ytyxtWXwvdGfy1/rpR/BPrIWl
 Dwxbs43pczFWDMC6bUrTuMp1+Yz4DmjgIOAqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764268862; x=1764873662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vLGWEFwekip+co2GDpIKUvnlKh4QKC7t5T8AfA9uSTY=;
 b=ZYyR9eSHrJLs6UZWz+GMmBsMfqh4d7McoSphsySFUo+nydXFNLj6fLJWtt8fN4hP7X
 azjbxKJ/nm0WIeyZ6w4hLcoQk3ZUjlXRRHrqGBXJlXfpFESO39/bItVIYZGj1Ea8bmZl
 aXFCCtXzUxb7rDT/XHyn+zYmOY0SuU7f7QZVnneYWbtDNqJapTxI8UdNEtOvN7SiqsU/
 JysR/9JHnvh87DYtKLLoPFpU/dKlqO70Y+FFVQuoF85IHiqB/sPY0f3fzo6vb/em8w3t
 2jBgiciLzg3+hdtJkWf4KoNBilZljI8wTIRnN3nvdIybvlw9JBY9q07PEmLhO//YTkqH
 9kAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUmHD2dQaoDVp7/PaVey3qP5C0mNRNowqMIYqFnUU5wSGsdMdWBnGpw3yTkWrKx6xg68ra3ac=@lists.denx.de
X-Gm-Message-State: AOJu0YzMCCBlx7qrYmJijcRI30RK8ouGwnjJg2Bfo9W6S/6xml2kUvx4
 TElsLmMq11TO8zMBTuKnDbg+6F1ScfiU7JgN03INkc8hjl3KBxF01Ym42TCX9qKyWHI=
X-Gm-Gg: ASbGncurdwXiVLlo+c/IcRBhp/9ISkyr3GRfD+JLDhBerFYD5IZUI1JkRXlhgNKvTzu
 LKVHum65lApYcXATGl35ZA8fAy3cPNHRedFTZDhFeju28Mpcx/nV0M/x9TxmvB+LCTQj/XeNyxd
 Fjwtn0m9xOsrGu7Zpf7KeMAj4X33Oyv5rEq4Iit107QBwCOCDkfbINdjf0gmnfp+Si/fR60LM5P
 yS6dUtayh390zJDrgymfoi7CzRVEcXAaEcXhMRiulkX3AE2oVM7vX4m6MVthjON+/dTQNJBy++Y
 yhP74zPsUeAWiCbaAJMZWtTJEy5T7h2O5c6EyO69kD1CK0i5gCekAylB1kVbvtniinG/bQAG1XW
 QeVrqZd6In80kX2svYu34ONdd+fEHiSTasoY0rwIFJqhAZRQ0xh6vOY98Hb4blnPqdezOPVsh5L
 jzoaIIFf3fJRHZvz7KEDQyNpBwoEPWLMNaTQ4BZQdzd0UUOcYuHg==
X-Google-Smtp-Source: AGHT+IFzTlCk+Ik/ablFhI4SRS0R1qUbS3nws5Tcgg45TbMfyJ+m/PUgfCjJKPa0XYgIAtQzpLOfIw==
X-Received: by 2002:a05:6808:1a21:b0:450:bb4e:8395 with SMTP id
 5614622812f47-45115b2ae36mr8448950b6e.53.1764268862391; 
 Thu, 27 Nov 2025 10:41:02 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453169b3785sm636827b6e.3.2025.11.27.10.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 10:41:01 -0800 (PST)
Date: Thu, 27 Nov 2025 12:40:59 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] binman: blob_dtb: improve error message when SPL is not
 found
Message-ID: <20251127184059.GX2125796@bill-the-cat>
References: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
 <20250909170357.GA1799865@bill-the-cat>
 <89715907-3d24-483d-943f-a027097962aa@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QSn1bino08xOhEmS"
Content-Disposition: inline
In-Reply-To: <89715907-3d24-483d-943f-a027097962aa@bootlin.com>
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


--QSn1bino08xOhEmS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 07:04:06PM +0100, J=E9r=E9mie Dautheribes wrote:
> Hi Tom,
>=20
> On 09/09/2025 19:03, Tom Rini wrote:
> > On Wed, Aug 20, 2025 at 05:06:54PM +0200, J=E9r=E9mie Dautheribes wrote:
> >=20
> > > When using binman with the '-a spl-dtb=3Dy' flag, if the SPL blob is =
not
> > > found, binman throws a cryptic error message:
> > > binman: 'NoneType' object has no attribute 'startswith'
> > >=20
> > > Let's improve the error message to explicitly state which SPL blob is
> > > missing.
> > > This is particularly useful when binman is used as a standalone tool
> > > outside the U-Boot source tree.
> > >=20
> > > Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.c=
om>
> > > ---
> > >   tools/binman/etype/blob_dtb.py | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > >=20
> > > diff --git a/tools/binman/etype/blob_dtb.py b/tools/binman/etype/blob=
_dtb.py
> > > index b234323d7cf..772579394d4 100644
> > > --- a/tools/binman/etype/blob_dtb.py
> > > +++ b/tools/binman/etype/blob_dtb.py
> > > @@ -8,6 +8,8 @@
> > >   from binman.entry import Entry
> > >   from binman.etype.blob import Entry_blob
> > >   from dtoc import fdt_util
> > > +import errno
> > > +import os
> > >   import struct
> > >   # This is imported if needed
> > > @@ -42,6 +44,9 @@ class Entry_blob_dtb(Entry_blob):
> > >           """Get the device-tree from the list held by the 'state' mo=
dule"""
> > >           self._filename =3D self.GetDefaultFilename()
> > >           self._pathname, _ =3D self.FdtContents(self.GetFdtEtype())
> > > +        if self._pathname is None:
> > > +            raise FileNotFoundError(errno.ENOENT,
> > > +                                    os.strerror(errno.ENOENT), self.=
_filename)
> > >           return super().ReadBlobContents()
> > >       def ProcessContents(self):
> >=20
> > Sorry for the delay in review. We also need to update the function
> > comment so that python coverage remains at 100%.
>=20
> Sorry but I'm really not familiar with python coverage. I had a look to t=
he
> official documentation and it looks like I need to add a test to cover th=
is
> specific function. That is what you are requesting?

So, doc/develop/binman_tests.rst talks a bit about testing of binman and
python coverage. In this case I believe the issue is that the function
you're modifying needs to have the comment block annotations updated to
include the exception it can throw.

--=20
Tom

--QSn1bino08xOhEmS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSibMwAKCRAr4qD1Cr/k
CmlvAQCLsjQ2Nd4YlKObvID/GtZYgIRJOpzKCKblDCyCTAzRlgD6AhL96X/xzf5y
/+dw9UeR6XIVLwdJmDo4fiFmYlmqxQU=
=KFXI
-----END PGP SIGNATURE-----

--QSn1bino08xOhEmS--
