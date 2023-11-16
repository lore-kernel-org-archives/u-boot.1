Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC06C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 04:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2892387440;
	Thu, 16 Nov 2023 05:11:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gV3Ky+mT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ECCF8725C; Thu, 16 Nov 2023 05:11:22 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493E586F73
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 05:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7a67b9cd230so12334639f.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700107879; x=1700712679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZDjmWK5zrBzxEXrSsc2eQ4DlmPhgdHnBaoFW6cyZck=;
 b=gV3Ky+mTudxefEcQfoqYwC8fYmKPNG1ifUL269yvc0uqf8zxd8vWknMFnDIcBoWnOE
 odHXq5RjTXKJ3OliD5IpwtKjxpGokBBt56mnKqY08qUcVbXiRLvanFnqluxl1PLUSuvX
 6QhRsyxgeYbGrMH/22OLqpkpNR//iLE3e3Irk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700107879; x=1700712679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZDjmWK5zrBzxEXrSsc2eQ4DlmPhgdHnBaoFW6cyZck=;
 b=Qbpjz66jqoetdaYglWODoo0FmeFKR4+4Wbp2JGYv0sw5ybtS3+74Am33z2fuNSy6IR
 2LbyC4fS6bgEY2gUoBdD92cXzzV0rBFpsQs2ToavWcCdt6hepHDaXfyreSiSj6bxVCD1
 9ry6jeH6Gmi/vZNLSAH91tg+PTOx3lEpeq/7y1+guXpmjafx3elSZEldEt4/KduNwKzN
 76/yTFmq7O5np28FZw8TupE118B6+VDccGylyQpS/zu54EnPRSzKD0k+ZSBMa+w1iCu8
 uU3RoSAHy9Jp+Om6ZL4uB7ZKaPucaYnOLM49cyWvZb83sHODH0ciwIyeMG5IMXYYyAYW
 0xZQ==
X-Gm-Message-State: AOJu0YzP6xIBxPgl1mpsmZoJIIhL3ksmkP+bM2eJUt9hQWa6ECXcJiY+
 eMMC12vD1hUUMxWrW9YU2DkAcidxqBBkGojoCABZ5Q==
X-Google-Smtp-Source: AGHT+IFyNpgg12qvArM1Kvo+3Q9ToLyJqmuScqohititC403zU2BFU00sSUklpOXDh6EogIq6Go/kg==
X-Received: by 2002:a6b:91a:0:b0:7a6:7bbe:5aa0 with SMTP id
 t26-20020a6b091a000000b007a67bbe5aa0mr14937270ioi.0.1700107878842; 
 Wed, 15 Nov 2023 20:11:18 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a02a803000000b0045a1063713asm1307527jaj.130.2023.11.15.20.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 20:11:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 01/32] arm: x86: Drop discarding of command linker-lists
Date: Wed, 15 Nov 2023 21:10:01 -0700
Message-ID: <20231116041043.362055-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231116041043.362055-1-sjg@chromium.org>
References: <20231116041043.362055-1-sjg@chromium.org>
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

Since we can now cleanly disable CMDLINE when needed, drop the rules
which discard the command code.  It will not be built in the first
place.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/cpu/u-boot.lds     | 3 ---
 arch/x86/cpu/u-boot-64.lds  | 4 ----
 arch/x86/cpu/u-boot-spl.lds | 4 ----
 arch/x86/cpu/u-boot.lds     | 4 ----
 4 files changed, 15 deletions(-)

diff --git a/arch/arm/cpu/u-boot.lds b/arch/arm/cpu/u-boot.lds
index fc4f63d83489..7724c9332c3b 100644
--- a/arch/arm/cpu/u-boot.lds
+++ b/arch/arm/cpu/u-boot.lds
@@ -14,9 +14,6 @@ OUTPUT_ARCH(arm)
 ENTRY(_start)
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
 #if defined(CONFIG_ARMV7_SECURE_BASE) && defined(CONFIG_ARMV7_NONSEC)
 	/*
 	 * If CONFIG_ARMV7_SECURE_BASE is true, secure code will not
diff --git a/arch/x86/cpu/u-boot-64.lds b/arch/x86/cpu/u-boot-64.lds
index d0398ff00d71..00a6d8691211 100644
--- a/arch/x86/cpu/u-boot-64.lds
+++ b/arch/x86/cpu/u-boot-64.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 #ifdef CONFIG_TEXT_BASE
 	. = CONFIG_TEXT_BASE;	/* Location of bootcode in flash */
 #endif
diff --git a/arch/x86/cpu/u-boot-spl.lds b/arch/x86/cpu/u-boot-spl.lds
index a0a2a06a18cd..50b4b1608552 100644
--- a/arch/x86/cpu/u-boot-spl.lds
+++ b/arch/x86/cpu/u-boot-spl.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 	. = IMAGE_TEXT_BASE;	/* Location of bootcode in flash */
 	__text_start = .;
 	.text  : {
diff --git a/arch/x86/cpu/u-boot.lds b/arch/x86/cpu/u-boot.lds
index a31f4220a000..c418ff44aa08 100644
--- a/arch/x86/cpu/u-boot.lds
+++ b/arch/x86/cpu/u-boot.lds
@@ -11,10 +11,6 @@ ENTRY(_start)
 
 SECTIONS
 {
-#ifndef CONFIG_CMDLINE
-	/DISCARD/ : { *(__u_boot_list_2_cmd_*) }
-#endif
-
 	. = CONFIG_TEXT_BASE;	/* Location of bootcode in flash */
 	__text_start = .;
 
-- 
2.43.0.rc0.421.g78406f8d94-goog

