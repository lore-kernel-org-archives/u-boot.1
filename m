Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0270C25B74
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 18:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2C9188388;
	Tue, 21 May 2024 20:55:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iogGhqrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A50F8837C; Tue, 21 May 2024 20:55:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EAE28828E
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 20:55:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716317730; x=1747853730;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yR+QUj6rhIgoasVKmpwOwj26jDMFHSm+Uh+6YCh7dDY=;
 b=iogGhqrJ/TJy7d0l8RoyRedCTFwf0rh6LqXec0AvCbJkGP+cxW365chB
 Yx4GMcqCpIlcS0tMdWfV71qfycdNeHBCfdWrt+aTsOTmsxAp+arM8bu7z
 xDp/R4ob8Fy97v1u18O2pR5jxvXU0KSQ3W/Dq4U3bBpzDIxinXcRdUjf+
 OjVAqH6dMcqYpdqleNXaTOcgM9jVrsb80qAbYcrmx+4cQ0JuTLCve1lC5
 Z6JNm7576StvGcbnZ0HZtCntYawhG+76tuH9inOzCcQq1VPxj5Usa3Kj9
 5cZHonxOMTMYzBpUqLEhblMGhOnAIpNYszeEm2UeEIiX0Cgwyw9QxpJS7 g==;
X-CSE-ConnectionGUID: nOcNTH+iTumkwkbFJtGV4g==
X-CSE-MsgGUID: cwMIvy4cSWizB3lWmbU6eA==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="12477668"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="12477668"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 11:55:27 -0700
X-CSE-ConnectionGUID: rR8gVRcrQ2WtryFSufRq/w==
X-CSE-MsgGUID: tdGJ2NyWSY+TAvexHICMxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="56248795"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 11:55:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1s9Udr-00000009ktP-1iPC; Tue, 21 May 2024 21:55:19 +0300
Date: Tue, 21 May 2024 21:55:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>
Cc: "Kumar, Udit" <u-kumar1@ti.com>, vigneshr@ti.com, nm@ti.com,
 joe.hershberger@ni.com, m-chawdhry@ti.com, afd@ti.com,
 devarsht@ti.com, sjg@chromium.org, emanuele.ghidoli@toradex.com,
 matthias.schiffer@ew.tq-group.com, a-bhatia1@ti.com,
 vitor.soares@toradex.com, danishanwar@ti.com, bmeng.cn@gmail.com,
 mkorpershoek@baylibre.com, s-vadapalli@ti.com, u-boot@lists.denx.de,
 joao.goncalves@toradex.com, hnagalla@ti.com
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
Message-ID: <ZkzuF_DIklnGd70_@smile.fi.intel.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
 <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
 <20240521162145.GT2568172@bill-the-cat>
 <ZkzNa9TnTIixVnfJ@smile.fi.intel.com>
 <20240521164541.GY2568172@bill-the-cat>
 <ZkzehjK1AQ2tcPpw@smile.fi.intel.com>
 <20240521175247.GB2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521175247.GB2568172@bill-the-cat>
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

On Tue, May 21, 2024 at 11:52:47AM -0600, Tom Rini wrote:
> On Tue, May 21, 2024 at 08:48:54PM +0300, Andy Shevchenko wrote:
> > On Tue, May 21, 2024 at 10:45:41AM -0600, Tom Rini wrote:
> > > On Tue, May 21, 2024 at 07:35:55PM +0300, Andy Shevchenko wrote:
> > > > On Tue, May 21, 2024 at 10:21:45AM -0600, Tom Rini wrote:
> > > > > On Tue, May 21, 2024 at 07:12:09PM +0300, Andy Shevchenko wrote:
> > > > > > On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> > > > > > > On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > > > > > > > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:

...

> > > > > > > > Are you Cc'ing random people with this?
> > > > > > > > Please don't do it.
> > > > > > > 
> > > > > > > I used names names popped up while running get_maintainer.pl script of
> > > > > > > u-boot
> > > > > > > 
> > > > > > > your email id was there for patch-3 of this series
> > > > > > 
> > > > > > Nice, the tool is broken. Please, work with the respective people to fix a tool
> > > > > > or to tune it to avoid such mistakes in the future.
> > > > > > 
> > > > > > (Hint: I would first disable Git fallback completely)
> > > > > 
> > > > > So you were cc'd thanks to:
> > > > > commit 5e541a05f70296dbad07fc1f4e8678ad207bb476
> > > > > Author: Simon Glass <sjg@chromium.org>
> > > > > Date:   Sun Jul 30 21:01:45 2023 -0600
> > > > > 
> > > > >     env: Use include/env for text-environment includes
> > > > >     
> > > > >     The 'environment' word is too long. We mostly use 'env' in U-Boot, so use
> > > > >     that as the name of the include directory too.
> > > > >     
> > > > >     Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Intel Edison
> > > > 
> > > > Yeah, and it even explicitly stated what I reviewed from that code...
> > > > 
> > > > >     Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > > > 
> > > > > And, I'm sorry because there are other contributors who get upset when git
> > > > > fallback doesn't find them (because it also ages out after a year).
> > > > > In this case there's not even a "tweak the threshold" option since
> > > > > there's only a single commit to the file so you're in 100% of them.
> > > > 
> > > > Just an example of false positive by get_maintainer.pl :-(
> > > > And a confirmation of what I said — tool is broken.
> > > 
> > > It's an imperfect tool, yes. A quick check shows that if you never want
> > > to be cc'd from a git tag, you can add yourself to
> > > .get_maintainer.ignore and you will still be matched for things you have
> > > an explicit MAINTAINER entry for.
> > 
> > But this will kill me being a maintainer of U-Boot parts (regarding to
> > a certain platform) which is not what I want.
> 
> With a quick local test, no, it still reported you for edison stuff
> since that's not where the ignore list comes in.

I see. Still looking at the rate of false positives so far from U-Boot project
I don't see that a big hammer, like the proposed one, should be used. Better to
teach people on how to use/tune the tool, it will be helpful in a long-term.

-- 
With Best Regards,
Andy Shevchenko


