Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D968FC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 07:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B77480D1C;
	Thu, 30 Jan 2025 08:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QHvjhpLn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B201981F0D; Thu, 30 Jan 2025 08:21:35 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D15DA81F95
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 08:21:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso4333175e9.0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738221691; x=1738826491; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KICAciBS1Dm1QdXLPe+9RsuF2+IGx+Q6jXy+Aj1RYr8=;
 b=QHvjhpLnhKoq6SJm2SPnTiFrT8yLxlTa4yGmrhPp6bARGoo/Nx3tR3mAXa7MdKeSUC
 h2reDI4qGryEFxt31r5gRI2ER7fztT1tD7RtiHNte6emieQUMrxalFAB3NTLkfASobW5
 UE8jdi+mXTTW1K01C3YdT2HCOYsJmEzoQpxbZtF5jT5YPf7iM6D4rtpmI6k3vvT+oSRa
 fFZ5k+ub8+lT4H25G9qJHndtjfyzWvClrWmufY7xNHMjOqOiyAtPyityWhjQd97uzhM9
 o9w244h7Uk09lKq6Sby/4dB9vhmPNjjwbHBZ6WTcHsaqvOwK8AsJKPowroFVjVo5YQvv
 ASAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738221691; x=1738826491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KICAciBS1Dm1QdXLPe+9RsuF2+IGx+Q6jXy+Aj1RYr8=;
 b=AJwguwadwYOGElmJbr0o6nnHkl7tc7Q3ZXi17nfNW7v019SzEcPNZyUdmphYeKuiE9
 pGlto5+bY2kbX5IkwlotF4t7Yc7ESGjDyGTlHVwa7qlWYRj9R8HUEMtsKAZ4SgVbdHH7
 xagMJUoeiluKCIABuTKH4n+nlQ1y/1AUU6owxhTf+PVCIz/580oOIUwi2euYATjndodi
 7g9omy34P/3h7kXKCpw+84DddwlOG9cixVi8C7TGi73lw8a+9SEgCyq+j6ZoTN8dIYOt
 CCVNI7Q7JIr4hJBURRthQ3NFDIF03ZhcJ3L2rGPB1CEThhcz4gmYo47clxLmt54U1MhK
 RFRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu/nUvGRpye9CBcqBi9XiD9ShxHps4JVD/iQqEJnBFMSTuY6gcbtOovXjSrOLFcjwZYI8YjgU=@lists.denx.de
X-Gm-Message-State: AOJu0Yz4xHbDKhHtKxFTUt7fitgq4cqJO/FMUMAG6Er/dTEvzIrv9mb0
 WRjValhekB1JpYuoo0nt45X9semXOjvJ6LjOmdB/p6OtTd794SXEeR7Yu7Vr/30=
X-Gm-Gg: ASbGncu8CVELCZ1COmBhUglKHlUiCVVc+LmMqYkueec0SGcsygBkS2bg1EcyW9kY/2g
 6QCBoqyKKOCd6MbHTcbuvU6KcrSZtWjvZuk4y6D/oFm0MmBb2xzkLwfBG5Hp6uWaj53N01b1gUc
 oTWEiY8srldWKf8a13tbAIlMPXJSNe6s9UCYmzs3lDDDA7fcLZusUuOrxmp/24yrkR77blvpcuQ
 VM9cI6SVovKnS3EpuV1NYujE5tgownH7IHbg82TBrjmV4Wj2yikN0GLvBqkkQXkcNvyWMbsdPIB
 hCpK3y+NWUTamw8pG6zJEpxXLme9XmzZqwNDIrrZkO6WKFNXsw==
X-Google-Smtp-Source: AGHT+IGkmrQfKLpskhAbZdr19pl/n83nkMDfmWchUPEZt3cR7QOwqHzEyT6GZLduwbMFM0tCxQO4CQ==
X-Received: by 2002:a05:600c:5489:b0:434:a0bf:98ea with SMTP id
 5b1f17b1804b1-438dc3becffmr45456075e9.9.1738221691179; 
 Wed, 29 Jan 2025 23:21:31 -0800 (PST)
Received: from hades.. (ppp176092181030.access.hol.gr. [176.92.181.30])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df2asm48076345e9.29.2025.01.29.23.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 23:21:30 -0800 (PST)
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
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [RFC PATCH 3/4] arm64: mmu_change_region_attr() add an option not to
 break PTEs
Date: Thu, 30 Jan 2025 09:20:28 +0200
Message-ID: <20250130072100.27297-4-ilias.apalodimas@linaro.org>
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

The ARM ARM on section 8.17.1 describes the cases where
break-before-make is required when changing live page tables.
Since we can use this function to tweak block and page permssions,
where BBM is not required add an extra argument to the function.

While at it add a function we can use to change the attributes of normal
memory without breaking the pages tables first

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c           | 27 ++++++++++++++++++++++++-
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++++-----
 arch/arm/include/asm/system.h           |  3 ++-
 arch/arm/mach-snapdragon/board.c        |  2 +-
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index a4ca56c8ed42..60d0870013e8 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -968,11 +968,14 @@ void mmu_set_region_dcache_behaviour(phys_addr_t start, size_t size,
  * The procecess is break-before-make. The target region will be marked as
  * invalid during the process of changing.
  */
-void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
+void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs, bool bbm)
 {
 	int level;
 	u64 r, size, start;
 
+	if (!bbm)
+		goto skip_bbm;
+
 	start = addr;
 	size = siz;
 	/*
@@ -997,6 +1000,7 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
 			   gd->arch.tlb_addr + gd->arch.tlb_size);
 	__asm_invalidate_tlb_all();
 
+skip_bbm:
 	/*
 	 * Loop through the address range until we find a page granule that fits
 	 * our alignment constraints, then set it to the new cache attributes
@@ -1020,6 +1024,27 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
 	__asm_invalidate_tlb_all();
 }
 
+void mmu_set_attrs(phys_addr_t addr, size_t size, int type)
+{
+	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE | PTE_TYPE_VALID;
+
+	switch (type) {
+	case 1:
+	/* RO */
+		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN | PTE_BLOCK_RO;
+		break;
+	case 2:
+		/* RX */
+		attrs |= PTE_BLOCK_RO;
+		break;
+	case 3:
+		/* RW */
+		attrs |= PTE_BLOCK_PXN | PTE_BLOCK_UXN;
+	}
+
+	mmu_change_region_attr(addr, size, attrs, false);
+}
+
 #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 
 /*
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index d2d3e346a36f..caf1dab05936 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -1573,7 +1573,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 	} else {
 		mmu_change_region_attr(
 					CFG_SYS_SDRAM_BASE,
@@ -1581,7 +1581,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 #ifdef CONFIG_SYS_DDR_BLOCK3_BASE
 #ifndef CONFIG_SYS_DDR_BLOCK2_SIZE
 #error "Missing CONFIG_SYS_DDR_BLOCK2_SIZE"
@@ -1594,7 +1594,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 			mmu_change_region_attr(
 					CONFIG_SYS_DDR_BLOCK3_BASE,
 					gd->ram_size -
@@ -1603,7 +1603,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 		} else
 #endif
 		{
@@ -1614,7 +1614,7 @@ void update_early_mmu_table(void)
 					PTE_BLOCK_MEMTYPE(MT_NORMAL)	|
 					PTE_BLOCK_OUTER_SHARE		|
 					PTE_BLOCK_NS			|
-					PTE_TYPE_VALID);
+					PTE_TYPE_VALID, true);
 		}
 	}
 }
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index dbf9ab43e280..0a8ca19e45e9 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -287,8 +287,9 @@ void flush_l3_cache(void);
  * @emerg: Also map the region in the emergency table
  */
 void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
-void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
+void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs, bool bbm);
 
+void mmu_set_attrs(phys_addr_t addr, size_t size, int type);
 /*
  * smc_call() - issue a secure monitor call
  *
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 2ef936aab757..13f4e8e640ef 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -577,7 +577,7 @@ static void carve_out_reserved_memory(void)
 		if (i == count || start + size < res[i].start - SZ_2M) {
 			debug("  0x%016llx - 0x%016llx: reserved\n",
 			      start, start + size);
-			mmu_change_region_attr(start, size, PTE_TYPE_FAULT);
+			mmu_change_region_attr(start, size, PTE_TYPE_FAULT, true);
 			/* If this is the final region then quit here before we index
 			 * out of bounds...
 			 */
-- 
2.43.0

