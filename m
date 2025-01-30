Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3268FC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 07:21:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B693E80C85;
	Thu, 30 Jan 2025 08:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Aox0LJWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB05C80C99; Thu, 30 Jan 2025 08:21:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 175AC81250
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283d48so2774955e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738221674; x=1738826474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoSFznlnmdzy6VCmKJQIDoPp+0ELTpXnMyRTMOebkMg=;
 b=Aox0LJWFKUMw7AF3nSC0p7/En7JDGv+OGAxuyNsGS+GszwwSbEokpLxFxNkqatwmcw
 ll2yCBAv9Gry6IJ7P+QmVwntyLu014XGN1JdYBenfZh5bsOSLoy2kbtzphzpfRLjZvcf
 IX7F5T48U/72yiCRYFYIpnxnpg0QHfl27IOIKxLLup0GMq6MkhpKRI3teOwjAEkRWydb
 f/l+8DMw8bxbZZy8YLw/ljoMwU1fqk4omBAIQWzKCK7ALYO5a0BD+qOkCAW5Kemj+kk6
 0ll9MoUtPpSk05JVisCW6oPbnYSr05bdd5LjSwXnP7ruzGlFV78lTJqeC7nkCi1F0p5M
 hlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738221674; x=1738826474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoSFznlnmdzy6VCmKJQIDoPp+0ELTpXnMyRTMOebkMg=;
 b=LlZtB9opNoHqS665ENN1sGhWA8tEb7+VW55NxKsdFENIgviWPqM54I+7BCSx4W87al
 WJmrDo1WQdI+npoRag09nzYfBXaRHR8AypDQoLJEAAYyrEsi1opjDlynxQSZHos1fwgW
 pSO66Q9KYuc0cTVSLmm2OaUOu3JsUltf0VReLW29UdHECNcsx4H/OllH7O/lYiNaFMEZ
 +NPsQJ62xiw8grC57mtdEuOaII0eIJyZLdtQTF46qfV4+8vjORg5WmtUUxjc/xCE8Day
 mWyD9z3ZMODOFUahcEX0njsqPmOPo+Wz5gYshM8NrG9JThSmOj1Jpy+fY7UDSli/u2b6
 c5rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHHBS5WeRIBYqzP6kyoTkVPboRYQHAGXzozn4JB08okBltoyipRV1X8mqvLL+AkvV/50WAOxA=@lists.denx.de
X-Gm-Message-State: AOJu0YyQN80k8eF/dQ0zzNXSNus89qB2JZ2bdu8T2q+VT7pr5TTfMhfC
 YhNvz6N6NMhPqbwM2xwPpw0RjXyMZnxaoVYWhwc+1rDKfh0a4BAUNq/SjwNws9M=
X-Gm-Gg: ASbGncvUjV0JaK3oM0wCl+dDU981NZeJWSdyBhbASL8qjg6YD2iZhgudX8Pt5aVg4U9
 NJrGsiED76b/xIBxgES0QnX6Qss62ZCMi3K57Dyeht4Qj4hUBEUOyDnhSAskPdbvSXEVQQhxgyO
 Ur1O/B1unUPK3bzoBDpE/dnRodYldgwuT7r/Jq9urtRVdIdFKzXCDMc0nDu5TSQ+32rWFV30ZQi
 GR8Sjbyc2Bsmb+iKIvKrnjurM1q13PSQ3aA0lTmPe3wH1ap0NViNEr04a5z2ajFqpVzLvtxyWeh
 va5LMmPE+Te9JsWlyIbqMcxDCJXiPCZpJxSJzSdbRHDkf3WFIw==
X-Google-Smtp-Source: AGHT+IHxK1lyZdKGyyDEVe+krRXK7f74E4aJPZnxPxOGVyYRHc6a3j1Roc2NACAiKuQlK+BkgutvZw==
X-Received: by 2002:a05:600c:3ca0:b0:436:1aa6:b8ee with SMTP id
 5b1f17b1804b1-438dc3aa574mr55978945e9.2.1738221674515; 
 Wed, 29 Jan 2025 23:21:14 -0800 (PST)
Received: from hades.. (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df2asm48076345e9.29.2025.01.29.23.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 23:21:14 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: maz@kernel.org,
	trini@konsulko.com,
	CFSworks@gmail.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [RFC PATCH 1/4] meminfo: add memory details for armv8
Date: Thu, 30 Jan 2025 09:20:26 +0200
Message-ID: <20250130072100.27297-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
References: <20250130072100.27297-1-ilias.apalodimas@linaro.org>
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

Upcoming patches are mapping memory with RO, RW^X etc permsissions.
Fix the meminfo command to display them properly

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 18 +++++++++++++++++-
 arch/arm/include/asm/armv8/mmu.h |  2 ++
 cmd/meminfo.c                    |  5 +++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 5d6953ffedd1..a4ca56c8ed42 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -421,7 +421,7 @@ static int count_ranges(void)
 	return count;
 }
 
-#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
+#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
 #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
 
 enum walker_state {
@@ -568,6 +568,17 @@ static void pretty_print_table_attrs(u64 pte)
 static void pretty_print_block_attrs(u64 pte)
 {
 	u64 attrs = pte & PMD_ATTRINDX_MASK;
+	u64 perm_attrs = pte & PMD_ATTRMASK;
+
+	if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN) &&
+	    perm_attrs & PTE_BLOCK_RO)
+		printf("%-5s", " | RO");
+	else if ((perm_attrs & PTE_BLOCK_PXN) && (perm_attrs & PTE_BLOCK_UXN))
+		printf("%-5s", " | RW");
+	else if (perm_attrs & PTE_BLOCK_RO)
+		printf("%-5s", " | RX");
+	else
+		printf("%-5s", " | RWX");
 
 	switch (attrs) {
 	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
@@ -1112,3 +1123,8 @@ void __weak enable_caches(void)
 	icache_enable();
 	dcache_enable();
 }
+
+void arch_dump_mem_attrs(void)
+{
+	dump_pagetable(gd->arch.tlb_addr, get_tcr(NULL, NULL));
+}
diff --git a/arch/arm/include/asm/armv8/mmu.h b/arch/arm/include/asm/armv8/mmu.h
index 0ab681c893d3..6af8cd111a44 100644
--- a/arch/arm/include/asm/armv8/mmu.h
+++ b/arch/arm/include/asm/armv8/mmu.h
@@ -66,6 +66,7 @@
 #define PTE_BLOCK_NG		(1 << 11)
 #define PTE_BLOCK_PXN		(UL(1) << 53)
 #define PTE_BLOCK_UXN		(UL(1) << 54)
+#define PTE_BLOCK_RO            (UL(1) << 7)
 
 /*
  * AttrIndx[2:0]
@@ -75,6 +76,7 @@
 #define PMD_ATTRMASK		(PTE_BLOCK_PXN		| \
 				 PTE_BLOCK_UXN		| \
 				 PMD_ATTRINDX_MASK	| \
+				 PTE_BLOCK_RO		| \
 				 PTE_TYPE_VALID)
 
 /*
diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index 5e83d61c2dd3..3915e2bbb268 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -15,6 +15,10 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+void __weak arch_dump_mem_attrs(void)
+{
+}
+
 static void print_region(const char *name, ulong base, ulong size, ulong *uptop)
 {
 	ulong end = base + size;
@@ -54,6 +58,7 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 
 	puts("DRAM:  ");
 	print_size(gd->ram_size, "\n");
+	arch_dump_mem_attrs();
 
 	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
 		return 0;
-- 
2.43.0

