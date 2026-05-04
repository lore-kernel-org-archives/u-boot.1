Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 432C6CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD2B8846AF;
	Mon,  4 May 2026 15:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="cpdzv0y0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DD0846A7; Mon,  4 May 2026 15:20:53 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46E5484255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhz06R7zfcY;
 Mon,  4 May 2026 15:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900850;
 bh=hl2oTjhZdqDqjTFjkFte8v0xBNjfhsnnOVxBWFU6XG8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=cpdzv0y0UNDulFHydcEW6pyg/v6+A6gOjclStbv9CCbQjIWoUDP8nqO4p3BTtL7gm
 a1lpXCd8Zbkwuxa6iyZd+8mcocsql/86DGqbm4vQRWDdueIRbnT/CFlfoq8Ejm+Kt2
 w154dL+WfU8rls2eudTplJsRfvkznZneIAh0Is2cE7gSR0SM33NSmrkPm+QDZC0lf6
 +Smy4JhDqbbn5AoJ5fKZ1hxVvLe05yQR53rZ8ijIL8EHC80zeJlkJbCJBZzQZc35Mv
 01+bK9Ifyi94XBXnBth8NMwualAzpOs9X2I5tsejdmipQNC8fTh1zUelmfFdKHl8PG
 McaSYiZ4ry9Zw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhx6Ct5zBtD; Mon,  4 May 2026 15:20:49 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:34 +0200
Subject: [PATCH RFC next 07/18] scripts/Makefile.extrawarn: handle
 CONFIG_WERROR in U-Boot-specific file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-7-b19301d1948a@cherry.de>
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

This is not something that is in Linux kernel in v5.1, nor in v6.1 which
will be the next sync. Since the next sync will be importing
scripts/Makefile.extrawarn directly instead of backporting individual
patches, CONFIG_WERROR handling would be gone.

Move the CONFIG_WERROR handling to the U-Boot-specific file such that it
doesn't get removed during the next sync.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn        | 3 ---
 scripts/Makefile.extrawarn.u-boot | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index c5ed501d374..7dfc374a19d 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -22,9 +22,6 @@ endif
 
 export KBUILD_EXTRA_WARN
 
-KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
-KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)
-
 ifeq ("$(origin W)", "command line")
   KBUILD_EXTRA_WARN := $(W)
 endif
diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
index 0a9b49a30f0..86f6fbc2301 100644
--- a/scripts/Makefile.extrawarn.u-boot
+++ b/scripts/Makefile.extrawarn.u-boot
@@ -25,3 +25,6 @@ ifdef CONFIG_CC_IS_CLANG
 # there are other places as well. For now, we will silence this warning.
 KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
 endif
+
+KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
+KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)

-- 
2.54.0

