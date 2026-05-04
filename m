Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE750CD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C017B846D0;
	Mon,  4 May 2026 15:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QNZAcPI1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDEF84659; Mon,  4 May 2026 15:20:59 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [83.166.143.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAAA58468E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj53NZQzdtx;
 Mon,  4 May 2026 15:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900857;
 bh=X9Cc6hLhOctVNkruOgBMJ19g+yUPr6+dhTZTLdgMiA0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QNZAcPI1m/t6sIYBdu/9HDll4LrDvRn9MX8R2QdwvPZREXBqN8aBXcB5py9+Me0HQ
 GHybTm50B0ZSXHTYUSSU98JfE0MUVaxBghEi44d6W4A9D++HZPRUf56z5FAbB6mL5G
 ZD4LYFwp4nNwcf5NrpvOWAab+u+h2Z/NGOhNM1NLbyB9N0xnBbb8XiV0EkxcXKQgTC
 vYnA55dSRlyW8AR01/+r9xRhDUqggtCEJP8rka9N1zEElupDMVlth392KlHcUPIIj8
 0u9oRtjq0UheLl0afmrGKfwGqpjzY2Jix1fm86FDzCxQiOoMPc/s44+ePp35QZQTc1
 rrdZ6mBvkrP7Q==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj42HZ8zBqm; Mon,  4 May 2026 15:20:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:40 +0200
Subject: [PATCH RFC next 13/18] kbuild: rust: move `-Dwarnings` handling to
 `Makefile.extrawarn`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-13-b19301d1948a@cherry.de>
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

[ Upstream commit 592b571f20c5b905c47a1370210456f9f90ce04f ]

Original commit log:

  Following commit e88ca24319e4 ("kbuild: consolidate warning flags
  in scripts/Makefile.extrawarn"), move `-Dwarnings` handling into
  `Makefile.extrawarn` like C's `-Werror`.

  No functional change intended.

[git conflict trying to remove KBUILD_RUSTFLAGS from Makefile, which we
 don't have in U-Boot]
[U-Boot doesn't build anything Rust so this is useless except for the
 fact it allows to backport patches from Linux kernel easier]
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index b5b1a762cdc..2af90af594e 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -104,5 +104,6 @@ endif
 ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
 
 KBUILD_CPPFLAGS		+= -Werror
+KBUILD_RUSTFLAGS	+= -Dwarnings
 
 endif

-- 
2.54.0

