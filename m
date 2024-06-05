Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4CCC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C45988315;
	Wed,  5 Jun 2024 12:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jdf1DwFl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80F5A8831D; Wed,  5 Jun 2024 12:17:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A22D881A2
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:17:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717582659; x=1749118659;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+tqrfn9l3tNjRgKxGtPVLPtigjTITcWWcPZFe4bBrmE=;
 b=jdf1DwFlP114TbRRTHhWlv/kAf4CGkXRJ3finhBViB6sKybPBVqG+9D3
 CqJr5PDLKuYhECsSPitl38C0TJdu57CjKr461tn1R91yxbU69K3V1LNCr
 6DccWcn6O7VB9LaauvEPwKT4FnRasTDDd6N73O2goHPrErh1TKUa9v4DR
 G8oEJSMJdUQg5bbYYz4+Un7NxOPSDMVMpw0/AiBQHuN5mdSCDfd5BBM1r
 TWiXMLKTRM7z+vwGV/bUreP28wjVs6dDjnDMeDtsPyePkaofWyczf3cXl
 9G8UyV1cd5AHTsBO0v9ArLu4m65jbUa04DhtaxbBimbNLcz/V+ZHvz7Lq g==;
X-CSE-ConnectionGUID: CKA9bgdUSViU/rpIitNb8A==
X-CSE-MsgGUID: ngL776FYRf+8cPYPXaIBBw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14020081"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="14020081"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 03:17:37 -0700
X-CSE-ConnectionGUID: B+uYQVWBTcmyDDsRE28c9Q==
X-CSE-MsgGUID: NXrdEH+CTu6YWXImTvCIeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="75029809"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 03:17:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1sEnhu-0000000DpHc-2z9G; Wed, 05 Jun 2024 13:17:26 +0300
Date: Wed, 5 Jun 2024 13:17:26 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: Re: [PATCH v3 03/25] mbedtls: add mbedtls into the build system
Message-ID: <ZmA7NgxcSS315jrK@smile.fi.intel.com>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
 <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
 <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
 <CAC_iWj+PpUurGLqMw42ALHV6fOLnSwscG4KB2k-55eO2HuLwCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+PpUurGLqMw42ALHV6fOLnSwscG4KB2k-55eO2HuLwCQ@mail.gmail.com>
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

On Wed, Jun 05, 2024 at 12:35:37PM +0300, Ilias Apalodimas wrote:
> On Wed, 5 Jun 2024 at 12:30, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Jun 04, 2024 at 05:50:08PM -0400, Raymond Mao wrote:
> > > On Tue, 4 Jun 2024 at 16:17, Andy Shevchenko <
> > > andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:

...

> > > > > This patch series requires mbedtls git repo to be added as a
> > > > > subtree to the main U-Boot repo via:
> > > > >
> > > > > $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > > > >       https://github.com/Mbed-TLS/mbedtls.git \
> > > > >       v3.6.0 --squash
> > > >
> > > > Is this approach maintainable?
> > > > I don't remember if we have similar in Linux kernel, for example.
> > > > (There are few candidates like compression algorithms that are usually
> > > > being
> > > >  hosted elsewhere)
> >
> > No answer?
> 
> subtrees is what was decided on OF_UPSRTEAM as well. If you have a
> better idea feel free to propose it, but for the sake of conformance
> we are better off doing the same thing on every external tree we pull
> in

How do they will (or already do) maintain this?

At least it's a good to have a few words on the choice made in the cover
letter, so we will have no questions on it.

> > > > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > > > we need to convert the CRLF endings to LF and do a commit manually:
> > > > >
> > > > > $ git add --renormalize .
> > > > > $ git commit

...

> > > > >  lib/mbedtls/mbedtls_def_config.h | 4262 ++++++++++++++++++++++++++++++
> > > >
> > > > This is ridiculously HUGE! This is unreviewable. Moreover, this is even
> > > > hard to
> > > > configure by the user! Can you rather make it modular and maybe create a
> > > > separate documentation for the most important options (I do not believe one
> > > > needs _all_ of them to be set / tuned)?
> > > >
> > > > This is a file from MbedTLS and follows its own style.
> > > And this is how MbedTLS is configured - with all features listed in a
> > > config file and
> > > commenting out the unused features with "//").
> > > The modification here is just to control those existing options with
> > > Kconfigs.
> >
> > And why should we blindly follow this nonsense?
> 
> It's easier to follow up future changes tbh. But I do agree the config
> file is huge. Perhaps splitting in 2 files is going to be easier
> mbedtls_def_config.h -> contains all the options that rarely need
> tuning, which I assume is the majority of the header
> mbedtls_usef_config.h -> contains the imporant options, crypto,
> checksum algorithms etc
> 
> Thoughts?

The problem is on who decides which are "rarely need". The feasible (to me)
approach is to split per domain. Like you listed at the very end of your reply.
We can also learn from managing MTA configurations, such as Exim4 where user
may decide if they want a single file or split version.

-- 
With Best Regards,
Andy Shevchenko


