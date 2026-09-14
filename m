Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F95C88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02F4180E3E;
	Mon, 14 Sep 2026 14:17:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PXSqzdJ6tbFv; Mon, 14 Sep 2026 14:17:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3549A80E85
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395457;
	b=lCuv/tJkybN0HArYRYoZsPqVMgYus2xIw3PsjpFxCsXUVBctwf4aUo1rXLD8iQAPlB6S
	 zWjjaAlQgY4uMDczu1GDjF0FCpbclgzLR0d8rrq7rY0CfycwqVVGSnlgxF7A7EcWDoaPO
	 amzq9juVwqLfPHsfeqEwxHShTgbVFAsgM7ErLpDlCSZCX1ph0iDzKC9DYNzxyJ5DZg2Ij
	 30ONUh43k15EI3s0RKP9w1crZTUgGO/d9FNSFI0Gr49IAZr2fp+I3qgU/Q0unHa7sRvfZ
	 tTzG1Ij6xemX1ac+Ga0mnJ9Z4k+0AxbBJg/6N4Qsctpw91b+cxhvYklXwRvw9sYcAbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395457;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=q/xtFH5XH0erfMZgtGViCBeG2I04xK9AgZ1xZPNd7Xo=;
	b=SR/UGPGO/JVQnUv0oZ8xA5IcHS/Qt3wHz9cmcsl5bA7NeyQp7h3myvu94/CI0slrxWXg
	 RcGiNc3R2nJC2T9K6hr7zP5NufhgqcFQYkxySoHwYVeMgiWkoORYZAv4QDuPVkQjCGLmX
	 jEd7chcudYA2gjFdgX5aBKZmmooZU4cLxNhfqSLI5FwXPsuwIdFSLn067OAo+L7Y1A1m1
	 eonxzjDROEZGUWLmRnJEM8aetlOVSIHTTHC8zgC3oGjPBKipImYkXBdtVOG3pGf/6sQU6
	 aRuME2p/rAfff+Mv+3P+b6q9PEU3GKsRY8mF02phRRbKsP/jVlcE4b48B/PVkOsZQtQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395457;
	bh=q/xtFH5XH0erfMZgtGViCBeG2I04xK9AgZ1xZPNd7Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LS+mKiQwHUE0kWNIfOYUk7z7CF3zA19rJ6VLDv2GcXoweIjnY7kIRCHS0YwbShEFa
	 sHm2KBO2cwGRco6BxSMgQGqJAbK+n4pEJHyUQ03OFKti0qMOmPll4qZR+5cBan/Gv2
	 u5n4l/0kHbAzW2UIyXFieanKPFYGnsMLzWyY3/x8nlQHK0ZYSbvu9kpjNhZdG5Um9F
	 br/0GykllYOkC1jFlDVpMxC5zarLY4U5yJo6u3GFvTkdVSGErS/FE8JgVtfl7icOBx
	 JnJ6RfN5My1Gd2JpYovba3He5EkWPD0VT65hwA2eG8J98H7VlTK4+osz+Y8RELJADo
	 ZINLRNk8IlHXg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3549A80E85;
	Mon, 14 Sep 2026 14:17:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C1AD949D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B38AE40640
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WNbqIUxdafHs for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 126D340631
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384216;
 b=WAVCMLoKRav1N+idbyz3WInLomIHSrbbzS1S2WRj+bclDlK0jFi/9B4TxDeZOv2pN3dd
 1ldC/5OWRfe17zqu6AQjajClcTwKkBZxZBHcIwq/iDGtKkMbg+PW+GHG3j5bhU58uhCYU
 YKZA9r2HM7CzjzGHSRnOQ/dsigOvZVLDZuVcQdmo5asC9mxSebiJmiSQAdCkeNEOmxrWE
 ySukvjSAlBNrLVDbHB4I5QepKglejsZs401P7+O5guIITtvtT/FY6ibbxohVI9SKNnJhE
 jilmD5lX5IDTDutUR5nO5/oZe8aXL3kNoi2G8S5s5AseB+sds+ugJYtCXORaJZhiEUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384216;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=q/xtFH5XH0erfMZgtGViCBeG2I04xK9AgZ1xZPNd7Xo=;
 b=XXztMCUjfOg7oxfySivDaBax6Nta3qo0rNUXE3dP9UMT7y5d96TtS6OlhQDD1Uw3TDBr
 OGWzPnNFQHpOkDDl7QFVrkpbXTSBF/DvzpwmL4rcLw6wGVlHw27ifbTbIhp/ZygfrZSgt
 uljOeJ6NjEbQWvVTn4ifi5Qch2N6QRf5yRwDV4jpXTUGfbDLuNahlCytQN1oGSHNnuCXa
 MH1xOYC9D9ef/zCeomm3eslOUAMjf/UxnFPsHmJwmJKJXQdKsw2t1WPY3g82ZdTcQ1JPN
 8y7/Uyg3qjCIPX3aN1znQOG/DEb99I99WurjGuyFoLBlFkocYwxbyv2a6TJ7fJh1PvQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=enFRrY0e; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=enFRrY0e
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 126D340631
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9EBC61D34;
 Mon, 14 Sep 2026 04:01:35 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B5343F86F;
 Mon, 14 Sep 2026 04:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383699; bh=AjZROmHMJULNWp7p5sXqZGiiPfCTUvbvhbz3Cez42C4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=enFRrY0eF9bJ0tmV7pnDbWiH1rbW2J/lXLwtPV2xKPAsCFhraTlY6zHeLikp95NKi
 TjD+nmsAyeq7e4Ydglnvc/O7v1evkUJJuj/e5nvIyP/IQ95nC1kJAM9i2Ilr1nU1Za
 wqb91RFv/T3v2YbW4xXRe/blrIAbZRH3UVG306kw=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 07/22] arm: cache: keep range maintenance available at EFI
 runtime
Date: Mon, 14 Sep 2026 12:00:51 +0100
Message-Id: <20260914110106.1974894-8-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
Changelog:
===============

v5:

Ilias:

- Split the ARMv8 cache range-maintenance runtime annotations out of
  the EFI variable TEE runtime patch.
---
 arch/arm/cpu/armv8/cache.S    |  8 ++++++++
 arch/arm/cpu/armv8/cache_v8.c | 20 ++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache.S b/arch/arm/cpu/armv8/cache.S
index c9e46859b4f..386b62c2d81 100644
--- a/arch/arm/cpu/armv8/cache.S
+++ b/arch/arm/cpu/armv8/cache.S
@@ -169,7 +169,11 @@ ENDPROC(__asm_flush_l3_dcache)
  * x0: start address
  * x1: end address
  */
+#ifdef CONFIG_ARM_FFA_RT_MODE
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
+#ifdef CONFIG_ARM_FFA_RT_MODE
+.pushsection .text.efi_runtime.__asm_invalidate_dcache_range, "ax"
+#else
 .pushsection .text.__asm_invalidate_dcache_range, "ax"
+#endif
 ENTRY(__asm_invalidate_dcache_range)
 	mrs	x3, ctr_el0
 	ubfx	x3, x3, #16, #4
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index e59528e576e..edde8f73a6b 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -8,6 +8,12 @@
  */
 
 #include <cpu_func.h>
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+#include <efi_loader.h>
+#define CACHE_RUNTIME_ATTR __efi_runtime
+#else
+#define CACHE_RUNTIME_ATTR
+#endif
 #include <hang.h>
 #include <log.h>
 #include <asm/cache.h>
@@ -915,7 +921,8 @@ inline void flush_dcache_all(void)
 /*
  * Invalidates range in all levels of D-cache/unified cache
  */
-void invalidate_dcache_range(unsigned long start, unsigned long stop)
+void CACHE_RUNTIME_ATTR invalidate_dcache_range(unsigned long start,
+						unsigned long stop)
 {
 	__asm_invalidate_dcache_range(start, stop);
 }
@@ -923,20 +930,25 @@ void invalidate_dcache_range(unsigned long start, unsigned long stop)
 /*
  * Flush range(clean & invalidate) from all levels of D-cache/unified cache
  */
-void flush_dcache_range(unsigned long start, unsigned long stop)
+void CACHE_RUNTIME_ATTR flush_dcache_range(unsigned long start,
+					   unsigned long stop)
 {
 	__asm_flush_dcache_range(start, stop);
 }
 #else
-void invalidate_dcache_range(unsigned long start, unsigned long stop)
+void CACHE_RUNTIME_ATTR invalidate_dcache_range(unsigned long start,
+						unsigned long stop)
 {
 }
 
-void flush_dcache_range(unsigned long start, unsigned long stop)
+void CACHE_RUNTIME_ATTR flush_dcache_range(unsigned long start,
+					   unsigned long stop)
 {
 }
 #endif /* CONFIG_SYS_DISABLE_DCACHE_OPS */
 
+#undef CACHE_RUNTIME_ATTR
+
 void dcache_enable(void)
 {
 	/* The data cache is not active unless the mmu is enabled */
-- 
2.34.1

