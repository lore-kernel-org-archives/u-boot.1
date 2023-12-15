Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05156C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:47:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40F7787C3A;
	Fri, 15 Dec 2023 18:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iM687ghe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F44487C3B; Fri, 15 Dec 2023 18:47:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F78387C38
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702662420; x=1734198420;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=R0S/JwWM0+x4ZRz+QfwEIZQdDngCSlJIyjA/EVi2R8M=;
 b=iM687ghePvhB8m7EbD7jQDjk/jtTCl1PZouRjxpXd8zlrVXdjLzHK//4
 F3b+j7nojKTIfgQp6QxVt9iqeY2uP4P9X8QAVzIv2B/29O05wa4+ANHwL
 WCzqnutgyMABKJxEsFQ+4dWY2F0ztjdXMMD7FiERrxT/64br10Q68mPWj
 9qaOS38uNtNLtLp2XRaSecNBuMfDUj7wJdk7VyYVfcaeVBxmLF4/puSUU
 K9tSPj4CkPVhaKWcAspi7pz6LykQ+X+hF+VdMwNzqXSXNW3sglWTsv6wI
 4IxHo2IGCUKbPTJhgr89vmPtlgObu0byTqT4iXOQuvq4mca99bwmDEo7D g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="13987338"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; d="scan'208";a="13987338"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 09:46:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="809045575"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; d="scan'208";a="809045575"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 09:46:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1rECH0-00000006BQT-0JKf; Fri, 15 Dec 2023 19:46:54 +0200
Date: Fri, 15 Dec 2023 19:46:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] cmd: acpi: check HW reduced flag in acpi list
Message-ID: <ZXyRDStdm4J__CIX@smile.fi.intel.com>
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
 <20231215164016.137794-4-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215164016.137794-4-heinrich.schuchardt@canonical.com>
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

On Fri, Dec 15, 2023 at 05:40:16PM +0100, Heinrich Schuchardt wrote:
> On non x86 platforms the hardware reduce flag must be set in the FADT
> table. Write an error message if the flag is missing.

...

> +	if (!IS_ENABLED(CONFIG_X86) &&
> +	    !(fadt->flags & ACPI_FADT_HW_REDUCED_ACPI))
> +		log_err("FADT not ACPI hardware reduced compliant\n");

I guess it's half baked solution as this, HW reduced, flag adds more
limitations even on x86. If you want a good validation it should be done
in a separate function taking others aspects into account.

But since it doesn't affect my area of interest in U-Boot, I won't prevent
you from doing this way, it's up to the U-Boot maintainers how to proceed
with it.

-- 
With Best Regards,
Andy Shevchenko


