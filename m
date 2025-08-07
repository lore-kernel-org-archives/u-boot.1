Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BC6C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 07:57:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9851843E3;
	Thu,  7 Aug 2025 09:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754553453;
	bh=WqelV80l5mBCNQcg7GTkpcKwC9jYBX/6VEuPRlGdHUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l1DbSmrrWyAQEJRJFFI3076ZaFwwWk6FHc2ggEH2wQHSTApa7jK11uHzKZNijWhfD
	 wKAeaHdb8xVu92nPRwOUafTkva7t8XtIIr/aUDRRCxHDyJPUFXV5ZeX/Ab/KpInR3m
	 dgxanrJdZ5JHsO0vgp77TtUvBGVXYHVqhV2apYgFR0zJtUpA3urCPtnGTKn7SNQVny
	 dufNTBxk7+mram4DO0JufL5uzXahgmhl6dFFN2O41AzuIFr5DDW4xLaf9PiUvbY4kt
	 Wq8114mOPyw0oG6LfLTH/2+XTKEzASbtyEQRUSM5J2ge4gHLUdpO638L92IzquR6ws
	 5iR0M/eiW4FZg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 503FB83C35; Thu,  7 Aug 2025 09:57:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D322683A92
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="WgOofjTb"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EDFF61038C12A; 
 Thu,  7 Aug 2025 09:57:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754553449; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WqelV80l5mBCNQcg7GTkpcKwC9jYBX/6VEuPRlGdHUs=;
 b=WgOofjTbqLquWI0WbJJ1sFG1tBkvXtKP5vXzTomp6lbQN8UO4+0Hk3nWkUsHnYV6tt0sy3
 KK7ZSUJe4A0GX3YhJLQz3aZSLg2Yt+cfLSDGE+a4G8MmidI42tmNMsqg+vj99NArPEmzni
 HQwQs3QRy4ol7T+2HjP3l3YVy1+hX6NXFDw2rUYxKu31hJZDBNJH60rQtgr5n+2yRq0VVr
 2J3i0z9IYCI8cveJIsvXRWFXgv+uF3xE/d/DxSyxIxunpzxQqF0f9LNcDYeX4fuqUzJwc+
 Fbt6uSKrq6oh6or35T/2RzvDm8lb8D3wDqLR6bWysKG4DcdhTLmg06zlJw0PTQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v6 3/4] mips: serial: Silence "unused variable" warning
Date: Thu,  7 Aug 2025 09:56:52 +0200
Message-Id: <20250807075653.356088-4-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807075653.356088-1-pro@denx.de>
References: <20250807075653.356088-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Before this commit, mtmips_spl_serial_init() caused the following
warning:

  arch/mips/mach-mtmips/mt7628/serial.c:14:23: warning: unused variable ‘base’ [-Wunused-variable]
     14 |         void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
        |                       ^~~~

This happens whenever CONFIG_SPECIFY_CONSOLE_INDEX is unset, which leads
to an effectively empty function:

  void mtmips_spl_serial_init(void)
  {
	  void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
  }

Add the __maybe_unused attribute to silence this warning.

Signed-off-by: Philip Oberfichtner <pro@denx.de>
---

Notes:
    Changes in v6: none
    
    Changes in v5: none
    
    Changes in v4: new

 arch/mips/mach-mtmips/mt7620/serial.c     | 2 +-
 arch/mips/mach-mtmips/mt7621/spl/serial.c | 2 +-
 arch/mips/mach-mtmips/mt7628/serial.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mach-mtmips/mt7620/serial.c b/arch/mips/mach-mtmips/mt7620/serial.c
index 35544b8537e..a6915865e27 100644
--- a/arch/mips/mach-mtmips/mt7620/serial.c
+++ b/arch/mips/mach-mtmips/mt7620/serial.c
@@ -24,7 +24,7 @@ void board_debug_uart_init(void)
 void mtmips_spl_serial_init(void)
 {
 #ifdef CONFIG_SPL_SERIAL
-	void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
+	void __iomem __maybe_unused *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
 
 #if CONFIG_CONS_INDEX == 1
 	clrbits_32(base + SYSCTL_GPIOMODE_REG, UARTL_GPIO_MODE);
diff --git a/arch/mips/mach-mtmips/mt7621/spl/serial.c b/arch/mips/mach-mtmips/mt7621/spl/serial.c
index 5cf093a078a..3f600d778e7 100644
--- a/arch/mips/mach-mtmips/mt7621/spl/serial.c
+++ b/arch/mips/mach-mtmips/mt7621/spl/serial.c
@@ -11,7 +11,7 @@
 void mtmips_spl_serial_init(void)
 {
 #ifdef CONFIG_SPL_SERIAL
-	void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
+	void __iomem __maybe_unused *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
 
 #if CONFIG_CONS_INDEX == 1
 	clrbits_32(base + SYSCTL_GPIOMODE_REG, UART1_MODE);
diff --git a/arch/mips/mach-mtmips/mt7628/serial.c b/arch/mips/mach-mtmips/mt7628/serial.c
index 11a2149e127..88d63f3825b 100644
--- a/arch/mips/mach-mtmips/mt7628/serial.c
+++ b/arch/mips/mach-mtmips/mt7628/serial.c
@@ -11,7 +11,7 @@
 void mtmips_spl_serial_init(void)
 {
 #ifdef CONFIG_SPL_SERIAL
-	void __iomem *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
+	void __iomem __maybe_unused *base = ioremap_nocache(SYSCTL_BASE, SYSCTL_SIZE);
 
 #if CONFIG_CONS_INDEX == 1
 	clrbits_32(base + SYSCTL_GPIO_MODE1_REG, UART0_MODE_M);
-- 
2.39.5

