Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A148BC87FCB
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A435F83F56;
	Mon,  4 Aug 2025 23:51:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C8xfB6VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912B983F87; Mon,  4 Aug 2025 23:51:22 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3579083F56
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-87999c368e9so329038439f.0
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344279; x=1754949079; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jlho9TgeK3y6c9AQ/j57kMuTBotX7y/Y2phc940KiNg=;
 b=C8xfB6VKAcrGq1Eyj5fpS0X1RYgi90PrJm2aaX8wNH4mb2fCzMFjgCQWTRU5RYRqDP
 COQcUcL90MBcG5V7wjYKzMxU1rPautnJX9mQ1MW2MXg7PLZA3Q3kEqz50u5jKu4ej23H
 Hb97fu/WcfcCJwbyFXu9Y9mO7ZlrD6yFyNC48=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344279; x=1754949079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jlho9TgeK3y6c9AQ/j57kMuTBotX7y/Y2phc940KiNg=;
 b=vM61G3KscWWyqIIRJHPRr3Gu9Iq/9NmOuq8JoslQtKwjRrTQ0l+T9a1bAJmGZ0A7a3
 WlG1NkXe89wYtmkvLwYUJ9PAzjmk81I4fRtQX1/gNsUV9wMZ60ApcYTLHEE7WGLuCnX1
 Sb+YLxogdYJmBG2v3voOgmqg0hEfSvDNsJeKPU1/I8sSfBGs4R2fWu++SdeMkLqlH7HF
 s01aWjOIaeyG8x/sYOT8oLtIVlf+J9ohfIe9EttPZRbVRzATBmZuQqVAE8P/7GUab07K
 xH6bYiFB+bqnEdNRTRuI2Mv7J0yYPjvx3AQ2lKRDNq9+LGpEJJ5Ir1FpGTGUMwUrTY/L
 f5dA==
X-Gm-Message-State: AOJu0YyRKZyRPCsBT1KXXIGK9N1l7mQOIyYfzeRvoVGaXCsxezOZdF2H
 O6d6lNe3h1exbfqS0kkkvH9zMvAJEZpHo8zdoSGDA7ieXl1rbQf25A59uA/F+Nz/+KaCMhdnuyr
 K68Pa8Vc=
X-Gm-Gg: ASbGncuH++Sz4OEkTTG156/xllLZqqhm5Hmbvkb1HtPmwpxmriQdcl4L9gMuNuY52EV
 X+xlaGvfyC+aX67Tr4WcRCMSeoDECm3XHiNEfRZa9dKaMt4CGln0ofLPcvtH/3F3YhCPyHKDF3b
 AfGp3chbR4rnonjTmROLkn2pXffgsZbiLyuGx+nj0DHRGhUhAtTvzJNUTg2dAmOGM1hG7fS3/M6
 Hzs+QF0YHL+6eGtnSXDIBNSgSNo6t30Ka1wJQ4vC18ALO5vmwDBpcDV7YHp20e+T7gwUDZRYX4d
 SgGJkMxyw/vRJkjbDovQBC+iGtKaR5CYO6FGZDK3nGlH6X01QzSxeW1a1wf7QP5phJKJwkZFwnH
 jTGpF4yO2OCnYX9eNlbfXW72IbnW15Qa0vx++9+Rw2BfVMEgja/b3+W6MbBGoyl/YVRuPpuqixv
 u9d/Y=
X-Google-Smtp-Source: AGHT+IH2NzO8TVTMZN8giCfXWFEchLoMOW5sgQlX9hhW4/tHsKIlk9UL8DfwvCFGDd5IzhLxpS0YVA==
X-Received: by 2002:a05:6602:3c2:b0:879:c9db:cbf0 with SMTP id
 ca18e2360f4ac-8816831d73cmr2274258939f.2.1754344274870; 
 Mon, 04 Aug 2025 14:51:14 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-881738bd93fsm176463139f.25.2025.08.04.14.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:51:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] power: Tighten some power driver dependencies
Date: Mon,  4 Aug 2025 15:51:13 -0600
Message-ID: <20250804215113.1412224-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The MediaTek mt6323 power driver cannot build without access to some
platform specific header files. Express that requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/power/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index fd1c871f0dbb..d17337c0c3f0 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -463,6 +463,7 @@ config TWL4030_POWER
 
 config POWER_MT6323
 	bool "Poweroff driver for mediatek mt6323"
+	depends on ARCH_MEDIATEK
 	select CMD_POWEROFF
 	help
 	  This adds poweroff driver for mt6323
-- 
2.43.0

