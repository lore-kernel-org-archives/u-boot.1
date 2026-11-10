Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E29606B2E8
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UoH3za7m;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=GRqbGTg8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2332781677;
	Tue, 10 Nov 2026 13:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 37MEsg5N1ryb; Tue, 10 Nov 2026 13:06:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E54881603
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315998;
	b=F+L7+0dQ3+RG+dcFynM20ITELv/D7S+DEGcJORkRBkZutrki0weFanjdINOSWgQXGIJe
	 eviD3wevuty0MATZxpMNtH2GQVmdyDStUtvmy5abYf5jTm52q5bzHoh3bDvEQ4caSYW+U
	 SvhTep4ieyxZu2hMdK1p346FlO1pduX2D0a0fjI4DGwqlIf/TXZst+KuRMIpiWSOis5ll
	 DRCdQJyY8RT3yel5SkkuoZmH508XMwt8t/wmFcg4V2vTNHGg6d50VqjYsUa4bg80JJ8AW
	 RFeIWklQhkLuJG6SGDa0I/kHpl6yfNXp4bCGpyg8BWsOsFi/iFoh30Rgrq4Ia6qxXjw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tLp4r1I70GXgIpHklS0JE5mEXTCy9dawT+Pij+JKq4U=;
	b=L56lWUBwKKnqfZ8q0DsYE6hjetmzX3/0tjgWTu34YXJT+y8DlRP7Dv7lxxOUHx+0TGXN
	 iuVItxUGbPYHVf/aSsERwcw3Gp7A3ZKWz62Fch96fQ/NcTCkBV6DL/5vNGPgyd6ugu9Bp
	 EreqR/YkKsL1cF3v+eHU6KzyyHupbwGLkUANeHPK0Yeb96EZPrDA4VLEWmgYEH6N/8YCI
	 L+GZEDKW+LHHLOnyE6WdOkjAEk1WcBVyAA1kglu/jlBIZXWYbc+MC7lERwe5cwq4qKZbV
	 DfDy9OEhRglVnaJdjdGEmaQYm2FpTLyyYThTjrrDdqv7T74yrxDga0hGRUxTaAuDPxw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315998;
	bh=tLp4r1I70GXgIpHklS0JE5mEXTCy9dawT+Pij+JKq4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UoH3za7mmdnJ5W6UGvB2vYQEMAsIXF+qKyWInzeCuoW9Ltj12MyjKPFuyaDfHKrHv
	 B1/kKrsvjXvkfEXgQNz6723UC1CYiBLj4GaoaA0NkBuhWf4Lj8RNL661FqSNmF6Da5
	 vVs4TFR+4by8zPPmAmPouCCVdvtIXlail86hIj3tvLJN74JVyTVv9C+Q6tYv2DD9Py
	 KP8gkXzTzAMusLoAYLYvJhWsHkkcmjGEs6T0m3zdcBcOtInKTebZwMUP5fRROY19IZ
	 iQxNrdIkvAOSKkcUlNhtpqdEHYnLAgiLTojjDMV/znbyrLlAJYEta5FyMtFEjMlj/I
	 yvdhmdQq1zM9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E54881603;
	Tue, 10 Nov 2026 13:06:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC8CA731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CE37A4076E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfCSvoISwh8W for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org EA998407FC
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=GRqbGTg8
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA998407FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8BE81E7D;
 Tue, 10 Nov 2026 01:58:26 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAC003F632;
 Tue, 10 Nov 2026 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304709; bh=TAMesmgTbMImgoyMiHo9FlgCc4Y2n/i5/ocqtbgggy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GRqbGTg8xDkX7GyQX8faBAIDOHjBC3CWzPKsImWiTtXYF6JibnBp8Kc6SOL65CIzj
 wns6y/MVtA7L64TqR4Kv4M8qQj5Mmt/eFj6MTvboAgOuuumkp81waTIx0UmrP3XIRD
 s3Z6yTmRtaJOWnKr2SHj30zE0dxoCf/YHS9jL4zo=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 12/22] efi_loader: reserve FF-A shared buffer for runtime
 variables
Date: Tue, 10 Nov 2026 09:57:53 +0000
Message-ID: <e57efcaaad03e3f0d08e55df28d15ecf334db5fe.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Changelog:
===============

v5:

Ilias:

  - Guard FF-A shared-buffer references for OP-TEE-only builds

v3:

Simon:

- Document the get_comm_buf() ownership contract for boot and runtime
- Zero only the active comm_buf_size in the runtime shared-buffer path
- Add SetVirtualAddressMap() handling for ffa_shared_buf via
  efi_convert_pointer()
- Add a BUILD_BUG_ON() for EFI-page alignment of
  CONFIG_FFA_SHARED_MM_BUF_ADDR

v2:

Ilias, Simon:

- Move shared-buffer reservation to the end of init
- Add a runtime shared-buffer bounds check
- Document the shared-buffer page-alignment assumption
- Reword setup_mm_hdr() documentation
- Narrow mm_var_guid scope
- Update the copyright header
---
 lib/efi_loader/efi_variable_tee.c | 130 +++++++++++++++++++++++++++---
 1 file changed, 119 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 7f35ac7dd22..a03f2091eb4 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -56,9 +56,12 @@ static const char *mm_sp_svc_uuid = MM_SP_UUID;
 static u16 __efi_runtime_data mm_sp_id;
 #endif
 
+#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
+static void *__efi_runtime_data ffa_shared_buf;
+#endif
 extern struct efi_var_file __efi_runtime_data *efi_var_buf;
-static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
-static efi_uintn_t max_payload_size;	/* func + data */
+static efi_uintn_t __efi_runtime_data max_buffer_size;	/* comm + var + func + data */
+static efi_uintn_t __efi_runtime_data max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
 static bool __efi_runtime_data ebs_called;
 
@@ -524,8 +527,64 @@ static efi_status_t __efi_runtime mm_communicate(u8 *comm_buf,
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
+#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
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
+#else
+		return NULL;
+#endif
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
@@ -534,10 +593,11 @@ static efi_status_t __efi_runtime mm_communicate(u8 *comm_buf,
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
@@ -555,16 +615,15 @@ static u8 *setup_mm_hdr(void **dptr, efi_uintn_t payload_size,
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
@@ -1077,6 +1136,20 @@ void efi_variables_boot_exit_notify(void)
 	ebs_called = true;
 }
 
+/**
+ * ffa_shared_buf_notify_virtual_address_map() - SetVirtualAddressMap callback
+ *
+ * @event:	callback event
+ * @context:	callback context
+ */
+#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+static void EFIAPI __efi_runtime
+ffa_shared_buf_notify_virtual_address_map(struct efi_event *event, void *context)
+{
+	efi_convert_pointer(0, (void **)&ffa_shared_buf);
+}
+#endif
+
 /**
  * efi_init_variables() - initialize variable services
  *
@@ -1085,6 +1158,9 @@ void efi_variables_boot_exit_notify(void)
 efi_status_t efi_init_variables(void)
 {
 	efi_status_t ret;
+#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+	struct efi_event *event;
+#endif
 
 	/* Create a cached copy of the variables that will be enabled on ExitBootServices() */
 	ret = efi_var_mem_init();
@@ -1103,5 +1179,37 @@ efi_status_t efi_init_variables(void)
 	if (ret != EFI_SUCCESS)
 		return ret;
 
+#if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT) && IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
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
+#endif
+
 	return EFI_SUCCESS;
 }
-- 
2.43.0

