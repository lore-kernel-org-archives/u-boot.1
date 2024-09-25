Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90474C369D9
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F374588D54;
	Wed, 25 Sep 2024 14:58:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lEuB70fY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4296788D4A; Wed, 25 Sep 2024 14:58:16 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40D3188D35
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a8d3cde1103so634107866b.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269087; x=1727873887; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tYoMGrXqE+S6nEdOO2l2em6C8ljT7oMt6hQeXmK8ONo=;
 b=lEuB70fY9zfaVw0D7gc38rAhvRPqhwAqz2Qjy9PwBwHQwNixG1g3xgTwgbXj7g5nzk
 P1wRe4zz+9wdN+GyC8YolQ8dEJWp5KtApVEl4KG5jc0MrCJtqt53zb5tGiF2VhQKYBRO
 /yLRLw1vaFZZR0wU3pp6n2nI7g7mps1M8We0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269087; x=1727873887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tYoMGrXqE+S6nEdOO2l2em6C8ljT7oMt6hQeXmK8ONo=;
 b=MZ0ONxN7n7vA/JTLBBMiiiaHFgNuNWGWLavOsjujcbQ9oU7Noy3k0Tg+aa9C/0Stk+
 N4ZO56dsz7MMucpZjBMiFY/w3M9WrRrxybWabZwIgLyuhKXe9qDdwpJSJet0+ouS3hIn
 CQzsgZdMfV7CGWabKbGSKR/ZseWg1oHEsOE+afWiNihaOdARiaLqrHMApqFlVoLGmCGY
 E0tqrWX3vbUddFjOyiZHYq7NnzCyw/jRQN+OG78GNG1+kmxj34oaRt2DQKuhzd4fJI3o
 ghzKRXhNnZgDlEq0ZOpWgHnXtmtkxBGnKHr04/45WIZ2mufARAMWTdyhfAGM9zrTGIZ6
 x7rg==
X-Gm-Message-State: AOJu0YwUM3pPt/WCzREfRpFiKAEh7WJALbz7SZYM5il/YB6AF+juY7D8
 CKPJHGYUiaM1edoLTZ7WeaC0oGb7qUF4FunnIKlc0B/SaNchhxQodP16Lr+A23GkAPLQyoOIEsy
 8Ww==
X-Google-Smtp-Source: AGHT+IFDMQAxY+dIMBlV7rcMqooYL96t3WAW+8iw5x/xuSL/GIxk7dl1LM8Pn5FKusNSvHmzbP0amw==
X-Received: by 2002:a17:907:720e:b0:a86:c372:14c3 with SMTP id
 a640c23a62f3a-a93a061bb7emr237196866b.48.1727269087420; 
 Wed, 25 Sep 2024 05:58:07 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:58:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Devarsh Thakkar <devarsht@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 11/19] spl: Support jumping to VPL from TPL
Date: Wed, 25 Sep 2024 14:55:37 +0200
Message-ID: <20240925125622.197915-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Use spl_get_image_pos() to obtain the image position to jump to. Add
the symbols used for VPL so that the correct image can be loaded.

Use the functions provided for accessing these symbols and add a few
comments too.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index d01e9861f88..623e486c210 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -50,15 +50,19 @@ u32 *boot_params_ptr = NULL;
 
 #if CONFIG_IS_ENABLED(BINMAN_UBOOT_SYMBOLS)
 /* See spl.h for information about this */
+#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && !defined(CONFIG_VPL_BUILD)
 binman_sym_declare(ulong, u_boot_any, image_pos);
 binman_sym_declare(ulong, u_boot_any, size);
+#endif
 
-#ifdef CONFIG_TPL
+#if defined(CONFIG_TPL)
+/* TPL jumps straight to SPL */
 binman_sym_declare(ulong, u_boot_spl_any, image_pos);
 binman_sym_declare(ulong, u_boot_spl_any, size);
 #endif
 
 #ifdef CONFIG_VPL
+/* TPL jumps to VPL */
 binman_sym_declare(ulong, u_boot_vpl_any, image_pos);
 binman_sym_declare(ulong, u_boot_vpl_any, size);
 #endif
@@ -179,9 +183,15 @@ ulong spl_get_image_pos(void)
 	if (spl_next_phase() == PHASE_VPL)
 		return binman_sym(ulong, u_boot_vpl_any, image_pos);
 #endif
-	return spl_next_phase() == PHASE_SPL ?
-		binman_sym(ulong, u_boot_spl_any, image_pos) :
-		binman_sym(ulong, u_boot_any, image_pos);
+#if defined(CONFIG_TPL) && !defined(CONFIG_VPL)
+	if (spl_next_phase() == PHASE_SPL)
+		return binman_sym(ulong, u_boot_spl_any, image_pos);
+#endif
+#if defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && !defined(CONFIG_VPL_BUILD)
+	return binman_sym(ulong, u_boot_any, image_pos);
+#endif
+
+	return BINMAN_SYM_MISSING;
 }
 
 ulong spl_get_image_size(void)
@@ -263,8 +273,8 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 	 */
 	if (u_boot_pos && u_boot_pos != BINMAN_SYM_MISSING) {
 		/* Binman does not support separated entry addresses */
-		spl_image->entry_point = u_boot_pos;
-		spl_image->load_addr = u_boot_pos;
+		spl_image->entry_point = spl_get_image_text_base();
+		spl_image->load_addr = spl_get_image_text_base();
 	} else {
 		spl_image->entry_point = CONFIG_SYS_UBOOT_START;
 		spl_image->load_addr = CONFIG_TEXT_BASE;
-- 
2.43.0

