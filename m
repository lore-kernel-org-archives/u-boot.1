Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2175ACC6B2C
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD28A80F6E;
	Wed, 14 Oct 2026 20:03:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oGimCKqX8yNv; Wed, 14 Oct 2026 20:03:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BC0B80FF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008212;
	b=sDf3FDe17tCbpFcg50xwdodwlpJ5WwvNuppI+w+t/MINS1VW5sqKKOskhGoJf+XUS75k
	 xDFShV3iEVAVwsuEpeX1WUGyt82XSkK4NC/rCKuUcdZVcCHlcwOMIpb40UrkLV/no88qf
	 oilwIaWkFdhL+gFZpvJF5HDdZ2ayhBxvpuNyfhVVBcMEZJTkUHL+hb+g55kVCHJNLNUkS
	 Wco5kBem55RBofPvME24oIIztoyLbss2YOt8KsfGioY+/yM4FT1cl5UF8vSOLXirsuZbi
	 SnJlJjeb3EtOm6NrTTp9KJdmY0ibgBSxQBqO15fPo5vFhbT0Pc8gyBbLc7YuvpTTfXw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/vhmKi2p/4dPR+PdYgubYJJ+p8nPJofeVLyTPz8Jofk=;
	b=sLC15c1T7wK9lbBpIc5NHGWW2rNPeDXMw+2ihGIyDAUJZ0oohwFA1K/I3kaspedJ8CNP
	 n5I2IH5TqCgNssRtzaJwFNJYwNO582fHe5BPSVU5ASjGQJq6IoZER09PhF/WopIp+9FWo
	 nrpnfoxMVndUGrUgkIlHxRprR1mv8PjIgtvDVaJkJ7qSeTDKex4fzTMA2r9xQrQkya4sp
	 Hg4hkVFS0yZa4pM6wFe+nT2fV2EeBuU2iJBTKOuY6j78vLIEnbbUFYGeuDtYobFy6Ex3c
	 ZN1jlRBEW+YF9a3QAVi+YYzNtMXLJpN8b9qTyvcVB2+T/PFTuNEwcRtrDR/ZLALaKBQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WWrcFHbe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008212;
	bh=/vhmKi2p/4dPR+PdYgubYJJ+p8nPJofeVLyTPz8Jofk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qvEKNpGBFvFlxdwyupAjlp2gIftxehkP1dDzArqJ7m12BO8cQ+HWGW9UjKvB8eJ4m
	 Sja9PI87h6bgdkxlSiUTOrFRWnRNJX0biEYV+Mv+cM4we7Sab+VHhk+wkftBHRFG7f
	 EfTCiBcM9GV/RVa8LcL31VSf+VD9ITH7s85wdnvsMFWx1xzU6P0St9xxf4YafDYLGJ
	 CLTtWX1VEm6Ijo3U7yTi5FsOJacSXLVsESKqKBD2MLqFA1QRhOltZ+yqtbAUBnlK/T
	 24CYwqIMvdTuV2j6dXtizDiF2nRSQx5jcvYJbF4SLC9MwPUMdQNjGm+Cwe1mDUmVLf
	 W+3YdjGmeyIQw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BC0B80FF7;
	Wed, 14 Oct 2026 20:03:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 780081DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DF8D80FC6
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HEYffu4yVE-n for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DAC480FA9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002203;
 b=tJrF+32W0mnHjPwKDRvwZcJAgy8A67NRMIpGL+UAH68G3wY6AZFUo56VIhUtz08t0Ssk
 RDyQOoKB6PuLGNG7Tumw7uaZAAJmIDx+Wc2HAu/2HM2T5pcbMq325rerFOs+9mh3ManYU
 Wyk6TdpW/BQqVksUI+wQ4Dg0ll39r8k3yldXrZ/DGvpabrZSRLaCyEIIBfFWtbDLywH0t
 /T7jyrOAVONN6CKPc/N54lgcv4ZV+bmg4W/H/nYw2m+uaqTKdgK9jtdamQ+PIjDenQ1hm
 5vE8/xKCnpZPWnqksFnkVcsCPlelXJKkNScWvO1riJrEMOYsDrZX/LF8p+drgfIXiuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002203;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=/vhmKi2p/4dPR+PdYgubYJJ+p8nPJofeVLyTPz8Jofk=;
 b=VImMFfYmYfYtjOEfqm+ZyJkI+o55fepho923BHlPMQkBZ/3HawyNdOj9Oc7hGveTS/Hf
 oS8EPsK/Yoc5sPhRz8sb41EsJk/ZtvQjy+T4xGlIof1Bvb+1cs0N4+ueHRV4f4R/8IdeV
 kPeBer0n/8d1QqLv+J/K6l+Ki2QuOxKHeb51aA4MNKpXCouYfCpwi2Gb3WQacL4ClvFRW
 d+2kpY+7o7zgf4K0OXn4YpwUBnVbmnKTkcnsUkMA3bjkBhCv22IyvtVTWBXFI94cz334i
 zWR7Vo3e4iTdXcsccWKQv7EALDcQC3jE8uxQp8UJPC4XH+UnPOp5imVbDPs9H9y9DTg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=WWrcFHbe; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=WWrcFHbe
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9DAC480FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52AF4153B;
 Wed, 14 Oct 2026 11:23:19 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E163F871;
 Wed, 14 Oct 2026 11:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002202; bh=YspF3LLD6IvUpbQv6+s7urzrBB+7enxZUm30hBO//cM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WWrcFHbeh/w4QAq20O6x3Gr+Ss0zRZ7BXY6kUcRp4ELt5zQjmZCRDntjopNaIxDIO
 ldIP4517J/+kxSMQej/3ZgZjEwmaRmGr9oCv5vKqSNDxbFzBtpSSuWX7tpjsJv2oB/
 yhNwXw77ZNRNB2xG20NWQhDfD+x9wtkX9IrA7X64=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 07/22] arm: cache: keep range maintenance available at EFI
 runtime
Date: Wed, 14 Oct 2026 19:22:47 +0100
Message-ID: <a6090f240af935d2ae1d425838c911f09e656af0.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
2.43.0

