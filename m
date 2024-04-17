Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE92C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 09:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE6DB88442;
	Wed, 17 Apr 2024 11:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="CS7rtY6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E85628845A; Wed, 17 Apr 2024 11:36:46 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B7588466
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 11:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-418c2bf2f55so1732275e9.2
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 02:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713346603; x=1713951403;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zR3rGeBYRvZX4mDH/R1Xjrg6Bo248TE0omOsiOLJBV4=;
 b=CS7rtY6g8gnrGGfJeokgCGBurKnP2y7z+FAxz4M/mjpMkuyuwUuzK2JDh5yrDEnkZE
 gUkiuoHRXzq8pjrSHxPKv8k0GWQcUIWehhnYlBaHNI96O37Dol5x9r1aLf4NqiiMCBY6
 HCDECMxUa5aeKbPc2nN8xAQp6b7LvjRbQzj6JrvBSynKWw6wHQnYSUJx1Pd8kTnEHMqE
 WIckBs9YwM1/0w8UD4Nqm38QPFEBG6xXGlxhKNogvGoU2W4nRMW3QqMcGXkWSSEewEFp
 ufhLJOiAMxRne5N9++LyeAv1293YAKyh7JdZk2ogMQ5s/qdO3OU05SBp5Y7m5+FpA+ZR
 H++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713346603; x=1713951403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zR3rGeBYRvZX4mDH/R1Xjrg6Bo248TE0omOsiOLJBV4=;
 b=hUluaHov/FfFg1XnHFr//TiGD2E7RpmEF7f3xDbTepS8q+04Z+qJLDYOCjvj/0NThr
 1O9AdQ9IMcoeOVZog2rlE7kpm2WLrjwHmnnwAEEEscWBxmTdwpwZQTNZHuYYAIxp2Oye
 tzH+ZNg3OTe90ZqEs0gYpEKRjWCQtkM3aph9Q557cRH3+9VKBSy7HEz4UCbQW4id0jdn
 v1D5H3vk1PUxjwDQMD4D74bnR8WUePSDjPyHbEOqJMwDdpCAGEFsFEhkDzgMkgzTrr0A
 nt3UFY20GAw/hToeNVQeh2L1CzEvvmVr7cM6G9foKgnT35yIibn6Vo4YOZ/t0+m/W7Sc
 QpkQ==
X-Gm-Message-State: AOJu0YwJs5FZraoC2Ya0WHBQZGDSFlfp4SP8o1vSEgiwU+TmkL6D94u5
 fErI1kM6Qq4+h8Dc0N+eQK8DBrwvlEatR2YsR5Y9d98kVTSftiEBbDg2fqoAanRGzJtKn8+9XCY
 zSWc=
X-Google-Smtp-Source: AGHT+IE0RGdg4Xb2ed55zNfEMR0JOMh7vHhKcUbOB20DcgU0Q06kIL2q5lrqEq5fzBjsixBvCjxBeA==
X-Received: by 2002:a05:600c:4689:b0:418:4ecb:fc80 with SMTP id
 p9-20020a05600c468900b004184ecbfc80mr6165547wmo.23.1713346603566; 
 Wed, 17 Apr 2024 02:36:43 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at.
 [92.42.140.82]) by smtp.gmail.com with ESMTPSA id
 g20-20020a05600c4ed400b004183e983d97sm2073204wmq.39.2024.04.17.02.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 02:36:43 -0700 (PDT)
From: lukasz.czechowski@thaumatec.com
To: u-boot@lists.denx.de
Cc: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Subject: [PATCH v2] rockchip: px30-board-tpl: Use CONFIG_TPL_BANNER_PRINT flag
Date: Wed, 17 Apr 2024 11:35:42 +0200
Message-Id: <20240417093542.275150-1-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.34.1
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

From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Display TPL init information message only when TPL_BANNER_PRINT
configuration entry is set. This allows to disable information
message in case logs on UART are unwanted.
Update parent ifdef condition to check also CONFIG_TPL_SERIAL
to match logic of the non-PX30 TPL implementation.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>

---
Changes for v2:
- Updated parent ifdef condition
---
 arch/arm/mach-rockchip/px30-board-tpl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
index 637a5e1b18..db368a7b8c 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-#ifdef CONFIG_DEBUG_UART
+#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
 	debug_uart_init();
 	/*
 	 * Debug UART can be used from here if required:
@@ -46,7 +46,9 @@ void board_init_f(ulong dummy)
 	 * printhex8(0x1234);
 	 * printascii("string");
 	 */
+#if CONFIG_TPL_BANNER_PRINT
 	printascii("U-Boot TPL board init\n");
+#endif
 #endif
 
 	secure_timer_init();
-- 
2.34.1

