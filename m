Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50F27C54E41
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 18:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6859B87DE6;
	Wed,  6 Mar 2024 19:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="QcaO8Xpd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1DF38792D; Wed,  6 Mar 2024 19:59:39 +0100 (CET)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com
 [IPv6:2a00:1450:4864:20::649])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E9FA87C0A
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 19:59:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3Er3oZQkKBmUGLPRULQQbJRRJOH.FRPX-ERRWOLVWV.GHQa.GH@flex--dimorinny.bounces.google.com
Received: by mail-ej1-x649.google.com with SMTP id
 a640c23a62f3a-a4531df8727so3737166b.2
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 10:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709751571; x=1710356371; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=IkJBlRHr1MnBJ8BFY/COQb8zlbQgTu1+SK+kF9BShbo=;
 b=QcaO8Xpdwez2Z7me9i/eUrrJQxhiMejNSTU4r8QnOAhs8zDhL2NCpAMeJ2OA5v2vFx
 mjHn8gB/beomfbuDoNtui3meniFjOwefm+s7FaTm94lotAzX74FQWCECrxkC5G+UYtTH
 ZdURIiFgdEcgelSpqe1aJfSNUQQJ3nWrbItewBFQ9/FhjsWVEPmTcnSJfbmwTNMLmJT2
 wvH/iRa4AzE3k+tIIOiMnkj/2d5aIRz5K4r6vOAkUoDMy0sb3U9U+PBfuxOraMCtZjiS
 32oarRxpLhoOmtYr5qvWZOhfjzho4FhoLhqM5fmhUx5p+sKjqsLEOt0vp1DNIn7NTySm
 OoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709751571; x=1710356371;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IkJBlRHr1MnBJ8BFY/COQb8zlbQgTu1+SK+kF9BShbo=;
 b=WD1MbUiu079TDnx5YHflY5o96YzPEDDfgHtK82u2CNosMvIbpuwC1Xj39VPrWhuyxf
 ztG7xUSMDWV3AoO5CJpCxYkfFke4LmW+1IeQvyjZ2Z44DBDyJi0mostZnUB19oVzYfGx
 vuqPVIgaLXG9n2I4uXs2gnq69drakQp/l/nAfu54MYpHOFOicwLSh8WCEMuAaWY1hmHC
 fGav5mOFWzKcvOelyBvplM/myRR11mqU0Xd5eHkVnWmFxu5NQET2ZktuwfMVIFd7LUAK
 giTOPkuUvrj+YDcEed7LM9ZEjuf3Pol0bQDon7QwNgxOHPmS/8V+NptsKuwftxm1Nh7a
 vvbg==
X-Gm-Message-State: AOJu0Yw+qsUIZIdbm7GjE3WXSs9TqcDQYayVYi7iDMexhymU3DxdbNRw
 C6sgNZ4XsHBXxfDwCa4WO5ViyVULBJp8asqV0/i3CKAY57X8h1L2CzcOL+Mzict01jYkB96LgRF
 y2PjXzNj8BXptKqt001Tf1hz89foAtdZ2yV48/HXSbijl4JDfraFYd+0e9ZxmYSLMmUA7J2Y7gJ
 x3iuMWVvMVtCYBXEXxzq1fwDSTs9CepV7oeR9aU8SES8xXZw==
X-Google-Smtp-Source: AGHT+IE07GdR+B/oq34H4obqdjlJkegH3KW0wqAnBohFm/9HCX/dzrQH3TsEs2bxX3cw/05+81OkdVrIdCY4vT4=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:bf09:8cbc:464b:6c87])
 (user=dimorinny job=sendgmr) by 2002:a17:906:6a0c:b0:a3f:be13:e2c8 with SMTP
 id qw12-20020a1709066a0c00b00a3fbe13e2c8mr49409ejc.11.1709751570604; Wed, 06
 Mar 2024 10:59:30 -0800 (PST)
Date: Wed,  6 Mar 2024 18:59:19 +0000
In-Reply-To: <20240306185921.1854109-1-dimorinny@google.com>
Mime-Version: 1.0
References: <20240306185921.1854109-1-dimorinny@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306185921.1854109-2-dimorinny@google.com>
Subject: [PATCH 2/4] fastboot: blk: add block device flashing configuration
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
---
 drivers/fastboot/Kconfig | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 5e5855a76c..460c5e98d7 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
 config FASTBOOT_FLASH
 	bool "Enable FASTBOOT FLASH command"
 	default y if ARCH_SUNXI || ARCH_ROCKCHIP
-	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
+	depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
 	select IMAGE_SPARSE
 	help
 	  The fastboot protocol includes a "flash" command for writing
@@ -109,12 +109,16 @@ choice
 
 config FASTBOOT_FLASH_MMC
 	bool "FASTBOOT on MMC"
-	depends on MMC
+	depends on MMC && BLK
 
 config FASTBOOT_FLASH_NAND
 	bool "FASTBOOT on NAND"
 	depends on MTD_RAW_NAND && CMD_MTDPARTS
 
+config FASTBOOT_FLASH_BLOCK
+	bool "FASTBOOT on block device"
+	depends on BLK
+
 endchoice
 
 config FASTBOOT_FLASH_MMC_DEV
@@ -189,6 +193,18 @@ config FASTBOOT_MMC_USER_NAME
 	  defined here.
 	  The default target name for erasing EMMC_USER is "mmc0".
 
+config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
+	string "Define FASTBOOT block interface name"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  "Fastboot block interface name (mmc, virtio, etc)"
+
+config FASTBOOT_FLASH_BLOCK_DEVICE_ID
+	int "Define FASTBOOT block device id"
+	depends on FASTBOOT_FLASH_BLOCK
+	help
+	  "Fastboot block device id"
+
 config FASTBOOT_GPT_NAME
 	string "Target name for updating GPT"
 	depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
-- 
2.44.0.278.ge034bb2e1d-goog

