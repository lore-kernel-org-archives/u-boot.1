Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D29FCC6B2E
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 20:03:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 325A68109A;
	Wed, 14 Oct 2026 20:03:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JkunieJk2r2u; Wed, 14 Oct 2026 20:03:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E715081099
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792008219;
	b=IdaoWsWi/11lcEJlg+AQx38JWh/c1sxhQ3Z2lSm6uSOVxWCuIAcLmex10yHx/elMkkXL
	 qUmXO8xOK5qhbmZ2VbxnubAaIY9snZRzp/EE1bUiUDaMAdiXuNSYOfghpJvW/ImadC6q3
	 ZcPmUq58s3U6HCO2eHbEChYd7TlYRfDxL+0551I5phRGfkOuXqXrAnIXG6cRUnzDXtalN
	 XpDC3v/ovO1hcCQ0zSimJjpgZzqx3CAqSuyuMafpxQ3xIeOK/a18ueBUnpoXTNbea22ug
	 KaFOK2UTZYqjIsh44V4+uzyGdHDf7WUWubL/51UoRrkPFCZ4Gor87tkJHs4ltdnFunQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792008219;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=WSXo+hGuLpUcZepk+W1lY+zbAx7boxSs4Tlg5YOJxsM=;
	b=nINHu1K4ItEHFaommns3RDQtOUv7Ya91bu0mLxH2PGIR5Yfk05iG0xFZx57fnoVeOKxR
	 7PRWHAaKTK5KCOxKyiyV79zGlQn8onxcYR7/Mk8+IPz2MlDw/CqNdde9GYSvqpXEQTD9e
	 aNqW38/xi1nDNcl+BTidOyhp16vNM7ye47my/ypR7e9i3uB/DxxOw/oTypZRYlsk46dY6
	 J8fpkXq5BFYTvnZa6jYl6My5zvetTeSXHhWQQoa/J0WRJMoROu1P/U0IQdh22lmdoWICY
	 QCi6zm+nAvwBOLOawSZlt0cfKvGlAgOtSqMlX/r8Sv5xyAG2EbSJeFlcNG05YaNFBDA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WbfZ6JBT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792008219;
	bh=WSXo+hGuLpUcZepk+W1lY+zbAx7boxSs4Tlg5YOJxsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CF5UO2GcSXTsRkb6ssZ4a2BsZuLBlNCZevXTpNk2dpLHAbQCTqBTP4O2TN0kHiWYr
	 7yjDtQm5Jf1xW3AJZA7IfUOXAYbW3cL+tR2VJ8E9CMvgkAimkbTUzm7PUEzc6Da8yU
	 c8AeqgJ4+CI9LO4/EA5tDN6VK5iHghH/ycbfIJYEus6P30YFiSa0/H9yhEIwMZFfuK
	 8gldqcDtywbdqydVeJjce21clPWMXNrtRnEPcuIYTND5Goldegty/1zjHFf+MipkVG
	 hc466G5MeA5/7lSZQafU78MYqjtknG2AGBEIZ2jRGgSHe/MceUOghHSiYzXZyik0+J
	 htpGgtnNsUKHA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E715081099;
	Wed, 14 Oct 2026 20:03:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C8D611518
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA9F180FB7
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tdjs1HTVTNpz for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 18:23:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 188F780FA9
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792002208;
 b=mRxgM7cyi4bN1t9L9sNIFtzRulRrL93R/MHxjzgbwk8TXlmtb/IgQ4ubSubT8FHnzgvA
 BV+WgZOY30C5yrjeKhcG8iSowLxfbhbupjfg5aJWC+wcBORw9H+XZsCL9ufJFvHhVdb07
 Tim9YOaUsYJ1tuxCT1W30aoX+Ptsc9Tu/U5aHqlmy2DvfMCNFEgGTYaPbz3img+f9pIqr
 UGQ5zP2aVXL3Gj1fvrLYknBdzIwY+HnToAKBbZxmK0tldLGbsMQDTQUtlyyzk3KlHcB9u
 V6GivBgGb4Lk187MEATML4T8QsBlIuLNLBQGJLvyWR4pI8ZjbCtO8HVd/3YyIhnSXgQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792002208;
 h=Received-SPF:Received:Received:DKIM-Signature:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=WSXo+hGuLpUcZepk+W1lY+zbAx7boxSs4Tlg5YOJxsM=;
 b=IrbKjn2t9/UcjWPQK1DumFBocTO35IJ2e0SuAniQPDDOQra2tuju4sgaj+sEtjSNNE9U
 r3LzDuL30zCcyYrjweMBFJSA9f5mBj38lHDHCR2Ig1Tev7TIQSCHi/ZjqibPVtd+QrVsD
 B/5ZzX7ektsIOGEbEVLbgr6+M1buhEijkyNkmjqvGduqeI3B3hQr2syMwyuIdkZl8C6Lq
 G+AWrzORlsUPJUfmkdkQ81NkENJRlhrHkK4ytPWtU/EU8Gts4/LeUZ3mlhHYTEiObwZs8
 ariZRkjPcbt5M25HsycuXtHY6j9xDnCFXzYZllCQOtP+1Jehz4Mxd0onDLDdfbzWG8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=WbfZ6JBT; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=harsimransingh.tungal@arm.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=foss header.b=WbfZ6JBT
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 188F780FA9
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 18:23:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EEDE152B;
 Wed, 14 Oct 2026 11:23:24 -0700 (PDT)
Received: from e142474.cambridge.arm.com (e142474.arm.com [10.2.203.50])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A66A3F871;
 Wed, 14 Oct 2026 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792002207; bh=NjrfNux5itizJqGJFfftExRBurq1lx/mT7UlhFWoJMc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WbfZ6JBTafDNldNb2TOaxseLEnC660QeMcbHwzd/0uc/qBr4mNv/evRnjl6DgOGu2
 b2gulzw8T8dQd24OCd831e/g4SCHFCbJQ4k/7s097f+jBh6zMw3bvmovX8pTXUP0F4
 TNqAWeZ01u1FdBaE427nf5UDWWtTgIby+s0b6WYc=
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Devaraj Ranganna <Devaraj.Ranganna@arm.com>,
 Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
Subject: [PATCH v6 10/22] efi_loader: make FF-A MM SP notification runtime-safe
Date: Wed, 14 Oct 2026 19:22:50 +0100
Message-ID: <d7bea00f0b6122f34fa94b528c6c82778db39c2a.1792001844.git.harsimransingh.tungal@arm.com>
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

