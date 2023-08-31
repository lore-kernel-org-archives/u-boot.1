Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3732FC83F01
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 12:47:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25D5186576;
	Thu, 31 Aug 2023 14:47:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fJeGO3Ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FDBB86580; Thu, 31 Aug 2023 14:47:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B4F863E7
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 14:47:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693486035; x=1725022035;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=+yNXu6wWWmNqSLXb4hi6slnYBYDW6WBG4O9RISSOQtU=;
 b=fJeGO3OwOueUxIZQLJlBMD2t43tGP0L+KTlGDSXYmGdOaF3O9LBAd1vP
 7aw+JfbHNCMu+51wOdwD6eWSgL/jfFunP98zO+5xHV+Aeu21di3ngOwFL
 sJdFHgceihhyi0imnmL4O3MZ1TxcX7HfP5vxm9VQA1voZ5eGjBrpxaTX6
 Ub/ug9uQ5Gy2KHlA2Ep9EZaHmlRD1/bTcHHOSsEGy9bhmo83nk2nh/OXy
 PQURFXIZ6lXP2sPcfFA1AJ2RBK9dGcOlEskNFHdFs3L1naOdPCM1/7fY1
 TaQK4oiPy401v7HqEksiuGY7rnuE0/hCHeReA6cYtqouwbvwErZGdmFbt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="462299193"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; d="scan'208";a="462299193"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 05:47:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="716332152"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; d="scan'208";a="716332152"
Received: from smile.fi.intel.com ([10.237.72.54])
 by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2023 05:47:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1qbh4n-005O6o-0b; Thu, 31 Aug 2023 15:47:09 +0300
Date: Thu, 31 Aug 2023 15:47:08 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v2 1/2] Reland "x86: Move FACP table into separate
 functions""
Message-ID: <ZPCLzFAJyj7H1hg/@smile.fi.intel.com>
References: <20230831031341.2657786-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831031341.2657786-1-sjg@chromium.org>
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

On Wed, Aug 30, 2023 at 09:13:34PM -0600, Simon Glass wrote:
> Each board has its own way of creating this table. Rather than calling the
> acpi_create_fadt() function for each one from a common acpi_write_fadt()
> function, just move the writer into the board-specific code.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Not sure this is correct SoB chain. In kernel project we would do

Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Simon Glass <sjg@chromium.org>

> ---
> (Now fixed - thank you Andy!)

Right,
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


