Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9682BC67861
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B83BD882A8;
	Sat,  6 Apr 2024 16:03:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L5+wwykP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238ED88168; Sat,  6 Apr 2024 16:03:04 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47E6882CE
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41649734f87so683505e9.1
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412181; x=1713016981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FMqfUdl76G4qBulxCLMeh65myWO0ylZWG10h5H0frZ8=;
 b=L5+wwykPDDu26a1mlEw+4YEiWVin5KUN7Kqaoih99gqkae8eYJWOpv6q8y95Tmjbv4
 XgEOoKzfFURx0eVpcDGYusavgGylnTSBss+Jj3lvh3MfM7iSbnHg1tJ4NaYzjrSHkMDi
 V7PcNIV+9uow1E3iG+0qIgSIXsWUI1wtROeFc8KURfLTHHbteWIA7RkAzvJSOcPQ1AZZ
 aIqdAYQq41bTXvCTOYMWihLtF5jXgzOAML/sMzMzFdiq1xskO0IJ7J7+nz/7rAYWukzu
 Bj+tzkRPn/Zi10zQ5XaNBenMh3mPzCgEJVm6duw8nRkRg5QAT9iPWnstcdA5/KBajirl
 CDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412181; x=1713016981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FMqfUdl76G4qBulxCLMeh65myWO0ylZWG10h5H0frZ8=;
 b=kZwDWFyKbzrCDaPjDhCSSVhQCvIkx+XppRv3v6n2mUbBgZ9XNR80ng9D3TDOuDFn4t
 HSnWjwxX3mZVyfITfNJTQFwjkCLvjhA7OJC+P0PzxYFaiaYAHCcEpYGi0AOmpz+NpSYH
 ZGyEEbKW/+cwQaFxsOQsigLjsATiPvNM1LKTI3u+XPo8JTRMK9jZgmMxpG/Am4FdUXCf
 DjV2hWNWRxWJ/JeX9z4+6H4GQJ7rkNp3eFaRpWvSymuHpjBYCt2957PBwm+ReJCaSOTe
 H60DGTMMoAC2Qdrp3Cmvz4L2KBhHG9OaYbBVtAjqkTY60hwYvkLCOOHxZ6etvCUO53BI
 o6jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOLYjgsmaMapjozKWejQroSC/UyFSXtEeJhAxnm1FTIiXdG7vostdhOZ/fNXOWwNQ2X0a6sOKi/TljahneWNku7Mz54Q==
X-Gm-Message-State: AOJu0YzYyqfgT6uN2TtB0SLdZyRVfj5pWkuhAp4cOlvuaXXSnwmlXfq/
 m3A6QwI1kyK3zFxLWSSHlA+lDZoL7sapQEjDRMQ36VX11l3mBKVsqJIeMtNPn4s=
X-Google-Smtp-Source: AGHT+IFW1oIR0liZcaJAhYfSUcfg7cPWlQ3kzhNweQu+9/cxnEaRi/GPtq9wvYDisi0taOWPWs2kgA==
X-Received: by 2002:a05:600c:3acd:b0:416:3aa1:54ad with SMTP id
 d13-20020a05600c3acd00b004163aa154admr1205820wms.0.1712412181340; 
 Sat, 06 Apr 2024 07:03:01 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:03:01 -0700 (PDT)
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
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v1 4/4] efi_selftest: add tests for setvariableRT
Date: Sat,  6 Apr 2024 17:02:00 +0300
Message-Id: <20240406140203.248211-10-ilias.apalodimas@linaro.org>
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

