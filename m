Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADE8C3ABC9
	for <u-boot@archiver.kernel.org>; Sat, 10 May 2025 13:46:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC3E82AE2;
	Sat, 10 May 2025 15:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EbAzz8eX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4764C82BAA; Sat, 10 May 2025 15:44:34 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6674482A65
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 15:44:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5faaddb09feso5746294a12.2
 for <u-boot@lists.denx.de>; Sat, 10 May 2025 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746884671; x=1747489471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3D1JCy/juyHWYjCK9W4k5k4G33D5QNBccasuh3gDOs=;
 b=EbAzz8eXH9nZI4DMdvCEtCq00E9Htp3E9X+JocPwter+MRHegIks0iVsJTtkv7GtAX
 Umshza3r1CCQnKEVCPULo4XhPf4F0BpXdVOTK2+txptZU74VqCZNtpLEXEvEa4dXNEDX
 VyDr+vUglVH69TSzumJ++45jkipNQ7WiFZLNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746884671; x=1747489471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3D1JCy/juyHWYjCK9W4k5k4G33D5QNBccasuh3gDOs=;
 b=qfHNdF08z/X5SEHXPdeGKzzSKMzfGMnAenxyGk/whrf+ySnYZrx3RIHHRPqdStFqGf
 nzdPcrHPRb+R88Mi8LfyzMLNLoKQux5NVy78243fH5yxc3mcPgaZn+5SbJvlAAaVpeeP
 F8jeq/r/I07D2LPpC65HB5WqQJggGbJ4x554Q9HviZpGUsfsfXxRXa6Rsf13HccnsDSy
 8MeXYzXbyrpKAwlvpUzlPMgvA9DZ4DWh5LG/P8kQZ0yskaadrIz+dkqMFQS/+q3Sp2Zf
 GJyimuQAVO3R2+VCKyC9sl1fKgK8FuUeEP2VT2NDOGioTenN39UGTkjQmVToOAbVV5RK
 7iVg==
X-Gm-Message-State: AOJu0YwK9NFRCNGtlSddHb4bKyfca+6nyRs/IoDeabGsDG2EBoXFgFmP
 6HYrRPbSwf4mJp0tP2qFB+3ikrWLDvjDrKGOJt4xbx5KRs+7SU3uSicU7WscxbZvXCNUMC4TPSE
 V29GNlIy8VQ==
X-Gm-Gg: ASbGncuIQ+QIrK1MlFG8utc50AxSHbv0Qdwuiza1GSK7rlM9ru7iG3210mm79AjxuOY
 HCfm73dwwuf9S3OK0iXCdl6E860cCH8PYt8A3WbKjueuW8D3ZYMHuCTU9fCs0DT3lN9048iNGdL
 9jaGl1iu83wo7nrQI5QSmvYkFtnOIubdRLISaBi8APjz+l8tYcKUiT4DCFdvZgfMxvBawCJfhRU
 vfo1+up7zFkMf1FBwdpITy+rwyYCTiYEEkwr9HkrGR0Z6tDhZf3X1sHt1/J6WVJ7k7/ud0HOsOE
 0qABcE+BuMPvrfhCg416zB6MSQ4tbqFH6WxaWVwNjVl6ifn+aZ2XtoU7Kz2HEwayhwEpkvtfB/G
 aiJc=
X-Google-Smtp-Source: AGHT+IHf5lwNwWGlEwXbPLtEVOsjD2ajdm8r98u8QJ6P0JXt/o9xkBGMytOO9KdEFpdMbUFmx3FKew==
X-Received: by 2002:a17:907:9810:b0:ad2:4144:2329 with SMTP id
 a640c23a62f3a-ad2414424e5mr98393566b.7.1746884660593; 
 Sat, 10 May 2025 06:44:20 -0700 (PDT)
Received: from chromium.org (82-132-222-17.dab.02.net. [82.132.222.17])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad219747028sm319763866b.106.2025.05.10.06.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 May 2025 06:44:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v4 20/22] passage: Add docs for spl_handoff
Date: Sat, 10 May 2025 15:42:18 +0200
Message-ID: <20250510134253.1581164-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250510134253.1581164-1-sjg@chromium.org>
References: <20250510134253.1581164-1-sjg@chromium.org>
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

This tag already exists in U-Boot. Add documentation, following the
format set out.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/sandbox/stdpass_check.c | 15 ++++++++-------
 include/handoff.h             | 10 +++++++---
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/board/sandbox/stdpass_check.c b/board/sandbox/stdpass_check.c
index 2244a90c3ba..d04f41137c1 100644
--- a/board/sandbox/stdpass_check.c
+++ b/board/sandbox/stdpass_check.c
@@ -6,13 +6,6 @@
  * Copyright 2021 Google LLC
  */
 
-/* BLOBLISTT_U_BOOT_SPL_HANDOFF */
-#include <handoff.h>
-void check_spl_handoff(void)
-{
-	__maybe_unused struct spl_handoff check;
-};
-
 /*
  * See also doc/develop/std_passage.rst
  *
@@ -33,3 +26,11 @@ void check_struct_name(void)
 {
 	/* __maybe_unused struct struct_name check; */
 }
+
+/* BLOBLISTT_U_BOOT_SPL_HANDOFF */
+#include <handoff.h>
+void check_spl_handoff(void)
+{
+	__maybe_unused struct spl_handoff check;
+};
+
diff --git a/include/handoff.h b/include/handoff.h
index c0ae7b19a75..c7e6e4746bf 100644
--- a/include/handoff.h
+++ b/include/handoff.h
@@ -8,18 +8,24 @@
 #ifndef __HANDOFF_H
 #define __HANDOFF_H
 
+#include <linux/types.h>
+
 #if CONFIG_IS_ENABLED(HANDOFF)
 
-#include <linux/types.h>
 #include <asm/handoff.h>
+#endif
 
 /**
  * struct spl_handoff - information passed from SPL to U-Boot proper
  *
+ * bloblist_tag: BLOBLISTT_U_BOOT_SPL_HANDOFF
+ *
  * @ram_size: Value to use for gd->ram_size
  */
 struct spl_handoff {
+#if CONFIG_IS_ENABLED(HANDOFF)
 	struct arch_spl_handoff arch;
+#endif
 	u64 ram_size;
 	struct {
 		u64 start;
@@ -44,5 +50,3 @@ void handoff_load_dram_banks(struct spl_handoff *ho);
 int handoff_arch_save(struct spl_handoff *ho);
 
 #endif
-
-#endif
-- 
2.43.0

