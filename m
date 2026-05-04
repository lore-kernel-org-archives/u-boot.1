Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1852CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F02846D5;
	Mon,  4 May 2026 15:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="aPoL0H/t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5AC8468E; Mon,  4 May 2026 15:21:00 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF3AB84255
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj63Wy4zfWm;
 Mon,  4 May 2026 15:20:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900858;
 bh=YtwTqlk9Oqawe2KTAo/NcBVckqT30Ifs9O6FCAsJapM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aPoL0H/txzDbPNuUYb5GI+UVfdrrsm85yegnbHQzCvHXqfb04wTcJ1J270l8MF9lR
 uRDN8AUtAZdDV6JysdNAgdZKJLzGAZo4GVH0MAjVb2bMXpD7qpEg0WxeE05hyU3eY1
 LdztHwTisCT1B3iW3zijc0/bodP3j4Eawu3JjM5nckUh/tR5NmGjB5vMaLieSZ8+cq
 Ovf29SznC7ztqMIIM7QosdWYqzjFddtbbVj5+N9/nsGx49tXeOH+i4LuLFPIJhWpaD
 Wz7HJt0lc/fxYibcRjYQwqJKzZKdndDeUYnOAvBUUNBu3wIBp8z/tYGb9jIO6z3Uj6
 zVrw3yap/Crfg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj51v2LzDLc; Mon,  4 May 2026 15:20:57 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:41 +0200
Subject: [PATCH RFC next 14/18] kbuild: respect CONFIG_WERROR for linker
 and assembler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-14-b19301d1948a@cherry.de>
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

[ Upstream commit ec4a3992bc0b5b659eceb44a9f8582b26f2c8489 ]

Original commit log:

  The linker and assembler do not share the compiler flags.

  Make sure they also fail on warnings with CONFIG_WERROR and W=e.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 2af90af594e..29b6aab5f72 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -104,6 +104,8 @@ endif
 ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
 
 KBUILD_CPPFLAGS		+= -Werror
+KBUILD_AFLAGS		+= -Wa,--fatal-warnings
+KBUILD_LDFLAGS		+= --fatal-warnings
 KBUILD_RUSTFLAGS	+= -Dwarnings
 
 endif

-- 
2.54.0

