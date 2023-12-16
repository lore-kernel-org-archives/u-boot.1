Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D070C4332F
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 03:17:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 601FA87C94;
	Sat, 16 Dec 2023 04:15:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HPUMBNvk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA2487C76; Sat, 16 Dec 2023 04:15:24 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D3D387B3B
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 04:15:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35f89f18daeso5488815ab.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702696519; x=1703301319; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MSzuf5ZtitDxQ2UhGFg+YURrNd2q5NkShFXIw1AVQw=;
 b=HPUMBNvkNzVFdgMU5QizpZQtH4OaSOmAzGLRNjf991Ja5QcT/ErtTcbvsZwwGQH3OX
 HdWNYbVYSV1vIjGtRuSZ4WwXPMPgKtVQ8gUw/yg8GmBAmZZjQpoJKR8cuulu7KWFrHgr
 aOFFMUTL0CUcZIfRI+W9vQ9GL7ynh3JTG23e0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702696519; x=1703301319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0MSzuf5ZtitDxQ2UhGFg+YURrNd2q5NkShFXIw1AVQw=;
 b=BUPyPLs76kR9TlD7aEP1vZE18X+AjfqWTo7Yz1eFrk1DZt0770etgCAAol9BaN8oF1
 99Aj2f1+JU6TX2nxq6aoj2uD08afHPCv2cGNzc5TUQtpq8o8ESCJ8F4s5BURbfqrLVTN
 SHTFoYEIEvoPhVyqRQIzUSShqpTa0iF1a+7AjcU9q1yEY0ZnQ1EuCcRz5GxqZ9l/o0cp
 T6Xd77tXyR/IQbUPUDRn1eSonk3uG4Im/bK9wJGzE6ia5uVQO4wFEOr2W4vUwIexGM7D
 Tn7nPLFEoW9Q2ABsq+5NRUw+YtvnQ5U0Kf83NBdaOxE742XjyNKepRuQNMkR4vks6mq+
 TjLw==
X-Gm-Message-State: AOJu0Yz/8FbAfwcLRiYnLwr9cPNOYaPawkItVOjewu6GEDqyTqH4dZvH
 mRRdRo+dRt94HLHd2YkIn2uQJhs3p83aH9pMV2ZslA==
X-Google-Smtp-Source: AGHT+IHX1JqPR5yhOysWdB/N5bYUiUTZQCYsShQflutiDZi1oU6RArgcx4QZW3hK7YTg0Te7QfO6tA==
X-Received: by 2002:a05:6e02:1ba1:b0:35f:79ca:4e34 with SMTP id
 n1-20020a056e021ba100b0035f79ca4e34mr5987693ili.15.1702696519674; 
 Fri, 15 Dec 2023 19:15:19 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a92ceca000000b0035f75e80d1esm542163ilq.52.2023.12.15.19.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 19:15:19 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 13/22] bootz: Avoid use of #ifdef
Date: Fri, 15 Dec 2023 20:14:17 -0700
Message-ID: <20231216031446.2222362-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231216031446.2222362-1-sjg@chromium.org>
References: <20231216031446.2222362-1-sjg@chromium.org>
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
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

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

