Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6333C67861
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D98A882B0;
	Sat,  6 Apr 2024 16:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FXSomDGy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A9A2882AD; Sat,  6 Apr 2024 16:02:50 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7EF787FC8
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-415515178ceso21793365e9.0
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412167; x=1713016967; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLCePymBroPg8dvI0tS2hkmlyqZYdv2aHSDV4Y0HTyA=;
 b=FXSomDGyLDGcUIuOSQF5RnmOrJ7WkNalxrxFyWw63KLig2UcrsXUlds3TtWHWGqnQE
 lw8IMpaJ5jZVvwfCFOG260ft3NZZkm5UFksXL4nvDjltVGOJH1gdlG8Jh9kqzk/Fhqzn
 Z5+TB8wsoNaj7m3XwRAvHdiT3ZNOWQUlaK16t+e/50LCiWILVqUlIFF7a+igyFpXYlZX
 advPHJUrGCFJk+5qk+ENNKuvtGTjrIZRhKns6nNBUA1O8fr8gKjGmh5JXmzqj6aYxE6G
 4exPuoNQhvLwkW5Gch9jTBofHeG+dXs7fLGboz7+LRQKZWhwAvcBQTmlVPQ7CAmbPV2M
 TO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412167; x=1713016967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QLCePymBroPg8dvI0tS2hkmlyqZYdv2aHSDV4Y0HTyA=;
 b=fTlaNRnVJbRuuGMRa1lQ+UmTX/6r3U+wkq68J1NqNlWF/DD6HTy3W7BVkPMsTFFFX/
 HwC3YMwMSkZBbcAxTWurH8dwXla9bsJ2uHvN/0O2s455w5eBP+ewxtNATu5iHxjxDl3V
 XTcN4yCvO4SV8lDXnO0FCdl5ZTlP03G9VVXqz0wYh1PIabFQ4KF1+A4Arob908wjmpoa
 1CBrfNhLN3Fecz5weuSjcxBD/4wsSlmjtGSahVJT4wQGkWUt1UiX0faMnhv4GCwRYXRB
 BmXnTfGMBDsOuaO37Z2uXdylxCh7EayOHqe6QxFfuFlqAm8meEHx2c/HrFOze1u5HOEi
 nW3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX2xrHy02h5egRX2ZzNcDIgnjzLWYqX0+K20FyPlePgdn+1xDYy0F08w0fs3ET8VAGYheT/htDgjQwovumff3O/EjpKA==
X-Gm-Message-State: AOJu0YwedbvrsoQzB4bETuEPLuQ8TH3eVpMHDleH/h9jPkG/ikjuROIC
 7MolfJgZEQhqpSN3ecNnqJ7/46xM4app2TsIuhkDrjJF/1owwn4F0Pa1ZmNgnjw=
X-Google-Smtp-Source: AGHT+IE4+L4FQawo1sbFdUMoR8CtFCIXIkSqhOzllYhNb8qCyco9pU5t97Dov5r6JUul0DniruViXA==
X-Received: by 2002:a05:600c:1c10:b0:416:4685:10ca with SMTP id
 j16-20020a05600c1c1000b00416468510camr431132wms.14.1712412167377; 
 Sat, 06 Apr 2024 07:02:47 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:02:47 -0700 (PDT)
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
Subject: [PATCH v1 1/4] efi_loader: conditionally enable SetvariableRT
Date: Sat,  6 Apr 2024 17:01:57 +0300
Message-Id: <20240406140203.248211-7-ilias.apalodimas@linaro.org>
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

When EFI variables are stored on file we don't allow SetVariableRT,
since the OS doesn't know how to access or write that file.  At the same
time keeping the U-Boot drivers alive in runtime sections and performing
writes from the firmware is dangerous -- if at all possible.

For GetVariableRT  we copy runtime variables in RAM and expose them to
the OS. Add a Kconfig option and provide SetVariableRT using the same
memory backend. The OS will be responsible for syncing the RAM contents
to the file, otherwise any changes made during runtime won't persist
reboots.

It's worth noting that the variable store format is defined in EBBR [0]
and authenticated variables are explicitly prohibited, since they have
to be stored on a medium that's tamper and rollback protected.

- pre-patch
$~ mount | grep efiva
efivarfs on /sys/firmware/efi/efivars type efivarfs (ro,nosuid,nodev,noexec,relatime)

$~ efibootmgr -n 0001
Could not set BootNext: Read-only file system

- post-patch
$~ mount | grep efiva
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)

$~ efibootmgr -n 0001
BootNext: 0001
BootCurrent: 0000
BootOrder: 0000,0001
Boot0000* debian        HD(1,GPT,bdae5610-3331-4e4d-9466-acb5caf0b4a6,0x800,0x100000)/File(EFI\debian\grubaa64.efi)
Boot0001* virtio 0      VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,0000000000000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,850000001f000000)/VenHw(e61d73b9-a384-4acc-aeab-82e828f3628b,1600850000000000){auto_created_boot_option}

$~ efivar -p -n 8be4df61-93ca-11d2-aa0d-00e098032b8c-BootNext
GUID: 8be4df61-93ca-11d2-aa0d-00e098032b8c
Name: "BootNext"
Attributes:
        Non-Volatile
        Boot Service Access
        Runtime Service Access
Value:
00000000  01 00

[0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig                        |  16 +++
 lib/efi_loader/efi_runtime.c                  |   5 +
 lib/efi_loader/efi_variable.c                 | 114 ++++++++++++++++--
 .../efi_selftest_variables_runtime.c          |  13 +-
 4 files changed, 135 insertions(+), 13 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index a7c3e05c13a0..b210ceea6d64 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -63,6 +63,22 @@ config EFI_VARIABLE_FILE_STORE
 	  Select this option if you want non-volatile UEFI variables to be
 	  stored as file /ubootefi.var on the EFI system partition.
 
+config EFI_RT_VOLATILE_STORE
+	bool "Allow variable runtime services in volatile storage (e.g RAM)"
+	depends on EFI_VARIABLE_FILE_STORE
+	help
+	  When EFI variables are stored on file we don't allow SetVariableRT,
+	  since the OS doesn't know how to write that file. At he same time
+	  we copy runtime variables in DRAM and support GetVariableRT
+
+	  Enable this option to allow SetVariableRT on the RAM backend of
+	  the EFI variable storage. The OS will be responsible for syncing
+	  the RAM contents to the file, otherwise any changes made during
+	  runtime won't persist reboots.
+	  Authenticated variables are not supported. Note that this will
+	  violate the EFI spec since writing auth variables will return
+	  EFI_INVALID_PARAMETER
+
 config EFI_MM_COMM_TEE
 	bool "UEFI variables storage service via the trusted world"
 	depends on OPTEE
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index 18da6892e796..8ebbea7e5c69 100644
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
@@ -126,6 +127,10 @@ efi_status_t efi_init_runtime_supported(void)
 				EFI_RT_SUPPORTED_SET_VIRTUAL_ADDRESS_MAP |
 				EFI_RT_SUPPORTED_CONVERT_POINTER;
 
+	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
+		rt_table->runtime_services_supported |=
+			EFI_RT_SUPPORTED_SET_VARIABLE;
+
 	/*
 	 * This value must be synced with efi_runtime_detach_list
 	 * as well as efi_runtime_services.
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 6fe3792a12a5..f79041e6bedd 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -218,17 +218,20 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
 	return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
 }
 
-efi_status_t efi_set_variable_int(const u16 *variable_name,
-				  const efi_guid_t *vendor,
-				  u32 attributes, efi_uintn_t data_size,
-				  const void *data, bool ro_check)
+/**
+ * setvariable_allowed() - checks defined by the UEFI spec for setvariable
+ *
+ * @variable_name:	name of the variable
+ * @vendor:		vendor GUID
+ * @attributes:		attributes of the variable
+ * @data_size:		size of the buffer with the variable value
+ * @data:		buffer with the variable value
+ * Return:		status code
+ */
+static efi_status_t __efi_runtime
+setvariable_allowed(const u16 *variable_name, const efi_guid_t *vendor,
+		    u32 attributes, efi_uintn_t data_size, const void *data)
 {
-	struct efi_var_entry *var;
-	efi_uintn_t ret;
-	bool append, delete;
-	u64 time = 0;
-	enum efi_auth_var_type var_type;
-
 	if (!variable_name || !*variable_name || !vendor)
 		return EFI_INVALID_PARAMETER;
 
@@ -260,6 +263,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 	     !(attributes & EFI_VARIABLE_BOOTSERVICE_ACCESS)))
 		return EFI_INVALID_PARAMETER;
 
+	return EFI_SUCCESS;
+}
+
+efi_status_t efi_set_variable_int(const u16 *variable_name,
+				  const efi_guid_t *vendor,
+				  u32 attributes, efi_uintn_t data_size,
+				  const void *data, bool ro_check)
+{
+	struct efi_var_entry *var;
+	efi_uintn_t ret;
+	bool append, delete;
+	u64 time = 0;
+	enum efi_auth_var_type var_type;
+
+	ret = setvariable_allowed(variable_name, vendor, attributes, data_size,
+				  data);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
 	/* check if a variable exists */
 	var = efi_var_mem_find(vendor, variable_name, NULL);
 	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
@@ -452,6 +474,78 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
 			 u32 attributes, efi_uintn_t data_size,
 			 const void *data)
 {
+if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+	struct efi_var_entry *var;
+	efi_uintn_t ret;
+	bool append, delete;
+	u64 time = 0;
+
+	/*
+	 * Authenticated variables are not supported the rest of the checks
+	 * are in setvariable_allowed()
+	 */
+	if (attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
+		return EFI_INVALID_PARAMETER;
+	/* BS only variables are hidden deny writing them */
+	if (!(attributes & EFI_VARIABLE_RUNTIME_ACCESS))
+		return EFI_INVALID_PARAMETER;
+
+	ret = setvariable_allowed(variable_name, vendor, attributes, data_size,
+				  data);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	/* check if a variable exists */
+	var = efi_var_mem_find(vendor, variable_name, NULL);
+	append = !!(attributes & EFI_VARIABLE_APPEND_WRITE);
+	attributes &= ~EFI_VARIABLE_APPEND_WRITE;
+	delete = !append && (!data_size || !attributes);
+
+	if (var) {
+		if (var->attr & EFI_VARIABLE_READ_ONLY ||
+		    !(var->attr & EFI_VARIABLE_NON_VOLATILE))
+			return EFI_WRITE_PROTECTED;
+
+		/* attributes won't be changed */
+		if (!delete && (((var->attr & ~EFI_VARIABLE_READ_ONLY) !=
+		    (attributes & ~EFI_VARIABLE_READ_ONLY))))
+			return EFI_INVALID_PARAMETER;
+		time = var->time;
+	} else {
+		if (!(attributes & EFI_VARIABLE_NON_VOLATILE))
+			return EFI_INVALID_PARAMETER;
+		if (append && !data_size)
+			return EFI_SUCCESS;
+		if (delete)
+			return EFI_NOT_FOUND;
+	}
+
+	if (delete) {
+		/* EFI_NOT_FOUND has been handled before */
+		attributes = var->attr;
+		ret = EFI_SUCCESS;
+	} else if (append && var) {
+		u16 *old_data = var->name;
+
+		for (; *old_data; ++old_data)
+			;
+		++old_data;
+		ret = efi_var_mem_ins(variable_name, vendor, attributes,
+				      var->length, old_data, data_size, data,
+				      time);
+	} else {
+		ret = efi_var_mem_ins(variable_name, vendor, attributes,
+				      data_size, data, 0, NULL, time);
+	}
+
+	if (ret != EFI_SUCCESS)
+		return ret;
+	/* We are always inserting new variables, get rid of the old copy */
+	efi_var_mem_del(var);
+
+	return EFI_SUCCESS;
+} else
+
 	return EFI_UNSUPPORTED;
 }
 
diff --git a/lib/efi_selftest/efi_selftest_variables_runtime.c b/lib/efi_selftest/efi_selftest_variables_runtime.c
index 4700d9424105..4c9405c0a7c7 100644
--- a/lib/efi_selftest/efi_selftest_variables_runtime.c
+++ b/lib/efi_selftest/efi_selftest_variables_runtime.c
@@ -62,9 +62,16 @@ static int execute(void)
 				    EFI_VARIABLE_BOOTSERVICE_ACCESS |
 				    EFI_VARIABLE_RUNTIME_ACCESS,
 				    3, v + 4);
-	if (ret != EFI_UNSUPPORTED) {
-		efi_st_error("SetVariable failed\n");
-		return EFI_ST_FAILURE;
+	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		if (ret != EFI_INVALID_PARAMETER) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
+	} else {
+		if (ret != EFI_UNSUPPORTED) {
+			efi_st_error("SetVariable failed\n");
+			return EFI_ST_FAILURE;
+		}
 	}
 	len = EFI_ST_MAX_DATA_SIZE;
 	ret = runtime->get_variable(u"PlatformLangCodes", &guid_vendor0,
-- 
2.37.2

