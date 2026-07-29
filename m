Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC9AC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E7BCB81240;
	Wed, 29 Jul 2026 12:28:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1FaNNTRcIAo4; Wed, 29 Jul 2026 12:28:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1AE588125E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328119;
	bh=pcTFcCJ+O5FC9kDg78dKjtAZhVOHBeoQMqEc3sPNtFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=V8tXWsixJeup2XRuTIv1zcS4LtamXVJ36M3JLcIw8fW0GkZ8g12EIAgCwo0AQCyv7
	 owCzJybpSbpv5ruKSaxcN0ooYzZizmTNWiI7VYKt0KohoO0G6yaM4fLUydVNfxBWeT
	 P1oMDxXq8trQONa09t0LqlEh71oGNx5RByDhvg+BcDWmhv5FrO6vX90eyC9EMQ/naz
	 6V9ffGCvKMa1CgcH6o1BLibG/Ugd0sGbSkxCHg5V4FZzRAi1E5poMHnMl39oaQ+p/e
	 pjYakyzRMWWSkM/jwEaa7DL6kjCi7AJBTTJZI0E4qZUF7+7ODAlpNM90H5GlZaTGC/
	 JMRoz3ZMEb6mw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1AE588125E;
	Wed, 29 Jul 2026 12:28:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5D4CD4BF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4F48580FDD
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id paF2hbvHydlS for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 29B5280F78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29B5280F78
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 29B5280F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AF7D849A1; Wed, 29 Jul 2026 10:52:11 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 68ACB8494B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:09 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A52E8169C;
 Wed, 29 Jul 2026 01:52:04 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65B733F66F;
 Wed, 29 Jul 2026 01:52:07 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 14/22] efi_loader: enable TEE runtime GetVariable() over
 FF-A
Date: Wed, 29 Jul 2026 09:51:16 +0100
Message-Id: <20260729085124.2618817-15-harsimransingh.tungal@arm.com>
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
 t=1785315128; bh=/ISmxkBkzUpoBZBuEW1Ys+ofg/s3U4Qtoye9k4tiihw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OAWxry6uXppxZOqtBaiURYHJod+nYLGq9i8jjatEvh5sFbD2OAU4/44x4YGpOo9p5
 nHCV7GPQU/P47T/A8iYDg301b1Rj2UMJe4GiwE+RtVGIrmq4adTMKCkBFLnrXN6Tdr
 s9ZySR3mfiEwQiarK4sBkUdJxuy/FJeZcGLMINGE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=OAWxry6u
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="OAWxry6u"; 
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

Add the TEE-backed runtime GetVariable() implementation for the FF-A/MM
variable backend. The runtime path builds the MM request using EFI
runtime-safe memory helpers and uses the shared MM communication path
after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 89 ++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index d04b8dc1376..89991fb72b2 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -988,6 +988,93 @@ out:
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
 efi_status_t efi_set_variable_int(const u16 *variable_name,
 				  const efi_guid_t *vendor, u32 attributes,
 				  efi_uintn_t data_size, const void *data,
@@ -1253,7 +1340,7 @@ void efi_variables_boot_exit_notify(void)
 	/* Update runtime service table */
 	efi_runtime_services.query_variable_info =
 			efi_query_variable_info_runtime;
-	efi_runtime_services.get_variable = efi_get_variable_runtime;
+	efi_runtime_services.get_variable = efi_get_variable_int_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_int_runtime;
-- 
2.34.1

