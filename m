Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC5CEE49AB
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 00:18:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69307864BD;
	Wed, 23 Aug 2023 02:18:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="RTYWMV8P";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="FEx4mX0t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAFDD86403; Wed, 23 Aug 2023 02:18:46 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45943864B3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 02:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RVmz7590Jz9snh;
 Wed, 23 Aug 2023 02:18:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33tE8vV+hgGF1nnBeBAa/Hwl+h1HKM/alki6XM2xx68=;
 b=RTYWMV8PJOTgMsorH8WrhUEGWlerNSKNNLpnf09DSkV4gAyOEjXWZ68IsX9xDhaiXOANIo
 t8JLszvWCzTnfnoIOi9DPmusgtnQ+M5EwF0E0bQxpKazScxk2MrLwZjOgM7YDw4K1qxOwV
 rvKL087Ia+xZE+IS4Wx14TOF6ydMAlZZfxJidGbClU7MlZvkWHUpMJwxHmsEZuBbOcYrSe
 lq1JgroWw3IVmvGVyJif7nN9enwWis5BnhJbJOJ24Rls8aBpl04uFCKGhKnhT3vx77jq4b
 RdhRu1bMm7+2/N/HYuikV7b4agiH+CHGpBnN3omUMCNXPgYdiJ1Hd/7nC08Mng==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692749921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=33tE8vV+hgGF1nnBeBAa/Hwl+h1HKM/alki6XM2xx68=;
 b=FEx4mX0tDsawAb0g9C63hAdV7CKS+O4kA8qv7WBbabC6Qtnwzc9qAHN4RnBjEcb4Lof8sS
 qmfzQ2fLo5ezkf4/6KbReXftiujikdfLZiny1PBu1d1PZ2rkxhSk9LXpYnl85OUeFA6f4x
 0YSXqJJnnADmPMJhrtYwpJdW8cwmlRV1XR3tNMnyu2DfJR0zL4hnV3zAKRcN3u6T4eQLOp
 xkVbPQDu16yJWc2QRoBesSWu1PwWCFDfDu6YO4y8Fp2AGrZuDv070DiC0g0mA6PYByUp7t
 Ads1lxcMWlBQowe3PI2j25jOBSVtaeUKpwP3ZazGfJFY4ZCwF9h9KtWwQUOavg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/5] drivers/mtd/nvmxip: Rework the read accessor to
 support 32bit systems
Date: Wed, 23 Aug 2023 02:18:18 +0200
Message-Id: <20230823001821.266578-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
References: <20230823001821.266578-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: a4e9qqc8h5uja1ebiqwtg8zm1k941q37
X-MBO-RS-ID: 86d59d1fc2228f4a921
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

Get rid of nvmxip_mmio_rawread() and just implement the readl()/readq()
reader loop within nvmxip_blk_read(). Cast the destination buffer as
needed and increment the read by either 4 or 8 bytes depending on if
this is systemd with 32bit or 64bit physical address.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Simon Glass <sjg@chromium.org>
---
V2: No change
---
 drivers/mtd/nvmxip/nvmxip.c | 38 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/mtd/nvmxip/nvmxip.c b/drivers/mtd/nvmxip/nvmxip.c
index a359e3b4822..0bd98d64275 100644
--- a/drivers/mtd/nvmxip/nvmxip.c
+++ b/drivers/mtd/nvmxip/nvmxip.c
@@ -15,23 +15,6 @@
 #include <linux/errno.h>
 #include "nvmxip.h"
 
-/**
- * nvmxip_mmio_rawread() - read from the XIP flash
- * @address:	address of the data
- * @value:	pointer to where storing the value read
- *
- * Read raw data from the XIP flash.
- *
- * Return:
- *
- * Always return 0.
- */
-static int nvmxip_mmio_rawread(const phys_addr_t address, u64 *value)
-{
-	*value = readq(address);
-	return 0;
-}
-
 /**
  * nvmxip_blk_read() - block device read operation
  * @dev:	the block device
@@ -49,15 +32,14 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
 {
 	struct nvmxip_plat *plat = dev_get_plat(dev->parent);
 	struct blk_desc *desc = dev_get_uclass_plat(dev);
-	/* number of the u64 words to read */
-	u32 qwords = (blkcnt * desc->blksz) / sizeof(u64);
+	/* number of bytes to read */
+	u32 size = blkcnt * desc->blksz;
 	/* physical address of the first block to read */
 	phys_addr_t blkaddr = plat->phys_base + blknr * desc->blksz;
-	u64 *virt_blkaddr;
-	u64 *pdst = buffer;
+	void *virt_blkaddr;
 	uint qdata_idx;
 
-	if (!pdst)
+	if (!buffer)
 		return -EINVAL;
 
 	log_debug("[%s]: reading from blknr: %lu , blkcnt: %lu\n", dev->name, blknr, blkcnt);
@@ -66,12 +48,16 @@ static ulong nvmxip_blk_read(struct udevice *dev, lbaint_t blknr, lbaint_t blkcn
 
 	/* assumption: the data is virtually contiguous */
 
-	for (qdata_idx = 0 ; qdata_idx < qwords ; qdata_idx++)
-		nvmxip_mmio_rawread((phys_addr_t)(virt_blkaddr + qdata_idx), pdst++);
-
+#if IS_ENABLED(CONFIG_PHYS_64BIT)
+	for (qdata_idx = 0 ; qdata_idx < size; qdata_idx += sizeof(u64))
+		*(u64 *)(buffer + qdata_idx) = readq(virt_blkaddr + qdata_idx);
+#else
+	for (qdata_idx = 0 ; qdata_idx < size; qdata_idx += sizeof(u32))
+		*(u32 *)(buffer + qdata_idx) = readl(virt_blkaddr + qdata_idx);
+#endif
 	log_debug("[%s]:     src[0]: 0x%llx , dst[0]: 0x%llx , src[-1]: 0x%llx , dst[-1]: 0x%llx\n",
 		  dev->name,
-		  *virt_blkaddr,
+		  *(u64 *)virt_blkaddr,
 		  *(u64 *)buffer,
 		  *(u64 *)((u8 *)virt_blkaddr + desc->blksz * blkcnt - sizeof(u64)),
 		  *(u64 *)((u8 *)buffer + desc->blksz * blkcnt - sizeof(u64)));
-- 
2.40.1

