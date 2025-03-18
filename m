Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E10C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30D0D81D42;
	Wed, 19 Mar 2025 04:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J9XRIvqn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BD34810F4; Tue, 18 Mar 2025 18:41:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B50800B6
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:41:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319701; x=1773855701;
 h=from:to:subject:date:message-id:mime-version;
 bh=aXFMy1uMrTzADuaexFZEaQAqbJWp8UJjaPqOj2vBgzY=;
 b=J9XRIvqnWqQC187PgsIgiHCUB3AKogEKa5QA7szcXaZhow0vHmN23ovW
 9PcOoJomi779AoftNvK5tra1InWmUxv1zWJrDXszTJIVZREOt25AJf6zw
 RPARtDn+SIRWc33XUKcv2iKYdYPoDP/bFIIiI/qCuOWCRHZgH9mdysLaF
 K3wPOsMarXX9bXZP69ZVQ7PODKGMPCItytoKCVwJWmE3nt03xP8eRN1ZB
 K1ITq4hvG0aEK1J9ENju2yqiQ5jaWKKdjQy2sVlnMxL6t678a78gBqpX/
 z6gRLogj/W5NAPU4FL7DY15NYCFjNx24p8XOiS2gpuVnx58KlF/q4U2vM Q==;
X-CSE-ConnectionGUID: xhw0dMooQCy3JE4BO5WoVQ==
X-CSE-MsgGUID: WP9Eh4rZT82ZLjWuzeqfow==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54859404"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="54859404"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:41:40 -0700
X-CSE-ConnectionGUID: WcCDmNvmS3q4XIsdtp0jpg==
X-CSE-MsgGUID: H5dYMgs4RD2xKUlTrcrXcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="159489426"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:41:39 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH 4/5] Fix EFI boot file name definition for 64-bit x86
Date: Tue, 18 Mar 2025 10:41:38 -0700
Message-ID: <87tt7qtewd.fsf@jcompost-mobl.amr.corp.intel.com>
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

This change aligns the preprocessor directive with the standard
configuration flag used for detecting 64-bit x86 architecture.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 include/config_distro_bootcmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/config_distro_bootcmd.h b/include/config_distro_bootcmd.h
index 0a4e4b8ff85..8ac3a4feeb8 100644
--- a/include/config_distro_bootcmd.h
+++ b/include/config_distro_bootcmd.h
@@ -112,7 +112,7 @@
 #define BOOTEFI_NAME "bootarm.efi"
 #elif defined(CONFIG_X86_RUN_32BIT)
 #define BOOTEFI_NAME "bootia32.efi"
-#elif defined(CONFIG_X86_RUN_64BIT)
+#elif defined(CONFIG_X86_64)
 #define BOOTEFI_NAME "bootx64.efi"
 #elif defined(CONFIG_ARCH_RV32I)
 #define BOOTEFI_NAME "bootriscv32.efi"
-- 
2.48.1

