Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7D3E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:37:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B97D88012C;
	Fri, 13 Dec 2024 13:37:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l+CAn6Ex";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 972D98012C; Fri, 13 Dec 2024 13:37:26 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB2CF80081
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:37:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so319825166b.3
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734093443; x=1734698243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nwh7zWaMYsvGoePDeV4Eh8iM4TBX6+mXlk0HKMSc4vU=;
 b=l+CAn6ExkHKExiRS4tEHpBEHMLaFCix/Vmvb+mszHo02y42Fs7/PsXOtI/8FcAK2mG
 hJjCB/FhrEAxWJagZZQxYVlU8lE8dc4rY4NTsOrZHCpB2UZDmpHaFgXDFh4wvU89q74u
 EYxiR1o8Z5YdzLLu5I/rFXV/uY3b96Up1knFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093443; x=1734698243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nwh7zWaMYsvGoePDeV4Eh8iM4TBX6+mXlk0HKMSc4vU=;
 b=Egv7LTCOoQdejQdTrK6SoKaMyfunqViEfA7U5OfqkAiv4t3TXiT/cz22tKqJF+BUZF
 GbnWIRw0vkCoaTuNH3tDQuuYxbEzunINZ3nS1XLnaFurTv2GxlQyoJVuc/aTEIxWQ6mP
 bp0sNUrnFbpdIyKmhQ2gl0ATJNU005zGUZL+nPVfslGoTo8igWUHacHM8IGBKCsXwKwi
 1nn5uVSnQKiKgetkGNIuuei4iLQGul7Ca9ji0weq96ZNYNjWMMezEcpczV3SUZBjzFG+
 sI57yEeWjys0S+bCi0JoZVmxlI2JBvJWDtGRYGE6A/w+E0PI3fcyRdbxd07DbjLdctAV
 SVmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGMtD+iyooXTc6zRIk2AMMxwq2dZbqf3aKRubMA92RgtuwJ57mqdAkq0OIuMuj/SIQ8GFAdzk=@lists.denx.de
X-Gm-Message-State: AOJu0YyV6/mODzqme7huf+exKwQ12Z4sZcG+AkER086aDpLZpqokaNXC
 HNRyBLqyWT5NFLFOJvVZaQfsoTJwFSnPqio8VMec8NJuMHx/+FxFd8+JiIO6dfbkfus9IaKykGU
 rvBpYdTZ4vZwb3GJsGB0Nf0NF40S/Ls9hEEDk97GZNxLMOoYF9A==
X-Gm-Gg: ASbGncuvvqJon+054bWYMvOkrTBKGzjYxwqtEXyvIrZ70tFIPUv/k+yO36gNGCTSSi6
 GgUq9vyoRQ1MI4SPzUO+gGucGp/vZaQF9VWkJYx4=
X-Google-Smtp-Source: AGHT+IH4Mn+PsNqJBlqobsBJ3s2K7EOY6IlacLr5hZNfPIDy0Y9iUPhNmBb2sEcj4QIvRrhKHjCfFcl/kORlQp2s85w=
X-Received: by 2002:a17:907:c0f:b0:aa6:5d30:d976 with SMTP id
 a640c23a62f3a-aab778c1d94mr283024966b.10.1734093442735; Fri, 13 Dec 2024
 04:37:22 -0800 (PST)
MIME-Version: 1.0
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
 <20241212165147.GF1505244@bill-the-cat>
In-Reply-To: <20241212165147.GF1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Dec 2024 05:37:11 -0700
Message-ID: <CAFLszThy7RzztLNa_tDH2rkPqWZvimZv04Hx1Bo5SRs13One=Q@mail.gmail.com>
Subject: Re: Applying patches to mainline (Was: Re: [PATCH v2 0/7] efi_loader:
 Add support for logging to a buffer)
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

On Thu, 12 Dec 2024 at 09:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Dec 12, 2024 at 07:09:12AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 6 Dec 2024 at 17:59, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Dec 06, 2024 at 04:43:47PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 6 Dec 2024 at 13:12, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Dec 06, 2024 at 12:19:38PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 4 Dec 2024 at 09:27, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Dec 04, 2024 at 08:13:04AM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 3 Dec 2024 at 18:29, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Dec 02, 2024 at 05:21:05PM -0700, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > From my side I'd like to change the conversation a little, to how to
> > > > > > > > > > land code, rather than why we should bother. "Code needs to land"
> > > > > > > > > > should be the motto. If someone has taken the time to create
> > > > > > > > > > something, our bias should be towards getting it in, with sufficient
> > > > > > > > > > changes to make it fit the project. There are cases where something is
> > > > > > > > > > just a bad idea, or should be done another way, but for people working
> > > > > > > > > > on major features or changes, biasing towards not landing the code is
> > > > > > > > > > just going to make them go elsewhere.
> > > > > > > > >
> > > > > > > > > This is the wrong approach I believe. The goal has always been and
> > > > > > > > > continues to be to have reviewed (whenever possible, our developer
> > > > > > > > > community is small) incremental change over time.
> > > > > > > >
> > > > > > > > Yes, I agree with that, but it isn't what I said.
> > > > > > >
> > > > > > > I don't know how else to interpret "Code needs to land". I'm not sure
> > > > > > > what reviewed patches we have that are outstanding, but also not fairly
> > > > > > > new. We do have patches outstanding, in general. Much of those fall in
> > > > > > > to the categories of:
> > > > > > > - Custodian is active, but also very busy (virtually everyone is a
> > > > > > >   volunteer so I have a hard time getting forceful with people that have
> > > > > > >   a large queue).
> > > > > > > - Custodian isn't active / no direct custodian and the code hasn't been
> > > > > > >   reviewed by anyone else.
> > > > > >
> > > > > > Here's my intention with 'code needs to land': to bias against people
> > > > > > saying "I don't like this; I don't care about your use case; please go
> > > > > > away"
> > > > >
> > > > > To me that applies an arbitrary nature to patches being rejected, which
> > > > > I do not see as being the case.
> > > > >
> > > > > > > > > Just because something
> > > > > > > > > has been posted a number of times does not mean it's ready to be merged.
> > > > > > > >
> > > > > > > > I didn't say that either.
> > > > > > >
> > > > > > > It's an impression you give however when you repost a series less than a
> > > > > > > day after last posting, without addressing all of the feedback.
> > > > > >
> > > > > > I'm going to ignore that comment as it is not helpful and
> > > > > > mischaracterises my contributions.
> > > > >
> > > > > I stand by it, and will let others judge if that's the impression they
> > > > > have, or not.
> > > >
> > > > I'll put the relevant threads at [1], ditto.
> > > >
> > > > >
> > > > > > > > > Your challenge today is that on patchwork you have over 150 patches
> > > > > > > > > covering a wide variety of topics and of which many series have
> > > > > > > > > technically-merited feedback that needs to be addressed in a technical
> > > > > > > > > manner.
> > > > > > > >
> > > > > > > > By my count I have about 10 series in progress, with a small number of
> > > > > > > > patches (< 10?) with pending feedback
> > > > > > >
> > > > > > > I'm not sure about that less than 10 number, in part because it's hard
> > > > > > > to keep track of which feedback was applied, and which not. And part
> > > > > > > because some of those series are places where I told you I'm unsure
> > > > > > > about the core concept but you asked and I'm giving you leeway to show
> > > > > > > me the end result.
> > > > > >
> > > > > > OK
> > > > > >
> > > > > > >
> > > > > > > > that isn't effectively just a
> > > > > > > > NAK.
> > > > > > >
> > > > > > > To be clear, "just a NAK" isn't the whole story. Those NAKs come with
> > > > > > > technical rationales and requests. But maybe they're just lost in the
> > > > > > > volume of emails you have in some cases. I know for example I mentioned
> > > > > > > a few times and places that we have tests today for booting the OS, when
> > > > > > > you mention that we need to add a test for booting the OS. We need to
> > > > > > > expand that test, yes.
> > > > > >
> > > > > > If you look at the OF_BLOBLIST thing, it is basically a NAK. I don't
> > > > > > see any other way to interpret it,. So several boards in my lab have
> > > > > > been broken for a year.
> > > > >
> > > > > To be clear, you want to revert:
> > > > > commit 70fe23859437ffe4efe0793423937d8b78ebf9d6
> > > > > Author:     Simon Glass <sjg@chromium.org>
> > > > > AuthorDate: Wed Jan 3 18:49:19 2024 -0700
> > > > > Commit:     Simon Glass <sjg@chromium.org>
> > > > > CommitDate: Sun Jan 7 13:45:07 2024 -0700
> > > > >
> > > > >     fdt: Allow the devicetree to come from a bloblist
> > > > >
> > > > >     Standard passage provides for a bloblist to be passed from one firmware
> > > > >     phase to the next. That can be used to pass the devicetree along as well.
> > > > >     Add an option to support this.
> > > > >
> > > > >     Tests for this will be added as part of the Universal Payload work.
> > > > >
> > > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >     Reviewed-by: Tom Rini <trini@konsulko.com>
> > > > >     Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > >
> > > > > Which means that you did not test your changes on your hardware at the
> > > > > time? And wish to (seemingly) replace that with an earlier version of
> > > > > the patch which was objected to on technical grounds at the time.
> > > > > Without explaining why the current code does not function on these
> > > > > platforms, only that it does not, for entirely unclear reasons.
> > > >
> > > > It never worked on my board, though. I spent 6 revisions trying to
> > > > explain that. After number 6 [2] you got in touch and said that I
> > > > needed to rework it, which I dutifully did, in version 7 [3]. I did
> > > > that purely to unblock Raymond's series. I even put that in the patch:
> > > >
> > > > "The discussion on this was not resolved and is now important due to the
> > > > bloblist series from Raymond. So I am sending it again since I believe
> > > > this is a better starting point than building on OF_BOARD"
> > > >
> > > > Are you now saying I should have refused and argued for another few
> > > > revisions? Patience does have its limits.
> > >
> > > I'm saying that I assumed what you pushed functioned on your hardware,
> > > which is why I'm surprised now that it doesn't.
> >
> > How can you possibly assume that, or be 'surprised' about that?! I
> > repeatedly said that the solution was no good for me and I was very
> > clear that I only sent that patch because you insisted on it. You sent
> > a 'thank you' afterwards, which rang pretty hollow after so much
> > effort and still having broken boards.
>
> Well, I can and maybe should more often admit to missing a thing or two
> in very long threads, that's how. Doubly so in light of the patches I
> posted now (after you wrote the above, but before I read it) fixing your
> platforms.
>
> > From what I vaguely recall, in a discussion that went on till the cows
> > came home, it was tied up with U-Boot not being allowed to have its
> > own devicetree. Another vague recollection was that I was stupid and I
> > didn't understand...
>
> Yes, that's another thing that doesn't make any sense. You still insist
> that point while no one is making the point you insist someone is
> making.

Well, I did spend many happy hours arguing with someone about whether
U-Boot was allowed to have its own devicetree, have its own properties
in the devicetree, etc. I did not imagine it. I believe that
OF_BLOBLIST was radioactive partly because of that.

>
> > > I'll look through all of
> > > the links later, but I think you still haven't explained _why_ this
> > > solution doesn't function on your platforms (now or last year) and what
> > > your platforms need (as in, can't change) / want (you would need to
> > > rework some other part of the firmware stack to get them in agreement on
> > > that platform).
> >
> > Actually I've explained that many, many times. They use bloblist but
> > not for passing the FDT. This strange insistence that the bloblist
> > must carry the FDT is what caused all these problems. I need a
> > platform to be able to boot TPL, have a bloblist set up in SPL, pass
> > it to U-Boot proper, all without having an FDT in it.
>
> OK, but that doesn't seem to be how the platforms work? Bob and Kevin
> don't use TPL (but they use TF-A? I can't see in gitlab how we build for
> testing on HW and it's not clear if we're grabbing bl31 from somewhere),
> but it's SPL that initializes DRAM. And that means we can't look at the
> bloblist in DRAM before init'ing DRAM. Coral does have TPL, but does not
> enable TPL_BLOBLIST currently. But it looks like it also does DRAM
> initialization in SPL, so, overall the same class of problem.

Yes, that's right. See [1]

It would be nice to expose that information in gitlab. Not hard to do,
just print out the parameters for the UBootProviderDriver. It would be
even better to build bl31 from source and print out the source-hash
used.

>
> And the insistence was that IF we have bloblist support THEN we must
> look at it. Which we can't if it's in DRAM and we're responsible for
> DRAM. Which these days is often not the case. And if you mentioned that
> problem in the many threads we had at the time, it was drowned out by
> other comments.

My patch from a year ago fixed a regression and a bug. It should have
been applied, but instead we all argued about it through 7 revisions
and then it just died. That result is not on me, sorry.

>
> > > > > So I do not think I've arbitrarily nak'd the revert you posted, I've
> > > > > been asking you to explain why the code doesn't work. And I still don't
> > > > > have an answer as to why after at run time we don't find a valid
> > > > > bloblist here the fall-back use cases aren't functioning. To me that
> > > > > seems like the bug to investigate and explain. Reverting code to find
> > > > > when functionality broke is great, I do it all the time. Saying we need
> > > > > to revert because something broke *without* saying why it broke is a
> > > > > problem.
> > > > >
> > > > > > > > It isn't a particularly large number, if you add up the patches I
> > > > > > > > do in each cycle. It is in the nature of development and code review
> > > > > > > > that things are often not right the first time, or someone else has
> > > > > > > > another perspective, so I cannot see how this can be reduced.
> > > > > > >
> > > > > > > The easy way to reduce it would be to go from 10 series in progress to 1
> > > > > > > series in progress, and finish that before picking up series number 2,
> > > > > > > and so on. And then in the future, stop when you have more than 2 or 3
> > > > > > > in progress at once.
> > > > > >
> > > > > > That's obviously not practical for the amount I am contributing and
> > > > > > the length of time it takes us to get things in. I hope it isn't a
> > > > > > serious suggestion!
> > > > >
> > > > > It's extremely serious. For example
> > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=435516&state=*
> > > > > is a 46 part patch series that touches 3 or 4 different areas and the
> > > > > only type of review that's feasible is "Does this cause the binary to
> > > > > grow too much? Or in unexpected ways?" And that sets aside that I
> > > > > believe I did ask you to rework "bootm: Allow building bootm.c without
> > > > > CONFIG_SYS_BOOTM_LEN" to refactor things so that SYS_BOOTM_LEN is always
> > > > > defined. That's not even a hard change, I say as someone that had to do
> > > > > that as part of Kconfig migration of oddly (ab)used symbol names.
> > > > >
> > > > > But in this case, your series that touch areas of code actively
> > > > > maintained by other people is even more relevant. Whereas areas without
> > > > > other active developers, or where you are the main developer, I can find
> > > > > some smaller limits on what must be reviewed all of your *EFI* has other
> > > > > active developers on it. Who are providing technical feedback, not
> > > > > arbitrary or stylistic feedback. Please be explicit about what you are
> > > > > suggesting in this case, so I do not mischaracterize your intention.
> > > > >
> > > > > > > But really, it feels like "Code needs to land" is another way of saying
> > > > > > > "Just a NAK should be ignored".
> > > > > >
> > > > > > Yes, a bias more towards that would be more healthy IMO. A NAK needs
> > > > > > to come with a full understanding of the use case, an alternative way
> > > > > > to meet the use case, once that doesn't involve boiling the Pacific
> > > > > > Ocean.
> > > > >
> > > > > As it stands, I do not like to, but sometimes feel I *have*to* break one
> > > > > board to unbreak another board and keep reminding both parties to
> > > > > resolve the issue so no board is broken. There has been, since I have
> > > > > taken over the lead of the project, at least once where I have
> > > > > over-ruled the relevant custodian and that has resulted in the custodian
> > > > > leaving. I both feel that was the right technical call, and regret it
> > > > > came to that, still. I do not want to adopt a more broad use of that
> > > > > policy. The default for absence of agreement must be to try again.
> > > >
> > > > I see that Peter sent a few indignant emails. You can't win.
> > >
> > > I assume this is about the LED series, and I further assume you forgot /
> > > missed where he explained that removing the legacy code is a functional
> > > user visible usability regression on the pinephone.
> >
> > It seems you are saying that we can break my boards completely, but
> > Peter must have his flashing LEDs?
>
> Well, as I've stated many times and in many threads, I do not like
> breaking one platform to fix another. And yes, I did think your three
> platforms were functional and you didn't like the solution we had come
> to. But also, pinephone, U-Boot is the firmware stack it ships with.
> Phones tend to not have a lot of easily usable user-visible feedback
> options. So yes, I really do not want to remove the early indications
> that the device is alive / working (or to report it's not working!) when
> we've also just recently added support for what they're missing (because
> another new device, the openwrt one, has similar user visible
> requirements). So to be clear, there's 5 platforms using the legacy
> code. 1 of which someone is actively trying to in their spare time port
> to the new codebase. I do not see the urgency in removing the legacy
> code right now. I also do not see the point in gating the removal after
> pinephone works (unless someone steps up for the other platforms, but
> it's also likely a working conversion will make it easier to see why the
> attempted quick conversion did NOT work, and so we redo the other 4
> based on what we've learned and hope they do now work).

I don't really disagree with any of that.

It might encourage bad behaviour though, e.g. a time-pressed
maintainer pops his head up just long enough to cast doubt on patches,
then heads off safe in the knowledge that nothing will happen for a
few more months.

Regards,
Simon

[1] https://github.com/labgrid-project/labgrid/pull/1411/commits/6d3b4a0cfc7e35e0547dcd14065328df4b4b5e1f#diff-66f82743402c95b2eac8f9937c61c582bd0aca2b35e841477d62122c811b7750R944
