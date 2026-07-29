Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF432C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052A160B1B;
	Wed, 29 Jul 2026 12:28:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Gpl86bH1uKCs; Wed, 29 Jul 2026 12:28:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CAAF760AC8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328099;
	bh=cHK20AIDt4bYb1CG3vqX1oBGVv5eqm//yL1wPpvVNb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ngo81gSXlqm2AHBtYvxynNiZhv64pOgBXNVbIFxLU2U01oDlFtKhaheFdk3ibadjv
	 YIlo3EHGonCTO0ae8QqJRQPTDrj/Axp01UUQMwr26WuEmNWsBy6ucBlwH2i40SnbBV
	 tACHU9PpTsudy4empLI/CHmpJd/9IZ/00CqdBfK0fANXehmL/qoNPwjZ97Efzqg1l7
	 8zJIdszQviI+XSPyxYfD4kbZjNOW+tL0IMrMqt4hdonyJJhMB05l9bvEPXbNRbhgS1
	 FsrYor4EED1+BVYiz0CoVrfRicuvN7lj9TbPA4HpZfYFLAwQITczaAM5EdzG3T80fo
	 ltzHx1adepGSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAAF760AC8;
	Wed, 29 Jul 2026 12:28:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C8BC726C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AE9AD6080F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZqUxyiiQ2gPd for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:51:53 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C3E15607E5
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3E15607E5
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C3E15607E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:51:52 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 099BD8494B; Wed, 29 Jul 2026 10:51:51 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id BF2F98498B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:51:48 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F166E169E;
 Wed, 29 Jul 2026 01:51:43 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80DC23F66F;
 Wed, 29 Jul 2026 01:51:46 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 03/22] arm-ffa: add runtime-safe FF-A SMC wrapper
Date: Wed, 29 Jul 2026 09:51:05 +0100
Message-Id: <20260729085124.2618817-4-harsimransingh.tungal@arm.com>
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
 t=1785315108; bh=Z/4VMErAA6s3YverXZb/7rfZ4cyxefJVh+vpeFOMzEM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d3R0m5S/ostAugo9890gUarPyfJ8RBt+oMG8MBjowG73wAZC3mlVkBClj7cse1OzB
 Q2ZTUuedC7UWwWok6Rt00jm9O+njeSw/LLUZWyHqRXI3n1xNk43tYMpTx8JLoCTfHd
 LBPCXk59tTrIXwWT7E1ADHKFQFpjKD5a2h2SCrZw=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=d3R0m5S/
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="d3R0m5S/"; 
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

Add FF-A runtime annotations and expose invoke_ffa_fn_runtime() for code
that must remain available after ExitBootServices().

Provide implementations for the Arm FF-A driver and sandbox emulator so
later runtime direct-message helpers can use the same SMC entry point in
both environments.

Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
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
2.34.1

