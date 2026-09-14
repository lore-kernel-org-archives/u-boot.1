Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6485CC88E75
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 14:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2893280E3B;
	Mon, 14 Sep 2026 14:17:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JN930dfCpfAg; Mon, 14 Sep 2026 14:17:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EFE6180EA8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789395459;
	b=GnDX9TTWb41F3OQglr+kpkgeiGI7jijCCQEzMxq4eqe0ckCSoPx40Iml1eu5tTEtnXLQ
	 cbjxz69z6m+ftC6y8TfUH5++Vhi13znfCstN1b9lI8B/ZRukLjwAkI3eDjPE5CvshoIvS
	 wmQt2JiAv64JAX9/cM98FRpg9AUJp72ro7GAvwDpTs7Gd84vahd7N/vsO/l/HX0Tl4rHh
	 yolYLvi7m0a8pGt5l0XwhbQxbDwvbfh+PQHq5urOCVXx9q7GV1cWgXSKji3D9E9Wxe2C4
	 qqqIMOXJ3mKf3IaEBeeswUcpuDmlNT1Etq+108wHRGHty9vIpArYnstTUEdy4SyYk6w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789395459;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ms8s8UWkuaeiQ/ay7DrSIL7/tSr6gRLVXKoqmWCXS8M=;
	b=bDQu17wdDmonQrn353mL0aT7r+imYM47llmkQLL55v7utQqL0r8WD/sn0r7WHnScMg+z
	 1njnz5ZeyLeDFr7Xej+NXVNJj5SPdorocRK2nfmoTsHk8LW/lgYkCKbRlbNgSAKGcvreo
	 qmbURynufeSn4qqUm9r/Z7JjP2VZMeQyvgn3j2sBMu8XxyrohLnRjyxKGkcSRLM4VdMoC
	 O4rJxsW80ajA4Vb0SFxxPdTrmZytoZONtLfKEX3KeYhHNamGcONefIB837yoZChaghp5H
	 4Yu+nNb+GHOYaCGSYEq5r3VTTjuyYBIC+oa4NfU4WT44fRmbNVlaamR1TnKB4nMt0Lw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b="m/GHbFnw";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789395459;
	bh=ms8s8UWkuaeiQ/ay7DrSIL7/tSr6gRLVXKoqmWCXS8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JnG+87qrqXZKtQqLuhUeavU7NDdk3BhG/ma3DLPdCuyTaWx2jHHULBB99/oqUH5JT
	 lt1NH8pd5VdWkFNeh+Dov/Cku2I1RlQdF9mS8wqxCk7Jk8d81yiD5EjJOZygomaIlG
	 wZ46MjZCi16AHvunw0hBy568CB50/vESW4vnG3LY3X/EDlTFsL8X9zVHn9HRpeZBaX
	 ocImHj4n6PCvrqzqvnoX/uKKEGEQzkBZhPMSBYthl54GtxwubvrddZEA8b/unjplSV
	 7I4Ruvzn9AIpiAYBZUUFDBHaplsu7kB1cRXmrjtqlag6GfkumshsmsvPlaj9ogIl50
	 hKhZu6RZnQfvw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFE6180EA8;
	Mon, 14 Sep 2026 14:17:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DD4862D0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CE95380D8C
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qj9qPq1cFOAe for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 11:10:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org F313D80D93
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789384217;
 b=kkziyBPFJjo8dwHeUvd3hhjGI37eLX6mOjPV9IzxbqIn+IPzxJl9iIgGEixIqpk+U4KP
 o6G8yic7afzx/htEn3B883j8CEVxvb+WnIhMzXS5AaNohXe5xmFCd2idTDO6cSz2N8fGc
 sYEgJIILGaOmmdhVSXz7eDeid6YBd35Y5LlBeGuMH6BUo6kG1wfGWSRqUQbiN4cb/LZXv
 tFUdIHHMX2g2UCMgey3e46ftbvJCU8tkZtXZmxbIaV0j/gJm8MKhRBsbaCRXLiLXD1SXh
 ZYDL2AxTpOjg8Lxzl9/WiqjJxc8sm9vbJSIQIo+bCPKVHR0gKgwgOByXOoXtuZLNzOw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789384217;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ms8s8UWkuaeiQ/ay7DrSIL7/tSr6gRLVXKoqmWCXS8M=;
 b=ARAAZRmvpTHLDusolRUvWa9pmzL6qZz/QQHV4iInoU0V9vJiMGJevPn4eA1qrTM4QFGf
 EMtPE8tsjOesxFHFXNfwBOSHliYiflQQn52N/VZPsvV8YCR3LvmZGv7wCGWhWBQT/QidE
 BWvbIJrKvHUQr9qv9fbfpfzjO2TtEwgDia8Huotr6Aa3wmhh9AVEgUTEMsUNnifYpmiMD
 lbwRp/OKmboAUntHZ8IFirIpqmxPHRJ4yUmUKPd9RTqbpsibrSqm1whYWc2txJlL1jW6H
 QUPrHGqvwLewemEg7+9KSRGoS/dRqUqMrcrXQ3YlnhoP6qV7xnQzTXmzWXXGN7tiTXA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b="m/GHbFnw"; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=m/GHbFnw
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id F313D80D93
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 11:10:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 237C31DB5;
 Mon, 14 Sep 2026 04:01:41 -0700 (PDT)
Received: from e132995.arm.com (unknown [10.57.49.141])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293963F86F;
 Mon, 14 Sep 2026 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1789383704; bh=2irKMRt5yMclFdkzidotQE9AfQwlHVoTmmfVdKjlAZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=m/GHbFnwx3fmUUov8/FIugwImuFFiZkUmez6JI40bc6chJbWO7JXD9VJg8If4iGIh
 oO4exjmR9Y1ssN6ygyN3TusOIrdPQOjwZKiBW2VNJ8NbFJrjhcxSnSNyJ7hw0Zqrrh
 cH4DC13UpwEavoNFZarVNNQt37bYqJf2yfT7D7Ho=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v5 10/22] efi_loader: make FF-A MM SP notification runtime-safe
Date: Mon, 14 Sep 2026 12:00:54 +0100
Message-Id: <20260914110106.1974894-11-harsimransingh.tungal@arm.com>
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

Make the FF-A MM SP notification helper usable after ExitBootServices().
The boot path continues to use the FF-A driver-model operation, while
the runtime path uses the resident FF-A runtime transport.

This keeps the notification path shared while avoiding driver-model
access from EFI runtime code.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Signed-off-by: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>

---
Changelog:
===============

v3:

Ilias:

- Remove log calls from the runtime MM SP notification path

v2:

Ilias, Simon:

- Fold runtime MM SP notification into the common path
---
 lib/efi_loader/efi_variable_tee.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/lib/efi_loader/efi_variable_tee.c b/lib/efi_loader/efi_variable_tee.c
index 50a98a1dd0a..9cae7b7e5ac 100644
--- a/lib/efi_loader/efi_variable_tee.c
+++ b/lib/efi_loader/efi_variable_tee.c
@@ -14,6 +14,7 @@
 
 #if CONFIG_IS_ENABLED(ARM_FFA_TRANSPORT)
 #include <arm_ffa.h>
+#include <arm_ffa_runtime.h>
 #endif
 #include <cpu_func.h>
 #include <dm.h>
@@ -51,7 +52,7 @@ static const int __efi_runtime_rodata mm_sp_resp_map[] = {
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

