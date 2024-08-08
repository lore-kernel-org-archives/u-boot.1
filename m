Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F349C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:01:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13C3588BCD;
	Fri,  9 Aug 2024 01:59:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cWUMuMcn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CA6F88BB6; Fri,  9 Aug 2024 01:59:49 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8126A88BC7
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 01:59:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso130412966b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723161586; x=1723766386; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=04osG1A9hoXMWl+0lh8GWl0YeWw+AupZfabTs31eXLM=;
 b=cWUMuMcngL8aERXu/MmC8TnPFor98udMMh6CSviDM+zpeOniyxfAzTcgUZCE03l5NN
 cAaOv3Evvzla2AdMcbofcai6Y5FsitJBbLwnl+om4ZCafQYt/NYrW44vY1Y3zWwhXl+q
 shTfwyJ/PcBuXpZaBj52GJYlNQMBTKFex3DDfypzfp+gFi6RyTsVZe65ZeyzYyjBu2Vv
 rbGUfOzLL21YO2W7USgSz8FGtA093sT8rp0c4TwJb7wNIPy4x5N5MVthUCNgLI6U0pC7
 bpwKzAkqX1/vFElFRyD2W4btiV6bus83ImkIAOTY/OmAIflZ6/sA+j40CAKgLyQ/Ugm2
 aeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723161586; x=1723766386;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=04osG1A9hoXMWl+0lh8GWl0YeWw+AupZfabTs31eXLM=;
 b=VIyrtP9q/9eV+b4Jvktxsj44EeP/Xl0/m91B+c1uyJof6YFWqaeEqSMiMk/AHS2cGe
 jx78fIv3FhPPTJdgVhkj+R4wJqPJwqbmXDKaDLjbiMyVKK/cL7yYjaVnJUpGmN/FNyys
 fLnnqCiRD0M1WWwED+xRSNd1tFzy3MIh5W00n0ula4kDWQ7GsOz4b2L/jkLN/FQ5OIHA
 o7hPp7IHIvZoc06llLShyUQhAt6MkKIBo6Z+pxzsKCBN2jfhkDRHa35LpwxBSvqM0uzg
 FpTaEqf2Hi4/vM2/j1yX7QpYUNAU0brTwnH4AIlQt9jJXAajm7figGBBwWjq+BoM3cSW
 htfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCD6njiPTav9Pg0xsWWosBLCjzxOxRiHI+NU+bG4zWBqiLVYe0Iqfs/LOxxiyTQnY/d8Y5NsX0TkVCxLTHoQiXoeUVKA==
X-Gm-Message-State: AOJu0YygQqzfpnZheqaVufqe3y1JANNtac3dI7FZF2WPCD2LJrBzsqHH
 qO1wGSJf2P5gzdNhNhmJ0X4OY7tL4L2vX+3pVLTMMAv4yYUI3MWvityjNKmB7KM=
X-Google-Smtp-Source: AGHT+IH7lrqzpSEoGaPXM8DYa2OgUmUyC8DOSCkgcFLTCh0zTdhz/sEGmaQwdw4GLiZfrQD0A/LXcQ==
X-Received: by 2002:a17:907:7290:b0:a79:82c1:a5b2 with SMTP id
 a640c23a62f3a-a8090c26c00mr263458866b.9.1723161585896; 
 Thu, 08 Aug 2024 16:59:45 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45423sm784047866b.134.2024.08.08.16.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 16:59:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 01:59:31 +0200
Subject: [PATCH 08/11] armv8: mmu: add a way to map additional regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-snapdragon-improvements-v1-8-7c353f3e8f74@linaro.org>
References: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
In-Reply-To: <20240809-b4-snapdragon-improvements-v1-0-7c353f3e8f74@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=I+9ipfeNdEptTRnpJiTjsZesLVLKr+Y6p2Fs08UVmcU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtVvobIeQbqh0IgzdDxxKb8j3yFwz0qz8tMg7y
 /Hpzc3wsxeJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVb6AAKCRAFgzErGV9k
 tpRnD/9UXoG/5VVqClH6ewJQRSG++InweyM2SovAbUMqhzqPyPyLi1asUQOusORbhGg7wnYYxZ8
 5wBWbWL3EKDTl+DlGrGUQq0c4tE3XAHbugyiVuH9ZCtDQFyT4GxOuyecKdrEgHp5vrJHGnKOm71
 pqtiK0n4UG67jjnymmCfNDjdX2bmGi1YK2aVJQ87AqTZi/q95oq+KFyStux3imaVfCAefjnwKwG
 E5il1eoJewzvq4UAatIy7SacErQsSeT5lYbY5RSR1E7EZKzvmALodNaRAq78NE97uOCzFaxiSBB
 C7XWWWQvUE8iRo5gkJD9sne9DeOGo2xgTq3RHJZ4WSGByyNbIB38uORlN5xJBOeWRo5GBKFZ1IG
 CXv7qQfgRWLYUmMLI2z1zuSwjxr1qnI6WmKf3gLbCT7v/OM9zVohzFIm2BsG2/tkX3iLUJ9pfH1
 2AmliBy8BJw6eo2PcrYbl8MoBnjPmMxOIksX96h5+hCcMt2LuZ1sZHn3yAIoaEWbq9L8S108LVw
 Xu7Ss268wuW2pEghDtw1rMq+LnrJBBWZtwZo3dXnFIRt6z6q9x1YDyPFs2IQ8Qtt550lDWLwDxi
 CuBJ795g5mLaLcfAHrYeJfABvfDIT9ISCF2IamVRBN2Kz3qJOKgy1bLMD5kxLYrrIQ1bqHKlc9s
 d+oM/55l8KObLMA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

In some cases we might want to map some memory region after enabling
caches. Introduce a new helper for this.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 25 +++++++++++++++++++++++++
 arch/arm/include/asm/system.h | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index c3f8dac648ba..631d9efa5e10 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -338,8 +338,33 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
 		size -= next_size;
 	}
 }
 
+void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
+{
+	u64 va_bits;
+	int level = 0;
+	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
+
+	attrs |= PTE_TYPE_BLOCK | PTE_BLOCK_AF;
+
+	get_tcr(NULL, &va_bits);
+	if (va_bits < 39)
+		level = 1;
+
+	if (emergency)
+		map_range(addr, addr, size, level,
+			  (u64 *)gd->arch.tlb_emerg, attrs);
+
+	/* Switch pagetables while we update the primary one */
+	__asm_switch_ttbr(gd->arch.tlb_emerg);
+
+	map_range(addr, addr, size, level,
+		  (u64 *)gd->arch.tlb_addr, attrs);
+
+	__asm_switch_ttbr(gd->arch.tlb_addr);
+}
+
 static void add_map(struct mm_region *map)
 {
 	u64 attrs = map->attrs | PTE_TYPE_BLOCK | PTE_BLOCK_AF;
 	u64 va_bits;
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 7e30cac32a09..2237d7d00668 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -276,8 +276,18 @@ void wait_for_wakeup(void);
 void protect_secure_region(void);
 void smp_kick_all_cpus(void);
 
 void flush_l3_cache(void);
+
+/**
+ * mmu_map_region() - map a region of previously unmapped memory.
+ * Will be mapped MT_NORMAL & PTE_BLOCK_INNER_SHARE.
+ *
+ * @start: Start address of the region
+ * @size: Size of the region
+ * @emerg: Also map the region in the emergency table
+ */
+void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
 void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
 
 /*
  * smc_call() - issue a secure monitor call

-- 
2.46.0

