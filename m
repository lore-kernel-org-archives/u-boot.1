Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FECC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 16:54:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB8687B17;
	Thu, 14 Dec 2023 17:52:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eqjYW9iW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F065387AFE; Thu, 14 Dec 2023 17:51:59 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F3287ACF
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 17:51:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-35f7589ea1fso6485665ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 08:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702572714; x=1703177514; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cl84ho9PaHKi9mTJyi7LOgPR2lT9kcSBVz8kzl/nQK8=;
 b=eqjYW9iW2NlddrsDrS0HYCA/frvq+nrxDEhcEKBfQ7nCz08Dl5t9nlhQDfbZHudEJW
 FQGm8Ch2OcNemqaNlpGra08DtPG9IDidhxQpQZRUNUpSWrCoTs/gkd0B3C8tNunXgj9i
 8IC47VSotfe3AhZTGGIrUMQUi0RbF62rsEXI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702572714; x=1703177514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cl84ho9PaHKi9mTJyi7LOgPR2lT9kcSBVz8kzl/nQK8=;
 b=ieGAJRbW+8ivXxLaLBeyRC/mrgZFPJOeFc7tPZkXvX7SD/QcEgI/uAB4Q0sAmyauGM
 RKdLRWioIE/kZBjr7IiXal/KHqoNjcUuUHuUKofzi5p2eY5BO8i82dYSrhuchO13uv4A
 8m73li2PRnu1dqkArgYReQTi1JhvloMJw+zFZTLAI2oXt5nuIMDrWPkaLwqT+jZxlvK/
 yZb4XKPdfdnBmygB4SjT6LLFh0dd1wfgupaG8ZleHUInc171oXdOmsjpmezM2gaxKg2r
 SmwBRQW7WjJHRhZOfCIivmS+v8DPA9UTfuuZbfyHLQE09p/3fzIUPhsoKMIMxDUhR0/3
 XQHQ==
X-Gm-Message-State: AOJu0YwH0zqH8uQG+cRDHlIN0q4e/a9qyX8lBGrlolwLGIa1Q75qUSiH
 c1fj7yvAMC7Tuh923cd3Z89fFyHTP2vKQBY2aAzjCQ==
X-Google-Smtp-Source: AGHT+IHOBjM9nj9WKeP19baBtwTyPpHNCtP4e3tgY7xupBVDkFyc8B965HnWJvXSYKHI4d5GQRAXcQ==
X-Received: by 2002:a05:6e02:1bca:b0:35f:80e4:298b with SMTP id
 x10-20020a056e021bca00b0035f80e4298bmr1360153ilv.40.1702572714599; 
 Thu, 14 Dec 2023 08:51:54 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 bn14-20020a056e02338e00b00357ca1ed25esm1228347ilb.80.2023.12.14.08.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 08:51:54 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 13/21] bootz: Avoid use of #ifdef
Date: Thu, 14 Dec 2023 09:50:22 -0700
Message-ID: <20231214165112.2182274-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214165112.2182274-1-sjg@chromium.org>
References: <20231214165112.2182274-1-sjg@chromium.org>
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

Use the compiler to get the set of states, instead of the preprocessor.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Split out bootz removal of #ifdef

 cmd/bootz.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/cmd/bootz.c b/cmd/bootz.c
index a652879ea5ec..8c25905598a8 100644
--- a/cmd/bootz.c
+++ b/cmd/bootz.c
@@ -64,7 +64,7 @@ static int bootz_start(struct cmd_tbl *cmdtp, int flag, int argc,
 
 int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-	int ret;
+	int states, ret;
 
 	/* Consume 'bootz' */
 	argc--; argv++;
@@ -79,14 +79,13 @@ int do_bootz(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	bootm_disable_interrupts();
 
 	images.os.os = IH_OS_LINUX;
-	ret = do_bootm_states(cmdtp, flag, argc, argv,
-#ifdef CONFIG_SYS_BOOT_RAMDISK_HIGH
-			      BOOTM_STATE_RAMDISK |
-#endif
-			      BOOTM_STATE_MEASURE |
-			      BOOTM_STATE_OS_PREP | BOOTM_STATE_OS_FAKE_GO |
-			      BOOTM_STATE_OS_GO,
-			      &images, 1);
+
+	states = BOOTM_STATE_MEASURE | BOOTM_STATE_OS_PREP |
+		BOOTM_STATE_OS_FAKE_GO | BOOTM_STATE_OS_GO;
+	if (IS_ENABLED(CONFIG_SYS_BOOT_RAMDISK_HIGH))
+		states |= BOOTM_STATE_RAMDISK;
+
+	ret = do_bootm_states(cmdtp, flag, argc, argv, states, &images, 1);
 
 	return ret;
 }
-- 
2.43.0.472.g3155946c3a-goog

