Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A7ECC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1EEBD40712;
	Wed, 14 Oct 2026 20:03:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wzAecqTGPMPy; Wed, 14 Oct 2026 20:03:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5430F406FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008215;
	b=Ra3qWCjndApls8qawoIORg+hNGd2bIQEvkMQZXszSS1xi3ihdmiwKH2iDzxbPq3MqK8A
	 ykkBuExXdSA+FgStD/5tILp+aqLbIiKIRscsciJD30Z//LlCZI605tV9KcufCQ5HCUkCF
	 CStnu3KhJunYQ9P+gpAy0RWS9AwsRZMvS3tl/F8HrhCr5Cc8WtcM/i+S/S8T/FMt8psRP
	 +SwZfIX2Zw48mDjFost5dPdoAVLfU6jPNE2q/cm7jHssAoWXzB6qeRBTI0Q8XAgefjbg9
	 K8Im1vSS1GSL0YPKYSBO0Wl2pzb/LbppsQlyNrF7YVDMKph53Sz0NcId2t8/I8AWzPg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008215;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=BmSXg9kGEftxrbOkxMynTVq+CmfXjeSihjKfMMJ4pmk=;
	b=CMrH6sWPGC0EKidzPn0FGeaomSwQIlABAu4FJxHwTLWppy2t2qQY+E/CqWodV5zhmjBe
	 CRB9LsXTmYqEebeSPrXOGxTrccO5z8lXeYxVbnzbKTobu7j8Q7BDoOI6hg8k8cHhQEzFk
	 Uex13FYFiTgwfXat0gWaCcufY5OyeN/Y8xYfu+zr1oEkH6pnn42DpZYJnQdfLDmCZO6aL
	 1ePTgoHDmVEot9dUvpmbkATCJ8/0Is/ERj4qGbZJ27RLdtcEP2MS9x8PErocE9g1wx5ed
	 tI895bvkIf/VFQdn7mtxXnbkNpuEb9Zq3ZIAGBALGq4MWj1jwLWQvgj/Lfi8aWtcPhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ndOyhKZT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008215;
	bh=BmSXg9kGEftxrbOkxMynTVq+CmfXjeSihjKfMMJ4pmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qBuul2PLUNlb5o3yryfesiycAJ5oc4cdwHc/MmN+Hw+yoRO9yQ+pC1br2oGbjv45J
	 djLXOo9/3aUmMvF3ZHETXho8kHZO7VqiK+qNWez0hmny/Qo6YeefA2cOToDgxTu/FK
	 3xm7TK2CgbSEs5Mt5KviAJV202T7TlC/NHLQfRC3uWYJVfjBK69IP28Hor2NNj+Zrp
	 A9OnsZ9c/h2THI9FDXrRz1jIBWOlfk7Sdj1JDCH2ta5cYRBhtQeb2wcgg/2+wf5Biy
	 JJX33bqzXPX5Igl7JhXusrq92T+dTY6suWd4IzBeb/rIyP5BmK1teU1/CUQFXEDAkz
	 /vG+itWIudwwQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5430F406FB;
	Wed, 14 Oct 2026 20:03:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C97C2A58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA620407A0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RseO3JJgpQbp for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D97E6407C0
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002205;
 b=lXdC0dfm66Wz5hOfD9nHnZFzYKgk0JnXhRKJAFjFl8HXraFIlu2r1jA3zA/wwr6QJFW6
 fFixFyfvegnG6TCN8ZRLsLPQli9HA2gPW9HCYrsxRYjWOQBAoP5cZFgevtM1/uRRnqpvY
 ozUb9ybvTrSTBo5GLdTae3PsG4Qus4CQY2TNlp/qbCBI4YClWxIqEcv/6EdVGSlL2ULZH
 xEnsdAqdWfx6z4x2LlzlhOP2XK6XRPb3t1YsEr1m2G8SH5iD/rr846Hn9FGNRcAAyVS1u
 cNG7FGpRS37AW8yTJik1D4ppLwMURxKXDRPR24eJvicHmz8jtD+4En+KUGUZyKnpJgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002205;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=BmSXg9kGEftxrbOkxMynTVq+CmfXjeSihjKfMMJ4pmk=;
 b=MOecEUhytwTyWsKDwyq0xwuGNkn1ixqrz8F0aRNfjYoYO7aHz4nquYgjrCXupEb+x/Rs
 95sn80DQtKEbUrymhXRL6TEZxV1FkUdeE2O5vtz7ygT43fdOwDBwcKmZom2AGEAcMEQlV
 B8xwzNxEDbFrjjnoKGbIPBDDiKu6dExSWZ3acCZhbazTHqshy8jyL40BXYTLE15dOPT0D
 mVV87OJTttqm8XjCX5o9Jan3rdQ43cNpYYbiZ7j8d25IpnWM7KuyKQjCfewMhaW3o5xBI
 NlfXZ8HpmlrwLZAcXLHzvh0dZM3QkC4mrP6AoxBcql402YlwbR4vEABhyP7TmvD9c9A==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=ndOyhKZT; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=ndOyhKZT
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id D97E6407C0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0EDD152B;
 Wed, 14 Oct 2026 11:23:20 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC76E3F871;
 Wed, 14 Oct 2026 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002204; bh=B/O4oaS9HQvghWs/wbIyqJSHPSgX9qZD4JBNRmG4cJQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ndOyhKZTs2lyccYIYSM97smDbCQ1kir6uuDM5N5oy9dXwdNG4DaSOjgT34og54LEs
 TBsB8kDfg9mjIuRTRPlGhCPHo3admWFl390H8o7TD+2OPaGPrGgUQzSeQbsx4OcFWj
 INwnfMi+XyFVgV9jg1s+oxMSJr17pEhXJ78LFgmQ=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 08/22] efi_loader: add MM SP status mapping for FF-A
 variables
Date: Wed, 14 Oct 2026 19:22:48 +0100
Message-ID: <1d9eccd99b93a604113d2cb9eac38610582240c0.1792001844.git.harsimransingh.tungal@arm.com>
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

