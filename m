Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A881C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 23:35:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95D9280F67;
	Sat, 22 Feb 2025 00:35:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kBcFVRFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDE07806FE; Sat, 22 Feb 2025 00:35:30 +0100 (CET)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DF3180F53
 for <u-boot@lists.denx.de>; Sat, 22 Feb 2025 00:35:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5ded1395213so4490574a12.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 15:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740180928; x=1740785728; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/aMYyNBuHGqqSUzX0Q1n/tpYQJttW5HM3Mt++2nkCq4=;
 b=kBcFVRFswW6anX3RKztU8yCOfTbXClA2UoKGlNxOC31Wt+0b1+Ywgfzu441KRnqQMi
 +UKlpTjIr+wrhcLsZR4WdPGTbhCMPvlSGV2LcGyYIqLSoV2A2ruoc9UtWqs155yD2Jjb
 vLyCJi/wJRsO7cvlfRbAEEMSu4XVYKypMh5tg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740180928; x=1740785728;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/aMYyNBuHGqqSUzX0Q1n/tpYQJttW5HM3Mt++2nkCq4=;
 b=bN6hcpuvlOMgfi0NdGet50R2zat7fR3/ynSVQPYBoHfO5LiO6NRYnhuu8DDzfV2gbX
 e9ELu72E/g7Chs2i/4aJb+b3BuJHa4F+m9B6KrgWvUIz2LoGFUb9Z04K0mjRVwfpIVBD
 DpGOWLCt9TvhtHylyhdMjgcDtkWlx1yNGHde3rAFvCYyYP8/HiyrUjWJAUttrOKIdwXW
 IV56f8Y4xiqxMYy15Hvkg1yQamCXphOmOC7ghBbW0SmJQQXVrEorvS3j5u1jw3aGP+wK
 vVJXE/9XQt7WdB0IExl58cEfRATD2GcBihYRUfZWCB+l8cPqNKStwbm2DJ3ftb/AJ7Le
 FJOQ==
X-Gm-Message-State: AOJu0YwEHg02/A3fP1wqkUEBSR3O2Zx8cwxPem2wNOFJGBkfvRpSavX3
 MKqdf5QMgThhNZceVwJ3Y2BSfu5yxgDdFFuNztO4jFGbDBhsM6R/+Y4AkGpNCkjza1rMk505egp
 ATvrGq6frtJHKIGV3uj9BjZI+C4d810nt8BXE
X-Gm-Gg: ASbGncsAD9TCWtqAjCYEQaqB4KIUhcSASC/51uc8z+SIYy9TubMOoiV+A1lmbBlHstm
 TGT25FS4q+2DMNn6D00vel6dkui9Ci6tzUWelGgy7xlEyQNEXN1r9yRh41mDEbl1XBieSnylZZF
 P6WUV7aR4J
X-Google-Smtp-Source: AGHT+IEGcUP5n18kkC+3oxo2jPq+2+WHc0YG23FWbqIpQJ7WFoNT2z4oNL7dqQ1cAjYgrMK7W8nfr1hDwCAlRr+J/rw=
X-Received: by 2002:a17:907:7ea0:b0:ab7:d179:2496 with SMTP id
 a640c23a62f3a-abc099b8422mr570149766b.6.1740180928053; Fri, 21 Feb 2025
 15:35:28 -0800 (PST)
MIME-Version: 1.0
References: <CAFLszTgnP7wGymh58coQBP=Rbui2O=ggXDT+Yu1pcgvCoLuFXw@mail.gmail.com>
 <20250220151643.GZ1233568@bill-the-cat>
 <CAFLszTiKbg2twYpJJTFb9bFya+5D2DsVPBGKXuw9pw6Y+cvUbg@mail.gmail.com>
 <20250220174005.GA1233568@bill-the-cat>
 <CAFLszTh=Mn9Hxe41KBB+8xjBBxVv=spV=g26tY+Hq6q43EM4=w@mail.gmail.com>
 <20250220204001.GC1233568@bill-the-cat>
 <CAFLszTjx1uQU+O=XrS6BBijpiSNtdR_-X_9LCjYZCSe+A0HC8g@mail.gmail.com>
 <20250221141940.GG1233568@bill-the-cat>
 <20250221192556.GP1233568@bill-the-cat>
 <CAFLszTicfTaAih-h6zgUD2ND2584quCmiayOZ__3t2Y+Ps0Lpg@mail.gmail.com>
 <20250221232005.GV1233568@bill-the-cat>
In-Reply-To: <20250221232005.GV1233568@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Feb 2025 16:35:16 -0700
X-Gm-Features: AWEUYZnWAcTHzdUHsVNzxl3sY01HjOZBpgHY3Seaz9zjaK_bBND0LHfMfXSSzVA
Message-ID: <CAFLszTjDukiu-06gRxWmahXB6gKiTQjGPfT1D9TqeMZcG+h_yw@mail.gmail.com>
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

On Fri, 21 Feb 2025 at 16:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 21, 2025 at 03:54:52PM -0700, Simon Glass wrote:
> > Hi  Tom,
> >
> > On Fri, 21 Feb 2025 at 12:26, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 21, 2025 at 08:19:40AM -0600, Tom Rini wrote:
> > > > On Thu, Feb 20, 2025 at 06:30:18PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Thu, 20 Feb 2025 at 13:40, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 20, 2025 at 11:13:34AM -0700, Simon Glass wrote:
> > > [snip]
> > > > > > I will look at "splg4" once it's somewhere on source.denx.de and I can
> > > > > > look at it, and refrain from otherwise assuming how it solves the
> > > > > > problems I had seen previously.
> > > > >
> > > > > I pushed an updated version to dm/splg-working but it is not very
> > > > > updated. Still needs more work.
> > > >
> > > > Thanks.
> > >
> > > So, after doing the remaining CONFIG_TEXT_BASE -> CONFIG_PPL_TEXT_BASE
> > > changes, here's another example of the problem with your approach. What
> > > stops xilinx_zynqmp_kria from building in splg-working is that
> > > BUTTON was missing from scripts/conf_nospl. Annoyingly, a mrproper (or
> > > since I always use O=, rm -rf) is needed for changes there to be picked
> > > up, but that's maybe just a missing Makefile dependency line. But that
> > > just makes it easier to see the next problem, which I don't see the
> > > answer to. For PPL, we can build drivers/spi/zynqmp_gqspi.o just fine.
> > > For SPL however:
> > >   CC      spl/drivers/spi/zynqmp_gqspi.o
> > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c: In function 'zynqmp_qspi_of_to_plat':
> > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:203:22: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > >   203 |         plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
> > >       |                      ^
> > > /home/trini/work/u-boot/u-boot/drivers/spi/zynqmp_gqspi.c:205:26: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> > >   205 |         plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
> > >       |                          ^
> > >
> > > And I don't see, really, what's even getting us down this error path.
> >
> > It's the FDT_64BIT in conf_nospl - that symbol needs to be the same
> > across all phases.
> >
> > I pushed a new tree which builds without the warning. Note that
> > SPL_SPI is enabled.
>
> So, the "what" is FDT_64BIT wasn't correct. I think this is showing that
> scripts/conf_nospl is going to be a problem in and of itself, and likely
> as confusing if not more-so than any of the in-the-end visible changes.

Yes, perhaps the key point I've been trying to get across is this confusion.

As you know, at present we have two types of options:
a) those for which each phase has its own value
b) those for which there is a single value shared across all phases

The only way today that you can tell them apart is by looking for uses
of CONFIG_IS_ENABLED() and $(PHASE_) with the option. If you see them,
then the option is a) otherwise it is b). There is no way to tell from
Kconfig. Also, some parts of the code may use CONFIG_IS_ENABLED() for
an option, some may use IS_ENABLED() for that same option. Some may
use $(PHASE_) and some may not. It's a bit of a mess.

Stepping back a bit, perhaps the goal of my series is to identify
options in b) so we can deal with them in a better way. They are all
listed in conf_nospl, in preparation for some future action.

Regards,
Simon
