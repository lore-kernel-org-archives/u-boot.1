Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AE4C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DC3082E05;
	Mon,  7 Apr 2025 14:18:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LECmULUQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C387C82E40; Mon,  7 Apr 2025 14:18:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2A682B7E
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:18:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744028282; x=1775564282;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9idX+quL7AQRO+exd5vGWLutUmF8kHK/PBWzZ1vCbIU=;
 b=LECmULUQ6CTrn26QsIFeXXcsSesyBLyxF5wVWeshMB0E/KOwTWdGy+J0
 5BG1TQIaw27RUUsz5i35mpgtB8Kfz9x5UE8B2mylwsmcFfyv96MPxagC2
 9QFcRPTtkxWi9Jms38nebEEIrHr8+kpM+8XbXj/hldPejvkFumuNh8uu9
 a9i9MhMF0eWq6Bv2cJcodKDhePljnbUWmc9Poz6fpCV3C7epZnTEB5W6O
 jloy/Fz4uf15qco86DaFJ3FTl/GqYGsch6Gvm8N3t8unswOeRK6DDab5z
 nKljFf0Z5hbP/3EhFMsHvK5AKyXOyq/xhvyPTAnkpR67mrk/aKuYZUJlO Q==;
X-CSE-ConnectionGUID: PIZSYMTqQfurkbcjsJtGng==
X-CSE-MsgGUID: MXpOJPknSL+O4vnv1PuT2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="49065478"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="49065478"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 05:18:00 -0700
X-CSE-ConnectionGUID: GNWAQXHXSaWPPhdFjVfcLQ==
X-CSE-MsgGUID: QIcdlQoQTU2tKt7163Hl5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="158910643"
Received: from smile.fi.intel.com ([10.237.72.58])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 05:18:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1u1lQL-0000000A3uh-0ZJj; Mon, 07 Apr 2025 15:17:57 +0300
Date: Mon, 7 Apr 2025 15:17:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] IOMUX: Fix stopping unused dropped consoles
Message-ID: <Z_PCdOI0VU9ViuJ1@smile.fi.intel.com>
References: <20250407-iomux-stop-v1-1-d6485f7446fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407-iomux-stop-v1-1-d6485f7446fd@linaro.org>
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

On Mon, Apr 07, 2025 at 01:10:00PM +0200, Stephan Gerhold wrote:
> iomux_match_device() returns -ENOENT instead of the end index, which means
> console_stop() is never called at the moment for unused consoles.
> 
> This prevents e.g. f_acm from releasing the USB gadget interface when
> removing it from stdio/stderr/stdin.

Good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


