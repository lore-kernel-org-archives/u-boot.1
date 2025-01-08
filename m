Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C466E77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 14:22:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C6D7800DF;
	Wed,  8 Jan 2025 15:22:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZjhVJgI6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 861A28036B; Wed,  8 Jan 2025 15:22:46 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74BC58006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 15:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-aaf60d85238so1260065966b.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 06:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736346164; x=1736950964; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2vpMmIw0tt4pEkEM1IouktG3DXpnNY7LidRqXotMSRY=;
 b=ZjhVJgI6ob1eM1QWCO8DCjXBUOblDiZp7AEfwznxVq44Ro+8qH4SDgySUJmzRvsJM4
 2et42uLwI9wpc1j6lcNz1PKVI86Dpj4urXKMZ+kC380EL/FQ53bSCcNWUN7iMfyqjusP
 /x+SCOYK6ds3naCDjQyUFcUD2dhbnpjDOd8oKUAJTGIN2b+ohgA8ytgwRPpiwV92P75d
 Tq4lIq4ofgYRI0azCdJR8Cj6w4XuHxCP2IQPXJvk2T/ma6AoD346TGUfsaTYGBllMCsr
 luC0tEpG18i5c+Ev5D5Nv4M1bgrhuFLpHeFgNNPQA+wCveASlYRtt5AauPni09N7vcAZ
 57IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736346164; x=1736950964;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2vpMmIw0tt4pEkEM1IouktG3DXpnNY7LidRqXotMSRY=;
 b=ihSlEuyQLdUW/uU5a7U8UG/2cG34JtQphU5XlMJjHrX8k9QMLDLZee3HaeL8us4Qp3
 lYpwxOJb4ngDaPKv3sdIyFRJr7ZvE2uuqBUFXikpq/tGIhMO8UFA4dL3OrkhmFsEHhM1
 IKRK4AXvti/ptZoifOcHXd32J9aRQY79iYygnBWP2u7jULjnzfYH9Xe9FPUf/tX9A1TU
 +cAl6IhgZBcWsGTA0lIcwFNmZyZkOD1QWdRGzPtDb76A3PR7g3XAF9TluV1uvPSMFoKD
 Jaxq+nwgMBDNRS1LbMJr3HmC/SlUsNoVS4FEJoZpDaWdGjOEbtkIURLmHQKcaD9CyxeF
 E5oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+Zrg0eVoVqeO76wtJ9QQrXdFeREL7q9wJr1QWnA1VfZa3P05Z/oCZ3h5kFOAicVGVayrJ0Zk=@lists.denx.de
X-Gm-Message-State: AOJu0YzMZ+hif1/jOyvKHAYy8eVYSb6fEJdaztcjH4EYhn4NbI8wROeX
 kicspwn8F6E0xTaES09kFx8VhOlkUlyUrroG4JbCbOybVy5RjWf2VdQntDCq0c4=
X-Gm-Gg: ASbGncuFxqF/6Pd9bJDI84+KU+LFXvbKWX7/WwDTgc7ROGbGPnKuG9DpKJndf8df4O4
 l9uKQKH7ahtFrYkwnUsapN6Evo3JreP0+EKe2SRnztyId/iF7bnjd7pRlYM/HaQBiIO8elxqcNx
 r+lHs4cKWxTF5bBTTTM85ADdyRtbFquUsJ3qcaTGTQKy4u2+N9flOUzhtitP9IiiFHuwISYrE2v
 FV7xDh+rUu/qD1qsiqs3DhUECvqfsQwz5JJJC8GyEYBXHqiD3XjRe7wy71N0yCPwonfl5MW0PVT
 Y6rNMFM96JRCwZk=
X-Google-Smtp-Source: AGHT+IESwwq3QqaKTlnXFFhOKIQWGMBSAmCoqJte2Tu+3IgyMO0Tcy7+WSHA2Gn+RyQtTHGiuo4dfg==
X-Received: by 2002:a17:907:9687:b0:aa6:912f:7ec1 with SMTP id
 a640c23a62f3a-ab2abc779dcmr242801666b.39.1736346163816; 
 Wed, 08 Jan 2025 06:22:43 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d806fedbbasm26220346a12.71.2025.01.08.06.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 06:22:42 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marc Zyngier <maz@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 =?UTF-8?q?Pierre-Cl=C3=A9ment=20Tosi?= <ptosi@google.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
Subject: [PATCH] armv8: mmu: don't switch to emergency tlb when adding a
 dynamic mapping
Date: Wed,  8 Jan 2025 15:22:24 +0100
Message-ID: <20250108142235.1194640-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

This seems to cause crashes on a bunch of Qualcomm platforms. It's safer
to just update the live table and flush it.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/cpu/armv8/cache_v8.c | 11 ++---------
 arch/arm/include/asm/system.h |  3 +--
 drivers/soc/qcom/cmd-db.c     |  2 +-
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index e6be6359c5d9..43051d156122 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -338,9 +338,9 @@ static void map_range(u64 virt, u64 phys, u64 size, int level,
 		size -= next_size;
 	}
 }
 
-void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
+void mmu_map_region(phys_addr_t addr, u64 size)
 {
 	u64 va_bits;
 	int level = 0;
 	u64 attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_INNER_SHARE;
@@ -350,19 +350,12 @@ void mmu_map_region(phys_addr_t addr, u64 size, bool emergency)
 	get_tcr(NULL, &va_bits);
 	if (va_bits < 39)
 		level = 1;
 
-	if (emergency)
-		map_range(addr, addr, size, level,
-			  (u64 *)gd->arch.tlb_emerg, attrs);
-
-	/* Switch pagetables while we update the primary one */
-	__asm_switch_ttbr(gd->arch.tlb_emerg);
-
 	map_range(addr, addr, size, level,
 		  (u64 *)gd->arch.tlb_addr, attrs);
 
-	__asm_switch_ttbr(gd->arch.tlb_addr);
+	flush_dcache_range(gd->arch.tlb_addr, gd->arch.tlb_size);
 }
 
 static void add_map(struct mm_region *map)
 {
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 52f6c9b934d7..475ca97c5c82 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -283,11 +283,10 @@ void flush_l3_cache(void);
  * Will be mapped MT_NORMAL & PTE_BLOCK_INNER_SHARE.
  *
  * @start: Start address of the region
  * @size: Size of the region
- * @emerg: Also map the region in the emergency table
  */
-void mmu_map_region(phys_addr_t start, u64 size, bool emerg);
+void mmu_map_region(phys_addr_t start, u64 size);
 void mmu_change_region_attr(phys_addr_t start, size_t size, u64 attrs);
 
 /*
  * smc_call() - issue a secure monitor call
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index 67be18e89f4d..4c8bd9abda23 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -202,9 +202,9 @@ static int cmd_db_bind(struct udevice *dev)
 		return -ENOENT;
 	}
 
 	/* On SM8550/SM8650 and newer SoCs cmd-db might not be mapped */
-	mmu_map_region((phys_addr_t)base, (phys_size_t)size, false);
+	mmu_map_region((phys_addr_t)base, (phys_size_t)size);
 
 	cmd_db_header = base;
 	if (!cmd_db_magic_matches(cmd_db_header)) {
 		log_err("%s: Invalid Command DB Magic\n", __func__);
-- 
2.47.0

