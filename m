Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2114CCF9F8
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 18:46:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424EC83EEF;
	Sun,  9 Nov 2025 19:45:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="tGhpxycS";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="S36End4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 937A583EEF; Sun,  9 Nov 2025 19:45:57 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7FCF83D0C
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 19:45:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d4MFH3K0nz9tMd;
 Sun,  9 Nov 2025 19:45:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762713955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJavbibh0u0U3CVz+nar7lHGHAWuWUBu8PereuqPmKw=;
 b=tGhpxycSujLDDsf/saF0nk9IQop0FZRmJyAlZIomp6MK62gEeVn0DHTG6yijZcwQZq72Ba
 qtw8bnteR7XUJQRDMFSfJ9U90CBGavhtLNSdSfwLxx6DXgefU3SbNWshJRwnoQxaj25Xlu
 KGaFUoYe2K/eB4EoB3to8D8NjvAHg/6BVerD+6WdBDLcbiLENz2G1cnmLJ64uX6AWaRtUt
 b8nMvlJO6A6K4tfEJfiHqBN/gEtxooEA0YKtpP//H09lpHDYBOEmxcJ3EYlavhGbHRvl17
 y3+j0DQs6hAkFZjAkuYVJoWMECiai5TiiaIN+a0tLEtcs6bX7P/biAvADDq6Vw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762713953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JJavbibh0u0U3CVz+nar7lHGHAWuWUBu8PereuqPmKw=;
 b=S36End4cGxbyykNzRgVYBdyMOGiiYliMTgwwMwrA3sq8YrkQ1ho35ZMfc/fsN/2M0lMe33
 IsmjbTN60PzCaaBE4ahlsC0ZEZ6cGeaN2CMiJu3SKxpHYqU9qCWo/AGdQldatlrkSQo7il
 gdDluPVH38BIuRG/9OkViqKvxFjV2O9bXieESzzQFu0BY8joPJJB5cMBgifG1KQeolh9ze
 HVfA2ylaFZWkCSyunfNnwR2SD7DMx+BW0ahmYvrk+X9sBySEWeHq+reQSB+Nvhqj6pjHl7
 ZHi0UrthlwophWoHCQ28kanGqMLewAlHAIHi5/KtGQkz7yW4k7DT7w++ojHh1g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] ARM: Fix HAS_ARMV7_SECURE_BASE help text
Date: Sun,  9 Nov 2025 19:45:41 +0100
Message-ID: <20251109184551.41457-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 0c2ebf0c1b268899152
X-MBO-RS-META: 3aem18phwxmgzxbray8npzqf9tyir8r7
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

Drop the 'a' from 'ahardware', no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/armv7/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/cpu/armv7/Kconfig b/arch/arm/cpu/armv7/Kconfig
index ab86d642eee..3a3c1784e18 100644
--- a/arch/arm/cpu/armv7/Kconfig
+++ b/arch/arm/cpu/armv7/Kconfig
@@ -28,7 +28,7 @@ config ARMV7_BOOT_SEC_DEFAULT
 	variable to "sec" or "nonsec".
 
 config HAS_ARMV7_SECURE_BASE
-	bool "Enable support for a ahardware secure memory area"
+	bool "Enable support for a hardware secure memory area"
 	default y if ARCH_LS1021A || ARCH_MX7 || ARCH_MX7ULP || ARCH_STM32MP \
 			|| MACH_SUN6I || MACH_SUN7I || MACH_SUN8I || TEGRA124
 
-- 
2.51.0

