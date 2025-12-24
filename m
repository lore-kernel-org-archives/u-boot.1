Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D8DE7491E
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 07:45:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98164841BE;
	Wed, 24 Dec 2025 08:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GP4NDPKR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7413841CD; Wed, 24 Dec 2025 08:45:15 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7833B84198
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 08:45:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 8192B3FF71; 
 Wed, 24 Dec 2025 07:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1766562312;
 bh=KW2LIRtiuJWTpCvnWSr2zW4iDSTxWyWeS3DMOzGyfiY=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=GP4NDPKRkGWYcwp1ng3FjRgstz+p3qW4TYZvEAL7kTir3h9vzcK00PDaqaZTYDJdA
 dTWUUPeuiGIiHf9lxJahaE1Z9WV7lWHWzvKQ9+G6Onuesg6Cndgrp3Jar23BW6GPlS
 oIlbXy3/imz4Iko9VsaDJVkXO+tz0GL8Gv9fp8+KVEX8CeN0/Y+23BzaRfKe6d7rRF
 iFycMj3ycrk7M5U53BlzyFoRc9tZySEe6aGrQhPC0ZOyOtOLWle4ExxgR37ZDPi4Jv
 zWl7HxisoeHFgU26IdyaafCgCo5x7coESQYM3KhNkHISjjaDY+iSIiouQBt7A9nBFs
 eLrMHm8+wv24DEF+GdTSoyLpUQKNdSV2FmE0Kps+m9MUWspiYTAtcW0n+9KL1iYAsV
 Ic3V6TZSuwDHTOVQcYeGuI8PqM+gOo9mitlxrYsfsb6plM9GoVYH2yPQoXN5Q3yVJy
 +XRUOyvs4t/5qbyOnEDh3/kil9JYjjS3f/t0b4vozz+Hs4LQYPShY3d78tHZPsYNGY
 pESB198PceuD77HX9JVlhuR7cbo1TKKnggHxrgOwddrqYBfDSgoeNrjAGHEKUhVUP6
 aKl05cgMKUvwMOgzmmba7bfQB1jWq820q/aTFtqMbYvyd+Aerp8vyWs9VMPQp2t8I2
 wcFyMVWs8itlDRlMhCOFzflE=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Raymond Mao <raymondmaoca@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] test: The LMB test depends on CONFIG_LMB
Date: Wed, 24 Dec 2025 08:45:07 +0100
Message-ID: <20251224074507.15540-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Many boards use CONFIG_LMB=y but not all, e.g.
amd_versal2_mini_defconfig. Building this board with CONFIG_UNIT_TEST=y
fails:

    aarch64-linux-gnu-ld:
    test/lib/lmb.c:411:(.text.test_noreserved+0x428):
    undefined reference to `lmb_free'

We should be able to enable CONFIG_UNIT_TEST on any board.

With this patch the LMB test is only built if LMB is enabled which
overcomes the build issue.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	Extend the commit message.
---
 test/lib/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/lib/Makefile b/test/lib/Makefile
index 7c9dc180c8d..f25383a40e5 100644
--- a/test/lib/Makefile
+++ b/test/lib/Makefile
@@ -16,7 +16,7 @@ obj-$(CONFIG_USE_PRIVATE_LIBGCC) += test_ctz.o
 endif
 obj-y += hexdump.o
 obj-$(CONFIG_SANDBOX) += kconfig.o
-obj-y += lmb.o
+obj-$(CONFIG_LMB) += lmb.o
 obj-$(CONFIG_HAVE_SETJMP) += longjmp.o
 obj-$(CONFIG_SANDBOX) += membuf.o
 obj-$(CONFIG_HAVE_INITJMP) += initjmp.o
-- 
2.51.0

