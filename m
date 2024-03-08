Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1560CC5475B
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 10:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C2CC88075;
	Fri,  8 Mar 2024 11:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OdPmCFtw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E9328807B; Fri,  8 Mar 2024 11:13:06 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF9C87EF4
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 11:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3797bb48b6=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 4286FxoH031642; Fri, 8 Mar 2024 11:13:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=selector1; bh=C0NQpfM
 kBt8cf0x4Be6nUzwu9u2Imx+XbfpiPqCjCzA=; b=OdPmCFtwLHgRQ0gQTW0MQGz
 t+vfdRSlH2jk0r3FKZkw0inAPFJ/gyv3IKXElkdz/81lRlnDCmaSWq4K43u/OsH4
 q0wz07D+m5K4HD/W26A/oIzksC+8IJiJW2OPo1nVrzBqd6Y8hsOqubPQkLUI4hAB
 MdDeSK9oA2ZT8ZcXqLwoH+QLkCBjzUuupwgDn14JY+w4CW4G/8zrFjj9CuDdg/iV
 O+i8EMsWCekxrzDGjHQ1w8M8qWCJrDaxAt2fGgG6QhCpXPSbdvP4fgHVaFCV/gJj
 p7Ssi3LlJAlSgDn/ygL0ch7aWEwEy8oC+/CCR3x20R2IcwdJ6aiVZyO40uOh7cQ=
 =
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3wkuvj3xvu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Mar 2024 11:13:01 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 09F8940047;
 Fri,  8 Mar 2024 11:12:57 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D567C25ED6B;
 Fri,  8 Mar 2024 11:12:39 +0100 (CET)
Received: from localhost (10.252.7.115) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 8 Mar
 2024 11:12:39 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] stm32mp: Reserve OPTEE area in EFI memory map
Date: Fri, 8 Mar 2024 11:12:30 +0100
Message-ID: <20240308101230.2595220-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.7.115]
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_07,2024-03-06_01,2023-05-22_02
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

Since commit 7b78d6438a2b3 ("efi_loader: Reserve unaccessible memory")
memory region above ram_top is tagged in EFI memory map as
EFI_BOOT_SERVICES_DATA.
In case of STM32MP1 platform, above ram_top, there is one reserved-memory
region tagged "no-map" dedicated to OP-TEE (addr=de000000 size=2000000).

Before booting kernel, EFI memory map is first built, the OPTEE region is
tagged as EFI_BOOT_SERVICES_DATA and when reserving LMB, the tag LMB_NONE
is used.

Then after, the LMB are completed by boot_fdt_add_mem_rsv_regions()
which try to add again the same OPTEE region (addr=de000000 size=2000000)
but now with LMB_NOMAP tag which produces the following error message :

"ERROR: reserving fdt memory region failed (addr=de000000 size=2000000 flags=4)"

To avoid this, OPTEE area shouldn't be used by EFI, so we need to mark
it as reserved.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 arch/arm/mach-stm32mp/dram_init.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/mach-stm32mp/dram_init.c b/arch/arm/mach-stm32mp/dram_init.c
index fb1208fc5d5..f67f54f2ae0 100644
--- a/arch/arm/mach-stm32mp/dram_init.c
+++ b/arch/arm/mach-stm32mp/dram_init.c
@@ -7,6 +7,7 @@
 
 #include <common.h>
 #include <dm.h>
+#include <efi_loader.h>
 #include <image.h>
 #include <init.h>
 #include <lmb.h>
@@ -75,3 +76,14 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 
 	return reg + size;
 }
+
+void efi_add_known_memory(void)
+{
+	if (IS_ENABLED(CONFIG_EFI_LOADER))
+		/*
+		 * Memory over ram_top is reserved to OPTEE.
+		 * Declare to EFI only memory area below ram_top
+		 */
+		efi_add_memory_map(gd->ram_base, gd->ram_top - gd->ram_base,
+				   EFI_CONVENTIONAL_MEMORY);
+}
-- 
2.25.1

