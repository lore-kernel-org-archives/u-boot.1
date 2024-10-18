Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF55AD2FFF5
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 11:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD5E8908F;
	Fri, 18 Oct 2024 13:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q8iWQ8fK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 342BE8906D; Fri, 18 Oct 2024 13:43:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924178908F
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 13:43:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729251825; x=1760787825;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8mgMzXcvgHyJUznfgyAwaxNZZ8VRSGoixWT7pyFelx0=;
 b=Q8iWQ8fKd0RkSxylz2XeYnyPvbl2Ahvyf4Znt16I52BrdAP1t8eWq1S4
 dDLpLIBdoBpyvhGtyRq6IzuyTne47ZXavm7em4Ful0Z0nnDZcs/qdaMRr
 mns0XKAHcrso+TNfSi60cJJ0MXuMAfHNoSYNqHp40wJg30Uc+vnT3k8l6
 8DNwN/kCMObvk5skmsuHn2v6sEmpf5u9qmyuYJz4tehFyOC9DhDiawr1m
 GcPaDbgBkbJWIL/3MmZYvXM39zkbVDCnoEuh2W5iNnle+JYAF62WEpwJ4
 N3n/3fe3eD9m7aFXc6i4uGoIriwzHftJU6vlu42yyG9+lk3mWokohwIfO Q==;
X-CSE-ConnectionGUID: Q5LbMvXiQO28OBu4+9hoFg==
X-CSE-MsgGUID: DBaJMVzzTBigBen+Dh+ITQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28915630"
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="28915630"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 04:43:43 -0700
X-CSE-ConnectionGUID: osmKnYiNQ+2w5Ag6i7K9QQ==
X-CSE-MsgGUID: xFcZfyyoRK+P0gxx2JkLFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="109584778"
Received: from smile.fi.intel.com ([10.237.72.154])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 04:43:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t1lON-00000004RiG-1NhP; Fri, 18 Oct 2024 14:43:39 +0300
Date: Fri, 18 Oct 2024 14:43:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
Message-ID: <ZxJJ6tXYV7tEPfy3@smile.fi.intel.com>
References: <CAFLszThN1GbLJerc_4GST7iLORCK1E+jLR9kBRhpXGak_f-q2Q@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
 <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
 <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
 <CAFLszTiL8uA7tRkeK3+KTnVD1uTs32cx0kMWfamZBhd5LoBQdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTiL8uA7tRkeK3+KTnVD1uTs32cx0kMWfamZBhd5LoBQdQ@mail.gmail.com>
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

On Thu, Oct 17, 2024 at 04:11:48PM -0700, Simon Glass wrote:
> On Wed, 9 Oct 2024 at 08:08, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Oct 08, 2024 at 07:55:33PM -0600, Simon Glass wrote:
> > > On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The compiler is not happy to have no prototypes for the functions that
> > > > are not defined static. Add them. This helps avoiding the compiler warnings:
> > > >
> > > >   arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for ‘board_final_init’ [-Wmissing-prototypes]
> > > >   arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for ‘board_final_cleanup’ [-Wmissing-prototypes]
> > > >   arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for ‘reserve_arch’ [-Wmissing-prototypes]
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Thanks!
> >
> > > OK, but could you add proper comments for these?
> >
> > Any proposed texts for them? The comments were out of scope of my patch,
> > but I may add anything that is provided as a template.
> 
> I found some comments in one of the files, so you could use these as a
> base. Whenever you change code, you should make sure it has function
> comments, follows style, etc. That way things slowly get better.
> 
> /*
>  * Implement a weak default function for boards that need to do some final init
>  * before the system is ready.
>  */
> __weak void board_final_init(void)
> {
> }
> 
> /*
>  * Implement a weak default function for boards that need to do some final
>  * processing before booting the OS.
>  */
> __weak void board_final_cleanup(void)
> {
> }
> 
> Applied to u-boot-dm, thanks!

Thanks, but what does it mean to me? Should I send an update to add the comments?

-- 
With Best Regards,
Andy Shevchenko


