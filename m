Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F58FCD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44A4A846C7;
	Mon,  4 May 2026 15:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="dl83oPSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4517C846C3; Mon,  4 May 2026 15:21:02 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC8584659
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj745hbzdb9;
 Mon,  4 May 2026 15:20:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900859;
 bh=RsTvkP3mJYGnXfEAOk8AdGTnR+V+fEv+tnLXRGRCA/Q=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dl83oPScw7AXYYrLHT3PHXt5aOIeRQnoMQUXFUoCjJ8JR2Pfb7pcLLzsDVe6WWXaT
 T3r2u2vxaIgjkGUHMQFAkWb0XGetwVwiYHpTwMRy82C4bP/HpcoVgm/PW26oosLutM
 9TOHGMWWlSfqwzQY8LFlx9W0kgH/DhFqjXcQzRlgZQFjWfZ15a0XKxhij/XdafpgKu
 yQaVZQc2pXw//s0IRe/OCM2tHgLHBR9FWOzuCCiStLSWXwRTfTyDy7LMHcdojZ0ol6
 V6yzkFPFU088tTwtz2RnUCqBvcmlfLIkJ83hz5/SQnbjfyMaopkUzdQUcPCblT+zP/
 X6j0+uE0fMKaA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj62d4FzC7x; Mon,  4 May 2026 15:20:58 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:42 +0200
Subject: [PATCH RFC next 15/18] kbuild: enable -Werror for hostprogs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-15-b19301d1948a@cherry.de>
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

[ Upstream commit 27758d8c2583d10472b745a43ff86fef96c11ef7 ]

Original commit log:

  The hostprog compilers and linkers do not share the regular compiler flags,
  so they are not affected by CONFIG_WERROR or W=e. As hostprogs are used
  during the bootstrap of the build, they can't depend on kconfig options.

  Enable -Werror unconditionally.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 29b6aab5f72..8988308cc36 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -109,3 +109,8 @@ KBUILD_LDFLAGS		+= --fatal-warnings
 KBUILD_RUSTFLAGS	+= -Dwarnings
 
 endif
+
+# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
+KBUILD_HOSTCFLAGS	+= -Werror
+KBUILD_HOSTLDFLAGS	+= -Wl,--fatal-warnings
+KBUILD_HOSTRUSTFLAGS	+= -Dwarnings

-- 
2.54.0

