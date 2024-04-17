Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BA2C04FF9
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3747888476;
	Wed, 17 Apr 2024 12:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ybad0dnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6249088467; Wed, 17 Apr 2024 12:19:59 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BA18847B
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:19:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516d487659bso6533137e87.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713349195; x=1713953995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5mbi9CNku5RtmM+MIL6L/pSl5j85cc0WaO0GSnvMbtk=;
 b=ybad0dnAKmCCm6AVHWu24AxKcxp/3R/8+jEIwhzGMrg4qBk/xXZMxmGK+eo0GGbVYW
 5Gc46tK0M9UboMTa1OmqzmYD6o1cly7z3CJ7elGhY4SdJVQxj2IFNEVRAS5+OO+9LGvZ
 XtJs3TCufC+ml85hyeiRjJDzLFMbCedoJT1x29G8tWEw7vrse+J0CBvQVQA8FW6u6g7F
 sT6tlN3esVHna+B7DMvj8tk6caFXVwQEMsaYxpaZg11m3gGD5uypbKP4L/HQHpy77Esi
 tP0y4GZrca8Ibvh35rk85P8hXB78LB/SKpLZazeGdRc+yz/rgvftB/jyaJpEZReP2ne+
 G60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713349195; x=1713953995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5mbi9CNku5RtmM+MIL6L/pSl5j85cc0WaO0GSnvMbtk=;
 b=s7BFDdHfiJJmeMQvqcds5E5OsoAbrWpGfVSDeDD14X9ZJz58ZCm7NreANWHQPIgP2s
 3ZwKxC8Uhe4wD6AzyddmXbWtDNCcq3K+2usrnL3J0N3ZFsC+d/BLeyQG3xJWTaIdGifT
 iQD4n2F/F2/YHfDeRTIBenXtuD47HuWCRv4rPZWykHVK9DKbbppFxa3BVNAFs9sUxPed
 w7ZuBoId6F8arwNY7K/142MAvU8GWhQ+2D4J9gSJbzDNUvNXPXV+VKbGWWgULiycBEyQ
 6dLxCKtybtfVRK+xJRyL6PdctXURD99M7Xcc0md4ngj49o4IQSJnIYt2HjMlQ2ytpcXb
 YdbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO2V4bfrJ4mF/D40jz2c8cqn0mV6WKo4PLGoP6q7k3dFlTg55QPMxedDQMB09pX5puj2FHHWVrqnVS8MODUQV0DMMI2Q==
X-Gm-Message-State: AOJu0Ywjgt3vyQFuP6rKxE4QYQxUoNgNgHilCDj69yU4qQDgzgp49oC5
 38cZVfKyK97I/a1CtzcRCjSHCG2HPeP3LSNiL33LKcHvE+uKW7z4ae+iMiOGpPg=
X-Google-Smtp-Source: AGHT+IHqNrlq0UxTZtOLKkXW5KhtFoafJ4ubN4IT6zOomWUK/Uar0J/JXOz81rkVTUoJowxJNGxYTA==
X-Received: by 2002:ac2:4e15:0:b0:519:1eba:6381 with SMTP id
 e21-20020ac24e15000000b005191eba6381mr3256954lfr.49.1713349195404; 
 Wed, 17 Apr 2024 03:19:55 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm13567780wrq.19.2024.04.17.03.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 03:19:54 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Janne Grunau <j@jannau.net>, Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 4/4] efi_selftest: add tests for setvariableRT
Date: Wed, 17 Apr 2024 13:19:25 +0300
Message-Id: <20240417101928.119115-5-ilias.apalodimas@linaro.org>
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
index 4c9405c0a7c7..e492b50a43c2 100644
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
+					    sizeof(v2),
+					    v2);
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
2.40.1

