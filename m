Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B38AC54E90
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 15:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4A3F830F4;
	Thu, 22 May 2025 17:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a5XcI/nt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9105783100; Thu, 22 May 2025 17:10:20 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55600830E9
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 17:10:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 54MFAGeC1849072;
 Thu, 22 May 2025 10:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1747926616;
 bh=kYuGCLta0Gk/OGYJj+/ARYfLxx0jRvb3WMlOmw7WbT0=;
 h=From:To:CC:Subject:Date;
 b=a5XcI/ntsA9Ih1rrwnfVQstkC1iO0UXhXN+k8SkCigp2VwISSOpC5RyO6jGz4Xr20
 yP42gdNxvlvBAt76tLTRDCHqRx4Ahuw8ScxvZvf2+5+vj1xx3eng3WA9m5kHWphwTo
 9xNY7v3dYsiK3OlwimJAmR8zgduvUDdRIAh5Lx04=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 54MFAGDG3582918
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 22 May 2025 10:10:16 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 22
 May 2025 10:10:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 22 May 2025 10:10:16 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 54MFAFWe691522;
 Thu, 22 May 2025 10:10:15 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v1] ti: k3: abstract common fdt api for reserved mem fixups
Date: Thu, 22 May 2025 20:39:40 +0530
Message-ID: <20250522150941.563959-1-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

The usage of fdt_fixup_reserved is repeated for ATF and OP-TEE for
multiple platforms, this patch creates a single fdt API for fixing up
the reserved-memory node with added error handling.

All k3 platforms already share a common tispl template which ensures
binaries are loaded as per the respective CONFIG_*_LOAD_ADDR. And the
provided new_size for the fixup is overridden by the size from fdt node
anyways. This allows for safe abstraction of the reserved memory fixups
for all current platforms.

fdt_fixup_reserved now abstracts the ATF and OP-TEE fixups by calling
the renamed static fdt_fixup_reserved_memory function with the required
parameters.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/mach-k3/am62ax/am62a7_fdt.c |  5 +----
 arch/arm/mach-k3/am62px/am62p5_fdt.c |  5 +----
 arch/arm/mach-k3/am62x/am625_fdt.c   |  5 +----
 arch/arm/mach-k3/common_fdt.c        | 22 ++++++++++++++++++++--
 arch/arm/mach-k3/common_fdt.h        |  3 +--
 arch/arm/mach-k3/j722s/j722s_fdt.c   |  5 +----
 6 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-k3/am62ax/am62a7_fdt.c b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
index 7f764ab36b5..9a4599432ff 100644
--- a/arch/arm/mach-k3/am62ax/am62a7_fdt.c
+++ b/arch/arm/mach-k3/am62ax/am62a7_fdt.c
@@ -10,8 +10,5 @@
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 2c40fa5a594..9f4b1663864 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -92,8 +92,5 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
 	fdt_fixup_thermal_zone_nodes_am62p(blob, k3_get_max_temp());
 	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/am62x/am625_fdt.c b/arch/arm/mach-k3/am62x/am625_fdt.c
index 11152194ed0..e4382508dc3 100644
--- a/arch/arm/mach-k3/am62x/am625_fdt.c
+++ b/arch/arm/mach-k3/am62x/am625_fdt.c
@@ -118,8 +118,5 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 	fdt_fixup_pru_node_am625(blob, k3_has_pru());
 	fdt_fixup_thermal_zone_nodes_am625(blob, k3_get_max_temp());
 	fdt_fixup_thermal_cooling_device_cpus_am625(blob, k3_get_core_nr());
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
diff --git a/arch/arm/mach-k3/common_fdt.c b/arch/arm/mach-k3/common_fdt.c
index 75f0469f456..5b89b85a852 100644
--- a/arch/arm/mach-k3/common_fdt.c
+++ b/arch/arm/mach-k3/common_fdt.c
@@ -115,8 +115,9 @@ int fdt_del_node_path(void *blob, const char *path)
 	return ret;
 }
 
-int fdt_fixup_reserved(void *blob, const char *name,
-		       unsigned int new_address, unsigned int new_size)
+static int fdt_fixup_reserved_memory(void *blob, const char *name,
+				     unsigned int new_address,
+				     unsigned int new_size)
 {
 	int nodeoffset, subnode;
 	int ret;
@@ -167,3 +168,20 @@ add_carveout:
 
 	return 0;
 }
+
+int fdt_fixup_reserved(void *blob)
+{
+	int ret;
+
+	ret = fdt_fixup_reserved_memory(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR,
+					0x80000);
+	if (ret)
+		return ret;
+
+	ret = fdt_fixup_reserved_memory(blob, "optee",
+					CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/arch/arm/mach-k3/common_fdt.h b/arch/arm/mach-k3/common_fdt.h
index 52c07957483..e2f26983a73 100644
--- a/arch/arm/mach-k3/common_fdt.h
+++ b/arch/arm/mach-k3/common_fdt.h
@@ -8,7 +8,6 @@
 
 int fdt_fixup_msmc_ram_k3(void *blob);
 int fdt_del_node_path(void *blob, const char *path);
-int fdt_fixup_reserved(void *blob, const char *name,
-		       unsigned int new_address, unsigned int new_size);
+int fdt_fixup_reserved(void *blob);
 
 #endif /* _COMMON_FDT_H */
diff --git a/arch/arm/mach-k3/j722s/j722s_fdt.c b/arch/arm/mach-k3/j722s/j722s_fdt.c
index 29c832d28ac..97d34f50539 100644
--- a/arch/arm/mach-k3/j722s/j722s_fdt.c
+++ b/arch/arm/mach-k3/j722s/j722s_fdt.c
@@ -9,8 +9,5 @@
 
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
-	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
-	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);
-
-	return 0;
+	return fdt_fixup_reserved(blob);
 }
-- 
2.49.0

