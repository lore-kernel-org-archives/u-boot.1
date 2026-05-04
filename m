Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA82CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87E4F84683;
	Mon,  4 May 2026 15:20:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Dg54vym1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B0F84683; Mon,  4 May 2026 15:20:48 +0200 (CEST)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0715A84255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mht5XwMzdwc;
 Mon,  4 May 2026 15:20:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900846;
 bh=lLl7z5PojfLOCSRxGEA0BZ6k6WxwDPnFy81JuVmotuQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Dg54vym1nzT+yhe4/091mV4qeR+qJA/YSliaAME8SVrhW0+OhmIx/aM40tf37sdEq
 z4gRBqHCkjQOIONbZyU/59iqyoBTdWRL82ghYvK3T9bQBQdXEXxFi9afBzJ1Y+CgxP
 3TL6aEVo2K6xUFE3L342yIZoPYlqdWIqiiZGrH3kIcvJNsgsrqn0wfftt263fYhfUA
 iJSsHpmo3gALhgz75/2lLT+HN5DkcVe91kYVor8EpqkARnHUbSfypUsr+3qRhOjfHk
 O8R/N5DtknP6b99uHWeUyvlD2BMZC00dUjaqhJvDEkWTETWQGL37l25PpI6eJQnEKo
 s0XqaF3WhbzKA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhs2KYGz9pZ; Mon,  4 May 2026 15:20:45 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:30 +0200
Subject: [PATCH RFC next 03/18] scripts/Makefile.extrawarn: migrate -Wvla
 to a U-Boot-specific file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-3-b19301d1948a@cherry.de>
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

In the next commits, we'll be synchronizing scripts/Makefile.extrawarn
with the Linux kernel's at version 6.1 which is what we've been claiming
we've synced to for a while but that isn't true.

In kernel commit 0bb95f80a38f ("Makefile: Globally enable VLA warning"),
available in v4.20, -Wvla is now enabled tree-wide and not present in
scripts/Makefile.extrawarn anymore. When we'll be syncing to v6.1, we'll
therefore be losing this flag (since it's not in our root Makefile). We
could backport the changes to the root Makefile to our root Makefile but
U-Boot is not VLA-free unlike the kernel.

We have two options:
- backport the changes to the root Makefile and disable it in
  scripts/Makefile.extrawarn.u-boot,
- only enable it in scripts/Makefile.extrawarn.u-boot, with the same
  warn level as currently: 3,

For now, do the second option. We should probably go for the first
option in the long term and try to synchronize our flags with the
kernel's. Much bigger undertaking than desired right now.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile                          | 1 +
 scripts/Makefile.extrawarn        | 1 -
 scripts/Makefile.extrawarn.u-boot | 9 +++++++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 49d9740327e..eb61df70838 100644
--- a/Makefile
+++ b/Makefile
@@ -1025,6 +1025,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
 
 include $(srctree)/scripts/Makefile.extrawarn
+include $(srctree)/scripts/Makefile.extrawarn.u-boot
 
 # Add user supplied CPPFLAGS, AFLAGS and CFLAGS as the last assignments
 KBUILD_CPPFLAGS += $(KCPPFLAGS)
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 4e1714c9484..c5ed501d374 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -65,7 +65,6 @@ warning-3 += -Wpointer-arith
 warning-3 += -Wredundant-decls
 warning-3 += -Wswitch-default
 warning-3 += $(call cc-option, -Wpacked-bitfield-compat)
-warning-3 += $(call cc-option, -Wvla)
 
 warning := $(warning-$(findstring 1, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
 warning += $(warning-$(findstring 2, $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)))
diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
new file mode 100644
index 00000000000..21872a5492b
--- /dev/null
+++ b/scripts/Makefile.extrawarn.u-boot
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# ==========================================================================
+#
+# Collection of warnings that are specific to U-Boot
+#
+# ==========================================================================
+ifneq ($(findstring 3, $(KBUILD_EXTRA_WARN)),)
+KBUILD_CFLAGS += $(call cc-option, -Wvla)
+endif

-- 
2.54.0

