Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31724CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97590846A7;
	Mon,  8 Jun 2026 10:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dac9RbFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4852846C3; Mon,  8 Jun 2026 10:11:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB17984154
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780906274; x=1812442274;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=uC/jkDdiTkuPUDVh6gyb2Zqny0LeeROHRnUITCOahM4=;
 b=dac9RbFBrcCGd//oRkIRUFs0vRacmAHGbhPFCnkhJt0OaW+m+SOlCYcd
 kFFgz0hnBSnKw5jQDiksSmNy39Q03O8/y82arr1Rw+Wcb8uGnsKfvtWEL
 HNFBggRFpWbC/uwgpRJgtyRT3qJ8GQIvWYlGm5msonetcOhTWMVKX9rpo
 yO47hVAf/qA8MFFe55bIc5df1SUKIYMjnAOFhGb2TBnZIcZjRo7oH7KEB
 qiYJRe/sheNcV9UztylHIOGpUi1lkunSX0y9qj+INIPINQF42g6TtRjUq
 NP4Sp4lg04mbGsyjx7487ORdHZNag/5TfwAQT1FWd6PIapdAHkGPV+RUQ w==;
X-CSE-ConnectionGUID: KHQOgh4vRISLhKZqRAWixg==
X-CSE-MsgGUID: fCEsJQ7PT7GrxTtGBbhGXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="91961339"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="91961339"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:11:05 -0700
X-CSE-ConnectionGUID: on7Yw1k+TYyaQB+X2I80wg==
X-CSE-MsgGUID: c+nbQnsfRW24pl73wnFvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="244366780"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:11:03 -0700
Date: Mon, 8 Jun 2026 11:11:01 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Flashing Edison
Message-ID: <aiZ5Fargxaykd7np@ashevche-desk.local>
References: <CAFLszThw+GHX8t1V_FgDmLBYVUxt7fLU-28eeH4hH2K1LdBdaw@mail.gmail.com>
 <ah1cQApIrmWAa8TS@ashevche-desk.local>
 <CAFLszTj7aQvqXDeBd91Du3i=0X+9ssrANXcNDqGxyxMR_-dh2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTj7aQvqXDeBd91Du3i=0X+9ssrANXcNDqGxyxMR_-dh2w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Sat, Jun 06, 2026 at 07:55:48AM -0600, Simon Glass wrote:
> On Mon, 1 Jun 2026 at 04:17, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sun, May 31, 2026 at 08:31:38PM -0600, Simon Glass wrote:

> > > I've dusted off the Edison and have confirmed that it starts up:

...

> > > U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)
> > >
> > > CPU:   Genuine Intel(R) CPU   4000  @  500MHz
> > > DRAM:  980.6 MiB
> > > WDT:   Started with servicing (60s timeout)
> > > MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
> > > Loading Environment from MMC... OK
> > > In:    serial
> > > Out:   serial
> > > Err:   serial
> > > Net:   No ethernet found.
> > > Hit any key to stop autoboot:  0
> > > =>
> > >
> > > Now I can see the instructions in doc/board/intel/edison.rst but I am
> > > not sure how to translate that into a lab. Basically I have:
> > >
> > > - UART
> > > - Relay hooked up to the RESET button (SW1 U15)
> > > - power control
> > >
> > > The instructions in edison.rst are quite complex. I can run the
> > > xfstk-dldr-solo tool but I don't want to have to download and install
> > > a recovery image even time I want to try a new U-Boot
> > >
> > > Basically what I want is to be able to send U-Boot to the board over
> > > USB and then have it boot into that U-Boot. It seems that once U-Boot
> > > is installed the board behaves differently, but there must be a way
> > > around that.
> >
> > If you need just U-Boot and you don't care about its default environment
> > the `dfu-util` is the only what you need.
> >
> > Note, I have a helper script to setup U-Boot environment here:
> > https://gist.github.com/andy-shev/2c388310f2773ead647d9c1a3f1c813f
> >
> > It has comments and examples how to do in different scenarios (working DFU
> > and recovery).
> >
> > Based on your experience, please, feel free to update documentation to make
> > it easier, because the process is not so complex. The current one most likely
> > describes more steps that are needed for the old U-Boot (which came on a stock
> > image in 2014) to replace.
> 
> OK, so after a considerable amount of effort this is what I have found:
> 
> I have Edison OTG/DFU on a Coolgear per-power power hub, plugged
> straight into the lab machine (no hub). The 1-hub depth (board -> hub
> -> host) seems to be required for reliable xfstk DnX transfers.
> 
> The board seems happy drawing power through the OTG VBUS (the
> Coolgear), so does not need the power connector to be powered (at
> least until it uses too many watts). In any case both must be off for
> the board to actually power off.

Yes, both mini-B connectors add to the power, so the board is required to be
fully off the connections in order to get coldboot.

> There are two cases:
> 1. A bricked board auto-enters DnX (8086:e005) on power-up - no straps needed.
> 2. FM/RM straps are only to force a HEALTHY board into recovery.
> 
> However, from the point of view of my lab, I can't assume the board is
> healthy and handling case (2) adds complexity.
> 
> So I run:
> 
>     sudo xfstk-dldr-solo --gpflags 0x80000007 --osimage u-boot-edison.img \

>       --fwdnx edison_dnx_fwr.bin --fwimage edison_ifwi-dbg-00.bin \

This is not needed as long as you have the firmware block correct, otherwise
you wear off the eMMC quicker.

>       --osdnx edison_dnx_osr.bin --verbose
> 
> then power-cycle via the Coolgear; it flashes IFWI + U-Boot and the
> board comes up as 8087:0a99 with a full dfu-util alt list, including
> u-boot0
> 
> I also need a udev rule, of course.

True, this is somewhere documented, but maybe not in U-Boot documentation.

> I ended up with some rather complex Labgrid logic (no chance of
> upstreaming it, but I suppose that's OK). I also created a Binman
> etype. Building the image with binman, I found the OSIP sector also
> needs a valid GPT-protective MBR (a 0xee entry) or the ROM won't boot
> it.
> 
> Finally I found that the board doesn't actually boot on mainline for
> me.

It might be that some patches as usually broke it as there is lack of
testing.

> I suspect I am doing something wrong, but in any case I am going
> to send a small series for your review.
> 
> Here's the successful job:
> 
> https://concept.u-boot.org/u-boot/u-boot/-/jobs/524065

Wow, thanks for the efforts!

The problem is I can't see anything right now:

HTTP 502: Waiting for GitLab to boot
It can take up to a few minutes for GitLab to boot completely.

This page will automatically reload every 5 seconds.

-- 
With Best Regards,
Andy Shevchenko


