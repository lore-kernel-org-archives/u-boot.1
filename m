Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89241CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF4E2846AA;
	Mon,  4 May 2026 15:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Dwhk2BnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D9E7846DC; Mon,  4 May 2026 15:21:04 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B3F3846C1
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj95Hg3zj3Z;
 Mon,  4 May 2026 15:21:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900861;
 bh=JCLjSzHlLOvyL4zUIjti/p37C7aBno+mZZLgakVjEd8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Dwhk2BnMlIEX2Hg+8YV2I1gJFQBS0zFixKgAJwrNrdZYv0Y9J7FG+KoV1q9oOgjsN
 BESxs99PjdExNUx7Kbup2MjX2dFTXvLWpvFpy/wZ18KaGzEOsnnHelKdgnDSw0gcT9
 yXQ5ydQHiOV3flFdzPKSWeIYUpvqwKW5EJ/v5OHKJRvHorbEtMtBXyHmUQgbqCot1E
 orAiQaDMnG70Th2lV5PjAYnsUN3uVVIPBs4XlBkc6nv+gINVynyopSL+jwU45l+Un/
 KLbmLvC1g1GL3Dv5bWNxzkKXmfT3GPMKNuqiVjUR/n7s3XlZP8Wzkb2rfjQV5Ecb60
 4J1KnyEnQ8W6g==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj83k5TzCpb; Mon,  4 May 2026 15:21:00 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:44 +0200
Subject: [PATCH RFC next 17/18] scripts/Makefile.build: do not run
 kernel-docs with warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-17-b19301d1948a@cherry.de>
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

We have too many of them for now and the kernel has switched to a Python
script with likely many other small changes. We also have a couple of
patches in our fork, so it'll need to be ported to the new version once
sync'ed.

For now, let's simply not run kernel-docs with warnings, which allows us
to use W=e to enable Werror for host and target compilers as well as the
linker and assembler. This will then be used in buildman in next commit.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 73b6769ab90..230180fa1f1 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -127,7 +127,10 @@ else ifeq ($(KBUILD_CHECKSRC),2)
 endif
 
 ifneq ($(KBUILD_EXTRA_WARN),)
-  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
+  # U-Boot: Too many warnings in our docs and this prevents us from using the
+  # very convenient W=e to configure -Werror via a Make variable, so silence it
+  # for now.
+  # cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $<
 endif
 
 # Compile C sources (.c)

-- 
2.54.0

