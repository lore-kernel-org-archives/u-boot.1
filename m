Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D349C43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 12:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB81A841C2;
	Sat, 27 Jun 2026 14:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IdDPRy+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC69A8460E; Sat, 27 Jun 2026 14:22:21 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCA6805D7
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 14:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so1026539a12.1
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 05:22:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782562938; cv=none;
 d=google.com; s=arc-20260327;
 b=D2+teApNlPXEq6rWuZrYUBj4mfEwFFAaWyBmviUo8orlApfq4keSc1sZXfHXa2Ms1k
 6hAIN+RERhNma/a+7RXiww5X1Ma10Kp+frd0INdS1P33xFK/49LJTK4s3jc3793dYmPl
 KdxA42CuppEQARECTeGiZbd17G3GaNCwIEyII/kG+14yHl+i2/wF8/BQ5wEXb03jHPot
 QJjnd5QNjPZGflcbr56KOv+nyn4GrOcycbjpP+bnKH3zZlP6oVPwBSlJweA6GtvJe3gd
 OGnVIeSrLdDwSsjLfGbykCKjI6P1V9BhD6xD7L1MabQ2T33rnJqXKsUwEDa24KUnj9Qc
 15+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AQzCwbemfjowhgusGlyHydK43LI/iBlko3RlgvWdt4Y=;
 fh=dYRdw2a/nCzaiso6GcqLcZOUXXOF//tjQn8gRhrKfNU=;
 b=VB6r0AcXR1tqWaXMXTEwmY6bhwL/JazT1WrIbHTqglAKsLtl0TtP/2fv4oGCx06Y8o
 79BRqzmrKuphmk3crcof+QMyJWRg116kuFuGXIjGn4eC5fzBbxX4dDA2kSsKg831WNFK
 Sou5Xom4sSA7YvLnjO4yHtE8sI1VGNWnnVDczXOVDOK+65jNJN8qYHX0Y36Ad0a98GQ1
 EjQLV302kXkZdXLNc9hdPYNiU+e5FtAkAPSxAEvuAAdNKOnk1Q73XYZ3ADcMsexq2P4X
 Ii+RxnNj8Xh6XvPD8e0LCxi9253iOmT2LCH9hoVGL9ReLH2ZxP2tbQ1QfoLXZdifr1ND
 wmag==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782562938; x=1783167738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AQzCwbemfjowhgusGlyHydK43LI/iBlko3RlgvWdt4Y=;
 b=IdDPRy+WY+mfnjykIJ70aSPCl/NRo1Fy8WDJdo0FuCxZ7vkm/bUPnfseI7JlNe0BRu
 FbeXPymr22sKoQwogaciLvnFTksXgq/8mOTzrh+zkbnZJelqCy0cIEMyk46cvmHrOq24
 2naH2hKyEvFId1SZ7RnDubhN19iBGO8M4N4qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782562938; x=1783167738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AQzCwbemfjowhgusGlyHydK43LI/iBlko3RlgvWdt4Y=;
 b=D2Lm/8Jb8ASbbXKBKvqdCEM6FU8Lcqn+/SeSWIEe9mdEo82b9uq+/PdEv7bE9rn4RC
 F1Qao02x3MtexN98NoOhJXtQdwLZ5uXGuQIlu93EA8bl2MfGGnNqaaTOAI18ojNEaPA1
 315hXKw6Hk7AM8f4NtHx99GtLUhrz3bxJ5r8h13dIqw+P4mbAuh5QqvGtMXD1XEn43JC
 w9RuM5Jl5pnYGfPiBCpoCja+OiEU6eVkBg2f+cQA5MTQLu4bx//+iTvR4aaGxc+q9BU2
 XPQJaWssKmniz1d82Un36JAWAFfg1j3/VV+aNTHh7dPLvgTx86ChdMhqGqVeU6fKiuNC
 e6nw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpq8E8V+gnxyXcXhF1V7dDxhzoDgQ8ts1cPWuOOXwh51MzV2RmV2j73i68l47QyRhKp5MCdkvk=@lists.denx.de
X-Gm-Message-State: AOJu0YxSjxUm8KGrg/vKas3c380FzJf38ZE9a5WcYtIwkOXtq+7ISwLb
 7NZQSaCIK+xu6QCogS312luCk1gFIrkCGZur8VY8kByoCDCJWOPTmCS2059o04EFw/VsfN7Dvr0
 y+GiYU1+Dz/MBnzgUqfZhRpW3GuLtj1kz0oj/te70J5KiXgKHh6ghkQ+u
X-Gm-Gg: AfdE7cm2AvR0DA9K9euIjBoJk57pAMEmgCN+bGhmsBrCTMW8FEVXb6xkM4kJ0Iq0VSG
 fAoruGOIKRg80/XTDqVkxjbIMEvJ6YCEtOArlvRuP7ZzRvEJT4X3pb3oqIQdEWLk5Kf49fbws9+
 xZMFWfjjusPjKIFP0CnibhsGpb8cdgXMjCgtM9MFgF6Pe0HHQQv0SLF4Qhov/8ku9uU5zfa4yg1
 vzGATmhmImAdB2EfI2bUedAXjoWv+tVAXcvXfqzSU/QTBFio/NfXR4vwwHvmNwMU61iIHmCKQ==
X-Received: by 2002:a05:6402:27d0:b0:697:80bb:c28d with SMTP id
 4fb4d7f45d1cf-69810a45f4fmr3869051a12.6.1782562938312; Sat, 27 Jun 2026
 05:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszTj620LX379mqtMN6Bu6W29fFt5okjab8Cqk79yy4aJgTQ@mail.gmail.com>
 <6c21c8d8-74c0-43bc-9249-6cc1dc401136@linaro.org>
 <CAFLszTjGwi0MhX3wNH0eGVsumG=8c48hupe86eS_8E+J+LNdBA@mail.gmail.com>
 <CALeDE9MSA5RGEuBseiSrj6-yw9a44=0+PWC8=_HKboC-fWkkzQ@mail.gmail.com>
 <CAFLszThAqVjZ0Jd5kdB5q=bhGTNpAeHw3WXpUHnFQ_OH_KmXLA@mail.gmail.com>
 <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
In-Reply-To: <6d0f3078-2ba8-474c-9a1f-481eeb7f47bf@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Jun 2026 13:22:06 +0100
X-Gm-Features: AVVi8CeAwfvogZSjrVGM_9GKV49DA1aaTUcGk9DBUBzFAqAw03XRXI4d47GZgl0
Message-ID: <CAFLszTi+4s51HtaQrgBLEsOzoCjtZ+CGdvqBm4B9_fj-rpKqwg@mail.gmail.com>
Subject: Re: U-Boot Concept Tree Proposal
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Quentin,

On Fri, 26 Jun 2026 at 19:07, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 6/18/26 5:06 PM, Simon Glass wrote:
> [...]
> >>>>> Another difference is AI. I believe that AI is the next step on from
> >>>>> compilers, which also took a long time to produce good code and find
> >>>>> acceptance. The Concept tree welcomes (and encourages) high-quality AI
> >>>>> contributions and reviews. It accepts PRs and allows reviews on PRs or the
> >>>>> mailing list. It relies 99% on automated tests (sandbox, QEMU and labs) so
> >>>>> sets a high bar for testing. It uses a separate Gitlab instance for now and
> >>>>> of course uses a separate mailing list and Patchwork project to avoid
> >>>>> cluttering the main list. Concept runs an AI-powered cherry-picker so that
> >>>>> it keeps up with mainline. In no sense is it operated as a fork.
> >>>>
> >>>> I'm clearly against using AI for any of development or review work as it
> >>>> can't be fully trusted and will monopolize precious reviewers time reviewing
> >>>> AI code instead of reviewing legitimate contributions from individual and companies.
> >>>>
> >>>> Using AI for CI testing and regression testing could help if it doesn't add
> >>>> a burden for maintainers by reporting false positives.
> >>>
> >>> RIght, Tom has been very clear about this too, even suggesting that AI
> >>> is actually unethical. This is indeed one of my motivations for the
> >>> Concept tree.
> >>
> >> To avoid the scrutiny of using AI? If that's the case and you're
> >> intention I have further concerns.
> >
> > Not really the scrutiny...the more scrutiny the better, I think. But
> > if mainline is anti-AI then Concept can provide a place where people
> > can make use of it.
> >

Thanks for taking the time to reply to this - it is a very important
but very quiet thread.

>
> Tom has clearly communicated multiple times that AI is generally not
> welcome in U-Boot. So how is accepting AI contributions into Concept
> compatible with "Once features are landed and functional in Concept I
> hope that many will find their way to mainline"? Who's going to do the
> work? Who's going to take the legal liability of reworking AI-written
> code for submission to mainline? How is this going to address the main
> issue you're having of "code is not landing"? It's still not in mainline.

U-Boot tends to follow Linux, so we'll see what U-Boot's policy turns
out to be in .rst format. I am hopeful that eventually more people
will see the cost/benefit ratio of AI in a different light. My
understanding is the policy will be addressed once the infra move is
finished. Linux requires disclosure, something I have worked hard to
do in Concept. The legal question is covered by Linux's policy too
[1]. I do understand that any new technology creates fans and
opponents, problems and opportunities. Some thoughts at [3]

My approach has generally been to embrace change (and deal with the
fallout) rather than to resist it.

>
> What I think will happen is "I cannot get this merged into mainline so
> I'm going to get it merged into Concept and then direct my users at
> that". And eventually, over time, everything from this Concept
> contributor and their users will only land in Concept and we won't even
> have it on mainline ML.

I don't want to speak for Tom, but yes I can trace the genesis of
Concept to the increasing difficultly of getting things accepted,
particularly large things like bootstd and VBE. What do you suggest
instead of Concept?

>
> You keep repeating Concept is not a fork, but I don't understand how it
> can NOT be one.

Concept cherry-picks from mainline so that it stays up-to-date. So it
should be possible to grab a feature from Concept and apply it to
mainline without too many conflicts. A fork does not care about
mainline at all. This is a big and complex topic though, since
features build on each other (e.g. see the BLS thread [2] where the
Concept version builds on pxe_utils refactoring, making it hard to get
into mainline without several precursor series).

>
> Considering Concept is apparently going to be hosted on the same GitLab
> instance as mainline, I see this as potentially confusing people as to
> what it actually is.

Yes it could be confusing...I'm open to ideas on how to handle that.

> I still am pretty upset at the various articles you
> or AI in your behalf posted on the u-boot.org website claiming support
> for various features in U-Boot either "submitted" (nowhere to be seen on
> the ML) or not explicitly stating they are merged in a fork of U-Boot
> (Concept, that is).

See above re fork. I am responsible for the articles, although Claude
and Gemini helped write most of them. I thought I was being quite
careful to label things as 'Concept', but I've just gone back through
and found a good number unfortunately did not. I've fixed those and
also updated the titles in about 20 cases too. Please let me know if
you see other problems.

> That with the fact our official documentation used
> to be on docs.u-boot.org really made it look like (to me) we were behind
> this effort. We made the mistake of hosting the docs on a domain name we
> didn't (still don't?) control, I would like to avoid repeating the same
> mistake a different way by hosting a fork on the same instance as mainline.

OK. Would a URL link to Concept be acceptable?

>
> U-Boot has friction also because we don't have enough reviewers or
> maintainers compared to the number of contributors. I don't see how you
> plan on addressing that by maintaining Concept by yourself (with an AI
> I'm assuming).
> I appreciate you're possibly one of the most if not the most active
> reviewer on the ML and that there's not much more you can do to improve
> the situation aside from recruiting more people to review.

Yes I have generally been the most active reviewer over the last 10
years or so, although sometimes I have burnout and stop.

Here's how people become reviewers, IMO:

Step 1: Punter has a problem, debugs it and conceives a fix / feature
to resolve it
Step 2: Punter sends a patch or short series
Step 3a: People review the code and Tom accepts some version of it
Step 3b: Patch is rejected, or people are mean or dismissive, or don't
understand the problem, or the effort gets too great (punter exits
here and goes to write his own firmware in Rust :-)
Step 5: Punter sees a related patch from someone else and decides to
reply with some thoughts
Step 6: Punter starts getting interested in more areas of U-Boot,
sending patches and reviewing, etc.

A key challenge IMO is reviewers / maintainers (and authors!!) of
generic code. We have maintainers who handle archs and some areas. We
lack people who are willing to dig into unfamiliar code, figure out
how it should work and review / send patches. It is thankless work in
many cases - I can attest to that, having done many thousands of
reviews.

Speaking for myself, I would be encouraged to spend more time on
reviews if I had a stronger sense of ownership of a particular
subsystem (and ability to get PRs accepted).

Out of interest I tried to list the top reviewers in somehat generic
directories (anyone who has done at least 50 reviews in an area):

EXCLUDE=board,include,configs,arch/arm/dts ./review-stats.sh 20 50
reviews commits  name                 top review areas (# reviews)
   7224   10576  Simon Glass          common(699), test(665),
doc(519), lib(452), tools(447), cmd(447), arch/x86(378),
arch/sandbox(273), drivers/core(204), scripts(197),
arch/arm/include(184), drivers/video(181), drivers/serial(180),
boot(134), drivers/clk(131), drivers/mmc(129), drivers/gpio(126),
arch/arm/cpu(123), drivers/net(117), Makefile(116), drivers/usb(113),
drivers/power(110), drivers/pinctrl(109), drivers/mtd(105),
MAINTAINERS(101), arch/arm/mach-rockchip(96), drivers/pci(89),
net(86), drivers/spi(83), drivers/misc(80), arch/mips(75), README(73),
arch/powerpc(72), arch/arm/Kconfig(66), fs(65), drivers/timer(65),
drivers/i2c(65), arch/arm/mach-tegra(58), arch/arm/lib(58),
drivers/block(54), Kconfig(53), env(52)
   2953    4094  Tom Rini             common(352), arch/arm/cpu(224),
arch/arm/include(200), cmd(159), lib(124), tools(113), doc(101),
arch/arm/mach-omap2(94), scripts(92), boot(79), drivers/mmc(68),
arch/arm/Kconfig(65), test(60), README(60), drivers/net(56),
drivers/usb(52), arch/arm/mach-keystone(52)
   2675    1611  Bin Meng             arch/x86(839), cmd(180),
doc(164), drivers/pci(143), arch/riscv(135), common(133), lib(122),
test(95), scripts(65), drivers/net(60), tools(57), drivers/core(55),
arch/sandbox(52)
   1907     540  Kever Yang           arch/arm/mach-rockchip(343),
doc(132), drivers/ram(93), drivers/clk(90), arch/arm/include(90),
dts(89), drivers/phy(53)
   1703    1702  Stefan Roese         tools(190),
arch/arm/mach-mvebu(142), drivers/watchdog(94), drivers/pci(91),
common(71), cmd(66), drivers/net(61)
   1484     578  York Sun             arch/arm/cpu(277),
arch/arm/include(242), arch/powerpc(196), drivers/net(141)
    996    1036  Jagan Teki           drivers/mtd(221),
drivers/spi(208), arch/arm/mach-sunxi(65)
    875     679  Patrice Chotard      arch/arm/mach-stm32mp(183)
    829     123  Priyanka Jain        arch/powerpc(131),
arch/arm/cpu(65), drivers/net(58)
    813    1281  Fabio Estevam        arch/arm/mach-imx(147),
arch/arm/include(63)
    768    3054  Heinrich Schuchardt  lib(348), doc(136), cmd(86)
    746    4354  Marek Vasut          drivers/usb(207), common(75)
    697     327  Ilias Apalodimas     lib(334), cmd(94)
    674    1381  Peng Fan             arch/arm/mach-imx(160),
drivers/mmc(80), arch/arm/include(54)
    605     743  Heiko Schocher       drivers/i2c(194), common(51)
    515    1180  Patrick Delaunay     arch/arm/mach-stm32mp(79)
    478     381  Philipp Tomsich      arch/arm/mach-rockchip(84)
    455      91  Ramon Fried          drivers/net(299), net(65)
    433      34  Leo Yu-Chi Liang     arch/riscv(194)
    428      76  Mattijs Korpershoek  drivers/usb(127), boot(68)

>
> I also see "It relies 99% on automated tests (sandbox, QEMU and labs) so
> sets a high bar for testing." as wishful thinking. I'm sure you've read
> like most of us that it's not unusual for LLMs to write useless tests or
> tests that don't do anything, or even remove existing tests that don't
> pass because the instructions was all tests need to pass. We also
> already have tests and yet we still have plenty of bugs that weren't caught.

Yes LLMs can write terrible tests - I have certainly spent many happy
hours arguing with it about tests needing to be specific, etc.
Actually we don't even bother to track code coverage in U-Boot, as
Zephyr does, for example. I have never got around to doing it, but if
we did, it would shine a light on what coverage is missing. My view is
that untested code likely doesn't work - even it if worked when
written (and landed!) it might have been broken later. So we should
have tests. You will be aware that I have expended enormous effort in
expanding tests and I generally build in tests from the start with a
new feature. Also see my review count for test/ above.

>
> I'll finish that my gut feeling (shared with some of my current and
> former colleagues) is that U-Boot is disappointingly unstable. Unlike
> the Linux kernel, U-Boot suffers from fewer eyes looking at code, fewer
> people developing it, fewer people testing master or even any recent
> release (the number of reports we have for bugs on releases from years
> ago...), and lack of proper and extensive CI test infrastructure (and if
> we have some, it's heavily centralized into a handful of people's
> offices). I loathe every time I need to update U-Boot because I don't
> know what I'll have to debug for days or if I really do test everything
> there's to test (is it my fault for not keeping up with master, yes, but
> I shouldn't feel this way).
> So I really think we could have much more confidence in code being
> merged if we had more testing, possibly on real hardware, possibly by
> companies offering to do some proper CI (e.g. like Intel is doing with
> Yocto, spending days testing release candidates before the project tags
> a release). Maybe with distros slowly adopting Aarch64 and U-Boot with
> it we'll have more coverage. I know you've worked on labgrid support for
> U-Boot and you have some merge request(s) still open there but it seems
> you're hitting the same wall there you're hitting here.

Yes I fully agree about more testing. Re Labgrid, I basically have my
own u-boot-integration branch [4] which I rebase every now and then
and it works OK. I figured out the first step in redoing it to support
one environment per board, but haven't finished - the key challenge
(apart from scale) is I have ~40 boards on one exporter, not 40
separate rpi exporters each connected to a single board. Perhaps I
will finish it by August. It just needs a solid week of effort. But in
the meantime it works fine as is, on mainline and Concept.

>
> I think one of the issues could also be because you landed so many big
> features and reworks in the past, you're likely the only one who knows
> how things work in many parts of the project. binman comes to mind,
> bootflow/bootmeth, (signed) FIT, etc... Getting people to review your
> code is then difficult because it requires an enormous amount of effort
> to get into it and most people don't have that amount of time available
> to them (or willingness to spend it in that).

Indeed.

>
> I believe we should be focusing on getting more reviewers, on many
> different parts of the code, and more automated testing, on real
> hardware. I believe that once we have this, then we will naturally have
> less time between submission and merge, and eventually can land bigger
> reworks or new features.

As an example of automated testing, the core driver model started with
a lot of tests. As we updated and expanded the behaviour, we added
more. We see people updating the behaviour but seldom do we see bugs
in the existing functionality. Same with bootstd (although it took a
while to achieve the same behaviour as the distro scripts), clk,
pmic...still, we have to remind people to add a test when they tweak
the behaviour.

Re getting more reviewers, see my comments above. It has to start with
a successful and pleasant experience when initially sending code.

Thanks again for taking the time to write this up.

Regards,
Simon

>
> Cheers,
> Quentin

[1] https://docs.kernel.org/process/coding-assistants.html
[2] https://lore.kernel.org/u-boot/CAFLszTghO2OM44ZvPg+L2aufKH9ztBz=cCx9sTjNU-eyeS_8AQ@mail.gmail.com/
[3] https://www-concept.deinde.dev/blog/thoughts-on-ai-assisted-coding
[4] https://github.com/sjg20/labgrid/tree/u-boot-integration
