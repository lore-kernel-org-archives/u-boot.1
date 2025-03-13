Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96FEC282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 17:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA32980F9C;
	Thu, 13 Mar 2025 18:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tfxG5IsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CE580FF7; Thu, 13 Mar 2025 18:17:37 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF01E80756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 18:17:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7c5675dec99so139336085a.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 10:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741886253; x=1742491053; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ivVwElMQRBwqNsxIUs7eAUMUviqFt+jub2Py3v+41PQ=;
 b=tfxG5IsOf1ZDPzNxwGJvxefXXsUjXd6tbHKZ4ov5FjPdsyoiC+z8fCNeyqcXfAPba6
 1eb5UnbcdoY+flIEYZ4KzSXGBZ3T0Iz3QhrsGqXz7D3iYEwZsJMHAZVclhiCqqPkaPNm
 65Y6AOclbS4fQdw7mzcwCQ9pRNcp6A8wxSwhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741886253; x=1742491053;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ivVwElMQRBwqNsxIUs7eAUMUviqFt+jub2Py3v+41PQ=;
 b=mW41nvcg62u0RMJiYj+h9r6W95C8x9t689QuOJnEpvSS4KrL3TU2Ggg/NXCpWaA6+a
 Jr8e4nhVBaHJCE5Sa28FfZbTPXjcG/oVrcOY3XDHSSDOrlXe4/4xEjX0uMiROoxTvGxV
 AOF8umx76pJxcYSWuB7ap4B/eNoXm7B0btHbubO8k9jMfDvUbntoXG2L/XaJ87gmxRis
 B5X/odOu5xXPbDq1IzRToooUN0eQuPffFW/cZ34ayY3MroU+XWbG+sTT5VgO1teCDhEK
 8LoWAi7T91ooz6l+3f6Le4ll3pF/fgAZ/90pByVVhXhHmkVJMWUFuaO80X5Lo+PExr2w
 Haxw==
X-Gm-Message-State: AOJu0YwxukxeBzKzyl1H1jkbCEYeZ4jEWBjWkEnOnsT8mZG6jshvDQ/r
 wIwiYY0jz1B72wDgjQDVKIjQZAUmHBW84XPR+xZJdGiHrLjCuk0shfnggLuyM8gzIrtManRqlFC
 O
X-Gm-Gg: ASbGnct2WEEIM63GH6pyTSbJzuTsL2uvGoFnP05bmHmidYC0iXLUpcRc9I0Esh3spzg
 Bbqzc2RpuVe6YhMWT4Apq2yD9E0mjnOPH/aHkpiRBYvWDhdvJ2Wo2MBYoUvtGDVeyeCdVL2MynN
 jRLFcRvLvpW54jNj7DjOX7mTi9IOnlg3mrOocD/CN2dLywcQWiwC1ZzUGhd3m3cyOe9pVd/dhoP
 u2WkOr4N5tp3w1BLssdhdBLeEgdNc4/1XKlfjDdos5H4FlZDl88I6YGImsYe3mBHRb2KVOnDopw
 aMGUfdy6GCZVef9e7ks44+gq+U3FWMTBhm2FlEnBKiz86NDp
X-Google-Smtp-Source: AGHT+IEF65qQP6bRNdz9nPPLj/PiBd+w/qNxrGCXwXc6vt5YWn2ZWIenkci8DaMCvGGO6SAWWzks/Q==
X-Received: by 2002:a05:620a:278d:b0:7c5:3ca5:58fb with SMTP id
 af79cd13be357-7c579ef5efcmr84192485a.4.1741886252582; 
 Thu, 13 Mar 2025 10:17:32 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb63f598sm11329791cf.32.2025.03.13.10.17.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 10:17:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] onenand: Remove ONENAND_BOOT option
Date: Thu, 13 Mar 2025 11:17:29 -0600
Message-ID: <20250313171729.2126283-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The option ONENAND_BOOT is never set, so remove it. The option
SYS_ONENAND_BOOT was never migrated to Kconfig and any platforms which
supported that have long been removed from the code, so remove the
reference there as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/mach-omap2/omap3/lowlevel_init.S | 4 ++--
 boot/Kconfig                              | 8 --------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3/lowlevel_init.S b/arch/arm/mach-omap2/omap3/lowlevel_init.S
index 1ab9472e1987..5541a4714ac0 100644
--- a/arch/arm/mach-omap2/omap3/lowlevel_init.S
+++ b/arch/arm/mach-omap2/omap3/lowlevel_init.S
@@ -176,10 +176,10 @@ ENTRY(lowlevel_init)
 	ldr	sp, SRAM_STACK
 	str	ip, [sp]	/* stash ip register */
 	mov	ip, lr		/* save link reg across call */
-#if !defined(CONFIG_SYS_NAND_BOOT) && !defined(CONFIG_SYS_ONENAND_BOOT)
+#if !defined(CONFIG_SYS_NAND_BOOT)
 /*
  * No need to copy/exec the clock code - DPLL adjust already done
- * in NAND/oneNAND Boot.
+ * in NAND Boot.
  */
 	ldr	r1, =SRAM_CLK_CODE
 	bl	cpy_clk_code
diff --git a/boot/Kconfig b/boot/Kconfig
index c09a98c3233c..f101200ba7a5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1436,14 +1436,6 @@ config NAND_BOOT
 	  booted via NAND flash. This is not a must, some SoCs need this,
 	  some not.
 
-config ONENAND_BOOT
-	bool "Support for booting from ONENAND"
-	imply MTD_RAW_NAND
-	help
-	  Enabling this will make a U-Boot binary that is capable of being
-	  booted via ONENAND. This is not a must, some SoCs need this,
-	  some not.
-
 config QSPI_BOOT
 	bool "Support for booting from QSPI flash"
 	help
-- 
2.43.0

