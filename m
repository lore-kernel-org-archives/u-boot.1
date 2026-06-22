Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8779BCDB46F
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 14:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD94484931;
	Mon, 22 Jun 2026 16:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T6Rapr6h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1019B849BA; Mon, 22 Jun 2026 16:40:29 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69E0C848EB
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 16:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-48633190849so1749691b6e.3
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 07:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782139225; x=1782744025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=43pyoXY90i8ZCaMcsrtryHHymA7Pcl70Rof56B5mXyk=;
 b=T6Rapr6hS0I1qyidec8N2tc39KmOHE/RNsJzRm7/C/MMVUjqhh3zArxHQjkAnnXWIM
 Ba1iZw6747WlLnXDvSyKZ/7n/yngEpK3o55w02+xlm0swzGoCW3MDYq8zSPHwkwtDRE4
 beM3F9H/lDH4iILRyZ6/4lL67xkKNc6Mf/xW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782139225; x=1782744025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43pyoXY90i8ZCaMcsrtryHHymA7Pcl70Rof56B5mXyk=;
 b=H7AapuqXmOYyE+iJA+j9Kn5szbFolZmpIfFSoL7M2U/04Eo6mfLrBVMRpNRtfE9Q5f
 iDeiu8MkNpd9tgWHQ79waJjmMGc+MQiUdo3xzGLWXDtP0AduH9g07Zc1VwkLTyhIEK+7
 /ZCY7beD0rshVtdvqL++yak0HqvbAe1NpAEkl05mkZ6id6BvANgyZP/43262r+zYgaTt
 GZgawub1F+yHdv52J6zE5/NEOb4cW6wvLFNd3bm+Ikx7NAUzvWT8dD20T4b8i8gjjOIj
 PhOFqGhzUfdsKOdWA+GCmEUWLlVEeRYDNTWHVsfmiWBn8oa+WSgrwZA0DvmxDEXOVzDH
 CwFQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9KJAgHvhlonamPd8PZGWE+/keXsDuJDHKb44LoLanWfgKkjVjn1VFdDERSB1MKuN26DvWQu0c=@lists.denx.de
X-Gm-Message-State: AOJu0YzonXC/pxPxPFk9vT9Kh2NpE0udPj/lU1VXeKbCvlVDJWEWByL+
 eikGhfT5Yo7Ml2nrhp1NrSAFfwc9oDobYVqsv6yDZW642Rfuwq9JUA9n8De5PrxNnwA=
X-Gm-Gg: AfdE7cnE9/1QO08mWFWbWe0if2fB79W2FBg0FcZKV9X7VFHEkHj4KWKNEai3WYHY0zL
 HoYjq4p3qu1BvkqBwpJJ7qWtuU5dnvkd/+TlCIgr9vk14we32XNvARB5c6EjwO8OXBjBSszIUeo
 cZzpYPpLXg0KU+upoHG+6zRF2/Bc+WMT0yX3Mek2DMtIp8AsjhDDpTaDtotSx7Z4fETkuYLQ9hg
 NCmdXri2U+zvZ8QeakSPVzh1QviqN76f7h1lym0goJFMTSw35Gja2/KYj0bHnXXyTE7z2PGzkr1
 jzIK68iikq3FJxmEFFsPUv4NZ6HVdCszyMdoyX7poP/hi8+7EOYX9XSkGxxAiBKMkzngGT4JMEA
 cIq8rUpSsPrVT2vKhFc33zixN0Px9Z9pMG+aXt/0FgyLkIMfPGUQvS4qsn/lT+1zmFzkvI3eusK
 3LsPeAjRZINAYvlWkgUD+9hs8mtkUlhjlgRQCUQRXf0x2I9iBcBy59V+8FyK0NlSDtyI82MID2Y
 W9bYjwz9BBZXtiYvaJALQog7R0QVe3avZ5DhAz8
X-Received: by 2002:a05:6808:1812:b0:489:9f26:feaa with SMTP id
 5614622812f47-4899f271e22mr13804494b6e.35.1782139225096; 
 Mon, 22 Jun 2026 07:40:25 -0700 (PDT)
Received: from bill-the-cat (fixed-187-189-154-245.totalplay.net.
 [187.189.154.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-48aeea473f4sm4752202b6e.18.2026.06.22.07.40.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 07:40:23 -0700 (PDT)
Date: Mon, 22 Jun 2026 08:40:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: U-Boot Concept Tree Proposal
Message-ID: <20260622144021.GY382693@bill-the-cat>
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <CAFLszThH0A1XMv7P=QA7HreiSq6MLEriE7hODxk6S6MA5t6+rA@mail.gmail.com>
 <CALeDE9P8GozaHwkV54LXkES6sWXyNUibs5tmvuV1VgMtxEpLiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xKzpQf9uNG78D6R6"
Content-Disposition: inline
In-Reply-To: <CALeDE9P8GozaHwkV54LXkES6sWXyNUibs5tmvuV1VgMtxEpLiA@mail.gmail.com>
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


--xKzpQf9uNG78D6R6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 03:32:21PM +0100, Peter Robinson wrote:
> On Thu, 18 Jun 2026 at 16:19, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Wed, 3 Jun 2026 at 06:06, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Dear U-Boot Contributors,
> > >
> > > I would like to introduce the U-Boot Concept tree along with a few th=
oughts on its role in U-Boot.
> > >
> > > By way of background, I have been a contributor for about 15 years - =
around 10k commits and countless reviews. I have introduced many innovation=
s into the project: e.g. sandbox, device tree, C test infrastructure, Binma=
n, standard boot. Of course I could not have done any of this without the U=
-Boot community (nor would there be any point).
> > >
> > > As the U-Boot project has matured, the demands for mainline stability=
 and rigorous review have created a natural friction for landing complex, l=
arge-scale feature and refactoring series at the necessary pace. This struc=
tural reality, which has slowed the adoption of ambitious efforts like boot=
std, VBE, xPL [1], and CI-connected hardware labs, is what the Concept tree=
 is designed to alleviate.
> > >
> > > I strongly believe that projects must evolve in order to stay relevan=
t in the long term. This includes code-refactoring, new features and subsys=
tems, along with migration of old code to use them.  A look back at the U-B=
oot of 2010 shows how far the project has come. I don't think anyone would =
still be using U-Boot if it had not evolved.
> > >
> > > I have set up a 'Concept' tree, a possible future for U-Boot, as a wa=
y to regain the old pace of innovation. This environment is a proving groun=
d for new features where we maintain a lower bar for risk tolerance and com=
pleteness. We will accept partial and speculative features, provided the un=
derlying code remains robust and of high quality, with the shared understan=
ding that features may be dropped if they do not prove beneficial.
> > >
> > > Another difference is AI. I believe that AI is the next step on from =
compilers, which also took a long time to produce good code and find accept=
ance. The Concept tree welcomes (and encourages) high-quality AI contributi=
ons and reviews. It accepts PRs and allows reviews on PRs or the mailing li=
st. It relies 99% on automated tests (sandbox, QEMU and labs) so sets a hig=
h bar for testing. It uses a separate Gitlab instance for now and of course=
 uses a separate mailing list and Patchwork project to avoid cluttering the=
 main list. Concept runs an AI-powered cherry-picker so that it keeps up wi=
th mainline. In no sense is it operated as a fork.
> > >
> > > Once features are landed and functional in Concept I hope that many w=
ill find their way to mainline, although inevitably some rework will be nee=
ded.
> > >
> > > I recognise that introducing a new 'Concept' tree might initially cau=
se confusion or concern. This is an invitation to work together to define i=
ts role. I welcome all feedback - positive or negative - here on the mailin=
g list, privately, or on irc. Let=E2=80=99s discuss how this initiative can=
 help U-Boot remain the defining firmware for the 2030s.
> > >
> > > [1]  https://lore.kernel.org/u-boot/CAFLszTg6sKpZ1yP3Pjgk9_Fx3MOh=3Di=
eT2oaHfgLf3_nC+xXA9g@mail.gmail.com/
> >
> > Just to report that after some brief discussions, we have agreed on a
> > path forward here (thank you Peter!).
> >
> > Concept will become a custodian tree in U-Boot's Gitlab instance. I
> > will run it, with access to my hardware lab. It will cherry-pick from
> > mainline and accept code through its own channels (PRs and separate
> > mailing list + patchwork). When features are ready for mainline, I
> > will send patches to the main list for review in the normal way.
>=20
> Thanks not entirely what I envisioned with the custodian tree, cherry
> pickign from mainline and accepting PRs is very much a fork in my
> opinion.
>=20
> My intention was that it's a place for you to collaborate with others
> on feature branches to get them to a point they are ready to go out
> for review to go into mainline, not pull features from others etc
> which sounds like to me a fork of stuff that may not reach mainline.
>=20
> > I have been working to migrate things off u-boot.org (lab, gitlab,
> > blog... and email). I am transferring u-boot.org to the SFC once this
> > is finished in the next few days. If we do end up setting up email
> > addresses for people on u-boot.org, I'd appreciate keeping sjg@
>=20
> As I've stated elsewhere the only emails will be for the admin
> required for the running of the project as a whole.
>=20
> > Tom, Neil Peter, please can you ack this to confirm you are happy with =
it?
>=20
> With the caveats outlined above, basically yes.

I've been quiet on this thread as I think I've already put more than
enough words out already about this situation. So to repeat what Peter
said, yes, a custodian tree (which is a well defined thing for the last
two decades, predating both of us in the project) but not a parallel
and divergent tree.

--=20
Tom

--xKzpQf9uNG78D6R6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajlJUQAKCRAr4qD1Cr/k
CmQQAP904ya2WugA/AErl09yi0MxvrzHosTuiztckexYtstrsAEA8V0JNrB2zFMG
l3x1rVTpYEb3esAeICEdgWcIfHfA9Qc=
=ydek
-----END PGP SIGNATURE-----

--xKzpQf9uNG78D6R6--
