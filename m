Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED10EF99E5
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 23:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7D488367F;
	Sat, 14 Feb 2026 00:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Gqt7ZnF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5484983DE4; Sat, 14 Feb 2026 00:07:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 981D583AA9
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 00:07:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771024022; x=1802560022;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=raIb4haVe5x+r2Bi0Yy2mVIqebf37Ws50YFyfXdUYYQ=;
 b=Gqt7ZnF5yf3DRZ33qN3IgbzLPXnXn7niqE3XAv6tGqJQheYm5gi5tfz2
 ImlIAQOdG4jRRR0kJFrQrk/m0Rb/Qii8lvwrb5TbnVWHzn2PX0j36l1aV
 kYACRWCjPnn7N2f39MSYnDMui9p8E7GPnVXuj9F2au5L5zCLOdH1Uk/It
 8omh9t7t5MweCuhpo8pAuODvh09+jWDrCZummaM/EWTJNtgYlTJRDMBiw
 krRRyG7n4QHXjIduW2o/uZsm95y8DncGcFZU/oAxHC5mWD99JxMK0kMck
 TB+kJrBerkbGO75OPbNridlflw0gLl+Wtb8xfwMRjqt3BUHzFCWRRlYom Q==;
X-CSE-ConnectionGUID: VWKVvkHnSNikaxqMKBJI3g==
X-CSE-MsgGUID: yF5KbO0iSnKXc7wgrlc4xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="72117206"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="72117206"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 15:07:00 -0800
X-CSE-ConnectionGUID: FQERrfCKR0S+UuvSCIgjOQ==
X-CSE-MsgGUID: oxmUgcrCShybtHKmNKNOIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; d="scan'208";a="212152774"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.20])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 15:06:59 -0800
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: Tom Rini <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>,  Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
In-Reply-To: <87o6m16d9b.fsf@jcompost-mobl.amr.corp.intel.com> (Jeremy
 Compostella's message of "Fri, 6 Feb 2026 09:35:44 -0700")
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
 <87a4xnuljz.fsf@jcompost-mobl.amr.corp.intel.com>
 <20260206015056.GO2603314@bill-the-cat>
 <87o6m16d9b.fsf@jcompost-mobl.amr.corp.intel.com>
Date: Fri, 13 Feb 2026 16:06:58 -0700
Message-ID: <87fr74gs4t.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
 CA 95052. USA
MIME-Version: 1.0
X-Mailman-Approved-At: Sat, 14 Feb 2026 00:33:42 +0100
Content-Type: text/plain
Content-Disposition: inline
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

Is there any update on this commit?

Jeremy Compostella <jeremy.compostella@intel.com> writes:

> Tom Rini <trini@konsulko.com> writes:
>
>> On Thu, Feb 05, 2026 at 10:50:24AM -0700, Jeremy Compostella wrote:
>>
>>> Is there anything more I should be doing? This is a bug fix I would
>>> really appreciate seeing merged.
>>
>> It would be nice if someone else reviewed it. It's also been a day since
>> posting. I'll put it in my list to make sure doesn't get lost for the
>> next release, thanks.
>
> Thank you for looking into this. It would indeed help if someone else could review it.
>
>>> Jeremy Compostella <jeremy.compostella@intel.com> writes:
>>> 
>>> > This commit updates the RAM region filtering logic in
>>> > board_get_usable_ram_top() to skip any memory regions whose start address
>>> > is above 4GB. Previously, only the end address was capped at 4GB, but
>>> > regions entirely above this threshold were still considered.
>>> >
>>> > Typically, the following memory map entries would cause
>>> > board_get_usable_ram_top() to return 0x100000000, which is incorrect.
>>> >
>>> >     start=00000000, end=00001000, type=16
>>> >     start=00001000, end=000a0000, type=1
>>> >     start=000a0000, end=000f6000, type=2
>>> >     start=000f6000, end=000f7000, type=16
>>> >     start=000f7000, end=00100000, type=2
>>> >     start=00100000, end=6f170000, type=1
>>> >     start=6f170000, end=70000000, type=16
>>> >     start=70000000, end=80800000, type=2
>>> >     start=e0000000, end=f8000000, type=2
>>> >     start=fa000000, end=fc000000, type=2
>>> >     start=fc800000, end=fc880000, type=2
>>> >     start=fd800000, end=fe800000, type=2
>>> >     start=feb00000, end=feb80000, type=2
>>> >     start=fec00000, end=fed00000, type=2
>>> >     start=fed20000, end=fed80000, type=2
>>> >     start=feda1000, end=feda2000, type=2
>>> >     start=fedc0000, end=fede0000, type=2
>>> >     start=100000000, end=102400000, type=2
>>> >     start=102400000, end=47f800000, type=1
>>> >     start=4000000000, end=4020000000, type=2
>>> >
>>> > By adding a check to continue the loop if the region's start address
>>> > exceeds 0xffffffffULL, the function now properly ignores regions that are
>>> > not usable in 32-bit address space.
>>> >
>>> > Change-Id: I8cbe0281aeea67a2f5bb9f6669456f5c7df9b409
>>> > Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
>>> > ---
>>> >  arch/x86/cpu/coreboot/sdram.c | 2 ++
>>> >  1 file changed, 2 insertions(+)
>>> >
>>> > diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
>>> > index 013225f129a..cc1edd7badd 100644
>>> > --- a/arch/x86/cpu/coreboot/sdram.c
>>> > +++ b/arch/x86/cpu/coreboot/sdram.c
>>> > @@ -42,6 +42,8 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>>> >  			continue;
>>> >  
>>> >  		/* Filter memory over 4GB. */
>>> > +		if (start > 0xffffffffULL)
>>> > +			continue;
>>> >  		if (end > 0xffffffffULL)
>>> >  			end = 0x100000000ULL;
>>> >  		/* Skip this region if it's too small. */
>>> 
>>> -- 
>>> Jeremy
>>> One Emacs to rule them all

-- 
Jeremy
One Emacs to rule them all
