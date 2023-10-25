Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95AD2C25B47
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 06:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D03B1871E8;
	Wed, 25 Oct 2023 08:52:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EwPs6Q/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301CC871BB; Wed, 25 Oct 2023 08:52:21 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04A19871BB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 08:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5859d13f73dso3437432a12.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 23:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698216737; x=1698821537; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsPlZ/wDaNWJ0P29qnPTIvw1Av9TUM2cc5+ph3hvcqw=;
 b=EwPs6Q/d3d+yXPWvMp1QQWz5Xe60Qr8vgyLhQ8bzBOsaAfXjsQbrm9B15UuDlJQOXK
 wQu2KhH9JsImaoCyvTPwrWMod91Gcalqs7vsF+477UBFvzGR1Jrm2X+jh0jg32iqhdLr
 P0CulXu7sATsys91gRaJkJlTu9CC1YdGwjR/qFCveiionW82s99FIeAGtNWDwk9shFMl
 msRGiwTlSPXPt70xJq60yTu02sru9lk0lJE7mODWVzKVas/aQ5n2GwO8QjQi2zUbO1NT
 Ru/IzGmgxp4znswuc2OQ23l5f/QuqywpnG7QFtGagSXUU9uwyfuqoFMkMXlm5r3HNHH4
 Q0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698216737; x=1698821537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsPlZ/wDaNWJ0P29qnPTIvw1Av9TUM2cc5+ph3hvcqw=;
 b=GDK5pcLj1x6TEFvg1krnUGr2hSK6kaO5d3IU6XI3+Pn0eNtOF83UNsa5aWha0Cq9po
 LnaF4ypp0qZT0wFPDJMsp6p9W6AZgw2YP8qPG60FKSAicItzGq7Fm2o+v8iGiYJRcSGh
 s1gXT8nHItGYAyUdWX0ajnDQ+kmlMdLRUj6YYZnQPZ+nm6v+rId/hbaEBFDEbkKRzk+T
 bzhqla8X4JY1sfaRZFEWD6NLd20g16QX9qBBuQNfj7gOwGsANLtHrIVCbI0nEV35xrez
 AaCEhRP2L0bWykU31Qg5/q8Xxc8PTSMV8XxVP98AbZ1sGKG6I3mRGNjBPKVMhZ9V6HY2
 N1gA==
X-Gm-Message-State: AOJu0YzXtHdwDtduE+AtmKFQUiQ4dOuV4+WA4wRYfWz6DQgR3RpFpz0j
 iE3f+UxD9xxf21CHuhxZDFtcgk/GzLaW3EkrlYo=
X-Google-Smtp-Source: AGHT+IEF4SpDAKtiv1k7UVZI8hAErI7vTYopQqPBl7r5pHNI4KA3ndMHROyaJc9EFN4LA7ILJCA/KA==
X-Received: by 2002:a05:6a20:9187:b0:15e:a8:6bb4 with SMTP id
 v7-20020a056a20918700b0015e00a86bb4mr5048724pzd.8.1698216737029; 
 Tue, 24 Oct 2023 23:52:17 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 f8-20020a170902ce8800b001c9c5a1b477sm8468806plg.169.2023.10.24.23.52.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 23:52:16 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: jaswinder.singh@linaro.org, ryosuke.saito@linaro.org,
 sugimoto.yoshio@socionext.com, ilias.apalodimas@linaro.org,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH 1/3] board: developerbox: remove obsolete NOR flash layout
 definition
Date: Wed, 25 Oct 2023 15:51:01 +0900
Message-Id: <20231025065103.3101666-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
References: <20231025065103.3101666-1-masahisa.kojima@linaro.org>
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

There are two kinds of NOR flash layout for the Developerbox.
Capsule update for the old layout is no longer available since
it has small capacity for secure world images and can not
house the TA such as fTPM.
This commit removes the definition related to the obsolete
NOR flash layout for the UEFI capsule update.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
---
 include/configs/synquacer.h | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/include/configs/synquacer.h b/include/configs/synquacer.h
index cd7359c2f8..e36e63e81e 100644
--- a/include/configs/synquacer.h
+++ b/include/configs/synquacer.h
@@ -40,20 +40,6 @@
 
 /* Since U-Boot 64bit PCIe support is limited, disable 64bit MMIO support */
 
-#ifdef CONFIG_FWU_MULTI_BANK_UPDATE
-#define DEFAULT_DFU_ALT_INFO
-#else
-#define DEFAULT_DFU_ALT_INFO "dfu_alt_info="				\
-			"mtd nor1=u-boot.bin raw 200000 100000;"	\
-			"fip.bin raw 180000 78000;"			\
-			"optee.bin raw 500000 100000\0"
-#endif
-
-/* GUIDs for capsule updatable firmware images */
-#define DEVELOPERBOX_UBOOT_IMAGE_GUID \
-	EFI_GUID(0x53a92e83, 0x4ef4, 0x473a, 0x8b, 0x0d, \
-		 0xb5, 0xd8, 0xc7, 0xb2, 0xd6, 0x00)
-
 #ifdef CONFIG_FWU_MULTI_BANK_UPDATE
 #define DEVELOPERBOX_FIP_IMAGE_GUID \
 	EFI_GUID(0x7d6dc310, 0x52ca, 0x43b8, 0xb7, 0xb9, \
@@ -64,10 +50,6 @@
 		 0x33, 0xe0, 0xb9, 0x16, 0xf3, 0x98)
 #endif
 
-#define DEVELOPERBOX_OPTEE_IMAGE_GUID \
-	EFI_GUID(0xc1b629f1, 0xce0e, 0x4894, 0x82, 0xbf, \
-		 0xf0, 0xa3, 0x83, 0x87, 0xe6, 0x30)
-
 /* Distro boot settings */
 #ifdef CONFIG_CMD_USB
 #define BOOT_TARGET_DEVICE_USB(func)	func(USB, usb, 0)
@@ -107,7 +89,6 @@
 	"ramdisk_addr_r=0xa0000000\0"		\
 	"scriptaddr=0x88000000\0"		\
 	"pxefile_addr_r=0x88100000\0"		\
-	DEFAULT_DFU_ALT_INFO			\
 	BOOTENV
 
 #endif /* __CONFIG_H */
-- 
2.34.1

