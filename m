Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1210E606A330
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wuaSik8j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MnQDQapN
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E371981549;
	Tue, 10 Nov 2026 13:06:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XNWq_zoYK2OR; Tue, 10 Nov 2026 13:06:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C9BDC813F1
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315989;
	b=Wo4An9/yFM//dStopE/7GtgQbjbEUYd2ty2Bl/IKPNpf19tj52bXVk/FvVscQI0iTJvW
	 Bfz8nZFCvoEdrshumX0HwlyMK7KZmns6at+m8wrWvY6II//ZJnwBj572/ZRU3Qb5SDOsr
	 JQPj/yycCpLDvzZM3gqA2ipVFXsb4BCKR0aiMQsdpmRAOkDEBXFJFGRIXX+tcbMEXhCce
	 x664vgWh4dmUrnSvC8piXghW10FUaVhv8n0CWduFymstlJl6pZlrHXcuoZ+1TAV22/jQ5
	 xTl/UEZ0yTN3j6jrEL53J3hYG5cJBQsLAwJzZ+TvBbquQYJLKolrlf+zkbvvF7OYkOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315989;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BmSXg9kGEftxrbOkxMynTVq+CmfXjeSihjKfMMJ4pmk=;
	b=Fd8Ml9cDVztLcElwK3WqVUMampipIIqC9uE3QenNWsQniaMSlTIloJa4uOulWo85fyqy
	 oKGFuoUJexWKMH+hjqM5QmOKYmoj71iLNfDZsBEtfjC4GveOs5EmZ1qGY6Xixh63+EcfS
	 HFzI2DS+csb7nQC1+2cFHQe2HaGwRn1Gi5q3Wlli/SIGiVXpL2y6ldCTMfN9Z2WIXf/RJ
	 BK2UeS9IvLyO0heBOeX6Qb02jn7kejKCAwvveJBXZiGbzuMQdcSdSNvLNEtqclR/9m4CE
	 nw85jdW71gP/Ib6Jd2a3QwfWIYRSSZFPggJut7Y3i1nrM94xcFG2k3M2CzmpfeUHp5g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315989;
	bh=BmSXg9kGEftxrbOkxMynTVq+CmfXjeSihjKfMMJ4pmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wuaSik8jRTsAmo4V7On1Wj0YDXt6OjBS82vjTCwgPH49gN+kgxGnplXzyCz/eNjwT
	 jONz5e8thFddrHz/yUdDXy+25gtfX3iRIpYCMhxWiMc2lOiwMqTd5JShJcK6C/oWcT
	 Kx32j+j8RLYfewKYRtU+wWryNaIzSj6QN7iHKNqBrv+qmOOD+Td5/ai7nQ9AA8Bpf/
	 soIJmXNbSTHZiwINTIfT9LWUPCDuwU0GXXmC8JHh/kakotfcEF6g04lLevFO73VUt0
	 rf+/nKBSHcfq91x5BxNrVYAlCcxv9y/fbyjzN8lb2wapPudpU68Xzra00MHAWgkum/
	 ac/OPbVz4tbBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C9BDC813F1;
	Tue, 10 Nov 2026 13:06:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 89A51731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B38640346
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id erhFSgF5Yxfw for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A39BB4034B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=MnQDQapN
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id A39BB4034B
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F40111E7D;
 Tue, 10 Nov 2026 01:58:20 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D7BDC3F632;
 Tue, 10 Nov 2026 01:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304704; bh=B/O4oaS9HQvghWs/wbIyqJSHPSgX9qZD4JBNRmG4cJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MnQDQapNzpKXoX2nSpNrCM6UezzNiJn2VSy360FuPWYuqET4gDFvuR1HHbrNAMYgZ
 Jd7j0btEVj4isHJ8vX/0l149eMoV4+HuoJDxybYyhalJ0iiYpNnARUtL+O9e0dHYSg
 uqw/YokFMuuRS6NQFmsEYDOJnWB3Tp+POOMhb27I=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 08/22] efi_loader: add MM SP status mapping for FF-A
 variables
Date: Tue, 10 Nov 2026 09:57:49 +0000
Message-ID: <8d880710107bc8c1f88e36b7049562bfb931948a.1794221712.git.harsimransingh.tungal@arm.com>
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Define the MM SP status values as an enum and add a runtime-safe helper
for translating MM SP notification results to U-Boot errno values.

The FF-A notification path uses the same mapping during boot and after
ExitBootServices(), so keep the mapping table in EFI runtime rodata.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v5:

Ilias:

- Include MM_SUCCESS in the MM SP response map

v4:

Ilias:

- Replace MM status macros with an enum

v3:

Simon:

- Add a comment explaining the sparse MM SP error map indexing

v2:

Ilias, Simon:

- Reuse common MM SP error mapping
---
 lib/efi_loader/efi_variable_tee.c | 50 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 6a1fa39bb6f..bc15795e94f 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -4,7 +4,7 @@
  *
  *  Copyright (C) 2019 Linaro Ltd. <sughosh.ganu@linaro.org>
  *  Copyright (C) 2019 Linaro Ltd. <ilias.apalodimas@linaro.org>
- *  Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *  Copyright 2022-2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  *  Authors:
  *    Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -21,18 +21,34 @@
 #include <efi_api.h>
 #include <efi_loader.h>
 #include <efi_variable.h>
+#include <linux/kernel.h>
 #include <malloc.h>
 #include <mapmem.h>
 #include <mm_communication.h>
 #include <tee.h>
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
-/* MM return codes */
-#define MM_SUCCESS (0)
-#define MM_NOT_SUPPORTED (-1)
-#define MM_INVALID_PARAMETER (-2)
-#define MM_DENIED (-3)
-#define MM_NO_MEMORY (-5)
+enum mm_sp_status {
+	MM_SUCCESS = 0,
+	MM_NOT_SUPPORTED = -1,
+	MM_INVALID_PARAMETER = -2,
+	MM_DENIED = -3,
+	MM_NO_MEMORY = -5,
+};
+
+/*
+ * MM_* failure codes are negative. Use -MM_* as sparse positive indices so
+ * ffa_map_sp_event() can look up mm_sp_resp_map[-sp_event_ret]. The
+ * unassigned gap between MM_DENIED and MM_NO_MEMORY maps to -EACCES.
+ */
+static const int __efi_runtime_rodata mm_sp_resp_map[] = {
+	[MM_SUCCESS]		 = 0,
+	[-MM_NOT_SUPPORTED]	 = -EINVAL,
+	[-MM_INVALID_PARAMETER]	 = -EPERM,
+	[-MM_DENIED]		 = -EACCES,
+	[-MM_NO_MEMORY - 1]	 = -EACCES,
+	[-MM_NO_MEMORY]		 = -EBUSY,
+};
 
 static const char *mm_sp_svc_uuid = MM_SP_UUID;
 static u16 mm_sp_id;
@@ -169,6 +185,26 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
 }
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
+/**
+ * ffa_map_sp_event() - Map MM SP response to errno
+ * @sp_event_ret: MM SP return code from MM SP notification
+ *
+ * Convert the MM SP return code into a standard U-Boot errno. This helper
+ * is marked __efi_runtime so it can be shared by both the boot and runtime
+ * FF-A notification paths.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int __efi_runtime ffa_map_sp_event(int sp_event_ret)
+{
+	int idx = -sp_event_ret;
+
+	if (idx >= 0 && idx < (int)ARRAY_SIZE(mm_sp_resp_map))
+		return mm_sp_resp_map[idx];
+
+	return -EACCES;
+}
+
 /**
  * ffa_notify_mm_sp() - Announce there is data in the shared buffer
  *
-- 
2.43.0

