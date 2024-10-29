Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74600D3A692
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 19:12:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84F8F891A1;
	Tue, 29 Oct 2024 20:12:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xe4ZXp+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68D73885B3; Tue, 29 Oct 2024 19:58:28 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7532989187
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 19:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vassilisamir@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a99cc265e0aso903345866b.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 11:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730228305; x=1730833105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gi+PXY/5JeeE6bcHCd9fNkK0FZexYGPe1uszzVsms8Q=;
 b=Xe4ZXp+0RB0HNphNMwMaMEyM0iMa48oYaypdezo2zF5vSgiUjLgLuwyV99PPwG518T
 QkAlMy3e77gXyq5cujV+q4VV5aVNe3ZCWZslwaBQovH1K/1pwXf7Jqhc0hCTcmxUYsSM
 MYLAgyC5ol8rnymOJE0tL7N+ufysCX6zNPW6wa7E9Augreofcdv5sxOmxhQeOenLGtCo
 2fINZ5h20ZiX+CQWlDMqOMHvApI4fWKhAtD9A8qZlKEMcmOw8pF/nhkNKcSFvbvPiaid
 Jli2fluKzWq1BuV3kWOxmn5aUYLkIGsQmpGKaUabWJrSYXjP4uGlXrIaS8PA/efwQW3T
 B73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730228305; x=1730833105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gi+PXY/5JeeE6bcHCd9fNkK0FZexYGPe1uszzVsms8Q=;
 b=K9YyOMTgcUCS9WFx4rZDqZAfaXM3nkhdzTiYLxeReIg88+UXH9Xu4OvvNh1EUj1Vnz
 Vj8FFHw/3GdpKPdzep/xov8YjbHdsccF4Ia3HUpp0nYDPzifFAc8BVt7xqwXxnG7NBAl
 rUMoIgRVjzZHhpek5zkVGOn1+JMKmUj/mRA+GVrvcS1xs+HLRrxEik3NTN6V+fKvjiEa
 wZWtS61jUcmXtkSWNeHBansfzkBkfM7wIdNNACb5bb2gLXwMuLdtV7OK5kj6S+1CrUuP
 cxpQ2kIe/2IsCUz+4JcHB4hZUI+1Adp/Zf86FAPYExFKaPcrfw23mvigAzv15kXSLn1p
 vyDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV43X46K6Ppn0YapYWi85746Ja56crRpPHd7hnhquxEs3nL+oTBltHgbrMpiV2uAtqIEplQRkU=@lists.denx.de
X-Gm-Message-State: AOJu0YxdpV53xP2JjP3JTlSZU+JdsMxKlAo0F7A1wAR24SIllaJ3+7sK
 07ulRBmoFXLWNH4mjfxkMUleybF+0Vi4jkfgIe0iRHtEDDDePjxo
X-Google-Smtp-Source: AGHT+IH9jAnPlSLZxF8UJh4n9kvEXq2nScggD5Ire3w+W8lFKmbh38OBsoaSJ2ChqiMNtcwbD6qAmA==
X-Received: by 2002:a17:907:9815:b0:a99:e326:53f2 with SMTP id
 a640c23a62f3a-a9de5f67a62mr1086192966b.28.1730228304780; 
 Tue, 29 Oct 2024 11:58:24 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:89e7:cc9d:3a72:92f3])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-a9b1f2994e9sm494511866b.115.2024.10.29.11.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 11:58:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: trini@konsulko.com, michal.simek@amd.com, hs@denx.de, pro@denx.de,
 sjg@chromium.org
Cc: vasileios.amoiridis@cern.ch,
	u-boot@lists.denx.de
Subject: [PATCH v1 1/1] drivers: bootcount: Add ZynqMP specific bootcount
 support
Date: Tue, 29 Oct 2024 19:58:14 +0100
Message-ID: <20241029185814.7937-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029185814.7937-1-vassilisamir@gmail.com>
References: <20241029185814.7937-1-vassilisamir@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Oct 2024 20:12:43 +0100
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

From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>

Add native support of the bootcount mechanism in the ZynqMP by utilising internal
PMU registers. The Persistent Global Storage Registers of the Platform Management
Unit can keep their value during reboot cycles unless there is a POR reset, making
them appropriate for the bootcount mechanism.

Signed-off-by: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
---
 drivers/bootcount/Kconfig            |  4 ++++
 drivers/bootcount/Makefile           |  1 +
 drivers/bootcount/bootcount_zynqmp.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100644 drivers/bootcount/bootcount_zynqmp.c

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index fa6d8e7128..95b6a9541a 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -82,6 +82,10 @@ config BOOTCOUNT_AT91
 	bool "Boot counter for Atmel AT91SAM9XE"
 	depends on AT91SAM9XE
 
+config BOOTCOUNT_ZYNQMP
+	bool "Boot counter for Zynq UltraScale+ MPSoC"
+	depends on ARCH_ZYNQMP
+
 config DM_BOOTCOUNT
         bool "Boot counter in a device-model device"
 	help
diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
index 245f879633..487adc1212 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_BOOTCOUNT_GENERIC)	+= bootcount.o
 obj-$(CONFIG_BOOTCOUNT_MEM)	+= bootcount.o
 obj-$(CONFIG_BOOTCOUNT_AT91)	+= bootcount_at91.o
+obj-$(CONFIG_BOOTCOUNT_ZYNQMP)  += bootcount_zynqmp.o
 obj-$(CONFIG_BOOTCOUNT_AM33XX)	+= bootcount_davinci.o
 obj-$(CONFIG_BOOTCOUNT_RAM)	+= bootcount_ram.o
 obj-$(CONFIG_BOOTCOUNT_ENV)	+= bootcount_env.o
diff --git a/drivers/bootcount/bootcount_zynqmp.c b/drivers/bootcount/bootcount_zynqmp.c
new file mode 100644
index 0000000000..9bb801e188
--- /dev/null
+++ b/drivers/bootcount/bootcount_zynqmp.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-FileCopyrightText: 2024 CERN (home.cern)
+
+#include <bootcount.h>
+#include <stdio.h>
+#include <zynqmp_firmware.h>
+
+#define PMU_PERS_GLOB_GEN_STORAGE0 0x00FFD80050
+
+void bootcount_store(ulong a)
+{
+	int ret;
+
+	ret = zynqmp_mmio_write(PMU_PERS_GLOB_GEN_STORAGE0, 0xFF, a);
+	if (ret)
+		printf("Failed: mmio write\n");
+}
+
+ulong bootcount_load(void)
+{
+	int ret;
+	u32 val;
+
+	ret = zynqmp_mmio_read(PMU_PERS_GLOB_GEN_STORAGE0, &val);
+	if (ret)
+		printf("Failed: mmio read\n");
+	return val;
+}
-- 
2.34.1

