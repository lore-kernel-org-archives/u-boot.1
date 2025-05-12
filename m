Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C655BC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 18:26:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AA3280C83;
	Mon, 12 May 2025 20:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eo3tuxcS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BFB826AA; Mon, 12 May 2025 20:25:58 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A2B680584
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 20:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747074355; x=1778610355;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o2Vm6VLNXr74UCZa+knq5ur8iy0B9GTE4UDSX8JGdqI=;
 b=eo3tuxcS4B6zVMB5lIufwMaZrcbGhS647EeNipwGDPHzEeXCElN2V0Xx
 80VtNY+fd4rAbaJ04tAvwoq1xqlZ72WtlvXosbCWvoBLNxZyWDlNTrphk
 lcZs1/oVhR1voffODa9nwAUB3lxWT5hSvVIfwHcP3yLpr3IzfPdZ9PpFO
 eNk2zwocdZc1fdaO5yAyvQZdyEWf4Vmp3mZN3+v99PZGXY/bJWoOQEyOw
 DPsbkSv9IHZ9GiYvkbivEgPVZxDfNIONeUl4dI0YOXdqshxgkmdM36ZLH
 uxe3n3W+FiRlQZIwYnCPahAVCifQb+8PUlwxWGALUKHbpAhzOVHsQZ6fD w==;
X-CSE-ConnectionGUID: kngI+MIKTEW7Z+FUysJ/1Q==
X-CSE-MsgGUID: euFvYzDvRxax2rJz1qaMjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="60227395"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="60227395"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 11:25:53 -0700
X-CSE-ConnectionGUID: iUyKZwkQRFSPurF7DDKMKA==
X-CSE-MsgGUID: sC+BL6u4SE+asy1H2D0hEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; d="scan'208";a="142404014"
Received: from smile.fi.intel.com ([10.237.72.52])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 11:25:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1uEXqU-000000012MX-39Tv; Mon, 12 May 2025 21:25:46 +0300
Date: Mon, 12 May 2025 21:25:46 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH V3 0/3] cmd: env: select: Add output for available
 environment targets
Message-ID: <aCI9KoEkJR8P8lit@smile.fi.intel.com>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
 <aCGlPXMozNUty7R-@smile.fi.intel.com>
 <10712670b2bf422dbda67be449b0107a@dh-electronics.com>
 <aCGzhJPzGuL2i-mt@smile.fi.intel.com>
 <bd2e8c8f75a74a509653351208abf4d8@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2e8c8f75a74a509653351208abf4d8@dh-electronics.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
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

On Mon, May 12, 2025 at 03:15:06PM +0000, Christoph Niedermaier wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, May 12, 2025 10:38 AM
> > On Mon, May 12, 2025 at 08:22:19AM +0000, Christoph Niedermaier wrote:
> >> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> Sent: Monday, May 12, 2025 9:38 AM
> >>> On Fri, May 09, 2025 at 09:00:40PM +0200, Christoph Niedermaier wrote:
> >>>> Add the "-l" parameter to the "env select" command to print the available
> >>>> environment targets, convert all argument parsing in the file nvedit.c to
> >>>> getopt() and check that with unit tests.
> >>>>
> >>>> The first patch converts the parsing of arguments to getopt() for all env
> >>>> commands. The second one adds unit tests for checking the env command.
> >>>> These were used to check the env commands before and after the conversion.
> >>>> The third patch adds the actual new parameter "-l" for the "env select"
> >>>> command.
> >>>
> >>> What is the binary size increase with this change, please?
> >>
> >> I don't know exactly which binary size I should look at?
> >> I have looked at the object file of nvedit.c:
> >>
> >> I built it with the config dh_imx6_defconfig.
> >>
> >> Before my patches:
> >> $ ls -la cmd/nvedit.o
> >> -rw-r--r-- 1 developer developer 57644 May 12 10:03 cmd/nvedit.o
> >>
> >> After my patches:
> >> $ ls -la cmd/nvedit.o
> >> -rw-r--r-- 1 developer developer 59292 May 12 10:06 cmd/nvedit.o
> >>
> >> So the increase is 1648 Bytes (+2.86%).
> > 
> > U-Boot binary. And better to use bloat-o-meter script for that, it shows the
> > breakdown in more precise terms.
> 
> With bloat-o-meter it looks like this (before and after my patches):
> 
> ./bloat-o-meter -p arm-linux-gnueabihf- u-boot_before u-boot_after
> add/remove: 5/1 grow/shrink: 4/2 up/down: 1152/-652 (500)
> Function                                     old     new   delta
> bdinfo_print_all                               -     404    +404
> __getopt.constprop                             -     292    +292
> substitute                                     -     156    +156
> print_eth                                      -     124    +124
> print_bi_dram                                  -      72     +72
> do_env_default                               116     152     +36
> do_env_import                                424     456     +32
> do_env_print                                 740     764     +24
> do_env_delete                                 92     104     +12
> do_env_export                                336     328      -8
> substitute.lto_priv                          156       -    -156
> do_bdinfo                                    580      92    -488
> Total: Before=501681, After=502181, chg +0.10%

Not bad. Thank you for sharing!

-- 
With Best Regards,
Andy Shevchenko


