Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5EDCD3430
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 13:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C7D8846AC;
	Mon,  4 May 2026 15:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="j57WcsbA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371218466D; Mon,  4 May 2026 15:20:52 +0200 (CEST)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:19:8e30::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4971784686
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 15:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4g8Mhx63kkzfy9;
 Mon,  4 May 2026 15:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1777900849;
 bh=iNtBERv+7EGnx3ovs/hNm+eknNEiaHJeleOA9EIhCfU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=j57WcsbAkChzrbzKjmnNd6cE15r26Xz1zuBpE/NXGtH6DVjItAn6WAxV0IA3bBsL2
 xcXwmSgqiykfeNAbQdYxfcD9RXULJIgdP5ExRk+esCDa+iOcNO0AbJcU6GE2sy2T7r
 Q+JPGJ0yPHmRwSpUmSCIJ+0jfA8X9VXjyTZHEZy3ER9fEsinbXF2lA0yCdaaanJ9GF
 BXFiTUY+cU7E53QMQRB0MDvUZdfZq2jrmXcjyRseigM8ZNfM37g2RI78CIKkvX6Y/O
 G/H8TBEBltt29RKJ6FmBvG8uzcmZ6r3M/myGKIHpdoj6SoYWuEh0owuyxXwsS4pvgb
 R9pAfC6bcsApQ==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4g8Mhw4Z74zClt; Mon,  4 May 2026 15:20:48 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 04 May 2026 15:20:33 +0200
Subject: [PATCH RFC next 06/18] Makefile: move deprecated-non-prototype to
 scripts/Makefile.extrawarn.u-boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-extrawarn-sync-v1-6-b19301d1948a@cherry.de>
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

This option is specific to U-Boot and was added back in
commit 52ee1a0294e8 ("global: Disable deprecated-non-prototype warning
with clang"). It was added next to other flags which are imported from
the Linux kernel Makefile. This makes it unnecessarily hard to backport
patches from that project since we'll always have a difference in the
git context.

So, move this to the new scripts/Makefile.extrawarn.u-boot file where we
can store everything that is U-Boot-specific and lower the efforts for
syncing with the Linux kernel for Makefile.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 Makefile                          |  1 -
 scripts/Makefile.extrawarn.u-boot | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a0e9406bc59..bfd4976a0d4 100644
--- a/Makefile
+++ b/Makefile
@@ -1007,7 +1007,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, tautological-compare)
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
 # See modpost pattern 2
 KBUILD_CFLAGS += $(call cc-option, -mno-global-merge,)
-KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
 else
 
 # These warnings generated too much noise in a regular build.
diff --git a/scripts/Makefile.extrawarn.u-boot b/scripts/Makefile.extrawarn.u-boot
index 21872a5492b..0a9b49a30f0 100644
--- a/scripts/Makefile.extrawarn.u-boot
+++ b/scripts/Makefile.extrawarn.u-boot
@@ -7,3 +7,21 @@
 ifneq ($(findstring 3, $(KBUILD_EXTRA_WARN)),)
 KBUILD_CFLAGS += $(call cc-option, -Wvla)
 endif
+
+ifdef CONFIG_CC_IS_CLANG
+# We have a number of places in the code which use the following syntax:
+#
+# void func(a, b, c)
+#     int a; /* Does a */
+#     something_t *b; /* Pointer to b */
+#     int c; /* Does c */
+# {
+# ...
+# }
+#
+# Which while not what we document as our coding style, this is also code
+# which we have imported from other projects, and would like to re-sync
+# with in the future. While the biggest example of this is the zlib code,
+# there are other places as well. For now, we will silence this warning.
+KBUILD_CFLAGS += $(call cc-disable-warning, deprecated-non-prototype)
+endif

-- 
2.54.0

