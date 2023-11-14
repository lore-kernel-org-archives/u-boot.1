Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA959C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 12:51:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE2C48715B;
	Tue, 14 Nov 2023 13:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Jh5H4PNK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8CA88744F; Tue, 14 Nov 2023 13:51:20 +0100 (CET)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com
 [IPv6:2a00:1450:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 347A98715B
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 13:51:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c83ffcdbe3so32391001fa.1
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 04:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699966276; x=1700571076; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FgutPZyknN1fJV78aYYJLHxvMt7B5/DQRdfoIyhs0Co=;
 b=Jh5H4PNK7w8lLIqcgOd2XcVRUpAW8BrL/BeNvBu44aqdpmEzO1r8NcI7L9USypwr+2
 s1PrvGySuYMzb0M1zFJ1W6p0ucKPtr4V7s7PDifewupPb+SKWZB8WhQqvF7eWRdzdeEy
 dPZ5p0/AjBXZGuWvge53g/cmM+7kUjZFlNEIQuR+kAlEOz6z47Jrf0zh7Imm/KrtBihe
 dKfAASFERcsdZ/TztgpOPx+9spss0lJl8kXXQBMVHtUet1VxYehtC2hgRzN6FGNEH1Xh
 sCotQza2mG+Kt5XLemO1X5ts5cNUQVnmp+jxPTp3bmrP75xFhSq6fWeaucChE711aw6o
 Y8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699966276; x=1700571076;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FgutPZyknN1fJV78aYYJLHxvMt7B5/DQRdfoIyhs0Co=;
 b=rKsgib09fCi4Pd2qtcU3/6WTVPP3e27+cCjO+xRCV9vb6NbgnZkFlLLklLh+Y51dh3
 sBN21RpyEvG5X7WjbKZ81hHto541UcJJDzM7553uiiLqY5x/BsTRpoJfms0Rbi8gElJL
 VauY5m9xlNXxOTuSIvMSWDHrBmCBTtIsk6nUYMQ2sRs1uv8L6LjY4UfdavLSaoRLjvAc
 +vdKW35M4C7UaIZg27OWWJMf7l8o+vmDkZJLyyVk47uaRdtNWOUXj3ojFyZeECQs9g+S
 ANSF3lPZ3Lj5r76bXnNs8aAq5cGf29NLbPALQYkCjdxkMlrCDYgH5ajUQ8OPnOVw03SO
 4cvg==
X-Gm-Message-State: AOJu0YzUAXw/xebuPkH0AdO5n3e8OAEW+SZYNW9EbkEOrKDMG0bxibn+
 6qVqC9XKQAZPju7Eg/kPBES5jQ==
X-Google-Smtp-Source: AGHT+IGE/8uY5/73mJuvvkfDZNLhKBxGwjm4akMAI52bEcw/U5qMB4lbFgz00PRWe1c1TR7xMdu4rw==
X-Received: by 2002:a2e:3a18:0:b0:2c5:4718:5d45 with SMTP id
 h24-20020a2e3a18000000b002c547185d45mr1673150lja.52.1699966276577; 
 Tue, 14 Nov 2023 04:51:16 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a7bcbc7000000b004064cd71aa8sm11263451wmi.34.2023.11.14.04.51.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 04:51:15 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 14 Nov 2023 12:51:11 +0000
Subject: [PATCH 1/2] serial: msm-geni: don't rely on parent misc device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-geni-uart-v1-1-48c8ba9dda36@linaro.org>
References: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
In-Reply-To: <20231114-b4-geni-uart-v1-0-48c8ba9dda36@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=xEIVdCWxBgWYRyP0mz0KJl0Xxx+I4F1TtFiSbarQTN0=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTgXKf13eIN9/j3ilx7kd/9rWX2kUOGGVKZ8xY96+7Ki
 hW4KdzaUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACaycwEjw/rE21ZW2tZL3IPa
 +vhPZpxZx3Xjv4+tnLvUXr8s/9UcvxgZWj5umh/B1JH898vs6MwT8j/4S0OPXlK0mtF9JnzPuvv
 NawE=
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

commit 1b15483deb3f ("misc: add Qualcomm GENI SE QUP device driver")
introduced support for platform-specific oversampling values, necessary
to configure the UART clocks on all platforms at runtime. However it
relies in probing a parent device. Despite the DM_FLAG_PRE_RELOC flag,
this is not done consistently during boot.

Instead, take another approach by relying on ofnode_ helpers to read the
serial engine base address and do the read directly. This fixes early
UART on boards with a non-default oversampling rate.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/misc/Kconfig             |  7 -------
 drivers/misc/Makefile            |  1 -
 drivers/misc/qcom-geni-se.c      | 41 ----------------------------------------
 drivers/serial/Kconfig           |  2 --
 drivers/serial/serial_msm_geni.c | 29 ++++++++++++++++++----------
 5 files changed, 19 insertions(+), 61 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 97057de8bf92..423cf22949aa 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -527,13 +527,6 @@ config WINBOND_W83627
 	  legacy UART or other devices in the Winbond Super IO chips
 	  on X86 platforms.
 
-config QCOM_GENI_SE
-	bool "Qualcomm GENI Serial Engine Driver"
-	depends on ARCH_SNAPDRAGON
-	help
-	  The driver manages Generic Interface (GENI) firmware based
-	  Qualcomm Technologies, Inc. Universal Peripheral (QUP) Wrapper.
-
 config QFW
 	bool
 	help
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b67b82358a6c..2d08181251c7 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,7 +60,6 @@ obj-$(CONFIG_NUVOTON_NCT6102D) += nuvoton_nct6102d.o
 obj-$(CONFIG_P2SB) += p2sb-uclass.o
 obj-$(CONFIG_PCA9551_LED) += pca9551_led.o
 obj-$(CONFIG_$(SPL_)PWRSEQ) += pwrseq-uclass.o
-obj-$(CONFIG_QCOM_GENI_SE) += qcom-geni-se.o
 ifdef CONFIG_QFW
 obj-y += qfw.o
 obj-$(CONFIG_QFW_PIO) += qfw_pio.o
diff --git a/drivers/misc/qcom-geni-se.c b/drivers/misc/qcom-geni-se.c
deleted file mode 100644
index 281a5ec819a9..000000000000
--- a/drivers/misc/qcom-geni-se.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Qualcomm Generic Interface (GENI) Serial Engine (SE) Wrapper
- *
- * Copyright (C) 2023 Linaro Ltd. <vladimir.zapolskiy@linaro.org>
- */
-
-#include <common.h>
-#include <dm.h>
-#include <misc.h>
-#include <asm/io.h>
-
-static int geni_se_qup_read(struct udevice *dev, int offset,
-			    void *buf, int size)
-{
-	fdt_addr_t base = dev_read_addr(dev);
-
-	if (size != sizeof(u32))
-		return -EINVAL;
-
-	*(u32 *)buf = readl(base + offset);
-
-	return size;
-}
-
-static struct misc_ops geni_se_qup_ops = {
-	.read = geni_se_qup_read,
-};
-
-static const struct udevice_id geni_se_qup_ids[] = {
-	{ .compatible = "qcom,geni-se-qup" },
-	{}
-};
-
-U_BOOT_DRIVER(geni_se_qup) = {
-	.name = "geni_se_qup",
-	.id = UCLASS_MISC,
-	.of_match = geni_se_qup_ids,
-	.ops = &geni_se_qup_ops,
-	.flags  = DM_FLAG_PRE_RELOC,
-};
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 9f0f84c9b426..81fdac047824 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -957,8 +957,6 @@ config MSM_SERIAL
 
 config MSM_GENI_SERIAL
 	bool "Qualcomm on-chip GENI UART"
-	select MISC
-	imply QCOM_GENI_SE
 	help
 	  Support UART based on Generic Interface (GENI) Serial Engine (SE),
 	  used on Qualcomm Snapdragon SoCs. Should support all qualcomm SOCs
diff --git a/drivers/serial/serial_msm_geni.c b/drivers/serial/serial_msm_geni.c
index 78fd9389c036..3e2e15b6cefe 100644
--- a/drivers/serial/serial_msm_geni.c
+++ b/drivers/serial/serial_msm_geni.c
@@ -486,12 +486,12 @@ static const struct dm_serial_ops msm_serial_ops = {
 	.setbrg = msm_serial_setbrg,
 };
 
-static void geni_set_oversampling(struct udevice *dev)
+static int geni_set_oversampling(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
-	struct udevice *parent_dev = dev_get_parent(dev);
+	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
 	u32 geni_se_version;
-	int ret;
+	fdt_addr_t addr;
 
 	priv->oversampling = UART_OVERSAMPLING;
 
@@ -499,16 +499,22 @@ static void geni_set_oversampling(struct udevice *dev)
 	 * It could happen that GENI SE IP is missing in the board's device
 	 * tree or GENI UART node is a direct child of SoC device tree node.
 	 */
-	if (device_get_uclass_id(parent_dev) != UCLASS_MISC)
-		return;
+	if (!ofnode_device_is_compatible(parent_node, "qcom,geni-se-qup")) {
+		pr_err("%s: UART node must be a child of geniqup node\n",
+		       __func__);
+		return -ENODEV;
+	}
 
-	ret = misc_read(parent_dev, QUP_HW_VER_REG,
-			&geni_se_version, sizeof(geni_se_version));
-	if (ret != sizeof(geni_se_version))
-		return;
+	/* Read the HW_VER register relative to the parents address space */
+	addr = ofnode_get_addr(parent_node);
+	geni_se_version = readl(addr + QUP_HW_VER_REG);
+
+	printf("geni_se_version: %x\n", geni_se_version);
 
 	if (geni_se_version >= QUP_SE_VERSION_2_5)
 		priv->oversampling /= 2;
+
+	return 0;
 }
 
 static inline void geni_serial_init(struct udevice *dev)
@@ -553,8 +559,11 @@ static inline void geni_serial_init(struct udevice *dev)
 static int msm_serial_probe(struct udevice *dev)
 {
 	struct msm_serial_data *priv = dev_get_priv(dev);
+	int ret;
 
-	geni_set_oversampling(dev);
+	ret = geni_set_oversampling(dev);
+	if (ret < 0)
+		return ret;
 
 	/* No need to reinitialize the UART after relocation */
 	if (gd->flags & GD_FLG_RELOC)

-- 
2.42.1

