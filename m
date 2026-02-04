Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97780E95363
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 09:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D3583B55;
	Wed,  4 Feb 2026 10:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D0zDDw0U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3478B83A24; Wed,  4 Feb 2026 03:42:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AC01839D5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 03:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770172961; x=1801708961;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=H3wNjeunb1xFQApzsfjGkr8qkNZbVeeD7UnaPab/Xow=;
 b=D0zDDw0U9fUanaG87TCf2v8YOhg/zfzki+uf73Zxfi2Uy2ODwvMzk56l
 pJZ+Inw6faSmB3IyheCbohD/vYRONttjG2RETC79R5AChbndiwh+HzLXS
 dPWhDimN1AweY8M0EsLUi1Krdb4Zit3VcwGcbaRamy4F0HT0NBAgEzCqS
 CkuKllA9tAYA/oUl/cGkP0GDynm7YWo8MujFYmODNnvqZvZdfFCxlJU6y
 c8zsccJgAyMTqQXV79zfAiHwAI6rc5pARQL5rov4D4Ydu+9HLXGgIwj+z
 KvRwyrBFQUmOoJJLHsoPM/NMmz5pf3e8MXAL2f7JFgzLLer0EtFj0MQ6l A==;
X-CSE-ConnectionGUID: EttcW4/ITZW7JycuUIwU6w==
X-CSE-MsgGUID: VO++Ih7PRRSLztCqsMZ0Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="58932990"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; d="scan'208";a="58932990"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 18:42:38 -0800
X-CSE-ConnectionGUID: 5tMIbtLwTHOde8GV7G+ddw==
X-CSE-MsgGUID: OXVYGB8SRp+pcjD6WhPT7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; d="scan'208";a="209323206"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.110.217])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Feb 2026 18:42:38 -0800
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] x86/coreboot: Exclude memory regions starting above 4GB
Date: Tue, 03 Feb 2026 19:42:36 -0700
Message-ID: <87qzr1z0tf.fsf@jcompost-mobl.amr.corp.intel.com>
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
 95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 04 Feb 2026 10:34:46 +0100
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

This commit updates the RAM region filtering logic in
board_get_usable_ram_top() to skip any memory regions whose start address
is above 4GB. Previously, only the end address was capped at 4GB, but
regions entirely above this threshold were still considered.

Typically, the following memory map entries would cause
board_get_usable_ram_top() to return 0x100000000, which is incorrect.

    start=00000000, end=00001000, type=16
    start=00001000, end=000a0000, type=1
    start=000a0000, end=000f6000, type=2
    start=000f6000, end=000f7000, type=16
    start=000f7000, end=00100000, type=2
    start=00100000, end=6f170000, type=1
    start=6f170000, end=70000000, type=16
    start=70000000, end=80800000, type=2
    start=e0000000, end=f8000000, type=2
    start=fa000000, end=fc000000, type=2
    start=fc800000, end=fc880000, type=2
    start=fd800000, end=fe800000, type=2
    start=feb00000, end=feb80000, type=2
    start=fec00000, end=fed00000, type=2
    start=fed20000, end=fed80000, type=2
    start=feda1000, end=feda2000, type=2
    start=fedc0000, end=fede0000, type=2
    start=100000000, end=102400000, type=2
    start=102400000, end=47f800000, type=1
    start=4000000000, end=4020000000, type=2

By adding a check to continue the loop if the region's start address
exceeds 0xffffffffULL, the function now properly ignores regions that are
not usable in 32-bit address space.

Change-Id: I8cbe0281aeea67a2f5bb9f6669456f5c7df9b409
Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
---
 arch/x86/cpu/coreboot/sdram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
index 013225f129a..cc1edd7badd 100644
--- a/arch/x86/cpu/coreboot/sdram.c
+++ b/arch/x86/cpu/coreboot/sdram.c
@@ -42,6 +42,8 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 			continue;
 
 		/* Filter memory over 4GB. */
+		if (start > 0xffffffffULL)
+			continue;
 		if (end > 0xffffffffULL)
 			end = 0x100000000ULL;
 		/* Skip this region if it's too small. */
-- 
2.52.0

