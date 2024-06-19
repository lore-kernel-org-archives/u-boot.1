Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7046C27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 12:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 855F4884AA;
	Wed, 19 Jun 2024 14:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cJr3+vwO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2264B8844B; Wed, 19 Jun 2024 14:35:02 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B4287923
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 14:34:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7ebdb5d9915so240095939f.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718800498; x=1719405298; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+GDZ8O5ppyOnlEhKFtCD7X+qzrHiUQmZ/BcTHvjrt0=;
 b=cJr3+vwO3Wq5Gy8GlUKYUq1MP6C0puV0NCE/INcBrBwZVsw8fPzC6/VcPWHZiBlXNn
 00A7IsvxZ6XiFtnHddpQbsF28ffGS/esS7sYJXfb9Z+czSr4Ifjqr5qeyQW5VOstewIs
 7GQgnk7/wkb5Xvkiya6kI8u6kUeez5+dv/JjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718800498; x=1719405298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X+GDZ8O5ppyOnlEhKFtCD7X+qzrHiUQmZ/BcTHvjrt0=;
 b=jiGpXf+/CKg1HdtqVlQiS2u2UKx7EMtc0e/lVCo152d/AdEA6oZx73qP0z9NnNelit
 cz07tKM/RTmrQBBKtO2jyArjbfLPZLhuCb7tAxq0UGXva2H6uy+jkQ0m/DIM08BfbW7B
 TZ+jkm86N2x35RbZK0OTBSecPZfbccqokmixF2kEk4d0eWh2JWan7Ti2teigR8xS9vap
 ZstO0iQsfJJ6sZ8Ak5tgOquTxUm1hXWmZM95Y9TkXRD2BbPKpepiKHvE1tzl4t3e6l3Y
 APhm0kUMCezVF4S2vvD0xBy1sYWiabAVgG/z4QWXHLa4yr1GcCwMZ9Mm4BUmfZkzXS06
 Im/g==
X-Gm-Message-State: AOJu0YwFOBHUvxwLTOSwXUlzbi+6sySnXlA7S9dV0nzMwyGxX4NO1fGr
 jnelRJGeelf7CITeHfWuefEr5bEkz7jra3kGUruSnMXAlsBJa7RzX01fzSWzVrrhaJ8pefInMcW
 AtQ==
X-Google-Smtp-Source: AGHT+IHQGDJYKE2IzZ0D4qlJ1fhJVkcCO0JKV8dbRw+dhUK8CZlu7yvxCiiWSY0pPSAmvUVO+/Yw4g==
X-Received: by 2002:a05:6602:3f84:b0:7eb:9697:95c9 with SMTP id
 ca18e2360f4ac-7f13eba7599mr290078839f.0.1718800498454; 
 Wed, 19 Jun 2024 05:34:58 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b956a20f18sm3701882173.133.2024.06.19.05.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 05:34:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Paul Menzel <paulepanter@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] zboot: Correct use of state_mask argument
Date: Wed, 19 Jun 2024 06:34:52 -0600
Message-Id: <20240619123453.720600-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619123453.720600-1-sjg@chromium.org>
References: <20240619123453.720600-1-sjg@chromium.org>
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

There is confusion in this function between the flag and state_mask
parameters, which prevents the boot from actually happening. Correct
this by using state_mask instead of flag for deciding which states to go
through.

This fixes booting of some 32-bit Debian kernels.

Note: Some sort of CI for this is in the works.

Fixes: 228c6722d44 ("x86: zboot: Avoid iteration in do_zboot_states()")

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 cmd/x86/zboot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index c14219f19e9..94e602b8a5b 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -122,18 +122,18 @@ U_BOOT_SUBCMDS(zboot,
 int do_zboot_states(struct cmd_tbl *cmdtp, int flag, int argc,
 		    char *const argv[], int state_mask)
 {
-	int ret;
+	int ret = 0;
 
 	log_debug("state_mask %x\n", state_mask);
-	if (flag & ZBOOT_STATE_START)
+	if (state_mask & ZBOOT_STATE_START)
 		ret = do_zboot_start(cmdtp, flag, argc, argv);
-	if (!ret && (flag & ZBOOT_STATE_LOAD))
+	if (!ret && (state_mask & ZBOOT_STATE_LOAD))
 		ret = do_zboot_load(cmdtp, flag, argc, argv);
-	if (!ret && (flag & ZBOOT_STATE_SETUP))
+	if (!ret && (state_mask & ZBOOT_STATE_SETUP))
 		ret = do_zboot_setup(cmdtp, flag, argc, argv);
-	if (!ret && (flag & ZBOOT_STATE_INFO))
+	if (!ret && (state_mask & ZBOOT_STATE_INFO))
 		ret = do_zboot_info(cmdtp, flag, argc, argv);
-	if (!ret && (flag & ZBOOT_STATE_GO))
+	if (!ret && (state_mask & ZBOOT_STATE_GO))
 		ret = do_zboot_go(cmdtp, flag, argc, argv);
 	if (ret)
 		return ret;
-- 
2.34.1

