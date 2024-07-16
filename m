Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25722C3DA59
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 21:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59B7588348;
	Tue, 16 Jul 2024 23:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZKgl7A6C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76D5B8843A; Tue, 16 Jul 2024 23:36:25 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ACC888266
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 23:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-708cf5138b6so2136241a34.0
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721165782; x=1721770582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7wFtKjcFlPbhJBq9ac+R64M/kesEQ1HMeo8J219aq4=;
 b=ZKgl7A6CQoLKMTAKtZiELzhKZAVWm6nyXsCL23X8MDRAtlB4yRaMAOJ8Ng2m5/tPip
 Jr/ejEN2NPPOzX8S3vZMZbpz39vMEFxYiBrz9SvgiCnQEXJdPBOKBm00X72Md0bpiCeY
 E37YipkBu8ZOSLXJpK7W1dAwhEahkWMl8foIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721165782; x=1721770582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7wFtKjcFlPbhJBq9ac+R64M/kesEQ1HMeo8J219aq4=;
 b=IhUm/zUMZ/6y2d4oqQ2rPyQGthFDgq8TZc7p3WKDboehN84BSqsVLoZvMDZiS0XXHi
 pDDv42aH4Ng4aenzZzT5AoeqnaMnxe5E5QdJm/MZxK/eBtXCknSz2+YjRsF4JxXMdSqC
 W6bxqDeuN6Q0JiNBYH4DSxE8lIMjM3vYFDQbFdeynv4DhKQns8HFYK9R+lV74ESoa5kI
 Wy/ZSyaS7noj3LitVuo6dOWY2rmsDQyEBn8EEJEIHVZodOEfLU7b9OOdWZnsxtm1OFFt
 e6+kl8EvjvBNF0LlDqDugSGyf0XmDfaueCzI1+Q9HkhYPYcsCHzhOSuoWXNp8bXFRqz8
 b35w==
X-Gm-Message-State: AOJu0Yz7xkBZl61N6wYZ28DVanikAyRNJMoYT+uXMzeb0u4KCfYzu3Fi
 OuL9rNA27eikX+w+FKMbNy7DEP9LljdntoLp80ISbhWmJ+BcotRtW3RoER977ww=
X-Google-Smtp-Source: AGHT+IHihsnsjBMTTyQ9Vpe6B/PQLMZz9/WHu22C1nx9N8VbzKJVf94HPExin7hzBCD1qWk6GoxRzA==
X-Received: by 2002:a05:6830:4118:b0:703:64c6:305b with SMTP id
 46e09a7af769-708d991998emr4287431a34.2.1721165781642; 
 Tue, 16 Jul 2024 14:36:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d01d1dsm1452089a34.62.2024.07.16.14.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 14:36:20 -0700 (PDT)
Date: Tue, 16 Jul 2024 15:36:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Josh Boyer <jwboyer@redhat.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Nishanth Menon <nm@ti.com>
Subject: Re: Request for hosting a boot-firmware repository in u-boot git
 (denx and GitHub)
Message-ID: <20240716213618.GO561963@bill-the-cat>
References: <20240620213539.ftmjhphypssxp5n4@desolate>
 <20240716191300.GM561963@bill-the-cat>
 <4bb80912-62fa-4f33-a344-351141d8df10@canonical.com>
 <20240716200147.GN561963@bill-the-cat>
 <e188ea04-9309-408b-8749-f137fbbd23fa@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SnjsZYTY8TXYmYGR"
Content-Disposition: inline
In-Reply-To: <e188ea04-9309-408b-8749-f137fbbd23fa@canonical.com>
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


--SnjsZYTY8TXYmYGR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:14:26PM +0200, Heinrich Schuchardt wrote:
> On 7/16/24 22:01, Tom Rini wrote:
> > On Tue, Jul 16, 2024 at 09:35:18PM +0200, Heinrich Schuchardt wrote:
> > > On 7/16/24 21:13, Tom Rini wrote:
> > > > On Thu, Jun 20, 2024 at 04:35:39PM -0500, Nishanth Menon wrote:
> > > > > Hi Team,
> > > > >=20
> > > > > We have briefly discussed this topic on IRC[1]. I would like to
> > > > > propose a new boot-firmware repository similar to the Linux-firmw=
are
> > > > > repository under the aegis of u-boot hosting.
> > > > >=20
> > > > > In addition to TI, it looks like some NXP[2] and Rockchip[3]
> > > > > platforms seem to require additional closed-source/open-source
> > > > > binaries to have a complete bootable image. Distribution rights a=
nd
> > > > > locations of these binaries are challenging, and there needs to b=
e a
> > > > > standard for how and where they are hosted for end users.
> > > > >=20
> > > > > Further, looking ahead to future architectures:
> > > > > * IP firmware: More and more IP vendors are embedding their own
> > > > >     "specialized controllers" and require firmware for the operat=
ion
> > > > >     (similar to Rockchip's DDR controller, I guess),
> > > > > * boot stage firmware: Additional stages of the boot process invo=
lve
> > > > >     vendor intermediate firmware, such as power configuration.
> > > > > * Security enclave binaries: While I see a few folks trying to ha=
ve an
> > > > >     open-source s/w architecture, many PKA and PQC systems still =
require
> > > > >     prop binaries for IP reasons.
> > > > >=20
> > > > > NOTE: I am not judging any company(including TI) for reasons why =
some
> > > > > firmware is proprietary, but I hate to have the end users and oth=
er
> > > > > system (distro) maintainers have to deal with hell trying to make=
 the
> > > > > life of end users easy to live with.
> > > > >=20
> > > > > In the case of TI's K3 architecture devices, we have two binary b=
lobs
> > > > > that are critical for the boot process.
> > > > >=20
> > > > > 1. TIFS Firmware / DMSC firmware[4]=E2=80=94This is the security =
enclave
> > > > >     firmware. It is often encrypted, and sources are not public (=
due to
> > > > >     various business/regulatory reasons).
> > > > > 2. DM Firmware[5] - There is a source in public in some cases and
> > > > >     binary only in others - essentially limited function binary t=
o be
> > > > >     put up in the device management uC. In cases where the source=
 is
> > > > >     available, the build procedure is, in my personal opinion, pr=
etty
> > > > >     arcane, and even though in theory it is practical, in practic=
e, not
> > > > >     friendly - efforts are going to simplify it, even probably in=
tegrate
> > > > >     it with a more opensource ecosystem, but that is talking "loo=
k at the
> > > > >     tea leaves" stuff.
> > > > > 3. Low Power Management (LPM) binaries: tifs stub: another encryp=
ted
> > > > >     binary that gives the tifs system context restore logic before
> > > > >     retrieving tifs firmware and a corresponding DM restoration b=
inary.
> > > > >=20
> > > > > All told, this is not unlike the situation that necessitated the
> > > > > creation of a Linux firmware repository.
> > > > >=20
> > > > > Options that I see:
> > > > >=20
> > > > > 1. Let the status quo be - SoC vendors maintain random locations =
and
> > > > >     random rules to maintain boot firmware.
> > > > > 2. Ask Linux-firmware to host the binaries in a single canonical
> > > > >     location
> > > > > 3. Host a boot-firmware repository - u-boot repo may be the more
> > > > >     logical location.
> > > > >=20
> > > > > * (1) isn't the correct answer.
> > > > >=20
> > > > > * (2) Though I haven't seen any policy from the Linux-firmware
> > > > >     community mandating anything of the form, the binaries we are=
 talking
> > > > >     of may not belong to Linux-firmware as they aren't strictly s=
peaking
> > > > >     something Linux kernel will load (since the bootloader has th=
at
> > > > >     responsibility), and in some cases may not even directly talk=
 to
> > > > >     (security enclave or DDR firmware stuff). I am adding Josh to=
 this
> > > > >     mail to see if he has any opinions on the topic (but keeping
> > > > >     from cross posting on linux-firmware list, unless folks feel =
it is
> > > > >     OK).
> > > > >=20
> > > > > On (3):
> > > > > Proposal:
> > > > >=20
> > > > > * Create a boot firmware repository in Denx and/or GitHub (if
> > > > >     financials are a hurdle, I hope we can solve it as a communit=
y).
> > > > > * Limit binaries only to those consumed part of the u-boot scope.
> > > > >=20
> > > > > * Limit binaries only to those that do not have an opensource pro=
ject
> > > > >     (Trusted Firmware-A/M, OP-TEE, etc..) or depend entirely on v=
endor
> > > > >     source or are binary only in nature (subject to licensing ter=
ms below)
> > > > > * Limit binaries to some pre-established size to prevent reposito=
ry
> > > > >     explosion - say, 512Kib?
> > > > > * Follow the same rules of integration and licensing guidelines as
> > > > >     Linux-firmware[6].
> > > > > * Similar rules as Linux-firmware guidelines of ABI backward and
> > > > >     forward compatibility.
> > > > > * Set a workflow update flow and a compatibility requirements doc=
ument
> > > > >=20
> > > > > If we agree to have boot firmware under the stewardship of u-boot=
, we
> > > > > should also set other rules, which is excellent to discuss.
> > > > >=20
> > > > > Thoughts?
> > > >=20
> > > > I believe that fundamentally, this is a problem that exists beyond =
both
> > > > just "U-Boot needs some binaries" and "TI has some binaries that
> > > > bootloaders need". So a generic solution is appropriate, and some s=
ort
> > > > of community-based hosting of these needs (with appropriate licensi=
ng
> > > > from the IP owners) makes sense. Looking around at the binaries I h=
ave
> > > > to keep locally to use NXP platforms, and TI platforms and Rockchip
> > > > platforms, it's far from ideal. Having one place to get them all fr=
om
> > > > would make life easier for a lot of developers and also frankly for=
 a
> > > > lot of end customers of these chips.
> > > >=20
> > >=20
> > > Some thought needs to be given to the license implications of these b=
inaries
> > > for operating system distributions.
> > >=20
> > > A distro providing a combined binary consisting of U-Boot and closed =
source
> > > firmware might be interpreted as conflicting with U-Boot's GPL licens=
e.
> > >=20
> > > Distributing the closed source binaries and U-Boot in separate packag=
es
> > > according to their respective licenses and only assemble them on the =
target
> > > device via a post-installation script might be allowable.
> >=20
> > For this project the question is making sure that the binaries are
> > licensed such that they could be externally redistributable.
> >=20
> > I don't know why someone would suggest that ABI calls are suddenly
> > linkage as I thought that (as far as these matters go) that was already
> > settled, but I am not a lawyer.
>=20
> The relevant term in the GPL 2.0 license is "work based on the Program".
> According to the GPL a "work based on the Program" is "a work containing =
the
> Program or a portion of it".
>=20
> If you build a binary via binman that contains U-Boot and another binary,
> the resulting binary could be considered "a work containing the Program o=
r a
> portion of it".
>=20
> The GPL 2.0 requires:
>=20
> "But when you distribute the same sections as part of a whole which is a
> work based on the Program, the distribution of the whole must be on the
> terms of this License, whose permissions for other licensees extend to the
> entire whole, and thus to each and every part regardless of who wrote it."

I'm not a lawyer and I don't pretend to be one on mailing lists, either.

In that my non-lawyer statements matter, I don't think binman
constitutes some new form of linking and I believe it falls in to the
same well known ABI exception.

But that's entirely unrelated to the question of hosting binaries (some
of which may be closed source) for use in firmware projects, some of
which will not be GPL. For example, I would assume that running
tianocore on i.MX8 requires the same assorted binaries that U-Boot does,
and that would not have a license conflict.

--=20
Tom

--SnjsZYTY8TXYmYGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaW584ACgkQFHw5/5Y0
tyyaSQv/UJTBb8cVSR8w77ZYfNOHehrIJViymbazX+idXOU8pJrR/HGvMqqD2fEs
GzD62A2zLr8o399hLU8cqVKqJEMuATLcEbVU8JPtQa/dNg8XPO26ct9fY5y0N01g
Ggsu6zmGUya4Ur8pfLlcc7+xFfGnZWeZycRRQfo2171p3V/wqCk/oHeLQd4/TvsP
N0dUclWLeTOzhDeLfhl+iJyGQ1LbANQHwVT2zP+d2l4K1EQgH4d2LV2t9TpZESlY
L1qDYlLLideAVHzP9nSuxxdgxAMfq2oO7swCBmfHU9jjvga6WZup1BTiWjHzfWzJ
WGnlh3w98Kl1AcCuIV5k+cKC4MHaF62EtuYUOJWV7OmqugaIZO2pdh+ydSXbZiGZ
nspLSjdfes/7dPge4iTF9iHll0Kry1JvbKjY49FgrCd7/aoQupjqgZmylJoXU6JD
fb6+IjSGvX5v5IG1VR4/I5F9/R5Gidc4LIMMOAxnXGyAC7hA0mwd2gjLWSF9uqbF
wP32uX7x
=mifx
-----END PGP SIGNATURE-----

--SnjsZYTY8TXYmYGR--
