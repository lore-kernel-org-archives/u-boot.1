Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F38E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 16:51:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317F0801BD;
	Thu, 12 Dec 2024 17:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CbQXCd/H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24286801BF; Thu, 12 Dec 2024 17:51:55 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0BE80141
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 17:51:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d89dc50927so6235186d6.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 08:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734022311; x=1734627111; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j5RqDNl1wVDq/S1AWRwlgSRpCGBpyR1btuyMiFzf2Gs=;
 b=CbQXCd/Hmkh67P4KF3JWtijRibgbmgfEs+ir6VDYaq24mPvLrG9b9LPXxQ6aJ7AGuY
 lycaKaAJkoUhMy0uUnTfrrLFFv90IQJxJsVVJkQJZvBpbqelQeRVAjDKG2Q2A6HfBnif
 /LKluHOJsdMNwkUXeKweWcrWqQSPcIQwPlDhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734022311; x=1734627111;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5RqDNl1wVDq/S1AWRwlgSRpCGBpyR1btuyMiFzf2Gs=;
 b=jbp9b7vZ67rcoaH3GoNzO9U1HO+tscE64XmlTCHIYVkGaNBa5yK09ZbXgLdns2ZtNw
 ImPZPbXxQhc2wP7SXDL0LsqRFi+xXoax3VNWaXjC5GsR5iewoEY1KFTWZe2VF7DcERvK
 rKLfsgSZ4iRDO3IBWERfpsVdItzJgLqh/ndTu+cDVcJTwJTlUI3rSV43Bt3ZHt6oZOgq
 00d1+wWmpM9VVda0ASge02SzdOYAfe/R6RwS53cbTOh5aLGB/8NkDbluPOvskHyVUKJV
 HUVcghO0TaefTKguacHlgYBcOzyuzgeAKE01TPLTRvAgi8bRM/jgO5wLddXh22W5AxKe
 WgDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtxEJThu3ajl+tAUDJ5M0ZrHwARsnU8JsQWAEn72n6u2xQRMuQhRCqWMomXG2e018AsoiKW60=@lists.denx.de
X-Gm-Message-State: AOJu0YyS3sXVTPt94Fjp73VQEq6fTIDoIT6dUKDwEtfdvm+gQAkC6n25
 LdJ8adTW9iYP0pG11sHLrOZBg5Yp03qXhDz14Nw3eWcFXvGENTvUSHf3cTt/Rzw=
X-Gm-Gg: ASbGncs7lWQ0G+4uZaGcs+7tAFnry0xH/2u8O9z9NTq8EnKGruq0yhrKh8cbpYXLwUs
 NG+xaQp/n2LagqvnHKliMm3NURuUNyi2ZD0oe2ooBkpR0QmC9ON9lOAP/kYYbSaLrgc55iCaCu4
 6SkVhKCTxs0Tm5LDp1hCrbbd/25hdkiZZsFMVwZWe8aiOKNEfTHYSN4yZP2GK5PMftejZ0r4qwb
 mOppTKaf4WX9Aj4/9WmIcy7XwudFTdqyjPv95+11QzugRTiqnIlQCFy
X-Google-Smtp-Source: AGHT+IHIJ1MI3S0VCV5QThE7slYHdTqrlRvGBpBLGWmbjZRyQeR+cVDhREodqcVZeqNMJRAoW5+KmQ==
X-Received: by 2002:a05:6214:509e:b0:6cb:d1ae:27a6 with SMTP id
 6a1803df08f44-6db0f789448mr12880776d6.24.1734022310771; 
 Thu, 12 Dec 2024 08:51:50 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8dac12dbasm82692586d6.131.2024.12.12.08.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 08:51:50 -0800 (PST)
Date: Thu, 12 Dec 2024 10:51:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7]
 efi_loader: Add support for logging to a buffer)
Message-ID: <20241212165147.GF1505244@bill-the-cat>
References: <20241202141558.GD2457179@bill-the-cat>
 <CAFLszTjxOE_037+kR0jgdax80sBombYo_k0YgiuVnP=KZCOvuA@mail.gmail.com>
 <20241204012907.GD2457179@bill-the-cat>
 <CAFLszTgrd3gb0hfTCtRgaX2nwbCPhGKiftAJ8gCqrGDw-thOHw@mail.gmail.com>
 <20241204162707.GG2457179@bill-the-cat>
 <CAFLszTjs7taGs5LjiZ4XBgkJtjK_Db7ZiWwbpW6Kzz_tFjo=Rw@mail.gmail.com>
 <20241206201236.GA2457179@bill-the-cat>
 <CAFLszTg2Y13iUsL7EHcw=8cKY_ii==ANoG-ztpS0Y5eMc_UKow@mail.gmail.com>
 <20241207005910.GE2457179@bill-the-cat>
 <CAFLszTg74zTUN-8VhY5sENe0hMxrnHkXd67ji4w=q=eu33NAaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GpUplOeXAwcUGV0f"
Content-Disposition: inline
In-Reply-To: <CAFLszTg74zTUN-8VhY5sENe0hMxrnHkXd67ji4w=q=eu33NAaQ@mail.gmail.com>
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


--GpUplOeXAwcUGV0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 07:09:12AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 17:59, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 04:43:47PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 13:12, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 12:19:38PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > From my side I'd like to change the conversation a little=
, to how to
> > > > > > > > > land code, rather than why we should bother. "Code needs =
to land"
> > > > > > > > > should be the motto. If someone has taken the time to cre=
ate
> > > > > > > > > something, our bias should be towards getting it in, with=
 sufficient
> > > > > > > > > changes to make it fit the project. There are cases where=
 something is
> > > > > > > > > just a bad idea, or should be done another way, but for p=
eople working
> > > > > > > > > on major features or changes, biasing towards not landing=
 the code is
> > > > > > > > > just going to make them go elsewhere.
> > > > > > > >
> > > > > > > > This is the wrong approach I believe. The goal has always b=
een and
> > > > > > > > continues to be to have reviewed (whenever possible, our de=
veloper
> > > > > > > > community is small) incremental change over time.
> > > > > > >
> > > > > > > Yes, I agree with that, but it isn't what I said.
> > > > > >
> > > > > > I don't know how else to interpret "Code needs to land". I'm no=
t sure
> > > > > > what reviewed patches we have that are outstanding, but also no=
t fairly
> > > > > > new. We do have patches outstanding, in general. Much of those =
fall in
> > > > > > to the categories of:
> > > > > > - Custodian is active, but also very busy (virtually everyone i=
s a
> > > > > >   volunteer so I have a hard time getting forceful with people =
that have
> > > > > >   a large queue).
> > > > > > - Custodian isn't active / no direct custodian and the code has=
n't been
> > > > > >   reviewed by anyone else.
> > > > >
> > > > > Here's my intention with 'code needs to land': to bias against pe=
ople
> > > > > saying "I don't like this; I don't care about your use case; plea=
se go
> > > > > away"
> > > >
> > > > To me that applies an arbitrary nature to patches being rejected, w=
hich
> > > > I do not see as being the case.
> > > >
> > > > > > > > Just because something
> > > > > > > > has been posted a number of times does not mean it's ready =
to be merged.
> > > > > > >
> > > > > > > I didn't say that either.
> > > > > >
> > > > > > It's an impression you give however when you repost a series le=
ss than a
> > > > > > day after last posting, without addressing all of the feedback.
> > > > >
> > > > > I'm going to ignore that comment as it is not helpful and
> > > > > mischaracterises my contributions.
> > > >
> > > > I stand by it, and will let others judge if that's the impression t=
hey
> > > > have, or not.
> > >
> > > I'll put the relevant threads at [1], ditto.
> > >
> > > >
> > > > > > > > Your challenge today is that on patchwork you have over 150=
 patches
> > > > > > > > covering a wide variety of topics and of which many series =
have
> > > > > > > > technically-merited feedback that needs to be addressed in =
a technical
> > > > > > > > manner.
> > > > > > >
> > > > > > > By my count I have about 10 series in progress, with a small =
number of
> > > > > > > patches (< 10?) with pending feedback
> > > > > >
> > > > > > I'm not sure about that less than 10 number, in part because it=
's hard
> > > > > > to keep track of which feedback was applied, and which not. And=
 part
> > > > > > because some of those series are places where I told you I'm un=
sure
> > > > > > about the core concept but you asked and I'm giving you leeway =
to show
> > > > > > me the end result.
> > > > >
> > > > > OK
> > > > >
> > > > > >
> > > > > > > that isn't effectively just a
> > > > > > > NAK.
> > > > > >
> > > > > > To be clear, "just a NAK" isn't the whole story. Those NAKs com=
e with
> > > > > > technical rationales and requests. But maybe they're just lost =
in the
> > > > > > volume of emails you have in some cases. I know for example I m=
entioned
> > > > > > a few times and places that we have tests today for booting the=
 OS, when
> > > > > > you mention that we need to add a test for booting the OS. We n=
eed to
> > > > > > expand that test, yes.
> > > > >
> > > > > If you look at the OF_BLOBLIST thing, it is basically a NAK. I do=
n't
> > > > > see any other way to interpret it,. So several boards in my lab h=
ave
> > > > > been broken for a year.
> > > >
> > > > To be clear, you want to revert:
> > > > commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
> > > > Author:     Simon Glass <sjg@chromium.org>
> > > > AuthorDate: Wed Jan 3 18:49:19 2024 -0700
> > > > Commit:     Simon Glass <sjg@chromium.org>
> > > > CommitDate: Sun Jan 7 13:45:07 2024 -0700
> > > >
> > > >     fdt: Allow the devicetree to come from a bloblist
> > > >
> > > >     Standard passage provides for a bloblist to be passed from one =
firmware
> > > >     phase to the next. That can be used to pass the devicetree alon=
g as well.
> > > >     Add an option to support this.
> > > >
> > > >     Tests for this will be added as part of the Universal Payload w=
ork.
> > > >
> > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >     Reviewed-by: Tom Rini <trini@konsulko.com>
> > > >     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > >
> > > > Which means that you did not test your changes on your hardware at =
the
> > > > time? And wish to (seemingly) replace that with an earlier version =
of
> > > > the patch which was objected to on technical grounds at the time.
> > > > Without explaining why the current code does not function on these
> > > > platforms, only that it does not, for entirely unclear reasons.
> > >
> > > It never worked on my board, though. I spent 6 revisions trying to
> > > explain that. After number 6 [2] you got in touch and said that I
> > > needed to rework it, which I dutifully did, in version 7 [3]. I did
> > > that purely to unblock Raymond's series. I even put that in the patch:
> > >
> > > "The discussion on this was not resolved and is now important due to =
the
> > > bloblist series from Raymond. So I am sending it again since I believe
> > > this is a better starting point than building on OF_BOARD"
> > >
> > > Are you now saying I should have refused and argued for another few
> > > revisions? Patience does have its limits.
> >
> > I'm saying that I assumed what you pushed functioned on your hardware,
> > which is why I'm surprised now that it doesn't.
>=20
> How can you possibly assume that, or be 'surprised' about that?! I
> repeatedly said that the solution was no good for me and I was very
> clear that I only sent that patch because you insisted on it. You sent
> a 'thank you' afterwards, which rang pretty hollow after so much
> effort and still having broken boards.

Well, I can and maybe should more often admit to missing a thing or two
in very long threads, that's how. Doubly so in light of the patches I
posted now (after you wrote the above, but before I read it) fixing your
platforms.

> From what I vaguely recall, in a discussion that went on till the cows
> came home, it was tied up with U-Boot not being allowed to have its
> own devicetree. Another vague recollection was that I was stupid and I
> didn't understand...

Yes, that's another thing that doesn't make any sense. You still insist
that point while no one is making the point you insist someone is
making.

> > I'll look through all of
> > the links later, but I think you still haven't explained _why_ this
> > solution doesn't function on your platforms (now or last year) and what
> > your platforms need (as in, can't change) / want (you would need to
> > rework some other part of the firmware stack to get them in agreement on
> > that platform).
>=20
> Actually I've explained that many, many times. They use bloblist but
> not for passing the FDT. This strange insistence that the bloblist
> must carry the FDT is what caused all these problems. I need a
> platform to be able to boot TPL, have a bloblist set up in SPL, pass
> it to U-Boot proper, all without having an FDT in it.

OK, but that doesn't seem to be how the platforms work? Bob and Kevin
don't use TPL (but they use TF-A? I can't see in gitlab how we build for
testing on HW and it's not clear if we're grabbing bl31 from somewhere),
but it's SPL that initializes DRAM. And that means we can't look at the
bloblist in DRAM before init'ing DRAM. Coral does have TPL, but does not
enable TPL_BLOBLIST currently. But it looks like it also does DRAM
initialization in SPL, so, overall the same class of problem.

And the insistence was that IF we have bloblist support THEN we must
look at it. Which we can't if it's in DRAM and we're responsible for
DRAM. Which these days is often not the case. And if you mentioned that
problem in the many threads we had at the time, it was drowned out by
other comments.

> > > > So I do not think I've arbitrarily nak'd the revert you posted, I've
> > > > been asking you to explain why the code doesn't work. And I still d=
on't
> > > > have an answer as to why after at run time we don't find a valid
> > > > bloblist here the fall-back use cases aren't functioning. To me that
> > > > seems like the bug to investigate and explain. Reverting code to fi=
nd
> > > > when functionality broke is great, I do it all the time. Saying we =
need
> > > > to revert because something broke *without* saying why it broke is a
> > > > problem.
> > > >
> > > > > > > It isn't a particularly large number, if you add up the patch=
es I
> > > > > > > do in each cycle. It is in the nature of development and code=
 review
> > > > > > > that things are often not right the first time, or someone el=
se has
> > > > > > > another perspective, so I cannot see how this can be reduced.
> > > > > >
> > > > > > The easy way to reduce it would be to go from 10 series in prog=
ress to 1
> > > > > > series in progress, and finish that before picking up series nu=
mber 2,
> > > > > > and so on. And then in the future, stop when you have more than=
 2 or 3
> > > > > > in progress at once.
> > > > >
> > > > > That's obviously not practical for the amount I am contributing a=
nd
> > > > > the length of time it takes us to get things in. I hope it isn't a
> > > > > serious suggestion!
> > > >
> > > > It's extremely serious. For example
> > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D435516&st=
ate=3D*
> > > > is a 46 part patch series that touches 3 or 4 different areas and t=
he
> > > > only type of review that's feasible is "Does this cause the binary =
to
> > > > grow too much? Or in unexpected ways?" And that sets aside that I
> > > > believe I did ask you to rework "bootm: Allow building bootm.c with=
out
> > > > CONFIG_SYS_BOOTM_LEN" to refactor things so that SYS_BOOTM_LEN is a=
lways
> > > > defined. That's not even a hard change, I say as someone that had t=
o do
> > > > that as part of Kconfig migration of oddly (ab)used symbol names.
> > > >
> > > > But in this case, your series that touch areas of code actively
> > > > maintained by other people is even more relevant. Whereas areas wit=
hout
> > > > other active developers, or where you are the main developer, I can=
 find
> > > > some smaller limits on what must be reviewed all of your *EFI* has =
other
> > > > active developers on it. Who are providing technical feedback, not
> > > > arbitrary or stylistic feedback. Please be explicit about what you =
are
> > > > suggesting in this case, so I do not mischaracterize your intention.
> > > >
> > > > > > But really, it feels like "Code needs to land" is another way o=
f saying
> > > > > > "Just a NAK should be ignored".
> > > > >
> > > > > Yes, a bias more towards that would be more healthy IMO. A NAK ne=
eds
> > > > > to come with a full understanding of the use case, an alternative=
 way
> > > > > to meet the use case, once that doesn't involve boiling the Pacif=
ic
> > > > > Ocean.
> > > >
> > > > As it stands, I do not like to, but sometimes feel I *have*to* brea=
k one
> > > > board to unbreak another board and keep reminding both parties to
> > > > resolve the issue so no board is broken. There has been, since I ha=
ve
> > > > taken over the lead of the project, at least once where I have
> > > > over-ruled the relevant custodian and that has resulted in the cust=
odian
> > > > leaving. I both feel that was the right technical call, and regret =
it
> > > > came to that, still. I do not want to adopt a more broad use of that
> > > > policy. The default for absence of agreement must be to try again.
> > >
> > > I see that Peter sent a few indignant emails. You can't win.
> >
> > I assume this is about the LED series, and I further assume you forgot /
> > missed where he explained that removing the legacy code is a functional
> > user visible usability regression on the pinephone.
>=20
> It seems you are saying that we can break my boards completely, but
> Peter must have his flashing LEDs?

Well, as I've stated many times and in many threads, I do not like
breaking one platform to fix another. And yes, I did think your three
platforms were functional and you didn't like the solution we had come
to. But also, pinephone, U-Boot is the firmware stack it ships with.
Phones tend to not have a lot of easily usable user-visible feedback
options. So yes, I really do not want to remove the early indications
that the device is alive / working (or to report it's not working!) when
we've also just recently added support for what they're missing (because
another new device, the openwrt one, has similar user visible
requirements). So to be clear, there's 5 platforms using the legacy
code. 1 of which someone is actively trying to in their spare time port
to the new codebase. I do not see the urgency in removing the legacy
code right now. I also do not see the point in gating the removal after
pinephone works (unless someone steps up for the other platforms, but
it's also likely a working conversion will make it easier to see why the
attempted quick conversion did NOT work, and so we redo the other 4
based on what we've learned and hope they do now work).

--=20
Tom

--GpUplOeXAwcUGV0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbFJ8ACgkQFHw5/5Y0
tyw8Ugv/TH0nWeWJw2aTVBU0heIzzQR927757Be6qCptwtBO3ptkpXmk6v8h2plV
Cg66Q/byMTGLF2d0n7Oq2+Vf87bjvJ6ZfwHPdE6QWXZ1si7vjrnvt5esfX2lDDAB
fbp2iUgBCGue+sfw16dQ09EKehofPuzcKg0NlzaJwi7ewC47ZBiWss+0yFbJnki2
p6aTsbMf9b7KW8TyoSvejWkQeLVQIJzkAVlq6uRmGOv1yrQJBXJqwRztWpfeMFxE
E9ukewPXd6y8xYNGnhv32oGf449WDvEq98TXvLjRoDANkwTtPTiw0YMa6PAeTcUQ
v6ISmSxNWrif+uGCAAt0aEUnbdV47+C4cWmZmmU0cAnFV14SL/rfn2wN7LE6gLhf
8rBLh3nDRY+P0Iky87fUBUKfrZfBzpJwWgC7ZuQpHiwcgIXDYGYxAiZrpBbQd531
q5mDTL80Fz6CGx8nWxu/NnO6Ny9vZ2toI2qcPDffWJd6E1L7dDKGyyuHjoXtcG/q
gMeXA1/a
=W938
-----END PGP SIGNATURE-----

--GpUplOeXAwcUGV0f--
