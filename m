Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C76E7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D832D8021A;
	Fri, 13 Dec 2024 15:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="U/YNVW3a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15D628020C; Fri, 13 Dec 2024 15:33:12 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E62D3801F5
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6e4d38185so141729685a.0
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734100388; x=1734705188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ef0lvGzLMaCDnMxwXl66LN9Ax5IvYsTbM7HAEDzqjrs=;
 b=U/YNVW3apIo/VIbqb58OrMEwdzoh2QyZF/jpzXKuqzjeVp7YdsLGB5ldYPVJD5CYgz
 Dx36YUt+weAP8Rf/yzH36+V8BR8SZATHY6idIvEKT5HZXXGtIAWoG76UZC1kdBP2MzRS
 sn6aHplNCdSOE1V5I3oC8RWzF3HScspG/EfAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100388; x=1734705188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ef0lvGzLMaCDnMxwXl66LN9Ax5IvYsTbM7HAEDzqjrs=;
 b=ZpHTPNcNI0ZYRaDv1zvBrfhnwztt9yeoEf4s86x5G36xjKVgds/ONehLm+1C7D3YEg
 TMpvNzYd8be0vQ6hegjcbMjGiUukCOvVa9xG/KSuOUsCuqJDr4xRwtnq/mpoXHl4e0oJ
 ccCJbtytObqJVI56siHxveQZ3zFIpgqBHtm3SNKwVfjcaWYizEG9fvfXHx9cTDKT4sJi
 iogI2JksHXDa/4FS9AoRWeMNqoFngzdIo2HFfuIw69BYxvUIg0VOeBo7T9AS0qnFLVps
 LDoxTAUiC4Ed34wziPpfuAU/GGxE1Q0fgp8wrPQrRXvEHvnwavIky+peNnqfPfLjTq+K
 OEWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMHNFKIEuiSR94l9u1eMZC3UExEWnphaW6Y1sIZjeQGIyDtZ4DNulQJVA/mA0zCxOo12dN60E=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4KNqvFGqCVb7iNQeUVdT7UJj+b3Dnp85+jE3ySTpXzdud0RRH
 Mn9VZ55vNd8xo6OUY6HEAAA23Srtc6/NE6NNoUyBOEpWxhgyVesAP1eADI9evlo=
X-Gm-Gg: ASbGnctOfO0xPh0EjCmqcMOAyNXH2c0yVbPoEPbQwSJgZ8PDSZqWPpZoBgBWFsaHdyr
 2viPE4YsX16LZBDcixA7Gd6cejZDhywi9DmTewqN+shzQ+bH9vnIV1Q6oxyAS+gYWKu49VpQn3l
 b6hBzDYkVqWUPdOl0dLOcHHbYuZ0aACk+GBaGKKojvamCHpOyA8jttxz2bGCxVocerrhfjxZ6mB
 qL5Ckjumrf6CPtnz6mGYYcHTIX51w1+jLa3OUFJFhkmDQPQKz7L432q
X-Google-Smtp-Source: AGHT+IEU5dMtvUhBGgW49AGrHIXp8oRCCkVpnu4CAdgIwhiv0Ty8eDUQeZkBVlZ6aSUiKqzikqxWHA==
X-Received: by 2002:a05:620a:44c2:b0:7b7:2de:6f83 with SMTP id
 af79cd13be357-7b702de6ffdmr29637785a.41.1734100387487; 
 Fri, 13 Dec 2024 06:33:07 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f1c352b2sm197223685a.63.2024.12.13.06.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 06:33:06 -0800 (PST)
Date: Fri, 13 Dec 2024 08:33:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241213143304.GU1505244@bill-the-cat>
References: <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
 <20241206201236.GA2457179@bill-the-cat>
 <CAFLszTg2Y13iUsL7EHcw=8cKY_ii==ANoG-ztpS0Y5eMc_UKow@mail.gmail.com>
 <20241207005910.GE2457179@bill-the-cat>
 <CAFLszTg74zTUN-8VhY5sENe0hMxrnHkXd67ji4w=q=eu33NAaQ@mail.gmail.com>
 <20241212165147.GF1505244@bill-the-cat>
 <CAFLszThy7RzztLNa_tDH2rkPqWZvimZv04Hx1Bo5SRs13One=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nUApHL8QzNc5+7YF"
Content-Disposition: inline
In-Reply-To: <CAFLszThy7RzztLNa_tDH2rkPqWZvimZv04Hx1Bo5SRs13One=Q@mail.gmail.com>
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


--nUApHL8QzNc5+7YF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 05:37:11AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 12 Dec 2024 at 09:51, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 12, 2024 at 07:09:12AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 17:59, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 04:43:47PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 6 Dec 2024 at 13:12, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 06, 2024 at 12:19:38PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > From my side I'd like to change the conversation a li=
ttle, to how to
> > > > > > > > > > > land code, rather than why we should bother. "Code ne=
eds to land"
> > > > > > > > > > > should be the motto. If someone has taken the time to=
 create
> > > > > > > > > > > something, our bias should be towards getting it in, =
with sufficient
> > > > > > > > > > > changes to make it fit the project. There are cases w=
here something is
> > > > > > > > > > > just a bad idea, or should be done another way, but f=
or people working
> > > > > > > > > > > on major features or changes, biasing towards not lan=
ding the code is
> > > > > > > > > > > just going to make them go elsewhere.
> > > > > > > > > >
> > > > > > > > > > This is the wrong approach I believe. The goal has alwa=
ys been and
> > > > > > > > > > continues to be to have reviewed (whenever possible, ou=
r developer
> > > > > > > > > > community is small) incremental change over time.
> > > > > > > > >
> > > > > > > > > Yes, I agree with that, but it isn't what I said.
> > > > > > > >
> > > > > > > > I don't know how else to interpret "Code needs to land". I'=
m not sure
> > > > > > > > what reviewed patches we have that are outstanding, but als=
o not fairly
> > > > > > > > new. We do have patches outstanding, in general. Much of th=
ose fall in
> > > > > > > > to the categories of:
> > > > > > > > - Custodian is active, but also very busy (virtually everyo=
ne is a
> > > > > > > >   volunteer so I have a hard time getting forceful with peo=
ple that have
> > > > > > > >   a large queue).
> > > > > > > > - Custodian isn't active / no direct custodian and the code=
 hasn't been
> > > > > > > >   reviewed by anyone else.
> > > > > > >
> > > > > > > Here's my intention with 'code needs to land': to bias agains=
t people
> > > > > > > saying "I don't like this; I don't care about your use case; =
please go
> > > > > > > away"
> > > > > >
> > > > > > To me that applies an arbitrary nature to patches being rejecte=
d, which
> > > > > > I do not see as being the case.
> > > > > >
> > > > > > > > > > Just because something
> > > > > > > > > > has been posted a number of times does not mean it's re=
ady to be merged.
> > > > > > > > >
> > > > > > > > > I didn't say that either.
> > > > > > > >
> > > > > > > > It's an impression you give however when you repost a serie=
s less than a
> > > > > > > > day after last posting, without addressing all of the feedb=
ack.
> > > > > > >
> > > > > > > I'm going to ignore that comment as it is not helpful and
> > > > > > > mischaracterises my contributions.
> > > > > >
> > > > > > I stand by it, and will let others judge if that's the impressi=
on they
> > > > > > have, or not.
> > > > >
> > > > > I'll put the relevant threads at [1], ditto.
> > > > >
> > > > > >
> > > > > > > > > > Your challenge today is that on patchwork you have over=
 150 patches
> > > > > > > > > > covering a wide variety of topics and of which many ser=
ies have
> > > > > > > > > > technically-merited feedback that needs to be addressed=
 in a technical
> > > > > > > > > > manner.
> > > > > > > > >
> > > > > > > > > By my count I have about 10 series in progress, with a sm=
all number of
> > > > > > > > > patches (< 10?) with pending feedback
> > > > > > > >
> > > > > > > > I'm not sure about that less than 10 number, in part becaus=
e it's hard
> > > > > > > > to keep track of which feedback was applied, and which not.=
 And part
> > > > > > > > because some of those series are places where I told you I'=
m unsure
> > > > > > > > about the core concept but you asked and I'm giving you lee=
way to show
> > > > > > > > me the end result.
> > > > > > >
> > > > > > > OK
> > > > > > >
> > > > > > > >
> > > > > > > > > that isn't effectively just a
> > > > > > > > > NAK.
> > > > > > > >
> > > > > > > > To be clear, "just a NAK" isn't the whole story. Those NAKs=
 come with
> > > > > > > > technical rationales and requests. But maybe they're just l=
ost in the
> > > > > > > > volume of emails you have in some cases. I know for example=
 I mentioned
> > > > > > > > a few times and places that we have tests today for booting=
 the OS, when
> > > > > > > > you mention that we need to add a test for booting the OS. =
We need to
> > > > > > > > expand that test, yes.
> > > > > > >
> > > > > > > If you look at the OF_BLOBLIST thing, it is basically a NAK. =
I don't
> > > > > > > see any other way to interpret it,. So several boards in my l=
ab have
> > > > > > > been broken for a year.
> > > > > >
> > > > > > To be clear, you want to revert:
> > > > > > commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
> > > > > > Author:     Simon Glass <sjg@chromium.org>
> > > > > > AuthorDate: Wed Jan 3 18:49:19 2024 -0700
> > > > > > Commit:     Simon Glass <sjg@chromium.org>
> > > > > > CommitDate: Sun Jan 7 13:45:07 2024 -0700
> > > > > >
> > > > > >     fdt: Allow the devicetree to come from a bloblist
> > > > > >
> > > > > >     Standard passage provides for a bloblist to be passed from =
one firmware
> > > > > >     phase to the next. That can be used to pass the devicetree =
along as well.
> > > > > >     Add an option to support this.
> > > > > >
> > > > > >     Tests for this will be added as part of the Universal Paylo=
ad work.
> > > > > >
> > > > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > >     Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > > >     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > >
> > > > > > Which means that you did not test your changes on your hardware=
 at the
> > > > > > time? And wish to (seemingly) replace that with an earlier vers=
ion of
> > > > > > the patch which was objected to on technical grounds at the tim=
e.
> > > > > > Without explaining why the current code does not function on th=
ese
> > > > > > platforms, only that it does not, for entirely unclear reasons.
> > > > >
> > > > > It never worked on my board, though. I spent 6 revisions trying to
> > > > > explain that. After number 6 [2] you got in touch and said that I
> > > > > needed to rework it, which I dutifully did, in version 7 [3]. I d=
id
> > > > > that purely to unblock Raymond's series. I even put that in the p=
atch:
> > > > >
> > > > > "The discussion on this was not resolved and is now important due=
 to the
> > > > > bloblist series from Raymond. So I am sending it again since I be=
lieve
> > > > > this is a better starting point than building on OF_BOARD"
> > > > >
> > > > > Are you now saying I should have refused and argued for another f=
ew
> > > > > revisions? Patience does have its limits.
> > > >
> > > > I'm saying that I assumed what you pushed functioned on your hardwa=
re,
> > > > which is why I'm surprised now that it doesn't.
> > >
> > > How can you possibly assume that, or be 'surprised' about that?! I
> > > repeatedly said that the solution was no good for me and I was very
> > > clear that I only sent that patch because you insisted on it. You sent
> > > a 'thank you' afterwards, which rang pretty hollow after so much
> > > effort and still having broken boards.
> >
> > Well, I can and maybe should more often admit to missing a thing or two
> > in very long threads, that's how. Doubly so in light of the patches I
> > posted now (after you wrote the above, but before I read it) fixing your
> > platforms.
> >
> > > From what I vaguely recall, in a discussion that went on till the cows
> > > came home, it was tied up with U-Boot not being allowed to have its
> > > own devicetree. Another vague recollection was that I was stupid and I
> > > didn't understand...
> >
> > Yes, that's another thing that doesn't make any sense. You still insist
> > that point while no one is making the point you insist someone is
> > making.
>=20
> Well, I did spend many happy hours arguing with someone about whether
> U-Boot was allowed to have its own devicetree, have its own properties
> in the devicetree, etc. I did not imagine it. I believe that
> OF_BLOBLIST was radioactive partly because of that.

This...

> > > > I'll look through all of
> > > > the links later, but I think you still haven't explained _why_ this
> > > > solution doesn't function on your platforms (now or last year) and =
what
> > > > your platforms need (as in, can't change) / want (you would need to
> > > > rework some other part of the firmware stack to get them in agreeme=
nt on
> > > > that platform).
> > >
> > > Actually I've explained that many, many times. They use bloblist but
> > > not for passing the FDT. This strange insistence that the bloblist
> > > must carry the FDT is what caused all these problems. I need a
> > > platform to be able to boot TPL, have a bloblist set up in SPL, pass
> > > it to U-Boot proper, all without having an FDT in it.
> >
> > OK, but that doesn't seem to be how the platforms work? Bob and Kevin
> > don't use TPL (but they use TF-A? I can't see in gitlab how we build for
> > testing on HW and it's not clear if we're grabbing bl31 from somewhere),
> > but it's SPL that initializes DRAM. And that means we can't look at the
> > bloblist in DRAM before init'ing DRAM. Coral does have TPL, but does not
> > enable TPL_BLOBLIST currently. But it looks like it also does DRAM
> > initialization in SPL, so, overall the same class of problem.
>=20
> Yes, that's right. See [1]
>=20
> It would be nice to expose that information in gitlab. Not hard to do,
> just print out the parameters for the UBootProviderDriver. It would be
> even better to build bl31 from source and print out the source-hash
> used.
>=20
> >
> > And the insistence was that IF we have bloblist support THEN we must
> > look at it. Which we can't if it's in DRAM and we're responsible for
> > DRAM. Which these days is often not the case. And if you mentioned that
> > problem in the many threads we had at the time, it was drowned out by
> > other comments.
>=20
> My patch from a year ago fixed a regression and a bug. It should have
> been applied, but instead we all argued about it through 7 revisions
> and then it just died. That result is not on me, sorry.

And this are both part of the same problem. You are unable to
communicate the *why* of *what* you are doing in an effective manner.
You need to figure out how to fix that problem, not go and write more
code that still doesn't effectively communicate your design choices. "It
works for me" doesn't scale beyond a solo project.

> > > > > > So I do not think I've arbitrarily nak'd the revert you posted,=
 I've
> > > > > > been asking you to explain why the code doesn't work. And I sti=
ll don't
> > > > > > have an answer as to why after at run time we don't find a valid
> > > > > > bloblist here the fall-back use cases aren't functioning. To me=
 that
> > > > > > seems like the bug to investigate and explain. Reverting code t=
o find
> > > > > > when functionality broke is great, I do it all the time. Saying=
 we need
> > > > > > to revert because something broke *without* saying why it broke=
 is a
> > > > > > problem.
> > > > > >
> > > > > > > > > It isn't a particularly large number, if you add up the p=
atches I
> > > > > > > > > do in each cycle. It is in the nature of development and =
code review
> > > > > > > > > that things are often not right the first time, or someon=
e else has
> > > > > > > > > another perspective, so I cannot see how this can be redu=
ced.
> > > > > > > >
> > > > > > > > The easy way to reduce it would be to go from 10 series in =
progress to 1
> > > > > > > > series in progress, and finish that before picking up serie=
s number 2,
> > > > > > > > and so on. And then in the future, stop when you have more =
than 2 or 3
> > > > > > > > in progress at once.
> > > > > > >
> > > > > > > That's obviously not practical for the amount I am contributi=
ng and
> > > > > > > the length of time it takes us to get things in. I hope it is=
n't a
> > > > > > > serious suggestion!
> > > > > >
> > > > > > It's extremely serious. For example
> > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D43551=
6&state=3D*
> > > > > > is a 46 part patch series that touches 3 or 4 different areas a=
nd the
> > > > > > only type of review that's feasible is "Does this cause the bin=
ary to
> > > > > > grow too much? Or in unexpected ways?" And that sets aside that=
 I
> > > > > > believe I did ask you to rework "bootm: Allow building bootm.c =
without
> > > > > > CONFIG_SYS_BOOTM_LEN" to refactor things so that SYS_BOOTM_LEN =
is always
> > > > > > defined. That's not even a hard change, I say as someone that h=
ad to do
> > > > > > that as part of Kconfig migration of oddly (ab)used symbol name=
s.
> > > > > >
> > > > > > But in this case, your series that touch areas of code actively
> > > > > > maintained by other people is even more relevant. Whereas areas=
 without
> > > > > > other active developers, or where you are the main developer, I=
 can find
> > > > > > some smaller limits on what must be reviewed all of your *EFI* =
has other
> > > > > > active developers on it. Who are providing technical feedback, =
not
> > > > > > arbitrary or stylistic feedback. Please be explicit about what =
you are
> > > > > > suggesting in this case, so I do not mischaracterize your inten=
tion.
> > > > > >
> > > > > > > > But really, it feels like "Code needs to land" is another w=
ay of saying
> > > > > > > > "Just a NAK should be ignored".
> > > > > > >
> > > > > > > Yes, a bias more towards that would be more healthy IMO. A NA=
K needs
> > > > > > > to come with a full understanding of the use case, an alterna=
tive way
> > > > > > > to meet the use case, once that doesn't involve boiling the P=
acific
> > > > > > > Ocean.
> > > > > >
> > > > > > As it stands, I do not like to, but sometimes feel I *have*to* =
break one
> > > > > > board to unbreak another board and keep reminding both parties =
to
> > > > > > resolve the issue so no board is broken. There has been, since =
I have
> > > > > > taken over the lead of the project, at least once where I have
> > > > > > over-ruled the relevant custodian and that has resulted in the =
custodian
> > > > > > leaving. I both feel that was the right technical call, and reg=
ret it
> > > > > > came to that, still. I do not want to adopt a more broad use of=
 that
> > > > > > policy. The default for absence of agreement must be to try aga=
in.
> > > > >
> > > > > I see that Peter sent a few indignant emails. You can't win.
> > > >
> > > > I assume this is about the LED series, and I further assume you for=
got /
> > > > missed where he explained that removing the legacy code is a functi=
onal
> > > > user visible usability regression on the pinephone.
> > >
> > > It seems you are saying that we can break my boards completely, but
> > > Peter must have his flashing LEDs?
> >
> > Well, as I've stated many times and in many threads, I do not like
> > breaking one platform to fix another. And yes, I did think your three
> > platforms were functional and you didn't like the solution we had come
> > to. But also, pinephone, U-Boot is the firmware stack it ships with.
> > Phones tend to not have a lot of easily usable user-visible feedback
> > options. So yes, I really do not want to remove the early indications
> > that the device is alive / working (or to report it's not working!) when
> > we've also just recently added support for what they're missing (because
> > another new device, the openwrt one, has similar user visible
> > requirements). So to be clear, there's 5 platforms using the legacy
> > code. 1 of which someone is actively trying to in their spare time port
> > to the new codebase. I do not see the urgency in removing the legacy
> > code right now. I also do not see the point in gating the removal after
> > pinephone works (unless someone steps up for the other platforms, but
> > it's also likely a working conversion will make it easier to see why the
> > attempted quick conversion did NOT work, and so we redo the other 4
> > based on what we've learned and hope they do now work).
>=20
> I don't really disagree with any of that.

I'm sure.

> It might encourage bad behaviour though, e.g. a time-pressed
> maintainer pops his head up just long enough to cast doubt on patches,
> then heads off safe in the knowledge that nothing will happen for a
> few more months.

We can worry about that if it ever happens.

--=20
Tom

--nUApHL8QzNc5+7YF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdcRaAACgkQFHw5/5Y0
tyxcjAv8DtHlEvcqihMlADaCMk8VMa94OEf8Ze5lre2acS4XxEykEFG9AcCAPRMV
xveqJBlMOwHf6EsoCbUut1Z5xhZopoVgqk7/JUYowrScy/WVNJDiDKXY4SFbaziV
hccS4tM4Z4LbFEV0qVU2rV2BUNHHjeSlw+Dt7eYzQX7i2hGJrLAawWKCPwkaqnM0
a3+E+g3Se9zBEDRSBhiNWpTxxl66SeUAmElCXcDXTeGJ1C4W1c75eLab5BaMZ2Y5
Z0uQ82mHefgAInpiiUnUsY5NMYIMgFYgN928pxo23qiVAVKi2K8uqIJP+6olDDmA
I7I/41KUGdyNEPA8NGRr0A1WqpCTDumnyX3TvjytL6+AAzT/050KFYVNTpU4bc4T
F5Z37dcC/ue95TX/JxkVptpeJf11e/K3zNL+bATjm4cgOH/Y+YOFrpPIap6fWbCh
DMtxcPr2+hgeH8FzG0KYGcPjOV9t74lpDySOMvC2AR9QLb+2LLFsI75RYAtHRAop
2emIMaYj
=K57w
-----END PGP SIGNATURE-----

--nUApHL8QzNc5+7YF--
