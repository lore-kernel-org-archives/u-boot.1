Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F354CCA0EFA
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682708304F;
	Mon, 25 Aug 2025 15:59:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fl/xmHbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B5468307F; Mon, 25 Aug 2025 15:59:20 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C7EB83043
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:59:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-61bfa392bc1so2755635eaf.1
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756130357; x=1756735157; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=t8l7TOKXXLa+/e/Khde7SUh0J1iNM8gJAQt2vuGPnMU=;
 b=fl/xmHbufTeqNsUgeweidFmDBwROvvGEGPACsuFM5uSDed2CYE/onsPv+r3pYFutlf
 NwNhsBZQSBBbSNjQR7wEJO5ob9Un/OYH5aVs4eLIgacpy5q629jupuG7OiMutqnLKwY9
 RCo6e5Fd+Q2A+6jE25khGa9lvo/QP6FWyzZH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756130357; x=1756735157;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t8l7TOKXXLa+/e/Khde7SUh0J1iNM8gJAQt2vuGPnMU=;
 b=jKc6/G9gMYRCk0uv5cGS7CAn/c4FreFAL4rAayNDboCyA9Nuw56bIOtZn1VTwUMBj7
 rwZN5PkigeszfyadrmY5jRPY6O8trqsnNuMxVpjI6QyqVbslAZkbKbYjcPUdktwWEX7Y
 Uh8+G4AR1gaCqRgAFE4pHk0TdoaOhJ0uSB/yH+6mPB368nBv2LyZK8jJjx+glB3vpy1J
 PXHuV0yz7sRzvkVCAx5wuHI42qMowJpwBwR5NXhb5j7Mz+DdLXECMuXpFDeZUzHujAla
 R9w1Tx3KgUyZdyCtA5d6OaYcALb6P+Anfsm7QJzJE/0yavy3YW+gM59Qyqp/s+rR9jqc
 Kycw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsu0X7Tg9ppRkRFI5buF82d4Vis5Q+g5GL3xL8u58cUjjNC4JIBpqI+eOQFf8tUzh5q0GyxQY=@lists.denx.de
X-Gm-Message-State: AOJu0YwZ5hxjMdwo5xYofazws5elDX6itIPR5C3UdGpS4b2NMblLejOV
 /3Weuge+F7+HmydSi04tsBLYoo/AR6a2810Q8oFp6unE9iJWwNWUY47/31Wb/vPEVpU=
X-Gm-Gg: ASbGnctrgcTjKBrJqBDvNnEHNJGFrhN8FMhDa8OYqrjLB5RAHp4aV5kKrPqtg4knUYQ
 qnCmxezgf/MSQOj8kygdQfTc0G/27XBEBI0wqiBN3FYdjxLYBKw28hHlF3VUF/3EBWzLdRUtJUG
 Njuj/c8AVrL2iAobA5rlYe9d4FRN2ZK7D1sCBXUIfa8EbfjFG7OBN5TLK5Q/jVoQ86FyjXdr3hz
 L4Y/Vq+M/qlDHlYguA5cuHr6jSzkQaMMw9dqKanoN0a7EbGPkwGJEKtiEoSw1eFWTlvS93jao2r
 rHTONWClkG33ANMB4eAENmwnC0pQtdK74+5ObL2li3V19FNvzQXeOlnD+OPkCzoEfooKoDbx7R0
 MbPFe7iJ+3p5/TCVj1AVgvu4o1MYJtnpymDMHIgJKZlwbwH5ftEaA63ao
X-Google-Smtp-Source: AGHT+IH6x25xvMzRre5ZZEWedj7LDYPDt//D/Gi8DRanNCUHvHLOvqyW7K3P7WN8KnnPWcypAtAGpA==
X-Received: by 2002:a05:6820:151a:b0:61b:e931:c6c7 with SMTP id
 006d021491bc7-61db9e703c0mr5337964eaf.4.1756130356857; 
 Mon, 25 Aug 2025 06:59:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61dc76aa215sm949950eaf.5.2025.08.25.06.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 06:59:16 -0700 (PDT)
Date: Mon, 25 Aug 2025 07:59:14 -0600
From: Tom Rini <trini@konsulko.com>
To: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Subject: Re: [PATCH v2] misc: fs_loader: Add QSPI RAW partition loading support
Message-ID: <20250825135914.GR124814@bill-the-cat>
References: <24b4a185-3575-46ae-8d5d-43fd0902a4f3@mailbox.org>
 <088604a7-3220-4158-a7aa-6e1528b9e38d@altera.com>
 <4f28a730-3952-4a6e-8f9b-506b588b43e6@mailbox.org>
 <6f4b1dbf-45ea-42d8-8f26-a611ed215d75@altera.com>
 <48d5afec-0508-46d6-b444-117d4a7bfe32@mailbox.org>
 <303a50e6-e670-4456-a23c-cb829bc1dd88@altera.com>
 <edcc50c3-4968-494e-9fb1-6acdefd26a53@mailbox.org>
 <c13ee750-2534-4cfa-ac6c-a6a51dec33b1@altera.com>
 <6935fd0b-8027-48a0-b9ec-076535d929b9@mailbox.org>
 <9879ace5-88e0-40be-8b49-4e3baee5c1ec@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VeceoTJHolgHRLqs"
Content-Disposition: inline
In-Reply-To: <9879ace5-88e0-40be-8b49-4e3baee5c1ec@altera.com>
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


--VeceoTJHolgHRLqs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 01:14:59PM +0530, Ravulapalli, Naresh Kumar wrote:
> Hi Marek
>=20
> On 21-Aug-25 5:33 PM, Marek Vasut wrote:
> >=20
> > On 8/21/25 12:26 PM, Ravulapalli, Naresh Kumar wrote:
> >=20
> > [...]
> >=20
> > > > How big is the file ? crc32 is weak . Why not use e.g. fitImage for
> > > > this ?
> > > >=20
> > > > If this raw loading should be available to users, it should come wi=
th a
> > > > BIG WARNING about data integrity.
> > >=20
> > > User can use CRC32 and if they require SHA256/512, they can use that =
as
> > > well or any other algorithm as desired.
> > >=20
> > > RAW partition support is helpful for flash constraint devices especia=
lly
> > > in a use case where we need to store data as RAW during run-time and =
if
> > > data integrity is required, user has the flexibility to choose
> > > respective algorithms like CRC/SHA etc. The whole objective of this
> > > patch is to provide that flexibility to the user.
> > >=20
> > > I don't think we need the BIG WARNING, as RAW data by definition will
> > > not have any built-in integrity features and users should exercise
> > > caution if data integrity is required. It is mentioned in the enum
> > > definition that choosing "DATA_RAW" flag will store data as RAW.
> >=20
> > It is not a good idea to use RAW data in the first place, because it
> > gives the user false sense of safety, but in reality it can lead to
> > silent data corruption. Hence, please add big warning.
> >=20
> > Also, how big are your payloads ? You did not answer that question .
>=20
> Is adding "log_warning()" be sufficient, like "log_warning("%s: Chosen RAW
> data type DOESN'T have built-in data integrity support\n", __func__);" ?
>=20
> Our typical payloads are of 3 KB size.

I feel like documenting a reminder about this in the option help text
should be enough.

--=20
Tom

--VeceoTJHolgHRLqs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKxsLgAKCRAr4qD1Cr/k
CkN8AP45VPUJhEiHYjFqEinBT6Ny0R113TLtEYXNmbipazajOAEAicXCnqsM/3Tx
CWzne7mKyY4hVXWMzfqOqrBKWnZerAI=
=vOod
-----END PGP SIGNATURE-----

--VeceoTJHolgHRLqs--
