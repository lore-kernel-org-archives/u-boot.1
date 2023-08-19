Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3379BEE49A5
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:24:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 784EB86FFB;
	Sat, 19 Aug 2023 23:23:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JpRWdzYd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E82C86C58; Sat, 19 Aug 2023 23:23:25 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B809386C1E
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79216d8e2cfso36524139f.1
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480201; x=1693085001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fUBrkeyUqQKaQBK2KVE23VRuLQ3O0qrjQ+PCDkt7r4=;
 b=JpRWdzYdtVKxBlkkWbP8mjns85kqdQYDM4HrEfKDobEhU8n+B2V+u9RGWMtiOPM9jx
 p8V23lYoLSmYZl3byd8bi3JkhQ1NtFrEvIrl0T3a9neV+Jm7VK6651NGXvk15FRHRFuF
 y63B08PQqWyRSMKU2PzHIAWC6VRDWzYppZcCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480201; x=1693085001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fUBrkeyUqQKaQBK2KVE23VRuLQ3O0qrjQ+PCDkt7r4=;
 b=Sm/1ggK3Yu6BcLeEznljGHn6yr7zcd0+f8tbTwkBakpcdcIsQowSrk7x0osZagG7EB
 DlRMQyeFXimK6jEY3Z0gCn1xrSBWWbmse6PPoJjK3R2ZdlOC13cvCCNaL5PyuGDKysYo
 w6xUh3I3U1gOw2xhNo3sNo51edGLuwzADP0HKO5zClcTlckR0cSO7VwCNedx5DUMYorO
 66pz6y4Vf7PVmud1o8RiAnjQAKL/Go7SXzWSr+QGXGR8vf6gDLIgo9P5k6EqFUJVzXeF
 zJlu5WNUulXA/9/nJWHymrRWR16C8o2wqdi+lXgiFBFvrDcQYlNFu61Og7H7xGen/dwq
 V4OQ==
X-Gm-Message-State: AOJu0YyRuNndKuzhhs8Pf+F5e0h6q6zfZLdvDMIPDeKgtK1UqiDqGtwy
 QorfWaxargw+ROF0Y8nP1XlgweYA5fDYAkq7xwY=
X-Google-Smtp-Source: AGHT+IE6yrdjd52LzoXj+XR7GoGCZX0ZI3RCIsdsgvo9evOeI1QzdQ0j+mwXcMpLtsgJi0zat8sdgA==
X-Received: by 2002:a5d:8d05:0:b0:791:7e14:4347 with SMTP id
 p5-20020a5d8d05000000b007917e144347mr3550940ioj.13.1692480201416; 
 Sat, 19 Aug 2023 14:23:21 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 04/19] x86: Set the CPU vendor in SPL
Date: Sat, 19 Aug 2023 15:22:42 -0600
Message-ID: <20230819212309.1094440-5-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

(no changes since v1)

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
2.42.0.rc1.204.g551eb34607-goog

