Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F89CC021B4
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:01:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 374B480F5C;
	Thu, 20 Feb 2025 22:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="coUZ3E6z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E8B88001F; Thu, 20 Feb 2025 14:55:40 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618F680F5F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43995b907cfso5898755e9.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740059738; x=1740664538; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqOy20sja8WQ+/N6U2BFZ8pmWuEOlVnY5Bc/eM0M/kM=;
 b=coUZ3E6zhbKHKCFLEWdU+Oe+jNaxpQNj3dg3ZRxv2i5poghpHGcZAGh6+itdmd9YZh
 mrkmZegOfF+pR4zHWOtDM+w4MJdH9SjYS6y8ROFdw3j7IgWVsMQu/24yV6gf3UA881NG
 v3BeHbh/OUvb0fpgNoCOsAXiSgEmAG1KJzQZsx63wuP/Limon6mzDP0zmjSi3EFgMlB+
 ckJPlzF+jF1Yot7K5z5DppreF3ZuJ7BNP8E/t+6MeQosAuxQTANCxxdmV4/w+nJcvKje
 Ce+6gnS6fV43i4Vgg3QbedEjF8BE8z+Lj/JaSKOB7AnGQlYHsCke072hdM0LkrLSgYRH
 kDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740059738; x=1740664538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqOy20sja8WQ+/N6U2BFZ8pmWuEOlVnY5Bc/eM0M/kM=;
 b=bA/7NUOQC2dSNcuWyjAuDG9rixQuMZyseMZvhA/N/kBcqGyjnvXHF+fkyf5R/f/VIA
 BrOSOrUblese/oGQ2ai+O1e17PEDc9Fky9z95nFt3n9oe2BXsA2WiVM1Rhxh1TVXKYej
 rInJtq42B7Zi8mhnirgX4N9ebTt5r6SQFnwK6SJ8WA566zDwnX72OzplzfY3QEI978hI
 rWvdOQnj95IJSeY6Q+nn4slUgx8F8B7F8OT+tW2Lt7wihqbUTtz5zpulDcgIWh+/qFea
 UUVe+qqZ0zGh8uhU4G5x+cWqJPUQgCdf3+VOvHjWaFatn7vh1XNsSoqFh77ORgdalOUh
 9NWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMKFVKprIaBFKFCzJfdiG5hr1Rv2fQ7txOCphEb4z6O/FVNQ3mkAayl4Az/v+PmjHrRGdWK/s=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+VfWedPS5MBkRLqW0KnhUR/oZ0aEWZ3GLXGpYUG/KYmg6jSqr
 ybxu2FcilNOMnXsL1uh1SsusFyLvu+RU4GH3Cz1G+qzNV8a8BQqrcVChquWucgw=
X-Gm-Gg: ASbGnctZPiroPpHjaUY+GzSUnKdiYnF/PpwF6BGP5YyExCiRHHPI8aKNA7GC9X4VaBj
 /8nDQ6q8K0E6Mflpyxca01yFkynxXaGPcOOtHUuKmZca0Vz+i694DGIy8t+5NRazQreUupSTmQO
 FzkTkKdJCuWRbcYGWiYYOXVjvKpr4zvcnxN6CbtEBzbR5KlmLhW7hCJpLqXtVXhm9eZBptsJ09n
 Nf5w1GvoYoFEzA+D9SEk80M/49KpGzDLTPF3nEVmliprIi5Hb4uWn4g4F7N9werbwyOMg554bJC
 ePOOz3zFO22ybMT/0hwt8e49/z163KN7h3TN8ZYzSxen0KEQIhmToI4MJZ/3GGREm+d+eA==
X-Google-Smtp-Source: AGHT+IFG3gy9lfiOHqdJhwjAjDlQNA8br5AABaY0MMD66EeCCXH6pk317xr9XvUc14qHrU/YJXYRGA==
X-Received: by 2002:a05:600c:4750:b0:439:9828:c425 with SMTP id
 5b1f17b1804b1-4399828c633mr96694555e9.7.1740059737811; 
 Thu, 20 Feb 2025 05:55:37 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987088ecbsm111659865e9.31.2025.02.20.05.55.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 05:55:37 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sam Protsenko <semen.protsenko@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 1/6] meminfo: add memory details for armv8
Date: Thu, 20 Feb 2025 15:54:38 +0200
Message-ID: <20250220135506.151894-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:01:46 +0100
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

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c    | 26 +++++++++++++++++++++++---
 arch/arm/include/asm/armv8/mmu.h |  2 ++
 cmd/meminfo.c                    |  6 ++++++
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 5d6953ffedd1..c4b3da4a8da7 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -421,7 +421,7 @@ static int count_ranges(void)
 	return count;
 }
 
-#define ALL_ATTRS (3 << 8 | PMD_ATTRINDX_MASK)
+#define ALL_ATTRS (3 << 8 | PMD_ATTRMASK)
 #define PTE_IS_TABLE(pte, level) (pte_type(&(pte)) == PTE_TYPE_TABLE && (level) < 3)
 
 enum walker_state {
@@ -568,6 +568,20 @@ static void pretty_print_table_attrs(u64 pte)
 static void pretty_print_block_attrs(u64 pte)
 {
 	u64 attrs = pte & PMD_ATTRINDX_MASK;
+	u64 perm_attrs = pte & PMD_ATTRMASK;
+	char mem_attrs[16] = { 0 };
+	int cnt = 0;
+
+	if (perm_attrs & PTE_BLOCK_PXN)
+		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "PXN ");
+	if (perm_attrs & PTE_BLOCK_UXN)
+		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "UXN ");
+	if (perm_attrs & PTE_BLOCK_RO)
+		cnt += snprintf(mem_attrs + cnt, sizeof(mem_attrs) - cnt, "RO");
+	if (!mem_attrs[0])
+		snprintf(mem_attrs, sizeof(mem_attrs), "RWX ");
+
+	printf(" | %-10s", mem_attrs);
 
 	switch (attrs) {
 	case PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE):
@@ -613,6 +627,7 @@ static void print_pte(u64 pte, int level)
 {
 	if (PTE_IS_TABLE(pte, level)) {
 		printf(" %-5s", "Table");
+		printf(" %-12s", "|");
 		pretty_print_table_attrs(pte);
 	} else {
 		pretty_print_pte_type(pte);
@@ -642,9 +657,9 @@ static bool pagetable_print_entry(u64 start_attrs, u64 end, int va_bits, int lev
 
 	printf("%*s", indent * 2, "");
 	if (PTE_IS_TABLE(start_attrs, level))
-		printf("[%#011llx]%14s", _addr, "");
+		printf("[%#016llx]%19s", _addr, "");
 	else
-		printf("[%#011llx - %#011llx]", _addr, end);
+		printf("[%#016llx - %#016llx]", _addr, end);
 
 	printf("%*s | ", (3 - level) * 2, "");
 	print_pte(start_attrs, level);
@@ -1112,3 +1127,8 @@ void __weak enable_caches(void)
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
index 5e83d61c2dd3..acdb38dcba02 100644
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
@@ -58,6 +62,8 @@ static int do_meminfo(struct cmd_tbl *cmdtp, int flag, int argc,
 	if (!IS_ENABLED(CONFIG_CMD_MEMINFO_MAP))
 		return 0;
 
+	arch_dump_mem_attrs();
+
 	printf("\n%-12s %8s %8s %8s %8s\n", "Region", "Base", "Size", "End",
 	       "Gap");
 	printf("------------------------------------------------\n");
-- 
2.47.2

