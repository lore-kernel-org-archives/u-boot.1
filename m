Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C76C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EAA180EF9;
	Mon, 14 Sep 2026 14:17:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4GCDgBBkFM8; Mon, 14 Sep 2026 14:17:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BD2B080B5F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395477;
	b=qZMSfgcapOfYo0B73u9vOqZcIomn7Nmu2Ef3Rg+RWKcpbjSWKU+VuiExL5EtNF0ZXcWa
	 H/jWks9KF3e76MhCsoyac0pOWLqAt0jcOKqcVbMACxbUPu+vsU/y99D4Sy9ABYYOL3q4P
	 SH91Uc+9H8+2YdlEKSToTHR8YVvXfgpMTUu1bL4dFyb3JSl7jPDN3WVGqCixt3wiWrtOA
	 VKtKHyRPsFvRPN5vnHXZPh0QVRSsdExXQpmvU9x86R9NoWiMrWaTcGIMAWjpgFEXI+5Ct
	 uOuBuaAc4leXL2BYVLtLgwEDV8Kj0vGVGxkC9Z/Sgwp2Wi9iXN+Tm6uG0MghQpE01gA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8SnlEhAtLo9OeqfeVJd7qvL5DOhkWk5icVRqDGyJyJg=;
	b=k4bjR66v8eBhpns3M1jJtfCTbD3ZiCh6a8PQCCmS9rP2xkP+K8AW0xWzmkhwL/+BaTVe
	 OJ4TkZ7zWUM4ddwrTQfqMjGwIyLZO40DcT7fEpTHYJHeZYaT7VRiLT/blD1Iyuw+ZFfUU
	 v6OFqvKI6TU/TXuDHDylB+7Xc6uvtiH4vGM8PPK3nNPkYKDRS1cNvKbvNAeEr5c39Qoel
	 aH8ICo4JoSUQmcX2mGYN5ZTXYcyHJOJHy4fu77bBiaR00Q/h1VBy2lvkReM/fi8/KGD/B
	 Pdv6lgFs6KFV4Uc8HoO7vg9A0lpMzMuMC1Jfi4lFRGKCXvsLRBUhFbE/DVotQExrxxA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395476;
	bh=8SnlEhAtLo9OeqfeVJd7qvL5DOhkWk5icVRqDGyJyJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mYIHPjdUYtq7XyfiXAirCi1cL6xwx0qrWtNLeQBfRKgmKaqP6cinFDY8TV57X9JIT
	 2LS2NUXogCVnZ2xjIQ35AE0WT5sJKJzca0BcTPGtl7OqSCqBpOVNNdBwikfo2aso3Q
	 zrvYUKTR9phZWMWwUqu8vOToymQ3qHbTa7DpqX9fN0hZ7g062ccoJHDJKZqAAfHQ+f
	 Q6II3OWLxxMLEUh4XsmXN0xUVeD5uSxN0xvT09pdFmwCIaDoCY/3411+ltyUttY8Se
	 e2P1l5/+PIz/4sc8v5WYZfxZ6rAR6lqcOlRZWrTpl7GSYMcblUT98eYbbaRmx62CrB
	 zClUg218SMLAg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BD2B080B5F;
	Mon, 14 Sep 2026 14:17:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 97DBB493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89928606A0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J7NrP0SSsYE3 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7E97360692
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=VVSFTjB7LG/qALVkPjkuA6znYVPI6jXhm5aaC9QMDUxnI3LwWDFfE3fSE6szyP+i7il7
 YnSteCUaJ5ZxOy9Cu09xAW21DzbneeYjHoSNRvj1jfs+6II6i/M9/JoNXDA982SZgorNO
 Eq4a2Z/GypC2KD10kMh2JcB8A2bQiEOZQQAkSqaYSj8JAEm0Mswh+GsGFVb3GXDcZ+ccS
 JJ6/+dF+RZn8o42Qy/IPAlcAN8SVXf7o9BoymroZRyGtxeRdIeoAF+7npu7WtZqPm0AQF
 Atq/9PakCMsXwIPq3dAP5XU+tu7ZETvhyxaewxVusq1Z2qZx04jhiLqCR1neM7VAARg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=8SnlEhAtLo9OeqfeVJd7qvL5DOhkWk5icVRqDGyJyJg=;
 b=Mzqlf8pu1asOXiIDh3Ga6htMwNPYdoiGImfh9vm7qCupDEXaET8P+IzG25WDiB1xBEbq
 3vp0p/3PzU2byy8wO9TLOYYxL9tU8Zso8lPezB4nbYUbG/BmaMcwrDtPvzOYEciX1nEFP
 Oq9HForfQCVS/rSp+e8UWztTq9UsXz8PUjKWBxLs+Or+33Yc794Hi+xyhPvwM8x5xrkd0
 Q9hGUZvENLcfVWMdFSJ0SBJYu6tJieZdqH9hDA8pxxNiONBVtt+c9jO4nK6JP75BnxmS9
 wPblmgB8VXVL4v+w/utYsUzUn44clFsdqS0r0qgF3jdOoRHBFEkGogvi/Je9Bdi1uXw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=odYiZuds; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=odYiZuds
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E97360692
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3750E1D6F;
 Mon, 14 Sep 2026 04:01:37 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970EF3F86F;
 Mon, 14 Sep 2026 04:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383700; bh=Mtyncx23eXx9oA1jVuLkwfPV/7jUQIDLOQBqWBiEyis=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=odYiZuds5NkrPP4ufizc3HHEE44eI6kMykj4+jTs3tlcf4NYDi2J78UkvKzfKppdq
 3CK8xdMqMLe2hc3+49covLMu3vWAh2XOsh1KqDPwOJ1F6cL6Sx66GA0hTk9CDb3d/5
 B9YuJmMezac+zj+Cki5CFylWp6Iqnaa7QUnocA1U=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 08/22] efi_loader: add MM SP status mapping for FF-A
 variables
Date: Mon, 14 Sep 2026 12:00:52 +0100
Message-Id: <20260914110106.1974894-9-harsimransingh.tungal@arm.com>
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
2.34.1

