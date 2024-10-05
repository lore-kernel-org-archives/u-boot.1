Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B24CFB42B
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79116889E2;
	Sat,  5 Oct 2024 21:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RDbqR0NQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA04888965; Sat,  5 Oct 2024 21:14:03 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55BAB889C3
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Authentication-Results: phobos.denx.de; spf=none
 smtp.mailfrom=andriy.shevchenko@linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728155641; x=1759691641;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lbKZqmnzP7iNMNg3WtuORGVysjy5I/Lh6r80FgNa3a0=;
 b=RDbqR0NQt/TxOzZJYbDNuEnRNlfDot4BzANO26XMgVYDpckG3SibAQof
 IF0AKX91Py5fd7q+lCysc0XtCn+ktwnwUUVBJfxzLVryGEvTYS+LWPmNN
 49gdDI6KlEWXAWo+lPNZu/fyL0w6lM+hd6PMnFWUCcz6wjolLzCl9M9bC
 UAJja5y2i5sZsy87juHpEagk3bQhLs37LuRv1E7xD/zp4SuvsUUTMYq09
 jT+1e+e5YExAkVhGVhVLp3gjTgmeFAEfoiPpC/NMyRqqq2+kOpl6iL+KL
 zZ9T6TLptC573HBW4/wtE0f3rT0mdduBZXtCeGThKAwUPWUYj6T5XoiUM g==;
X-CSE-ConnectionGUID: rDUteHT1SnS6ajgsSlroJA==
X-CSE-MsgGUID: Wc+LxhsOT9eaag9PufANlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11216"; a="31145940"
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="31145940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2024 12:13:59 -0700
X-CSE-ConnectionGUID: OB3xOJN1T0WNsJS/iLt9nw==
X-CSE-MsgGUID: UpgEaepzSEK8dyaKrb9iJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,181,1725346800"; d="scan'208";a="75370839"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmviesa010.fm.intel.com with ESMTP; 05 Oct 2024 12:13:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 0A318197; Sat, 05 Oct 2024 22:13:56 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tom Rini <trini@konsulko.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v1 2/4] x86: cpu: Mark a few functions static
Date: Sat,  5 Oct 2024 22:11:58 +0300
Message-ID: <20241005191353.1927660-3-andriy.shevchenko@linux.intel.com>
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

Some functions are not used anywhere except the same file
where they are defined. Mark them static. This helps avoiding
the compiler warnings:

  arch/x86/cpu/cpu.c:343:6: warning: no previous prototype for ‘detect_coreboot_table_at’ [-Wmissing-prototypes]
  arch/x86/cpu/mtrr.c:90:6: warning: no previous prototype for ‘mtrr_write_all’ [-Wmissing-prototypes]
  arch/x86/cpu/i386/interrupt.c:240:6: warning: no previous prototype for ‘__do_irq’ [-Wmissing-prototypes]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/cpu/cpu.c            | 2 +-
 arch/x86/cpu/i386/interrupt.c | 2 +-
 arch/x86/cpu/mtrr.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/cpu/cpu.c b/arch/x86/cpu/cpu.c
index 3aa35b811b36..e9300709347e 100644
--- a/arch/x86/cpu/cpu.c
+++ b/arch/x86/cpu/cpu.c
@@ -340,7 +340,7 @@ int reserve_arch(void)
 }
 #endif
 
-long detect_coreboot_table_at(ulong start, ulong size)
+static long detect_coreboot_table_at(ulong start, ulong size)
 {
 	u32 *ptr, *end;
 
diff --git a/arch/x86/cpu/i386/interrupt.c b/arch/x86/cpu/i386/interrupt.c
index b3f4214acdb7..6f78b072cde5 100644
--- a/arch/x86/cpu/i386/interrupt.c
+++ b/arch/x86/cpu/i386/interrupt.c
@@ -237,7 +237,7 @@ void *x86_get_idt(void)
 	return &idt_ptr;
 }
 
-void __do_irq(int irq)
+static void __do_irq(int irq)
 {
 	printf("Unhandled IRQ : %d\n", irq);
 }
diff --git a/arch/x86/cpu/mtrr.c b/arch/x86/cpu/mtrr.c
index 50cba5fb88dc..07ea89162dee 100644
--- a/arch/x86/cpu/mtrr.c
+++ b/arch/x86/cpu/mtrr.c
@@ -87,7 +87,7 @@ void mtrr_read_all(struct mtrr_info *info)
 	}
 }
 
-void mtrr_write_all(struct mtrr_info *info)
+static void mtrr_write_all(struct mtrr_info *info)
 {
 	int reg_count = mtrr_get_var_count();
 	struct mtrr_state state;
-- 
2.43.0.rc1.1336.g36b5255a03ac

