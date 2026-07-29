Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173ECC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D344860B2B;
	Wed, 29 Jul 2026 12:28:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yHlV29fhBWLv; Wed, 29 Jul 2026 12:28:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E147860B16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328116;
	bh=WVQsDCL1IfRVkvJvVTtZNpWzPR21HM2IOjNiFJZJBvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ewn774zL7wuxkjzABq44fdzUs5kHikaRbSSQGfajy9YjtUfD8hb/Mm/uZhnisTCXp
	 VeXyYQU3Y0XAn86uAyzpB7x10PnUrLUTKbIh+CxLI7O9lkUYdPe3hYZAQQSdqyQ3lN
	 Q84Z88DmBe8aqNW7iZuSvZuEYsT32dr+cK+Yh1ND6TgdFPoFlnpbc82NMff3k+8msT
	 ubTxIbm9IfKjGD6WBD91u1b+ZqQejMTe2QZaUBu+/r5mUmuXg7Q3niIsc9Pj12S/pQ
	 S0NJH+0PED+mWLGpId+7WB8+VfyMNGXrJ9w4GITFFTG7N7rFoov8yJ5cUH3GqVzSfO
	 uQi/lmCtF4w9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E147860B16;
	Wed, 29 Jul 2026 12:28:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DCD1B26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FECD80F85
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XdA0GYUAVqLf for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C6A8580F78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6A8580F78
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6A8580F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:09 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A0FB849A1; Wed, 29 Jul 2026 10:52:08 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D5F9E8494B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:05 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22654169C;
 Wed, 29 Jul 2026 01:52:01 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51763F66F;
 Wed, 29 Jul 2026 01:52:03 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 12/22] efi_loader: reserve FF-A shared buffer for runtime
 variables
Date: Wed, 29 Jul 2026 09:51:14 +0100
Message-Id: <20260729085124.2618817-13-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
References: <20260729085124.2618817-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 29 Jul 2026 12:28:13 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=arm.com; s=foss; 
 t=1785315125; bh=7XO1PtyjRLKC7gj4ajgYUNfRmLTsoAxPc9xueyIR2xw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=asNFIKW3ZWp0tnV/oJTZ3hwVk6an50fSPomKb3RiAhAZMhOewgJOmCcfBXUflaKfc
 SofOL+AdfSad7tqALjpDHIA++BCts7OSGvcz1tTJ6gFSK0tZi2M9vtawrnRkw3ffiv
 Xrgopk5q+pcNtztToykzCiuYG7GeCj8i5MXYG0/c=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=asNFIKW3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="asNFIKW3"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use the statically reserved FF-A shared MM buffer for EFI variable
runtime communication after ExitBootServices(), since dynamic allocation
is no longer available.

Keep the shared-buffer pointer convertible across
SetVirtualAddressMap(), add the buffer to the EFI runtime memory map,
and reject runtime requests that do not fit in the configured shared
buffer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 118 +++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 8de258bb36b..5c7104662e9 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -54,9 +54,10 @@ static const char *mm_sp_svc_uuid = MM_SP_UUID;
 static u16 __efi_runtime_data mm_sp_id;
 #endif
 
+static void *__efi_runtime_data ffa_shared_buf;
 extern struct efi_var_file __efi_runtime_data *efi_var_buf;
-static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
-static efi_uintn_t max_payload_size;	/* func + data */
+static efi_uintn_t __efi_runtime_data max_buffer_size;	/* comm + var + func + data */
+static efi_uintn_t __efi_runtime_data max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
 static bool __efi_runtime_data ebs_called;
 
@@ -524,8 +525,60 @@ static efi_status_t __efi_runtime mm_communicate(u8 *comm_buf,
 }
 
 /**
- * setup_mm_hdr() -	Allocate a buffer for StandAloneMM and initialize the
- *			header data.
+ * get_comm_buf() - Obtain a communication buffer for MM/FF-A exchange
+ * @payload_size: size of the payload that will be appended to the
+ *                MM communication header
+ *
+ * This helper returns a buffer suitable for constructing an
+ * EFI_MM_COMMUNICATE message. During the boot phase a new buffer is
+ * dynamically allocated. After ExitBootServices(), dynamic
+ * allocation is no longer permitted, and all runtime communication must
+ * use the statically reserved FF-A shared buffer.
+ *
+ * The caller owns the returned buffer only during the boot phase and
+ * must release it with free(). During the runtime phase, the returned
+ * pointer aliases the static FF-A shared buffer and must not be freed.
+ *
+ * Return:
+ *   Pointer to a valid communication buffer on success.
+ *   NULL if no suitable communication buffer is available.
+ */
+static __efi_runtime u8 *get_comm_buf(efi_uintn_t payload_size)
+{
+	efi_uintn_t comm_buf_size;
+	u8 *comm_buf;
+
+	comm_buf_size = MM_COMMUNICATE_HEADER_SIZE +
+			MM_VARIABLE_COMMUNICATE_SIZE +
+			payload_size;
+
+	/*
+	 * After ExitBootServices(), dynamic allocation is no longer permitted.
+	 * Use the predefined FF-A shared buffer at runtime; otherwise allocate
+	 * a fresh buffer during the boot phase.
+	 */
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+			if (comm_buf_size > CONFIG_FFA_SHARED_MM_BUF_SIZE)
+				return NULL;
+			comm_buf = ffa_shared_buf;
+			if (!comm_buf)
+				return NULL;
+			efi_memset_runtime(comm_buf, 0, comm_buf_size);
+		} else {
+			return NULL;
+		}
+	} else {
+		comm_buf = calloc(1, comm_buf_size);
+		if (!comm_buf)
+			return NULL;
+	}
+	return comm_buf;
+}
+
+/**
+ * setup_mm_hdr() -	Obtain a communication buffer for StandAloneMM and
+ *			initialize the MM header
  *
  * @dptr:		pointer address of the corresponding StandAloneMM
  *			function
@@ -534,10 +587,11 @@ static efi_status_t __efi_runtime mm_communicate(u8 *comm_buf,
  * @ret:		EFI return code
  * Return:		buffer or NULL
  */
-static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
-			efi_uintn_t func, efi_status_t *ret)
+static __efi_runtime u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
+				      efi_uintn_t func, efi_status_t *ret)
 {
-	const efi_guid_t mm_var_guid = EFI_MM_VARIABLE_GUID;
+	static const __efi_runtime_rodata efi_guid_t mm_var_guid =
+		EFI_MM_VARIABLE_GUID;
 	struct efi_mm_communicate_header *mm_hdr;
 	struct smm_variable_communicate_header *var_hdr;
 	u8 *comm_buf;
@@ -555,16 +609,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
 		return NULL;
 	}
 
-	comm_buf = calloc(1, MM_COMMUNICATE_HEADER_SIZE +
-			  MM_VARIABLE_COMMUNICATE_SIZE +
-			  payload_size);
+	comm_buf = get_comm_buf(payload_size);
 	if (!comm_buf) {
 		*ret = EFI_OUT_OF_RESOURCES;
 		return NULL;
 	}
 
 	mm_hdr = (struct efi_mm_communicate_header *)comm_buf;
-	guidcpy(&mm_hdr->header_guid, &mm_var_guid);
+	efi_memcpy_runtime(&mm_hdr->header_guid, &mm_var_guid,
+			   sizeof(mm_hdr->header_guid));
 	mm_hdr->message_len = MM_VARIABLE_COMMUNICATE_SIZE + payload_size;
 
 	var_hdr = (struct smm_variable_communicate_header *)mm_hdr->data;
@@ -1077,6 +1130,18 @@ void efi_variables_boot_exit_notify(void)
 	ebs_called = true;
 }
 
+/**
+ * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap callback
+ *
+ * @event:	callback event
+ * @context:	callback context
+ */
+static void EFIAPI __efi_runtime
+ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, void *context)
+{
+	efi_convert_pointer(0, (void **)&ffa_shared_buf);
+}
+
 /**
  * efi_init_variables() - initialize variable services
  *
@@ -1085,6 +1150,7 @@ void efi_variables_boot_exit_notify(void)
 efi_status_t efi_init_variables(void)
 {
 	efi_status_t ret;
+	struct efi_event *event;
 
 	/* Create a cached copy of the variables that will be enabled on ExitBootServices() */
 	ret = efi_var_mem_init();
@@ -1103,5 +1169,35 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		/*
+		 * The FF-A shared buffer is accessed by EFI runtime services, so
+		 * keep the resident pointer convertible across
+		 * SetVirtualAddressMap() and mark the region as runtime memory.
+		 *
+		 * CONFIG_FFA_SHARED_MM_BUF_ADDR is expected to be EFI-page aligned.
+		 */
+		BUILD_BUG_ON(CONFIG_FFA_SHARED_MM_BUF_ADDR & EFI_PAGE_MASK);
+		ffa_shared_buf = (void *)CONFIG_FFA_SHARED_MM_BUF_ADDR;
+		ret = efi_create_event(EVT_SIGNAL_VIRTUAL_ADDRESS_CHANGE,
+				       TPL_CALLBACK,
+				       ffa_shared_buf_notify_virtual_address_map,
+				       NULL, NULL, &event);
+		if (ret != EFI_SUCCESS)
+			return ret;
+		ret = efi_add_memory_map(CONFIG_FFA_SHARED_MM_BUF_ADDR,
+					 CONFIG_FFA_SHARED_MM_BUF_SIZE,
+					 EFI_RUNTIME_SERVICES_DATA);
+		if (ret != EFI_SUCCESS) {
+			efi_close_event(event);
+			log_err("EFI: failed to add FF-A shared buffer to runtime map (%lu)\n",
+				ret);
+			return ret;
+		}
+		log_info("EFI: FF-A shared buffer runtime map: addr=0x%lx size=0x%lx\n",
+			 (ulong)CONFIG_FFA_SHARED_MM_BUF_ADDR,
+			 (ulong)CONFIG_FFA_SHARED_MM_BUF_SIZE);
+	}
+
 	return EFI_SUCCESS;
 }
-- 
2.34.1

