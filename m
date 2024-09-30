Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC76FCF6498
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 01:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2883888ECD;
	Mon, 30 Sep 2024 03:50:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VFIGF/ai";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83D9088DB9; Mon, 30 Sep 2024 03:50:37 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0F0188E51
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 03:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-82aac438539so194351539f.1
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 18:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727661032; x=1728265832; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gy0Yg9Rq6yXqIEUKWK7WNcooAleQz2BIJu35LCaPHqU=;
 b=VFIGF/aiUvyeNIwoZIqpXxUdqUHwCLzF2qq9ng7FaWl+SE2B64xZ+qwF6VIXYp5bP9
 pm8dk8IGlXr9t5qd0BSY3KoaX9ek9BcoUAIXcH139r9lN3Njw6PggqpEdxCa67FOqGKV
 rm4eTASWqFlqA5XeaVIYnctKFOFwPQgkxAfnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727661032; x=1728265832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gy0Yg9Rq6yXqIEUKWK7WNcooAleQz2BIJu35LCaPHqU=;
 b=RBLXJBIkAV+pB1o5iy2FKWqsr9CbEa8OdjxgjySfB4kfpzBDU/oJ5Qttcm/nZrN1kv
 CSkeeY1wf45e2HfsvUZiPbgf9rgUbrqrBYM78AlvlDxwK5JSYyTTUcYse5cdeYorPs9m
 0k9K9t6ph6ofIagJAd1a/i3hYnWhFtjyPivsVU4qKTS2WMZo2LTXhPTvpvePa7nNmEmP
 klDHDiXZO7WmE9Kv+s86l6QSEnG6TSLteSya2p2ysgmvHsiSBeux0BITBZODVYTJD7c3
 Ze7Qg5+39fAJ7350iwasgqiOTcul60zwQCDE9jwuBPU7/rMzOuaB92L6K2I1AWCOz9fs
 sTFA==
X-Gm-Message-State: AOJu0Yw6LEaA7Kj6JU6fVYnupSZvifYNM5DQ9r4Lelw/jxLhv12oUjb9
 fhgANekI9ozQ6XI6eCv0nJJkeO8w3TNQ6nBP1rU/VuwdVhihFFftwTthnK2Si11WuntMuUfVsxK
 MCg==
X-Google-Smtp-Source: AGHT+IEVsuZpR3fsDABNUQ4PQ6O/kOP0poHBJTcfUiXineHBG3vJchi31dalJwq4iHupa5DWNW/fXg==
X-Received: by 2002:a92:ca05:0:b0:3a0:97df:997e with SMTP id
 e9e14a558f8ab-3a345179ef0mr78162055ab.14.1727661032359; 
 Sun, 29 Sep 2024 18:50:32 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a344de1d5fsm22074185ab.62.2024.09.29.18.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Sep 2024 18:50:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alexander Dahl <ada@thorsis.com>, Heiko Schocher <hs@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joao Marcos Costa <jmcosta944@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <seanga2@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 21/33] doc: Move init-related things out of README
Date: Sun, 29 Sep 2024 19:49:44 -0600
Message-Id: <20240930014956.1434060-22-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240930014956.1434060-1-sjg@chromium.org>
References: <20240930014956.1434060-1-sjg@chromium.org>
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

Changes in v3:
- Move to earlier in the series

 README                | 82 --------------------------------------
 doc/develop/index.rst |  1 +
 doc/develop/init.rst  | 92 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+), 82 deletions(-)
 create mode 100644 doc/develop/init.rst

diff --git a/README b/README
index 78d91a2f62d..54e723162fd 100644
--- a/README
+++ b/README
@@ -133,88 +133,6 @@ run some of U-Boot's tests.
 
 See doc/arch/sandbox/sandbox.rst for more details.
 
-
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
2.34.1

