Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F74CCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:34:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FD1846B0;
	Wed, 17 Jun 2026 08:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CANE+FM0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F8184895; Wed, 17 Jun 2026 08:34:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1014838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andriy.shevchenko@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781678059; x=1813214059;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vCaXuW5O2As2omEHg8JVHHEnYyv4pZvI2oxmuD0CvkU=;
 b=CANE+FM0tauZN1iUkYMmeXz7Q183numrLaFjSP5mYCktn+PLGo9Gic1Y
 Ifc+yJ1h1TjSM4Gfx/7NfYmMIopnj0UDmrJqQ19JEv/IfLqCKkRRwPHRp
 MMUQOmgmsPcPjgEsf11AkL6qEwJdh6DiFyiMZK/S805Kd6Hd82Wu2g45U
 HpAIa7gL1WTmMibNg4ek9oQHUraHlpdW92OY0lUC/MFIko+fUn5VDjoGb
 CAgpjG3YbGPcJ/Lgyoz7aj9nzIiC0jkqW3gpo5qYaBCaWedeP42Q1za+V
 NOFnYI1QFhrogWakKRpWl9ybs9jAw82YxywbUJ7Go4pXUIg7+uDAicVWi A==;
X-CSE-ConnectionGUID: 0CnIBqbtSUadtBNwU3Pylg==
X-CSE-MsgGUID: Zecnz2mfT22Fh3kMkCyGcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82572010"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82572010"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:34:16 -0700
X-CSE-ConnectionGUID: lPGSAXHASNq8YiPQa3eKbA==
X-CSE-MsgGUID: eBT8RS9JQf2MHOxSNFk/tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="243604761"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2026 23:34:15 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id CD75195; Wed, 17 Jun 2026 08:34:13 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:34:13 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Raymond Mao <raymondmaoca@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 4/5] CI: Add an sjg-lab job for the Intel Edison
Message-ID: <ajI_5ZXpQ4ygg4-Q@black.igk.intel.com>
References: <20260616142444.48193-1-sjg@chromium.org>
 <20260616142444.48193-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616142444.48193-5-sjg@chromium.org>
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

On Tue, Jun 16, 2026 at 08:24:19AM -0600, Simon Glass wrote:
> Add the Intel Edison (Merrifield/Tangier) to the sjg-lab CI matrix.
> U-Boot is sent over DFU into the board's eMMC u-boot0 partition during
> U-Boot's brief do_probe_dfu window, and a reset then boots it from
> there. The lab environment handles the build and the DFU send, so the
> job only has to name the role.

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


