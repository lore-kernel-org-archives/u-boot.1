Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3489FCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 18:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 391A3848B9;
	Mon, 25 May 2026 20:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="gM70CD8d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF5C3848BB; Mon, 25 May 2026 20:42:41 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F10DA8482E
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 20:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josh2@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B9F5B26AAB;
 Mon, 25 May 2026 20:42:39 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Aqns7zixhVGG; Mon, 25 May 2026 20:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779734559; bh=f80pKm3dRA9NMfWptWdk6doI6kdSEkMZEH9cSf376Us=;
 h=From:To:Cc:Subject:Date;
 b=gM70CD8dn3j1qf/DPMkEpbMn05c+KpsDe4ZzuTlBLwH53u/gsbbiK7vJzm2m9qKrF
 trR7ZzgLY5SrqQpFeLFl/C9jr/3XTktSoZBoTRz4gYhi2xy8qntylelPTwB8nRDcd2
 OCcu8NTmD/D+Fy7bBpY+05DxEF2Ya3CY+y0qRWdsmM7v7PyZIpzYDcTPmsNaImyugP
 4eHKrQBjcXroOXLU6kC74dEHR4j4Ou97QwPP2095VyY7oyWwbyZVb7eSfcqv8nMJce
 SOXXltalKXc6RYvt3LbSGxcdcXWW2PcIE+zjhSdQCmBn3jTA+OkvUgU9fYg+tQqZVS
 natcQviEQLxOA==
From: Josh Law <josh2@disroot.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Josh Law <josh2@disroot.org>
Subject: [PATCH] armv8: sec_firmware: check secure memory bounds
Date: Mon, 25 May 2026 18:42:32 +0000
Message-ID: <20260525184232.3043-1-josh2@disroot.org>
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

sec_firmware_load_image() copies the firmware image into the reserved
secure memory area after the MMU tables. The FIT image size was used
without checking that the copy still fits inside that reservation.

Loadable images use the same secure memory area and had the same issue.

Check the destination range before copying either image type. Keep the
copy size as size_t so the FIT image size is not truncated before
memcpy().

Signed-off-by: Josh Law <josh2@disroot.org>
---
 arch/arm/cpu/armv8/sec_firmware.c | 50 ++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index 8c31fd19399..5b15739c9b7 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -26,6 +26,7 @@ extern void c_runtime_cpu_setup(void);
 #define SEC_FIRMWARE_LOADED	0x1
 #define SEC_FIRMWARE_RUNNING	0x2
 #define SEC_FIRMWARE_ADDR_MASK	(~0x3)
+#define SEC_FIRMWARE_PHYS_ADDR_MAX	((phys_addr_t)~0ULL)
 /*
  * Secure firmware load addr
  * Flags used: 0x1 secure firmware has been loaded to secure memory
@@ -47,6 +48,24 @@ static int sec_firmware_get_data(const void *sec_firmware_img,
 				      data, size);
 }
 
+static int sec_firmware_check_copy_range(phys_addr_t dest, size_t size)
+{
+	phys_addr_t secure_start;
+	phys_addr_t secure_end;
+
+	secure_start = gd->arch.secure_ram & MEM_RESERVE_SECURE_ADDR_MASK;
+	if (CFG_SYS_MEM_RESERVE_SECURE >
+	    SEC_FIRMWARE_PHYS_ADDR_MAX - secure_start)
+		return -EOVERFLOW;
+
+	secure_end = secure_start + CFG_SYS_MEM_RESERVE_SECURE;
+	if (dest < secure_start || dest > secure_end ||
+	    size > secure_end - dest)
+		return -ENOSPC;
+
+	return 0;
+}
+
 /*
  * SEC Firmware FIT image parser checks if the image is in FIT
  * format, verifies integrity of the image and calculates raw
@@ -87,7 +106,7 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 	size_t size;
 	ulong load;
 	const char *str, *type;
-	int count, i, len;
+	int count, i, len, ret;
 
 	conf_node_off = fit_conf_get_node(sec_firmware_img, NULL);
 	if (conf_node_off < 0) {
@@ -153,8 +172,20 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 		}
 
 		/* Compute load address for loadable in secure memory */
-		sec_firmware_loadable_addr = (sec_firmware_addr -
-						gd->arch.tlb_size) + load;
+		sec_firmware_loadable_addr = sec_firmware_addr -
+					     gd->arch.tlb_size;
+		if (load > SEC_FIRMWARE_PHYS_ADDR_MAX -
+		    sec_firmware_loadable_addr) {
+			printf("SEC Loadable: invalid load address\n");
+			return -EOVERFLOW;
+		}
+		sec_firmware_loadable_addr += load;
+		ret = sec_firmware_check_copy_range(sec_firmware_loadable_addr,
+						    size);
+		if (ret) {
+			printf("SEC Loadable: image exceeds secure memory\n");
+			return ret;
+		}
 
 		/* Copy loadable to secure memory and flush dcache */
 		debug("%s copied to address 0x%p\n",
@@ -180,7 +211,7 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 }
 
 static int sec_firmware_copy_image(const char *title,
-			 u64 image_addr, u32 image_size, u64 sec_firmware)
+			 u64 image_addr, size_t image_size, u64 sec_firmware)
 {
 	debug("%s copied to address 0x%p\n", title, (void *)sec_firmware);
 	memcpy((void *)sec_firmware, (void *)image_addr, image_size);
@@ -236,10 +267,13 @@ static int sec_firmware_load_image(const void *sec_firmware_img,
 	if (ret)
 		goto out;
 
-	/* TODO:
-	 * Check if the end addr of SEC Firmware has been extend the secure
-	 * memory.
-	 */
+	ret = sec_firmware_check_copy_range(sec_firmware_addr &
+					    SEC_FIRMWARE_ADDR_MASK,
+					    raw_image_size);
+	if (ret) {
+		printf("SEC Firmware: image exceeds secure memory\n");
+		goto out;
+	}
 
 	/* Copy the secure firmware to secure memory */
 	ret = sec_firmware_copy_image("SEC Firmware", (u64)raw_image_addr,
-- 
2.47.3

