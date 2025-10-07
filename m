Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D80CCD183
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 19:10:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F271A8394E;
	Tue,  7 Oct 2025 21:10:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="gneYH2zi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A698083959; Tue,  7 Oct 2025 21:10:26 +0200 (CEST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [95.215.58.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F28338389E
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 21:10:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1759864220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ed5SGVQWEij/Bzf+KG4QVy5N35ghZwSXXkphOAb1K2A=;
 b=gneYH2ziMsIJ44xJkUzjj84TtvrqRNLqWnW93ufD/rKljGp+81wvumaeNUPb+H38tR7ImI
 Ob9Jfi4GpwBk8VB8xmTgUZPtLCe8k6TxRfjdazCJi/pChKPpnQtj5UDmTHv9a2HZHbOjnR
 59U3nPAnnNO4U0rR7qxUT978GL4bEyGGalawYvtX3Ntd+ZL6aBvntzcCSEcsPRUmGz0ayB
 VDMa3guhSLZ2rpA2L8pL7EzOlbTe5h6WLDPZT9B5WC97Qim7HqEx0Uw4R1Mwo+domk7oOL
 5uRpyPzDtXSyXAYcaSiuom0e1PkGjQby8u5iEXPq5ZfZ8FiWvXGp5WUe2EEA4A==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Tue, 07 Oct 2025 19:10:07 +0000
Subject: [PATCH] arm: meson: add support for EFI capsule updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-meson-capsule-v1-1-6175f7b4cf9e@postmarketos.org>
X-B4-Tracking: v=1; b=H4sIAI5l5WgC/x3MQQqAIBBG4avErBO0kqirRAuxvxooC4cikO6et
 PwW7yUSRIZQXySKuFn4CBmmLMivLixQPGVTpStrtG7VDjmC8u6Ua4NyprN1B+1sA8rNGTHz8/+
 G8X0/fm7DUV8AAAA=
X-Change-ID: 20251007-meson-capsule-a19539e0a54e
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5716;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=S1Ezg5ikHem1K2jUVoBea0PkwpGPW8Uj9layWuyqXiA=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBo5WWUDp+FniB+FNugmfS47z22V5snjnnJ8XXkV
 eKl5b7FdgWJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaOVllAAKCRCEr8vQ14ma
 A927D/9VfaGbjRZswTkv99pRKo5T7I7LmEjCfnagcxgjvRUCxGp/HR8X364tQsIFhWJTw7jnE5M
 RzbhxA2Wyie0uJnKyV7zCkoRYLzQR+5N+PECoyFJRGGsDMAsZtgWAlC/rqrJ2oRu2V73ph0KZaj
 GHoqlz0WU/Gt/awAwBsSTq93CDpX4nFOHZZYxbhAVH5cvd9pFywVdaQ3xSPo9oSXVqVqWuwLP4R
 IOKEP03WVMkuIey/f9jWqpPHZUc4v7JUn5dH2m9BvBqVXajNEQPCsvLkEzsUqDGMumgtfKYlihK
 D61L8YvF0bUJMrfs/cQjTXWM0it/VsJ9S5//qYOxIAXbYGiKFXgAswOuD+hC9L/X8RalN/NJLsR
 AoaPDB6Qd6zXzlGZM0t1SPhi2h74g48gqnBKlxeomuaMHlGd0ru6iI3KuT/4p3hSvCrf05xljAu
 eJdP4UE8IefE4aNU6z20mWwblrEHUzYa/HPCke3+0cIrWCd7aEGlcK6S2ZntGou0kQ71ZMLaev6
 /MTJOrjbf4i8HpuSTTBMkMJ6vmE1NzuS/tYDDRqTgYm2PrueTZY6rRIZCoNNkSeE8JM1JRajvLu
 ymj4x+aXlUDBJLy4sjzNVQPcc4ucRYetf4+TL8kz5Cz7aA1aUdl3+h4Xqeo+NVko2A0E3XtOXYf
 J0lDHkSbrowzguA==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Previously, few Amlogic devices supported EFI capsule updates.
Generally only the Libre Computer ones with SPI flash supported it,
thanks to board-specific code.

This commit commonises capsule update support across supported
Amlogic boards.  Similar to Qualcomm's support for it, the dfu string
and firmware name is automatically generated at runtime depending on
which device we are booted from.  Right now this supports flashing to
the eMMC/SD and SPI flash.

As usual, the capsule UUID is automatically generated.  You can get it
by enabling CONFIG_CMD_EFIDEBUG and running:

	=> efidebug capsule esrt
	========================================
	ESRT: fw_resource_count=1
	ESRT: fw_resource_count_max=1
	ESRT: fw_resource_version=1
	[entry 0]==============================
	ESRT: fw_class=796180D4-AAB2-50F1-B16A-53DFF9CA89B2
	ESRT: fw_type=unknown
	ESRT: fw_version=0
	ESRT: lowest_supported_fw_version=0
	ESRT: capsule_flags=0
	ESRT: last_attempt_version=0
	ESRT: last_attempt_status=success
	========================================

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
Currently EFI capsule updates are only supported on the following
Amlogic-based boards:

 - Libre Computer AML-S805X-AC
 - Libre Computer AML-A311D-CC
 - Libre Computer AML-S905D3-CC

This is done with board-specific configuration in board/libre-computer/.

With this patch, EFI capsule updates can now work on most of the other
Amlogic boards supported by u-boot, such as the Libre Computer
AML-S905X-CC, without the need for board-specific configuration
beforehand.
---
 arch/arm/include/asm/arch-meson/boot.h |  2 ++
 arch/arm/mach-meson/Makefile           |  2 +-
 arch/arm/mach-meson/board-common.c     |  3 ++
 arch/arm/mach-meson/capsule.c          | 59 ++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
index a11dfde719e3e48e10bcb1f6b1b84eb8586ca9e7..e66b45983fe2f5d81f83642c01502a72773213b2 100644
--- a/arch/arm/include/asm/arch-meson/boot.h
+++ b/arch/arm/include/asm/arch-meson/boot.h
@@ -21,6 +21,8 @@ int meson_get_boot_device(void);
 
 int meson_get_soc_rev(char *buff, size_t buff_len);
 
+void meson_setup_capsule(void);
+
 /**
  * meson_get_socinfo - retrieve cpu_id of the Amlogic SoC
  *
diff --git a/arch/arm/mach-meson/Makefile b/arch/arm/mach-meson/Makefile
index 535b0878b9105e7a83729bea65fa4cd70cd4beac..640921e2b8e9b4777f0b212991edea26de2987d4 100644
--- a/arch/arm/mach-meson/Makefile
+++ b/arch/arm/mach-meson/Makefile
@@ -2,7 +2,7 @@
 #
 # Copyright (c) 2016 Beniamino Galvani <b.galvani@gmail.com>
 
-obj-y += board-common.o sm.o board-info.o
+obj-y += board-common.o sm.o board-info.o capsule.o
 obj-$(CONFIG_MESON_GX) += board-gx.o
 obj-$(CONFIG_MESON_AXG) += board-axg.o
 obj-$(CONFIG_MESON_G12A) += board-g12a.o
diff --git a/arch/arm/mach-meson/board-common.c b/arch/arm/mach-meson/board-common.c
index 39774c43049a40ed11578086603717571bedd23b..df9f576e7d2a1ce77b9a98259de4c3abf87784ed 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -145,6 +145,9 @@ int board_late_init(void)
 {
 	meson_set_boot_source();
 
+	/* Generate dfu_string for EFI capsule updates */
+	meson_setup_capsule();
+
 	return meson_board_late_init();
 }
 
diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
new file mode 100644
index 0000000000000000000000000000000000000000..a798f8a3e8c3a8807720af4ef89ccfc20f22f2f8
--- /dev/null
+++ b/arch/arm/mach-meson/capsule.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+
+#include <dm.h>
+#include <asm/arch/boot.h>
+#include <efi_loader.h>
+#include <mmc.h>
+
+/*
+ * To be able to support multiple devices and flash to the correct one we need
+ * to automatically generate the dfu_string and fw_name to match the device we
+ * are booted from.  This is done by meson_setup_capsule() which is then called
+ * in board_late_init().  Right now we support EFI capsule updates on SPI flash,
+ * eMMC and SD cards.
+ */
+struct efi_fw_image fw_images[] = {
+	{
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = NULL, /* to be set in meson_capsule_setup */
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
+/*
+ * TODO: Support usecase e.g. FIT image on eMMC + SPL on SD.
+ */
+void meson_setup_capsule(void)
+{
+	static char dfu_string[32] = { 0 };
+	int mmc_devnum = 0; /* mmc0 => SD card */
+	static uint32_t max_size = 0x2000; /* 4 MB */
+	uint32_t offset = 0x1; /* offset for flashing to eMMC/SD */
+	int boot_device = meson_get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_EMMC:
+		mmc_devnum = 1; /* mmc1 is always eMMC */
+	case BOOT_DEVICE_SD:
+		snprintf(dfu_string, 32, "mmc %d=u-boot.bin raw %d %d", mmc_devnum, offset, max_size);
+		fw_images[0].fw_name = u"U_BOOT_MESON_MMC";
+		break;
+	case BOOT_DEVICE_SPI:
+		/* We assume there's only one SPI flash */
+		fw_images[0].fw_name = u"U_BOOT_MESON_SPI";
+		snprintf(dfu_string, 32, "sf 0:0=u-boot.bin raw 0 %d", max_size);
+		break;
+	default:
+		debug("Boot device %d unsupported\n", boot_device);
+	}
+	debug("EFI Capsule DFU string: %s", dfu_string);
+
+	update_info.dfu_string = dfu_string;
+}

---
base-commit: 072264c4b3406aee50dad08355588577a547ab48
change-id: 20251007-meson-capsule-a19539e0a54e

Best regards,
-- 
Ferass El Hafidi <funderscore@postmarketos.org>

