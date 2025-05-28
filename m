Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDB9C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 12:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76CB683ABF;
	Wed, 28 May 2025 14:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G95K+c5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7E1C83AAB; Wed, 28 May 2025 14:34:07 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F22A68397A
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 14:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-85b38fb692fso81556139f.2
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 05:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748435642; x=1749040442; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3D1JCy/juyHWYjCK9W4k5k4G33D5QNBccasuh3gDOs=;
 b=G95K+c5IyvvGcW4mfLGxxATZQeSauadDAuXFYKyBIIeZ5gKIFCSw1blQXBGSGZV+/0
 TfOqSROxsqVyBORO2oZWMCwF8ci36U7ycGr2CWlhjsI9466jIIYU3amjGYqI+BJ51xWf
 ofSOP+zuoF46nuj6Ep8KuEJeuVr7Ob+RnH6Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748435642; x=1749040442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3D1JCy/juyHWYjCK9W4k5k4G33D5QNBccasuh3gDOs=;
 b=b8GPAfeOgJA7x7ghl4hKlPZeLGs24uYAw4RgZNwnDxcGOaX5oDNz/8xxpelbH2Oo/Z
 E37XRVdH+WvNGEitP3pXkmTSxZFxaUkz1Ji3YENAOq9ox5gD0eh88i2EaFZIuWn9nnAq
 nEUBZCKz6g2CFSKYRNYaJb9YeNDZWr7BpPLsQenYkrkfy+ivwaMGbXGa3lxqcNTvVdYb
 2M5+VKJJkUgszOFIJ/0mdtqPUeBV8NwCIjwQuogJ6ZgmyiJl6vX0tzoR7w6qsqBDphAf
 UqkSFP9vdE7gpnrBqUUo/OnfQTatR9Wjhs2eX6kbFXTRiD0KbWK2UpqK1cRyL+KIuEG2
 GCAw==
X-Gm-Message-State: AOJu0Yw91pfNcpYC/R+CNv49BY8tnubgl+BS+dXLiTtMQBcjiM0M/cZu
 DNZV1fnIdemdVg7dJ4ijmOMpYCKnAqAZtln4n7VAL3P621ozTmfsiv9b0nCUl+B8sPkzKP+fzPo
 GEYzu6D6P
X-Gm-Gg: ASbGncstSmMvUSplyfcJeoLj+z0DqrR9pTlZtWweUSzU38mCRndJJue90A2p+JbFMJ7
 fTG9OXdeWFlv7edVeI/0sAZdWM7KkHcOGq+vzVha5LobWecObTCVUwv5AcaAizlaYgYq7aG2oXa
 FIsdXpD4H7Am2Au+pSKj83PIkq/XJyIS2EhGjbS/IskjelhIeLyEyQHo1TkE1OOij6YbtNmCjog
 bQb7zsLCJnxO1ocKVDlHy5glnMmmZEyxQaNO4AGKKfEXTh5ps4SFkYRatuN4TG+TDz1XSQU0Glz
 VN8d/nEIw8rzr2p0UaX1wpNqdJURIwsAbfjfk/tdGu1gJFa5ZuaCZPl7VpGMvYKPE0/Kt63iXzU
 7xv4IL5ST45lYUyemEz/mL3c=
X-Google-Smtp-Source: AGHT+IFcsbiLsBImrk/seioSTpE2pRqTb3UYn/2QxjyLBB7rCNwfrNhmFTUCjq8APvwzMImplReHmg==
X-Received: by 2002:a05:6e02:1488:b0:3dc:8746:962b with SMTP id
 e9e14a558f8ab-3dc9b6e58d3mr163632895ab.15.1748435641951; 
 Wed, 28 May 2025 05:34:01 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4fdbd4bb408sm205972173.58.2025.05.28.05.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 05:34:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: =?UTF-8?q?Fran=C3=A7ois=20Ozog?= <francois.ozog@linaro.org>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Phelps <andrew.phelps@canonical.com>,
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>
Subject: [PATCH v5 23/25] passage: Add docs for spl_handoff
Date: Wed, 28 May 2025 06:32:25 -0600
Message-ID: <20250528123236.1138632-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528123236.1138632-1-sjg@chromium.org>
References: <20250528123236.1138632-1-sjg@chromium.org>
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

