Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7061D15D98
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 14:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1075F88E75;
	Mon, 21 Oct 2024 16:27:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZZg0Ma+a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F214488E8A; Mon, 21 Oct 2024 16:27:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9359E88B1F
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 16:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729520870; x=1761056870;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=+F1dGLDid/NHYkrnWspl2EOTk6mydC9ZYnAvZZLaDBQ=;
 b=ZZg0Ma+acw36KMeCIqIWgEPa2L8Wm8J26dcle0SfF+OS1oLka2dvRSaN
 gXvzo4V8UVl5COoVi/539o0kmfrl5uaHRcV9sGmNZJRn52Zi9hOsiI22d
 VooFeK4oNOPfbyd8Iwza5Gao5zgsO31IvQ0pDHfkTOvexboyzXKQoKwHJ
 zMAyIujPzrfECID2SHUzo/Ix85r4jaokHFNy/0eIZioZL+Xhy+3O+QZCa
 qtuns275E4+L8h5LHNIiYquvxXbV0W3SjVieDgxDjpYvRdI05SDWzxPeA
 5diu0K/4GBlD7VErOQVsAqFlSWUqlT6HmWFeL3DPsySioHpCCrppZG7Gu Q==;
X-CSE-ConnectionGUID: GlY+/Hd7Ti2Hxyw6GhRPPQ==
X-CSE-MsgGUID: xfTTBqtTR5W7NKkzX6MbqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28781827"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28781827"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:27:49 -0700
X-CSE-ConnectionGUID: jaDMF3gjRhaSzVdkEpQpAQ==
X-CSE-MsgGUID: s9yUvY4WSS2d344Rwmb5mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; d="scan'208";a="102858634"
Received: from smile.fi.intel.com ([10.237.72.154])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2024 07:27:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t2tNo-00000005Wzp-3mxM; Mon, 21 Oct 2024 17:27:44 +0300
Date: Mon, 21 Oct 2024 17:27:44 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>
Subject: enabling W=1 by default
Message-ID: <ZxZk4K4ff1T3gUVm@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi!

looking at the redness of the output of `make W=1` here is the question:
isn't it a good time to enable `make W=1` by default. Yes, I understand
the impact, but at least we can do it mandatory for a _new_ code submitted to
U-Boot, right?

Ideally I would have what Linux kernel has for a few releases already, i.e.
Werror by default and getting close to make a clean builds with that and
make W=1` at least against default configurations (yeah, with U-Boot there is
probably no default, but sandbox one).

-- 
With Best Regards,
Andy Shevchenko


