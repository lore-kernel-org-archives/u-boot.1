Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76942C3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 12:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5A47822D7;
	Fri,  9 May 2025 14:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lw4m1Yc/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34708283E; Fri,  9 May 2025 14:53:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A2982162
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 14:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746795190; x=1778331190;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hZHFQ7+64gb7usDk5HeSA/y3Zw2amVgw6hgeXFmNMeI=;
 b=lw4m1Yc/hzczGrXAgsSrggOm4XWk/Laqt77GYENbZhR3b4s0vhwM9E6Z
 zc2MdCXAxT2Vjapg8TC8XY5EmuwTZGyxxuSj6V0NyKXoEeTKCS7FHMQAA
 AfTLsGm9oQdYsHUgjFyUeGzLPpY7zo4AwJo9dvm+YQAfF6HqxbiQtCuHW
 oylHwZurfN3VBliey8CxPIT+1XUsVLDQcdoA0PsFIOC1Bu2IaP3nQePs4
 VXZUVRC09M9TBVLGFDuCXg+3of7Me8AxxkogcVRfOm2FnxNueqc69noEt
 mnlGSW7PaYlzIhj5wpLR+aOnChk7E3RySx2ZZBTodPpuOhK8en/A2zETI Q==;
X-CSE-ConnectionGUID: fYTJMzYISPaT3CUsOoUJFg==
X-CSE-MsgGUID: 8XkCL3V+QHSUASP3NStSlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="66027346"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="66027346"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 05:53:08 -0700
X-CSE-ConnectionGUID: cDQM7gsgQxmjzZX8M4M4Gw==
X-CSE-MsgGUID: 58ztRcp+TomtQS+MaLZ8Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; d="scan'208";a="141828362"
Received: from smile.fi.intel.com ([10.237.72.52])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 05:53:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1uDNDr-000000005y5-2taG; Fri, 09 May 2025 15:53:03 +0300
Date: Fri, 9 May 2025 15:53:03 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/1] x86: cpu: Describe board final hooks in the header
Message-ID: <aB36rz9tajyRZEzh@smile.fi.intel.com>
References: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
 <CAFLszTgmcg+EdhDjiuSgtYR1kwgsTwEBvhC+LZNqB9ypx8ev7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgmcg+EdhDjiuSgtYR1kwgsTwEBvhC+LZNqB9ypx8ev7w@mail.gmail.com>
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

On Sat, Oct 19, 2024 at 05:51:00AM -0600, Simon Glass wrote:
> On Fri, 18 Oct 2024 at 09:56, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The new two declarations board_final_init() and board_final_cleanup()
> > need a description. Add it here.
> >
> > Suggested-by: Simon Glass <sjg@chromium.org>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  arch/x86/include/asm/cpu.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

What's the status of this?

-- 
With Best Regards,
Andy Shevchenko


