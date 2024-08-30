Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00725CA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:17:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3921F8897B;
	Fri, 30 Aug 2024 12:17:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aMhzyAwn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CFE8817C; Fri, 30 Aug 2024 12:17:24 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 812B988744
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-371a92d8c90so961236f8f.3
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013042; x=1725617842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S0RBhVoNaek3QAHuKn+tz7pK4sQBIpxCfm7RmAzgMQ8=;
 b=aMhzyAwnvmFH2/aanplGhMTeSxuP+JiNbyk6VY2I9XWSRC23nZSmRrYVDC2oc/z4Cg
 O75hoNh8uszWx+hzLsg1XP+WCSYrwiB4xnhZEcfAlaEofSGm4w9QpZQWCglcsRafmEx2
 9yUFJwXMeczR+GzqO5zrOZeE8AphkIpSf002mOX1eBd/Ld0YtkoVePcu7bdbBfE46riG
 gJwl4NZrCy2OLxK8alwk1veOidOYgctXaHJf4WGEZUBwCcUNmyLJ7+0tsiW2onsp6QZI
 M8znomz/E6uAPaXD2J7HcshAxI4tb/0W8a7apG7dKkwZz62F+PaisgP2BwBl9hXjOyzq
 EyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013042; x=1725617842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S0RBhVoNaek3QAHuKn+tz7pK4sQBIpxCfm7RmAzgMQ8=;
 b=pf4+8w2f9hiJSjEE75w2hV4G1WVJhuKJuBTKxx5P2GMdlJWm/Y7k73YONxO9GPGDp+
 cu6l0j9rLurJVLWuocHSsaDwdRcv4h6FOQ6mMPQPfKmE1X/hLSXioAxI3Vt4wxNsJdOR
 ZkkNoUPfITvbiXRFCVQw8W9Jqagil5CZ7kEkjrnTlpIzM4960QJTGN5l+DWCwNFndjaC
 EuqIHOKoWiz6yPt3nc6bJN+Wx293V5OLREPuqC0gg450TIFXO4c1nDt+Sni85Q+CuSko
 h7VG3uP55I+ILx3l28Z+LM0kU4nLx2jPRuf0aWx+NkKjU0VcFqVLv8yFSVCMESDFLPYh
 JdaQ==
X-Gm-Message-State: AOJu0YwfBL6OkTur13QJjPXxc4/cxkH71GbaQNI8JHCT7Nx0JlJJdUPz
 dCn8N3yzz3U1UcPNsmeg7vGsTowhJs2QS6i/ZtTc38AI5wHQVURY/St1pxNRDEXQ0G3WyYRnI3Y
 wAk3Ylw==
X-Google-Smtp-Source: AGHT+IGEmN/P6yUVcC/QU3B5YUBQSanMwfgKlSm2xQdUR7wlYe/mIIFSbuBb+dbv2zLLMx7NEl/Ixg==
X-Received: by 2002:a5d:6605:0:b0:374:959a:780a with SMTP id
 ffacd0b85a97d-374a9677377mr969434f8f.57.1725013041684; 
 Fri, 30 Aug 2024 03:17:21 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:21 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Andrew Davis <afd@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
Subject: [PATCH v2 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
Date: Fri, 30 Aug 2024 12:16:44 +0200
Message-Id: <e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f90e48f58a..dc7bdd7942 100644
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

