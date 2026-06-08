Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEB4CD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FB4A83EEF;
	Mon,  8 Jun 2026 10:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Qh5eNMCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3298405A; Mon,  8 Jun 2026 10:24:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 366A1807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780907077; x=1812443077;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=7YeHDwUOpQdPuxNGa5veKUp+kuF/Ra+/7TH4ptfZeyA=;
 b=Qh5eNMCVU+0/BYe7YeSqlkdDGBLdazUlaad/dBUKDBmHX/OUbKKAwQtS
 WPFctN32HXixhTdZ2qVJyzDjtlMsOZV3LNO5F7kaLSHoRlgsmmOAFd2i3
 eV+Gl+l2TFODrGewQSu5xBcaAWt/TdPfXy0uMs3QWnjfENr2r5oZMO3uI
 FhJRSroUNO6SyKKTozMCAdeqRnL2px6iNbN7xmwtQMjepKSuX8fvTSPDV
 nmjzmzTXSxw8Jx3JUxAxLe0HijuwmheBMYghpjmj+mKHud6SJxytDOFqj
 6oTJvCnI7tvz1V3z/bEnt3GqVjUdfmNzfz6W62YFTHPJyVAwGyfhlayFn Q==;
X-CSE-ConnectionGUID: lkj0wkshSOixrbuEBKaGmQ==
X-CSE-MsgGUID: pPRJ56UqTZCh7TMNyA9LeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85490525"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85490525"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:24:32 -0700
X-CSE-ConnectionGUID: hJqhxvnZS7epXE8cp/9Vlw==
X-CSE-MsgGUID: iF2HU6kmRPybWw+5C09ohA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245581522"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:24:28 -0700
Date: Mon, 8 Jun 2026 11:24:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 2/5] edison: Widen the DFU auto-probe window for flashing
 U-Boot
Message-ID: <aiZ8NxRN01PeHQ3I@ashevche-desk.local>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607230519.3022520-3-sjg@chromium.org>
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

On Sun, Jun 07, 2026 at 05:05:11PM -0600, Simon Glass wrote:
> On boot the Edison environment opens a brief DFU window (do_probe_dfu) so
> a host can reflash U-Boot over USB before the board continues booting.
> The length of that window is governed by dfu_to_sec, which is 3 seconds.
> 
> Three seconds is not enough, but not because the transfer is slow. The
> window is a hard deadline measured from when do_probe_dfu starts: the dfu
> command records its start time once and never resets it on activity,
> despite the 'inactivity timeout' wording in the command's help. Sending
> U-Boot through the lab uses most of the window before the transfer even
> begins -- the gadget must enumerate, labgrid must detect the resource,
> sync the image and launch dfu-util over SSH, about 3 seconds of setup.
> The 700KB transfer itself takes only about 1.3 seconds (including the
> eMMC write), so the real window usage is roughly 4.4 seconds; a 3-second
> window expires during the setup, before the write can finish.
> 
> Raise dfu_to_sec to 8 to cover the setup and transfer with margin. The
> board waits out this timeout on every boot where no host connects, so
> there is no benefit in making it longer than necessary.

No objection.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


