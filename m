Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEBBD75E5D
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 321FC899CD;
	Sun, 24 Nov 2024 21:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H3aBMjGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AD618951A; Sun, 24 Nov 2024 21:27:47 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AB28999A
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa539d2b4b2so171728366b.1
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480062; x=1733084862; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tMiqRhrEmexn1JVPb8Plej2ovd5t/ZqG05OkUd4Q8OE=;
 b=H3aBMjGyo5JHzFkW0ckkLmaQzartccui0IwoSBT2fg33/wzEHwjzi0ZoiD8Da8GC7F
 Mege6zXmHU9jnG9ElTNWlma9Ir7i+rq6TiDPfzAkjQOqgVm2+XB3jd16/i7PqHCoZ/Zj
 yS9KBDN3GS811ZztxHQu9xibrQ4hyB+CZg+vdDjQY6FtxiFCppvkVjs7oW2gU0gvaMZx
 8y0Id75eZFgsBbAeiIGMwOEKh1B0Z9lCwbI1hE9/WK3pjHzxG+5QU58wQaRSuYkkN944
 iWx9nNg+QfCPDEoTReaxRVS4catTqsb4qORksdbvv5M0nvWyDhJT9Hw2pw0fKm7R4xX4
 JWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480062; x=1733084862;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tMiqRhrEmexn1JVPb8Plej2ovd5t/ZqG05OkUd4Q8OE=;
 b=UQz4VtKHF2yw13oas8n+pQxFuF0xHtaWe/zSg4wYvC/F61mVSIF4y/dorjrBX0hmcz
 5ytRoPZmdULPoRbYzB+kABhKKgMIR8HmCpiZnC/W1V+2b5b9muzDScfobggDx+v9aGqv
 zdx7lDvDFDeLhXZ2Nt2/koStBFA67NGAM+b9/WzDJVRrx0XFr3mybuYKcg5Bl8yTTklb
 rSfCc9AvSMl30jWgia0BeX9ybVKDqfwcocUDsJLfrJhdo11YKfhiBZs2F7+YUEMMGiVM
 a/Ght7jCXKTayIo9+mK1BqROeyCORwTWwkGvZL1PcCUQ2oG9os7ysy6YQahkopsVXrp7
 LASg==
X-Gm-Message-State: AOJu0YxN71M8EjhBxgxqEvrSCV7xHX3wH6DqguywFn9i0XqXJk2OysPn
 d6Nk901VKEpWDCWQ+LIa9PPWckpZl9Z6LUqoVJhhx1YljfHOeUmKsmGgeosTMGM=
X-Gm-Gg: ASbGnctiUguKGAa0H9ml89sFjTnjfivZhl5utifUEc7xWWLTiotdrDGGz+caSeQ/vzs
 6tH0wePASWorHvZQ+zuJVlmS2+N0baJZW32SjVrvl+5p7JUxBEdHqHKQW9h0SzELZpO11USVkie
 abN75nUvD4pikVv0bTbNbJSyNKT1k4KvZxKEr9g9W5EUSwpm3aKCpU6nmd7+v/BDCy7M9sAjQ3J
 Nxe9plsUCCaxWK6515foGkPxkag5XUZhMwUJOVxIa4QtuxV6lrYZnF9D1qmyA5pkdCj
X-Google-Smtp-Source: AGHT+IGpF5U5irT9FM1wO/Dp8kxDGPtYSBRYaBozSh2NljsEtDP0i0Va+t1JbNN2FXaMFUgt1kgytA==
X-Received: by 2002:a17:906:3cb1:b0:aa5:1d09:2083 with SMTP id
 a640c23a62f3a-aa51d0920c0mr931769066b.13.1732480062651; 
 Sun, 24 Nov 2024 12:27:42 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:42 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:04 +0100
Subject: [PATCH RFC 08/14] mach-snapdragon: support booting with EFISTUB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-8-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3413;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=bnXyHbJrrjUj8gai5xh1lap2MF28gSjtPXd4TM2v+Og=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHiN25jZOkR9t6wyOa9wJU8qXmT73RmzCqivJ3y50v
 2bZ5ajVUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACbyuY/hf0rzv0Oy8mHbXymk
 33D58vojb/4LrzDFDpZdnhWBhYHTmBj+WVcZtMueOb1wWnvyetu0RLn9Vu/ypu6tjO1KPbLkvcg
 WbgA=
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

Retrieve the EFI info header passed in via x0 and use it to populate the
memory banks when booting with CONFIG_EFI_STUB.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c     | 15 +++++++++++++++
 arch/arm/mach-snapdragon/dram.c      | 15 ++++++++++++++-
 arch/arm/mach-snapdragon/qcom-priv.h |  2 ++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index dbac8aa2709a..f92b26c88d46 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -41,8 +41,10 @@ DECLARE_GLOBAL_DATA_PTR;
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
+struct efi_info_hdr *efi_info __section(".data") = NULL;
+
 static void show_psci_version(void)
 {
 	struct arm_smccc_res res;
 
@@ -59,15 +61,28 @@ static void show_psci_version(void)
  */
 void *board_fdt_blob_setup(int *err)
 {
 	struct fdt_header *fdt;
+	struct efi_info_hdr *info = NULL;
 	bool internal_valid, external_valid;
 
 	*err = 0;
 	fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
 	external_valid = fdt && !fdt_check_header(fdt);
 	internal_valid = !fdt_check_header(gd->fdt_blob);
 
+	/*
+	 * If EFI_STUB is enabled, we got handed a pointer and it's NOT
+	 * a valid FDT, then it might be the efi_info table!
+	 */
+	if (CONFIG_IS_ENABLED(EFI_STUB) && fdt && !external_valid)
+		info = (struct efi_info_hdr *)fdt;
+
+	if (info->version == 1) {
+		debug("Got EFI info header!\n");
+		efi_info = info;
+	}
+
 	/*
 	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
 	 * Bail out while we can still print a useful error message.
 	 */
diff --git a/arch/arm/mach-snapdragon/dram.c b/arch/arm/mach-snapdragon/dram.c
index ef226e000858..0493653e432b 100644
--- a/arch/arm/mach-snapdragon/dram.c
+++ b/arch/arm/mach-snapdragon/dram.c
@@ -7,12 +7,15 @@
 #define pr_fmt(fmt) "QCOM-DRAM: " fmt
 
 #include <asm-generic/unaligned.h>
 #include <dm.h>
+#include <efi_stub.h>
 #include <log.h>
 #include <sort.h>
 #include <soc/qcom/smem.h>
 
+#include "qcom-priv.h"
+
 #define SMEM_USABLE_RAM_PARTITION_TABLE 402
 #define RAM_PART_NAME_LENGTH            16
 #define RAM_NUM_PART_ENTRIES            32
 #define CATEGORY_SDRAM 0x0E
@@ -89,9 +92,19 @@ static void qcom_configure_bi_dram(void)
 }
 
 int dram_init_banksize(void)
 {
-	qcom_configure_bi_dram();
+#ifdef CONFIG_EFI_STUB
+	gd->arch.table = (phys_addr_t)efi_info;
+	/* We actually parsed a memory map from SMEM (and used it to
+	 * set ram_base/ram_top), but it's better to respect the table
+	 * from the EFI bootloader.
+	 */
+	if (efi_info)
+		dram_init_banksize_from_efi();
+	else
+#endif
+		qcom_configure_bi_dram();
 
 	return 0;
 }
 
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 690557463642..58b8cb497482 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -4,8 +4,10 @@
 #define __QCOM_PRIV_H__
 
 #include <stdbool.h>
 
+extern struct efi_info_hdr *efi_info;
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}

-- 
2.47.0

