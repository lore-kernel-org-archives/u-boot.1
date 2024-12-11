Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37FEE77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 07:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87DD78021D;
	Wed, 11 Dec 2024 08:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ECjWmjkK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lo/DYQnA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 921698021D; Wed, 11 Dec 2024 08:32:35 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D76580200
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 08:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y7S401GTjz9srp;
 Wed, 11 Dec 2024 08:32:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb9uQTjPik1XsMdgOMgsPSxpQ2a6leM4TlmMxyVuCgc=;
 b=ECjWmjkKucXZh0jZjSMo8F00MvQvBclKDvIxi9cIkLXjXQOZomLFsOeRBsooH/ztrXFMwJ
 OE0s279QPwuW1QQzC6OROMFOwKpIY7qnHYanv8VIGcx4bxPhcRsOTbEi0fn6r2f7uCVDiW
 +hQYkr/VPl0gqLBptZAY1AYoTd6tY9QVEtlT0jPe+2b1adBQCWKQUpkvd9ozxBNA50EXzQ
 vXF+xjHIlXCT9Bd/lzbWLyjNNtGfGaxS3Ext6HAK4bh/hRxFvhxotZmaHgJ+Q9S+B0xjMY
 HE05wI2vRMYofuZDPlUQAAMjAaKTf+5UxFWx+ZOB0eqqz61vOW79aXhsKBYaog==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1733902350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cb9uQTjPik1XsMdgOMgsPSxpQ2a6leM4TlmMxyVuCgc=;
 b=Lo/DYQnAqmtzDKimES+KFJs8jLNQoN0wovNxanorKcP84NbkxoM9z9H12oroSukz/4Vxz6
 w6FHiBrDy5oIsVSOaT50NI+m1P2lgFv81CZEG4r/3Mau5Rf+EBhUY9Ssvn5FMFd3vmojSE
 Nrm5deTiYzdsLT/J1z/TzV60DEsVfiUnRFu18TaT3xjUKRpshbn9PyYUNwyLHliZqz1BNb
 Xi6UhHeT+0JMT6VPAVaOrB2qyCANU+N16GGijn+WPba2Shprky7nj2xVsL9RQLetYtHegN
 Y7oMhBhSbwcdDnfTa5AKvl45Sal/d5IOkqs+kyNZ1dyU/tkrCADNYVXJtnPMiw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/13] ARM: renesas: Fix R-Car spelling
Date: Wed, 11 Dec 2024 08:30:26 +0100
Message-ID: <20241211073210.8087-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
References: <20241211073210.8087-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 5tzam57w75fjbdc7gjteihiedtfrx1ya
X-MBO-RS-ID: b44f019319d205aa37b
X-Rspamd-Queue-Id: 4Y7S401GTjz9srp
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

The correct spelling is R-Car, including the dash, update the usage.
Kconfig strings and comment changes only, no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: No change
---
 arch/arm/mach-renesas/Kconfig.32           | 4 ++--
 arch/arm/mach-renesas/include/mach/boot0.h | 2 +-
 arch/arm/mach-renesas/memmap-gen3.c        | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-renesas/Kconfig.32 b/arch/arm/mach-renesas/Kconfig.32
index 693a5abba0d..bbc61ccf480 100644
--- a/arch/arm/mach-renesas/Kconfig.32
+++ b/arch/arm/mach-renesas/Kconfig.32
@@ -1,11 +1,11 @@
 if RCAR_32
 
 config ARCH_RENESAS_BOARD_STRING
-	string "Renesas RCar Gen2 board name"
+	string "Renesas R-Car Gen2 board name"
 	default "Board"
 
 config RCAR_GEN2
-	bool "Renesas RCar Gen2"
+	bool "Renesas R-Car Gen2"
 	select PHY
 	select PHY_RCAR_GEN2
 	select TMU_TIMER
diff --git a/arch/arm/mach-renesas/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
index fe88a2e0373..2128eccd8a4 100644
--- a/arch/arm/mach-renesas/include/mach/boot0.h
+++ b/arch/arm/mach-renesas/include/mach/boot0.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Specialty padding for the RCar Gen2 SPL JTAG loading
+ * Specialty padding for the R-Car Gen2 SPL JTAG loading
  */
 
 #ifndef __BOOT0_H
diff --git a/arch/arm/mach-renesas/memmap-gen3.c b/arch/arm/mach-renesas/memmap-gen3.c
index c50700df078..d24419f5daa 100644
--- a/arch/arm/mach-renesas/memmap-gen3.c
+++ b/arch/arm/mach-renesas/memmap-gen3.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Renesas RCar Gen3 memory map tables
+ * Renesas R-Car Gen3 memory map tables
  *
  * Copyright (C) 2017 Marek Vasut <marek.vasut@gmail.com>
  */
-- 
2.45.2

