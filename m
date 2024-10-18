Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68238D2FFFA
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:56:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDF4188D47;
	Fri, 18 Oct 2024 17:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PyMoerIc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85DA588D72; Fri, 18 Oct 2024 17:56:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22C1C88D29
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:56:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729266993; x=1760802993;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7JoH+KdCV9X6YHSrQUAV171OzEKGDECL7IVLbwGImpc=;
 b=PyMoerIcGeXM6/dOfZUxp7Ar4u4HCTbN9F/XaAyuUT38KOuqRIQJvVNP
 DD2V+QTFLA/fsU4wPIi8MWaZf3UJ2qCKe2QmEc1iRGGbXsubx0w/8aag/
 Eq5ZKrV9tKRdinHId0iu5cHrdZXcO3KG/kVgSfVyZPI+Dm+Mt1/Ff5w43
 evxqfq10z7qK4k56Bmmvc6l89M8MaxgcMKr6KtEHOyBcIQRudqGh/8cBy
 b/pHAOoI6MscTVTcPadN/h6zf3XeY0B/YUbyvF5UWKowmXvfxSPK01SAd
 8lt36PFsRHCA6U2JtRHpdob2CUQylr7TKoxOG3uiEE4UxcsRZ2odS5F16 Q==;
X-CSE-ConnectionGUID: m/ACZawmRcCDuXllJzt4fQ==
X-CSE-MsgGUID: g/ZVZAe6S5CfoXeEBCAAGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="16419436"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="16419436"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:56:31 -0700
X-CSE-ConnectionGUID: SyN2ToQ5SKaDE8MVgDlnkA==
X-CSE-MsgGUID: U+XSM6LtSva4pdossvk5ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="83731009"
Received: from smile.fi.intel.com ([10.237.72.154])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:56:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t1pL1-00000004WVg-3VBe; Fri, 18 Oct 2024 18:56:27 +0300
Date: Fri, 18 Oct 2024 18:56:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
Message-ID: <ZxKFK96o5PGRCWSR@smile.fi.intel.com>
References: <CAFLszThN1GbLJerc_4GST7iLORCK1E+jLR9kBRhpXGak_f-q2Q@mail.gmail.com>
 <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
 <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
 <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
 <CAFLszTiL8uA7tRkeK3+KTnVD1uTs32cx0kMWfamZBhd5LoBQdQ@mail.gmail.com>
 <ZxJJ6tXYV7tEPfy3@smile.fi.intel.com>
 <CAFLszTjPNafOL+Qmbq8JCjJ0tY7GiC-1TycVZZxy+6aY4pZLNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTjPNafOL+Qmbq8JCjJ0tY7GiC-1TycVZZxy+6aY4pZLNQ@mail.gmail.com>
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

On Fri, Oct 18, 2024 at 08:55:00AM -0600, Simon Glass wrote:
> On Fri, 18 Oct 2024 at 05:43, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Oct 17, 2024 at 04:11:48PM -0700, Simon Glass wrote:
> > > On Wed, 9 Oct 2024 at 08:08, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:

...

> > > /*
> > >  * Implement a weak default function for boards that need to do some final init
> > >  * before the system is ready.
> > >  */
> > > __weak void board_final_init(void)
> > > {
> > > }
> > >
> > > /*
> > >  * Implement a weak default function for boards that need to do some final
> > >  * processing before booting the OS.
> > >  */
> > > __weak void board_final_cleanup(void)
> > > {
> > > }
> > >
> > > Applied to u-boot-dm, thanks!
> >
> > Thanks, but what does it mean to me? Should I send an update to add the comments?
> 
> Yes, please. I'm just tidying up some x86 patches while Bin is away.

Patch has just been sent.

-- 
With Best Regards,
Andy Shevchenko


