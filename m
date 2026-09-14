Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC42AC88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61B478107C;
	Mon, 14 Sep 2026 14:18:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oJE2vWX7KXzG; Mon, 14 Sep 2026 14:18:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org DCB3680E14
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395488;
	b=P8EYApgA3wd22LRXT66nc7vLIyKMVg7ZBRKVuv4qNNtxov7xvN1inw6XT5V7TYZKv7UJ
	 qjsGfZBFsV4VdyNT3eRnctNn7Ni1Ten2/R+nOJxk+q/t38krmeQ+rxyEQcn1IDk4ry5rJ
	 F73Xsf2DrbzXlv01rH1AMOAsfQ7Kuqj24SMVSOV25thaNe21Hbenc+1RPIhBNcWkPKe6P
	 N7h4EzxfQ9PeN2bOCwHgQQMeoMKOcLJtAk6JBuq/8nm8i5QarFDc2innIwSrm/3GamEBC
	 ANW+YhZs+Ky8Qw6HEm2OFzRR6fT012z6c7sq9UYYslZZ1WxgsLBOVnTRbebsqCtho9g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395488;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BJg/ZSdA1qjFxBAEQTv/TBOQLRwnTdI70KN3EMkfO7Y=;
	b=cehe/20bf2RPxwmKp35/IBRh2R2wRjwpHDF8zyiEYMkZSpcOWStjdFEL8YWM6NiWhXxi
	 jEryqjGKmGkXqvBqHfQnZf6FWTpBdexYwe+PZzFj6H8IN5gT+dccKy820GG4Hihyrq1D/
	 LsB4dlVWiuxxes9G/EzOeR3K7uEcIy7hsiV/lSNfhMnsbz9ZQW6Ec4n3PEMhvbozvMK9r
	 LaP6PxOKPxyDi5oH11q93Bzp1q7gSmvMDPDBvbOz56jQLX3OyxOOV+pSmPQ4TgqmPij5o
	 itf8nTuTLuNJkJFg1fDRxP/Sdn/iPbcX1bQcDbMOnWS3azi59Zg9Opsnn79tG+1RBjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395488;
	bh=BJg/ZSdA1qjFxBAEQTv/TBOQLRwnTdI70KN3EMkfO7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gjTlLbaM9G3j6zPz/lvK3u4ohNYREpdoQ3z++0Gdc7MpXDz8FWJuLGDCkqRVTLB63
	 uKyVPiG/UwJaXIabBvcTAIrVmzv5lg6C0a/u08TLKkmoOUj+h01jxtutPCXuuLWESF
	 FyWR2Z3cJp+XsWzFvXxzT/p7jwOH3P0XBBYVmcTQGHHsLb0ZsWlnPL5Fs073hOBMGs
	 rIqYkZOIvOa+rPnjUI2uPH186p0J7rOBjN1/LpRKjip5rAPWyjzN9kCqSKm/S6RhwB
	 7dsdEuQZ1xLzULXI4WJeIky0afxwpNUhkkwuN6gp14rt62WXmuXhymjZ3rMD09o7DC
	 JbIu7X3UGC+KA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DCB3680E14;
	Mon, 14 Sep 2026 14:18:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B81DB465
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9DF0D4052C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dVLPL0DgnuJK for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org ACF754063E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=qoJQ6+/ZjBF6oKnXPD4VS/LAaEA1Rx5IxPndxB2tFJ0QAQBcE8RD+pLvL6ElteDrSywh
 gjcN0Pol5yqL8OvL4wmH05sy25Y9lSrzsF7jJP3PfRh3cbPAIM6jifcOOlSb6HVpTcnvh
 EaJGd6yF9s07uiLndBMPR/4Cq+lf7BqoZQos4pQ6KGf8Ix3h3V49p1zcu8gD8Aq/IaaII
 9WIoAcVPFidbSZmCabUiwrr9Nh9RKLrkl5RA+X/9UQnUXzBQp2vEZC0k5K7szF2IhnsmE
 ijBqAlu9P2NOCeRApH2UEbYU2mQDbU6lCdD9LeOjvWH/bXCesHlBVxohzYy+OgfYa/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=BJg/ZSdA1qjFxBAEQTv/TBOQLRwnTdI70KN3EMkfO7Y=;
 b=cZnTDN7OSZtkw38njv6ONTErKhSeIaLqoTZQoY0LllNzjfRI2qhOGA8zXFt/S5MblWs9
 a58hVAOMdGnp7++lMxs1IomoGQ7L/LGwfPyaugw2OOgmVmOuM37P6drNtpb9vlvxMsr4S
 ShjUpe1Dv4/DoItqiAUj+rz4WjYsgojIxk3BG/MFuBLkKROkByIjMENZkCrd/aXcZUgFS
 K8Oe2TdG+dKsyNoXDjDDZ/raWQwJdMQoMHSssxfQDppKHbh9e134NHUXlLosxFo/IOIwh
 clFHfb0Nc2lI1JttZaLF0yPVvzXEC8O8l4GYBAH8kB/GS/6zfVmdB7nWPyKKO8FFQdA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=h1t3w5d1; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=h1t3w5d1
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACF754063E
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B8121E2F;
 Mon, 14 Sep 2026 04:01:44 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1D9A3F9A2;
 Mon, 14 Sep 2026 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383708; bh=EIQeDuVi+Q2JAr4X7xRTwimVOTGFFazt4GFceBP8JWE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h1t3w5d1Vd2YKEIZCSvBM+7IqDhjviASgLmOwpsX3NnYzUMKfaR9Nkv+KarRkFkWB
 GLay4HKod1YjIAR5uODstmWU1NxBNxVSmxHSAlh/h322oX4yz4bmrEnZ5xq87momNq
 6ah9lVICjxDfYMP0SCxxMJxgjqy6jmNhiXVaX7g0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 12/22] efi_loader: reserve FF-A shared buffer for runtime
 variables
Date: Mon, 14 Sep 2026 12:00:56 +0100
Message-Id: <20260914110106.1974894-13-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Sep 2026 14:17:12 +0000
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
2.34.1

