Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE64DC43458
	for <u-boot@archiver.kernel.org>; Sat, 27 Jun 2026 17:42:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F98D84979;
	Sat, 27 Jun 2026 19:41:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="l4y17AYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC20841C2; Sat, 27 Jun 2026 16:44:45 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id D3FEF8056B
 for <u-boot@lists.denx.de>; Sat, 27 Jun 2026 16:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D981F60;
 Sat, 27 Jun 2026 07:44:37 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.95.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7565E3F905;
 Sat, 27 Jun 2026 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782571482; bh=Z8Nl8UV14SVGSl/R9ozrLzKUx+MmsjNYjWjqDuUSVWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=l4y17AYxX/ZeYIhwEFPrsT9ZALh111GrtwxK8upwQJ7iTbAq7qPRqHH19Tc/eo3W/
 Jequl4y1aGOKPP/mw4kUMm4zSNFKVFz6JjSJYTbNvk4CQTZcyjP3LmdyeuGtGQ5IJ9
 QDO2IoP99ICgxhRWlPr+g4MH7BZ+Wvpa88onxEWw=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugues Kamba Mpiana <hugues.kambampiana@arm.com>,
 Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v3 04/10] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
Date: Sat, 27 Jun 2026 15:44:15 +0100
Message-Id: <20260627144421.2067410-5-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
References: <20260627144421.2067410-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 27 Jun 2026 19:41:26 +0200
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

Route EFI runtime variable APIs through FF-A MM communication

Route EFI runtime variable services through the FF-A/MM backend in
lib/efi_loader/efi_variable_tee.c. After ExitBootServices(),
GetVariable(), SetVariable(), GetNextVariableName(), and
QueryVariableInfo() use the runtime entry points and continue to reach
the MM secure partition.

Keep the existing boot-time helpers unchanged and add runtime service
wrappers for variable access and property handling. Reuse the
runtime-safe setup_mm_hdr() and common mm_communicate() path, which
selects the FF-A transport appropriate for the current phase, and use
the EFI runtime-safe memory helpers in the runtime-only code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 344 ++++++++++++++++++++++++++++--
 1 file changed, 326 insertions(+), 18 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index fe205bdf966..474dd186a3e 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -716,6 +716,38 @@ out:
 	return ret;
 }
 
+static efi_status_t __efi_runtime set_property_int_runtime(const u16 *variable_name,
+							   efi_uintn_t name_size,
+							   const efi_guid_t *vendor,
+							   struct var_check_property *var_property)
+{
+	struct smm_variable_var_check_property *smm_property;
+	efi_uintn_t payload_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	payload_size = sizeof(*smm_property) + name_size;
+	if (payload_size > max_payload_size) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+	comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
+				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET,
+				&ret);
+	if (!comm_buf)
+		return ret;
+
+	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(*vendor));
+	smm_property->name_size = name_size;
+	efi_memcpy_runtime(&smm_property->property, var_property,
+			   sizeof(smm_property->property));
+	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
+
+	ret = mm_communicate(comm_buf, payload_size);
+
+	return ret;
+}
+
 static efi_status_t get_property_int(const u16 *variable_name,
 				     efi_uintn_t name_size,
 				     const efi_guid_t *vendor,
@@ -761,6 +793,49 @@ out:
 	return ret;
 }
 
+static efi_status_t __efi_runtime get_property_int_runtime(const u16 *variable_name,
+							   efi_uintn_t name_size,
+							   const efi_guid_t *vendor,
+							   struct var_check_property *var_property)
+{
+	struct smm_variable_var_check_property *smm_property;
+	efi_uintn_t payload_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	efi_memset_runtime(var_property, 0, sizeof(*var_property));
+	payload_size = sizeof(*smm_property) + name_size;
+	if (payload_size > max_payload_size) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+	comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
+				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET,
+				&ret);
+	if (!comm_buf)
+		return ret;
+
+	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->guid));
+	smm_property->name_size = name_size;
+	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
+
+	ret = mm_communicate(comm_buf, payload_size);
+	/*
+	 * Currently only R/O property is supported in StMM.
+	 * Variables that are not set to R/O will not set the property in StMM
+	 * and the call will return EFI_NOT_FOUND. We are setting the
+	 * properties to 0x0 so checking against that is enough for the
+	 * EFI_NOT_FOUND case.
+	 */
+	if (ret == EFI_NOT_FOUND)
+		return EFI_SUCCESS;
+	if (ret != EFI_SUCCESS)
+		return ret;
+	efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));
+
+	return EFI_SUCCESS;
+}
+
 efi_status_t efi_get_variable_int(const u16 *variable_name,
 				  const efi_guid_t *vendor,
 				  u32 *attributes, efi_uintn_t *data_size,
@@ -848,6 +923,93 @@ out:
 	return ret;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_variable_int_runtime(u16 *variable_name, const efi_guid_t *vendor,
+			     u32 *attributes, efi_uintn_t *data_size, void *data)
+{
+	struct var_check_property var_property;
+	struct smm_variable_access *var_acc;
+	efi_uintn_t payload_size;
+	efi_uintn_t name_size;
+	efi_uintn_t tmp_dsize;
+	u8 *comm_buf = NULL;
+	efi_status_t ret, tmp;
+	u32 var_attr = 0;
+
+	if (!variable_name || !vendor || !data_size) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	/* Check payload size */
+	name_size = u16_strsize(variable_name);
+	if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	/* Trim output buffer size */
+	tmp_dsize = *data_size;
+	if (name_size + tmp_dsize >
+			max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
+		tmp_dsize = max_payload_size -
+				MM_VARIABLE_ACCESS_HEADER_SIZE -
+				name_size;
+	}
+
+	/* Get communication buffer and initialize header */
+	payload_size = MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
+	comm_buf = setup_mm_hdr((void **)&var_acc, payload_size,
+				SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
+	if (!comm_buf)
+		return ret;
+
+	/* Fill in contents */
+	efi_memcpy_runtime(&var_acc->guid, vendor, sizeof(var_acc->guid));
+	var_acc->data_size = tmp_dsize;
+	var_acc->name_size = name_size;
+	var_acc->attr = attributes ? *attributes : 0;
+	efi_memcpy_runtime(var_acc->name, variable_name, name_size);
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret != EFI_SUCCESS && ret != EFI_BUFFER_TOO_SMALL)
+		return ret;
+
+	/* Update with reported data size for trimmed case */
+	*data_size = var_acc->data_size;
+	if (attributes)
+		var_attr = var_acc->attr;
+
+	/* Copy the data if ret is EFI_SUCCESS  */
+	if (ret == EFI_SUCCESS) {
+		if (data)
+			efi_memcpy_runtime(data, (u8 *)var_acc->name + var_acc->name_size,
+					   var_acc->data_size);
+		else
+			ret = EFI_INVALID_PARAMETER;
+	}
+
+	/*
+	 * UEFI > 2.7 needs the attributes set even if the buffer is
+	 * smaller
+	 */
+	if (attributes) {
+		tmp = get_property_int_runtime(variable_name, name_size, vendor,
+					       &var_property);
+		if (tmp != EFI_SUCCESS) {
+			ret = tmp;
+			return ret;
+		}
+		*attributes = var_attr;
+		if (var_property.property &
+		    VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
+			*attributes |= EFI_VARIABLE_READ_ONLY;
+	}
+
+	return ret;
+}
+
 efi_status_t efi_get_next_variable_name_int(efi_uintn_t *variable_name_size,
 					    u16 *variable_name,
 					    efi_guid_t *guid)
@@ -912,6 +1074,68 @@ out:
 	return ret;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_next_variable_name_int_runtime(efi_uintn_t *variable_name_size,
+				       u16 *variable_name, efi_guid_t *guid)
+{
+	struct smm_variable_getnext *var_getnext;
+	efi_uintn_t payload_size;
+	efi_uintn_t out_name_size;
+	efi_uintn_t in_name_size;
+	u8 *comm_buf = NULL;
+	efi_status_t ret;
+
+	if (!variable_name_size || !variable_name || !guid) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	out_name_size = *variable_name_size;
+	in_name_size = u16_strsize(variable_name);
+
+	if (out_name_size < in_name_size) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	if (in_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
+		ret = EFI_INVALID_PARAMETER;
+		return ret;
+	}
+
+	/* Trim output buffer size */
+	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
+		out_name_size = max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
+
+	payload_size = MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
+	comm_buf = setup_mm_hdr((void **)&var_getnext, payload_size,
+				SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
+				&ret);
+	if (!comm_buf)
+		return ret;
+
+	/* Fill in contents */
+	efi_memcpy_runtime(&var_getnext->guid, guid, sizeof(*guid));
+	var_getnext->name_size = out_name_size;
+	efi_memcpy_runtime(var_getnext->name, variable_name, in_name_size);
+	efi_memset_runtime((u8 *)var_getnext->name + in_name_size, 0x0,
+			   out_name_size - in_name_size);
+
+	/* Communicate */
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret == EFI_SUCCESS || ret == EFI_BUFFER_TOO_SMALL) {
+		/* Update with reported data size for trimmed case */
+		*variable_name_size = var_getnext->name_size;
+	}
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	efi_memcpy_runtime(guid, &var_getnext->guid, sizeof(*guid));
+	efi_memcpy_runtime(variable_name, var_getnext->name, var_getnext->name_size);
+
+	return ret;
+}
+
 efi_status_t efi_set_variable_int(const u16 *variable_name,
 				  const efi_guid_t *vendor, u32 attributes,
 				  efi_uintn_t data_size, const void *data,
@@ -994,7 +1218,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
 		var_property.attributes = attributes;
 		var_property.minsize = 1;
-		var_property.maxsize = var_acc->data_size;
+		var_property.maxsize = data_size;
 		ret = set_property_int(variable_name, name_size, vendor, &var_property);
 	}
 
@@ -1045,7 +1269,7 @@ out:
 }
 
 /**
- * efi_query_variable_info() - get information about EFI variables
+ * efi_query_variable_info_int_runtime() - get information about EFI variables
  *
  * This function implements the QueryVariableInfo() runtime service.
  *
@@ -1054,24 +1278,50 @@ out:
  *
  * @attributes:				bitmask to select variables to be
  *					queried
- * @maximum_variable_storage_size:	maximum size of storage area for the
+ * @max_variable_storage_size:		maximum size of storage area for the
  *					selected variable types
- * @remaining_variable_storage_size:	remaining size of storage are for the
+ * @remain_variable_storage_size:	remaining size of storage are for the
  *					selected variable types
- * @maximum_variable_size:		maximum size of a variable of the
+ * @max_variable_size:			maximum size of a variable of the
  *					selected type
  * Return:				status code
  */
 efi_status_t EFIAPI __efi_runtime
-efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
-				u64 *remain_variable_storage_size,
-				u64 *max_variable_size)
+efi_query_variable_info_int_runtime(u32 attributes, u64 *max_variable_storage_size,
+				    u64 *remain_variable_storage_size,
+				    u64 *max_variable_size)
 {
-	return EFI_UNSUPPORTED;
+	struct smm_variable_query_info *mm_query_info;
+	efi_uintn_t payload_size;
+	efi_status_t ret;
+	u8 *comm_buf;
+
+	if (!max_variable_storage_size ||
+	    !remain_variable_storage_size ||
+	    !max_variable_size || !attributes)
+		return EFI_INVALID_PARAMETER;
+
+	payload_size = sizeof(*mm_query_info);
+	comm_buf = setup_mm_hdr((void **)&mm_query_info, payload_size,
+				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
+				&ret);
+	if (!comm_buf)
+		return ret;
+
+	mm_query_info->attr = attributes;
+	ret = mm_communicate(comm_buf, payload_size);
+	if (ret != EFI_SUCCESS)
+		return ret;
+	*max_variable_storage_size = mm_query_info->max_variable_storage;
+	*remain_variable_storage_size =
+			mm_query_info->remaining_variable_storage;
+	*max_variable_size = mm_query_info->max_variable_size;
+
+	return ret;
 }
 
 /**
- * efi_set_variable_runtime() - runtime implementation of SetVariable()
+ * efi_set_variable_int_runtime() - runtime implementation of SetVariable()
  *
  * @variable_name:	name of the variable
  * @guid:		vendor GUID
@@ -1081,11 +1331,69 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
  * Return:		status code
  */
 static efi_status_t __efi_runtime EFIAPI
-efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
-			 u32 attributes, efi_uintn_t data_size,
-			 const void *data)
+efi_set_variable_int_runtime(u16 *variable_name, const efi_guid_t *guid,
+			     u32 attributes, efi_uintn_t data_size,
+			     const void *data)
 {
-	return EFI_UNSUPPORTED;
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
+	ret = get_property_int_runtime(variable_name, name_size, guid,
+				       &var_property);
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
+		ret = set_property_int_runtime(variable_name, name_size, guid, &var_property);
+	}
+
+	return (mm_communicate_ret == EFI_SUCCESS) ? ret : mm_communicate_ret;
 }
 
 /**
@@ -1118,11 +1426,11 @@ void efi_variables_boot_exit_notify(void)
 
 	/* Update runtime service table */
 	efi_runtime_services.query_variable_info =
-			efi_query_variable_info_runtime;
-	efi_runtime_services.get_variable = efi_get_variable_runtime;
+			efi_query_variable_info_int_runtime;
+	efi_runtime_services.get_variable = efi_get_variable_int_runtime;
 	efi_runtime_services.get_next_variable_name =
-			efi_get_next_variable_name_runtime;
-	efi_runtime_services.set_variable = efi_set_variable_runtime;
+			efi_get_next_variable_name_int_runtime;
+	efi_runtime_services.set_variable = efi_set_variable_int_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.34.1

