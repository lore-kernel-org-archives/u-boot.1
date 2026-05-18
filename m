Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46CBCD4F52
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 09:01:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 751B184693;
	Mon, 18 May 2026 11:01:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XBz5mGNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E80484150; Mon, 18 May 2026 11:00:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CB9883FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 11:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so15414765e9.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 02:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779094856; x=1779699656; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LDQiqMtqpYCp51ELGuhqfrqKbNt1u0zY7nh9hPkNxI0=;
 b=XBz5mGNTzy6Ck6oF5slPGxnQRI4EGiBeSak5rMT4UoAiGaYwBJ15KlrpbYfPKvj1rE
 zvXlJqR1a1CpaIAx8Rp7MuypInSqqoL9fluMUNO72OAFpBQNsKztOpGFR47ecKZcxn6i
 7TrXA8O2hRMzDt/NT4mw5ZKWyeSNGxzfPkTiCIl9IimaZIb4RvmTATenkwQ9GF5re5qg
 aIRThi/bv71G5UZIdyoe8SiIhA2UxCRW9Lx8hi17Lb4z5B3GdkeYAIrqSRO/QEm2En1o
 CgkX1Z/bZG+h+l/QuX00fphZuTYOeOyskZDpCKS9nvp/+f9/UrBCoCVBierho4WXYOs0
 dt8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779094856; x=1779699656;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LDQiqMtqpYCp51ELGuhqfrqKbNt1u0zY7nh9hPkNxI0=;
 b=GPUKbI1MhmbaR8uZ46bjxI5KEoolgRrc7Idt3pt/byTjeocnJn/SvllsVyrg20A1ub
 5b4e6G2tl2Sr8bWM9wYRnZgQ//PEZzES5/12fKBxxHmpnjtqj5rEfRdqeeOc78YA36hy
 Cl4/TgPhN9VEFHwRt4ktsAsHx+p3eeQa64TEeuLhJDmjBp4RZe0AZ0DL+UMNaudAQ4Oc
 kHcRBdF/WBgmm9A+aiHs/bNXjdJtWe8Y92WM1zqy+JdvWk4xDHlt84yF22YL5xk0Yy2o
 SdRjNBCwU3zaNTSiX/DFrPnZYI1GiwjtBeif0QewieGb5OIRvOrAVUMhAZDrLbRVVikc
 7KMg==
X-Gm-Message-State: AOJu0Ywk5FmZhRzEtwxWRdwvsNNqL75hmTHfbamOjPeWUdf8VXx+kJA5
 8/S855dhzuNcNI9DmRrTMRiWJtXmXSH42wn6q4a49BSeu+KeVEJGFaKFc+oGgxSQEfw=
X-Gm-Gg: Acq92OGat8TYBs5DcaSdw9GLzI9DNQNzpCE9KXcDKi7q5pr5UYRW1HznBd380y4157N
 BlhkT6OLk8F54uoVz59AsuLUgub+vPOBP5Wp4hChPysyaoeWSGK45UqLhNxHRzxRJmGsK3GbH3b
 R61udgHQO22HJFQ08q2HrgAVbz4WlCGm2zjkwVbJLotxQ4GBdlif/5j++g+HvOQEtGV4aKS/ruj
 eU/hxRsgpN7H8aCkBcOzg4CXK4CR/2C0KVbf+67erojZQH/+dHHFQNb6r3e7799hM2R3m85f4FH
 M4L1Bt2VrflAJmcNmIZq+Qnu6DHf0YqIJgNv6S7LmmWOJYbZQTfvP/ar3aChwdWn/gsG1thxqME
 o3GeNRFC82cBltni2/Zum0MHtJNwvQJw4LX9N/MHUo4b91OBycRShKHpwmsppl42aB4QSxEQUQJ
 0J9mKNqugJFG0b9i8zF4bqmLRYKGNaBPxjeTj6380F6sdkGhcLidwUG82k8foXH8YxaPFI
X-Received: by 2002:a05:600c:a00f:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fe63263dfmr219352625e9.16.1779094855544; 
 Mon, 18 May 2026 02:00:55 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab3977sm265269425e9.9.2026.05.18.02.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 02:00:54 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 18 May 2026 11:00:50 +0200
Subject: [PATCH v5 1/4] armv8: mmu: add a function to help debug TLB
 lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-b4-mmu-unmap-fixes-v5-1-7802245a40a2@linaro.org>
References: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
In-Reply-To: <20260518-b4-mmu-unmap-fixes-v5-0-7802245a40a2@linaro.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Sumit Garg <sumit.garg@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3479;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=SQP6aL9nue8foYCAUuMDPt/T78X0OJHu7CRwBVc0rcU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhiyuqy6+/L0GlTbTTM4llc/Y0zQzw5NHe2tf6HRHhzu1i
 0WcG/91lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIksvcfwP++E0GERgYPdHEKT
 Pv+OuJO/rLL37o0lqydxL+xZeuyhSysjw/RfcjsPf/Za9Zpp4QrPdp6Mv/+WdTWG/Di3+qpHPaM
 fryAA
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

Example output on QEMU aarch64:

Performing software TLB lookup of address 0x50100000 va_bits: 40
  PTE: 0x47fe0000. addr[47:39]: 0x000 (offset 0x00000)
  L0: 0x47fe0000 -> TABLE (0x47fe1000)
    PTE: 0x47fe1000. addr[38:30]: 0x001 (offset 0x00008)
    L1: 0x47fe1008 -> BLOCK (0x40000000)
      [0x40000000 - 0x80000000]

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 60 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/armv8/mmu.h |  7 +++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 39479df7b21f..97a1c39ed268 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -733,8 +733,68 @@ void dump_pagetable(u64 ttbr, u64 tcr)
 	       va_bits, va_bits < 39 ? 3 : 4);
 	walk_pagetable(ttbr, tcr, pagetable_print_entry, NULL);
 }
 
+/* Do a software pagetable walk for the given address */
+void tlb_debug_lookup(u64 addr)
+{
+	u64 va_bits;
+	u64 ttbr = gd->arch.tlb_addr, *pte;
+	int lshift, level;
+
+	get_tcr(NULL, &va_bits);
+	level = va_bits < 39 ? 1 : 0;
+
+	printf("Performing software TLB lookup of address %#010llx va_bits: %lld\n",
+	       addr, va_bits);
+
+	addr = ALIGN_DOWN(addr, 0x1000);
+	pte = ((u64 *)ttbr);
+	for (int i = level; i < 4; i++) {
+		int indent = (i - level + 1) * 2;
+		u32 idx;
+		u64 _addr;
+
+		lshift = level2shift(i);
+		idx = (addr >> lshift) & 0x1FF;
+
+		printf("%*sPTE: %#010llx. addr[%d:%d]: %#05x (offset %#07x)\n", indent, "", (u64)pte,
+		       lshift + 8, lshift, idx, idx * 8);
+		printf("%*sL%d: %#010llx -> ", indent, "", i, (u64)(&pte[idx]));
+
+		pte = &pte[idx];
+		_addr = *pte & GENMASK_ULL(va_bits, PAGE_SHIFT);
+
+		/*
+		 * Check the PTE and either descend if it's a table or print
+		 * the mapping and return.
+		 */
+		switch (pte_type(pte)) {
+		case PTE_TYPE_FAULT:
+			printf("UNMAPPED!\n");
+			return;
+		case PTE_TYPE_BLOCK:
+			printf("BLOCK (%#010llx)\n", _addr);
+			break;
+		case PTE_TYPE_TABLE:
+			if (i < 3) {
+				printf("TABLE (%#010llx)\n", _addr);
+				pte = (u64 *)_addr;
+				continue;
+			} else { /* PTE_TYPE_PAGE */
+				printf("PAGE (%#010llx)\n", _addr);
+			}
+			break;
+		default:
+			printf("Unknown (%#010llx)\n", _addr);
+			break;
+		}
+
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

