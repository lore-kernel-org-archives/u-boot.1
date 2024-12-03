Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E6BE77166
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:46:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 554AA896A9;
	Wed,  4 Dec 2024 00:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UiGVz17W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DD6988F55; Wed,  4 Dec 2024 00:46:23 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82BD78966C
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-8418f849466so206911239f.1
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269578; x=1733874378; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=El44hvYoArK6lqJKjv96dHFcIMtvoAoIYAra/BqgSOo=;
 b=UiGVz17WjVC/gkz0IV22mputvNku0/rXHpcz+CmBacqFgoq1glUDV3KcExPk2S2Htm
 CImPTY5tJ5nisEzICNnFxU0UbRIvQdN49dMJWc4AHsPSX9r5s579/hTo6n4tAWNYO01o
 VT1RiBBXNGWTyV/Msz9I3/fpXdViXjGt1Ldkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269578; x=1733874378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=El44hvYoArK6lqJKjv96dHFcIMtvoAoIYAra/BqgSOo=;
 b=sX9Nyc4OYTankeNZYfwMHmsz6VUf+5ozCTMl4RYpMunRmuG/To0ykJ9EeeyzW8/Oqi
 +GogjXLFvZUVlaihdg/E7UhBDcW3OmIVTHcl57HISh55a+NP7BbrgCAf5hfc5KPePkSn
 QG5rkMAd6i/VXMSvzF8v4McY0hnbK0boMXWrJ6IMNSt1W3CkP96ojoeFGtDQjbBy2B57
 Skj8sIEdTWUiKRho8DNWB4neBDquP7tU4oRpbkQKfmPUutK1x70ega3p0+pzaeTp8H9O
 b46rqfen7d5pu54cRqt12R1jInfAFKvacU5pJFWUycZ01UNwC2EtC80n7vZMYDVlunHV
 KlVQ==
X-Gm-Message-State: AOJu0Yx8gNZU4Y/4s6bqZ3lTv02aOC7zXc3rukmk88J2HFyQruRG7Ee8
 16xfbUOGAlxs46kp8FDwdLYEnDxyMinEftTYNfhy8SW61a/oXCFoxlrnbXsxj7tthItyBboAsJE
 =
X-Gm-Gg: ASbGncuavgUC3a+CKaZv+TbS3w1eQOiQFTt1YwniTGPqRZirkDyxHETD2/48IbJKPYL
 +dfSpn6s5RC4cWBAsa1PjXrbarN5OZNAlOMXD48lOWNfMODUMohhlzX9hqV9VuKD3Cuo6KHyjHj
 79pIbQcK0hIEpCsgY9DvtQAZpQL9ct2C3GFxUuWxBQ61QHWGtbPkkQmNV6CwRU2B8u5sFMoSmAA
 ndwpkQI72qQkG7/qkgz49/FuJ87zzs5atfB5kd1WgDsFknLSMpRST+lYtpnVeL51jOXsY4ixnlu
 DOcFt/hpcVU=
X-Google-Smtp-Source: AGHT+IGxDFdujfOab4RwNeWMzxjPmUjb7ECyx4YehDxSJtRTUgNwcd/EKvgwjN7gduSyPRmRV8y1LQ==
X-Received: by 2002:a05:6602:2d81:b0:843:e008:95b7 with SMTP id
 ca18e2360f4ac-8445b42cdebmr575889539f.0.1733269578367; 
 Tue, 03 Dec 2024 15:46:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:46:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 03/41] x86: Drop duplicate definition of zimage_dump()
Date: Tue,  3 Dec 2024 16:45:21 -0700
Message-Id: <20241203234559.2938192-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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
2.34.1

