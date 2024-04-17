Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF900C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 10:20:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B8498846F;
	Wed, 17 Apr 2024 12:19:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yREKFCcz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B935B88473; Wed, 17 Apr 2024 12:19:53 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E38088461
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 12:19:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so1067712f8f.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 03:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713349190; x=1713953990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMd8OlxBtIIcuMk5RTxGzDKRyct5SClUuz0w1Aajvpk=;
 b=yREKFCcztr/uj1SYsc6oc8NzLqnezuPB3janjAccjd7ls1lEi3qyYNregdt0bde5O1
 611vU/lct56bUmI1p3S8RGbVK5HD7J9zOMQRNUPGqIXUj9xX2XSbp6gg8hXDNOgfzG6L
 UNPhRUSM4Pkth/BaIbJ5vf5d0/WUFC3elf843OIMXrUN4j8xIDxoVujcaeXTLTzOzZqk
 dRogo2pY5NLLhF31v74ZLLGJLn+6PWcbVTlA5fQdhDvdvYSdI2C/lWLReO2B2+VTQ68f
 85dVJc7TsYnF/ftSHYecdKiiHcwxY4O+FMWuTQc5V+b+WwrY1ymi8gcD9oBbF7P+ZFHP
 ne0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713349190; x=1713953990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMd8OlxBtIIcuMk5RTxGzDKRyct5SClUuz0w1Aajvpk=;
 b=V/ivWXBm4NEXZiudbxUcon2QEqrunFDxrv0GYxzQeJeEwyfgQz2a5tDYFTnl3MXePq
 RZk9O+fzHBwx677kAIUj4fBiAfLgyiMBZaWE9Gv1dTnH/APOixqrxT08QyZQ0Zlu8zl1
 /cqxHBw4mTaCSZwVxVP9kleYrYPCijBZQhXtjYin9T3mElxs5FpYINfI1M3WHE5i+0rM
 85sTVegKXoSf1hgsmKOgGxvl7fGb0iqdBlVHK+CuN4p3cV49M4tFrqj6Dww/aS0c7N7d
 h7NXLltfysycUjilRXDePrjkCgh0fzgg4u+ectzwvDprVCkwpFlkboE+zULyR6ZoXP83
 39yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoR2S+rgtHoskCUm90SE+oCc5K2o073B3QHu38jgdYr5nVzTiQ1BjlhUYp4/SFTZ0qMrFuv0GX+O/PzrSRrtKTC+Sfqw==
X-Gm-Message-State: AOJu0Yx23MRFElcx0fEf+KRNv5xyy6j0X4Kjttsvm9BbMianqnHwlTug
 yIrdjrh0Y9I8qxYXFdF21xIsGro/+dOCmPB5grlarhnNoB0Lo9kO1tOZ/2DRlxs=
X-Google-Smtp-Source: AGHT+IGjz02Bdk+q5h3s8TeDbbb6hSc766vzITfDzu3JUdrJ3PHHDeIJgA27TgGQiujq1ufjwle6gw==
X-Received: by 2002:a5d:5f90:0:b0:341:a640:b516 with SMTP id
 dr16-20020a5d5f90000000b00341a640b516mr12198352wrb.70.1713349190508; 
 Wed, 17 Apr 2024 03:19:50 -0700 (PDT)
Received: from hades.. (ppp089210071137.access.hol.gr. [89.210.71.137])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d488c000000b003472489d26fsm13567780wrq.19.2024.04.17.03.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 03:19:49 -0700 (PDT)
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
 Simon Glass <sjg@chromium.org>, Janne Grunau <j@jannau.net>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
Subject: [PATCH v2 3/4] efi_loader: add an EFI variable with the file contents
Date: Wed, 17 Apr 2024 13:19:24 +0300
Message-Id: <20240417101928.119115-4-ilias.apalodimas@linaro.org>
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

Previous patches enabled SetVariableRT using a RAM backend.
Although EBBR [0] defines a variable format we can teach userspace tools
and write the altered variables, it's better if we skip the ABI
requirements completely.

So let's add a new variable, in its own namespace called "VarToFile"
which contains a binary dump of the updated RT, BS and, NV variables
and will be updated when GetVariable is called.

Some adjustments are needed to do that.
Currently we discard BS-only variables in EBS(). We need to preserve
those on the RAM backend that exposes the variables. Since BS-only
variables can't appear at runtime we need to move the memory masking
checks from efi_var_collect() to efi_get_next_variable_name_mem()/
efi_get_variable_mem() and do the filtering at runtime.

We also need an efi_var_collect() variant available at runtime, in order
to construct the "VarToFile" buffer on the fly.

All users and applications (for linux) have to do when updating a variable
is dd that variable in the file described by "RTStorageVolatile".

Linux efivarfs uses a first 4 bytes of the output to represent attributes
in little-endian format. So, storing variables works like this:

$~ efibootmgr -n 0001
$~ dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c of=/boot/efi/ubootefi.var skip=4 bs=1

[0] https://arm-software.github.io/ebbr/index.html#document-chapter5-variable-storage

Co-developed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 include/efi_variable.h            |  14 ++-
 lib/charset.c                     |   2 +-
 lib/efi_loader/efi_runtime.c      |  19 ++++
 lib/efi_loader/efi_var_common.c   |   6 +-
 lib/efi_loader/efi_var_mem.c      | 146 ++++++++++++++++++------------
 lib/efi_loader/efi_variable.c     |   6 +-
 lib/efi_loader/efi_variable_tee.c |   5 -
 7 files changed, 130 insertions(+), 68 deletions(-)

diff --git a/include/efi_variable.h b/include/efi_variable.h
index 42a2b7c52bef..b545a36aac50 100644
--- a/include/efi_variable.h
+++ b/include/efi_variable.h
@@ -271,13 +271,16 @@ const efi_guid_t *efi_auth_var_get_guid(const u16 *name);
  *
  * @variable_name_size:	size of variable_name buffer in bytes
  * @variable_name:	name of uefi variable's name in u16
+ * @mask:		bitmask with required attributes of variables to be collected.
+ *                      variables are only collected if all of the required
+ *                      attributes match. Use 0 to skip matching
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
@@ -289,12 +292,15 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size, u16 *variable_na
  * @data_size:		size of the buffer to which the variable value is copied
  * @data:		buffer to which the variable value is copied
  * @timep:		authentication time (seconds since start of epoch)
+ * @mask:		bitmask with required attributes of variables to be collected.
+ *                      variables are only collected if all of the required
+ *                      attributes match. Use 0 to skip matching
  * Return:		status code
  */
 efi_status_t __efi_runtime
 efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
-		     u64 *timep);
+		     u64 *timep, u32 mask);
 
 /**
  * efi_get_variable_runtime() - runtime implementation of GetVariable()
@@ -334,4 +340,8 @@ efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
  */
 void efi_var_buf_update(struct efi_var_file *var_buf);
 
+efi_status_t __efi_runtime efi_var_collect_mem(struct efi_var_file *buf,
+					       efi_uintn_t *lenp,
+					       u32 check_attr_mask);
+
 #endif
diff --git a/lib/charset.c b/lib/charset.c
index df4f04074852..182c92a50c48 100644
--- a/lib/charset.c
+++ b/lib/charset.c
@@ -387,7 +387,7 @@ int u16_strcasecmp(const u16 *s1, const u16 *s2)
  *		> 0 if the first different u16 in s1 is greater than the
  *		corresponding u16 in s2
  */
-int u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
+int __efi_runtime u16_strncmp(const u16 *s1, const u16 *s2, size_t n)
 {
 	int ret = 0;
 
diff --git a/lib/efi_loader/efi_runtime.c b/lib/efi_loader/efi_runtime.c
index c8f7a88ba8db..99ad1f35d8f1 100644
--- a/lib/efi_loader/efi_runtime.c
+++ b/lib/efi_loader/efi_runtime.c
@@ -130,6 +130,8 @@ efi_status_t efi_init_runtime_supported(void)
 				EFI_RT_SUPPORTED_CONVERT_POINTER;
 
 	if (IS_ENABLED(CONFIG_EFI_RT_VOLATILE_STORE)) {
+		int s = 0;
+
 		ret = efi_set_variable_int(u"RTStorageVolatile",
 					   &efi_guid_efi_rt_var_file,
 					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
@@ -141,6 +143,23 @@ efi_status_t efi_init_runtime_supported(void)
 			log_err("Failed to set RTStorageVolatile\n");
 			return ret;
 		}
+		ret = efi_set_variable_int(u"VarToFile",
+					   &efi_guid_efi_rt_var_file,
+					   EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					   EFI_VARIABLE_RUNTIME_ACCESS,
+					   sizeof(s),
+					   &s, false);
+		if (ret != EFI_SUCCESS) {
+			log_err("Failed to set VarToFile\n");
+			efi_set_variable_int(u"RTStorageVolatile",
+					     &efi_guid_efi_rt_var_file,
+					     EFI_VARIABLE_BOOTSERVICE_ACCESS |
+					     EFI_VARIABLE_RUNTIME_ACCESS |
+					     EFI_VARIABLE_READ_ONLY,
+					     0, NULL, false);
+
+			return ret;
+		}
 		rt_table->runtime_services_supported |= EFI_RT_SUPPORTED_SET_VARIABLE;
 	}
 
diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
index aa8feffd3ec1..7862f2d6ce8a 100644
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
diff --git a/lib/efi_loader/efi_var_mem.c b/lib/efi_loader/efi_var_mem.c
index 6c21cec5d457..65ab858c926e 100644
--- a/lib/efi_loader/efi_var_mem.c
+++ b/lib/efi_loader/efi_var_mem.c
@@ -36,9 +36,11 @@ efi_var_mem_compare(struct efi_var_entry *var, const efi_guid_t *guid,
 	const u16 *data, *var_name;
 	bool match = true;
 
-	for (guid1 = (u8 *)&var->guid, guid2 = (u8 *)guid, i = 0;
-	     i < sizeof(efi_guid_t) && match; ++i)
-		match = (guid1[i] == guid2[i]);
+	if (guid) {
+		for (guid1 = (u8 *)&var->guid, guid2 = (u8 *)guid, i = 0;
+			i < sizeof(efi_guid_t) && match; ++i)
+			match = (guid1[i] == guid2[i]);
+	}
 
 	for (data = var->name, var_name = name;; ++data) {
 		if (match)
@@ -184,53 +186,6 @@ u64 __efi_runtime efi_var_mem_free(void)
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
@@ -261,11 +216,7 @@ efi_status_t efi_var_mem_init(void)
 	efi_var_buf->magic = EFI_VAR_FILE_MAGIC;
 	efi_var_buf->length = (uintptr_t)efi_var_buf->var -
 			      (uintptr_t)efi_var_buf;
-	/* crc32 for 0 bytes = 0 */
 
-	ret = efi_create_event(EVT_SIGNAL_EXIT_BOOT_SERVICES, TPL_CALLBACK,
-			       efi_var_mem_notify_exit_boot_services, NULL,
-			       NULL, &event);
 	if (ret != EFI_SUCCESS)
 		return ret;
 	ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE, TPL_CALLBACK,
@@ -276,10 +227,75 @@ efi_status_t efi_var_mem_init(void)
 	return ret;
 }
 
+/**
+ * efi_var_collect_mem() - Copy EFI variables matching attributes mask from
+ *                         efi_var_buf
+ *
+ * @buf:	buffer containing variable collection
+ * @lenp:	buffer length
+ * @mask:	mask of matched attributes
+ *
+ * Return:	Status code
+ */
+efi_status_t __efi_runtime
+efi_var_collect_mem(struct efi_var_file *buf, efi_uintn_t *lenp, u32 mask)
+{
+	static struct efi_var_file __efi_runtime_data hdr = {
+		.magic = EFI_VAR_FILE_MAGIC,
+	};
+	struct efi_var_entry *last, *var, *var_to;
+
+	hdr.length = sizeof(struct efi_var_file);
+
+	var = efi_var_buf->var;
+	last = (struct efi_var_entry *)
+	       ((uintptr_t)efi_var_buf + efi_var_buf->length);
+	if (buf)
+		var_to = buf->var;
+
+	while (var < last) {
+		u32 len;
+		struct efi_var_entry *var_next;
+
+		efi_var_mem_compare(var, NULL, u"", &var_next);
+		len = (uintptr_t)var_next - (uintptr_t)var;
+
+		if ((var->attr & mask) != mask) {
+			var = (void *)var + len;
+			continue;
+		}
+
+		hdr.length += len;
+
+		if (buf && hdr.length <= *lenp) {
+			efi_memcpy_runtime(var_to, var, len);
+			var_to = (void *)var_to + len;
+		}
+		var = (void *)var + len;
+	}
+
+	if (!buf && hdr.length <= *lenp) {
+		*lenp = hdr.length;
+		return EFI_INVALID_PARAMETER;
+	}
+
+	if (!buf || hdr.length > *lenp) {
+		*lenp = hdr.length;
+		return EFI_BUFFER_TOO_SMALL;
+	}
+	hdr.crc32 = crc32(0, (u8 *)buf->var,
+			  hdr.length - sizeof(struct efi_var_file));
+
+	efi_memcpy_runtime(buf, &hdr, sizeof(hdr));
+	*lenp = hdr.length;
+
+	return EFI_SUCCESS;
+}
+
 efi_status_t __efi_runtime
 efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 		     u32 *attributes, efi_uintn_t *data_size, void *data,
-		     u64 *timep)
+		     u64 *timep, u32 mask)
 {
 	efi_uintn_t old_size;
 	struct efi_var_entry *var;
@@ -291,11 +307,22 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 	if (!var)
 		return EFI_NOT_FOUND;
 
+	/*
+	 * This function is used at runtime to dump EFI variables.
+	 * The memory backend we keep around has BS-only variables as
+	 * well. At runtime we filter them here
+	 */
+	if (mask && !((var->attr & mask) == mask))
+		return EFI_NOT_FOUND;
+
 	if (attributes)
 		*attributes = var->attr;
 	if (timep)
 		*timep = var->time;
 
+	if (!u16_strcmp(variable_name, u"VarToFile"))
+		return efi_var_collect_mem(data, data_size, EFI_VARIABLE_NON_VOLATILE);
+
 	old_size = *data_size;
 	*data_size = var->length;
 	if (old_size < var->length)
@@ -315,7 +342,8 @@ efi_get_variable_mem(const u16 *variable_name, const efi_guid_t *vendor,
 
 efi_status_t __efi_runtime
 efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
-			       u16 *variable_name, efi_guid_t *vendor)
+			       u16 *variable_name, efi_guid_t *vendor,
+			       u32 mask)
 {
 	struct efi_var_entry *var;
 	efi_uintn_t len, old_size;
@@ -324,6 +352,7 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
 	if (!variable_name_size || !variable_name || !vendor)
 		return EFI_INVALID_PARAMETER;
 
+skip:
 	len = *variable_name_size >> 1;
 	if (u16_strnlen(variable_name, len) == len)
 		return EFI_INVALID_PARAMETER;
@@ -347,6 +376,11 @@ efi_get_next_variable_name_mem(efi_uintn_t *variable_name_size,
 	efi_memcpy_runtime(variable_name, var->name, *variable_name_size);
 	efi_memcpy_runtime(vendor, &var->guid, sizeof(efi_guid_t));
 
+	if (mask && !((var->attr & mask) == mask)) {
+		*variable_name_size = old_size;
+		goto skip;
+	}
+
 	return EFI_SUCCESS;
 }
 
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index abc2a3402f42..4aaa05a617d7 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -209,14 +209,16 @@ efi_get_variable_int(const u16 *variable_name, const efi_guid_t *vendor,
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
diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index dde135fd9f81..4f1aa298da13 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -959,11 +959,6 @@ void efi_variables_boot_exit_notify(void)
 		log_err("Unable to notify the MM partition for ExitBootServices\n");
 	free(comm_buf);
 
-	/*
-	 * Populate the list for runtime variables.
-	 * asking EFI_VARIABLE_RUNTIME_ACCESS is redundant, since
-	 * efi_var_mem_notify_exit_boot_services will clean those, but that's fine
-	 */
 	ret = efi_var_collect(&var_buf, &len, EFI_VARIABLE_RUNTIME_ACCESS);
 	if (ret != EFI_SUCCESS)
 		log_err("Can't populate EFI variables. No runtime variables will be available\n");
-- 
2.40.1

