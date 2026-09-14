Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EABC88E77
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64F186073E;
	Mon, 14 Sep 2026 14:18:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ODFR3Xez5_ZK; Mon, 14 Sep 2026 14:17:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 6D80D606FF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395479;
	b=spOl4GaFTTeW8heUtv/wjDhBrIsfNnNm73YCmQPfucaCM+3phxVraUs26ekVBHzP3A6S
	 ZrQtFQ4Gm5fLTAXtL3lZ25Pw2Vt+QGXSnYnRW7pH165iJeMRq7+rdQbI/IEu02FICk9FR
	 D/fFLEJa3b9v88uSO5gx//dJNKn5v5HOpNKjclwv9W/Mc2ziGCwmpR0LeqA6R8YGueD/b
	 dCCR/jOHy0GffMjeFEUeRxT399h/CaVC11qG8G9kk8lTgYhErZZHNACEaAK3PfvO7mb5l
	 7wnpROW8nG6KhCAdXWJwaf62wYxm45Iim9ApXYH23pi/zRYxZ4/+vUYQozOM5qdC+iQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2vB7wcUeCc5uxrDZzyl/eNmTpvmaojlr9/IZX2eUyVA=;
	b=Q8fleeIrMlaPN5zW2P4Cd7BBbgKXlIlFgyhMhOrZnbFLcfvxoQGM6Xfnv0c7nAsGHqAy
	 d4uZYwppvA7C5FL08bqGZrxL8R7tz68kNiQXDGfmz2RBXwPNtTFyDqnud/1GB85WDR1ww
	 gF7bi9UyZgd3E2t1q7M87YhDL+pmKrCExXsUsUqv0arOCvArkj6CqHgNMtuMnnvIAqIhj
	 D2W2zuvru/dXZibn4FkS6Yy1stQktKQDnOUAy/Z6y23nhB9azb4HZxcycUZZUROb61d/9
	 PysFGFOLclTXlWBs/CXNj+v0PhpIIWdh3+RYYP6+6fLNgbMBpR+TlikCAP0ULorat/A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395479;
	bh=2vB7wcUeCc5uxrDZzyl/eNmTpvmaojlr9/IZX2eUyVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ysz0du5woUXGCgL0UnieKszxi1hbJEBUHbtAN89I0voWwS2kp5g47GSTeEPwOa0jU
	 3DoF8px11GEREb6qre/l0EbeLasQ86+iUo0xYtIXCDxDE/YnZJcpny61O2Ow+B8q7A
	 ChDDcTrmBB/8vYUaBlAuRJVV/1pK5pbxuq+2+LlsvtCGx8+6NhvFtDAUUrRe+8NuUH
	 M/w7Y/WtxdFhGlNu8k4gLL+VbPGZzihDCWDzvvWfTGh6F0JbR8ScHUp2pnLUZLq3vr
	 yEkhmpzHRwZTrgN6pnAh0+aOJPpgVqvn0NjEqZMoiRsyL1lml9wnE33MzlKoRBhOXt
	 HnZ4mEZ3AJJmQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D80D606FF;
	Mon, 14 Sep 2026 14:17:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id A601249D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 975554052C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7lsqqfhrRsXH for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9F16640639
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=qu2jNq+Ro/B6O43uNWhIsp44nipvtUYuCLbzVcalzB/TJalxwLf+VeOLUoBaOtYm93BC
 sA+aAjIFq29Mv266OC1NLtDT4I7TmiZ+iPX0MS6Zeo4fV71x/giqwbqAHG2mZLtZwZJVi
 CmYBFaOu5nyWvxmAwcFnb66t9Erym8cm55UGGkKL4Sz1BZJr0/erXubi3x7C2uBE7GpJ1
 +o/DD9Aen2FfQ13cPaK9tAjwgCxdpPdTChVNksrIesniIpxsoWZiiMCpyBmrJPjzV4rj1
 vBpKar8Av1zcp0hj0yLomnWvglC1/0FVBhpL2WZmr1UbwfuSSaTSFcGkkDm+1rffu2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=2vB7wcUeCc5uxrDZzyl/eNmTpvmaojlr9/IZX2eUyVA=;
 b=S53ykH/3Zkk/Az0cHUCmYWdhdgU8l/qXS1XUFOcssCUFJHiABRUvQasBjs0z1aSZCkYh
 uzK65EPOrdtcWC2VQkTnVOysmCN1lZc3QNBdC4kiH0I9Sic2TdZYiRL+a08mhLAYiY2dA
 BZLuUvDrFRpgf41ilmi2PqbUoEzUdsmwqwi6+Qfc3sMqqlNde/JyjB2f98TNKOdalXNxu
 NIBv3WTIvPiq+40GlAeHR8o2bwmMn9dP4mbiegUHiQjqQM9WZxTTyboeQoERwL3zLpg3J
 0buQDq44xQ/OpXWdKxWXh8218Orh9UUNfQWqn8TEXLJ0BpcvBxgeYUzr1BvinmOmwSw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=s15JqWNw; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=s15JqWNw
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9F16640639
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DBAF1E32;
 Mon, 14 Sep 2026 04:01:46 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 795E43F86F;
 Mon, 14 Sep 2026 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383709; bh=l2gbjS5a4SKYYflknOPB1HAz+K2RMZtJb1CO2bNoIDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s15JqWNweOVhm/RyLRfSZkJGJnYK8BLQM89jNEPF9+4xE7tJgbOM2/rU3cL4AD+cY
 p9zchBE76a6H9aK+NPeYjQVNtUYxk5j9pIGPtzJd2+a9mzt/E9P/YHhCMFdLGbJv6h
 F1qAluGceLIfKaVjS17Xbs7goeE8Ydd+A6wy/cSM=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable() over
 FF-A
Date: Mon, 14 Sep 2026 12:00:57 +0100
Message-Id: <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
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
 lib/efi_loader/efi_variable_tee.c | 147 ++++++++++++++++++++++++++++--
 1 file changed, 140 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index a03f2091eb4..5f494731ae5 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -723,6 +723,38 @@ out:
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
@@ -768,6 +800,49 @@ out:
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
@@ -1001,7 +1076,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
 		var_property.attributes = attributes;
 		var_property.minsize = 1;
-		var_property.maxsize = var_acc->data_size;
+		var_property.maxsize = data_size;
 		ret = set_property_int(variable_name, name_size, vendor, &var_property);
 	}
 
@@ -1078,7 +1153,7 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
 }
 
 /**
- * efi_set_variable_runtime() - runtime implementation of SetVariable()
+ * efi_set_variable_int_runtime() - runtime implementation of SetVariable()
  *
  * @variable_name:	name of the variable
  * @guid:		vendor GUID
@@ -1088,11 +1163,69 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
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
@@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
 	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_runtime;
-	efi_runtime_services.set_variable = efi_set_variable_runtime;
+	efi_runtime_services.set_variable = efi_set_variable_int_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.34.1

