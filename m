Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8DAC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A0AB881257;
	Wed, 29 Jul 2026 12:28:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WYfB1K356_Qf; Wed, 29 Jul 2026 12:28:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6963281242
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328105;
	bh=WK2wuBNb/QNky79EhjWHMDBWV12WJYi6AjkpK0Z3qWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EgZ4m/hiKVfnN9ZEj7pIypv1CsqWxbgfp+xSKjN2FoW1AkuGPbxpgPzBE2Wi6Qfp+
	 0gcpCoMeJ+1NV2KBF4K2ZSvHsC3ET8OF9vP/DP8VvrlbnLoAtUz/fJBJeNbBTqXg6o
	 gsivsHIxC2IX8bQ1Te0f8fZ5InpiMrkgjyiexKdX9dXxcbAeTwkwe35Zh5oHiNRm5D
	 gnuAHaN/IMm2JHuT0tgqJzc/yghOzxvCjLYrm+a8HOFEcBQVUUdsnecLJmsHUYZhm+
	 SpKqyl67Ns3fRIHE+LLz2Dby3OhAMFTo96WpzoGCuYzOOSyG5b6ctCpmCNzBP736xA
	 X0h96QsiTNG4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6963281242;
	Wed, 29 Jul 2026 12:28:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 449FC26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3694D4009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ycwJlw7qTFXR for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9C8FF4004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C8FF4004B
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C8FF4004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE78849AA; Wed, 29 Jul 2026 10:51:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id DB7FE8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:56 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08202169C;
 Wed, 29 Jul 2026 01:51:52 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 968813F66F;
 Wed, 29 Jul 2026 01:51:54 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 07/22] arm: cache: keep range maintenance available at EFI
 runtime
Date: Wed, 29 Jul 2026 09:51:09 +0100
Message-Id: <20260729085124.2618817-8-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315116; bh=RBSDwXy0ALbOnZr5DVZ5sGo9HxUxn2ZsvhzHQjjk/2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sdDjkBzy3m12Vx9gXw9paLfUQImwMrpk3w/WceuW22hQV0uZvIVw3YBwmxkRr9rXQ
 VZ3mKzt/1CSyHVWRM99i+rCM7Q7JrV2zmwbooYBksuQVGhM+N4sfmtHyp75vgaRqsw
 LrCISFXplo960Ovm3FLHGhsYzzkMFYTD84kB9ag4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=sdDjkBzy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="sdDjkBzy"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The FF-A EFI runtime variable path uses a shared MM communication buffer
after ExitBootServices(). Before sending a request to the MM secure
partition the buffer range must be flushed, and after the response the
same range must be invalidated.

Keep flush_dcache_range() and invalidate_dcache_range() available from
EFI runtime code on arm64, together with the underlying assembly range
helpers, so the FF-A runtime transport can maintain the shared buffer
without using whole-cache operations after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 arch/arm/cpu/armv8/cache.S    |  8 ++++++++
 arch/arm/cpu/armv8/cache_v8.c | 13 +++++++++----
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
index c9e46859b4f..916558fe477 100644
--- a/arch/arm/cpu/armv8/cache.S
+++ b/arch/arm/cpu/armv8/cache.S
@@ -169,7 +169,11 @@ ENDPROC(__asm_flush_l3_dcache)
  * x0: start address
  * x1: end address
  */
+#ifdef CONFIG_EFI_LOADER
+.pushsection .text.efi_runtime.__asm_flush_dcache_range, "ax"
+#else
 .pushsection .text.__asm_flush_dcache_range, "ax"
+#endif
 ENTRY(__asm_flush_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
@@ -195,7 +199,11 @@ ENDPROC(__asm_flush_dcache_range)
  * x0: start address
  * x1: end address
  */
+#ifdef CONFIG_EFI_LOADER
+.pushsection .text.efi_runtime.__asm_invalidate_dcache_range, "ax"
+#else
 .pushsection .text.__asm_invalidate_dcache_range, "ax"
+#endif
 ENTRY(__asm_invalidate_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 7c0e3f6d055..d150da4778e 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -8,6 +8,7 @@
  */
 
 #include <cpu_func.h>
+#include <efi_loader.h>
 #include <hang.h>
 #include <log.h>
 #include <asm/cache.h>
@@ -855,7 +856,8 @@ inline void flush_dcache_all(void)
 /*
  * Invalidates range in all levels of D-cache/unified cache
  */
-void invalidate_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime invalidate_dcache_range(unsigned long start,
+					   unsigned long stop)
 {
 	__asm_invalidate_dcache_range(start, stop);
 }
@@ -863,16 +865,19 @@ void invalidate_dcache_range(unsigned long start, unsigned long stop)
 /*
  * Flush range(clean & invalidate) from all levels of D-cache/unified cache
  */
-void flush_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime flush_dcache_range(unsigned long start,
+				      unsigned long stop)
 {
 	__asm_flush_dcache_range(start, stop);
 }
 #else
-void invalidate_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime invalidate_dcache_range(unsigned long start,
+					   unsigned long stop)
 {
 }
 
-void flush_dcache_range(unsigned long start, unsigned long stop)
+void __efi_runtime flush_dcache_range(unsigned long start,
+				      unsigned long stop)
 {
 }
 #endif /* CONFIG_SYS_DISABLE_DCACHE_OPS */
-- 
2.34.1

