Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78330E77173
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 00:59:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D18258918B;
	Sat,  7 Dec 2024 01:59:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UVjfoneF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1027989124; Sat,  7 Dec 2024 01:59:18 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F33A8918B
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 01:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8e8445219so6948746d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 16:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733533154; x=1734137954; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rTURFKO9JN2Sr9CdEBdpq395CTaxxyHB5Ni8D9HndR0=;
 b=UVjfoneFzX0780G3/ZvYGADHy4QwfROTHRDgdBS2xgjkmfnCWnoCrcZQizsF065V5G
 DizjaSuiHTnjb4UuDXl5bd//FlEjQf/rYjTn1K5KXvFYdEwOzMYmy2TFh8SEAif4Pdd+
 mDR4M7uMja2bqvhQdFJYUI2RToSViw6WJK2Ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533154; x=1734137954;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTURFKO9JN2Sr9CdEBdpq395CTaxxyHB5Ni8D9HndR0=;
 b=Iz/s5QREsVNQ3KZPakjD/ce1FJFAUQ7WAD2gxTImiGoiFYbAZbKR0hyLiJeWwhf4O+
 +/85ZNF+u70z/DiMfEyJ9dSvFCnR7QfGyyLnW42ePW73BTJIMMh7Sdb8yo+bYAZkQclV
 OduMByEZnjfHPfa+4ClJJ8B8MWrIFrHHZcCWuzr1BKhuX+MJMYEsxHahvKavgRYSQujU
 u1xcaaTanVyzHJz6Q0icfNnO360HfUzJG3oMQwONTG5ujYlj8Wb9q9sqiLtor2G6KIfP
 qxk8D4rObxo2daVzjnVQ24bkC7wwpZaArmVa23sJGLcTp+Ai4DrF3pprwdolwPS3gTO3
 J4Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsd9xb9sjkTfHKB4KRPUpkzwA66NsgZTVC32ramLWQASoHU2KixLB0dxfIsHba+a0TVNTnEDs=@lists.denx.de
X-Gm-Message-State: AOJu0Ywiyx+uYTwCL7l94R47rIulhxfE77ag5c1JXGTBKNMF3cthvbYh
 PZZf+NWL1DXvnObGJ+QiK2FeJLpWfeSPaPZh4TKW2nyY2lBsLaU9mGQMqBAo+Oo=
X-Gm-Gg: ASbGncuIxYzt72J5XxhMnRKS74K+8RefejlaagFRyNj90doIejaX0vl755cMPaewrJy
 CtbbII9YY6gohyPb1pGgrVYpQLjVr+4Y15SazNRol+qGgNPFuJJlrkbsk9uwuXjIRihVfjLDEzO
 bwFynnmm5JbobK0R1DyrsZ3q8UAGJtNVQEEce+zV8vT7VHR8QGBd/7RR6nbxTBliTLUqErSTzB3
 JN0PnQvzVtLx7cSGRU2Isxgf0joxCKAPGE59kIXvHJizUEAQmE=
X-Google-Smtp-Source: AGHT+IE9iOlJUt3Br+vK2cfPggSbjNSHe/9ZhjsA2W6UmlPRNXQs0EfGEnQd04tfozGsTtRCbihD9A==
X-Received: by 2002:a05:6214:2684:b0:6d8:861f:adca with SMTP id
 6a1803df08f44-6d8e73e90b0mr67484116d6.42.1733533154026; 
 Fri, 06 Dec 2024 16:59:14 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a8441asm225658285a.84.2024.12.06.16.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 16:59:13 -0800 (PST)
Date: Fri, 6 Dec 2024 18:59:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241207005910.GE2457179@bill-the-cat>
References: <20241202001243.1283274-1-sjg@chromium.org>
 <D477BE0D-064D-46CE-B83B-C8B1E546575D@gmx.de>
 <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
 <20241206201236.GA2457179@bill-the-cat>
 <CAFLszTg2Y13iUsL7EHcw=8cKY_ii==ANoG-ztpS0Y5eMc_UKow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="aoPV4HMVn5NmX7QD"
Content-Disposition: inline
In-Reply-To: <CAFLszTg2Y13iUsL7EHcw=8cKY_ii==ANoG-ztpS0Y5eMc_UKow@mail.gmail.com>
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


--aoPV4HMVn5NmX7QD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 04:43:47PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 13:12, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 12:19:38PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > > > >
> > > > > > > From my side I'd like to change the conversation a little, to=
 how to
> > > > > > > land code, rather than why we should bother. "Code needs to l=
and"
> > > > > > > should be the motto. If someone has taken the time to create
> > > > > > > something, our bias should be towards getting it in, with suf=
ficient
> > > > > > > changes to make it fit the project. There are cases where som=
ething is
> > > > > > > just a bad idea, or should be done another way, but for peopl=
e working
> > > > > > > on major features or changes, biasing towards not landing the=
 code is
> > > > > > > just going to make them go elsewhere.
> > > > > >
> > > > > > This is the wrong approach I believe. The goal has always been =
and
> > > > > > continues to be to have reviewed (whenever possible, our develo=
per
> > > > > > community is small) incremental change over time.
> > > > >
> > > > > Yes, I agree with that, but it isn't what I said.
> > > >
> > > > I don't know how else to interpret "Code needs to land". I'm not su=
re
> > > > what reviewed patches we have that are outstanding, but also not fa=
irly
> > > > new. We do have patches outstanding, in general. Much of those fall=
 in
> > > > to the categories of:
> > > > - Custodian is active, but also very busy (virtually everyone is a
> > > >   volunteer so I have a hard time getting forceful with people that=
 have
> > > >   a large queue).
> > > > - Custodian isn't active / no direct custodian and the code hasn't =
been
> > > >   reviewed by anyone else.
> > >
> > > Here's my intention with 'code needs to land': to bias against people
> > > saying "I don't like this; I don't care about your use case; please go
> > > away"
> >
> > To me that applies an arbitrary nature to patches being rejected, which
> > I do not see as being the case.
> >
> > > > > > Just because something
> > > > > > has been posted a number of times does not mean it's ready to b=
e merged.
> > > > >
> > > > > I didn't say that either.
> > > >
> > > > It's an impression you give however when you repost a series less t=
han a
> > > > day after last posting, without addressing all of the feedback.
> > >
> > > I'm going to ignore that comment as it is not helpful and
> > > mischaracterises my contributions.
> >
> > I stand by it, and will let others judge if that's the impression they
> > have, or not.
>=20
> I'll put the relevant threads at [1], ditto.
>=20
> >
> > > > > > Your challenge today is that on patchwork you have over 150 pat=
ches
> > > > > > covering a wide variety of topics and of which many series have
> > > > > > technically-merited feedback that needs to be addressed in a te=
chnical
> > > > > > manner.
> > > > >
> > > > > By my count I have about 10 series in progress, with a small numb=
er of
> > > > > patches (< 10?) with pending feedback
> > > >
> > > > I'm not sure about that less than 10 number, in part because it's h=
ard
> > > > to keep track of which feedback was applied, and which not. And part
> > > > because some of those series are places where I told you I'm unsure
> > > > about the core concept but you asked and I'm giving you leeway to s=
how
> > > > me the end result.
> > >
> > > OK
> > >
> > > >
> > > > > that isn't effectively just a
> > > > > NAK.
> > > >
> > > > To be clear, "just a NAK" isn't the whole story. Those NAKs come wi=
th
> > > > technical rationales and requests. But maybe they're just lost in t=
he
> > > > volume of emails you have in some cases. I know for example I menti=
oned
> > > > a few times and places that we have tests today for booting the OS,=
 when
> > > > you mention that we need to add a test for booting the OS. We need =
to
> > > > expand that test, yes.
> > >
> > > If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
> > > see any other way to interpret it,. So several boards in my lab have
> > > been broken for a year.
> >
> > To be clear, you want to revert:
> > commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
> > Author:     Simon Glass <sjg@chromium.org>
> > AuthorDate: Wed Jan 3 18:49:19 2024 -0700
> > Commit:     Simon Glass <sjg@chromium.org>
> > CommitDate: Sun Jan 7 13:45:07 2024 -0700
> >
> >     fdt: Allow the devicetree to come from a bloblist
> >
> >     Standard passage provides for a bloblist to be passed from one firm=
ware
> >     phase to the next. That can be used to pass the devicetree along as=
 well.
> >     Add an option to support this.
> >
> >     Tests for this will be added as part of the Universal Payload work.
> >
> >     Signed-off-by: Simon Glass <sjg@chromium.org>
> >     Reviewed-by: Tom Rini <trini@konsulko.com>
> >     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >
> > Which means that you did not test your changes on your hardware at the
> > time? And wish to (seemingly) replace that with an earlier version of
> > the patch which was objected to on technical grounds at the time.
> > Without explaining why the current code does not function on these
> > platforms, only that it does not, for entirely unclear reasons.
>=20
> It never worked on my board, though. I spent 6 revisions trying to
> explain that. After number 6 [2] you got in touch and said that I
> needed to rework it, which I dutifully did, in version 7 [3]. I did
> that purely to unblock Raymond's series. I even put that in the patch:
>=20
> "The discussion on this was not resolved and is now important due to the
> bloblist series from Raymond. So I am sending it again since I believe
> this is a better starting point than building on OF_BOARD"
>=20
> Are you now saying I should have refused and argued for another few
> revisions? Patience does have its limits.

I'm saying that I assumed what you pushed functioned on your hardware,
which is why I'm surprised now that it doesn't. I'll look through all of
the links later, but I think you still haven't explained _why_ this
solution doesn't function on your platforms (now or last year) and what
your platforms need (as in, can't change) / want (you would need to
rework some other part of the firmware stack to get them in agreement on
that platform).

> > So I do not think I've arbitrarily nak'd the revert you posted, I've
> > been asking you to explain why the code doesn't work. And I still don't
> > have an answer as to why after at run time we don't find a valid
> > bloblist here the fall-back use cases aren't functioning. To me that
> > seems like the bug to investigate and explain. Reverting code to find
> > when functionality broke is great, I do it all the time. Saying we need
> > to revert because something broke *without* saying why it broke is a
> > problem.
> >
> > > > > It isn't a particularly large number, if you add up the patches I
> > > > > do in each cycle. It is in the nature of development and code rev=
iew
> > > > > that things are often not right the first time, or someone else h=
as
> > > > > another perspective, so I cannot see how this can be reduced.
> > > >
> > > > The easy way to reduce it would be to go from 10 series in progress=
 to 1
> > > > series in progress, and finish that before picking up series number=
 2,
> > > > and so on. And then in the future, stop when you have more than 2 o=
r 3
> > > > in progress at once.
> > >
> > > That's obviously not practical for the amount I am contributing and
> > > the length of time it takes us to get things in. I hope it isn't a
> > > serious suggestion!
> >
> > It's extremely serious. For example
> > https://patchwork.ozlabs.org/project/uboot/list/?series=3D435516&state=
=3D*
> > is a 46 part patch series that touches 3 or 4 different areas and the
> > only type of review that's feasible is "Does this cause the binary to
> > grow too much? Or in unexpected ways?" And that sets aside that I
> > believe I did ask you to rework "bootm: Allow building bootm.c without
> > CONFIG_SYS_BOOTM_LEN" to refactor things so that SYS_BOOTM_LEN is always
> > defined. That's not even a hard change, I say as someone that had to do
> > that as part of Kconfig migration of oddly (ab)used symbol names.
> >
> > But in this case, your series that touch areas of code actively
> > maintained by other people is even more relevant. Whereas areas without
> > other active developers, or where you are the main developer, I can find
> > some smaller limits on what must be reviewed all of your *EFI* has other
> > active developers on it. Who are providing technical feedback, not
> > arbitrary or stylistic feedback. Please be explicit about what you are
> > suggesting in this case, so I do not mischaracterize your intention.
> >
> > > > But really, it feels like "Code needs to land" is another way of sa=
ying
> > > > "Just a NAK should be ignored".
> > >
> > > Yes, a bias more towards that would be more healthy IMO. A NAK needs
> > > to come with a full understanding of the use case, an alternative way
> > > to meet the use case, once that doesn't involve boiling the Pacific
> > > Ocean.
> >
> > As it stands, I do not like to, but sometimes feel I *have*to* break one
> > board to unbreak another board and keep reminding both parties to
> > resolve the issue so no board is broken. There has been, since I have
> > taken over the lead of the project, at least once where I have
> > over-ruled the relevant custodian and that has resulted in the custodian
> > leaving. I both feel that was the right technical call, and regret it
> > came to that, still. I do not want to adopt a more broad use of that
> > policy. The default for absence of agreement must be to try again.
>=20
> I see that Peter sent a few indignant emails. You can't win.

I assume this is about the LED series, and I further assume you forgot /
missed where he explained that removing the legacy code is a functional
user visible usability regression on the pinephone.

--=20
Tom

--aoPV4HMVn5NmX7QD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTnd0ACgkQFHw5/5Y0
tyyYzQv/Y/xyQXWqMkCla+65zZKX67AzXUmIZb4gjAJ9/sA6NKowSCjXSgYWCDSs
Vulj/VH6U247I99ajFKSQ9NwrXsfNj4Mm5yoBnNVLRSMbAx3p0/g1wmfqmquCgJy
SzSh9eiefRRaYqvdQ6C+PwOlzfkE622LeafpBp6f/J4C4pJakSYvHxGqYxbuNgZP
5uefzp0W6xeizxIbbOeSGUUSRjVqFjivNAE9Su0n+by8s6p4j/d/Is0OcRViACuH
jdina6HmoHJ07anqLtuJs+ldJ4f3gg1x/lMFKt1rrvLWfTOyQh2VLjXcQlZSeTCN
pn8Ki7CV8XOKdXA8usQkWgUBknzWxgzjgCXVaj4pgPE5FxAh3rOV5WJPkTLddlOR
KaoEYaKLVEOBnxEi/igRLs70E5ASb6OXAQ4g9ElUzxUpTogHh6QHixe3i9PdFLj0
Hd+ZEs4NaGCIVSwcByZuckBY1oqqaerLf83F7e6x46wmXMvHE5jCFSN64PNBRp1i
l2vdQOsM
=Vvuo
-----END PGP SIGNATURE-----

--aoPV4HMVn5NmX7QD--
