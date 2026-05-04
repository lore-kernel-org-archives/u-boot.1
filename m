Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AD9CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D72846BC;
	Mon,  4 May 2026 15:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="aWT1w0le";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6C2B846C0; Mon,  4 May 2026 15:20:57 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3DB78468E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj33JGmzg3g;
 Mon,  4 May 2026 15:20:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900854;
 bh=W9X+xKFj2nwOtpR3hhGG/yuxUtU5zPqgsEsAR+AW5qo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=aWT1w0leHAiaXvOREoI/DIEf/UPGYLHBZUwpWszf3S+/BYRVWhRqS4LBmcof2ZMoX
 C5u8ZGl7GZFmwkeSvqxeQErbBVRIgNKxOZuPqrvxnt2OWmB1Wew8Txt7xKzY8TlFuK
 X86bB19T07iiJ4QEOgjZ2MpVVt0O4Xbno/IC8dql2v6cKPPhn2XCiWO9elC3taHi9t
 LOyLYX+IHQ3DkxhSl3gAJ2gQ2YhoS+hfLqktStVt/6Hgd6JLZ4xeYzOGXDOnNWdfrO
 xX/mgSGP+lT74yDYPXOskNGFewnnFTRtKif4Q9tCqc5FyKFvHch2s6Hu29Ij3dieEI
 Uw38wbFsgIPJQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj20V8nzDJ6; Mon,  4 May 2026 15:20:54 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:38 +0200
Subject: [PATCH RFC next 11/18] kbuild: unify W=e and CONFIG_WERROR
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-11-b19301d1948a@cherry.de>
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

[ Upstream commit e7a10929c574cf30981a8e19ef39bc35e63e8b46 ]

Original commit log:

  The two mechanisms have the same effect, unify their implementation.

  Also avoid spurious rebuilds when switching between the two.

[git conflict trying to remove the KBUILD_CPPFLAGS for CONFIG_WERROR,
 because U-Boot didn't have it before, due to missing backport for
 e88ca24319e4 ("kbuild: consolidate warning flags in
 scripts/Makefile.extrawarn") which we won't backport for now due to too
 many conflicts]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 65954320e0f..b5b1a762cdc 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -99,9 +99,9 @@ KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
 endif
 
 #
-# W=e - error out on warnings
+# W=e and CONFIG_WERROR - error out on warnings
 #
-ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
+ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
 
 KBUILD_CPPFLAGS		+= -Werror
 

-- 
2.54.0

