Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F30C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 12:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A136760B2C;
	Wed, 29 Jul 2026 12:28:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z5VLfXO2En2T; Wed, 29 Jul 2026 12:28:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3214460AFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785328111;
	bh=4rQDqwRg7wgVLgnbZ3DSq+BzfCFMNnLsqdCMK0GhPIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=acQyK8jaNqCDSMMogEth80RL70hsPHKva56EA+c0AXwRwnKb9//LU9/aF0iQ8UkPZ
	 Ise5avlvw9TbQniUQn5L9mlj4+IjnM9lcUBvzyFtobbynX9UXBTbNfLb30cEzd8CbG
	 6c05MI3nUNpgdfAeUo5JPlQ1Whb/f7K3u3nfIhu2qF0g5uQNaNj8bSLfwqjsrMrTFp
	 sUkN7Dn/4edc4R/jq0ZVBj4aYNDG1FxH52DXbAs5RL6wOj2VWSseEMf7DY5sF5Hru3
	 AogMGigL2jDYZXKZyL6MtNAg/53hsAbUhOn0HacxKsNNpsU+S1FOXTsyN6Nc6wKP/O
	 DI3qn340DSOWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3214460AFD;
	Wed, 29 Jul 2026 12:28:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BDE93B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A2EA607E5
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DU7S06qFUZgD for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5551B60AC0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5551B60AC0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5551B60AC0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:52:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5FA3849AA; Wed, 29 Jul 2026 10:52:04 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7EE278494B
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 10:52:02 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C5B9169C;
 Wed, 29 Jul 2026 01:51:57 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.65.220])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 384413F66F;
 Wed, 29 Jul 2026 01:52:00 -0700 (PDT)
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v4 10/22] efi_loader: make FF-A MM SP notification runtime-safe
Date: Wed, 29 Jul 2026 09:51:12 +0100
Message-Id: <20260729085124.2618817-11-harsimransingh.tungal@arm.com>
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
 t=1785315121; bh=uxM0fgwEhwX1RdZXHSKwMhOPsjp8aaf/1jDZajAj+Yc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cjCfy9Sy5hVv5dVQPvC9GLuKSidYGvHRzcG3+urQiXzjbJE+TKHut/LWIZlOx594J
 Be9vZaH2jokzC7GrRZ/H6gkjuPkltOW38Suqyjm44SqcabSnKeqwq6BDVw6ehHn9KI
 9O/Js0jTewC5knyqaCAGUMfGpo7AfmHNHaHdlYKQ=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=arm.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=cjCfy9Sy
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=harsimransingh.tungal@arm.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=arm.com header.i=@arm.com header.b="cjCfy9Sy"; 
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

Make the FF-A MM SP notification helper usable after ExitBootServices().
The boot path continues to use the FF-A driver-model operation, while
the runtime path uses the resident FF-A runtime transport.

This keeps the notification path shared while avoiding driver-model
access from EFI runtime code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
---
 lib/efi_loader/efi_variable_tee.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 72055b36bba..4ebba83036c 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -14,6 +14,7 @@
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
 #include <arm_ffa.h>
+#include <arm_ffa_runtime.h>
 #endif
 #include <cpu_func.h>
 #include <dm.h>
@@ -49,7 +50,7 @@ static const int __efi_runtime_rodata mm_sp_errmap[] = {
 };
 
 static const char *mm_sp_svc_uuid = MM_SP_UUID;
-static u16 mm_sp_id;
+static u16 __efi_runtime_data mm_sp_id;
 #endif
 
 extern struct efi_var_file __efi_runtime_data *efi_var_buf;
@@ -229,52 +230,34 @@ static int __efi_runtime ffa_map_sp_event(int sp_event_ret)
  * This is a blocking call during which trusted world has exclusive access
  * to the MM shared buffer.
  *
- * Return:
- *
- * 0 on success
+ * Return: 0 on success
  */
-static int ffa_notify_mm_sp(void)
+static int __efi_runtime ffa_notify_mm_sp(void)
 {
 	struct ffa_send_direct_data msg = {0};
 	int ret;
 	int sp_event_ret;
-	struct udevice *dev;
+	bool at_runtime = efi_at_runtime();
 
-	ret = uclass_first_device_err(UCLASS_FFA, &dev);
-	if (ret) {
-		log_err("EFI: Cannot find FF-A bus device, notify MM SP failure\n");
-		return ret;
-	}
+	msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET;
 
-	msg.data0 = CONFIG_FFA_SHARED_MM_BUF_OFFSET; /* x3 */
+	if (at_runtime) {
+		ret = ffa_sync_send_receive_runtime(mm_sp_id, &msg, 1);
+	} else {
+		struct udevice *dev;
 
-	ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
+		ret = uclass_first_device_err(UCLASS_FFA, &dev);
+		if (ret)
+			return ret;
+
+		ret = ffa_sync_send_receive(dev, mm_sp_id, &msg, 1);
+	}
 	if (ret)
 		return ret;
 
-	sp_event_ret = msg.data0; /* x3 */
+	sp_event_ret = msg.data0;
 
-	switch (sp_event_ret) {
-	case MM_SUCCESS:
-		ret = 0;
-		break;
-	case MM_NOT_SUPPORTED:
-		ret = -EINVAL;
-		break;
-	case MM_INVALID_PARAMETER:
-		ret = -EPERM;
-		break;
-	case MM_DENIED:
-		ret = -EACCES;
-		break;
-	case MM_NO_MEMORY:
-		ret = -EBUSY;
-		break;
-	default:
-		ret = -EACCES;
-	}
-
-	return ret;
+	return ffa_map_sp_event(sp_event_ret);
 }
 
 /**
-- 
2.34.1

