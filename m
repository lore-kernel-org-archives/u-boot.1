Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B99D1039C
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 02:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675EB88FCB;
	Fri, 25 Oct 2024 04:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D0kULvAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DC6188B0C; Fri, 25 Oct 2024 04:02:40 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE4E88F83
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 04:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b158542592so102867685a.2
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 19:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729821753; x=1730426553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TmGiU8hTdE/i3CkC3m5nW2x+X5WDaGWRQQKox4eVncI=;
 b=D0kULvAMK67156hvPg0wR+oQjLx0pb4nQGu3X7AMXcCmKGpCuEohy5IyjnJuCCLsux
 Duu9LljZbLsSbMUearq8ZXXRiC6mRXIUeffsCNs3GRWAIMxp4FnzZcyx1wnsfRusxHQx
 GKJf4P0eALnjWVRz2LMOwpcxtLSjcRiuHkQ87Typl4mRUArJv5Ggs+KsJmVjauVi7D4e
 iPOQDWkjH5oPk3eM/XpOuco7giOZRGozo2fSSOBol7MUKT5O4Oc8PIkFvH1YMR99nz60
 vuKnDM76Y011EmoYXd7LIv/dCajpyR+Pm0Kb/iS6djQ5AXu0j2C4V5KK/2i2Bjuky0iY
 GISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729821753; x=1730426553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TmGiU8hTdE/i3CkC3m5nW2x+X5WDaGWRQQKox4eVncI=;
 b=ZUXlGWU27GEel2h9lvNvSSak3w87ECxiS53aZ8Gbisu9bxgDKXXwbr50OsrW1K7Cch
 /VjkKUOR7TlMQVjNs9BD63cQz/+xeWrF0S9TyWiL6FuHjCiHlcJkUhRYwwcldygerBKz
 J7Wvs5/5zKWhUKKTVzhGWb99BqZgsSiSESNn+f2OsCi3XRtTK8+g0rs8lya01o1jQjS6
 l1Zug5ntYgGJQwcrcm7vxyUt2CQNZOzZvjtu2ait/WUeKKxo9tSzf7Xcw5FkbkrGnScM
 RzAUjUhLJqmXqPhhDnrK3DdnstHdAWTMLs3wLki5CDIAeKDzlye618TQ922POu/1lflW
 RMtA==
X-Gm-Message-State: AOJu0YyagzT8LP2NKUmMWZQSn4FzYtxCHBsT4l7mQu64NumQfPfOXBOt
 YVQUDtEolfyesrFiQMq7YUgXvsQapGFyjT2z1FGHz5Rp4/4QVsMrY8z+X23H
X-Google-Smtp-Source: AGHT+IH8YpG1/lqm2ZiFlovjUaoGfk2yDH49GVS1hdETbvuy0yiiPKLQzINp7nh674ldj4v/nIGISQ==
X-Received: by 2002:a05:620a:1a8f:b0:7b1:56f0:e06f with SMTP id
 af79cd13be357-7b17e568066mr928667685a.15.1729821752879; 
 Thu, 24 Oct 2024 19:02:32 -0700 (PDT)
Received: from jesse-desktop.. (pool-108-26-179-17.bstnma.fios.verizon.net.
 [108.26.179.17]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d294b3fsm11607585a.33.2024.10.24.19.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 19:02:32 -0700 (PDT)
From: Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To: u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Jesse Taube <Mr.Bossman075@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/4] configs: imxrt1050-evk: Enable standard boot
Date: Thu, 24 Oct 2024 22:02:27 -0400
Message-ID: <20241025020228.1686306-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
References: <20241025020228.1686306-1-Mr.Bossman075@gmail.com>
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

Enable standard boot support and add default environments for the
imxrt1050-evk board.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env | 13 +++++++++++++
 board/freescale/imxrt1050-evk/imxrt1050-evk.env     | 13 +++++++++++++
 configs/imxrt1050-evk_defconfig                     |  4 ++--
 configs/imxrt1050-evk_fspi_defconfig                |  5 +++--
 include/configs/imxrt1050-evk.h                     |  7 -------
 5 files changed, 31 insertions(+), 11 deletions(-)
 create mode 100644 board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env
 create mode 100644 board/freescale/imxrt1050-evk/imxrt1050-evk.env

diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env b/board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env
new file mode 100644
index 00000000000..c61e9e3c00a
--- /dev/null
+++ b/board/freescale/imxrt1050-evk/imxrt1050-evk-nor.env
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* environment for imxrt1050-evk */
+
+#ifdef CONFIG_VIDEO
+stdin=serial
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+#endif
+
+fdt_addr_r=0x80800000
+kernel_addr_r=0x80000000
+boot_targets=nor
diff --git a/board/freescale/imxrt1050-evk/imxrt1050-evk.env b/board/freescale/imxrt1050-evk/imxrt1050-evk.env
new file mode 100644
index 00000000000..1c5cbc29d53
--- /dev/null
+++ b/board/freescale/imxrt1050-evk/imxrt1050-evk.env
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+/* environment for imxrt1050-evk */
+
+#ifdef CONFIG_VIDEO
+stdin=serial
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+#endif
+
+fdt_addr_r=0x80800000
+kernel_addr_r=0x80000000
+boot_targets=mmc
diff --git a/configs/imxrt1050-evk_defconfig b/configs/imxrt1050-evk_defconfig
index 2653efac148..141303c5a29 100644
--- a/configs/imxrt1050-evk_defconfig
+++ b/configs/imxrt1050-evk_defconfig
@@ -23,10 +23,10 @@ CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_HAVE_SYS_UBOOT_START=y
 CONFIG_SYS_UBOOT_START=0x800023FD
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SPI_BOOT=y
-# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
diff --git a/configs/imxrt1050-evk_fspi_defconfig b/configs/imxrt1050-evk_fspi_defconfig
index 95b5b56ece7..b77dbab7077 100644
--- a/configs/imxrt1050-evk_fspi_defconfig
+++ b/configs/imxrt1050-evk_fspi_defconfig
@@ -9,6 +9,7 @@ CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
+CONFIG_ENV_SOURCE_FILE="imxrt1050-evk-nor"
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20020000
 CONFIG_ENV_OFFSET=0x80000
@@ -24,10 +25,10 @@ CONFIG_SPL_SIZE_LIMIT=0x20000
 CONFIG_SPL=y
 CONFIG_HAVE_SYS_UBOOT_START=y
 CONFIG_SYS_UBOOT_START=0x800023FD
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_BOOTSTD_DEFAULTS=y
 CONFIG_SD_BOOT=y
 CONFIG_SPI_BOOT=y
-# CONFIG_USE_BOOTCOMMAND is not set
 CONFIG_SYS_CBSIZE=256
 CONFIG_SYS_PBSIZE=276
 CONFIG_SYS_CONSOLE_ENV_OVERWRITE=y
diff --git a/include/configs/imxrt1050-evk.h b/include/configs/imxrt1050-evk.h
index b370e25105a..c520c2fc203 100644
--- a/include/configs/imxrt1050-evk.h
+++ b/include/configs/imxrt1050-evk.h
@@ -18,13 +18,6 @@
 #define DMAMEM_BASE			(PHYS_SDRAM + PHYS_SDRAM_SIZE - \
 					 DMAMEM_SZ_ALL)
 
-#ifdef CONFIG_VIDEO
-#define CFG_EXTRA_ENV_SETTINGS \
-		"stdin=serial\0" \
-		"stdout=serial,vidconsole\0" \
-		"stderr=serial,vidconsole\0"
-#endif
-
 /*
  * Address of U-Boot for SPI NOR boot
  */
-- 
2.45.2

