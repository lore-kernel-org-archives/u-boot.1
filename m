Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE7BECD9AF
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 22:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AC1383B5E;
	Thu,  5 Feb 2026 23:07:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GPQCrVeG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27ED83B5E; Thu,  5 Feb 2026 18:50:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 007D5838FA
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 18:50:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770313828; x=1801849828;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=dcbEMq13idMGMA5nFNTTMLafYuVAXhpVzgyqNl1K27c=;
 b=GPQCrVeG0TVn5lPwX9afv6LhVKpT67z3nvgC/7lb5YHtCbe3RqbGh3W0
 kTXKrMTFpph3iA86dYGcsvI3alY8zzyjGB5y9K7fBYjhKV9OUkfyO0Qhk
 lqv5miMRLHqWcEh5dUC2U6zv37Rl5vn38xn7+dYBL+umSzneuLzMDFgAk
 aCn8Mqkhta1gYPIGyzLgvrpl6Gw+fba2hC93YkJ5s2kKvzgP9z2zn4beB
 FTWhvUFPYVhhX0MupD/eaUkL5uo4fmOtu/pTW5QrkA8QX/okj7Ccfk1Q7
 u9sAX8maLVKOC721HdMY42NkFmXcKav3dqrj/x2ZL8NACcm9xmbMbrnhk w==;
X-CSE-ConnectionGUID: 7mYYuyMRR5KXb4N5rf89WQ==
X-CSE-MsgGUID: v/6x2OAfTWqSJDMLmgBnVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="71617490"
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; d="scan'208";a="71617490"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 09:50:26 -0800
X-CSE-ConnectionGUID: 1THFv6H7ToGq4fnX1nrjLw==
X-CSE-MsgGUID: YWOW+QDKSE2SxCqD4hTrPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,275,1763452800"; d="scan'208";a="215129144"
Received: from aschende-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.111.99])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 09:50:27 -0800
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
In-Reply-To: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com> (Jeremy
 Compostella's message of "Tue, 3 Feb 2026 19:42:36 -0700")
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
Date: Thu, 05 Feb 2026 10:50:24 -0700
Message-ID: <87a4xnuljz.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
 CA 95052. USA
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 05 Feb 2026 23:07:24 +0100
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

Is there anything more I should be doing? This is a bug fix I would really appreciate seeing merged.

Regards,
Jeremy

Jeremy Compostella <jeremy.compostella@intel.com> writes:

> This commit updates the RAM region filtering logic in
> board_get_usable_ram_top() to skip any memory regions whose start address
> is above 4GB. Previously, only the end address was capped at 4GB, but
> regions entirely above this threshold were still considered.
>
> Typically, the following memory map entries would cause
> board_get_usable_ram_top() to return 0x100000000, which is incorrect.
>
>     start=00000000, end=00001000, type=16
>     start=00001000, end=000a0000, type=1
>     start=000a0000, end=000f6000, type=2
>     start=000f6000, end=000f7000, type=16
>     start=000f7000, end=00100000, type=2
>     start=00100000, end=6f170000, type=1
>     start=6f170000, end=70000000, type=16
>     start=70000000, end=80800000, type=2
>     start=e0000000, end=f8000000, type=2
>     start=fa000000, end=fc000000, type=2
>     start=fc800000, end=fc880000, type=2
>     start=fd800000, end=fe800000, type=2
>     start=feb00000, end=feb80000, type=2
>     start=fec00000, end=fed00000, type=2
>     start=fed20000, end=fed80000, type=2
>     start=feda1000, end=feda2000, type=2
>     start=fedc0000, end=fede0000, type=2
>     start=100000000, end=102400000, type=2
>     start=102400000, end=47f800000, type=1
>     start=4000000000, end=4020000000, type=2
>
> By adding a check to continue the loop if the region's start address
> exceeds 0xffffffffULL, the function now properly ignores regions that are
> not usable in 32-bit address space.
>
> Change-Id: I8cbe0281aeea67a2f5bb9f6669456f5c7df9b409
> Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
> ---
>  arch/x86/cpu/coreboot/sdram.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
> index 013225f129a..cc1edd7badd 100644
> --- a/arch/x86/cpu/coreboot/sdram.c
> +++ b/arch/x86/cpu/coreboot/sdram.c
> @@ -42,6 +42,8 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  			continue;
>  
>  		/* Filter memory over 4GB. */
> +		if (start > 0xffffffffULL)
> +			continue;
>  		if (end > 0xffffffffULL)
>  			end = 0x100000000ULL;
>  		/* Skip this region if it's too small. */

-- 
Jeremy
One Emacs to rule them all
