Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD19FC3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A32A640832;
	Wed, 14 Oct 2026 20:03:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9O-7SwTUBgM3; Wed, 14 Oct 2026 20:03:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C600940816
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008226;
	b=d4Xcy7ci+mSSUMw9AOWlZ8m+YJSxOcB1wnlD6pUJXlIToBosM18lwDz40er3T5vtP/wm
	 4Vcx0zDO/DlsqflTiYQpMn/P+PkQjF9ocllU8XRVuPelihc1mQuoPA93WTpCsm0zGtPuN
	 yDZHm7mJo9DihP2PoEwr4JJ8+lrXTvDxuQDRaI02frivcZ+cJrnb0SwhgjGl6OtdJpo5C
	 eN941uJO8ZpedRRemBta1T6vCUDcvNSQi6XGVz8B+w6PDwaYGjBt/i13EOBJUeZaNwo/2
	 uE5t6ph7h9cZsOS8Gc0n2glkA1og660aAyQW1QP/JYxxFyvzHulcKjdDywnuOHcDxrQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008226;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=NxSJTwLQMQdAKrwTRoejtJeoZFvwucJLOCzoSKu6N8U=;
	b=lptStdiz4C1PGmdlzGzozuEGjhHSJ3KDAoD22igKVhXwmaVN8fmuTdPfagditcXe14Qh
	 DzdXD4XB236uwRVv0g1cAfN63FJo4N8r/ijVzUayMkqbngd74SVpmztDanRqQ2npCUKhc
	 H8hruX2Y8xssZYsxw8XAiO0M3bCpyOBWXmVbYnU07S34dsyuiiBX82rKWH3K7r607uovE
	 hMRszMyrOtV+wo/Ev/zC1B723qDaGv2B3RiOLSG+4nZtra/TSiJFnMdDkNUkfnX+qrJFB
	 vZA8p/RS19kDUYjm8pGF4NAHPEdpC/sTulRnlaSLvHzKKQw3j9vU0/cS/KIiNJ1VD6g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008226;
	bh=NxSJTwLQMQdAKrwTRoejtJeoZFvwucJLOCzoSKu6N8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iqyyVvxyHQR7hQSyk8KVQGWb4hb/vu9SzS9nbNIE8dEhA5MVb8BSsEpO4vcymwblG
	 bwGSFYxLkdlWxXqG3FfXHir7T+ADlXzX7rHe3PXGxYL3dlF1d8VO4auxFnmHHz+IHc
	 mNoO0e+v97X/ThuMtri6NdZRZ53QFFXdNgToN/6qRjdzxx90HApB0lFfhhLAzMCFlk
	 HR8lONS0GhTmaa9axB8dZ+mQ/xCBXvf3bPFzuHdByNBm/LkGGgvKCyHz3QtUrhWdeo
	 e1zVXkjqCbUnaNUQzyjS09yRav2Map19ULQSSMiutANU1KlZEwp3Ho4DqvrCyOX9Ox
	 jib3AExNGzCmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C600940816;
	Wed, 14 Oct 2026 20:03:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id ADFA11DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9485860849
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AFpl12P2lsIZ for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C1130607CF
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002216;
 b=rHxQ3aBJfDUvTYS/qeG+PBTLX539LaeiriEXSApx65NZ0CMfrOwZAShjhQxesoARqFv9
 vFstGiAVnDJqqcublkp5SwuYXb47EV8YcvytOWYv3402hiImQE+t0M54U2mKH1tY8HP6X
 Z/6VM8v7EeMvItvXaXmtW+fmOjoDSOsxZZE0SCd9Rvf1aM14aQLet0itnCPDkEVfjXC75
 wbX9SWy/5s/7VcpB7SBg+UwcqJ4jqIgTOZbU2CaxJ3rm9uTa4ICJVHzIcaqxbjv+tp15Y
 LrdRM43YLXlpdj0w3OoFM4q4LOuL9l90VV0Avb9R0Okg/TIOb3K86L2xILbJyUvafoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002216;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=NxSJTwLQMQdAKrwTRoejtJeoZFvwucJLOCzoSKu6N8U=;
 b=VNFl0b+kGnz6muT7TQtwQ8GSlha0sfwFoVVJ1DoGV4+06WeSL4LjVtdW/Tyvo/GonFKd
 89E1oDVQna/xxDOgQQzJZuyZcWeA601tML5vKWoaxZvuqjoidDPOd0jtDNta3jyEDeeft
 e3UvqTpObhMaS1KeUXyde9gEMH2I7/vriliEK/ZpK3pc834l1+Ixj3XCqsco9Za5HKy8U
 KYhoXhGTGZ1elcR+yUGCUtXTlcrV9Ss8yAFfiFiLg9mUgH8txX8y37ES+meyWZ+ZRkTdH
 HF8sb/4fC/sBa0Pxrf6Ba7yqJlGsuY4XEzOKtc21ME/z7UVCx+4wRH/TYj+DpoOF0cw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=PycTTIGz; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=PycTTIGz
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id C1130607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C44AC152B;
 Wed, 14 Oct 2026 11:23:30 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C19893F871;
 Wed, 14 Oct 2026 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002214; bh=E/xN4a8FHExNJVPmpePokFyh7Jzynz9W0TS2pS4i5fQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=PycTTIGzvSMp+9jfDhsiCtQeIPdG1piqQXnjOUCI3db/dzepQ6h16HYKvud2RYfAt
 pvzAFC4BIUcIBTB1jUlZ7+p0vJm6Tnxhv3HlZy4P2DmtTHIv73eKSDgjmeoQV7bxm0
 38Tt816DHgPTVgmyQ9gB9gw4z5CGJwS7NHGAVsLA=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 14/22] efi_loader: enable TEE runtime GetVariable() over
 FF-A
Date: Wed, 14 Oct 2026 19:22:54 +0100
Message-ID: <4e29268bbd4d9aaa11e0b285ee08e66c2e924c95.1792001844.git.harsimransingh.tungal@arm.com>
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

Add the TEE-backed runtime GetVariable() implementation for the FF-A/MM
variable backend. The runtime path builds the MM request using EFI
runtime-safe memory helpers and uses the shared MM communication path
after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v6:

Ilias:

- Reuse the common property getter in GetVariable runtime path
- Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
- Rename FF-A GetVariable runtime handler with _ffa_runtime suffix

v4:

Ilias:

- Split the runtime GetVariable() support out of the combined runtime
  variable-services patch.

v3:

Ilias:

- Rename TEE/FF-A runtime handlers to private *_int_runtime names

Simon:

- Cache attributes before reusing the FF-A shared buffer
- Add EFIAPI to the runtime GetVariable() helper
---
 lib/efi_loader/efi_variable_tee.c | 90 ++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index b4cf12d6332..7e8049e177c 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -920,6 +920,93 @@ out:
 	return ret;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *vendor,
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
+		tmp = get_property_int(variable_name, name_size, vendor,
+				       &var_property);
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
 efi_status_t efi_set_variable_int(const u16 *variable_name,
 				  const efi_guid_t *vendor, u32 attributes,
 				  efi_uintn_t data_size, const void *data,
@@ -1234,13 +1321,14 @@ void efi_variables_boot_exit_notify(void)
 
 	/* Update runtime service table */
 	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		efi_runtime_services.get_variable = efi_get_variable_ffa_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
 	} else {
+		efi_runtime_services.get_variable = efi_get_variable_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_runtime;
 	}
 	efi_runtime_services.query_variable_info =
 			efi_query_variable_info_runtime;
-	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
-- 
2.43.0

