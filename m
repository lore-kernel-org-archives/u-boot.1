Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF20C27C53
	for <u-boot@archiver.kernel.org>; Sun, 16 Jun 2024 17:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519AC8819D;
	Sun, 16 Jun 2024 19:31:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Oz2FCKgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1B968818B; Sun, 16 Jun 2024 19:31:11 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59DBF8817C
 for <u-boot@lists.denx.de>; Sun, 16 Jun 2024 19:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-041-025.um47.pools.vodafone-ip.de
 [178.202.41.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6FE9240F9A; 
 Sun, 16 Jun 2024 17:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718559067;
 bh=2GTqJa/ibJ1l9tmGVAduhcm0qrnwOeRUr0LrLx3Ahoc=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Oz2FCKgKJDhxnMBVEFVatp5pE88sMvzVX7n3q3zZKoY75asVnqb1r066tQOgDmMMT
 q9XxU/tmUgsnf9WCRb7IC/Z6yRGWo8QMgmrMinqQ0WaYCO53P6nZ16M/hjFjDXF/7T
 CMK/p6FEUdyrBTDyA0WbqDPQPRsXdW76WBkUgn0Oqbgz75oLdI2BxSSnO1rBgkwM6o
 0VzTmbO4lAXUSlfutlY6jlNq0aYWGnCi591+cRb1J64utHpc+sqyrW5BA1pbygNRDt
 ixQfbkAAi7DuggOuTC4wMU/MYjGCDjPTPsm13g80nQ9+o18dQPuerHhJIv2hI3E1oW
 W9b32C0aJoFTw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] arm: implement invalidate_icache_all on ARM11
Date: Sun, 16 Jun 2024 19:31:04 +0200
Message-ID: <20240616173105.7430-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
References: <20240616173105.7430-1-heinrich.schuchardt@canonical.com>
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

In EFI sub-system we rely on invalidate_icache_all() to invalidate the
instruction cache after loading binaries. Add the missing implementation on
ARM1136, ARM1176.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/cpu/arm11/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/cpu/arm11/cpu.c b/arch/arm/cpu/arm11/cpu.c
index 01d2e1a125d..4bf0446b543 100644
--- a/arch/arm/cpu/arm11/cpu.c
+++ b/arch/arm/cpu/arm11/cpu.c
@@ -116,3 +116,15 @@ void enable_caches(void)
 #endif
 }
 #endif
+
+#if !CONFIG_IS_ENABLED(SYS_ICACHE_OFF)
+/* Invalidate entire I-cache */
+void invalidate_icache_all(void)
+{
+	unsigned long i = 0;
+
+	asm ("mcr p15, 0, %0, c7, c5, 0" : : "r" (i));
+}
+#else
+void invalidate_icache_all(void) {}
+#endif
-- 
2.43.0

