Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E914DCD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E791846C3;
	Mon,  4 May 2026 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="La5cUKJz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3AA3846C0; Mon,  4 May 2026 15:20:58 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEE69846B2
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj43SxNzhD6;
 Mon,  4 May 2026 15:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900856;
 bh=MJ9QYedsdcbZxeldJMrK3+wkdIowsXfBJ+Xqfl5qw/k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=La5cUKJz/Nkdnk9gKTZQU7EG8CZDX5WN0EK4Pkko3Dw/9Rj9B5cIPVC21/UeQUSYi
 O9zfLFb5Pww5DPc47ORtU7P2abYnt3SeMBhFQMJue/gUAHY/faz7tOWDRhFDrlacA7
 Fpw6HGH7cfwv9NBb8pDdf+BWeGc8ksdtA/ek72CeAoNkHimYrnclaBUwolzpRm07bB
 1L9FN4XM2z5GDU7jgpzBH6UWPK/CS+J4rlfcLD6UrYDFXsf9eYFm5JfUtqvbTD3pgM
 uiUCHLrDmh4ig1oar8/Zyv56C6YxqobcJn4BmpE/L84lGSJe/50KedJoWtSMaD5dp8
 i6/jp+DCSqzJw==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj30Q7ZzcCj; Mon,  4 May 2026 15:20:55 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:39 +0200
Subject: [PATCH RFC next 12/18] scripts/Makefile.extrawarn.u-boot: remove
 redundant Werror handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-12-b19301d1948a@cherry.de>
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

In the previous commit, scripts/Makefile.extrawarn from the Linux kernel
gained support for adding -Werror to KBUILD_CPPFLAGS when CONFIG_WERROR
is enabled, therefore this is now redundant and can be removed.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn.u-boot | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
index 86f6fbc2301..0a9b49a30f0 100644
--- a/scripts/Makefile.extrawarn.u-boot
+++ b/scripts/Makefile.extrawarn.u-boot
@@ -25,6 +25,3 @@ ifdef CONFIG_CC_IS_CLANG
 # there are other places as well. For now, we will silence this warning.
 KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
 endif
-
-KBUILD_CPPFLAGS-$(CONFIG_WERROR) += -Werror
-KBUILD_CPPFLAGS += $(KBUILD_CPPFLAGS-y)

-- 
2.54.0

