Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E85ECAC5B9
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 19:53:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63CDC8344E;
	Mon, 29 Sep 2025 21:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="KIngw2hs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5F28341C; Mon, 29 Sep 2025 21:52:58 +0200 (CEST)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC975832DA
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 21:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=openbsd.org
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=kettenis@openbsd.org
X-KPN-MessageId: f80d4c69-9d6d-11f0-b0b9-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
 by ewsoutbound.so.kpn.org (Halon) with ESMTPS
 id f80d4c69-9d6d-11f0-b0b9-00505699b430;
 Mon, 29 Sep 2025 21:53:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kpnmail.nl; s=kpnmail01;
 h=mime-version:message-id:date:subject:to:from;
 bh=EZrtevkCtkx1t7Om3HNRbn/jzI1WVEMkb1UZU/SklCw=;
 b=KIngw2hsUotmcIzjPz6UqOx54t8lGXk2oCvpRD+CK2BjffFwiZq/5h+whC4aH9IiKH8tNi4I806M+
 fbR+Hhjihouq/R2+WtN0wkEHd1/BUiytGBkMRycN/4g/TP7RO5bEgV+d+2j1nHplqSaYELeoGBjgka
 bKuF9FvgfR0dyDl8=
X-KPN-MID: 33|/HNxS2Tb5gfrWNTZjCQZo7g4D6GbuOZpZMXJwIcIHAnIqBYuq54lgjczO2ZM2SW
 68nWbEuy5eSlCjvZNYFlKnvI0M2sPNVe4eMjl0eLAf8A=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|bOuvzKy6FR/bEv9ysxxHBbzkrNgMh5pT/84+GzxebPDSszXInb+hy1zZO2YFrky
 cB/0zXtxYWUrB+Fw/vxcFvg==
X-Originating-IP: 80.61.163.207
Received: from bizet.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net
 [80.61.163.207]) by smtp.xs4all.nl (Halon) with ESMTPSA
 id e47bba44-9d6d-11f0-8d3e-00505699b758;
 Mon, 29 Sep 2025 21:52:55 +0200 (CEST)
From: Mark Kettenis <kettenis@openbsd.org>
To: u-boot@lists.denx.de
Cc: marex@denx.de,
	trini@konsulko.com,
	Mark Kettenis <kettenis@openbsd.org>
Subject: [PATCH v2 1/3] apple: Set up file system firmware loader
Date: Mon, 29 Sep 2025 21:52:39 +0200
Message-ID: <20250929195241.70351-2-kettenis@openbsd.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250929195241.70351-1-kettenis@openbsd.org>
References: <20250929195241.70351-1-kettenis@openbsd.org>
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

Find the appropriate EFI system partition on the internal NVMe
storage and set the U-Boot environment variables such that
the file system firmware loader can load firmware from it.

Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
---
 arch/arm/mach-apple/board.c | 59 +++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
index 4cd8979bdc2..d8b6787c705 100644
--- a/arch/arm/mach-apple/board.c
+++ b/arch/arm/mach-apple/board.c
@@ -8,6 +8,8 @@
 #include <efi_loader.h>
 #include <env.h>
 #include <lmb.h>
+#include <nvme.h>
+#include <part.h>
 
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
@@ -771,6 +773,60 @@ u64 get_page_table_size(void)
 	return SZ_256K;
 }
 
+static char *asahi_esp_devpart(void)
+{
+	struct disk_partition info;
+	struct blk_desc *nvme_blk;
+	const char *uuid = NULL;
+	int devnum, len, p, part, ret;
+	static char devpart[64];
+	struct udevice *dev;
+	ofnode node;
+
+	if (devpart[0])
+		return devpart;
+
+	node = ofnode_path("/chosen");
+	if (ofnode_valid(node)) {
+		uuid = ofnode_get_property(node, "asahi,efi-system-partition",
+					   &len);
+	}
+
+	nvme_scan_namespace();
+	for (devnum = 0, part = 0;; devnum++) {
+		nvme_blk = blk_get_devnum_by_uclass_id(UCLASS_NVME, devnum);
+		if (!nvme_blk)
+			break;
+
+		dev = dev_get_parent(nvme_blk->bdev);
+		if (!device_is_compatible(dev, "apple,nvme-ans2"))
+			continue;
+
+		for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+			ret = part_get_info(nvme_blk, p, &info);
+			if (ret < 0)
+				break;
+
+			if (info.bootable & PART_EFI_SYSTEM_PARTITION) {
+				if (uuid && strcasecmp(uuid, info.uuid) == 0) {
+					part = p;
+					break;
+				}
+				if (part == 0)
+					part = p;
+			}
+		}
+
+		if (part > 0)
+			break;
+	}
+
+	if (part > 0)
+		snprintf(devpart, sizeof(devpart), "%x:%x", devnum, part);
+
+	return devpart;
+}
+
 #define KERNEL_COMP_SIZE	SZ_128M
 
 #define lmb_alloc(size, addr) lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
@@ -780,6 +836,9 @@ int board_late_init(void)
 	u32 status = 0;
 	phys_addr_t addr;
 
+	env_set("storage_interface", blk_get_uclass_name(UCLASS_NVME));
+	env_set("fw_dev_part", asahi_esp_devpart());
+
 	/* somewhat based on the Linux Kernel boot requirements:
 	 * align by 2M and maximal FDT size 2M
 	 */
-- 
2.50.1

