Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D68606BFD3
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YaxKK7CM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=AtLb3ATE
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7982981753;
	Tue, 10 Nov 2026 13:06:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3GoWozIskBM8; Tue, 10 Nov 2026 13:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E286D8154B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794316011;
	b=qF+8oolQpDWYEfYT25/stc/5HZyteZQVMgLmuNDjdieFSzp3ZECS1cVBxt/WzLTqn74a
	 LFQacVfflqou/rBw2LOFrt6D8kx6GbpX8AC4J0ZD+42ndwIGPT93+dBYNsaEdBlMz4NKn
	 Xa/GSq/ZF1035wTvYmqfVL40SFDSQUurM/RgY++yFT/TTexZuXlgPeIP6mPKWP2AkIcBv
	 1hStCQsjVueqtQwm5YPUslUXzgbJ+h3zHpToMxrGhPgwqvJaTC0bxIoE5yFyF8YAz8TE1
	 yOPaW4dShS3LO+YVzKFfIVRE9LNtWxekWU1zy3auOgDzjOL8sv0ddZJzrvN3ZWFF/mQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794316011;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=jSTlPVth4K1ZqRdl3DtfvzFTIVG4fJHG9mqY6ym7kbU=;
	b=iXnKVobHKTCK7jHK1EVOgvKRYg4i6BDKPUu15PTK622D5uHzw2SXPkEuiTCqXCVmk6Wv
	 Iuxj2+crPEkY1cp9ePts8AS+DNz3u5a73nlqPnoDzx2thDKGs1XNhCh6htXgZDk/Ugo7+
	 4Xoj0XWV8603gqs+ySABGFSjcJ+N+/9E7s1JwBrIXedSDso0iiSYfJb6WyFmvmWKChiIo
	 YBx5MO8VGh/z1aE3ERKrXm0EwjQ0RnyNnM39sVbXTw9XOToWxEp/U6Uw61IbP0U7MiLeU
	 P5HG7UzHxBEx9WepYM+VjyEV4Yme7XqkXWNwAl8hT6X2Tt7u1ORMxgsn0W3SpGxjq/Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794316011;
	bh=jSTlPVth4K1ZqRdl3DtfvzFTIVG4fJHG9mqY6ym7kbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YaxKK7CM4thg5qD/1Vi/QndhoYz+rbePTahrmmbHRAg2V5Iu0QbuI4z9+sgSrihQB
	 EsD6DQAxYQGBKfwlZ0tH7DhUA70EzwxSo2jB9WxfGD2EIIzD6bYP9GRx8rV3BZpsbX
	 ZD/wcUfpXXg8v7irSqwlE4w/S4uqLth5DYtUoHzmF4PHF1jOAiAxiSd8yDbd0Q5JY/
	 17IWkLwE5Kfm7L8SQeoN0hdx60jt1qcZCcnKib/fYrXu1YsbLid7Wu1sYn0z3KKcih
	 JY8BzEdezAXuGFVB8M5x/yJZOJPU+4iYIYGl1xKV7c5ppZVpDkRnZ2VFyGDPOIMhr8
	 BLSA3p/yR8xsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E286D8154B;
	Tue, 10 Nov 2026 13:06:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C4363F15
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AA84A40347
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIgbbCEJHLlr for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org BD9894008A
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=AtLb3ATE
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id BD9894008A
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C2A41E7D;
 Tue, 10 Nov 2026 01:58:34 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E3FC3F632;
 Tue, 10 Nov 2026 01:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304717; bh=PAfZzB6INKQ/HjesBxfn9BMm6G1sodo0JbtnMweAqx4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AtLb3ATEmEfDt71UW7GdtnYnBRCFStP89ltpLgpU3asqlOsgYx9SGF2p7PMCYMhyt
 5WKTjMCXJXApDr0wSnIiOEaJZ6CiwrDcAiEXlZhTZPwMbNJCbxru7sTi6wlkocg3du
 tOOiHb8cHhQcZBt0JnNAvkEJM58fHaJwditds+c4=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 17/22] efi_loader: enable TEE runtime QueryVariableInfo()
 over FF-A
Date: Tue, 10 Nov 2026 09:57:58 +0000
Message-ID: <e2d5fca8121bf452af978a2cef749b5add724d42.1794221712.git.harsimransingh.tungal@arm.com>
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
 lib/efi_loader/efi_variable_tee.c | 64 +++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 9bcdef5887f..5a887348c39 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -1201,6 +1201,59 @@ out:
 	return ret;
 }
 
+/**
+ * efi_query_variable_info_ffa_runtime() - get information about EFI variables
+ *
+ * This function implements the QueryVariableInfo() runtime service for
+ * OP-TEE with FF-A runtime transport.
+ *
+ * See the Unified Extensible Firmware Interface (UEFI) specification for
+ * details.
+ *
+ * @attributes:				bitmask to select variables to be
+ *					queried
+ * @max_variable_storage_size:		maximum size of storage area for the
+ *					selected variable types
+ * @remain_variable_storage_size:	remaining size of storage are for the
+ *					selected variable types
+ * @max_variable_size:			maximum size of a variable of the
+ *					selected type
+ * Return:				status code
+ */
+efi_status_t EFIAPI __efi_runtime
+efi_query_variable_info_ffa_runtime(u32 attributes, u64 *max_variable_storage_size,
+				    u64 *remain_variable_storage_size,
+				    u64 *max_variable_size)
+{
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
+}
+
 /**
  * efi_set_variable_ffa_runtime() - runtime implementation of SetVariable()
  *
@@ -1281,9 +1334,10 @@ efi_set_variable_ffa_runtime(u16 *variable_name, const efi_guid_t *guid,
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
@@ -1357,18 +1411,20 @@ void efi_variables_boot_exit_notify(void)
 
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

