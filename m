Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66992C021B5
	for <u-boot@archiver.kernel.org>; Sat, 22 Feb 2025 02:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CFE28056B;
	Sat, 22 Feb 2025 03:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M3+91yfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D784C80F56; Sat, 22 Feb 2025 03:07:23 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F35EF806FE
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 03:07:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5dc89df7eccso4985760a12.3
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 18:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740190038; x=1740794838; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xiloxW2X8J67iR6HuElMis+WlW+B4V/q3uBZAfnVyeY=;
 b=M3+91yfD/Va9bFrp9SjvczlKDmyHFisRtLKqhLPVUNdFN1uYaVeiTAVoW9gH8v6rOI
 YYBXUoBNakWapbPPlCywH6Q0sycS0cA8L28oZ+6gKYaueTGobGYWMdwputdFP2paaJwn
 YMLY4IQBdeaqN6lGlZNfqRvrKNpL8HeHlBmaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740190038; x=1740794838;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiloxW2X8J67iR6HuElMis+WlW+B4V/q3uBZAfnVyeY=;
 b=BHzGyvyZxc6jtPcAwT4v9dj1T2pEEgNA8hDTXP+ufZl18oYdf6r+nNsCtUVLd7BnDE
 kVSqMjHJvM8p6OdCwmxqXKx++QnRZY8OrEE2EQlxNLUGjJ5BcOxK7it5wegrMns/dP/4
 B+EkZayEIBL2qHv9rE/z1pKi4a6wZG5/mFsBP5Zu5nf7frtfi1nCMYlimqWzz8CMe9o9
 51UXX5j1W6nnnXSr776u5WCHyYHqMei4p2636FiIR+zUfjopA0ug70QXBsW26CA8xofg
 youFtwJ7IdosYL40uqM8u7Dew/nl29AQZOl5eQ2vUftjz7M0BHCgXTfnOigmdYjcNrd4
 ZZNA==
X-Gm-Message-State: AOJu0Yz3Ic7FUat5f+87HzsEFC7sKycx1utqaNXR3qa9LhriFcuI1Z+q
 E/M4Qts74rS/VUnRnF95APBrXxcb4g8fJGq2WbBfhdzIeZZwXOj5uUUQs/kxIV/1v+44O4WF6Gu
 G9gugCoy00D1sq2WTGtFNdM0jogsgVsENvfD6
X-Gm-Gg: ASbGncs42umLpveUZR3riQRP9TKhesAp1LQEyHFrRAHRag3pmUfcOCbyrpSQUY88IzZ
 BP4a6T2ZqX5CF03vgJMtT2V7cwcCJ1kN1+V6tl+yngmp+/urB2heFfiUaWcA4Ymv4TfXGdBu4UI
 cHblQk4uky
X-Google-Smtp-Source: AGHT+IGE2FH58oMOg2HwDSfm+Zy21rEugcIgIkGWyIgv9lwFdf+i3A0t+8lZdlD5CGq4SFUD6FxY41+ediMVfk/fvZ0=
X-Received: by 2002:a17:907:7743:b0:ab7:c358:2fec with SMTP id
 a640c23a62f3a-abc099ca6a7mr507459366b.5.1740190038231; Fri, 21 Feb 2025
 18:07:18 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
 <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
 <20250222000331.GW1233568@bill-the-cat>
 <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
 <20250222010654.GA1233568@bill-the-cat>
In-Reply-To: <20250222010654.GA1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 19:07:06 -0700
X-Gm-Features: AWEUYZlzrqj6T28YbUHtfKmfHVVT-LFHmBDoRfF4n50TOCKecRNJIN_LyFda7n0
Message-ID: <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
Subject: Re: xPL Proposal
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 U-Boot Custodians <u-boot-custodians@lists.denx.de>
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

On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > > > > Hi  Tom,
> > > > > >
> > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > > > > > [snip]
> > > > > > > > > > I will look at "splg4" once it's somewhere on source.denx.de and I can
> > > > > > > > > > look at it, and refrain from otherwise assuming how it solves the
> > > > > > > > > > problems I had seen previously.
> > > > > > > > >
> > > > > > > > > I pushed an updated version to dm/splg-working but it is not very
> > > > > > > > > updated. Still needs more work.
> > > > > > > >
> > > > > > > > Thanks.
> > > > > > >
> > > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > changes, here's another example of the problem with your approach. What
> > > > > > > stops xilinx_zynqmp_kria from building in splg-working is that
> > > > > > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
> > > > > > > since I always use O=, rm -rf) is needed for changes there to be picked
> > > > > > > up, but that's maybe just a missing Makefile dependency line. But that
> > > > > > > just makes it easier to see the next problem, which I don't see the
> > > > > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
> > > > > > > For SPL however:
> > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > > > >   203 |         plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > >       |                      ^
> > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > > > >   205 |         plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
> > > > > > >       |                          ^
> > > > > > >
> > > > > > > And I don't see, really, what's even getting us down this error path.
> > > > > >
> > > > > > It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
> > > > > > across all phases.
> > > > > >
> > > > > > I pushed a new tree which builds without the warning. Note that
> > > > > > SPL_SPI is enabled.
> > > > >
> > > > > So, the "what" is FDT_64BIT wasn't correct. I think this is showing that
> > > > > scripts/conf_nospl is going to be a problem in and of itself, and likely
> > > > > as confusing if not more-so than any of the in-the-end visible changes.
> > > >
> > > > Yes, perhaps the key point I've been trying to get across is this confusion.
> > > >
> > > > As you know, at present we have two types of options:
> > > > a) those for which each phase has its own value
> > > > b) those for which there is a single value shared across all phases
> > >
> > > Agreed.
> > >
> > > > The only way today that you can tell them apart is by looking for uses
> > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see them,
> > >
> > > Partially agreed. Those are strong indicators that both CONFIG_FOO and
> > > CONFIG_SPL_FOO exist, but not always. We have, intentionally, both the
> > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_BAR does
> > > not) and some future-proofing (CONFIG_SPL_BAZ may exist in the future,
> > > but not yet).
> >
> > OK
> >
> > >
> > > > then the option is a) otherwise it is b). There is no way to tell from
> > > > Kconfig.
> > >
> > > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a linter
> > > would be a handy thing to have. But you're mentioning this in another
> > > context, why we need some additional knowledge somewhere.
> >
> > What I meant was that we don't have anything in the Kconfig for FOO
> > that says this is a global option or an xPL-specific one. We have to
> > hunt for SPL_FOO, etc.
> >
> > >
> > > > Also, some parts of the code may use CONFIG_IS_ENABLED() for
> > > > an option, some may use IS_ENABLED() for that same option. Some may
> > > > use $(PHASE_) and some may not. It's a bit of a mess.
> > >
> > > I'm sure you can find some examples where we have CONFIG_IS_ENABLED(FOO)
> > > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's not a
> > > big deal, and should be fixed.
> >
> > But this is largely the point of my series. It's the reason why
> > qconfig is able to locate these cases and warn about them. It is a big
> > deal, IMO, or at least big enough for me to attempt this.
> >
> > >
> > > I'm only going to rant slightly that checkpatch.pl telling people to use
> > > these macros has made the situation worse, not better, out of an
> > > ingrained need to silence checkpatch.pl.
> > >
> > > And what you're missing is that sometimes we intentionally don't want
> > > $(PHASE_), or would need to rewrite the Makefile to make use of it.
> > > fs/Makefile is an example of this.
> >
> > The next step from my side would be to get rid of the 'ifdef
> > CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoying.
> >
> > >
> > > > Stepping back a bit, perhaps the goal of my series is to identify
> > > > options in b) so we can deal with them in a better way. They are all
> > > > listed in conf_nospl, in preparation for some future action.
> > >
> > > There are two big problems here. The first of which is that conf_nospl,
> > > as a concept, is going to be incomplete. Do you list every CMD in there?
> > > Why? They'll never be in a non-PPL phase. It will be its own nightmare
> > > to keep correct, once it is bug-compatible with what we have today.
> >
> > This is actually the *nice* thing about conf_nospl. We should reduce
> > it to empty, just like we did with the Kconfig whitelist.
> >
> > We have this rule:
> >
> > libs-$(CONFIG_CMDLINE) += cmd/
> >
> > which is enough for most things. The only issue is that sometimes,
> > e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
> >
> > So I don't agree at all that my series is a 'big problem'. It is a
> > solution to the current confusion and it shows up what is broken and
> > needs to be fixed.
> >
> > >
> > > The second big problem is that it doesn't make it any easier to solve
> > > what I keep calling the DWC3 problem. It's a valid use case that two
> > > developers have hit independently of wanting to enable USB gadget
> > > support (and the HW uses DWC3) in SPL and not PPL. Not only are you not
> > > solving this problem, it gets worse to solve. Today it's "OK, I need to
> > > find where to move obj-$(CONFIG_FOO) to be more visible and
> > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONFIG_FOO)
> > > working here but not there?".
> >
> > Is that because some Makefile higher in the hierarchy is not building
> > that subdir? I don't know what this is about.
> >
> > >
> > > To me, at absolute best case here, we're making a lot of changes and
> > > spending a lot of time to not really address the underlying problems,
> > > just making some questionable value visibility changes. We could reduce
> > > ourselves to one macro by saying only ever use CONFIG_IS_ENABLED(FOO)
> > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case where it
> > > must only be tested on CONFIG_FOO.
> >
> > Or we could finish and apply my series, which does this.
> >
> > > I'm 80% sure we could simplify all of
> > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that eliminates the
> > > which to use of those question.
> >
> > Again, let's apply my series, which actually gets rid of PHASE_, SPL_
> > and XPL_ altogether.
> >
> > > And update / expand upon the existing
> > > documentation we have as it's not clear enough for everyone. Then we can
> > > think, again, about how to solve the problems that are introduced by
> > > building our entire source tree N times from a single configuration
> > > file. Or if we need to do something radical there.
> >
> > At this point I'm getting the feeling that you imagine my series is
> > some grand unified plan for Kconfig. It really isn't and this thread
> > is reminding me of why I originally wrote it. Bear in mind it was over
> > two years ago and I have mostly forgotten all the issues. It is a
> > clean-up series. It isn't the second coming but it isn't the
> > antichrist either.
>
> I worry you're going to spend another month of effort to get this to 1:1
> compatibility (modulo fixing bugs) with what we have today and get
> disappointed once it rolls out to -next. But I guess I've already spent
> too much time trying to convince you this is a bad idea and that your
> cure is worse than the disease.

To me the core issue is whether to completely split the defconfig
files. I am quite worried about that. You are quite worried about the
confusion my series will cause.

I think it is reasonable, if we go with my series, that I drive
conf_nospl down to zero lines (and remove the feature) before going
any further. Would that make you more comfortable? It would be a fair
bit of work, but could be done over a few releases.

Regards,
Simon
