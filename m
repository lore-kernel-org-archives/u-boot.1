Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936B6CD3436
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:23:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81DB4846E1;
	Mon,  4 May 2026 15:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="Mgv7svE/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14CD9846D2; Mon,  4 May 2026 15:21:03 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE792846A4
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mj852KmzJDp;
 Mon,  4 May 2026 15:21:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900860;
 bh=wPgmSsOMi6JGPjvhIk9AfxCLt+GH+7rfNC4J1po3urM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Mgv7svE/Qdie7gDuJ9lvBGCZOf9b1AbL2lxiNTKGH+OP7oZKfTNbDIGO9bL9MW22k
 GKosSwNXZ/5Qh/J0GE5cxL3ckXwfdKdLHBTBErwEoGZM+d2QU6f0EoERq/pL9E8794
 Sg7QEPpmn1LnQ3oDwisGV1erRFImxASELhgBJivlMoJtKCl6vM69VuVQm3p7rKQFf7
 +FHwsiIHwURRhaA46BaaYJb5a20ew4mWMP3gALPwyeIo3YDShuK5jcdv2/NIgqY5D6
 2iqDp8hVDeJEX4VsbJ76iaDaNTG3M32xt0YWt/uWFOKGUkF7MBuLQGIkbM2qf600Z/
 KiG04bZRbEQFA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mj73XWDzDqF; Mon,  4 May 2026 15:20:59 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:43 +0200
Subject: [PATCH RFC next 16/18] scripts/Makefile.extrawarn: Respect
 CONFIG_WERROR / W=e for hostprogs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-16-b19301d1948a@cherry.de>
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

[ Upstream commit 7ded7d37e5f5b36b4acd74380156cf07b6640c5b ]

Original commit log:

  Commit 27758d8c2583 ("kbuild: enable -Werror for hostprogs")
  unconditionally enabled -Werror for the compiler, assembler, and linker
  when building the host programs, as the build footprint of the host
  programs is small (thus risk of build failures from warnings are low)
  and that stage of the build may not have Kconfig values (thus
  CONFIG_WERROR could not be used as a precondition).

  While turning warnings into errors unconditionally happens in a few
  places within the kernel, it can be disruptive to people who may be
  building with newer compilers, such as while doing a bisect. While it is
  possible to avoid this behavior by passing HOSTCFLAGS=-w or
  HOSTCFLAGS=-Wno-error, it may not be the most intuitive for regular
  users not intimately familiar with Kbuild.

  Avoid being disruptive to the entire build by depending on the explicit
  opt-in of CONFIG_WERROR or W=e to enable -Werror and the like while
  building the host programs. While this means there is a small portion of
  the build that does not have -Werror enabled (namely scripts/kconfig/*
  and scripts/basic/fixdep), it is better than not having it altogether.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 scripts/Makefile.extrawarn | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 8988308cc36..9fdc38a40af 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -108,9 +108,11 @@ KBUILD_AFLAGS		+= -Wa,--fatal-warnings
 KBUILD_LDFLAGS		+= --fatal-warnings
 KBUILD_RUSTFLAGS	+= -Dwarnings
 
-endif
-
-# Hostprog flags are used during build bootstrapping and can not rely on CONFIG_ symbols.
+# While hostprog flags are used during build bootstrapping (thus should not
+# depend on CONFIG_ symbols), -Werror is disruptive and should be opted into.
+# Only apply -Werror to hostprogs built after the initial Kconfig stage.
 KBUILD_HOSTCFLAGS	+= -Werror
 KBUILD_HOSTLDFLAGS	+= -Wl,--fatal-warnings
 KBUILD_HOSTRUSTFLAGS	+= -Dwarnings
+
+endif

-- 
2.54.0

