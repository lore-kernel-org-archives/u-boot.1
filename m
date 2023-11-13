Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16811C4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 16:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6B1870FF;
	Mon, 13 Nov 2023 17:08:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RKb0VBVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFC9870FF; Mon, 13 Nov 2023 17:08:41 +0100 (CET)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F48E870BC
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:08:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=o451686892@gmail.com
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6c10f098a27so3450943b3a.2
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699891715; x=1700496515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SdKaXkanC/JGTSSj1Ny0ALwQcvQSTEWkiGwQ7g0s40A=;
 b=RKb0VBVra81XK+UflR77SVRRHxuLarl1EUMV0qyOoUAXkbAsjxVSBQ75NZKe5W6UIF
 dpsp4QkGA+4ztIcmD9vbJFVIM5yWYem2YzxVBW8A1EdEB/Bc6R98kVWen//blS6PxNVG
 bTBmDTWc0n3f8C3gocZqzPOhzCAF9A4cdIP0nYFsU5ry1eijpwvaQQo+HNFGr0kWXJCr
 6RKyGM29BHebQMA3E4KpkhawzDj4F8EiciWS6/7+SQzT8FCKMcj3KZ1qewPeL5EZJd5X
 B/Mukkxrt9ufp5qX2Zz/YqRATXYzEuW81pxg0o3OJMWQbpV/YFrdeQxqwNGbevLS2m5L
 vfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699891715; x=1700496515;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SdKaXkanC/JGTSSj1Ny0ALwQcvQSTEWkiGwQ7g0s40A=;
 b=fcKcugcixJwQgeIGhJA1nHIHUSc7Ppb8ZKh+WMFVdWwsi4tx/hegSgjhf5x+G2B+qk
 YrBN9/Hz/YCe1cLAuhaAyAtAWROaVWwtCCTg0/ozWNL+hIg09rq01WGNVQgRYFK5eRgI
 YwlO4lGLYjknlM1SDujy/W3HcrAC62CNLoS++s2oVvXyzLOgOBO73NAcSz/5AUJaDyHT
 5mxl+oIlvHym7SAydPPPE1gtbVfJY/czi680st0ffdqiTuS23RvU9j2a5y9rItC3CxfU
 o2rcE9a5rsK96SEXF2iBZ6KnJGo1A69ufHlVASDle/C9ftzMxuqPjpejwwfzQaWFsgFQ
 E4MA==
X-Gm-Message-State: AOJu0YyOlPpnKm+ATjAWwKf7sWAwuL28VIwzw2T+xfbV2jVcQ0N6rtUg
 u9InpBHvrevRHujaCKoxkinfzYT3Li1JFKiY
X-Google-Smtp-Source: AGHT+IEgvobl06xda0/TCSRepqQRwL83A/Anb+tsML+4jzXRTjM2TY6iFT7oKIJxVfq2a+C1vs181Q==
X-Received: by 2002:a05:6a20:6a04:b0:186:7988:c747 with SMTP id
 p4-20020a056a206a0400b001867988c747mr2763186pzk.19.1699891715175; 
 Mon, 13 Nov 2023 08:08:35 -0800 (PST)
Received: from ownia.localdomain ([8.210.91.195])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a62fb0e000000b006c0678eab2csm4097605pfm.90.2023.11.13.08.08.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 08:08:34 -0800 (PST)
From: Weizhao Ouyang <o451686892@gmail.com>
To: u-boot@lists.denx.de
Cc: Weizhao Ouyang <o451686892@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2] efi_loader: Fix UEFI error handling
Date: Mon, 13 Nov 2023 16:08:23 +0000
Message-Id: <20231113160823.138145-1-o451686892@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Try to catch error the earlier way.

Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>
---
Changes in v2:
- Avoid to stop the boot process.

 lib/efi_loader/efi_var_file.c | 4 +++-
 lib/efi_loader/efi_variable.c | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
index 62e071bd83..fe1c462f17 100644
--- a/lib/efi_loader/efi_var_file.c
+++ b/lib/efi_loader/efi_var_file.c
@@ -192,8 +192,10 @@ efi_status_t efi_var_restore(struct efi_var_file *buf, bool safe)
 		ret = efi_var_mem_ins(var->name, &var->guid, var->attr,
 				      var->length, data, 0, NULL,
 				      var->time);
-		if (ret != EFI_SUCCESS)
+		if (ret != EFI_SUCCESS) {
 			log_err("Failed to set EFI variable %ls\n", var->name);
+			return ret;
+		}
 	}
 	return EFI_SUCCESS;
 }
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index be95ed44e6..2b2ca8c090 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -350,8 +350,6 @@ efi_status_t efi_set_variable_int(const u16 *variable_name,
 
 	if (var_type == EFI_AUTH_VAR_PK)
 		ret = efi_init_secure_state();
-	else
-		ret = EFI_SUCCESS;
 
 	/*
 	 * Write non-volatile EFI variables to file
-- 
2.39.2

