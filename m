Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8999C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7666380D4A;
	Mon, 14 Sep 2026 14:17:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYV3mM9ccaZt; Mon, 14 Sep 2026 14:17:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4693D80E07
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395453;
	b=A8GBRZeKkmdH1wvDiQBjE0PBWWJsgj50Rx1a1yRT6IYU5pda2PybkAh6uGMh7xGa+nJ7
	 L6C8D/NvnUKrdmRbZ9qrLrLxRE6VSAVmsE/LBndQ9Pt17mDulWkq34CUP9Y0UhQV1SYac
	 6JCyspngMzji395oVGzbahfCOgIvLMoSP8S8rDmq7Sw3RbtZvMl51PiUUs2UseHVJHUnd
	 eFKU+Npczi9whKF+WDJHiFPw5h6jc+PCSDt9DSqyVBgkE3hzk+SpXnQZE1IVNFzI4Lemi
	 yhO9i03/cWq5znpPNgGHBIAU7bCE+FWM7bqbFZ1pxFqZOVuxJ5Mir71pK1nmw8v/wFg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395453;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=m9/Qogarj1WpvhJJb83vOjxuNQewRWfxGSmwEUofahI=;
	b=HuU57roiYUW+0G9GIPqR+t3gTwciVX7SoF4cRj4yUG6WIkNc5slqEzEtc325QCrCW+Nj
	 PkpAxdzDB4V1U+DtKv3E0Z0tSun2/3UF0LcQ1Cqb6fbyMRk2q+UtU8ZYhaAeIH33WLOx/
	 B1eGUxWcEfNzsDSgMJb9dMtmEGA3/ieTrYLX9xofnEtqfc4vLP5V65jzYBSTvnw4yCu3z
	 V4dL5I0QIC3WUl6JOHTcvJunnO83u9MIecTqFK8MHLOL7seFZFOe3yxt0h+j4o5cGEd6H
	 6iWjcFh4QmailSPCkCJ8Xxj1sTQgA/nxd6qyiLv33/gtK1drL61sW+V+9YYLUlztHdg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395453;
	bh=m9/Qogarj1WpvhJJb83vOjxuNQewRWfxGSmwEUofahI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vdBmmzmxlcUKF1Oh9rIQe8uALQJAklltNin8m/3Sn7Z6xj2JlcCYgUtX7NlHzXUsa
	 dyMrUKBf2PzI9tV2l2qtNUs38AXqLH0n6RVAyvDxNQmuq/ElCWoRwfrI6RCBybWO/0
	 v3HP9WwmuY8/NJn6nAJr7GsJPMD9xilAxejui8hPRzOlKX4v84CvR60GgUys7dyIV2
	 5DEj6k9a9bHSxPvBV85ZEK5XwAowOuRRBF9HBYpYxrdBUO5pGnFGNmg+BVTAjSkgfu
	 c+fIqej4VmFMlWVOUsUfDC3dQtvu2v4fmAVpyzAOfma0WsYOUUOPeJnWthnMD3NNzl
	 UA8vpa0ZgsQwg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4693D80E07;
	Mon, 14 Sep 2026 14:17:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A1DFC49D
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9449D40121
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 68uoifBeJssw for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D8F3640119
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384216;
 b=oNGAqlTcesois9H6ku/XJkk05xruZUtKOC8CMNQZWTzSq1caJoG1QZfl4jsMjZzlnTKG
 qKcFitiCh/L7cv1KNbVoH/jpK5rbBSHvNTDzCZ2Rru9wgbA5Nolsis+8dB3smC+hVrjHR
 YYF+uDCvlzEiwV9mCCgdKGlGxKtHvK99X706+OQ868c0eBFcMqeZr5n34JScx2kSlOuIZ
 ypQWYdJrqz6P5mEqo66gclP6LPA2/p7E4vBnA1ja1nuJX/lwmRSPUkn7oOR4aCixU+qOx
 eE1wqrkmrRY7ZxAK41Iwp9SCvtyiKKDnln9N3cmlAtUkdSjJ1W7O+lLoL+Cuv9zbshg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384216;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=m9/Qogarj1WpvhJJb83vOjxuNQewRWfxGSmwEUofahI=;
 b=R6JTgNB61nlhi9fG0GIHm/gUqPutgLDXwANUX0X7n88SaPuBmKHc+1ZAJ1QFAl4FWTy7
 6LxgbWS4Vgb5oL8cNgUFkqYqnrGw8XSZuq8hcfyEfbkn943hjMcrEgDaGAmD1DPtnAE5i
 Q+OVcT9qLeJonWE4wVAxlnC/W89lBwdjaulu1qb4hmElUCXFDA0OW2KZPh4YlRG0fcUxW
 AdWRuNvnbDcUf1/eGeWlK5hpayLB4o3kF5m4LFPh1jG6klxuorkhY6nP8CRA6jfucTicI
 mj6KrHjMzk6rewUOHXfe0FP4I144ebdcFG9mMtVSVvP8N+h+Pz04JLLJ9x9hxeA0FhQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=eFbDCU65; 
 arc=none smtp.remote-ip=217.140.110.172
X-Greylist: delayed 528 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 14 Sep 2026 11:10:15 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=eFbDCU65
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8F3640119
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:15 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4171F37;
 Mon, 14 Sep 2026 04:01:52 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50A413F86F;
 Mon, 14 Sep 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383715; bh=WHmwoWvtJb88Vt7Yqkf+PFFis77qGIp4Ppgetb5JIYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eFbDCU65IRxy+6B0UHzCY5mzqm0AkOzOUzqZxN6nFhdFUmxUbBCtIObn402hh0s28
 gUV6DXMg+LPX1rcnszS9qPLZo+tFGQlLqS/BT6hzju9q0F7uxJqC7xAvpr/F6C2zhd
 X4s05uTRhfVG34mh8cv69URqq1+F7cijnqpwaQi0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 16/22] efi_loader: enable TEE runtime QueryVariableInfo()
 over FF-A
Date: Mon, 14 Sep 2026 12:01:00 +0100
Message-Id: <20260914110106.1974894-17-harsimransingh.tungal@arm.com>
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

Add the TEE-backed runtime QueryVariableInfo() implementation for the
FF-A/MM variable backend. The runtime path uses the shared MM
communication path after ExitBootServices() and returns the variable
storage limits reported by the MM secure partition.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v4:

Ilias:

- Split the runtime QueryVariableInfo() support out of the combined
  runtime variable-services patch.

v3:

Ilias:

- Rename TEE/FF-A runtime handlers to private *_int_runtime names
---
 lib/efi_loader/efi_variable_tee.c | 44 ++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 0de9949344e..3e4fd33dca6 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1276,7 +1276,7 @@ out:
 }
 
 /**
- * efi_query_variable_info() - get information about EFI variables
+ * efi_query_variable_info_int_runtime() - get information about EFI variables
  *
  * This function implements the QueryVariableInfo() runtime service.
  *
@@ -1285,20 +1285,46 @@ out:
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
@@ -1407,7 +1433,7 @@ void efi_variables_boot_exit_notify(void)
 
 	/* Update runtime service table */
 	efi_runtime_services.query_variable_info =
-			efi_query_variable_info_runtime;
+			efi_query_variable_info_int_runtime;
 	efi_runtime_services.get_variable = efi_get_variable_int_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_int_runtime;
-- 
2.34.1

