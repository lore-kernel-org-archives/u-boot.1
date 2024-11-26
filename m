Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10881D3B98D
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 13:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8488A89C84;
	Tue, 26 Nov 2024 14:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="e3JJKlvo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75B9A89C53; Tue, 26 Nov 2024 11:51:52 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40ACC89C64
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:51:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=g-praveen@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQAphIa824382
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Nov 2024 04:51:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732618303;
 bh=kzc7j5Xo+VXqfQsETmPgPELxp6S4ulN8/tEFDCSkSeA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=e3JJKlvoOh6FStskFHoElKah57R0QiF5nLWvaUDM3yv9kL/cHFVmqObxLIUMwW8gA
 mlXMjx/10TjRisi6rCzRb8PfiRIlxdPgI3VsdUYwGDfR3C46LWwNcA446h2hSoQGSF
 3AziWG9B884xyU8QMzldIGkWFvcJvMOktix4TgLQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AQAphp8013777
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Nov 2024 04:51:43 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Nov 2024 04:51:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Nov 2024 04:51:43 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.52])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AQApXPR104864;
 Tue, 26 Nov 2024 04:51:40 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>
CC: <sjg@chromium.org>, <rasmus.villemoes@prevas.dk>, <sr@denx.de>,
 <pbrobinson@gmail.com>, <jonas@kwiboo.se>, <u-boot@lists.denx.de>, Gokul
 Praveen <g-praveen@ti.com>
Subject: [PATCH 2/2] drivers: serial: serial_omap: Fix TI OMAP UART U-Boot
 driver to support higher baudrates
Date: Tue, 26 Nov 2024 16:21:31 +0530
Message-ID: <20241126105131.43359-3-g-praveen@ti.com>
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

Move to OMAP specific implementation of certain ops functions as the UART
prints on the serial console fail for baudrates greater than 460800.

The MDR1 register is responsible for determining the speed mode at which
the UART should operate for OMAP specific devices. The baud divisor is used
to set the UART_DLL register which is used for generation of the baud
clock in the baud rate generator. The implementation logic is similar to
how it is implemented in omap_8250_get_divisor function of 8250_omap UART
linux driver.

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 drivers/serial/serial_omap.c | 56 +++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/serial/serial_omap.c b/drivers/serial/serial_omap.c
index 94672655c2..224d9cbf29 100644
--- a/drivers/serial/serial_omap.c
+++ b/drivers/serial/serial_omap.c
@@ -15,6 +15,12 @@
 #include <clk.h>
 #include <linux/err.h>
 
+/*
+ * These are the definitions for the MDR1 register
+ */
+#define UART_OMAP_MDR1_16X_MODE		0x00	/* UART 16x mode */
+#define UART_OMAP_MDR1_13X_MODE		0x03	/* UART 13x mode */
+
 #ifndef CFG_SYS_NS16550_CLK
 #define CFG_SYS_NS16550_CLK  0
 #endif
@@ -151,6 +157,54 @@ static const struct udevice_id omap_serial_ids[] = {
 };
 #endif /* OF_REAL */
 
+static int omap_serial_calc_divisor(struct ns16550 *com_port, int clock, int baudrate)
+{
+	unsigned int div_13, div_16;
+	unsigned int abs_d13, abs_d16;
+	/*
+	 * The below logic sets the MDR1 register based on clock and baudrate.
+	 */
+	div_13 = DIV_ROUND_CLOSEST(clock, 13 * baudrate);
+	div_16 = DIV_ROUND_CLOSEST(clock, 16 * baudrate);
+
+	if (!div_13)
+		div_13 = 1;
+	if (!div_16)
+		div_16 = 1;
+
+	abs_d13 = abs(baudrate - clock / 13 / div_13);
+	abs_d16 = abs(baudrate - clock / 16 / div_16);
+
+	if (abs_d13 >= abs_d16)
+		serial_out(UART_OMAP_MDR1_16X_MODE, &com_port->mdr1);
+	else
+		serial_out(UART_OMAP_MDR1_13X_MODE, &com_port->mdr1);
+
+	return abs_d13 >= abs_d16 ? div_16 : div_13;
+}
+
+static int omap_serial_setbrg(struct udevice *dev, int baudrate)
+{
+	struct ns16550 *const com_port = dev_get_priv(dev);
+	struct ns16550_plat *plat = com_port->plat;
+	int clock_divisor;
+
+	clock_divisor = omap_serial_calc_divisor(com_port, plat->clock, baudrate);
+
+	ns16550_setbrg(com_port, clock_divisor);
+
+	return 0;
+}
+
+const struct dm_serial_ops omap_serial_ops = {
+	.putc = ns16550_serial_putc,
+	.pending = ns16550_serial_pending,
+	.getc = ns16550_serial_getc,
+	.setbrg = omap_serial_setbrg,
+	.setconfig = ns16550_serial_setconfig,
+	.getinfo = ns16550_serial_getinfo,
+};
+
 #if CONFIG_IS_ENABLED(SERIAL_PRESENT)
 U_BOOT_DRIVER(omap_serial) = {
 	.name	= "omap_serial",
@@ -162,7 +216,7 @@ U_BOOT_DRIVER(omap_serial) = {
 #endif
 	.priv_auto	= sizeof(struct ns16550),
 	.probe = ns16550_serial_probe,
-	.ops	= &ns16550_serial_ops,
+	.ops	= &omap_serial_ops,
 #if !CONFIG_IS_ENABLED(OF_CONTROL)
 	.flags	= DM_FLAG_PRE_RELOC,
 #endif
-- 
2.34.1

