Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E504C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 55FE28126A;
	Wed, 29 Jul 2026 12:28:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id teyXxLuoozMW; Wed, 29 Jul 2026 12:28:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 153DA811B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328117;
	bh=NDsBo/n2MsT/ccK0kz+EG/JiK46sh1qbgz+ZJXhssc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mXFmpnfP8hqwYh5Tv1GZFbTxHbTiaGruVcUTxuQYWFqJ/FXn3RNkh0s0e8cOZPWyr
	 MDlDh7dOBf0wSjTaPjfCIEmMt6lUagPYvZPYPEJ9qRuBzwgI4l/XtSHLh2O1N7W96w
	 3Xixqa1rfWdRhCt8Ytxl00hKu8rpdVcl3HVPl+f00lo8ZgZHWrXG6pXPyx0vm7TH8e
	 dJr5ER6UexEVfN/fQsH5srWQIUWO3GrXe4Aoo2xTEofzDW4yY2E5S7xwshv/of41AV
	 wZn1U/gMOzvqSFVpQ/A7yR+gEdIvb8fYO53DTG/cpVxEhmh5z995ez+B1fap1CetfA
	 YXdGB5PttOVxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 153DA811B3;
	Wed, 29 Jul 2026 12:28:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 99A02490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8B95F607E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1N8LvgCcaKZ3 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A958960AC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A958960AC0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A958960AC0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:11 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0708E849AA; Wed, 29 Jul 2026 10:52:10 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B4D3F8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:07 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF8E7169E;
 Wed, 29 Jul 2026 01:52:02 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51903F66F;
 Wed, 29 Jul 2026 01:52:05 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 13/22] efi_loader: enable TEE runtime SetVariable() over
 FF-A
Date: Wed, 29 Jul 2026 09:51:15 +0100
Message-Id: <20260729085124.2618817-14-harsimransingh.tungal@arm.com>
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
 t=1785315127; bh=VaNvIJRkal9W4TxRlOqySNDcqfHpnsO5cUR6tpeH62k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HL6FtZxtAk0MFTbrWYMzRMvW/soS+EpTKRDBamZp+y7EXv/wB2hLErdd063g6zudP
 hLdF0hA1BRP32b4nFnWXcjOyIrBDEM0LlsNrb5zZ91z+ABuRptfNuks7eNkkAihgzf
 UxDDzzCex7IpUAUhVJvj10+wHtW9M8786mb9fuIQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=HL6FtZxt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="HL6FtZxt"; 
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
 lib/efi_loader/efi_variable_tee.c | 147 ++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 5c7104662e9..d04b8dc1376 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -717,6 +717,38 @@ out:
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
@@ -762,6 +794,49 @@ out:
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
@@ -995,7 +1070,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
 		var_property.attributes = attributes;
 		var_property.minsize = 1;
-		var_property.maxsize = var_acc->data_size;
+		var_property.maxsize = data_size;
 		ret = set_property_int(variable_name, name_size, vendor, &var_property);
 	}
 
@@ -1072,7 +1147,7 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
 }
 
 /**
- * efi_set_variable_runtime() - runtime implementation of SetVariable()
+ * efi_set_variable_int_runtime() - runtime implementation of SetVariable()
  *
  * @variable_name:	name of the variable
  * @guid:		vendor GUID
@@ -1082,11 +1157,69 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
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
@@ -1123,7 +1256,7 @@ void efi_variables_boot_exit_notify(void)
 	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_runtime;
-	efi_runtime_services.set_variable = efi_set_variable_runtime;
+	efi_runtime_services.set_variable = efi_set_variable_int_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.34.1

