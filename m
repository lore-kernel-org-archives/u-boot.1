Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E216C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 12:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A5A83A94;
	Fri,  1 Aug 2025 14:58:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="ZO+fGOBR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23FC83A95; Fri,  1 Aug 2025 14:58:06 +0200 (CEST)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [162.216.242.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8740383A92
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 14:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding; 
 bh=Kmmt4DXqeu4l2QhZORb+JMMHMl8zjuxlN/2ZZQP1M2I=;
 b=ZO+fGOBRmI7zrNbS8fG7SMt8P8G6SV+wFlcXnKvLTjoVfao8r+dQbCk2cMPKEYTzGgFX2kSNojkUVD5N4tJxGDaqJAqdtvUBd1eCBKA6zE+URMlfXoBu8PEPmW+9UMEsFkigqTd7zjIKobKnw6a9j0uWwbZ6sGNwegtk/i6y3OX1gVCuEyJxZSuFSZTU0+eg0khSbzSgZQZapMgidgWPPv+Fs1eR4Eo3GIKMemCby+58iZ0FhGpdKOW3Dc
 vvW0pa5HokwlwqG1AL3ikTNGNrAqtj/VEoNkbG61wT5AHVv15go0UA99Qrbjgeg2xIaBLLBY8BsbX+K5Cg+wI5M2p/WA==
Received: from TkB (188-24-194-92.rdsnet.ro [188.24.194.92])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Fri, 1 Aug 2025 12:57:59 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH] Timers: prevent conflict between ARM Generic Timer and Timer
 drivers
Date: Fri,  1 Aug 2025 12:57:30 +0000
Message-ID: <20250801125730.1485-1-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.49.0
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

Can't enable both CONFIG_SYS_ARCH_TIMER and CONFIG_TIMER_*.
This error occurs:
  ld: lib/time.o: in function `get_tbclk':
  /usr/src/u-boot/lib/time.c:72: multiple definition of `get_tbclk'; arch/arm/cpu/armv7/arch_timer.o:/usr/src/u-boot/arch/arm/cpu/armv7/arch_timer.c:63: first defined here
  ld: lib/time.o: in function `get_ticks':
  /usr/src/u-boot/lib/time.c:87: multiple definition of `get_ticks'; arch/arm/cpu/armv7/arch_timer.o:/usr/src/u-boot/arch/arm/cpu/armv7/arch_timer.c:44: first defined here

This commit makes timer drivers only available when ARM Generic Timer is not selected.
If it's selected, shows a warning explaining why Timers aren't visible.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 arch/arm/Kconfig      | 2 ++
 drivers/timer/Kconfig | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4e7593616d8..afa581dcf78 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -453,6 +453,8 @@ config SYS_ARCH_TIMER
 	  It is mandatory for ARMv8 implementation and widely available
 	  on ARMv7 systems.
 
+	  Note: Timer drivers (CONFIG_TIMER) are unavailable when this timer is selected.
+
 config ARM_SMCCC
 	bool "Support for ARM SMC Calling Convention (SMCCC)"
 	depends on CPU_V7A || ARM64
diff --git a/drivers/timer/Kconfig b/drivers/timer/Kconfig
index cb6fc0e7fda..f1020661dc0 100644
--- a/drivers/timer/Kconfig
+++ b/drivers/timer/Kconfig
@@ -1,8 +1,13 @@
 menu "Timer Support"
 
+comment "Timer drivers are unavailable when ARM Generic Timer (CONFIG_SYS_ARCH_TIMER) is selected."
+	depends on DM
+	depends on SYS_ARCH_TIMER
+
 config TIMER
 	bool "Enable driver model for timer drivers"
 	depends on DM
+	depends on !SYS_ARCH_TIMER
 	help
 	  Enable driver model for timer access. It uses the same API as
 	  lib/time.c, but now implemented by the uclass. The first timer
-- 
2.49.0


