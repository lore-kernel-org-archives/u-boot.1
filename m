Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A07C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63067811A0;
	Wed, 29 Jul 2026 12:28:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QLsZLVUQri0U; Wed, 29 Jul 2026 12:28:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EF8F811E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328107;
	bh=cGDyVHpmjZ/pK5cBe9/CQKsBbCQoYOZn6iJIHwT04h4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WHEk9SvfGEAsWIN8hFL8TG2selhNtoIcx7jWyQjSUdnmQWEubjGJ9QMLdAn4wUuSt
	 IE9XxnU8m9y1Ut8/nC65xYPQqxZiwiP8Hc/MClNLEaO+Hf94fYHuhQHwqiyxsl5DVa
	 o7T5IzP1hbQp+gs7iEKnTaKDCMebpMYKwYH0KO7JYIDcwvehq4vtICaiJgxfv8uEcq
	 xRmJFqM8jYS7AaMZoPSEPNlsKpzJbyh9Hxd78aT8Un92yd2p3GiB/ADZbeQjuDI77v
	 NpMRH4/n8c9Md9jTMnAmYXBhZ1BDWoDiMSAReWKATna2JGoQZ1tINaRaUV0KpC47Jk
	 hgAyOj6b75xXA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EF8F811E6;
	Wed, 29 Jul 2026 12:28:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4B372490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DD9580FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n_IeEOxRR2Nr for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A23E380F85
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A23E380F85
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A23E380F85
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:02 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBF4C8493F; Wed, 29 Jul 2026 10:52:00 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B25B48494B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:58 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9FBC169E;
 Wed, 29 Jul 2026 01:51:53 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712BB3F66F;
 Wed, 29 Jul 2026 01:51:56 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 08/22] efi_loader: add MM SP status mapping for FF-A
 variables
Date: Wed, 29 Jul 2026 09:51:10 +0100
Message-Id: <20260729085124.2618817-9-harsimransingh.tungal@arm.com>
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
 t=1785315117; bh=Qy9qTVhId78TZLSzb35ziexbWti98F7n8gKs5LumWf8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=a0eEEZKqPgKIpf00BwfhzkwoaZJWTyRWLTofRopMrC0oomF8smSEzw5jZ3YVpFS5n
 8vbmtqnYrzTSy4G7IRPiMHTFuNO9dAKdzNWH6AogIQQSOs6hfA1V9ZOxYXp3h7y0jz
 RErvPHOMGIoIe5jqsinw+0HmGnDnt7IblYMLO6is=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=a0eEEZKq
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="a0eEEZKq"; 
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

Define the MM SP status values as an enum and add a runtime-safe helper
for translating MM SP notification results to U-Boot errno values.

The FF-A notification path uses the same mapping during boot and after
ExitBootServices(), so keep the mapping table in EFI runtime rodata.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 50 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 6a1fa39bb6f..8a75da414f7 100644
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
@@ -21,18 +21,32 @@
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
+ * MM_* return codes are negative. Use -MM_* as sparse positive indices so
+ * ffa_map_sp_event() can look up mm_sp_errmap[-sp_event_ret]. Unassigned
+ * slots remain 0 and are treated as unmapped MM return codes.
+ */
+static const int __efi_runtime_rodata mm_sp_errmap[] = {
+	[-MM_NOT_SUPPORTED]	 = -EINVAL,
+	[-MM_INVALID_PARAMETER]	 = -EPERM,
+	[-MM_DENIED]		 = -EACCES,
+	[-MM_NO_MEMORY]		 = -EBUSY,
+};
 
 static const char *mm_sp_svc_uuid = MM_SP_UUID;
 static u16 mm_sp_id;
@@ -169,6 +183,28 @@ static efi_status_t optee_mm_communicate(void *comm_buf, ulong dsize)
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
+	if (sp_event_ret == MM_SUCCESS)
+		return 0;
+	if (idx > 0 && idx < (int)ARRAY_SIZE(mm_sp_errmap) &&
+	    mm_sp_errmap[idx])
+		return mm_sp_errmap[idx];
+	return -EACCES;
+}
+
 /**
  * ffa_notify_mm_sp() - Announce there is data in the shared buffer
  *
-- 
2.34.1

