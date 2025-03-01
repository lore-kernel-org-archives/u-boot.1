Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971C8C282C6
	for <u-boot@archiver.kernel.org>; Sun,  2 Mar 2025 12:41:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545F4811DF;
	Sun,  2 Mar 2025 13:40:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C1pqF9wq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2759E810FE; Sat,  1 Mar 2025 17:50:11 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 171FB810F5
 for <u-boot@lists.denx.de>; Sat,  1 Mar 2025 17:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so5450437a12.2
 for <u-boot@lists.denx.de>; Sat, 01 Mar 2025 08:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740847808; x=1741452608; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oPeOoPLAsG4Khv298L+G8ZQ4GLiDx2VsYRKaerfIu18=;
 b=C1pqF9wqdBm9Ak2Ax0DIf+elMmeZndcoU7qYW8a3Bhy3Mg+/FZK3Ohm2tzv0b970Hv
 9OahqMksrnHD/Jrls54/i0iNMRDSszyjVeYWv+htkZg//U8w2KRvefnQSFeXr234BEO7
 PrYc2PyAbCsyex2aMY/t7KZ1IyEIrfAsDLjq/n5VLlDT749bURhsafxel2g2+C/B0KiT
 SRMK2ecyUyEN5zISqS1WWR+b56ixNa7Mq6D2kQ80ZUkR6MwNgUyerGJyxigCxrjNPN99
 W3bnzIjVftyXhtzXATfRtAIpDC4QEDL64wnYYIuKtJ2CG5WjUcA9hUy784IFAu2RYbRG
 n8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740847808; x=1741452608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oPeOoPLAsG4Khv298L+G8ZQ4GLiDx2VsYRKaerfIu18=;
 b=cl5EFZkfBgFEqN4PTN9wCxyyXijWZlJrec93Er859Y7pZTGoMwxVMxi55mxQDEf89/
 /RFqNp6KGCjJ4w0/2a0+aWCPc1YFjw0PWPBvPe0pXlg+WPyh7C9XQoIfnExmHPyQrVAb
 EJ1bbuZB3T1WZHjlwUMQ53+msOEs0ZVrDAOzoEqg0Bo+2CYi0GiRRl1kj2ke6K42hs7A
 UAQWGovwL/njz5h67l7yIjtyYj86Jn6hz/haB1cDz7+8x1YIFcZnumxR5ONPS1RjLIKk
 LtqkDqFUehQ78pLZfnxl71zG3sccpvu92uxedObGMnqWdA0RIZphzfJ28J10KIvV/Y9k
 xU0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU53QB9shw687sJzAx/7FrbXehLYqAUSopXupHmxkVu6Mb62wdKdp3tWfaaXuH136yQghNOupw=@lists.denx.de
X-Gm-Message-State: AOJu0YzyCvwawe+UzbgTNkaO2O+7bqMnE1TuUxg7DVnpZA0GFIecPw6M
 MgCXRtq65PLu2tmOffsemC+WexZn6DLo+jdRXR22xbkYw+EMcQyTstNK8GlIhBw=
X-Gm-Gg: ASbGncuEv8hlmx4jnAWhXdLSbd+11/USk+b077VX0Vnozn129d1r+XpQs+knU3TU0v4
 z94cK812Mi2+BhvnNW43dolhzHfkXnlWCy6z2hPxWXj4Jy1CjEG7fkOaiQIguWYq4x6G5psERXg
 CP0nfw1QJ0m0SP7c3Qrfn0CZNmAQZBc9FGlg7dp0OdAxfwqsoX4j2f2RMEz9+S/gy+XEwZ36nSO
 /RtmD5Ma5Eywu/F/Tf0dyDfacmbzO59igBfR02uYQcg4Ar/zOfZkongdivb/WeZSg9VlBHV/lFJ
 1LmWinzO2CVIcpIkFSAVUhJdEyNgHx01D4UCe2PdSKgolAAjdENE3CABLDz6MdagOMa5ACoIGyk
 z1gt0BBDvnBdclHB7azhf1/A=
X-Google-Smtp-Source: AGHT+IFnzbCB9X4geilSrZQz3DlHjBcrJpEiQ/GfNel/tULrbrahmU5RZS+NM1dJhzbxf1Wb64SjlQ==
X-Received: by 2002:a05:6402:380a:b0:5e4:cad2:b67c with SMTP id
 4fb4d7f45d1cf-5e4d6b85943mr8160246a12.32.1740847808534; 
 Sat, 01 Mar 2025 08:50:08 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3fb5927sm4257231a12.53.2025.03.01.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Mar 2025 08:50:07 -0800 (PST)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	mark.kettenis@xs4all.nl
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Alex Shumsky <alexthreed@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v4 4/6] arm64: mmu_change_region_attr() add an option not to
 break PTEs
Date: Sat,  1 Mar 2025 18:49:02 +0200
Message-ID: <20250301164922.397441-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
References: <20250301164922.397441-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 02 Mar 2025 13:40:23 +0100
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

The ARM ARM on section 8.17.1 describes the cases where
break-before-make is required when changing live page tables.
Since we can use this function to tweak block and page permssions,
where BBM is not required add an extra argument to the function.

While at it add a function description.

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 48 ++++++++++++++++++++---------------
 arch/arm/include/asm/system.h | 18 +++++++++++++
 2 files changed, 46 insertions(+), 20 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index c4b3da4a8da7..29100913bc82 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -967,61 +967,69 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
 	flush_dcache_range(real_start, real_start + real_size);
 }
 
-/*
- * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
- * The procecess is break-before-make. The target region will be marked as
- * invalid during the process of changing.
- */
-void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
+void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
 {
 	int level;
 	u64 r, size, start;
 
-	start = addr;
-	size = siz;
 	/*
 	 * Loop through the address range until we find a page granule that fits
-	 * our alignment constraints, then set it to "invalid".
+	 * our alignment constraints, then set it to the new cache attributes
 	 */
+	start = addr;
+	size = siz;
 	while (size > 0) {
 		for (level = 1; level < 4; level++) {
-			/* Set PTE to fault */
-			r = set_one_region(start, size, PTE_TYPE_FAULT, true,
-					   level);
+			/* Set PTE to new attributes */
+			r = set_one_region(start, size, attrs, true, level);
 			if (r) {
-				/* PTE successfully invalidated */
+				/* PTE successfully updated */
 				size -= r;
 				start += r;
 				break;
 			}
 		}
 	}
-
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
+}
+
+/*
+ * Modify MMU table for a region with updated PXN/UXN/Memory type/valid bits.
+ * The procecess is break-before-make. The target region will be marked as
+ * invalid during the process of changing.
+ */
+void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
+{
+	int level;
+	u64 r, size, start;
 
+	start = addr;
+	size = siz;
 	/*
 	 * Loop through the address range until we find a page granule that fits
-	 * our alignment constraints, then set it to the new cache attributes
+	 * our alignment constraints, then set it to "invalid".
 	 */
-	start = addr;
-	size = siz;
 	while (size > 0) {
 		for (level = 1; level < 4; level++) {
-			/* Set PTE to new attributes */
-			r = set_one_region(start, size, attrs, true, level);
+			/* Set PTE to fault */
+			r = set_one_region(start, size, PTE_TYPE_FAULT, true,
+					   level);
 			if (r) {
-				/* PTE successfully updated */
+				/* PTE successfully invalidated */
 				size -= r;
 				start += r;
 				break;
 			}
 		}
 	}
+
 	flush_dcache_range(gd->arch.tlb_addr,
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
+
+	mmu_change_region_attr_nobreak(addr, siz, attrs);
 }
 
 #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 091082281c73..849b3d0efb7a 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -303,8 +303,26 @@ void flush_l3_cache(void);
  * @emerg: Also map the region in the emergency table
  */
 void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
+
+/**
+ * mmu_change_region_attr() - change a mapped region attributes
+ *
+ * @start: Start address of the region
+ * @size:  Size of the region
+ * @aatrs: New attributes
+ */
 void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
 
+/**
+ * mmu_change_region_attr_nobreak() - change a mapped region attributes without doing
+ *                                    break-before-make
+ *
+ * @start: Start address of the region
+ * @size:  Size of the region
+ * @aatrs: New attributes
+ */
+void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t size, u64 attrs);
+
 /*
  * smc_call() - issue a secure monitor call
  *
-- 
2.47.2

