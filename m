Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4830C55167
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 08:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 054F280FBC;
	Fri, 31 Jul 2026 08:30:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BTpNzdo9A-L1; Fri, 31 Jul 2026 08:30:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 41B9D80FEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785486606;
	bh=JFYxhASPGhd605Mkxfqt4uWeH61tmXqOWZIs574sJqs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MWrHUzV03fm0VHPjvorl8TGPcF9dF6cG4SM9riDAG9sk2iig1+wmyrZ2wC+rrEMcJ
	 DDibRjgr959VAX/izJWVI7WAUma4hxKPj2nKT/J5+FkHEclTJ067ehnBlZuqMiazEO
	 QYEVcDYQYkizdutDdQZrLoWQVVVlFg7sE6OLJJrs/q6vARjKNOMsyS7wIcQrp2uTS4
	 /tkTddV32Us9sRIl2ub4yAWyVa/Cu0xI/bT/n3j7zDsCM7VrFYZ5jpbCUn+FGYMVbI
	 msKNFG9aDYRGErMCFiZZ3aDi0Plp9jPm7ncRM8p9Xd/AVKFR0awUQKRhiQo1U8ozWk
	 s/1fyXGMXtfqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 41B9D80FEF;
	Fri, 31 Jul 2026 08:30:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 66D412E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B0CA80FB0
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CjNJPZbLTvOP for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 08:30:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9984F80DEF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9984F80DEF
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9984F80DEF
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 08:30:01 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-69c1220bd51so1108898a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785486599; x=1786091399;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JFYxhASPGhd605Mkxfqt4uWeH61tmXqOWZIs574sJqs=;
 b=csSfauUZnwW1WNvMSADOzdn4U7CHymvwcrQnaF88Ag0lAWUJ3Js5sIVvv5PFKU/OMC
 LsPUDrdsZnoYVRkpk7/DJ56Dtn9Hlrcgvxje9bazA5lJjuJjOq6wPSAynkJaAYpWmbPw
 phWpopg2dmeNoj69yIEL4G+nvsDk48ydtzIWFU52vuB7NPkVO/SIJP0xptsCJE2W8iU9
 ENcvDpg4ZEhAtwPIuNyHQgk7QBuulOTTBpu/n56WMDjBJT+f/wVY+DAknSaQEfgYlv3X
 6FeE5wy4gzZq2CWov6YmXbYet0nXg3jZYCSjnE6qtPEy9yDDT5qEwbiBeVmtiW9iD4fi
 MSPA==
X-Gm-Message-State: AOJu0Ywr2LDV5iKTnoblH0+LoUmlVYSI36r5SF0CP3ze2i8uFYmafc4V
 TbrQZEo/q+oBmfqX/EadjDskZPhjP3QhTjqOn1bHROgLlupdwYG6W4P07S4T2o1XQZA=
X-Gm-Gg: AR+sD11UwTF9Ea9WrXtcFPk49qJds8ioIy9fpIZm+TDkBPa9TeKy1VKJIVEkUIg1FcM
 eGNNHkYvEXTEuXL0Wf8UCYvWVTo7ezTnojQr3JLxsAAq+qB5KzT/ypi/kl/otJAsKnxS/xOpUG2
 WIBOkBOAAqAlG8lLeTKhcmkJKUKp7Pfo6UdcMwTGjBbBnKsBGGz9e5Ecm+PKqF0Wjs2GT5+Vqj8
 M6POYnFiKKVIfyXXNAck32oecRsW8dGKk6DYJaLLCPz8tDn7+AIv+fCYBOxAAHNjL031mlpKewH
 5juSigEzHVp/gbDSJxT6Pv3Mn8KGPAnvRWM0F1PUORL2r8bf8jQnNXmxZ/XC5p1/2RWEs0l1t1h
 X8+4h6BnVC30xgJ9NmauRJRpjTMsYwOIJVLzdVC+KZJOPwvfSMHUVzyXQdhjl97WEa8o6WnhKON
 C98TVLUAOKS7JY8PkiGCFYZyIdEQHfT8HHZ/9xbsmkokcgQD0VDulw7MRGRBs9s/VKnBKNw9W/P
 ojG05QMtziwqEZEFIKDNyJY3QNNBWifWhRrVUJI5PVJPsKNx7t+WH/f21M86kPob4XDlSdUBgeE
 7LU1ct7dc84=
X-Received: by 2002:a05:6402:458b:b0:69f:e12c:bd43 with SMTP id
 4fb4d7f45d1cf-6a098cacdc3mr487163a12.12.1785486599377; 
 Fri, 31 Jul 2026 01:29:59 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-212-171-227-71.pool212171.interbusiness.it. [212.171.227.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a09c661641sm583646a12.29.2026.07.31.01.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 01:29:58 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Fri, 31 Jul 2026 10:29:39 +0200
Subject: [PATCH RFC v3 3/5] fastboot: make shared configuration checks
 phase-aware
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-ccaione-upstream-spl-fastboot-v3-3-dbea3ff4529e@baylibre.com>
References: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
In-Reply-To: <20260731-ccaione-upstream-spl-fastboot-v3-0-dbea3ff4529e@baylibre.com>
To: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Suhrid Subramaniam <Suhrid.Subramaniam@mediatek.com>, 
 =?utf-8?q?Macpaul_Lin_=28=E6=9E=97=E6=99=BA=E6=96=8C=29?=
 <Macpaul.Lin@mediatek.com>, 
 =?utf-8?q?Pablo_Sun_=28=E5=AD=AB=E6=AF=93=E7=BF=94=29?=
 <pablo.sun@mediatek.com>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sam Day <me@samcday.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Carlo Caione <ccaione@baylibre.com>, David Lechner <dlechner@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, Lukasz Majewski <lukma@denx.de>, 
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Julien Masson <jmasson@baylibre.com>, Alexey Charkov <alchark@gmail.com>, 
 Adrian Freihofer <adrian.freihofer@siemens.com>, 
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785486599; x=1786091399;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JFYxhASPGhd605Mkxfqt4uWeH61tmXqOWZIs574sJqs=;
 b=QWbIElobULkSXwGNF8EEkc27jHkYTT52TjFkniCiwdVTHMjgdyN8WEKf016w3AYxpa
 14VJ4IBmXVFkMjJyC+Ca2OPttc3sT1zu1Bbwcy4azawHUG0kJWpB8362dLj6+QA1Oa9d
 OnKFG5Xbuh2dlY288NFCZfOWOdIiG36h8KZsNiD11Ea2NxhgUQXuL2mFSpPP84XKKn2X
 xCJh6HWfPw7LqVaZlu0oGHiI2x8h/AHLQJXtNNn1NSSaOskfLRiGoyLyNE5afzAGrvNO
 FXjAfBjD450j9xo+zj55jrzmEMH3lLVOYiu3vclG0kjhftzFXRFD6GqB5/ofSJqYnEh8
 dF9g==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=QWbIElob
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

