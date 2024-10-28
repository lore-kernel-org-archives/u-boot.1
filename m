Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D0DD13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 07:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E33389072;
	Mon, 28 Oct 2024 08:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TNwZ4jwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08E788EAE; Mon, 28 Oct 2024 08:53:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AD87881FD
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 08:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730102024; x=1761638024;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=s9Gh3GvNxcL9DZ8+rO6h3wwJropK3DsgFTqZS8BMnKw=;
 b=TNwZ4jwgYXQLbdrHQ/d6gPeqDHrbuCuOkXsVyHQrcoDm2fIj7aG6yu/0
 vFU/jJrSfEP3nwSd1RjXT1KaMbBqw8BZp4Npxp0OE01rVtSjvRPJuC112
 Bie9CQlVFbCrXmmI2Fx3jQHNc3l2HC4VMfP8Z8n5ugF/+6cyElg4YRIzA
 DKLYR/5AXKkUrJXy9/RaBTaDrsNK3J4pGwXDYEgCH0w8mlPN/cwJuJkxK
 Lvp/QYl9EFdHgREwQaPRzPJTtiTuqUD58PvnzaSla1jgyObv6+eAhleTN
 VNq1omUjZ+pRl2vzarfJrKLmN2e73Rf3G3nwEtq2IfLXfyyfDB3rhes1R w==;
X-CSE-ConnectionGUID: RvXAaZ40Ti2go3MBGxnX7Q==
X-CSE-MsgGUID: 6fHxnoSETrisHUAMa3DIbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29549173"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="29549173"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 00:53:43 -0700
X-CSE-ConnectionGUID: IHLVUPirRZqPQL6oLVetKg==
X-CSE-MsgGUID: lq1NwTasTnO1VVTp/fybDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; d="scan'208";a="104862427"
Received: from smile.fi.intel.com ([10.237.72.154])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2024 00:53:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1t5KZF-00000007r1w-3aWQ; Mon, 28 Oct 2024 09:53:37 +0200
Date: Mon, 28 Oct 2024 09:53:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: xypron.glpk@gmx.de, Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] efi_loader: Mark efi_bootmgr_release_uridp as static
Message-ID: <Zx9DAX71XyQdrClq@smile.fi.intel.com>
References: <20241026073734.102723-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026073734.102723-1-ilias.apalodimas@linaro.org>
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

On Sat, Oct 26, 2024 at 10:37:32AM +0300, Ilias Apalodimas wrote:
> This is only used locally so make it static

Missing period at the end.
Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


