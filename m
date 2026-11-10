Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0AC606B2C8
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Hlcgyi46;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XgicdF+k
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 79064815CA;
	Tue, 10 Nov 2026 13:06:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o-WzuZkmsLhi; Tue, 10 Nov 2026 13:06:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F33C481573
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315991;
	b=hZAMDWX3r3Q8C/q7KoSgocCKEkO+Swkjk6RC9MnYpqjNf6YckmtVPgCi4vYq2u4H83q9
	 wn+MTBMyLeT9j7Y2kyWU8bG6oi3mmEafADEy8Trb7oyreBYs+KtTxBpCBqEKKkuD+y6ML
	 eWNS2+adaQQl+4VwqvmubaBFVVIPkeX4qNXVqgBcb4ZQ9ko4ylxXTGvPq3FjKaVZ34gxD
	 YO15zDnF4J1UXIqAG3ppQvAGoeZZbHTjiZQz7chIsKT9dWBQ/U2YKdgJU1fAN4hI+vimO
	 ZhjWis1gyI6sT4Fj7KWfFMgNu+HaCQZMQnPhgzyuP2jnmAyBJnZfc5PY8HRn41dtjrg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315991;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Fc/PEl15kQ1MEMfTeAl4OqGSwtAqkftphUVyZSFedok=;
	b=cgKdKy4ZgVGlyCukSfWHMs3X/PORUAW0WSMBuQviXXm7DJAjS66vM2h6D8fqyYMlX6c6
	 2BMbQgmfGXt2Fc8uQ7637JWovYrxSdyjoptxoqsRIsHey7SHpKfwcJzroILKAq90VPA0W
	 HkY1PS0Xz5OALXctbKZchvTnHGuJTPtw2wC1xU101DpbVDGIqDzoKBWcno22oN4tKmqOG
	 jbMjp1KpssBKe256nEdJu/3/NJ7fbqt0sj+K830fYLJ8hiZnebxhuJCE5rCBvWnx5Y7j3
	 o4iksOwSntK/cwIhfyF/pS/pJEcqh+jrlIiUuo7JNqUghR/xJHgYVx1W5w2r4oPTp6g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315991;
	bh=Fc/PEl15kQ1MEMfTeAl4OqGSwtAqkftphUVyZSFedok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Hlcgyi46YNbRcFspSsWYFxITpSZXHGyx+QNfPOuMX4QX09Aj0f6UGFvhLPSmYSY0b
	 WNShThBq6TNDtybrycKwbOcIJArPvvUEqdX/6APv19a8N9//jsUuptE7b7jrW246D+
	 ov7kXNTAQYR6N+lGOiZwO+RvNG59ky97AaxA3t6ca1c+0lKvjz0AG1BRlQnesBgolP
	 FGVjEm2S9RBAnqWdsDvMDT7qccjUNnAv2pSFGUhJJPb5KCGXxMrq0fRLq40JA04TEz
	 7nWuv/TDhZYFRuWjokHWzvQRGzLup/puQ875/T2+ESodpcR+b2xXcOh36BP2ThpTwd
	 sE18o+8XlLrhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F33C481573;
	Tue, 10 Nov 2026 13:06:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 53E94F15
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36BB5405B0
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FIuHfin3gryn for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8E8AA40819
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=XgicdF+k
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8E8AA40819
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 732091516;
 Tue, 10 Nov 2026 01:58:22 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B0C3F882;
 Tue, 10 Nov 2026 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304705; bh=9OdRUQFRgsdorpFv2X0m6oS8cs3YCa4PDwTFoMVC2SI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XgicdF+kbWduAEATxYNgSNYJKP5AAzk/GNn6yB6IqhCDo/lInw/eVhDLP/POPDqWL
 pAFmIXbY92/fueHY8dNiFOidzLAJ0HG02fDCBo+G3Ac/RTkkmXf6iz2lafDjvYGmCD
 2tQh87/pkwXU3e470skHePPy/mSEm33uuJAAExa0=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 09/22] efi_loader: make MM transport selection runtime-safe
Date: Tue, 10 Nov 2026 09:57:50 +0000
Message-ID: <3b1131cc72cf15fb25fb5550bec795c2321be940.1794221712.git.harsimransingh.tungal@arm.com>
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

Track when ExitBootServices() has been called and make the MM transport
selection helper callable from EFI runtime code.

At runtime, select the FF-A transport only when FF-A runtime mode is
enabled. Otherwise keep using the OP-TEE MM communication path so builds
without CONFIG_ARM_FFA_RT_MODE do not lose their existing runtime
backend.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v4:

Ilias:

- Keep OP-TEE as the runtime fallback without FF-A RT mode

v2:

Ilias, Simon:

- Rename runtime-phase tracking to efi_at_runtime()
---
 lib/efi_loader/efi_variable_tee.c | 44 +++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index bc15795e94f..50a98a1dd0a 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -58,12 +58,28 @@ extern struct efi_var_file __efi_runtime_data *efi_var_buf;
 static efi_uintn_t max_buffer_size;	/* comm + var + func + data */
 static efi_uintn_t max_payload_size;	/* func + data */
 static const u16 __efi_runtime_rodata pk[] = u"PK";
+static bool __efi_runtime_data ebs_called;
 
 struct mm_connection {
 	struct udevice *tee;
 	u32 session;
 };
 
+/**
+ * efi_at_runtime() - Indicate whether the system is in the UEFI runtime phase
+ *
+ * This helper returns whether the firmware has transitioned into the
+ * UEFI runtime phase, meaning that ExitBootServices() has been invoked.
+ *
+ * Return:
+ *   true  - The system is operating in UEFI runtime mode.
+ *   false - The system is still in the boot services phase.
+ */
+static bool __efi_runtime efi_at_runtime(void)
+{
+	return ebs_called;
+}
+
 /**
  * get_connection() - Retrieve OP-TEE session for a specific UUID.
  *
@@ -399,27 +415,30 @@ static efi_status_t ffa_mm_communicate(void *comm_buf, ulong comm_buf_size)
 /**
  * get_mm_comms() - detect the available MM transport
  *
- * Make sure the FF-A bus is probed successfully
- * which means FF-A communication with secure world works and ready
- * for use.
+ * Make sure the FF-A bus is probed successfully during the boot phase,
+ * which means FF-A communication with secure world works and is ready for
+ * use. During the runtime phase, use FF-A only when FF-A runtime mode is
+ * enabled; otherwise keep using OP-TEE comms.
  *
- * If FF-A bus is not ready, use OPTEE comms.
+ * If FF-A bus is not ready at boot, use OP-TEE comms.
  *
- * Return:
- *
- * MM_COMMS_FFA or MM_COMMS_OPTEE
+ * Return: MM_COMMS_FFA or MM_COMMS_OPTEE
  */
-static enum mm_comms_select get_mm_comms(void)
+static enum mm_comms_select __efi_runtime get_mm_comms(void)
 {
 	struct udevice *dev;
 	int ret;
 
-	ret = uclass_first_device_err(UCLASS_FFA, &dev);
-	if (ret) {
-		log_debug("EFI: Cannot find FF-A bus device, trying Optee comms\n");
+	if (efi_at_runtime()) {
+		if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE))
+			return MM_COMMS_FFA;
 		return MM_COMMS_OPTEE;
 	}
 
+	ret = uclass_first_device_err(UCLASS_FFA, &dev);
+	if (ret)
+		return MM_COMMS_OPTEE;
+
 	return MM_COMMS_FFA;
 }
 #endif
@@ -1018,6 +1037,9 @@ void efi_variables_boot_exit_notify(void)
 			efi_get_next_variable_name_runtime;
 	efi_runtime_services.set_variable = efi_set_variable_runtime;
 	efi_update_table_header_crc32(&efi_runtime_services.hdr);
+
+	/* Record that ExitBootServices() has been called */
+	ebs_called = true;
 }
 
 /**
-- 
2.43.0

