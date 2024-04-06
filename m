Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C45CD1284
	for <u-boot@archiver.kernel.org>; Sat,  6 Apr 2024 14:02:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DD8288027;
	Sat,  6 Apr 2024 16:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bI6TnO/S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FB7187EA8; Sat,  6 Apr 2024 16:02:37 +0200 (CEST)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D66588027
 for <u-boot@lists.denx.de>; Sat,  6 Apr 2024 16:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d68651e253so35723351fa.0
 for <u-boot@lists.denx.de>; Sat, 06 Apr 2024 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712412154; x=1713016954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xfx58Fx+VretUB6RvdI5IVG6BjbRnfg8/KNb6nU4VHM=;
 b=bI6TnO/Sh5Wnny6J8njLHT8RbXKihiiZluF0iB0hyTC3hw2944D4k9rsb+pfUJJ/1w
 DbpX5BlsZGjzqHi8HdtT44Q3AAE5C99l+GPe5Hmtd0e4ExWnj2St6+cukrKCalGW/dgL
 8wCXgQw3c7UrubaQznvsTdibVRT4GB/ntWI/8CIYdhQXE9LIq2cODulWjotaPoZ38Qv8
 i/vgmu5MWPodZozyQgT5k/iz4iYMeb0YQiFXnAtDxDZKaLZV7Iajn/chIo7dopMt0dcY
 pj0uVQtLyJcYmlSwLzHUt6IRzfLXNCvLfGmOlbSJLf5WGipPZpBjMNsFFonDQbzV/SMM
 88/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712412154; x=1713016954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xfx58Fx+VretUB6RvdI5IVG6BjbRnfg8/KNb6nU4VHM=;
 b=t8rh79Dnh11K+g7Hd0WuMJ0SaIlwYG6CalcOCNePZrGDqJ0TvM5IPe5NEVdpdUkIOh
 PVcbPHImoLONSdFKgGCeCOJOY0BDWegWMrqz09mX1dlRtLm7IzQEyF0S2EidE57A+IZH
 ddasdypR13GJzHk1+pYjRVz4EE6WmiVELOiaphPIM2hcH4UHr19zLHkiKinLNBtqMQo0
 WT3uhBUNTP+bJPFRbvN8gGemWqpIQse14To6loSm7F9Ug/2XasHkTjduHsnfEXk84EZ0
 vQas9tJFXc9AHE3RZGPKiDzS+Vmnh8AG1etN+9rf4hRP8qKWsnqQitNzMLpcQkS9fVYL
 1K2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZBrS9OgXKlVzT2XnE/cJjahWzD5hob3vRkp133KDvBtMo85IpUnH/AeqMRNgZRquDw5QTDzsVk9/phsjnS7GikGykmw==
X-Gm-Message-State: AOJu0Yx/R8/5UYm0VcJ4oY7HW6T6znM4yz0AYdGYvr4PQRDffbuUZ7/w
 0yAbgzeWBAktT+u8ORclr4lerokWZ16+IMhzuKChvl5CpXgkam1OhIcQvxwbpVg=
X-Google-Smtp-Source: AGHT+IEp5xGmW6nazcSQxuPl99Wfs8TNSvcTW11qLfci0RtqDC537nZM7V5KQPSrqPho+Ga5WApi1w==
X-Received: by 2002:a2e:88cc:0:b0:2d4:7829:4d11 with SMTP id
 a12-20020a2e88cc000000b002d478294d11mr2977633ljk.39.1712412152893; 
 Sat, 06 Apr 2024 07:02:32 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004163de6cfabsm1729756wms.11.2024.04.06.07.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Apr 2024 07:02:32 -0700 (PDT)
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
Subject: [PATCH v1 3/4] efi_loader: add an EFI variable with the variable file
 contents
Date: Sat,  6 Apr 2024 17:01:54 +0300
Message-Id: <20240406140203.248211-4-ilias.apalodimas@linaro.org>
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

Previous patches enabled SetVariableRT using a RAM backend.
Although EBBR [0] defines a variable format we can teach userspace tools
and write the altered variables, it's better if we skip the ABI
requirements completely.

So let's add a new variable, in its own namespace called "VarToFile"
which contains a binary dump of the updated RT, BS and, NV variables.

Some adjustments are needed to do that. Currently we discard BS-only
variables in EBS(). We need to preserve those on the OS RAM backend
that exposes the variables. Since BS-only variables can't appear at RT
we need to move the memory masking checks from efi_var_collect() to
efi_get_next_variable_name_mem()/efi_get_variable_mem() and do the
filtering at runtime. We also need to make efi_var_collect() available
at runtime, in order to construct the "VarToFile" buffer with BS, RT &
NV variables.

All users and applications (for linux) have to do when updating a variable
is dd that variable in the file described by "RTStorageVolatile".

Linux efivarfs uses a first 4 bytes of the output to represent attributes
in little-endian format. So, storing variables works like this:

$~ efibootmgr -n 0001
$~ dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c of=/boot/efi/ubootefi.var skip=4 bs=1

[0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage

Suggested-by:Ard Biesheuvel <ardb@kernel.org> # dumping all variables to a variable
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_variable.h            |  15 +++-
 lib/efi_loader/efi_boottime.c     |   2 +
 lib/efi_loader/efi_var_common.c   |  43 +++++------
 lib/efi_loader/efi_var_file.c     |   1 -
 lib/efi_loader/efi_var_mem.c      |  90 ++++++++++-------------
 lib/efi_loader/efi_variable.c     | 118 ++++++++++++++++++++++++------
 lib/efi_loader/efi_variable_tee.c |   1 -
 7 files changed, 164 insertions(+), 106 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 42a2b7c52bef..8963339b9bb6 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -271,13 +271,15 @@ const efi_guid_t *efi_auth_var_get_guid(const u16 *name);
  *
  * @variable_name_size:	size of variable_name buffer in bytes
  * @variable_name:	name of uefi variable's name in u16
+ * @mask:		bitmask with required attributes of variables to be collected.
+ *                      variables are only collected if all of the required
  * @vendor:		vendor's guid
  *
  * Return: status code
  */
 efi_status_t __efi_runtime
 efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_name,
-			       efi_guid_t *vendor);
+			       efi_guid_t *vendor, u32 mask);
 /**
  * efi_get_variable_mem() - Runtime common code across efi variable
  *                          implementations for GetVariable() from
@@ -289,12 +291,14 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_na
  * @data_size:		size of the buffer to which the variable value is copied
  * @data:		buffer to which the variable value is copied
  * @timep:		authentication time (seconds since start of epoch)
+ * @mask:		bitmask with required attributes of variables to be collected.
+ *                      variables are only collected if all of the required
  * Return:		status code
  */
 efi_status_t __efi_runtime
 efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
-		     u64 *timep);
+		     u64 *timep, u32 mask);

 /**
  * efi_get_variable_runtime() - runtime implementation of GetVariable()
@@ -334,4 +338,11 @@ efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
  */
 void efi_var_buf_update(struct efi_var_file *var_buf);

+/**
+ * efi_prealloced_rt_memory() - Get a pointer to preallocated EFI memory
+ *                              available at runtime
+ *
+ * Return: pointer to preallocated runtime usable buffer
+ */
+void __efi_runtime *efi_prealloced_rt_memory(void);
 #endif
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index 1951291747cd..39481c89a688 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -97,6 +97,8 @@ const efi_guid_t efi_guid_load_file_protocol = EFI_LOAD_FILE_PROTOCOL_GUID;
 const efi_guid_t efi_guid_load_file2_protocol = EFI_LOAD_FILE2_PROTOCOL_GUID;
 /* GUID of the SMBIOS table */
 const efi_guid_t smbios_guid = SMBIOS_TABLE_GUID;
+/* used by special U-Boot variables during SetVariableRT */
+const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;

 static efi_status_t EFIAPI efi_disconnect_controller(
 					efi_handle_t controller_handle,
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index 07b9603d49f3..4abc90e411e7 100644
--- a/lib/efi_loader/efi_var_common.c
+++ b/lib/efi_loader/efi_var_common.c
@@ -182,7 +182,8 @@ efi_get_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
 {
 	efi_status_t ret;

-	ret = efi_get_variable_mem(variable_name, guid, attributes, data_size, data, NULL);
+	ret = efi_get_variable_mem(variable_name, guid, attributes, data_size,
+				   data, NULL, EFI_VARIABLE_RUNTIME_ACCESS);

 	/* Remove EFI_VARIABLE_READ_ONLY flag */
 	if (attributes)
@@ -195,7 +196,8 @@ efi_status_t __efi_runtime EFIAPI
 efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
 				   u16 *variable_name, efi_guid_t *guid)
 {
-	return efi_get_next_variable_name_mem(variable_name_size, variable_name, guid);
+	return efi_get_next_variable_name_mem(variable_name_size, variable_name,
+					      guid, EFI_VARIABLE_RUNTIME_ACCESS);
 }

 /**
@@ -427,18 +429,15 @@ void *efi_get_var(const u16 *name, const efi_guid_t *vendor, efi_uintn_t *size)
  *
  * Return:	Status code
  */
-efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *lenp,
-					    u32 check_attr_mask)
+efi_status_t __efi_runtime
+efi_var_collect(struct efi_var_file **bufp, loff_t *lenp, u32 check_attr_mask)
 {
 	size_t len = EFI_VAR_BUF_SIZE;
 	struct efi_var_file *buf;
 	struct efi_var_entry *var, *old_var;
 	size_t old_var_name_length = 2;

-	*bufp = NULL; /* Avoid double free() */
-	buf = calloc(1, len);
-	if (!buf)
-		return EFI_OUT_OF_RESOURCES;
+	buf = (struct efi_var_file *)efi_prealloced_rt_memory();
 	var = buf->var;
 	old_var = var;
 	for (;;) {
@@ -451,32 +450,26 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
 			return EFI_BUFFER_TOO_SMALL;

 		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
-		memcpy(var->name, old_var->name, old_var_name_length);
-		guidcpy(&var->guid, &old_var->guid);
-		ret = efi_get_next_variable_name_int(
-				&var_name_length, var->name, &var->guid);
+		efi_memcpy_runtime(var->name, old_var->name, old_var_name_length);
+		efi_memcpy_runtime(&var->guid, &old_var->guid, sizeof(efi_guid_t));
+		ret = efi_get_next_variable_name_mem(&var_name_length, var->name,
+						     &var->guid, check_attr_mask);
 		if (ret == EFI_NOT_FOUND)
 			break;
-		if (ret != EFI_SUCCESS) {
-			free(buf);
+		if (ret != EFI_SUCCESS)
 			return ret;
-		}
 		old_var_name_length = var_name_length;
 		old_var = var;

 		data = (u8 *)var->name + old_var_name_length;
 		data_length = (uintptr_t)buf + len - (uintptr_t)data;
-		ret = efi_get_variable_int(var->name, &var->guid,
+		ret = efi_get_variable_mem(var->name, &var->guid,
 					   &var->attr, &data_length, data,
-					   &var->time);
-		if (ret != EFI_SUCCESS) {
-			free(buf);
+					   &var->time, check_attr_mask);
+		if (ret != EFI_SUCCESS)
 			return ret;
-		}
-		if ((var->attr & check_attr_mask) == check_attr_mask) {
-			var->length = data_length;
-			var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
-		}
+		var->length = data_length;
+		var = (struct efi_var_entry *)ALIGN((uintptr_t)data + data_length, 8);
 	}

 	buf->reserved = 0;
@@ -490,5 +483,3 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *

 	return EFI_SUCCESS;
 }
-
-
diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 413e1794e88c..8614e3d34706 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -83,7 +83,6 @@ efi_status_t efi_var_to_file(void)
 error:
 	if (ret != EFI_SUCCESS)
 		log_err("Failed to persist EFI variables\n");
-	free(buf);
 	return ret;
 #else
 	return EFI_SUCCESS;
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 6c21cec5d457..a7af0604733e 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -16,6 +16,7 @@
  * relocation during SetVirtualAddressMap().
  */
 static struct efi_var_file __efi_runtime_data *efi_var_buf;
+static void __efi_runtime_data *efi_rt_prealloced;
 static struct efi_var_entry __efi_runtime_data *efi_current_var;

 /**
@@ -184,53 +185,6 @@ u64 __efi_runtime efi_var_mem_free(void)
 	       sizeof(struct efi_var_entry);
 }

-/**
- * efi_var_mem_bs_del() - delete boot service only variables
- */
-static void efi_var_mem_bs_del(void)
-{
-	struct efi_var_entry *var = efi_var_buf->var;
-
-	for (;;) {
-		struct efi_var_entry *last;
-
-		last = (struct efi_var_entry *)
-		       ((uintptr_t)efi_var_buf + efi_var_buf->length);
-		if (var >= last)
-			break;
-		if (var->attr & EFI_VARIABLE_RUNTIME_ACCESS) {
-			u16 *data;
-
-			/* skip variable */
-			for (data = var->name; *data; ++data)
-				;
-			++data;
-			var = (struct efi_var_entry *)
-			      ALIGN((uintptr_t)data + var->length, 8);
-		} else {
-			/* delete variable */
-			efi_var_mem_del(var);
-		}
-	}
-}
-
-/**
- * efi_var_mem_notify_exit_boot_services() - ExitBootService callback
- *
- * @event:	callback event
- * @context:	callback context
- */
-static void EFIAPI
-efi_var_mem_notify_exit_boot_services(struct efi_event *event, void *context)
-{
-	EFI_ENTRY("%p, %p", event, context);
-
-	/* Delete boot service only variables */
-	efi_var_mem_bs_del();
-
-	EFI_EXIT(EFI_SUCCESS);
-}
-
 /**
  * efi_var_mem_notify_exit_boot_services() - SetVirtualMemoryMap callback
  *
@@ -241,6 +195,7 @@ static void EFIAPI __efi_runtime
 efi_var_mem_notify_virtual_address_map(struct efi_event *event, void *context)
 {
 	efi_convert_pointer(0, (void **)&efi_var_buf);
+	efi_convert_pointer(0, (void **)&efi_rt_prealloced);
 	efi_current_var = NULL;
 }

@@ -261,13 +216,21 @@ efi_status_t efi_var_mem_init(void)
 	efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
 	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
 			      (uintptr_t)efi_var_buf;
-	/* crc32 for 0 bytes = 0 */

-	ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
-			       efi_var_mem_notify_exit_boot_services, NULL,
-			       NULL, &event);
+	/*
+	 * efi_var_collect() needs to run at runtime and provide us
+	 * copies of variables used for the VarToFile variable.
+	 * Preallocate memory equal to the variable storage and
+	 * preserve it to copy variables around
+	 */
+	ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
+				 EFI_RUNTIME_SERVICES_DATA,
+				 efi_size_in_pages(EFI_VAR_BUF_SIZE),
+				 &memory);
 	if (ret != EFI_SUCCESS)
 		return ret;
+	efi_rt_prealloced = (void *)(uintptr_t)memory;
+
 	ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
 			       efi_var_mem_notify_virtual_address_map, NULL,
 			       NULL, &event);
@@ -279,7 +242,7 @@ efi_status_t efi_var_mem_init(void)
 efi_status_t __efi_runtime
 efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
-		     u64 *timep)
+		     u64 *timep, u32 mask)
 {
 	efi_uintn_t old_size;
 	struct efi_var_entry *var;
@@ -291,6 +254,9 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 	if (!var)
 		return EFI_NOT_FOUND;

+	if (mask && !((var->attr & mask) == mask))
+		return EFI_NOT_FOUND;
+
 	if (attributes)
 		*attributes = var->attr;
 	if (timep)
@@ -315,7 +281,8 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,

 efi_status_t __efi_runtime
 efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
-			       u16 *variable_name, efi_guid_t *vendor)
+			       u16 *variable_name, efi_guid_t *vendor,
+			       u32 mask)
 {
 	struct efi_var_entry *var;
 	efi_uintn_t len, old_size;
@@ -324,6 +291,7 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
 	if (!variable_name_size || !variable_name || !vendor)
 		return EFI_INVALID_PARAMETER;

+skip:
 	len = *variable_name_size >> 1;
 	if (u16_strnlen(variable_name, len) == len)
 		return EFI_INVALID_PARAMETER;
@@ -347,6 +315,11 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
 	efi_memcpy_runtime(variable_name, var->name, *variable_name_size);
 	efi_memcpy_runtime(vendor, &var->guid, sizeof(efi_guid_t));

+	if (mask && !((var->attr & mask) == mask)) {
+		*variable_name_size = old_size;
+		goto skip;
+	}
+
 	return EFI_SUCCESS;
 }

@@ -354,3 +327,14 @@ void efi_var_buf_update(struct efi_var_file *var_buf)
 {
 	memcpy(efi_var_buf, var_buf, EFI_VAR_BUF_SIZE);
 }
+
+void __efi_runtime *efi_prealloced_rt_memory(void)
+{
+	char *s;
+	int count = EFI_VAR_BUF_SIZE;
+
+	s = (char *)efi_rt_prealloced;
+	while (count--)
+		*s++ = 0;
+	return efi_rt_prealloced;
+}
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index f97c8c57f75c..4f529169ea54 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -22,6 +22,8 @@
 #include <u-boot/crc.h>
 #include <asm/sections.h>

+static const efi_guid_t __efi_runtime_data efi_guid_efi_rt_var_file =
+						U_BOOT_EFI_RT_VAR_FILE_GUID;
 #ifdef CONFIG_EFI_SECURE_BOOT

 /**
@@ -208,14 +210,16 @@ efi_get_variable_int(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
 		     u64 *timep)
 {
-	return efi_get_variable_mem(variable_name, vendor, attributes, data_size, data, timep);
+	return efi_get_variable_mem(variable_name, vendor, attributes, data_size,
+				    data, timep, 0);
 }

 efi_status_t __efi_runtime
 efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
 			       u16 *variable_name, efi_guid_t *vendor)
 {
-	return efi_get_next_variable_name_mem(variable_name_size, variable_name, vendor);
+	return efi_get_next_variable_name_mem(variable_name_size, variable_name,
+					      vendor, 0);
 }

 /**
@@ -479,6 +483,8 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
 	efi_uintn_t ret;
 	bool append, delete;
 	u64 time = 0;
+	struct efi_var_file *buf;
+	loff_t len;

 	/*
 	 * Authenticated variables are not supported the rest of the checks
@@ -520,30 +526,60 @@ if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
 			return EFI_NOT_FOUND;
 	}

-	if (delete) {
+	if (!delete) {
+		/*
+		 * We always insert new variabes and delete the old one when
+		 * appending
+		 */
+		len = 2 * (u16_strlen(variable_name) + 1) + data_size +
+			sizeof(struct efi_var_entry);
+		if (var && append)
+			 len += 2 * var->length;
+		/*
+		 * We will copy the variable update into VarToFile,
+		 * account for it twice
+		 */
+		len *= 2;
+		if (len > efi_var_mem_free())
+			return EFI_OUT_OF_RESOURCES;
+		if (append && var) {
+			u16 *old_data = var->name;
+
+			for (; *old_data; ++old_data)
+				;
+			++old_data;
+			ret = efi_var_mem_ins(variable_name, vendor, attributes,
+					      var->length, old_data, data_size,
+					      data, time);
+		} else {
+			ret = efi_var_mem_ins(variable_name, vendor, attributes,
+					      data_size, data, 0, NULL, time);
+		}
+	} else {
 		/* EFI_NOT_FOUND has been handled before */
 		attributes = var->attr;
 		ret = EFI_SUCCESS;
-	} else if (append && var) {
-		u16 *old_data = var->name;
-
-		for (; *old_data; ++old_data)
-			;
-		++old_data;
-		ret = efi_var_mem_ins(variable_name, vendor, attributes,
-				      var->length, old_data, data_size, data,
-				      time);
-	} else {
-		ret = efi_var_mem_ins(variable_name, vendor, attributes,
-				      data_size, data, 0, NULL, time);
 	}
-
 	if (ret != EFI_SUCCESS)
 		return ret;
 	/* We are always inserting new variables, get rid of the old copy */
 	efi_var_mem_del(var);

-	return EFI_SUCCESS;
+	/*
+	 * Create a volatile variable that userspace apps can dd and
+	 * update the file contents
+	 */
+	ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+	if (ret != EFI_SUCCESS)
+		return ret;
+	var = efi_var_mem_find(&efi_guid_efi_rt_var_file, u"VarToFile", NULL);
+	if (var)
+		efi_var_mem_del(var);
+
+	ret = efi_var_mem_ins(u"VarToFile", &efi_guid_efi_rt_var_file,
+			      EFI_VARIABLE_RUNTIME_ACCESS, len, buf, 0,
+			      NULL, time);
+	return ret;
 } else

 	return EFI_UNSUPPORTED;
@@ -557,11 +593,11 @@ void efi_variables_boot_exit_notify(void)
 	const efi_guid_t efi_guid_efi_rt_var_file = U_BOOT_EFI_RT_VAR_FILE_GUID;
 	const efi_guid_t rt_prop_guid = EFI_RT_PROPERTIES_TABLE_GUID;
 	efi_status_t ret;
+	struct efi_var_file *buf;
+	loff_t len;
+	bool fail = false;

 	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
-		struct efi_rt_properties_table *rt_prop =
-			efi_get_configuration_table(&rt_prop_guid);
-
 		ret = efi_set_variable_int(u"RTStorageVolatile",
 					   &efi_guid_efi_rt_var_file,
 					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
@@ -569,11 +605,47 @@ void efi_variables_boot_exit_notify(void)
 					   EFI_VARIABLE_READ_ONLY,
 					   sizeof(EFI_VAR_FILE_NAME),
 					   EFI_VAR_FILE_NAME, false);
+		if (ret != EFI_SUCCESS) {
+			fail = true;
+			goto out;
+		}
+
+		ret = efi_var_collect(&buf, &len, EFI_VARIABLE_NON_VOLATILE);
+		if (ret != EFI_SUCCESS) {
+			fail = true;
+			goto out;
+		}
+
+		ret = efi_set_variable_int(u"VarToFile",
+					   &efi_guid_efi_rt_var_file,
+					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					   EFI_VARIABLE_RUNTIME_ACCESS,
+					   len,
+					   buf, false);
 		if (ret != EFI_SUCCESS)
-			rt_prop->runtime_services_supported |= ~EFI_RT_SUPPORTED_SET_VARIABLE;
-		else
-			log_err("Can't RTStorage. SetVariableRT won't be available\n");
+			fail = true;
+out:
+		if (fail) {
+			efi_set_variable_int(u"RTStorageVolatile",
+					     &efi_guid_efi_rt_var_file,
+					     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					     EFI_VARIABLE_RUNTIME_ACCESS |
+					     EFI_VARIABLE_READ_ONLY, 0, 0,
+					     false);
+			efi_set_variable_int(u"VarToFile",
+					     &efi_guid_efi_rt_var_file,
+					     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					     EFI_VARIABLE_RUNTIME_ACCESS, 0, 0,
+					     false);
+		} else {
+			struct efi_rt_properties_table *rt_prop =
+				efi_get_configuration_table(&rt_prop_guid);
+
+			rt_prop->runtime_services_supported |=
+					EFI_RT_SUPPORTED_SET_VARIABLE;
+		}
 	}
+
 	/* Switch variable services functions to runtime version */
 	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index dde135fd9f81..9d0e270591ea 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -969,7 +969,6 @@ void efi_variables_boot_exit_notify(void)
 		log_err("Can't populate EFI variables. No runtime variables will be available\n");
 	else
 		efi_var_buf_update(var_buf);
-	free(var_buf);

 	/* Update runtime service table */
 	efi_runtime_services.query_variable_info =
--
2.37.2

