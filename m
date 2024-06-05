Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012BEC25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 09:30:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C6BC88191;
	Wed,  5 Jun 2024 11:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZcbbPAk3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1838836C; Wed,  5 Jun 2024 11:30:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5651487A9C
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 11:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717579836; x=1749115836;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9oAwNn8PfMJVnvPmP0kr4k5YJDk0VrZ2AsgL4Oqt9mQ=;
 b=ZcbbPAk34OB4O9t0K/E7uSPCHdoh5cd2Cdf8+ELRIMaLtMqc3rU+CFhb
 aJ340XTBTapN+wBkHnw5IB5BFCXNzXrtgt80LKn3tPpDUZuRQpgg7KVwP
 Ap17xhX3Zo6weO1MYFGjd0dWwd/3HNPhKzf6HPQvG+YGwmJEVm5+CPq/9
 jVu/jK1hk7OyOj7fuVm1VAcho3X7cHJdsjmrqRJdtA8FsaX0sym4PgVJw
 ZT/jbr8mPyWARHLV7c+ECFRW5rNDmjzvW8GrzBw5tLgghJ6eMh/zwwuQe
 of7F1Uh3QBDudG4lzsHBrg4qCtBXUJe1jiOW7sTbr7WR1I56JuoPJ+dvQ w==;
X-CSE-ConnectionGUID: 5m9OZEPaQSCjO13NjOnZ+A==
X-CSE-MsgGUID: WPRNb7OVQ7uzAh6I2qIO9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="36697533"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="36697533"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 02:30:34 -0700
X-CSE-ConnectionGUID: 64ZFmxfOSNi9i5TgjFBJKA==
X-CSE-MsgGUID: jYzlg8x6SJ+Ij9n0hFSK7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="38173078"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 02:30:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1sEmyO-0000000DohI-0zKW; Wed, 05 Jun 2024 12:30:24 +0300
Date: Wed, 5 Jun 2024 12:30:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Stefan Bosch <stefan_b@posteo.net>, Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
Message-ID: <ZmAwMGCXZQbhoK0P@smile.fi.intel.com>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
 <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
 <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEfUkU+tcgjs61thzAiNVsBZEVDUTY+BBAxNQFuemHsfzWf9Sw@mail.gmail.com>
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

On Tue, Jun 04, 2024 at 05:50:08PM -0400, Raymond Mao wrote:
> On Tue, 4 Jun 2024 at 16:17, Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:

...

> > > This patch series requires mbedtls git repo to be added as a
> > > subtree to the main U-Boot repo via:
> > >
> > > $ git subtree add --prefix lib/mbedtls/external/mbedtls \
> > >       https://github.com/Mbed-TLS/mbedtls.git \
> > >       v3.6.0 --squash
> >
> > Is this approach maintainable?
> > I don't remember if we have similar in Linux kernel, for example.
> > (There are few candidates like compression algorithms that are usually
> > being
> >  hosted elsewhere)

No answer?

> > > Moreover, due to the Windows-style files from mbedtls git repo,
> > > we need to convert the CRLF endings to LF and do a commit manually:
> > >
> > > $ git add --renormalize .
> > > $ git commit

...

> > >  lib/mbedtls/mbedtls_def_config.h | 4262 ++++++++++++++++++++++++++++++
> >
> > This is ridiculously HUGE! This is unreviewable. Moreover, this is even
> > hard to
> > configure by the user! Can you rather make it modular and maybe create a
> > separate documentation for the most important options (I do not believe one
> > needs _all_ of them to be set / tuned)?
> >
> > This is a file from MbedTLS and follows its own style.
> And this is how MbedTLS is configured - with all features listed in a
> config file and
> commenting out the unused features with "//").
> The modification here is just to control those existing options with
> Kconfigs.

And why should we blindly follow this nonsense?

-- 
With Best Regards,
Andy Shevchenko


