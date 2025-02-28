Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CCAC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:04:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D72680FE2;
	Fri, 28 Feb 2025 11:04:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC1E80FE1; Fri, 28 Feb 2025 11:04:43 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 473CE807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-CSE-ConnectionGUID: JK687z2DQy+w1gYTXGd7xw==
X-CSE-MsgGUID: aflFHiueSk+mc9fyraUH2g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2025 19:04:38 +0900
Received: from rz-ub2404.betafive.net (unknown [10.226.94.53])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id AC9BB401EFD8;
 Fri, 28 Feb 2025 19:04:36 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Tom Rini <trini@konsulko.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2] Kconfig: Introduce CONFIG_WERROR
Date: Fri, 28 Feb 2025 10:04:33 +0000
Message-ID: <20250228100434.56442-1-paul.barker.ct@bp.renesas.com>
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
Changes v1->v2:
  - s/the kernel/U-Boot/

 Kconfig                    | 11 +++++++++++
 scripts/Makefile.extrawarn |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/Kconfig b/Kconfig
index 6379a4541664..70dc385dd2f2 100644
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
+	  successfully build U-Boot.
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

