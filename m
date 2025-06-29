Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9608C7EE30
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 19:55:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62DF82F46;
	Sun, 29 Jun 2025 21:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JxwFMez1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D1F82F33; Sun, 29 Jun 2025 21:55:01 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ED6782EA9
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 21:54:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so1286381f8f.3
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751226898; x=1751831698; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aOXNodHoG1FmWo7t66ZaQyZtVykwluwuMStVN23FtI4=;
 b=JxwFMez1Y031cFi11q3Pkr4xgK9t65u1yaw3EZ+Zo717yIc2S0RLk+/aXw+Nxnuo75
 in2i5lCG0JuWDfAUzPDXCZ4GaQ+HQGl4fk2UJfjECNfsu5W9vfz1w4Zg5j6HBgcNo2by
 ZaEr58EV89n8NsFBtN7v2Qn1OQK6Lw528bmnJSNgAY/HL7FgNwGMhQ11jUXO6pHHZmSa
 DAWAFTTZJKIc47F3Fcujiyjsflee0JT9Vt2ZCRV3h1O0rdQGnGS0OShauW7sGRBTuF2P
 MfPczGU9d28HeihgGgynv0yvi1QZeCeSWo12sgM798KCOkhXRzyC8E3oSPnwKOvldP1J
 jCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751226898; x=1751831698;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aOXNodHoG1FmWo7t66ZaQyZtVykwluwuMStVN23FtI4=;
 b=xVm72kkD0PkhqOz5tB1b5gMj8uhPgmsGdSnU6f9aNaesr8WEsrfuwuBEG13z3NjMLN
 LGhqOGheKyPwwdtliXcP5MiKou6+AocoP0tFkUesnHRbhTI97xY2cpsHGtXhF1/G56RJ
 +IMKkmgcG91rsJH1n8ZzFYr0tLjs02VayXe5/NBpBgRKAoDsTgFcOxmS1zUbNCfdDFUs
 7fNid1eEJFcaNpe0Kn04IGczuO5tgiYxEzAbLvshhrl4RKZ8lvOnmX9PzS3zQG1vduHk
 Wg2rp34FqwHokUat6qOYcjKTT6qQzONZHhnswDwjAuJGlHXPiPUzEUkmHdQsqIFlJIKT
 WzBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpSiUUBJAhpfqqhiaRwP4+ap9u/xHjekCKPsRbBRIxrcaXZ+AIotAOmYTxV1omlO51ZX7OeOg=@lists.denx.de
X-Gm-Message-State: AOJu0YzajGqtSsm1pqOBMg19F+/1+IcRK4p79H+A6PqxdQy8iuvvJOoz
 4QTxL4/74rphwITlSS+DL5XpCVhj5cR/r42kdXHcCMLT8/ZZljmwSLbkw13laQ==
X-Gm-Gg: ASbGncvCdm0W2bOEkE0JVa0WAyZFMDMpxSMIGEFbd10IXFrsrOgpzaN5CdlfnyyVUGw
 RT1ojEfJD+3t+y97fKnslC5u+UgiMd+Pjh2KvLGXcz4iC/xYPSEgzx0q9ww1qxaxN0lmAUG0jXl
 zOVkC/vekAwW/Dp3W4K2lhD4Lrb1/9G/RVBYSkYVUR7d4z0SwHa45Iy1Ax6tr14qm7vhg2SXx7N
 xuxCWFoVPLHWo6Ez45V46l6nDgAyWARnU52RW1R4pgE5mDRN87v3EPmupQyEyoRJ6GNLYLrIQWt
 3MzDbxaNa82OhiNi9xU+q8V7a8OuAAW89P1WUXofO2cdWTOsWeaCaopq68nHAJQ2uPA/M+kJnd2
 jr/R+dhaOKRZ+doSRz+7rMqj2oVk+HNLD6mMN9UYJO7WAejn5hnLKEi80zrtVAe3+a+W+1OEnin
 4FgHTfYW3RQQs249KfxNor
X-Google-Smtp-Source: AGHT+IFF6G0gHwF8uAeBLwCXv7fEsjAzi/nj9VmMcyFpltjjyAdZB8Htb67KQFjmvYIWemEdPUod9Q==
X-Received: by 2002:a5d:5050:0:b0:3a6:d2ae:830 with SMTP id
 ffacd0b85a97d-3a9001a14a8mr7767590f8f.56.1751226898325; 
 Sun, 29 Jun 2025 12:54:58 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fab6esm8672408f8f.31.2025.06.29.12.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 12:54:57 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Derald D. Woods" <woods.technical@gmail.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 1/3] omap3: evm: Drop old musb omap3 driver
Date: Sun, 29 Jun 2025 20:54:46 +0100
Message-ID: <20250629195455.53083-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.50.0
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

The USB_OMAP3 driver was (re)added in commit e74e9f620a6 as part
of migrating to DM_USB but the config already had MUSB_OMAP2PLUS
which is the newer musb driver and what other omap3 devices use.
So drop it so we can drop the old driver.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 configs/omap3_evm_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/omap3_evm_defconfig b/configs/omap3_evm_defconfig
index 42c6aadea97..25c2fe532c2 100644
--- a/configs/omap3_evm_defconfig
+++ b/configs/omap3_evm_defconfig
@@ -78,7 +78,6 @@ CONFIG_OMAP3_SPI=y
 CONFIG_USB=y
 # CONFIG_SPL_DM_USB is not set
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_OMAP3=y
 CONFIG_USB_MUSB_GADGET=y
 CONFIG_USB_MUSB_OMAP2PLUS=y
 CONFIG_USB_HOST_ETHER=y
-- 
2.50.0

