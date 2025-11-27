Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D547FD111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 19:26:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 100118449C;
	Thu, 27 Nov 2025 20:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WWli5QiT";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="MOMhI2uH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F30D0844C5; Thu, 27 Nov 2025 20:26:49 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94F968444D
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 20:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dHRJ716hXz9tB5;
 Thu, 27 Nov 2025 20:26:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764271607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YOmEo0Ws6CcnOFs70J6z3ZQsdAehhz9yIrzntjWjRWM=;
 b=WWli5QiTYl/x4NT3SZkup8VFh0mN4SbMg5/11KO2QvF09x+sWjJQlG1vn9pkMGHuUE7E8z
 eUuVb1gEdKrWVKns4VCOXiOdjMcDa6oZzW/IQ610G0eQoLhJEcgvqo9GZ+Zdlh6bgwrAHu
 OAHHwI0pL+BonLmqmPwW2q9IYC5TqOM2VYDpjQfvjIq1mdyzw5qJ50OpKuxO+rIClsXkxE
 rsu3qeGYdkifwD33XIlY5d6GFpomh32U9McQ4tOuz51jcKyg/4TrUYB6SzLdDj2Mz9H46p
 xMw8wQtGiD612U8pLrLOGhTLHVzEXh8pb8OCgFcGJbZghiattsFsWaDg5RJzOw==
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764271605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YOmEo0Ws6CcnOFs70J6z3ZQsdAehhz9yIrzntjWjRWM=;
 b=MOMhI2uHME4fixdT1GJp/z2KdUVVafWNkP0NNRA9mnxDGj88RoBewZEMzAkrg3A75oLWOM
 2wl9IEqMiIhze4tMsSSprqZS9nVndc5dqPXJUv4YKpU/7numQHB9ebQsCZ9dYGJIvGZTOU
 Ac/iIx6W+z2TFCv93SOCADxG4hWQJ5NbQAPKBptqhQivadqxPn0bsUBysrMqGZQokWgV3/
 2ZUeXCPVnkBv9RYwxVM6/T/E4KG6x0pPioPeuErUwqNvVMVetYe5klN6XBfHuoYEAVh7dw
 hVGuD2pT8eQhKG8G7o6PsHSpijQvNnTks/fRWUs0bBkPa0xAx3CWlu6rZ15pUA==
To: u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, Marek Vasut <marek.vasut@mailbox.org>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
Date: Thu, 27 Nov 2025 20:25:21 +0100
Message-ID: <20251127192633.79935-1-marek.vasut@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: cb9f9c99d16e7001954
X-MBO-RS-META: bznancgsebpyjp4fiqpncxbt5rrcchth
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

The PQC support is available on i.MX94 and i.MX95 B0 and newer.
This can be detected at runtime using is_imx94()/is_imx95() and
soc_rev() macros.

Eliminate IMX_PQC_SUPPORT and CONTAINER_HDR_ALIGNMENT and make
U-Boot generic on i.MX95 A0, A1, B0 and newer once more.

Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: "João Paulo Gonçalves" <joao.goncalves@toradex.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
NOTE: Compile-tested only
---
 arch/arm/mach-imx/image-container.c | 20 +++++++++++---------
 arch/arm/mach-imx/imx9/Kconfig      |  2 --
 common/spl/Kconfig                  |  7 -------
 common/spl/spl_imx_container.c      |  7 ++++---
 include/imx_container.h             | 23 +++++++++++++----------
 5 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 78f2488cf6d..59169db2fa0 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -131,7 +131,8 @@ int get_container_size(ulong addr, u16 *header_length)
 
 static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length, bool *v2x_cntr)
 {
-	u8 *buf = malloc(CONTAINER_HDR_ALIGNMENT);
+	const int hdr_alignment = container_hdr_alignment();
+	u8 *buf = malloc(hdr_alignment);
 	int ret = 0;
 
 	if (!buf) {
@@ -146,7 +147,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 		count = blk_dread(mmc_get_blk_desc(mmc),
 				  offset / mmc->read_bl_len,
-				  CONTAINER_HDR_ALIGNMENT / mmc->read_bl_len,
+				  hdr_alignment / mmc->read_bl_len,
 				  buf);
 		if (count == 0) {
 			printf("Read container image from MMC/SD failed\n");
@@ -160,7 +161,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 		struct spi_flash *flash = (struct spi_flash *)dev;
 
 		ret = spi_flash_read(flash, offset,
-				     CONTAINER_HDR_ALIGNMENT, buf);
+				     hdr_alignment, buf);
 		if (ret != 0) {
 			printf("Read container image from QSPI failed\n");
 			return -EIO;
@@ -170,7 +171,7 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 #ifdef CONFIG_SPL_NAND_SUPPORT
 	if (dev_type == NAND_DEV) {
-		ret = nand_spl_load_image(offset, CONTAINER_HDR_ALIGNMENT,
+		ret = nand_spl_load_image(offset, hdr_alignment,
 					  buf);
 		if (ret != 0) {
 			printf("Read container image from NAND failed\n");
@@ -181,12 +182,12 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 #ifdef CONFIG_SPL_NOR_SUPPORT
 	if (dev_type == QSPI_NOR_DEV)
-		memcpy(buf, (const void *)offset, CONTAINER_HDR_ALIGNMENT);
+		memcpy(buf, (const void *)offset, hdr_alignment);
 #endif
 
 #ifdef CONFIG_SPL_BOOTROM_SUPPORT
 	if (dev_type == ROM_API_DEV) {
-		ret = spl_romapi_raw_seekable_read(offset, CONTAINER_HDR_ALIGNMENT, buf);
+		ret = spl_romapi_raw_seekable_read(offset, hdr_alignment, buf);
 		if (!ret) {
 			printf("Read container image from ROM API failed\n");
 			return -EIO;
@@ -282,6 +283,7 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 
 static ulong get_imageset_end(void *dev, int dev_type)
 {
+	const int hdr_alignment = container_hdr_alignment();
 	unsigned long offset[3] = {};
 	int value_container[3] = {};
 	u16 hdr_length;
@@ -298,7 +300,7 @@ static ulong get_imageset_end(void *dev, int dev_type)
 	debug("seco container size 0x%x\n", value_container[0]);
 
 	if (is_imx95() || is_imx94()) {
-		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+		offset[1] = ALIGN(hdr_length, hdr_alignment) + offset[0];
 
 		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
 		if (value_container[1] < 0) {
@@ -308,14 +310,14 @@ static ulong get_imageset_end(void *dev, int dev_type)
 
 		if (v2x_fw) {
 			debug("v2x container size 0x%x\n", value_container[1]);
-			offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+			offset[2] = ALIGN(hdr_length, hdr_alignment) + offset[1];
 		} else {
 			printf("no v2x container included\n");
 			offset[2] = offset[1];
 		}
 	} else {
 		/* Skip offset[1] */
-		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+		offset[2] = ALIGN(hdr_length, hdr_alignment) + offset[0];
 	}
 
 	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9725a96043..8a01b9045dd 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -36,14 +36,12 @@ config IMX95
 	select DM_MAILBOX
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
-	select IMX_PQC_SUPPORT if !IMX95_A0
 
 config IMX94
 	bool
 	select ARMV8_SPL_EXCEPTION_VECTORS
 	select DM_MAILBOX
 	select IMX9
-	select IMX_PQC_SUPPORT
 	select SCMI_FIRMWARE
 	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 8dade2b501e..f8fd502f5a5 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -372,13 +372,6 @@ config SPL_IMX_CONTAINER_USE_TRAMPOLINE
 	help
 	  Enable SPL load reader to load data to a trampoline buffer.
 
-config IMX_PQC_SUPPORT
-	bool "Enable to support i.MX ROM PQC Container"
-	depends on SPL && SPL_LOAD_IMX_CONTAINER
-	help
-	  Support i.MX ROM new PQC container format. If your chip does not use
-	  PQC container, say 'n'.
-
 config IMX_CONTAINER_CFG
 	string "i.MX8 Container config file"
 	depends on SPL && SPL_LOAD_IMX_CONTAINER
diff --git a/common/spl/spl_imx_container.c b/common/spl/spl_imx_container.c
index 79d021f81dc..e0e8ee0a5e6 100644
--- a/common/spl/spl_imx_container.c
+++ b/common/spl/spl_imx_container.c
@@ -87,11 +87,12 @@ static struct boot_img_t *read_auth_image(struct spl_image_info *spl_image,
 static int read_auth_container(struct spl_image_info *spl_image,
 			       struct spl_load_info *info, ulong offset)
 {
+	const int hdr_alignment = container_hdr_alignment();
 	struct container_hdr *container = NULL;
 	u16 length;
 	int i, size, ret = 0;
 
-	size = ALIGN(CONTAINER_HDR_ALIGNMENT, spl_get_bl_len(info));
+	size = ALIGN(hdr_alignment, spl_get_bl_len(info));
 
 	/*
 	 * It will not override the ATF code, so safe to use it here,
@@ -104,7 +105,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	debug("%s: container: %p offset: %lu size: %u\n", __func__,
 	      container, offset, size);
 	if (info->read(info, offset, size, container) <
-	    CONTAINER_HDR_ALIGNMENT) {
+	    hdr_alignment) {
 		ret = -EIO;
 		goto end;
 	}
@@ -124,7 +125,7 @@ static int read_auth_container(struct spl_image_info *spl_image,
 	length = container->length_lsb + (container->length_msb << 8);
 	debug("Container length %u\n", length);
 
-	if (length > CONTAINER_HDR_ALIGNMENT) {
+	if (length > hdr_alignment) {
 		size = ALIGN(length, spl_get_bl_len(info));
 
 		free(container);
diff --git a/include/imx_container.h b/include/imx_container.h
index 684fc3bc988..1a19d2503e7 100644
--- a/include/imx_container.h
+++ b/include/imx_container.h
@@ -6,17 +6,14 @@
 #ifndef __CONTAINER_HEADER_H_
 #define __CONTAINER_HEADER_H_
 
+#include <asm/arch/sys_proto.h>
+
 #include <linux/sizes.h>
 #include <linux/types.h>
 
 #define IV_MAX_LEN			32
 #define HASH_MAX_LEN			64
 
-#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
-#define CONTAINER_HDR_ALIGNMENT 0x4000
-#else
-#define CONTAINER_HDR_ALIGNMENT 0x400
-#endif
 #define CONTAINER_HDR_EMMC_OFFSET 0
 #define CONTAINER_HDR_MMCSD_OFFSET SZ_32K
 #define CONTAINER_HDR_QSPI_OFFSET SZ_4K
@@ -76,14 +73,20 @@ int get_container_size(ulong addr, u16 *header_length);
 
 static inline bool valid_container_hdr(struct container_hdr *container)
 {
-#if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
 	return (container->tag == CONTAINER_HDR_TAG ||
 		container->tag == 0x82) &&
 		(container->version == CONTAINER_HDR_VERSION ||
 		 container->version == 0x2);
-#else
-	return container->tag == CONTAINER_HDR_TAG &&
-	       container->version == CONTAINER_HDR_VERSION;
-#endif
+}
+
+static inline int container_hdr_alignment(void)
+{
+	if (is_imx94())
+		return 0x4000;	/* PQC */
+
+	if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
+		return 0x4000;	/* PQC on i.MX95 B0 and newer */
+
+	return 0x400;	/* Non-PQC on i.MX95 A1 and older */
 }
 #endif
-- 
2.51.0

