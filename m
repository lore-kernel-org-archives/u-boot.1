Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DBDC83F10
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 22:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B8A8365C;
	Thu, 10 Jul 2025 00:29:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nJQ8hk3j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F3F835D8; Thu, 10 Jul 2025 00:29:38 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93BFD835E2
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 00:29:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-611a7c617a7so130519eaf.1
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752100174; x=1752704974; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RigVrSA44POmlhhEBn0OU92QxVpgnXsWCtqGjnJJjOE=;
 b=nJQ8hk3jwAgIJZd8aaikRIO1YnpOngU84xDJRvedVKjis+JC8SAYyd/b87eNvYUkOG
 oJJl9g63BljdhMD5xsPO8NosTVUyxItSs2bm1rgN9wwa8Thi0U7eN17woLrfKI6PIW4/
 xipIxa13rP+d2R7rT98r+Pqxk58Qi2enyxHyz/ORNECOLY10VevIm9ifigU10DU4uEGC
 3fJjCSXHSRF+M9iY59j8nOXyh3Qa9B6Np0UpnlMY1uDPgBzEBL4hD9xozo+cDqreO/1r
 yyX8dt2BR1d9RDk39sBbsXxNlDcc5tkZ9TWXkaZsdeG+6S/1lArOSg0XcMMiUWwE7m5D
 KIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752100174; x=1752704974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RigVrSA44POmlhhEBn0OU92QxVpgnXsWCtqGjnJJjOE=;
 b=atH+DLVYN5/9CqM87/0V5MFw2gOJaPGX7ceyj4R3u4/cgVZcVPMEHD+JWTq6w6GSnK
 bSWttChp5RkZqG056+7oXKtHDuvWMWaqD4yHPTkzP3Izo421Dmd2ArzPGTqvSmBa5Xfw
 o4ptQuqiph4cuajcBCgjSDyIudxc0Shj5LeShlb+La7evG9PUTfn05rr+qstlhQ65Yhm
 izZRl2BLva7eY40YQLey92xWcnHqvCaf+nDyQP+LOs1qOOCOh8cDkMZu/SpLhKqI6Q/5
 ET+RiyVFiUSIBqhRvseCBp0tEivaHX+we13gDb72XlMTUiRzt6NyRRbzFv9bGpvWQ5Fb
 aOOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX7BqxFX7M4IJ4NaOXTVX611qwrI+74AdDR7naS2vBS3NbYikwG3s+oFO9KIRJIeQk0ehZ8js=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7V0FqAlp10dxrk+YgW1VfBlkPrTohv3ba6hEWwHzikSR9wIhj
 hGj/l/mg+f3UFm6xlChIuoE4GhEwGtsd7gCnRZCU6M4GkuADIL5emsq3CfN1KT7BKJQ=
X-Gm-Gg: ASbGncvHz0rRPTTnAtJByz1YKxooJPTIxcz90oBuEnryQPJuGM7f3nt+Oaq/AnQh30/
 s0x3iDmZRrs8ZizYcC+4SjJeYQZRKlhdkex76BSJHiDaYYnDyrVHliofgyaDzi/Wf0geLb8eumM
 WVWj7cgvsJBMuOng17d9UfLfQgJHyrWbd0lFAJHAZQzKm31EdmOAG9fEkHFmK8KlU197d7tIjX/
 l2TCqgAwztjNMne/zXezqfSnF9Ma5p1XGWs0JoYgG4CLjW9y2Lak2LPm5dmQCVNuAla2kcOG8D5
 I+ozg5Olf3Z4BTeC21WnPNgZNxqYKhtxH+owZLmm492eRy3/LQf3bb5w674VVVrOErKNVK6Y
X-Google-Smtp-Source: AGHT+IGr+SoIC28X7lMenggQFwM2nKF9bIsS8MCgkWjeDOII7jZ/bQd9zyx+QeLs4rNilSKyoGFgZA==
X-Received: by 2002:a05:6870:3c8f:b0:2e9:1c4a:9fdc with SMTP id
 586e51a60fabf-2ff10860d96mr277989fac.17.1752100174240; 
 Wed, 09 Jul 2025 15:29:34 -0700 (PDT)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ff1172e579sm42189fac.45.2025.07.09.15.29.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 15:29:33 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Simon Glass <sjg@chromium.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Greg Malysa <malysagreg@gmail.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, u-boot@lists.denx.de
Subject: [PATCH 8/9] board: samsung: e850-96: Enable EFI Capsule Update
 mechanism
Date: Wed,  9 Jul 2025 17:29:25 -0500
Message-Id: <20250709222926.24671-9-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250709222926.24671-1-semen.protsenko@linaro.org>
References: <20250709222926.24671-1-semen.protsenko@linaro.org>
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

Make it possible to update E850-96 firmware binaries using EFI Capsule
Update mechanism. For example, to update the U-Boot binary, the capsule
file can be generated like this:

    $ ./tools/mkeficapsule --index 4 \
      --guid 629578c3-ffb3-4a89-ac0c-611840727779 \
      u-boot.bin capsule4.bin

The resulting 'capsule4.bin' should be copied to ESP partition (in
/boot/efi/EFI/UpdateCapsule/ directory). Then after reboot U-Boot will
update the 'bootloader' area in eMMC Boot Partition A (boot0) and remove
the capsule file, by EFI boot manager executed as a part of Standard
Boot:

    Applying capsule capsule4.bin succeeded.
    Reboot after firmware update.

The kernel will also expose the ESRT table information via SysFS in
/sys/firmware/efi/esrt/entries.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 board/samsung/e850-96/e850-96.c | 40 +++++++++++++++++++++++++++++++++
 configs/e850-96_defconfig       |  3 +++
 include/configs/e850-96.h       | 21 +++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/board/samsung/e850-96/e850-96.c b/board/samsung/e850-96/e850-96.c
index addfe0460973..4e034b9bd3be 100644
--- a/board/samsung/e850-96/e850-96.c
+++ b/board/samsung/e850-96/e850-96.c
@@ -4,6 +4,7 @@
  * Author: Sam Protsenko <semen.protsenko@linaro.org>
  */
 
+#include <efi_loader.h>
 #include <env.h>
 #include <init.h>
 #include <mapmem.h>
@@ -15,6 +16,45 @@
 #define OTP_CHIPID0		0x4
 #define OTP_CHIPID1		0x8
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = E850_96_FWBL1_IMAGE_GUID,
+		.fw_name = u"E850-96-FWBL1",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = E850_96_EPBL_IMAGE_GUID,
+		.fw_name = u"E850-96-EPBL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = E850_96_BL2_IMAGE_GUID,
+		.fw_name = u"E850-96-BL2",
+		.image_index = 3,
+	},
+	{
+		.image_type_id = E850_96_BOOTLOADER_IMAGE_GUID,
+		.fw_name = u"E850-96-BOOTLOADER",
+		.image_index = 4,
+	},
+	{
+		.image_type_id = E850_96_EL3_MON_IMAGE_GUID,
+		.fw_name = u"E850-96-EL3-MON",
+		.image_index = 5,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 0="
+			"fwbl1.img raw 0x0 0x18 mmcpart 1;"
+			"epbl.img raw 0x18 0x98 mmcpart 1;"
+			"bl2.img raw 0xb0 0x200 mmcpart 1;"
+			"bootloader.img raw 0x438 0x1000 mmcpart 1;"
+			"el3_mon.img raw 0x1438 0x200 mmcpart 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 96e91959f16c..e334efd4d5fb 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -15,6 +15,9 @@ CONFIG_SYS_LOAD_ADDR=0x80000000
 CONFIG_ENV_OFFSET_REDUND=0x10000
 # CONFIG_PSCI_RESET is not set
 CONFIG_EFI_SET_TIME=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
diff --git a/include/configs/e850-96.h b/include/configs/e850-96.h
index 4607b3089b21..63e85332bd86 100644
--- a/include/configs/e850-96.h
+++ b/include/configs/e850-96.h
@@ -9,4 +9,25 @@
 #ifndef __E850_96_H
 #define __E850_96_H
 
+/* GUIDs for capsule updatable firmware images */
+#define E850_96_FWBL1_IMAGE_GUID \
+	EFI_GUID(0x181cd3f2, 0xe375, 0x44d2, 0x80, 0x78, \
+		 0x32, 0x21, 0xe1, 0xdf, 0xb9, 0x5e)
+
+#define E850_96_EPBL_IMAGE_GUID \
+	EFI_GUID(0x66c1a54d, 0xd149, 0x415d, 0xaa, 0xda, \
+		 0xb8, 0xae, 0xe4, 0x99, 0xb3, 0x70)
+
+#define E850_96_BL2_IMAGE_GUID \
+	EFI_GUID(0x89471c2a, 0x6c8d, 0x4158, 0xac, 0xad, \
+		 0x23, 0xd3, 0xb2, 0x87, 0x3d, 0x35)
+
+#define E850_96_BOOTLOADER_IMAGE_GUID \
+	EFI_GUID(0x629578c3, 0xffb3, 0x4a89, 0xac, 0x0c, \
+		 0x61, 0x18, 0x40, 0x72, 0x77, 0x79)
+
+#define E850_96_EL3_MON_IMAGE_GUID \
+	EFI_GUID(0xdf5718a2, 0x930a, 0x4916, 0xbb, 0x19, \
+		 0x32, 0x13, 0x21, 0x4d, 0x84, 0x86)
+
 #endif /* __E850_96_H */
-- 
2.39.5

