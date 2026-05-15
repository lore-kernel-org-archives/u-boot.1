Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F96DCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 22:08:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 070FE8480B;
	Sat, 16 May 2026 00:08:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JPhng06R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E24A8487F; Sat, 16 May 2026 00:08:07 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA84084713
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:08:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so178879a34.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778882881; x=1779487681; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XH4wtrQqh3X7Zc+FldlF9/uvXKfRhnBRXVAhRWUyjNE=;
 b=JPhng06RiPkwoZ9wmblsuVyjNyQF+s2teL21Hwmn/GQHl85vF3pAPUPNxxPQUsxFWy
 igvC9zrh8qIsAax37I6mewgxgrysNg6FK3m16Uj4HbL7sGFKgtBiO53NSU34SZy8yfjq
 vtxoXhtK1Vzs91Ld0Mel0OgpYqdPQVR7UlXjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882881; x=1779487681;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XH4wtrQqh3X7Zc+FldlF9/uvXKfRhnBRXVAhRWUyjNE=;
 b=WNyNyJD/DO7GOFYHch8Iqp3w7undMEAhgny73/1JNyWlxgaBUn2gmebSXN9axPPiJQ
 z5xxFX6mhntabKlvBBFOeuARuJWJxjOc5UufCx6Y4jcs/YTJaCKqmg7v2Jjhx70X1c3M
 vrfVeqCtkAflvMLM16F3HVwz7T+HZLsu65qys1NVjsOMi1MXTaWxlIe9HA4kJMxTFIBn
 vi3mtkVsUn9RZbQhs2xdNoXKag/5MGhMlj/Jyn0nrZKjPpa+17mELWU9MNfIOLObEkHr
 L+zTxkHduk/EimA331j1At7JSRh9qd2IU02+1jEU9q8sXGbisOUn2r3LNI0HtANBpFC/
 2c0w==
X-Gm-Message-State: AOJu0YyoaEnYO3U99BEjN1lGueQlP6DP+FCuQYwuHRoC7NAUF2wqbos3
 VVJSkteCaBKhpt1cqBtbePk8FuV9e7K/J5e+iBW8w9AfO+kd0x3WQ1YSDH/O5WnGE0rDCJQz3Em
 NTQTH7dXEGAEg
X-Gm-Gg: Acq92OFVlbKnUqqrlYqBJ6SSJz+BZMjzAFrAhQVAZ02bhsZK1Ji9VSENij50iBvZQSS
 LNsZfM3kMTIH/nuN9BZPDsEbzCdABteeQKQYdofIPJfaE/WPd8lQPq0KUCmX9nYZKXyuHqAwN1Z
 eGptRNrWJSq4z6TGE5GMm3+4db8erypJD9Wh84bfoSxINDss32BWeTB8hRFhlPwApI9dU9qSY95
 h0d49RWQrxtjP0gYznFeFP5k7PWGUZDeDKt90uWf0AhNSfim73HBWb2ou0Kl5UPw438Hb9gMtVT
 KWkIAqMelthQ835c9ApIiMIrp3WBriUHKTtcCXoxuVy/pPi0ELe0iqH0/1Ee6kEeTIQuKnRk2b9
 hT+JauS1Wi4rInDnjTzz2SfUtrh9ih4q7eQDt0d8rrJmHIlirctD+i0jRNOYFGF32qo4PXOgKoX
 oHZtpH5SE+vVJp/UlLjOiOMN29K3Zd8yxH5m7+Pidveb0lOapya+K8JRxG5zLQ1EBn8c7x4yRBT
 9h3hlsysKaVXLjWrahO9eWUduD2RhChDv+eJbB/fSEQMiYSEkp51nmD4IciEA==
X-Received: by 2002:a05:6830:4989:b0:7dc:da06:c0f0 with SMTP id
 46e09a7af769-7e4ea087f57mr3790125a34.4.1778882881506; 
 Fri, 15 May 2026 15:08:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bbd0be3sm2256378a34.15.2026.05.15.15.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 15:08:00 -0700 (PDT)
Date: Fri, 15 May 2026 16:07:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: AI-assisted review
Message-ID: <20260515220758.GM1858239@bill-the-cat>
References: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WI9kxSV5A7dn/TFQ"
Content-Disposition: inline
In-Reply-To: <CAFLszTjnL6rn_mTA+jhcrRLF0yEtN4FVwTeGGy9GeGbgdB9fYw@mail.gmail.com>
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


--WI9kxSV5A7dn/TFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 03:03:21PM -0600, Simon Glass wrote:

> Hi,
>=20
> There was a query on the call this week about whether I am doing
> AI-assisted code review. As I said on the call: yes. Here is a brief
> description of how it works.
>=20
> It is built into Patman (on the Concept tree) with a new 'patman
> review' command. You give it the series name / number, or perhaps a
> patch name/number and it applies the patches to a new branch, does a
> review then adds its comments to its database.
>=20
> A '-d' flag can be used to create draft emails in Gmail (sorry, it
> doesn't support other email programs yet). You then check and update
> the emails and send them (or delete them). I am not an expert in
> handling the 'user voice' part of AI, but have made an attempt to make
> it follow any provided configuration, as well as to scan recent
> reviews to actually create to create a voice.
>=20
> Obviously this is very rudimentary and could be expanded considerably.
> But the mere fact that it creates draft emails is a win for me, even
> if I ultimately delete or rewrite most of the comments. I can imagine
> 10 different ways to improve it to be more useful.
>=20
> I wrote a blog post about it if you want more details, or you can ask me =
here.
>=20
> I am very interested in hearing how others are using these new tools
> for code review.

And the big thing for now is that since we as a project do not yet have
an AI policy aside from "please don't". One of the points I was making
on the call is that there's a difference in value between "Human
reviewed it, looks fine" and "Human spent some tokens, agent didn't see
any problems".

And I know several other people have been doing at least first pass
reviews with various agent-tools, it's just no one else has been posting
reviews at your scale. And lessons learned from other projects is that
the prompts are more important than whatever wrapper around the agent
one is using.

--=20
Tom

--WI9kxSV5A7dn/TFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCageZOwAKCRAr4qD1Cr/k
CgxwAQC9D8peEO/W8A+UZfddfpRnrj1lIFEDSlmPq8Y2bzGm7QEApIzvn9GCEpYp
nPCUNZ3ucBcKHFDJJiwZBN23xPcrnQM=
=hRzf
-----END PGP SIGNATURE-----

--WI9kxSV5A7dn/TFQ--
