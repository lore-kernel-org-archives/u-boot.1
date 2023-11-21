Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6556CC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:11:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21B1B8763A;
	Tue, 21 Nov 2023 18:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iWCVR6Jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 787F4875FC; Tue, 21 Nov 2023 18:09:50 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8282887642
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c8880fbb33so20817181fa.0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586580; x=1701191380; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d4YhP6MdZSOZ44DXIDRNYanXLEw0d+r3l7ESBfKug2M=;
 b=iWCVR6Jmb7y54SaUGgEDdvNuGmht1TUvIkbpS73dLNz0kGp/kMsrMXXiBDR5MpCnIR
 1GRnTURxlAvsf7bxTG40RBfgzN7/zRS0Lucb2CUEWPa9pURlEh5DLbk+MQNjzGeNj2a+
 e43teoSXYakx8NvQNkmufKLfL2aOuBkui/tQTsWusgFbViJtmAqT+k3EZuNBLrnXFDGf
 naTNXjSkxtVZfMdTQJf6SyaSTTPM2DH4PRdXLTnL5VChKSb5esGQxVp0fqXK96DdUb+Q
 DoMkhZkI73E8nbAHez+LqSZn4VU5dgnQJoWL8eUnm5b8xZL2Ccfkh9aMYax2LKmWCpel
 dEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586580; x=1701191380;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d4YhP6MdZSOZ44DXIDRNYanXLEw0d+r3l7ESBfKug2M=;
 b=P1P5QNiTLP1mAYIP4AS0ynVMorK0cx40EpZVrLOekpUnq/qAFVSVHKg+6DMxkKrSsT
 IaJynMKhLfciRuF5BZkTUFQXMXDz/LGZ4NLswax93OxzxBwI8I+Tkz3X3dnZmxl88Q3g
 wGDm/hwfvLqHTTWXBa4Knz/2KELmSoq4I0Cw6wqctlS3UBgpzztIb86DPuA29EitlsCV
 U6OfQK/6zpSvRUpim1LAZv+x7nCVm5PMp1DpdAPxKSRZuCsOqSH53pVDeZ2xkveHNVrr
 X2s1nB7ENsU69oZ+HJfwGTbpR65tcpbZMAKhKxpEKyq7sb+o5dsAj5YCazKAhkets8TQ
 4isw==
X-Gm-Message-State: AOJu0Yz2TJUQ6kvcd/z9Oqr1O4w8+IFsu+GpakmDAFd+UPzKymPLr4OG
 zYlGjInPBBDumRmnfL3yE7BLnw==
X-Google-Smtp-Source: AGHT+IErn2Yz+cwYOt6Hfub+A9meRkqcuQlTzHyVGGe2LG6L0Vosvu8Hf3GAUVtg0yCPCpOvTE1mog==
X-Received: by 2002:a05:651c:157:b0:2c5:1d11:5688 with SMTP id
 c23-20020a05651c015700b002c51d115688mr6883527ljd.14.1700586579855; 
 Tue, 21 Nov 2023 09:09:39 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:39 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:34 +0000
Subject: [PATCH 11/21] board: dragonboard410c: import board code from
 mach-snapdragon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-11-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7010;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=NRk2wgImu9xSxY0Jqke9wn+fk97YriyFyd2l5TJfhPk=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ24HT3ZMcJhzcuGtXb0eflx+2TPZEpoyLBWtX1u/T
 /WPOhnQUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbC0c3IMFEvkf9Mg9EZZXbN
 w763Mzbop3+pvGzj+lZwK/c3n2nfVzEybPkvYGJwJv3LMksf48qvFavMH/0zXxL+YuX27WzmK5S
 unwQA
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Makefile                  |  2 -
 arch/arm/mach-snapdragon/include/mach/dram.h       | 12 -----
 arch/arm/mach-snapdragon/misc.c                    | 55 ----------------------
 board/qualcomm/dragonboard410c/Makefile            |  3 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c   |  4 +-
 .../qualcomm/dragonboard410c/misc.c                | 51 +++++++++++++++++++-
 .../mach => board/qualcomm/dragonboard410c}/misc.h |  1 +
 7 files changed, 54 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 3a3a297c1768..d02432df8b04 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -6,6 +6,4 @@ obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
-obj-y += misc.o
-obj-y += dram.o
 obj-$(CONFIG_TARGET_QCS404EVB) += sysmap-qcs404.o
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
index 1b99c8b0efef..a3ae1a5f9136 100644
--- a/board/qualcomm/dragonboard410c/Makefile
+++ b/board/qualcomm/dragonboard410c/Makefile
@@ -2,4 +2,5 @@
 #
 # (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
 
-obj-y	:= dragonboard410c.o
+obj-y += dragonboard410c.o
+obj-y += misc.o
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 350e0e9e20aa..3ee7e806918b 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -17,10 +17,10 @@
 #include <asm/global_data.h>
 #include <asm/gpio.h>
 #include <fdt_support.h>
-#include <asm/arch/dram.h>
-#include <asm/arch/misc.h>
 #include <linux/delay.h>
 
+#include "misc.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 int dram_init(void)
diff --git a/arch/arm/mach-snapdragon/dram.c b/board/qualcomm/dragonboard410c/misc.c
similarity index 64%
rename from arch/arm/mach-snapdragon/dram.c
rename to board/qualcomm/dragonboard410c/misc.c
index 499dfdf0da6e..27d51ef78914 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/board/qualcomm/dragonboard410c/misc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Onboard memory detection for Snapdragon boards
+ * Miscellaneous Snapdragon functionality
  *
  * (C) Copyright 2018 Ramon Fried <ramon.fried@gmail.com>
  *
@@ -9,10 +9,56 @@
 #include <common.h>
 #include <dm.h>
 #include <log.h>
+#include <mmc.h>
 #include <part.h>
 #include <smem.h>
 #include <fdt_support.h>
-#include <asm/arch/dram.h>
+#include <asm/unaligned.h>
+
+#include "misc.h"
+
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
+u32 msm_board_serial(void)
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
+void msm_generate_mac_addr(u8 *mac)
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
 
 #define SMEM_USABLE_RAM_PARTITION_TABLE 402
 #define RAM_PART_NAME_LENGTH            16
@@ -97,3 +143,4 @@ int msm_fixup_memory(void *blob)
 
 	return 0;
 }
+
diff --git a/arch/arm/mach-snapdragon/include/mach/misc.h b/board/qualcomm/dragonboard410c/misc.h
similarity index 87%
rename from arch/arm/mach-snapdragon/include/mach/misc.h
rename to board/qualcomm/dragonboard410c/misc.h
index c60e3e472470..fe44caf51b18 100644
--- a/arch/arm/mach-snapdragon/include/mach/misc.h
+++ b/board/qualcomm/dragonboard410c/misc.h
@@ -9,5 +9,6 @@
 
 u32 msm_board_serial(void);
 void msm_generate_mac_addr(u8 *mac);
+int msm_fixup_memory(void *blob);
 
 #endif

-- 
2.42.1

