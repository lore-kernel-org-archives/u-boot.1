Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A153C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3D6A87FAE;
	Mon, 26 Feb 2024 18:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DN1xdwuR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03ABB87FF7; Mon, 26 Feb 2024 18:26:53 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A057387F6A
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412a588c8b4so7278025e9.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968399; x=1709573199; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mFyE1cCD+YSeAR0efCUoeU0rIhdUSE4+L502wPH1Y0w=;
 b=DN1xdwuRAi4kmbJGxSIl0gve7yspl48BjbFveram/xT+fbxNgzgVJ6IIq88nWG+BeQ
 2vgVNczu9nzPmosnc/UJtlohtBSx9snIDwqi2IlMJWRrpsYjR5jUguBw2I36rSX8cOBL
 oVDoGYo6uE/4roHfbsTrSk2MrybO6/VEw9W846LVqtMGWEQ7wHQWwDmo4BhIBO/slono
 KHC3JgOm6ueFj3HrkXPWMP7yBYSlqBNdD+6kFD33MEFwwPP6nAcincYc3Jd+H654IE+8
 xpee4bNUgy/sKNBmICusKobX3At+b/gTVKxuPL6eCFTASar4QZT88GztBPG5+bddPFmi
 HHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968399; x=1709573199;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFyE1cCD+YSeAR0efCUoeU0rIhdUSE4+L502wPH1Y0w=;
 b=gdiD/vWEzcUjZFmSQHcKQGDI9NwP6RHMIdTkztrKkhhsrOJcWUiA52d7335fzTl1Em
 rOk58biGV19gvshbULLyvlXCFRQAgfZcrkYmD2m9QESchs95na6FH7TgrYD+xW1UyTXx
 AxKULhP8iJ0v3dIP1p5lyVXgj2fr6L9pAxDMOYhVtdCbVYbJJS97E49DaOcka87/eQp+
 6c4j9qwopOB9WR9vy4sW8ea8SEmcxTyuBtbKGt6crvarG+a+NaIy7D9kO//KLa3baFHB
 A4BqSuIDYftLLGR2yKOaLkHW/5Hg5dVXKRdLCfWCnNNVDgfTm9LpyWK50bzUN5uAyp4K
 lT3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf0SE8HP8Fk9ifpKTe2XcAvaxeox9mHKdod+wQDCIsHKa1RdhC7rIU8tdEWP0yEBMmtIgxUkXHRx6jDL5/FDevyPJ28w==
X-Gm-Message-State: AOJu0YzVdO3Mi8CRGHp1+Xpkh1xop4s1CrTpWRVnPNprEJV1gMnQGgTE
 TzZvnPM7CwxU5AEXTeDhnPc7IRpnBADbZtHTc8XXu2xuUqBit8EXuksuuSI4IH8=
X-Google-Smtp-Source: AGHT+IFIrtzN54GkbHYHmMsbUUKyx72C+pMKYacJtwU63mtM7SJMzBe5E00+evukN5Zrz1kteFuu5w==
X-Received: by 2002:a05:600c:5246:b0:412:8d98:78a with SMTP id
 fc6-20020a05600c524600b004128d98078amr6992886wmb.13.1708968398977; 
 Mon, 26 Feb 2024 09:26:38 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:38 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:22 +0000
Subject: [PATCH v5 18/39] board: dragonboard410c: import board code from
 mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-18-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=9381;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=rnLdN5eTv+Mu1SQMZoZaoDhf7MrUwhnEwZ6b1Tq3JAI=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J3dtruMJk1+zmi/8zapDR7qsPBbGqP97Mf1p4uoPV
 8y9yqfs7ShlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQAT+XeI4X8E11mXV0bxbDz+
 rIo/ay/+8bHVEvbfKmUuxiV1sTT1/35GhlaL67rtJ1c+fzJNRirxcf565ZIPjHwpW+s69QreZPO
 mJwAA
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Some of the db410c board support code was written to be generic and
placed in mach-snapdragon. However, as the db410c is the only board
using this, move the code out of mach-snapdragon. This makes is more
obvious what code is relevant for which targets and helps tidy things up
a little more.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org> #qcs404
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile                |  2 -
 arch/arm/mach-snapdragon/dram.c                  | 99 ------------------------
 arch/arm/mach-snapdragon/include/mach/dram.h     | 12 ---
 arch/arm/mach-snapdragon/include/mach/misc.h     | 13 ----
 arch/arm/mach-snapdragon/misc.c                  | 55 -------------
 board/qualcomm/dragonboard410c/Makefile          |  2 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c | 48 +++++++++++-
 7 files changed, 45 insertions(+), 186 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 3a3a297c1768..d02432df8b04 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -5,7 +5,5 @@
 obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
-obj-y += misc.o
-obj-y += dram.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
deleted file mode 100644
index 499dfdf0da6e..000000000000
--- a/arch/arm/mach-snapdragon/dram.c
+++ /dev/null
@@ -1,99 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Onboard memory detection for Snapdragon boards
- *
- * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
- *
- */
-
-#include <common.h>
-#include <dm.h>
-#include <log.h>
-#include <part.h>
-#include <smem.h>
-#include <fdt_support.h>
-#include <asm/arch/dram.h>
-
-#define SMEM_USABLE_RAM_PARTITION_TABLE 402
-#define RAM_PART_NAME_LENGTH            16
-#define RAM_NUM_PART_ENTRIES            32
-#define CATEGORY_SDRAM 0x0E
-#define TYPE_SYSMEM 0x01
-
-struct smem_ram_ptable_hdr {
-	u32 magic[2];
-	u32 version;
-	u32 reserved;
-	u32 len;
-} __attribute__ ((__packed__));
-
-struct smem_ram_ptn {
-	char name[RAM_PART_NAME_LENGTH];
-	u64 start;
-	u64 size;
-	u32 attr;
-	u32 category;
-	u32 domain;
-	u32 type;
-	u32 num_partitions;
-	u32 reserved[3];
-} __attribute__ ((__packed__));
-
-struct smem_ram_ptable {
-	struct smem_ram_ptable_hdr hdr;
-	u32 reserved;     /* Added for 8 bytes alignment of header */
-	struct smem_ram_ptn parts[RAM_NUM_PART_ENTRIES];
-} __attribute__ ((__packed__));
-
-#ifndef MEMORY_BANKS_MAX
-#define MEMORY_BANKS_MAX 4
-#endif
-
-int msm_fixup_memory(void *blob)
-{
-	u64 bank_start[MEMORY_BANKS_MAX];
-	u64 bank_size[MEMORY_BANKS_MAX];
-	size_t size;
-	int i;
-	int count = 0;
-	struct udevice *smem;
-	int ret;
-	struct smem_ram_ptable *ram_ptable;
-	struct smem_ram_ptn *p;
-
-	ret = uclass_get_device_by_name(UCLASS_SMEM, "smem", &smem);
-	if (ret < 0) {
-		printf("Failed to find SMEM node. Check device tree\n");
-		return 0;
-	}
-
-	ram_ptable = smem_get(smem, -1, SMEM_USABLE_RAM_PARTITION_TABLE, &size);
-
-	if (!ram_ptable) {
-		printf("Failed to find SMEM partition.\n");
-		return -ENODEV;
-	}
-
-	/* Check validy of RAM */
-	for (i = 0; i < RAM_NUM_PART_ENTRIES; i++) {
-		p = &ram_ptable->parts[i];
-		if (p->category == CATEGORY_SDRAM && p->type == TYPE_SYSMEM) {
-			bank_start[count] = p->start;
-			bank_size[count] = p->size;
-			debug("Detected memory bank %u: start: 0x%llx size: 0x%llx\n",
-					count, p->start, p->size);
-			count++;
-		}
-	}
-
-	if (!count) {
-		printf("Failed to detect any memory bank\n");
-		return -ENODEV;
-	}
-
-	ret = fdt_fixup_memory_banks(blob, bank_start, bank_size, count);
-	if (ret)
-		return ret;
-
-	return 0;
-}
diff --git a/arch/arm/mach-snapdragon/include/mach/dram.h b/arch/arm/mach-snapdragon/include/mach/dram.h
deleted file mode 100644
index 0a9eedda414c..000000000000
--- a/arch/arm/mach-snapdragon/include/mach/dram.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Snapdragon DRAM
- * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#ifndef DRAM_H
-#define DRAM_H
-
-int msm_fixup_memory(void *blob);
-
-#endif
diff --git a/arch/arm/mach-snapdragon/include/mach/misc.h b/arch/arm/mach-snapdragon/include/mach/misc.h
deleted file mode 100644
index c60e3e472470..000000000000
--- a/arch/arm/mach-snapdragon/include/mach/misc.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Snapdragon DRAM
- * Copyright (C) 2018 Ramon Fried <ramon.fried@gmail.com>
- */
-
-#ifndef MISC_H
-#define MISC_H
-
-u32 msm_board_serial(void);
-void msm_generate_mac_addr(u8 *mac);
-
-#endif
diff --git a/arch/arm/mach-snapdragon/misc.c b/arch/arm/mach-snapdragon/misc.c
deleted file mode 100644
index 7d452f4529b7..000000000000
--- a/arch/arm/mach-snapdragon/misc.c
+++ /dev/null
@@ -1,55 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Miscellaneous Snapdragon functionality
- *
- * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
- *
- */
-
-#include <common.h>
-#include <mmc.h>
-#include <asm/arch/misc.h>
-#include <asm/unaligned.h>
-
-/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
-#define UNSTUFF_BITS(resp, start, size) \
-	({ \
-		const int __size = size; \
-		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
-		const int __off = 3 - ((start) / 32); \
-		const int __shft = (start) & 31; \
-		u32 __res; \
-					\
-		__res = resp[__off] >> __shft; \
-		if (__size + __shft > 32) \
-			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
-		__res & __mask;	\
-	})
-
-u32 msm_board_serial(void)
-{
-	struct mmc *mmc_dev;
-
-	mmc_dev = find_mmc_device(0);
-	if (!mmc_dev)
-		return 0;
-
-	if (mmc_init(mmc_dev))
-		return 0;
-
-	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
-}
-
-void msm_generate_mac_addr(u8 *mac)
-{
-	/* use locally adminstrated pool */
-	mac[0] = 0x02;
-	mac[1] = 0x00;
-
-	/*
-	 * Put the 32-bit serial number in the last 32-bit of the MAC address.
-	 * Use big endian order so it is consistent with the serial number
-	 * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:34:ab:cd
-	 */
-	put_unaligned_be32(msm_board_serial(), &mac[2]);
-}
diff --git a/board/qualcomm/dragonboard410c/Makefile b/board/qualcomm/dragonboard410c/Makefile
index 1b99c8b0efef..189f83813325 100644
--- a/board/qualcomm/dragonboard410c/Makefile
+++ b/board/qualcomm/dragonboard410c/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-y	:= dragonboard410c.o
+obj-y := dragonboard410c.o
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 1adac07569ae..40b5448c6ef1 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -11,16 +11,15 @@
 #include <dm.h>
 #include <dm/pinctrl.h>
 #include <env.h>
 #include <init.h>
+#include <mmc.h>
 #include <net.h>
 #include <usb.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <fdt_support.h>
-#include <asm/arch/dram.h>
-#include <asm/arch/misc.h>
 #include <linux/delay.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -54,8 +53,51 @@ int board_usb_init(int index, enum usb_init_type init)
 
 	return 0;
 }
 
+/* UNSTUFF_BITS macro taken from Linux Kernel: drivers/mmc/core/sd.c */
+#define UNSTUFF_BITS(resp, start, size) \
+	({ \
+		const int __size = size; \
+		const u32 __mask = (__size < 32 ? 1 << __size : 0) - 1;	\
+		const int __off = 3 - ((start) / 32); \
+		const int __shft = (start) & 31; \
+		u32 __res; \
+					\
+		__res = resp[__off] >> __shft; \
+		if (__size + __shft > 32) \
+			__res |= resp[__off - 1] << ((32 - __shft) % 32); \
+		__res & __mask;	\
+	})
+
+static u32 msm_board_serial(void)
+{
+	struct mmc *mmc_dev;
+
+	mmc_dev = find_mmc_device(0);
+	if (!mmc_dev)
+		return 0;
+
+	if (mmc_init(mmc_dev))
+		return 0;
+
+	return UNSTUFF_BITS(mmc_dev->cid, 16, 32);
+}
+
+static void msm_generate_mac_addr(u8 *mac)
+{
+	/* use locally adminstrated pool */
+	mac[0] = 0x02;
+	mac[1] = 0x00;
+
+	/*
+	 * Put the 32-bit serial number in the last 32-bit of the MAC address.
+	 * Use big endian order so it is consistent with the serial number
+	 * written as a hexadecimal string, e.g. 0x1234abcd -> 02:00:12:34:ab:cd
+	 */
+	put_unaligned_be32(msm_board_serial(), &mac[2]);
+}
+
 /* Check for vol- button - if pressed - stop autoboot */
 int misc_init_r(void)
 {
 	struct udevice *btn;
@@ -102,10 +144,8 @@ int board_late_init(void)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	u8 mac[ARP_HLEN];
 
-	msm_fixup_memory(blob);
-
 	if (!eth_env_get_enetaddr("wlanaddr", mac)) {
 		msm_generate_mac_addr(mac);
 	};
 

-- 
2.43.1

