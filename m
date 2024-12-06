Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CED4E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 20:12:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A480D8921B;
	Fri,  6 Dec 2024 21:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LWrS6V/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A20D89274; Fri,  6 Dec 2024 21:12:44 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F8B589175
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 21:12:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3ea43811488so1262286b6e.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 12:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733515960; x=1734120760; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=T27AUV88Zclt9gnNhQDzWDBeaiIYJqgkUMW6jakhJoM=;
 b=LWrS6V/94jxTz3pidNoXniOOIoPLHOViVsD991+YJ2vXSyQaAIpdbc9DtxXCdx0QYb
 TCpvER8V01qQgWY+39wM9NDKfgNRpbGFAUaR+yTGmvhZe+Yo9b6IiuSDL68X0CuHuHCb
 3n6kBf69cgn3kg6AfcDbs64b2fM5ts7/fxpOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733515960; x=1734120760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T27AUV88Zclt9gnNhQDzWDBeaiIYJqgkUMW6jakhJoM=;
 b=uashgMmQQaTG5HMAS/ubyloCsJ4ZG6SKi0N0eS7f8STZHCFMy2OO1Tj2YMaPjqy3xE
 ft4wdPRRQLyc3g6cZ57og958SWFPpFg8VTAICH0Mey8Pl4v1fpcP3XdTMnubLPLCsehn
 1p7mhBOAQSwgC35iDPi3+/bi8GONvYQclIs34hMh+/v+LMH48Izo964vQrdIztc6xHc3
 /7prYIJ+eAUHtQAyI4L4LwdhpuzEURqdckNnLY0P5dSKdVJ1WVzGiXv7UcCms/aIXiKk
 sqv0zAOUkt1zrpIv1nuzB7abICvYas1z0OroUV8Gt5xjrzwfxhKJZ8zIh4PxWx96Opdg
 aovQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9UMGBgW5cahaNzAsF4uZomgfzZsJkJvpdpZYy3IqmNWQ06W0SL0jfLjXl/JMO/DcQx8xyzVM=@lists.denx.de
X-Gm-Message-State: AOJu0YzADr+F8RJAHSP1tVQ6nltEkMlIC22v+IKQiUBVKDOvpIsmdzSK
 TIDvI/fkgYs5ZpM96fw0FGYPQ2mht77W9+CPAYrS5eVuCNXH4vDizI/dFeDDMeI=
X-Gm-Gg: ASbGncvo22GAl1I0f4ECTKtcRNSzHli9oBr/urI1tI7XDriUs/lP3kXqbMumDpIztBr
 755CRJ66/YOYSIjLHiDqhtSO3fJc881onu4dh8DGsRKH76nJsxCA0q44iMGLY+9AS9c/4wr7QjB
 2k/VgrCiFKLFDQy1iiNfjnyLMCq7Lmn0hxdHrC50orlOY9B5B8EBRibTA4uQH02terxfVVwOrRF
 DDtwyBs7tktna0dC7LdaOb2fMtPCZR7RyBsXCe0ojYLl5gm3w==
X-Google-Smtp-Source: AGHT+IGJpx/EmL27ztrVkFmA1yra5TfzcjLTGu/Q2u8sRZIG2dDUKXO9u0ZcHMmLrEhVJ8uIGLZGSw==
X-Received: by 2002:a05:6808:e8b:b0:3ea:4aec:4a43 with SMTP id
 5614622812f47-3eb19e17c9emr4141839b6e.43.1733515960001; 
 Fri, 06 Dec 2024 12:12:40 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da696e7csm22650916d6.47.2024.12.06.12.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 12:12:39 -0800 (PST)
Date: Fri, 6 Dec 2024 14:12:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241206201236.GA2457179@bill-the-cat>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V2HeLf+B4GjEEsLd"
Content-Disposition: inline
In-Reply-To: <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
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


--V2HeLf+B4GjEEsLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 12:19:38PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > >
> > > > > From my side I'd like to change the conversation a little, to how=
 to
> > > > > land code, rather than why we should bother. "Code needs to land"
> > > > > should be the motto. If someone has taken the time to create
> > > > > something, our bias should be towards getting it in, with suffici=
ent
> > > > > changes to make it fit the project. There are cases where somethi=
ng is
> > > > > just a bad idea, or should be done another way, but for people wo=
rking
> > > > > on major features or changes, biasing towards not landing the cod=
e is
> > > > > just going to make them go elsewhere.
> > > >
> > > > This is the wrong approach I believe. The goal has always been and
> > > > continues to be to have reviewed (whenever possible, our developer
> > > > community is small) incremental change over time.
> > >
> > > Yes, I agree with that, but it isn't what I said.
> >
> > I don't know how else to interpret "Code needs to land". I'm not sure
> > what reviewed patches we have that are outstanding, but also not fairly
> > new. We do have patches outstanding, in general. Much of those fall in
> > to the categories of:
> > - Custodian is active, but also very busy (virtually everyone is a
> >   volunteer so I have a hard time getting forceful with people that have
> >   a large queue).
> > - Custodian isn't active / no direct custodian and the code hasn't been
> >   reviewed by anyone else.
>=20
> Here's my intention with 'code needs to land': to bias against people
> saying "I don't like this; I don't care about your use case; please go
> away"

To me that applies an arbitrary nature to patches being rejected, which
I do not see as being the case.

> > > > Just because something
> > > > has been posted a number of times does not mean it's ready to be me=
rged.
> > >
> > > I didn't say that either.
> >
> > It's an impression you give however when you repost a series less than a
> > day after last posting, without addressing all of the feedback.
>=20
> I'm going to ignore that comment as it is not helpful and
> mischaracterises my contributions.

I stand by it, and will let others judge if that's the impression they
have, or not.

> > > > Your challenge today is that on patchwork you have over 150 patches
> > > > covering a wide variety of topics and of which many series have
> > > > technically-merited feedback that needs to be addressed in a techni=
cal
> > > > manner.
> > >
> > > By my count I have about 10 series in progress, with a small number of
> > > patches (< 10?) with pending feedback
> >
> > I'm not sure about that less than 10 number, in part because it's hard
> > to keep track of which feedback was applied, and which not. And part
> > because some of those series are places where I told you I'm unsure
> > about the core concept but you asked and I'm giving you leeway to show
> > me the end result.
>=20
> OK
>=20
> >
> > > that isn't effectively just a
> > > NAK.
> >
> > To be clear, "just a NAK" isn't the whole story. Those NAKs come with
> > technical rationales and requests. But maybe they're just lost in the
> > volume of emails you have in some cases. I know for example I mentioned
> > a few times and places that we have tests today for booting the OS, when
> > you mention that we need to add a test for booting the OS. We need to
> > expand that test, yes.
>=20
> If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
> see any other way to interpret it,. So several boards in my lab have
> been broken for a year.

To be clear, you want to revert:
commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
Author:     Simon Glass <sjg@chromium.org>
AuthorDate: Wed Jan 3 18:49:19 2024 -0700
Commit:     Simon Glass <sjg@chromium.org>
CommitDate: Sun Jan 7 13:45:07 2024 -0700

    fdt: Allow the devicetree to come from a bloblist

    Standard passage provides for a bloblist to be passed from one firmware
    phase to the next. That can be used to pass the devicetree along as wel=
l.
    Add an option to support this.

    Tests for this will be added as part of the Universal Payload work.

    Signed-off-by: Simon Glass <sjg@chromium.org>
    Reviewed-by: Tom Rini <trini@konsulko.com>
    Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Which means that you did not test your changes on your hardware at the
time? And wish to (seemingly) replace that with an earlier version of
the patch which was objected to on technical grounds at the time.
Without explaining why the current code does not function on these
platforms, only that it does not, for entirely unclear reasons.

So I do not think I've arbitrarily nak'd the revert you posted, I've
been asking you to explain why the code doesn't work. And I still don't
have an answer as to why after at run time we don't find a valid
bloblist here the fall-back use cases aren't functioning. To me that
seems like the bug to investigate and explain. Reverting code to find
when functionality broke is great, I do it all the time. Saying we need
to revert because something broke *without* saying why it broke is a
problem.

> > > It isn't a particularly large number, if you add up the patches I
> > > do in each cycle. It is in the nature of development and code review
> > > that things are often not right the first time, or someone else has
> > > another perspective, so I cannot see how this can be reduced.
> >
> > The easy way to reduce it would be to go from 10 series in progress to 1
> > series in progress, and finish that before picking up series number 2,
> > and so on. And then in the future, stop when you have more than 2 or 3
> > in progress at once.
>=20
> That's obviously not practical for the amount I am contributing and
> the length of time it takes us to get things in. I hope it isn't a
> serious suggestion!

It's extremely serious. For example
https://patchwork.ozlabs.org/project/uboot/list/?series=3D435516&state=3D*
is a 46 part patch series that touches 3 or 4 different areas and the
only type of review that's feasible is "Does this cause the binary to
grow too much? Or in unexpected ways?" And that sets aside that I
believe I did ask you to rework "bootm: Allow building bootm.c without
CONFIG_SYS_BOOTM_LEN" to refactor things so that SYS_BOOTM_LEN is always
defined. That's not even a hard change, I say as someone that had to do
that as part of Kconfig migration of oddly (ab)used symbol names.

But in this case, your series that touch areas of code actively
maintained by other people is even more relevant. Whereas areas without
other active developers, or where you are the main developer, I can find
some smaller limits on what must be reviewed all of your *EFI* has other
active developers on it. Who are providing technical feedback, not
arbitrary or stylistic feedback. Please be explicit about what you are
suggesting in this case, so I do not mischaracterize your intention.

> > But really, it feels like "Code needs to land" is another way of saying
> > "Just a NAK should be ignored".
>=20
> Yes, a bias more towards that would be more healthy IMO. A NAK needs
> to come with a full understanding of the use case, an alternative way
> to meet the use case, once that doesn't involve boiling the Pacific
> Ocean.

As it stands, I do not like to, but sometimes feel I *have*to* break one
board to unbreak another board and keep reminding both parties to
resolve the issue so no board is broken. There has been, since I have
taken over the lead of the project, at least once where I have
over-ruled the relevant custodian and that has resulted in the custodian
leaving. I both feel that was the right technical call, and regret it
came to that, still. I do not want to adopt a more broad use of that
policy. The default for absence of agreement must be to try again.

--=20
Tom

--V2HeLf+B4GjEEsLd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTWqsACgkQFHw5/5Y0
tyymhAv+OxhxcY+tzIciwSP+tZQi+YUt245OhFfB8kDEkExkw8VwydoiSYPQikfW
7NcIgL24i+xP95xv1oUMI0Sh2UDWGRJhxpz90YHRqjIl1syXWmJiCuBv36KjQNlY
kg+9SgksbbHnREBMBX2u1ehncwLgOymsR0E92wVddnfACBs9zr4qmUAsQqS1WFB8
Zo3EtsC/VussTB2Hq9aHm/oSA2z1D4uQb0LDqr2DNuApW4q1efjqOEJNyUTuAwNu
T6LjR7RrV69xs30ir2bU3VVUsmQp/WJ/WR0aDhbUArMzSYrobrB3HbIjXwcUMuR0
7UYxCk4pfClJGBSgS9ZcPQ0EtQaW0WxMzCMvB4eB/nI/oX8l0zueN2jfYzH0ISzy
SSr73AzoPD0EOMh3nc9iFDSyeKZogr1LIv0luGT+Egy5H0SwQlzG++xNFUaQtJbL
tqB9sOv3VEZz76EpSSoDYXLaODBNgITYgYeTMW9q49c0caxN+QifUamUL5wert2v
kTOPN/WD
=N7yQ
-----END PGP SIGNATURE-----

--V2HeLf+B4GjEEsLd--
