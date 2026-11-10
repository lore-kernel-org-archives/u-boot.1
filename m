Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790C606BFD7
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m4s/ubLj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Xd4HaJAy
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CC0C812AA;
	Tue, 10 Nov 2026 13:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u6PzNX1K34sD; Tue, 10 Nov 2026 13:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 79A3C816A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316007;
	b=NtC0Yv+0tdAiZzu8YQb19XTf+7E5mf3/tJo47kKSVCDdJ9uPex/q7qJOMIqtp2fWTobm
	 wlksayarGRVenFA9WUysaqXxsJm3aKUE5FpdzT8RMPU+Y5v9srkvvh54x0l0dnLlsrdV2
	 eDYcL63vrzlrAduJcaVZxj6tAqJ1sT/Jr3XTO+wvJ7LrE0rZPye22LVcCWZpPehOquRd6
	 +mT3Zyb+daza4fqmR+upiZO2jfkcQydWXp6roFq1VGzyNsQpAg2z4+ChpQhIitVd3AbH9
	 K2g0FDjHCVK/5RyLf0RtF02jiYczY2KB3xvA9eIX31B9+fCArpRBMn2ZnUxQLYjvQdQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=JPR7McQh4gnYtkbZ1umPBqrsw7ObN+sVRNhaoxkCrkQ=;
	b=EvX/Y+X8vDzfSv7I7VTXJKNmZc/UvuzadfWCb7OXPid9mlapGgW2POsYYJ0iPiLzck2v
	 GDXqZVH6tkgUbKPEcigvvRwj53gs7+bVEmYppJih7jojtl02kLD7G3L+odyd/at2ADzFa
	 U8mkbzn2uYqZhvcLXkyEbkZbTqsMeaW2yNFI91NJZdTS2M9ImvF1W+Q0E2HzfoVD27v9n
	 443+f7FAFeyFbuMktoWGUQcEBdspn+vtWeLc5po1sdGnQXeaVYQLO6UUgB+N1ntjCnXeG
	 fEyigtbJlzukg8SG2v55usOHp4yxVPzX/nToH5kPv5P/7LMio8QFT37Zsh5EyFhzCsw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=Xd4HaJAy;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316007;
	bh=JPR7McQh4gnYtkbZ1umPBqrsw7ObN+sVRNhaoxkCrkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m4s/ubLjs5IvODz95KaKSIQRO9cfThRLXBF+gAkDSiiYGIw4OKy9UI0vFEbmec8ZU
	 pFDyrVYr2E6HD79Yx8ZO+hKv2tmP36Ky3YzD3f7L7m/xLFhwBcZMHfYGt0nr2rfsgd
	 EzIUcDSlWsckMYHJxgDrR4HaUYsRvEPH6R3MaoHFBZgCWVkVuWyZG+09f9inFn3twW
	 J5qT9TptmESRuxo40U+Ou5Q/zu2VNB0hRSMSLCtWgyg//Mk4amPFxrArPgpUMZTCgU
	 Fs7kPq/Je8hcZWOtIvJzqLvcv1d3V6U6T6OwLSN8qOu9oAlEIlEvUOrO2zj7NE2AAi
	 NMygLhjq0mPUA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79A3C816A0;
	Tue, 10 Nov 2026 13:06:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id CD7DE731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8E4F81113
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eG_511dUUQH0 for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E3858810D4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=Xd4HaJAy
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3858810D4
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD9271516;
 Tue, 10 Nov 2026 01:58:32 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F2583F632;
 Tue, 10 Nov 2026 01:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304715; bh=bUC7dcEfTSP6ohgSfoBirJ1q83qldBn28Q8eI2J0YNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xd4HaJAy4FM1G1mL9RO5xoPkk6BusX90UBIzFKvDecTQIxMW4oFQOCB0W0g6jwnqv
 ZTjV/sZ70ftpFWiFbjbXjnWh2LBxb0Bxv4BOZalsgBi197RQKQE828aesDhvcvBAvr
 P7JR5Poamrcz6HSR+jUrHyrDruYD7vz4xmWEKjQ0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 16/22] efi_loader: enable TEE runtime GetNextVariableName()
 over FF-A
Date: Tue, 10 Nov 2026 09:57:57 +0000
Message-ID: <aff456d0ff53ea9b9408a87bc6406fa684c42f15.1794221712.git.harsimransingh.tungal@arm.com>
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

Add the TEE-backed runtime GetNextVariableName() implementation for the
FF-A/MM variable backend. The runtime path uses EFI runtime-safe memory
helpers and the shared MM communication path so variable enumeration can
continue after ExitBootServices().

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v6:

Ilias:

- Restore OP-TEE runtime callbacks when FF-A runtime mode is disabled
- Rename FF-A GetNextVariableName runtime handler with _ffa_runtime suffix

v4:

Ilias:

- Split the runtime GetNextVariableName() support out of the combined
  runtime variable-services patch.

v3:

Ilias:

- Rename TEE/FF-A runtime handlers to private *_int_runtime names

Simon:

- Add EFIAPI to the runtime GetNextVariableName() helper
---
 lib/efi_loader/efi_variable_tee.c | 68 ++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index fb6c3c78c8f..9bcdef5887f 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1007,6 +1007,68 @@ efi_get_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *vendor,
 	return ret;
 }
 
+efi_status_t __efi_runtime EFIAPI
+efi_get_next_variable_name_ffa_runtime(efi_uintn_t *variable_name_size,
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
@@ -1296,15 +1358,17 @@ void efi_variables_boot_exit_notify(void)
 	/* Update runtime service table */
 	if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
 		efi_runtime_services.get_variable = efi_get_variable_ffa_runtime;
+		efi_runtime_services.get_next_variable_name =
+				efi_get_next_variable_name_ffa_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_ffa_runtime;
 	} else {
 		efi_runtime_services.get_variable = efi_get_variable_runtime;
+		efi_runtime_services.get_next_variable_name =
+				efi_get_next_variable_name_runtime;
 		efi_runtime_services.set_variable = efi_set_variable_runtime;
 	}
 	efi_runtime_services.query_variable_info =
 			efi_query_variable_info_runtime;
-	efi_runtime_services.get_next_variable_name =
-			efi_get_next_variable_name_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
 
 	/* Record that ExitBootServices() has been called */
-- 
2.43.0

