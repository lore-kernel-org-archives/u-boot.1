Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDACC369D9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 01:06:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E96481E0F;
	Thu,  1 May 2025 03:05:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N0RLKLgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE0C78210F; Thu,  1 May 2025 03:05:41 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98FC381F0B
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 03:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d817bc6eb0so1542355ab.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 18:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746061537; x=1746666337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xh4BQaw4hiM5eyiyFlJIRm/+7zsM/t+zQMCHYIOtZ2s=;
 b=N0RLKLgI+le7YecLbfUGUcBttPpzUSm49WXrPEdOFP5Us14hrwgX8CnHSPNKiY7pFG
 qRYbI53du2d+aZcqQaXRerjwHSAJCc/g74Pux+lxPzs9d9V2AVTDxT+A5dNA7VpYcWTt
 4y0RPi0iuPqqmQ8ubete2KioOQ8DHJTC5o0iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746061537; x=1746666337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xh4BQaw4hiM5eyiyFlJIRm/+7zsM/t+zQMCHYIOtZ2s=;
 b=o5nMjfGwMz6bqK0x6ybof/rvHfnEVdYpuZDOqNI5TAwaQgLshrCIdaXCoFpY81NW6L
 1Q9sBWfgSDv29Oc/CBKoN2257a7906GfAEEWx3RsnKjucgRhP9sNd6VciznZa5vF8UUO
 WyiR+oXGgdTMeP6t3OAnqOq45LM39C7abhDkEP3Xxq+fbtZW+Amk9r4Z298lYc5jQ7L3
 R7A6uW/AVzcFwVmUBO/HwdTf5TlppP2RG/pM/xHU08EQnaSZTbfiMuHJTc0l7nPmMnjT
 DoA1bhl5oP1D8QYCMS5a7oQQD2rw55B42267E5VLbY3aOqU7GEuZlqsHuEuAtnopgUol
 h4dA==
X-Gm-Message-State: AOJu0Yx+353gk/KLeuh2/akTrkRo43AKg+uWlYyCSF19zm8B3WWAFgDA
 bdOMHEgLeK6akYw/DHDK/DTFPhGVBDJ86HvE6E4LeeSqaW428vSa12zyE2AtfaRxC3RaKqtP4dA
 =
X-Gm-Gg: ASbGncuKygiXCVBPz5wHnwDuhGptcMCF6GlxZa+mIJ0Pof8cnP2cmRF0W2fpnKRX8D9
 WdNtO9qPf4r4+66Mr211+9DhzoLZhV4mAekgU/wSq0TYbJ5NZNsAiQdJvDOMsu0FzLhEX6RtsWh
 QOVGumrGVzq+iOfkhpdgJS1AOO0heX4SedmvUsn1p4tuedaUoM5pLOJ0jjxW9uVItACIxlWU9c8
 QJVJBRoBm/kZm4ZPv/CLf2YlKDunmbclIfloLUq4KmX5cjZ7BCJRt1IGQWoI7wDUSsjBT7CJqtM
 Cjf8VE8Z6hwdTl4UIPFhv1uqxzI1FyiZ+M+0uhCnZefbnX+2ioTyVY7FkC/qAdp65GDzMrHH0LB
 k1w==
X-Google-Smtp-Source: AGHT+IECyid3rNH/qOaOpzC80Acbe0k86mraEVwW3jSPU1lpc0chIyWq16XjH0wyE/lkHtQgfx2/sw==
X-Received: by 2002:a05:6e02:1c0b:b0:3d4:337f:121c with SMTP id
 e9e14a558f8ab-3d96f1b2017mr14408675ab.10.1746061537448; 
 Wed, 30 Apr 2025 18:05:37 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d95f480a99sm10771855ab.68.2025.04.30.18.05.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 18:05:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v2 08/22] toradex: Include env.h to permit reading the
 environment
Date: Wed, 30 Apr 2025 19:04:33 -0600
Message-ID: <20250501010456.3930701-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501010456.3930701-1-sjg@chromium.org>
References: <20250501010456.3930701-1-sjg@chromium.org>
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

Two files read from the environment but don't not include the correct
header. Update them.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 board/toradex/colibri_imx7/colibri_imx7.c   | 1 +
 board/toradex/verdin-imx8mm/verdin-imx8mm.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 7de29e3abfb..69a8a18d3a7 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -4,6 +4,7 @@
  */
 
 #include <cpu_func.h>
+#include <env.h>
 #include <init.h>
 #include <net.h>
 #include <asm/arch/clock.h>
diff --git a/board/toradex/verdin-imx8mm/verdin-imx8mm.c b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
index 9359e0ac6bf..066e8db678f 100644
--- a/board/toradex/verdin-imx8mm/verdin-imx8mm.c
+++ b/board/toradex/verdin-imx8mm/verdin-imx8mm.c
@@ -3,7 +3,7 @@
  * Copyright 2020-2021 Toradex
  */
 
-#include <config.h>
+#include <env.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
-- 
2.43.0

