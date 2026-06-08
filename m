Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B28CD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E58583EEF;
	Mon,  8 Jun 2026 11:34:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cs69Tq9l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 789DD8405A; Mon,  8 Jun 2026 11:34:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAB4C807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:34:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andriy.shevchenko@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780911255; x=1812447255;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BIXPqWV3GMCmTcQBx3t32EpF512G434qqMYZsDdL/94=;
 b=cs69Tq9l+hqcGgwjPe3UmBecyi32eQInIlQ+eHX375RAdP1K8BjdYrG9
 WACvmp8gXafSXVRAnVON5fqs3USJ0j36t8WX6ZFDUPJJKRAKwDFyLSd9z
 obD41NZrI07QGP8Qk6eIf0MWQQn9RHClYKdJ0biNDQRGV4ovBrXdNMY6/
 EfeG6K2E6j4arFOZzIg/a/NZwFL6t+8+RK0xxA5zRdeORjKp6y8MHx+Tt
 8Zx1Dgr1NBSai+0ldUohbYzQ/Q33OVacl8i2nLG090CQRTJlikibxmGcc
 uxaiL/k8+uM2dSMmeAfjc7++ihDNinPcG1ZwmRh3sLfVG9fWB1vjx/Tzi g==;
X-CSE-ConnectionGUID: cfFeet5UQGWE1AM8B64YTw==
X-CSE-MsgGUID: RAV+A1onQfWNNxCCj3cj8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85528264"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85528264"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 02:34:12 -0700
X-CSE-ConnectionGUID: tT66OpPqQz2PdCCtsfaPSQ==
X-CSE-MsgGUID: BF8GpHBTRDCns/XPFsQeng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="247360953"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa004.fm.intel.com with ESMTP; 08 Jun 2026 02:34:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 9165295; Mon, 08 Jun 2026 11:34:09 +0200 (CEST)
Date: Mon, 8 Jun 2026 11:34:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 5/5] doc: edison: Rewrite the update instructions
Message-ID: <aiaMkZA_sEB-yoG1@black.igk.intel.com>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607230519.3022520-6-sjg@chromium.org>
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

On Sun, Jun 07, 2026 at 05:05:14PM -0600, Simon Glass wrote:
> Split the two ways of getting U-Boot onto the board: a plain DFU
> transfer into u-boot0 when a working U-Boot is already present, and the
> xFSTK mask ROM recovery when it is not. Drop the steps that only applied
> to replacing the original 2014 U-Boot, document the 4KB alignment gap
> the mask ROM needs (and that the bare u-boot.bin lacks), note that a
> bricked board enters DnX without any straps, and add udev rules for
> running the tools without sudo.

...

> -By default Intel Edison boards are shipped with preinstalled heavily
> -patched U-Boot v2014.04. Though it supports DFU which we may be able to
> -use.

I think we need to have a reference to this aspect somewhere.

...

> +Updating U-Boot over DFU
> +------------------------
>  
> +Once a working U-Boot is present, updating it is just a DFU transfer into the
> +``u-boot0`` eMMC partition; the board boots the new U-Boot on the next reset.
>  
> +1. Prepend the 4KB alignment gap to ``u-boot.bin``::
>  
> +     $ { head -c 4096 /dev/zero; cat u-boot.bin; } > u-boot-edison-dfu.bin

But this step is not needed if we build upstream U-Boot, otherwise the whole
point of having out-of-the-box working binary is ruined. That's why we should
really distinguish the U-Boot from stock image and from upstream.

...

> +Copy ``xfstk-dldr-solo`` to ``/usr/local/bin`` and
> +``libboost_program_options.so.1.54.0`` to ``/usr/lib/i386-linux-gnu/``. You
> +might find this `drive`_ helpful for the recovery image and the libraries.
>  
> +Download and unpack the Edison recovery image, then, with the board powered

Intel Edison.

> +off, run:

...

>  .. code-block:: none
>  
> -  XFSTK Downloader Solo 1.8.5
> -  Copyright (c) 2015 Intel Corporation
> -  Build date and time: Aug 15 2020 15:07:13
> -
> -  .Intel SoC Device Detection Found
> -  Parsing Commandline....
> -  Registering Status Callback....
> -  .Initiating Download Process....
> -  .......(lots of dots)........XFSTK-STATUS--Reconnecting to device - Attempt #1
> -  .......(even more dots)......................

I believe it's still useful for users to understand that reconnection is not an
issue.

...

> -.. code-block:: none
> -
> -  ******************************
> -  PSH KERNEL VERSION: b0182b2b
> -  		WR: 20104000
> -  ******************************
> -
> -  SCU IPC: 0x800000d0  0xfffce92c
> -
> -  PSH miaHOB version: TNG.B0.VVBD.0000000c
> -
> -  microkernel built 11:24:08 Feb  5 2015
> -
> -  ******* PSH loader *******
> -  PCM page cache size = 192 KB
> -  Cache Constraint = 0 Pages
> -  Arming IPC driver ..
> -  Adding page store pool ..
> -  PagestoreAddr(IMR Start Address) = 0x04899000
> -  pageStoreSize(IMR Size)          = 0x00080000
> -
> -  *** Ready to receive application ***
> -
> -After another 10 seconds the xFSTK tool completes and the board resets. About
> -10 seconds after that should see the above message again and then within a few
> -seconds U-Boot should start on your board:

The above example seems also useful to me for the unprepared users.

-- 
With Best Regards,
Andy Shevchenko


