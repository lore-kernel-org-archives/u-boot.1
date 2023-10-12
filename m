Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08765CDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:31:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBD6686EBB;
	Thu, 12 Oct 2023 04:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C9V6yvAG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A4D286ED5; Thu, 12 Oct 2023 03:59:51 +0200 (CEST)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5759886E40
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 03:57:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7741c2e76a3so28478285a.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697075798; x=1697680598; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaEy5PGOWXgr4E8RR7zVU64g143y+yhbPqBmwcYb+lo=;
 b=C9V6yvAG/ur+oR74pdrEtmTN45RT+8EBNVfHQQKaEiNBH+h2TijtsNILzZoGjmU57Z
 L1uHHr4DCg/W70fFUuv9y3oUc1JnMnngiqTT7wKp2H66bNWezsI+ChvIpvgqKM9E1t9l
 L9krIHKSVI7u5ahVL0XdSiijSHmQCZF+yk6Wr0avPje3sTAllZgmqzph5UPvQ6NLJ17V
 8jYQifsNkV0oajpnmMiy+NqD4h0YvDY6hk+5shQz15xnriEyfZJeBu/Cbf/S6LqyT5Fc
 OLjgoaxB+jr+FwoUfyhvEq7wiIrNT5I2bk0d806E7MQ4sgUAEdBNFftzY+fQVlOcVQgi
 STkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697075798; x=1697680598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaEy5PGOWXgr4E8RR7zVU64g143y+yhbPqBmwcYb+lo=;
 b=uAFyQNZQ9DP/R0pxCF20nDvYbB0HWsQY7iA/1nNY5IY2EJQaJ30aZEvBd7KgcDaUCY
 0r3/yUOYlzNSoxhlCr0lSsofKCUAOJEc0l1NqILRMTtVfbTnJqDKvIGlsQdL+K6nE/vs
 2hA8n4XtvmHaU/b6Hr4WF5SF1spWifOFBA85J0s/HLkBzDeDWhkjaT1dJ4bj28V38KIL
 W8xGKwKj1ITRETUkobKbyMDj2LZmuNnwHPMkgYx82jl8Xrud0PYpBqo1AdrEMqvipwqj
 yra3T74/N4rK7wCoxTRAEEV2baTE9w0JYjm+Akcrey/kscWMfb0a2zXcxBi9a6M+vV7g
 3JxQ==
X-Gm-Message-State: AOJu0YzI1Elm+9ETOkGkGKWkY4VeExWf9jZf+DRbubT0MWA5uoNIdleF
 TodsXdAhiJtyK0Wp4g/zIBYielspXyRfew==
X-Google-Smtp-Source: AGHT+IF9F8mir8Nv8T7iulfYwpSpmYeXm/UardbiGgyjVgev4oF/NqXM+3wHQ2UKw591HE2cvzmAvA==
X-Received: by 2002:a05:620a:450b:b0:777:326d:83de with SMTP id
 t11-20020a05620a450b00b00777326d83demr4965878qkp.56.1697075798193; 
 Wed, 11 Oct 2023 18:56:38 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 i10-20020a37c20a000000b0077589913a8bsm5586435qkm.132.2023.10.11.18.56.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 18:56:37 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>,
 uboot-imx@nxp.com, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 08/26] Move i.MX8 container image loading support to common/spl
Date: Wed, 11 Oct 2023 21:56:08 -0400
Message-Id: <20231012015626.3487451-9-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231012015626.3487451-1-seanga2@gmail.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
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

To facilitate testing loading i.MX8 container images, move the
parse-container code to common/spl.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 MAINTAINERS                                        |  1 +
 arch/arm/mach-imx/Kconfig                          | 13 -------------
 arch/arm/mach-imx/Makefile                         |  2 +-
 common/spl/Kconfig                                 | 14 ++++++++++++++
 common/spl/Makefile                                |  1 +
 .../spl/spl_imx_container.c                        |  0
 6 files changed, 17 insertions(+), 14 deletions(-)
 rename arch/arm/mach-imx/parse-container.c => common/spl/spl_imx_container.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 35209e73af5..dd6bb558dc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -299,6 +299,7 @@ F:	arch/arm/include/asm/arch-vf610/
 F:	arch/arm/include/asm/mach-imx/
 F:	board/freescale/*mx*/
 F:	board/freescale/common/
+F:	common/spl/spl_imx_container.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 266bb20df9d..08ab7069187 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -194,19 +194,6 @@ config IMX_DCD_ADDR
 	  This information is shared with the user via mkimage -l just so the
 	  image can be signed.
 
-config SPL_LOAD_IMX_CONTAINER
-	bool "Enable SPL loading U-Boot as a i.MX Container image"
-	depends on SPL
-	help
-	  This is to let SPL could load i.MX Container image
-
-config IMX_CONTAINER_CFG
-	string "i.MX Container config file"
-	depends on SPL
-	help
-	  This is to specific the cfg file for generating container
-	  image which will be loaded by SPL.
-
 config IOMUX_LPSR
 	bool
 
diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index aebfa6517bd..7c4e03278e3 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -79,7 +79,7 @@ obj-$(CONFIG_CMD_NANDBCB) += cmd_nandbcb.o
 endif
 
 ifeq ($(CONFIG_SPL_BUILD),y)
-obj-$(CONFIG_SPL_LOAD_IMX_CONTAINER) += image-container.o parse-container.o
+obj-$(CONFIG_SPL_LOAD_IMX_CONTAINER) += image-container.o
 endif
 
 ifeq ($(SOC),$(filter $(SOC),imx8ulp imx9))
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index 46323597942..ad574a600e3 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -330,6 +330,20 @@ config SPL_LEGACY_IMAGE_CRC_CHECK
 	  If disabled, Legacy images are booted if the image magic and size
 	  are correct, without further integrity checks.
 
+config SPL_LOAD_IMX_CONTAINER
+	bool "Enable SPL loading and booting of i.MX8 Containers"
+	depends on SPL
+	help
+	  Support booting U-Boot from an i.MX8 container image. If you are not
+	  using i.MX8, say 'n'.
+
+config IMX_CONTAINER_CFG
+	string "i.MX8 Container config file"
+	depends on SPL && SPL_LOAD_IMX_CONTAINER
+	help
+	  Specify the cfg file for generating the container image which will be
+	  loaded by SPL.
+
 config SPL_SYS_MALLOC_SIMPLE
 	bool "Only use malloc_simple functions in the SPL"
 	help
diff --git a/common/spl/Makefile b/common/spl/Makefile
index bad2bbf6cf1..4f8eb2ec0ca 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_$(SPL_TPL_)OPENSBI) += spl_opensbi.o
 obj-$(CONFIG_$(SPL_TPL_)USB_STORAGE) += spl_usb.o
 obj-$(CONFIG_$(SPL_TPL_)FS_FAT) += spl_fat.o
 obj-$(CONFIG_$(SPL_TPL_)FS_EXT4) += spl_ext.o
+obj-$(CONFIG_$(SPL_TPL_)LOAD_IMX_CONTAINER) += spl_imx_container.o
 obj-$(CONFIG_$(SPL_TPL_)SATA) += spl_sata.o
 obj-$(CONFIG_$(SPL_TPL_)NVME) += spl_nvme.o
 obj-$(CONFIG_$(SPL_TPL_)SEMIHOSTING) += spl_semihosting.o
diff --git a/arch/arm/mach-imx/parse-container.c b/common/spl/spl_imx_container.c
similarity index 100%
rename from arch/arm/mach-imx/parse-container.c
rename to common/spl/spl_imx_container.c
-- 
2.37.1

