Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63215606A31C
	for <u-boot@archiver.kernel.org>; Sat, 28 Nov 2026 13:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=fQlskRpk;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LjaqCC/X
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3897A81175;
	Sat, 28 Nov 2026 13:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1DAOUm-vPCbo; Sat, 28 Nov 2026 13:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 50B8A810A3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795871539;
	b=PHSDYHfuiII/14NAfGfCSRerh09+JYD6K9L93MXEsyLGTga+bAymp0qPwj9/HwwSOGIc
	 5ZaAfC9qGvlI/lcZZXhNXNIGsAHGJAufQv1zT2VMAjiKo4Wy4mdNtvg0VR+6VwlW2kiao
	 6JFlPuONcbV1P41PZsYD9ZAM3guO7zRT5WXiMXvo/X64uKkECuq9D7qn20JpIWMSWJSuJ
	 1PEx/tAsQKRqaKBMHR+cKgEaXJboh/+M3sQ1v37kUWDpw1l22JM3/U1M21IK+hG4c96aG
	 aKanWNx4Zm6TWM7ie7JmaX8EytsSfyzcs68RgUJ5CG5UFKGqG4KDWunC+g44k9jFnHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795871539;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rdxNlosAlBewiPdjMJ1RAkatpO+Vb2wrgMzcVEygBJA=;
	b=ZmtfLbrMe/9ivKSVjdbl3FRxf/wsswGZ3UkBWDMe0aZ5CdFoReI4t4YhJkdC1q/Dah7Q
	 dSG2a1ejt1VYcdT01o5xYrI55HUhLiuX0mKRzhBREtW9MT3bzXuTrqgoWL9HqWFEx3MSF
	 l4FuX8dFvm5jVrjaHHacwICfmuOUMlHB4ixCNQJr1egG+PGSB5XOySOs2DtJjnevz/PD3
	 HxSljZpYcMO07H8Fcog8gZ7Lb8xGAba8PxmSlVuWHYPnexY0+suFz4TauW7D6sBsQPbYd
	 t1UTdqsEazyoVb5kU/d8aZL0OZDl58c0FmoaH01wQoau9ww3n2ZCuTqriOFw7pYmLfA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795871539;
	bh=rdxNlosAlBewiPdjMJ1RAkatpO+Vb2wrgMzcVEygBJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fQlskRpkPG/juZaD4nPLNnu+RvOpAfXNYskWE1qsyG/0vS1zDPq0vVwk/0n7yGPt3
	 ef7CMdMJ6TiSgPu5HRGESOeQMsb+3ElcbLsVekSTW0wo5g1BqKxsBCkE6yMbMCRYrn
	 hWKyMI4kc6IqgXQCHO+Kcmq0DDfOVbs2hoYBNfJySmflBsMWhn4rUhUIrNSRbqm+f2
	 28Nz6mTbhxLeLZEVCyQmQM3ZDEb6OfqsmnYauCp4+xJFQCJZO39nOSnA2k8FgHfD9T
	 YnYz/tTD0XzYc1XgztHij7fJG/NGWsuLfXVF29u+8fiyWN8xULzI5d0UQud89mdjW8
	 DBHhb0fSMyqcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50B8A810A3;
	Sat, 28 Nov 2026 13:12:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 141EF3D9
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE87540659
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IVUFGF6lwTmQ for <u-boot@lists.u-boot-project.org>;
 Sat, 28 Nov 2026 13:12:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EB93840645
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=LjaqCC/X
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EB93840645
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 13:12:01 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4bba5e17cbeso34339675e9.1
 for <u-boot@lists.u-boot-project.org>; Sat, 28 Nov 2026 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1795871520; x=1796476320;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rdxNlosAlBewiPdjMJ1RAkatpO+Vb2wrgMzcVEygBJA=;
 b=LjaqCC/XUA4RO1nHVtKkEFCXQkr6uiNQihjU2EZ6eT+bpE25l6fiarK7tBMQojjVgq
 OubWffAkJq6C7iCrYlZkOPEOqNbjFFbDhLyydJ59bqDczxNISaIUEXfekn/USBsjSKT4
 0NrxeT6bB6l62PDyuqQe6e+e481dWJ5//cnCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795871520; x=1796476320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rdxNlosAlBewiPdjMJ1RAkatpO+Vb2wrgMzcVEygBJA=;
 b=O/kll/D2lrlWSt49fbsahjcHB0uvmvpjw8aKocD8aTUxGR6IMKRmm1ozgR7ElseeSk
 5zneXlkSj7fZV90I/ohagRoa3zfVE/CsOSRiJZF5jODkggr6HUh0togPtfPCye4BzNVy
 T0M7t9OK7XMSdjsosg4IYFAMo25eHr69XO8pcFoW5M+UJDmwItzVHky/7kr3CHsmnngV
 s7VGh0rtTuWpUXf6AaNQbHhtiQVfMwS1UrgFQhqMSYJsgq6/8XM5SdLvXrigixrvjEhc
 wz69je0pX4IPaSrW4Xivq+CKQTK9a/nHTakwyh4B1RIX3KsqEXRUkL73O208pUKZ2j0x
 QzsQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHJZQtadiktqF0H/g0dutbGbSGcMNkYRAicPGrralZS40hUzgyJc6Uebo/gFDV8uZ7pHGiBz7c=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+kEc41Rm9nOpKLoQ2qqBxRpaxLkaYkXZydAyBMBPwp00h8Vs5M
 8ygtAoB4oTIuOAWt7Tjv0gHhgczhlmOmaSCQJm2OOyHIBKDwuHUzoUvyfMseKYt808w=
X-Gm-Gg: AZFdTZfGISJ0ep8OkLAgoT/g525yOMwrhitbpDOfjcb/GJzOLoBWsMjW+kCuGmlkiul
 pEQuqckYmYxK6RA8GDpo+meQmw4tsdd226DLcH2GCklfEUBVu4BWAn0B342DBObrBgwFzyJmiM0
 9PIyPo7U7CuUGwO5q1cthavp4r4S7yLo8AAQwA7RRJRL+eOhlV27deTo9/91dd3mO2JZCMbZMGS
 HT+MQdLe7D0WZ/nFnct/dvl1h4UAXJf0moYRfSff+MFe7I9xYVP8TV0Jo9g64D8IOc/Wi4yb6QB
 CsQ6aWiMdxb4Rx14ecP+ZAzkziv3kQoRuCdMcjhhBVwx9aqPi63s8RqDiAMZcwuelV7wdAqdpVO
 47/0r2U6QwrjK6PHwORLPGYrTMoOmZxuqjFUJU9HNboLAb5vY6c/wa9v4TUuoTflB8lfYAbOBlk
 GduSJINBRaz3nKfZfjB1zQB6nQCJYLVKc3Q3m/8Gc6SLwoLR2hyGJa7turDGMF3U6xlgYWY38xq
 Le6i68FQAI8O7asyrM0lNPIx24hZN23DBXma9uLF0DbhQlbm6kG2bEKkthzA18BpsGtcuwPkZzH
 IzAojc+yk8hjC22xX9lLA/PagQxk7BtzkUG+Z1WZCbNaUwrxyG8WDe2KbWzj1JqqrNRQoUmDcMd
 k5Yr6ngb1/n/Dn2CwvKoS93D88/rEiJqDbh/6OcSLP3rt1KLKwxOHCwJMFlfdXzOHbEqtXn7Ryd
 47fCnROco9G0aD0bvu8Ge6ea0G9Q==
X-Received: by 2002:a05:600c:c173:b0:4a1:813f:2a60 with SMTP id
 5b1f17b1804b1-4bb88800134mr537916315e9.11.1795871519774; 
 Sat, 28 Nov 2026 05:11:59 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm1076382015e9.13.2026.11.28.05.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Nov 2026 05:11:59 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Yannick Fertre <yannick.fertre@foss.st.com>,
 linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Subject: [PATCH v3 18/29] arm: stm32mp: stm32mp2: move boot device environment
 helpers to SoC code
Date: Sat, 28 Nov 2026 14:10:35 +0100
Message-ID: <20261128131125.2141352-19-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
References: <20261128131125.2141352-1-dario.binacchi@amarulasolutions.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The environment location and the MMC environment device only depend on
the boot device reported by the ROM code, so they are not specific to
the STMicroelectronics boards.

Move env_get_location(), mmc_get_env_dev() and the mmc_get_boot() helper
to the SoC code, so that other vendor boards can use them too.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v3:
- Add Reviewed-by tag

 arch/arm/mach-stm32mp/stm32mp2/Makefile |  1 +
 arch/arm/mach-stm32mp/stm32mp2/env.c    | 82 +++++++++++++++++++++++++
 board/st/stm32mp2/stm32mp2.c            | 71 +--------------------
 3 files changed, 84 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/mach-stm32mp/stm32mp2/env.c

diff --git a/arch/arm/mach-stm32mp/stm32mp2/Makefile b/arch/arm/mach-stm32mp/stm32mp2/Makefile
index 8f2e641dcab6..f2def2d1283e 100644
--- a/arch/arm/mach-stm32mp/stm32mp2/Makefile
+++ b/arch/arm/mach-stm32mp/stm32mp2/Makefile
@@ -5,6 +5,7 @@
 
 obj-y += cpu.o
 obj-y += arm64-mmu.o
+obj-y += env.o
 obj-y += rifsc.o
 obj-y += stm32mp2x.o
 obj-$(CONFIG_OF_SYSTEM_SETUP) += fdt.o
diff --git a/arch/arm/mach-stm32mp/stm32mp2/env.c b/arch/arm/mach-stm32mp/stm32mp2/env.c
new file mode 100644
index 000000000000..9e7b5b882908
--- /dev/null
+++ b/arch/arm/mach-stm32mp/stm32mp2/env.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause
+/*
+ * Copyright (C) 2023, STMicroelectronics - All Rights Reserved
+ */
+
+#define LOG_CATEGORY LOGC_ARCH
+
+#include <config.h>
+#include <env_internal.h>
+#include <log.h>
+#include <mmc.h>
+#include <asm/arch/sys_proto.h>
+#include <dm/device.h>
+#include <dm/uclass.h>
+
+enum env_location env_get_location(enum env_operation op, int prio)
+{
+	u32 bootmode = get_bootmode();
+
+	if (prio)
+		return ENVL_UNKNOWN;
+
+	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
+	case BOOT_FLASH_SD:
+	case BOOT_FLASH_EMMC:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
+			return ENVL_MMC;
+		else
+			return ENVL_NOWHERE;
+
+	case BOOT_FLASH_NAND:
+	case BOOT_FLASH_SPINAND:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_UBI))
+			return ENVL_UBI;
+		else
+			return ENVL_NOWHERE;
+
+	case BOOT_FLASH_NOR:
+		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
+			return ENVL_SPI_FLASH;
+		else
+			return ENVL_NOWHERE;
+	default:
+		return ENVL_NOWHERE;
+	}
+}
+
+static int mmc_get_boot(void)
+{
+	struct udevice *dev;
+	u32 boot_mode = get_bootmode();
+	unsigned int instance = (boot_mode & TAMP_BOOT_INSTANCE_MASK) - 1;
+	char cmd[20];
+	const u32 sdmmc_addr[] = {
+		STM32_SDMMC1_BASE,
+		STM32_SDMMC2_BASE,
+		STM32_SDMMC3_BASE
+	};
+
+	if (instance >= ARRAY_SIZE(sdmmc_addr))
+		return 0;
+
+	/* search associated sdmmc node in devicetree */
+	snprintf(cmd, sizeof(cmd), "mmc@%x", sdmmc_addr[instance]);
+	if (uclass_get_device_by_name(UCLASS_MMC, cmd, &dev)) {
+		log_err("mmc%d = %s not found in device tree!\n", instance, cmd);
+		return 0;
+	}
+
+	return dev_seq(dev);
+}
+
+int mmc_get_env_dev(void)
+{
+	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_ENV_MMC_DEVICE_INDEX), (-1));
+
+	if (mmc_env_dev >= 0)
+		return mmc_env_dev;
+
+	/* use boot instance to select the correct mmc device identifier */
+	return mmc_get_boot();
+}
diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index f2575339b990..96735fa9f8a1 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -7,12 +7,11 @@
 
 #include <button.h>
 #include <config.h>
-#include <env_internal.h>
+#include <env.h>
 #include <fdt_support.h>
 #include <led.h>
 #include <log.h>
 #include <misc.h>
-#include <mmc.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
@@ -88,74 +87,6 @@ int board_init(void)
 	return 0;
 }
 
-enum env_location env_get_location(enum env_operation op, int prio)
-{
-	u32 bootmode = get_bootmode();
-
-	if (prio)
-		return ENVL_UNKNOWN;
-
-	switch (bootmode & TAMP_BOOT_DEVICE_MASK) {
-	case BOOT_FLASH_SD:
-	case BOOT_FLASH_EMMC:
-		if (CONFIG_IS_ENABLED(ENV_IS_IN_MMC))
-			return ENVL_MMC;
-		else
-			return ENVL_NOWHERE;
-
-	case BOOT_FLASH_NAND:
-	case BOOT_FLASH_SPINAND:
-		if (CONFIG_IS_ENABLED(ENV_IS_IN_UBI))
-			return ENVL_UBI;
-		else
-			return ENVL_NOWHERE;
-
-	case BOOT_FLASH_NOR:
-		if (CONFIG_IS_ENABLED(ENV_IS_IN_SPI_FLASH))
-			return ENVL_SPI_FLASH;
-		else
-			return ENVL_NOWHERE;
-	default:
-		return ENVL_NOWHERE;
-	}
-}
-
-int mmc_get_boot(void)
-{
-	struct udevice *dev;
-	u32 boot_mode = get_bootmode();
-	unsigned int instance = (boot_mode & TAMP_BOOT_INSTANCE_MASK) - 1;
-	char cmd[20];
-	const u32 sdmmc_addr[] = {
-		STM32_SDMMC1_BASE,
-		STM32_SDMMC2_BASE,
-		STM32_SDMMC3_BASE
-	};
-
-	if (instance >= ARRAY_SIZE(sdmmc_addr))
-		return 0;
-
-	/* search associated sdmmc node in devicetree */
-	snprintf(cmd, sizeof(cmd), "mmc@%x", sdmmc_addr[instance]);
-	if (uclass_get_device_by_name(UCLASS_MMC, cmd, &dev)) {
-		log_err("mmc%d = %s not found in device tree!\n", instance, cmd);
-		return 0;
-	}
-
-	return dev_seq(dev);
-};
-
-int mmc_get_env_dev(void)
-{
-	const int mmc_env_dev = CONFIG_IS_ENABLED(ENV_IS_IN_MMC, (CONFIG_ENV_MMC_DEVICE_INDEX), (-1));
-
-	if (mmc_env_dev >= 0)
-		return mmc_env_dev;
-
-	/* use boot instance to select the correct mmc device identifier */
-	return mmc_get_boot();
-}
-
 int board_late_init(void)
 {
 	const void *fdt_compat;
-- 
2.43.0

