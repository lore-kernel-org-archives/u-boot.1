Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A2AC88E78
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7670180DC5;
	Mon, 14 Sep 2026 14:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PDyiMP88m1JK; Mon, 14 Sep 2026 14:17:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7CCC580E2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395451;
	b=PUrIHd9Qh+nPveNuTK40XtD57q1cX1uE2cd8hV5QCZQV+XLlqYfR0/aAVfCozUELqUus
	 YSH+D7VAic/FZS2YP3iOjCKM+zm16kgEbU+VwtcPOjxenlnKEz0T2WsQ6+blGvR1bhh0G
	 h0bZzqyH+Cfh2xMYZIMiol732dhyLdIRVU6TfSmK5je+RTl+VUMnTBBqapIgv0wXmz1wx
	 Tl9lOlEECC8sB6+dyVkEBCjy8azyTTwHET/2lFzLE/s/Hjrm6rJT/9Wj0h1At2M1+4AxA
	 gUGVYkKHsr0tbSMe2s2OEupfXYr9kvM+8Ywe6T1iR8QEEyDVJcJnLFlNy7ePKwGdBYA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=pTn3o8kUxmwdSdjAsVHswc1pJE2VMVZvc0H8jkOx0VA=;
	b=VO7Win/hylEq/rnGO81cCBVp4uZEYfyBfI+HGzNkbzst6AZLAY0i5zZYpQby0I760m+S
	 mXOwiYI9hWJqEUkjdK5CQQASC2e5Hqt/dUhL1aq5jJt3F2zLqQKk83uOxEdeEZSYxm8zz
	 V5LDD5Tc8IZEU4ojrooaoTz3j+DR9YoCFapMnYVr54hyGS9LLzB0WwrV/fyjy8q3oBoYJ
	 kHK13bdd4Wwi/7I0i2M7Y+TufVonjvSGVnriYfckYAczfSNeDBiqbsyuo8R36yveeiJ58
	 b507YXKb1r+2rVyMzaSvR1XABdXq2Cn6DIwzZ4JwJJRB28MuGPy+LRPR7v6DG7VuYpQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Lm4maqPO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395451;
	bh=pTn3o8kUxmwdSdjAsVHswc1pJE2VMVZvc0H8jkOx0VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K8ucwtvvLPTt13gAvr8y9upfEfrrGY3oAolH3BdJ1LJWP9S7MavPfOCEjiXz88KPK
	 tMU2qmMc4U6FzFS9x97fUMxP/VQh4PhKHOSiK+T0NtXgOp64Ffbe3istyHM4lXdpyc
	 ED5aw2trIFNwUdexeyOtrSO2Vlmy5NnodVDGhlykuNn/d7ShW9pG/H5vQKcE6HThbf
	 rAAULU4W1yCN9xO1zvM3JOI3rTSBQvnwaC2O90wDzMPoddn9y5bRsv2MM364AeX1gW
	 PdI2tyUPx/KwB0CKtcGNAjMjPtHpOZY0dMzfYMw3J6ou2IKGXHLBGIEuuUheh1/nCN
	 wXfO9t0yjxidw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7CCC580E2B;
	Mon, 14 Sep 2026 14:17:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E4A52D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8FCBF80DA2
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7nDGYOTuWXLU for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C0E3880D8C
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384216;
 b=MrUaMOAhrcGOtIZJR6sLDTyfKLmtqNcupvYDLB9epXi+K+tMFilToDrPiLO1e7u632yk
 pRiuSwXAOecVd7tqi4msKK0etiuZZj8AcK00nR/mKv5M1n0Ly9rHth3JVEDYZgEi3t7Ab
 KyD00IkoxTyveCWiQaKV4EhdAI+YuW937CifCyZTl9ojmLFmSh7zqwJ8QxwKgqyJt1aOT
 P8NGZXIUBJsPSYPjSuIpwtkO2lqAKb+2y0ZWDOs6bNxg0ImH70HXrgYdfCQNaff98J+r9
 hwUenzI4iaCtIgWY/f1R6PyEBD4TJylaXjzG33aVUgGQWpqnhVil4pWMvtBB/tK006w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384216;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=pTn3o8kUxmwdSdjAsVHswc1pJE2VMVZvc0H8jkOx0VA=;
 b=cP+8VKhVO+rHzlk+DvNm3N4WZl6QwjJfk56MCIG34ueSM8b7uIbhWemc7BIJl3hhP021
 VYncavjqZSiT8PLMiFa/6DT0EkYAiBWDEFpU1CRUJdNa7M4gLpCsYepEP3+vRi32XckaU
 Q8i708BVqaSahmSaG7TxBHILp1LGp2zGe2bJKNSmKCKDqW+GYqvcIR99yCnpaklRHS9Pz
 TO03FIs2EX30874ZERestWNCf7PquWi+2SRcYqGY4PFN6vdIlFDRdNpoeyQCZNiaWv5ap
 s9l/q+tZGWhn3h6oXBVFLoaFTnAayR2d3QcEstayd8rT/q+6VWJrVJasQQctA6D3UYw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=Lm4maqPO; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Lm4maqPO
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id C0E3880D8C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F4461E8D;
 Mon, 14 Sep 2026 04:01:48 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 484963F86F;
 Mon, 14 Sep 2026 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383712; bh=UycG48l+GkefoIEG5WAqNWeGW1cbPM+EUerNVT8S/Ic=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lm4maqPOZK5QopyOEbPEMs6Nnn1D0u4YVxtAgtBcvxeNflgbi/u5l59qbbbS/CoYG
 +CSViX39BLJ8z4Faz/r331baAgcUoclRKco3GPiNChRcnlNzHpZNBagpDLOHV7IYBj
 6UdaYUTCgCSLe+PW54rO14MOHKPG1UhYHSuwEbBE=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 14/22] efi_loader: enable TEE runtime GetVariable() over
 FF-A
Date: Mon, 14 Sep 2026 12:00:58 +0100
Message-Id: <20260914110106.1974894-15-harsimransingh.tungal@arm.com>
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

Add the TEE-backed runtime GetVariable() implementation for the FF-A/MM
variable backend. The runtime path builds the MM request using EFI
runtime-safe memory helpers and uses the shared MM communication path
after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

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
 lib/efi_loader/efi_variable_tee.c | 89 ++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 5f494731ae5..254d6bf8909 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -994,6 +994,93 @@ out:
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
@@ -1259,7 +1346,7 @@ void efi_variables_boot_exit_notify(void)
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

