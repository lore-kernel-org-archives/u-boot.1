Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4121E95A66
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CC5886F8C;
	Sun,  8 Oct 2023 01:16:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cJMTiSop";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A88B86DCB; Sun,  8 Oct 2023 01:15:02 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A6C986F2C
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-351250be257so14405765ab.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720404; x=1697325204; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xxm0206OOO7nse9KspJEPmH6AfQ6j3lrpKe4/0NG9J4=;
 b=cJMTiSop5fw7xZ1iTqrlau0eCDagM3BU7AakCh2kwboG8A83oSO9SlKSbx197irM3M
 WCo+FwmK6kM+4Uz9S0nKcc+efBhD89r3q1SH28r4UZAJqGSX3Zo5NwhfrNyW1Zy6W9SA
 A62s/ebtiCyfTfafo/TzVJSffVg7I+SRRxrOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720404; x=1697325204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xxm0206OOO7nse9KspJEPmH6AfQ6j3lrpKe4/0NG9J4=;
 b=qr9yjQB9goMrDcsT+i617VFqtq16y8kJ6zFYs32jtmH4qbnXCdT9quc7TSZKC6Hh+w
 xdpt/IPdIRFhzw05nCCGbeC6+vOQIL+pd2UB4LCIvE+UadaRbRiwhZigDPBjJTELT4fl
 PEFjp7u5ELmIEbbJMLmhD3flv4fBBvW6BR9G8U8370wjh2p3o6UtHiAhV8n4KpDjKdd1
 POexpLN335jCyricPWMDub/jp7ReN0ftH4rW6z3w3gwfdcUpqWDRj+BZ2K+iwcMi7RRa
 cFgCYhDNsusqGCdCcsg/N5qDAnEF7jKWmrPkzcjqJCL8OKu9SDhCEKna5RE2er9DkDrj
 SpgQ==
X-Gm-Message-State: AOJu0Yxlf0FfxJk1jEZTK0GvaD0b8oFyvRjVdri5t50kk35tAIznr93d
 TefMzZeNu8umXuL+VnJymDtC9qyGOqHgCXPFNPg=
X-Google-Smtp-Source: AGHT+IE96PYqSzxPXvxkr5vmxXqZqZE6Axvkp5JTTwbWNlu2t4kW0h8wRBxNowm6CQ5kK9O+h/BBAA==
X-Received: by 2002:a05:6e02:963:b0:34c:e84b:4c5c with SMTP id
 q3-20020a056e02096300b0034ce84b4c5cmr10148026ilt.27.1696720404477; 
 Sat, 07 Oct 2023 16:13:24 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:24 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 25/27] arm: x86: Drop discarding of command linker-lists
Date: Sat,  7 Oct 2023 17:12:44 -0600
Message-ID: <20231007231255.277623-26-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

Changes in v2:
- Add new patch to drop discarding of command linker-lists

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
2.42.0.609.gbb76f46606-goog

