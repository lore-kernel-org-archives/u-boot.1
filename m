Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6530FC87FCF
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 21:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F0C88404E;
	Mon,  4 Aug 2025 23:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uk4ikxqp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23DFE84002; Mon,  4 Aug 2025 23:57:35 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082DB83FF8
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 23:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-87c017978e6so141600839f.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 14:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754344651; x=1754949451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2fLXff9u97ktV7xBDCe7owWd+KiaS+LKMAqgSAYNMHA=;
 b=uk4ikxqpoZD+B4OpWSkVSvr53CN4oMcpgdtQJ05bEklLHtV3fFRHR3ZoRxcfBDkETz
 L5YsMocbsoCe11qpzq/ifdV0kgiKF5I2eauQ0UixuaHkuIM3mq73QE5jgiIBtx1cI+1t
 jBqVsdiGlEZpxFGHkJl9siL9nYYN62u1sdK8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344651; x=1754949451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fLXff9u97ktV7xBDCe7owWd+KiaS+LKMAqgSAYNMHA=;
 b=Ucxf09QT2l2yI3TJigrl04ZeBvuvvh73ziUyqdi3XqJ6uwWKLkWCoh1BKS4AyGkbXc
 pGMf+WVKhlUAxE9Nwctv1gpDNfOO1i1gylNHrgoWuI8sV1NzfODUeUaT44fxfxAcKbEs
 AxMTnO+N5lU+Mzibf5AT2l5yqqBKLp3j5LBLTt7Ru3ksPj4HebLdM2KBwYvbhMW/R8my
 19M34CkJJWl1tJP5T97QcATOTGv5DjVG0VUQJdQOPLdpdnwU8/mQZaI05DrrPs5jGnA9
 TjbH+1YORqgA7NbRQX6LB1tTZ+D524oIKQ52Ogt9Z2O0u43Yg56TGlYhfW44Mm5CbM12
 sB/A==
X-Gm-Message-State: AOJu0Yy+/ApMWMVCGLaHgldfw3Q5ILfJk7129iDiQeN6YDzWVI/Zls+p
 aEoqK2tH8qfzW6pwedZdxlgYYwCyHRTY3uE1BHyGTcFnKB52+cM8mKqLAdPzYu9zbkhlGZ8fuz1
 GvRCMiP0=
X-Gm-Gg: ASbGncsMq9JIovMfotp5b6hfaTx3+sUSZGLDuaNo8QWc4ZTRW39NB5NW+HFNjEToUDU
 MYhdDYOcBkC12WYtWUsqAMdzsJoTCQLbhvYV8H+fAWiYprZn19KAL5fkicTJkRfrWOxaWdQl3+5
 PxroPAIUpuptJo8oCfnH1BAcDKExBnHTgG3GtoSXcMasOzfchCrDhA49Ciy8KGPmtDPka4b/4BJ
 cFS4/TrMymyRNa/3FC3fZorZbsHKgec/JbaBZfFhNZqGdS4vWuX9WIeHOEciSQsvKVKQ5CENhUu
 rsfUrNihz7HPPkDyqbUruuD79KXEQHsYTR++fxmOcbNrlnN83f+LZo4e9pFcJImzmhfYOx+iaIe
 X6+uzMkWTdlTTpOH/gEP5EOgV+tObgE3R3JBXd98fmtS5bxHycLcEL32VHO+t+cAIyKzt
X-Google-Smtp-Source: AGHT+IEDyA5K81AF1QC39J0l6peTIwLmt4LdxZAKqikGysrORY3ASbtIRuFQln82s+x+Zjf4jxIO2w==
X-Received: by 2002:a05:6e02:460b:b0:3e3:dcfa:eadb with SMTP id
 e9e14a558f8ab-3e51032dc8dmr24788145ab.1.1754344646551; 
 Mon, 04 Aug 2025 14:57:26 -0700 (PDT)
Received: from localhost.localdomain (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50a9f677f81sm1066177173.39.2025.08.04.14.57.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 14:57:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sound: Tighten some sound driver dependencies
Date: Mon,  4 Aug 2025 15:57:16 -0600
Message-ID: <20250804215719.1413106-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804215719.1413106-1-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
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

A few sound drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/sound/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/sound/Kconfig b/drivers/sound/Kconfig
index 0948d8caab06..81de9b30f397 100644
--- a/drivers/sound/Kconfig
+++ b/drivers/sound/Kconfig
@@ -23,7 +23,7 @@ config I2S
 
 config I2S_ROCKCHIP
 	bool "Enable I2S support for Rockchip SoCs"
-	depends on I2S
+	depends on I2S && ARCH_ROCKCHIP
 	help
 	  Rockchip SoCs support an I2S interface for sending audio data to an
 	  audio codec. This option enables support for this, using one of the
@@ -32,7 +32,7 @@ config I2S_ROCKCHIP
 
 config I2S_SAMSUNG
 	bool "Enable I2C support for Samsung SoCs"
-	depends on I2S
+	depends on I2S && ARCH_EXYNOS
 	help
 	  Samsung Exynos SoCs support an I2S interface for sending audio
 	  data to an audio codec. This option enables support for this,
@@ -51,7 +51,7 @@ config SOUND_DA7219
 
 config SOUND_I8254
 	bool "Intel i8254 timer / beeper"
-	depends on SOUND
+	depends on SOUND && X86
 	help
 	  This enables support for a beeper that uses the i8254 timer chip.
 	  This can emit beeps at a fixed frequency. It is possible to control
@@ -82,7 +82,7 @@ config SOUND_IVYBRIDGE
 
 config I2S_TEGRA
 	bool "Enable I2S support for Nvidia Tegra SoCs"
-	depends on I2S
+	depends on I2S && ARCH_TEGRA
 	select TEGRA124_DMA
 	help
 	  Nvidia Tegra SoCs support several I2S interfaces for sending audio
-- 
2.43.0

