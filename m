Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD887C3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 13:27:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2208C86A56;
	Fri, 25 Aug 2023 15:27:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="i/SnASzq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D4786A57; Fri, 25 Aug 2023 15:27:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF2BD86A4F
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 15:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692970058; x=1724506058;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/9t82maUvuJ8R7HRMKdcVEykUekk3FFNkdvhIdFBbMg=;
 b=i/SnASzq96D9ZRZlunMD20vnlJa2ulZyVORk44cQiDWwP9N4Pjim9cfd
 4iy2gaYVMQlpwjkcyxWywDipeiqyaYKNZ+FxWwEzeVc9Y7NsuYkhppfkE
 YwHGAvdNhZ0hrq7CTGOfC7EK1deHZNO46BiPXPs3bRCYrxiCNYsfgFN16
 TlIcmK+NQ488va+hMw9kfvPL0Np4/3X4fQeTJTk4iXmaNNT9/kM/2VvKt
 InUWvD7mhlHXD9r79jq0IKaWrYaQ7SdibX/40WZjX42OFFj4ZTHoMBoe8
 Q0lAuie38wVWNXypb/lPzQM7DYz/XW0Ej7/GnvirfRHFPAKVqcjwJHjnZ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461074054"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="461074054"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 06:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068241860"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="1068241860"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2023 06:27:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1qZWqb-001aUs-17; Fri, 25 Aug 2023 16:27:33 +0300
Date: Fri, 25 Aug 2023 16:27:33 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] Reland "x86: Move FACP table into separate functions""
Message-ID: <ZOisRZBQQJDW/Pco@smile.fi.intel.com>
References: <20230824182337.1666435-1-sjg@chromium.org>
 <ZOiLOkGpI87jAZ7h@smile.fi.intel.com>
 <ZOiqBvuZ6Z1gWd4h@smile.fi.intel.com>
 <ZOiryc6qOuentDqF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOiryc6qOuentDqF@smile.fi.intel.com>
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

On Fri, Aug 25, 2023 at 04:25:29PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 25, 2023 at 04:17:58PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 25, 2023 at 02:06:34PM +0300, Andy Shevchenko wrote:
> > > On Thu, Aug 24, 2023 at 12:23:32PM -0600, Simon Glass wrote:
> > > > Each board has its own way of creating this table. Rather than calling the
> > > > acpi_create_fadt() function for each one from a common acpi_write_fadt()
> > > > function, just move the writer into the board-specific code.
> > > 
> > > No luck, but I have a bit of time to debug more.
> > 
> > Okay, after your patch even U-Boot can't see those tables
> > 
> > => acpi list
> > Name      Base   Size  Detail
> > ----  --------  -----  ------
> > RSDP  000e4500     24  v02 U-BOOT
> > RSDT  000e4530     34  v01 U-BOOT U-BOOTBL 20231001 INTL 0
> > XSDT  000e45e0     44  v01 U-BOOT U-BOOTBL 20231001 INTL 0
> > CSRT  000e5490     58  v00 U-BOOT U-BOOTBL 20231001 INTL 0
> > MCFG  000e5610     3c  v01 U-BOOT U-BOOTBL 20231001 INTL 0
> > SPCR  000e5650     50  v02 U-BOOT U-BOOTBL 20231001 INTL 0
> > APIC  000e56a0     48  v02 U-BOOT U-BOOTBL 20231001 INTL 0
> > 
> > Because the base is badly corrupted:
> > 
> > -00000030: 52 53 44 54 38 00 00 00 01 95 55 2d 42 4f 4f 54  RSDT8.....U-BOOT
> > +00000030: 52 53 44 54 34 00 00 00 01 eb 55 2d 42 4f 4f 54  RSDT4.....U-BOOT
> 
> Length -4 bytes, another checksum as a result.
> 
> > -00000050: 00 00 00 00 90 54 0e 00 f0 54 0e 00 10 56 0e 00  .....T...T...V..
> > +00000050: 00 00 00 00 90 54 0e 00 10 56 0e 00 50 56 0e 00  .....T...V..PV..
> 
> Missing pointer to 0x0e54f0 which is... FADT!
> 
> > -00000060: 50 56 0e 00 a0 56 0e 00 00 00 00 00 00 00 00 00  PV...V..........
> > +00000060: a0 56 0e 00 00 00 00 00 00 00 00 00 00 00 00 00  .V..............
> > 
> > -000000e0: 58 53 44 54 4c 00 00 00 01 7b 55 2d 42 4f 4f 54  XSDTL....{U-BOOT
> > +000000e0: 58 53 44 54 44 00 00 00 01 d5 55 2d 42 4f 4f 54  XSDTD.....U-BOOT
> 
> Wrong length, another checksum.
> 
> > -00000100: 00 00 00 00 90 54 0e 00 00 00 00 00 f0 54 0e 00  .....T.......T..
> > +00000100: 00 00 00 00 90 54 0e 00 00 00 00 00 10 56 0e 00  .....T.......V..
> > 
> > -00000110: 00 00 00 00 10 56 0e 00 00 00 00 00 50 56 0e 00  .....V......PV..
> > +00000110: 00 00 00 00 50 56 0e 00 00 00 00 00 a0 56 0e 00  ....PV.......V..
> > 
> > -00000120: 00 00 00 00 a0 56 0e 00 00 00 00 00 00 00 00 00  .....V..........
> > +00000120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> 
> Same reason. So, your code forgot to link FADT to the main tables.

By code analysis you simply missed

+       acpi_add_table(ctx, fadt);

I'm going to check this right now... Stay tuned!

-- 
With Best Regards,
Andy Shevchenko


