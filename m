Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9694ACC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D4E381011;
	Wed, 14 Oct 2026 20:03:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7hkhIfMaIqkH; Wed, 14 Oct 2026 20:03:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5C7EB810E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008223;
	b=fu6Tmdsgymrt19dgUBZo/h5IghYpl6dMpeEd8PdNNeMl1BfvCpB0eLMlBGbAWUOACiXv
	 DoHj8fq/6ZhSz9KY2CFD966Mrv9P+AV892LTLVcYWxJ2aRSa0eZlHaB9oVbyNVOd2hNML
	 iM/enWh1/K0mG2cQBKjqWA6wxD/ZBhx3Y4+dOQVjN1wTSUSX30qW4+Nz35XUFGX8hniOC
	 kCB7sgAYV++VxH8VoryfYTwvSVkV+K3xChI5EPtue9Qvf4peLVumUKimm7hJkh/fPKKu5
	 a5R/IHPe5gSpcIC+yPj1X2bQGBXWpNiLomnf6ye6Y4+IQVrhaN0/1fKuwWRM3FdlzVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008223;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tLp4r1I70GXgIpHklS0JE5mEXTCy9dawT+Pij+JKq4U=;
	b=X8zjR6+41OBWKclhtbJ+MQaVOHP4hSjue74xs9la8sF7U5B+7WFvzvkGxmZyRh7ggtAF
	 LkHygFsJ6q1z5yl56oeV0ZpFIHEB91RqwLzzTzFrQGGI4O5+go87JsMqOcc5bwxOGCvlk
	 xd2jlYH8SiGgg6dYH/AtFG5CyddDNNgiDJJEgzTjaK4p29jOpbpNcMT28ikX/Va4DYx+K
	 RVwNaBMyuo3k8uQCybmNQuZu9zwyPjWL9WY8WWVMaoSZUwaa3aEE2mSoh7He62HhRr75J
	 wE6IizHksLrbZtTWD4xmG6Q2Wc8uuxnV+E0EtZA5kJn5OcuPi5cusixKwzz0A8QPeuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008223;
	bh=tLp4r1I70GXgIpHklS0JE5mEXTCy9dawT+Pij+JKq4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SBesAz9/lzHaCp5FNKzOuCsTbXkKxNB7mdyU8Ymrer3tMEEDXQnCOjsYpIcxvVm9y
	 Ow0Y44L46qvK4oGFEcvH8zMkHpEZXyouodTSssbNKgGPfXaKKa91wu6MLjIhvs9if9
	 FaPizF2aEB8Tw5OnJ50tHbyC0uZ/PyO/GN1g5t3a34cJr2Nx1i1xwYCpBW0fwz2UE0
	 5z+k2j/xJgvJVinzaoSqa/9VPZv38R6RmnNhpXmGx5hkpseQDmwCDo85plB82zhLYw
	 GL0O9V1XeW8zXoHGT2U0gC9zqBwSsFlxXZhnipYn3tdOGCeMkhaAdaPEyixFmvn4Z/
	 brsvGF/MCTSfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5C7EB810E6;
	Wed, 14 Oct 2026 20:03:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 26A3E4DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0C695407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RxEikP-obzvK for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B80F0407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002211;
 b=MB9mPk6g8MeoEWk04+0T6EqqpeWQPpHEm5oflHAJ8Q94ysdmx+cg3l+EMpV/bdFmKpAN
 CLCrpUOxzR3qfZeUzC3G8/LsXYPP32O5I6xBvDsgHH7E9ff7ijQ1RiiHv3OEnjsWu40Bq
 P15YzDuna9viz/8834of9XvqpHKtSi39VPMp4JnBlyHIyThpS8wZY1FVHlV/0DNLhLb4T
 K2F6tJEpeNZ8eZ/K5Bl3qBngu8Sn24CccedNUsX1ItpgdUqgRGE9w8o32tNkpGZMQzNzv
 KVKpgrw3kbYrLWnNZVV8tF60dYH6ZCIrBs0m1woBVLhPdyzNUvvqQH+rSLtOzx6b5fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002211;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=tLp4r1I70GXgIpHklS0JE5mEXTCy9dawT+Pij+JKq4U=;
 b=pXzWvfWDUTRcp3s2UJp4X3ETTSO1meeZoixJIKHpe2yyvafbuwOz6pWpAdmNxAnVEARo
 Fs1W4zTx8pXycoUwD+KsvmAVMDzpJ8QS9ZWr1qunuZB/dFJFXnkrQsiMZ7Io5+yG6/7p8
 Akt6Z/xRFAPUnMGOlG4TjJLG+RsVBUaS3nooX8chq089Okm4aQ9KtIuohYNxqLQHSQgJ7
 PB2wRZNPOU0oyBg2iPG9nfBUTeLEVrBYhXDaPAS3l2bLmKB5Q5H8hAAVf75gVv4A+r9fn
 urwIcbF9KBXoRG1s0CXP1D2pW+v+apKvVMOjCKNMcpFNebC1vmEDgpsPwiNCL4cw8+A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=IMPxjAQk; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=IMPxjAQk
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id B80F0407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80A79153B;
 Wed, 14 Oct 2026 11:23:27 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D3CD3F871;
 Wed, 14 Oct 2026 11:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002210; bh=TAMesmgTbMImgoyMiHo9FlgCc4Y2n/i5/ocqtbgggy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IMPxjAQk4Am/ZeS3MRMsxKPFpg7hDSNhEzDZj1X8dEkL0H9s5ukC1JLDdSMRtPcwo
 IsRi4N0VOGE1G3CqPOIq5sMRcJSBihMJoeMa+b0+IWwjx2mSvU786h8vTupdTWKbOE
 5GKWpHlW0Qs6imDw9ljTzlC4T6MJAOQGmzl/JZh4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 12/22] efi_loader: reserve FF-A shared buffer for runtime
 variables
Date: Wed, 14 Oct 2026 19:22:52 +0100
Message-ID: <d588710bdb75d3a8d991e82a504c4ad424e2bfee.1792001844.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792001844.git.harsimransingh.tungal@arm.com>
References: <cover.1792001844.git.harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 14 Oct 2026 20:03:15 +0000
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
2.43.0

