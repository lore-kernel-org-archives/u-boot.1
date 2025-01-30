Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6957BC0218D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 01:21:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E95880AE4;
	Thu, 30 Jan 2025 02:21:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="KxHv7bek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8864080B9B; Thu, 30 Jan 2025 02:21:23 +0100 (CET)
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F81E809D0
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 02:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=1425075683@qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1738200065; bh=za9k61x3IkUiXI5iqMQOG1ZxCUDOqOoZFOx+PMiqveg=;
 h=From:To:Cc:Subject:Date;
 b=KxHv7bekj0Qbi865tTg7CAN8JVRze0SlPhDZlAt5UXr+R5XFSvvJD6PwnHowbxgqL
 Tp14uuSemrOCW9XDYQL9WhJygex/mmYaaw/Yayv7Vq4IlzTcrL7zHasbYixNehqgnv
 MYUtuDlR9DURsYuJalgLay4lmc85igcm+hcR4Bok=
Received: from ubuntu.localdomain ([112.51.40.31])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 54395C80; Thu, 30 Jan 2025 09:21:03 +0800
X-QQ-mid: xmsmtpt1738200063twikr2dfu
Message-ID: <tencent_E08F4B0FE7E0151B543039103D26CCA4B306@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujxLh3e2ZfRj7jnfzwjGcEY4gFS06JReilzec89IwwatU6GdXv9U
 /UdJUGJCbtgPwB60YQvq59O6gip9tpy3AOs+39L/GBSm7iwfzEv9TLDMLVMBDMqqXqnRf3YH1Fdr
 gc3ZLwpGvPDw3F3EyxUx/J9XPJTa6sNBECNxJDcln1I8OagJ8BL+TU74DDzr/Li39Cmk7uZ1D0Cv
 27Q4vfA/1pO5yzh5I/ec2ShI9ASICr1/zOQjNY//P3MbJdjWdDt6iJcPQyfb3eJucKIzvFN3SGk3
 NSaMN9FHnowwQz5sPPY4F09l1VwKEwoWpVJrbZriSEehE5bWBMRILV71riIE1cCQawK30hdYKU1r
 iJtKanNt83VbYtUKh3fe2u15v+QQzvBx64P5b1FEXHLWXPl4AuzukFWzfYGR7gfOcXSJZnGJ1tXM
 hfrVx1Ibn5iVyM5yAZUwbw+1jLg2WPtvSYd4FoBtV3iZSC99FFufLkmQDEf2Kn9W7dJdvWwHh7h5
 DaMA0+z1rN83en6RD+rEpnIIyHjFUUcNjL/0hwaEnmEpn66iKWrMyqQK6UxgBO4njEDyQs4BgjHw
 RKETSY9B0d4v3amwBO6TQR847hW4CyDIbxge8bjx5azeSzsdRci+pn02dIe2k3pT7WOd+48pivtu
 B/053cNUzOsxG9B/SqI8TcBsUBVEpO4fhcpsbn9AP+1SdYEQAb0ZJTMAT86ZE8ivI17TFzWyXrg4
 6tHDw9L05rNiXpJZTPTYoYxwYjc7nASR2F58lYXRcRjUEMefWZU/gKjagmANMU5qgsSxoY190NeR
 Xzgs+1DNo4FJRk9zSns9OhcHEgZ232yQwpjDv9DJVGpVrH6jnMmDZoL4sOS5CyjwRuHaE0zE6Jbr
 8GbOGXH6trILPV5Ay8fvDxFbWvKINFpj+BfFqxO7JvK/8v3KP2UxWMQ+vneNHXA5rWiDar18vol5
 61XJDI9b4hIvK/coNwiLv8dUPsjshNzM5FoGtvuM6HYBYfXazSTQ==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: 1425075683@qq.com
To: Liya Huang <1425075683@qq.com>
Cc: Heiko Schocher <hs@denx.de>, Enrico Leto <enrico.leto@siemens.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v1] arm: Other boards should not show this option in menuconfig
Date: Thu, 30 Jan 2025 09:21:00 +0800
X-OQ-MSGID: <20250130012101.315807-1-1425075683@qq.com>
X-Mailer: git-send-email 2.25.1
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

From: Liya Huang <1425075683@qq.com>

When I was using STM32 board,
this option appeared in menuconfig and caused me trouble.
I observed that the root cause was that
the option was not included in the endif,
but when I tried to fix it,
an error occurred.
I didn't find a solution.
Only deponds can be used for hiding

Signed-off-by: Liya Huang <1425075683@qq.com>
---

Changes in v1:
- Replace depends on ARCH_IMX8 with depends on TARGET_CAPRICORN as suggested

 board/siemens/common/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/siemens/common/Kconfig b/board/siemens/common/Kconfig
index 4ae12b1c973..3808257cd07 100644
--- a/board/siemens/common/Kconfig
+++ b/board/siemens/common/Kconfig
@@ -3,4 +3,5 @@ config FACTORYSET
 
 config DDR_SI_TEST
 	bool "DDR signal integrity test implementations"
+	depends on TARGET_CAPRICORN
 	default y
-- 
2.25.1

