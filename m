Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00981C19F32
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 00:27:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11F2881276;
	Thu,  6 Mar 2025 01:26:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l9b92gOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2504A80FE2; Thu,  6 Mar 2025 01:26:34 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9603F81253
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 01:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85afd2b9106so9196939f.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 16:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741220790; x=1741825590; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+4VrS5y5lgDem2Bt9RptwRV5U96bSIt4UvEAzwDirWg=;
 b=l9b92gOrOQfNZ9gjWWsUwDSthJTQewWpliXTK5VnKObmA3fh3gU3eQUxez8dKisbve
 bWg+UgIKggvsHwxRXemV4dAqxI0LDMTKi44NupC4N0a9jLQqQUkezSsH6LYnn9TUXm7g
 ewjAVkgrt/7DHIEnkcKhHiy16M7ULCBrY1/bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741220790; x=1741825590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+4VrS5y5lgDem2Bt9RptwRV5U96bSIt4UvEAzwDirWg=;
 b=L9DBkH6+G+jgfgSduzr2UZgvuVhCqspW/vUqxCKDsUjQAUt2k0Q5FYzs/NE8gYKVF+
 vPyrO1q72ewZXpMkr2K5OH52Wou/sExKyhKX2LwanwSdP97G7vUrbRth6X6nInlnxD+N
 ik49JIBOXhtCThckB0nydFas5WAZg5f4rg30otddoXgChLEa54XZtoGraKeGDdMGnEka
 e/1O+LLDvIMxG7eLiBCH3Er4MraD8yh8oZbKtXK10vsbCyxT8x2TWQt31ojLY2fdmMAl
 E6o2RfmAiK0SPtCchqtLOJrCaG37hp5GSIPgB+PDDf5ONUyupMXuRFFSlI2kKyNNaCQD
 LV5w==
X-Gm-Message-State: AOJu0YzrI+517CA/sasRD/kdDwJECiD76VylwvFaDPfFpbKs9L89rqy2
 ur6oEFTNPRdtHrHIpu0LmD93pWpF5pcSv6hAruNqyZFukhRiNQEkTy7KnJGg1cDuUqHga9kTo2Y
 =
X-Gm-Gg: ASbGncvcCejWhKTbiglKeldZDPQsMU0ovDHefHNaXHhLXFrbSpFnVAVKMDdmo2FvTPv
 mT+2S4IbDP1dhtcQH7tbIx0jQzgRvU60hHUSJ7nrf1Np9ADbV+uhtKS8MPz/vYr7qE9oXfUqfyT
 +UIb6YZIF2y90Y2L5iyKzjiv5CVy2VS9RHhV14o6TxkQ3qUz3bDJLJipe4JMzzcFDH1YOJMo+65
 bpdneOHylXWj6ni6oU7lmYZ53ZUZ4FrZhQSNjbpgxJbpTIBDdvVTBh37nUDyFazN7PLCsRedxcF
 68X715yM1UkvTG+31gzwit1Z1uhThJ9laIB/i86/SSLaY039FhHQDpxq58IPzUBTS1NMF7wXNIo
 MIsWF1A==
X-Google-Smtp-Source: AGHT+IEKQzn2Pl3tw1PqW57aQwoYzyWHrYYhvIJVpFulnCEuNALYisZTmKCrBqGSg//pBki4BZao8A==
X-Received: by 2002:a05:6602:3994:b0:85a:e1c0:3ee5 with SMTP id
 ca18e2360f4ac-85aff8c1f70mr716276639f.8.1741220789762; 
 Wed, 05 Mar 2025 16:26:29 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-85b11986869sm1106239f.1.2025.03.05.16.26.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 16:26:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v5 03/29] x86: Drop duplicate definition of zimage_dump()
Date: Wed,  5 Mar 2025 17:24:57 -0700
Message-ID: <20250306002533.2380866-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306002533.2380866-1-sjg@chromium.org>
References: <20250306002533.2380866-1-sjg@chromium.org>
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

This is now defined in bootm.h so drop the duplicate in the x86 code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/x86/include/asm/zimage.h | 8 --------
 cmd/x86/zboot.c               | 1 +
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/zimage.h b/arch/x86/include/asm/zimage.h
index 8b542605170..76b2a797ccf 100644
--- a/arch/x86/include/asm/zimage.h
+++ b/arch/x86/include/asm/zimage.h
@@ -71,14 +71,6 @@ struct zboot_state {
 
 extern struct zboot_state state;
 
-/**
- * zimage_dump() - Dump information about a zimage
- *
- * @base_ptr: Pointer to the boot parameters
- * @show_cmdline: true to show the kernel command line
- */
-void zimage_dump(struct boot_params *base_ptr, bool show_cmdline);
-
 /**
  * zboot_load() - Load a zimage
  *
diff --git a/cmd/x86/zboot.c b/cmd/x86/zboot.c
index 3035172352a..40f67a75593 100644
--- a/cmd/x86/zboot.c
+++ b/cmd/x86/zboot.c
@@ -7,6 +7,7 @@
 
 #define LOG_CATEGORY	LOGC_BOOT
 
+#include <bootm.h>
 #include <command.h>
 #include <mapmem.h>
 #include <vsprintf.h>
-- 
2.43.0

