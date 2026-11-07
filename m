Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF87606A336
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 14:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z/7Yr4lF;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=BJrw8fQ+
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 467F960767;
	Sat,  7 Nov 2026 14:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eABSf_9Ta8kn; Sat,  7 Nov 2026 14:33:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6E377607D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794062037;
	b=OfPOCGmwmGjKILVX2BGPOjYzV04K1QOxYdZQIiMmYrF9Xz0i0q9L24Gsi0kqPIyUDxl+
	 dGKWfUv5YLvvmFRqpP/zLPICeSl+99mpm2CaSu9gvNyOwKdLshGLY6z4VbStmFFamLnCQ
	 07lBzt5iIl+Y8fjyWxGYxu3Ws0p+3C9m6af2+ApjgGRm3ksNaFBit+wwisBvCjA2uCxXb
	 Rau8E6PUbjpXJEwC0K8so1XOGiUvA53udBmn8fhKlRoMe6Edt6jyompnHnboBjSKc0Kyf
	 aAdEQexwa0G2XCqDRmuOLf2n4ZsMLdfiT0ljOgRvKHWkZfoACKH2Fkbilh9VE2OIPSg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794062037;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=80XXF+VJVrJqt3e0nZCsibOhoivrONBaisz+iBRGsdM=;
	b=ZLxsM3Jc8qEZr2pVDx949jsfjS69f7fEjgutqGpiYeZEYpz0vNc4jzrg2emeMqIROlVh
	 sHQdWTHihTdfD+3S60woTDeGogJS/xt3v+F2vpXyiv9Z2cCFhVDQMS++HrZKKwqbEivE7
	 TEiQyc8AYJJs2+/AvKRGfGSPD+SLqZuwy1w8aeCMhQYxAZhgenxPCywSwl6D4wp/obrpx
	 3iD0GhxyorEUUUbf6iD92gNkdiLuzYPvCz/IHGedsx3y1PIJxCDvPKLq8OD0I0JGTXSK9
	 MYzmS6zcGZN+P6V6HMyKc+rm+qVD35BCyWR4ecpSNm99oIUiECa2Me/r1cuEAOnQk3g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794062037;
	bh=80XXF+VJVrJqt3e0nZCsibOhoivrONBaisz+iBRGsdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z/7Yr4lFKWlZ+cW1mB8SFQmhgaujJuyaMGbErzZIiZp9QGDJzvcbKkaQE5vvn3rrj
	 LS1Hj3HiCMyYUI0beNengk1Syi6OBMXpO/V1cMwAqsLmbSaOhQqmCF3SFS57Pa1tvz
	 m/n/ShtIxhh2aQ2YsFVDL7PDyW4U7STZT0nCWF6UxDS1On+e9Tr3XmEGvQK5ceNOBv
	 Jfy2x6KoX+7EwvwoXfm0NeeAU0fgziqjR8ZqS41klTt8i1aRoZgDCsTNovQQ8qYzTj
	 Z2zravfVD9FlL3Pdcw9D0LQnNMQl5UCrvd5gg063hF5WbXACji3fkUL6K0uQ5ht7Mb
	 /ul+yi4zUTf6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6E377607D2;
	Sat,  7 Nov 2026 14:33:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 55F692E5
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 395D881657
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rywn-EjCd6oH for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 14:33:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1CE9081686
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=BJrw8fQ+
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1CE9081686
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 14:33:35 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48e1d0e5dafso294239f8f.1
 for <u-boot@lists.u-boot-project.org>; Sat, 07 Nov 2026 06:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1794062014; x=1794666814;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=80XXF+VJVrJqt3e0nZCsibOhoivrONBaisz+iBRGsdM=;
 b=BJrw8fQ+qR/+OFEU4qowhMOrFtQL13TgivcthF+rolX7dYB+1ldnvqSBZlAFuyN/yI
 hQheqXoVB9HfdiXO6oAIfCo6T8eueqnuAwGNjKQHHGGLKV2soXGHfY6aAppKB0hbmDGs
 Wl34kRgN4cYpyqUXHtdC/MMdnha9jWLzxFFbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794062014; x=1794666814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=80XXF+VJVrJqt3e0nZCsibOhoivrONBaisz+iBRGsdM=;
 b=1NVCT3RQGcxNQJH4v2wlolhE1YQEY4uZGKwt8WDrAAsIa7xzRSuf+5vKF9gx9pazIR
 PTlqgwhkEROenOVlQvRAQTUpQNfH+A+8ISqUE7JSm8RtxumpZTJNSs9VlwRZilrJ1ISO
 UNgPJsb1cNin5G3Cmt3U+HsR24H5vFHHD1iwkBN3LAdVAuyPpsLL/VN4G4xY7jGyqGz9
 2+8Kzf21JqL1FRlg53nA20sWQvsjy5Eckft5w/dHWCgAyObVor2wigpsjp/8Yr1hV8sY
 ZhoDFn4VPisOoBGAv3Vus+xCoo5C+gblKBZbP7bIuD+vV/1RK09jcOZEzjy5kVwsEa/Q
 y75A==
X-Forwarded-Encrypted: i=1;
 AL+hErFHCZLw7mm1O3O3IEK50BABBIbstEIBbI9qFTXmIidsAFuGYGaxX/IL750p0oQOsFRbgtbQ3fs=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9nddg5Ea9QNhwPgR9aIWM73z3LSEm0rgw8a9RegeG7UhyDuwep
 5pFd7hFzLeHb4ir5Ll2B130UlMlO8ZexrkXZyaOolhox8qVi3IwulQbtg6wKKhtRCdc=
X-Gm-Gg: AYBFou349gpC575zKlz8g67mVqYNPNCQZZaMlIYA6tdD8HbaL7/YJQkipY4ltua1ZNf
 URXKpf9D8S/m6C5ELL8iPJX9M42Llc7Paerrj9mNhVXJQmVSLYc9m/bqnAHd67RZ0oMxjivnx7J
 0eWqHSByDyTqn3R0Z0eHhnNciSO6vRwHdq4ewzaMwhDBrLOeRCtFJMfgaFU3XtC30e/ySCTTtEo
 bHy9rdw1VQtyI+zakdKIZ7mW8e1XwSyl652a/ldO/4FC4NHC3teIoYdXzO7niKA5j9j7Uq7swav
 xAlVed8cVo5/brhRVnyr16I9oCFYEkZIdqrl0FfQ2mFKlXuHVGJnn3QKTWm/ms18nec2XrmHX7I
 KhncvC0F0V19TU5oKoBo/Seb+smpiIYqdcFV5Q3/TJ6ci/Puzle66KGi27pVENd/me+RRj0lZlu
 DfEH7+s2j9+MUJm5E7FJjWb5VSB/bacOEUOG0ptgK2FPD8RqWLBwFik4LNZxEK0F0Q7w9VVDpdk
 IHtZptUfsbBr/P8DhpJpbyrNOBQhoCZE7BKEFmBqucsII3dBhFJxqZlK6XlnKVKqC2GV6XYx61t
 75BG+bRhSOuTz0I9wqcLU0RCYu3bOI8ejn8gX0+VQadAWJbYsDheNwXgG5fUM0qvGdQDCLUH5YS
 IyxjXDfVGkcgBtY7kUqvvD6BZBlqe4Rj9MrhIi00j568++6q5fjJWLUy1OL5mIN7uToGdotca3E
 bjZoh98gXn9Rt239kcZo6U/9Uf1Q==
X-Received: by 2002:a05:6000:41d3:b0:491:eb12:e151 with SMTP id
 ffacd0b85a97d-4941f5733a1mr3661252f8f.4.1794062013836; 
 Sat, 07 Nov 2026 06:33:33 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7cc6187sm10027247f8f.46.2026.11.07.06.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Nov 2026 06:33:32 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: michael@amarulasolutions.com, linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 24/35] arm: stm32mp: stm32mp2: move boot device environment
 helpers to SoC code
Date: Sat,  7 Nov 2026 15:32:14 +0100
Message-ID: <20261107143241.2236511-25-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
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
---

(no changes since v1)

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

