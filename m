Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4D0C35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 03:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A9581B4B;
	Wed, 19 Mar 2025 04:16:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q+S6n5eX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E52A8129F; Tue, 18 Mar 2025 18:39:45 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0A4C81026
 for <u-boot@lists.denx.de>; Tue, 18 Mar 2025 18:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jeremy.compostella@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1742319583; x=1773855583;
 h=from:to:subject:date:message-id:mime-version;
 bh=IngEYi4XZ6JScZgkDXrCLU8HcS6aQcqUSHI+h83BN7A=;
 b=Q+S6n5eXRk93TxemE0ZNII5KdnLdtzGZmaGiaeKCVvXQEF0/eIgOOwJo
 uichYGtAtqk6jlH/qEU72jex9em0Gr2rIdPS0tOYbGvYVOrz+6rnu1Giv
 oGzg8SNumNCF6X/IiQhZOjZuOmzHHXrUFB/OfLtAxVstYYFg2YqSLw6+/
 aLIgmyCU+fOD2QHrWtwZnkzjcnNVOyzIrEnz8GipYNP/snl9vLj84g2SQ
 bTsiytr2FCJqcH3tSGC2aJTrDVrB0Vmhnf3k0UlBSs5JLnfzd4bk9eT1i
 68gylaif8F6/6kEj82XocNzPb6242US05nlRIY2WHPjMH/9X0a6LsHo2i w==;
X-CSE-ConnectionGUID: vVfYGQovRJagOB61r1Bihg==
X-CSE-MsgGUID: fegL+NLBRny00e/oK7yW5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54859172"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="54859172"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:39:42 -0700
X-CSE-ConnectionGUID: WrAjUqEFQtmOtSbLmnf7jg==
X-CSE-MsgGUID: gkwqaXW+RBuf6uCV64P/0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; d="scan'208";a="122068281"
Received: from msatwood-mobl.amr.corp.intel.com (HELO
 jcompost-mobl.amr.corp.intel.com) ([10.125.109.226])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2025 10:39:41 -0700
From: Jeremy Compostella <jeremy.compostella@intel.com>
To: <u-boot@lists.denx.de>
Subject: [PATCH 1/5] arch/x86: Add 64-bit U-Boot configuration without SPL
Date: Tue, 18 Mar 2025 10:39:40 -0700
Message-ID: <877c4mutk3.fsf@jcompost-mobl.amr.corp.intel.com>
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

This commit introduces a new configuration option X86_RUN_64BIT_NO_SPL
to allow building U-Boot as a 64-bit binary without using the SPL
(Secondary Program Loader). The motivation is to simplify the boot
process for certain x86-based platforms that do not require SPL, such as
those booting directly from a 64-bit coreboot firmware.

This update revises the `X86_RUN_64BIT` configuration to more accurately
describe its role as "32-bit SPL followed by 64-bit U-Boot." It
clarifies the sequence of operations during the boot process, where the
system transitions from a 32-bit SPL (Secondary Program Loader) to the
main 64-bit U-Boot.

Signed-off-by: Jeremy Compostella <jeremy.compostella@intel.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 arch/x86/Kconfig              | 10 +++++++++-
 arch/x86/cpu/coreboot/Kconfig |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 006a59d6fa6..dc9483ad723 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -30,7 +30,7 @@ config X86_RUN_32BIT
 	  arch_phys_memset() can be used for basic access to other memory.
 
 config X86_RUN_64BIT
-	bool "64-bit"
+	bool "32-bit SPL followed by 64-bit U-Boot"
 	select X86_64
 	select SPL if !EFI_APP
 	select SPL_SEPARATE_BSS if !EFI_APP
@@ -40,6 +40,14 @@ config X86_RUN_64BIT
 	  runs through the 16-bit and 32-bit init, then switches to 64-bit
 	  mode and jumps to U-Boot proper.
 
+config X86_RUN_64BIT_NO_SPL
+	bool "64-bit"
+	select X86_64
+	help
+          Build U-Boot as a 64-bit binary without SPL. As U-Boot enters
+          in 64-bit mode, the assumption is that the silicon is fully
+          initialized (MP, page tables, etc.).
+
 endchoice
 
 config X86_64
diff --git a/arch/x86/cpu/coreboot/Kconfig b/arch/x86/cpu/coreboot/Kconfig
index 085302c0482..66f25533b97 100644
--- a/arch/x86/cpu/coreboot/Kconfig
+++ b/arch/x86/cpu/coreboot/Kconfig
@@ -26,7 +26,7 @@ config SYS_COREBOOT
 	imply CBMEM_CONSOLE
 	imply X86_TSC_READ_BASE
 	imply USE_PREBOOT
-	select BINMAN if X86_64
+	select BINMAN if X86_RUN_64BIT
 	select SYSINFO
 	imply SYSINFO_EXTRA
 
-- 
2.48.1

