Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6025CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:51:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA35386BCF;
	Sun, 15 Oct 2023 09:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iyAJ1qip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77397868AE; Sun, 15 Oct 2023 09:46:09 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CE8D86DBC
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:45:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7c7262d5eso43468507b3.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697355913; x=1697960713; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ph7EN84Xi+7wGxIOgJl2wvIovJRgHyXxBa2qmaUdCbs=;
 b=iyAJ1qipSazBnHKLT2/Kj2mEFuQERMpywYGREn6MU5xMt860Z+Bz2cQ69xjwQlW7u8
 Y93kVqIujYsLJLr358p6Ejq7u03M79qnnP8/++kQLhs4DEPcefnD1lTEWUN56/0LVAD2
 8Q7nBZ3lfbr+s5NZ/ezquR30QEGktQadxu3EFoZy6miJeFhXTpwl4gYNE+Ff3/7vdzkq
 Mk9sddeYmwugbr+eIentkZaye0aGT1k5YkWNf0BC31wDiVEYWOliAKh626NgEH/eztni
 2y4/SM4U6LnT9uPtG1a/Cw4QSiMlSEe9LLwzkCiU1+iAyRCmOkUq0s2dhyxkFqieVuH0
 qPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697355913; x=1697960713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ph7EN84Xi+7wGxIOgJl2wvIovJRgHyXxBa2qmaUdCbs=;
 b=ODCg44//vhDdgOU2gdPIgapka5CiO53iPDtz8PJZ0Dc8EJRIQfcmL/80aC870iXsgx
 5hQ0OF7vwTCsVf/6gvjcaCDpPQs5Kn1B8j0oVNpxcMENk3TwuzjlBZAeMBmkBArDrEn0
 LAZoa6iUJZ3S6Ezsm/PeW3sK+0j2PewWK+nHKM5/e/ahN/QU7cVdmyPi1KxDsBDgESyG
 y42moMVOgwy+pTBVa4npHWRmcaTxJUHXoRPvarZssAWqh4K+frfWgXEFajKu9otxewPz
 24SYIR/0ViduYxg9AOuBG9byRR0LiHzPqGqMNarI/A+O2oJ4/JEtwHb/Tj2aggyp7e7N
 kxGQ==
X-Gm-Message-State: AOJu0YzVybyJu+rmOWrza5zEpBzfq00pxLLIfGmzAVusEae5lHkMmK94
 X/eknH7OetXLPYtF9im0zXtzfSLn6nA95g==
X-Google-Smtp-Source: AGHT+IHUof/Z+dmOX1IQu/ALmhDvZBJMLzBPAkiGl0/Hpo5dQ+aB1cVOoeByfHn4XnuqObGanPt3tQ==
X-Received: by 2002:ac8:4e8a:0:b0:417:9075:3364 with SMTP id
 10-20020ac84e8a000000b0041790753364mr38041843qtp.6.1697316498639; 
 Sat, 14 Oct 2023 13:48:18 -0700 (PDT)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 m4-20020ac866c4000000b0041b12c06bcfsm1739559qtp.40.2023.10.14.13.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Oct 2023 13:48:18 -0700 (PDT)
From: Sean Anderson <seanga2@gmail.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <seanga2@gmail.com>, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2 09/29] Move i.MX8 container image loading support to
 common/spl
Date: Sat, 14 Oct 2023 16:47:45 -0400
Message-Id: <20231014204805.439009-10-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231014204805.439009-1-seanga2@gmail.com>
References: <20231014204805.439009-1-seanga2@gmail.com>
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

(no changes since v1)

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

