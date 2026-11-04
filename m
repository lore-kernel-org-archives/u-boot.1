Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A0606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 08:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=q+hi01f7;
	dkim=pass (1024-bit key, unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LuWJOB2n
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3015780FAD;
	Wed,  4 Nov 2026 08:52:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P7_VQSxEPyII; Wed,  4 Nov 2026 08:52:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 440A3810C5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793782333;
	b=AEXx9DPZ2fxxdI5avmBVoDV9lqHXQA9j+nthN4fDdhbL6a1ndutBEzdpW/XMnEdgqdSL
	 TXayYdmYKLOb4LTEK5SY/2MDZiyQB1RputhrhopSReYo7JBs42+x+mkFUGUWMu8x4QDC0
	 bu8+ZON8rqSZNJEOB24SwOWTBT1q1NAizYCAsPlo0Px2ZnvH5W86QdSk+vw1d1vjz6wEW
	 DjhBCDyV8wKReO39V+RPjsn/rr4EqOEebJvpnxpM/FxGc3pXklB97vD5AqubFCFxLwGVv
	 7vWEZD7ByLfLjRiu5ZFZQM+iQPak0VDjP2UXneFz1pOevg/sW5y9m/rPz43fVjyRIMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793782333;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BRLwnsw+lzQr6PVk6mSJeeOcOljjRkHPe/9mh9YSDE0=;
	b=dVklXwfczTjgp4pb8/7N9uBiY8/eoV/BguYoftGZauHbVtLkmj7fXsFH8C8c38HzuMAa
	 6JKfU1+DxyREkin9kQnSGWx2rLQNloP5onYrdgqhkvbULGaIT6qK6jx1cfbn+2ophSRJy
	 KuKuWTJAI/AZMrEZbDUAesgqCJZaaVj+o3+VEMbzkFuzu0Z1Mkl8JtiH+vA352aiSZL/W
	 DaU8nbTWfEiFNX9TRoNN/Fi1Ik9n6dzWg6q2pzQ+vvkRlAJvzJFuXLeORoCPqGp4H6PD6
	 v3F+63i3tKdHoo3tvjsd7bSnujxRqM8k6eDhUxqGneiqJBSYKPk+mjNhPL7bvCX3GwQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=LuWJOB2n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793782333;
	bh=BRLwnsw+lzQr6PVk6mSJeeOcOljjRkHPe/9mh9YSDE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q+hi01f7zURp+z2+QmptTRD1q39T8ua+juYnnGKI1o59nn5JfRpmnrRqG+oNsKNEM
	 0sNuSHrji4wEEW2BLXuatIevHNu/9WO6SG9kf/yI8j7tNxGMF57rE8pieH8aUXrsd9
	 rI+mUf/HZsPYd18N0cbXie+W+ZyLFh+qtimnzsNZ1YCkhHDV6ErB4PoJXibQotUrDk
	 ygrWQKH67MHMDeFz5PJxicwTsdNk4pJ1G6gmV7TwO1R1KNlrbLY6VizNRwENVMmQr/
	 GCxmzUeMja7VIy/xkbV0PlmawM08cDupyAiFENQjJQRlHVjM+PV8Cavk2dof1ZMSuv
	 0sTWLRfK/P4Qw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 440A3810C5;
	Wed,  4 Nov 2026 08:52:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CC1A62B6
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE366810D7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J92et-mniIDa for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 08:52:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B31928108C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793782330;
 b=qf1kpu0KP/ZtK05Z7mlrTiW+0tlzi6Avdy+gQoYUKV41AH9UVHl3oTS/GUy2CBrFqqz2
 uyZyKvha7UMqYwNzvqaorKgJrNxJKsPyP/5s/MPzjVzFL8UFukRTSePCQxro384j6KKYC
 87T3fSrJhqZPYTA6747hrq43iYEQr0wtnbGy7/QTJwQkF4v5OsG1n0A9H+SJXMVmPsmj0
 VAmxdQQ2+LDyv+FbfxF0QbtJJ+hT6puTko/ep2bAExLsrd//g/SJExx0zmdRFd/Z5+4k3
 Tmqyyar9WjcWBJcMdUO7UgtmEhi1w25nkEqW1WPWAKQzekFMdqv3n3bfJ7/rIpp00iQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793782330;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=BRLwnsw+lzQr6PVk6mSJeeOcOljjRkHPe/9mh9YSDE0=;
 b=c82/7LmDwk03YgycqDziDECgHJ0Dv6SIy4ZSAn4A0s40u2bvwN3T+GVVHI2/0kUlqbvQ
 y+2zaUo7K/lnXY5OaplTQwBTP05NiVnJ9SP+KiaSa2/5aFITg5O02F/JuRlRCIF7rV8l2
 LQ7cab4Kyw8fVRClunp9P++uBXUkNSS3R3wDDDk6sLUemenG0pI9zwLon4SDgb8AuvHxf
 z9huqhB5SQ7dvVPoqKlS56lvBOmQc8AoNEbTNg4O9ZAaZR2PkiBqDk523YFQQ/5uXJwJq
 VFS8cDJ459Gg3kgxXzLAanUajZdEbCIr+4fWbG+oe8gU1Vwn1c2VWhnx7ClMPtuT0sQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=amarulasolutions.com;
 dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com
 header.a=rsa-sha256 header.s=google header.b=LuWJOB2n; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::335"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::335; helo=mail-wm1-x335.google.com;
 envelope-from=dario.binacchi@amarulasolutions.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=amarulasolutions.com
 header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google
 header.b=LuWJOB2n
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B31928108C
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 08:52:09 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so3600255e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 00:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1793782325; x=1794387125;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRLwnsw+lzQr6PVk6mSJeeOcOljjRkHPe/9mh9YSDE0=;
 b=LuWJOB2nbli34EHEh1BwGecu5K/6Ij/qWoU4k9FY+wS5oHIDqzhpVhCmgDO9u2iu6k
 b/7I35M7Ar5JV899FpZ0+YGtJS1WRHIf20wC9UL38wCoEpwRlwvv4oGt/73Fl9r8A4sw
 wDiv4+6ggzRAb/Gvk8MJh5bejtT+QQXpGMexc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793782325; x=1794387125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BRLwnsw+lzQr6PVk6mSJeeOcOljjRkHPe/9mh9YSDE0=;
 b=KoL8e0oV/t6S5S4fvfscx0jfPeqTC1tywS3vjdBnWIde81eT3q2aFhsYC4VNOjTTpO
 2Hgm2Pyl2zmCLJ+Zojx/2cTApxzzjJTQrnuTwa7VrPy7iHhqBMqEwzfol9H5tMeEYb0s
 NdtVAnYjdAAFpxWhc8XV+uPk9f7M1QYN+A6W5Bix5bjsO77PhfPtQRUKaDbLAiIz2+4g
 Js631FDv/8VjYrmqNmha4fPoR9H3gAQnuwr3gOiMnBg/Ie+6glAv9iEAOQesHGm0/X65
 6V+pSJc96hlXs4FEfdfvYWV6KPH4pIWQktljaj1nLdY6QUwHQ5epjiaMNsJdyXMzTQ1H
 o2sQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlnzWfBiMlIqSFctdMekhXet8vR5t3U9zGq47uQNXj7fXhgiDRTTZ9rqG8Ui9pwr5aIJYLvRU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/L3eDhXmFyegPobpKlDwyViI3l7/PwUsN071LtUubSCcjeTiW4
 /9orwYv0k7D45dlFX1+9C6Lrt31NuUcMgK2Ni/MkURV5Ct9iqSsqgRE2e/VuVmwt7RE=
X-Gm-Gg: AYBFou02MIoruVMgqfFSaCFpmSZEEjSncsmXSgzL64CsyFO8B+pQMNmCjtXfyH4+n2X
 kt/ISAhtBsTD1jPxJN7q3/1PWRy3U1y1mhS4UBErU/B4NJ6xRHv842Y5p61ZCe/xfotpngR+Ckd
 zktWhUvM8Yi8FkitZaeTl/+HxXhwpIbug/z8IKWNRk6O6d7iiAdWbTCjKJGWRfWuDCMTcrUegrC
 5faplz+x1xHB3ca3sjtSNfiHIepaZv8nxthowStXJ4owcZomt6722VQ0RFYCrMFDNWkUfM/ofmi
 Y5kU0tzilsN4Lsq4dILGC+TtESYbZwfCpp+FKVcy5on7Ul0mSD1xPPWLRVkY/Ut6ayb2Njc1Vgl
 4oMI08Rvj1v1fsxu8CVe9mLJi4wJFjehP+ZjYHLT1LG9nS//hyJa+vaf89mDV8P/nusPtG+ej6w
 tcRLmNOAfbo6DznpuE7XkHBJWQaD2253u/mgeETjEihWVRjcn2lm2+caMqrxqVlIBeGEY4818VI
 Xp6d4Wbxx8HN5sKHdrodb9gLzreJURnkeheu76n2EQ939sTLMqxUBLWx9cIMG5CY+38CuPDGmkz
 lMWT/TcH1+myTuOLn0/I58YQO2gsBe8jvSQfmRVrxYPdEe/eIrQk/3fSLQpENbWfuCf/NGM0L2H
 xffHwoJAGnOrn4PNvKffIMhWFWFg=
X-Received: by 2002:a05:600c:34cf:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4ac150b38ebmr359556815e9.1.1793782325564; 
 Wed, 04 Nov 2026 00:52:05 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.. ([109.54.139.206])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b413312a4fsm20555915e9.1.2026.11.04.00.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 00:52:04 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: linux-amarula@amarulasolutions.com, michael@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 23/33] arm: stm32mp: stm32mp2: move boot device environment
 helpers to SoC code
Date: Wed,  4 Nov 2026 09:49:56 +0100
Message-ID: <20261104085036.4012238-24-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
References: <20261104085036.4012238-1-dario.binacchi@amarulasolutions.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

