Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A69C02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 23:52:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F11EC80B98;
	Sat, 15 Feb 2025 00:52:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ic3EBPr3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D25280C98; Sat, 15 Feb 2025 00:52:21 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F9B80756
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 00:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d9837f201aso7152713a12.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 15:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739577137; x=1740181937; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Pvds/6JMbwohMiPI/2zQMX0mBnxwl0L5svpIkimWyro=;
 b=Ic3EBPr3Pq50SdeVMzBkX8zwhXkxjfUfhmksueVBNAQqHBt3XjkAg8wmJe1RvO/2mO
 dpkk3+/0xwmH3C3h0njkZH1w+a29/wck/OBXsArgjZP/R7tAsRhB/VUUHvx5G2SGidQQ
 qQJjOpcludoQiZq3uspAnXLnEJbgxB14NwiGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739577137; x=1740181937;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pvds/6JMbwohMiPI/2zQMX0mBnxwl0L5svpIkimWyro=;
 b=Fl+OCuVBGGEsZrUQnyVNimEcBZkrR7rUDO+JV1xilhTqkEaK/ZsZuaJfLzw/uFq+8u
 VIFWsX/iix2d01BjJYB+QzbveemOgVhLS4NZQgSYYEFupAWafdQ+5uehtffnzJkX+YGf
 p1PvMTz/l58pFU0weDhmCV1pyEz9pkHyc2iEMHZ9F3o8gRrQlvLi3twM6S/GbkpRVu/d
 huukDziV7A4l8yo4TtbENCd+F7niCA3U/1SKGCVGaolXt6kynX+GQQ4QLUI+SiKCA3lb
 +F1fT2PzLcR85MT4UkNUZupMZNIHJyDSuMdT9Zf0uNWtQPI4iirIu1y90hfniGxMFKX6
 m7/g==
X-Gm-Message-State: AOJu0YwEJ8krejq1b/F/gm3JmkvvSvSJ4gqadPdn2CkUxw/9zbJD0wQ7
 3V6vsGVnESBiGSa+PWeUlmPqLmfkRqgYOytwVFERBOwkhx2D7C3ZFgddQgw7k+LATaztHCAk4RC
 BvNNENcGIpa2AEZPYUz8D45hDKTz65UesRORifjAjQt/srkiBPA==
X-Gm-Gg: ASbGncvxUwTT4sBmU8JD07/LC5Qe9QyoxYConhGyKF48xiJTzHaESY/OSZXahtxhH8W
 8Yi8qDpGhAK/jt7NortSsqhG8cMKeruBMVTYmqP8JV23EPAeRdiWVVngqc45haIsFaDiKRHha+A
 ==
X-Google-Smtp-Source: AGHT+IGA2LqNJb8Icxf9jgFLV+RXiu+8bctv1UGpyMgrNwICeZ1frESlHvgqJ6NBKEG2GCh0dFPK9h+5NxOFk7iwt6g=
X-Received: by 2002:a17:907:96ab:b0:ab7:bdcc:baf8 with SMTP id
 a640c23a62f3a-aba510de4e6mr757307466b.28.1739577136339; Fri, 14 Feb 2025
 15:52:16 -0800 (PST)
MIME-Version: 1.0
References: <20250212225829.GS1233568@bill-the-cat>
 <CAFLszThNpm9_GRVPALTc+r_b2sFa1h=ih_JuNB9BZv+t7Qj5cQ@mail.gmail.com>
 <20250213180352.GY1233568@bill-the-cat>
 <CAFLszTj5z9TF_a0Y6zEABmUvjVjEYgw31gGRMX3Y1anVJgEvnA@mail.gmail.com>
 <20250213225932.GC1233568@bill-the-cat>
 <CAFLszTia0RZXgVRMq=jfBc75bNFSO6N8m5MtuPLcs33DHbE3FQ@mail.gmail.com>
 <20250214143928.GG1233568@bill-the-cat>
 <CAFLszTg0yeOu13h1bxq2KiqVqwUQ-DdiJc+nhhknf5_JGygXgw@mail.gmail.com>
 <20250214211652.GI1233568@bill-the-cat>
 <CAFLszTi=abpaGi0CnnNoKYsT9M0H-9xrGaQtdLORvM8J7usX1Q@mail.gmail.com>
 <20250214234354.GJ1233568@bill-the-cat>
In-Reply-To: <20250214234354.GJ1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Feb 2025 16:52:04 -0700
X-Gm-Features: AWEUYZkGhEPUmn7g6iYtgn9_G2Ns8OY26DSPn9rHktRaWAzj0ny5GVL-Zhw4v28
Message-ID: <CAFLszTghcMz1mnu_jZOi9=TQpTgjyOQV-4sT=p=Q=dUBo3pQ_Q@mail.gmail.com>
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

On Fri, 14 Feb 2025 at 16:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 14, 2025 at 03:46:30PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 14 Feb 2025 at 14:16, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 14, 2025 at 12:48:33PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, Feb 14, 2025, 07:39 Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Thu, Feb 13, 2025 at 05:09:47PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, 13 Feb 2025 at 15:59, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Feb 13, 2025 at 02:57:59PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, Feb 13, 2025, 11:03 Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 13, 2025 at 05:50:13AM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Wed, 12 Feb 2025 at 15:58, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Feb 12, 2025 at 01:05:11PM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Wed, 12 Feb 2025 at 11:35, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Wed, Feb 12, 2025 at 10:41:45AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, 12 Feb 2025 at 09:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 03:54:21PM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > On Tue, 11 Feb 2025 at 14:22, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > On Tue, Feb 11, 2025 at 08:03:20AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > I just wanted to send a note to (re-)introduce my ideas[1] for the
> > > > > > > > > > > > > > > > > > next iteration of xPL.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > A recent series introduced 'xPL' as the name for the various
> > > > > > > > > > > > > > > > > > pre-U-Boot phases, so now CONFIG_XPL_BUILD means that this is any xPL
> > > > > > > > > > > > > > > > > > phase and CONFIG_SPL means this really is the SPL phase, not TPL. We
> > > > > > > > > > > > > > > > > > still use filenames and function naming which uses 'spl', but could
> > > > > > > > > > > > > > > > > > potentially adjust that.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > The major remaining problem IMO is that it is quite tricky and
> > > > > > > > > > > > > > > > > > expensive (in terms of time) to add a new phase. We also have some
> > > > > > > > > > > > > > > > > > medium-sized problems:
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > a. The $(PHASE_), $(SPL_) rules in the Makefile are visually ugly and
> > > > > > > > > > > > > > > > > > can be confusing, particularly when combined with ifdef and ifneq
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > b. We have both CONFIG_IS_ENABLED() and IS_ENABLED() and they mean
> > > > > > > > > > > > > > > > > > different things. For any given option, some code uses one and some
> > > > > > > > > > > > > > > > > > the other, depending on what problems people have met along the way.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > c. An option like CONFIG_FOO is ambiguous, in that it could mean that
> > > > > > > > > > > > > > > > > > the option is enabled in one or more xPL phases, or just in U-Boot
> > > > > > > > > > > > > > > > > > proper. The only way to know is to look for $(PHASE_) etc. in the
> > > > > > > > > > > > > > > > > > Makefiles and CONFIG_IS_ENABLED() in the code. This is very confusing
> > > > > > > > > > > > > > > > > > and has not scaled well.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > d. We need to retain an important feature: options from different
> > > > > > > > > > > > > > > > > > phases can depend on each other. As an example, we might want to
> > > > > > > > > > > > > > > > > > enable MMC in SPL by default, if MMC is enabled in U-Boot proper. We
> > > > > > > > > > > > > > > > > > may also want to share values between phases, such as TEXT_BASE. We
> > > > > > > > > > > > > > > > > > can do this easily today, just by adding Kconfig rules.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I agree with a through c and for d there are likely some cases even if
> > > > > > > > > > > > > > > > > I'm not sure TEXT_BASE is a good example. But I'm not sure it's as
> > > > > > > > > > > > > > > > > important as the other ones.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > OK. No, TEXT_BASE is not a great example in my book either. But it is
> > > > > > > > > > > > > > > > true that SPL needs to know U-Boot's text base.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Here's another:
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > config SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > >    default SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > >    default y if SPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > config TPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > > >    depends on TPL_SYS_MALLOC_F
> > > > > > > > > > > > > > > >    default SPL_SYS_MALLOC_F_LEN
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Alternatively:
> > > > > > > > > > > > > > > config SYS_MALLOC_LEN
> > > > > > > > > > > > > > >    ... current default X if Y
> > > > > > > > > > > > > > >    default 0x2800 if RCAR_GEN3 && !PPL
> > > > > > > > > > > > > > >    default 0x2000 if IMX8MQ && !PPL
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > PPL means (in my book) that we have a PPL, i.e. it is always true. It
> > > > > > > > > > > > >
> > > > > > > > > > > > > And in my proposal you're choosing between PPL, SPL, TPL, VPL.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > is the same today, with SPL. We have CONFIG_SPL_BUILD which indicates
> > > > > > > > > > > > > > which build it is. If you are suggesting that SPL means that this is
> > > > > > > > > > > > > > the SPL build, then which thing tells us whether or not we have an SPL
> > > > > > > > > > > > > > build? I'm just a bit confused by this.
> > > > > > > > > > > > >
> > > > > > > > > > > > > And we wouldn't have CONFIG_SPL_BUILD because we would either be
> > > > > > > > > > > > > configuring for SPL=y or SPL=n, there's no confusion anymore.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > But how can I make the TPL value of SYS_MALLOC_F_LEN the same as the
> > > > > > > > > > > > > > SPL one, with your scheme?
> > > > > > > > > > > > >
> > > > > > > > > > > > > If your question is "how do I set an arbitrary but consistent value in
> > > > > > > > > > > > > SPL and SPL" that's not enforced. But they also shouldn't be arbitrary
> > > > > > > > > > > > > and we should have sane defaults set in Kconfig, regardless of either
> > > > > > > > > > > > > proposal. While I'm trying to not get lost in the details today we have
> > > > > > > > > > > > > 80 matches on "git grep SPL_.*_LEN= configs/" and 2 for TPL and I would
> > > > > > > > > > > > > encourage someone to verify those are needed. My initial recollection is
> > > > > > > > > > > > > that most of these are from when we bumped SYS_MALLOC_F_LEN or so up to
> > > > > > > > > > > > > the commonly used default and had the few platforms that didn't use the
> > > > > > > > > > > > > new default previously switch to the old one.
> > > > > > > > > > > > >
> > > > > > > > > > > > > In other words, I don't think there's a problem here that isn't solved
> > > > > > > > > > > > > today, outside of either proposal.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > So I'm still not understanding how you handle Kconfig dependencies
> > > > > > > > > > > > > > between phases with your scheme. Are you saying you don't and they are
> > > > > > > > > > > > > > not important?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Basically. The majority of the cases of:
> > > > > > > > > > > > > config SPL_FOO
> > > > > > > > > > > > >    default y if FOO
> > > > > > > > > > > > >
> > > > > > > > > > > > > config TPL_FOO
> > > > > > > > > > > > >    default y if SPL_FOO
> > > > > > > > > > > > >
> > > > > > > > > > > > > Just go away because FOO is already default y or select/imply'd by
> > > > > > > > > > > > > TARGET_BAR or ARCH_BAZ.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > Also, is there a single Kconfig tree for U-Boot, or are you saying you
> > > > > > > > > > > > > > want a different set of Kconfig files for each phase?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Just the Kconfig files we have today. Likely with less overall lines
> > > > > > > > > > > > > since for example we could drop:
> > > > > > > > > > > > > config SPL_FS_EXT4
> > > > > > > > > > > > >         bool "Support EXT filesystems"
> > > > > > > > > > > > >         select SPL_CRC16 if EXT4_WRITE
> > > > > > > > > > > > >
> > > > > > > > > > > > > Since we already have fs/ext4/Kconfig.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > Proposal
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > 1. Adjust kconf to generate separate autoconf.h files for each phase.
> > > > > > > > > > > > > > > > > > These contain the values for each Kconfig option for that phase. For
> > > > > > > > > > > > > > > > > > example CONFIG_TEXT_BASE in autoconf_spl.h is SPL's text base.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > 2. Add a file to resolve the ambiguity in (c) above, listing the
> > > > > > > > > > > > > > > > > > Kconfig options which should not be enabled/valid in any xPL build.
> > > > > > > > > > > > > > > > > > There are around 200 of these.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > 3. Introduce CONFIG_PPL as a new prefix, meaning U-Boot proper (only),
> > > > > > > > > > > > > > > > > > useful in rare cases. This indicates that the option applies only to
> > > > > > > > > > > > > > > > > > U-Boot proper and is not defined in any xPL build. It is analogous to
> > > > > > > > > > > > > > > > > > CONFIG_TPL_xxx meaning 'enabled in TPL'. Only a dozen of these are
> > > > > > > > > > > > > > > > > > needed at present, basically to allow access to the value for another
> > > > > > > > > > > > > > > > > > phase, e.g. SPL wanting to find CONFIG_PPL_TEXT_BASE so that it knows
> > > > > > > > > > > > > > > > > > the address to which U-Boot should be loaded.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > 4. There is no change to the existing defconfig files, or 'make
> > > > > > > > > > > > > > > > > > menuconfig', which works just as today, including dependencies between
> > > > > > > > > > > > > > > > > > options across all phases.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > 5. (next) Expand the Kconfig language[2] to support declaring phases
> > > > > > > > > > > > > > > > > > (SPL, TPL, etc.) and remove the need for duplicating options (DM_MMC,
> > > > > > > > > > > > > > > > > > SPL_DM_MMC, TPL_DM_MMC, VPL_DM_MMC), so allowing an option to be
> > > > > > > > > > > > > > > > > > declared once for any/all phases. We can then drop the file in 2
> > > > > > > > > > > > > > > > > > above.
> > > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > > With this, maintaining Kconfig options, Makefiles and adding a new
> > > > > > > > > > > > > > > > > > phase should be considerably easier.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I think this will not make our life easier, it will make things harder.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > I think what we've reached now shows that Yamada-san was correct at the
> > > > > > > > > > > > > > > > > time in saying that we were going down the wrong path with how we
> > > > > > > > > > > > > > > > > handled SPL/TPL.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > You've mentioned this quite a few times over the years. Is there a
> > > > > > > > > > > > > > > > reference to what he suggested we should do? Or perhaps it is what you
> > > > > > > > > > > > > > > > have below.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > I don't recall what he proposed instead, just that when it became clear
> > > > > > > > > > > > > > > that I wanted to move from the "S:CONFIG_FOO.." syntax for how SPL was
> > > > > > > > > > > > > > > handled to how we're doing it today, he thought that was the wrong
> > > > > > > > > > > > > > > direction.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes, IMO he was right about that.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > My request instead is:
> > > > > > > > > > > > > > > > > - Largely drop SPL/TPL/VPL (so no DM_MMC and SPL_DM_MMC and so on, just
> > > > > > > > > > > > > > > > >   DM_MMC) as a prefix.
> > > > > > > > > > > > > > > > > - Likely need to introduce a PPL symbol as you suggest.
> > > > > > > > > > > > > > > > > - Make PPL/SPL/TPL/VPL be a choice statement when building a defconfig.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Good idea.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > - Split something like rockpro64-rk3399_defconfig in to
> > > > > > > > > > > > > > > > >   rockpro64-rk3399_ppl_defconfig
> > > > > > > > > > > > > > > > >   rockpro64-rk3399_spl_defconfig rockpro64-rk3399_tpl_defconfig
> > > > > > > > > > > > > > > > >   and add Makefile logic such that for X_defconfig as a build target but
> > > > > > > > > > > > > > > > >   not configs/X_defconfig not existing, we see if any of
> > > > > > > > > > > > > > > > >   configs/X_{ppl,spl,tpl,vpl}_defconfig exist and we run a builds in
> > > > > > > > > > > > > > > > >   subdirectories of our object directory, and then using binman combine
> > > > > > > > > > > > > > > > >   as needed.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > This means splitting the existing file into a separate one for each
> > > > > > > > > > > > > > > > phase. I believe that will be hard to manage.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Do you mean initially, or long term? Initially, it should be a bit of
> > > > > > > > > > > > > > > shell scripting. The consolidation (ie most/all rk3399 having an
> > > > > > > > > > > > > > > identical _spl_defconfig) can't be automated. Long term I'm not sure it
> > > > > > > > > > > > > > > would be any different. Most of the maintenance is on resync'ing which
> > > > > > > > > > > > > > > is automated.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Long term. How does 'make menuconfig' work in this case? Won't you
> > > > > > > > > > > > > > have to run it three times for SPL, TPL and PPL?
> > > > > > > > > > > > >
> > > > > > > > > > > > > Yes, you would run configure for what you're building. This is a good
> > > > > > > > > > > > > thing as it will no longer be so confusing to hunt down where SPL or TPL
> > > > > > > > > > > > > or VPL options for a specific thing reside.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > >   - Maybe instead the Makefile logic above we would parse X_defconfig
> > > > > > > > > > > > > > > > >     and see if it's a different format of say PHASE:file to make it
> > > > > > > > > > > > > > > > >     easier to say share a single TPL config with all rk3399, have a few
> > > > > > > > > > > > > > > > >     common SPL configs and then just a board specific PPL.
> > > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > > This solves (a) by removing them entirely. This solves (b) by removing
> > > > > > > > > > > > > > > > > the ambiguity entirely (it will be enabled or not). As a bonus for (b)
> > > > > > > > > > > > > > > > > we can switch everyone to IS_ENABLED(CONFIG_FOO) and match up with the
> > > > > > > > > > > > > > > > > Linux Kernel again. This solves (c) again by removing it entirely.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The scheme I propose removes a-c also. I should have made that clear.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Er, ok. That's not how it looked before, but I guess I'm just mistaken.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Yes I think so...it was a major goal to remove this stuff. [1] [2]
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thanks.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > > > There is not a huge difference between your scheme and mine. My
> > > > > > > > > > > > > > > > question is, how do you handle (d)?
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Well, either (d) isn't important as for example MMC wasn't a good choice
> > > > > > > > > > > > > > > in your proposal as virtually everyone "select MMC" today or it's
> > > > > > > > > > > > > > > handled more easily as my example above in SYS_MALLOC_LEN.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > The way I see it, both schemes remove the ambiguity. Mine retains a
> > > > > > > > > > > > > > > > single deconfig file and a single 'make menuconfig' for each board.
> > > > > > > > > > > > > > > > Yours feels more like building independent U-Boot images.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > It is explicitly building independent U-Boot images, yes. With a wrapper
> > > > > > > > > > > > > > > around "make all of the images for a given platform". So much of our
> > > > > > > > > > > > > > > confusing and messy code is because we aren't doing that. And since most
> > > > > > > > > > > > > > > modern SoCs can work as (mostly )generic SPL selects correct DTB for PPL
> > > > > > > > > > > > > > > we really could have fewer overall build configurations.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I'd really like to see a generic aarch64 U-Boot for PPL, although it
> > > > > > > > > > > > > > would be quite large with all the drivers. Perhaps we could start by
> > > > > > > > > > > > > > having a generic Rockchip one, for example.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Still I don't see this being strongly related to the discussion about
> > > > > > > > > > > > > > these two different schemes.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Well, in your scheme how do we have say generic-aarch64_defconfig
> > > > > > > > > > > > > function on either chromebook_bob or am62x_beagleplay_a53 ? In mine,
> > > > > > > > > > > > > since everything is a separate build, generic-aarch64_defconfig has
> > > > > > > > > > > > > PPL=y, ARCH_K3=y and ROCKCHIP_RK3399=y. And then
> > > > > > > > > > > > > chromebook_bob_defconfig would say to use chromebook_bob_tpl_defconfig,
> > > > > > > > > > > > > generic-rk3399_spl_defconfig and generic-aarch64_defconfig. As a bonus
> > > > > > > > > > > > > instead of am62x_beagleplay_a53_defconfig and
> > > > > > > > > > > > > am62x_beagleplay_r5_defconfig we would have am62x_beagleplay_defconfig
> > > > > > > > > > > > > that would say to use the appropriate SPL/PPL for R5, and appropriate
> > > > > > > > > > > > > SPL/PPL for A53.
> > > > > > > > > > > > >
> > > > > > > > > > > > > But the one big huge caveat I want to make here is that "generic" images
> > > > > > > > > > > > > are useful in some use cases (I'm sure all of the regular F/OSS
> > > > > > > > > > > > > distributions would love a single actually common PPL if they can fit
> > > > > > > > > > > > > it) will strip things down. Whatever the IoT edge device closest to you
> > > > > > > > > > > > > now really won't want to ship with all the platforms enabled. Image size
> > > > > > > > > > > > > still matters.
> > > > > > > > > > > >
> > > > > > > > > > > > OK thanks for the details. I think I have a reasonable idea of what
> > > > > > > > > > > > you are proposing, now. It would work, but is quite radical, IMO.
> > > > > > > > > > > > That's not necessarily a bad thing, but in my mind I see a sequencing
> > > > > > > > > > > > possibility.
> > > > > > > > > > > >
> > > > > > > > > > > > A few points from my side:
> > > > > > > > > > > >
> > > > > > > > > > > > 1. I would love to see the defconfig files reduce in size, with more
> > > > > > > > > > > > and better defaults. One way to do this would be to enforce a maximum
> > > > > > > > > > > > length. I added a feature to qconfig to allow finding common options
> > > > > > > > > > > > among boards (the -i flag), but I'm not sure if many people use it.
> > > > > > > > > > >
> > > > > > > > > > > I don't see reducing defconfig size as important honestly. Should we
> > > > > > > > > > > have more and better defaults? Yes. But almost everything is under 200
> > > > > > > > > > > lines with the biggest (non-sandbox) ones being the generic zynqmp
> > > > > > > > > > > platform(s?).
> > > > > > > > > >
> > > > > > > > > > Agreed.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > 2. Generic boards is something I have been pushing for years (in fact
> > > > > > > > > > > > it is why I originally introduced devicetree), but I'm not seeing a
> > > > > > > > > > > > lot of traction.
> > > > > > > > > > >
> > > > > > > > > > > I don't think generic boards are universally helpful. Even if what I'm
> > > > > > > > > > > proposing would allow for more of it, below the PPL stage I'm not sure
> > > > > > > > > > > it's both feasible enough and useful enough for production. At the PPL
> > > > > > > > > > > stage it still has to be small enough and not overly burdensome. What we
> > > > > > > > > > > talked about on the call yesterday about using more multi-dtb images is
> > > > > > > > > > > a step in the right direction, yes.
> > > > > > > > > >
> > > > > > > > > > Agreed. Anway, we can create separate targets for generic boards if we want to.
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > 3. Iit seems that you want to remove all the 'if SPL' pieces and just
> > > > > > > > > > > > rely on the current PPL configuration. But how will that work? There
> > > > > > > > > > > > are tons of features which don't work in SPL, or are not relevant, or
> > > > > > > > > > > > have special 'small' versions. That is a *lot* of Kconfig refactoring
> > > > > > > > > > > > just to get something working, isn't it? With my scheme there is no
> > > > > > > > > > > > Kconfig change needed initially - it can be done later as needed /
> > > > > > > > > > > > desirable.
> > > > > > > > > > >
> > > > > > > > > > > I don't think we would remove most "if SPL" cases. Taking part of the
> > > > > > > > > > > current stanza for ROCKCHIP_RK3399 as an example:
> > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > >         select ARM64
> > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > >         select SPL
> > > > > > > > > > >         select SPL_ATF
> > > > > > > > > > >         select SPL_BOARD_INIT if SPL
> > > > > > > > > > >         ...
> > > > > > > > > > >         select SPL_CLK if SPL
> > > > > > > > > > >         ...
> > > > > > > > > > >         select CLK
> > > > > > > > > > >         ...
> > > > > > > > > > >         imply TPL_CLK
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > This would become:
> > > > > > > > > > > config ROCKCHIP_RK3399
> > > > > > > > > > >         bool "Support Rockchip RK3399"
> > > > > > > > > > >         select ARM64
> > > > > > > > > > >         select SUPPORT_SPL
> > > > > > > > > > >         select SUPPORT_TPL
> > > > > > > > > > >         select SPL_ATF if SPL # TBD: Does 'ATF' make sense outside of SPL?
> > > > > > > > > > >         select BOARD_INIT if SPL # Not TPL_BOARD_INIT here
> > > > > > > > > > >         select CLK # imply was likely wrong before? Would need to check
> > > > > > > > > > >         ...
> > > > > > > > > >
> > > > > > > > > > I was more talking about the large blocks of 'if SPL' - e.g. we have
> > > > > > > > > > common/spl/Kconfig and common/spl/Kconfig.tpl
> > > > > > > > >
> > > > > > > > > I would vastly reduce the contents within those 'if' blocks, but there
> > > > > > > > > are still options that are xPL-centric without a PPL counterpart, such
> > > > > > > > > as SPL_ATF (I suspect, but if not I'm sure others).
> > > > > > > > >
> > > > > > > > > > But just the level of thought required in your small example above
> > > > > > > > > > suggests it is a large effort.
> > > > > > > > >
> > > > > > > > > Yes, restructuring our Kconfig logic and then removing our xPL logic is
> > > > > > > > > some work. So was, I suspect, all of what you did already.
> > > > > > > > >
> > > > > > > > > > > > 4. My scheme splits the config into separate files. Yours makes the
> > > > > > > > > > >
> > > > > > > > > > > I don't see yours as splitting the configs in to separate files, I see
> > > > > > > > > > > it as generating some intermediate objects. The configs don't change and
> > > > > > > > > > > that's one of our problem areas.
> > > > > > > > > >
> > > > > > > > > > So you mean a big problem area is the current Kconfig?
> > > > > > > > >
> > > > > > > > > I mean it's a problem for users a board developers to make valid
> > > > > > > > > configurations and update them as needed. Filesystems are in the
> > > > > > > > > filesystem menu, unless they're SPL and then it's all under the big SPL
> > > > > > > > > menu.
> > > > > > > > >
> > > > > > > > > > Mind generates
> > > > > > > > > > out to an include/generated/autoconf_xxx for each phase. Yes they are
> > > > > > > > > > intermediate files and auto-generated, but each 100% controls its
> > > > > > > > > > phase, so there is no confusion and CONFIG_IS_ENABLED() / odd Makefile
> > > > > > > > > > rules anymore.
> > > > > > > > >
> > > > > > > > > Yes, removing CONFIG_IS_ENABLED and $(PHASE_)/$(XPL_) from Makefiles is
> > > > > > > > > good. But the intermediate files aren't going to help (nor hurt) any of
> > > > > > > > > the problems themselves. If you're reading those to figure out a
> > > > > > > > > problem, it's like when you're reading a .i file to figure out a
> > > > > > > > > problem, it means you're already in a complex troublesome spot.
> > > > > > > > >
> > > > > > > > > But I don't know that CONFIG_SPL_FS_FAT=y means that CONFIG_FS_FAT=y for
> > > > > > > > > SPL builds leads to "no confusion". But I do think that CONFIG_SPL=y and
> > > > > > > > > CONFIG_FS_FAT=y does.
> > > > > > > > >
> > > > > > > > > > > > split earlier, at the Kconfig level. So it seems that we could go with
> > > > > > > > > > > > my scheme to get us to a split config, then, after that, decide
> > > > > > > > > > > > whether to move that split earlier to Kconfig itself. The choices
> > > > > > > > > > >
> > > > > > > > > > > I don't think so. Yours makes things complicated by making the build do
> > > > > > > > > > > even more (and from the RFC, the implementation tooling diverges from
> > > > > > > > > > > upstream).
> > > > > > > > > >
> > > > > > > > > > Yes it makes the kconf tool generate those separate files for each phase [3]
> > > > > > > > > >
> > > > > > > > > > > Mine makes things differently complicated by doing less for
> > > > > > > > > > > most things, but needing some thought on how to know that say
> > > > > > > > > > > chromebook_bob needs chromebook_bob_tpl_defconfig,
> > > > > > > > > > > chromebook_bob_spl_defconfig and chromebook_bob_ppl_defconfig to be
> > > > > > > > > > > built, before asking binman to go put things together.
> > > > > > > > > >
> > > > > > > > > > Yours seems feasible in a fully Binman world, but given the difficulty
> > > > > > > > > > we (or I) have completing a migration, I honestly don't believe this
> > > > > > > > > > is feasible in today's U-Boot. The other problem is that it all has to
> > > > > > > > >
> > > > > > > > > I'm not 100% sure it's everything needs binman actually. Or even if we
> > > > > > > > > do take this as a reason to push for more binman, it's just some trivial
> > > > > > > > > types already handled in the Makefile that's missing.
> > > > > > > > >
> > > > > > > > > > be done at once. We need to rewrite the Kconfig and flip over the
> > > > > > > > > > board. Will we carry people with us? That is a huge risk to the
> > > > > > > > > > project IMO.
> > > > > > > > >
> > > > > > > > > I'm not sure, actually, that it couldn't be done in stages. We might
> > > > > > > > > need a little bit of fakery around being able to just build SPL without
> > > > > > > > > PPL in the interim.
> > > > > > > > >
> > > > > > > > > > Anyway, yes my schema makes the build do even more (with 400 lines of
> > > > > > > > > > kconf additions and a patch that can likely be upstreamed). But
> > > > > > > > > > otherwise, it is a one-off improvement, without any changes to the
> > > > > > > > > > existing Kconfig.
> > > > > > > > >
> > > > > > > > > I thought Yamada-san rejected changes going in this direction before?
> > > > > > > > > But either way, no it's not likely the final overburden in terms of
> > > > > > > > > divergence.
> > > > > > > >
> > > > > > > >
> > > > > > > > Yes. Masahiro will make his own decisions and I am confident he will
> > > > > > > > reject any future changes I send
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > So my point is that we could go with the first part of my scheme to
> > > > > > > > > > resolve the 'medium' problems then decide which way to continue after
> > > > > > > > > > that. From your side you won't have lost anything towards where you
> > > > > > > > > > want to head. The two options would then be:
> > > > > > > > > >
> > > > > > > > > > - exhance kconfig language to build in the notion of phases
> > > > > > > > > > - split the defconfigs for each board, redo the Kconfig rules and
> > > > > > > > > > teach the build to combine images
> > > > > > > > >
> > > > > > > > > If things go down your proposed path instead, no, I don't see that as
> > > > > > > > > making it meaningfully easier to go the way I proposed later. The only
> > > > > > > > > commonality is dropping $(PHASE_)/$(XPL_)/etc and CONFIG_IS_ENABLED ->
> > > > > > > > > IS_ENABLED. And (almost) all of that is a script'able change.
> > > > > > > >
> > > > > > > > To be frank, the difference is that I have actually put in the work to
> > > > > > > > try this. It is more than 50 and perhaps as many as 100 patches. Quite
> > > > > > > > difficult work. Honestly, compared to that, the logic changes are not
> > > > > > > > that large.
> > > > > > > >
> > > > > > > > That is why I believe this work is a prerequisite for both schemes
> > > > > > > >
> > > > > > > > >
> > > > > > > > > > > > would then be to use your scheme (Kconfig refactoring, splitting
> > > > > > > > > > > > defconfigs and some rework), or to do my scheme (which would require
> > > > > > > > > > > > enhancing the Kconfig language a bit just for U-Boot and some optional
> > > > > > > > > > > > rework over time). Both schemes would need a small amount of
> > > > > > > > > > > > build-logic changes, but I'm not sure yet what that would look like.
> > > > > > > > > > > >
> > > > > > > > > > > > Does that sound right?
> > > > > > > > > > >
> > > > > > > > > > > With what I said above, yes I think we're closer at least to
> > > > > > > > > > > understanding each other.
> > > > > > > > > >
> > > > > > > > > > Yes.
> > > > > > > > >
> > > > > > > > > Well, with that, what now?
> > > > > > > > >
> > > > > > > > > What makes the current situation untenable is VPL. And I gather I
> > > > > > > > > haven't convinced you to put that on hold long enough to instead rework
> > > > > > > > > how we build things, have I?
> > > > > > > >
> > > > > > > > Which VPL thing?
> > > > > > >
> > > > > > > That it exists. When it was just SPL, it's manageable. With TPL, well,
> > > > > > > it was supposed to be tiny and so just a few more things. And with VPL,
> > > > > > > that makes 4. It's too much. Something needs to be done. Four times is
> > > > > > > too many. If solving Marek's desire for PSCI-from-U-Boot means we need
> > > > > > > number 5 that becomes even worse (and I also suspect that's a case of
> > > > > > > one build covers the SoC or family of SoCs depending on hardware
> > > > > > > changes).
> > > > > >
> > > > > > Yes, that's why I took on this effort a few years back.
> > > > > >
> > > > > > >
> > > > > > > > You have convinced me that you have a solution. It makes a lot more
> > > > > > > > sense to me than previously and it may be that it is better in the
> > > > > > > > end. For example, with VBE it I would make a lot of sense to build 20
> > > > > > > > boards as just TPL and use a generic rock chip board for everything
> > > > > > > > else. That would be a lot tidier with your scheme. It is very hard to
> > > > > > > > predict the future and VBE is still not finished, some two years in.
> > > > > > > >
> > > > > > > > I don't want to be tied to your scheme today though.
> > > > > > > >
> > > > > > > > So if you can accept my going ahead with 1-4 and helping me with that,
> > > > > > > > then we can stop and discuss which way to go, perhaps by prototyping
> > > > > > > > the two options?
> > > > > > >
> > > > > > > I want to start by saying I do appreciate you put in a lot of work in
> > > > > > > this direction already, and I do see some of the end goals it achieves
> > > > > > > as being important, and I'm glad you see my idea has some good parts
> > > > > > > too.
> > > > > > >
> > > > > > > I want to figure out how to move forward on this problem. My other part
> > > > > > > of this thread, this morning, was also part of me looking harder, again,
> > > > > > > at the RFC series you posted before. And that's where I still have large
> > > > > > > reservations. There are *so* *many* symbols we need to now have 4
> > > > > > > variants of, instead of 1 variant of. Take:
> > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1134219-58-sjg@chromium.org/
> > > > > > > for example. It adds SPL_PARTITION_TYPE_GUID but we include <part.h> in
> > > > > > > files built in TPL (and likely VPL) so aren't we going to need that
> > > > > > > every time? And with a quick size-check on pinebook-pro-rk3399 it looks
> > > > > > > like it's not working as intended either? I checked and part_get_info
> > > > > > > shrinks because CONFIG_PARTITION_TYPE_GUID is not set, or rather:
> > > > > > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > > > > >                 info->type_guid[0] = 0;
> > > > > > > #endif
> > > > >
> > > > > Oh, I get it now. Previously CONFIG_PARTITION_TYPE_GUID=y but now
> > > > > CONFIG_SPL_PARTITION_TYPE_GUID=n and while I'm not sure that's a good
> > > > > thing I see what happened. And now I see my problem from yesterday
> > > > > morning was similar but different.
> > > > >
> > > > > > > is not true and checked. And I can't see why. And there's other size
> > > > > > > reductions (this time in tpl) on pinebook-pro-rk3399 that I didn't dig
> > > > > > > in to more, but wasn't that symbol:
> > > > > > >                tpl-u-boot-tpl: add: 0/-4, grow: 0/0 bytes: 0/-344 (-344)
> > > > > > >                  function                                   old     new   delta
> > > > > > >                  dev_get_uclass_plat                         12       -     -12
> > > > > > >                  simple_bus_post_bind                        92       -     -92
> > > > > > >                  _u_boot_list_2_uclass_driver_2_simple_bus     120       -    -120
> > > > > > >                  _u_boot_list_2_driver_2_simple_bus         120       -    -120
> > > > > > >
> > > > > > > And I'm not bringing this up to badger you about bugs in an RFC series
> > > > > > > (it's RFC, there's bugs) but rather because I think it highlights some
> > > > > > > core issues with the approach as implemented.
> > > > > >
> > > > > > But surely you can see that both schemes have exactly the same issues?
> > > > > >
> > > > > > My point is that the work to tidy up things and then get to a 'clean'
> > > > > > source tree and Makefiles is the hard bit here and has to be done with
> > > > > > both schemes.
> > > > > >
> > > > > > Just let me know which way you want to go. I don't have anything ready
> > > > > > to send, but I could probably drag it over the line before too long,
> > > > > > if you are keen.
> > > > >
> > > > > Once I figured out what was the cause of the problems I saw in the RFC,
> > > > > I had to rewrite this a few times. Your approach needs even more symbols
> > > > > added than were in the RFC, and the newly added symbols need further
> > > > > auditing to make sure we have the same behavior as today at least by
> > > > > default.
> > > >
> > > > This is the idea that we need to clean up a, b and c. Your scheme is
> > > > the same in this respect. If we have CONFIG_FOO today, then your
> > > > scheme may need that duplicated to each defconfig file. Either you
> > > > resolve the ambiguity or don't. But if you do, then you have to add
> > > > symbols, with both schemes.
> > >
> > > There is minimal pain in saying a defconfig needs to list CONFIG_FOO
> > > there is pain in saying that we need to list
> > > config PARTITION_TYPE_GUID
> > > ...
> > > config SPL_PARTITION_TYPE_GUID
> > > ...
> > > config TPL_PARTITION_TYPE_GUID
> > > ...
> > > config VPL_PARTITION_TYPE_GUID
> > > ...
> > >
> > > In what I'm saying it's not generally an issue because:
> > > $ git grep -l PARTITION_TYPE_GUID configs | wc -l
> > > 21
> > >
> > > And we don't have to do additional upkeep on having N symbols.
> >
> > Well we only need to add those extra symbols if 1) we want that
> > feature in a particular xPL, *and* 2) we don't want it everywhere.
>
> Yes, and the problem is adding more of them. Again, we would need to
> duplicate drivers/usb/gadget/Kconfig with your scheme.
>
> > There is nothing in my scheme which requires us to add options that
> > don't currently exist...but there is a problem if some code uses
> > CONFIG_IS_ENABLED(FOO) today and some code uses IS_ENABLED(FOO). My
>
> That's good because that wasn't (how it seemed?) previously.
>
> > conf_nospl file helps with that and avoids changing Kconfig. But
> > again, if we are using both, then who knows what it means today, and
> > I'd like to clean it up.
>
> What we have today, with respect to CONFIG_IS_ENABLED(...) /
> IS_ENABLED(...) is clearer than IS_ENABLED(CONFIG_FOO) that is really
> checking for CONFIG_SPL_FOO or CONFIG_VPL_FOO if it's in SPL or VPL.
> It's easy to get *wrong* yes, but it's also clear. You're checking for
> what it says.
>
> > > > > On the one hand, this is at least a well defined technical
> > > > > problem and if you do the language extension *first* the code changes
> > > > > aren't so bad.
> > > >
> > > > There are no significant Kconfig changes in my scheme, other than the
> > > > conf_nospl file. The language extension is quite separate.
> > >
> > > $ git diff pre-RFC-migrate-to-split-config..RFC-migrate-to-split-config
> > > \
> > >         | filterdiff -i "a/*/Kconfig" | diffstat -p1 | tail -n 1
> > >  25 files changed, 316 insertions(+), 3 deletions(-)
> > >
> > > And that is largely duplication of existing symbols. And again, it
> > > wasn't enough duplication.
> >
> > I wonder if that is stuff that was already applied? Here is what I have today.
> >
> > $ glo ci/master..splg4  | filterdiff -i "a/*/Kconfig" | diffstat -p1 | tail -n 1
> >  0 files changed
> >
> > You can use the u-boot-dm/splg-working tree to see the original
> > version. From memory, the splc tree is very old and was mostly applied
> > or dropped.
>
> The splc-working tree is the RFC you pointed at earlier and so yes, what
> I was comparing with. If you were able to drop some of the problems,
> that's good.
>
> > > > > But for the user running menuconfig / etc? That's not
> > > > > going to be pretty. And we still won't have fixed the problems like "why
> > > > > is TPL even trying to build DWC3?" without reworking more symbols.
> > > > >
> > > > > So I don't think this is the right approach as it doesn't reduce
> > > > > confusion and may increase it (why do I need to set
> > > > > CONFIG_SPL_PARTITION_TYPE_GUID when the code checks for
> > > > > CONFIG_PARTITION_TYPE_GUID?
> > > >
> > > > Because it is an SPL build...I actually think that makes a lot of
> > > > sense. You just need to understand that CONFIG_SPL_ means the SPL
> > > > build, which in fact is what we have been using for years.
> > >
> > > And it's no longer clear in the code, is the problem.
> > >
> > > >
> > > > > But why is CONFIG_SPL_FRAMEWORK still there?
> > > >
> > > > Not relevant to the discussion, IMO.
> > >
> > > It's an example symbol. Why does the code have:
> > >
> > > #ifdef CONFIG_PARTITION_TYPE_GUID
> > > ...
> > > #endif
> > >
> > > And that's true for SPL builds. But the code also still has:
> > > #ifdef CONFIG_SPL_FRAMEWORK
> > > ...
> > > #endif
> > >
> > > Which is only true for CONFIG_SPL_FRAMEWORK being set.
> >
> > OK I think I understand your question. The tools work by identifying
> > options which are in PPL and may or not be in other builds. There is
> > no CONFIG_FRAMEWORK so all of this migration doesn't apply.
>
> No, you entirely misunderstand me. I am not talking about the tool. I am
> talking about the developer.
>
> > If there were a CONFIG_IS_ENABLED(FRAMEWORK) or a CONFIG_FRAMEWORK
> > then the discussion would be different.
> >
> > BTW, I wonder if we could drop that symbol, or switch it around so
> > that boards which don't use it have to set CONFIG_SPL_STRANGE or
> > similar.
>
> Touching the PowerPC TPL/SPL stuff is very low on the priority list. If
> you want to file an issue for it, please do. But that (roughly) is why
> there's SPL_FRAMEWORK.
>
> > > > > Oh..). The main thing it does is drop $(PHASE_) and I honestly think
> > > > > that's more confusing. We still have one build where we need to do or
> > > > > not do different things for FOO && PPL, FOO && SPL, etc but the code
> > > > > just references CONFIG_FOO but doesn't always mean CONFIG_FOO=y/n in the
> > > > > .config / defconfig.
> > > >
> > > > Yes, that's the conf_nospl file which I have dealt with.
> > >
> > > OK? My point is that the code is now more confusing, not less confusing.
> > > Because the code says CONFIG_PARTITION_TYPE_GUID. Not
> > > CONFIG_SPL_PARTITION_TYPE_GUID. And not IS_ENABLED(PARTITION_TYPE_GUID)
> > > which is at least a hint that one needs to look harder, and oh,
> > > CONFIG_SPL_PARTITION_TYPE_GUID maybe matches somehow.
> >
> > If you are saying that it is better to have CONFIG_IS_ENABLED(FOO),
> > IS_ENABLED(CONFIG_FOO), obj-$(CONFIG_$(PHASE_)FOO) etc., then I don't
> > agree, sorry. That is problems a-c in my original proposal and my
> > understanding is that both our approaches resolve this problem.
> >
> > Otherwise, you've just lost me and we should probably give up on this point.
>
> Yes, I am saying that what we have today is less confusing than what you
> are proposing. Because with your proposal:
>
> obj-$(CONFIG_FS_FAT) += fat/
>
> Can refer to CONFIG_SPL_FS_FAT, CONFIG_FS_FAT or CONFIG_VPL_FS_FAT. That
> is not good for humans.

Let's just stop on this point. We seem to be going backwards. Now you
are saying that you *want* to keep:

a. The $(PHASE_) stuff in Makefiles
b. The CONFIG_xxx / CONFIG_IS_ENABLED(xxx) split

and you believe that

c. the ambiguity I mentioned with CONFIG_FOO

are all actually a good thing?

Your first response was "I agree with a through c and for d there are
likely some cases even if I'm not sure TEXT_BASE is a good example"
which I took to mean that you saw these as problems just like I do.

But if you believe we are better off with a-c as they are today, then
none of my work has any relevance to what you are looking for.

>
> > > > > I really think we need to literally split the config files up such that
> > > > > for the most part we do (in psuedo code):
> > > > > %_full_config:
> > > > >   make -C $(srctree) O=$(obj)/ppl %_ppl_defconfig
> > > > >   make -C $(srctree) O=$(obj)/spl %_spl_defconfig
> > > > >   ...
> > > > >
> > > > > all:
> > > > >   [ -d $(obj)/ppl ] && make -C $(srctree) O=$(obj)/ppl all
> > > > >   [ -d $(obj)/spl ] && make -C $(srctree) O=$(obj)/spl all
> > > > >   ...
> > > > >
> > > >
> > > > Perhaps you should take a look at this and come up with an RFC series
> > > > for your scheme? I think that would help us gain a better shared
> > > > understanding of the problem.
> > > >
> > > > Failing that, I am willing and able to do another version of my
> > > > scheme, if it suits.
> > >
> > > And how about instead you come up with an RFC of what I suggested, in
> > > order to further your VPL proposal?
> >
> > That's unlikely, for two reasons:
> >
> > i. We can start with my scheme, get that applied and then still
> > continue on to your scheme, so we haven't lost anything by doing mine
> > first
> >
> > ii. I still believe my scheme could be the right one, although I have
> > to admit I would rather look at it again when we get to that point, as
> > I do have quite a few concerns about the Kconfig complexity of 4),
> > with my scheme, particularly after this discussion
> >
> > >
> > > Or, have we finally come to it. I can either merge your proposal, which
> > > I have grave reservations about, or you'll just do this all in your
> > > downstream fork? Because no, I don't have time to work on reworking this
> > > for VPL. I don't have the interest in reworking this for VPL.  Or should
> > > we come up with some method for the community to vote on what to do
> > > here?
> >
> > Or, if you don't want to make time to work on it, why get in the way
> > of those who are willing to do so?
>
> Because I'm reviewing your code and see grave problems? Problems that
> could be worse than doing nothing? That's why. I will take a look at
> "splg-working". However, I disagree with your point (i) above in that
> the reusable work is the script'able work. For example, we've already
> had feedback that when using $(PHASE_) vs $(XPL_) is confusing. Now
> we're going to replace that confusion with "why does CONFIG_SPL_FOO
> sometimes also mean CONFIG_FOO but not others?".

How much feedback and how many people?

Anyway, please see above. Let's just start this whole thread again
once we can figure out what you do and don't want from the end result.

Regards,
Simon
