Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21191CFB42C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:14:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FE388B23;
	Sat,  5 Oct 2024 21:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="J9ER3/BD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0B5B88B23; Sat,  5 Oct 2024 21:14:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B58B88A1B
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728155642; x=1759691642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RO+HB/r+po5J9uZ3EzRgf88/1GAoSPy3BWsJr/mstJk=;
 b=J9ER3/BD9NVDwaxuTQg9UdXY1YEONleDrxnbbUAqjRmLR3+H2G34DZim
 x9lltWvYokaeC362zuN+HI9QiVuvQCflhkdYVZ9eNirHbFo7aXLp/8iKp
 fZLpT1oJtKE30HTLTvn+F7EHj3BijUoJMXcOXkMIRw2tKvvB3MfKY7Z1f
 opldT9Uxhc64zStz3PsrwVYTioWKKKwSLZCDVjGWf3nzdHhzZ6IyZh/ab
 qM7jihUDAVlv06XwffSO37Gi0BQ9mQNen/DY1G+b7rXrs/ySKW0FRROps
 7YGQjM9/lgnjyru4+RYbt8jJEExBwwcZMJOZpbdbTqlkB9cF9UxoQVVDr g==;
X-CSE-ConnectionGUID: HpkoLxQhTH68mVRe27bYnA==
X-CSE-MsgGUID: ccM7hRB0S3efTVAXiBy+dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="31145943"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="31145943"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2024 12:13:59 -0700
X-CSE-ConnectionGUID: 8uf4PZkFTwiqCtF2EDppag==
X-CSE-MsgGUID: nnvM4+hoQvSBSVP8wVqNZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="75370840"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa010.fm.intel.com with ESMTP; 05 Oct 2024 12:13:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 1DCD04BB; Sat, 05 Oct 2024 22:13:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 3/4] x86: cpu: Add a few prototypes to the header file
Date: Sat,  5 Oct 2024 22:11:59 +0300
Message-ID: <20241005191353.1927660-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
In-Reply-To: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
References: <20241005191353.1927660-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The compiler is not happy to have no prototypes for the functions that
are not defined static. Add them. This helps avoiding the compiler warnings:

  arch/x86/cpu/cpu.c:197:13: warning: no previous prototype for ‘board_final_init’ [-Wmissing-prototypes]
  arch/x86/cpu/cpu.c:205:13: warning: no previous prototype for ‘board_final_cleanup’ [-Wmissing-prototypes]
  arch/x86/cpu/cpu.c:307:5: warning: no previous prototype for ‘reserve_arch’ [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 073f80b07f10..d71bc1b80c05 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -298,4 +298,11 @@ u32 cpu_get_stepping(void);
  */
 int cpu_phys_address_size(void);
 
+void board_final_init(void);
+void board_final_cleanup(void);
+
+#ifndef CONFIG_EFI_STUB
+int reserve_arch(void);
+#endif
+
 #endif
-- 
2.43.0.rc1.1336.g36b5255a03ac

