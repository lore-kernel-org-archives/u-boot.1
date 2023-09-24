Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 412ADCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:42:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB8286BAC;
	Sun, 24 Sep 2023 22:40:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FP2ahyyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 998AE86B2C; Sun, 24 Sep 2023 22:40:32 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5A686B68
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7926b7f8636so144815939f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588029; x=1696192829; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfERxBKrxNEJOvibOg2pA7zAS5Z4RNllPjMgTiVhZ78=;
 b=FP2ahyyUHBthoENXOymnANc1cfEdvVDD7R1aYlJD/3KwFyOv+SSvGRLKZMjwikVAjJ
 3K5HlEoLs5P9huYbeUVtd0qT8RkbkiOkT3S/kF1LQKf1hbq2JAR1ZiaaLf/3pnEy3aFm
 1sELlbcxcWMQVab0heS8wzvODF364ixzOpu+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588029; x=1696192829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfERxBKrxNEJOvibOg2pA7zAS5Z4RNllPjMgTiVhZ78=;
 b=RUP3n4qfIILkTAKr3VS2M5ItJ43AchNpeyMZEKTKfX7Rkw3dQRv2kjcIjyP2CFMQol
 reacPB9AGz3TFV/CsarxGahbAtWppfi4ydt6c7NP8XK5YCd4f9qx0SQKeOZZexR8Nvqa
 9SGKiNsIbtFsilcIKBPXk11bnUxhBgot9SfQhfRdHEdO7fHSfUgJMqQY3Z3awDc9xMrG
 HuXHhRF7cqtwh5YBG1kd12mIOH2qK0Z7ioHbaTGwtldendazYwPmd0p19lsqhkxsTI0s
 uzFoarHWCZtC0876G6BWLd7WBCUVuurEl172DU5e+9nRImlY90SOu1C2/JcVWBfMuFmK
 oSVQ==
X-Gm-Message-State: AOJu0Yy72X//G1Ht+Gu4ka8xvBO6cLWIpmN/Y+tzk7oKjiqUGX7GkxPP
 pjy055lVbIic3T/cn9INeLE4lJEEOGDmPHF+u+0=
X-Google-Smtp-Source: AGHT+IFRqgwSLbXXg6ZJUmBxnxCNv9e2THA3UHVHjax1+OM5I/f0eFgjIWChcbAoSDxFR/UHtqILyg==
X-Received: by 2002:a05:6602:1512:b0:79f:ab2c:a908 with SMTP id
 g18-20020a056602151200b0079fab2ca908mr5892088iow.7.1695588029087; 
 Sun, 24 Sep 2023 13:40:29 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Hector Palacios <hector.palacios@digi.com>, Marek Vasut <marex@denx.de>
Subject: [PATCH 10/25] cmd: Use an #ifdef around run_commandf()
Date: Sun, 24 Sep 2023 14:39:28 -0600
Message-ID: <20230924203953.1829820-11-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

This is not available if CMDLINE is disabled, so add an #ifdef to correct
this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/cli.c b/common/cli.c
index 3916a7b10a7d..4d0fea4387f2 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -129,6 +129,7 @@ int run_command_list(const char *cmd, int len, int flag)
 	return rcode;
 }
 
+#ifdef CONFIG_CMDLINE
 int run_commandf(const char *fmt, ...)
 {
 	va_list args;
@@ -153,6 +154,7 @@ int run_commandf(const char *fmt, ...)
 	}
 	return run_command(console_buffer, 0);
 }
+#endif /* CMDLINE */
 
 /****************************************************************************/
 
-- 
2.42.0.515.g380fc7ccd1-goog

