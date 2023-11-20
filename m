Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCFFC54E76
	for <u-boot@archiver.kernel.org>; Mon, 20 Nov 2023 11:28:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F84874AC;
	Mon, 20 Nov 2023 12:28:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="W6z0lExw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2480D874BA; Mon, 20 Nov 2023 12:28:37 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 680828717E
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 12:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700479714; x=1732015714;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BXBjDQdQLajeHvKCqT0YuRqAGlOfnGE2mmOwbEqQ01I=;
 b=W6z0lExw0lkXUaySfX/F5cvAUuJYUaOZrFJ7HZykJBroC3cd2F/UJsZK
 xgYiVZc36ncV/fuMu3PsWSUgUnwWtOUTirMOa3GlGoDnEuk3+q4eVSLVB
 ocsDOCBRwKfcoE599H+hyisfsS+9QcYOU52fh4vSdvFM7ZSFEW3Swduj1
 wvJOsB+Ci2gRjVIVmDcW7EeQkRzXNUdDr4CNypfgDAnAplwYqGcy9hqZD
 gwStT/PdnLwRFlKHOsI04hWPaj91XZokTUFgnpeg6m6FzBqjCnWLPysBF
 Sh/DhzsQPqHyYl+btoKBUMfpkV3iU8M8etKRylVBUytAHt4MeErTrSQob w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="458097578"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="458097578"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 03:28:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="910078647"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="910078647"
Received: from smile.fi.intel.com ([10.237.72.54])
 by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 03:28:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1r52Rp-0000000FXD4-1nGy; Mon, 20 Nov 2023 13:28:13 +0200
Date: Mon, 20 Nov 2023 13:28:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] cmd: acpi: fix acpi list command
Message-ID: <ZVtCzUlhBv59DdLY@smile.fi.intel.com>
References: <20231118225248.105229-1-heinrich.schuchardt@canonical.com>
 <20231118225248.105229-3-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118225248.105229-3-heinrich.schuchardt@canonical.com>
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

On Sat, Nov 18, 2023 at 11:52:48PM +0100, Heinrich Schuchardt wrote:
> ACPI tables may comprise either RSDT, XSDT, or both. The current code fails
> to check the presence of the RSDT table before accessing it. This leads to
> an exception if the RSDT table is not provided.
> 
> The XSDT table takes precedence over the RSDT table.
> 
> The return values of list_rsdt() and list_rsdp() are always zero and not
> checked. Remove the return values.
> 
> Addresses in the XSDT table are 64-bit. Adjust the output accordingly.
> 
> As the RSDT table has to be ignored if the XSDT command is present there is
> no need to compare the tables in a display command. Anyway the
> specification does not require that the sequence of addresses in the RSDT
> and XSDT table are the same.
> 
> The FACS table header does not provide revision information. Correct the
> description of dump_hdr().
> 
> Adjust the ACPI test to match the changed output format of the 'acpi list'
> command.

(Side question: Do you use --histogram when preparing patches? if no, try it.)

...


> +		if (rsdp->xsdt_address) {
> +			if (!xsdt->entry[i])
> +				break;
> +			hdr = map_sysmem(xsdt->entry[i], 0);
> +		} else {
> +			if (!rsdt->entry[i])
> +				break;
> +			hdr = map_sysmem(rsdt->entry[i], 0);
> +		}

With a help of temporary variable this can be rewritten as

		tmp = 0; // or NULL, I haven't checked the type.

		if (rsdp->xsdt_address)
			tmp = xsdt->entry[i];
		else
			tmp = rsdt->entry[i];

		if (!tmp)
			break;

		hdr = map_sysmem(tmp, 0);


-- 
With Best Regards,
Andy Shevchenko


