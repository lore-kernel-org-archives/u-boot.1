Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE229EC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 15:59:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B72D86A68;
	Thu,  7 Sep 2023 17:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N+6DxErP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0CE586A35; Thu,  7 Sep 2023 17:58:40 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF8E886A68
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7927f36120cso46868939f.1
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102315; x=1694707115; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zTPDBXKoBFVR7fs1I0Vez+Z8DhMRSE+qQU5VpbyH4M=;
 b=N+6DxErPtb8xC2gauzb13xQFrSi15+p/fBONrWq8jsKMkxcIyVZqTVyG9QCoAlhNcO
 A0qssD5zkzY3LoZdCoO49xWD74DtZhYtRyMUf6QGYQMpmrMBvRDhYoHpLiInX0nLqmKo
 Z+yn3uepOaj43asxnXmLOMdak+hAiDNCWFo7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102315; x=1694707115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zTPDBXKoBFVR7fs1I0Vez+Z8DhMRSE+qQU5VpbyH4M=;
 b=I+n0SX9TZBpte1Juxb0ISJ4czC+gBxT/Ne/etAIRjgNO5VC9BJs5FqTlOLyVmlnZC0
 jWxIcUMzhC4yTRphH6QbyRUg9GYUQ3p2kTMDwuPQkdS0jxs5jLIrHvZgysN+/jsPM5tL
 CtgcENHDec+vAZe0dD39eemS8Ll5GWNzfIOr7IqsRSXSV7d4ApULuRsfOiK/a/VI9LFj
 CIKkSOZzwyn1Yp1Jxasc7sej4x8GekVQeix3x9trwk+ouRZSSyZ99+RbKIXA3UTgP0EI
 4pooXOzfeoA2sEYXvwBx5VhX97D5tEZZk11mSMsS4BJIFP/WSxhPjOuePW3Tj58mrqzE
 QJug==
X-Gm-Message-State: AOJu0YwIBOGWIO3Ixw3OjUzz60Z6cbhsKDQNMZApBUzFNhahn+Vro6V4
 m82Qq6SiguvObdzsgOokQI1b0tDlxhIQ0pPM7Kc=
X-Google-Smtp-Source: AGHT+IEAnX69C0JaBoeM6LjPaRTB3uHJy92DHZOgP7sO1kiWgjb38vxUbjHLsVOmFfavTIppKGaskw==
X-Received: by 2002:a6b:ea07:0:b0:792:9333:2cbf with SMTP id
 m7-20020a6bea07000000b0079293332cbfmr129923ioc.6.1694102315460; 
 Thu, 07 Sep 2023 08:58:35 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a02b881000000b004317dfe68e7sm5498839jam.153.2023.09.07.08.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:58:35 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 6/9] x86: broadwell: Avoid initing the CPU twice
Date: Thu,  7 Sep 2023 09:58:18 -0600
Message-ID: <20230907155825.48056-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155825.48056-1-sjg@chromium.org>
References: <20230907155825.48056-1-sjg@chromium.org>
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

When TPL has already set up the CPU, don't do it again. This existing
code actually has this backwards, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 arch/x86/cpu/broadwell/cpu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/cpu/broadwell/cpu.c b/arch/x86/cpu/broadwell/cpu.c
index 560b1f7893f6..cbd4a3b67973 100644
--- a/arch/x86/cpu/broadwell/cpu.c
+++ b/arch/x86/cpu/broadwell/cpu.c
@@ -11,6 +11,7 @@
 #include <event.h>
 #include <init.h>
 #include <log.h>
+#include <spl.h>
 #include <asm/cpu.h>
 #include <asm/cpu_x86.h>
 #include <asm/cpu_common.h>
@@ -67,12 +68,11 @@ int arch_cpu_init(void)
 {
 	post_code(POST_CPU_INIT);
 
-#ifdef CONFIG_TPL
 	/* Do a mini-init if TPL has already done the full init */
-	return x86_cpu_reinit_f();
-#else
-	return x86_cpu_init_f();
-#endif
+	if (IS_ENABLED(CONFIG_TPL) && spl_phase() != PHASE_TPL)
+		return x86_cpu_reinit_f();
+	else
+		return x86_cpu_init_f();
 }
 
 int checkcpu(void)
-- 
2.42.0.283.g2d96d420d3-goog

