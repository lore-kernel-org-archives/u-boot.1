Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A42ACDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 14:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9593586CE3;
	Mon, 16 Oct 2023 16:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bI+CXGb7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EB5486B73; Mon, 16 Oct 2023 16:14:19 +0200 (CEST)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E88286484
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 16:14:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 874FE20018;
 Mon, 16 Oct 2023 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1697465657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wsNH4q+2p9UwkgnPXVkFLeyDFNT/tJKDMzIpJzcudgU=;
 b=bI+CXGb7l2hku3Kz3xVo2tYOJZ+LLbm3ObZ7A2bI2yGqT7WQxjiLWpsW4vkX2AW6LUnwPZ
 dnqFC6xXCkm6kezyY+DbNPbU81mU9dgHs65A6tyCHmFCbRAuvqR6Kf7gRiTTAhfQ5aXPZZ
 FcTzytKAxB6YtVwB/dh88XM5o+8m2xFR+9h+FTtm+j3I44VA4+BbuAFgnoOolW/QsTcEh/
 bDrFh5tu+rmBniFg2R/rC2RmfT5Zovg/AyIUQeRrqL80hbxPeWMgh6a6KLkZAKnU0KgMKJ
 jf5CqiaaBeLc9Al3Vc1CMFg13douJ4pCbEz4ipeIPBpmwuicV9p5X49w5RcSMQ==
From: Thomas Richard <thomas.richard@bootlin.com>
To: u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, thomas.richard@bootlin.com,
 gregory.clement@bootlin.com, u-kumar1@ti.com
Subject: [PATCH 2/9] configs: j7200_evm_r5: Used reserved memory in DDR for
 stack
Date: Mon, 16 Oct 2023 16:11:28 +0200
Message-Id: <20231016141135.325698-3-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231016141135.325698-1-thomas.richard@bootlin.com>
References: <20231016141135.325698-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Mailman-Approved-At: Mon, 16 Oct 2023 16:15:29 +0200
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

From: Gregory CLEMENT <gregory.clement@bootlin.com>

When resuming from suspend to ram, we load again the DM firmware.
However, we have to be sure to not modify the memory used by
Linux.

Currently the SPL stack in DDR was in place that could be used by
Linux. Instead of it use a memory address that is located in a
reserved location that won't be used by Linux.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---

 configs/j7200_evm_r5_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index c4dd33627b..7450529d66 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -20,7 +20,7 @@ CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_SPL_STACK_R_ADDR=0x82000000
+CONFIG_SPL_STACK_R_ADDR=0xa5300000
 CONFIG_SPL_FS_FAT=y
 CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
-- 
2.39.2

