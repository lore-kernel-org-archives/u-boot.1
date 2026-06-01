Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826D3CD6E56
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 10:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED3FF84874;
	Mon,  1 Jun 2026 12:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CIFwHTPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31CA284869; Mon,  1 Jun 2026 12:17:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1030D84869
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 12:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780309062; x=1811845062;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=g7z6TJdV7xtbHqqQuH1xYRQz4dg56XLc6ZpqyJ232gw=;
 b=CIFwHTPUEjpcw56ECjNcTC6O+wjzCBuqpFUhVDs+ZjkgTbx0AcgDQsR1
 73ZLIOSOCk83t+iBIzmUnGYMYQpvJ6kpJGF/TebplIHCxvIKD8LXifK2+
 jF3U8pRUqHZcwXO1QtLxP5hi9eN1CsJsuD8pmlzUFxafanqT39AfG7DH9
 2F5iHk8EXdF6ALRi4SBrMVoWFCG2Any/+d0B+KBJyEXxYg528JMkxwBSE
 p2E/fQ/ldHIcaGrbo9wcFqPK88UQQjseXkIhKKSkxksrdD1VrVkNw0lBC
 wz5Zw//Wagbh0M5VrqDQ+I9RmyBU1r2X15C6fI5RnPUaxsTdrYFd53874 w==;
X-CSE-ConnectionGUID: 0uw6qDuYScaO1zlrsQTxIg==
X-CSE-MsgGUID: hPGROE8dTpeoS3y1mqh7cA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92446729"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="92446729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 03:17:40 -0700
X-CSE-ConnectionGUID: wT/zEpl2RPiifZGpTlCmLw==
X-CSE-MsgGUID: iUslIKdlQ0yMm6c2BYC9hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; d="scan'208";a="281658097"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost)
 ([10.245.245.111])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2026 03:17:39 -0700
Date: Mon, 1 Jun 2026 13:17:36 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Flashing Edison
Message-ID: <ah1cQApIrmWAa8TS@ashevche-desk.local>
References: <CAFLszThw+GHX8t1V_FgDmLBYVUxt7fLU-28eeH4hH2K1LdBdaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszThw+GHX8t1V_FgDmLBYVUxt7fLU-28eeH4hH2K1LdBdaw@mail.gmail.com>
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

On Sun, May 31, 2026 at 08:31:38PM -0600, Simon Glass wrote:
> Hi Andy,
> 
> I've dusted off the Edison and have confirmed that it starts up:
> 
> # ub-int -T edison
> 
> 
> ******************************
> PSH KERNEL VERSION: b0182b2b
> WR: 20104000
> ******************************
> 
> SCU IPC: 0x800000d0  0xfffce92c
> 
> PSH miaHOB version: TNG.B0.VVBD.0000000c
> 
> microkernel built 11:24:08 Feb  5 2015
> 
> ******* PSH loader *******
> PCM page cache size = 192 KB
> Cache Constraint = 0 Pages
> Arming IPC driver ..
> Adding page store pool ..
> PagestoreAddr(IMR Start Address) = 0x04899000
> pageStoreSize(IMR Size)          = 0x00080000
> 
> *** Ready to receive application ***
> 
> 
> U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)
> 
> CPU:   Genuine Intel(R) CPU   4000  @  500MHz
> DRAM:  980.6 MiB
> WDT:   Started with servicing (60s timeout)
> MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
> Loading Environment from MMC... OK
> In:    serial
> Out:   serial
> Err:   serial
> Net:   No ethernet found.
> Hit any key to stop autoboot:  0
> Target:blank
> Partitioning already done...
> Flashing already done...
> 
> 
> ******************************
> PSH KERNEL VERSION: b0182b2b
> WR: 20104000
> ******************************
> 
> SCU IPC: 0x800000d0  0xfffce92c
> 
> PSH miaHOB version: TNG.B0.VVBD.0000000c
> 
> microkernel built 11:24:08 Feb  5 2015
> 
> ******* PSH loader *******
> PCM page cache size = 192 KB
> Cache Constraint = 0 Pages
> Arming IPC driver ..
> Adding page store pool ..
> PagestoreAddr(IMR Start Address) = 0x04899000
> pageStoreSize(IMR Size)          = 0x00080000
> 
> *** Ready to receive application ***
> 
> 
> U-Boot 2020.10-rc3-00032-gd9f6680e925-dirty (Sep 03 2020 - 18:44:28 -0600)
> 
> CPU:   Genuine Intel(R) CPU   4000  @  500MHz
> DRAM:  980.6 MiB
> WDT:   Started with servicing (60s timeout)
> MMC:   mmc@ff3fc000: 0, mmc@ff3fa000: 1
> Loading Environment from MMC... OK
> In:    serial
> Out:   serial
> Err:   serial
> Net:   No ethernet found.
> Hit any key to stop autoboot:  0
> =>
> 
> 
> Now I can see the instructions in doc/board/intel/edison.rst but I am
> not sure how to translate that into a lab. Basically I have:
> 
> - UART
> - Relay hooked up to the RESET button (SW1 U15)
> - power control
> 
> The instructions in edison.rst are quite complex. I can run the
> xfstk-dldr-solo tool but I don't want to have to download and install
> a recovery image even time I want to try a new U-Boot
> 
> Basically what I want is to be able to send U-Boot to the board over
> USB and then have it boot into that U-Boot. It seems that once U-Boot
> is installed the board behaves differently, but there must be a way
> around that.

If you need just U-Boot and you don't care about its default environment
the `dfu-util` is the only what you need.

Note, I have a helper script to setup U-Boot environment here:
https://gist.github.com/andy-shev/2c388310f2773ead647d9c1a3f1c813f

It has comments and examples how to do in different scenarios (working DFU
and recovery).

Based on your experience, please, feel free to update documentation to make
it easier, because the process is not so complex. The current one most likely
describes more steps that are needed for the old U-Boot (which came on a stock
image in 2014) to replace.

> Any help much appreciated. It was nice to meet you in person!

Likewise!

-- 
With Best Regards,
Andy Shevchenko


