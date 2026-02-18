Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CEDE9A04A
	for <u-boot@archiver.kernel.org>; Wed, 18 Feb 2026 04:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A40983AC5;
	Wed, 18 Feb 2026 05:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Rewslwnl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A14B83B99; Wed, 18 Feb 2026 03:57:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B450F83AA9
 for <u-boot@lists.denx.de>; Wed, 18 Feb 2026 03:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771383474; x=1802919474;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=yKt22hyPG6pUE36gou4CYVIQDMtYankHGYIMNHkT8pI=;
 b=RewslwnlvndjLNdCGAEMS1OVj4FX/cz/VtBkDogjGTc6U+hTSxm9Yigl
 151VofhVu2uLt5KA7dx46KsnkEJFqP9Bmp5CQwOyXYJwT26TkTtjVf41i
 9WEf9LiuFzbNE+CV7FtF7h/y8fmuuHH24OxFVP5ElR5K+yeYhNcaOodCP
 1mTvsC1lnHOlwG1JHjtQe7+GOXWnmlfC9ksU67OfGdYiGEqOlU3FesjO7
 IxFYD/ufB3IyQhYj4brZOxhvQSBHvz1a1EYQb7gY04izJUaKEDvSetxL6
 wsJTjvKUFSpskc7PFHoBN4BUCTucWH2uevFcxvld2EtdNW/4X5ZGDtKaX Q==;
X-CSE-ConnectionGUID: UP4iOrQ1Sz+mwrGUJiMOBw==
X-CSE-MsgGUID: 9a/sNMl9RV2lfMfV9XhU0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11704"; a="60030872"
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="60030872"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 18:57:52 -0800
X-CSE-ConnectionGUID: YzDuTCcRT3yi3jrCwoxMlw==
X-CSE-MsgGUID: /up0KTjmQc2v/5rFKOXpiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,297,1763452800"; d="scan'208";a="212215688"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.143])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 18:57:51 -0800
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
Cc: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
In-Reply-To: <177127074392.2634449.16645339876724577955.b4-ty@konsulko.com>
 (Tom Rini's message of "Mon, 16 Feb 2026 13:39:03 -0600")
References: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
 <177127074392.2634449.16645339876724577955.b4-ty@konsulko.com>
Date: Tue, 17 Feb 2026 19:57:50 -0700
Message-ID: <87wm0azrkh.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara,
 CA 95052. USA
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 18 Feb 2026 05:26:13 +0100
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

Thank you Tom.

Tom Rini <trini@konsulko.com> writes:

> On Tue, 03 Feb 2026 19:42:36 -0700, Jeremy Compostella wrote:
>
>> This commit updates the RAM region filtering logic in
>> board_get_usable_ram_top() to skip any memory regions whose start address
>> is above 4GB. Previously, only the end address was capped at 4GB, but
>> regions entirely above this threshold were still considered.
>> 
>> Typically, the following memory map entries would cause
>> board_get_usable_ram_top() to return 0x100000000, which is incorrect.
>> 
>> [...]
>
> Applied to u-boot/master, thanks!
>
> [1/1] x86/coreboot: Exclude memory regions starting above 4GB
>       commit: 8666b16015d4212facacc514e2eb626f3630dcf0

-- 
Jeremy
One Emacs to rule them all
