Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7E8CD1284
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 11:51:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3363488249;
	Thu, 11 Apr 2024 13:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WslZDaTA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0755F8824A; Thu, 11 Apr 2024 13:51:30 +0200 (CEST)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1CF687FED
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 13:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1e2c725e234so5882295ad.1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 04:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712836286; x=1713441086; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8/aa3gScZqXXsGSX/yLIBh8w5anFgh4CEr50CxkBb2M=;
 b=WslZDaTA3FtniG2bMy2A9DejJYipkJj01wVFEOtuMWeDYr9SWcRpCAD/SvVxkLJr3N
 eb1rsDQs6dy7ZKh6NnwzX6yasFWmQ6AMSips9/P/Z6VxeUVJ6W2sa+eUV7WcamboxNAL
 mGj4OhAi3VQdjxpMS4XArtidAZk+2P225ICsTk6LEJChrPdRMnlrENHMdYXw5ycBU2oo
 Yh3oj4UprJiCbcgp/Bsqv6GMaRu6tJiwQ61sgE1BBm8AC2OqLwB4OiICYOlnqOS4SVdq
 fcAaFwvQ92AcKvh234tYBoQenx2nAq9qSJ8x9QQh1C0ok+wWf0ebaxCWhuTl1TOE04xo
 7QWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712836286; x=1713441086;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/aa3gScZqXXsGSX/yLIBh8w5anFgh4CEr50CxkBb2M=;
 b=JqdzQGRitNscbefj0luSwckd4xX9xfmqoDFECnlkL6pCoT9SMrmqhqdqW1wXZSfDLT
 nvgVX5UUScMEdEP/UZr0nsHey5+RZ5VTCGRaDf/JkegMPIN46aOzxebTAg+Jzs9sUAci
 5YzYjr6m73EFKhjpnnnn1rcUsutqq104Ig9yJoEnaoPlsyFyf48K0MTD0hiBIAX7NM9p
 J+WoMHRfXoXsLdbnmJDzI6gpgZ1upBR9HiR6mHwhCNIOm0ys2TGbtKja+emdzT8TLS28
 RqrTqSZlnv9QGO9PYj/RleULmgFeIv7lB3Cyi66gxvex0UYnb1ndk+Q9J3hZUNF/s3MZ
 b1Jw==
X-Gm-Message-State: AOJu0Yyzd/RVqL4YGeTZbAynMOLgzzp1/Kb7HQ8MySwpOdZQ+GjP2QmR
 n/LyoQwCcxV9OPEcrffOaBsG/GBe/AZ6Qzrewm3Uy4peM8y7m8/h9n4wzUcie9Igf2rmzqklqwR
 s
X-Google-Smtp-Source: AGHT+IHsqHDopi0UXQ+qFpdMueNMWaSfXzNX0ZYtx43c8ofVIo6Kr+wDE6TuaTNSCEr1LfZmgts+pw==
X-Received: by 2002:a17:902:e811:b0:1e3:cb8d:e28f with SMTP id
 u17-20020a170902e81100b001e3cb8de28fmr3019966plg.31.1712836285923; 
 Thu, 11 Apr 2024 04:51:25 -0700 (PDT)
Received: from sumit-X1.. ([223.178.210.92]) by smtp.gmail.com with ESMTPSA id
 f13-20020a170902ce8d00b001e3e0aa9776sm1008456plg.27.2024.04.11.04.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 04:51:25 -0700 (PDT)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, trini@konsulko.com,
 stephan@gerhold.net, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] mach-snapdragon: Allow other board vendors apart from Qcom
Date: Thu, 11 Apr 2024 17:21:16 +0530
Message-Id: <20240411115116.344595-1-sumit.garg@linaro.org>
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

Qcom SoCs derived boards can come from various OEMs/ODMs and not just
Qcom itself. So allow CONFIG_SYS_VENDOR to be set correctly
corressponding to the actual board vendor.

Suggested-by: Stephan Gerhold <stephan@gerhold.net>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig  | 15 +++++++++------
 configs/dragonboard410c_defconfig |  1 +
 configs/dragonboard820c_defconfig |  1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 96e44e2c549..4615a140d0d 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -4,7 +4,11 @@ config SYS_SOC
 	default "snapdragon"
 
 config SYS_VENDOR
-	default "qualcomm"
+	string "Snapdragon board vendor"
+	help
+	  Allows to specify vendor for the Snapdragon SoCs based boards.
+	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
+	  will be used as the custom board directory.
 
 config SYS_MALLOC_F_LEN
 	default 0x2000
@@ -19,12 +23,11 @@ config LNX_KRNL_IMG_TEXT_OFFSET_BASE
 	default 0x80000000
 
 config SYS_BOARD
-	string "Qualcomm custom board"
+	string "Snapdragon SoCs based board"
 	help
-	  The Dragonboard 410c and 820c have additional board init
-	  code that isn't shared with other Qualcomm boards.
-	  Based on this option board/qualcomm/<CONFIG_SYS_BOARD> will
-	  be used.
+	  Allows to specify the Snapdragon SoCs based board name.
+	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
+	  will be used as the custom board directory.
 
 config SYS_CONFIG_NAME
 	string "Board configuration name"
diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 260a8349d3b..3b6f50307a3 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_SYS_VENDOR="qualcomm"
 CONFIG_SYS_BOARD="dragonboard410c"
 CONFIG_COUNTER_FREQUENCY=19000000
 CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
diff --git a/configs/dragonboard820c_defconfig b/configs/dragonboard820c_defconfig
index ebc80eb2a46..a795497ef5d 100644
--- a/configs/dragonboard820c_defconfig
+++ b/configs/dragonboard820c_defconfig
@@ -1,4 +1,5 @@
 CONFIG_ARM=y
+CONFIG_SYS_VENDOR="qualcomm"
 CONFIG_SYS_BOARD="dragonboard820c"
 CONFIG_COUNTER_FREQUENCY=19000000
 CONFIG_ARCH_SNAPDRAGON=y
-- 
2.34.1

