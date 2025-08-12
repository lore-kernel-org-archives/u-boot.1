Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F247ECA0EC4
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 14:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A4D58338D;
	Tue, 12 Aug 2025 16:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YiaUB8w6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEEA58340C; Tue, 12 Aug 2025 16:33:55 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B228C83145
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 16:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-306db05b292so1855965fac.1
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 07:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755009232; x=1755614032; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yMemuf/juviWNzPRewhMb/ZqC9WBLT7nX2Gn1AtVtNQ=;
 b=YiaUB8w6m6nOjhaT7knkuRa8PO0/6sIcwNdvZqNSPXJH+PERDr+Rf40OtI1onXyiZz
 eZ5fIVwLNCft9eeDcn5ONjJg2y8aQzrm78CyZU2Wx//o9EJbYinA+Xh9tKntr3w6sTUr
 +exXtuQKzvccAYc49OUqi8g3OJ5y9qDPzv6n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755009232; x=1755614032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yMemuf/juviWNzPRewhMb/ZqC9WBLT7nX2Gn1AtVtNQ=;
 b=kYwUXknje/gb7Jjf8WVQERSPVFmkJqLrpNz9SUnkJELJN0weZXUog8tSbJYhcO795d
 JWTclKW0cv9hyi04FlNlYsTk/Opit8+TkpiwJzym7FkSSASnJzWZ9G106UJ4smx+wqvX
 vBTQrlO/JGQ8IyD5n5KZL+gd3N/f04TfyWTA6dAx/F2tafUpzChD0V6+bVu45Igw4k8u
 BPZiU03+MtBpuJnYz4pZa004Zn1SsbZLIFMVM5H6RqOi4kC49y2LREWO+55lL+Y/9ovs
 wLwg2uQfl/z2dY6EhFpP8fALRSwBoFVsgTti8/WVgmRsFzW7Y2uaTLt+QV/qSQBHM15b
 4ZRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz+YsML4Sp6HlHKzW858hog8D2EXYL9uY2Zf2GcV7C59vQQOKySy1SLkmJaFkEUZA7RkjWkU0=@lists.denx.de
X-Gm-Message-State: AOJu0YyFR06xe3wRyYzrE1mRwqs1HEM+nYmJuONNx3hNU5QpBs/mpgqU
 4R9Plp7lFIm/Lt+Gsxx8py8Y4RsfQHJYzLL3IHbbMc+JM7VW+PudHnlczVX25Ii2hUE=
X-Gm-Gg: ASbGncshQhELvruKpPOTjKw+HVOKuDa/wJu7ClMsgyYiXEsEWQlmacelTUdCyY4qENw
 TpGZ61Arid0Pbg0oorME6J72P406ovm3r3xop3SYpAA0jhM3MuAxcjTnTYEv7TeLJ2LZBbveWZI
 7tH/ph3rnuzyTVh9a+4qOv/5dOG/9tCDL7IJ/JMn9/uYXKALAbTtSncY7wnddHzi4drtenENWvd
 ZjgXu5nA4OYJviMpS6YQHBH+d5ZYzJZvQ2h6GX2oOBFYiQCvNJ10EFAYGAgFMc69caVTOFmMmqJ
 HcexFvzD9/eJ2EklIKFciQ1fkHLejOo22YoSEnEuDLR50LuPdkJCNHtNbyI/pNbyC1jAlsnMdJv
 BO7vLqLGLKxse3WFnjtt/rkLd9WSt9/5QGy1nKS+xBEnk+/ZIusNfAV1F
X-Google-Smtp-Source: AGHT+IF6G3vsDXr5H/fbPS/A+xGJBwtMsDMI8+wowF6PgIqXsl/6FaQg42BmhFYQEepQgKlcjW/Htw==
X-Received: by 2002:a05:6870:8a14:b0:30c:b54:ed77 with SMTP id
 586e51a60fabf-30c95051f05mr2250170fac.19.1755009232263; 
 Tue, 12 Aug 2025 07:33:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30c10c7a694sm3870477fac.9.2025.08.12.07.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 07:33:51 -0700 (PDT)
Date: Tue, 12 Aug 2025 08:33:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: Seeking advice on API return type inconsistency
Message-ID: <20250812143349.GQ124814@bill-the-cat>
References: <f5c94319-8ef8-459d-88b2-836702779cfb@linaro.org>
 <e10a39e4-9606-4ae4-86dd-11de4b39b5ed@cherry.de>
 <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EY9Bzxmi6ntMEl1P"
Content-Disposition: inline
In-Reply-To: <2d6457b8-c637-4531-8f56-e2aea320a319@linaro.org>
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


--EY9Bzxmi6ntMEl1P
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:17:47AM +0100, Andrew Goodbody wrote:
> On 11/08/2025 17:36, Quentin Schulz wrote:
> > Hi Andrew,
> >=20
> > On 8/11/25 5:24 PM, Andrew Goodbody wrote:
> > > Hi,
> > >=20
> > > I was wondering what people's thoughts were on API return types. In
> > > particular there is this and other examples in include/clk-uclass.h
> > >=20
> > > /**
> > > =A0=A0* get_rate() - Get current clock rate.
> > > =A0=A0* @clk:=A0=A0=A0 The clock to query.
> > > =A0=A0*
> > > =A0=A0* This returns the current rate of a clock. If the clock is
> > > disabled, it
> > > =A0=A0* returns the rate at which the clock would run if it was enabl=
ed. The
> > > =A0=A0* following pseudo-code should hold::
> > > =A0=A0*
> > > =A0=A0*=A0=A0 disable(clk)
> > > =A0=A0*=A0=A0 rate =3D get_rate(clk)
> > > =A0=A0*=A0=A0 enable(clk)
> > > =A0=A0*=A0=A0 assert(get_rate(clk) =3D=3D rate)
> > > =A0=A0*
> > > =A0=A0* Return:
> > > =A0=A0* * The rate of @clk
> > > =A0=A0* * -%ENOSYS if this function is not implemented for @clk
> > > =A0=A0* * -%ENOENT if @clk->id is invalid. Prefer using an assert
> > > instead, and doing
> > > =A0=A0*=A0=A0 this check in request().
> > > =A0=A0* * Another negative error value (such as %EIO or %ECOMM) if the
> > > rate could
> > > =A0=A0*=A0=A0 not be determined due to a bus error.
> > > =A0=A0*/
> > > ulong get_rate(struct clk *clk);
> > >=20
> > >=20
> > > get_rate is declared as returning a ulong but the description says
> > > that it can return negative errors. A simple test of the return
> > > value for being less than 0 will always fail so errors can go
> > > undetected. Casting to a signed type seems less than ideal.
> > >=20
> > > What is the best way to deal with this? Cast to a signed or update
> > > the API to be signed or...?
> > >=20
> >=20
> > Note that clk_get_rate() in the kernel has the same function signature
> > so I would refrain from changing the type otherwise we'll have some
> > "funny" bugs to handle considering it isn't that uncommon to import
> > drivers almost as-is from the Linux kernel.
>=20
> Ah yes. The difference being that the kernel does not seem to attempt to
> push an error code through this API, you get a rate or you get 0.

How is the error code pushed? Or is it up to the caller to decide that 0
means on a case by case basis?

--=20
Tom

--EY9Bzxmi6ntMEl1P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJtQzAAKCRAr4qD1Cr/k
CsRKAQCayzb49kmewGhhe8Iwg2sF/vQ6NzucaeDNgIdazp45VQD9FEpOnH21mGqm
AME+Y9/ObsXXW8KwXfN3boPHhW44wws=
=SQ8R
-----END PGP SIGNATURE-----

--EY9Bzxmi6ntMEl1P--
