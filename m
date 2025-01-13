Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63EDC02187
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 19:49:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37E44805E9;
	Mon, 13 Jan 2025 20:49:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pIE/xT4r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA5238060C; Mon, 13 Jan 2025 20:49:04 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 462D0805DA
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 20:49:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6f1b54dc3so760878385a.1
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736797741; x=1737402541; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+ron9iEkfIXlK6TSpfRkfPXiDMfTNcL/mZUCsjH+948=;
 b=pIE/xT4rW7GW2fqxHrasPZBGNL39mZal39fLooQqECNwrJNF5dncVDtedKZvtcIg1f
 I5u429X3//dD5+mDmd3+rPWG5WjzXHdH4o3cgSeMq1Nea0RlDF12iwmOdcyiX2q0fGef
 LG+V/gfxMQ5S/s1ojiP/3NbhPivdWWuMozD3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736797741; x=1737402541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ron9iEkfIXlK6TSpfRkfPXiDMfTNcL/mZUCsjH+948=;
 b=mMQp4dGyzzA95zd5RRDmPT4uUyev/9X8aeHCNPfxZgP0ck9V9iAGhuAI1IMBZWROHJ
 qPeBLjawWJHPOzA+K1cm5LfbV1asCgr3g7WKjGti3MlpfunudgTIqE/tH0dEoFLWTvmI
 by+EuMGYPQOcnrQmWFCU2j+U/hN8YqBQH/zYzhpHb3OTIOLlDM1dGr7kBDC3/7jdUQi2
 iVTN3z7Ge1hm9x9rkH7HISTAOiixpWvLYZYigbFODiYUDyuWim/+Vzh5RskN7Dm+g5gM
 npM62NIOoqCyfFdSieO0gTfZLmjVtNr+s4NpltIMA06tNTKHT7PPagXZLhQzouWMZI2X
 xLZw==
X-Gm-Message-State: AOJu0Yycd80yKFuFC/NmsE6N+BXWBzJg8tM6M05yJwR4yWET1zRKXjyF
 GL5rXQ29XgOP9PjtEQatjy04WP6jXFz99TyWzCL6cha9ammd1L7xO4iuaS6kkgnIXQ5qvq1Kz87
 a
X-Gm-Gg: ASbGncsQoS1v+5+7oCN/Y8m6M13ljus1qVS9pB6MSTgl9iMpynezBNFgAsSLOv1Dl9n
 i/T4BL6uhYEh/EZkgHAfpiTXkXeLRXNxcdZkFj0q6crmgtTiCOEx3mCpDF2ZLW+hqHGOjK4NYr0
 vCVJxoNb7AxbKu07XMLotZapWlxZsQK2IcQA03RsEe5TaRbNIxeonOGVn4fSVvkKAkC2Td82y06
 0lyO67ltb3573rdJq5KkDoWyJmW70r2PZYXYcpP4sXaoMo1XPVpDyo=
X-Google-Smtp-Source: AGHT+IH7TM6vIm2qsyqYCRw/rao8TgnV2uoLzI+sGhoyfBN8R31G8DyvipHHDzWoc2V7yLD7MBlT2A==
X-Received: by 2002:a05:620a:1794:b0:7b6:ce6e:229c with SMTP id
 af79cd13be357-7bcd97d5b78mr3620248985a.55.1736797741038; 
 Mon, 13 Jan 2025 11:49:01 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be44d3da3bsm53097685a.114.2025.01.13.11.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 11:49:00 -0800 (PST)
Date: Mon, 13 Jan 2025 13:48:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [ANN / RFC] Regular community calls?
Message-ID: <20250113194857.GB3476@bill-the-cat>
References: <20250113183409.GY3476@bill-the-cat>
 <CAFLszTjDx3bBwgnvB2v6ow70a4-XS-fR5UHFdFQNn7Fdytba8w@mail.gmail.com>
 <20250113193035.GA3476@bill-the-cat>
 <CAFLszTjPdX1kORnMNUMEUdrjYmQwiVm043nZGBZEV591oXtzEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="by739v66IhQ9a98F"
Content-Disposition: inline
In-Reply-To: <CAFLszTjPdX1kORnMNUMEUdrjYmQwiVm043nZGBZEV591oXtzEQ@mail.gmail.com>
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


--by739v66IhQ9a98F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 12:39:08PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 12:30, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 12:10:35PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 13 Jan 2025 at 11:34, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > Hey all,
> > > >
> > > > It's been suggested again a few times recently that we should try a=
nd
> > > > have some sort of regular open call / video chat as that might help
> > > > clear up some issues. To that end, I'd like to propose we have the =
first
> > > > one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a d=
ay
> > > > after the v2025.04-rc1 release, and I'll include a link in the rele=
ase
> > > > email. If this works out well, we can make it a regular thing for t=
he
> > > > day after a release and also try rotating the time, or having a sec=
ond
> > > > meeting much later in my day that's at a better time for other part=
s of
> > > > the world.
> > >
> > > So do you mean the first one will be in two weeks (i.e. Tues 28th Jan=
uary
> > > America/Europe, Wed for Asia?)
> >
> > Yes, thanks for the clarification.
> >
> > > Here are the running notes
> > > <https://docs.google.com/document/d/1YBOMsbM19uSFyoJWnt7-PsOLBaevzQUg=
V-hiR88a5-o/edit?tab=3Dt.0>
> > > from the previous series.
> >
> > Meeting minutes are good, but perhaps we should send them out via email
> > so they're more accessible.
>=20
> Yes, I think Google docs has an option for that, but it would need to
> be in text format.

Yes, I think the key is taking minutes and avoiding discussing how we
format the minutes. Whomever volunteers to take the minutes can take
them however is easiest and then send them as an email afterwards.

--=20
Tom

--by739v66IhQ9a98F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFbiEACgkQFHw5/5Y0
tyzU1gv+LzZS3WMcccr27OWQBuKVAC9kYgTYdc9cCs99PXxedkEoDq4VrWFY0nrT
BE3Eg/KtY3M8lrjs7OtexlWYiEPVgKcyLEDiiNGcnRLLG0Njcm6zo457bvPgy9KM
4cn8/0OGiisqYUBHRoTE7B1Oahs9PVntvUcPWL69P/ppPRkHrg6Clc3fTExzB/5V
Zos1AwvWjmiPSNWsSgtLeOIv6knvJ0uth/TWaQfkcmx2ZCG0OKlI6IrcK7H0A0Wg
k2y0QdM1NxuGYEPQM2PxLtVZNUb6POrTqZx1WeIuaEixEptjcYfZxegjLKLZX52k
IOC0DykwL4XtHUddovgGoOiyN/P13+Z74lgctjDuy87C96MuUOdAN3AMJmbbJZ0e
6Q/sk6YS4sZ5++Ih6B26xrLbmoScdZl488iozTz5EQ2FG8WeHQEAKE6UAWeG34l0
azo2BANhSo7rWAhywB8my9p3ycDc+thW8m2RImy3CEcIGRarPH5t9K1vbPRtoy22
pPcdcjp9
=k9wG
-----END PGP SIGNATURE-----

--by739v66IhQ9a98F--
