Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5473BCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 19:58:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CBE784BF5;
	Thu,  7 May 2026 21:58:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wFmSQ39w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2418A84BE0; Thu,  7 May 2026 21:58:25 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DFC784BD4
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 21:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4890d945eb4so15608835e9.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183902; x=1778788702; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DSQjV9y7mbSdVGWtNrpYx0Of8/i/OdE4zb/JPgBqKOI=;
 b=wFmSQ39wmKkwpSJokesVG0J0QYojSASuXex7+h7QgEKzn4S4fnVdUdK7so9SPc7Cqn
 V690lN5ssnzXdJgzHTKQhPNiuLpkMxLSIfueyucVTCy4lcFDynuoNrUj1R/HSOfl2z6w
 c5YtgXnhMzexReA4XrKMNfjQTQS3yWIfS1LHUP2dXcy1XaYIx7lMk2FtUmXFG67QI8oM
 V6hO37Y8MmxDZY0x+/pyYHj+a8pxnRBjgA2qXZ+yzWqP/Vi81B2mjxiIqoWmwXnVDNZQ
 skSp+Uhb9BYbGzpzjym6Knj2Wf1zJKPyzwR8SGvaVeSo3D6LIrCjxsJzzQ7riWQSUUyr
 QU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183902; x=1778788702;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DSQjV9y7mbSdVGWtNrpYx0Of8/i/OdE4zb/JPgBqKOI=;
 b=OY9KcBUFWi97PDocqa5vZJt0+Vuf/rOHmio5KyKrHWO3rvtFkH7Wr1MVbhCFW8neeq
 sPkiswCF3vm35ThukDI9qrT0igU4Iz8TrP6MneJvuGjZypxerA9njmmLsY9Z1ni46v3n
 9mVgiQc6ItlLmozxLxtlmkfYN/rRfVZigQ2yBjPCgcDnc5kZmQn6yu2q9vM36syX2Mpq
 1vdlPGkDSOPpH8tbjcJN46kIC8WwTt3q55Dpnc8I0fD7P7PKEftYYdk60jCDhiOA9Dsb
 ZIFUVvCZMbjGU1IDMGq9U9V8Ydel0q8A7KFpigDOl0TccrwKOYyfuk8h88MK0azk3pN7
 T3Qw==
X-Gm-Message-State: AOJu0YwbrslhFcuE3FnafXDmBRKeSwM75ZiSLzsMek8Lv46IcPawpT/Q
 jURuvx2Nrg6pMRd3vtDlgXy4mQl9D4D+rVB+VOVigJWlS6aKySRa7Lf7JMWIibGhcvQ=
X-Gm-Gg: AeBDiev5LnD1iXmAZHn5Kc76sYh42COY2izYPacW6peQuvsQWUxck7gKW81fjCJOP7Q
 ESjIGLpuyWh7zzL2TWYlROiOC9VTISezdSnSMo8vCzMd30h0l4J4QzdfHaR2MEIC8P8hfJq+w35
 NYpr5rlqxIcjHt5rEgjJ/pFfnRgN9nYkfGp5bZrXIzo21G9Gwm/mxFwygnZ2rm0iqGmJxQoOMy3
 NOunfuhIaY3ieshHgaa0rSNILus3AnG26Wc7gS0VX5Fp7HecHF9s0M5lUUVGfKVraiJfYhCXXPP
 KXbyFKy5fogdmjkGrmamDneTsDoW4x08G9YLLSAOcV3etLZpsN98yltIIOC4dQxmrmKo848HJtP
 qc++xHXHc9E/2kRUrPBuDlsQ0WvBDP1YVupWUUsDtCOEPbnoPM2Riwum40aUYaJHVjx9YPqPGPU
 rsI3kukcfGax/2cVJHhzRIX3r2e/8Q4PY0omdt0IrRnJoKVCgHAOI+9UhGkYbQ2DnHQGK+
X-Received: by 2002:a05:600c:4e56:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-48e5dfd6508mr63507005e9.5.1778183902561; 
 Thu, 07 May 2026 12:58:22 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538d2878sm235344265e9.15.2026.05.07.12.58.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:58:21 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 07 May 2026 21:58:08 +0200
Subject: [PATCH v3 1/4] armv8: mmu: add a function to help debug TLB
 lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-b4-mmu-unmap-fixes-v3-1-aac7726d87d5@linaro.org>
References: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
In-Reply-To: <20260507-b4-mmu-unmap-fixes-v3-0-aac7726d87d5@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsw/727/Efs3tT+xW/Z6ousr5jOHTFjbQn6fyNjH2VC4U
 1LL4ANjRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZjIMx6G32zTKrz/RfHMOXUk
 fZ9nC2dHjr5OcOOkGbOLhN4cEe+2rmT4xaTNe5NLo/bEGb0XE/pZT29pcu05aiWoUzNzX95GWcc
 HagA=
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

