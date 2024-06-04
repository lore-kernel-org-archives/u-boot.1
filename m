Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC39DC25B78
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 20:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32A3487ECD;
	Tue,  4 Jun 2024 22:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kHM5U9TJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37A4187ECD; Tue,  4 Jun 2024 22:17:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898E686F6E
 for <u-boot@lists.denx.de>; Tue,  4 Jun 2024 22:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717532270; x=1749068270;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+SJ8wCiO8BlrypFKGb3S0fpGJAGYz5YdgvufyctAA18=;
 b=kHM5U9TJ6mlgURBk8R/iVEt91mmBaVOQbrF/glJem59k6qhDXYJLvwtA
 XvSLhMiKIYIaCIRlNuucFO91XBUn38XGyJgof/Ok4V1fRznlOKMsvI3cB
 np6mfIMYfkQmNA6Ppy2k7ZKaKHztZ7XdJEUL/rPh34+KBroLai/r8R33G
 UbbE+/540n9ERToatNRwPBQNMdQsxDoBIuhYjonvMfhTc4hpUpLyISOW8
 6Ie3y6Zg7BMcMoC2iwCPu/fNZ8qc6NysO2Dt1cNM84c2Y2Hjfn7D0iIdG
 9Brt25GhNNX4t3SuxkEvlPOCi8c8ZI1awuXVuOwsOtKJ6HlUia0AXN9M1 Q==;
X-CSE-ConnectionGUID: 97xdv4diQC2OM3BOG9/Z/w==
X-CSE-MsgGUID: v+pc3e34SxubPM27srphxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="13945030"
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="13945030"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 13:17:48 -0700
X-CSE-ConnectionGUID: 6/enJve9Q4mkCDCQacgEvQ==
X-CSE-MsgGUID: 1DYkaH3rRKenlkCRH4XXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,214,1712646000"; d="scan'208";a="37290108"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 13:17:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1sEabC-0000000DeVx-2i2V; Tue, 04 Jun 2024 23:17:38 +0300
Date: Tue, 4 Jun 2024 23:17:38 +0300
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
Message-ID: <Zl92YrE0tw-15wzZ@smile.fi.intel.com>
References: <20240528140955.1960172-1-raymond.mao@linaro.org>
 <20240528140955.1960172-4-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528140955.1960172-4-raymond.mao@linaro.org>
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

On Tue, May 28, 2024 at 07:09:14AM -0700, Raymond Mao wrote:
> Port mbedtls with dummy libc header files.
> Add mbedtls default config header file.
> Optimize mbedtls default config by disabling unused features to
> reduce the target size.
> Add mbedtls kbuild makefile.
> Add Kconfig and mbedtls config submenu.
> 
> Prerequisite
> ------------
> 
> This patch series requires mbedtls git repo to be added as a
> subtree to the main U-Boot repo via:
> 
> $ git subtree add --prefix lib/mbedtls/external/mbedtls \
>       https://github.com/Mbed-TLS/mbedtls.git \
>       v3.6.0 --squash

Is this approach maintainable?
I don't remember if we have similar in Linux kernel, for example.
(There are few candidates like compression algorithms that are usually being
 hosted elsewhere)

> Moreover, due to the Windows-style files from mbedtls git repo,
> we need to convert the CRLF endings to LF and do a commit manually:
> 
> $ git add --renormalize .
> $ git commit

...

>  lib/mbedtls/mbedtls_def_config.h | 4262 ++++++++++++++++++++++++++++++

This is ridiculously HUGE! This is unreviewable. Moreover, this is even hard to
configure by the user! Can you rather make it modular and maybe create a
separate documentation for the most important options (I do not believe one
needs _all_ of them to be set / tuned)?

-- 
With Best Regards,
Andy Shevchenko


