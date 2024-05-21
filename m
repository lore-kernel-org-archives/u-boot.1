Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B87C3C25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AEF2882F9;
	Tue, 21 May 2024 18:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SxtuZTa4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E166288339; Tue, 21 May 2024 18:36:09 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66AE3881C1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716309367; x=1747845367;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=KPpfO8+ugFNXTO0LCmgpTjzJ74wJGJ6qX92l8olxkQE=;
 b=SxtuZTa4L2FUsI1q/KLVKpnso430Jwl2cl7vau0WyGmxbaGIacyulLr7
 cBtFBbLJWvvl4vfsUn3iSbL9mhzt2iVW5d0BsupNiV/J3l6SPwRnWIVu9
 /VZ+dabrLrp9I87i/Lx1DKrz8Kn+VN4uYP6T6eP1g01MWytLwOxM0PEEM
 VtnrPn8Z6sLjeDfCZWGZUOcCxMmbbNjk9Nz3tEMcbYHJ/xn9BkyNc3Qph
 Z6ThR9ck08JNGEe7ipGtA6VVF8NqNILckT2TMdrTUCHxdOL07O0WKKPfI
 hhK+v/ubvTk6lVhPOT4bNM/2UgLW9vrrQKHruPlux/f0gdhZkRyyBoGgW g==;
X-CSE-ConnectionGUID: v6Z68Sp+RdqHj/XziNUkDA==
X-CSE-MsgGUID: jlIHSO2nReG+MbJ+VdPcbQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12459126"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="12459126"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 09:36:05 -0700
X-CSE-ConnectionGUID: zZN8qlXzQkyR8tIilv4tOg==
X-CSE-MsgGUID: eFirc/vwRBOdl13RGnu5OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="70391103"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 09:36:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1s9SSy-00000009iIm-1Ia6; Tue, 21 May 2024 19:35:56 +0300
Date: Tue, 21 May 2024 19:35:55 +0300
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
Message-ID: <ZkzNa9TnTIixVnfJ@smile.fi.intel.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
 <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
 <20240521162145.GT2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240521162145.GT2568172@bill-the-cat>
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

On Tue, May 21, 2024 at 10:21:45AM -0600, Tom Rini wrote:
> On Tue, May 21, 2024 at 07:12:09PM +0300, Andy Shevchenko wrote:
> > On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> > > On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > > > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:

...

> > > > Are you Cc'ing random people with this?
> > > > Please don't do it.
> > > 
> > > I used names names popped up while running get_maintainer.pl script of
> > > u-boot
> > > 
> > > your email id was there for patch-3 of this series
> > 
> > Nice, the tool is broken. Please, work with the respective people to fix a tool
> > or to tune it to avoid such mistakes in the future.
> > 
> > (Hint: I would first disable Git fallback completely)
> 
> So you were cc'd thanks to:
> commit 5e541a05f70296dbad07fc1f4e8678ad207bb476
> Author: Simon Glass <sjg@chromium.org>
> Date:   Sun Jul 30 21:01:45 2023 -0600
> 
>     env: Use include/env for text-environment includes
>     
>     The 'environment' word is too long. We mostly use 'env' in U-Boot, so use
>     that as the name of the include directory too.
>     
>     Signed-off-by: Simon Glass <sjg@chromium.org>
>     Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com> # Intel Edison

Yeah, and it even explicitly stated what I reviewed from that code...

>     Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> 
> And, I'm sorry because there are other contributors who get upset when git
> fallback doesn't find them (because it also ages out after a year).
> In this case there's not even a "tweak the threshold" option since
> there's only a single commit to the file so you're in 100% of them.

Just an example of false positive by get_maintainer.pl :-(
And a confirmation of what I said — tool is broken.

-- 
With Best Regards,
Andy Shevchenko


