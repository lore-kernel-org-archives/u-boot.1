Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84184C369C9
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 18:19:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D961083190;
	Thu, 17 Apr 2025 20:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MeNyTamY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87768318F; Thu, 17 Apr 2025 20:17:24 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE26830DF
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 20:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3cf82bd380bso8580485ab.0
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744913840; x=1745518640; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3D1JCy/juyHWYjCK9W4k5k4G33D5QNBccasuh3gDOs=;
 b=MeNyTamYCD8y8jnpoXAsZao5jRo6fuWe7w6QnGgFCqS4aoG6kAcaoaQCXZ8K6WLNdq
 YOGgozZYexdZGm/WpwQ84tmkmkzTP9ZtJxf2UTL57TrP2vv4RETTKXuD5kwQsNkYMayf
 tsypcsVOvJiEQIS+QV9KC0T/TAf48tqASj0wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744913840; x=1745518640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3D1JCy/juyHWYjCK9W4k5k4G33D5QNBccasuh3gDOs=;
 b=VvCSFdlcm/Jl28MNqm6FWDn9zFhxNV5sKK3Es0nSFZlK07PlbnBT4wp4JU9AxajX1x
 CavaJFb6w1ltQL7c2xdulwQAEMbbTP/wPl8GWpGwqBIs3BI9lmuSkuCNplPhHmJ8/0Sx
 w4U9v7xjnUayc5QtmHhmT9mkSfigG2pqfxS65zrwDYIX4O2rnPheK2Yczw7sjOuNKrt1
 XxN1M4KdApjq6Lg40DiUKFnz2B3iCdiwtRx6LZ5O8yu0v5y1zEwpU6WWvqelCLEsf6WM
 RYSCZ7C3YDAm7YrrBXqRP4l/fkFzgZW/7M8sP/kcTxabuQUKMnwNrBvJ6JPgJ+HHbiLH
 /xXA==
X-Gm-Message-State: AOJu0Yx6GoniEGPdXWZEJvFqZ4SrDW0yvi7IewgzzQR9vjEBNS+YI1Nh
 iSC51SQNfRmf3uQyL+E2M1FLTdqSo/atLZ+LoU0AoBCu/qDrUbgVBuiTCxCjRnY8BxbyTuLTZU0
 =
X-Gm-Gg: ASbGnctULDsSsfKQhUXIGP0R9IflYir4NFv+XZqXTGvGA7V02H10frnf7aDwwSfiM4r
 +l/wVzXCzdenTkHzqFXa3JXp1fsPvUJpUTuVUknKqn8xfhubwHSnWONLwW2L2BC0VDwOAEVNCoV
 NtIUA9ReZGZ0rGaiEFEq2w+xYMObFtI3hSsH5pprjXmdMBHXKvWI/CUrrZ2t4zXm7PKonN3wn/W
 6AGO+vzAJ79HC58cxqKfmpwbXr78p9dZx5BcrFHWZ+fXNjKLY+AoTIoXDiADkDO4KSQpd6oaYlJ
 SXDsstAHgS5L5BxNOoxVVAnH2N4KGPK+t8S4hkKAkrzIYXcmlHIvGALybMAwO64jKPW1C4BYQP7
 Hpg==
X-Google-Smtp-Source: AGHT+IHC+dA3Bu7t14fVC6QtfF0Aqe47JESYJ348q4N8TwplNJY5o8v5Tt1VOikyAsZXBLfowE6akA==
X-Received: by 2002:a05:6e02:1aa8:b0:3d4:6e2f:b493 with SMTP id
 e9e14a558f8ab-3d88edc2f12mr1045205ab.11.1744913840629; 
 Thu, 17 Apr 2025 11:17:20 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a37cb9aesm66673173.28.2025.04.17.11.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 11:17:19 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Peter Maydell <peter.maydell@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v3 20/22] passage: Add docs for spl_handoff
Date: Thu, 17 Apr 2025 12:16:02 -0600
Message-ID: <20250417181613.1355024-14-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417181613.1355024-1-sjg@chromium.org>
References: <20250417181613.1355024-1-sjg@chromium.org>
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

