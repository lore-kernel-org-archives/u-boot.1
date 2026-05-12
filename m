Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7838BCD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 11:13:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 428E683CD3;
	Tue, 12 May 2026 13:13:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gnWxh3Zt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5057C8341A; Tue, 12 May 2026 13:13:16 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69365803C6
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 13:13:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so48731055e9.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778584394; x=1779189194; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DSQjV9y7mbSdVGWtNrpYx0Of8/i/OdE4zb/JPgBqKOI=;
 b=gnWxh3ZtvbDG7qOamK5Vxv7dHlDGnZmygbvALv8q/Vy+czXHOXhYONRS5w64sKBITb
 fBd7/K8bmsQZyEla16e6N0AiWqU9LcC/jismg4NqPEzoc3L1i7uPS7D1olL48WGWnNgG
 8eFN3371Y8TlqZP8KrCFGpM7zZcjfnIUd6FX8ki4/Dpc5/Qq1S/kYAJgCCgMzLHHAJ19
 o+OuYrTxeJMmkmcIpNSQJVIqzPTzZEgqJ9pd2qDzQBVIGZT3aCZQEwazly6rz37od8jg
 Pb+DDdH1lZ57O7mrjxXbsOYx3rqfKedKRZWF53h1/P9zhEGZXg9bWYcbvKdA1Ys32Z4J
 i0tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778584394; x=1779189194;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DSQjV9y7mbSdVGWtNrpYx0Of8/i/OdE4zb/JPgBqKOI=;
 b=tLmOiFXdXaUEmLiWL9GuyfQrT1bDNjMgF5e7A4sDOxBYIYUD3JfQNQk6bVB5uYDuC7
 qS6YuttNBQJoSW1gVJdT6ed8jJ5RK0rS7JajTYAjMCpeoD/g9doeGuY9gaHL7RaEhIcg
 h+04wDKcIcH02+A9ZLOu70j5s+FmX4Wd28HIVAK60GwEH79C4fhBi3DwJ02KTweQ5dd7
 dsYDR6MalIc8Tnc5VL4ANVtWH8Xjp/zYr7rFER5fHzovPSadb/xsEAqK/lxSX6b+XPpC
 N5acaxwPHvNDhVgkjcYb4IDx0OPoVNf2wGEcBkZEw+clNssy27rV0QQxO3+H9unvCaut
 mARg==
X-Gm-Message-State: AOJu0YzsJveZlfCyca+ArdTpaCpPaDdh+pi6+G8fNsdJikSIvgC3Js+N
 Bsyl/+O5dsAKpaMk1NVCXBiy2tWQ2EU3tD1wneMdkwJUQkrnsDiCaYghI2omGfW99pg=
X-Gm-Gg: Acq92OGe6bK929E6NQnNUPGZtXuXyj+7i1MnHIqLRRmkEpaBlaI2ngWGoK215ZZcXbb
 WPE4Eh0LBsHvDwe5N41or63tTDppjn7qgAj2xHL4N4IAlylC8UYTbvwsN1iIJCDrL22xrkhO+9V
 +ySdUcaATD9Y0d1NX3KeNlNX0QQnnmK6+zSqjNXR12WJpuuz3LCXpV+yu1tsrwo1KTYjnoE0ZBX
 oAsU1xwqiQtCSAwv0sbGH1uw6960Ox5rnKcEKOXUao90I202M4177yZxxCtfzVDX29F9gzUYss8
 VDyid94cvixslHBEZ1sNxMf6za2/ujkZ6X8QXH4sJJiqQ0sMreHbZBIUUBVitbQCoZIdOBPekSp
 cjDZr9ycauwzkwFw0t+9FWDsXMDsY8uEVSMEP16EFd5xCxoAktFmW1tWpLuuKEi8RX+skKJLl4+
 RNwZHQ+XP0RwAOIyWeCtpLSSO7PNxYodgl5pXs8O8AcV4p3sraHTO55vuTo59AJJ/mQpadgDVw9
 Y9gZOM=
X-Received: by 2002:a05:600c:4e43:b0:48a:768b:eea9 with SMTP id
 5b1f17b1804b1-48e8fe4dc69mr40274555e9.4.1778584393846; 
 Tue, 12 May 2026 04:13:13 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6b00fsm35124259f8f.11.2026.05.12.04.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 04:13:13 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 12 May 2026 13:13:10 +0200
Subject: [PATCH v4 1/4] armv8: mmu: add a function to help debug TLB
 lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-b4-mmu-unmap-fixes-v4-1-fab802f647c9@linaro.org>
References: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
In-Reply-To: <20260512-b4-mmu-unmap-fixes-v4-0-fab802f647c9@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3001;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=ihdmhMvN7Ul+L2ZRsYR5ALXhN7ULEibmzAbYek1owPY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhixmbrc/blNOfZ16vuPlyl+NV19f+i1/LaNno8KmmfV9p
 gelv6y60lHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmUqLA8E9ZYnVmAGOC7p4Z
 3BdPWPftEHjVZ/j25VTuz4vvsmlXpyswMnSJJfz+Xda0ipUlP+Xk5j7BcD1zvtVB4bduXthRrXg
 +7icA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Implement a super basic software TLB walk which can look up a single
address in the TLB and print each stage of the translation. This is
helpful for debugging TLB issues and will be compiled out if unused.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 49 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  7 ++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21f..368c622cd18e 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -733,8 +733,57 @@ void dump_pagetable(u64 ttbr, u64 tcr)
 	       va_bits, va_bits < 39 ? 3 : 4);
 	walk_pagetable(ttbr, tcr, pagetable_print_entry, NULL);
 }
 
+/* Do a software pagetable walk for the given address */
+void tlb_debug_lookup(u64 addr)
+{
+	u64 tcr = get_tcr(NULL, NULL);
+	u64 va_bits = 64 - (tcr & (BIT(6) - 1));
+	u64 ttbr = gd->arch.tlb_addr, *pte;
+	int lshift, level = va_bits < 39 ? 1 : 0;
+
+	printf("Performing software TLB lookup of address %#010llx va_bits: %lld\n", addr, va_bits);
+
+	addr = ALIGN_DOWN(addr, 0x1000);
+	pte = ((u64 *)ttbr);
+	for (int i = level; i < 4; i++) {
+		int indent = (i - level + 1) * 2;
+		lshift = level2shift(i);
+		u32 idx = (addr >> lshift) & 0x1FF;
+		u64 _addr;
+
+		printf("%*sPTE: %#010llx. addr[%d:%d]: %#05x (offset %#07x)\n", indent, "", (u64)pte,
+		       lshift + 8, lshift, idx, idx * 8);
+		printf("%*sL%d: %#010llx -> ", indent, "", i, (u64)(&pte[idx]));
+
+		pte = &pte[idx];
+		_addr = *pte & GENMASK_ULL(va_bits, PAGE_SHIFT);
+
+		switch (pte_type(pte)) {
+		case PTE_TYPE_FAULT:
+			printf("UNMAPPED!\n");
+			return;
+		case PTE_TYPE_BLOCK:
+			printf("BLOCK (%#010llx)\n", _addr);
+			break;
+		case PTE_TYPE_TABLE: // || PTE_TYPE_PAGE
+			if (i < 3) {
+				printf("TABLE (%#010llx)\n", _addr);
+				pte = (u64 *)_addr;
+				continue;
+			} else { // Page
+				printf("PAGE (%#010llx)\n", _addr);
+			}
+			break;
+		}
+
+		// We did the lookup!
+		printf("%*s[%#010llx - %#010llx]\n", indent + 2, "", _addr, _addr + (1 << lshift));
+		return;
+	}
+}
+
 /* Returns the estimated required size of all page tables */
 __weak u64 get_page_table_size(void)
 {
 	u64 one_pt = MAX_PTE_ENTRIES * sizeof(u64);
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 8aa5f9721c4a..ee81619a1843 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -186,8 +186,15 @@ void walk_pagetable(u64 ttbr, u64 tcr, pte_walker_cb_t cb, void *priv);
  * @tcr: TCR value to use
  */
 void dump_pagetable(u64 ttbr, u64 tcr);
 
+/**
+ * tlb_debug_lookup() - Perform a software TLB walk printing each stage
+ *
+ * @addr: the address to look-up in the TLB.
+ */
+void tlb_debug_lookup(u64 addr);
+
 struct mm_region {
 	u64 virt;
 	u64 phys;
 	u64 size;

-- 
2.53.0

