Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3395FE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:32:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2856387217;
	Mon,  2 Oct 2023 03:17:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lw4PJysp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C188B87172; Mon,  2 Oct 2023 03:17:25 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAA987161
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so569159939f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209368; x=1696814168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NLg7qhMgIm/t9UJwgFKNekIyWrp6N8OiU8q+Pk/P6k=;
 b=Lw4PJyspXaHQUyep/lM4HBUjUir8bW5mhWJ0rOSgCQimn8Q5lAjgjSKIHMbyWquMPn
 G+YdS35sClRlvBedOIMgEg3umJdg/8/w0AEVKIrgLNF4KGx2PklEGIapdPyWCJe1wt0n
 IKNm0KNh8hYViu0p17GjfJLVR0BGmMMfw230s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209368; x=1696814168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NLg7qhMgIm/t9UJwgFKNekIyWrp6N8OiU8q+Pk/P6k=;
 b=SzxQYiy1SDJRn3aI3yMBiwHAJtF4N2qFZr0QVJ7fLy+fHXAE+6S3ZfBJUeUHbRrdZg
 IKxgKrY46PaAYy0BH/SMFNNSNT34AvtKrBOaFjpaIwmRbmM2xcAamS1GKYcHDAtE9Xyy
 hb9ME2tKGLT2MuyQJPOJDpCtGP5g7YYOxb90yDtvu95QNNdbziyQC1ATd/tQCh7QVXB0
 qr7J44WGw1iNPZ/7e/qJjPTDCETeyjrifwsHmj8HVNwhRm34TPJTlig6muV+HUvwQu2b
 Qq2gOB47FS5rb/EUuQEuxx3Uxue8RKHgLLAPbLfVQJtn8XO3Ah7mkjgdBE0+N72HEpZV
 Tupg==
X-Gm-Message-State: AOJu0YxkwwlOd+QQCFB3S668tneVVn+cMbVkLwHmhUTG8nF82KV6CBcz
 D8RS4d7/bZd7XfPViu2LAx15gyIuS9HFvypCDqw=
X-Google-Smtp-Source: AGHT+IFTSS48EJOVFs/7uILoyQ5PVyTR520C8mqedjDkpWFXVnUt4q13hH4HnGqpTbq1p+x3it9TNA==
X-Received: by 2002:a05:6602:2288:b0:794:efb0:83d6 with SMTP id
 d8-20020a056602228800b00794efb083d6mr11471228iod.12.1696209368281; 
 Sun, 01 Oct 2023 18:16:08 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Brandon Maier <brandon.maier@collins.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>
Subject: [PATCH 05/34] test: Run bootstd tests only on sandbox
Date: Sun,  1 Oct 2023 19:15:15 -0600
Message-ID: <20231002011553.463514-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

These make use of disk images which are not available on reak boards.
Add a new Kconfig to ensure these tests only run where they are valid.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Kconfig  | 5 +++++
 test/Makefile | 2 +-
 test/cmd_ut.c | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/test/Kconfig b/test/Kconfig
index 69d63a5ff7dd..022395e489bb 100644
--- a/test/Kconfig
+++ b/test/Kconfig
@@ -64,6 +64,11 @@ config UT_LIB_RSA
 
 endif
 
+config UT_BOOTSTD
+	bool "Unit tests for standard boot"
+	depends on UNIT_TEST && SANDBOX
+	default y
+
 config UT_COMPRESSION
 	bool "Unit test for compression"
 	depends on UNIT_TEST
diff --git a/test/Makefile b/test/Makefile
index 178773647a82..4e179cb3930a 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -26,7 +26,7 @@ obj-$(CONFIG_UT_TIME) += time_ut.o
 obj-y += ut.o
 
 ifeq ($(CONFIG_SPL_BUILD),)
-obj-$(CONFIG_UNIT_TEST) += boot/
+obj-$(CONFIG_$(SPL_)UT_BOOTSTD) += boot/
 obj-$(CONFIG_UNIT_TEST) += common/
 obj-y += log/
 obj-$(CONFIG_$(SPL_)UT_UNICODE) += unicode_ut.o
diff --git a/test/cmd_ut.c b/test/cmd_ut.c
index d3505fe8d97e..f74930a7ecbe 100644
--- a/test/cmd_ut.c
+++ b/test/cmd_ut.c
@@ -57,7 +57,7 @@ static struct cmd_tbl cmd_ut_sub[] = {
 #ifdef CONFIG_CMD_BDI
 	U_BOOT_CMD_MKENT(bdinfo, CONFIG_SYS_MAXARGS, 1, do_ut_bdinfo, "", ""),
 #endif
-#ifdef CONFIG_BOOTSTD
+#ifdef CONFIG_UT_BOOTSTD
 	U_BOOT_CMD_MKENT(bootstd, CONFIG_SYS_MAXARGS, 1, do_ut_bootstd,
 			 "", ""),
 #endif
-- 
2.42.0.582.g8ccd20d70d-goog

