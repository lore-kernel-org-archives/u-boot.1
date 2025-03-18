Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081CAC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF72B81D0B;
	Wed, 19 Mar 2025 04:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WztX7fMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94159800B6; Tue, 18 Mar 2025 18:40:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22BBA800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:40:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319638; x=1773855638;
 h=from:to:subject:date:message-id:mime-version;
 bh=WdYZZ6tCGnVG8BlzG+Vnmm4aU2sIcZlXmu4cdRzr0Zo=;
 b=WztX7fMgy/GKoYI0nXIWIfwpXRJU16TeXxQCA1jx1G0ugW3UQUVNp0lT
 lzla/Wx3e2j2YQjMEjNUmrhOdtpZMmSFfDjW44D9YM1mOMFlTo9Nmy5y9
 AdINqeoy7xxeP6mh/vTWrXByQK5YmbOYiErDK4jVU6+2vtSDiTtwXSOtU
 csEmZrfgseTpWi+uMDcFycX8c30KCXJ9a91NxvVLUWFwSdrdrJnp8qNpF
 k4mTmSpK3z1yMQlqHhWp3jEWgzNkbaUPBhFrk1lN/6/JC85MvYCB70SQ8
 FnPOd89TfhxRXCzQcxUQHHbaqf9nDxaye9u5V9ZCj6E2n00lu3f8VU5N8 w==;
X-CSE-ConnectionGUID: sSFl5DOxQNCpZ9pPssB92A==
X-CSE-MsgGUID: WVBqSwjRQCKBr+gunKyj2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="42725886"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="42725886"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:40:36 -0700
X-CSE-ConnectionGUID: NMhgehzEQSGPeVJWodUnnw==
X-CSE-MsgGUID: Kd3CWKBbSe2HTZfp9c5RMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122314261"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:40:35 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH 3/5] arch/x86/lib: Fix CONFIG_X86_64 usage in zimage.c
Date: Tue, 18 Mar 2025 10:40:34 -0700
Message-ID: <87y0x2tey5.fsf@jcompost-mobl.amr.corp.intel.com>
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

Correct the preprocessor directive used to check for 64-bit kernel
support in the `zboot_go` function. The code previously checked for
`CONFIG_X86_RUN_64BIT`, which is not the correct configuration option
for determining if the kernel should run in 64-bit mode. The correct
option is `CONFIG_X86_64`.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/x86/lib/zimage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/zimage.c b/arch/x86/lib/zimage.c
index 2eece34a073..ca3bd713ff2 100644
--- a/arch/x86/lib/zimage.c
+++ b/arch/x86/lib/zimage.c
@@ -424,7 +424,7 @@ int zboot_go(void)
 
 	entry = state.load_address;
 	image_64bit = false;
-	if (IS_ENABLED(CONFIG_X86_RUN_64BIT) &&
+	if (IS_ENABLED(CONFIG_X86_64) &&
 	    (hdr->xloadflags & XLF_KERNEL_64)) {
 		image_64bit = true;
 	}
-- 
2.48.1

