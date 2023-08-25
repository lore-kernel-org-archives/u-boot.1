Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCACC3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 11:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F8E886699;
	Fri, 25 Aug 2023 13:07:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dGNDlKgq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F300867F7; Fri, 25 Aug 2023 13:07:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F2B86689
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 13:06:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692961619; x=1724497619;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XJ0F16W/1iJfY030T53ps28O9h2ycBESi9tEybUMTVU=;
 b=dGNDlKgqSilEwRqaboOFup0Nlel/hqN0Xnq+9bu1800e/i5Tb0s0ueeV
 q05sWjyYZlyTpq6aOrmO+FHTNJ6r3oQeptcEGkq+62WMaOTrwhWHlyfR2
 B2AcqCrEhYuGc2ZFhWa8lnMJ1TNsyJ5qcqbrUjwQca7pRIKVBKWvrLuQO
 QssblWfNekG8ttSEYHA8SPMyRYB66MeiKJoFYwjxoPmEvMemP7nSiEXBf
 Ae/aUgSZj3+zfSM0ceg2UBYoMiOSvsITJRjQZvIRWjbVUjz2O8k6ukAKZ
 g53IXZB2YoIjRZ8nV5PQn9Yp65QrK3FLuUeJgO3jal/ow6hREilUXed4m A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="354219032"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="354219032"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2023 04:06:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="851926064"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; d="scan'208";a="851926064"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga002.fm.intel.com with ESMTP; 25 Aug 2023 04:06:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1qZUeA-00ELLQ-2U; Fri, 25 Aug 2023 14:06:34 +0300
Date: Fri, 25 Aug 2023 14:06:34 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 1/2] Reland "x86: Move FACP table into separate functions""
Message-ID: <ZOiLOkGpI87jAZ7h@smile.fi.intel.com>
References: <20230824182337.1666435-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824182337.1666435-1-sjg@chromium.org>
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

On Thu, Aug 24, 2023 at 12:23:32PM -0600, Simon Glass wrote:
> Each board has its own way of creating this table. Rather than calling the
> acpi_create_fadt() function for each one from a common acpi_write_fadt()
> function, just move the writer into the board-specific code.

No luck, but I have a bit of time to debug more.

-- 
With Best Regards,
Andy Shevchenko


