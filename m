Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AA606B2FD
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PpVc3MK4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ZodFCrUF
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 749448169E;
	Tue, 10 Nov 2026 13:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-0RBF2HWQfy; Tue, 10 Nov 2026 13:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E73648167C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316002;
	b=XJ7hOJ/mN56lxPBr39pr366MqWDCpJLxBE92Py9nLa+0xn7gjChC390NyJBFcgzHxCFA
	 gGxOOO3nQFrWIRIVWk48bM2Xu9X+ZKH4ecWxb/iOCkuYfdQpUrN1tntSOWn8+1HwDvUGl
	 6NOlF5mvXVWGVeN1OVJBGUzWXkaK3YLamPZzonud49PPIujhYeTN1LD2vioIzfoicsckg
	 0htAyO4tBgCidGIbvzlKB7XWB2WEpgZuX4DExf+Dl7AUxRxizi0LKSJGnCA8j0svOlRXD
	 yv1+AasowLjburXjahottu7pb/7Ahi2szk6D5FTfjvl138Q050uR28i0PdMmffKbtUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316002;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8bPamKise2oUbHIlJ90Zqfp21CoLPo6suPtS1qSPxIs=;
	b=HZvq0zIxkp+79GBvZYXZ74EP4nXJB3gWo3PtX6vIDyu3hO7cSn8LOCLu5egfP4NCe9vJ
	 Xmb6P3Wzq+okJsqR+Pm80Q4ZCjSSysjf/6BAQkoh17wMiCzjqdfIfJuhZpr4K9cgomELX
	 sdoTI2czTSAv9qIxVQH9tjbfHeUjNR7DEX7bhXPdu7cbG6ygdakVf6Hj/iisPXOmwaBHn
	 0dI/2/PcLzQlP6deh9yRW9as62LX7WjeyO3nZSe6pJ17sMHqRCe0ygK/lkjAvozL6KGIL
	 vwKHlEADpOfiJRXqmGgTs6CxjSvPh+SDpsmVexVQAbPv4g/rZcaM38+00uehPBYWNfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316002;
	bh=8bPamKise2oUbHIlJ90Zqfp21CoLPo6suPtS1qSPxIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PpVc3MK43Wa1NW16PaIOEHsua6c7mE70385VV5ej9Fzm9Fzz7ux7SrLmJZA5wgDfI
	 OlkzmR0o1RJJEr1LeyiNg9UZG6kuQ9rpp9WCfbl9//WRqBCWs5N/v9dsEj+VU2fH29
	 pS7/tkqW1mxskV40G4SQXeY200HYerffTTnRCURdiW4h5MDGK5gYAd4yuU0EdLdTBt
	 qTFiY0SLMRX8ucchW9j5Fa0ZgbNS/QlAiIANt2neJAbZ20hPB0r6ENKchf3KGpns4U
	 AfdOVMR5K9UEMuh//ECZP9i/MdALo707WjsZ4du39eUidPxJQNeGaMUeFo7XQSxjdH
	 Q6xZfucgRew0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E73648167C;
	Tue, 10 Nov 2026 13:06:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 30258731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 163D64076E
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id szuZCJPA3XwR for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org F071A405B0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=ZodFCrUF
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id F071A405B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB4A01E7D;
 Tue, 10 Nov 2026 01:58:29 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACE9B3F632;
 Tue, 10 Nov 2026 01:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304712; bh=EZ40Zdli8lIP38o1bKKv7X2sul+o6wWOATjy8DM8Bew=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZodFCrUF9CXj1Q7KRQ0sG7i74HqiksbwcQy8aeeRqtR0Tr02hlxoC23vg+xl/0WN8
 5tVpWcbOCvwx8aII/zsbMSXzHb0ZYEiLN15fjFDip0La824RMh9VzX35PqJeLH+H7m
 MeYNIRA41zrLcGC7pllgPkgAA7xa2Hhz4iIlPznU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 14/22] efi_loader: enable TEE runtime SetVariable() over
 FF-A
Date: Tue, 10 Nov 2026 09:57:55 +0000
Message-ID: <f1f151301c0bb8a4713bcbed9c9202a189a461c5.1794221712.git.harsimransingh.tungal@arm.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the TEE-backed runtime SetVariable() implementation for the FF-A/MM
variable backend. The runtime path uses EFI runtime-safe memory helpers
and the shared MM communication path so SetVariable() can reach the MM
secure partition after ExitBootServices().

Add runtime-safe variable-property helpers for the SetVariable() path
and use the original data_size argument when restoring the read-only
property maxsize, instead of relying on the MM response buffer.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v7:

Ilias:

- Remove duplicate definition of efi_query_variable_info_runtime

v6:

Ilias:

- Guard TEE runtime handler registration with CONFIG_ARM_FFA_RT_MODE
- Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
- Rename FF-A SetVariable runtime handler with _ffa_runtime suffix
- Reuse runtime-safe property helpers in SetVariable paths

v4:

Ilias:

- Split the runtime SetVariable() support out of the combined runtime
  variable-services patch.

v3:

Simon:

- Return early on the EFI_NOT_FOUND property-get path at runtime
- Use the original data_size for the read-only property maxsize update

Ilias:
- Rename TEE/FF-A runtime handlers to private *_int_runtime names

v2:

Simon:

- Move the read-only property check before `setup_mm_hdr()` in
  efi_set_variable_runtime
- Drop the stale copied boot-path comment
---
 lib/efi_loader/efi_variable_tee.c | 151 +++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 32 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index a03f2091eb4..bff9370180c 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -689,10 +689,10 @@ out:
  * StMM can store internal attributes and properties for variables, i.e enabling
  * R/O variables
  */
-static efi_status_t set_property_int(const u16 *variable_name,
-				     efi_uintn_t name_size,
-				     const efi_guid_t *vendor,
-				     struct var_check_property *var_property)
+static efi_status_t __efi_runtime set_property_int(const u16 *variable_name,
+						   efi_uintn_t name_size,
+						   const efi_guid_t *vendor,
+						   struct var_check_property *var_property)
 {
 	struct smm_variable_var_check_property *smm_property;
 	efi_uintn_t payload_size;
@@ -700,54 +700,52 @@ static efi_status_t set_property_int(const u16 *variable_name,
 	efi_status_t ret;
 
 	payload_size = sizeof(*smm_property) + name_size;
-	if (payload_size > max_payload_size) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
+	if (payload_size > max_payload_size)
+		return EFI_INVALID_PARAMETER;
+
 	comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
 				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET,
 				&ret);
 	if (!comm_buf)
-		goto out;
+		return ret;
 
-	guidcpy(&smm_property->guid, vendor);
+	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
-	memcpy(&smm_property->property, var_property,
-	       sizeof(smm_property->property));
-	memcpy(smm_property->name, variable_name, name_size);
+	efi_memcpy_runtime(&smm_property->property, var_property,
+			   sizeof(smm_property->property));
+	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
 
 	ret = mm_communicate(comm_buf, payload_size);
+	if (!efi_at_runtime())
+		free(comm_buf);
 
-out:
-	free(comm_buf);
 	return ret;
 }
 
-static efi_status_t get_property_int(const u16 *variable_name,
-				     efi_uintn_t name_size,
-				     const efi_guid_t *vendor,
-				     struct var_check_property *var_property)
+static efi_status_t __efi_runtime get_property_int(const u16 *variable_name,
+						   efi_uintn_t name_size,
+						   const efi_guid_t *vendor,
+						   struct var_check_property *var_property)
 {
 	struct smm_variable_var_check_property *smm_property;
 	efi_uintn_t payload_size;
 	u8 *comm_buf = NULL;
 	efi_status_t ret;
 
-	memset(var_property, 0, sizeof(*var_property));
+	efi_memset_runtime(var_property, 0, sizeof(*var_property));
 	payload_size = sizeof(*smm_property) + name_size;
-	if (payload_size > max_payload_size) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
+	if (payload_size > max_payload_size)
+		return EFI_INVALID_PARAMETER;
+
 	comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
 				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET,
 				&ret);
 	if (!comm_buf)
-		goto out;
+		return ret;
 
-	guidcpy(&smm_property->guid, vendor);
+	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
-	memcpy(smm_property->name, variable_name, name_size);
+	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
 
 	ret = mm_communicate(comm_buf, payload_size);
 	/*
@@ -757,14 +755,17 @@ static efi_status_t get_property_int(const u16 *variable_name,
 	 * properties to 0x0 so checking against that is enough for the
 	 * EFI_NOT_FOUND case.
 	 */
-	if (ret == EFI_NOT_FOUND)
+	if (ret == EFI_NOT_FOUND) {
 		ret = EFI_SUCCESS;
+		goto out;
+	}
 	if (ret != EFI_SUCCESS)
 		goto out;
-	memcpy(var_property, &smm_property->property, sizeof(*var_property));
+	efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));
 
 out:
-	free(comm_buf);
+	if (!efi_at_runtime())
+		free(comm_buf);
 	return ret;
 }
 
@@ -1001,7 +1002,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
 		var_property.attributes = attributes;
 		var_property.minsize = 1;
-		var_property.maxsize = var_acc->data_size;
+		var_property.maxsize = data_size;
 		ret = set_property_int(variable_name, name_size, vendor, &var_property);
 	}
 
@@ -1051,6 +1052,85 @@ out:
 	return ret;
 }
 
+/**
+ * efi_set_variable_ffa_runtime() - runtime implementation of SetVariable()
+ *
+ * This function implements the SetVariable() runtime service for OP-TEE
+ * with FF-A runtime transport.
+ *
+ * @variable_name:	name of the variable
+ * @guid:		vendor GUID
+ * @attributes:		attributes of the variable
+ * @data_size:		size of the buffer with the variable value
+ * @data:		buffer with the variable value
+ * Return:		status code
+ */
+static efi_status_t __efi_runtime EFIAPI
+efi_set_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *guid,
+			     u32 attributes, efi_uintn_t data_size,
+			     const void *data)
+{
+	efi_status_t ret, mm_communicate_ret = EFI_SUCCESS;
+	struct var_check_property var_property;
+	struct smm_variable_access *var_acc;
+	efi_uintn_t payload_size;
+	efi_uintn_t name_size;
+	u8 *comm_buf = NULL;
+	bool ro;
+
+	if (!variable_name || variable_name[0] == 0 || !guid)
+		return EFI_INVALID_PARAMETER;
+
+	if (data_size > 0 && !data)
+		return EFI_INVALID_PARAMETER;
+
+	/* Check payload size */
+	name_size = u16_strsize(variable_name);
+	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
+	if (payload_size > max_payload_size)
+		return EFI_INVALID_PARAMETER;
+
+	ro = !!(attributes & EFI_VARIABLE_READ_ONLY);
+	attributes &= EFI_VARIABLE_MASK;
+
+	ret = get_property_int(variable_name, name_size, guid,
+			       &var_property);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
+		return EFI_WRITE_PROTECTED;
+
+	comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
+				SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
+	if (!comm_buf)
+		return ret;
+
+	/* Fill in contents */
+	efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
+	var_acc->data_size = data_size;
+	var_acc->name_size = name_size;
+	var_acc->attr = attributes;
+	efi_memcpy_runtime(var_acc->name, variable_name, name_size);
+	efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_size);
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret != EFI_SUCCESS)
+		mm_communicate_ret = ret;
+
+	if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)) {
+		var_property.revision = VAR_CHECK_VARIABLE_PROPERTY_REVISION;
+		var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
+		var_property.attributes = attributes;
+		var_property.minsize = 1;
+		var_property.maxsize = data_size;
+		ret = set_property_int(variable_name, name_size, guid, &var_property);
+	}
+
+	return (mm_communicate_ret == EFI_SUCCESS) ? ret : mm_communicate_ret;
+}
+
 /**
  * efi_query_variable_info() - get information about EFI variables
  *
@@ -1080,6 +1160,9 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
 /**
  * efi_set_variable_runtime() - runtime implementation of SetVariable()
  *
+ * This function implements the SetVariable() runtime service for OP-TEE
+ * without FF-A runtime transport.
+ *
  * @variable_name:	name of the variable
  * @guid:		vendor GUID
  * @attributes:		attributes of the variable
@@ -1124,12 +1207,16 @@ void efi_variables_boot_exit_notify(void)
 	free(var_buf);
 
 	/* Update runtime service table */
+	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
+	} else {
+		efi_runtime_services.set_variable = efi_set_variable_runtime;
+	}
 	efi_runtime_services.query_variable_info =
 			efi_query_variable_info_runtime;
 	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_runtime;
-	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.43.0

