Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2479606B2D2
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=wE8FhNLW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=krgYSZZ2
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9E22815FF;
	Tue, 10 Nov 2026 13:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UwPJ1icnLkQ; Tue, 10 Nov 2026 13:06:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 72D6781446
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794315993;
	b=d8fovaKS+KENXyJrR5dDJsOrYZouxpfVIqaIpZI0QqfO8oZn/yXKi8bMmfC31LFQI7EI
	 8gvnIlrIKISr3pSsMhFaWgptTbfu9UORKrC2PC1nqSU5SExAb/UVTFrxoBKvD9ypEFABC
	 KEtTDCV/e247GCtsLvBKrq6jDZzaa0Hf+fE38Ugr5rxQxYYDa9kwx/RLIlSHc7iHKm5MH
	 JLIpdSUXPtfXx5/aMoz2HnIBIIZnY+OfthY1MEFlIdiulS8W1Gy9vVQG7xN4hJ8O+0E+A
	 ovEWN72S+q3YJqtYo4LdlObKHROk8PcvVby7QbGA0Hd8U+GPoFSzZQelPIbVe/qag5w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794315993;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WSXo+hGuLpUcZepk+W1lY+zbAx7boxSs4Tlg5YOJxsM=;
	b=PV0NK6P1CbVaEYqnuRfIY8TkNMe5DV82WnIjzBMcvxhBJWlBinoCIJ3Mn2IKsyeItyqc
	 iQufMEi+D0Hug+bFRlqlHXhYsD8JtthvoDyFkRQFoN/Dh1ALRCb88UyFjqHPvcJWhu42f
	 nR4xQ1u5YHBvSO/h9uJ/i6AFDuaSxK6lP23EsGVtfvjyEwx5dIgl7lQ7HAptLstqX+6jU
	 lbyk6RkkBIDYt5XKxDIqyvV2IOFtlwDsdHWIdLFUPEFFfH24PjOpqWv29+WvC16kBGrRz
	 fmLCpz8uNXmh/Hh/wXoeq/x6jvfk+mGQ2LXcYNAoOIo6rRfBPjO7NrbWCdFgrq9EWEg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=krgYSZZ2;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794315993;
	bh=WSXo+hGuLpUcZepk+W1lY+zbAx7boxSs4Tlg5YOJxsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wE8FhNLWq7nTyVqOwgS36UXeLOEQHjz3SnAM9Zw8jk7HIJqtmrDuFP06yp7XEBQbs
	 9pKIMMZwCjoYs5NZFfD9yyVxCSAMLVlRdP5XpXD+D4+DeRbLmLxqsWWg/kKlVMkezp
	 UWIuQQHOYfzpiAMVT9B5NBdgShYMZKmeV3OiXd3ksy8bnLtEuXP7FFaTXhFhjh5hjD
	 qvyXukJ6gRibGYpp8vXUxJUy9HZjiep1IvObn2f8hFP/KmNPlr/o0sbR3TdwcYogcd
	 1HOaljkFpM+/lEH6CAuOd4b7+MW67s0+4cGXdT0JwBmounf3LDHqgH0FPrF0mXovuw
	 /+/hRZe6Yq+Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72D6781446;
	Tue, 10 Nov 2026 13:06:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C9D41F15
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A45C98112C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Esrou_Pqx-3g for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 09:58:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F26B981108
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=krgYSZZ2
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id F26B981108
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 09:58:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3FCC1E7D;
 Tue, 10 Nov 2026 01:58:23 -0800 (PST)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C83EC3F882;
 Tue, 10 Nov 2026 01:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1794304706; bh=NjrfNux5itizJqGJFfftExRBurq1lx/mT7UlhFWoJMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=krgYSZZ2kIxnlvoqq4c4L4GP02TB1Dg91wsp0I4yKtoBtWfY/ecq8r8SGQuF87oAc
 1M0FnIDC4c6nT8s7myXis9pgZB3k4TuF7Nr4+m8J2W7l3CkXwAZakGOpvWVjPE+q2D
 TF/JeKnwTuFJj8u8nePSGSv+K/lLF0Wy6nebWETs=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v7 10/22] efi_loader: make FF-A MM SP notification runtime-safe
Date: Tue, 10 Nov 2026 09:57:51 +0000
Message-ID: <918000500d46a1139e2e29029cc423cf66721934.1794221712.git.harsimransingh.tungal@arm.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.43.0

