Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB88AC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 01:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B145C84994;
	Wed,  8 Jul 2026 03:30:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DcV/3BH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1122384A20; Wed,  8 Jul 2026 03:30:29 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83AEF8499C
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 03:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7eb3865ea6fso163462a34.2
 for <u-boot@lists.denx.de>; Tue, 07 Jul 2026 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783474225; x=1784079025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kwuPfl+5yByWjlRLOqplcITghNrUgBhU/PUIpsZ25w=;
 b=DcV/3BH80hUckZlUirVNDTX8oIB5k3ZHkORbo4kOlFLEJG//UVI2qeOmfy89sN/xNq
 6DGwEOEGlDqotEhYR1OtvJHTM/n+PcRUzJ+6fBg4i/lcDie1pj05LGJCxqSBeqsHFepg
 nWC9LmniQZPxwfk0j2A64JEAmEO3T1TOOouWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783474225; x=1784079025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1kwuPfl+5yByWjlRLOqplcITghNrUgBhU/PUIpsZ25w=;
 b=JeW+7K+leAzqosGEKqT4RHTPPwX5mfau+PClwWLupKPf2sz/xhf5fJOdKNx2FYrQTh
 g9imy7elypaXdeQrUf91YnApWFT9nzxIDu1RHLwxeCSVy2H5m3s0hStJG/HyF0G7mkRN
 GUAxjdHvLbynNVP4FNVFgydKFo6LGuhx+OmOr1wGBwBJbkXz8Jdg0y2unkxQqTDWk8Hn
 yEDB+en1GCgb+ztYc4UjOztyal1XcSezDNLBdtWqPzEMXet+2DOQqJ3fA7bVWiCA0L10
 sgp5VlFPJNV3nVPBMla4uHZD6g+soVDS4thGciC/2TE2JHqWZUxj+bNvypLmise7DsjE
 ojjg==
X-Gm-Message-State: AOJu0YwgXf8DMhGgWe/eZ+bMpRV5vk4GsJ40m61tWeblhnlNQ//5CvSt
 h9AAVtfKCfgJAplMC839KZO20mW8Jr01iDkFk+D+5E1ILhD9G3aQ+5uxGO21pfzwo27ojbgKmTH
 TJJ+t+8w=
X-Gm-Gg: AfdE7cmfa9eorSoiwIfUK7oOOxCpHR1zKP/3/v1BbCZ7iINlh0i7WJ3qDhIW/iYBSuk
 bmDSGfFSI2TwVTczSwLhKOSiA1+ig0Ee+RUD6C5n7gjGTDUYI+hlgDeiLSCj55gP0key+rVsMww
 az3shMWlbSxDrZFVx+NyZc8w/y+MSCHgZb2MA/J5sls4tp2lLU0FaKe7M9SG4PsiGUkHMCKIHAu
 F/Q7lNbdN/QC3cZxIQnROptkvBroPcxHMvDA2LDGpmfiFkpV05eGNELoNu5d2eN8NCcJ423H25l
 Fnr0Mda0m0TEKrbweMEAOiOTMfsNXyxSLDkE6hD/cyvxg13v/qHPajXp/vVzDHPNcfzZMGlT3+r
 uo339OdB+/M7npYyEYL6lYfg7/rMbPm8G5MovRo1iHacYvKm9cL0+ajelpanLtl00bIUY5wlRKE
 jjNKHvOKRg6Zzr3HeSwEcIgBNv3CXB23gVm9YtNKHpWit7gBjc1mF0T2U0VL/gtBz84GnTEofQy
 k363WQJYeCW9U02fIsYJQ7iNRgJCe89Z6PuC0nD1qBVO8AdnCIb3bJ79sFZpQ==
X-Received: by 2002:a05:6830:710e:b0:7e9:b537:102c with SMTP id
 46e09a7af769-7ebcff9bd41mr278581a34.25.1783474225039; 
 Tue, 07 Jul 2026 18:30:25 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-100-56.totalplay.net. [189.203.100.56])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcaf77ba4sm780182a34.9.2026.07.07.18.30.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 18:30:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: David Feng <fenghua@phytium.com.cn>, Linus Walleij <linusw@kernel.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 2/7] vexpress64: Correct CONFIG symbol logic around device
 tree passage
Date: Tue,  7 Jul 2026 19:25:12 -0600
Message-ID: <20260708013019.288985-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708013019.288985-1-trini@konsulko.com>
References: <20260708013019.288985-1-trini@konsulko.com>
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

When we don't have BLOBLIST_PASSAGE_MANDATORY enabled, then we're being
passed the device tree in some other manner, via OF_HAS_PRIOR_STAGE.
Correct our logic around which symbols are used to guard what is
generated / used and when.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: David Feng <fenghua@phytium.com.cn>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 board/armltd/vexpress64/Kconfig      | 2 +-
 board/armltd/vexpress64/Makefile     | 2 ++
 board/armltd/vexpress64/vexpress64.c | 4 ++--
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index 49c7fda0b83a..a988c7198498 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -31,7 +31,7 @@ choice
 config TARGET_VEXPRESS64_BASE_FVP
 	bool "Support Versatile Express ARMv8a FVP BASE model"
 	select VEXPRESS64_BASE_MODEL
-	imply OF_HAS_PRIOR_STAGE if !BLOBLIST
+	imply OF_HAS_PRIOR_STAGE
 
 config TARGET_VEXPRESS64_BASER_FVP
 	bool "Support Versatile Express ARMv8r64 FVP BASE model"
diff --git a/board/armltd/vexpress64/Makefile b/board/armltd/vexpress64/Makefile
index b0dd1d0af879..5f9dc2af930a 100644
--- a/board/armltd/vexpress64/Makefile
+++ b/board/armltd/vexpress64/Makefile
@@ -5,6 +5,8 @@
 
 obj-y	:= vexpress64.o
 
+ifeq ($(CONFIG_BLOBLIST_PASSAGE_MANDATORY),)
 obj-$(CONFIG_OF_HAS_PRIOR_STAGE)	+= lowlevel_init.o
+endif
 
 obj-$(CONFIG_TARGET_VEXPRESS64_JUNO)	+= pcie.o
diff --git a/board/armltd/vexpress64/vexpress64.c b/board/armltd/vexpress64/vexpress64.c
index d68da0e3d650..8b6b96d757d5 100644
--- a/board/armltd/vexpress64/vexpress64.c
+++ b/board/armltd/vexpress64/vexpress64.c
@@ -97,7 +97,7 @@ int dram_init_banksize(void)
  * Push the variable into the .data section so that it
  * does not get cleared later.
  */
-#ifdef CONFIG_OF_HAS_PRIOR_STAGE
+#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
 unsigned long __section(".data") prior_stage_fdt_address[2];
 #endif
 
@@ -150,7 +150,7 @@ static phys_addr_t find_dtb_in_nor_flash(const char *partname)
 }
 #endif
 
-#ifdef CONFIG_OF_HAS_PRIOR_STAGE
+#ifndef CONFIG_BLOBLIST_PASSAGE_MANDATORY
 /*
  * Filter for a valid DTB, as TF-A happens to provide a pointer to some
  * data structure using the DTB format, which we cannot use.
-- 
2.43.0

