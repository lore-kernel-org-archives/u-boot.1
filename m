Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3697CC67861
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5C0C87FC8;
	Sat,  6 Apr 2024 16:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NMF6Cym8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C50787FC8; Sat,  6 Apr 2024 16:02:54 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7740C87EA8
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4163ae5b845so3170155e9.0
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412172; x=1713016972; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNYWRtTcfYPoyKQ45AFg9FBU9+hEW4peULAuPL/Us60=;
 b=NMF6Cym8UEEqWxGk7OcFeLAOY3h5lo0KZGxN8jYlCxDCknHKkfDJlt4hPbBhqE4ocu
 SO1S+lpi1JHwhb0f5xwViYWRaf5f7SjFb1g66PSZFUm7iwUWOQgxIMkIoDJLh8iiiMf3
 530gVPt0MVeE56hqsIDb/vOBg1g5sXprrEJqQhB8pmXZU4W13vf5TWOEL7++vhyGhJc4
 p7f6uSbayzti8Up+Ukb3QolV212fCskhb2Boq9JkDIcTqSNNiUkEPj0b8OtiXHjRZAl0
 1oP3f5uDJF2MTOz5G3aIMXd3j2unbCWr8ZP2SeEfIU84dSkAlOld29A74mmTNZSZ0Cgk
 d6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412172; x=1713016972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uNYWRtTcfYPoyKQ45AFg9FBU9+hEW4peULAuPL/Us60=;
 b=QDnOSe9Jfl9qsNz+hO+LE4sTBQ0fFcG51v+GLS6/D76If76bXr1p1JyDkz2I++/G3Z
 Xqmikl98xWxXstV02lMmmfMSU3KgHuMSQpQtGWH/HLkUMacnq4HYLn6RjL/K6v7pJSST
 pqgxwcszgk8vkpHWt5A+9SG19w+Oj+6/8LnMhf13gshjTGG4i4sNJpQoVpu1rZl982Q8
 vh97o6/fEvXdkGLxz4O9wh/brgEMvTXHZsDkeWbOcvQPLIET8PIV/9HPRwlsSmnhyFBl
 F7iUcfcuWepnFaFXOZ+4SFle6J2mRMUc1MfPBGVX54D5gJofeHdLJ59kUkdmMXsrQSMD
 +FmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl1xmHLwIOtUbi+rh4o2DMBPmX4fkgpk9lqCY9fUIC+j/vekR34e5npsqwBsUJXKbaz+Z3V1kwEFTp6pl4lSEDI/xICA==
X-Gm-Message-State: AOJu0Yxqr5x78daXDV9hE9g/QtfMplKZqblUdEHEkbVuRlFmzqO05boQ
 De3nRwqUHdfyTmd/KxnyYTK1TuEN0YQTWow+Ss3DVYEI2vkHEOmrVpfVz1+wQqU=
X-Google-Smtp-Source: AGHT+IGYvjmIpq5XEEzdSK3Uy4YaJxt4zUKJrkmtimyYcYk2BMQatwBo/G+89OiZIORKS+ZnQN8Itw==
X-Received: by 2002:a05:600c:3153:b0:414:759a:71d5 with SMTP id
 h19-20020a05600c315300b00414759a71d5mr3208457wmo.34.1712412172071; 
 Sat, 06 Apr 2024 07:02:52 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:02:51 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>, Bin Meng <bmeng@tinylab.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Eddie James <eajames@linux.ibm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 2/4] efi_loader: Add OS notifications for SetVariableRT in
 RAM
Date: Sat,  6 Apr 2024 17:01:58 +0300
Message-Id: <20240406140203.248211-8-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
References: <20240406140203.248211-1-ilias.apalodimas@linaro.org>
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

Previous patches enable SetVariableRT using a volatile storage backend
using EFI_RUNTIME_SERVICES_DATA allocared memory. Since there's no
recommendation from the spec on how to notify the OS, add a volatile
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
 include/efi_loader.h          |  4 ++++
 lib/efi_loader/efi_runtime.c  |  4 ----
 lib/efi_loader/efi_variable.c | 20 ++++++++++++++++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 7daca0afba2b..25551fe18948 100644
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
index 8ebbea7e5c69..d898ba6c268f 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -127,10 +127,6 @@ efi_status_t efi_init_runtime_supported(void)
 				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
 				EFI_RT_SUPPORTED_CONVERT_POINTER;
 
-	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
-		rt_table->runtime_services_supported |=
-			EFI_RT_SUPPORTED_SET_VARIABLE;
-
 	/*
 	 * This value must be synced with efi_runtime_detach_list
 	 * as well as efi_runtime_services.
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index f79041e6bedd..f97c8c57f75c 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -554,6 +554,26 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
  */
 void efi_variables_boot_exit_notify(void)
 {
+	const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
+	const efi_guid_t rt_prop_guid = EFI_RT_PROPERTIES_TABLE_GUID;
+	efi_status_t ret;
+
+	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		struct efi_rt_properties_table *rt_prop =
+			efi_get_configuration_table(&rt_prop_guid);
+
+		ret = efi_set_variable_int(u"RTStorageVolatile",
+					   &efi_guid_efi_rt_var_file,
+					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					   EFI_VARIABLE_RUNTIME_ACCESS |
+					   EFI_VARIABLE_READ_ONLY,
+					   sizeof(EFI_VAR_FILE_NAME),
+					   EFI_VAR_FILE_NAME, false);
+		if (ret != EFI_SUCCESS)
+			rt_prop->runtime_services_supported |= ~EFI_RT_SUPPORTED_SET_VARIABLE;
+		else
+			log_err("Can't RTStorage. SetVariableRT won't be available\n");
+	}
 	/* Switch variable services functions to runtime version */
 	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
-- 
2.37.2

