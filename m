Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A822C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 12:39:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2424482BCD;
	Wed, 30 Jul 2025 14:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1753879149;
	bh=qeTimwQAGpYVw+hMcZWmQdTvBn4C/pMrBRkI8R096j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zZkM94BDiQqhwW3F9zcnNGKgeLJMBgTO2dZqPvMP/bDD1+TMvqg86ToBf7Lvv25Nb
	 Zhs+Nu967r+hiKg5m6OEXIprUtDAXlyhSFG/X6UYAzA581ddky3Q24DCHgqO3o2Tgf
	 vSgih1KmolTgEMRGbu5IFAF+DCanniMaOHQLqpcM6/SKPSwAJZUwsks6glboLMW+Vb
	 0UvGZoO10UkB123uZytAFOsvcUxpZJhuUNY1aIeviPNa3TvK7Nj2C/1KGutN6UD5vT
	 gDCZDoa/DXbJA5LNk7bVX4oZariyqmjlrd7N+P4ieEDpWImRBk/AJxtNe6DAImtzbv
	 b4cRVMq6JAdiw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A67D8304F; Wed, 30 Jul 2025 14:39:07 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 857A98004F
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 14:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pro@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Ts/C4K86"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9CB161038C126; 
 Wed, 30 Jul 2025 14:39:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1753879145; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=qeTimwQAGpYVw+hMcZWmQdTvBn4C/pMrBRkI8R096j8=;
 b=Ts/C4K86n2QGu3TirDyqNLSPrXGnosnKqphV+kmO4/32FjFBtSEUjZVB8pK2TcKuhcx5Of
 PD+47g0g5ot9iJ4SezYBbTmOwix3ok01z0ZI4G+2nC3t9x+ZRuyblrguDZrHbu0CrYULva
 A2iJoEDrp+3p6m5ztW2s3q2qcLFmbJ+PEsn007omRyYjt3+D3AsynZe/AubNkk+/S8yfJa
 /eEzoHF/4f9UQB67u/sVu2vpaRvJvliXF9On/yFtDZMCMK0eq+Zw4VFD/VnY3lxi+g4mXx
 HbGHpRH2v7SOf9DqHMN+WUXTtRokBR9pTA7+fD6m48iprfWZnhOmiGKrc3+/3g==
From: Philip Oberfichtner <pro@denx.de>
To: u-boot@lists.denx.de
Cc: Philip Oberfichtner <pro@denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>,
 Weijie Gao <weijie.gao@mediatek.com>
Subject: [PATCH v5 3/4] mips: serial: Silence "unused variable" warning
Date: Wed, 30 Jul 2025 14:38:32 +0200
Message-Id: <20250730123833.249923-4-pro@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730123833.249923-1-pro@denx.de>
References: <20250730123833.249923-1-pro@denx.de>
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

