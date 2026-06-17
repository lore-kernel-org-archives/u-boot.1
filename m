Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F41ECD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:42:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DDB846B0;
	Wed, 17 Jun 2026 08:42:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AoctTjoH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 006D584894; Wed, 17 Jun 2026 08:42:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B427838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:42:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781678559; x=1813214559;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eAsuwrP7tDNiMIRRwhQf6Krj+C1OhNYYtb8dKpNHCGU=;
 b=AoctTjoHuVieKT2T1IRCA4hZHy6g8g4bylvCI/NmZTDCoJqOydPC78gU
 pWANZjxAHQYBXlroPqLw6PI09mrT6fAuRf0yeOPNHPqTtQX3skJY1TxMe
 C+GwTiqmnPQOY3PdzoafsRDgYItGiEn9GT+Fx6J4Tz47QGIISpYBp9lue
 gnjpWLUB93cr3lsxbvyosfTKwLbCmWWBCB2y0fPuGr90Sr/khMWEqhNt8
 qGppufIEexuqFG6vFVzlLU3HGmIqHcGqfcSeVSNJMSLUpBRnCwVPZ3Riy
 Ya/Plq3yTRY7rcs7191IDqSC8pIlLa1s7/FiwF1yYixs67aSvTVYtOhCP w==;
X-CSE-ConnectionGUID: Y2Ea8zb0R+O0HhZVDXem5g==
X-CSE-MsgGUID: A6ipPRkMS4CFsyIrACbMzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82521397"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82521397"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:42:37 -0700
X-CSE-ConnectionGUID: QpCgfC0nT5q8SCMGzV26vg==
X-CSE-MsgGUID: t7N5Hz0VRHaa6V6v74mLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="243826326"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa010.fm.intel.com with ESMTP; 16 Jun 2026 23:42:34 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id C603C95; Wed, 17 Jun 2026 08:42:32 +0200 (CEST)
Date: Wed, 17 Jun 2026 08:42:32 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marex@nabladev.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH v2 1/5] binman: Add an entry type for the Intel OSIP header
Message-ID: <ajJB2IhtZ4swZoLW@black.igk.intel.com>
References: <20260616142444.48193-1-sjg@chromium.org>
 <20260616142444.48193-2-sjg@chromium.org>
 <ajI_QluanoNRbhON@ashevche-desk.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajI_QluanoNRbhON@ashevche-desk.local>
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

On Wed, Jun 17, 2026 at 09:31:30AM +0300, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 08:24:16AM -0600, Simon Glass wrote:
> > Intel Atom SoCs (Medfield, Clovertrail, Merrifield and Moorefield) boot
> > via an 'OS Image Profile' (OSIP): a 512-byte '$OS$' header which tells
> > the boot ROM where the OS image lives, where to load it and where to
> > start executing. On the Intel Edison (Merrifield) the OS image is
> > U-Boot.
> > 
> > The Edison image embeds this header as the static blob
> > board/intel/edison/edison-osip.dat which is an empty stub in the tree,
> > so a fresh build emits an all-zero, non-functional header.
> > 
> > Add an 'intel-osip' entry type which builds the header from devicetree
> > properties, computing the checksum and taking the load address and entry
> > point (both required) plus the logical block address, image size and
> > attribute as parameters. The same sector doubles as the eMMC's
> > protective MBR, which the boot ROM requires before it loads the OS
> > image, so emit a GPT-protective (0xee) partition entry and the 0x55aa
> > signature too. Use it for the Edison image in place of that blob, and
> > remove the now-unused stub file.
> > 
> > The Edison node derives the load address and entry point from
> > CONFIG_TEXT_BASE (entry point) and CONFIG_TEXT_BASE - 0x1000 (load
> > address), rather than repeating the magic numbers, since the 0x1000
> > difference is the mask ROM's load/entry gap.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

While I gave a tag, please check the comment in my reply to patch 5.

-- 
With Best Regards,
Andy Shevchenko


