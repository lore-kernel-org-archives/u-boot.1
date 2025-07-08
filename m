Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31003C8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 10:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE1B83018;
	Tue,  8 Jul 2025 12:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1751971251;
	bh=voJettxfqKuUyjtlirTR4RxVXG8FQ/owoSVt8EK6Xsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zfaD6nfJzvIxDSiWZ8pc6UfKAzKltVLXN5XKiM771Fg6m2UbFGHkXeKU09037F6te
	 jefPdgqPsUkl4k/J9nJdznlCD9ki6CDMXanbl1ndwERG39/t/2QtqRJXWhV60VKUBk
	 d4WU3zjziENZnQJPPisO0+IIgZzeS73k6+ZkEiE8GNuO4IVUkEUL8K3uKCKoEz15ET
	 cgkygdKSy4xxUi9NrfOQ7KWzyDtknBnNvApZZKnIIRntzEPcJ0G6nDVtxY71MOqauf
	 7lnMJjTI0oT3YaYWBQ6WiaRakXsEMjHeWPcNeNxfPcottKjQm1sAK7qLHNY6L0AbgO
	 bn4M+hvr6pMOw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B123683018; Tue,  8 Jul 2025 12:40:50 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFBDD83015
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 12:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="VUAGf22v"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E71010380104; 
 Tue,  8 Jul 2025 12:40:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1751971248; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=voJettxfqKuUyjtlirTR4RxVXG8FQ/owoSVt8EK6Xsk=;
 b=VUAGf22vbELjEMNaQiFAZ9dbb5MrrmEzIaLeLOoUgA6gF6v2sDtYukmvBDH/bTy0uUgbmu
 9dB00Dc16nIkR1iJGP9Lh5ci244n2N45Vf/KIor4YCxMVRLpb1cXFz8fVjeEYQ5E6/+hFD
 J6+NxHDAaxN+abtMJmD9lw+dSYvAvWqLWeAwyVilHKOV3D63cAyHxPW1+Vm4h4rOO/BfPl
 7pbUWKJOzi9BiQ3Ec2AT/MK0nSmpIM2PUW9xC0NqMHTJExm7fFFQyV8SFef3r4oQw61+yW
 91XpAloPYsR+sdNL2xEfCCUPeh+xgehKAsp3JmFmsm/MMPo3elC5bIzddkK/HQ==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v4 2/3] mips: serial: Silence "unused variable" warning
Date: Tue,  8 Jul 2025 12:39:58 +0200
Message-Id: <20250708103959.26129-3-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708103959.26129-1-pro@denx.de>
References: <20250708103959.26129-1-pro@denx.de>
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

