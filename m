Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD94CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66902846BD;
	Mon,  4 May 2026 15:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QpEEDaYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C928468E; Mon,  4 May 2026 15:20:55 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69D96846A4
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj10mPszfTG;
 Mon,  4 May 2026 15:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900852;
 bh=8cKJqCDe/10CZvhHAxrWavNoh0rw7VL7O/GkRkyL5ew=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QpEEDaYXBV4zORL/hKlo8gcEHN2XPYub4SKAujXELGaCXXEKZrNzE4Vm7MGlPHy0x
 l3M8cT4gT+4gbDwOVohYewZax1opEWicIwF/FD4/4fzwkaPnh3iUnrjEQFO5EGITmc
 ErR8nOW/sMo8bQGmoJar3nXDidsYJ3ctFGDNuw3hGEDC1RPbMo7gS71WiBMIXbKhu2
 NDUkVCGy9FL54Tj6u88700PBRds5U0zqO6Mkl2UB6WElstXwO1TbSExzGkZVqtRW+z
 gYXmUWuGYAonWJ21cU89BFK06AdWVJFriz1FXJSylxySH2WBN43t5pZSdw2b6l9x0j
 3X11QfXUW/XmA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhz6XCmzBJl; Mon,  4 May 2026 15:20:51 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:36 +0200
Subject: [PATCH RFC next 09/18] kbuild: support W=c and W=e shorthands for
 Kconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-9-b19301d1948a@cherry.de>
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

[ Upstream commit c77d06e70d59cbc6e3c22bf644bb0b197a5fc182 ]

Original commit log:

  KCONFIG_WARN_UNKNOWN_SYMBOLS=1 and KCONFIG_WERROR=1 are descriptive
  and suitable in scripting, but typing them from the command line can
  be tedious.

  Associate them with KBUILD_EXTRA_WARN (and the W= shorthand).

  Support a new letter 'c' to enable extra checks in Kconfig. You can
  still manage compiler warnings (W=1) and Kconfig warnings (W=c)
  independently.

  Reuse the letter 'e' to turn Kconfig warnings into errors.

  As usual, you can combine multiple letters in KCONFIG_EXTRA_WARN.

    $ KCONFIG_WARN_UNKNOWN_SYMBOLS=1 KCONFIG_WERROR=1 make defconfig

  can be shortened to:

    $ KBUILD_EXTRA_WARN=ce make defconfig

  or, even shorter:

    $ make W=ce defconfig

[note that U-Boot currently doesn't make use of the KCONFIG_WERROR or
 KCONFIG_WARN_UNKNOWN_SYMBOLS symbols as we're using an ancient version
 of kconfig, so technically W=c won't do anything.]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile                   | 10 ++++++++++
 scripts/Makefile.extrawarn |  9 ---------
 scripts/kconfig/Makefile   |  8 ++++++++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index aed54cee4a4..bd33437fdfd 100644
--- a/Makefile
+++ b/Makefile
@@ -105,6 +105,15 @@ endif
 
 export quiet Q KBUILD_VERBOSE
 
+# backward compatibility
+KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
+
+ifeq ("$(origin W)", "command line")
+  KBUILD_EXTRA_WARN := $(W)
+endif
+
+export KBUILD_EXTRA_WARN
+
 # Kbuild will save output files in the current working directory.
 # This does not need to match to the root of the kernel source tree.
 #
@@ -2745,6 +2754,7 @@ help:
 	@echo  '		1: warnings which may be relevant and do not occur too often'
 	@echo  '		2: warnings which occur quite often but may still be relevant'
 	@echo  '		3: more obscure warnings, can most likely be ignored'
+	@echo  '		c: extra checks in the configuration stage (Kconfig)'
 	@echo  '		e: warnings are being treated as errors'
 	@echo  '		Multiple levels can be combined with W=12 or W=123'
 	@echo  ''
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 6bbba36c596..b1881d83e06 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -8,15 +8,6 @@
 
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 
-# backward compatibility
-KBUILD_EXTRA_WARN ?= $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
-
-ifeq ("$(origin W)", "command line")
-  KBUILD_EXTRA_WARN := $(W)
-endif
-
-export KBUILD_EXTRA_WARN
-
 #
 # W=1 - warnings which may be relevant and do not occur too often
 #
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index abc34f60d15..f072772eba8 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -22,6 +22,14 @@ ifeq ($(quiet),silent_)
 silent := -s
 endif
 
+ifneq ($(findstring c, $(KBUILD_EXTRA_WARN)),)
+export KCONFIG_WARN_UNKNOWN_SYMBOLS=1
+endif
+
+ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
+export KCONFIG_WERROR=1
+endif
+
 # We need this, in case the user has it in its environment
 unexport CONFIG_
 

-- 
2.54.0

