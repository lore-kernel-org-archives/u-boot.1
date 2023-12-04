Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E133C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:33:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920ED878B2;
	Mon,  4 Dec 2023 01:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fZwAbTT4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAAD877E5; Mon,  4 Dec 2023 01:30:27 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C99B878B2
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:30:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce52ff23dfso191460b3a.0
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649823; x=1702254623; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUOCT8ybq9pHLqhKxMSDLw11MF8MgwaafozyRc/YsKk=;
 b=fZwAbTT4f16K15db3RuAOZfIbm2VuHdL1t3f452Rzz9dcUHv/YfzXh2Rzw/Pbwasdz
 NQnFcTa59zq8IJHHo8E6rHYYVsKgLbKLzbSPdWnfb6YBV4XRKfY3ugl9dJvuPMphWwII
 lw3EAYV2X+TZp1EEeLV4XlSMVtk7NlgZ2Lv7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649823; x=1702254623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUOCT8ybq9pHLqhKxMSDLw11MF8MgwaafozyRc/YsKk=;
 b=ekSIvGlsf724lElBD/rcMnUWBiu6Bmw2EOY2Ag8BsryryLrV1NbJQQf8n469GWCxk9
 sZmhhVkLUbH2QWJlSDKWOdrxElhWZRMeZqwQaTG1TPi8sdptvo48+vTMGZ7+NLl8UQWb
 LrHh0YHh8qx0qYrz8c4aSK4heF1OSUOn478DySgOj5XY3di9ydhDyqutGLh0UWX9pdPT
 GP4Zp7BreNICdGU9sZm9TntYjMbt5/7FAJXXc7L3ea7O3GzM9jpK5PIpuvZWPXHWtpXF
 KfpbQcecut2XSbWBWvXahKZt4AIUfNdIejWQhBz2sSu3SSXo/kdvkcqpFUxpeRRsE5Q6
 aEeQ==
X-Gm-Message-State: AOJu0YwHetmkQANh3wIyyZp0agnvJauiICk1HZ+MGQxDpdPbHwypmDXF
 XJ7H0hO5G4SFaRYtJnd54IG9r2sfrhDBsImJundEEg==
X-Google-Smtp-Source: AGHT+IHzJx3WePCXNElhQAiDYebS/Kw1AOyoO+0FfthUaAgLgOZtEmdOijgk2wVH2R8dbGG7/Z2uNA==
X-Received: by 2002:a05:6a00:188b:b0:6cd:fa78:db9c with SMTP id
 x11-20020a056a00188b00b006cdfa78db9cmr3908853pfh.12.1701649823636; 
 Sun, 03 Dec 2023 16:30:23 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a056a001b5800b006ce3a0b4bfasm2346433pfv.24.2023.12.03.16.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:30:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 08/13] x86: zboot: Drop intermediate zboot_go() function
Date: Sun,  3 Dec 2023 17:29:33 -0700
Message-ID: <20231203172933.8.Iaa270a7231e610258d361f35f5da324db9ef69c8@changeid>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204002944.897949-1-sjg@chromium.org>
References: <20231204002944.897949-1-sjg@chromium.org>
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

This function only calls zboot_go() so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index f392b6b3e493..f49cdd91a1f8 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -106,21 +106,12 @@ static int do_zboot_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	return 0;
 }
 
-static int _zboot_go(void)
-{
-	int ret;
-
-	ret = zboot_go();
-
-	return ret;
-}
-
 static int do_zboot_go(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char *const argv[])
 {
 	int ret;
 
-	ret = _zboot_go();
+	ret = zboot_go();
 	if (ret) {
 		printf("Kernel returned! (err=%d)\n", ret);
 		return CMD_RET_FAILURE;
-- 
2.43.0.rc2.451.g8631bc7472-goog

