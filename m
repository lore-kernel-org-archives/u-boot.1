Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B72D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674E78959D;
	Tue, 19 Nov 2024 14:19:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S+6aJBnP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B8A6895B0; Tue, 19 Nov 2024 14:19:03 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0238895A9
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a77562332aso5137445ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022339; x=1732627139; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+AYZlz6cGlHttVE7vJZxGV91qTB1ubAPPTiAp2Vmxo=;
 b=S+6aJBnPfZ+BPmODnFQEsaWPyG92AFqoMw0NBiLQ732UiJ5DzlPlwOVaFunSGc4k6/
 UQOZjp4uCIztdS1ZS2+gb1OFOjbhDBGY5eL/4Eje4aaD15wMXxImYlqIx7vaoY9q/Nl5
 FZoXTVJ34ryALml6Svr9/WzKZiEKQafBBUxqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022339; x=1732627139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+AYZlz6cGlHttVE7vJZxGV91qTB1ubAPPTiAp2Vmxo=;
 b=Sq2H3pcqfI//gRH/wQB0g6GqmvyziX0jZ8w9tL/3xjYmAe3nKuNk4zIqx0m8OMi0Ft
 toLYJgwEsH6X4QSJubeUQMjvbljfEnlNfJee4vYOiSfESKIGiEJADJlsk+HCYILCQPjX
 8l6/jAFZsGagEZt0lR5Gxy1JiGinfgt1Asf7y996XneISTjDYFfy7HwjEbcSHdFJmSFy
 eEYUUy4r6ubGX3luS7paNI06VGYwxSDqjccRoADKAgHme++AJEqiWHSdyQiILOYY6PC1
 yljbYQiNKgBT32C19wGr9JDGb9kpJp88HJE2/WbQobTylunmHAQoWNVJRKdd5vKnEviX
 Gzxw==
X-Gm-Message-State: AOJu0Yz5YWFDnuLAN8EJfekLGjsY+8ngCKMxKow2B8gvqAhJOFBAdgmr
 +VU+RYfAy8p1HjXk9v7rr1ddPNCSFNAP2JBDKJtvCfz4dEJa+GqcqDCUoJS2iXeXHkms8AQlVmo
 =
X-Google-Smtp-Source: AGHT+IECC24eLOe4HUIvvIOd3tk5h3+qvlpl2u5/uU+JLKVQwNB/KfMJhNdbWbzLsTYM3xSj703gVg==
X-Received: by 2002:a05:6e02:198b:b0:3a7:7e40:8a75 with SMTP id
 e9e14a558f8ab-3a77e408c69mr11853495ab.18.1732022339026; 
 Tue, 19 Nov 2024 05:18:59 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:18:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 03/39] x86: Drop duplicate definition of zimage_dump()
Date: Tue, 19 Nov 2024 06:18:08 -0700
Message-Id: <20241119131844.4078144-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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
2.34.1

