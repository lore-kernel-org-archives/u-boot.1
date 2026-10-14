Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C30C3DA7A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C968D81123;
	Wed, 14 Oct 2026 20:03:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TVzaoL7wPCH1; Wed, 14 Oct 2026 20:03:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 180928110C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008230;
	b=iEWBPf/IR6pIre0UcuXBpg0gv0VjkR4v7E7qOtY2aDvHUGBsP932z8HbSudKTVEaMjAr
	 Mt86HE8ruLK6RCVfRTc17kkHk0Skgbd9sQLlfuvM6gQ1wjANtYm/PcRilwOl7+j2EAeUq
	 gxNepIHobBwCKruuMJGPMJmWWLfc03pqoemAKBtrMWNQA/j0Mi0dY/t6xV7DPHgOUf1hl
	 ivg6bGYpI26RpcSJahvorGRaixdknobJajC3s7cO9tSND9qT3QiO0Wa1wMQKsbHoILORA
	 qpbkxGU4sgRXlRmSVMi9MMKEvTjJ7ECrhBMUbUYJJqi9uStnAM8oxDP2F/NTWj3ABTQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008230;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ePcfrQjHQymjcYRV7obX69vwRvrR1g5OTeu1F98pdP4=;
	b=oIJ9KzkulalERso+s0sUIbHvXlKWrIc4j2xqMEnZ3YQ7PcExrsrtjwekP0fwmKI0r+AV
	 T8odgbLRfZBiLzyKrBmfWBiMCl3reBtA77SPHgXMdZomAXoOp85J4JAKetQS/U8zR7ydW
	 2v/IErMjv1wRPCy9bsNftM1jr+qSsJIT+ZRBzQ0g478wUqMJG6+NPr9dzvamPydZcSLiN
	 G39Sm6Vs94fZAp4evB/Jsj09yqC+6grJ7fqbLMugT/rJWZaHBTmysLIBREzEFYQWDpHG4
	 aNssTu58dhj0+xrPrT11dxyC5RuYaRr/ai8ws2xRYkEi1zMRpvIpxb0aNr6ybw4bryg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008230;
	bh=ePcfrQjHQymjcYRV7obX69vwRvrR1g5OTeu1F98pdP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ayvGAnrh503IXhUDat20R7w6MLYmvtztJf1o9GvyGwv2+uRSiTdPIm0PamzdUUM1v
	 W7ejHRXBa8GvNf+9MykB7WXo9DvIOw5dInVkwB4XbKNjxRTFdStcf/bkhV5uqB5AvE
	 cd/sFPetSH5fH4/uqbbBD+uN0ntSBIMU3Jk7aefLsyfFtIpDQQh/qoi5all+mj2GQg
	 yoWxQZweYkpTyjFYM+E26mlkz1fZJld969zPOc5yOz3N1mjUWr7Nwz2ODtgJ4Pc3gB
	 0ZozWymHS+F+q4AFEvSzQD8e401cuJuPdUaGk2wGW/tUYE0d7NaJWbwla2yEO+SUs9
	 1l0igbSTTf2UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 180928110C;
	Wed, 14 Oct 2026 20:03:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 96F334DD
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94BC0407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FTryT7Zz-fJf for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CC222407A0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002218;
 b=ENhQHuQzUl2KbRnNEuYsak5FrYF6wCVX2yNAh5zHYgmFBRdm7+Bb03t5on+zM0biNXeM
 nzbkx/RXbVyDkQ5ik/MbhQwE6BXv0hB6fLlzynwNzWXNBYTPhAKODZ1EU6TVO3OVJq3/L
 /kpUNbJag5nroXtpvA+XBDywCGCebFe4z/+Z7gyJOwYQGdWc5BmfuGp3LFQhQU8I9NSpg
 R2c/0mh6KC7Xfmpl/O45tK0YHROCveVTCbjwKzqlx0gyG+zqesTH4TrCZZCsVFBM6o3Yh
 Wb+Ofo1JB8AUr6SJllf20XFBepwjfGKBmn7JxnZaGAy8cN0SUgX3OeEzQMvk8EkMqLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002218;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ePcfrQjHQymjcYRV7obX69vwRvrR1g5OTeu1F98pdP4=;
 b=LLX3DJY5IMOYpsGpjWmkLuvRkMzVLnNe8SCCprL6ES67VtSzIAB9G4TUoC3DrMl3wvT6
 /D9BOvrxgE6fhGJOaJB+tF3YO/sNXerOd9+agCo2lxePA/OBQ8s9MzszUJAKlK2NdgXvk
 CIBvR3znAOra7qoWU1E1BLFZgTojEN4Pv4pfCGB0ceaHt5i9H2iDUp/+smbf7mm/ILcHG
 VYOmwAxKUf+i3OBY7n5AxUCqny63SPp8/CaRhEAskI1aPzFb2pCoxJQUOXeLpQr2g27NS
 l4GEskdyLK445jAtPIi+uZrhfysrWpw6fWzxxhpgjfbi8w/QWRZY+n4bCOdtUvoIKTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=IRiZ6C58; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=IRiZ6C58
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC222407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C89152B;
 Wed, 14 Oct 2026 11:23:34 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10ACE3F871;
 Wed, 14 Oct 2026 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002217; bh=dQ1EsNuPPK+b0rkzOGy0/mJgLFIWjIMn1dwy+6CjxvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IRiZ6C58NQUqv0JEJ/1179bAvEg5FbTAQyhS7p/TkfKZyzX3aERzb6rmGcmU8jf7M
 X2vy2ojmXFGAq9S1Pd1bjaUy6B+y2HWlu6Z1WhTp7IL0wkVxrMeYKeJzW5Nx0g6vqa
 n3llDZV+iDN+93Pv9ygdPAUsmPY9fqZANDEIp9sk=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 16/22] efi_loader: enable TEE runtime QueryVariableInfo()
 over FF-A
Date: Wed, 14 Oct 2026 19:22:56 +0100
Message-ID: <a6ec9ebede13c4aa015a586a09d3ce5cea4244ca.1792001844.git.harsimransingh.tungal@arm.com>
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

Add the TEE-backed runtime QueryVariableInfo() implementation for the
FF-A/MM variable backend. The runtime path uses the shared MM
communication path after ExitBootServices() and returns the variable
storage limits reported by the MM secure partition.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v6:

Ilias:

- Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
- Rename FF-A QueryVariableInfo runtime handler with _ffa_runtime suffix

v4:

Ilias:

- Split the runtime QueryVariableInfo() support out of the combined
  runtime variable-services patch.

v3:

Ilias:

- Rename TEE/FF-A runtime handlers to private *_int_runtime names
---
 lib/efi_loader/efi_variable_tee.c | 56 ++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index b078ccce20e..0e795892bd7 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1202,29 +1202,56 @@ out:
 }
 
 /**
- * efi_query_variable_info() - get information about EFI variables
+ * efi_query_variable_info_ffa_runtime() - get information about EFI variables
  *
- * This function implements the QueryVariableInfo() runtime service.
+ * This function implements the QueryVariableInfo() runtime service for
+ * OP-TEE with FF-A runtime transport.
  *
  * See the Unified Extensible Firmware Interface (UEFI) specification for
  * details.
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
+efi_query_variable_info_ffa_runtime(u32 attributes, u64 *max_variable_storage_size,
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
@@ -1307,9 +1334,10 @@ efi_set_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *guid,
 }
 
 /**
- * efi_query_variable_info() - get information about EFI variables
+ * efi_query_variable_info_runtime() - get information about EFI variables
  *
- * This function implements the QueryVariableInfo() runtime service.
+ * This function implements the QueryVariableInfo() runtime service for
+ * OP-TEE without FF-A runtime transport.
  *
  * See the Unified Extensible Firmware Interface (UEFI) specification for
  * details.
@@ -1383,18 +1411,20 @@ void efi_variables_boot_exit_notify(void)
 
 	/* Update runtime service table */
 	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		efi_runtime_services.query_variable_info =
+				efi_query_variable_info_ffa_runtime;
 		efi_runtime_services.get_variable = efi_get_variable_ffa_runtime;
 		efi_runtime_services.get_next_variable_name =
 				efi_get_next_variable_name_ffa_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
 	} else {
+		efi_runtime_services.query_variable_info =
+				efi_query_variable_info_runtime;
 		efi_runtime_services.get_variable = efi_get_variable_runtime;
 		efi_runtime_services.get_next_variable_name =
 				efi_get_next_variable_name_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_runtime;
 	}
-	efi_runtime_services.query_variable_info =
-			efi_query_variable_info_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.43.0

