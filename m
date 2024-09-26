Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4706CCCFA07
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:47:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D203C8902A;
	Fri, 27 Sep 2024 00:47:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bET07gg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E018902A; Fri, 27 Sep 2024 00:47:40 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83A589028
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:47:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-458320b30e7so9091661cf.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390856; x=1727995656; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5m4xQlGKVZkAKmWMuF465eo6FEYdWd5ANx9SxZ+NcFk=;
 b=bET07gg8hyiujX66ViUYB+0lEm8hQfkeNISGnSGCjszroUJbk+vzVfHTddTW8nEta8
 OF2ELuep12erVNExEIsCYbPpILU9voWmhVdESkPTJ7QXyezwZ/wK9V+QMXCg2/33Y3ch
 o4UYJfMh3/WwH6gv3+yZONecR3L3dBMNx/PoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390856; x=1727995656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5m4xQlGKVZkAKmWMuF465eo6FEYdWd5ANx9SxZ+NcFk=;
 b=QUE/DXWpplAma2G9x4FzpyEqvbx3xWcjx1eptE4oaHR9VroZcCJ+Tk2NjsGAtPXEEs
 TzG/1BtbJZ24HUWWSZQWom3LOcwqu46KTf1HxDMU3kSys9QZjm79mOXx5DFTjavsWJMK
 +wQJh7afyxwwyrC67JPDldYR58Xj6DftaONxpBLKsxO3u9WCQHG5GU0hqSpjycWJLNnY
 9R92XyswMdG7+lVkJXnQEPxVL1e9W4o6bxXmvYaSpYc5XiZSHrHgoogAXRfLahbR8J8i
 X6yZrto/frKtRSCYmokxHYddmOLtPhuFQLztXQ3xRIW+ou11lUJyAWYWeDUT9JcJIhrq
 hV+A==
X-Gm-Message-State: AOJu0Yy3KZabAuMGwR+ur3h5gt9N1udOr65Sjp5UNvGxqHk5M0JAOY7k
 5h88yZ5GOHb+HE0hBwPUrXF6dFFCnjrx5cx+u2Uz3rHp44LYvzPb2W9+N0GXfEs3HUc5KY2PWor
 ZkOeD1h0=
X-Google-Smtp-Source: AGHT+IHz4USYAhYVT5g2k4keQBRdWsKFg0q9oF0B8uoT/3qSWiJywYV+qFrwLUGPe2x3gCmsno+s7w==
X-Received: by 2002:ac8:5d46:0:b0:45b:5e8e:33b7 with SMTP id
 d75a77b69052e-45c9f290ad1mr16302591cf.52.1727390856431; 
 Thu, 26 Sep 2024 15:47:36 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.47.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:47:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 41/42] doc: Move init-related things out of README
Date: Fri, 27 Sep 2024 00:36:06 +0200
Message-ID: <20240926223814.1276764-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

Move this section to rst, changing it just enough so that it builds.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 README                | 81 -------------------------------------
 doc/develop/index.rst |  1 +
 doc/develop/init.rst  | 92 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 81 deletions(-)
 create mode 100644 doc/develop/init.rst

diff --git a/README b/README
index 5115d28fac1..5a5b93fecb8 100644
--- a/README
+++ b/README
@@ -134,87 +134,6 @@ run some of U-Boot's tests.
 See doc/arch/sandbox/sandbox.rst for more details.
 
 
-Board Initialisation Flow:
---------------------------
-
-This is the intended start-up flow for boards. This should apply for both
-SPL and U-Boot proper (i.e. they both follow the same rules).
-
-Note: "SPL" stands for "Secondary Program Loader," which is explained in
-more detail later in this file.
-
-At present, SPL mostly uses a separate code path, but the function names
-and roles of each function are the same. Some boards or architectures
-may not conform to this.  At least most ARM boards which use
-CONFIG_SPL_FRAMEWORK conform to this.
-
-Execution typically starts with an architecture-specific (and possibly
-CPU-specific) start.S file, such as:
-
-	- arch/arm/cpu/armv7/start.S
-	- arch/powerpc/cpu/mpc83xx/start.S
-	- arch/mips/cpu/start.S
-
-and so on. From there, three functions are called; the purpose and
-limitations of each of these functions are described below.
-
-lowlevel_init():
-	- purpose: essential init to permit execution to reach board_init_f()
-	- no global_data or BSS
-	- there is no stack (ARMv7 may have one but it will soon be removed)
-	- must not set up SDRAM or use console
-	- must only do the bare minimum to allow execution to continue to
-		board_init_f()
-	- this is almost never needed
-	- return normally from this function
-
-board_init_f():
-	- purpose: set up the machine ready for running board_init_r():
-		i.e. SDRAM and serial UART
-	- global_data is available
-	- stack is in SRAM
-	- BSS is not available, so you cannot use global/static variables,
-		only stack variables and global_data
-
-	Non-SPL-specific notes:
-	- dram_init() is called to set up DRAM. If already done in SPL this
-		can do nothing
-
-	SPL-specific notes:
-	- you can override the entire board_init_f() function with your own
-		version as needed.
-	- preloader_console_init() can be called here in extremis
-	- should set up SDRAM, and anything needed to make the UART work
-	- there is no need to clear BSS, it will be done by crt0.S
-	- for specific scenarios on certain architectures an early BSS *can*
-	  be made available (via CONFIG_SPL_EARLY_BSS by moving the clearing
-	  of BSS prior to entering board_init_f()) but doing so is discouraged.
-	  Instead it is strongly recommended to architect any code changes
-	  or additions such to not depend on the availability of BSS during
-	  board_init_f() as indicated in other sections of this README to
-	  maintain compatibility and consistency across the entire code base.
-	- must return normally from this function (don't call board_init_r()
-		directly)
-
-Here the BSS is cleared. For SPL, if CONFIG_SPL_STACK_R is defined, then at
-this point the stack and global_data are relocated to below
-CONFIG_SPL_STACK_R_ADDR. For non-SPL, U-Boot is relocated to run at the top of
-memory.
-
-board_init_r():
-	- purpose: main execution, common code
-	- global_data is available
-	- SDRAM is available
-	- BSS is available, all static/global variables can be used
-	- execution eventually continues to main_loop()
-
-	Non-SPL-specific notes:
-	- U-Boot is relocated to the top of memory and is now running from
-		there.
-
-	SPL-specific notes:
-	- stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
-
 The following options need to be configured:
 
 - CPU Type:	Define exactly one, e.g. CONFIG_MPC85XX.
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 0d0e60ab56c..da9643dca14 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -38,6 +38,7 @@ Implementation
    distro
    driver-model/index
    environment
+   init
    expo
    cedit
    event
diff --git a/doc/develop/init.rst b/doc/develop/init.rst
new file mode 100644
index 00000000000..2955d9bdbc3
--- /dev/null
+++ b/doc/develop/init.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Board Initialisation Flow
+-------------------------
+
+This is the intended start-up flow for boards. This should apply for both
+SPL and U-Boot proper (i.e. they both follow the same rules).
+
+Note: "SPL" stands for "Secondary Program Loader," which is explained in
+more detail later in this file.
+
+At present, SPL mostly uses a separate code path, but the function names
+and roles of each function are the same. Some boards or architectures
+may not conform to this.  At least most ARM boards which use
+CONFIG_SPL_FRAMEWORK conform to this.
+
+Execution typically starts with an architecture-specific (and possibly
+CPU-specific) start.S file, such as:
+
+- arch/arm/cpu/armv7/start.S
+- arch/powerpc/cpu/mpc83xx/start.S
+- arch/mips/cpu/start.S
+
+and so on. From there, three functions are called; the purpose and
+limitations of each of these functions are described below.
+
+lowlevel_init()
+~~~~~~~~~~~~~~~
+
+- purpose: essential init to permit execution to reach board_init_f()
+- no global_data or BSS
+- there is no stack (ARMv7 may have one but it will soon be removed)
+- must not set up SDRAM or use console
+- must only do the bare minimum to allow execution to continue to
+  board_init_f()
+- this is almost never needed
+- return normally from this function
+
+board_init_f()
+~~~~~~~~~~~~~~
+
+- purpose: set up the machine ready for running board_init_r():
+  i.e. SDRAM and serial UART
+- global_data is available
+- stack is in SRAM
+- BSS is not available, so you cannot use global/static variables,
+  only stack variables and global_data
+
+Non-xPL-specific notes:
+
+    - dram_init() is called to set up DRAM. If already done in SPL this
+      can do nothing
+
+xPL-specific notes:
+
+    - you can override the entire board_init_f() function with your own
+      version as needed.
+    - preloader_console_init() can be called here in extremis
+    - should set up SDRAM, and anything needed to make the UART work
+    - there is no need to clear BSS, it will be done by crt0.S
+    - for specific scenarios on certain architectures an early BSS *can*
+      be made available (via CONFIG_SPL_EARLY_BSS by moving the clearing
+      of BSS prior to entering board_init_f()) but doing so is discouraged.
+      Instead it is strongly recommended to architect any code changes
+      or additions such to not depend on the availability of BSS during
+      board_init_f() as indicated in other sections of this README to
+      maintain compatibility and consistency across the entire code base.
+    - must return normally from this function (don't call board_init_r()
+      directly)
+
+Here the BSS is cleared. For SPL, if CONFIG_SPL_STACK_R is defined, then at
+this point the stack and global_data are relocated to below
+CONFIG_SPL_STACK_R_ADDR. For non-SPL, U-Boot is relocated to run at the top of
+memory.
+
+board_init_r()
+~~~~~~~~~~~~~~
+
+    - purpose: main execution, common code
+    - global_data is available
+    - SDRAM is available
+    - BSS is available, all static/global variables can be used
+    - execution eventually continues to main_loop()
+
+Non-SPL-specific notes:
+
+    - U-Boot is relocated to the top of memory and is now running from
+      there.
+
+SPL-specific notes:
+
+    - stack is optionally in SDRAM, if CONFIG_SPL_STACK_R is defined
-- 
2.43.0

