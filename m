Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C0C1B087
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 22:01:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF3E81668;
	Thu, 27 Feb 2025 23:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3303D81668; Thu, 27 Feb 2025 23:01:05 +0100 (CET)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by phobos.denx.de (Postfix) with ESMTP id 39A228166D
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 23:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: +iqtlSMxRnOKzdobTj0f1A==
X-CSE-MsgGUID: 0UYAKwjARRiE17iBswDnSw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie5.idc.renesas.com with ESMTP; 28 Feb 2025 07:00:51 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.93.138])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 16AAB40578DF;
 Fri, 28 Feb 2025 07:00:49 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH] Kconfig: Introduce CONFIG_WERROR
Date: Thu, 27 Feb 2025 22:00:30 +0000
Message-ID: <20250227220031.789695-1-paul.barker.ct@bp.renesas.com>
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

Add a new config option under "General setup" to enable the -Werror flag
when building U-Boot. This is useful during development to help catch
mistakes.

This is based on a similar config option added to the Linux kernel by
Linus in 2021 - see Linux commit 3fe617ccafd6 ("Enable '-Werror' by
default for all kernel builds"). The modification of KBUILD_CFLAGS is
done in Makefile.extrawarn, matching where it was moved in the kernel by
Linux commit e88ca24319e4 ("kbuild: consolidate warning flags in
scripts/Makefile.extrawarn").

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 Kconfig                    | 11 +++++++++++
 scripts/Makefile.extrawarn |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/Kconfig b/Kconfig
index 6379a4541664..4fbe65222952 100644
--- a/Kconfig
+++ b/Kconfig
@@ -27,6 +27,17 @@ config DEPRECATED
 	  code that relies on deprecated features that will be removed and
 	  the conversion deadline has passed.
 
+config WERROR
+	bool "Compile U-Boot with warnings as errors"
+	help
+	  A U-Boot build should not cause any compiler warnings, and this
+	  enables the '-Werror' flag to enforce that rule.
+
+	  However, if you have a new (or very old) compiler or linker with odd
+	  and unusual warnings, or you have some architecture with problems,
+	  you may need to disable this config option in order to
+	  successfully build the kernel.
+
 config LOCALVERSION
 	string "Local version - append to U-Boot release"
 	help
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 7d39b27d24a9..f687515fc799 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -13,6 +13,9 @@
 
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 
+KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
+
 ifeq ("$(origin W)", "command line")
   export KBUILD_ENABLE_EXTRA_GCC_CHECKS := $(W)
 endif
-- 
2.43.0

