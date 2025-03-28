Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE211C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2EFA81A0C;
	Fri, 28 Mar 2025 13:08:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="e/580lXX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F36DB8082A; Fri, 28 Mar 2025 13:08:18 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1B8181A0C
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-854a68f5a9cso170888139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743163692; x=1743768492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXf3k5WoFopNF9kVpwk5oyA33Y3NlSpvJfn98Ic8VbY=;
 b=e/580lXXCxve4Vfn2xzof2XwtB62jQ2Qx80YVZETzDdPHVffN1HMXKv0MCj4PIAIew
 9PkZLKI03inwfXxXTBlL0H1XM/yf1EovQhlfip6ITi1sQHygNiRmB7EopQM/StxYWmhe
 bkGIltaIUt9c0pjs58mDdTvbbFj5WaC6FDw6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743163692; x=1743768492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXf3k5WoFopNF9kVpwk5oyA33Y3NlSpvJfn98Ic8VbY=;
 b=nyTkCrCNMlYM3521gnXGlIxWgNdKQZqHEGMOXn6gwmEGwKzo+gTQ2+OgG43qzLnAba
 wIdWI/xPqwOg6K6jb7kytAA2jihpZHa+NI+iH5ZZyQP5vlHvgUFRU0LseZxP0+NH7Zy5
 DVV/6YnHfaTEIvvo77KW0RoOQrVonSowk8pfoby3bli8wQMaqnGU39dCHS3dGhyoUKfl
 vcq4ZYZgeKOUN3jjWhrFg/E6Z0SuaLxnt8h9Ra7OjKitLaJ/HfA5bYfIjAuAzg5wLFGJ
 HNE/7XB6H7DiwfHcb5qB8SEu7XhWZJHoPsc6N8/FWnBKekhHmJpXXV4iNjqvhnC4u0Gr
 t8qQ==
X-Gm-Message-State: AOJu0YzztDXbqkoTGu7P/bc4Z2lQ2liR5j3qFW0YfaJ6papEZnxjrw9Z
 yQVPLZYca6zk2MnH88AGB4UNuy0Iqsj1xW+IYof97UpGNJKADQrgTXfQF0XZkTNg5arAL31DOEA
 =
X-Gm-Gg: ASbGnctOozHAnxBCzCwyXwSSQQVbB/3J4cpziz4hCTeXIuoTcn7suRKwAzi5PWkZSLm
 1haOjZF41OxR9rZlGYygrkQ7pgRWDHEKpVJZZieXbmbCLbqt3+UlIlTyeWM7l/+IET73nNunRYv
 AFy7i07PLeGfj17Qyxus3N2JrjvwJaJhkLd3YP1ojEOBMxfEXpboTiHDfUoAonzdfRQFRNJv4Qs
 iHswHLyNWmTvC+uiXcC5sXZAM1XbMvVzKpYGHefhzDRiXRaIQI+mSZwWECdL9f4FcWpFToAq2Cr
 MP4Ei1rK0RmjiWk8tgtAQM7dyLOTDEkdSM4o0gFvz9xF5PTzz7SNlRhEErCLwS8ukTOA2jj7Icb
 XNglwfw==
X-Google-Smtp-Source: AGHT+IGrSDytZwymfLHDeGRgovbFdlSSPrGXTePIH/JHSty7CMrZLSQjWafSSBooZIMkNsUTeRBnuQ==
X-Received: by 2002:a05:6602:408c:b0:85b:482b:8530 with SMTP id
 ca18e2360f4ac-85e8205f628mr912860939f.2.1743163692422; 
 Fri, 28 Mar 2025 05:08:12 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f464871894sm406344173.91.2025.03.28.05.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 05:08:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Tom Rini <trini@konsulko.com>,
 Trevor Woerner <twoerner@gmail.com>
Subject: [PATCH v2 1/1] efi: Tidy up nits in the ARM64 EFI app
Date: Fri, 28 Mar 2025 06:07:42 -0600
Message-ID: <20250328120802.2562751-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328120802.2562751-1-sjg@chromium.org>
References: <20250328120802.2562751-1-sjg@chromium.org>
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

This patches tidies up a few things in the recently added EFI app for
ARM:

- Use 0 as the value for SYS_LOAD_ADDR
- Reword help for TARGET_EFI_ARM_APP64
- Do the same for x86-app targets, for consistency
- Delete efi-arm_app32 MAINTAINERS entry since there is no such thing

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Changes in v2:
- Add a cover letter so the base commit is provided

 Kconfig                           | 2 +-
 board/efi/Kconfig                 | 6 +++---
 board/efi/efi-arm_app/MAINTAINERS | 7 -------
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Kconfig b/Kconfig
index 5ffdc481827..589fed689c8 100644
--- a/Kconfig
+++ b/Kconfig
@@ -551,7 +551,7 @@ config SYS_LOAD_ADDR
 	default 0x12000000 if ARCH_MX6 && !(MX6SL || MX6SLL  || MX6SX || MX6UL || MX6ULL)
 	default 0x80800000 if ARCH_MX7
 	default 0x90000000 if FSL_LSCH2 || FSL_LSCH3
-	default 0x02000000 if ARCH_EFI
+	default 0 if ARCH_EFI
 	default 0x0 if ARCH_SC5XX
 	help
 	  Address in memory to use as the default safe load address.
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 174e6ecd6f4..5237f58093e 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -17,7 +17,7 @@ config TARGET_EFI_X86_APP32
 	help
 	  This target is used for running U-Boot on top of EFI. In
 	  this case EFI does the early initialisation, and U-Boot
-	  takes over once the RAM, video and CPU are fully running.
+	  starts once the RAM, video and CPU are fully running.
 	  U-Boot is loaded as an application from EFI.
 
 config TARGET_EFI_X86_APP64
@@ -27,7 +27,7 @@ config TARGET_EFI_X86_APP64
 	help
 	  This target is used for running U-Boot on top of EFI in 64-bit mode.
 	  In this case EFI does the early initialisation, and U-Boot
-	  takes over once the RAM, video and CPU are fully running.
+	  starts once the RAM, video and CPU are fully running.
 	  U-Boot is loaded as an application from EFI.
 
 config TARGET_EFI_X86_PAYLOAD
@@ -59,7 +59,7 @@ config TARGET_EFI_ARM_APP64
 	help
 	  This target is used for running U-Boot on top of EFI in 64-bit mode.
 	  In this case EFI does the early initialisation, and U-Boot
-	  takes over once the RAM, video and CPU are fully running.
+	  starts once the RAM, video and CPU are fully running.
 	  U-Boot is loaded as an application from EFI.
 
 endchoice
diff --git a/board/efi/efi-arm_app/MAINTAINERS b/board/efi/efi-arm_app/MAINTAINERS
index 3114db69a35..3e2a85ab961 100644
--- a/board/efi/efi-arm_app/MAINTAINERS
+++ b/board/efi/efi-arm_app/MAINTAINERS
@@ -1,10 +1,3 @@
-EFI-ARM_APP32 BOARD
-M:	Simon Glass <sjg@chromium.org>
-S:	Maintained
-F:	board/efi/Kconfig
-F:	board/efi/efi-arm_app/
-F:	configs/efi-arm_app32_defconfig
-
 EFI-ARM_APP64 BOARD
 M:	Simon Glass <sjg@chromium.org>
 S:	Maintained
-- 
2.43.0

