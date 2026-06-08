Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73DB5CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:27:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 051EA8481F;
	Mon,  8 Jun 2026 10:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jz1Kj2Zn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B5B083EEF; Mon,  8 Jun 2026 10:27:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D6CE8481F
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780907240; x=1812443240;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=R7qiVSArvuwpI1nFsi+8LLPfqTtrpCr6iyMTsWiC2mU=;
 b=jz1Kj2ZnJUVNNYp5930WTA+slr1hFdSn4IR7Z5Rc+Xs4lEdwc21m9myj
 FL0DlE+7A6QjHCqXFF+CJ3vSeIVQTe7gaUyukB62NS51ls7Au7DLya6uY
 jc9ltcQa+i/Q13U/WGv8jMDGbCd/mdGk1bygvArU+6HY25M9nx9+Zv8YN
 Y3wf1DUqd+IDRNcQ+UcK6tSk8KKu+Pzm2D4NML6eRE1TvX3ESJFBfXPY1
 ZygZ6l5+sdkk+/nXwssdNdjOzhzHm8vmZrHd4gIsaqBvbQSYyvwDRtQ0b
 TTAuFmegr6vH02weRMWG9BYYXFMWnF51owT2idNlXQUBvfQfZJqE+g5RC g==;
X-CSE-ConnectionGUID: lKvmhSz5TFe+nInZ7nCQMw==
X-CSE-MsgGUID: ZrTM5NNuTAuV3tRjGTwNZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85490744"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85490744"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:27:18 -0700
X-CSE-ConnectionGUID: Pw59cFo6T7OxF6yaYGIsbQ==
X-CSE-MsgGUID: wBRElE0DSbGhbKMnFGPqGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245581762"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:27:15 -0700
Date: Mon, 8 Jun 2026 11:27:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
Message-ID: <aiZ84c8pgWwDzJbq@ashevche-desk.local>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607230519.3022520-4-sjg@chromium.org>
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

On Sun, Jun 07, 2026 at 05:05:12PM -0600, Simon Glass wrote:
> The mask ROM loads the OS image to 0x01100000 but enters it at
> 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
> was arranged by board/intel/edison/config.mk, which prepended 4096 zero
> bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
> recipe moved its output back over u-boot.bin.
> 
> Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
> that rule from running, so u-boot.bin no longer gains the 4KB prefix.
> The mask ROM then jumps 4KB into U-Boot's code and the board never
> starts, sitting in BootROM download mode (DnX) and cycling.
> 
> Since the Edison image is assembled by binman, provide the gap there
> instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
> Drop the now-redundant alignment hack from the board config.mk.

Nice!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


