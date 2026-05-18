Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A05FCD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 15:58:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CBF883FEE;
	Mon, 18 May 2026 17:58:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q2qtpBAn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF2184119; Mon, 18 May 2026 17:58:49 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3560E83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 17:58:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-439c3cc76deso1688500fac.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779119925; x=1779724725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ogM0XgRuDv3jxz/axBveVLzBjZYs/hhqlXjRjdqyLks=;
 b=Q2qtpBAnA6eaptxa+tNNGQnpNB1HtJ6JjY1aSlT9CggoR3kC1B5yEHLM4OdIeo6GAB
 CkJwqNckVag8SB0cy6v0qNEz7AHKvsE16E88zGKr9DniSPgYm5vwfYnWgoy8i9ebD6pc
 vhS0oIH313XQ2WkhkDiSGzzUuBL0lFn84e7Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779119925; x=1779724725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ogM0XgRuDv3jxz/axBveVLzBjZYs/hhqlXjRjdqyLks=;
 b=XALVpL7lfpcepblnMNBrzi5FWyQ4O6SXCMXDjE+BFrMRW0IcbHOR9SbouJMNK54JLC
 +rbQG+d5jREoDOTdnUyQh3/cwkjK0na4i7HaSqgO4C7Wy//cqi1UfV9Ok9B6bxjkcuZ3
 RYiDwMtxdFQ92PsbDHcrB0UeDDEvhA9cObTlgkLtGGAhFNduSdtBsHLqrpxI7IW/iXrr
 VO47hCTN+QG9YrEVVB2/iRJMveJ82dsZfwOojp82aAy0TQSioRXzp7NWUBlsvLEH1CrU
 7E3A+4ZS+2/PdUFooINs+NxPjgPG+KC9Xiqv0+j5ssYbVGh5Xn+qPN1IdKUE92SYkzJu
 xPHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Aq3YQTyLIxPxQdBMmJo7KY9CpYFipVSPTLrM66/02sl9n7AhrTWsQjQycMPlSUcWawND+gXA=@lists.denx.de
X-Gm-Message-State: AOJu0YxRirkhtHoquaC1Ghz4/NC9qrOgOUp0drJyrg0zWYUh5LOEblGV
 g0OIbrJaA5dmqqXi04FJVwG/gw9lPEEnPxpe2AIqo4wHf+oILLUljkMMAMKwj638MQQk2pe5CQ0
 0+SnZKE2keOsr
X-Gm-Gg: Acq92OEKXkOJEMw8lZ/vCvvhgsD4q4ar+fg6RrCEFthz3xHQvRu9vG66gTB6BIqOLzo
 4avjhkmyeh2yqjCcXyJFdE9W9IURMdtUD+/JREoWHZoJNiApMtj0crjquVfWhGq3tfcBP23T0fL
 llEiJ/8JcPdDI2SuPNILrfRWi2EFvS+z8ym6C+k3Ck1oFUU0/DVzP/F9nejDCcgCgiPAfLXjjAd
 fyt/8AtuMXAM0MGw0/XmyIeEWe8C1PEBXrjEYM97J1dZQD+KrtS4h1ZgDRNFtwRlnFyFx0azie4
 wXQj2hkef2XZFzWL4KpRf+Mt4luj60UyCpW9G/GKIgIio4zbhcBZF0zxw1bcGGVr+CMwa+QgtT2
 cRVGG4a7NiFHb8KWzqR/jEu3FmVfZqhXfssnliDCpPMfy/Cw5xIA7/6l64HA6piOa70TDqhviag
 KEgyGyrpHrIgvLVdlg7q877+AnZ6cPubFhvANp08Mjv6VuFpklpLnAcExeB2BXRDZ6IzJWwffjt
 0rX3iBoYEycDEPJUYb80WOYaHeyPsfOgmKWpjyk5mSb8XnTRHw=
X-Received: by 2002:a05:6820:62a:b0:696:15bf:ca5f with SMTP id
 006d021491bc7-69c9430100cmr10002365eaf.19.1779119925432; 
 Mon, 18 May 2026 08:58:45 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a956fa075sm4444730fac.10.2026.05.18.08.58.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 08:58:44 -0700 (PDT)
Date: Mon, 18 May 2026 09:58:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: AI-assisted review
Message-ID: <20260518155842.GR1858239@bill-the-cat>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
 <20260515220758.GM1858239@bill-the-cat>
 <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="B3jBl5VART0gRmbN"
Content-Disposition: inline
In-Reply-To: <46705f94-6cef-4016-ab05-7839514e9257@amd.com>
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


--B3jBl5VART0gRmbN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 10:55:40AM +0200, Michal Simek wrote:
>=20
>=20
> On 5/16/26 00:07, Tom Rini wrote:
> > On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:
> >=20
> > > Hi,
> > >=20
> > > There was a query on the call this week about whether I am doing
> > > AI-assisted code review. As I said on the call: yes. Here is a brief
> > > description of how it works.
> > >=20
> > > It is built into Patman (on the Concept tree) with a new 'patman
> > > review' command. You give it the series name / number, or perhaps a
> > > patch name/number and it applies the patches to a new branch, does a
> > > review then adds its comments to its database.
> > >=20
> > > A '-d' flag can be used to create draft emails in Gmail (sorry, it
> > > doesn't support other email programs yet). You then check and update
> > > the emails and send them (or delete them). I am not an expert in
> > > handling the 'user voice' part of AI, but have made an attempt to make
> > > it follow any provided configuration, as well as to scan recent
> > > reviews to actually create to create a voice.
> > >=20
> > > Obviously this is very rudimentary and could be expanded considerably.
> > > But the mere fact that it creates draft emails is a win for me, even
> > > if I ultimately delete or rewrite most of the comments. I can imagine
> > > 10 different ways to improve it to be more useful.
> > >=20
> > > I wrote a blog post about it if you want more details, or you can ask=
 me here.
> > >=20
> > > I am very interested in hearing how others are using these new tools
> > > for code review.
> >=20
> > And the big thing for now is that since we as a project do not yet have
> > an AI policy aside from "please don't". One of the points I was making
> > on the call is that there's a difference in value between "Human
> > reviewed it, looks fine" and "Human spent some tokens, agent didn't see
> > any problems".
> >=20
> > And I know several other people have been doing at least first pass
> > reviews with various agent-tools, it's just no one else has been posting
> > reviews at your scale. And lessons learned from other projects is that
> > the prompts are more important than whatever wrapper around the agent
> > one is using.
> >=20
>=20
> Don't think scale is the problem. Tool and integration is another topic.

Simon posted approximately 100 reviews in about 24 hours. That scale is
a problem, when most of them are just reviewed-by tags, from someone
that has a history of doing human reviews. Reputation is a factor here
I'm trying to figure out how best to articulate.

I have thoughts on the rest that I want to get back to later, thanks.

--=20
Tom

--B3jBl5VART0gRmbN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCags3LgAKCRAr4qD1Cr/k
CnI1AQDetZcGlNLTpDFjEmG8yVDjsiEQ9CKSenPNmsUzOVV9jAEAoS0kP+V405LS
qf00EO6RoKZM1vLplxZMVrrm1Any/Ao=
=0cNE
-----END PGP SIGNATURE-----

--B3jBl5VART0gRmbN--
