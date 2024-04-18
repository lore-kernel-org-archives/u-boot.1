Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD0DC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 12:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC96788653;
	Thu, 18 Apr 2024 14:55:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZeMBtFEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55D588864A; Thu, 18 Apr 2024 14:55:26 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4265F88652
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 14:55:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-349c5732fd1so669997f8f.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713444924; x=1714049724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sD7myUhu0NlToBzZBxJAVXRQsqlvJyrZki1WrUbboOE=;
 b=ZeMBtFEeWrTqTe+S+skQd1LbUrAJxg0o5Mn1TWoQN8I8hFveqITdSNrAVg5PRyGOeH
 M9rSAmBy4dqgNhMyT/Cb+cFGju0OkbzByavLDDTVSHbRoOqSab7e2JtYvviin4kJK6cN
 PbLy8f43glNAYxjHwB379dc3+WoP6XS0Rjronnx8hPXm24LgSd2j9GpBPztx6nxNd/th
 JQ10D9HrnZ0DICxqzDDrz94EJ3J8OP58qAIhJEp9ju9QT4gENKR98YRcWnwCGMulNbnh
 OnCHhvZpCH5RQagZG7JVQtb9370LaNaXaGY4fnHt6HO0AQ+3DTmiKvF6INo1NeB8ItOS
 fveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444924; x=1714049724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sD7myUhu0NlToBzZBxJAVXRQsqlvJyrZki1WrUbboOE=;
 b=ZpFRKUFLgbcO9p+lmN3UKIwW4+o1jE4jODNibv0gAhguOuihRu5lFZzQ+6EW6Rr+AG
 tOU+x0PuvbH/2I/6qsz9TD+QGWEh5ncfJ5PVcvFq1BF7oi36S7ixYJyX4JmW6PugdoEJ
 mBP4mfDhYnmfwVbRXWD/9OHzho5dv5WGqxgsC0nQz2pHok6f3i41ia+lbJwIgneC4B/8
 RHfD3fmRQz/uXog1Y3SR5JU7uvKaNUVqiR1Cr2fXkcnmcbzxadxg8Xd0C2AuAXDulthx
 pJ48qXb47jGa8NtD6U97SIDuTW6vT0UQvVZxWukW99kXztGzlmTdy/lFnTdVsqx6cWvw
 ngGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnbYCriRsvlt4SQ5tOWCTm5WvYUsUoAR2Ce0kRTxkpDJ0lTXRy54V5orrx6a6xgG2Eva08tJCzJaikEcwfr7gD+C3d5g==
X-Gm-Message-State: AOJu0Ywnm/aBz1qdr/YWm4qtubpanCHXUx/HDHuIlXnDY8Bf+iSfaE0m
 +oMQORHvL4fuM1kWwhIegQ80kyqelUiMjhrVPA2TiRBe8M62TeD73A6wbGdw2g4=
X-Google-Smtp-Source: AGHT+IFX5LaIgHznsrWqA2YbEZXu1VlW0jaXnuWs2HWR2nIlM3jS2/6wLlEKzaMx+U1JyNBFmJvSwQ==
X-Received: by 2002:a5d:6dd2:0:b0:347:4484:4498 with SMTP id
 d18-20020a5d6dd2000000b0034744844498mr2151345wrz.59.1713444923747; 
 Thu, 18 Apr 2024 05:55:23 -0700 (PDT)
Received: from hades.. (ppp176092141112.access.hol.gr. [176.92.141.112])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a1709060d8b00b00a525a18f748sm847002eji.165.2024.04.18.05.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 05:55:23 -0700 (PDT)
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
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v3 4/4] efi_selftest: add tests for setvariableRT
Date: Thu, 18 Apr 2024 15:54:53 +0300
Message-Id: <20240418125456.50944-5-ilias.apalodimas@linaro.org>
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

Since we support SetVariableRT now add the relevant tests

- Search for the RTStorageVolatile and VarToFile variables after EBS
- Try to update with invalid variales (BS, RT only)
- Try to write a variable bigger than our backend storage
- Write a variable that fits and check VarToFile has been updated
  correclty
- Append to the variable and check VarToFile changes
- Try to delete VarToFile which is write protected
- Try to add/delete runtime variables
- Verify VarToFile contains a valid file format

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 .../efi_selftest_variables_runtime.c          | 197 +++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 986924b881dd..28b4e9e7afa5 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -10,6 +10,8 @@
  */
 
 #include <efi_selftest.h>
+#include <efi_variable.h>
+#include <u-boot/crc.h>
 
 #define EFI_ST_MAX_DATA_SIZE 16
 #define EFI_ST_MAX_VARNAME_SIZE 40
@@ -17,6 +19,8 @@
 static struct efi_boot_services *boottime;
 static struct efi_runtime_services *runtime;
 static const efi_guid_t guid_vendor0 = EFI_GLOBAL_VARIABLE_GUID;
+static const efi_guid_t __efi_runtime_data efi_rt_var_guid =
+						U_BOOT_EFI_RT_VAR_FILE_GUID;
 
 /*
  * Setup unit test.
@@ -41,15 +45,18 @@ static int setup(const efi_handle_t img_handle,
 static int execute(void)
 {
 	efi_status_t ret;
-	efi_uintn_t len;
+	efi_uintn_t len, avail, append_len = 17;
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
@@ -63,11 +70,199 @@ static int execute(void)
 				    EFI_VARIABLE_RUNTIME_ACCESS,
 				    3, v + 4);
 	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		efi_uintn_t prev_len, delta;
+		struct efi_var_entry *var;
+		struct efi_var_file *hdr;
+
 		/* At runtime only non-volatile variables may be set. */
 		if (ret != EFI_INVALID_PARAMETER) {
 			efi_st_error("SetVariable failed\n");
 			return EFI_ST_FAILURE;
 		}
+
+		/* runtime atttribute must be set */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    3, v + 4);
+		if (ret != EFI_INVALID_PARAMETER) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
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
+		 * VarToFile size must change once a variable is inserted
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
+		/* Add an 8byte aligned variable */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v), v);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Delete it by setting the attrs to 0 */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    0, sizeof(v), v);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Add it back */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    sizeof(v), v);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Delete it again by setting the size to 0 */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    0, NULL);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Delete it again and make sure it's not there */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    0, NULL);
+		if (ret != EFI_NOT_FOUND) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/*
+		 * Add a non-aligned variable
+		 * VarToFile updates must include efi_st_var0
+		 */
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    9, v + 4);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		var = efi_var_mem_find(&guid_vendor0, u"efi_st_var0", NULL);
+		if (!var) {
+			efi_st_error("GetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		delta = efi_var_entry_len(var);
+		len = sizeof(data2);
+		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					    &attr, &len, data2);
+		if (ret != EFI_SUCCESS || prev_len + delta != len) {
+			efi_st_error("Get/SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/*
+		 * Append on an existing variable must update VarToFile
+		 * Our variable entries are 8-byte aligned.
+		 * Adding a single byte will fit on the existing space
+		 */
+		prev_len = len;
+		avail = efi_var_entry_len(var) -
+			(sizeof(u16) * (u16_strlen(var->name) + 1) + sizeof(*var)) -
+			var->length;
+		if (avail >= append_len)
+			delta = 0;
+		else
+			delta = ALIGN(append_len - avail, 8);
+		ret = runtime->set_variable(u"efi_st_var0", &guid_vendor0,
+					    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					    EFI_VARIABLE_RUNTIME_ACCESS |
+					    EFI_VARIABLE_APPEND_WRITE |
+					    EFI_VARIABLE_NON_VOLATILE,
+					    append_len, v2);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+		len = sizeof(data2);
+		ret = runtime->get_variable(u"VarToFile", &efi_rt_var_guid,
+					    &attr, &len, data2);
+		if (ret != EFI_SUCCESS || prev_len + delta != len) {
+			efi_st_error("Get/SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+
+		/* Make sure that variable contains a valid file */
+		hdr = (struct efi_var_file *)data2;
+		if (hdr->magic != EFI_VAR_FILE_MAGIC ||
+		    len != hdr->length ||
+		    hdr->crc32 != crc32(0, (u8 *)((uintptr_t)data2 + sizeof(struct efi_var_file)),
+					len - sizeof(struct efi_var_file))) {
+			efi_st_error("VarToFile invalid header\n");
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

