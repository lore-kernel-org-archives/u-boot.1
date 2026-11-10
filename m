Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D6D606E473
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Y0H7gF7q;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QFLhCgYM
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0777581298;
	Tue, 10 Nov 2026 13:05:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jPkwyOu_r8ub; Tue, 10 Nov 2026 13:05:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B9E64812A0
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315926;
	b=tf9Jfl9MeaSXoLdkXaXDcNkT3TeXHK4YU8QDRAAhRC3hBjblgxth+9LFrv3qxRhwMnd1
	 Gc2g8EzFZPwbUUN/vpEGJXivQksbg+b9WXS2FT6RafzaG4oG5bBBj2woYJHj4JJ/I8k5y
	 H0kSn+6RxRFUV/9xYppLqM5X9OOWSb6nbr2if807izp/T/ekwGD1G9odb2gvX5jN2M5Md
	 xm/vI47ddz1yjrkcdeBmCQtIi9Cx7N2qI/ki2bbnfFwqeuoEGliXdgne5mffleWKNz03y
	 2z1Stul0CzBK90sxv9pn8zKB56RHqTlz/0fUn3bTHXyfm5q740Y3hXb5iokY28Bja2A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315926;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rUkZgoS7Gm1Oqh1GneK/SW4fpXRzF/61thJg9hPN2pw=;
	b=ddiziIMXdi83unaZ2RwmqEXA0V8l3DG8EhKhw1rPGlhJf0QPFtSzS87O3VyJSdnTSbbH
	 33lIikQHaJCH0PZ9CDoIZnJedPXkTeQtuILH0AwpvN4ZZxHlw1EkePKJEjWYbZPZo6lOV
	 LXHzMjmw30OeWYwYoCiIBZIOghikb+sesEb+kx8epAfYF77TkPFNeWJNSt8ooLOSEqNl1
	 7XrjTmPZzJkSziwcbhbZBAsq9LfAiEh6lVrrBQ3+qy75iMVJf476H5wYLiWFxPszncamU
	 hiQhenTm/Soqilk0ewdJaVQCI5SSyQYlRt6Ar7pmFr5IdXH2TFJytk+QVLcf3fwKDVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315926;
	bh=rUkZgoS7Gm1Oqh1GneK/SW4fpXRzF/61thJg9hPN2pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Y0H7gF7qZgVHAuYaHGlhexgTc7AJFCV8oyXchvpOVHq2pjvfqIXD02fbgNFvmoFEz
	 zXr6Fgp0rwBpC8axpuPKE7LFz0g8RaCgEw2W9ZcU/u1e8JCddCrISJaLN1JKZbWsjV
	 fZeFRSXJtcMba4U9JBi3bBANCc56wVgGBfMVMXhP/sjxrhT395QtYwjR/X/lPoZDRr
	 wTFpz3YjMpABLvrSCeTRcbN/7/+DNlpgXR1NrCiEsOSbBmt1LLLTVkQakag4Di5oFM
	 Eu/rzU2nDA0v3qbryvltSMPWXGVpWlCFFLThX7ZaeG71KIBL8Om74qR4jD1LQp6JIb
	 NV/ABREvxHgMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9E64812A0;
	Tue, 10 Nov 2026 13:05:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 188C2731
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A00F40358
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH-osPTpYFHS for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9912C4032F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=QFLhCgYM
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9912C4032F
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80E041516;
 Tue, 10 Nov 2026 01:58:13 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6398C3F632;
 Tue, 10 Nov 2026 01:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304696; bh=R6279pSaBim71deY8VBpz+Ey5OnitD4qM8RaDjqvruA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QFLhCgYMDwXvnUPCLQKRiC5qobEHKHYP01NJj6vaS8qtU6aw/Cg7cW93XrwhKWSeK
 ZM5pMKGsu90x4ow/RYAVbTNaLBFmRAdm7SMZxKkEYyC0vxh4GHN3iOSrH6rOVxgbGL
 ZZFKt2IBh1L85t2dQP5e/BZ5fnl0qHxHShL/Srmk=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 03/22] arm-ffa: add runtime-safe FF-A SMC wrapper
Date: Tue, 10 Nov 2026 09:57:44 +0000
Message-ID: <4a550940ee5f906c157aad09ba7400d23e1b85bd.1794221712.git.harsimransingh.tungal@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794221712.git.harsimransingh.tungal@arm.com>
References: <cover.1794221712.git.harsimransingh.tungal@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 13:05:18 +0000
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

Add FF-A runtime annotations and expose invoke_ffa_fn_runtime() for code
that must remain available after ExitBootServices().

Provide implementations for the Arm FF-A driver and sandbox emulator so
later runtime direct-message helpers can use the same SMC entry point in
both environments.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v2:

Simon:

- Fix style issues
---
 drivers/firmware/arm-ffa/arm-ffa.c         | 16 ++++++++-
 drivers/firmware/arm-ffa/ffa-emul-uclass.c | 12 +++++++
 include/arm_ffa_runtime.h                  | 41 ++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 include/arm_ffa_runtime.h

diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
index 9e6b5dcc542..241ef018817 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ * Copyright 2022-2023, 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
  *
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
@@ -8,6 +8,7 @@
 
 #include <arm_ffa.h>
 #include <arm_ffa_priv.h>
+#include <arm_ffa_runtime.h>
 #include <dm.h>
 #include <log.h>
 #include <dm/device-internal.h>
@@ -25,6 +26,19 @@ void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
 	arm_smccc_1_2_smc(&args, res);
 }
 
+/**
+ * invoke_ffa_fn_runtime() - Runtime-safe SMC wrapper
+ * @args: FF-A ABI arguments to be copied to Xn registers
+ * @res:  FF-A ABI return values copied from Xn registers
+ *
+ * Calls the SMCCC SMC 1.2 helper from EFI runtime context. This wrapper
+ * is marked __ffa_runtime so it remains available after ExitBootServices().
+ */
+void __ffa_runtime invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res)
+{
+	arm_smccc_1_2_smc(args, res);
+}
+
 /**
  * arm_ffa_discover() - perform FF-A discovery
  * @dev: The Arm FF-A bus device (arm_ffa)
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 6198d687354..d270f7b614e 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -671,6 +671,18 @@ void invoke_ffa_fn(ffa_value_t args, ffa_value_t *res)
 	sandbox_arm_ffa_smccc_smc(&args, res);
 }
 
+/**
+ * invoke_ffa_fn_runtime() - Runtime-safe SMC wrapper
+ * @args: FF-A ABI arguments to be copied to Xn registers
+ * @res: FF-A ABI return data to be copied from Xn registers
+ *
+ * Calls the emulated SMC call.
+ */
+void invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res)
+{
+	sandbox_arm_ffa_smccc_smc(args, res);
+}
+
 /**
  * ffa_emul_find() - Find the FF-A emulator
  * @dev:	the sandbox FF-A device (sandbox-arm-ffa)
diff --git a/include/arm_ffa_runtime.h b/include/arm_ffa_runtime.h
new file mode 100644
index 00000000000..66096db3d24
--- /dev/null
+++ b/include/arm_ffa_runtime.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Arm Limited and/or its affiliates <open-source-office@arm.com>
+ *
+ * Authors:
+ *   Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
+ *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
+ */
+
+#ifndef __ARM_FFA_RUNTIME_H
+#define __ARM_FFA_RUNTIME_H
+
+#include <linux/types.h>
+#include <arm_ffa.h>
+#include <efi_loader.h>
+
+/**
+ *  __ffa_runtime - controls whether functions are
+ * available after calling the EFI ExitBootServices service.
+ * Functions tagged with these keywords are resident (available at boot time and
+ * at runtime)
+ */
+#if IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)
+#define __ffa_runtime_data __efi_runtime_data
+#define __ffa_runtime __efi_runtime
+#else
+#define __ffa_runtime_data
+#define __ffa_runtime
+#endif
+
+/**
+ * invoke_ffa_fn_runtime() - Runtime-safe SMC wrapper
+ * @args: FF-A ABI arguments to be copied to Xn registers
+ * @res:  FF-A ABI return values copied from Xn registers
+ *
+ * Calls low level SMC implementation. This wrapper
+ * is marked __ffa_runtime so it remains available after ExitBootServices().
+ */
+void __ffa_runtime invoke_ffa_fn_runtime(ffa_value_t *args, ffa_value_t *res);
+
+#endif
-- 
2.43.0

