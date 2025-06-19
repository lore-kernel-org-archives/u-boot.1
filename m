Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE8DC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:15:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B736082CEB;
	Thu, 19 Jun 2025 16:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uZhknyiz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8C882D06; Thu, 19 Jun 2025 16:15:12 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E8D982CCE
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-73a45bb2ac6so645074a34.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750342509; x=1750947309; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dn+vqoMsTHwv4/O9jtUfTRQ6e+hKTc4pvUdDcT5SaiY=;
 b=uZhknyizIWCou6NNnYFL2AGIIZjt2PYeDOAVhgqkhtdEmGbNPvfOuZdIs5tLgncX/j
 K3I2aPNEmgwd3VnmzHdseiN6f3OCL8ZVNj7sC+gCB3uWgN6uUKe/enBei1bFzG+knzeJ
 Ynpk1NtEhGgnFLXfHdC+IbnezBfxdkWhfID+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750342509; x=1750947309;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dn+vqoMsTHwv4/O9jtUfTRQ6e+hKTc4pvUdDcT5SaiY=;
 b=PXdGjPd2aL2smIJBFv6jqQjjp8l9tLoHO2KNwqe3JTCGasqAnVZh1L+FNa8Fs8d6A8
 EXkz4UYXLgNdoNWG3hIwui9rbf6/KGNz5ViBQOSI+drOa8wu3z1JneOav6nVhc770lua
 1cv41GABAMPV81agU4uKYUsbVDZ/ao1CSdXMBNHzAvycHs9POAo9ygiRvBRZRcP1PQXn
 pirkU61H0E0NcRjNfXV1cHpdVR1EFtPaES6xpHsP/EadlB5BYJkojI7j6YhrZmV79Yrt
 dwgbq8DuG8XbqoNfojIgeLrlWNBq9ZK9ueYIssae1YHQJImUa5iLVpwOWhyC/6gRl0nc
 9TEw==
X-Gm-Message-State: AOJu0YxP1M+tagH75rkpBCkm1m4DuycSRBnm40cELUzNbzYlSQtQV9F9
 IuTSm3UHQ2ybIGgcvemO6z2wgtGZ+NmoG/b4cgmNo0hIAzYOgT3Qw4WHHryUttMKvxbcsfMY6ja
 LfrdU9Uo=
X-Gm-Gg: ASbGncsTOZfmBFb7ZVl77nvIPW+MMhiYcy1mBRc/wFhWVndjNBtDK7EHF4yAht69Qww
 Uyl07O7ijND/hvTBsUKznW/IFwRiEQ95gZaWr2TDAYAEp827/im2ZJgSE9YThoLKzpXmeQlVI1x
 8XrB6AS4e6UvQ9s0QxxAvzT4KAWw4Ma9R/xF+vw8hXqm59KRFx4I7ref7EXj1eDGAUQhNOi2P6o
 84DFcbu9Nl0bX1IhUStnyT/POQQqpWmFX9+3eqqD2xVUkxRbmVWA4DdGsq+r9vG8d87f5FT3Fnv
 IbJg2igxcjUI6DWfEdOZV4xQe+yjiDGflHjNNRUpSuxjCrI71TTsfy47h1gPTYGMyHjhPNFa//P
 Tb8Eys0VMt6pwha3cr0zdhAQ=
X-Google-Smtp-Source: AGHT+IHtMKn1MuNZTWep7Ecyfea46Uiywz0myMylWYxUAo0E37a8BXyCU6MZfoS0cs8sQRHDyFDKOQ==
X-Received: by 2002:a05:6870:e0d3:b0:2d5:ba2d:80dd with SMTP id
 586e51a60fabf-2eaf089dcb4mr11428663fac.12.1750342508655; 
 Thu, 19 Jun 2025 07:15:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2eba6055950sm355128fac.24.2025.06.19.07.15.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:15:07 -0700 (PDT)
Date: Thu, 19 Jun 2025 08:15:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFH] Future direction of the U-Boot project
Message-ID: <20250619141505.GN6521@bill-the-cat>
References: <20250602222738.GC100073@bill-the-cat>
 <c5e8f85d-858e-4d22-8b6a-83f14c990328@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PGDbdKBIS+obZJLZ"
Content-Disposition: inline
In-Reply-To: <c5e8f85d-858e-4d22-8b6a-83f14c990328@linaro.org>
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


--PGDbdKBIS+obZJLZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 10:12:04AM +0200, neil.armstrong@linaro.org wrote:
> Hi Tom,
>=20
> On 03/06/2025 00:27, Tom Rini wrote:
> > Hey all,
> >=20
> > Something I've talked about in release emails earlier this year, and
> > promised a follow-up on but hadn't gotten to yet, was how to manage the
> > project moving forward. The email I made last week about Simon also I
> > believe highlighted some of the problems that we as a project and
> > community face.
> >=20
> > As a starting point, I want to thank all of the people (and companies)
> > that have been working on the project and doing the less visible but
> > important and expensive things that need doing. DENX has been running
> > much of the project infrastructure since inception. Currently, all of
> > the fast AMD64 build machines are from Simon. Linaro has been providing
> > two of the 3 fast ARM64 build machines (the other is from Simon). Our
> > patchwork project is on OzLabs group. A number of years ago, Simon
> > picked up the u-boot.org domain. There's likely other things I'm
> > unintentionally forgetting here.
> >=20
> > So, what are the problems I see and would like to get some help and
> > guidance in working on resolving? Well, in a lot of ways it all stems
> > from one root cause. The project was founded on the "BDFL" model,
> > which was quite common at the time, and a relatively reasonable option
> > too.
> >=20
> > But now? It makes getting resources harder. There are a number of people
> > working in the background now trying to get things donated to the
> > project (thank you, again) but I also know historically it's been a
> > challenge not having some distinct entity for U-Boot. Individual
> > contributions are best done as "I have a server" or similar. Conferences
> > are a strictly individual thing.
> >=20
> > Then there's the day to day parts of the project. I feel like I
> > shouldn't complain about taking vacations where I just handle pull
> > requests and not patchwork stuff too, or only doing a few things on the
> > weekend. But it also means there's no real way to handle contentious
> > issues other than what I say goes. Which isn't ideal.
> >=20
> > What to do about it? Well, I've talked with the Software Freedom
> > Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
> > before that, years ago at conferences). There are number of open source
> > and community focused projects that they provide a legal entity for and
> > help with administrative things. I've personally been a fan of what they
> > do, and donated yearly for a long time. I think they would be a good fit
> > for the project because they do this kind of work for a number of other
> > big and important and community centric projects. I would encourage
> > anyone interested to look at their website and look around.
> >=20
> > But that is something like step two or step three. The first step is
> > that I'm hoping some members of the community would like to formalize
> > helping with the project. SFC can help us with creating some
> > organizational structure for the project itself, but we need a few
> > people to do it. And before we even get that far, help with the mailing
> > list moderation queue and triaging patchwork assignments would be great.
>=20
> You can count on me for any help, for now for moderation and triage and
> I'll be happy to help for the project structure.

Thanks! Lets sync-up off list.

--=20
Tom

--PGDbdKBIS+obZJLZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUG2kACgkQFHw5/5Y0
tyw4twwAspV9MdKvQFBKOj0cP4U4rtSUWOFJ9fwSL0238BNVz8nYnGsQivIyfRoX
hOfaIEVLlvSAjUvuf31Fj4wBTfd8EpC27JRogDfzUCKz7vsdT7HWYtFmubiQ1XYP
A4qJ6SBHGbKjy+jKjZYtOpXEzHAJAMmQ2o29En/b6I21D954m5pKyYkFzwyAHlEn
StFlmQgEtM1FMc3o+XGf7s42MEkteZ6/DxS7lZw74PWD3bl3z5M6wXXCfn8ZakL/
BsyjRQvqfPE5m3bExUvNI+PB1UyOinw+DYV4KuxPVusV4CbSJsEYrR4rfIwkGtsN
xZrSxgTOhUVsPy+Rwztv4ctS49rbx0RQuLfw1Reu/zaALXoq+zJ/CBKAnQMHcsut
010CaNirVTx5xTtIYc/4ea41ucT0/1GTO1hZ2OsM6Qob6RXPqfLb8fSGCTaoUfZn
VwJOJ0tQNIpCoYedmAl+f89DFeOe+RlAk58i2fk2b0Fs/JQRuYYQI/F+6lHDayf+
ySEiHAVt
=x42K
-----END PGP SIGNATURE-----

--PGDbdKBIS+obZJLZ--
