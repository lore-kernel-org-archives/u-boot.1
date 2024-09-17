Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CB1C3601A
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:35:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AD5188E78;
	Tue, 17 Sep 2024 14:34:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cN/Oe0Le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D0388E78; Tue, 17 Sep 2024 14:34:55 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C16EE88E5E
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:34:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-374c5bab490so4428038f8f.1
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 05:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726576492; x=1727181292; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aJrg2ShcpGeoJr2BRuQhpu5iq0h9WOCdFu465pSgpys=;
 b=cN/Oe0LeJ6VLzjk07o0HMogKXbFOlJTSEO+TRe2IjxiHgCTe5dKhzNJ54yt5ek0roL
 MAHLPSB6Z5HUubDLwNam0kHVy7wNK00nsqauNA9rwyF4G6x3SG5Pq5+fT1QT0TkDv72e
 9HaMQSBOxIq7ICx8D5/2rnfgOny4c6O9kMi3MgCZ295eYnKofi91iiydBZsu1+ACX6ad
 vSDFqq0OR1fT7RI01Q+ugfp1eJuJ1ggkxu01Ziofa8oaC1qmGnwtxnsoTT/JW/pGjNhr
 g0cVoi6Od6XmE3q7zAzpA8ICjddsIXLIPBbgOlAljGhrzMcIJ7wkVIAL+GWCAVz9fuvF
 jCkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726576492; x=1727181292;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aJrg2ShcpGeoJr2BRuQhpu5iq0h9WOCdFu465pSgpys=;
 b=LXB7yJ3qewsva/Y34Wg7tfluD7ox7PIAKxLugYX65lgpidG91r5yjssLwZ7xmlaoLd
 KrcABz482rvbPxRbzqdBUUDQlRYlwxQa+I25qfMimRLPqtmVdXjj82wsawn9gHrDwFya
 iVm/4TF3Y+iHbybyd9/P8RdnLEPsSWtVy3AfHKnIqKUYaJVm2b8/6OzHqkox/IN2VA7A
 sNLQgPjQGwOtqlc8D2SaDVKaAH9LyqDxH9amqJIvBjhza7/AFF1PSyuVHcxCLHNfz2dB
 bHbTHr+u+qbp5zIX32RMTVar+KmzEX0j6dCGZ+8Rm/3D19S0wYWj4e8g8n230N7wJ76u
 N3IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGZKu6I4c879IaQFaU5EN/a5Iutb5QVmsVR/uo0cQzu0h28ZBTKxhkti03A3LFdsrurC1aJ1I=@lists.denx.de
X-Gm-Message-State: AOJu0YyDkXaTtNaxI42Mjj1Wdkjr3F831YetVCIz730VkiYnHhv++Ca+
 tQpgMDyWG5e9GmJiDCCBB4Tv2ePE77vdR/bwZANyIeF/LRHy057dCEYzD9VF1Yg=
X-Google-Smtp-Source: AGHT+IEr3EoxWGvHuhBYbo6cZ7OYOEf8eCwZvMmcd9BgvhEnuAoSmpX4Weip1PZM2N41klJ/Uu1sFA==
X-Received: by 2002:a05:6000:1249:b0:374:c400:8556 with SMTP id
 ffacd0b85a97d-378c27a8a80mr10214214f8f.11.1726576492079; 
 Tue, 17 Sep 2024 05:34:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378e73e80eesm9381772f8f.30.2024.09.17.05.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 05:34:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 17 Sep 2024 14:34:46 +0200
Subject: [PATCH v2 2/2] board: libre-computer: aml-s805x-cc: Enable capsule
 updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-u-boot-topic-dynamic-uuid-v2-2-416e39c6e271@linaro.org>
References: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
In-Reply-To: <20240917-u-boot-topic-dynamic-uuid-v2-0-416e39c6e271@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Da Xue <da@libre.computer>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3593;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=zPvetaBnOXIbwLciZ582jmJJxdSfwJxTLM7x5mHwgFs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm6XdoaNLyaTdYxEmyzmMqLRFS57XgKpKPFqjoKcxS
 LiH0Vh+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZul3aAAKCRB33NvayMhJ0XsLD/
 oCm3/Imtrd3QplxZRmxzJ/Lx58OEbwSkyn4FY+0zY2adP4e8WfoFkVM7fooJjvODV44c4tkJrxuIkm
 h1pdCD0C5Pva7yLHEKBSDfHcV5fzoTT1hAdVv5vYGdrAoOHK1mkqbjpxtRFyaMKeiGiZb6ZzMSRvA+
 LzoZwHcmnYjlbAvlsyYtDaqh9qQPBwzFYhnnQ9oJ9PcJ3iZeVGycKIgp4TKRPcKeP3UxIQ9d8HBEV1
 5+TJarMPT7Jaa2xgoKM2bVcKDPcp2mVeysC8R3hNHCorKnY+MSPNI3Zu20eYVx1xuMBvnLi2Pl5q+g
 60B1jM5H6xHL5jMU84w1IUiZgluXm0iH/O/mr/3eUMmhWHjoAWzAzt6jxIrfu1M5SPcd9a6X1luxzk
 E+m4qI4A1czl4kCv5ZQAVDrrblAnP1s/icb/U1IUkgPj0UPeUHROepsOm2ou0F8Tx+kiiHBe9x00X/
 ecFDDRx6xR7Jsr6pxvkR8eppJf8XRqqQmVMEq6Mc/QvjAZvDfafuyRaDaFPJId9FM97rzuQNSVFMkn
 x5UNKAPSGAyt5fwJcDtLUXKd3HzPYH9bx6bNntvDXa1eZjcU839MBMl4WFB9Zrkpz2rON4/rtluhJd
 tlqXY5wE/fnSBSMyg6BHNeEgKZAwYA8gFRnPaFEw/Id2CAnqC6s5xT+UrS3w==
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

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c | 24 ++++++++++++++++++++++++
 configs/libretech-ac_defconfig                   |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index ae9834c0bf8..94cf5b4361f 100644
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
@@ -19,6 +20,29 @@
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
+#if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
+void set_dfu_alt_info(char *interface, char *devstr)
+{
+	if (strcmp(interface, "ram") == 0)
+		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
+	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
+		env_set("dfu_alt_info", update_info.dfu_string);
+}
+#endif
+
 int misc_init_r(void)
 {
 	u8 mac_addr[EFUSE_MAC_SIZE + 1];
diff --git a/configs/libretech-ac_defconfig b/configs/libretech-ac_defconfig
index 11d9795e05d..7763a14f203 100644
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
@@ -49,6 +51,8 @@ CONFIG_ENV_IS_IN_SPI_FLASH=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SARADC_MESON=y
 CONFIG_DFU_RAM=y
+CONFIG_DFU_SF=y
+CONFIG_SET_DFU_ALT_INFO=y
 CONFIG_MMC_MESON_GX=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
@@ -98,3 +102,5 @@ CONFIG_VIDEO_BMP_RLE8=y
 CONFIG_BMP_16BPP=y
 CONFIG_BMP_24BPP=y
 CONFIG_BMP_32BPP=y
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y

-- 
2.34.1

