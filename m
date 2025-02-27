Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920CCC021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 12:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30F43811A7;
	Thu, 27 Feb 2025 13:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DAPIlLj8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33ECF801FB; Thu, 27 Feb 2025 13:15:53 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D86810EA
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 13:15:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so122818966b.2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740658550; x=1741263350; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6JyPI1S6xBDKgWp6CFwNc+WJrzcMVyQFEDE89E/GLJY=;
 b=DAPIlLj8bPRVvNUDT2XH+7hSncIQzsEB5+i0QLBZWgOnVpSNaVfsO3cOI6LajlDB0X
 YW56UbLVWyTgWodlx9WuGQgwGVXq2n4FmoPsMqPpO2rVhXYf4+reZc9Qkj5ytkTGgwil
 T4uanojCEPIgmvTedIA/iNIck+i+x+kQoVoNyvWBbuuhe9H2Kz9LHmudQNvMeEnEXwuw
 Wx7PB3Fjxgrd+pNZA8DQbkbU+df7vJMVKXeNW5e8Sz2tntP7BeKm9EiUFOPOH9fKBBUx
 y1DNODGqsydrh3qoczTyFimHNebu5J14vFQhP/oLBhYD5ClMwyoFRtAkn8E5swpXffrG
 GMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740658550; x=1741263350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6JyPI1S6xBDKgWp6CFwNc+WJrzcMVyQFEDE89E/GLJY=;
 b=e4+zA708ee1K0fjRn+t/0Am5iA4m5luxuE55nvrjp2To7e5//Tf3oJowHy6QCyhhm/
 q/W8vhZc7BXLmCFWMRT137nUqMsxuN3qxnPl3+W26wSn0zikU8DiP7Te2NtWDmMSGJkh
 CL3vrYaqcuPUnuRfdUu1ND7sny4gkZm2WWB21vqnClno8AeCGK78ZqOmEpO/MU91ZRk4
 UGE1yIIcBeHINg7AHpX2lWDNmtqMM6US8Xdx8yCCEflyTIgLlG3w3BpRVxELZF/0YbCE
 t+5lchRRUkzmEGpmjZpsB8lX5reKNhOJjhM8wBjrnjR4g8l6grx3Dxbx6Qz5EKyUtkf7
 FyOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU1fQJkbwyq1yG2/S6OnEaOVbDP3TrOeS6Phx2xN5NVvUk9StJqDA6f7PjHH1AXXyY+sx57tM=@lists.denx.de
X-Gm-Message-State: AOJu0YxXkrwLpEKou1kGm4Hlr4EsQDDXEXPt5OIrWRP4bLBIdJT/KcBZ
 yo+87cnlVMM69UD5Oat/BiLkMDOipJH3Iuhe4YAgE89jUbgChIe7c6NePNUTN9o=
X-Gm-Gg: ASbGncvR2DNnR99gLc2LLGI9HBXddQyTsu0IUCIn/cKFEDETb0numRUsFh1bdbYHPNN
 pkoZJpUmS7KoGK2XqkWcMmWGy8svbA5Q7pexcbvoqR1jIvvrEImYOJKHQJx0Oiuou9Q8l9IXjOh
 Kx46wf7wIOa1cJ+WT+lkwJYN8HREhPkbP6HDLFzuwfrjjZZGVgPaZzMuLeHYIECsKmlCqx11i52
 A638nuvuY4mitDpOzk/2do7fXzXQ2Z+irqS8mfZIUWaPEfZiINJF2z8vgmh4PPbtE1AZcQfbOwR
 gkEwNBwUUubp69Jj/1JIe6xFH8vxvzv3N0ewe7S377pXggrh9smtzAv6JZQJvx9/s0cnExDvUtB
 RBoS/
X-Google-Smtp-Source: AGHT+IHe7rd17iJbpFL7GLYhISzycH3PAPS+YBqFV08GxcTWbn9Oe8d2yepDWDeBcbKTVZQ6dOFXGw==
X-Received: by 2002:a17:907:1b22:b0:abf:b2f:fef7 with SMTP id
 a640c23a62f3a-abf0b300382mr334268866b.29.1740658550536; 
 Thu, 27 Feb 2025 04:15:50 -0800 (PST)
Received: from localhost.localdomain (ppp176092191135.access.hol.gr.
 [176.92.191.135]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c0dc168sm114736566b.70.2025.02.27.04.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 04:15:50 -0800 (PST)
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
 Jerome Forissier <jerome.forissier@linaro.org>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Joshua Watt <jpewhacker@gmail.com>, Raymond Mao <raymond.mao@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Jonas Jelonek <jelonek.jonas@gmail.com>, uboot-snps-arc@synopsys.com,
 u-boot@lists.denx.de
Subject: [PATCH v3 4/6] arm64: mmu_change_region_attr() add an option not to
 break PTEs
Date: Thu, 27 Feb 2025 14:14:54 +0200
Message-ID: <20250227121515.232996-5-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
References: <20250227121515.232996-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Feb 2025 13:56:54 +0100
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
 arch/arm/cpu/armv8/cache_v8.c | 28 ++++++++++++++++++++++++++++
 arch/arm/include/asm/system.h | 18 ++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index c4b3da4a8da7..504fef34bf0f 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -1024,6 +1024,34 @@ void mmu_change_region_attr(phys_addr_t addr, size_t siz, u64 attrs)
 	__asm_invalidate_tlb_all();
 }
 
+void mmu_change_region_attr_nobreak(phys_addr_t addr, size_t siz, u64 attrs)
+{
+	int level;
+	u64 r, size, start;
+
+	/*
+	 * Loop through the address range until we find a page granule that fits
+	 * our alignment constraints, then set it to the new cache attributes
+	 */
+	start = addr;
+	size = siz;
+	while (size > 0) {
+		for (level = 1; level < 4; level++) {
+			/* Set PTE to new attributes */
+			r = set_one_region(start, size, attrs, true, level);
+			if (r) {
+				/* PTE successfully updated */
+				size -= r;
+				start += r;
+				break;
+			}
+		}
+	}
+	flush_dcache_range(gd->arch.tlb_addr,
+			   gd->arch.tlb_addr + gd->arch.tlb_size);
+	__asm_invalidate_tlb_all();
+}
+
 #else	/* !CONFIG_IS_ENABLED(SYS_DCACHE_OFF) */
 
 /*
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index dbf9ab43e280..802640de3b64 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -287,8 +287,26 @@ void flush_l3_cache(void);
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

