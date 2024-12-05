Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E91BE77173
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 20:36:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99AD88922D;
	Thu,  5 Dec 2024 21:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="LUfqSRD1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 247028954F; Thu,  5 Dec 2024 21:36:26 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B09D88F92
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 21:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-111-009.46.114.pool.telefonica.de
 [46.114.111.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 564093F212; 
 Thu,  5 Dec 2024 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1733430983;
 bh=7gDwzzZa4LBEGJCSLGZXwh29VA818/CY0vHuQXCwtJQ=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=LUfqSRD1UyC/AuK1xEqmjWbzGnPPUayu6tqZFIIDpemMzTcEJZSyC9xuBKquetIcZ
 92oySwfeNPyB3GmUGsAgMp5XehXt5Wy1iwj2ORP4gdQ+DY1mUlq8DRCIQi5OIcKGjR
 YWZn0KHaSWRbNYH+cxyBZqFGkrhFlu9NmHUj7o15RRr58D+/BbOSlMHUwrXYjsoBL7
 afoXY0XyEQbFw2tveHXmFQMMYH7t3xVqaD2XT+u/0rQBlwbm5AuFQ7EPPCoV9FW9Gz
 k5N8jPTBZQbIpBZhtajKvQhkPx+EixZj2daokAmcrxeG1C7F/4Gvx7T1SxzZQBKPdk
 3LBjh3+4Ev1xw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, David Feng <fenghua@phytium.com.cn>,
 Linus Walleij <linus.walleij@linaro.org>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Liviu Dudau <liviu.dudau@foss.arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] rtc: CONFIGS_RTC_PL031 must depend on CONFIGS_DM_RTC
Date: Thu,  5 Dec 2024 21:36:19 +0100
Message-ID: <20241205203621.45806-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

Building qemu_arm64_defconfig with CONFIGS_DM_RTC=n and CONFIGS_RTC_PL031=y
leads to a build failure.

Adjust the vexpress64 configuration to avoid circular dependency.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
    Adjust the vexpress64 configuration to avoid circular dependency.
---
 board/armltd/vexpress64/Kconfig | 2 +-
 drivers/rtc/Kconfig             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index cf998096e45..584b5455e97 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -16,8 +16,8 @@ config VEXPRESS64_BASE_MODEL
 	select VIRTIO_BLK if VIRTIO_MMIO
 	select VIRTIO_NET if VIRTIO_MMIO
 	select DM_ETH if VIRTIO_NET
+	imply DM_RTC
 	imply RTC_PL031
-	select DM_RTC if RTC_PL031
 	imply EFI_SET_TIME if DM_RTC
 	select LINUX_KERNEL_IMAGE_HEADER
 	select POSITION_INDEPENDENT
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 7fc53a6d61e..9c2d1398247 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -203,6 +203,7 @@ config RTC_RX8025
 
 config RTC_PL031
 	bool "Enable ARM AMBA PL031 RTC driver"
+	depends on DM_RTC
 	help
 	  The ARM PrimeCell Real Time Clock (PL031) is an optional SoC
 	  peripheral based on the Advanced Microcontroller Bus Architecture
-- 
2.45.2

