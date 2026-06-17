Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9CBCD98EE
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 06:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7BD2846B0;
	Wed, 17 Jun 2026 08:31:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="glAIUfDJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D54F284894; Wed, 17 Jun 2026 08:31:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55D15838BB
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 08:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781677897; x=1813213897;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=45/BoILpdDbDBbTcKYsHzgadL7q71uoBRAUR/0H2Al8=;
 b=glAIUfDJ+hnXRozndsPMT547DHgnPI+YIFg+ed2riQws2ZjwcsPe4I7n
 o4qtv8nUzu7VR0I7JOrARkAf2q84GksP6pkgnNxeIjWN2YsauG8EABoyh
 BFSZCXGc8RiA3qyUybssPap+Si5xmiPy6Y/E1fhF4Oh6lHO0exRv4YfLz
 zE39v3t5NwM0WhTxdWU1cGKvGmBYD2B3EcmI4x41MPiaOkNFqZRFIg0FE
 qRJnWmigQOS3uzN+VeTrrwgDhY1R+mcjxEZIPyGA0twyNVrIMImS0QhPW
 HNiHCNoguJX3tzB+lZjKfi9awDH6SrGsHx4slZGFgLOTq+ULFjt3oRVJM g==;
X-CSE-ConnectionGUID: wDItpNrVTCuq4msVJIlP1A==
X-CSE-MsgGUID: KTLt7DP5QfKCOSOwPDUhUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82362442"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="82362442"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:31:35 -0700
X-CSE-ConnectionGUID: t915XOpyT/KmUOnJrU3/LA==
X-CSE-MsgGUID: h1wOfVTZRGur39JUufHiLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="253089218"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.245.69])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2026 23:31:32 -0700
Date: Wed, 17 Jun 2026 09:31:30 +0300
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
Message-ID: <ajI_QluanoNRbhON@ashevche-desk.local>
References: <20260616142444.48193-1-sjg@chromium.org>
 <20260616142444.48193-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616142444.48193-2-sjg@chromium.org>
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

On Tue, Jun 16, 2026 at 08:24:16AM -0600, Simon Glass wrote:
> Intel Atom SoCs (Medfield, Clovertrail, Merrifield and Moorefield) boot
> via an 'OS Image Profile' (OSIP): a 512-byte '$OS$' header which tells
> the boot ROM where the OS image lives, where to load it and where to
> start executing. On the Intel Edison (Merrifield) the OS image is
> U-Boot.
> 
> The Edison image embeds this header as the static blob
> board/intel/edison/edison-osip.dat which is an empty stub in the tree,
> so a fresh build emits an all-zero, non-functional header.
> 
> Add an 'intel-osip' entry type which builds the header from devicetree
> properties, computing the checksum and taking the load address and entry
> point (both required) plus the logical block address, image size and
> attribute as parameters. The same sector doubles as the eMMC's
> protective MBR, which the boot ROM requires before it loads the OS
> image, so emit a GPT-protective (0xee) partition entry and the 0x55aa
> signature too. Use it for the Edison image in place of that blob, and
> remove the now-unused stub file.
> 
> The Edison node derives the load address and entry point from
> CONFIG_TEXT_BASE (entry point) and CONFIG_TEXT_BASE - 0x1000 (load
> address), rather than repeating the magic numbers, since the 0x1000
> difference is the mask ROM's load/entry gap.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +# Copyright 2025 Google LLC

I dunno the source of this, but it's 2026 outside.

...

>          data = self._DoReadFile('entry/fill_empty.dts')
>          self.assertEqual(tools.get_bytes(0, 16), data)
>  

Trailing whitespace, a chance to get rid of it.

> +    def testIntelOsip(self):
> +        """Test that binman can generate an Intel OSIP header"""
> +        data = self._DoReadFile('entry/intel_osip.dts')
> +        self.assertEqual(0x200, len(data))

-- 
With Best Regards,
Andy Shevchenko


