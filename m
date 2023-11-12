Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A48C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 00:10:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EABA86FB0;
	Sun, 12 Nov 2023 01:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kNQsUnTF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10C9286F84; Sun, 12 Nov 2023 01:09:38 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF87986F8A
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 01:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-359d559766cso11278995ab.1
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 16:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699747771; x=1700352571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okrupx0hEnVGFvS9r+7ykxKUcWH89WMnXHPLTOneRro=;
 b=kNQsUnTFsKqSUY0DJf7JfhPWvvKSeF93ll4/9mjk1gUvkR9h/wuIXPJGesRHrW2lP5
 sU1fZklalZG9cov/u0xGuvJhFemYjEBnnz7Xpyi2DdkuDAkm736bD6xsXTcY/dOqY3cr
 kX8WyyUarhIE/RD2uqwSd3bHk5IujFR0fx4AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699747771; x=1700352571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okrupx0hEnVGFvS9r+7ykxKUcWH89WMnXHPLTOneRro=;
 b=ojxLDYkNObPdBFvQmcypQPU6V6Qxa1fHuPknFBb9hIf8Jw3I50npQWQQ0XRoIlNJvo
 erCLyP2tXcACcbq8A1VmHbS1S6rDZK9ElKL32mjntUfZoHl1xgtD+kjzKPdMTw+Z3Viv
 yGfJTxjUVbTv9rJCTalJkY7dANpB4nzBI2gClOzJ8vZ90lFYzcxo6e1z9jK05oW2qw05
 fLEzptQj/oscP1Wh2r6iKYpWuc0iokbWOWPGcKabEK1QnG7AWV+M1CxgpKyynVbDeqqK
 rLnc6qQOM9a5TV0TQqJsh/gtK+6YkKaCyBUYLLEO4xIkaz8ZAt4KK8yUnlN6C3hYdBs0
 EkLQ==
X-Gm-Message-State: AOJu0Yxj9h81ZIbhDtdAjrpirdTFwW42trZSKhL47jvCKAYqRpEpGkrj
 ePDnclUAai5Y3GIbAJdV8LncUgeF7Dnj1ArVcqJPHw==
X-Google-Smtp-Source: AGHT+IE2AUosxGMBMLS0oahrkl8jmGMuubyCLUa+s/oVHhcJcZfpE8ojgkeLIb8tK2GvY+F4X9IDBg==
X-Received: by 2002:a92:c549:0:b0:359:c24b:9ee1 with SMTP id
 a9-20020a92c549000000b00359c24b9ee1mr4785008ilj.14.1699747771368; 
 Sat, 11 Nov 2023 16:09:31 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a92280e000000b003576ff2d8b1sm706804ilf.26.2023.11.11.16.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 16:09:31 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 01/29] arm: x86: Drop discarding of command linker-lists
Date: Sat, 11 Nov 2023 17:08:46 -0700
Message-ID: <20231112000923.73568-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112000923.73568-1-sjg@chromium.org>
References: <20231112000923.73568-1-sjg@chromium.org>
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
---

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
2.42.0.869.gea05f2083d-goog

