Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446BBCD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA14F847B0;
	Mon,  8 Jun 2026 10:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LvSHz4sd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A510083EEF; Mon,  8 Jun 2026 10:22:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD96847C6
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780906965; x=1812442965;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=CXPhdhF8VKmGe/EYyaMK4JyLsvSmN6wIYvE74HB8OoU=;
 b=LvSHz4sdIWAMMsNikwt4Ere/kK78qNI9Z9dDxe141eNBpoaPu1Gh+ok+
 HK4usl+OGfDkbltWytZKpdq5nvhsYCLfnGWYfR1ObfwofF4+nW+XMZChO
 uKIPt8hoUQiCBFrw2ztU3ysczeGWXEi4T4u1rjOEWi4SY4zyDOkjp28Yf
 nqAdPIqjLx06rU6nxZzmMM7n67/qYZYs1XXLw3DtX5cL3KMoPKM7GRe8u
 yDFOJEuUmvGsAULl3QnAtpGb+naeJsZKJs8AkbthBHD3RdAH+PV4LrEiQ
 6JI9u9wNBFUo2LMS6GNT12kaQmgyBsbq8q7vbfSTSCKyGSVbTqw2tV1Hn Q==;
X-CSE-ConnectionGUID: 9+nKNVekROS8Uiy/jfCQrg==
X-CSE-MsgGUID: Z5QOHizGQPuVifz6Vrd+Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81699634"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81699634"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:22:41 -0700
X-CSE-ConnectionGUID: mNaGkNkdQUijKPlJGGm8Ag==
X-CSE-MsgGUID: Y26PHTA+RbmGURmqH00E0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="244631907"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:22:38 -0700
Date: Mon, 8 Jun 2026 11:22:35 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [PATCH 1/5] binman: Add an entry type for the Intel OSIP header
Message-ID: <aiZ7y1hXFn8DM6GN@ashevche-desk.local>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607230519.3022520-2-sjg@chromium.org>
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

On Sun, Jun 07, 2026 at 05:05:10PM -0600, Simon Glass wrote:
> Intel Atom SoCs (Medfield, Clovertrail, Merrifield and Bay Trail) boot

Bay Trail may or may not be related to this. At least it's *not* a part of
Intel MID chips, so I would exclude it and if required add a *separate*
documentation later on. Also there is missing Moorefield to make the list
comprehensive.

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
> properties, computing the checksum and taking the load address, entry
> point, logical block address, image size and attribute as parameters.
> The same sector doubles as the eMMC's protective MBR, which the boot ROM
> requires before it loads the OS image, so emit a GPT-protective (0xee)
> partition entry and the 0x55aa signature too. Use it for the Edison
> image in place of that blob, and remove the now-unused stub file.

...

> +"""Entry-type module for an Intel OS Image Profile (OSIP) header
> +
> +This generates the 512-byte '$OS$' header used by the boot ROM on Intel Atom
> +SoCs (Medfield / Clovertrail / Merrifield / Bay Trail) to locate and load the

As per above.

> +OS image. On the Intel Edison (Merrifield) this OS image is U-Boot.
> +
> +The OS image is expected to immediately follow this header, i.e. at offset
> +0x200 in the containing section. A single OS Image Identifier (OSII) descriptor
> +is emitted, pointing at that image.
> +"""

...

> +# Sector count placed in the protective MBR entry, matching the reference
> +# Edison images. The on-disk GPT is authoritative, so this is informational.

Intel Edison

> +PROTECTIVE_MBR_SECTORS = 0x03a3e000

...

> +class Entry_intel_osip(Entry):

Is it convention to have a pattern as Entry_$name, where $name is only small letters?
If not, I would rather see this as normal Python name (CamelCase).

...

> +    Properties / Entry arguments:
> +        - intel,load-address (int): DDR address to load the OS image to
> +          (default 0x01100000)
> +        - intel,entry-point (int): Execution entry point of the OS image
> +          (default 0x01101000)

But why? We have these in the respective configuration already...

> +        - intel,lba (int): Logical block address of the image on the boot
> +          media (default 0x800)
> +        - intel,size-blocks (int): Size of the OS image in 512-byte blocks
> +          (default 0x3000)
> +        - intel,attribute (int): OSII attribute byte (default 0x0f)

...

> +        # Legacy boot signature at the end of the block
> +        data[BOOT_SIG_OFFSET] = 0x55
> +        data[BOOT_SIG_OFFSET + 1] = 0xaa

Wondering if we can do an assignment of 16-bit value.

-- 
With Best Regards,
Andy Shevchenko


