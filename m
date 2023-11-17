Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AE4C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 15:48:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE09C86EB8;
	Fri, 17 Nov 2023 16:48:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lcK0GWTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8477386DB1; Fri, 17 Nov 2023 16:48:08 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3468743F
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 16:48:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5b499b18b28so24010477b3.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700236079; x=1700840879; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ywXp+B39WiaUwvxEf0qHkFAGi6blErhyjzyBtFpikA8=;
 b=lcK0GWTrcqDdSL12sasydkkZ78sAmGX8Z+xDh1o/zTStU8lTMUuF4O688xjm4Ms/x1
 +Bu6ET4AfZGyX4O6SvEXcv82tdESJ3ELm4HPDt80V32lY5dmiw4pBDWWN6kwMydb68MS
 HHZZMt5l9URP7LlqV+aaL7vWQXOPdchIH8AWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700236079; x=1700840879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ywXp+B39WiaUwvxEf0qHkFAGi6blErhyjzyBtFpikA8=;
 b=EMi/LNkLaKeSVMssDBP1oLtluyeXkkVa0wf/inBbw+4gBcERGOlkhhsIB6pDijhroT
 JTxWB2H/vgG9ODEIH4UY6NhNUAFp8SEnr0lfoLopf18u+1542pa4RJFm3Wzoyx81L9L9
 QZBC5kwx9KWfDjTrkgXhujB6dV0d8xqaC3wJ9VncPPu6RblwekcmAb5Oa1msO/2tHrAj
 pg6cKwsj8pa7pkmyvhO351QIIyts7jJQWQz6AIpqPTbTpDD86C+Yix+FCaJCYCYbAUCy
 UBQBiwaOE2bghZgEiKCF4AEpkQbQhqWFtZ3HUdY5ToOBilqpF+vX367tIkzmQw9TLzsX
 qdXQ==
X-Gm-Message-State: AOJu0YzJjI7ZyTkK8NyU4rerNC2oXAufu+QCXpLLL5eHasNsroJrn2Ew
 rZsY/M0wkKJbuZvDeS5oGTqkCa7Lfykzb3yrBPBGfg==
X-Google-Smtp-Source: AGHT+IG3L7HMBDfxpVFSWqIJeDW2tA5QmrY4zYbW7I3lTVo3TiG72Kh+AnTeyTjha4uIuZqlF1VJVg==
X-Received: by 2002:a05:690c:4683:b0:5c1:47f2:6e05 with SMTP id
 gx3-20020a05690c468300b005c147f26e05mr17251956ywb.9.1700236079095; 
 Fri, 17 Nov 2023 07:47:59 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a81480d000000b005af81610bdbsm546299ywa.122.2023.11.17.07.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 07:47:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Matthias Winker <matthias.winker@de.bosch.com>,
 Philip Oberfichtner <pro@denx.de>, Minkyu Kang <mk7.kang@samsung.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: [PATCH] boards: Disable NET on platforms without NETDEVICES
Date: Fri, 17 Nov 2023 10:47:57 -0500
Message-Id: <20231117154757.777827-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

None of these platforms enabled a networking devices, and disabled
CMD_NET. Given that we used to gate network support on CMD_NET rather
than NET, we disable CONFIG_NET on these platforms now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Matthias Winker <matthias.winker@de.bosch.com>
Cc: Philip Oberfichtner <pro@denx.de>
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Sergey Temerkhanov <s.temerkhanov@gmail.com>
---
 configs/efi-x86_app32_defconfig     | 3 +--
 configs/efi-x86_app64_defconfig     | 3 +--
 configs/imx6q_bosch_acc_defconfig   | 3 +--
 configs/origen_defconfig            | 2 +-
 configs/s5pc210_universal_defconfig | 2 +-
 configs/stm32mp25_defconfig         | 2 +-
 configs/thunderx_88xx_defconfig     | 2 +-
 configs/trats2_defconfig            | 2 +-
 configs/trats_defconfig             | 2 +-
 9 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/configs/efi-x86_app32_defconfig b/configs/efi-x86_app32_defconfig
index 682ba5b89576..e2e6f42c9a9d 100644
--- a/configs/efi-x86_app32_defconfig
+++ b/configs/efi-x86_app32_defconfig
@@ -21,7 +21,6 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_PART=y
 # CONFIG_CMD_SCSI is not set
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
@@ -36,7 +35,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-CONFIG_USE_ROOTPATH=y
+# CONFIG_NET is not set
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 # CONFIG_REGEX is not set
diff --git a/configs/efi-x86_app64_defconfig b/configs/efi-x86_app64_defconfig
index d6b6c3d82995..14b5cd0fa0ee 100644
--- a/configs/efi-x86_app64_defconfig
+++ b/configs/efi-x86_app64_defconfig
@@ -22,7 +22,6 @@ CONFIG_SYS_PBSIZE=532
 CONFIG_CMD_BOOTZ=y
 CONFIG_CMD_PART=y
 # CONFIG_CMD_SCSI is not set
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_EXT2=y
@@ -38,7 +37,7 @@ CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_USE_BOOTFILE=y
 CONFIG_BOOTFILE="bzImage"
-CONFIG_USE_ROOTPATH=y
+# CONFIG_NET is not set
 CONFIG_REGMAP=y
 CONFIG_SYSCON=y
 CONFIG_CONSOLE_SCROLL_LINES=5
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 05bab034e0f9..6abb7954ba2d 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -63,7 +63,6 @@ CONFIG_CMD_PART=y
 # CONFIG_CMD_ITEST is not set
 # CONFIG_CMD_SOURCE is not set
 # CONFIG_CMD_SETEXPR is not set
-# CONFIG_CMD_NET is not set
 # CONFIG_CMD_BLOCK_CACHE is not set
 # CONFIG_CMD_SLEEP is not set
 # CONFIG_CMD_MP is not set
@@ -82,7 +81,7 @@ CONFIG_SYS_MMC_ENV_PART=1
 CONFIG_ENV_WRITEABLE_LIST=y
 CONFIG_ENV_ACCESS_IGNORE_FORCE=y
 CONFIG_VERSION_VARIABLE=y
-CONFIG_TFTP_BLOCKSIZE=512
+# CONFIG_NET is not set
 CONFIG_SPL_DM=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
diff --git a/configs/origen_defconfig b/configs/origen_defconfig
index 3a71d6e582a7..5e55b712df9e 100644
--- a/configs/origen_defconfig
+++ b/configs/origen_defconfig
@@ -35,13 +35,13 @@ CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_MMC_DW=y
diff --git a/configs/s5pc210_universal_defconfig b/configs/s5pc210_universal_defconfig
index f585c510635a..ac236c82a1fc 100644
--- a/configs/s5pc210_universal_defconfig
+++ b/configs/s5pc210_universal_defconfig
@@ -33,7 +33,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4_WRITE=y
@@ -42,6 +41,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+# CONFIG_NET is not set
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_SYS_I2C_S3C24X0=y
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 8423943f091c..75f27c98b441 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -23,7 +23,6 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADB is not set
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -31,6 +30,7 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+# CONFIG_NET is not set
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
diff --git a/configs/thunderx_88xx_defconfig b/configs/thunderx_88xx_defconfig
index 5c24b38bb1fa..0c71b298ada5 100644
--- a/configs/thunderx_88xx_defconfig
+++ b/configs/thunderx_88xx_defconfig
@@ -32,8 +32,8 @@ CONFIG_SYS_BOOTM_LEN=0x800000
 # CONFIG_CMD_EDITENV is not set
 # CONFIG_CMD_SAVEENV is not set
 # CONFIG_CMD_ENV_EXISTS is not set
-# CONFIG_CMD_NET is not set
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+# CONFIG_NET is not set
 # CONFIG_MMC is not set
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_SKIP_INIT=y
diff --git a/configs/trats2_defconfig b/configs/trats2_defconfig
index 6c4909f12be0..045c74f95efb 100644
--- a/configs/trats2_defconfig
+++ b/configs/trats2_defconfig
@@ -36,7 +36,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4_WRITE=y
@@ -44,6 +43,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+# CONFIG_NET is not set
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
diff --git a/configs/trats_defconfig b/configs/trats_defconfig
index 78484c071945..b1adaef17a01 100644
--- a/configs/trats_defconfig
+++ b/configs/trats_defconfig
@@ -35,7 +35,6 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_USB_MASS_STORAGE=y
-# CONFIG_CMD_NET is not set
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_SLEEP is not set
 CONFIG_CMD_EXT4_WRITE=y
@@ -43,6 +42,7 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+# CONFIG_NET is not set
 CONFIG_DFU_MMC=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x2000000
 CONFIG_DM_I2C_GPIO=y
-- 
2.34.1

