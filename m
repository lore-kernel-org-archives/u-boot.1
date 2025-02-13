Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56848C0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 09:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C48E580BAE;
	Thu, 13 Feb 2025 10:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MFj/hPq5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B44AE80C77; Thu, 13 Feb 2025 10:23:31 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09CD2807C0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 10:23:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51D9NQJ34086896
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 13 Feb 2025 03:23:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739438606;
 bh=DY+bjjwLBnA/BT5QqiAapq+vItiNd6cdW0mgm8stv8Q=;
 h=From:To:CC:Subject:Date;
 b=MFj/hPq5/a9yngljAt1LSq0xyGsw4vVOYQ4w5vKNdYG71Wy//U+H1+n5BdDrqg0Pt
 C82v8jpU+nESMzaYoeprZMwFnJjxdNPnLbZNYEiD4Eo1gGtfhiiJ8pt41sUsNZdcja
 +x5O4woCyy5ayD/UvyN6hGj9R2zPg/C13FkD/vek=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51D9NQ1J028697
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 13 Feb 2025 03:23:26 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Feb 2025 03:23:26 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Feb 2025 03:23:25 -0600
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [172.24.227.151])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51D9NNOn004848;
 Thu, 13 Feb 2025 03:23:23 -0600
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>
CC: <hnagalla@ti.com>, <m-chawdhry@ti.com>, <bmeng.cn@gmail.com>,
 <sjg@chromium.org>, <u-kumar1@ti.com>, <afd@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH] remoteproc: k3-dsp: Flush D cache after loading firmware
Date: Thu, 13 Feb 2025 14:53:22 +0530
Message-ID: <20250213092322.1484706-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
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

From: Udit Kumar <u-kumar1@ti.com>

Memory region used by remote cores was set to non-cached region but
commit 7c9c6e192580 ("arm: mach-k3: Merge initial memory maps") makes
all memory region as cached, unified across K3 devices.

This causes inconsistency while booting remote cores on devices, due to
cache incoherency between remote core and boot code.

So to make this operation coherent, cache the address and len while
loading ELF program headers to memory and flush that region in the next
cycle of load.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
---
 drivers/remoteproc/ti_k3_dsp_rproc.c | 36 ++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/ti_k3_dsp_rproc.c b/drivers/remoteproc/ti_k3_dsp_rproc.c
index e90f75a188c..5a7d6377283 100644
--- a/drivers/remoteproc/ti_k3_dsp_rproc.c
+++ b/drivers/remoteproc/ti_k3_dsp_rproc.c
@@ -15,6 +15,7 @@
 #include <clk.h>
 #include <reset.h>
 #include <asm/io.h>
+#include <asm/system.h>
 #include <power-domain.h>
 #include <dm/device_compat.h>
 #include <linux/err.h>
@@ -56,7 +57,9 @@ struct k3_dsp_boot_data {
  * @data:		Pointer to DSP specific boot data structure
  * @mem:		Array of available memories
  * @num_mem:		Number of available memories
- * @in_use: flag to tell if the core is already in use.
+ * @cached_addr:	Cached memory address
+ * @cached_size:	Cached memory size
+ * @in_use:		flag to tell if the core is already in use.
  */
 struct k3_dsp_privdata {
 	struct reset_ctl dsp_rst;
@@ -64,6 +67,8 @@ struct k3_dsp_privdata {
 	struct k3_dsp_boot_data *data;
 	struct k3_dsp_mem *mem;
 	int num_mems;
+	void __iomem *cached_addr;
+	size_t cached_size;
 	bool in_use;
 };
 
@@ -158,6 +163,13 @@ static int k3_dsp_load(struct udevice *dev, ulong addr, ulong size)
 		goto unprepare;
 	}
 
+	if (dsp->cached_addr && IS_ENABLED(CONFIG_SYS_DISABLE_DCACHE_OPS)) {
+		dev_dbg(dev, "final flush 0x%lx to 0x%lx\n",
+			(ulong)dsp->cached_addr, dsp->cached_size);
+		__asm_invalidate_dcache_range((u64)dsp->cached_addr,
+					      (u64)dsp->cached_addr + (u64)dsp->cached_size);
+	}
+
 	boot_vector = rproc_elf_get_boot_addr(dev, addr);
 	if (boot_vector & (data->boot_align_addr - 1)) {
 		ret = -EINVAL;
@@ -253,7 +265,6 @@ static void *k3_dsp_da_to_va(struct udevice *dev, ulong da, ulong len)
 {
 	struct k3_dsp_privdata *dsp = dev_get_priv(dev);
 	phys_addr_t bus_addr, dev_addr;
-	void __iomem *va = NULL;
 	size_t size;
 	u32 offset;
 	int i;
@@ -263,6 +274,16 @@ static void *k3_dsp_da_to_va(struct udevice *dev, ulong da, ulong len)
 	if (len <= 0)
 		return NULL;
 
+	if (dsp->cached_addr && IS_ENABLED(CONFIG_SYS_DISABLE_DCACHE_OPS)) {
+		dev_dbg(dev, "flush 0x%lx to 0x%lx\n", (ulong)dsp->cached_addr,
+			dsp->cached_size);
+		__asm_invalidate_dcache_range((u64)dsp->cached_addr,
+					      (u64)dsp->cached_addr + (u64)dsp->cached_size);
+	}
+
+	dsp->cached_size = len;
+	dsp->cached_addr = NULL;
+
 	for (i = 0; i < dsp->num_mems; i++) {
 		bus_addr = dsp->mem[i].bus_addr;
 		dev_addr = dsp->mem[i].dev_addr;
@@ -270,19 +291,20 @@ static void *k3_dsp_da_to_va(struct udevice *dev, ulong da, ulong len)
 
 		if (da >= dev_addr && ((da + len) <= (dev_addr + size))) {
 			offset = da - dev_addr;
-			va = dsp->mem[i].cpu_addr + offset;
-			return (__force void *)va;
+			dsp->cached_addr = dsp->mem[i].cpu_addr + offset;
 		}
 
 		if (da >= bus_addr && (da + len) <= (bus_addr + size)) {
 			offset = da - bus_addr;
-			va = dsp->mem[i].cpu_addr + offset;
-			return (__force void *)va;
+			dsp->cached_addr = dsp->mem[i].cpu_addr + offset;
 		}
 	}
 
 	/* Assume it is DDR region and return da */
-	return map_physmem(da, len, MAP_NOCACHE);
+	if (!dsp->cached_addr)
+		dsp->cached_addr = map_physmem(da, len, MAP_NOCACHE);
+
+	return dsp->cached_addr;
 }
 
 static const struct dm_rproc_ops k3_dsp_ops = {
-- 
2.34.1

