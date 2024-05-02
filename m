Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5CFC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:20:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C094588CA8;
	Thu,  2 May 2024 09:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YIoUxx9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36AB488D03; Thu,  2 May 2024 09:20:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D7C288C10
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:20:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714634438; x=1746170438;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+/+onVDrx+uvuvCjJFZMWR1ZSlfsE1p2rl1wT/tlTZU=;
 b=YIoUxx9MWj1uOpVhHSf8BjmXEkEo44mCf3bJ7U6w9YVuLi7sAIcHhC1r
 tAExB/0EDD59KKomWSbLEp4eIafuoQtFkcjQMJUT9bIV6PIDJaP1UN5f7
 z2l5ClGgFO/ALQr9FoOfcFytBQGttt2NZLitLTAOIG40kP3zhw43t9Bqo
 /EPqd2OAKWFKbl/Km7RyXIHku5t4PHadvswBFYTUVyo54W/p+/ogqGWPJ
 QofOWFEhpT3yTtjx2lK4rod/RkBaLqNmtx3WovP2DnLUj2W4kODEAxscB
 VEK8xB1R+fUR92k7ymucZbFpbyLhknQBIfT8bNKmnaqjqWRtb7yy0LnFX Q==;
X-CSE-ConnectionGUID: c992iLwARDKUztZSQOYCkQ==
X-CSE-MsgGUID: /TcxjxzCR+uO+cH0iQKlBg==
X-IronPort-AV: E=McAfee;i="6600,9927,11061"; a="10213585"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; d="scan'208";a="10213585"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 00:20:36 -0700
X-CSE-ConnectionGUID: 3hDfVsj7RDyrs2vmpU+KEQ==
X-CSE-MsgGUID: c4ZlEH68TlO4hyJ6wL4uaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; d="scan'208";a="31850435"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 00:20:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1s2Qk4-00000003Dqe-33DU; Thu, 02 May 2024 10:20:32 +0300
Date: Thu, 2 May 2024 10:20:32 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>, Aiden Park <aiden.park@intel.com>
Subject: Re: [PATCH 073/149] board: intel: Remove <common.h> and add needed
 includes
Message-ID: <ZjM-wJDOaInyYPq1@smile.fi.intel.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-73-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501024316.1767971-73-trini@konsulko.com>
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

On Tue, Apr 30, 2024 at 08:42:00PM -0600, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


