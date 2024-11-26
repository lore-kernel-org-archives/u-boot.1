Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CE0D3B98D
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8E1289C7F;
	Tue, 26 Nov 2024 14:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="C3p/F28C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE01989C6B; Tue, 26 Nov 2024 11:51:50 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A96189C6D
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:51:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AQApdUK082697;
 Tue, 26 Nov 2024 04:51:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732618299;
 bh=164T2Ch1X+oW0zav2h60PFR+3gCLwxk/qZg4Vu0unvY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=C3p/F28CPgZjIo8fGtlo4xYmpruz75Prz+TUxl85ezlaECEuLybWOG8a6SDr1cH9K
 ekqoaZ99xBF1x49wL88g/JxR/xPO+JO9RPR9n1XjLNIRHMeR69MRejhLuYlZH3qofr
 jYF8ase5HQycYMBiDCrERcZDnM+A45REr6frNUic=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQApdei095485;
 Tue, 26 Nov 2024 04:51:39 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 04:51:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 04:51:39 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.52])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQApXPQ104864;
 Tue, 26 Nov 2024 04:51:37 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>
CC: <sjg@chromium.org>, <rasmus.villemoes@prevas.dk>, <sr@denx.de>,
 <pbrobinson@gmail.com>, <jonas@kwiboo.se>, <u-boot@lists.denx.de>, Gokul
 Praveen <g-praveen@ti.com>
Subject: [PATCH 1/2] serial: ns16550: Increase scope of ops functions
Date: Tue, 26 Nov 2024 16:21:30 +0530
Message-ID: <20241126105131.43359-2-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126105131.43359-1-g-praveen@ti.com>
References: <20241126105131.43359-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Tue, 26 Nov 2024 14:09:03 +0100
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

Increase scope of ops functions and do some clean up for usage in device
-specific UART drivers.

Remove the static functionality of ops functions and migrate certain macros
to header file for usage in device-specific drivers.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 drivers/serial/ns16550.c | 25 ++++++++-----------------
 include/ns16550.h        | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/serial/ns16550.c b/drivers/serial/ns16550.c
index 3f6860f391..c3b884b6d0 100644
--- a/drivers/serial/ns16550.c
+++ b/drivers/serial/ns16550.c
@@ -12,7 +12,6 @@
 #include <log.h>
 #include <ns16550.h>
 #include <reset.h>
-#include <serial.h>
 #include <spl.h>
 #include <watchdog.h>
 #include <asm/global_data.h>
@@ -158,7 +157,7 @@ static inline int serial_in_dynamic(struct ns16550_plat *plat, u8 *addr)
 
 #endif /* CONFIG_NS16550_DYNAMIC */
 
-static void ns16550_writeb(struct ns16550 *port, int offset, int value)
+void ns16550_writeb(struct ns16550 *port, int offset, int value)
 {
 	struct ns16550_plat *plat = port->plat;
 	unsigned char *addr;
@@ -193,13 +192,6 @@ static u32 ns16550_getfcr(struct ns16550 *port)
 	return plat->fcr;
 }
 
-/* We can clean these up once everything is moved to driver model */
-#define serial_out(value, addr)	\
-	ns16550_writeb(com_port, \
-		(unsigned char *)addr - (unsigned char *)com_port, value)
-#define serial_in(addr) \
-	ns16550_readb(com_port, \
-		(unsigned char *)addr - (unsigned char *)com_port)
 #else
 static u32 ns16550_getfcr(struct ns16550 *port)
 {
@@ -214,7 +206,7 @@ int ns16550_calc_divisor(struct ns16550 *port, int clock, int baudrate)
 	return DIV_ROUND_CLOSEST(clock, mode_x_div * baudrate);
 }
 
-static void ns16550_setbrg(struct ns16550 *com_port, int baud_divisor)
+void ns16550_setbrg(struct ns16550 *com_port, int baud_divisor)
 {
 	/* to keep serial format, read lcr before writing BKSE */
 	int lcr_val = serial_in(&com_port->lcr) & ~UART_LCR_BKSE;
@@ -380,7 +372,7 @@ DEBUG_UART_FUNCS
 #endif
 
 #if CONFIG_IS_ENABLED(DM_SERIAL)
-static int ns16550_serial_putc(struct udevice *dev, const char ch)
+int ns16550_serial_putc(struct udevice *dev, const char ch)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
@@ -400,7 +392,7 @@ static int ns16550_serial_putc(struct udevice *dev, const char ch)
 	return 0;
 }
 
-static int ns16550_serial_pending(struct udevice *dev, bool input)
+int ns16550_serial_pending(struct udevice *dev, bool input)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
@@ -410,7 +402,7 @@ static int ns16550_serial_pending(struct udevice *dev, bool input)
 		return (serial_in(&com_port->lsr) & UART_LSR_THRE) ? 0 : 1;
 }
 
-static int ns16550_serial_getc(struct udevice *dev)
+int ns16550_serial_getc(struct udevice *dev)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 
@@ -420,7 +412,7 @@ static int ns16550_serial_getc(struct udevice *dev)
 	return serial_in(&com_port->rbr);
 }
 
-static int ns16550_serial_setbrg(struct udevice *dev, int baudrate)
+int ns16550_serial_setbrg(struct udevice *dev, int baudrate)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	struct ns16550_plat *plat = com_port->plat;
@@ -433,7 +425,7 @@ static int ns16550_serial_setbrg(struct udevice *dev, int baudrate)
 	return 0;
 }
 
-static int ns16550_serial_setconfig(struct udevice *dev, uint serial_config)
+int ns16550_serial_setconfig(struct udevice *dev, uint serial_config)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	int lcr_val = UART_LCR_WLS_8;
@@ -466,8 +458,7 @@ static int ns16550_serial_setconfig(struct udevice *dev, uint serial_config)
 	return 0;
 }
 
-static int ns16550_serial_getinfo(struct udevice *dev,
-				  struct serial_device_info *info)
+int ns16550_serial_getinfo(struct udevice *dev, struct serial_device_info *info)
 {
 	struct ns16550 *const com_port = dev_get_priv(dev);
 	struct ns16550_plat *plat = com_port->plat;
diff --git a/include/ns16550.h b/include/ns16550.h
index 7f48130008..5d9ff10541 100644
--- a/include/ns16550.h
+++ b/include/ns16550.h
@@ -25,6 +25,7 @@
 #define __ns16550_h
 
 #include <linux/types.h>
+#include <serial.h>
 
 #if CONFIG_IS_ENABLED(DM_SERIAL) ||  defined(CONFIG_NS16550_DYNAMIC) || \
 	defined(CONFIG_DEBUG_UART)
@@ -116,6 +117,15 @@ struct ns16550 {
 #endif
 };
 
+#if CONFIG_IS_ENABLED(DM_SERIAL)
+#define serial_out(value, addr)	\
+	ns16550_writeb(com_port, \
+		(unsigned char *)(addr) - (unsigned char *)com_port, value)
+#define serial_in(addr) \
+	ns16550_readb(com_port, \
+		(unsigned char *)(addr) - (unsigned char *)com_port)
+#endif
+
 #define thr rbr
 #define iir fcr
 #define dll rbr
@@ -225,6 +235,14 @@ void ns16550_putc(struct ns16550 *com_port, char c);
 char ns16550_getc(struct ns16550 *com_port);
 int ns16550_tstc(struct ns16550 *com_port);
 void ns16550_reinit(struct ns16550 *com_port, int baud_divisor);
+int ns16550_serial_putc(struct udevice *dev, const char ch);
+int ns16550_serial_pending(struct udevice *dev, bool input);
+int ns16550_serial_getc(struct udevice *dev);
+int ns16550_serial_setbrg(struct udevice *dev, int baudrate);
+int ns16550_serial_setconfig(struct udevice *dev, uint serial_config);
+int ns16550_serial_getinfo(struct udevice *dev, struct serial_device_info *info);
+void ns16550_writeb(struct ns16550 *port, int offset, int value);
+void ns16550_setbrg(struct ns16550 *com_port, int baud_divisor);
 
 /**
  * ns16550_calc_divisor() - calculate the divisor given clock and baud rate
-- 
2.34.1

