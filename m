Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B23BCC6B30
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD3998105C;
	Wed, 14 Oct 2026 20:03:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lUZ8MwyCsxFg; Wed, 14 Oct 2026 20:03:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BC26981022
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008202;
	b=L4iDikosg67bEJeshxYZ0CCzgv1LNNIdJMT33e12E+m3raDC8bcoWMp94OUZFXiK1Vxf
	 y1wk5hZdGzMoz0wFnTjOeHypqNAcOEnPv5u9esQCrMEUNEG5TEPO+5oDcs2PsnRhLYHZf
	 0ky58KSNl7Z+Dsd1DUNpQPznbt70FWvhEoinjT/V4gQCdwClcTeN8TEzU2eLHeKMaLcxS
	 pf0XdMHAO/Pm9m1AMztQVhXdfgLQPyrh9+DedeGAl3oqMyn/6x59FOSQiy6jUz4wdCBQ9
	 HKqHUxlXe+Do5zAYT5b8bRGWVGCwVyWjhA+ReD2iSYmosAj1YGOo5EymZavoVH3fAKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008202;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=rUkZgoS7Gm1Oqh1GneK/SW4fpXRzF/61thJg9hPN2pw=;
	b=Wb95dyfQJBcPSC8fJD7Rydk8JvgWHDrEhyN2GJHZ5SJsqM8VAEeFMgJklpcPmGlJpHzl
	 TuVbReR3gYMLXkXWW3Ds4Mo4lkUzKXsP8/Bf/w0BZwu6JIGPTb/1/OW2Jt747tiuPphSF
	 mktEEDILrd49unTWvHPqr/fasRWM5hRK0FGaz9Iv/NXd875CZamE2VBqRPkeSBjOzKmhg
	 AkAHISoQYDjQ+PrR6oheMAtlwoSZud+6Uq3nXR6DpsBH/8KnoTkHz13wO4vNJZgTu7FCf
	 GbaxuXh1hFZhfjCAf6rYPTGYG//A8Tkf/ancQEEdUKanN/7NbbE7isTax4aLxV+yuYA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008202;
	bh=rUkZgoS7Gm1Oqh1GneK/SW4fpXRzF/61thJg9hPN2pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=K/5B2MunlXbqnuz+H8xUOUkDKGUqwvtMkRhouasM46eOykjDkQltqODFD1pciyz0s
	 0MKdlkMoBWc0htzFMLhhUUgIZEI7YxIbnolzCbUTBrODxwmXGIKwOqGESYAVubDfw8
	 oSexNiXnKq/rUo8RLY+V9im9x3yEZqexXphApzpSKLWVjzAPT1Md08tDSEazU3mD+L
	 eknxOKTiL1cVe/cja7lsKZ3Lwe8zhc93KlujjoIsl4VVWYck+5aAsq0szWbZZVJkLV
	 kq1NwG8ZJoOnD8SGVOUlY/vIe5vhPVG9EeSoAANZo9Ryg9HxZh3PXgCMAi8s0UXTLJ
	 SwaPxtHBsczfg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC26981022;
	Wed, 14 Oct 2026 20:03:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8449DA58
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7631D607CF
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I65iNOsr7uiI for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 64EF7607DE
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002198;
 b=pLw5ghkzGYEwZxl/OEV4X9GEL0Fe6zZq6yVFDY+whUMh0SwLInBY0uJw8UOCSMO3wmgj
 29fRZH60cMq1s7hMhyH/+NHlX9NgBGLc1kkxoYcQQ9R4xPKaUN9Rydow9bMwcmHc/VvE8
 FlD/H2GOlUeaaAr5tUk0Zmw6UnnvfHk2RXCgSVzqnMogEx01XLj2t9EIfPts/4oRRuzsW
 4yoVlE13IloL19CyJWqVEiEPNGPRZZHxHXT8js7sOy0amL+U9J/n+cBrGuHMeD7eES+cc
 qBIM2tgbEp8cwINz02sei1Smijvuk+8Qle4erunpN47elN10sS6Hz1baMdXsY1p0/fg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002198;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=rUkZgoS7Gm1Oqh1GneK/SW4fpXRzF/61thJg9hPN2pw=;
 b=AsohHztLgsWvJjr3MqAcY8z74qIRCDwzjCa/4EkDdQxnS2Vz2eawaH1C57u/Nd1+beCj
 XTy9JHVYNf457034phM0AkLR1RUgQ4eW3aDXXKHZWVbCGLfKSItpsOzuuI6iBMoGgSuyi
 Z0GjN+DexAVUBJ/M+7Hu2HYBOJXI8crIxhfZni039Zhn126VzcGWdqaeoHPPGqojsVA9Z
 aD3or+TArlbVbAuCCI5M4e5cjE8Vk/EoGgorl+zl/xc0ttyO17L9E3/UsXIBSDutadGYs
 xQQtdAjRKWBmbEHiMOIwMb+wTaJm/qhb9QuNgEdwvfvlMnPGrSBXuChNTu4W0u1sL9A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="q69qKm9/"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=q69qKm9/
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64EF7607DE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A316E153B;
 Wed, 14 Oct 2026 11:23:12 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4943F871;
 Wed, 14 Oct 2026 11:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002195; bh=R6279pSaBim71deY8VBpz+Ey5OnitD4qM8RaDjqvruA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=q69qKm9/s+bVz82wgSR+54XACtW1QoKhWNB+GZQwndHHbz7LiOlg0v5Qrm8sogoFl
 Ty2K7BykJj0egmeja+6kH+eXRMrMx12siARus/wTGXfi1wbPJiDhCCw0rXf07H44/H
 pEjSUauQxzdDNH/pkeKxO6yZsJ9qigqb6uR9x8AU=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 03/22] arm-ffa: add runtime-safe FF-A SMC wrapper
Date: Wed, 14 Oct 2026 19:22:43 +0100
Message-ID: <bc9406e6c1193421dbabf253282b12410b1e11d6.1792001844.git.harsimransingh.tungal@arm.com>
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

