Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFBFCEDD9A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:07:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17DB489253;
	Wed,  9 Oct 2024 16:07:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="L3clSduW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3540289255; Wed,  9 Oct 2024 16:07:00 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812D989224
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728482818; x=1760018818;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=mdEB3sGXhBNjPhjeSFzsCpscPvhkp11w5Tb0e6i1kbg=;
 b=L3clSduWAKXc/fj0CJcOSSLxAaZmpmBjuzo25fLFi+3VorTiY6dc/Uqo
 4NymmpmSjM4ovhnp43TkTotYu+B0s3zQ7u8sFn2JfXJ3QlbnUPPWQK6gk
 Zo8MqIxPHdyikyUs0auromkYWyTeV0uayjFPXue+wCiGadGSu99NWSu86
 egThjFaUNIfBOjbAmjOQBRR+wRRexH4Nb5mVLOZTpuLGlbD7XOpNQZzay
 kUDXfLkXoJf5uAGVTJ4llrSiSkVE+G6SEK6m+ByNLlaNKWz86ZZGRuTBH
 +M3moCAdDHPz/fTKFQ9itpva0u56GCdVKoRhJoUUo9UW3dPN/Za1vPiFA w==;
X-CSE-ConnectionGUID: pOSOs2BISAm8KhMAiWiieg==
X-CSE-MsgGUID: dBPTl4hSTpyvS3mbhUwp8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="30661127"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="30661127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 07:06:43 -0700
X-CSE-ConnectionGUID: Am9ODrrRQoWOifFv6AZyzA==
X-CSE-MsgGUID: plXVOHNpRVq+ur/QIlT1Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="80776499"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa005.fm.intel.com with ESMTP; 09 Oct 2024 07:06:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id DE363807; Wed, 09 Oct 2024 17:06:40 +0300 (EEST)
Date: Wed, 9 Oct 2024 17:06:40 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 1/4] x86: cpu: Use default print_cpuinfo() for all
Message-ID: <ZwaN8GRyySFaMJm1@black.fi.intel.com>
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-2-andriy.shevchenko@linux.intel.com>
 <CAFLszTivZ-2fExaAkkc+gK3tq5dYwf4uxUXjkj2dhpkpopJKqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTivZ-2fExaAkkc+gK3tq5dYwf4uxUXjkj2dhpkpopJKqw@mail.gmail.com>
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

On Tue, Oct 08, 2024 at 07:56:43PM -0600, Simon Glass wrote:
> On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > Most of the copies of the print_cpuinfo() call the default method.
> > Remove all of those in order to have only the default one when
> > no `cpu` command is compiled.
> >
> > This also helps avoiding compiler warning, e.g.:
> >
> >   arch/x86/cpu/tangier/tangier.c:23:5: warning: no previous prototype for ‘print_cpuinfo’ [-Wmissing-prototypes]
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/cpu/broadwell/cpu.c                 | 12 ------------
> >  arch/x86/cpu/coreboot/coreboot.c             |  5 -----
> >  arch/x86/cpu/cpu.c                           |  6 +++++-
> >  arch/x86/cpu/efi/app.c                       |  5 -----
> >  arch/x86/cpu/efi/payload.c                   |  5 -----
> >  arch/x86/cpu/ivybridge/cpu.c                 | 14 --------------
> >  arch/x86/cpu/qemu/qemu.c                     |  6 ------
> >  arch/x86/cpu/quark/quark.c                   |  6 ------
> >  arch/x86/cpu/slimbootloader/slimbootloader.c |  5 -----
> >  arch/x86/cpu/tangier/tangier.c               |  5 -----
> >  arch/x86/cpu/x86_64/misc.c                   |  5 -----
> >  arch/x86/include/asm/u-boot-x86.h            |  1 -
> >  arch/x86/lib/fsp/fsp_common.c                |  6 ------
> >  13 files changed, 5 insertions(+), 76 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!

> BTW, this function is deprecated...since with CONFIG_CPU it is shown
> by the CPU driver.

Is it docemented somewhere? In any case this patch I think is good on
its own as it drastically reduces the possible churn in the future.

-- 
With Best Regards,
Andy Shevchenko


