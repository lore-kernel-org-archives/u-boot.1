Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F41CEDD9A
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:08:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B229989224;
	Wed,  9 Oct 2024 16:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="edkXeuOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD93889256; Wed,  9 Oct 2024 16:08:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722468921F
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:08:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728482884; x=1760018884;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=DZnlir1po/qUW2ENLQcK1DV+DpGJeYdTgXREIclDByw=;
 b=edkXeuOSroKu3Ktk9CYkIst0q0Hj2c6I7fE7cKwPdHznQhjXfATTE3Wr
 AON83WxQXyq417800FgCdPbTRT0wUXhon1OpWsOv34fWFL11aJ8/gdJpP
 qGkwcW+n0vpXXPUUeEukGCn5XWj36sNgoEUoNcaMabmBMcB2aMd5A2e4q
 dU7Eqkpt5/tEHif9jIag4HUC0wBnRAcD9xMlvLhZodNmvagGPCVSX01u6
 P8GBUnAkqnpolCMuGDEVacQxW69IDa9YoXMpB7oaJavp4JjwWM9oPa+u/
 c6IlyyIeRIsljt/zGbIJVaIzSNst1GuPuxHVi6g4mgtb81AbhjxC7f2pP g==;
X-CSE-ConnectionGUID: rxYefvc7TTmq7kmblll+zQ==
X-CSE-MsgGUID: WRCC0yycTtewVSbEQklbCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31680270"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; d="scan'208";a="31680270"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Oct 2024 07:08:02 -0700
X-CSE-ConnectionGUID: yPWqrhJnR/+ZvgzCNKVNBQ==
X-CSE-MsgGUID: 3z7zD7J5TMaW6hfThGq9rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; d="scan'208";a="81103879"
Received: from black.fi.intel.com ([10.237.72.28])
 by orviesa003.jf.intel.com with ESMTP; 09 Oct 2024 07:08:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 67889807; Wed, 09 Oct 2024 17:07:59 +0300 (EEST)
Date: Wed, 9 Oct 2024 17:07:59 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
Message-ID: <ZwaOPy9NTV4PmY5E@black.fi.intel.com>
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
 <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
 <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLszTjff52keqouqR3WK=cM=PX+EiTJQqz+YWBbDe3dSTYY8g@mail.gmail.com>
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

On Tue, Oct 08, 2024 at 07:55:33PM -0600, Simon Glass wrote:
> On Sat, 5 Oct 2024 at 13:14, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The compiler is not happy to have no prototypes for the functions that
> > are not defined static. Add them. This helps avoiding the compiler warnings:
> >
> >   arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for ‘board_final_init’ [-Wmissing-prototypes]
> >   arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for ‘board_final_cleanup’ [-Wmissing-prototypes]
> >   arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for ‘reserve_arch’ [-Wmissing-prototypes]
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks!

> OK, but could you add proper comments for these?

Any proposed texts for them? The comments were out of scope of my patch,
but I may add anything that is provided as a template.

-- 
With Best Regards,
Andy Shevchenko


