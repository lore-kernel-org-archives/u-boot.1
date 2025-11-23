Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE56CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:59:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 641A283C72;
	Sun, 23 Nov 2025 23:58:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VGtlX5+A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EE483C8C; Sun, 23 Nov 2025 23:58:39 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80F0383C6E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id CE76744976; 
 Sun, 23 Nov 2025 22:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938686;
 bh=88nYkNDoV0od7f/iEJIKBhkgFfydllykeCwDWdiYY0M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=VGtlX5+AkU3mbb/61zTMxpjtIl2F4BdWNB9mtAUoolnghyCzMTD3knXGIPtlcYVIZ
 L7R+54dXxbuWBklIr6V8ktTOCwjwlmPu73V1Irrh+Y297ZKQLRkVjYQQFzVSpTyXyZ
 x3AS6oElBeyZ3DTua8NqTLJh9UGKI06zHOx0v0Tab0J3LOleRjLAKZOiQ0xMv4ch2D
 enToIMZGCtVESVOWzQpVaC5sXDzjGvZiAMK2b4qNuDbVxelZQIbGKt98Yf5XKXXeCX
 L7b9Cx1iQtfqWoKRGVZHn21U2C4jLAeRC6KOqfXFUqRFUcCSrlX2Lp+WxZeI2z/R+O
 L81iGDR+xzL6Na4GouqK9v3x0ct+UOFNpRgpVUpEALkSORLsuYTGpVDIJMAU3YPg4d
 4xlBhit6zXs/xCtOyqVf21m18PU5floG59KmOgh3Sh/slM3ccRrXc0zGEwu34/QSgz
 X7Zr6xgXZWBHiFyrkxyGi9IpnU2IyBJFl44j4b1uyZkd8ad4Z5At4a553H2Mgo6iH1
 ZSkymAErMcY/sJJDKLFX5FJra6S70Dubn4CKhYkgGxHQog6Q1pxHE2IwDY7NtKFKHx
 Jvhv4ysrzsvhEg+yhdpxd1LSkYlCaiQQvgrgZwMZw2e8wyOQTfWBP+JBhm3Fozj4hO
 0sDAUjCM5h574trwc+deGZr8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 11/19] test: correct comments in test/cmd/font.c
Date: Sun, 23 Nov 2025 23:57:03 +0100
Message-ID: <20251123225711.227016-12-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

The test relates to the 'font' and not to the 'fdt' command.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/font.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd/font.c b/test/cmd/font.c
index 7ae648d7395..5c52f359a57 100644
--- a/test/cmd/font.c
+++ b/test/cmd/font.c
@@ -10,10 +10,10 @@
 #include <video_console.h>
 #include <test/ut.h>
 
-/* Declare a new fdt test */
+/* Declare a new font test */
 #define FONT_TEST(_name, _flags)	UNIT_TEST(_name, _flags, font)
 
-/* Test 'fdt addr' resizing an fdt */
+/* Test the 'font' command */
 static int font_test_base(struct unit_test_state *uts)
 {
 	struct udevice *dev;
-- 
2.51.0

