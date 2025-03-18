Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09C7C35FF3
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A90A81CA8;
	Wed, 19 Mar 2025 04:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iGPcHpSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A60BB810F4; Tue, 18 Mar 2025 18:40:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BD9E800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319606; x=1773855606;
 h=from:to:subject:date:message-id:mime-version;
 bh=TmAAyuoJ/qVi+WITm1jbk0IdZupcgc1HgX2N1ex/1IQ=;
 b=iGPcHpSzDENOlj5TQ2lvADD5KblRsRYsWJtZwG38sYPrwVGpKnV0po1R
 1z7ArWsol9T2ENGOTih31BXIhSdC1fjSST9DLbyBVZFsBbzaHBAubZI7m
 GwaQH1DKuUa0bL0Eimrnqqv6eTrBaf62ZOfUN30GtjxtQgxOBhIFdGXn9
 Cf4KAB5FoepgwsytPNhvA96RvjSVkLZSl0U+e567ZdOJtcfXxPJOUdqG1
 9Vj8UELORkxz9MbE+knK9pyX96mDxzEbH7+JtWuPfgJOHXFoCXOw3gDZW
 LASICj8PS84w6pVykIqqR208ZgpTxeOwm3bpsb1DKaFFL0SyRzqzJ/2V3 A==;
X-CSE-ConnectionGUID: h+wNNZzfT0SXfjAbASBu8g==
X-CSE-MsgGUID: dDX0cp6ySgGIazZiHt90wA==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="65940593"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="65940593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:40:05 -0700
X-CSE-ConnectionGUID: 6obmHCwgQnWYmFpt7+IXaw==
X-CSE-MsgGUID: 18FawFFeQdCsOxGxKwiMgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122512821"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:40:04 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH 2/5] arch/x86/cpu: Call x86_cpu_reinit_f for 64-bits
Date: Tue, 18 Mar 2025 10:40:03 -0700
Message-ID: <8734fautjg.fsf@jcompost-mobl.amr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Organization: Intel Corporation - 2200 Mission College Blvd. Santa Clara, CA
 95052. USA
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 19 Mar 2025 04:16:48 +0100
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

As both CONFIG_X86_RUN_64BIT and X86_RUN_64BIT_NO_SPL cases run U-Boot
in 64-bit mode with the CPU fully initialized already.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/x86/cpu/coreboot/coreboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/cpu/coreboot/coreboot.c b/arch/x86/cpu/coreboot/coreboot.c
index fa7430b436f..d0719d1a405 100644
--- a/arch/x86/cpu/coreboot/coreboot.c
+++ b/arch/x86/cpu/coreboot/coreboot.c
@@ -22,7 +22,7 @@ int arch_cpu_init(void)
 {
 	int ret;
 
-	ret = IS_ENABLED(CONFIG_X86_RUN_64BIT) ? x86_cpu_reinit_f() :
+	ret = IS_ENABLED(CONFIG_X86_64) ? x86_cpu_reinit_f() :
 		x86_cpu_init_f();
 	if (ret)
 		return ret;
-- 
2.48.1

