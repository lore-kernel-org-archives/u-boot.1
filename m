Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8516CCD4851
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 14:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB95846A5;
	Thu, 14 May 2026 16:49:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RuQD6mSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6776F8467F; Thu, 14 May 2026 14:50:01 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E834E83AA9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 14:49:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=harsimransingh.tungal@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADC6C244C;
 Thu, 14 May 2026 05:49:52 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.69.131])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E46343F7B4;
 Thu, 14 May 2026 05:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778762997; bh=B66UcmVKPY6sYq8dLV42+ngLhHnDsTYeM87n3FKvCsQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RuQD6mSjQjR3i7cUTsPYgYfDxf/mBJjjU2KcG/ttG/Z6BAEIsYlLWMO/GhTAbMaQz
 jSG5/ymxovOJx1wvkXSg5/bm37dCoTkjQElq1QYJUj4sH3PSaPBcBza+fuVp2Tk/JT
 vl+xMH5rd0goMUHbDMTV6qug1Zyj3PZJym+kP+QU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: abdellatif.elkhlifi@arm.com, trini@konsulko.com,
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de,
 hugues.kambampiana@arm.com, sjg@chromium.org,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v2 04/11] efi_loader: enable EFI runtime
 SetVariable()/GetVariable() using FF-A transport
Date: Thu, 14 May 2026 13:49:17 +0100
Message-Id: <20260514124924.1804332-5-harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 14 May 2026 16:49:29 +0200
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

Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---

Changelog:
===============

v2:

Simon:

- Cache attributes before reusing the FF-A shared buffer
- Move the read-only property check before `setup_mm_hdr()` in
  efi_set_variable_runtime
- Drop the stale copied boot-path comment
- Split the `u16_strsize()` runtime annotation to a separate patch

 lib/efi_loader/efi_variable_tee.c | 320 +++++++++++++++++++++++++++++-
 1 file changed, 315 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index ccd8d94a51e..8acd0ed127b 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -698,6 +698,38 @@ out:
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
@@ -743,6 +775,49 @@ out:
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
+		ret = EFI_SUCCESS;
+	if (ret != EFI_SUCCESS)
+		return ret;
+	efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));
+
+	return ret;
+}
+
 efi_status_t efi_get_variable_int(const u16 *variable_name,
 				  const efi_guid_t *vendor,
 				  u32 *attributes, efi_uintn_t *data_size,
@@ -830,6 +905,95 @@ out:
 	return ret;
 }
 
+efi_status_t __efi_runtime efi_get_variable_runtime(u16 *variable_name,
+						    const efi_guid_t *vendor,
+						    u32 *attributes,
+						    efi_uintn_t *data_size,
+						    void *data)
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
@@ -894,6 +1058,68 @@ out:
 	return ret;
 }
 
+efi_status_t __efi_runtime efi_get_next_variable_name_runtime(efi_uintn_t *variable_name_size,
+							      u16 *variable_name,
+							      efi_guid_t *guid)
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
@@ -1036,11 +1262,11 @@ out:
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
@@ -1049,7 +1275,33 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
 				u64 *remain_variable_storage_size,
 				u64 *max_variable_size)
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
@@ -1067,7 +1319,65 @@ efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
 			 u32 attributes, efi_uintn_t data_size,
 			 const void *data)
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
+		var_property.maxsize = var_acc->data_size;
+		ret = set_property_int_runtime(variable_name, name_size, guid, &var_property);
+	}
+
+	return (mm_communicate_ret == EFI_SUCCESS) ? ret : mm_communicate_ret;
 }
 
 /**
-- 
2.34.1

