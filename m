Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5B1E784BE
	for <u-boot@archiver.kernel.org>; Sun, 28 Dec 2025 15:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA03836AC;
	Sun, 28 Dec 2025 16:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YtTrEr+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EA5983A91; Sun, 28 Dec 2025 16:09:02 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79368392C
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 16:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-64b8e5d1611so10456523a12.3
 for <u-boot@lists.denx.de>; Sun, 28 Dec 2025 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1766934539; x=1767539339;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QdV98Lh2V4nNh/XTX3QeAlqNVCxsCWIqkbJ2eJwv54w=;
 b=YtTrEr+AZvypm2q6fRdLubH/u2RoqxCTWVxZgltn8/WeHcXjpexPnDkfCG0m931upn
 A6YZA+QTqcgP8KCqR4iHT/Dm0uABqjh253s63P9nnJjsIHpqZgdFF7hV+DU5TSNlDkmr
 ggS+UiR2fEWKUaeevNRF4vis7p0mX4pKWs138=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766934539; x=1767539339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QdV98Lh2V4nNh/XTX3QeAlqNVCxsCWIqkbJ2eJwv54w=;
 b=M78v9mt+8R/FmKZmxz57aPvxYJ4srtBuCbizxtvnAs4wJrmw05sxFgdxtHmdKfw0b/
 er/8rH2FHqgmeXjYvQ4C0d0Sg3KV7kFlYE52ViA6n468jt1IhOdcNBbsdsaRa8H7BtHn
 N8GTQWPj9GUVP331PDW0jG3G8z8md4mBboaDPiiSAUnVIF9pKD7U6Pyh3qvQgfnRP+lQ
 79LgCWWefLKtOMGSK3vxV26qg3iI6K0KPImcRKjC+Wmb/Gsmcq+AkqSA0n7gPmiQiG/H
 IYfDZmadWUwQIeTqDD9u3y9Bz9Z+6B9rL9Z4KJ6SpKXdJlk55ZB5X/MDWP0QmB41ZSxk
 n0sw==
X-Gm-Message-State: AOJu0Yw8LhHKXKOOLaTQd6NjjVhhzwLIDJVF6Sqzx+qxP/GkFZLGB4Us
 SZ0mC1mR6PcST0wpraZXspNvLMpTf0QuuqVllTt9yZNNIXwUUdKBN6wqZBfIPo/SHGdMILJuzGb
 hLQp1
X-Gm-Gg: AY/fxX5uGMPDMb6mhpDE6MaZdnrOodL6Lm3mK4jfEXrBeWfWvMGWhBGd6A/THJWeiGO
 A7FhuVAl2kHIP+X7s81I1wSvCjMRMtgLJk2yasEVsnR9S8ugZRvsMHlRZRkHh9TEvvTkwVbV54T
 imlNIvyqL8rWuf2Ez5DoySab+skgJXQmFMHpiC6Rf9I7AD823kjqI8NkX/aM3tCtQp4EapnLKGg
 nnZiOM0dWlm0Ob07KYwcvRse4tuQsxpLptUr8hnBivVwjQr11epa0FAgFXaLx86K1m3lsnTgTiK
 WZ67yipYsr7HGwwXUc1zofVTbmANYUTh0JzdbUr6HEFoO8zX0RvdcM7aM/Oh52YmU8x5KzDpsQ7
 jll08YuhMUJZbkMCs6X7cB8BaIZUbZBXDk+LUoj6piPomqpg5WSErKgFK4Cn4WOPyyC4myjPyu2
 PQRsAd2avrUjBbpPLBh81Z8vSVnPQ2BL1JzeAFVDBYOsqNVR6Ei3CxTQLmpcrJDqeaglXKOwezN
 eTe5pHIvL942leW7F49JXvrDxhptLvoybTTCyxjTb19pdV4GH5dNfq+qlQ7yMilPoCzqO4sm1Ua
 iD7HZXr3WdI=
X-Google-Smtp-Source: AGHT+IGjV6DdBS084zPfaxAWPJkz43g9d9O9YGxz5PyL/q4XmK2DvAuiV6z2Hr0YokkBe+f8uztY1w==
X-Received: by 2002:a05:6402:535b:20b0:64c:62f7:1ac4 with SMTP id
 4fb4d7f45d1cf-64c62f71cb9mr19426440a12.32.1766934538911; 
 Sun, 28 Dec 2025 07:08:58 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-95-248-31-95.retail.telecomitalia.it. [95.248.31.95])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599844sm28835422a12.25.2025.12.28.07.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Dec 2025 07:08:58 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH] board: stm32mp2: read boot index from backup register
Date: Sun, 28 Dec 2025 16:08:14 +0100
Message-ID: <20251228150844.24753-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Following the commit 95b5a7de30f6 (“FWU: STM32MP1: Add support to read
boot index from backup register”), this patch enables reading the boot
index from backup registers on STM32MP2 platforms.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 arch/arm/mach-stm32mp/include/mach/stm32.h |  4 ++++
 board/st/stm32mp2/stm32mp2.c               | 21 +++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/mach-stm32mp/include/mach/stm32.h b/arch/arm/mach-stm32mp/include/mach/stm32.h
index 2bf50c755cbd..90f06a052d3f 100644
--- a/arch/arm/mach-stm32mp/include/mach/stm32.h
+++ b/arch/arm/mach-stm32mp/include/mach/stm32.h
@@ -188,8 +188,12 @@ enum forced_boot_mode {
 /* TAMP registers x = 0 to 127 : hardcoded description, waiting NVMEM node in DT */
 #define TAMP_BACKUP_REGISTER(x)		(STM32_TAMP_BASE + 0x100 + 4 * (x))
 
+#define TAMP_FWU_BOOT_INFO_REG		TAMP_BACKUP_REGISTER(48)
 /* TAMP registers zone 3 RIF 1 (RW) at 96*/
 #define TAMP_BOOT_CONTEXT		TAMP_BACKUP_REGISTER(96)
+
+#define TAMP_FWU_BOOT_IDX_MASK		GENMASK(3, 0)
+#define TAMP_FWU_BOOT_IDX_OFFSET	0
 #endif /* defined(CONFIG_STM32MP23X) || defined(CONFIG_STM32MP25X) */
 
 /* offset used for BSEC driver: misc_read and misc_write */
diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index a72056e12d63..101f1a494108 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -224,3 +224,24 @@ void board_quiesce_devices(void)
 {
 	setup_led(LEDST_OFF);
 }
+
+#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
+
+#include <fwu.h>
+
+/**
+ * fwu_plat_get_bootidx() - Get the value of the boot index
+ * @boot_idx: Boot index value
+ *
+ * Get the value of the bank(partition) from which the platform
+ * has booted. This value is passed to U-Boot from the earlier
+ * stage bootloader which loads and boots all the relevant
+ * firmware images
+ *
+ */
+void fwu_plat_get_bootidx(uint *boot_idx)
+{
+	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
+		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
+}
+#endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
-- 
2.43.0

base-commit: 56cac250b0839ddbad1311d3ca4231f532b5aadf
branch: stm32mp2-active-index
