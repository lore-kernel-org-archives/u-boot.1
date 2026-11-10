Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A094606A330
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=O8RLO9Gy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sbb85rZu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D301281514;
	Tue, 10 Nov 2026 13:06:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KqJC_MxHXrWR; Tue, 10 Nov 2026 13:06:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 57C3981498
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315985;
	b=Htjgv3RaXxTCKEGUfrMDoD183bDRQT9WawtJF3XE2WGauFRSml/TT8r3jlmo2IYEZZBT
	 fLYoFYVcjMbP/jjGd7l+leq1c2+k+5PzQMlsbsWn4s4XYVrZnr6LoYY9nR7r7DvTELmAq
	 sLttBLq8tUkyOUnKQpyKJFCb2t58/qRrvAgWD2ztX26BhXMggDA68mGI+24m1S4znDwoW
	 6dCa3rtoyhPlUL5DbF4Gr2IEygU5osLPX0PJIVlzrxAZbangPpgGODkG7wkSRMGpVjV6t
	 ISAiDIqnlZMsMdFA0bWmqwkW+UHHSej6EM1OlbULUnagK4htg4WPC+YzbWb/UHcFwYQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315985;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DpRvGR3u3XpkMKtOPFDZAlhmnbxuCBI4WrJwXhnjuFg=;
	b=PpHUSW9kgiYyu5nw7YSX4QEKIcDdDhs7dQkBmmkuvTs6CFjS27dfuRvWydjzBpnyr3mS
	 jvh6sp9+iMf9EYpASl8Tr6NbV70J01cS61a+w9QgPJqxExmuwR9pdWbKdl+ATBuqnpHyJ
	 RphrWzq894+QKpUayLtxG0VxD7kx5bQHTttOUCG2WbDdQPO103y3XTbmLykIn7AONsZug
	 UrHkmDADFPLtdsdUXLFSQvVBZPN8sDfbQJ71XvKG9BhCcGTym5vDr4/TFf05vq4NO/1Rh
	 2j/9qza3GXZmgIeVygSyFyw24rLLsjRCWl0RA75jy2j2SvIOhVD3cI6nGl6sP4VT42g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315985;
	bh=DpRvGR3u3XpkMKtOPFDZAlhmnbxuCBI4WrJwXhnjuFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=O8RLO9GyeXsAFX9HMcfumSDpC605JMRM4EHT4gpbILiGv0BsZbk2JoJKjFioiElvQ
	 nYqQu5Vef+b6Hj7kIhJ5UG3eRmOP0QHFx2cr1pLSKFWTvQ7+rBqHRZw0nOluL9XZXn
	 LmvFjuJU508Hn+jxismdPKJhWvS6K4WW3u+a/RCZ5MBmRJ/xTH4fU3kEDPtPIsQy0o
	 j4ZrswPJ7S1W5czB1t+Wz32nUkRNq0qNglkVOLuX+YAaNtzXjnr0RP2F2jzE+Wj0Xr
	 7PePAVh0fhFvhAzFFME7zUNAKEnQwYuTvDOWX4Da3YTmUeRjeeIUpNwNBP3fGcR0YP
	 oRsqPdMBHjwuQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 57C3981498;
	Tue, 10 Nov 2026 13:06:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 5345D731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44F6B40816
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5RsHrrlI3xui for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 80CB0407FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=sbb85rZu
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 80CB0407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 802DD1516;
 Tue, 10 Nov 2026 01:58:19 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6581E3F632;
 Tue, 10 Nov 2026 01:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304702; bh=D/9GT7Rkn1cnJVDZWY2JtRGKRDCslBEDo8nU+wDNToo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sbb85rZu6XxcoOdLMruiUEZgMj7YTDYdjdVgfFosQF/hdktb7mPlRSq+wdmjCw7BP
 3oIJxA7J3HcWa6DTzY8Iri08PLr8Vye5V+0PAJ0E+dVBgexEzZDD2GDJhjAxenkrSp
 KeScpBYYYR40e4zYbdo31QAxbVNWR8u95KdsXT0M=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 07/22] arm: cache: keep range maintenance available at EFI
 runtime
Date: Tue, 10 Nov 2026 09:57:48 +0000
Message-ID: <abe9bfed89a81a3189cfe4df09d011c8d5d245c8.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index ad232435eb2..53d57c211cb 100644
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

