Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED735C3ABA2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 09:42:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB43D88EC0;
	Mon, 16 Sep 2024 11:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HtPPNaoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7D2188EB6; Mon, 16 Sep 2024 11:41:57 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CD7D88EC4
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 11:41:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cc8782869so41658295e9.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726479715; x=1727084515; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WXhkHhavhOUcV2XIl92zcF8hBcWoeJ6wr38Qdh/V28Q=;
 b=HtPPNaoX3SzautAknmNIoiJiICq1aJDOGMkgkWdnSW3b9bURewtZc70JwMlqs43wzw
 jBs8AtguAyWgmN9UosIVPc0P8l3aQjVimpAPBW5Kgyt0MojtuJ9z14mSjpGkld2izAWC
 SMya7cirnS0qznyowTUAvjUmD79V8vhCahGl0vw7X8EYGy24ih6N3m9AilFr3jk3/yWm
 QOG6WrLgK5DjzoonkZ7nTUbJ1FJIbYE/DysRqUY6db5dXJ4mM+1M7XBeSdBmSmF6XXYg
 MxCieo20fH9nRqkj4qhiZy1E0xXyqrTBPHze2CwdQDVL3Rk6C3DS6QbCdxJvJlYmsKox
 Px2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726479715; x=1727084515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WXhkHhavhOUcV2XIl92zcF8hBcWoeJ6wr38Qdh/V28Q=;
 b=Par1CTY4V12C5Lg0LKMnIKo1dxqVza83lUSJWBE0B0s+A06yWTefIk07rXesKZkYVL
 MNxW4fpNDKAnLZXicGCVvgtQYbFZ0YLcQ4RZNjY4M3qBweR5ViziLPlJqMzKLUwuSPUx
 39VNCWhHoIfaqp4vUOmQO1old2t4XuDH0en8tCxneqd1wbwWVeeTIoNfAquJfrlhkDYB
 O9J+QrlUHHxGL64rPocczKsQmOniJZFEizTedVrG0ObJ8WyeZGVy4KCYgKrpKorytc6M
 ag2h/E/D3XJprH33t2rqRKqhM838G3oh8FWSBdlqHGdSnXExNzlAcZ/4QmPUP2X2FLwZ
 YuzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkPqiBn3W27UjHWP6TmLv8Sll6V02bLEUcqTvZRNt3DDbVlWE/LoZImC5fqygx/UocaVmU2TE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4yht3QBjIWHnarQTMm1v8YkEXvlqsaFuyZSBw93O5+IRcnWgv
 sYNutVfaGcnzVPkAitdCWNXxNLTZBYFfJBhl23Lu3/FBMZauGv82EQu2WpeSgp0=
X-Google-Smtp-Source: AGHT+IHWCqwszPvczoyY20PL+XKIgrm8QOpBjniOe6+r8Mt1/HsjHZtEYDaXmULLQ6oTQ270T2KyQg==
X-Received: by 2002:a05:600c:1d84:b0:42c:bae0:f066 with SMTP id
 5b1f17b1804b1-42cdb539e84mr125983195e9.13.1726479714619; 
 Mon, 16 Sep 2024 02:41:54 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b05d4e1sm106398555e9.12.2024.09.16.02.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 02:41:54 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 16 Sep 2024 11:41:49 +0200
Subject: [PATCH 2/2] board: libre-computer: aml-s805-cc: Enable capsule updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-u-boot-topic-dynamic-uuid-v1-2-7e4f48542a0f@linaro.org>
References: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
In-Reply-To: <20240916-u-boot-topic-dynamic-uuid-v1-0-7e4f48542a0f@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3162;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=o7r6FW1caQIgnnPyt9ucbd3e0OvrsME6kk385uYnm8s=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm5/1f/bRi8MTXgfCO9XfMI3zP0d4Fh9YyBpxnieIV
 bcvwU66JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuf9XwAKCRB33NvayMhJ0UmVEA
 DFEv63ttwwp/xr0NKOPjXDwI7urvHYtxgmSbTq3jnrhcKaeN89YfahBOxGq5YyfuilaXfVBqerhwY1
 IG1N1wSPrd3jb+vU8nbqBsdjZWjQZ13CprhT3sHIZ7WiPf1lpdejQhvCWXLqPiQVu32OpQ5pUXftIU
 Lgs4leNMP+dLgaAE7Ez8tqqM94R5p/UOaLARW5JfzLwIBzJZMWNZqQa/u/kEacLS+7lfiuShdcgeVA
 FQjtC+vwPjGXZvmRuK5OU37uztah4jzY4ndY23Ujrj2FC/U7QRJeLkXFeveObER+zVA1k2lFhRnmjY
 96F74W70pWFVkFHSP/i+9XlQUy7s/gAIOzgHPkOMuolFK4vgObDu4rEDulxR2f8yldOB/GnAmfuan+
 sa/ZTFI6iBegLZpWpQ1SQwiiieA0aJJ3+BrVF1zBeuHTAusXwSsN0EnwC5baiHxdkv+X3MaeC4oCC/
 tdLutDtvi92fwhtlV1MrosKaCBJv8qcsKT77T0ucxKv5iyNu4FnjNp/UUVwUQ0sppFmc7mrHm+1p2B
 Rr7xZcCSGXLQgHiwLcOy+J55sMcscbLs5QeosHedc6Acpxzq8uZOmYzBYlqQ2zVbcqAxYq2TegSuE1
 Xm9KkMNM8dy61lr6IbiZkTGif/Ffp0UZVlJbykYDPVamOuEFbAx55PnwmNJQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Since the aml-s805-cc works well using EFI, and now the capsule updates
backend has been merged, let's enable the missing configs and add
the required structures to support it.

The GUID is dynamically generated for the board, to get it:
=> efidebug capsule esrt
========================================
ESRT: fw_resource_count=1
ESRT: fw_resource_count_max=1
ESRT: fw_resource_version=1
[entry 0]==============================
ESRT: fw_class=B8079027-9B2C-57D4-86AA-CC782ADA598C
ESRT: fw_type=unknown
ESRT: fw_version=0
ESRT: lowest_supported_fw_version=0
ESRT: capsule_flags=0
ESRT: last_attempt_version=0
ESRT: last_attempt_status=success
========================================

On the host (with the aml_encrypt_gxl result binary):
$ eficapsule --guid B8079027-9B2C-57D4-86AA-CC782ADA598C -i 1 u-boot.bin u-boot.cap

On the board (from USB disk containing u-boot.cap at root):
=> load usb 0:1 $kernel_addr_r u-boot.cap
=> efidebug capsule update $kernel_addr_r

The binary will then be flashed on the SPI.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 14 ++++++++++++++
 configs/libretech-ac_defconfig                   |  5 +++++
 2 files changed, 19 insertions(+)

diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index ae9834c0bf8..ba14df54967 100644
--- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -8,6 +8,7 @@
 #include <env.h>
 #include <init.h>
 #include <net.h>
+#include <efi_loader.h>
 #include <asm/io.h>
 #include <asm/arch/gx.h>
 #include <asm/arch/sm.h>
@@ -19,6 +20,19 @@
 #define EFUSE_MAC_OFFSET	52
 #define EFUSE_MAC_SIZE		6
 
+struct efi_fw_image fw_images[] = {
+	{
+		.fw_name = u"AML_S805X_AC_BOOT",
+		.image_index = 1,
+	},
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "sf 0:0=u-boot-bin raw 0 0x10000",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE + 1];
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 11d9795e05d..f146a495654 100644
--- a/configs/libretech-ac_defconfig
+++ b/configs/libretech-ac_defconfig
@@ -35,6 +35,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_IMI is not set
 CONFIG_CMD_ADC=y
 CONFIG_CMD_DFU=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
@@ -42,6 +43,7 @@ CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_EFIDEBUG=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_REGULATOR=y
 CONFIG_OF_CONTROL=y
@@ -49,6 +51,7 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
@@ -98,3 +101,5 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

-- 
2.34.1

