Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EB6C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 20:20:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB14282064;
	Thu, 24 Apr 2025 22:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c/nfdVzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2EC281E25; Thu, 24 Apr 2025 22:19:46 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 425EC8056A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 22:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=grandpaul@gmail.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb3so1614702a91.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745525982; x=1746130782; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSX/9sQGbKqDWDDqeHEWYA9ns/DUT3sg+GNNs1iBoWM=;
 b=c/nfdVzHr1oHWlrQ9RkLKcztY0wu0WzfEk1y6j843mQ5ICxwu7ZpllFD1qowTvw0Sc
 A3fF/i/aClQHgUU4VCURIw17ewYGsuVMrkVFLZ6grBN59RjEfizC5TJs+ryrVmbK/E9I
 kE2LWZzg35xrOd1Itz+PujMpxwYV+6P/JmOQ+j1UtkZyGznGAbXV2PRFPh0h1/dBoA3S
 tZxl184LuGMuapFjlYbF6Ae/YhjEW32H5Blujjwud5ZOCdOVxJ4xVfx3CtUCQMyHpUKc
 ozmkRYzCWJhlz3vCMosjKI3egEwuzJvYB3A0C8Fewx+jPf0Vafp6EO4hXqUhq6TD44u+
 k6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745525982; x=1746130782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jSX/9sQGbKqDWDDqeHEWYA9ns/DUT3sg+GNNs1iBoWM=;
 b=r6lNujCoyQjOvW3IgVShnUo5gIbd1err+WPvWTTaB8LyzVuZ4/GxQyRe/m8H+VbyRp
 +0fyHnM5lxzDWtjES0YK6UmFWdic12w8+u/tpk4yAFYBZxgUi2C2mxZMvDawkjjF44fe
 Ucxyw/MWWRAMI7MTG19eoLotDUqQXgJM9L9fBF8JRmela0Yry6frjcDGg6BuAy2xvoL8
 GvN6aPB8xh7KiJGoum+XdXP8ycpld78wJI9r+ndeb1kvwmXpO2AP5PXGaKi1a4aC+Oli
 X9yPs+ehxbL4SlBnCtD/DR61QR8JanJdDZ5FDxcM9Oj4TpyTHmhoHgq5tkCrv/P1V6Ic
 4CnA==
X-Gm-Message-State: AOJu0YxpHAI9aiDSQrh4DphAEQ6yy8VyC1d0MIZp0BMziD02OPiHP2yD
 O9se6OyWCJWZYvNIcZ5k88La9B1ssrZy2YcJdUNGSyx4ZyDfxDMdRRwuqA==
X-Gm-Gg: ASbGnctIhXsvfefFN41oHEVYTQ/IuHTasi8c+sMhYjnzicBwT/tLktp78J5kAbd75bl
 PJAI9Z+0CGHfbUtWSx3j3gE3nHQCtQR543jgAD/PyG44zPlPo5p13dubX99I4eU2kAkVQvVzAYr
 OlzRsA7dI2YIgc8+veI+soStRlRkikE4A+Y7HjZUMKyovVZsB0wTBEyu6BA174ZfmGfT0wCZmnN
 2ySegvvl8QxxRx2w9+9l7k7wcpxLax3OuBV8s0EuqTCIDHVIDFHvJAtmaEtyU6a6Sw+rjFPMIQU
 6B+NBvfzdmoKGy/yetgCgPp7j7Ic/dJk3SXv
X-Google-Smtp-Source: AGHT+IF7Kz+J0HlHz6YFoZGyi1F8tLAkC4my4NcH8Ti3BPRDI5ADlasL4IsiBItHZFjzhm3uQlNphQ==
X-Received: by 2002:a17:90b:3851:b0:2ff:58b8:5c46 with SMTP id
 98e67ed59e1d1-309f5534319mr1385606a91.8.1745525981643; 
 Thu, 24 Apr 2025 13:19:41 -0700 (PDT)
Received: from localhost ([61.71.79.124]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-309f7754d52sm39217a91.19.2025.04.24.13.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 13:19:41 -0700 (PDT)
From: "Ying-Chun Liu (PaulLiu)" <paulliu@debian.org>
To: u-boot@lists.denx.de
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 2/3] efi: add EFI_DEBUG_IMAGE_INFO_TABLE for debug
Date: Fri, 25 Apr 2025 04:19:25 +0800
Message-ID: <20250424201927.2027257-3-paulliu@debian.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250424201927.2027257-1-paulliu@debian.org>
References: <20250424201927.2027257-1-paulliu@debian.org>
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

From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>

EFI_DEBUG_IMAGE_INFO_TABLE is used to store EFI_LOADED_IMAGE for
debug purpose. This commit adds the table to the EFI_CONFIGURATION_TABLE.

This feature is described in UEFI Spec version 2.10. Section 18.4.

Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_api.h             | 24 ++++++++++++++++++++++++
 lib/efi_loader/efi_boottime.c | 16 ++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/efi_api.h b/include/efi_api.h
index 5017d9037cd..0f4245091f1 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -238,6 +238,10 @@ enum efi_reset_type {
 	EFI_GUID(0xcce33c35, 0x74ac, 0x4087, 0xbc, 0xe7, \
 		 0x8b, 0x29, 0xb0, 0x2e, 0xeb, 0x27)
 
+#define EFI_DEBUG_IMAGE_INFO_TABLE_GUID \
+	EFI_GUID(0x49152e77, 0x1ada, 0x4764, 0xb7, 0xa2, \
+		 0x7a, 0xfe, 0xfe, 0xd9, 0x5e, 0x8b)
+
 struct efi_conformance_profiles_table {
 	u16 version;
 	u16 number_of_profiles;
@@ -564,6 +568,26 @@ struct efi_loaded_image {
 	efi_status_t (EFIAPI *unload)(efi_handle_t image_handle);
 };
 
+#define EFI_DEBUG_IMAGE_INFO_UPDATE_IN_PROGRESS 0x01
+#define EFI_DEBUG_IMAGE_INFO_TABLE_MODIFIED     0x02
+
+struct efi_debug_image_info_normal {
+	u32 image_info_type;
+	struct efi_loaded_image *loaded_image_protocol_instance;
+	efi_handle_t image_handle;
+};
+
+union efi_debug_image_info {
+	u32 *image_info_type;
+	struct efi_debug_image_info_normal *normal_image;
+};
+
+struct efi_debug_image_info_table_header {
+	volatile u32 update_status;
+	u32 table_size;
+	union efi_debug_image_info *efi_debug_image_info_table;
+};
+
 #define EFI_DEVICE_PATH_PROTOCOL_GUID \
 	EFI_GUID(0x09576e91, 0x6d3f, 0x11d2, \
 		 0x8e, 0x39, 0x00, 0xa0, 0xc9, 0x69, 0x72, 0x3b)
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 366bc0d2b1d..e2665459e44 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -4038,6 +4038,16 @@ efi_status_t efi_initialize_system_table(void)
 	return ret;
 }
 
+struct efi_debug_image_info_table_header __efi_runtime_data
+efi_m_debug_info_table_header = {
+	0,
+	0,
+	NULL
+};
+
+const efi_guid_t efi_debug_image_info_table_guid =
+	EFI_DEBUG_IMAGE_INFO_TABLE_GUID;
+
 /**
  * efi_initialize_system_table() - Initialize system table
  *
@@ -4053,6 +4063,8 @@ efi_status_t efi_initialize_system_table_pointer(void)
 	u64 addr;
 	u64 aligned_addr;
 	u32 crc32_value;
+	efi_guid_t debug_image_info_table_guid =
+		efi_debug_image_info_table_guid;
 
 	/* Allocate configuration table array */
 	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
@@ -4077,5 +4089,9 @@ efi_status_t efi_initialize_system_table_pointer(void)
 			    (const unsigned char *)systab_pointer,
 			    sizeof(struct efi_system_table_pointer));
 	systab_pointer->crc32 = crc32_value;
+
+	ret = efi_install_configuration_table(&debug_image_info_table_guid,
+					      &efi_m_debug_info_table_header);
+
 	return ret;
 }
-- 
2.39.5

