Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1A6CD1284
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E4A98824A;
	Sat,  6 Apr 2024 16:02:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ul92xvWT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4098587FC8; Sat,  6 Apr 2024 16:02:40 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24B5087FC6
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso2288429f8f.0
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412157; x=1713016957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMqfUdl76G4qBulxCLMeh65myWO0ylZWG10h5H0frZ8=;
 b=Ul92xvWTNhLDeRNrNwSbih/KvhQ6LYG9eT6wsIDqB54lE0O85AYssaTxbN4gGW44eN
 ylLTzlYG/UOSSGrULMNHqecX/9eydsTi2NKASl3038qP2vLNR969zhZIU83hUb6hl/0A
 Xyy2hKsSVyt1LBL+ROyegcSyYpCQEwG8AxmCF8RtcqDF503F9fybY+wyXrRC9B8crUBD
 jh3AUCC7Wx+i5ybsK9a57+YsL84O29xz6o6nYi0S98u9L9Hd9EP62Nw4kJPIQlsqS9T4
 K3TdaY5etEGhyJwYzUfT1gvOY5ILvUMNdcJ42qT4Ay/wXJt1WyNX8Z2wt90amg2/Jpg6
 Eygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412157; x=1713016957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMqfUdl76G4qBulxCLMeh65myWO0ylZWG10h5H0frZ8=;
 b=ls5mw3JBkDCohfDsSME01MpC/qUHg1g5DdTFQ9PRMt2aum83YW0SVQSIebbfzyZQ6P
 Zpgh+Z6fJ57G9sqXQzWNMGxU+jxyEGZKAWmfd2N8RBWPnfz5haTFG4so4SQImd8vpr/V
 sqLU7zrLwlNyXfMe3/5fVnayD824UPcENOiikvmCfsGKbIdzVb5IHHqXaHznc9j3pqE4
 lzvWS+syq4h89C/eNEbAy5nMPSFY+VWPOEnR/b7bXt5I5Z+5jskH61bmlnzeA8TcoJvZ
 WrQKDKdg3fg9QzQR8yX+Yg/Se7fbfg1cqA56SnULkYaoQy2LNp7dXfd/gCNuF0pqwFSC
 Y7Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlYqZHrSXH830bIozmzr2bdey0zhVXn54GtkOm6QVNXAGEWU66IYTBlge6cYS2Ub++i/y0QOrpu5QzlzH/nQfiQoHkCA==
X-Gm-Message-State: AOJu0Yxw5JcIku2DDLhaVMhK45E/eCwTcMkf4x7iOmGvpz4CuKvJHmNg
 SfYgpybPyq0hNDD17chl2ZBFni9ySfm982M4KUbVT+nkQBP3Sbop9SmsubMfQJY=
X-Google-Smtp-Source: AGHT+IFIjunobLPmf5WueabjKzY58R+jWNAiT2gDrSQMiTO4unPVVXF6rVmg5laj/2lL0HkAY0gPQQ==
X-Received: by 2002:a05:600c:4505:b0:414:22e:1761 with SMTP id
 t5-20020a05600c450500b00414022e1761mr3138178wmo.16.1712412157614; 
 Sat, 06 Apr 2024 07:02:37 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:02:37 -0700 (PDT)
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
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 4/4] efi_selftest: add tests for setvariableRT
Date: Sat,  6 Apr 2024 17:01:55 +0300
Message-Id: <20240406140203.248211-5-ilias.apalodimas@linaro.org>
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

Since we support SetVariableRT now add the relevant tests

- Search for the RTStorageVolatile and VarToFile variables after EBS
- Try to update with invalid variales (BS, RT only)
- Try to write a variable bigger than our backend storage
- Write a variable that fits and check VarToFile has been updated
  correclty
- Append to the variable and check VarToFile changes
- Try to delete VarToFile which is write protected

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../efi_selftest_variables_runtime.c          | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 4c9405c0a7c7..eb4820e7deab 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -10,6 +10,7 @@
  */
 
 #include <efi_selftest.h>
+#include <efi_variable.h>
 
 #define EFI_ST_MAX_DATA_SIZE 16
 #define EFI_ST_MAX_VARNAME_SIZE 40
@@ -17,6 +18,8 @@
 static struct efi_boot_services *boottime;
 static struct efi_runtime_services *runtime;
 static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
+static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
+						U_BOOT_EFI_RT_VAR_FILE_GUID;
 
 /*
  * Setup unit test.
@@ -45,11 +48,14 @@ static int execute(void)
 	u32 attr;
 	u8 v[16] = {0x5d, 0xd1, 0x5e, 0x51, 0x5a, 0x05, 0xc7, 0x0c,
 		    0x35, 0x4a, 0xae, 0x87, 0xa5, 0xdf, 0x0f, 0x65,};
+	u8 v2[CONFIG_EFI_VAR_BUF_SIZE];
 	u8 data[EFI_ST_MAX_DATA_SIZE];
+	u8 data2[CONFIG_EFI_VAR_BUF_SIZE];
 	u16 varname[EFI_ST_MAX_VARNAME_SIZE];
 	efi_guid_t guid;
 	u64 max_storage, rem_storage, max_size;
 
+	memset(v2, 0x1, sizeof(v2));
 	ret = runtime->query_variable_info(EFI_VARIABLE_BOOTSERVICE_ACCESS,
 					   &max_storage, &rem_storage,
 					   &max_size);
@@ -63,10 +69,107 @@ static int execute(void)
 				    EFI_VARIABLE_RUNTIME_ACCESS,
 				    3, v + 4);
 	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		efi_uintn_t prev_len, delta;
+
 		if (ret != EFI_INVALID_PARAMETER) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
+
+		len = sizeof(data);
+		ret = runtime->get_variable(u"RTStorageVolatile",
+					    &efi_rt_var_guid,
+					    &attr, &len, data);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("GetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		len = sizeof(data2);
+		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					    &attr, &len, data2);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("GetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		/*
+		 * VarToFile will size must change once a variable is inserted
+		 * Store it now, we'll use it later
+		 */
+		prev_len = len;
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v2) / 2,
+					    v2 + (sizeof(v2) / 2));
+		/*
+		 * This will try to update VarToFile as well and must fail,
+		 * without changing or deleting VarToFile
+		 */
+		if (ret != EFI_OUT_OF_RESOURCES) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		len = sizeof(data2);
+		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					    &attr, &len, data2);
+		if (ret != EFI_SUCCESS || prev_len != len) {
+			efi_st_error("Get/SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* SetVariableRT updates VarToFile with efi_st_var0 */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v), v);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		len = sizeof(data2);
+		delta = 2 * (u16_strlen(u"efi_st_var0") + 1) + sizeof(v) +
+			sizeof(struct efi_var_entry);
+		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					    &attr, &len, data2);
+		if (ret != EFI_SUCCESS || prev_len + delta != len) {
+			efi_st_error("Get/SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* append on an existing variable will updateVarToFile */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_APPEND_WRITE |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v), v);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		prev_len = len;
+		delta = sizeof(v);
+		len = sizeof(data2);
+		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					    &attr, &len, data2);
+		if (ret != EFI_SUCCESS || prev_len + delta != len) {
+			efi_st_error("Get/SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Variables that are BS, RT and volatile are RO after EBS */
+		ret = runtime->set_variable(u"VarToFile", &efi_rt_var_guid,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v), v);
+		if (ret != EFI_WRITE_PROTECTED) {
+			efi_st_error("Get/SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
 	} else {
 		if (ret != EFI_UNSUPPORTED) {
 			efi_st_error("SetVariable failed\n");
-- 
2.37.2

