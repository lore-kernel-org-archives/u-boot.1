Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FD1C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35BAD60B54;
	Wed, 29 Jul 2026 12:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dzISxWErOQdx; Wed, 29 Jul 2026 12:28:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 733C660B20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328120;
	bh=B4QpgmF57iuz9dhSpEaz+MRiVV7Ls2ioKz1dCHtp9Xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DkDsdzxCRFs/e3C80zWie1qbvARSlc0GKtBXZEdCjJpN/aLKZtbrzhKWcBxdgzZYO
	 rDzGah861D38K9IvT97LQ1nWlIgL3QDXRBhJr2pcRELAQLAOoTIjCBDwLmbg4+RTKu
	 Yud4pF0Qzg+98gtoN4c73asBYgwbxWE9k4HG3NpK2rv50RTW7EE3tlNXI6QGyx/asR
	 hQsgjauMEUAr4/Tb0khPzPLZ5RtY2Sxz6MPzjdI67dmmY/5sErHd4AaLMtlFLcCu51
	 LOzYSH3PpzyZ5yh33PPp+1R7aQxFpl1DsrGSx2F9w9nCH/r1E+wqFzf5QvAhRidsKm
	 gVz7IMMJfN0hA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 733C660B20;
	Wed, 29 Jul 2026 12:28:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 51616490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3822B80F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rusE7sH9eMMr for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EC03F80FA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EC03F80FA9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC03F80FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:14 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAB28498B; Wed, 29 Jul 2026 10:52:13 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 252CC8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:11 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DAF1169C;
 Wed, 29 Jul 2026 01:52:06 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2553F66F;
 Wed, 29 Jul 2026 01:52:08 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 15/22] efi_loader: enable TEE runtime GetNextVariableName()
 over FF-A
Date: Wed, 29 Jul 2026 09:51:17 +0100
Message-Id: <20260729085124.2618817-16-harsimransingh.tungal@arm.com>
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
 t=1785315130; bh=ZeYuKpvXmkdmXZGz0nw+fbnJeP8SQiKB3t1OiEbk0U4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OBO6r4TnzL1xqvRxm0NtcgV7piLCAd9cTLou4y1jJKd61opuy3yHPuxUviDytDZta
 AtNpi17KfMcI+/08fmJyQA0j++o5fUyuQGLwCuwcDbgUCvqSaa9ij1y8pJjKJv6MPw
 +ATClv64xxrn7JLAk5EHC9Tt4sg2irkVEY02clsw=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=OBO6r4Tn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="OBO6r4Tn"; 
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

Add the TEE-backed runtime GetNextVariableName() implementation for the
FF-A/MM variable backend. The runtime path uses EFI runtime-safe memory
helpers and the shared MM communication path so variable enumeration can
continue after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 64 ++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 89991fb72b2..5f324b4d09f 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1075,6 +1075,68 @@ efi_get_variable_int_runtime(u16 *variable_name, const efi_guid_t *vendor,
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
@@ -1342,7 +1404,7 @@ void efi_variables_boot_exit_notify(void)
 			efi_query_variable_info_runtime;
 	efi_runtime_services.get_variable = efi_get_variable_int_runtime;
 	efi_runtime_services.get_next_variable_name =
-			efi_get_next_variable_name_runtime;
+			efi_get_next_variable_name_int_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_int_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
-- 
2.34.1

