Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B252C88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1B1C6072B;
	Mon, 14 Sep 2026 14:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kqqhc8WEqrDl; Mon, 14 Sep 2026 14:18:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A25F1606ED
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395484;
	b=esITn6IlZ8OfyQZc07wsypxcdJDX5N09fCv2Q2Vk98jrIcwWc5dqV17OaXifmogfz6iS
	 AAyS6RHCz6LxMuwpEMTqO0lYLTXpULNQzQ4U4WYVwxjQyt+K9bOGnnvuKBw/hDWLoi6ue
	 Ak3Ysd4AvWAvs6/IIEyu/pRdJK/hwuOyjZxrtcpIkqM6VCyygkl/vN+8CI5+ZvEvjZK1e
	 VxyaNucqiCSC6qn6rNSzyTso9ABIfeqytxZiVvDL9HNPNRxWJ+uPkUCP0U4v3PZ/hSkqt
	 rEvVafDH2s7NL2IoWCS5NYQbHxLCHp2N1RJVn0SsMSW/mJ+929oVB+5sNpNPUdRhG4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395484;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=VW31+r9y/p/m+atpkMv1VzgXBJwAjhTTH+h3CSk6EfQ=;
	b=l315XVRpzy4ZhcWTKvYv9ODZT03sEv+EzlDy/KaBq9Q6DGgD9ghBkYuZ65nj59mFuyGe
	 6WzVVHSr7Rloi7xrMuzHCgM2UDXET/aRc9uZ896pHAbg6YXHY2UuAd74P0rhFD7DBFWQN
	 MaDa1K2YV6zQpcxuJLYMlnsBAyKJdGDZxW2gLfFVRWRA5/vPmuTcSNcB3LjgrCNsZG5hb
	 9wga1NB9++n+fCUifj5JFHP8bsDiBrLWXuzyycgfOQQjuTS21KreCeOMACJhZweaVbK2K
	 5YUjzjW7g7mb1NSsWkVErkYCxll5QsvUPGijI3/elda4eD+X4iPZ8XiQKRr6ugnBoiw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=BfZi3sWV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395484;
	bh=VW31+r9y/p/m+atpkMv1VzgXBJwAjhTTH+h3CSk6EfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ze5ol//E9EzAwHeRXD1d9dbAPIfiRSD86I0q+mE4O3EKB7osq5JCI+TbyD8ss8AM2
	 IBmLlIBX7M8jmwNRrArIxpoe3LkQdbSP6PS9hALp9fHYW3JyfJvAkK39x4hgJ0kgal
	 2brReZwMwY1Pk1C3IGLs9F9zTDbctYqm2ixDI5TVSnhoaoZnsTZvTbESb6vH1PHrZB
	 0g2o0Kn7kjHHOxjUspuq3JFTJyCVCf6UCBaNb6FkzUFSVSdkIwFeO52TPLOOMrmK9F
	 lH5GU1K0dU0idpphOp8+J5uXI4e1ilBJTItmBHeBTxu6WdsqnC34ntqSroWTAkLgGt
	 fmWadAPvICHvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A25F1606ED;
	Mon, 14 Sep 2026 14:18:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3584A493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B2E9605EF
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_du8lfeBqx3 for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 8D9AA60693
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=NuQBMheOZFvQfIwSfvW97YRZthG21SXhBzFpO68fF150jA5Z4kFxZnu2kHljwLpPx5L7
 1tmIsE0/p399nZu5tl+dOEqsxwMTNPhlN4jmlw6cq1sD9fFb4V7zJli4uKMgMjxjf7h3i
 s/wIFakhtsr7cbQHBR9KCDnWduK+/KFAd0rphccD5nLTE/CDXfL5Z0695og9T22+XtOFK
 I5Vecq+KpOjf1GcSqMhrhcbU6837rR0l5IzqWwCQtJcYCOc30FQ+9g863D7TYMtKHWbsg
 a/nw88SIqDPaTnV6/ry614VnLD46DR+xFKSxZuIXPGyEWeIhZYmJcNdLKG73n+KEKbQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=VW31+r9y/p/m+atpkMv1VzgXBJwAjhTTH+h3CSk6EfQ=;
 b=EGHPioHbm7Qh/dS025OBn1T9gD5uZxr38hNGsNlxfR3H7t2voUTuplOajC+qL6jwIZAL
 BsR99jDivUqojLh4F2BO4GKUglopoLDvVqTfAKoecfA9SKmvU1D6kUPOfL3kN7tF7kyQu
 +tjra3iUbQ9TJ/gsyjnUV160ZGgRDNCBUHHZ4M0q19TtGLW4g374RP+5DyCaKcQIdceWz
 UuA2KhGU3ub2bJZ4DKgUCcVECGc72LInNFQZjwMI9SUMuoRQp0Nhg78hKkazPK2Zhy2H6
 pvl7Gcwv0AntuPbN+RfYHmwbzrPXg8KKYdbn0BTrmahbaUIsZ9iqdyDyBJPmrYHHyGA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=BfZi3sWV; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=BfZi3sWV
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8D9AA60693
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA7AE1CC4;
 Mon, 14 Sep 2026 04:01:28 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF0063F86F;
 Mon, 14 Sep 2026 04:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383692; bh=+2VVtfzCTrXYZ4jHmFds3eygNcjQhr4zzpzdXlq5AvQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BfZi3sWVeS7EFJgc7f0EZprxxA5OhATlf40Lx4l5L2fQoQnBdnxi4Ubl7+3Bi4YVF
 4gjD2DnENQ5GfA7X0FpApdhApmscSmjwGJ9/vUBV2NOtqU3uYtXZY45omqQLUfSKu5
 X+P42NzfAiQE4+tLZJPJ/5NwuRuT0ELr+RJdJG8E=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 03/22] arm-ffa: add runtime-safe FF-A SMC wrapper
Date: Mon, 14 Sep 2026 12:00:47 +0100
Message-Id: <20260914110106.1974894-4-harsimransingh.tungal@arm.com>
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
2.34.1

