Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5BCC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 16:07:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 761C881895;
	Thu,  6 Mar 2025 17:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EX4as6vI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B98681879; Thu,  6 Mar 2025 17:05:20 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D25F81974
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 17:05:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-85b0180631fso24984939f.1
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 08:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741277116; x=1741881916; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=EX4as6vI+vTUI8FVA1Gjlzwsj0oshWZ7OAPJTnmoxJLayKr+QOTG6Knaf6S7hUcbPu
 4g/SYKVoG/NrOnKh7iDfaJLtorSRbRK55PYkcBLR9aFQdfbpShi4o/esrTcoAo8Jgclp
 Gjpj6AjhspjvnoSctqhmpaZFhSQgy9MTLK7eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277116; x=1741881916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b18O0mXBGODv+uK2kOscdQzbGBpYEBF3/6yNBnZfDEs=;
 b=sB251qoOQVNn/NiaRHIoCAof0GkYBIObUNLh6hiS3Ryv+bNuLhsPh38M914jwhyj9I
 dms73Hc4SVzNetBLsU807He5B4DzdqBTVQyTVnIltH/NUeNdH1TF6fxfOB9dtt1SXTFp
 XS20prjiDBvOrIgbWpBiisxd+eTZoni0aQIB8N6a1siMCTw1aMvGGBcqVRtzdzQ6/aJf
 E7GZoJsd7qQ0HHBdgQ8MOYBIHdl2GdI9LY1BovaOmbBysoUF2G0ACZR+y01we2UEL1NG
 v6CJgSloCI10YEK4B6AiRV7CjyycxCJOrU1hkvyC3s52Gty2+JKcZae8/LIuKNZbAjAy
 Zttw==
X-Gm-Message-State: AOJu0YwW93r5WHn30pzCd0QBsrG9bngZR0zr0w8Effla9rMgpDXIN8Es
 Nbak5SooohEYwvn7l0DhdAUlxo5uC6YPYB1dUQKeKJUNSYaKPH9b4x1r2wBvoM0jUrM+t3VaxO8
 =
X-Gm-Gg: ASbGncuF1WQ1CvhnvtVF0GBVWHjMH6gOy8RaozJHQv/3/+uFfBAJ/+Jkh1rjUqwBY3p
 Q3nhbjDWSq3Z9sTdDxV0rZo5/bO1KWz0T1fFQVTMeQNUxrLGPPDQEvMWLbXJOL3hrQbdjAf5jEm
 wpKWkfY0u30mLU4sitOJJ53ikNVxcACYovS/tm0LQXak0zr701ztGAHq3ajxVLRgnXWYMvB2BRT
 WJYslpzKxJ5XvE778T9A2HEDqWHkLwBHTrN6L670Aloavq2tsuv/fbi+TF1bMUlWumDaTdAIZbn
 1cWMFbJMaCarI/l9EkDPHdUPPBXsKrgzUdIzNHxOaGQAp6Y12mvcZrKXGjVKv8nMoBj90S9mFGM
 zFRhGMA==
X-Google-Smtp-Source: AGHT+IHnrspL9J57Z2dM2RKERqydBnqPyorXLQ9HX3Ut93p7AHsyvcMDzkO2ZSMKHtcGYgViM/qifw==
X-Received: by 2002:a05:6e02:240a:b0:3d2:aa73:7b7a with SMTP id
 e9e14a558f8ab-3d441995eb8mr199835ab.12.1741277115548; 
 Thu, 06 Mar 2025 08:05:15 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f213b959c1sm46759173.38.2025.03.06.08.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:05:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 14/47] x86: Drop the message about features missing in
 64-bit
Date: Thu,  6 Mar 2025 09:03:41 -0700
Message-ID: <20250306160428.3041057-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306160428.3041057-1-sjg@chromium.org>
References: <20250306160428.3041057-1-sjg@chromium.org>
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

This functions normally and has done for a while, so drop this scary
message.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/lib/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/spl.c b/arch/x86/lib/spl.c
index 47cf9c862b5..0a6a761987e 100644
--- a/arch/x86/lib/spl.c
+++ b/arch/x86/lib/spl.c
@@ -281,7 +281,7 @@ void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
 {
 	int ret;
 
-	printf("Jumping to 64-bit U-Boot: Note many features are missing\n");
+	log_debug("Jumping to 64-bit U-Boot\n");
 	ret = cpu_jump_to_64bit_uboot(spl_image->entry_point);
 	debug("ret=%d\n", ret);
 	hang();
-- 
2.43.0

