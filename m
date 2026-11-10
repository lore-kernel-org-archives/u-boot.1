Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB049606BFD0
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Vn6OZXcr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=NaA4GYHP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74BD381659;
	Tue, 10 Nov 2026 13:06:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkqTKem5OQP6; Tue, 10 Nov 2026 13:06:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 99DB381544
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316005;
	b=k1LH5wkP4A1F5UJ2XfMU8F+ZqFfquUibLYla1pUjtUD5/HMBjZORuY+BQ0Pzl40O74Gt
	 IDtV7NE5pfI+APF3+anhqcPqVfF22LGthHILB5UXs2j9+VDDsKzHmKdNyjS68PTrjWvW6
	 0WfRdk0rLAZ6zat9E7U8v7C7VfTmrm6QcQNISWNQ0pA846jYGpm8CIoIeWr74denQGzNO
	 a2uB+YhVfsQhw+xX09XwMUlD+KaXHbxM+KDkALXLXWOiYLrO4E4u9DFICm1KIbVZ6Jr+d
	 BqOSrH3JK9hBk6UCUdSxVfsORBOcUtkVFN5HQGLmRLvpNgX7ExLTH/+9IldRM+td8jQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316005;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ylnbKLhiYhwqVHhROLpRQIYpasTbHg+h6gpagfAEPLQ=;
	b=U6U+zZObGlQx5/fXqvNkjcC791UCBbLMuWqP+xe7sWI+eELs4bIYZaK7ZB8Ef5PrLPhl
	 q4an3EoTggVSEdLg8cdBBv6Ge6uyfwongFG6MUVS3UDw/ceZqM2Zsbj8S/+P+fYc7Y1gV
	 ZVe9V8XsBz4scNtsDmEXV8n9VHiT5VTiofYNKZh6rEDnmdVCydonv30lNZ+8/alXVXRf0
	 3eS4MaRY427KxE2ERX+SnNmX8lpxQcV1+QoasRBVJ3SAnrplSMgyGAo7GKZ9nVJkA/9HW
	 7d3DtuESEe14iggAcGA8FXCjfAzDNvWwNV/iJf5mYqOdlsqtEyxXYAUulDPaWhtLCzA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316005;
	bh=ylnbKLhiYhwqVHhROLpRQIYpasTbHg+h6gpagfAEPLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vn6OZXcrCuZ2ubcCyBxEzjVhZLVfjTuhf7WQ/siRd0QMAxFJA29cQe8nbC1ieUOWD
	 Y0GNibw2/tm7+kVEwUB1Xcp9mOWyqpCnsg/bfn5KqP6Q8xpaOMW0eROpzA4ZsI1rX7
	 ZitQ7u3D+liFnKDpDkaW4HBmjMT9UDH6yicYMDYY8F3TW6RQR+EGPhvMKOwLORGuep
	 E9xbYEKJtWhvWuy969Rk76sO1IpmTPL6Rr6N/2SnTNyHzdDzVYWCXnOPGSTyLMNapw
	 /XH77xGIQngUn7yGCUyrGtDZN0kPG+68t8SAyt2GUD7AEj11+Flf+A0TKsDV7k3EAz
	 pryTk72hIVCcA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99DB381544;
	Tue, 10 Nov 2026 13:06:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 36313731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1C0554032F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXCKpFzMyq_e for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 5D8084008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=NaA4GYHP
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D8084008A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47B401E7D;
 Tue, 10 Nov 2026 01:58:31 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C03D3F632;
 Tue, 10 Nov 2026 01:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304714; bh=SnDkzxoAyiwZaszKL44yOfVER33TQNulsfgrPQmiT8I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NaA4GYHPlRD51WsP9x57/1U9qb6xyG9FYIA+fQfZIlNk9O81KxKxAKIxvW7AtprSx
 mQtS2IVHLWn4Zj3nIf2bwmFW6rOANustqqwS7ODa2WDdavAlJnzGphvCXtQmlLsPDG
 Rkmvoojxy+T31oIHnpCuTZBJqEzm2Z5QcyY3lh/U=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 15/22] efi_loader: enable TEE runtime GetVariable() over
 FF-A
Date: Tue, 10 Nov 2026 09:57:56 +0000
Message-ID: <da2a7e23ca354b20d72bc8b6f4a84252f00b5d68.1794221712.git.harsimransingh.tungal@arm.com>
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
index bff9370180c..fb6c3c78c8f 100644
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
@@ -1208,13 +1295,14 @@ void efi_variables_boot_exit_notify(void)
 
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

