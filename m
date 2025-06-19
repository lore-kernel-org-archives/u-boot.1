Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C1EC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 14:14:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BDC382CEB;
	Thu, 19 Jun 2025 16:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a+INLWPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB13582D2B; Thu, 19 Jun 2025 16:14:21 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C80982CBB
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 16:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-40a8013d961so202858b6e.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750342458; x=1750947258; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mVtRs187nWhyL/eMr6Y7h8P7Z3O0Qm8saF+vbyPuOTs=;
 b=a+INLWPPmMMCFzpzT2JXAetR4Byzp+GfzZQ/NDQsEklDwpu6YyG3m26a98uwkZA6ZG
 6mSyLaG4g1fKfRUcUZrgmA/sW11MeRO9g8a/cy18TIn5HxlyLwiRhNjOl//wMUWlVJAc
 jzwXQnL3rfMDTSpb2YdX5SeTG+kNVYKYD9mwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750342458; x=1750947258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVtRs187nWhyL/eMr6Y7h8P7Z3O0Qm8saF+vbyPuOTs=;
 b=m4pHO3KYrAEITpaF4UpTA7APH5xxSIIzJHWKT/kETFTp43MlkP3xEODqi2cWbuY1bg
 0fcd91a8ITzNhLD8GpMZAVK1HE2S+hZjq4mE4eWPbf+Y+v/tjaayYr6rqVw4zZRVNSxv
 vvHmH3jm6EcEzyfT/9IJWHwXnIzzLJ69xAIVXlLNmn+y07c/aB7K0XAWtO3HVpa+cNTH
 h6PWF4MYfz15yRz6QrKhkHRVsQMzipju0wwEdi8PyouQ+oWLQ2y8N4t2Euy80EMYdxHP
 26dUMRHIU1wnDojVkuTkmK0SmEG0LQNZPLplVMuuw7WkYb8veolcFEEVsFZfaAQ8c9T4
 IN4Q==
X-Gm-Message-State: AOJu0Yx20F/CipYki/46Dw2BCVoj78LjM5qeFVSgiTv7NCSWNdkQaxXV
 FcuZlxH/Ykv57uus/jEUT+AZwenzD7N57EyjKClzXR4pxpVCz05tKXkGJwwddDcNHwA4TL6EpXS
 3Y8fleFs=
X-Gm-Gg: ASbGncs6KqvWuI+ofL0TS9LElacaIx9OUHqgAOP7LEkTcr/YJauq+WFna9A3BuHRCkX
 t/HkUJOrLyEjBHSjzBRWMMcif5KZQmhGw7TYJmqBcUb/c6kYOi/3BJjFEsdIlGX4qvNHoXwdFwG
 1TspSsTSJvYlC+tyohUbkkCXSf6A1/Xb9hjQzClHlo5N0cK8IO9CrgaV9jdBjNYdOu7kkE7R4t0
 SVw5BaZazfSdE90QXenrk540FzZXN9l6Ixk9CqaxpnpJtLKP11UyGlUbRFT+ODYM6IMtDRNetFu
 yvWyBaHfN4vaCqdmlKmYieubRLXghm8S99kEcApZ2UuF5rTs1sj5T35XR43dB3pnq703Qt6Z7EY
 rIfZsPNYNDHu8+QuIDLyXqlc=
X-Google-Smtp-Source: AGHT+IE7Iv+Xn42O/wyfF0DIVlkiBu4uyQFAhlm54Y2QR3N8zuvBV8o2r2yEoawW9x6u9TIBO7vJsQ==
X-Received: by 2002:a05:6808:1484:b0:409:f8e:72a7 with SMTP id
 5614622812f47-40a7c23d095mr12167023b6e.33.1750342457764; 
 Thu, 19 Jun 2025 07:14:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a740b2808sm2765082b6e.6.2025.06.19.07.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 07:14:16 -0700 (PDT)
Date: Thu, 19 Jun 2025 08:14:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de
Subject: Re: [RFH] Future direction of the U-Boot project
Message-ID: <20250619141414.GM6521@bill-the-cat>
References: <20250602222738.GC100073@bill-the-cat> <87msa5ttlw.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nAxHo94+V5a2bEly"
Content-Disposition: inline
In-Reply-To: <87msa5ttlw.fsf@kernel.org>
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


--nAxHo94+V5a2bEly
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 09:08:11AM +0200, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On Mon, Jun 02, 2025 at 16:27, Tom Rini <trini@konsulko.com> wrote:
>=20
> > Hey all,
> >
> > Something I've talked about in release emails earlier this year, and
> > promised a follow-up on but hadn't gotten to yet, was how to manage the
> > project moving forward. The email I made last week about Simon also I
> > believe highlighted some of the problems that we as a project and
> > community face.
> >
> > As a starting point, I want to thank all of the people (and companies)
> > that have been working on the project and doing the less visible but
> > important and expensive things that need doing. DENX has been running
> > much of the project infrastructure since inception. Currently, all of
> > the fast AMD64 build machines are from Simon. Linaro has been providing
> > two of the 3 fast ARM64 build machines (the other is from Simon). Our
> > patchwork project is on OzLabs group. A number of years ago, Simon
> > picked up the u-boot.org domain. There's likely other things I'm
> > unintentionally forgetting here.
> >
> > So, what are the problems I see and would like to get some help and
> > guidance in working on resolving? Well, in a lot of ways it all stems
> > from one root cause. The project was founded on the "BDFL" model,
> > which was quite common at the time, and a relatively reasonable option
> > too.
> >
> > But now? It makes getting resources harder. There are a number of people
> > working in the background now trying to get things donated to the
> > project (thank you, again) but I also know historically it's been a
> > challenge not having some distinct entity for U-Boot. Individual
> > contributions are best done as "I have a server" or similar. Conferences
> > are a strictly individual thing.
> >
> > Then there's the day to day parts of the project. I feel like I
> > shouldn't complain about taking vacations where I just handle pull
> > requests and not patchwork stuff too, or only doing a few things on the
> > weekend. But it also means there's no real way to handle contentious
> > issues other than what I say goes. Which isn't ideal.
> >
> > What to do about it? Well, I've talked with the Software Freedom
> > Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
> > before that, years ago at conferences). There are number of open source
> > and community focused projects that they provide a legal entity for and
> > help with administrative things. I've personally been a fan of what they
> > do, and donated yearly for a long time. I think they would be a good fit
> > for the project because they do this kind of work for a number of other
> > big and important and community centric projects. I would encourage
> > anyone interested to look at their website and look around.
> >
> > But that is something like step two or step three. The first step is
> > that I'm hoping some members of the community would like to formalize
> > helping with the project. SFC can help us with creating some
> > organizational structure for the project itself, but we need a few
> > people to do it. And before we even get that far, help with the mailing
> > list moderation queue and triaging patchwork assignments would be great.
>=20
> I'm happy to help with the mailing list moderation queue. I'm in Europe
> timezone.
> I will be away for 2 months (August-Sept). Please reach out to me if you
> think I can help.

Thanks! We've talked off-list but I did want to say something in public.

--=20
Tom

--nAxHo94+V5a2bEly
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUGzYACgkQFHw5/5Y0
tyxhFgv/b6e5tnxrMRQNLljvOPKuowoJPEsz5AKKsbXGbbqIdqcrjKfBGQ590GOt
Id6Li3ktdMPE3J53+OjUMUEZLguCW2znaS47/0JbUDTFbrf65+cf83fGgQFh5XvK
H51QdKcswYPFl7ns9fD++gdpSLDeIH/Hxug3cNmEHdaLI2BqOYKojq2CMWxngcW7
0tkjYt+VkWCYmSps9YJLRdHGl52fQBoXCjincNmYZM0PUC4a0njkpw30EwG0YUFC
z+zUw7msuHzzJ7IDxd+QEWvTUebo24Ir91JYwJuKsYdEcnl2HOGEr3juGrwe38lw
Yi00nce4VjOHpyEHVAUfEPuN5YgMOh4h0qh13nsrPXZdMGdNPXhY+RTA3N8zJI1n
4fN3O3jm4IeyvibjKq/SVxbV0wnlUxNbwMJuAjfNe8ME0c1XyLsIxcwBDaKtF9Pf
bfMfmmirRE6oEU1XS0sUYYbWV1YNAvyb2G082cmXVr6bXRTg0G8Fjzl0kY6dk3s3
o9IcSdWV
=UYMa
-----END PGP SIGNATURE-----

--nAxHo94+V5a2bEly--
