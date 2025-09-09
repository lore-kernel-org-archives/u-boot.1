Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B51CAC582
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 17:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6938831A4;
	Tue,  9 Sep 2025 19:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fdUNhIrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75577831B4; Tue,  9 Sep 2025 19:04:04 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4744A8313B
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 19:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-61e6ee53d2dso1155719eaf.3
 for <u-boot@lists.denx.de>; Tue, 09 Sep 2025 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1757437440; x=1758042240; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yKbkJCCbhbiBdR+zH9mrpz3D//l6Ke0v2loNqfjhJ1E=;
 b=fdUNhIrQaOXhUxR6CMbAxxukRMOI7Pw1G/TyQaZ9Fq3nwMx9axX3LmPEADaDhlnkEJ
 h+d8b5yfS6RB83a8qyCErA/JPkomrPRHdXY8m+RmrMXR7DHYJQCRKc1dwUdUe9DqK6WF
 6Gv+kgHiGbZFvwkzZ3/DCjFxG3kra1IXEIcto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757437440; x=1758042240;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKbkJCCbhbiBdR+zH9mrpz3D//l6Ke0v2loNqfjhJ1E=;
 b=Ni95kTIUTpldDXAw9PbQbSp5I16feL+4LXY4X/i69WbDPvJ7KkTHo6AL0qPrLS2zJ2
 kmQhSHX7yRy9KDMEcWW92s2oObgwm+KvQXf+iwBqeUxn3G9UYch8KX/MwotjcLb1u4iA
 j82GwZYvLqSwCGC9Evoho9skcpPef8TC/Ogdlnt36Utq4ovYjx4AmWke/dWlnyOSbNri
 WauYVHHyBvvIpw7vVAQg7qjyF8+0X8Pqgo+MLc6+2FdRf+4zI/NewhY7VOaA0rA9yU/D
 fs309UKyIqAz4m5urVllHNHXx6F3KL3vQTA+3KCTN55zcDGeqGWL2tpBJ9N6MwTurTp3
 9S5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAuQjlSpa/40zkz4UUl7N9V+dl7oHlzX9SO6lideu6hxt8oLCDlurdrNlp8qlXkc2vralSBus=@lists.denx.de
X-Gm-Message-State: AOJu0YzPvaxzEiN8F+f1s0rrZrYIZIJzvMIF40JNGo1NU/SUUEC/wlBs
 r9SK+YV6F9pFmShdOSv0NERzAVn98fMnWGsLASKJE1a5CAIbKite26lbVxLQ2iBMyYE=
X-Gm-Gg: ASbGncvHtoXOir7HLZAdAPVA8YUChn4bUNvExB5UH7sss+nrKHyZC5q+4vp0VtOAjoV
 ZUamiALqVd+pZe/nS2n3c5Nuoy9ErVlnYeRV/atRwhP35BKm/d5sc2kOKVDnJGV44Z4on7g+96n
 qRQHvyzubjW9x2RnTIAzALPbALIdnWUUXkO8BhNdrv3p8ZEuHnCO3ScE8OtKJIsG83bYzk2hFEL
 4k5/B9ARfnQBfo8SXcNuwTqdW+xfgWCQe6lf1iWSAlDyx+3ZtEO7zDB7GDZDBYrRqBBPRK4p0gS
 LyCTkMXeva77HrSHwH2kkh4zbWkHaEP5agJqsHyTOa86qHYwjZN/RhBk5JqYsFCIKVa23BySKHU
 QLIeGvOiGj+/7u84hI/YciI5dtAMCIxqgd9uTPgzn0b0Cw7tg/wjdWI0h
X-Google-Smtp-Source: AGHT+IFWKChEIVWzxtiTsgSmGeXxaiOUDgDH8TmrgbuwEk8C3KcZ9Fi4nH+xSNWDiyZQgLzF3cFbLw==
X-Received: by 2002:a05:6808:4491:b0:438:3cfe:b5af with SMTP id
 5614622812f47-43b29bf5d8bmr5553617b6e.18.1757437440392; 
 Tue, 09 Sep 2025 10:04:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50d8f0d594fsm9973945173.23.2025.09.09.10.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 10:03:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:03:57 -0600
From: Tom Rini <trini@konsulko.com>
To: =?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] binman: blob_dtb: improve error message when SPL is not
 found
Message-ID: <20250909170357.GA1799865@bill-the-cat>
References: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="iOnscaYxAsGsQHWQ"
Content-Disposition: inline
In-Reply-To: <20250820150654.1398992-1-jeremie.dautheribes@bootlin.com>
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


--iOnscaYxAsGsQHWQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 05:06:54PM +0200, J=E9r=E9mie Dautheribes wrote:

> When using binman with the '-a spl-dtb=3Dy' flag, if the SPL blob is not
> found, binman throws a cryptic error message:
> binman: 'NoneType' object has no attribute 'startswith'
>=20
> Let's improve the error message to explicitly state which SPL blob is
> missing.
> This is particularly useful when binman is used as a standalone tool
> outside the U-Boot source tree.
>=20
> Signed-off-by: J=E9r=E9mie Dautheribes <jeremie.dautheribes@bootlin.com>
> ---
>  tools/binman/etype/blob_dtb.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/tools/binman/etype/blob_dtb.py b/tools/binman/etype/blob_dtb=
=2Epy
> index b234323d7cf..772579394d4 100644
> --- a/tools/binman/etype/blob_dtb.py
> +++ b/tools/binman/etype/blob_dtb.py
> @@ -8,6 +8,8 @@
>  from binman.entry import Entry
>  from binman.etype.blob import Entry_blob
>  from dtoc import fdt_util
> +import errno
> +import os
>  import struct
> =20
>  # This is imported if needed
> @@ -42,6 +44,9 @@ class Entry_blob_dtb(Entry_blob):
>          """Get the device-tree from the list held by the 'state' module"=
""
>          self._filename =3D self.GetDefaultFilename()
>          self._pathname, _ =3D self.FdtContents(self.GetFdtEtype())
> +        if self._pathname is None:
> +            raise FileNotFoundError(errno.ENOENT,
> +                                    os.strerror(errno.ENOENT), self._fil=
ename)
>          return super().ReadBlobContents()
> =20
>      def ProcessContents(self):

Sorry for the delay in review. We also need to update the function
comment so that python coverage remains at 100%.

--=20
Tom

--iOnscaYxAsGsQHWQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaMBd+QAKCRAr4qD1Cr/k
ChcFAPsE5oDza0MBstGZuZvY3lQF84q+p7w9IZihwWyehQ+NzAD8DI5s16wz+l0o
XL6clU/0Zy0JJYv7zgyEl8rkBOCbxgw=
=wiqO
-----END PGP SIGNATURE-----

--iOnscaYxAsGsQHWQ--
