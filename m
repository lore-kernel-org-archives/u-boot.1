Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D792CCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C8E484154;
	Mon,  8 Jun 2026 10:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YeVLyq8T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4EAB846B1; Mon,  8 Jun 2026 10:29:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7759583EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780907362; x=1812443362;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YoGvx/RULzW0g19DoO5Lym0+TU/vwt2j4xnBttn9/XM=;
 b=YeVLyq8T0BRarE7QHcIgUZ3SZQU5pF7vVBUwDQe2n60QpYi5YWvW3Ziu
 /jvMGSFDQDNO1tFu5tgrfo7vN2SAJKhW/Jjx1/PRT9Jiuds7nWNV2GUbE
 Ocnfeg6IefMhb7Uv83opdbiOHqpPD0pO8X2P6b1yvTGzXPWag4c3ZyzBs
 bXi6yEBghtOEkMNnEq8CEO5ETrqic5ERoce9YCtXRfMFnqEMd0Vdkh9kh
 ciJu0NkWDToID170dNni/cIiFXV2RwfzYaNZl8dYerQkt7oEAgYURa8rA
 pk9cJPMTUCs7BXBi210KQYMmrgTu5ABL5dUlWIGqLBbLvFIZP4VDn/PDB Q==;
X-CSE-ConnectionGUID: SdyAfQ6tSFqtHwdb3FI0oA==
X-CSE-MsgGUID: L6OxiFHwQtqKDCWiwN/58g==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="85491081"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="85491081"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:29:20 -0700
X-CSE-ConnectionGUID: oQZMBTSLRZGnuXWAXApeeQ==
X-CSE-MsgGUID: CCkqT3djRdWAXINV5REUKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245581896"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.110])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 01:29:17 -0700
Date: Mon, 8 Jun 2026 11:29:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>
Subject: Re: [PATCH 3/5] x86: edison: Align U-Boot via binman to fix the boot
Message-ID: <aiZ9W3ClrZ-B31VD@ashevche-desk.local>
References: <20260607230519.3022520-1-sjg@chromium.org>
 <20260607230519.3022520-4-sjg@chromium.org>
 <20260607234726.GF382693@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607234726.GF382693@bill-the-cat>
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

On Sun, Jun 07, 2026 at 05:47:26PM -0600, Tom Rini wrote:
> On Sun, Jun 07, 2026 at 05:05:12PM -0600, Simon Glass wrote:
> 
> > The mask ROM loads the OS image to 0x01100000 but enters it at
> > 0x01101000, so U-Boot must sit 0x1000 (4KB) into the loaded image. This
> > was arranged by board/intel/edison/config.mk, which prepended 4096 zero
> > bytes to u-boot.bin through an 'INPUTS-y += u-boot-align.bin' rule whose
> > recipe moved its output back over u-boot.bin.
> > 
> > Commit bd3f9ee679b4 ("kbuild: Bump the build system to 6.1") stopped
> > that rule from running, so u-boot.bin no longer gains the 4KB prefix.
> > The mask ROM then jumps 4KB into U-Boot's code and the board never
> > starts, sitting in BootROM download mode (DnX) and cycling.
> > 
> > Since the Edison image is assembled by binman, provide the gap there
> > instead: pad with a 'fill' of 4096 zero bytes ahead of the u-boot entry.
> > Drop the now-redundant alignment hack from the board config.mk.
> > 
> > Fixes: bd3f9ee679b4 ("kbuild: Bump the build system to 6.1")
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> 
> That's an unintentional behavior change we should understand why
> happened, and then do whatever needs to be done to fix it, so that other
> platforms that might have been in a similar spot can also be fixed.

While I agree on this, the Intel Edison case gets rectified by this series in
terms of getting rid of the known hack as Simon mentioned. Yes, it was me who
invented that hack long time ago for quicker ramping up the board.

-- 
With Best Regards,
Andy Shevchenko


