Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D961C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF33787B8A;
	Fri, 15 Dec 2023 19:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RoZZ0rgD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE2187BED; Fri, 15 Dec 2023 19:44:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A28387B42
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702665897; x=1734201897;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=oHkuo6/4/pwIlL+96lhizPr1tKJXrXePchZl15ynYuE=;
 b=RoZZ0rgDoGIzo4oyeIaRku7fBtO9QUK53WgrOBuBgsTJA4XLE2Oqpd9J
 hZrYcYU2N5KEsDbZuCJFeS1xSD/Fg0kq29W3xwkF7gR7EPqZcyjPRKSTc
 jynt4YWuewxqFRrws8vPEjg6Z/APXvSK70SiuI4k7JdFywUdXx8w/sncF
 xqqC2FO1rOlYfQ2mQVnp17/OENOgIGrOlvkp4BB8Ds+PI7UF6kH/h3inK
 S9OoIsaM/4gBnggk6fid8qQKZV/Ldj8eGF0bG/zgBNG5JXnZbf6EUt6OU
 nVlUKuFieL1lRD0JWS/AW+Au3HlHExgvGOeWWLTc1vujPad5+Jzk2vzcn g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="399151444"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; d="scan'208";a="399151444"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 10:44:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="892991795"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; d="scan'208";a="892991795"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 10:44:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1rEDB3-00000006CHX-45Gk; Fri, 15 Dec 2023 20:44:49 +0200
Date: Fri, 15 Dec 2023 20:44:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] acpi: fix FADT table
Message-ID: <ZXyeoSVVLqE77XQk@smile.fi.intel.com>
References: <20231215182658.187516-1-heinrich.schuchardt@canonical.com>
 <20231215182658.187516-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215182658.187516-2-heinrich.schuchardt@canonical.com>
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

On Fri, Dec 15, 2023 at 07:26:55PM +0100, Heinrich Schuchardt wrote:
> Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
> to uintptr_t to fill these.
> 
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored. We should not fill
> unused fields.

...

> v2:
> 	no change

Have you seen my email?

-- 
With Best Regards,
Andy Shevchenko


