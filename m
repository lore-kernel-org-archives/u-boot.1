Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E51EC021A0
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 23:42:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C791C80F9C;
	Fri, 14 Feb 2025 00:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JgwMoE0n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A256280C77; Fri, 14 Feb 2025 00:42:31 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32D280FA6
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 00:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-6f4b266d333so11636387b3.2
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739490146; x=1740094946; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=q+TbpFFpNJbtBMA3aK8GxXtugISUIQ7LK9VBJtdmYV4=;
 b=JgwMoE0n6hNZ1L/jO+mQl15eVkqQYdl1yqjq3RcSzRMiJLF7nmr/JZkwNn6d9on+U8
 qrci4+8oOipisbSnbDG1IJr+6J/9ALa/n1Cqf3dnBp4vwoqWZG4SLe9vs0FCvn9EznRJ
 hBrixZF8tamWcCZRKtbNWQ4D1i1DcLMZ2hT1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739490146; x=1740094946;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q+TbpFFpNJbtBMA3aK8GxXtugISUIQ7LK9VBJtdmYV4=;
 b=FX1uqU5iQZmJZeC5Xxxzjcc6ctytyUhuxvfLPrhEEjkt3UBG4wgZdcdAIEewvg+nDS
 UmmcP2rzYgRXXTSX9hFbZjs+CrbWW2v+dBoeco3weFzN/21QIip+7/ODsCWZxH2b3cRP
 vQ5a55WX4BX2opyGzIjkbgEiPsPCLGxsChNyaBEobXq6ZA4iZAriH3QKKAsstWvFhUEK
 rWfEHsCAHm80m8IfXkjsoPaOSuNFYlomJhns6I7qdgxvNEJYPL2L33xnJBTekxfBTT0s
 pC6flECK5k98XHAQOAOfj9ar9UmcZJrTp4OvZyPtVZPu2yL1yVqzssqArQWIDcnpJUkg
 GsJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWm0zFjbafWt5wG+7b/VNZWzwaHzsbpSwZrfYzZ/fNEXe7BzlkpW1ofyoAXRpAwt9+q8iz/0To=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1fTArO0IXsLUxWlsVYNXK8LwV3q3m3ZE3kHmXXFuDhyqq6xvK
 Gs3JRpInGZa9iq8VinQis5Bj5Jc4DJswSAqMjIj0nYeDxexItKy4SNil/Zk6x0M=
X-Gm-Gg: ASbGnctwVdPJWc7T41Frl/Xx3lYYZnUF9VzhU6Hq8HGAJila6uBH8KuB5ginw8J4ZFV
 X1b+oari8yuQCSHYtwNFHnrdkhHF7bMdv6BfdpC6Z4DWIBJWTMVlXhCvc9h6ER5BAWD4MfHBF/C
 75J1PBJRkbVjfE+lik/Hfb2Ag3MS8yjPgeiqDTw9dNCDZ5ki6v+oDtrJVpLRO4XNbM6tckNhlyl
 ZKx7DG7i4RZZ6aRslF8k/hCQmaSAXleWk+gFyxoEYEbWvZO0/Rd4RRRYDUzVzd1xebhs8PiFeS6
 1vkmeKCfob/ixxk=
X-Google-Smtp-Source: AGHT+IEqbV6M57Srw+oFlDjm0eyCIvW9W77dXQBZspCppg9+jyO1GRcE/YaUrmEvIFIIlzEWhjYmOw==
X-Received: by 2002:a05:690c:6386:b0:6f4:4280:2433 with SMTP id
 00721157ae682-6fb1f5a5f34mr87204697b3.9.1739490145643; 
 Thu, 13 Feb 2025 15:42:25 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fb35f65bb5sm5372017b3.27.2025.02.13.15.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 15:42:24 -0800 (PST)
Date: Thu, 13 Feb 2025 17:42:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 U-Boot Custodians <u-boot-custodians@lists.denx.de>,
 marek.vasut+renesas@mailbox.org,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: Generic U-Boot
Message-ID: <20250213234222.GE1233568@bill-the-cat>
References: <CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=ieT2oaHfgLf3_nC+xXA9g@mail.gmail.com>
 <20250211212222.GH1233568@bill-the-cat>
 <CAFLszTjaGsXZH6_CAbBhwJ7MAPdzdOUYn=CVBewQKCMX2CS1EQ@mail.gmail.com>
 <20250212164000.GO1233568@bill-the-cat>
 <CAFLszTghQcXGUWS-5GRtWydMzLyYKgKKi7Sd4_NikVrDGHkuzA@mail.gmail.com>
 <b5d2bd37-4424-4660-b5c3-d505e5485ced@linaro.org>
 <60e3e20c-3a02-4965-a3a4-a1b12335614e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LFZYFjM2Y/y5k2/x"
Content-Disposition: inline
In-Reply-To: <60e3e20c-3a02-4965-a3a4-a1b12335614e@linaro.org>
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


--LFZYFjM2Y/y5k2/x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 03:10:36PM +0000, Caleb Connolly wrote:
>=20
>=20
> On 2/13/25 15:03, Caleb Connolly wrote:
> > Hi all,
> >=20
> > On 2/12/25 17:41, Simon Glass wrote:
> > > Hi Tom,
> > >=20
> > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> > > >=20
> > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > > >=20
> > > > > The way I see it, both schemes remove the ambiguity. Mine retains=
 a
> > > > > single deconfig file and a single 'make menuconfig' for each boar=
d.
> > > > > Yours feels more like building independent U-Boot images.
> > > >=20
> > > > It is explicitly building independent U-Boot images, yes. With a wr=
apper
> > > > around "make all of the images for a given platform". So much of our
> > > > confusing and messy code is because we aren't doing that. And since=
 most
> > > > modern SoCs can work as (mostly )generic SPL selects correct DTB fo=
r PPL
> > > > we really could have fewer overall build configurations.
> >=20
> > Big +1 for this. Most Qualcomm platforms in the wild today that would
> > benefit from chainloading U-Boot will NEVER be able to run any stage
> > except PPL due to codesigning. For these I would ideally never like to
> > even think about non-PPL stages since they only added confusion.
> >=20
> > At the same time, it would be great to eventually have U-Boot SPL for
> > Qualcomm platforms that can replace Qualcomm's proprietary sbl1, and
> > maybe event some even smaller/earlier secure TPL(?) stage that replaces
> > their xbl_sec.
> >=20
> > I would very much prefer that these be distinct, since they vary in how
> > board specific they need to be (see below).
> >=20
> > Folks who are just contributing support for their device/soc (a few
> > quirks or simple driver ports from Linux in most cases) are going to
> > have the best experience when the learning curve from Linux to U-Boot is
> > minimal. Mixing up various boot stages into a single defconfig and
> > having custom kbuild infrastructure is the opposite of that, and seems
> > unnecessary.
> >=20
> > >=20
> > > I'd really like to see a generic aarch64 U-Boot for PPL, although it
> > > would be quite large with all the drivers. Perhaps we could start by
> > > having a generic Rockchip one, for example.
> >=20
> > We already have this for Qualcomm. Some small QoL things still need to
> > go upstream but you can build a single U-Boot binary and boot it on a
> > bunch of differences devices just by using the right DTB. See this build
> > script for example which builds for just a few devices:
> >=20
> > https://gitlab.com/sdm845-mainline/validation/-/blob/main/build_uboot.sh
> >=20
> > I think a bunch of things in mach-snapdragon could be moved to a generic
> > mach-aarch64 that could also target other SoCs like Rockchip or
> > Mediatek. I'd be super interested in helping to make this happen.
> >=20
> > Probably would even want to put more things into common code so other
> > architectures can adopt it (and make themselves smaller), then mach-
> > aarch64 can just be a stub for devices that are fully generic.
> >=20
> > The other potential concern with a generic aarch64 target is that we
> > then lose track of what devices are actually supported. It would be nice
> > to have something like a list of DTBs either in U-Boot or in some
> > associated infrastructure we use to build reference images.
> >=20
> > Which all ties back to the goal of providing distro-agnostic U-Boot
> > images to make Qualcomm (and other?) Android phones capable of running
> > more Linux distros.
>=20
> This has been very successful for older Qualcomm SoC's using lk2nd which
> supports a frankly ridiculous number of phones
>=20
> https://github.com/msm8916-mainline/lk2nd/blob/main/Documentation/devices=
=2Emd
>=20
> notably with just a binary per soc:
> https://github.com/msm8916-mainline/lk2nd/releases/tag/20.0
>=20
> They also do some fun things with DT that we might find some inspiration =
in.

There's certainly a lot that can be done with "generic enough for a
single family" as the goal. And there's cases where that's indeed both
enough and the goal, and we should support that as much as we can.

--=20
Tom

--LFZYFjM2Y/y5k2/x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeug14ACgkQFHw5/5Y0
tyx6pAwAt97nnlHl4FM3nfbdb4hV1aOjVp6gaGUtDoYb8TD4R3HOa+HDwPvpdgwp
0GWgeBqunmLCpY2g8pY5ddsYsnqL8N3z2buJQ8OJrlbmtqEr+ReCByDL4Y3X/x28
uawfJyIJie1qG+aP8hWt8L1hnP3oETYeER4VdV5WpP76gE07Y/2Ey1Xvh1TYaWd8
Gp/389uxVH/sXrmlJDFs3DOMw5QUNmzeYPKlvcHfqikW2f9EZokJZpoT/fdTPgK3
2WsRFXhuPzC8ewuEZLNDSI3kwgDbMx36r2erljguczdvKmlFO4RwY6kWzVKES27V
Lsc8KURpAJexAqsQkzOBETepgcg3jHwlWg5IVBWDK3sTSCUVF/pWvdJj1vf1psKb
qx2cwsf3OMs+wYGId1YXLMbxzC5srz01W7SnKOjT4Y13F/MfsxMGdU4zQrlfN9Xn
0r/fgW4G4pojII7t73wlHuCASUzsdJFYJgnzaaVQ8YEDvG27y1HVI4ltYNLcBbTB
Hvgh8aEc
=JM82
-----END PGP SIGNATURE-----

--LFZYFjM2Y/y5k2/x--
