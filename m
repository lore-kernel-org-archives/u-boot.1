Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9172FF53D90
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 20:02:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 857398419E;
	Mon, 16 Mar 2026 21:02:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=psihoexpert.ro header.i=@psihoexpert.ro header.b="t/B5gTQR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF15B8419E; Mon, 16 Mar 2026 21:02:34 +0100 (CET)
Received: from mx1.wiredblade.com (mx1.wiredblade.com [72.51.58.38])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FCFF8419E
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 21:02:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=psihoexpert.ro
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m95d+git@psihoexpert.ro
dkim-signature: v=1; a=rsa-sha256; d=psihoexpert.ro; s=dynu;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=cZb9tl31YkoA+vTrMmywm6IosBaw8JHfbS8bYXOgBaw=;
 b=t/B5gTQR8QGfdPWT7st6loB3xiDGBPoxiWZ8qP16q/Fz0PRdC/UdUdlh6auUQTJy4PW54hYiPcNT65HT19/NoreLZitXMzs8jIKFa+/wtYhC+v8c401qlyV+g/qt7qS5U+5jRXCZoomyjl0grDvKO2lQ+vfqno/oHAsigQe/b6I9xci1bfKYYrsdkdIoBvQOH0wp6i9JFdHjjH4tVAhP32LLnXwF0QWZKlq0hahMTS/3BhcxtmYGyjVMt2
 Q4MTu08vEXlE6to2p6TK3ClWBPK0jvFRDGSkuImy4h+rscCPV3ytBcg2vMunBV5rnvTz2M9HkOs02jS+hybLJhhY2ntg==
Received: from TkB (188-24-192-137.rdsnet.ro [188.24.192.137])
 by mx1.wiredblade.com with ESMTPSA
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256)
 ; Mon, 16 Mar 2026 20:02:24 +0000
From: Marius Dinu <m95d+git@psihoexpert.ro>
To: u-boot@lists.denx.de
Cc: Marius Dinu <m95d+git@psihoexpert.ro>
Subject: [PATCH resend 1/1] Timers: prevent conflict between ARM Generic Timer
 and Timer drivers
Date: Mon, 16 Mar 2026 22:03:54 +0200
Message-ID: <20260316200751.3024-2-m95d+git@psihoexpert.ro>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260316200751.3024-1-m95d+git@psihoexpert.ro>
References: <20260316200751.3024-1-m95d+git@psihoexpert.ro>
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
If it's selected, shows a message explaining why timers aren't visible.
The message should avoid the confusion that an empty Timers menu may cause.

Signed-off-by: Marius Dinu <m95d+git@psihoexpert.ro>
---
 arch/arm/Kconfig      | 2 ++
 drivers/timer/Kconfig | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3db5474a05b..534a649d521 100644
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
index f9511503b02..3be8bfe9e42 100644
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
2.52.0


