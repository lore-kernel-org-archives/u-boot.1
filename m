Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DA4C021BE
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 02:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6887680977;
	Wed, 26 Feb 2025 03:51:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C1PFamwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C2AF80786; Wed, 26 Feb 2025 03:51:24 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06631807EE
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 03:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-abec925a135so263850766b.0
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 18:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740538280; x=1741143080; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=efImsTHEwgQ8ObafBgSZeN7FcMjj3Tt2PeaL85eCeh4=;
 b=C1PFamwRty9VgwTZuc0DPhPFmynd7QyMetppyC40qVALOzAWW8jROG8vOA+Kn30o56
 ebSO4RhkvbDwQeL2kkSSFY6hkU+KpcfaoLZJbMJJF0Ywfb27Tr+Sv0CEWiy4vvSDo+e4
 yFTp4rrVRYWdKZ/kOA/qscaY7x1i7DFiFFsJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740538280; x=1741143080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=efImsTHEwgQ8ObafBgSZeN7FcMjj3Tt2PeaL85eCeh4=;
 b=jrNCiwN/xz+5Vubj4XtPVAhd2rai8Ynxjqp4WOwF2rPzkL0DsdhyBk0RPe4mH2WSC2
 KPOiTE/gH2Zr/8hP3XYUSJhN7c8kkK/ZY6hghhwot6UDFwe933tou2BVW5T6SbwwpYgV
 STuq8mFUxQssdj4BNnCGRsWYXYFP+sa8rnvK0fguHAPds/EX8XZtsN15SX4SmO44eAkH
 n8UZKznZnKvYsnY88Sa32MkuRBH3uj3CRrOE13jL8JJF1naldsWIN4p7VX4su8HHNbl3
 xMH65Pto7VrzlDUU76hrtHLxpdf59Md8ZaHaCCEZk1qfPDdlKfCp7+B2Kvg0QH6IekMB
 mMRg==
X-Gm-Message-State: AOJu0YyEWzsun8FUa0PsxC1dXzfNPRd+atmgqtrdqvFWHn6v3OL4wVMd
 e/h/WhmKi8/Blcslx+xYxfBPPkAXJZaighjNoqT44wwJpuOm73hNSo5KDhbOwPMYLuQpJ6QFlZM
 R5h1BH57SJsIRqbJICkWQjjf+2BWT97K9EfuNaw5ycFstWbGaFQ==
X-Gm-Gg: ASbGnctoanGN8P+MmKg92GVGav8y1uElgtQMoeXbaLoCi0wtX42VKrJa3QdTXexqfte
 +lS7BBkplIx0JEWHwk0qyeeTKMIXoM1W9byaqLD9G+2UWAbzjNE6kXb6y51wY3rfSi1OiQ9BJIo
 Fg9oApf+E4
X-Google-Smtp-Source: AGHT+IEljZK7/SQZZQsYgOqaPgLxzu3cUz6d9ap55cGSpG5j4QD5qOQ3mYu8uM3p3DW/WqTSSU89b3tLojQN+CaGh3s=
X-Received: by 2002:a17:907:7ba2:b0:abb:b31d:778f with SMTP id
 a640c23a62f3a-abeeed8db32mr137715866b.20.1740538280255; Tue, 25 Feb 2025
 18:51:20 -0800 (PST)
MIME-Version: 1.0
References: <20250221232005.GV1233568@bill-the-cat>
 <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
 <20250222000331.GW1233568@bill-the-cat>
 <CAFLszThbizWn8ja9pwfa6Fn6NBp83BdAUFkoO97PEtUCUuQzBg@mail.gmail.com>
 <20250222010654.GA1233568@bill-the-cat>
 <CAFLszTgS1KtMtuW9vo=F-H5q_km0BLsA5BVU_cZDSV9dgOo_mA@mail.gmail.com>
 <20250224160004.GF1233568@bill-the-cat>
 <CAFLszTjr7DDNdUDDsVyM_+KeFNA9pVu9CYTv12PqGPEad83xkw@mail.gmail.com>
 <20250225140242.GM1233568@bill-the-cat>
 <CAFLszTi6tNhFgXgYdYZpp=1-7P=O8wkAgug5xP2syn=mU==PCg@mail.gmail.com>
 <20250225215100.GC2640854@bill-the-cat>
In-Reply-To: <20250225215100.GC2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Feb 2025 19:51:07 -0700
X-Gm-Features: AQ5f1JoXVgoQ71l46RWKURFTAfDXJR1dPIDuVJ6Esj1_6W1zBA5hq_kp8gDMvU0
Message-ID: <CAFLszTiP3=FyUm36aLPfdwObQT0WPS_+Y486VRmV41cxEkA93w@mail.gmail.com>
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

On Tue, 25 Feb 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Feb 25, 2025 at 02:33:17PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 25 Feb 2025 at 07:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 04:38:50PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Mon, 24 Feb 2025 at 09:00, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Feb 21, 2025 at 07:07:06PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Fri, 21 Feb 2025 at 18:06, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Feb 21, 2025 at 05:24:35PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 21 Feb 2025 at 17:03, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Feb 21, 2025 at 04:35:16PM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi  Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > [snip]
> > > > > > > > > > > > > > > > I will look at "splg4" once it's somewhere on source.denx.de and I can
> > > > > > > > > > > > > > > > look at it, and refrain from otherwise assuming how it solves the
> > > > > > > > > > > > > > > > problems I had seen previously.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I pushed an updated version to dm/splg-working but it is not very
> > > > > > > > > > > > > > > updated. Still needs more work.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > > > > > > > > > > > > changes, here's another example of the problem with your approach. What
> > > > > > > > > > > > > stops xilinx_zynqmp_kria from building in splg-working is that
> > > > > > > > > > > > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
> > > > > > > > > > > > > since I always use O=, rm -rf) is needed for changes there to be picked
> > > > > > > > > > > > > up, but that's maybe just a missing Makefile dependency line. But that
> > > > > > > > > > > > > just makes it easier to see the next problem, which I don't see the
> > > > > > > > > > > > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
> > > > > > > > > > > > > For SPL however:
> > > > > > > > > > > > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > > > > > > > > > >   203 |         plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > > > > > > > > > > > >       |                      ^
> > > > > > > > > > > > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > > > > > > > > > > > >   205 |         plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
> > > > > > > > > > > > >       |                          ^
> > > > > > > > > > > > >
> > > > > > > > > > > > > And I don't see, really, what's even getting us down this error path.
> > > > > > > > > > > >
> > > > > > > > > > > > It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
> > > > > > > > > > > > across all phases.
> > > > > > > > > > > >
> > > > > > > > > > > > I pushed a new tree which builds without the warning. Note that
> > > > > > > > > > > > SPL_SPI is enabled.
> > > > > > > > > > >
> > > > > > > > > > > So, the "what" is FDT_64BIT wasn't correct. I think this is showing that
> > > > > > > > > > > scripts/conf_nospl is going to be a problem in and of itself, and likely
> > > > > > > > > > > as confusing if not more-so than any of the in-the-end visible changes.
> > > > > > > > > >
> > > > > > > > > > Yes, perhaps the key point I've been trying to get across is this confusion.
> > > > > > > > > >
> > > > > > > > > > As you know, at present we have two types of options:
> > > > > > > > > > a) those for which each phase has its own value
> > > > > > > > > > b) those for which there is a single value shared across all phases
> > > > > > > > >
> > > > > > > > > Agreed.
> > > > > > > > >
> > > > > > > > > > The only way today that you can tell them apart is by looking for uses
> > > > > > > > > > of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see them,
> > > > > > > > >
> > > > > > > > > Partially agreed. Those are strong indicators that both CONFIG_FOO and
> > > > > > > > > CONFIG_SPL_FOO exist, but not always. We have, intentionally, both the
> > > > > > > > > inverse case (CONFIG_SPL_BAR and CONFIG_TPL_BAR exist, CONFIG_BAR does
> > > > > > > > > not) and some future-proofing (CONFIG_SPL_BAZ may exist in the future,
> > > > > > > > > but not yet).
> > > > > > > >
> > > > > > > > OK
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > then the option is a) otherwise it is b). There is no way to tell from
> > > > > > > > > > Kconfig.
> > > > > > > > >
> > > > > > > > > Kconfig will happily allow "depends on BOGUS_SYMBOL" yes, and a linter
> > > > > > > > > would be a handy thing to have. But you're mentioning this in another
> > > > > > > > > context, why we need some additional knowledge somewhere.
> > > > > > > >
> > > > > > > > What I meant was that we don't have anything in the Kconfig for FOO
> > > > > > > > that says this is a global option or an xPL-specific one. We have to
> > > > > > > > hunt for SPL_FOO, etc.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Also, some parts of the code may use CONFIG_IS_ENABLED() for
> > > > > > > > > > an option, some may use IS_ENABLED() for that same option. Some may
> > > > > > > > > > use $(PHASE_) and some may not. It's a bit of a mess.
> > > > > > > > >
> > > > > > > > > I'm sure you can find some examples where we have CONFIG_IS_ENABLED(FOO)
> > > > > > > > > and IS_ENABLED(CONFIG_FOO) and it's not intentional, but that's not a
> > > > > > > > > big deal, and should be fixed.
> > > > > > > >
> > > > > > > > But this is largely the point of my series. It's the reason why
> > > > > > > > qconfig is able to locate these cases and warn about them. It is a big
> > > > > > > > deal, IMO, or at least big enough for me to attempt this.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > I'm only going to rant slightly that checkpatch.pl telling people to use
> > > > > > > > > these macros has made the situation worse, not better, out of an
> > > > > > > > > ingrained need to silence checkpatch.pl.
> > > > > > > > >
> > > > > > > > > And what you're missing is that sometimes we intentionally don't want
> > > > > > > > > $(PHASE_), or would need to rewrite the Makefile to make use of it.
> > > > > > > > > fs/Makefile is an example of this.
> > > > > > > >
> > > > > > > > The next step from my side would be to get rid of the 'ifdef
> > > > > > > > CONFIG_XPL_BUILD' in the Makefiles. It's confusing and annoying.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > Stepping back a bit, perhaps the goal of my series is to identify
> > > > > > > > > > options in b) so we can deal with them in a better way. They are all
> > > > > > > > > > listed in conf_nospl, in preparation for some future action.
> > > > > > > > >
> > > > > > > > > There are two big problems here. The first of which is that conf_nospl,
> > > > > > > > > as a concept, is going to be incomplete. Do you list every CMD in there?
> > > > > > > > > Why? They'll never be in a non-PPL phase. It will be its own nightmare
> > > > > > > > > to keep correct, once it is bug-compatible with what we have today.
> > > > > > > >
> > > > > > > > This is actually the *nice* thing about conf_nospl. We should reduce
> > > > > > > > it to empty, just like we did with the Kconfig whitelist.
> > > > > > > >
> > > > > > > > We have this rule:
> > > > > > > >
> > > > > > > > libs-$(CONFIG_CMDLINE) += cmd/
> > > > > > > >
> > > > > > > > which is enough for most things. The only issue is that sometimes,
> > > > > > > > e.g. with CONFIG_CMD_DHCP it doesn't mean the command at all.
> > > > > > > >
> > > > > > > > So I don't agree at all that my series is a 'big problem'. It is a
> > > > > > > > solution to the current confusion and it shows up what is broken and
> > > > > > > > needs to be fixed.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > The second big problem is that it doesn't make it any easier to solve
> > > > > > > > > what I keep calling the DWC3 problem. It's a valid use case that two
> > > > > > > > > developers have hit independently of wanting to enable USB gadget
> > > > > > > > > support (and the HW uses DWC3) in SPL and not PPL. Not only are you not
> > > > > > > > > solving this problem, it gets worse to solve. Today it's "OK, I need to
> > > > > > > > > find where to move obj-$(CONFIG_FOO) to be more visible and
> > > > > > > > > obj-$(CONFIG_$(PHASE_)FOO". Tomorrow it's "Why isn't obj-$(CONFIG_FOO)
> > > > > > > > > working here but not there?".
> > > > > > > >
> > > > > > > > Is that because some Makefile higher in the hierarchy is not building
> > > > > > > > that subdir? I don't know what this is about.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > To me, at absolute best case here, we're making a lot of changes and
> > > > > > > > > spending a lot of time to not really address the underlying problems,
> > > > > > > > > just making some questionable value visibility changes. We could reduce
> > > > > > > > > ourselves to one macro by saying only ever use CONFIG_IS_ENABLED(FOO)
> > > > > > > > > and IS_ENABLED(CONFIG_FOO) goes back to an ifdef for the case where it
> > > > > > > > > must only be tested on CONFIG_FOO.
> > > > > > > >
> > > > > > > > Or we could finish and apply my series, which does this.
> > > > > > > >
> > > > > > > > > I'm 80% sure we could simplify all of
> > > > > > > > > $(PHASE_)/$(XPL_)/$(SPL_) down to just $(PHASE_) and that eliminates the
> > > > > > > > > which to use of those question.
> > > > > > > >
> > > > > > > > Again, let's apply my series, which actually gets rid of PHASE_, SPL_
> > > > > > > > and XPL_ altogether.
> > > > > > > >
> > > > > > > > > And update / expand upon the existing
> > > > > > > > > documentation we have as it's not clear enough for everyone. Then we can
> > > > > > > > > think, again, about how to solve the problems that are introduced by
> > > > > > > > > building our entire source tree N times from a single configuration
> > > > > > > > > file. Or if we need to do something radical there.
> > > > > > > >
> > > > > > > > At this point I'm getting the feeling that you imagine my series is
> > > > > > > > some grand unified plan for Kconfig. It really isn't and this thread
> > > > > > > > is reminding me of why I originally wrote it. Bear in mind it was over
> > > > > > > > two years ago and I have mostly forgotten all the issues. It is a
> > > > > > > > clean-up series. It isn't the second coming but it isn't the
> > > > > > > > antichrist either.
> > > > > > >
> > > > > > > I worry you're going to spend another month of effort to get this to 1:1
> > > > > > > compatibility (modulo fixing bugs) with what we have today and get
> > > > > > > disappointed once it rolls out to -next. But I guess I've already spent
> > > > > > > too much time trying to convince you this is a bad idea and that your
> > > > > > > cure is worse than the disease.
> > > > > >
> > > > > > To me the core issue is whether to completely split the defconfig
> > > > > > files. I am quite worried about that. You are quite worried about the
> > > > > > confusion my series will cause.
> > > > > >
> > > > > > I think it is reasonable, if we go with my series, that I drive
> > > > > > conf_nospl down to zero lines (and remove the feature) before going
> > > > > > any further. Would that make you more comfortable? It would be a fair
> > > > > > bit of work, but could be done over a few releases.
> > > > >
> > > > > Here is my core concern. Can macros be tricky? Yes. Do we need a
> > > > > checkpatch.pl test for 'IS_ENABLED(FOO)' ? Yes. But the real problem is
> > > > > bugs like:
> > > > > - Take pinebook-pro-rk3399_defconfig
> > > > > - Enable all 3 of: CONFIG_SPL_USB_DWC3_GENERIC CONFIG_SPL_USB_GADGET
> > > > >   CONFIG_SPL_USB_SDP_SUPPORT
> > > > >
> > > > > Your proposal neither fixes that bug nor makes it easier to understand
> > > > > why that bug happens. And this is the category of build problems that we
> > > > > get that aren't "you missed using the right macro".
> > > >
> > > > Honestly, what on earth does this have to do with my series?
> > >
> > > It's that your series doesn't address the real problems we keep having.
> > >
> > > > The problem happens before and after my series, from what I can tell.
> > >
> > > Yes, I've said that numerous times.
> > >
> > > > If you want these sorts of combinations to be tested, perhaps add a
> > > > board that enables them, or even rethink your opposition to my
> > > > buildman proposal?[4]
> > >
> > > This isn't relevant to the point I've raised several times now. The
> > > failure mode above was reported by two different developers, neither of
> > > whom saw how to correctly solve the problem.
> >
> > That surprises me a little, as the problem seems pretty fundamental.
> > If you don't enable USB_GADGET, then symbols which depend on it don't
> > exist.
>
> But they don't want USB_GADGET in PPL. They only want it in SPL.

That seems to be splitting hairs, but OK. So why not make
USB_GADGET_MANUFACTURER depend on USB_GADGET || SPL_USB_GADGET ?

It wouldn't make sense to add SPL_USB_GADGET_MANUFACTURER as surely it
would be the same value? This is once good thing about what we have:
we can share values between phases without typing them in separately.

>
> > > And again, if you tried to solve this problem on your series you might
> > > see how what you're proposing will make things worse, not better.
> >
> > At least with my scheme you can do something like this:
> >
> > config SPL_USB_GADGET
> >    bool "USB Gadget Support in SPL"
> >    depends on USB_GADGET
>
> That symbol already exists. The problems are around all of the gadget
> symbols that don't exist.

OK. But we have to move in steps. We can't do everything at once.

>
> > I normally make the SPL symbols depend on PPL, since it normally
> > doesn't make a lot of sense to have the feature in SPL unless it is in
> > PPL. Is this an exception to that rule?
>
> This half of the problem (you're still missing the other half of the
> problem, the DWC3 code being built in TPL now and throwing
> warnings-turned-error with -Werror and then discarded at link time) is
> one of many examples where we keep having to duplicate symbols in
> Kconfig.

>
> > If we do go ahead and enhance Kconfig, then we can combine the two
> > symbols, which is something.
>
> Or, we go the direction I suggested instead. Where we never duplicate
> symbols, because we never need to anymore.
>
> Or, we step back because believe you're missing the bigger problems.

At this point I'm not sure where to go. You are determined to split
the defconfig files and have grace concerns about my schema. Vice
versa for me.

But my scheme takes us forward without needing to split the
defconfigs. It does offer some benefits IMO. Once we split the
defconfigs we can never put them back together.

Regards,
SImon
