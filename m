Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8D5CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:44:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588A6846B0;
	Wed, 17 Jun 2026 08:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PmSUeaCC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECEC848A2; Wed, 17 Jun 2026 08:44:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8060838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andriy.shevchenko@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781678669; x=1813214669;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=elOwG1e3ElwCwXi4Ey9hjfmTD37Lhrmrh0SNOVuEZos=;
 b=PmSUeaCC9pKa8c5iK/eR8oPWg86jmJ2YoVe6Ae5cbmliMzdXc8iVZPta
 OtbFqG4/PP+gA/aflGUW8mEHsfgBQ4Aa98dPD4HK93rpOl33Nz/lyZl0d
 bwkgr13+yJSGhLo+Clhn5yyqn3dc27UPmGWln+udVZVZhCnLC1x+lqWRp
 4VvIBYUwIO8tY8Te2/AKJkQsyqZTS8AHPv9XH+n1NXWpV12LNS7gWhakJ
 vnRjHG0ZlPtecifyvv8gBybGBeK1E44JEZriXpbBmB7qdOEvfiJOAAn+h
 9awPGR9PuefaVsFYNOHSps2Qkapsf+MpZHa6lZk3VIw9eWhbC2aj64HDO w==;
X-CSE-ConnectionGUID: Ru7QpU/DQQ+fsCUHkDQdkQ==
X-CSE-MsgGUID: /kxdIImpRa6uErMcZ6YN2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82341913"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82341913"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:44:27 -0700
X-CSE-ConnectionGUID: iijFdWKCQmuqr1x8AEXgzg==
X-CSE-MsgGUID: WxcgIOMzTAupeXCxktnV6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="246845770"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa006.jf.intel.com with ESMTP; 16 Jun 2026 23:44:26 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 383F695; Wed, 17 Jun 2026 08:44:25 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:44:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 5/5] doc: edison: Rewrite the update instructions
Message-ID: <ajJCSRepiixmmgO0@black.igk.intel.com>
References: <20260616142444.48193-1-sjg@chromium.org>
 <20260616142444.48193-6-sjg@chromium.org>
 <ajJBmmhl1Gk9n4GP@black.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJBmmhl1Gk9n4GP@black.igk.intel.com>
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

On Wed, Jun 17, 2026 at 08:41:30AM +0200, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 08:24:20AM -0600, Simon Glass wrote:
> > Split the two ways of getting U-Boot onto the board: a plain DFU
> > transfer into u-boot0 when a working U-Boot is already present, and the
> > xFSTK mask ROM recovery when it is not. Drop the steps that only applied
> > to replacing the original 2014 U-Boot, document the 4KB alignment gap
> > the mask ROM needs and which binman output to flash (rather than the
> > bare u-boot.bin), note that a bricked board enters DnX without any
> > straps, and add udev rules for running the tools without sudo.

...

> > -1. Prepare u-boot.bin as described in chapter above. You still need one
> > -   more step (if and only if you have original U-Boot), i.e. run the
> > -   following command::
> >  
> > -     $ truncate -s %4096 u-boot.bin
> 
> Still missing this important detail. The DFU on v2014.04 is broken in a way
> that it requires also the whole binary to be aligned by 4k. The above pads
> the tail to full 4k (last block).
> 
> Btw, now I realised that I haven't checked if this is inherited in your binman
> case. Note, I haven't put that into the Makefile hack as I expected users to
> do this once, but perhaps if somebody wants to start over (by flashing the last
> official image), the file size needs to be aligned.

TL;DR: Either we leave this in documentation, or we always have a bigger blob.
However I don't remember how (current) upstream U-Boot DFU will react on the
trailing garbage (nulls).

-- 
With Best Regards,
Andy Shevchenko


