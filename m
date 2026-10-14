Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5ACCC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C145E810D3;
	Wed, 14 Oct 2026 20:03:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NL60nwXvs4b9; Wed, 14 Oct 2026 20:03:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1B047810ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008225;
	b=jXk9iiujbc73vjcPEOVtP9Sm0SL8VDH1UXgOOqzPHezCNpf6D9Dltn0ThZIULT4rcGAv
	 Q5mAhD+uiAU0bh2LO5ratZBpyBx2ZUvg3i8nCMBgjVFBoIfU9K2ufIQ8rI5c5R4Qucbw6
	 djzV3vpRBP//TXZjCJV0NXI9EtyhkwRqWnDw7i/2EKM2EWLLX3X/C5m5VqUaQAvcL7CNB
	 /g7dtwbmqJd1ykgCIVbFJ2X6L9s1hOcgjtwHCr69N+vLLo12HonZs4zsDonPWsiCTz3s1
	 fdN8jCmhpMEj9HYCtFKNMlOV+bJeT0RcBsM9sjozag1Af+12n6gWio2GEsk5Nbg1nAg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008225;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=P6Ok084vSEqWzjox9PGcNh18qvQifrXQehB5pAGkeow=;
	b=tAkzjAC9ZDNkny1XBoEqvtmu5xPzlfHGmgU0NhE4WCXQ1P59LZK/BEeZ3hcdiVQHBmne
	 0JCd5jeoiwYkY9/wAgKtKg+6mlTdgiAUAXCh8+MX4Bspf2VudvkQKGZwG9pVkUQAI2JmO
	 nJC15SrHEglpEkbyH/lgNWx4PyPaqI5zFTZ3uMHHrhPKpUSAX7/3nI+9Fg78liZwtaA7N
	 SkksfxbktqBzFrjCBMnRoKK0nvViUPtvBcEJ8mSo7NqPGCpodCvI0CUHS2Ng5USXs4cZN
	 Kf/CADOk6LSA9uYZLqlSaq8jr3GICpjMh++V5mGbJicWmiQOJOnhua/xu+fqhfAItCA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008225;
	bh=P6Ok084vSEqWzjox9PGcNh18qvQifrXQehB5pAGkeow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LxBU24dZ9NCUW6Oz+sQzqVqKAjhqQynICNqhVhSw69U+sHY908KR9HrrIoV1nI6RY
	 VAgmRNaFbTQvj8eLEPERXtCFvBCyfhWCYEamq4yU7M6Z+rzvIXnY0npS1Fxnvx9fii
	 4oFn9ZPdDpt8FxJfLdFenhNUD5Ed0c92NiIJYmxFsmGEsxY7Eb/uVcd9ERNob34/dn
	 USXZazl7bqnOT1rNAsLyE7Zy+zDjiI7dWbiMBVnsx93Ua7nyEe9/nBN2L7DUm+eT3m
	 RY/fKMV1+HeJWvQgAD7KzjW9Psq72n8Gi+Yzw6LmZwEnQeaQQiORZO9jBp2iyRhXk/
	 uGZ7x3pKlLf3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B047810ED;
	Wed, 14 Oct 2026 20:03:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EE8711518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDF29607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aEIOapH0ewZE for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E4ECC60840
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002213;
 b=NyKiogkwWQSIkmrPqyPYAP2WQEDyCdt69FCbScmYN7efZTBlB/llEj39h0I7/PMRasUj
 fYkQwAOZWu7jbQM7Gl5PT5evavILhkRB2A3JBwYtqpab6K9Tiknw17s0NL56ZCX7adfXX
 WPDPX4BVJf0Vb7tXAZ14dO0IBcEMvlzMoXPX/TTnzea8ScR1GGc/WV1E0MXGfkuxAMrI9
 zm9EUB6vx2iBS2Howj7H8PpmVupjN2BlHroOp7VTI5lWMJ7Lyu9XQa7+dpLBADTxpWRZ6
 QbEVqvXqQwKJBuYALrrJar8YyHxApEuk4oaQbxtTKKXw+A/rsbt/PBNhvqvcjKmrDlA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002213;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=P6Ok084vSEqWzjox9PGcNh18qvQifrXQehB5pAGkeow=;
 b=qrBbmIT92EpFTe2SqdYLtilG2iqhMlmjX3yeaD5MOTqzlzT/54e8d22FJvZwN6w1CsWJ
 SQ76mz91g/lU56EpFBhRdRXbgoliIEyMcCYYl/Vq/L+IKJhza3pN8JuKAmvWXHsDUugSt
 X/8mVg/6kyecvMCUOPVJRLEIM7ETskQ1cmg4nNtY2KUliCH6YZ3TuSY7aeVeSM/N5yZUg
 MsBx6y4og09TWWuGgnOTpgCLIMZj3bL0XPxtUA4zqPdfAv9pyefHzkCpsPWpklOp1Bi6I
 AbE09C40jpjI0/f43aQv4XpsoRlGLzvYiP78D4uFdGYPO/QpZCrjJFh8WnnjSvIybpg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="WH/cHWTm"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=WH/cHWTm
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id E4ECC60840
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28FFC152B;
 Wed, 14 Oct 2026 11:23:29 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 256563F871;
 Wed, 14 Oct 2026 11:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002212; bh=zGuLBS0rlgcDQliFrxwuQjD6plRKphsBe8gNH28eZls=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WH/cHWTmiTu+WurKSTUiW6FudRYo03dY7anWx2eRVVS1kNaLJi9azACbDiNUvPxV3
 NzsaWUEbyRGV7UvZS+h2QHl35Vd5rnIrgq93yhSWF4irIKJXNPlZszZwdknOOGJgco
 WNaNRcv4Ue52huAJWK0ChrRipTIMW2q3j1VAMAO8=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 13/22] efi_loader: enable TEE runtime SetVariable() over
 FF-A
Date: Wed, 14 Oct 2026 19:22:53 +0100
Message-ID: <c927a9789a43f0903237040cced800e077bea7c5.1792001844.git.harsimransingh.tungal@arm.com>
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

v6:

Ilias:

- Guard TEE runtime handler registration with CONFIG_ARM_FFA_RT_MODE
- Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
- Rename FF-A SetVariable runtime handler with _ffa_runtime suffix
- Reuse runtime-safe property helpers in SetVariable paths

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
 lib/efi_loader/efi_variable_tee.c | 179 ++++++++++++++++++++++++------
 1 file changed, 146 insertions(+), 33 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index a03f2091eb4..b4cf12d6332 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -689,10 +689,10 @@ out:
  * StMM can store internal attributes and properties for variables, i.e enabling
  * R/O variables
  */
-static efi_status_t set_property_int(const u16 *variable_name,
-				     efi_uintn_t name_size,
-				     const efi_guid_t *vendor,
-				     struct var_check_property *var_property)
+static efi_status_t __efi_runtime set_property_int(const u16 *variable_name,
+						   efi_uintn_t name_size,
+						   const efi_guid_t *vendor,
+						   struct var_check_property *var_property)
 {
 	struct smm_variable_var_check_property *smm_property;
 	efi_uintn_t payload_size;
@@ -700,54 +700,52 @@ static efi_status_t set_property_int(const u16 *variable_name,
 	efi_status_t ret;
 
 	payload_size = sizeof(*smm_property) + name_size;
-	if (payload_size > max_payload_size) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
+	if (payload_size > max_payload_size)
+		return EFI_INVALID_PARAMETER;
+
 	comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
 				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_SET,
 				&ret);
 	if (!comm_buf)
-		goto out;
+		return ret;
 
-	guidcpy(&smm_property->guid, vendor);
+	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
-	memcpy(&smm_property->property, var_property,
-	       sizeof(smm_property->property));
-	memcpy(smm_property->name, variable_name, name_size);
+	efi_memcpy_runtime(&smm_property->property, var_property,
+			   sizeof(smm_property->property));
+	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
 
 	ret = mm_communicate(comm_buf, payload_size);
+	if (!efi_at_runtime())
+		free(comm_buf);
 
-out:
-	free(comm_buf);
 	return ret;
 }
 
-static efi_status_t get_property_int(const u16 *variable_name,
-				     efi_uintn_t name_size,
-				     const efi_guid_t *vendor,
-				     struct var_check_property *var_property)
+static efi_status_t __efi_runtime get_property_int(const u16 *variable_name,
+						   efi_uintn_t name_size,
+						   const efi_guid_t *vendor,
+						   struct var_check_property *var_property)
 {
 	struct smm_variable_var_check_property *smm_property;
 	efi_uintn_t payload_size;
 	u8 *comm_buf = NULL;
 	efi_status_t ret;
 
-	memset(var_property, 0, sizeof(*var_property));
+	efi_memset_runtime(var_property, 0, sizeof(*var_property));
 	payload_size = sizeof(*smm_property) + name_size;
-	if (payload_size > max_payload_size) {
-		ret = EFI_INVALID_PARAMETER;
-		goto out;
-	}
+	if (payload_size > max_payload_size)
+		return EFI_INVALID_PARAMETER;
+
 	comm_buf = setup_mm_hdr((void **)&smm_property, payload_size,
 				SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PROPERTY_GET,
 				&ret);
 	if (!comm_buf)
-		goto out;
+		return ret;
 
-	guidcpy(&smm_property->guid, vendor);
+	efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property->guid));
 	smm_property->name_size = name_size;
-	memcpy(smm_property->name, variable_name, name_size);
+	efi_memcpy_runtime(smm_property->name, variable_name, name_size);
 
 	ret = mm_communicate(comm_buf, payload_size);
 	/*
@@ -757,14 +755,17 @@ static efi_status_t get_property_int(const u16 *variable_name,
 	 * properties to 0x0 so checking against that is enough for the
 	 * EFI_NOT_FOUND case.
 	 */
-	if (ret == EFI_NOT_FOUND)
+	if (ret == EFI_NOT_FOUND) {
 		ret = EFI_SUCCESS;
+		goto out;
+	}
 	if (ret != EFI_SUCCESS)
 		goto out;
-	memcpy(var_property, &smm_property->property, sizeof(*var_property));
+	efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*var_property));
 
 out:
-	free(comm_buf);
+	if (!efi_at_runtime())
+		free(comm_buf);
 	return ret;
 }
 
@@ -1001,7 +1002,7 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 		var_property.property |= VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY;
 		var_property.attributes = attributes;
 		var_property.minsize = 1;
-		var_property.maxsize = var_acc->data_size;
+		var_property.maxsize = data_size;
 		ret = set_property_int(variable_name, name_size, vendor, &var_property);
 	}
 
@@ -1078,7 +1079,10 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
 }
 
 /**
- * efi_set_variable_runtime() - runtime implementation of SetVariable()
+ * efi_set_variable_ffa_runtime() - runtime implementation of SetVariable()
+ *
+ * This function implements the SetVariable() runtime service for OP-TEE
+ * with FF-A runtime transport.
  *
  * @variable_name:	name of the variable
  * @guid:		vendor GUID
@@ -1088,6 +1092,111 @@ efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
  * Return:		status code
  */
 static efi_status_t __efi_runtime EFIAPI
+efi_set_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *guid,
+			     u32 attributes, efi_uintn_t data_size,
+			     const void *data)
+{
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
+	ret = get_property_int(variable_name, name_size, guid,
+			       &var_property);
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
+		ret = set_property_int(variable_name, name_size, guid, &var_property);
+	}
+
+	return (mm_communicate_ret == EFI_SUCCESS) ? ret : mm_communicate_ret;
+}
+
+/**
+ * efi_query_variable_info() - get information about EFI variables
+ *
+ * This function implements the QueryVariableInfo() runtime service.
+ *
+ * See the Unified Extensible Firmware Interface (UEFI) specification for
+ * details.
+ *
+ * @attributes:                         bitmask to select variables to be
+ *                                      queried
+ * @maximum_variable_storage_size:      maximum size of storage area for the
+ *                                      selected variable types
+ * @remaining_variable_storage_size:    remaining size of storage are for the
+ *                                      selected variable types
+ * @maximum_variable_size:              maximum size of a variable of the
+ *                                      selected type
+ * Return:                              status code
+ */
+efi_status_t EFIAPI __efi_runtime
+efi_query_variable_info_runtime(u32 attributes, u64 *max_variable_storage_size,
+				u64 *remain_variable_storage_size,
+				u64 *max_variable_size)
+{
+	return EFI_UNSUPPORTED;
+}
+
+/**
+ * efi_set_variable_runtime() - runtime implementation of SetVariable()
+ *
+ * This function implements the SetVariable() runtime service for OP-TEE
+ * without FF-A runtime transport.
+ *
+ * @variable_name:      name of the variable
+ * @guid:               vendor GUID
+ * @attributes:         attributes of the variable
+ * @data_size:          size of the buffer with the variable value
+ * @data:               buffer with the variable value
+ * Return:              status code
+ */
+static efi_status_t __efi_runtime EFIAPI
 efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
 			 u32 attributes, efi_uintn_t data_size,
 			 const void *data)
@@ -1124,12 +1233,16 @@ void efi_variables_boot_exit_notify(void)
 	free(var_buf);
 
 	/* Update runtime service table */
+	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
+		efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
+	} else {
+		efi_runtime_services.set_variable = efi_set_variable_runtime;
+	}
 	efi_runtime_services.query_variable_info =
 			efi_query_variable_info_runtime;
 	efi_runtime_services.get_variable = efi_get_variable_runtime;
 	efi_runtime_services.get_next_variable_name =
 			efi_get_next_variable_name_runtime;
-	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.43.0

