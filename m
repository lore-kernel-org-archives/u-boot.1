Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E98C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F0E788464;
	Wed, 17 Apr 2024 12:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oJ3qbwHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC6D88461; Wed, 17 Apr 2024 12:19:49 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9866E8842A
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-418ce99e7fcso134095e9.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713349185; x=1713953985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=chYdKJSIqCPZ5ji7MNGV72oV6gQgjYtrYtQPdRJyYPA=;
 b=oJ3qbwHKMyrpHFlnadXV+mO+7vQDx+vsNiuIIJ2GOMHobjklN1YK4aHIdyKJSq+xXy
 kUjahyANZebAe+wbJ6YI5li5RTGXM3PMvUFieVh9YHT4rW/7iPOmFmPnNVzBMS5nDLJo
 nKivdBvXU8E9j4etBJU9vnzSL4/RTjB7UitOT1DNfxEW8WAR2s/TsKhYsTkURxeYgA/8
 8TvaJtdOje19YDNN4VdVE/nXfgm7L2sww/OKWys5HBDdeyzxf4Eg6jOSWfv1FXJVQglT
 7p6uRN/UYLpTugpTVwrJeHJB592bQEWgxiiffrPNKI5To/AJksN0LzU3YmFOX6HlswAt
 5PSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713349185; x=1713953985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=chYdKJSIqCPZ5ji7MNGV72oV6gQgjYtrYtQPdRJyYPA=;
 b=d+VgpUAdZMlVBQdqcOy9K826OYGgNC8h/GZ9x6HNtGtnajRanzm1P9CgCTYKo39keH
 CaIGcly4Lc/YyHj6PKz65PoOX/XKhYNwmML7pRaS2BHk9GzN5MOLYFp5NWCz7+8HerbK
 7Hgb7N1Xn24yc83wcIhPbIKnBysnz4eX/JSovfgBaOBnXpKYJ/PNYmpfuFuu22y5gOm2
 p5vPN3WwO0uJa8iLw0uCxB9yAMB/6uWZIms/u8aI9Bvzgy9ZfrKH47eJw+LtiAk13jIL
 lx54mGE6AIumFKe3azaVGNyXp1mDY/ucIAW0A4cUgCDXkj7WGgldYG9VlF+RVL3w+mSt
 1z2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ0wk+xxQFvx7l2SWWzew9gj2Xc0JLopYzPam30AYB45wuv0n4zwygXFYth6hP6TmGBQHfguNB8aRZixKlUZVeQRSvrw==
X-Gm-Message-State: AOJu0YwtZQY2f+YA5i0b1X0EgBlSbZ4Dx4jJEzh6hWZkmAlwyF4XWxBF
 +uiGzL81AyBsbJan5CkAI5cJKQkDULFmpOOBwUGKwjVrhQ7HB42PYNHn+dMdgfY=
X-Google-Smtp-Source: AGHT+IFlJXxWucnGCO+JonC5ZZylKoN6Vnosa9aX+folyiY5wd3zM7SCPNOrshnyKVRBQJR8NcgeNA==
X-Received: by 2002:a05:6000:1ace:b0:346:251a:396d with SMTP id
 i14-20020a0560001ace00b00346251a396dmr13149525wry.51.1713349184914; 
 Wed, 17 Apr 2024 03:19:44 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm13567780wrq.19.2024.04.17.03.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 03:19:44 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Janne Grunau <j@jannau.net>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, Weizhao Ouyang <o451686892@gmail.com>,
 u-boot@lists.denx.de
Subject: [PATCH v2 2/4] efi_loader: Add OS notifications for SetVariable at
 runtime
Date: Wed, 17 Apr 2024 13:19:23 +0300
Message-Id: <20240417101928.119115-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
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

Previous patches enable SetVariable at runtime using a volatile storage
backend using EFI_RUNTIME_SERVICES_DATA allocared memory. Since there's
no recommendation from the spec on how to notify the OS, add a volatile
EFI variable that contains the filename relative to the ESP. OS'es
can use that file and update it at runtime

$~ efivar -p -n b2ac5fc9-92b7-4acd-aeac-11e818c3130c-RTStorageVolatile
GUID: b2ac5fc9-92b7-4acd-aeac-11e818c3130c
Name: "RTStorageVolatile"
Attributes:
	Boot Service Access
	Runtime Service Access
Value:
00000000  75 62 6f 6f 74 65 66 69  2e 76 61 72 00           |ubootefi.var.   |

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_loader.h         |  4 ++++
 lib/efi_loader/efi_runtime.c | 19 ++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index bb51c0281774..69442f4e58de 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -159,6 +159,10 @@ static inline void efi_set_bootdev(const char *dev, const char *devnr,
 #define EFICONFIG_AUTO_GENERATED_ENTRY_GUID \
 	EFI_GUID(0x8108ac4e, 0x9f11, 0x4d59, \
 		 0x85, 0x0e, 0xe2, 0x1a, 0x52, 0x2c, 0x59, 0xb2)
+#define U_BOOT_EFI_RT_VAR_FILE_GUID \
+	EFI_GUID(0xb2ac5fc9, 0x92b7, 0x4acd, \
+		 0xae, 0xac, 0x11, 0xe8, 0x18, 0xc3, 0x13, 0x0c)
+
 
 /* Use internal device tree when starting UEFI application */
 #define EFI_FDT_USE_INTERNAL NULL
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index dde083b09665..c8f7a88ba8db 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -10,6 +10,7 @@
 #include <dm.h>
 #include <elf.h>
 #include <efi_loader.h>
+#include <efi_variable.h>
 #include <log.h>
 #include <malloc.h>
 #include <rtc.h>
@@ -110,6 +111,7 @@ static __efi_runtime_data efi_uintn_t efi_descriptor_size;
  */
 efi_status_t efi_init_runtime_supported(void)
 {
+	const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
 	efi_status_t ret;
 	struct efi_rt_properties_table *rt_table;
 
@@ -127,9 +129,20 @@ efi_status_t efi_init_runtime_supported(void)
 				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
 				EFI_RT_SUPPORTED_CONVERT_POINTER;
 
-	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
-		rt_table->runtime_services_supported |=
-			EFI_RT_SUPPORTED_SET_VARIABLE;
+	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		ret = efi_set_variable_int(u"RTStorageVolatile",
+					   &efi_guid_efi_rt_var_file,
+					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					   EFI_VARIABLE_RUNTIME_ACCESS |
+					   EFI_VARIABLE_READ_ONLY,
+					   sizeof(EFI_VAR_FILE_NAME),
+					   EFI_VAR_FILE_NAME, false);
+		if (ret != EFI_SUCCESS) {
+			log_err("Failed to set RTStorageVolatile\n");
+			return ret;
+		}
+		rt_table->runtime_services_supported |= EFI_RT_SUPPORTED_SET_VARIABLE;
+	}
 
 	/*
 	 * This value must be synced with efi_runtime_detach_list
-- 
2.40.1

