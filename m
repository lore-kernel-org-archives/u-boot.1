Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE34C71133
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:10:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 114AD86532;
	Fri, 25 Aug 2023 13:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aNhnZSTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECD2C86699; Fri, 25 Aug 2023 13:10:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4A2F8647A
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692961820; x=1724497820;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=jOQvPaWXmfKDOLzgK9WYYYx1gVkTBS8+Rub6s4JDNcM=;
 b=aNhnZSThOS6tsln6UhhCYi/vQs5Pc78TslcBqS+ItNZrIDWVXRZ7O9O4
 xOUEMr++ZMdLTXeQ0DYy/vkKMiwoOqF8RKKabbzVI+wZONqIUjNV1eF2D
 VwWw+2Mw0SM4k3zyic59aIllHQgRDclhufWImW5N3GUFyZlcyDZj+4kT6
 bWsK/XbFvcTWyCWpOzsgkFZRbTDnWmiWdFBft7mXSIib/5Rzq0zNGxHyb
 zqxxarhVFZMzCnue8KWwwlB9Buaz2VYyE60Skr3FVuFZQ3ktcgsn4cuQw
 2xHls1CJw+0Gqh9W9iwwlx1X05HobkwjKvongkJUSM+zSEjYqEM9XCXld w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="372088728"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="372088728"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 04:10:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="740575727"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="740575727"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 04:10:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1qZUhZ-00ESxU-28; Fri, 25 Aug 2023 14:10:05 +0300
Date: Fri, 25 Aug 2023 14:10:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] Reland "x86: Move FACP table into separate functions""
Message-ID: <ZOiMDRIailJwa2zY@smile.fi.intel.com>
References: <20230824182337.1666435-1-sjg@chromium.org>
 <ZOiLOkGpI87jAZ7h@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOiLOkGpI87jAZ7h@smile.fi.intel.com>
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

On Fri, Aug 25, 2023 at 02:06:34PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 24, 2023 at 12:23:32PM -0600, Simon Glass wrote:
> > Each board has its own way of creating this table. Rather than calling the
> > acpi_create_fadt() function for each one from a common acpi_write_fadt()
> > function, just move the writer into the board-specific code.
> 
> No luck, but I have a bit of time to debug more.

U-boot:

Writing tables to e4500:
ACPI: Writing ACPI tables at e4500
writing acpi tables
0base: writing table '<NULL>' at 000e4500
- return code 0
1facs: writing table 'FACS' at 000e4740
- return code 0
3dsdt: writing table 'DSDT' at 000e4780
- return code 0
4gnvs: writing table 'GNVS' at 000e5390
- return code 0
5csrt: writing table 'CSRT' at 000e5490
- return code 0
5fadt: writing table 'FADT' at 000e54f0
- return code 0
5mcfg: writing table 'MCFG' at 000e5610
- return code 0
5spcr: writing table 'SPCR' at 000e5650
- return code 0
5tcpa: writing table 'TCPA' at 000e56a0
5tcpa: Omitted due to being empty
- return code 0
5tpm2: writing table 'TPM2' at 000e56a0
5tpm2: Omitted due to being empty
- return code 0
5x86: writing table '<NULL>' at 000e56a0
- return code 0
6ssdt: writing table 'SSDT' at 000e56f0
6ssdt: Omitted due to being empty
- return code 0
8dev: writing table '<NULL>' at 000e56f0
- return code 0
writing acpi tables done ok
ACPI current = e56f0
- wrote 'acpi' to e4500, end e56f0
- wrote 'smbios' to e56f0, end e584f
- done writing tables


Linux:

[    0.003034] ACPI: RSDP 0x00000000000E4500 000024 (v02 U-BOOT)
[    0.003090] ACPI: XSDT 0x00000000000E45E0 000044 (v01 U-BOOT U-BOOTBL 20231001 INTL 00000000)
[    0.003158] ACPI: CSRT 0x00000000000E5490 000058 (v00 U-BOOT U-BOOTBL 20231001 INTL 00000000)
[    0.003219] ACPI: MCFG 0x00000000000E5610 00003C (v01 U-BOOT U-BOOTBL 20231001 INTL 00000000)
[    0.003277] ACPI: SPCR 0x00000000000E5650 000050 (v02 U-BOOT U-BOOTBL 20231001 INTL 00000000)
[    0.003332] ACPI: APIC 0x00000000000E56A0 000048 (v02 U-BOOT U-BOOTBL 20231001 INTL 00000000)
[    0.003382] ACPI: Reserving CSRT table memory at [mem 0xe5490-0xe54e7]
[    0.003403] ACPI: Reserving MCFG table memory at [mem 0xe5610-0xe564b]
[    0.003421] ACPI: Reserving SPCR table memory at [mem 0xe5650-0xe569f]
[    0.003437] ACPI: Reserving APIC table memory at [mem 0xe56a0-0xe56e7]

As you can see a few tables are missing:
FACS, DSDT, GNVS, FADT

-- 
With Best Regards,
Andy Shevchenko


