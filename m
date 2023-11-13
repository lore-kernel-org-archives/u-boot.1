Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A8AC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 19:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42F2C86D1D;
	Mon, 13 Nov 2023 20:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ad08kdq4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAD8C86F88; Mon, 13 Nov 2023 20:07:48 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52A3B86564
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 20:07:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6bf03b98b9bso4308448b3a.1
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 11:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699902463; x=1700507263; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rEZB6ys1fANSwRLgi7c8jFQ7iBZrav9ob9RGaF9TNn8=;
 b=Ad08kdq45HgObW3EoK4jta1vyoJH6Vlqr//0TI5Gbg+q09L4OjL+LnLiLfdoCRlt8v
 xb5I9sMeqUQ37mbfpnEEkhMzM4bkYruwOA0q5lE5MD/xjnQ1oDocsHzlWmyeC3Yy4XSU
 EA4HPJKnrbkCwWFeuU/emtAoGeFqHnBaGGyKpxSxmqn9xvBT4lTyXB+z2a3jR1OEoom2
 At8pIKQxwJTIRJ1tvilMw966wdgqdBYF2QVxHEy5Zyd59ThBEQjByWYU1oscYsuqoL6z
 vcTYxkh+4HanHy77R+RwCPwt3iFu78L07jFJ+M/IFKO8ENUX2zrOlOYJ5Guy7G7AF/No
 YDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699902463; x=1700507263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rEZB6ys1fANSwRLgi7c8jFQ7iBZrav9ob9RGaF9TNn8=;
 b=LxJ4SBxH3HQVMf0sWICH7s6F1j51hlhOADGJ3BgAKgP8arQSWyvj4XOxNuUExxMGq0
 XiJ1A7xUtcn1o7ruFuMB/YfDt/gIPd7IjYXSSBYUioodzKYgW6UcKoXa4P7OriEMacpo
 +ExKkWClGD5UifrLJhG0VhUxz7B24HBMyc+2o8CbWjHr4I2unwsOMSS3m7nx4alOmb9o
 00y9JBkLiexG7VV7qgwfLbvCuseHXWi0VPOkpBuVMkzkMkEN0TsI9f2ZNUMYQkBybYT2
 Xsyw/E+K+TZsWRI2jQhyRB6ShIwmY9LlJkjXTX8/Kpq3L/PM3de+EUTyd7OBf6j4ggQP
 fdVw==
X-Gm-Message-State: AOJu0YxTvIx7pOEJS6eNnLtaEgfaUSDq4wXzrpyYUj5/HEv2TP1KPFqI
 wAk6WNn9tY8an9KbJt3n+d0=
X-Google-Smtp-Source: AGHT+IG+/+toX7zPhbmQ+wMJI45SE/Qqmdz30pb5q1uZbcv9Ci5g9h/wIfm2JCI5VqkkUbiZZ2v69A==
X-Received: by 2002:a05:6a00:4c93:b0:68a:5cf8:dae4 with SMTP id
 eb19-20020a056a004c9300b0068a5cf8dae4mr700677pfb.3.1699902463409; 
 Mon, 13 Nov 2023 11:07:43 -0800 (PST)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 b27-20020aa78edb000000b006bd26bdc909sm4111500pfr.72.2023.11.13.11.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 11:07:42 -0800 (PST)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: [PATCH 1/1] arm: k3: Enable instruction cache for main domain SPL
Date: Mon, 13 Nov 2023 16:07:21 -0300
Message-Id: <20231113190721.1841748-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 13 Nov 2023 20:16:24 +0100
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Change spl_enable_dcache so it also enable icache on SPL
initialization for the main domain part of the boot flow. This
improves bootloader booting time.

Link: https://lore.kernel.org/all/20231109140958.1093235-1-joao.goncalves@toradex.com/
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 arch/arm/mach-k3/am625_init.c  | 2 +-
 arch/arm/mach-k3/am654_init.c  | 2 +-
 arch/arm/mach-k3/common.c      | 4 ++--
 arch/arm/mach-k3/common.h      | 2 +-
 arch/arm/mach-k3/j721e_init.c  | 2 +-
 arch/arm/mach-k3/j721s2_init.c | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 8fa36f7b91..1d4ef35e7b 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -209,7 +209,7 @@ void board_init_f(ulong dummy)
 		if (ret)
 			panic("DRAM init failed: %d\n", ret);
 	}
-	spl_enable_dcache();
+	spl_enable_cache();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/am654_init.c b/arch/arm/mach-k3/am654_init.c
index 0d3889cde2..f46b063d91 100644
--- a/arch/arm/mach-k3/am654_init.c
+++ b/arch/arm/mach-k3/am654_init.c
@@ -259,7 +259,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
 #endif
-	spl_enable_dcache();
+	spl_enable_cache();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index c3006ba387..f609e3001f 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -522,7 +522,7 @@ void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size)
 	}
 }
 
-void spl_enable_dcache(void)
+void spl_enable_cache(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
 	phys_addr_t ram_top = CFG_SYS_SDRAM_BASE;
@@ -543,7 +543,7 @@ void spl_enable_dcache(void)
 	      gd->arch.tlb_addr + gd->arch.tlb_size);
 	gd->relocaddr = gd->arch.tlb_addr;
 
-	dcache_enable();
+	enable_caches();
 #endif
 }
 
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index eabb44f620..bb84e98b55 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -37,7 +37,7 @@ void disable_linefill_optimization(void);
 void remove_fwl_configs(struct fwl_data *fwl_data, size_t fwl_data_size);
 int load_firmware(char *name_fw, char *name_loadaddr, u32 *loadaddr);
 void k3_sysfw_print_ver(void);
-void spl_enable_dcache(void);
+void spl_enable_cache(void);
 void mmr_unlock(uintptr_t base, u32 partition);
 bool is_rom_loaded_sysfw(struct rom_extended_boot_data *data);
 enum k3_device_type get_device_type(void);
diff --git a/arch/arm/mach-k3/j721e_init.c b/arch/arm/mach-k3/j721e_init.c
index b1f7e25ed0..7d793801de 100644
--- a/arch/arm/mach-k3/j721e_init.c
+++ b/arch/arm/mach-k3/j721e_init.c
@@ -287,7 +287,7 @@ void board_init_f(ulong dummy)
 	if (ret)
 		panic("DRAM init failed: %d\n", ret);
 #endif
-	spl_enable_dcache();
+	spl_enable_cache();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
diff --git a/arch/arm/mach-k3/j721s2_init.c b/arch/arm/mach-k3/j721s2_init.c
index a5be84b147..d46d91e652 100644
--- a/arch/arm/mach-k3/j721s2_init.c
+++ b/arch/arm/mach-k3/j721s2_init.c
@@ -232,7 +232,7 @@ void k3_mem_init(void)
 		if (ret)
 			panic("DRAM 1 init failed: %d\n", ret);
 	}
-	spl_enable_dcache();
+	spl_enable_cache();
 }
 
 /* Support for the various EVM / SK families */
-- 
2.34.1
