Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496A0C4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 20:57:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1D987F6A;
	Thu, 15 Feb 2024 21:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s6RtT8zX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1D0B87F2B; Thu, 15 Feb 2024 21:53:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96E8E87EE6
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:52:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33aea66a31cso723625f8f.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030366; x=1708635166; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1PjmJHGrMmgNK96s1iE0Iwl3eykzqZhpYlgGqc4S8MA=;
 b=s6RtT8zXeqSx+nYf3N8YlIg2oBjHqqFd2IiX2AJH2SWee5s6qOlpkzDT7MiHmbFXLY
 OE4w0OkoTorgAqcvjaAkFTd5zzwXaBcNOZxLqPYkb5SPIJYc5uujR7jiXk+6wknww2h5
 wkXBlVgouhfIa3htGbp3F0s7hyQPJsmH+roRWnxyG0ecsdYSPA8mm1xVJhyFnsfEo5TR
 SjlVVAV0Zac/PqCDeJ4XA8x9riwDKNE6w3Va/7FXBfelWpUpnGy2kilsPJ9Dm2uDHtFr
 tci2pzlKHOU7krVcRkGm3mZVvbn219Nugigx7xiRAxvmlycMXbIMtZRwIXktnEk6hPl2
 4Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030366; x=1708635166;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PjmJHGrMmgNK96s1iE0Iwl3eykzqZhpYlgGqc4S8MA=;
 b=m3z66MsxqIig56piZvlQVEH9XWRmOdSwViTrUYSl4rKZMUgOQsUn/ONb9mvolOFvGg
 fyMH6FnNPsa960LDG/W/q7RdEPLcJlJ79H0MXdlTBJDbrtY/mPe8Yq4+qvPazvTqmrXe
 E5SGKTsR1M+mqkZHneSAsN+LIOA9DN0i/LrA0MQ0nzC5SUDTU/ThMujIGuN38zxWC7m3
 UR/uyujldlPzUH8n41rHDnlfp1pQJfdaRw4loNNRsF8yRftV+I27tR8Br1OPDiGJ3v25
 T/fUjqrgk3Tp7UNFPHdLewCMZNBdB3trybNw7BIyYQXa3rncQzHCWtGoHNiHKTGtYvco
 0fhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkbvmL+FHM8SQAgOfs7KX2BxVsEMYozKDDCmOwk+vsvTCGv/Yj5wUdUK7AUX4Uuh9vbMlGJfsd4JF5Lo+dRhzCLmEtRQ==
X-Gm-Message-State: AOJu0Yz9ciJDjsWrKZo/0vSaiFNPDQgNDjTWTnpFGAEWtPDf4Pq5eD2g
 R5+IFGx7k1+xLSB/MVqRRtjswdxLNQJPjX9sD/CLDuB1JJrbzKShiUBT2dBKZuWGosoucO2Lvp1
 V
X-Google-Smtp-Source: AGHT+IFigFIXAAYqeOk/hVkrBB/4wAtPk5ilhUmp6wF/hrjrPzzau+kQNux7M3MX2nNuiaz/XEQTLQ==
X-Received: by 2002:a5d:5348:0:b0:33b:74a3:dcfb with SMTP id
 t8-20020a5d5348000000b0033b74a3dcfbmr1888014wrv.1.1708030365826; 
 Thu, 15 Feb 2024 12:52:45 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:52:45 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:39 +0000
Subject: [PATCH v4 21/39] mach-snapdragon: dynamic load addresses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-21-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=WZF6iVYHmUW3FOBpBMLvxOHqM6h6OgAwaa5OH4FQNYc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzlW1KF5x2MFWd3jq9Wdd9kqDPqvr1sdMWthxe5zA55
 On3CSLRHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAi5h0Mf8X0XrdOWaJ+xNI7
 MXOft/upDc+nt984EWzZL97jsDd3cgAjw67azhsTV/+t4fhzRUJ4tk/blcg1OiXCyaqxQqvcT7y
 YaQgA
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

Heavily inspired by Apple board code. Use the LMB allocator to configure
load addresses at runtime, and implement a lookup table for selecting a
devicetree.

As some Qualcomm RBx boards have different RAM capacities and base
addresses, it isn't possible to hardcode these regions.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/Kconfig                                 |  1 +
 arch/arm/mach-snapdragon/board.c                 | 34 ++++++++++++++++++++++++
 board/qualcomm/dragonboard410c/dragonboard410c.c |  2 +-
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 672577d0ddcc..0dba77f86b49 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1095,6 +1095,7 @@ config ARCH_SNAPDRAGON
 	select OF_SEPARATE
 	select SMEM
 	select SPMI
+	select BOARD_LATE_INIT
 	select OF_BOARD
 	select SAVE_PREV_BL_FDT_ADDR
 	select LINUX_KERNEL_IMAGE_HEADER
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index a1867852bcca..f445bed3af00 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -22,6 +22,7 @@
 #include <linux/bug.h>
 #include <linux/psci.h>
 #include <linux/sizes.h>
+#include <lmb.h>
 #include <malloc.h>
 #include <usb.h>
 
@@ -159,6 +160,39 @@ int board_init(void)
 	return 0;
 }
 
+void __weak qcom_late_init(void)
+{
+}
+
+#define KERNEL_COMP_SIZE	SZ_64M
+
+#define addr_alloc(lmb, size) lmb_alloc(lmb, size, SZ_2M)
+
+/* Stolen from arch/arm/mach-apple/board.c */
+int board_late_init(void)
+{
+	struct lmb lmb;
+	u32 status = 0;
+
+	lmb_init_and_reserve(&lmb, gd->bd, (void *)gd->fdt_blob);
+
+	/* We need to be fairly conservative here as we support boards with just 1G of TOTAL RAM */
+	status |= env_set_hex("kernel_addr_r", addr_alloc(&lmb, SZ_128M));
+	status |= env_set_hex("ramdisk_addr_r", addr_alloc(&lmb, SZ_128M));
+	status |= env_set_hex("kernel_comp_addr_r", addr_alloc(&lmb, KERNEL_COMP_SIZE));
+	status |= env_set_hex("kernel_comp_size", KERNEL_COMP_SIZE);
+	status |= env_set_hex("scriptaddr", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("pxefile_addr_r", addr_alloc(&lmb, SZ_4M));
+	status |= env_set_hex("fdt_addr_r", addr_alloc(&lmb, SZ_2M));
+
+	if (status)
+		log_warning("%s: Failed to set run time variables\n", __func__);
+
+	qcom_late_init();
+
+	return 0;
+}
+
 static void build_mem_map(void)
 {
 	int i;
diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.c b/board/qualcomm/dragonboard410c/dragonboard410c.c
index 0136cc2237de..fbbfc0e65e24 100644
--- a/board/qualcomm/dragonboard410c/dragonboard410c.c
+++ b/board/qualcomm/dragonboard410c/dragonboard410c.c
@@ -88,7 +88,7 @@ int misc_init_r(void)
 	return 0;
 }
 
-int board_late_init(void)
+int qcom_late_init(void)
 {
 	char serial[16];
 

-- 
2.43.1

