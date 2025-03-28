Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9239AC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 11:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBB178082A;
	Fri, 28 Mar 2025 12:33:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JYSVVjEJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890B6809A4; Fri, 28 Mar 2025 12:33:54 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91184805C8
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 12:33:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3d445a722b9so8829905ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 04:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743161627; x=1743766427; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QgWVkd2FRsvhjLS4PE5Kyao5wtaBFcE/PmOhYYUqTvY=;
 b=JYSVVjEJspc24ew/d9r5p2oAeZuCCsy0JGhKWkIhHg79FrPLNYiBGHp6EAvfKjWwrI
 J0lG4emiemKvtqqx7Br+10ZjrtmeMVf3ed5eRcydY7p/wYM2jRuhh1+PwtSiH3kkq6Yd
 yVu503WtbFT0POORTrHkx7JtRvsPUaLJiVrxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743161627; x=1743766427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QgWVkd2FRsvhjLS4PE5Kyao5wtaBFcE/PmOhYYUqTvY=;
 b=VLE7NeNwe+GbJk3PIf58SrNXuVUNX1CznFPhbR8ADetJ9w3vTgalFYx2O2g5+NvkNe
 s9QZNsC4WCLs6l3brOQk4hpFZNYBl/c/z0FK06JoKZIqnumm04BOc52zSy6CMKT5WXFF
 OOdeclFTIk6qOLiTeYWzfG3VpjMM5wVzJegqPq7XjcvzJRT1NKtOx6gEGZMyPcMtKOGp
 /jJ3U8fRskbFUP+zGG1kwNCn4KHihw8ujP4jhL51nbfSBIlUwSbvnLcm8YTB4ykMXKgj
 Tt1XkrLd6wlorN39+6eWvNM+VugnMmkoXJEeVKDBgWNST62P3TGyIsbMLgHEp1CeAfri
 7qDg==
X-Gm-Message-State: AOJu0YyD6JSaJ7TC8JpkjJrwozJM6uppXHQ4Txhv8Kfms/eDBJiKzlpl
 ik5O4Orbf3pBKaYG0JxaRD3A1ODzC1vl0aLw1H7rxiYqKO6UNtXWY4cbja2hm9EqLZRjMYBMIVc
 =
X-Gm-Gg: ASbGnctUNrcvdIvsgLDKPi24cbq5h93gKatPAtLLgN4soiyMUam8eYJkSm/VREHI8TY
 +KSr5bTH891rclpJkAJCo0oUDK4SdXnN6JFrhBR0y6qHKegmj4BqoXV1MUB3ejjR6T6342C3aM0
 d4p2XlEtPq/S8PhmlrGPAk8FqBvVDxryA+ZWxVpwHBorn9qyTPvNYvpckL45PEiws0NUPkaDZXT
 bTCH5RKOehb27Axp9d/9HWXrE8BCeuDryO1Ba2cGoDOZ6QwFrSsS+OkfchdDPIU2xi4/MJTkEzw
 8hbU3RJ5iETB6ylahmctywJpXZqCnliSqPONP2CaFdSspmXjPHVeQYtlBOMu3cDvf30E8MQT50b
 VdIfdog==
X-Google-Smtp-Source: AGHT+IG9k9bIEQK/eQxXEqEAdzfiK5uAGX+VVmtCcmkM6qu+P4lsnallmXHzln2N0A4jyiC/WWFNEw==
X-Received: by 2002:a05:6e02:198d:b0:3d3:faad:7c6f with SMTP id
 e9e14a558f8ab-3d5ccdc1fadmr71639415ab.5.1743161627006; 
 Fri, 28 Mar 2025 04:33:47 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d5d5a745c9sm4151135ab.43.2025.03.28.04.33.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 04:33:45 -0700 (PDT)
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
Subject: [PATCH] efi: Tidy up nits in the ARM64 EFI app
Date: Fri, 28 Mar 2025 05:33:31 -0600
Message-ID: <20250328113340.2542301-1-sjg@chromium.org>
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

This patches tidies up a few things in the recently added EFI app for
ARM:

- Use 0 as the value for SYS_LOAD_ADDR
- Reword help for TARGET_EFI_ARM_APP64
- Do the same for x86-app targets, for consistency
- Delete efi-arm_app32 MAINTAINERS entry since there is no such thing

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Caleb Connolly <caleb.connolly@linaro.org>
---

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

