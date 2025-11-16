Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D361CEBF86
	for <u-boot@archiver.kernel.org>; Sun, 16 Nov 2025 00:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B359839E4;
	Sun, 16 Nov 2025 01:19:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="feXHJomZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ACIg3oKJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 112F183A1B; Sun, 16 Nov 2025 01:19:41 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35A04839DF
 for <u-boot@lists.denx.de>; Sun, 16 Nov 2025 01:19:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d8BMZ5V0vz9twF;
 Sun, 16 Nov 2025 01:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m+WdoBgoy82fXZNjbhPq1APH9oTVVXP7zz0S4b8XYwA=;
 b=feXHJomZ6dHG8nnEGqrMvpY2rob5Ke9I6pxGShOikwzH4T4b0AR48bRr2/yKB2NONqSL6v
 TIdrubbyP0bUl0NhQn/26CqEWtQp33EUW6Je/PyzhhkOkCw8TwLonE7DD4kS0yjKCgvQG2
 rXMLSlBXrV4frN4qhw0uR5PQNsL7GMueOPE4qwuB0i6kgx8qTr90JNxn5irqoEZoWTZEZ8
 U18/dreiorNWgLt2RVS9+1P38Vj2mZATtIHo9fZK8J2soFQfUmByGmsclWM56AUJ9GAD3Q
 /jPA55h6Nx1j74aP4TwnYHY8gEf2sqbAiQG1Hk7TVMnzkl5b6VumTzU2DMKQpw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763252376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=m+WdoBgoy82fXZNjbhPq1APH9oTVVXP7zz0S4b8XYwA=;
 b=ACIg3oKJWQPjBoxguawUvguBkHQCiGVkwOnxKaMHiD5onpaEIqNNnIjG99DbPGO4N0gm3q
 wYmFVcrXeSo6vPvzp6Q/Jwg9nearqcCbn3pzBy3LetMS9zfEabfuoEG3koN6z/HSsEU9fs
 Q4VqRff+jak673ap38xnPYuiAOe7vhPrisYYppRCaTDfiMTU1PdSSViXDVqT2DEpcp6v8Y
 wobE8RT7ZFZN6301JR2DgWWUfQZDempLDxTBAMMs9yEjN6nwafxC3tkBbQ/1NLnycZZsIJ
 hgkb0mqdOlx6x+exSUXjXm+v4BSZWQd1RR28Z0fuX6lUQv5FIBeh4k9ffQ4hYg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] xtensa: Fix big endian build
Date: Sun, 16 Nov 2025 01:19:01 +0100
Message-ID: <20251116001934.675130-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9f662c5993e43ffd24c
X-MBO-RS-META: m1hkszahc7nrkw4tn7qngkw3y7qgeutr
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

Make sure the correct PLATFORM_...FLAGS are assigned in each
case, consistently. Assign PLATFORM_ELFFLAGS for both LE and
BE case. The previous PLATFORM_CPPFLAGS makes no sense for
these particular parameters, which are passed to objcopy.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/xtensa/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/config.mk b/arch/xtensa/config.mk
index 200b66f8504..75888720d4a 100644
--- a/arch/xtensa/config.mk
+++ b/arch/xtensa/config.mk
@@ -9,7 +9,7 @@ PLATFORM_CPPFLAGS += -D__XTENSA__ -mlongcalls -mforce-no-pic \
 LDFLAGS_FINAL += --gc-sections
 
 ifeq ($(CONFIG_SYS_BIG_ENDIAN),y)
-PLATFORM_CPPFLAGS += -B xtensa -O elf32-xtensa-be
+PLATFORM_ELFFLAGS += -B xtensa -O elf32-xtensa-be
 else
 PLATFORM_ELFFLAGS += -B xtensa -O elf32-xtensa-le
 endif
-- 
2.51.0

