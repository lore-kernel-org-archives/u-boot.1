Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38FCCD98C5
	for <u-boot@archiver.kernel.org>; Mon, 15 Jun 2026 06:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD2DF846A4;
	Mon, 15 Jun 2026 08:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HhQq+7kb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DBC684704; Mon, 15 Jun 2026 08:21:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04AA083FEE
 for <u-boot@lists.denx.de>; Mon, 15 Jun 2026 08:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781504515; x=1813040515;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=djiUlx2OvgItUHsOe9HsEe1gBBWPEGlCnhUL9OgWHOo=;
 b=HhQq+7kbNkqtIqXLFYf9v0bk6KiplOK9hBwK1JU51HTICH38n7n54+SM
 MWORCpMZqEpZAkqmK4QB6nJ4tXLjsBFyw6vKd7OAPRDa+iBZpRszUDRF5
 Tp8AHrt5Ri7VBms3mv0R3ZJ/J5s9JQ1w7al9l7jckqI4BscUCakpQVKnx
 REZT5EXxq3jtf26Dxsm6ZEcwRrx8fs2KWqqe3vbLY3ZVwrCfy4ON4bLJk
 YqXW/QlpSP9NRGQCM/BQgdLojkqgp7EdgsGg20Eat0XrJbPgx95hLO/eT
 yOZ17dCLT+30mSIUAvr2jbQ/jMIwgHd2nCbAnWnM6Cv7YEkdnw/8ie1tp w==;
X-CSE-ConnectionGUID: yhM1EWwHRVCanN3q+ztvCw==
X-CSE-MsgGUID: 0Mig3hXxTTebw/5adEXtdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="99658110"
X-IronPort-AV: E=Sophos;i="6.24,205,1774335600"; d="scan'208";a="99658110"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2026 23:21:53 -0700
X-CSE-ConnectionGUID: YCuzosF0Ryq38YxPPQFP6A==
X-CSE-MsgGUID: RD8YMUZ0TOa23S+OGXO8AQ==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.245.235])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2026 23:21:51 -0700
Date: Mon, 15 Jun 2026 09:21:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 1/2] x86: edison: Avoid passing FORCE to the align command
Message-ID: <ai-Z_aEpFY7FoPsp@ashevche-desk.local>
References: <20260613130519.1516808-1-sjg@chromium.org>
 <20260613130519.1516808-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613130519.1516808-2-sjg@chromium.org>
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

On Sat, Jun 13, 2026 at 07:05:12AM -0600, Simon Glass wrote:
> Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") adds FORCE
> as a prerequisite to the u-boot-align.bin rule, but cmd_mkalign_eds
> expands $^, so FORCE leaks in as a stray operand. The dd then fails
> (silently, since its stderr is discarded) and the following mv never
> runs, so u-boot.bin never gains its 4096-byte zero prefix. The mask ROM
> enters U-Boot 0x1000 (4KB) into the image and the board never starts,
> sitting in BootROM download mode (DnX).
> 
> Use $< instead of $^, which excludes FORCE and restores the prefix.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


