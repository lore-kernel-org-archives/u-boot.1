Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B33EEC01A2
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 08:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6550D83DB6;
	Mon, 23 Mar 2026 09:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="USeqiKcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1366683FDC; Mon, 23 Mar 2026 09:03:10 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903FB83BE1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 09:03:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andriy.shevchenko@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774252985; x=1805788985;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=23wvUupD7z2heMh29Yvr/0kT7GzmUPE/AucCHNKTs8s=;
 b=USeqiKcCQT51k2wIRssRDqioUyaWBMRU7kjiGv8nSXsL0gkgR5D9zB86
 jQlOvmJ5zwaKKTYbv+hGkSq/aBTyeNKnwhgavKR9jrqAbciBdvBwegb91
 c2oIALfdDCfZkrvovMsxuvhgNEmeSyDzefTmaeOMcFdibweQl0+WT+WjE
 YG9yN1EDRHdHhtBxqtICtS9BV8f6hPdaa71/7mbc6Ho72DZgXrjwL3wQO
 hFu7LtJAber3mLJcusliP2WoCa7QzHzxPe3KFdrouCmgf7qK8OEgTJmXN
 HlUQqt5Vd2hZ3CQXTu+Scin6HHt6BtH4K0ctIVZlv+g8BzfD0jl3DyIGG w==;
X-CSE-ConnectionGUID: PktnXcT8RfSCWLanfefGRA==
X-CSE-MsgGUID: cq9rOFZPQGSMMrMdOxXwmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="97866295"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="97866295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:03:03 -0700
X-CSE-ConnectionGUID: VnDVyWwnS0ipzDBp/IPZvg==
X-CSE-MsgGUID: RsnSiDuUSKWZiIBlERxpCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="223021677"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.244.22])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:02:59 -0700
Date: Mon, 23 Mar 2026 10:02:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Tom Rini <trini@konsulko.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Greg Malysa <malysagreg@gmail.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Eoin Dickson <eoin.dickson@microchip.com>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 u-boot@lists.denx.de, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 arm-scmi@vger.kernel.org, linux-gpio@vger.kernel.org,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Khaled Ali Ahmed <Khaled.AliAhmed@arm.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2 4/4] gpio: scmi: Add gpio_scmi driver
Message-ID: <acDzsKoMdfcXecca@ashevche-desk.local>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <f8e1dcb617917dfe69efce0b3407f8786e4c971d.1773256350.git.dan.carpenter@linaro.org>
 <acC2fSdjDmj5Wp1a@nxa18884-linux.ap.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acC2fSdjDmj5Wp1a@nxa18884-linux.ap.freescale.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
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

On Mon, Mar 23, 2026 at 11:41:49AM +0800, Peng Fan wrote:

[....]

> >+	ret = snprintf(NULL, 0, "gpio_scmi%d_", bank_cnt);
> >+	uc_priv->bank_name = devm_kzalloc(dev, ret + 1, GFP_KERNEL);
> >+	if (!uc_priv->bank_name)
> >+		return -ENOMEM;
> >+	snprintf(uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);
> 
> build fail in CI [1]:

Moreover, this is reinvention of devm_kasprintf() to begin with.

-- 
With Best Regards,
Andy Shevchenko


