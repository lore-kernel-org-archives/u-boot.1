Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29369C54EE3
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 12:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A3488A76;
	Wed, 28 Aug 2024 14:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QTFz+oj0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A051388829; Wed, 28 Aug 2024 14:10:44 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA25588847
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 14:10:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-371a13c7c80so354622f8f.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 05:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724847042; x=1725451842; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6H6IWdSN+rg+rHMHDRzq1nSIiOPpJHDMNLUt1yZPnk=;
 b=QTFz+oj0uB/nz9NgA3qF5EbQ7RqAaDr1uhJRuzzMhlc2/J+5L/m3i0Z4eFXdgPo089
 ssnu+qZgNY05ZPQJrk8J+WyZGy/Bn5R05W7L69guDgjliq9LJf0t4oZP+7FKaC3HUbyq
 ovdQYWhVJHE43iD5EtVq9eh0HBoCQozwxRq6eXPNM9yXMdXTmo6Katru/v/SFnwL5hbT
 kJxlhDF7ef5S+SAZd5xxmg6yXjOCYtBurtfKbALroHcFzP4IxjSNlIu39jKFqUh7djLM
 9emfsyAOwQ+ZRso4UwbD5HxdWZ3VZR3edGeIQ0hCm1GNnRVbwqVJg5O7TJeMrFD4evEP
 p4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724847042; x=1725451842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6H6IWdSN+rg+rHMHDRzq1nSIiOPpJHDMNLUt1yZPnk=;
 b=SeCRC8yfm4ISZi4FdWAtd6ui7rcyGR6V6aOyNMM9STA2fbHqM6e3dhd/b/h17S8ID/
 Xb2YCItJF9IE1lATQR4gP4sRRZ0S51uo+zjmcZILidY+X34MI0JbHzmp9TR96J5LxOTb
 TA6badKRFfVNc3//UVI5CyubX4/ObGJ9kj2B+iLd+Q6vTz/XHnlSCUEWRyVK5HMecwBs
 u8wbTBo2P3RftjzuXTVEWWxqylWiHGxr2G/QhOWhXkicGrGCPihhq74z1bGiLbpew3PF
 FqJtvDYyU3HLZKMKquORvvjXY3NSZh1EE1Z7dlhp6QF5oaicOp/ble9QN3dZinSMoxkt
 nIkA==
X-Gm-Message-State: AOJu0YzN5d1XD3QBIgNMy6o4HKooLJhf3Mfc50T1VPUAC4HSaRyVTZtd
 dvzzTCVzvXulj0pJskxyNBWznGAUO7w3ZP4YhUheAb91FXxdnnAjlOsiw9IL6vLn8FgjNX/offY
 FSmBTtg==
X-Google-Smtp-Source: AGHT+IGY/zKMx/wEBju39EI8qZtWare2EY0qgeIJkmVmBs3pdOSRlLaeDh6EPjp+bmJAomED7vCrXg==
X-Received: by 2002:a05:6000:1142:b0:366:dee6:a9ea with SMTP id
 ffacd0b85a97d-37495f74970mr1115246f8f.26.1724847041858; 
 Wed, 28 Aug 2024 05:10:41 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:8ac3:aada:f033:985a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba639687csm19470365e9.8.2024.08.28.05.10.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 05:10:41 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
Subject: [PATCH 01/13] Makefile: detect HOST_ARCH properly when CROSS_COMPILE
 is multi-word
Date: Wed, 28 Aug 2024 14:10:24 +0200
Message-Id: <7de6a75453d11fa56ae81f3ad3d0f16f0d12546e.1724846454.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724846454.git.jerome.forissier@linaro.org>
References: <cover.1724846454.git.jerome.forissier@linaro.org>
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

