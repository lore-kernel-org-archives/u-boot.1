Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D5CC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09EDE8863B;
	Thu, 18 Apr 2024 14:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="keTD/enx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEDB58863B; Thu, 18 Apr 2024 14:55:14 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 029008831A
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:55:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a526d0b2349so93491866b.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713444912; x=1714049712; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PG/fCLR7lE0HGFILjjYIa9AktQy4qPCNzdmMr//VU5k=;
 b=keTD/enxqam0wPQilvgmE4G+cXV4GsjnKdzOdkUke/mWHjGCb3exPHWWBzkE92tBFh
 tjAQcuG5GzGFBtg3hB2jrjStaZqMsCSjzerrGcOkGqIEoBMxW0B/dHJw3GHPkcDYEKmS
 bF3HPL7JTL8mq+t+XnwBbM8cVo8Lf60cHRzHIBMzx1Un3EaYS0JQkRXhj4pHVc0PZZYU
 GEo+AX/Q9+fwYOO3G99m6uUJn6Q8u1FK1JDWja/0lmjCksuTG/edHHFJVFO7/jpabyWY
 jRMvm6q3o5CEQurxojm4ihRiTFefYNuP3BrGPnBF7fy9uXFbz68O4KP0XUIZXJupzGZM
 pWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444912; x=1714049712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PG/fCLR7lE0HGFILjjYIa9AktQy4qPCNzdmMr//VU5k=;
 b=wRF6vbT/fUDHFHVoLCdqCFr49Js2bkAMJuO41aEZfttmnn8WLQfi/KyP99RplMmfaM
 RgmkyrYC03ka75ATfu08r5MXCGN9MO6JvQUp7OXzxsO6Ihp8mqx5BJaCfGOSP3LyVtU6
 /ZTjdoOiMI99o2w9WTFPSddYrVjYPdgaY5b6GipEmD88Gog4WVeaZ7qG7vMPQjgy4LME
 lOy5Ivwef+uw7++fNPXgusV+vwkTz4CopTNi6ub6fH6q9u7GOOFZq9l2bkpo2XCOZBk2
 cwTIRb5YTBzdK9RhTq7/QCJIKE+ZUVdsuBJWsInQu9JzaG5kwY9Uuqtb54OYOicWVY9V
 uQ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHl9FpbUOO1hxtCuGuonnK2zB0X9IkXdnIajTGc11m2fU1DorRM+6jECGBKlWRgq8ociQ1cVIMgVurA51fZB3vPCloAg==
X-Gm-Message-State: AOJu0YzwpfoikL8rWAVLpnR6K+ZSDAnG+XxU/C+NT/5dn4vCuvIrJx2m
 MxfEP4Gls2buUCgKxS6Ys1LdOKWigEIGJsO+4M4Byv/u/0yinG+DpJN4pKYOLzk=
X-Google-Smtp-Source: AGHT+IEGttThkPjVmleJ4FCFd6LjqY0y704poH6n1SJ9LYdkvOrNnDsgNC3VFO7tTYfLVBilZxKm+g==
X-Received: by 2002:a17:906:717:b0:a55:5516:39fa with SMTP id
 y23-20020a170906071700b00a55551639famr1599110ejb.64.1713444912540; 
 Thu, 18 Apr 2024 05:55:12 -0700 (PDT)
Received: from hades.. (ppp176092141112.access.hol.gr. [176.92.141.112])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a1709060d8b00b00a525a18f748sm847002eji.165.2024.04.18.05.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 05:55:11 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Janne Grunau <j@jannau.net>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 2/4] efi_loader: Add OS notifications for SetVariable at
 runtime
Date: Thu, 18 Apr 2024 15:54:51 +0300
Message-Id: <20240418125456.50944-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
References: <20240418125456.50944-1-ilias.apalodimas@linaro.org>
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

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

