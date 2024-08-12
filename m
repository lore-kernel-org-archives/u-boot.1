Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AD6C52D7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 20:57:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0579888C6;
	Mon, 12 Aug 2024 22:56:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xCzo3/fy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B54888703; Mon, 12 Aug 2024 22:56:49 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60960866EE
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 22:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso5317732a12.2
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 13:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723496206; x=1724101006; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1PxyyKOhIhLJM2KgJkvqItP92NBeMNvKC4AN5PkDxq8=;
 b=xCzo3/fyc4kANwIOVZik9JjffUQmMlkCYmj7pVfgxC5hqeNe3TZYJLeqPLDNKvtZHL
 Csyt+wzP+c1eRqTzgAU8yFBIQhzuSX2hE08t6MHapZhW35J8QrYDSyD0C3kOBjR0OvWd
 o8cbf0MjL/ZflcQOW8MaZdyhio6W8nWNANwJnb755Saw1HhQ3QHMPC1NcohlBBbqkP7i
 co/TreQ0VbuEQxFmtTocSCMxDhPgK1BhdzZ9EBYThHeCkUNUFoY2epa/VpKuxoMvwMoi
 f7x3RouTAHJkAscuAtB4GnVTnZwE7yl6PtiQZOox8it6+Hpz8rZL3O5CILeHv8jXAolY
 kogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723496206; x=1724101006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1PxyyKOhIhLJM2KgJkvqItP92NBeMNvKC4AN5PkDxq8=;
 b=b+b31BdDTz6gHDCEOW+aNBsYyk0DFnQ9nySwHmEdsvZxWsfItR5C5HA3F9mHZqpcU8
 CLxQUxUo8gq9QapwXY1/QgDxAcRYRtHVSaungYME1nWpnUygcLk+j4b2GtRGvFI6aOxt
 9NDwgirvA/1kakqXpvRpd4rwViSabOJByDE/YEWX99N3T7LNnD4Zwg2uw2x5Kc3q2/s7
 u4J/U1rh2UEjtTWMeUFHlpMujJfExZjF1GT/d4SwklA0kr0U55i497ODaqE4576mrVX1
 qfIUFMYy+dC383GVHJsjaoWhp915XOsp0n3NE2FSmMDwCzmOo+/GeqokNzaN/HqKqLhB
 QltA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTQ18dGJOQATbiOHdYALxnzqxR8KSJEumTQz2HShcj6cfG/WnypyyiFuvw9rdXyL9+w9KsZs4WesmLCJ59+Vp74Lq6bA==
X-Gm-Message-State: AOJu0YzaaM6bNcpRONkb86t/xBOum76EWn6ElWn0bJ2eN7W0VA1vMe79
 xkHethObQNvGDq9G9X8O0V1Pv91CIoGkC3iH8hmoDvMCHDSpqDPNBd9MxsH4uz4=
X-Google-Smtp-Source: AGHT+IHu3NRE8UyZ6UYLQ59IL/10VuUrlo/hH6IeRwB7XqYzwA3D+lBHsd7+UHSdspX04sFvGgBNlA==
X-Received: by 2002:a17:907:3fa3:b0:a7d:c9fa:e3b3 with SMTP id
 a640c23a62f3a-a80ed2ca647mr96190166b.54.1723496205337; 
 Mon, 12 Aug 2024 13:56:45 -0700 (PDT)
Received: from localhost.localdomain (ppp046103060252.access.hol.gr.
 [46.103.60.252]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a80f411b51esm9491966b.134.2024.08.12.13.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 13:56:44 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: xypron.glpk@gmx.de
Cc: kojima.masahisa@socionext.com, u-boot@lists.denx.de,
 akashi.tkhro@gmail.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 3/3] efi_loader: return the correct error in
 efi_bootmgr_release_uridp()
Date: Mon, 12 Aug 2024 23:56:38 +0300
Message-ID: <20240812205638.1732159-3-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
References: <20240812205638.1732159-1-ilias.apalodimas@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

There's currently a chance for this function to overwrite an error if
one occurred and the subsequent call to
efi_uninstall_multiple_protocol_interfaces() succedded. Although this
is an EFI event and we can't do much let's at least set and return
the correct error

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/efi_bootmgr.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
index 03cdee15017d..a3aa2b8d1b92 100644
--- a/lib/efi_loader/efi_bootmgr.c
+++ b/lib/efi_loader/efi_bootmgr.c
@@ -388,6 +388,7 @@ err:
 efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 {
 	efi_status_t ret = EFI_SUCCESS;
+	efi_status_t ret2 = EFI_SUCCESS;
 
 	if (!ctx)
 		return ret;
@@ -407,17 +408,18 @@ efi_status_t efi_bootmgr_release_uridp(struct uridp_context *ctx)
 
 	/* cleanup for PE-COFF image */
 	if (ctx->mem_handle) {
-		ret = efi_uninstall_multiple_protocol_interfaces(
-			ctx->mem_handle, &efi_guid_device_path, ctx->loaded_dp,
-			NULL);
-		if (ret != EFI_SUCCESS)
+		ret2 = efi_uninstall_multiple_protocol_interfaces(ctx->mem_handle,
+								  &efi_guid_device_path,
+								  ctx->loaded_dp,
+								  NULL);
+		if (ret2 != EFI_SUCCESS)
 			log_err("Uninstall device_path protocol failed\n");
 	}
 
 	efi_free_pool(ctx->loaded_dp);
 	free(ctx);
 
-	return ret;
+	return ret == EFI_SUCCESS ? ret2 : ret;
 }
 
 /**
-- 
2.45.2

