Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A266C3DA61
	for <u-boot@archiver.kernel.org>; Sat, 27 Jul 2024 07:22:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2333887F5;
	Sat, 27 Jul 2024 09:20:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.b="fSnYj3aG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F09887BE; Sat, 27 Jul 2024 09:20:39 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E42088755
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 09:20:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=9elements.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrick.rudolph@9elements.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a7d26c2297eso229243966b.2
 for <u-boot@lists.denx.de>; Sat, 27 Jul 2024 00:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=9elements.com; s=google; t=1722064837; x=1722669637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ICUjlWgwZzv3jhA1gIwbreE89kaBZSvvnWDxrN1P4qA=;
 b=fSnYj3aGlNP9MhB2jY0S/ri1ZGbG0p/ar32v04ST7yqDvqGPWK71bGZdOBQx25MF2C
 QUdJDdQCu6S8UQM6dDH05UhQ2/o1E4f83pGlEu2a9RKs5XNi33bggEEzusvUGSazAiqw
 DRSKbo7soHaCQPJduCdaXD2sUQtjiDaAVLJkQJQ+FihJkYz5ZUzdWTCMlx8jHUzGLRYv
 3c55sxFfXftYn5ne4MHmDnZ0WLzfYfeS11LH1iMLkfGFNM1vEQtpanIjoipJlITudFTQ
 qCaWOc1WlZRaBGZ1tK7aoIPqaAWNTw3apoV1bWTi7L9opUr2k4YcoX+H0tKxd5E+ZyXx
 XOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722064837; x=1722669637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ICUjlWgwZzv3jhA1gIwbreE89kaBZSvvnWDxrN1P4qA=;
 b=Hm8QoRC7mhRM30fKDpkiuQ3GDW+Bmf6PdebLm9NowRFjzEKdl/6s1bVZ7JGmeItGqT
 6mymevf80oN8ea6MAn4TbcSEU8BFqbAeGGuFM7MJLZ2aJ/QFWg9JuJyNQDz41/6/9Wcd
 u4/xXiLBAQNdfQMDFFpNgJWIF49SuISTuRSsuuTRd+1lk3dLig3AXRKhQ7Mhxosk6RKU
 IFmw5yEHp681E0372ogxbJpe0kjXiCHq4R8/qhyhlZvvxyZXZlEsIrtnVZ477Sc5cbFC
 cCsCB9+uI+AVIHMUI5545ifgalJ2Qvp6gP+Ecuubm2H7lUcf6JbeDHs9g9iDoYGBFNKz
 +Urg==
X-Gm-Message-State: AOJu0YzFJJ3xBiuzQCo2cTp48/Mi3L5uHx580OClaAF3qc5sWEoijN5h
 Qcon5ABTBbO3tZRE1h1zumArR5lvU+EXw+8Dx+5Z+v0JK2PvChZwyI7+TXM8VQkj6ykHi6tGEGp
 bqbI=
X-Google-Smtp-Source: AGHT+IEjUiACpZE+FYohCb6Tx4EFmAR5wzIBjcaLjlACmDagBGdMj/4Tm/2GBIZ5d3Vvd4UsiPvauw==
X-Received: by 2002:a17:907:96a0:b0:a7a:a0c9:124e with SMTP id
 a640c23a62f3a-a7d3ffadf1amr131160466b.4.1722064836677; 
 Sat, 27 Jul 2024 00:20:36 -0700 (PDT)
Received: from fedora.sec.9e.network
 (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab231f2sm253102866b.7.2024.07.27.00.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Jul 2024 00:20:36 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, bmeng.cn@gmail.com,
 Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: [PATCH 15/17] arm: mach-bcm283x: Add ARMV8_MULTIENTRY support
Date: Sat, 27 Jul 2024 09:17:16 +0200
Message-ID: <20240727071742.1735703-16-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
References: <20240727071742.1735703-1-patrick.rudolph@9elements.com>
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

When ACPI is enabled over FDT the APs cannot be brought out of reset
by the OS using the "FDT spin-table" mechanism, as no FDT is provided
to the OS. The APs must be released out of reset in u-boot and then
brought up in an ACPI compliant fashion.

When ARMV8_MULTIENTRY is specified the APs are released from reset
and will enter U-Boot after it has been relocated as well.

By default ARMV8_MULTIENTRY is not selected, keeping existing behaviour.

TEST: All APs enter U-Boot when run on qemu-system-aarch64

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: Peter Robinson <pbrobinson@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-bcm283x/Kconfig |  2 ++
 arch/arm/mach-bcm283x/init.c  | 47 +++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm/mach-bcm283x/Kconfig b/arch/arm/mach-bcm283x/Kconfig
index b3287ce8bc..de783aa8f5 100644
--- a/arch/arm/mach-bcm283x/Kconfig
+++ b/arch/arm/mach-bcm283x/Kconfig
@@ -12,6 +12,7 @@ config BCM2836
 config BCM2837
 	bool "Broadcom BCM2837 SoC support"
 	depends on ARCH_BCM283X
+	select ARCH_EARLY_INIT_R
 
 config BCM2837_32B
 	bool "Broadcom BCM2837 SoC 32-bit support"
@@ -29,6 +30,7 @@ config BCM2837_64B
 config BCM2711
 	bool "Broadcom BCM2711 SoC support"
 	depends on ARCH_BCM283X
+	select ARCH_EARLY_INIT_R
 
 config BCM2711_32B
 	bool "Broadcom BCM2711 SoC 32-bit support"
diff --git a/arch/arm/mach-bcm283x/init.c b/arch/arm/mach-bcm283x/init.c
index 80a10f2212..f6ccc76f39 100644
--- a/arch/arm/mach-bcm283x/init.c
+++ b/arch/arm/mach-bcm283x/init.c
@@ -7,6 +7,7 @@
  */
 
 #include <acpi/acpi_table.h>
+#include <asm-generic/sections.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <dm/device.h>
@@ -201,6 +202,52 @@ int mach_cpu_init(void)
 					       "brcm,bcm2712-pm");
 	if (offset > soc)
 		rpi_wdog_base = fdt_get_base_address(gd->fdt_blob, offset);
+	return 0;
+}
+
+int arch_early_init_r(void)
+{
+	int cpus, offset;
+	const char *prop;
+	u64 release_addr64;
+	uintptr_t *start_address;
+
+	if (CONFIG_IS_ENABLED(ARMV8_MULTIENTRY)) {
+		/*
+		 * Release CPUs from reset after u-boot has been relocated.
+		 */
+		cpus = fdt_path_offset(gd->fdt_blob, "/cpus");
+		if (cpus < 0)
+			return -ENODEV;
+
+		for (offset = fdt_first_subnode(gd->fdt_blob, cpus);
+		     offset >= 0;
+		     offset = fdt_next_subnode(gd->fdt_blob, offset)) {
+			prop = fdt_getprop(gd->fdt_blob, offset, "device_type", NULL);
+			if (!prop || strcmp(prop, "cpu"))
+				continue;
+
+			prop = fdt_getprop(gd->fdt_blob, offset, "enable-method", NULL);
+			if (!prop || strcmp(prop, "spin-table"))
+				continue;
+
+			release_addr64 = fdtdec_get_uint64(gd->fdt_blob, offset,
+							   "cpu-release-addr", ~0ULL);
+			if (release_addr64 == ~0ULL)
+				continue;
+
+			/* Point to U-Boot start */
+			start_address = (uintptr_t *)(uintptr_t)release_addr64;
+			*start_address = (uintptr_t)_start;
+
+			if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+				flush_dcache_range(release_addr64,
+						   release_addr64 + sizeof(uintptr_t));
+			/* Send an event to wake up the secondary CPU. */
+			asm("dsb	ishst\n"
+			    "sev");
+		}
+	}
 
 	return 0;
 }
-- 
2.45.2

