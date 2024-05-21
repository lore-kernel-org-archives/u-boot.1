Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C90BC25B7A
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 14:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641D08824A;
	Tue, 21 May 2024 16:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JpnGhyHs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5925388775; Tue, 21 May 2024 16:29:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DA1B80E9A
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 16:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716301769; x=1747837769;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=vzohk4ChqFZADxdZZK5Lpjz/n/VBq/dETwLIS6euiH4=;
 b=JpnGhyHsUEb/c5DIaxcyOzBDTzujRDARfbquuoirRWbwA71oPRX5ZqS5
 a9AQ/K5CRVmX0WRfgSRcyovpdso8rOPP1/asBBYA7EASXoBTLUGfheNTM
 hrhbFiBR7hWg7NA+PiCEoaZp+cfRChYtueyRr/D6lzEw4iVnwpteDFjc3
 SxgjLLe4okqsSWYoenl6oYyBq5SdhEXeaw+SBihJ8RxLWcDO2x/Ts2gVD
 9goHIHjr5aWq4Fb4OI635+OVLWawj5IL/jTkpKMn8+nKufgV1hbb3Ely0
 7YqbAXc8B5sW4yOzl+05Yduk82zgdRnvtERVeStzyKooVjnuPfrPOPO8C g==;
X-CSE-ConnectionGUID: 2Z3Vcgf3Q4GgpTr8hUFDXg==
X-CSE-MsgGUID: aJenXSE5Sdaz8XuG3MjU3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="30007474"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="30007474"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 07:29:26 -0700
X-CSE-ConnectionGUID: /s4LWKZgQKy9ZmQruLK5Lw==
X-CSE-MsgGUID: GvORtoi7RgGzkAU41O3A5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; d="scan'208";a="32993645"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2024 07:29:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1s9QUQ-00000009gJP-0Tqo; Tue, 21 May 2024 17:29:18 +0300
Date: Tue, 21 May 2024 17:29:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: vigneshr@ti.com, nm@ti.com, trini@konsulko.com, joe.hershberger@ni.com,
 m-chawdhry@ti.com, afd@ti.com, devarsht@ti.com, sjg@chromium.org,
 emanuele.ghidoli@toradex.com, matthias.schiffer@ew.tq-group.com,
 a-bhatia1@ti.com, vitor.soares@toradex.com, danishanwar@ti.com,
 bmeng.cn@gmail.com, mkorpershoek@baylibre.com, s-vadapalli@ti.com,
 u-boot@lists.denx.de, joao.goncalves@toradex.com, hnagalla@ti.com
Subject: Re: [PATCH 0/4] Adding support to load secure firmware for HS devices
Message-ID: <ZkyvvWotyQJQyz9k@smile.fi.intel.com>
References: <20240521105648.3780072-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521105648.3780072-1-u-kumar1@ti.com>
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

On Tue, May 21, 2024 at 04:26:44PM +0530, Udit Kumar wrote:
> Some use case needs rproc firmware to be loaded at u-boot stage,
> using following commands at u-boot shell, firmware could be loaded
> 
> => setenv dorprocboot 1
> => run boot_rprocs
> 
> For Secure devices, secure version of rproc firmware should be loaded,
> which is appended by sec keyword[0].
> but currently non-secure firmware is loaded even for secure devices.
> So adding support for loading secure firmware on Secured devices.

Are you Cc'ing random people with this?
Please don't do it.

-- 
With Best Regards,
Andy Shevchenko


