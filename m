Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F213D41D58
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 15:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B862A83655;
	Thu, 11 Dec 2025 16:30:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="m4Khfdiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F088389A; Thu, 11 Dec 2025 16:30:57 +0100 (CET)
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BAB783642
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 16:30:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1765467055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfXX3HaCsDLeyCs/ZwvGCesFs3v3RrvHpA739HZZZEk=;
 b=m4KhfdivWUXCnrMCIDYE9pAfjM4K6VRyUrBLI3GajGhzZEjkgJ6j+FC/WUUCNeYVxhHV+9
 95rw3E5o8OzaAwcVT2r4VBPoYQPSpfBbr3HOZyLFiKX5+Myb9ioCVDqZCjQc+qp6bfiQaL
 O1ehgxlP3U7P1Ga9mNOSCIsaIfpvLAh5+fZZhU/mNgK8EPx6D4q2zbj2tx4dCsDTzv8o5W
 V4XvTbdvgcP2frtsx5GgyBI8ZMK3O11mVg5P/e1ol7PA0hUl5Ij9AgvSKToq6mQEcdFp5y
 A/5HVz8eRqEZsp+FxvK119oaGsbTebGSoU3oY2HYi/e2Rbae78gyp09rEC3+PQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Thu, 11 Dec 2025 15:30:41 +0000
Subject: [PATCH v3 1/2] arm: meson: add support for EFI capsule updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-meson-capsule-v3-1-1cf15a2d2498@postmarketos.org>
References: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
In-Reply-To: <20251211-meson-capsule-v3-0-1cf15a2d2498@postmarketos.org>
To: u-boot-amlogic@groups.io, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Viacheslav Bocharov <adeep@lexina.in>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>, 
 Ferass El Hafidi <funderscore@tauchgang.dev>, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4965;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=R3/j5mwQ35bOujgm7R7yKQqif0z7oiKuBOgLb5KDLRk=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpOuOqdtEAwVjyaXQXdZNlSXpDyqCZZmGyiE7w8
 D7tWAS4ShSJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaTrjqgAKCRCEr8vQ14ma
 AzrZD/wIX5FpoizvP68oDirkCVE3qet3zORxGV2uNXLXPmq9hTn5cPdwwNMYNKJpfNreJKxCfXs
 uazHke/lRv6eRth6oE/cbaacFk0YAiUnQcjOtTWyLLvJ/qkTP8+ZClpduqjlH5vgrKby4sXaXsY
 d5IDpz3lwXc99ul7hOlGsFJ5+OPiejogkoPOzl9jg494ZleuwhaatCoYnyGgn85GBfyh9jcE4ZR
 /b37iWz2TExfPOCDpN/uBXtMH25H5nY7myZkUvoaVKC5NpHKysrCK4NUZqEP3+xyIQFIsUrWUnN
 6j5t7iZLibmj5pmRgYa8X4oIyZ8yhRqeZr9SSSqJ9/BrEpR0tti4K5DaoYgIMUeiSx076+yUuFl
 DYWYO1W0myj3inXWaFtYr+VU1bMBU3p2qPSW7oKmXqW2igeAbQXoCojSIEqYTrwbqdSo/zs+HBU
 /5Y4f5b+61xqL5+rQEk72WOvv9RrRwvhXVtOnTP9GXp0Nz1iOUGL9Kknge27BccfCptzVmf9ovN
 ay/FalU982CNUKsybMTAN9fJW+wWCapmCW4RDxVJUaZ1ro3JiLZyNSj+bE/YzaMtWSyL+C432DI
 F8rPSroYFjL2M/ds8QYuZ5Nq4nve344mp5JLDuaelHI9dvtxhAXhY9u5onUMeG6V/HxUGt0tqCl
 FaT+0hJfhQac6jQ==
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
 arch/arm/include/asm/arch-meson/boot.h |  2 ++
 arch/arm/mach-meson/Makefile           |  2 +-
 arch/arm/mach-meson/board-common.c     |  5 +++
 arch/arm/mach-meson/capsule.c          | 61 ++++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-meson/boot.h b/arch/arm/include/asm/arch-meson/boot.h
index a11dfde719e..e66b45983fe 100644
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
index 535b0878b91..640921e2b8e 100644
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
index 39774c43049..e8012604c33 100644
--- a/arch/arm/mach-meson/board-common.c
+++ b/arch/arm/mach-meson/board-common.c
@@ -145,6 +145,11 @@ int board_late_init(void)
 {
 	meson_set_boot_source();
 
+	if (CONFIG_IS_ENABLED(DFU) && CONFIG_IS_ENABLED(EFI_LOADER)) {
+		/* Generate dfu_string for EFI capsule updates */
+		meson_setup_capsule();
+	}
+
 	return meson_board_late_init();
 }
 
diff --git a/arch/arm/mach-meson/capsule.c b/arch/arm/mach-meson/capsule.c
new file mode 100644
index 00000000000..6e968a59c2c
--- /dev/null
+++ b/arch/arm/mach-meson/capsule.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2025, Ferass El Hafidi <funderscore@postmarketos.org>
+ */
+
+#include <asm/arch/boot.h>
+#include <dm.h>
+#include <efi_loader.h>
+#include <mmc.h>
+
+/*
+ * To be able to support multiple devices and flash to the correct one we need
+ * to automatically generate the dfu_string and fw_name to match the device we
+ * are booted from. This is done by meson_setup_capsule() which is then called
+ * in board_late_init(). Right now we support EFI capsule updates on SPI flash,
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
+	u32 max_size = 0x2000; /* 4 MB (MMC sectors are 512 bytes each) */
+	u32 offset = 0x1; /* offset for flashing to eMMC/SD */
+	int boot_device = meson_get_boot_device();
+
+	switch (boot_device) {
+	case BOOT_DEVICE_EMMC:
+		mmc_devnum = 1; /* mmc1 is always eMMC */
+		fallthrough;
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
+		debug("setup_capsule: Boot device %d unsupported\n", boot_device);
+		return;
+	}
+	debug("EFI Capsule DFU string: %s", dfu_string);
+
+	update_info.dfu_string = dfu_string;
+}

-- 
2.51.2

