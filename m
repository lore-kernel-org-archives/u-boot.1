Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F87C44536
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 20:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCFD180C17;
	Wed, 22 Jul 2026 20:43:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K43G2NCvrlfO; Wed, 22 Jul 2026 20:43:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A769880E65
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784753022;
	bh=JFYxhASPGhd605Mkxfqt4uWeH61tmXqOWZIs574sJqs=;
	h=Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=gnyZniaCOGTCMXfsNpq/zrROd+qld6Y+gfC7gA7jO0+Dz2ubU+jzB5xv9TGxwbgj4
	 dS7U/zC9G7hfx5voWD5NPoooTTQd30NhioRNx2mWFccw2HvHNvWPDBVHaD9NvhCjlI
	 DT80XblQal+s8EpzgZL78C659hxKW4fLkNgUtgyzv6u4zUwtWJMXMiBdMYRHq15DoE
	 0TxAUUKqDD0QgVnrZakrpIkbJq0G9su3RkgaNIwTNxwHye7+9fw4jm+7FCFP23NCX1
	 TGfUOgYfIrfHA5HlRqv4ge2wooZVaiItvGcN+DqYiKfn2y8tPKjIUHylOJ6mN12EXl
	 8Xa+FNxeZgH9w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A769880E65;
	Wed, 22 Jul 2026 20:43:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C3D9224
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3C5980C80
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 20ACBpQiH1eA for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 20:43:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org D6A1080E65
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D6A1080E65
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D6A1080E65
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 20:43:38 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493f6de72faso45868915e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 13:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784753017; x=1785357817;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JFYxhASPGhd605Mkxfqt4uWeH61tmXqOWZIs574sJqs=;
 b=ccwBcN3DHQrNfKc8DEdJP7r7oUZkPNWlUbxJl92CItjDWfSdS/sLj8aUu/md/SBvN3
 3EHL3qDyEALUK0F6NZAJuExjqKznXzFdgw789TTzO/FQzgLwrA/D/PXPWnz6OTSy5tr2
 m2b/ySKCTb0yU7ltaAoOJrkoIj6wa4ny6L9FeuDt4q6JuptGjTdM40wz2SYYyU7ZJQI+
 KG5Nujc7dNh1+PF57fKhkxza8IYtLKV5EqYon6JMPioI1OCw8a9DCHuzENLXEieDjE96
 aL+K8bV9AzWTMNlqt0of5CF0lDDRka9k5zr9uYqD/makLplBC08XoKO+E18YrxzYc2VB
 g4Lw==
X-Gm-Message-State: AOJu0YzJkZUaaPlLX4JmPFozeMPF8w3fQHi/2hsRAx1KLVlhBPQzK2Q6
 YP1U8SigbUCTLO2AXuewjtKcoI8yNyKl8APpYXj34IQezC7Hf5WdkRX8Wp4tB6xU8TU=
X-Gm-Gg: AR+sD12X2zJDHviTRCrOK5IMDz40zRJAnFqFOYjqhuQFJdK5bef24y9laGNxfvdDmtP
 bNJoUpQiq55Pox9apa8pm1YVV1JQ9rOp6zYz+xl5Hohihu5pB6JDtuPwhXjJFaUxXj1BZrX2ynv
 RwIuXhWzsJ6R8m1wtQt5a9Gf/nC1X40bwH2NcRJC+q79IwqaLhqxYWjLKU0q0AdeI+PgAm/2TLt
 VcMxuecBrDH6cMsESnwbdxyIB5r5iodOSryKPnA8frAbV8oAP6QOpVq8zsE6HZgUGd3UwDyXH5p
 3yA10AT3xHVsDcsNHsFYESUa2B01yPX/W2N4fNxkcEqh56IoCLj2RLu3/pW+GOFIHm9uhVd+nsI
 QtD0yNTZtnISGUNp1ZYSsWZdfvdf1NIxBIwKAIYCzrQ1u8LtCWNCdFtJlqnfvn4+fv/CZC5e/+1
 9hhz30XnRrSO0aTHAY6xAqONqF9ag5IN89Yjn+GyUjHVMpTaYasYZIywRI8cs=
X-Received: by 2002:a05:600c:c4a2:b0:495:3c6f:7c18 with SMTP id
 5b1f17b1804b1-495742c7395mr192765e9.3.1784753016886; 
 Wed, 22 Jul 2026 13:43:36 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b4e8885sm60775195e9.0.2026.07.22.13.43.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 13:43:34 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:43:05 +0200
Subject: [PATCH RFC v2 3/5] fastboot: make shared configuration checks
 phase-aware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-ccaione-upstream-spl-fastboot-v2-3-2ba3f71c42bc@baylibre.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Heiko Schocher <hs@nabladev.com>, Carlo Caione <ccaione@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784753017; x=1785357817;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFYxhASPGhd605Mkxfqt4uWeH61tmXqOWZIs574sJqs=;
 b=jbp6RX2juT0NU7wGjAAfOe19sMKi78tLOqZ/ReV3+ZKze38JVsBy42MrA51g+Lyhcl
 fe7giy27vdeGm1OCmIvd5IUKBrgfYkPoqB10RycBXtpWO0jmFH3hSbJf2QNMxDVZCTjt
 KAkykoTk/8QotGuaxP13cpxeOvo2eQ1Jyvm/DpYs2o91RLnH5zvCN0dyc1Xs0YQB3UuW
 WdeRWSauyUv8AXmPW2l8aJc90VEAr34zumSpg54tKae8Q5+QkRUS9NzwkUWknUz0bb+I
 61CwpwwFPfTCPpSFrS9pPWofbSuGC2MdG/Q2PrXRi4Ev+iSAKPLC+y9ur+7xQPGrvqZj
 jliw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=jbp6RX2j
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Carlo Caione via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Carlo Caione <ccaione@baylibre.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Fastboot currently builds only for U-Boot proper, so its source and
Makefile rules test CONFIG_FASTBOOT_* directly. The same checks would
select U-Boot-proper options when these files are compiled for another
phase, potentially compiling unavailable backends or using the wrong
configuration values.

Use CONFIG_IS_ENABLED(), CONFIG_VAL() and CONFIG_$(PHASE_) consistently
for code and object selection. The empty phase prefix preserves the
existing U-Boot-proper configuration and behavior while making the
shared implementation safe to reuse from SPL.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 drivers/Makefile              |  2 +-
 drivers/fastboot/Makefile     |  8 ++++----
 drivers/fastboot/fb_block.c   |  9 ++++-----
 drivers/fastboot/fb_command.c | 31 +++++++++++++++++--------------
 drivers/fastboot/fb_common.c  |  4 ++--
 drivers/fastboot/fb_getvar.c  | 14 +++++++-------
 drivers/fastboot/fb_mmc.c     | 36 ++++++++++++++++++------------------
 7 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 43d0ba33281..43d03479146 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_$(PHASE_)DMA) += dma/
 obj-$(CONFIG_$(PHASE_)DMA_LEGACY) += dma/
 obj-$(CONFIG_$(PHASE_)DFU) += dfu/
 obj-$(CONFIG_$(PHASE_)EXTCON) += extcon/
+obj-$(CONFIG_$(PHASE_)FASTBOOT) += fastboot/
 obj-$(CONFIG_$(PHASE_)GPIO) += gpio/
 obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
@@ -93,7 +94,6 @@ obj-y += block/
 obj-y += cache/
 obj-$(CONFIG_CPU) += cpu/
 obj-y += crypto/
-obj-$(CONFIG_FASTBOOT) += fastboot/
 obj-$(CONFIG_FWU_MDATA) += fwu-mdata/
 obj-y += misc/
 obj-$(CONFIG_MMC) += mmc/
diff --git a/drivers/fastboot/Makefile b/drivers/fastboot/Makefile
index 32e8e072c88..12008ac05e2 100644
--- a/drivers/fastboot/Makefile
+++ b/drivers/fastboot/Makefile
@@ -4,8 +4,8 @@ obj-y += fb_common.o
 obj-y += fb_getvar.o
 obj-y += fb_command.o
 obj-$(CONFIG_USB_FUNCTION_FASTBOOT) += fb_usb.o
-obj-$(CONFIG_FASTBOOT_FLASH_BLOCK) += fb_block.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_BLOCK) += fb_block.o
 # MMC reuses block implementation
-obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
-obj-$(CONFIG_FASTBOOT_FLASH_NAND) += fb_nand.o
-obj-$(CONFIG_FASTBOOT_FLASH_SPI) += fb_spi_flash.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_MMC) += fb_block.o fb_mmc.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_NAND) += fb_nand.o
+obj-$(CONFIG_$(PHASE_)FASTBOOT_FLASH_SPI) += fb_spi_flash.o
diff --git a/drivers/fastboot/fb_block.c b/drivers/fastboot/fb_block.c
index 51d1abb18c7..9658b14e668 100644
--- a/drivers/fastboot/fb_block.c
+++ b/drivers/fastboot/fb_block.c
@@ -130,11 +130,10 @@ int fastboot_block_get_part_info(const char *part_name,
 				 char *response)
 {
 	int ret;
-	const char *interface = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-						   CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME,
-						   NULL);
-	const int device = config_opt_enabled(CONFIG_FASTBOOT_FLASH_BLOCK,
-					      CONFIG_FASTBOOT_FLASH_BLOCK_DEVICE_ID, -1);
+	const char *interface = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+		(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME)), (NULL));
+	const int device = CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK,
+		(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_DEVICE_ID)), (-1));
 
 	if (!part_name || !strcmp(part_name, "")) {
 		fastboot_fail("partition not given", response);
diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
index 18d86988f4c..111516fd1b3 100644
--- a/drivers/fastboot/fb_command.c
+++ b/drivers/fastboot/fb_command.c
@@ -339,19 +339,19 @@ void fastboot_data_complete(char *response)
  */
 static void __maybe_unused flash(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_flash_write(cmd_parameter, fastboot_buf_addr,
 					   image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
 		fastboot_mmc_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
 		fastboot_nand_flash_write(cmd_parameter, fastboot_buf_addr,
 					  image_size, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_write(cmd_parameter, fastboot_buf_addr,
 					 image_size, response);
 }
@@ -367,16 +367,16 @@ static void __maybe_unused flash(char *cmd_parameter, char *response)
  */
 static void __maybe_unused erase(char *cmd_parameter, char *response)
 {
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK))
 		fastboot_block_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC))
 		fastboot_mmc_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND))
 		fastboot_nand_erase(cmd_parameter, response);
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI))
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI))
 		fastboot_spi_flash_erase(cmd_parameter, response);
 }
 
@@ -482,8 +482,9 @@ static void reboot_recovery(char *cmd_parameter, char *response)
 static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!env_get("partitions")) {
 		fastboot_fail("partitions not set", response);
@@ -505,8 +506,9 @@ static void __maybe_unused oem_format(char *cmd_parameter, char *response)
 static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
@@ -531,8 +533,9 @@ static void __maybe_unused oem_partconf(char *cmd_parameter, char *response)
 static void __maybe_unused oem_bootbus(char *cmd_parameter, char *response)
 {
 	char cmdbuf[32];
-	const int mmc_dev = config_opt_enabled(CONFIG_FASTBOOT_FLASH_MMC,
-					       CONFIG_FASTBOOT_FLASH_MMC_DEV, -1);
+	const int mmc_dev = CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC,
+					      (CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV)),
+					      (-1));
 
 	if (!cmd_parameter) {
 		fastboot_fail("Expected command parameter", response);
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 9c52e004588..3c0013490cc 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -234,8 +234,8 @@ void fastboot_set_progress_callback(void (*progress)(const char *msg))
  */
 void fastboot_init(void *buf_addr, u32 buf_size)
 {
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)
-	if (!strcmp(CONFIG_FASTBOOT_FLASH_BLOCK_INTERFACE_NAME, "mmc"))
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)
+	if (!strcmp(CONFIG_VAL(FASTBOOT_FLASH_BLOCK_INTERFACE_NAME), "mmc"))
 		printf("Warning: the fastboot block backend features are limited, consider using the MMC backend\n");
 #endif
 
diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
index e8aa0e09aa6..9e8e8889d08 100644
--- a/drivers/fastboot/fb_getvar.c
+++ b/drivers/fastboot/fb_getvar.c
@@ -70,19 +70,19 @@ static const struct {
 		.variable = "current-slot",
 		.dispatch = getvar_current_slot,
 		.list = true
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	}, {
 		.variable = "has-slot",
 		.dispatch = getvar_has_slot,
 		.list = false
 #endif
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)
 	}, {
 		.variable = "partition-type",
 		.dispatch = getvar_partition_type,
 		.list = false
 #endif
-#if IS_ENABLED(CONFIG_FASTBOOT_FLASH)
+#if CONFIG_IS_ENABLED(FASTBOOT_FLASH)
 	}, {
 		.variable = "partition-size",
 		.dispatch = getvar_partition_size,
@@ -116,21 +116,21 @@ static int getvar_get_part_info(const char *part_name, char *response,
 	struct disk_partition disk_part;
 	struct part_info *part_info;
 
-	if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_BLOCK)) {
+	if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_BLOCK)) {
 		r = fastboot_block_get_part_info(part_name, &dev_desc, &disk_part,
 						 response);
 		if (r >= 0 && size)
 			*size = disk_part.size * disk_part.blksz;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_MMC)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_MMC)) {
 		r = fastboot_mmc_get_part_info(part_name, &dev_desc, &disk_part,
 					       response);
 		if (r >= 0 && size)
 			*size = disk_part.size * disk_part.blksz;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_NAND)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_NAND)) {
 		r = fastboot_nand_get_part_info(part_name, &part_info, response);
 		if (r >= 0 && size)
 			*size = part_info->size;
-	} else if (IS_ENABLED(CONFIG_FASTBOOT_FLASH_SPI)) {
+	} else if (CONFIG_IS_ENABLED(FASTBOOT_FLASH_SPI)) {
 		r = fastboot_spi_flash_get_part_info(part_name, &disk_part,
 						     response);
 		if (r >= 0 && size)
diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
index 9bc782ccd02..ae33e35365b 100644
--- a/drivers/fastboot/fb_mmc.c
+++ b/drivers/fastboot/fb_mmc.c
@@ -75,7 +75,7 @@ static int do_get_part_info(struct blk_desc **dev_desc, const char *name,
 	int ret;
 
 	/* First try partition names on the default device */
-	*dev_desc = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	*dev_desc = blk_get_dev("mmc", CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 	if (*dev_desc) {
 		ret = part_get_info_by_name(*dev_desc, name, info);
 		if (ret >= 0)
@@ -111,7 +111,7 @@ static int part_get_info_by_name_or_alias(struct blk_desc **dev_desc,
 	return do_get_part_info(dev_desc, name, info);
 }
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
 static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 			    int hwpart, u32 buff_sz, char *response)
 {
@@ -130,7 +130,7 @@ static void fb_mmc_boot_ops(struct blk_desc *dev_desc, void *buffer,
 }
 #endif
 
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
+#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
 /**
  * Read Android boot image header from boot partition.
  *
@@ -346,7 +346,7 @@ int fastboot_mmc_get_part_info(const char *part_name,
 static struct blk_desc *fastboot_mmc_get_dev(char *response)
 {
 	struct blk_desc *ret = blk_get_dev("mmc",
-					   CONFIG_FASTBOOT_FLASH_MMC_DEV);
+					   CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 
 	if (!ret || ret->type == DEV_TYPE_UNKNOWN) {
 		pr_err("invalid mmc device\n");
@@ -370,15 +370,15 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	struct blk_desc *dev_desc;
 	struct disk_partition info = {0};
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, download_buffer, 1,
 					download_bytes, response);
 		return;
 	}
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, download_buffer, 2,
@@ -388,7 +388,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #endif
 
 #if CONFIG_IS_ENABLED(EFI_PARTITION)
-	if (strcmp(cmd, CONFIG_FASTBOOT_GPT_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_GPT_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -415,7 +415,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
-	if (strcmp(cmd, CONFIG_FASTBOOT_MBR_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MBR_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -440,7 +440,7 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	}
 #endif
 
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
+#if CONFIG_IS_ENABLED(ANDROID_BOOT_IMAGE)
 	if (strncasecmp(cmd, "zimage", 6) == 0) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
@@ -450,8 +450,8 @@ void fastboot_mmc_flash_write(const char *cmd, void *download_buffer,
 	}
 #endif
 
-#if IS_ENABLED(CONFIG_FASTBOOT_MMC_USER_SUPPORT)
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)
 			return;
@@ -485,17 +485,17 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 {
 	struct blk_desc *dev_desc;
 	struct disk_partition info;
-	struct mmc *mmc = find_mmc_device(CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	struct mmc *mmc = find_mmc_device(CONFIG_VAL(FASTBOOT_FLASH_MMC_DEV));
 
-#ifdef CONFIG_FASTBOOT_MMC_BOOT_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT1_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_BOOT_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT1_NAME))) {
 		/* erase EMMC boot1 */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
 			fb_mmc_boot_ops(dev_desc, NULL, 1, 0, response);
 		return;
 	}
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_BOOT2_NAME) == 0) {
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_BOOT2_NAME))) {
 		/* erase EMMC boot2 */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (dev_desc)
@@ -504,8 +504,8 @@ void fastboot_mmc_erase(const char *cmd, char *response)
 	}
 #endif
 
-#ifdef CONFIG_FASTBOOT_MMC_USER_SUPPORT
-	if (strcmp(cmd, CONFIG_FASTBOOT_MMC_USER_NAME) == 0) {
+#if CONFIG_IS_ENABLED(FASTBOOT_MMC_USER_SUPPORT)
+	if (!strcmp(cmd, CONFIG_VAL(FASTBOOT_MMC_USER_NAME))) {
 		/* erase EMMC userdata */
 		dev_desc = fastboot_mmc_get_dev(response);
 		if (!dev_desc)

-- 
2.55.0

