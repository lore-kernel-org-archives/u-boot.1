Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA50CD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:39:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B07788C6F;
	Tue,  3 Sep 2024 10:38:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ed9qz9m6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 734C888C1C; Tue,  3 Sep 2024 10:38:49 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8527F88C19
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:38:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42c7a384b18so22266475e9.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352726; x=1725957526; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fE83AK41qas/C5KrJhvshI8YbnBfo8bqWhSX5ugB1gI=;
 b=ed9qz9m6wMpHbuQBntma/v/UdMMrKzeBqJkfdGrDZXMd1+/U4jRKmCVDDGhN3m9GIJ
 S+28+rKG4dx4RoVBlLRuPGrmI+ZWi2s8tW1Fsg6F3LYIwjRzaP70P+/C/IXBiDq7L9pd
 OzRvTc4LvAJ00dsjH9CQNims81/VuRJJsZ0U3q6Q12FfvPzrG6IpS3Q9PI2UJqGYJraz
 3OyAixYMBH/MuHboWZwq3vbIjV8Lg4XzEb8SbsUdLUwG1eefIxq4Us68DQk3Af0URRUw
 vElxIM1XIDBiDK1BvKx0Xl3L7ATR7NEtqOEDqBnEvqRNoNiYc8+1ggbdfS0boj1ZDw4T
 4Qrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352726; x=1725957526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fE83AK41qas/C5KrJhvshI8YbnBfo8bqWhSX5ugB1gI=;
 b=vyl1BdHuwiQUVae3DPykjN243c7Tycwa8kGyFgyETa/UcKM69IFTqnTjiWv3JX0Q0R
 3fpPqQRBCB97GaLo4blXcs4HWLK1+J4t5WSb9EjpgQG7XpvDdihEVJhzmuRYo7AW19nB
 nqdlkRmBSCs2+pqA6ra6Xl79Hf9mxD1bCNbkSCbYBO4Nmt2Ed2a586TAMC87MkR0dIYv
 I6PBH6IW3KLBmUluj4E9qlJbf0Ec0v94YjGouizjp51fR6nD1qkD9MzuU5yLXaiaBdYL
 not31oXBVojU+j1jTaHxNtCCMw4QZShKPTyZ88LrAx4FjGkKqfKOMdICrnE3f1kXUu1l
 HEPw==
X-Gm-Message-State: AOJu0Ywgd7K7fe1poX2MJBFXp/Htnww328Jw9tf/ma9pc8Q/Z5Mbjw75
 gulqPIOnrLF8oPDZamtWbaRtUOCsX5rrRp9me0ncIBgNwNGICWBySyvjmB32UDA7vpytfJh451C
 wdOzQUg==
X-Google-Smtp-Source: AGHT+IGxB+8Z0Ri6D7cW/r9bhHWGGR352CW58zpPaQv/mKZViMHcCMO0XtYzI0OtGKNNsGTwN7sxPQ==
X-Received: by 2002:a05:600c:1c1a:b0:426:593c:935f with SMTP id
 5b1f17b1804b1-42bd731ee1bmr59489005e9.1.1725352726366; 
 Tue, 03 Sep 2024 01:38:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:38:45 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
Subject: [PATCH v3 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
Date: Tue,  3 Sep 2024 10:37:58 +0200
Message-Id: <a5617c0cb57624d004c4b4f42861822016edb2e9.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
detected and the sandbox build fail. It typically happens when using
ccache. For example:

 $ make sandbox_defconfig
 $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
        CC="ccache x86_64-linux-gnu-gcc"
 [...]
 In file included from boot/bootmeth_efi.c:16:
 include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
    33 | #error Unsupported UEFI architecture
       |  ^~~~~

A similar error occurs when the build is done via buildman and
~/.buildman contains:

  [toolchain-wrapper]
  wrapper = ccache

Fix the issue by considering only the last word in $(CROSS_COMPILE).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f90e48f58a5..dc7bdd79420 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ include include/host_arch.h
 ifeq ("", "$(CROSS_COMPILE)")
   MK_ARCH="${shell uname -m}"
 else
-  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
+  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
 endif
 unexport HOST_ARCH
 ifeq ("x86_64", $(MK_ARCH))
-- 
2.40.1

