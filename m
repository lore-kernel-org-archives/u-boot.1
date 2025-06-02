Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EE0C5AD49
	for <u-boot@archiver.kernel.org>; Mon,  2 Jun 2025 22:27:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 425EC80F9C;
	Tue,  3 Jun 2025 00:27:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rb3zrpHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B0A681E72; Tue,  3 Jun 2025 00:27:45 +0200 (CEST)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D503080F0E
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 00:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4033c70577fso2677993b6e.0
 for <u-boot@lists.denx.de>; Mon, 02 Jun 2025 15:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748903261; x=1749508061; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K3KOkA9vcnExGBorB0SCPlKWiacPgYEEy8cK7DGADqQ=;
 b=Rb3zrpHZwol+LU9bb8oMP3MUxWKo9Tzvk+tStgrIl6S3CWWSWOJRWcMLcMT4TFQoOD
 dSTqvd2HDOXwe76NiqG/Gg+eZuKlPWy5/Atituup2QX1qhE0FnPJwwdKoxAFlqtxeRPL
 2X69pbJ4we1Mda+krwOSCfL9QpekBiLrAxyGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748903261; x=1749508061;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3KOkA9vcnExGBorB0SCPlKWiacPgYEEy8cK7DGADqQ=;
 b=EEfQvqCYnbj28ntMybekhGmXhrU54EQRtzGr0w+vY4/65aEIKaFTpZJOfdxxejAE9R
 fOeqD6PqGGxzlzFicisvmjqD/eTlC9Id7dHSnX40X4QubecHYp2UixQGpoysuuaKSqeL
 Ant5kwVBsPT34ni18atDERc1ZyhY3mMFtJ/Qqw03baMtaR8XdU+fUC7atzLRHSUuWQ3I
 PaWp5mbu7ID474QJULU+C7LIj8UflCl2ZJTyCvqRgoOtBi8xrdCBSOTExXmYNniFAJXh
 /LmFlSH9Ct23HYFHD6vc2S35TB0QY3+hdtaUNGF0JLcsts1Unec4oscXEScG2dEHOSmr
 Hg9g==
X-Gm-Message-State: AOJu0YxBjRtPF139w+S13PSogIGj6VHI0N8MykXTTkowwgEMCAULkp1P
 ycCaZHJkBCe9abrt3eMrJ5l0AggOc0RyOoNdiUPupXx+fJ1QPV5Y5YFvfhuc5ba2t7/kOfgyyGD
 dQDlepPM=
X-Gm-Gg: ASbGncspF4WCTGYGlVuXhpTmAENUAEM2clrgTqtT1sej503kNT4zw1dF99P2b6T9I91
 JqKn4K/heVDRUkm6AFu7VkdEhFY4ylfcUooJI5S2vQumpPWMtoN+1SDNO7aCO1PKakvVch0n0o7
 wexzNO3DH46djtex0Oc87vIrdbKCHexwOY3XKOee8bMqDq5Ytdy3OlT3fIELyC86f9fMsCmPMZo
 zm4LJ9Z5dTdpk+jA3J+ux62IfgYAMvEESWC9f2jSn7eSjC+4XSv+ED3GsogaBVk4z5KoBjn2rwh
 D38t2zsQlr5G03WIzACByYbKnja35t1wGYTSlbpwRtZ11rZYOPxLBZmfbFZFe4xQYwD0oCXbEh1
 xMoRBmLJptg4o
X-Google-Smtp-Source: AGHT+IEucUnL6gUaABkLk2OHbVzZiLUil5GjTYUWa/dCUYiuwXX78h91ThNoNtOhdmKNMO74tovX4A==
X-Received: by 2002:a05:6808:2116:b0:404:a09a:dc0d with SMTP id
 5614622812f47-407a662416dmr5692579b6e.33.1748903261519; 
 Mon, 02 Jun 2025 15:27:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40678ce8fedsm1600309b6e.34.2025.06.02.15.27.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Jun 2025 15:27:40 -0700 (PDT)
Date: Mon, 2 Jun 2025 16:27:38 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [RFH] Future direction of the U-Boot project
Message-ID: <20250602222738.GC100073@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+HRbEPrvfdoriO+B"
Content-Disposition: inline
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


--+HRbEPrvfdoriO+B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Something I've talked about in release emails earlier this year, and
promised a follow-up on but hadn't gotten to yet, was how to manage the
project moving forward. The email I made last week about Simon also I
believe highlighted some of the problems that we as a project and
community face.

As a starting point, I want to thank all of the people (and companies)
that have been working on the project and doing the less visible but
important and expensive things that need doing. DENX has been running
much of the project infrastructure since inception. Currently, all of
the fast AMD64 build machines are from Simon. Linaro has been providing
two of the 3 fast ARM64 build machines (the other is from Simon). Our
patchwork project is on OzLabs group. A number of years ago, Simon
picked up the u-boot.org domain. There's likely other things I'm
unintentionally forgetting here.

So, what are the problems I see and would like to get some help and
guidance in working on resolving? Well, in a lot of ways it all stems
=66rom one root cause. The project was founded on the "BDFL" model,
which was quite common at the time, and a relatively reasonable option
too.

But now? It makes getting resources harder. There are a number of people
working in the background now trying to get things donated to the
project (thank you, again) but I also know historically it's been a
challenge not having some distinct entity for U-Boot. Individual
contributions are best done as "I have a server" or similar. Conferences
are a strictly individual thing.

Then there's the day to day parts of the project. I feel like I
shouldn't complain about taking vacations where I just handle pull
requests and not patchwork stuff too, or only doing a few things on the
weekend. But it also means there's no real way to handle contentious
issues other than what I say goes. Which isn't ideal.

What to do about it? Well, I've talked with the Software Freedom
Conservancy (https://sfconservancy.org/) (SFC) earlier in the year (and
before that, years ago at conferences). There are number of open source
and community focused projects that they provide a legal entity for and
help with administrative things. I've personally been a fan of what they
do, and donated yearly for a long time. I think they would be a good fit
for the project because they do this kind of work for a number of other
big and important and community centric projects. I would encourage
anyone interested to look at their website and look around.

But that is something like step two or step three. The first step is
that I'm hoping some members of the community would like to formalize
helping with the project. SFC can help us with creating some
organizational structure for the project itself, but we need a few
people to do it. And before we even get that far, help with the mailing
list moderation queue and triaging patchwork assignments would be great.

Thanks for reading this, I look forward to finding a sustainable path
forward for the project and the community at large.

--=20
Tom

--+HRbEPrvfdoriO+B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg+JUIACgkQFHw5/5Y0
tyx3gAwAhbZ+unxyuO4A+rgEXGyGbDrreI/bwrd+hCPwGN1mKyK1BFu8zTEIKBhJ
sOKCwj4ydiuRCua+rtY12Ohud/RsIaNHBYnCz6+PKCssYe3mYXtTb28AHvaKkmKu
3qso2NnymshmZfxqZV/iNq5PJx8NetclKgHcIZlrItNsVhT1qB31SbIPgpFPn/2d
0O/QXyp7l1fW6QzCCPHzgvRJ9V+31am3XscMSQGg/4x6JGJoRSANcqUWIK7qTsyX
gKpPkvDrl8oUzHctx+DrUQikLa8HrgsTBFgIdDbgVTkYpiVsrW905lKMp2vrDIYB
lmk+G8OP/LzawPeQow+1FRWI8fVOTz5eYuS7Tw6bhQ0nqNKpVHvJd5Sca8iJkXJn
zRTN5nSXsDF8XJ4WkjermfBTNtqpyrGauXG4Th4DilDrLXmOg/GlsdvtiwzjDi6y
WeEcaPqhEcJCoosuxUzK9R6gfou0yvebCSFm2U/kvXbyoFm+9izHMlK5YD2JHaj/
szw+/DqA
=If8r
-----END PGP SIGNATURE-----

--+HRbEPrvfdoriO+B--
