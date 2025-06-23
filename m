Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B1EC77B7C
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 17:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 957DF82E27;
	Mon, 23 Jun 2025 19:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bWWA0kPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C896182E2D; Mon, 23 Jun 2025 19:40:29 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECE7782D60
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 19:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-313a001d781so3215338a91.3
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750700425; x=1751305225; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dWnFlcGEsC+uF05ErKNU2gsHWLKF7m/yaz/dDCRm4aA=;
 b=bWWA0kPR3vRsLJBFME5tJtCA7P7cFD/NheejqafVf1745EjQeqvLmLJXD/oPkcMLFW
 Hs6dYPT0dv/CWN/usPLtGyJgKAhEmVKMaHanQHqQGvYBgB6piExeLBGnLIDkhwyadoAN
 kyqUW25QVzE7mXy/kD2QPkLR5gD5pbjDpAQvd+fQImeCXh2evmeWSFW3t3r6Oi6wglGF
 ZXPpfw9qJCNgrS5dt09ta1U1/zrUHdxSsRgmKI2R2vp5BGdgvaEuehNeAjQ+EjBduPgX
 g4DfxWzYeLTS1cbRdETwxoVJAiTVS2sA+st1B96r/DrhZ8KNuhCSSf4ay0JahRALJO4l
 WLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700425; x=1751305225;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWnFlcGEsC+uF05ErKNU2gsHWLKF7m/yaz/dDCRm4aA=;
 b=p9x1Qt7OEINGOyHpljwwXTaEg1/fMRqc0aSxthslenus9O/B8SiU/npmrHexzyRHxb
 HDD7q5AWZeKsg65BKXUnMquCLnmxU+buuxIAyJ6F+lZxSkjBiAH/9V+51vckgluQz98c
 wALN+Mw6i2T1O+rWS0WulJPOlvwIjxcyXACDWwijpgGgmZ8xmoH1uRj9OPyfqnF6zseC
 qen1lAz2DnoEMsLUS/A/pgfqLeivdQ5pH1vC4BkvnwU3Yt6mc6gx9XGihXpw6syse/6e
 2ktFoxCo1p4xc7dyklZqCLHkvogdQTLOY73k07uppYrcXtXCsE5ruVgZm0F8lZyd/LFk
 DRxg==
X-Gm-Message-State: AOJu0YxOI8xI+lg2+fexga28Cw0UbDYZixkT4E18pTexDztBaKxxLKBv
 JesaAcYeda9ZOc2wrZv2coUgqOFNOytlqDXaIPzh2I4zUdA6bm/wkQDI
X-Gm-Gg: ASbGnctPSJTxIMrEeoEq5BsFmEnrJhMTORp4lGiivl3kpsEvh6NgcwdBphZGmW/eZ/q
 lMuSJkLhcPZPEgnuWo7KiN5snbXWBsi/WOS0DJKntEvDF7zpaPbp6JvTnN2YmRBeOVs8Afx0A1h
 6oG5H543uuvspjTa1kJdZ+4USeGWlwVL5n4LegNc2xmJANEszS+vm+KFPFhyKpsTPwsutqLvH1g
 /xBBo64qaJxHyld6JFpJ8kIe6P7orD93RpiDfCXyxL6sBzweJ/8eg+6xCrP3XuOp0pl/mqy5KJ0
 EXH2qMJj5ly7w78Cc2lrD/TUWUA93gIJBd6llML2dZvTV4P7juzxg5Kqps0MHbmy7SdH0LMHA++
 uE5gV
X-Google-Smtp-Source: AGHT+IGnINXFb+MdrjAUUxu8yL9ethhNXQA3CqQavZpAhK9/6l2WA+SQUaDmcCz0lwHcvXyBCvF0eQ==
X-Received: by 2002:a17:90b:17c7:b0:311:b0ec:135f with SMTP id
 98e67ed59e1d1-3159d8fcf8fmr19128995a91.30.1750700425307; 
 Mon, 23 Jun 2025 10:40:25 -0700 (PDT)
Received: from [10.22.1.180] ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df8354bsm9465088a91.18.2025.06.23.10.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:40:24 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 23 Jun 2025 14:39:55 -0300
Subject: [PATCH 2/4] arm: mach-k3: Export common fdt fixups for use in
 board code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-am62p-fdt-fixup-trip-points-v1-2-12355eb6a72f@toradex.com>
References: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
In-Reply-To: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Avoid code duplication by making the common TI K3 device tree fixup
functions to be reusable by board-specific code.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm/mach-k3/am62ax/am62a7_fdt.c               |  3 +-
 arch/arm/mach-k3/am62px/am62p5_fdt.c               | 40 ++-------------------
 arch/arm/mach-k3/am62x/am625_fdt.c                 | 41 ++--------------------
 arch/arm/mach-k3/am65x/am654_fdt.c                 |  3 +-
 arch/arm/mach-k3/common_fdt.c                      | 38 +++++++++++++++++++-
 .../{common_fdt.h => include/mach/k3-common-fdt.h} |  7 ++--
 arch/arm/mach-k3/j721e/j721e_fdt.c                 |  3 +-
 arch/arm/mach-k3/j721s2/j721s2_fdt.c               |  3 +-
 arch/arm/mach-k3/j722s/j722s_fdt.c                 |  2 +-
 arch/arm/mach-k3/j784s4/j784s4_fdt.c               |  3 +-
 10 files changed, 51 insertions(+), 92 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
index 7f764ab36b564de2fb28ecd9c41d33de441165d5..c7c5d2f0885a432ab521df7080306d0c50691cfa 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -3,11 +3,10 @@
  * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <asm/hardware.h>
 #include <fdt_support.h>
 
-#include "../common_fdt.h"
-
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 2c40fa5a59410e2c1c53f8ec1bc256ec001d09a1..4d8061354c84c0f429d2ad0447bcdc2aea4d1004 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <asm/hardware.h>
-#include "../common_fdt.h"
 #include <fdt_support.h>
 
 static void fdt_fixup_cores_wdt_nodes_am62p(void *blob, int core_nr)
@@ -38,42 +38,6 @@ static void fdt_fixup_canfd_nodes_am62p(void *blob, bool has_canfd)
 	}
 }
 
-static int fdt_fixup_trips_node(void *blob, int zoneoffset, int maxc)
-{
-	int node, trip;
-
-	node = fdt_subnode_offset(blob, zoneoffset, "trips");
-	if (node < 0)
-		return -1;
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type = fdt_getprop(blob, trip, "type", NULL);
-
-		if (!type || (strncmp(type, "critical", 8) != 0))
-			continue;
-
-		if (fdt_setprop_u32(blob, trip, "temperature", 1000 * maxc) < 0)
-			return -1;
-	}
-
-	return 0;
-}
-
-static void fdt_fixup_thermal_zone_nodes_am62p(void *blob, int maxc)
-{
-	int node, zone;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return;
-
-	fdt_for_each_subnode(zone, blob, node) {
-		if (fdt_fixup_trips_node(blob, zone, maxc) < 0)
-			printf("Failed to set temperature in %s critical trips\n",
-			       fdt_get_name(blob, zone, NULL));
-	}
-}
-
 static void fdt_fixup_cpu_freq_nodes_am62p(void *blob, int max_freq)
 {
 	if (max_freq >= 1250000000)
@@ -90,7 +54,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_cores_wdt_nodes_am62p(blob, k3_get_core_nr());
 	fdt_fixup_video_codec_nodes_am62p(blob, k3_has_video_codec());
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
-	fdt_fixup_thermal_zone_nodes_am62p(blob, k3_get_max_temp());
+	fdt_fixup_thermal_critical_trips_k3(blob, k3_get_max_temp());
 	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
diff --git a/arch/arm/mach-k3/am62x/am625_fdt.c b/arch/arm/mach-k3/am62x/am625_fdt.c
index ab9b573f3cff3d6a341d688b703f16a31ca65494..e5d95ab7dd1bb2ea8b5d6469673a0b2566fd411c 100644
--- a/arch/arm/mach-k3/am62x/am625_fdt.c
+++ b/arch/arm/mach-k3/am62x/am625_fdt.c
@@ -3,12 +3,11 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <asm/hardware.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
 
-#include "../common_fdt.h"
-
 static void fdt_fixup_cores_nodes_am625(void *blob, int core_nr)
 {
 	char node_path[32];
@@ -40,42 +39,6 @@ static void fdt_fixup_pru_node_am625(void *blob, int has_pru)
 		fdt_del_node_path(blob, "/bus@f0000/pruss@30040000");
 }
 
-static int fdt_fixup_trips_node(void *blob, int zoneoffset, int maxc)
-{
-	int node, trip;
-
-	node = fdt_subnode_offset(blob, zoneoffset, "trips");
-	if (node < 0)
-		return -1;
-
-	fdt_for_each_subnode(trip, blob, node) {
-		const char *type = fdt_getprop(blob, trip, "type", NULL);
-
-		if (!type || (strncmp(type, "critical", 8) != 0))
-			continue;
-
-		if (fdt_setprop_u32(blob, trip, "temperature", 1000 * maxc) < 0)
-			return -1;
-	}
-
-	return 0;
-}
-
-static void fdt_fixup_thermal_zone_nodes_am625(void *blob, int maxc)
-{
-	int node, zone;
-
-	node = fdt_path_offset(blob, "/thermal-zones");
-	if (node < 0)
-		return;
-
-	fdt_for_each_subnode(zone, blob, node) {
-		if (fdt_fixup_trips_node(blob, zone, maxc) < 0)
-			printf("Failed to set temperature in %s critical trips\n",
-			       fdt_get_name(blob, zone, NULL));
-	}
-}
-
 static void fdt_fixup_thermal_cooling_device_cpus_am625(void *blob, int core_nr)
 {
 	static const char * const thermal_path[] = {
@@ -115,7 +78,7 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_cores_nodes_am625(blob, k3_get_core_nr());
 	fdt_fixup_gpu_nodes_am625(blob, k3_has_gpu());
 	fdt_fixup_pru_node_am625(blob, k3_has_pru());
-	fdt_fixup_thermal_zone_nodes_am625(blob, k3_get_max_temp());
+	fdt_fixup_thermal_critical_trips_k3(blob, k3_get_max_temp());
 	fdt_fixup_thermal_cooling_device_cpus_am625(blob, k3_get_core_nr());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
diff --git a/arch/arm/mach-k3/am65x/am654_fdt.c b/arch/arm/mach-k3/am65x/am654_fdt.c
index bcb15208be921a1633d74e25dbba54fb93ea58eb..73bca424da34586cfa35b32127817919af7a3ec2 100644
--- a/arch/arm/mach-k3/am65x/am654_fdt.c
+++ b/arch/arm/mach-k3/am65x/am654_fdt.c
@@ -3,10 +3,9 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <fdt_support.h>
 
-#include "../common_fdt.h"
-
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 867ed1731428d946246d971933b71ec4bc5ef953..2777354c6abae3205d47b92d2bba266154ac623a 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -3,11 +3,11 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include "common.h"
 #include <dm.h>
 #include <fdt_support.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
-#include "common_fdt.h"
 
 static int fdt_fixup_msmc_ram(void *blob, char *parent_path, char *node_name)
 {
@@ -164,3 +164,39 @@ add_carveout:
 
 	return 0;
 }
+
+static int fdt_fixup_critical_trips(void *blob, int zoneoffset, int maxc)
+{
+	int node, trip;
+
+	node = fdt_subnode_offset(blob, zoneoffset, "trips");
+	if (node < 0)
+		return -1;
+
+	fdt_for_each_subnode(trip, blob, node) {
+		const char *type = fdt_getprop(blob, trip, "type", NULL);
+
+		if (!type || (strncmp(type, "critical", 8) != 0))
+			continue;
+
+		if (fdt_setprop_u32(blob, trip, "temperature", 1000 * maxc) < 0)
+			return -1;
+	}
+
+	return 0;
+}
+
+void fdt_fixup_thermal_critical_trips_k3(void *blob, int maxc)
+{
+	int node, zone;
+
+	node = fdt_path_offset(blob, "/thermal-zones");
+	if (node < 0)
+		return;
+
+	fdt_for_each_subnode(zone, blob, node) {
+		if (fdt_fixup_critical_trips(blob, zone, maxc) < 0)
+			printf("Failed to set temperature in %s critical trips\n",
+			       fdt_get_name(blob, zone, NULL));
+	}
+}
diff --git a/arch/arm/mach-k3/common_fdt.h b/arch/arm/mach-k3/include/mach/k3-common-fdt.h
similarity index 68%
rename from arch/arm/mach-k3/common_fdt.h
rename to arch/arm/mach-k3/include/mach/k3-common-fdt.h
index 52c0795748389be46d6ba23aaab7065a930ba248..38a5bb82d954fa3060c41c50c08c54aec49fb3f2 100644
--- a/arch/arm/mach-k3/common_fdt.h
+++ b/arch/arm/mach-k3/include/mach/k3-common-fdt.h
@@ -3,12 +3,13 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
-#ifndef _COMMON_FDT_H
-#define _COMMON_FDT_H
+#ifndef _K3_COMMON_FDT_H
+#define _K3_COMMON_FDT_H
 
 int fdt_fixup_msmc_ram_k3(void *blob);
 int fdt_del_node_path(void *blob, const char *path);
 int fdt_fixup_reserved(void *blob, const char *name,
 		       unsigned int new_address, unsigned int new_size);
+void fdt_fixup_thermal_critical_trips_k3(void *blob, int maxc);
 
-#endif /* _COMMON_FDT_H */
+#endif /* _K3_COMMON_FDT_H */
diff --git a/arch/arm/mach-k3/j721e/j721e_fdt.c b/arch/arm/mach-k3/j721e/j721e_fdt.c
index bcb15208be921a1633d74e25dbba54fb93ea58eb..73bca424da34586cfa35b32127817919af7a3ec2 100644
--- a/arch/arm/mach-k3/j721e/j721e_fdt.c
+++ b/arch/arm/mach-k3/j721e/j721e_fdt.c
@@ -3,10 +3,9 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <fdt_support.h>
 
-#include "../common_fdt.h"
-
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/j721s2/j721s2_fdt.c b/arch/arm/mach-k3/j721s2/j721s2_fdt.c
index bcb15208be921a1633d74e25dbba54fb93ea58eb..73bca424da34586cfa35b32127817919af7a3ec2 100644
--- a/arch/arm/mach-k3/j721s2/j721s2_fdt.c
+++ b/arch/arm/mach-k3/j721s2/j721s2_fdt.c
@@ -3,10 +3,9 @@
  * Copyright 2023 Toradex - https://www.toradex.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <fdt_support.h>
 
-#include "../common_fdt.h"
-
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);
diff --git a/arch/arm/mach-k3/j722s/j722s_fdt.c b/arch/arm/mach-k3/j722s/j722s_fdt.c
index 29c832d28acf54d2ad73f76a4a3d135643bb6bb4..c7c5d2f0885a432ab521df7080306d0c50691cfa 100644
--- a/arch/arm/mach-k3/j722s/j722s_fdt.c
+++ b/arch/arm/mach-k3/j722s/j722s_fdt.c
@@ -3,8 +3,8 @@
  * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <asm/hardware.h>
-#include "../common_fdt.h"
 #include <fdt_support.h>
 
 int ft_system_setup(void *blob, struct bd_info *bd)
diff --git a/arch/arm/mach-k3/j784s4/j784s4_fdt.c b/arch/arm/mach-k3/j784s4/j784s4_fdt.c
index e127509705143ac93e9d26a7efc91aec55b81230..9c9a1382b419d3a4caa34613b696fcceda405097 100644
--- a/arch/arm/mach-k3/j784s4/j784s4_fdt.c
+++ b/arch/arm/mach-k3/j784s4/j784s4_fdt.c
@@ -6,10 +6,9 @@
  *	Apurva Nandan <a-nandan@ti.com>
  */
 
+#include <asm/arch/k3-common-fdt.h>
 #include <fdt_support.h>
 
-#include "../common_fdt.h"
-
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	return fdt_fixup_msmc_ram_k3(blob);

-- 
2.43.0

