Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D72C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3629E8130A;
	Wed, 29 Jul 2026 12:28:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gt0dTicmsDEX; Wed, 29 Jul 2026 12:28:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A625F81281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328121;
	bh=DIbBV8tFgE33j6zPfAhACEmoLWlfIOxO/h5EknbpFy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=umVUtrfOao905xyd0WJBflLQoJ3Igd0hBqMghFDqtUdoEBRWCDN667/5Simxquggr
	 OrZ2o+fL3vxVPgOL5Co3hc1zZfv6sD+lcobK+IDRtey0ljMKs0QSsxEt+zy9AaDq3u
	 kGlRPJfxehMTZmdkdOHgkLBxuhbpwdBHVNxYQcwAN3EKAd5Ai3TX/dMEmGCxFeuhP7
	 pPCPUVUN6N/5maY9nwCGlQFbjZWyN5AAmPjc7kp4XVUyCnDpzGCqhumM7jUNBhMqHf
	 KNXE7BquDihhKx31Cevy5a345tVfuRuXzzi9W4jVBRL+/W3rQBFsLBb1UM4oEYmWgx
	 WzIpBzArq5cBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A625F81281;
	Wed, 29 Jul 2026 12:28:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7896845B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EE1680FDD
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fvZeUxIFEKXO for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:17 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org CC9D380F78
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CC9D380F78
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CC9D380F78
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:16 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9D6849AA; Wed, 29 Jul 2026 10:52:15 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 0371B8494B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:13 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3993F169C;
 Wed, 29 Jul 2026 01:52:08 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC6323F66F;
 Wed, 29 Jul 2026 01:52:10 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 16/22] efi_loader: enable TEE runtime QueryVariableInfo()
 over FF-A
Date: Wed, 29 Jul 2026 09:51:18 +0100
Message-Id: <20260729085124.2618817-17-harsimransingh.tungal@arm.com>
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
 t=1785315132; bh=X4LliyilIjCgkf64YO4voc9zS2a2VUImrtH9YD938sQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NcToL8Rge2PesjOcLNb7IWdlVEkTrGMCZ/iRkmX9slS/uc6jCiEgrzNxypqq+d0DE
 Xu80HsdCJKQvujk7jNfl5PIO66Il2Z7rPkQa+DgeWHEALhK6bEIo+V5bSZwwPe5MWD
 Mdn0tsnhvbWpL2GG9Ao/kOLAXUPNNar1+5NfmVfU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=NcToL8Rg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="NcToL8Rg"; 
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

Add the TEE-backed runtime QueryVariableInfo() implementation for the
FF-A/MM variable backend. The runtime path uses the shared MM
communication path after ExitBootServices() and returns the variable
storage limits reported by the MM secure partition.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 44 ++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 5f324b4d09f..4189cdeaef0 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1270,7 +1270,7 @@ out:
 }
 
 /**
- * efi_query_variable_info() - get information about EFI variables
+ * efi_query_variable_info_int_runtime() - get information about EFI variables
  *
  * This function implements the QueryVariableInfo() runtime service.
  *
@@ -1279,20 +1279,46 @@ out:
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
@@ -1401,7 +1427,7 @@ void efi_variables_boot_exit_notify(void)
 
 	/* Update runtime service table */
 	efi_runtime_services.query_variable_info =
-			efi_query_variable_info_runtime;
+			efi_query_variable_info_int_runtime;
 	efi_runtime_services.get_variable = efi_get_variable_int_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_int_runtime;
-- 
2.34.1

