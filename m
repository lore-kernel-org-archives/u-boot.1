Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB59C47258
	for <u-boot@archiver.kernel.org>; Sun, 28 Jan 2024 13:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D16B787DED;
	Sun, 28 Jan 2024 14:39:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DEAXU/LZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B0D87DF5; Sun, 28 Jan 2024 14:39:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1218C87DCB
 for <u-boot@lists.denx.de>; Sun, 28 Jan 2024 14:39:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706449192; x=1737985192;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i3qE/X+7AzpvdJ9gvtCOR6veOSja4yXkzNCeCtYP284=;
 b=DEAXU/LZe5kBdL5/ssSsSN7qpaLr3kfWbn161lSUno3lov/RfrHdzez9
 ZGt8+azFnAaWfl6U1VavPJN3xVQq9SIfs/qEmbpnMuXDqdTfas28Ysz7l
 IlbmH99AwzCB12zOO+4jOIpUxfWprK3jDnErUzbFxMgPtw4s+Dnj6bjbU
 4vogZ6RYvvRpZ7kReDgnKjy11cjZRFfUs3xu+UqaoM7YG1rSZ9viTD+uA
 PLaXbFEKSN4EJt+kOkm8vOeDjzHegSMzKAQkloNv4ccvyxlq6s14Sg9dF
 X+B4WGCbflleyfA2WIvTEg0ILg3dwMCHHRre8zaHoOsNax05MNhMbR/B2 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="467042807"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="467042807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 05:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="787576600"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="787576600"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2024 05:39:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1rU5IT-0000000HSrM-3Bzv; Sun, 28 Jan 2024 15:34:05 +0200
Date: Sun, 28 Jan 2024 15:34:05 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 08/16] edison: Remove empty config header
Message-ID: <ZbZXzfyrbHvaDX74@smile.fi.intel.com>
References: <20240122223920.3630168-1-trini@konsulko.com>
 <20240122223920.3630168-8-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122223920.3630168-8-trini@konsulko.com>
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

On Mon, Jan 22, 2024 at 05:39:12PM -0500, Tom Rini wrote:
> Now that we support having CONFIG_SYS_CONFIG_NAME be unset to indicate a
> lack of board.h file, unset this on the edison platform and remove
> the otherwise empty file.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


