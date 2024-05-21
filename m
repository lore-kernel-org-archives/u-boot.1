Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0239C25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 16:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4889E887B9;
	Tue, 21 May 2024 18:12:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AGJnLut4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A632887AD; Tue, 21 May 2024 18:12:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D2EA887B1
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 18:12:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716307940; x=1747843940;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hjvA7ztJuCs1f+3RWeS5fq96hHImyrJe5DgdI+P8Kok=;
 b=AGJnLut4Oo3ylYtrbCcKHQujWcZ+T9zrU/nijGi6Y6KF8GwE8y4SVvEj
 bdtAt7lrJ1Jj1BXCqvuWRABc5UKnuhLpmQ5c7Rwj8y8CwcdOqmwb61P1k
 N1UQ1069REAKmfry8Yd7bevR46tDP2gOe3yHf8UBPaD1s3OX8lwAhrFHi
 dkadTty96ac8b+UoP7QSHIc9jbrhmyKgJwskmlEJfIPvOp270qQe6rfgb
 VU0ebBprYuVJA8FbZAdHofYf16jKkwJ1l7H6IfS746OYR+0qo2Bq0HWOa
 YZqiYQrwcin/hOS18xnPX8vHrI3LdBfsJgURsMuzN8tTqIDp/3OxAXPD3 g==;
X-CSE-ConnectionGUID: ouuZQyqRTjajjMdLkrEdMw==
X-CSE-MsgGUID: pJzvXlbGRRiL9k7inP0C/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12686311"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="12686311"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 09:12:18 -0700
X-CSE-ConnectionGUID: t9NYLxGuTZ2l/ObPYnWz4A==
X-CSE-MsgGUID: fwn3otaNTlqX4xjyXAVXbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="33583788"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 09:12:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1s9S5x-00000009hww-39xG; Tue, 21 May 2024 19:12:09 +0300
Date: Tue, 21 May 2024 19:12:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, trini@konsulko.com, joe.hershberger@ni.com,
 m-chawdhry@ti.com, afd@ti.com, devarsht@ti.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, matthias.schiffer@ew.tq-group.com,
 a-bhatia1@ti.com, vitor.soares@toradex.com, danishanwar@ti.com,
 bmeng.cn@gmail.com, mkorpershoek@baylibre.com, s-vadapalli@ti.com,
 u-boot@lists.denx.de, joao.goncalves@toradex.com, hnagalla@ti.com
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
Message-ID: <ZkzH2Sa4eGAxb2EB@smile.fi.intel.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
 <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
 <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ba74bf-21ea-4551-8631-c07d8ff2c0ea@ti.com>
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

On Tue, May 21, 2024 at 08:59:17PM +0530, Kumar, Udit wrote:
> On 5/21/2024 7:59 PM, Andy Shevchenko wrote:
> > On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:

...

> > Are you Cc'ing random people with this?
> > Please don't do it.
> 
> I used names names popped up while running get_maintainer.pl script of
> u-boot
> 
> your email id was there for patch-3 of this series

Nice, the tool is broken. Please, work with the respective people to fix a tool
or to tune it to avoid such mistakes in the future.

(Hint: I would first disable Git fallback completely)

> ./scripts/get_maintainer.pl
> 0003-include-env-ti-Add-support-for-secure-firmwares.patch
> Joe Hershberger <joe.hershberger@ni.com> (maintainer:ENVIRONMENT)
> Tom Rini <trini@konsulko.com> (maintainer:THE REST)
> Udit Kumar <u-kumar1@ti.com> (commit_signer:1/2=50%,authored:1/2=50%,commit_signer:1/7=14%,authored:1/7=14%)
> Simon Glass <sjg@chromium.org>
> (commit_signer:1/2=50%,authored:1/2=50%,authored:1/7=14%)
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> (commit_signer:1/2=50%)
> Bin Meng <bmeng.cn@gmail.com> (commit_signer:1/2=50%)
> Manorit Chawdhry <m-chawdhry@ti.com>
> (commit_signer:1/2=50%,commit_signer:5/7=71%,authored:4/7=57%)
> Mattijs Korpershoek <mkorpershoek@baylibre.com> (commit_signer:4/7=57%)
> Nishanth Menon <nm@ti.com> (commit_signer:1/7=14%,authored:1/7=14%)
> Siddharth Vadapalli <s-vadapalli@ti.com> (commit_signer:1/7=14%)
> u-boot@lists.denx.de (open list)

-- 
With Best Regards,
Andy Shevchenko


