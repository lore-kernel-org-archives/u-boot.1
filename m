Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D68ACC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:52:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B37786A50;
	Thu, 17 Aug 2023 03:52:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJNQgNg0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C224A86A44; Thu, 17 Aug 2023 03:52:04 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05283847D3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bca3311b4fso5712314a34.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237120; x=1692841920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7W2TpQN8yWcjO3EKJ0oz2OVVHWNxMPNgiWXDQ7WFKhQ=;
 b=HJNQgNg076YelFYz+B7gW+y96KtTzhXIp9QavaAzSLyUBgI+kBDmiy5KYcoTN2hRVH
 U+3HsIcD7WI/bqyIuciUkgzf87ZjAoeWBjJMTzo9R/X+t4m+E03HxPPtchllYdO+ye8m
 5IGI0WTKLeksVp1Hspr58XqeSxf3ovt/Xas5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237120; x=1692841920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7W2TpQN8yWcjO3EKJ0oz2OVVHWNxMPNgiWXDQ7WFKhQ=;
 b=QoCOSjUYVztorGl1cg87HIcEIGs6rNTofWLS9ZPy8V6kpzO6N5dGWOqHAQFhmSXrfP
 /3xwac0fAmwd6AvyoSVvU1n14w7+N8ooSa6lzfxA0yk9hVKf+UatdCwB2ZlxTzqmFbla
 stOSbtSYeSa0MnDw0JvOSs94cio6gFLnFGUVIzYYD0rzUtcW/0WFJEd0jd6fooT4DqPQ
 smpW8F3ld3gRCYu6silaDYUamCWKRid3wgjOuG6RbGy0wOK6HIdNS4jfUIP3XrNfrdR+
 sXnv737Fz9w99l8NdWlxrC9/3k+8oQK2am682FeWSAXjbaXQHKbBbXmBGlYshK4rFJyU
 W7jw==
X-Gm-Message-State: AOJu0Yx99MnXr5uiXkvhPUzsIvcW/Qbu8FfDN4JbXKecfYOvsyBEQVFv
 TGDIAMfulilGckDrMM9pOiF8ee9wx0ep0w4fd/Q=
X-Google-Smtp-Source: AGHT+IFWLAaDFJBVZHtZkMGKDMcRL4Lj9uz9hqBA70IuLqBL2yRKPNj9MB95/vnS3Mfecy0MDy2F1g==
X-Received: by 2002:a05:6830:4d3:b0:6bd:d95:d746 with SMTP id
 s19-20020a05683004d300b006bd0d95d746mr3558364otd.37.1692237120485; 
 Wed, 16 Aug 2023 18:52:00 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/9] x86: Set the CPU vendor in SPL
Date: Wed, 16 Aug 2023 19:51:37 -0600
Message-ID: <20230817015149.774847-3-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

We don't read this information in 64-bit mode, since we don't have the
macros for doing it. Set it to Intel by default. This allows the TSC timer
to work correctly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/x86/cpu/x86_64/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index d1c3873dd6a7..2647bff891f8 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -8,8 +8,11 @@
 #include <cpu_func.h>
 #include <debug_uart.h>
 #include <init.h>
+#include <asm/cpu.h>
 #include <asm/global_data.h>
 
+DECLARE_GLOBAL_DATA_PTR;
+
 int cpu_has_64bit(void)
 {
 	return true;
@@ -38,6 +41,10 @@ int x86_mp_init(void)
 
 int x86_cpu_reinit_f(void)
 {
+	/* set the vendor to Intel so that native_calibrate_tsc() works */
+	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	gd->arch.has_mtrr = true;
+
 	return 0;
 }
 
-- 
2.41.0.694.ge786442a9b-goog

