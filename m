Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E76DCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 06:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C1684664;
	Mon, 18 May 2026 08:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="VNbWb0k0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6542F84687; Mon, 18 May 2026 08:54:51 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52D6584664
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 08:54:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d75312379so1837167f8f.1
 for <u-boot@lists.denx.de>; Sun, 17 May 2026 23:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1779087288; x=1779692088;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swZTj+mBnyDem0Vmzvdz7LBEsTbhVc3zyakfr8nCa+4=;
 b=VNbWb0k0KaDLrzknCdB+ecIac0lJA99gtN9r3YFzEvfge1wEFaVpzOdGBhq0Mhg/Zu
 2ZczUd+vsmeMdd8YU+fFjYndqymSe8mhz2DOBZelppTu0d+o0OxOXI+oyWKUv3RC0LKu
 qvYinnj7tS5mLY2rVTmr9+ZyeNdq47E/0Dsu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779087288; x=1779692088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=swZTj+mBnyDem0Vmzvdz7LBEsTbhVc3zyakfr8nCa+4=;
 b=HJExnxiFfKWaQ+2jbivCNe88aaF/tgRfODVCpEASjTtK5qpTuKLcqWEYRQmF0xhGn5
 MWBXNdMMqpCng+1anRucHgaTYv4m9qn6kZaD6Jh3QJ4V6sW7I4vEWcsC8UJjO8YUNBAq
 ty7c88cmwiNCVxHh26ERZwkl01nJB8scisK3OdAqYIdVS6SWZAD1zBa7B4vsprEHZKF8
 n888ZeROyfOgjGLX1jEjNqgwMAqAsxj0r7IF4uOEOcwYI3BWXed8cNCFLAODSManHqMC
 Rg+s5DMjGhTJrWpC98PF9dTIkTFUU0dxXGpyxZ3x8HfcrMmn+V/+3FbYbtFoIP/wZLfJ
 ODMQ==
X-Gm-Message-State: AOJu0YxZBksbcK376RhQ5V2qDQTlCJD70luYpMHLZrRPFBNYDcxPUe46
 kJ6bS+VSO7d4i6yz/6ksBReYi5AoNwor9Eu26/1PHzFAkaF/5U4uS56NEJTllbxhTBBJu/FU6Mu
 YeJAN
X-Gm-Gg: Acq92OGPR0kPfohiq7dwQi1sjxwCZeKOAu+Aw6iddQV/O+RJEgSIUQiYmIHci61MYe2
 ExEXra606UVlYmDA6WcsocX/w9lkoCDffBM8knmHxR1frycnCekIXYNKAPpLihxAg1iqNeQS28/
 HhO+1Gy7ONUEbGNNM7LSjgak7e8lm8P4/692tQz6OzIZcsN01TMzd/8CIBqgm42qAMuBhdcXcN6
 ztis9gMEVTgjJDKwgUqjVpkXgzA2hHAazW9SDVNlbpUQ6ymyXH+4PBgCksQ6VtjRHM8xObScd8w
 w0aoaxMJguXwCkwJ8YHMjLR6bhhDY2SsWycL748VAMOX38cgWSLl/nWFAn3oiFSBY8MORhacvsz
 +N2iwn7ASjhwFX1tixDELz5tbVxz6jr79Ru5JZL4QIbdssVt4xFFqUEFEWnlGGDoYeU0lke/q5I
 oCwQoclmedMGH3VFqsigbsDd3mn/JLjhgmEFFsXXaEWyjHvfWmI2mAIoPBSMNtAtRqeTMCkocaa
 ZOKYOY7BKl+vvXhkUr5dpnKvI2CTQOkrlxkUwATlpLIKrdjFXj0KtD1e8YcqMmiDT7uajoGZ6Nn
 U24G3dYvYWWaPP49Kt7OJ69NMlzQQYCYIxo=
X-Received: by 2002:a05:6000:2387:b0:43e:aa88:f1a8 with SMTP id
 ffacd0b85a97d-45e5b747235mr20583219f8f.6.1779087288486; 
 Sun, 17 May 2026 23:54:48 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm34308524f8f.30.2026.05.17.23.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 23:54:48 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/2] board: st: factorize STM32MP FWU multi-bank support
Date: Mon, 18 May 2026 08:54:28 +0200
Message-ID: <20260518065443.2531017-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518065443.2531017-1-dario.binacchi@amarulasolutions.com>
References: <20260518065443.2531017-1-dario.binacchi@amarulasolutions.com>
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

Factorize FWU multi-bank support code common to STM32MP1 and
STM32MP2 platforms into a dedicated shared source file.

No functional change intended.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 board/st/common/Makefile      |  1 +
 board/st/common/stm32mp_fwu.c | 55 +++++++++++++++++++++++++++++++++++
 board/st/stm32mp1/stm32mp1.c  | 54 ----------------------------------
 board/st/stm32mp2/stm32mp2.c  | 53 ---------------------------------
 4 files changed, 56 insertions(+), 107 deletions(-)
 create mode 100644 board/st/common/stm32mp_fwu.c

diff --git a/board/st/common/Makefile b/board/st/common/Makefile
index 122b13c3aa8d..36dfaddfa0eb 100644
--- a/board/st/common/Makefile
+++ b/board/st/common/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PMIC_STPMIC1) += stpmic1.o
 ifeq ($(CONFIG_ARCH_STM32MP),y)
 obj-$(CONFIG_SET_DFU_ALT_INFO) += stm32mp_dfu.o
 obj-$(CONFIG_$(PHASE_)DFU_VIRT) += stm32mp_dfu_virt.o
+obj-$(CONFIG_FWU_MULTI_BANK_UPDATE) += stm32mp_fwu.o
 endif
 
 obj-$(CONFIG_TYPEC_STUSB160X) += stusb160x.o
diff --git a/board/st/common/stm32mp_fwu.c b/board/st/common/stm32mp_fwu.c
new file mode 100644
index 000000000000..ac7ca6bdca2a
--- /dev/null
+++ b/board/st/common/stm32mp_fwu.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+/*
+ * Copyright (C) 2026 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+#include <fwu.h>
+#include <part_efi.h>
+#include <asm/io.h>
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
+
+int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
+{
+	uint boot_idx;
+	efi_guid_t boot_uuid, root_uuid;
+	const efi_guid_t boot_type_guid = PARTITION_XBOOTLDR;
+	const efi_guid_t root_type_guid =
+		PARTITION_LINUX_FILE_SYSTEM_DATA_GUID;
+	char uuidbuf[UUID_STR_LEN + 1];
+	int retb, retr;
+
+	fwu_plat_get_bootidx(&boot_idx);
+
+	retb = fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid, boot_idx);
+	retr = fwu_mdata_get_image_guid(&root_uuid, &root_type_guid, boot_idx);
+
+	if (!retb && !retr) {
+		uuid_bin_to_str(boot_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
+		env_set("boot_partuuid", uuidbuf);
+
+		uuid_bin_to_str(root_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
+		env_set("root_partuuid", uuidbuf);
+	} else if (!retb && retr) {
+		log_warning("%s: found boot GUID but missing root GUID (%d)\n",
+			    __func__, retr);
+	} else if (!retr && retb) {
+		log_warning("%s: found root GUID but missing boot GUID (%d)\n",
+			    __func__, retb);
+	}
+
+	return 0;
+}
diff --git a/board/st/stm32mp1/stm32mp1.c b/board/st/stm32mp1/stm32mp1.c
index 8164a62e9a3a..9b933a2ba0b6 100644
--- a/board/st/stm32mp1/stm32mp1.c
+++ b/board/st/stm32mp1/stm32mp1.c
@@ -837,57 +837,3 @@ static void board_copro_image_process(ulong fw_image, size_t fw_size)
 }
 
 U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_COPRO, board_copro_image_process);
-
-#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
-
-#include <fwu.h>
-
-/**
- * fwu_plat_get_bootidx() - Get the value of the boot index
- * @boot_idx: Boot index value
- *
- * Get the value of the bank(partition) from which the platform
- * has booted. This value is passed to U-Boot from the earlier
- * stage bootloader which loads and boots all the relevant
- * firmware images
- *
- */
-void fwu_plat_get_bootidx(uint *boot_idx)
-{
-	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
-		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
-}
-
-int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
-{
-	uint boot_idx;
-	efi_guid_t boot_uuid, root_uuid;
-	const efi_guid_t boot_type_guid = PARTITION_XBOOTLDR;
-	const efi_guid_t root_type_guid =
-		PARTITION_LINUX_FILE_SYSTEM_DATA_GUID;
-	char uuidbuf[UUID_STR_LEN + 1];
-	int retb, retr;
-
-	fwu_plat_get_bootidx(&boot_idx);
-
-	retb = fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid, boot_idx);
-	retr = fwu_mdata_get_image_guid(&root_uuid, &root_type_guid, boot_idx);
-
-	if (!retb && !retr) {
-		uuid_bin_to_str(boot_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
-		env_set("boot_partuuid", uuidbuf);
-
-		uuid_bin_to_str(root_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
-		env_set("root_partuuid", uuidbuf);
-	} else if (!retb && retr) {
-		log_warning("%s: found boot GUID but missing root GUID (%d)\n",
-			    __func__, retr);
-	} else if (!retr && retb) {
-		log_warning("%s: found root GUID but missing boot GUID (%d)\n",
-			    __func__, retb);
-	}
-
-	return 0;
-}
-#endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
-
diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 5cbbbc322a3a..7bc7d2a608fd 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -188,56 +188,3 @@ void board_quiesce_devices(void)
 {
 	led_boot_off();
 }
-
-#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
-
-#include <fwu.h>
-
-/**
- * fwu_plat_get_bootidx() - Get the value of the boot index
- * @boot_idx: Boot index value
- *
- * Get the value of the bank(partition) from which the platform
- * has booted. This value is passed to U-Boot from the earlier
- * stage bootloader which loads and boots all the relevant
- * firmware images
- *
- */
-void fwu_plat_get_bootidx(uint *boot_idx)
-{
-	*boot_idx = (readl(TAMP_FWU_BOOT_INFO_REG) >>
-		    TAMP_FWU_BOOT_IDX_OFFSET) & TAMP_FWU_BOOT_IDX_MASK;
-}
-
-int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
-{
-	uint boot_idx;
-	efi_guid_t boot_uuid, root_uuid;
-	const efi_guid_t boot_type_guid = PARTITION_XBOOTLDR;
-	const efi_guid_t root_type_guid =
-		PARTITION_LINUX_FILE_SYSTEM_DATA_GUID;
-	char uuidbuf[UUID_STR_LEN + 1];
-	int retb, retr;
-
-	fwu_plat_get_bootidx(&boot_idx);
-
-	retb = fwu_mdata_get_image_guid(&boot_uuid, &boot_type_guid, boot_idx);
-	retr = fwu_mdata_get_image_guid(&root_uuid, &root_type_guid, boot_idx);
-
-	if (!retb && !retr) {
-		uuid_bin_to_str(boot_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
-		env_set("boot_partuuid", uuidbuf);
-
-		uuid_bin_to_str(root_uuid.b, uuidbuf, UUID_STR_FORMAT_GUID);
-		env_set("root_partuuid", uuidbuf);
-	} else if (!retb && retr) {
-		log_warning("%s: found boot GUID but missing root GUID (%d)\n",
-			    __func__, retr);
-	} else if (!retr && retb) {
-		log_warning("%s: found root GUID but missing boot GUID (%d)\n",
-			    __func__, retb);
-	}
-
-	return 0;
-}
-#endif /* CONFIG_FWU_MULTI_BANK_UPDATE */
-- 
2.43.0

base-commit: 215496fec59b3fa09256b4fb62f92af46e2ec7f9
branch: fwumdata-ab-stm32mp1
