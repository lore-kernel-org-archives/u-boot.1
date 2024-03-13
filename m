Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10252C54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 10:56:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4134487EBD;
	Wed, 13 Mar 2024 11:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=126.com header.i=@126.com header.b="gdhe57pu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24FF187DF1; Wed, 13 Mar 2024 06:48:39 +0100 (CET)
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
 by phobos.denx.de (Postfix) with ESMTP id 41DAB8792D
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 06:48:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lhdjply@126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=RJVGg
 ztzQ6Atr9Iltqpn6Tqq9KgQV+ffa8pZbUaor30=; b=gdhe57puOG7trbWEmE9Gi
 ZHjp0qSx+jUBt/eT6yXJ5qDLIQljnt2O/Dgnzi91zuXXMyARz4bQ3odhEliSlmj5
 gP3uRzRuj9Z/TWIZBBlsUFsdhe41kXb6bnk7fm09Og2jKDA0rx+vIlBWjkf4lKD3
 +1j9lSbII7GDKpuMZHaAIA=
Received: from localhost.localdomain (unknown [115.221.220.140])
 by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3n4yOPfFlK1zdAA--.2313S2; 
 Wed, 13 Mar 2024 13:45:51 +0800 (CST)
From: lhdjply@126.com
To: jagan@amarulasolutions.com,
	andre.przywara@arm.com,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	lhdjply <lhdjply@126.com>
Subject: [PATCH-V2] arm:suniv:complete the serial port configuration of Suniv
Date: Wed, 13 Mar 2024 13:45:46 +0800
Message-Id: <20240313054546.284435-1-lhdjply@126.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3n4yOPfFlK1zdAA--.2313S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF43XFWkZF17Xr13GFW5GFg_yoW8Zr4fp3
 W2va4agr15WF1a9FZ7Ar4Ivr45Ja17JwnrKwnrJa1jv3WDGw48Jr1rKrn8Cw1FvrZ3Zw4f
 Wr1kua15X34kZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uwo7_UUUUU=
X-Originating-IP: [115.221.220.140]
X-CM-SenderInfo: hokgy1lo16ij2wof0z/1tbi2w+g2mVLZWFfUgAAsJ
X-Mailman-Approved-At: Wed, 13 Mar 2024 11:56:10 +0100
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

From: lhdjply <lhdjply@126.com>

Due to the different serial ports used by each board, 
the serial IO configuration needs to be improved.

Signed-off-by: lhdjply <lhdjply@126.com>
---
 arch/arm/mach-sunxi/board.c | 4 ++--
 include/sunxi_gpio.h        | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index f4dbb2a740..b91c9629e4 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -151,8 +151,8 @@ static int gpio_init(void)
 	sunxi_gpio_set_cfgpin(SUNXI_GPE(3), 6);
 	sunxi_gpio_set_pull(SUNXI_GPE(3), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUNIV)
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPE_UART0);
-	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPE_UART0);
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(2), SUNIV_GPA_UART1);
+	sunxi_gpio_set_cfgpin(SUNXI_GPA(3), SUNIV_GPA_UART1);
 	sunxi_gpio_set_pull(SUNXI_GPA(3), SUNXI_GPIO_PULL_UP);
 #elif CONFIG_CONS_INDEX == 2 && defined(CONFIG_MACH_SUN5I)
 	sunxi_gpio_set_cfgpin(SUNXI_GPG(3), SUN5I_GPG_UART1);
diff --git a/include/sunxi_gpio.h b/include/sunxi_gpio.h
index db3742c039..51258e3dd9 100644
--- a/include/sunxi_gpio.h
+++ b/include/sunxi_gpio.h
@@ -108,6 +108,8 @@ enum sunxi_gpio_number {
 #define SUN8I_H3_GPA_UART0	2
 #define SUN8I_H3_GPA_UART2	2
 
+#define SUNIV_GPA_UART1		5
+
 #define SUN4I_GPB_PWM		2
 #define SUN4I_GPB_TWI0		2
 #define SUN4I_GPB_TWI1		2
@@ -130,12 +132,16 @@ enum sunxi_gpio_number {
 
 #define SUNXI_GPD_LCD0		2
 #define SUNXI_GPD_LVDS0		3
+#define SUNIV_GPD_UART1		3
+#define SUNIV_GPD_UART2		3
 
 #define SUNIV_GPE_UART0		5
+#define SUNIV_GPE_UART2		3
 
 #define SUNXI_GPF_SDC0		2
 #define SUNXI_GPF_UART0		4
 #define SUN8I_GPF_UART0		3
+#define SUNIV_GPF_UART0		3
 
 #define SUN4I_GPG_SDC1		4
 #define SUN5I_GPG_SDC1		2
-- 
2.34.1

