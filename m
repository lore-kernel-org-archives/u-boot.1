Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC058C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 15:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3C66A607E9;
	Thu, 20 Aug 2026 15:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JAVrQBC1xZrm; Thu, 20 Aug 2026 15:54:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787241261;
	bh=HQe1HvIpuXsRhptlZYtO2YR43C8S2roCPtVCJRG5b4c=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u47242e5JZWltTy3dKgB/oR+CJxB+rSGO236oHWVI471LscE26E9zDIMeBQfnmEwI
	 g4+3xk4xRHqctJk8HZeuzjqTJjo9vqZSH7/gW4lmgzKxR0E+I38UXoivRnbhUHyA8R
	 uNucqPZ5i5EyKgLbUd0JFOkySJR3Yj196adDF4eus+rKru2j8TDLIHaoOONHr6Szpl
	 HhwYj2RwRWcIwdGw4mJfTUsTEoudyTfEYqHx4k3wYFPjt7EW04adkSuDAkDSQejqYh
	 bwGERx8odGoTpHrCdix5YBfyb2hzsnBKrYewjr28uVOMiAQS4qRukku7ixdvdjUuY4
	 ZXa3f5EPgvG5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8EA0C607DE;
	Thu, 20 Aug 2026 15:54:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5E2E939E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:37:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BA2860739
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:37:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 72A0bxhiv_vX for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 15:37:40 +0000 (UTC)
X-Greylist: delayed 1388 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 20 Aug 2026 15:37:39 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=jo-so.de
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a03:4000:8:213::1;
 helo=s1.jo-so.de; envelope-from=joerg@jo-so.de; receiver=<UNKNOWN> 
Received: from s1.jo-so.de (unknown [IPv6:2a03:4000:8:213::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C93D56066B
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 15:37:39 +0000 (UTC)
Received: from mail-relay (helo=jo-so.de)
 by s1.jo-so.de with local-bsmtp (Exim 4.98.2)
 (envelope-from <joerg@jo-so.de>) id 1wx4TJ-00000006FuR-2KLU;
 Thu, 20 Aug 2026 17:14:25 +0200
Received: from joerg by tux.jo-so.de with local (Exim 4.100-RC3)
 (envelope-from <joerg@jo-so.de>) id 1wx4TI-00000002alk-3uTX;
 Thu, 20 Aug 2026 17:14:24 +0200
From: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH] rng: Fix build with SPL/TPL
Date: Thu, 20 Aug 2026 17:14:24 +0200
Message-ID: <ef549c4de7c2fb98e1e8554b5c7af761cdd15031.1787238864.git.joerg@jo-so.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 20 Aug 2026 15:54:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The inclusion of the drivers was wrapped by an “if not SPL/TPL”, which
always excluded them from SPL/TPL build.

Signed-off-by: Jörg Sommer <joerg@jo-so.de>
Fixes: 591257b05caba725eb57ceb174317ab4c7e460a7 (rng: Introduce SPL_DM_RNG)
---
 drivers/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 4c7ba741acb..269c3db12e8 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_$(PHASE_)PHY) += phy/
 obj-$(CONFIG_$(PHASE_)PINCTRL) += pinctrl/
 obj-$(CONFIG_$(PHASE_)POWER) += power/
 obj-$(CONFIG_$(PHASE_)RAM) += ram/
+obj-$(CONFIG_$(PHASE_)DM_RNG) += rng/
 obj-$(CONFIG_$(PHASE_)RTC) += rtc/
 obj-$(CONFIG_$(PHASE_)SERIAL) += serial/
 obj-$(CONFIG_$(PHASE_)SPI) += spi/
@@ -132,7 +133,6 @@ obj-$(CONFIG_W1_EEPROM) += w1-eeprom/
 obj-$(CONFIG_MACH_PIC32) += ddr/microchip/
 obj-$(CONFIG_FUZZ) += fuzz/
 obj-$(CONFIG_DM_HWSPINLOCK) += hwspinlock/
-obj-$(CONFIG_$(PHASE_)DM_RNG) += rng/
 endif
 
 obj-y += soc/
-- 
2.55.0

