Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CBCC3ABC3
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 07:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15854805D7;
	Mon, 12 May 2025 09:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fnEdkOCc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3E738091A; Mon, 12 May 2025 09:37:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 291E3800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 09:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747035462; x=1778571462;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QtXuzfQSbYXqEcFYKgpEFzH8e10ykWC6Z8TehJJ+h34=;
 b=fnEdkOCcnTA3/f7PtAFY1dBRz2/VKreKQd7oykXCg/5IPPgMzi08Vf1j
 e2CxdbOtU+XCvQtu0x/4vaV2irHCmntA0BSIA/X0S4j4EM42Cs3TM9lAG
 VH7euzvcoKyzmySkBE0SsUbaPAIlSCz/iM9fKfDtvNjL03PSt47rp+pAb
 +y3fp/cLOu1sF8OcKswLPMc8XtMaa9WcS8BaY48MMC+KsnZjlb/c4F0g1
 gois6dmuWLD8tXBxJ0tr69i5uzb679avqtZFNZm+PbyIwCE+kHmuAWClX
 QyhBENdTFoV8Zo528uY/mG8FgNJMr+yeMbD8TO+466dpWTq9WmVLOGX7k Q==;
X-CSE-ConnectionGUID: buGgXJn9TTSq426o2C13Kw==
X-CSE-MsgGUID: xTza3CzwT3CYabZJQYPSdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52628457"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="52628457"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 00:37:40 -0700
X-CSE-ConnectionGUID: qikLGharTUy7ORFYuXnyPw==
X-CSE-MsgGUID: riC0nk2oSyCMpLL9X8MpMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; d="scan'208";a="138212861"
Received: from smile.fi.intel.com ([10.237.72.52])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2025 00:37:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1uENjB-00000000qk6-41fl; Mon, 12 May 2025 10:37:33 +0300
Date: Mon, 12 May 2025 10:37:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: u-boot@lists.denx.de, Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH V3 0/3] cmd: env: select: Add output for available
 environment targets
Message-ID: <aCGlPXMozNUty7R-@smile.fi.intel.com>
References: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509190043.28641-1-cniedermaier@dh-electronics.com>
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

On Fri, May 09, 2025 at 09:00:40PM +0200, Christoph Niedermaier wrote:
> Add the "-l" parameter to the "env select" command to print the available
> environment targets, convert all argument parsing in the file nvedit.c to
> getopt() and check that with unit tests.
> 
> The first patch converts the parsing of arguments to getopt() for all env
> commands. The second one adds unit tests for checking the env command.
> These were used to check the env commands before and after the conversion.
> The third patch adds the actual new parameter "-l" for the "env select"
> command.

What is the binary size increase with this change, please?

-- 
With Best Regards,
Andy Shevchenko


