Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5EEC001CC
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF0248845C;
	Wed, 17 Apr 2024 12:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rQ9jnGDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4879A88344; Wed, 17 Apr 2024 12:19:43 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BC48845C
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-518b9527c60so4422583e87.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713349180; x=1713953980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPghf8TXYvYdo7Ht0e/0AUynb8vjZ4cHYaJHPSUWEZs=;
 b=rQ9jnGDvKfLecBWBK79WukUwCGwWQQFqhPs17YPTNLAf1mMf5UEppo9DQz5+1ABDXa
 dGblrBLmiRK5tcPw4gayEh0itmoqFlBW55d7SXhQOVTjkx0qotRYmVAr0J54SZszyeMD
 cZnhBinvwwZPExPpJMfzHKVH/w9EFuOWjTmyava4veQE2yGjSyirsVN8lhpWQiIIuP5M
 /FNTF/4fyAv/enZ9P99n7UTn/P22FbWazHvJaxB8rVzYSbQ20CrFMXvC2CiX/Gz+F0C1
 9SjOL0Z/WFdOj+24ScLb+q7RAl6NenumnJQOyd89YB97AC9qfzcW0ytbAWqAwmdGkABz
 ApCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713349180; x=1713953980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gPghf8TXYvYdo7Ht0e/0AUynb8vjZ4cHYaJHPSUWEZs=;
 b=Px/LiRypLxo5H9ngcKJ9eY+zqjzI5mdQDuwNBxtyx6/Fji+ZzRAEKsT2b3b2lp6ZaJ
 RFdHKuqd37LSudybsUFbVe7t5Ywg2FTBRVuakf38Lkcw6i2lpf5xo4u/ftLKXgQE/dXu
 B29q/NGe9tXV0xWD1lxz0Goeuz8TX6+SgIZg80tXECuiVC4Sb7zPHZX+mumjKI7i/xiU
 7w7/ryqqKGeTT9z5wLC/f0yhtStB6AqFYGltwAbUCajShX/lEIZTXZbl3akfiODJi3Dq
 pFeA7QCv5EJdtT+PqEwdJn/grez4VBs6Ie9YpShABeM10KY5Ijq5WxwXMmt9ppnVH/ah
 XQlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrQ0ofFtburx3VN8gaXMTEpCYpOH6JM54XdwkYbcIVsmBGsZuPzSrpmVOzo33+n002nEU2a0BVwGJXlhf6s+eL+wqO7A==
X-Gm-Message-State: AOJu0YzdvJEWsOex0hHFkDcmj2CHuAld7l1++pOxxJefhLvaGQqDLdgR
 3ErTNxyK4tYoLxOvxHEySXTq4rPSK3h4F6M9CdevoSNUQ35D613Q1vqt5DRDTGY=
X-Google-Smtp-Source: AGHT+IHe680W7XevDjKJI1atYCBehnTyFrpmc9D8E+DX71Q1igvYo8E92KcbPA2HTXTCEI+ptENUBg==
X-Received: by 2002:a05:6512:46a:b0:515:9aba:743a with SMTP id
 x10-20020a056512046a00b005159aba743amr12277530lfd.59.1713349180024; 
 Wed, 17 Apr 2024 03:19:40 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm13567780wrq.19.2024.04.17.03.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 03:19:39 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de,
	kettenis@openbsd.org
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 quic_llindhol@quicinc.com, ardb@kernel.org, pbrobinson@gmail.com,
 pjones@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Janne Grunau <j@jannau.net>,
 Simon Glass <sjg@chromium.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 1/4]  efi_loader: conditionally enable SetvariableRT
Date: Wed, 17 Apr 2024 13:19:22 +0300
Message-Id: <20240417101928.119115-2-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
References: <20240417101928.119115-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When we store EFI variables on file we don't allow SetVariable at runtime,
since the OS doesn't know how to access or write that file.  At the same
time keeping the U-Boot drivers alive in runtime sections and performing
writes from the firmware is dangerous -- if at all possible.

For GetVariable at runtime we copy runtime variables in RAM and expose them
to the OS. Add a Kconfig option and provide SetVariable at runtime using
the same memory backend. The OS will be responsible for syncing the RAM
contents to the file, otherwise any changes made during runtime won't
persist reboots.

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
 lib/efi_loader/efi_runtime.c                  |   4 +
 lib/efi_loader/efi_variable.c                 | 115 ++++++++++++++++--
 .../efi_selftest_variables_runtime.c          |  13 +-
 4 files changed, 134 insertions(+), 14 deletions(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index e13a6f9f4c3a..cc8371a3bb4c 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -62,6 +62,22 @@ config EFI_VARIABLE_FILE_STORE
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
index a61c9a77b13f..dde083b09665 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -127,6 +127,10 @@ efi_status_t efi_init_runtime_supported(void)
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
index e6c1219a11c8..abc2a3402f42 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -219,17 +219,20 @@ efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
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
 
@@ -261,6 +264,25 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
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
@@ -454,7 +476,78 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *vendor,
 			 u32 attributes, efi_uintn_t data_size,
 			 const void *data)
 {
-	return EFI_UNSUPPORTED;
+	struct efi_var_entry *var;
+	efi_uintn_t ret;
+	bool append, delete;
+	u64 time = 0;
+
+	if (!IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE))
+		return EFI_UNSUPPORTED;
+
+	/*
+	 * Authenticated variables are not supported. The EFI spec
+	 * in §32.3.6 requires keys to be stored in non-volatile storage which
+	 * is tamper and delete resistant.
+	 * The rest of the checks are in setvariable_allowed()
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
+		u16 *old_data = (void *)((uintptr_t)var->name +
+			sizeof(u16) * (u16_strlen(var->name) + 1));
+
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
 }
 
 /**
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
2.40.1

