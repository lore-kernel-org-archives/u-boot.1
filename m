Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A60FD2FFFA
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 15:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B9B088BBE;
	Fri, 18 Oct 2024 17:56:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ElnNlrTw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609F288BB2; Fri, 18 Oct 2024 17:56:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A489488BBE
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 17:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729266965; x=1760802965;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Ity7Ryj6fYUY9Go+UBiFF26Ot/Aqyzya1jXawG6eFAw=;
 b=ElnNlrTwN9CNa9aqs2HzFO55gwAjlaT9t9P9bodnXi00sStBjltYzpPG
 uQrOSnEgunXHGcUC6MosIrumVAHkxAiiVsCo4v63ZX71pZWLdu22Kft5R
 hQTsXPW+nVMmD0Q0088DxrczzjStfi1dLkT8pPX1EeQYy/I0knxh5/lO8
 G6Z+igkV0+U0k9i1Un58BxjDwAnO1/Wm6rwLt/akWh0Ylu7YOcYWoZ10n
 Gn+dvXkH2muLl/YSFPGvHaWLjWdEVwgbLL8Hv/6t89waSfrwqjxesT0/8
 6nKJyIr33zBa7iZFfkPbGQfZDo3xZap8WInhGVfmY5B1WRKbMtQZ0DB4L Q==;
X-CSE-ConnectionGUID: LyPzAk0HT7y/5vl/g/KoEQ==
X-CSE-MsgGUID: wEvvN0NlRp6jnUR29n96xw==
X-IronPort-AV: E=McAfee;i="6700,10204,11229"; a="28263503"
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="28263503"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 08:56:02 -0700
X-CSE-ConnectionGUID: SVmo3QszRraLpB6JFNqLtw==
X-CSE-MsgGUID: ANpkNNupQyO8o3tMdLlcEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,214,1725346800"; d="scan'208";a="79246814"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa010.fm.intel.com with ESMTP; 18 Oct 2024 08:56:01 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 01EE1256; Fri, 18 Oct 2024 18:55:59 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/1] x86: cpu: Describe board final hooks in the header
Date: Fri, 18 Oct 2024 18:55:57 +0300
Message-ID: <20241018155557.2184819-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The new two declarations board_final_init() and board_final_cleanup()
need a description. Add it here.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/cpu.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index d71bc1b80c05..a5b2043f7de1 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -298,7 +298,20 @@ u32 cpu_get_stepping(void);
  */
 int cpu_phys_address_size(void);
 
+/**
+ * board_final_init() - Final initialization hook (optional)
+ *
+ * Implements a custom initialization for boards that need to do it
+ * before the system is ready.
+ */
 void board_final_init(void);
+
+/**
+ * board_final_cleanup() - Final cleanup hook (optional)
+ *
+ * Implements a custom cleanup for boards that need to do it before
+ * booting the OS.
+ */
 void board_final_cleanup(void);
 
 #ifndef CONFIG_EFI_STUB
-- 
2.43.0.rc1.1336.g36b5255a03ac

