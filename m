Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B385C2BB3F
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 13:35:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D686287548;
	Mon, 20 Nov 2023 14:35:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RuGIFUwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9513D87154; Mon, 20 Nov 2023 14:35:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 021EE8755D
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 14:35:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700487338; x=1732023338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=X1yqe3/WzxuU4H471cSipoWlBgipk/byVd4SJYUJOsk=;
 b=RuGIFUwOp2/3ysgRw9CwPUq7IzUYnhbGeqRK3Sn6yrEuFu2rTE8uJxes
 oUQfSpRu4kOflrTAzJm4zedkN7iPIqfJupbJw8+rdtbxkHtYMyN5EYpon
 wsjJb2vO3NjJLj3sQn2yx+ldBxHZGC7Xk9UTlMiBxhs59WZsmYy4BBww6
 Q+TuDdntKBA/1j4ZepDpWx3hxbGNlopObiCq1sOwoSHkeGzHhHRGMSBTc
 GczHlcK6hzsQqJMLa8pl+ztdFvikAfg6Ztzx0HLph8rPT+rP7nTMzJHcu
 5T8IVIGfVcvm/JQ0uG5LDxhsUS50MSAb2e2Tj/UURLqKgfBRfdLYrw/VU Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="382007234"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="382007234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 05:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="910110628"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="910110628"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 05:35:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1r54R1-0000000FYlb-0h9S; Mon, 20 Nov 2023 15:35:31 +0200
Date: Mon, 20 Nov 2023 15:35:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] cmd: acpi: fix acpi list command
Message-ID: <ZVtgotGQJ8MS0JvG@smile.fi.intel.com>
References: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
 <20231118225248.105229-3-heinrich.schuchardt@canonical.com>
 <ZVtCzUlhBv59DdLY@smile.fi.intel.com>
 <2817b1b3-d26f-4ebd-a170-8fbaea89b5b7@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2817b1b3-d26f-4ebd-a170-8fbaea89b5b7@canonical.com>
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

On Mon, Nov 20, 2023 at 01:34:22PM +0100, Heinrich Schuchardt wrote:
> On 11/20/23 12:28, Andy Shevchenko wrote:
> > On Sat, Nov 18, 2023 at 11:52:48PM +0100, Heinrich Schuchardt wrote:

...

> > (Side question: Do you use --histogram when preparing patches? if no, try it.)
> 
> Thanks for reviewing.
> 
> No I don't use --histogram.
> 
> Without --histogram:
>  2 files changed, 45 insertions(+), 40 deletions(-)
> 
> With --histogram:
>  2 files changed, 54 insertions(+), 49 deletions(-)
> 
> The histogram algorithms finds less commonalities. Why should I prefer this?

Readability of the patch.

-- 
With Best Regards,
Andy Shevchenko


