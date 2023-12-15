Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B656C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:43:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8874A87B2E;
	Fri, 15 Dec 2023 18:43:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iyuqSRtc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7492D87C19; Fri, 15 Dec 2023 18:43:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13C5187B24
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702662228; x=1734198228;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=zq24aSYxta3SCUoJ+mo77SSD4yNsUiUVbGKQd2PIZQs=;
 b=iyuqSRtcfyEy/2NU9EPIe4/wafr9Cukz+GzaApykzu7LW0f6n2oCdpP+
 ANqwTNg1KccEfPAFx2LrSNiNTEKt8SeJl+y1fj35q534qB68mrrRCBoP2
 0ssuLzivTKiBbTIYIQZpXQCZgeACKdYsfkA257jSfbA6ETE7hzziMb1Py
 iSp3MdAu+pdodwGSD2RG26GzZpu27FgrRhXypwmVnlvFvwZ4sIhMU1ehT
 YqH+RVJ3ScOYVGVdKcVPyD4+9FzNY0RwgI4zpVOKo8Q+EU6BIpmfqJsWh
 TUicWG+N4Mlfc4idBNwM9IVRMNcdr+wNG1fzbglD6zxyb/bwUykCNBPTv g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375455107"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; d="scan'208";a="375455107"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 09:43:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840744135"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; d="scan'208";a="840744135"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2023 09:43:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1rECDu-00000006BNN-0NsI; Fri, 15 Dec 2023 19:43:42 +0200
Date: Fri, 15 Dec 2023 19:43:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] acpi: fix FADT table
Message-ID: <ZXyQTYKzRm6BMsMe@smile.fi.intel.com>
References: <20231215164016.137794-1-heinrich.schuchardt@canonical.com>
 <20231215164016.137794-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215164016.137794-2-heinrich.schuchardt@canonical.com>
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

On Fri, Dec 15, 2023 at 05:40:14PM +0100, Heinrich Schuchardt wrote:
> Fields X_FIRMWAE_CTRL and X_DSDT must be 64bit wide. Convert pointers to
> to uintptr_t to fill these.
> 
> If field X_FIRMWARE_CTRL is filled, field FIRMWARE must be ignored. If
> field X_DSDT is filled, field DSDT must be ignored. We should not fill
> unused fields.

Is it dictated by the specifications?
Please, put the reference here in the commit message (section X.Y.Z "Goo bar").

...


From code perspective LGTM.

-- 
With Best Regards,
Andy Shevchenko


