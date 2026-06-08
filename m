Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40005CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8E3283EEF;
	Mon,  8 Jun 2026 11:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iHh8T+E9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E495584154; Mon,  8 Jun 2026 11:35:36 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372D2807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:35:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780911334; x=1812447334;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kC2frNnloMx2SMzQcD2gKL/efxTvdgg4ke07M/VXdRY=;
 b=iHh8T+E9yZeBOj/M+egbvrMdbAZpqg2f+3tcmWhDOsUYiW7F+jJDMrYO
 MvW79QAkcQ5+ElffNwJaT63zfNlC9wnGVtgVSHYxj3wfpJRL9m/7P3rux
 Pt90rP1A8SfWnB3MA+0GqhfTeJz7zvJu7nTer59Zn9GfuuhPqUS2y7wnr
 By68aiTSBMQ3pYzHFcdriubVg4LurHv1oNTk0T6IhYPOHUQNfB22a5bbq
 NJZerc3kPcDGmdau56R9IYbM9LkYGYDefkt5BdOG1wqzsSuOoYYBKf7hk
 vNXnACLVfr3N3JIhXD56v5dzWW5spUKqLMEqhSvk3xDQ3ODhwCJgWvTKi A==;
X-CSE-ConnectionGUID: lidoklgiR/K6SvttTdDULA==
X-CSE-MsgGUID: KbBDzHg+QvqC9mwymEiG9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85528368"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85528368"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 02:35:33 -0700
X-CSE-ConnectionGUID: 5CKB2eABTK+saVNRucLXlg==
X-CSE-MsgGUID: YjBNtj1sSGydqXBO6Wg6Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="269211683"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 02:35:32 -0700
Date: Mon, 8 Jun 2026 12:35:29 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Flashing Edison
Message-ID: <aiaM4QIzKLbsl28O@ashevche-desk.local>
References: <CAFLszThw+GHX8t1V_FgDmLBYVUxt7fLU-28eeH4hH2K1LdBdaw@mail.gmail.com>
 <ah1cQApIrmWAa8TS@ashevche-desk.local>
 <CAFLszTj7aQvqXDeBd91Du3i=0X+9ssrANXcNDqGxyxMR_-dh2w@mail.gmail.com>
 <aiZ5Fargxaykd7np@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiZ5Fargxaykd7np@ashevche-desk.local>
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

On Mon, Jun 08, 2026 at 11:11:05AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 06, 2026 at 07:55:48AM -0600, Simon Glass wrote:
> > On Mon, 1 Jun 2026 at 04:17, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:

...

> > Here's the successful job:
> > 
> > https://concept.u-boot.org/u-boot/u-boot/-/jobs/524065
> 
> Wow, thanks for the efforts!
> 
> The problem is I can't see anything right now:
> 
> HTTP 502: Waiting for GitLab to boot
> It can take up to a few minutes for GitLab to boot completely.
> 
> This page will automatically reload every 5 seconds.

Now working. Thanks a lot for this!

-- 
With Best Regards,
Andy Shevchenko


