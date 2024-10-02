Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B95BCF6D2C
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 14:59:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AF0E89309;
	Wed,  2 Oct 2024 16:59:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m2DjmmRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EF1088F68; Wed,  2 Oct 2024 09:42:01 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 501AB88F01
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 09:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parth105105@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-53995380bb3so3524832e87.1
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 00:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727854918; x=1728459718; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hK/a9u7YkcV5oL/9+F+ANyeOp+H4GdDiq5LVRvL3uL4=;
 b=m2DjmmRBv57Fjo78XMb/EybfVnm7OQoP9qdJAgfACPgnJXlKtCRY/CL79NhpAg1NBX
 UKv+nugAN22MiGh9tiju9XsefNsPRJn+B3CrrbWy4hOscnKoVp+3xp1kIY34UXjlu53T
 l3OmXx/+zmlB/Eeb1kVbAeu8iHAbSktQj6AWPj/QXErHVNX48IEP+53NtkAyxZJ56BJh
 NN3x8Kcb622wmyWYT7rwN0XAgsaZfXEvQzGu4tKJJbimSrkGrcE0VMuDJXfVB0NLhtmv
 83RqipiXW8wvt65xmxqultqUAO1HOUU3eiVsaGfXg8nsHCSSNFPy00lLOU+V8DPv0sYT
 FLJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727854918; x=1728459718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hK/a9u7YkcV5oL/9+F+ANyeOp+H4GdDiq5LVRvL3uL4=;
 b=GXq5g4ki4tM29Yq5JvwbGavB8htWdtSI0IozV/oCMgR4Ijif2lzCCxn8C+kaH5Lp6R
 HKOQ1zWof4ityWRS8zCFK/A/VajT4SomNcBrkp7K7v5Gizpj19mZnyPU1DIrxn28Stf/
 QasTupq855ognIpEaytKIHpoKKkNgttCYRjC34ArNRNqj4EN7mk1iJ9OP0GDUhn9uS+a
 S3tbe9D6prYtv/GKIutkkVdncj6VPfseJfZrmumDQjSgT1WFiNln81/ZdAb7a5OR6G3b
 rpaBQgJZYAX8hDD+K+ZM+sZdQQ3fEEHpSckSMLXc08aqHXGEMdZcpv9LbatsWxf7P37G
 oK2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvRe5L93nasgo/tPS6HB39CBfJyLdItarTFFIt3bfmYbr5KD2bKpzX4wnYyEPalPVv36JS/l8=@lists.denx.de
X-Gm-Message-State: AOJu0YxW+YKBoVXuQf9Ot5sCL9lxLYvMGRxvOWyo5FeGZgEPIHNgYrMJ
 Sdhyq5rHICKO+h49TncBMDM/9F68Fi9JOXZYg3X8ce5cDBbw5/Xn
X-Google-Smtp-Source: AGHT+IFeuHF9ixf6GUjSnRwHWoeSyJ+apuP7Huvxp1f0yrrdmNeZd5HUqFBsC088Wz1k0Y6KrxaqlQ==
X-Received: by 2002:a05:6512:ea4:b0:535:6892:3be3 with SMTP id
 2adb3069b0e04-539a07a1e7fmr1134232e87.41.1727854918165; 
 Wed, 02 Oct 2024 00:41:58 -0700 (PDT)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f79ead8d8sm10946865e9.19.2024.10.02.00.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 00:41:56 -0700 (PDT)
From: Parth Pancholi <parth105105@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH] arm: mach-k3: am62: fixup thermal cooling device cpus
Date: Wed,  2 Oct 2024 09:41:33 +0200
Message-Id: <20241002074133.1749361-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 02 Oct 2024 16:59:01 +0200
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

From: Parth Pancholi <parth.pancholi@toradex.com>

AM62x devices now support CPU throttling based on thermal alerts
with a Linux commit 10e7bfd8114c ("arm64: dts: ti: k3-am62: Enable
CPU freq throttling on thermal alert"). However, this functionality
does not work correctly across all variants of the AM62x SoCs
which have different numbers of Cortex-A CPU cores: AM62x1 (1 core),
AM62x2 (2 cores), and AM62x4 (4 cores). On single-core and dual-core
AM62x devices, the following error is observed in the Linux kernel:

OF: /thermal-zones/main0-thermal/cooling-maps/map0: could not find
    phandle 94
OF: /thermal-zones/main1-thermal/cooling-maps/map0: could not find
    phandle 94

This commit adds a fixup to dynamically adjust the cooling-device
nodes in the thermal zones based on the actual number of CPU cores
available. This resolves the issue of CPU throttling not working
correctly on single-core and dual-core AM62x devices, while
maintaining the functionality for AM62x quad-core devices.

A similar approach is implemented for example on i.MX8MM SoC.

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 arch/arm/mach-k3/am62x/am625_fdt.c | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-k3/am62x/am625_fdt.c b/arch/arm/mach-k3/am62x/am625_fdt.c
index 8fe200a42318..ab9b573f3cff 100644
--- a/arch/arm/mach-k3/am62x/am625_fdt.c
+++ b/arch/arm/mach-k3/am62x/am625_fdt.c
@@ -5,6 +5,7 @@
 
 #include <asm/hardware.h>
 #include <fdt_support.h>
+#include <fdtdec.h>
 
 #include "../common_fdt.h"
 
@@ -75,12 +76,47 @@ static void fdt_fixup_thermal_zone_nodes_am625(void *blob, int maxc)
 	}
 }
 
+static void fdt_fixup_thermal_cooling_device_cpus_am625(void *blob, int core_nr)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/main0-thermal/cooling-maps/map0",
+		"/thermal-zones/main1-thermal/cooling-maps/map0"
+	};
+
+	int node, cnt, i, ret;
+	u32 cooling_dev[12];
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		int new_count = core_nr * 3;  /* Each CPU has 3 entries */
+		int j;
+
+		node = fdt_path_offset(blob, thermal_path[i]);
+		if (node < 0)
+			continue; /* Not found, skip it */
+
+		cnt = fdtdec_get_int_array_count(blob, node, "cooling-device",
+						 cooling_dev, ARRAY_SIZE(cooling_dev));
+		if (cnt < 0)
+			continue;
+
+		for (j = 0; j < new_count; j++)
+			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+
+		ret = fdt_setprop(blob, node, "cooling-device", cooling_dev,
+				  new_count * sizeof(u32));
+		if (ret < 0)
+			printf("Error %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_nodes_am625(blob, k3_get_core_nr());
 	fdt_fixup_gpu_nodes_am625(blob, k3_has_gpu());
 	fdt_fixup_pru_node_am625(blob, k3_has_pru());
 	fdt_fixup_thermal_zone_nodes_am625(blob, k3_get_max_temp());
+	fdt_fixup_thermal_cooling_device_cpus_am625(blob, k3_get_core_nr());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
 
-- 
2.34.1

