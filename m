Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B92FE9A776
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 11:53:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A53AA80517;
	Tue, 24 Mar 2026 12:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ehi/XA+l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EF878366F; Tue, 24 Mar 2026 12:53:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5616580087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andriy.shevchenko@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774353210; x=1805889210;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=0PBNBmGbmulLwLv3acbA52j+2yPqgm6BRU/oaeG/EgY=;
 b=ehi/XA+lQ/PIDhnqoPoXWDVe24ikid7bcKkC9uW6QQsB6QDVHqR4lAly
 lLS5wunJ3Q8g6z1bg5NEbVR+2Z67O/z7wk1ecsCOPzWWQeqfRrd/smvpY
 4YpBTZ1Ec/YHrqW//oumTcKFnwLL/6uIdD9nX+slAA8O46WHzxQnj0ltQ
 FM594gEoQmUuSLa+V6dwPDdVqytRdCAkfk9XZNAPNTjxeuuil23bp0xmy
 3j5jmzWpEA/tHrpiElthh+z+QnUFKs7YysS8hfmLCiHx8wVTxZMcUWmnW
 4XNBlI5WC/SULPF1+KjXU1QMc8XAQ3HyGfduqUN2SNAFN6H1E6HL6oSZL w==;
X-CSE-ConnectionGUID: kLUHrKBcQpGsSsNK4eC+hA==
X-CSE-MsgGUID: M+suR6lJQICV1lxGFytyTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75482313"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="75482313"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:53:28 -0700
X-CSE-ConnectionGUID: spGosCHIQk6ByUO8OGujdA==
X-CSE-MsgGUID: oP5rvWUGS5C1l6VeyuXpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; d="scan'208";a="217756091"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.244.214])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2026 04:53:22 -0700
Date: Tue, 24 Mar 2026 13:53:20 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
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
Message-ID: <acJ7MK7vq4mj01Qg@ashevche-desk.local>
References: <cover.1773256350.git.dan.carpenter@linaro.org>
 <f8e1dcb617917dfe69efce0b3407f8786e4c971d.1773256350.git.dan.carpenter@linaro.org>
 <acC2fSdjDmj5Wp1a@nxa18884-linux.ap.freescale.net>
 <acDzsKoMdfcXecca@ashevche-desk.local>
 <acJ4NiwCRchgq7-t@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acJ4NiwCRchgq7-t@stanley.mountain>
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

On Tue, Mar 24, 2026 at 02:40:38PM +0300, Dan Carpenter wrote:
> On Mon, Mar 23, 2026 at 10:02:56AM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 23, 2026 at 11:41:49AM +0800, Peng Fan wrote:

[....]

> > > >+	ret = snprintf(NULL, 0, "gpio_scmi%d_", bank_cnt);
> > > >+	uc_priv->bank_name = devm_kzalloc(dev, ret + 1, GFP_KERNEL);
> > > >+	if (!uc_priv->bank_name)
> > > >+		return -ENOMEM;
> > > >+	snprintf(uc_priv->bank_name, ret + 1, "gpio_scmi%d_", bank_cnt);
> > > 
> > > build fail in CI [1]:
> > 
> > Moreover, this is reinvention of devm_kasprintf() to begin with.
> 
> devm_kasprintf() isn't an option in u-boot.

Ah, that's what I missed :-)

-- 
With Best Regards,
Andy Shevchenko


