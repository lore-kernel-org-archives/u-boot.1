Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49351CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B915C8468E;
	Mon,  4 May 2026 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="DU2hQkfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AE7684659; Mon,  4 May 2026 15:20:56 +0200 (CEST)
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch
 [83.166.143.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95DD684659
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj224VBzgZx;
 Mon,  4 May 2026 15:20:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900853;
 bh=MEimfW8B8U/w8S8tu6hIfXPPXH41jyhhkNsBKCYzlZI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DU2hQkfGhAQZzS4QNJwYdM2NtP8C6JXn4j+aAy/zWZNz+Fp8ZAs6HdRBnYbf5SPc5
 SNJtwJTXjc93OTj7UM+B2lR0fEH0tNDIGFXRubegS10+mdBzGOgUkGJfdd27RI3KAo
 G3dm1kAf9q/cQdL3yCE6g43fSP626GEGGjiCyzxxojrMT0iQZAy4Mc2GHejdh3ZUI/
 Wd93eC9mStF7A+CI0rXhzyIx8WaRdJ1+EqW9bn+aYW2rDJe2DSpKx0mEjmgVuTyCf1
 TwdE3sG0NYNzAsSzcDQHdD5EUqKP0fRngeMcXp2ANCfHpIUkxnGxMjCxpC9ClUQzto
 3iVraWwwZyLpg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj06kTdzDP0; Mon,  4 May 2026 15:20:52 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:37 +0200
Subject: [PATCH RFC next 10/18] kbuild: align W=e with CONFIG_WERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-10-b19301d1948a@cherry.de>
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

[ Upstream commit f852ce052a8b78d6fade371bd1fad583541e78fa ]

Original commit log:

  CONFIG_WERROR sets KBUILD_CPPFLAGS while W=e would only set KBUILD_CFLAGS.

  As a preparation to unify the two mechanism, align their effects.

  While at it, add some alignment whitespace to prepare for later additions
  to the list of changed variables.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index b1881d83e06..65954320e0f 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -103,6 +103,6 @@ endif
 #
 ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
 
-KBUILD_CFLAGS += -Werror
+KBUILD_CPPFLAGS		+= -Werror
 
 endif

-- 
2.54.0

