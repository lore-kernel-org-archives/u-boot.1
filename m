Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD476CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58D14846D3;
	Mon,  8 Jun 2026 10:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lk8qPajj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75188847B0; Mon,  8 Jun 2026 10:31:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60AC584154
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780907505; x=1812443505;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nziKSvbs/gWprb+BDHwjpK+IypnauzcNMsldF0coy7s=;
 b=lk8qPajjtcoxlc2HhEzNrPpMSxK+i9plHxPwQehcaspYEdTvZu/Y2vkb
 f5WlsqSw0Qiwez+K7YiFL2haehn64kljJb4ITJAb2x621hLJDguRwUsbO
 PqE3iyFNsWgoJ61pmlBE8WZ2zU9dyhmgbfEAfBPw8lp0VKNV8q9IznkxK
 ATSnFg28NlDKWpCHG1DAEVNvIholED6FVPCnlvSMcATgpgcPpMczFcX5x
 5ONqGOvctJcWjqWTULZ5IkOCkML+KCmggI40ZWzFs4ZBrokQMghq+s5f3
 trqVZjeiKrAzJFjbYL0VuQgbjFawu57ijaAMe0Cfh8lwtBhXjn2oO7DJz A==;
X-CSE-ConnectionGUID: 5JiLCpHdTKGNvW0GLxV/BQ==
X-CSE-MsgGUID: yTmB7vUhSaaMk5wrTztPzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85263744"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85263744"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:31:41 -0700
X-CSE-ConnectionGUID: 4YV36216TIiCbmqMoLb7VQ==
X-CSE-MsgGUID: PwVQHNvkQG+enmYXKimM0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="269462866"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:31:36 -0700
Date: Mon, 8 Jun 2026 11:31:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 0/5] edison: Fix mainline boot and convert the image to
 binman
Message-ID: <aiZ95kbAQbS7sfBH@ashevche-desk.local>
References: <20260607230519.3022520-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607230519.3022520-1-sjg@chromium.org>
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

On Sun, Jun 07, 2026 at 05:05:09PM -0600, Simon Glass wrote:
> Mainline U-Boot does not boot on the Intel Edison. The mask ROM enters
> the OS image 0x1000 above its load address, so U-Boot needs 4KB of zero
> padding ahead of it. That padding used to come from an alignment rule in
> board/intel/edison/config.mk, but the Kbuild-6.1 bump stopped that input
> being built, so u-boot.bin now starts with code at offset 0 and the ROM
> jumps into the middle of it.
> 
> This series moves the image build into binman: a new intel-osip entry
> generates the OSIP header (with the GPT-protective MBR the mask ROM
> needs) and a fill provides the 4KB gap, replacing the config.mk hack and
> restoring the boot. It also widens the DFU auto-probe window so an
> automated flash has time to start, adds the board to the sjg-lab CI and
> rewrites the documentation to separate a normal DFU update from xFSTK
> recovery.
> 
> Tested on real hardware: a bricked board recovers via xFSTK, takes a
> fresh U-Boot over DFU and boots the result.

I have got only patches 0-3, I will try to get them from lore.kernel.org.
So far I reviewed them and fully support the series, thanks!

-- 
With Best Regards,
Andy Shevchenko


