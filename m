Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028A1C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 13:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AD9B4605AC;
	Wed, 26 Aug 2026 13:42:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id n2BCcxku2fJB; Wed, 26 Aug 2026 13:42:37 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787751757;
	bh=9NRfj5qf9geV85zllQj2XfF+91bM5oJa2cn2lo9pPHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ri7uDLJKbTaGxIBtyyncR4R7fmwcagv4/lRZozv+WNEFtsDPI14M2wDRcMxXey6k2
	 PGDhQU9WEHIlwzUQoLpjLrKdWkfqHgKbYgRHbe7v8X6+GzBURHKLmwGUemT+IDQs8s
	 3l7SAXwzo7lrmhw+/3Y6hVNHOoqdmK7L5NcsCXg1SiynoWOMavXJztN6saNqRKJOmO
	 tARFdop62H7zCtl2nOY0Ts9kkmeOpIT1p5WghBuh0xer2taLapaJ8x/LUtbcnx6bjZ
	 wM5NSkQAf911Q0QRYnoR+IqjH9prh7tx7gQjjnzv1E9KaDLd6FkctQvpz45hQOR0em
	 IJIhCRuG5lQ4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88DCC60770;
	Wed, 26 Aug 2026 13:42:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3A4273C3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1B3FC605E1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bF6d8ON4lYLJ for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 13:35:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=ZO6/86cW
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp3.osuosl.org (Postfix) with ESMTPS id A626E6067B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751297; bh=9NRfj5qf9geV85zllQj2XfF+91bM5oJa2cn2lo9pPHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=ZO6/86cWlyMGXbv9rbbehLB2PQqCUKh5u4t15NRBokyAVMYct85lQtqHDYXzcuk/I6yKtCbhv6B1oknMfq8rcmm4lQY3Ab8zRk/xosD0/H62TlAH/SAF3SumvvKWpupEu7oLVVm73+jyy3omeLScDkv/UZUvQHE5Odo+1vEO7n3O4/nUtZrcK3qi5Xw0ylbKYOlKhAhKJXy60V9s4/3DPvwm0obJV/X7m3GgTKWNu599vnXXgV22TfEmPnnJgY2x8qsVnbSigRmsT9sEdFEQupyxTDEi8C4pKGeTJkDklDWMNCm66txQwv43NQ6iWwiELNoMJeXKQtdrs/zhwAW5Ow==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787751297; bh=2CY0Z0JE69tMIKSXr2LlefldnQyyi9P4/4OTHISLe8O=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=b7ObYK8mJDQobn2UXH3xnlCCO8UfH6LxEhT4Lp37XNZ78qdh1cAXT+UhCPbMBqs9NtolC5oR1qQyBga2lts9vrrS9V4vQOICfrrSIpzs88Iut1TR2Pnvoo4LjJ9dIElBHeDGXCn/kwLQjBv9TvKYfJr9VWHLD9VSX6roDAnquKl+LO1dLpIonGRdvlCBcPC/thzxFpu4+3MlCp6RioDCsWDdEbDgQ7ycJBviorq54bHu56GCifWErev0ncYb+WCu7LQDIIR7P6AzV71i0FLJ1zsGI9mLjXc2ik4pTFR6SsI0EjrUzqnz2wfYK71Augk1jrfv8zs5LFi9Ehcw66SdUw==
X-YMail-OSG: CaQNJWcVM1kbM8VFDAHU1mO_WM.Yox7nX7P_ALavT5FumBz3A5x6gEKyaYQAL_X
 eUGCA_meMzTwMEJ6hQtKstV0G5QuimKdSEJ27bddx6nSRLRpS0Xqp0DhkUG0wgtFkVAQrNiLIMdJ
 Bfp_dydqZrmYg_9NMAEfRjD2Z.W5qZ5hwOzhZEVmMVsQJRj2c3EgIhGhhSSnPBmKzFv0SKp_ZH.m
 UvGg0ONPKF2bDa7zS_TUvkizSAiUuHvcWATIcS7g_dOGPmWwYj8l0AfdksQMctDrC7cNshXJzcSh
 zyy4viQcYfF2lGWKuUHlu4VnbLGRRcF_7B4raOFRxgh2lweTOr2PVTtlWlz0WHSD2vnwoQGUlrJG
 s5h1dpMBBwc9zQ8cCCw3f8h9DbX0XMMxIUOb5lX1JeQRsFInhkGuUHibqGRFBhVuovIoxSALq6n4
 hN5GejyQO9kdOokG.JeRWCyv1Qsd4jcbo4qB9sJAnhgWoKJwDfE.vCRx6nWze8bQ5AYA3Y8ODL6v
 rR1581DfH.k0RUxdOcE.vDaxDyx55gJ5iJFKfNhLdrUOBe3nA2eiZDacV1L7ZN29oMy9SXHTWbbU
 FaP_6Hos_xnUcUg.06kzxzX.4j5N3yrcYFWH62zj0WILpnD8PuxAba0SUb64ABSP4kPBeQTvlqwz
 KWdS8Dbzq69mFNhkjVAX81c1e5CfyqMLbs9ADF.w.PBGnF_QG5yq5dlqP1gBlGhxPju.uzrEVpyX
 982AevNcduYAOq1t_iNR.RPyasZPoniWP7Z6TtTgKtHgbKOiXpOAxyqYuu_rUhpS6SNik888nLK.
 lwH.zyDL4G4ex0d9afV.KmDpWdiD08M..6oRjzoDWxRXHXcl11YVmw4yB2YzP1jF6LFfuiF0aiXF
 FYAPFRrFi_5pCuEXh4QMPAqqzGhokWAa7WxfRBxgIcL84BHNBKSQX657FV9rJQtZHwR.lbekdgAk
 MV0Vr5Mr.3qh4KaZFONgcHYdqTpVIDDeRDHsqnWKlKxLtcI1kJSZ8a6G8kKEqfutRvYC5vdgxsb1
 ENLHvWTfH1Uy8pxQe8xa8oJ28P0fcchr1KDC9C._RS2imwGzCpDk4uNU6agavLWfpJJLVDGidSOd
 ITzlfy6ZJuioEK1cNjYC7DK4VoIXDH9LzlAruuptaHnzWu29pTiTZksF.zzFPtdzwXKCwNH1hIyy
 TDjUHGxXNRwbF32ggPK_U5k7nxv4rCSNRhA00nbf9Ot.fDVwOdsraQFcD7rvxluCrQrpdwZndMpc
 C_35SJr03U2EWdUxlyyTBWLBdoC_xMzhOCf.y36uY.EGLHj7.KYYO0Uxi3rnJAuHY1IBk3ZhpwU3
 qF2vu_kS15GSue0ObTKjR4KXF.yyfa7bKcId7MXGJcPaO9pUEPHgjqxx1H7KIpnd3oYDNo5ktCUG
 Ud6aGyJkOcyjOksMBGR2m85f8fRQ0McC7hozTRSZ7vXVKbhPjrfQJ6nza3Ce74BoGvSI0qY6mKRM
 NsvVYx.4YzRZdpuwLhrOyrpHVYF.dld.ULCpq614ELvRAVqviKQBnOqjYvYNkRvWOOisUf9N31lW
 Lp6X88.fw1rj8hM77D0UTGlcM9PMcwLkSDX8Dqv_elwLvQGyOnMcCr5XPswrqYcw3b2J4Rw.vdcY
 UluJepJiW_zsQFz8.b.4t81N_fJW4xO1.000H9d8nsSBYNROaemYjQXX7q_UBWKb1hcO99GWmM8k
 rjjnlMdpK4Za8rlSh1h74RTfXY1XsZ_tc1oo8iPhVE4ZDDCbAW920s1EaV.cIN4Z69ZOHeDlOe1N
 P9pr6hfsyzryWa0VmFkw9NGfg5a3Yu1YNY.uMi2R.O1UWliB48mjCwWrxShYy7QOCpxI3rtGJZT1
 mLhL8hgynfVy3MGgfj8i8qqpGNqMTVb7VzgrHmCA5v_NWz_sCo9FMuAZu9R.r3Jaw1h7O07nbUKR
 B4dMxEKB.c.iGtMSY7A37NZYO6mmXfwu1qit8OO7AfgZK0NCox4IFVpK2EboKjlPZEDoUmncoqUN
 iE6MZTw7hLXKQik30sS922cXFov_hMh6drjN.P6MURu9ju8qpHaY.2Bi7dueZsXPnPEhPHVbWbA-
 -
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 05c8640e-277e-485b-beaf-1ae509cc3f17
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP;
 Wed, 26 Aug 2026 13:34:57 +0000
Received: from dip100.lsn.sg3.yahoo.com ([106.10.223.109])
 by hello (SMTP) with SMTP ID acc4f7a299298e219e9ccf723c2619d7;
 Wed, 26 Aug 2026 13:34:54 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v2 3/9] serial: en75xx: add EcoNet/Airoha EN75xx UART driver
Date: Wed, 26 Aug 2026 19:04:37 +0530
Message-ID: <20f5028c61e71453b4f0a497bfec72eff7528683.1787736704.git.maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787736704.git.maskachoska@yahoo.com>
References: <20260825222211.712836-1-maskachoska@yahoo.com>
 <cover.1787736704.git.maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 13:42:25 +0000
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

Add a DM serial driver for the 16550-style UART on the EcoNet/Airoha
EN75xx SoCs. The block uses a fractional (X/Y) baud-rate divider rather
than the classic DLL/DLM divisor, and is accessed big-endian on the
EN7512/EN7521 and little-endian on the EN7528; the driver handles both.

Signed-off-by: AK Sharma <maskachoska@yahoo.com>
---
 drivers/serial/Kconfig         |   7 ++
 drivers/serial/Makefile        |   1 +
 drivers/serial/serial_en75xx.c | 170 +++++++++++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/serial/serial_en75xx.c

diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 5f8b98f0..2a8fee98 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -1098,6 +1098,13 @@ config ZYNQ_SERIAL
 	  This driver supports the Cadence UART. It is found e.g. in Xilinx
 	  Zynq/ZynqMP.
 
+config EN75XX_SERIAL
+	bool "EcoNet/Airoha EN75xx serial port support"
+	depends on ARCH_EN75XX
+	help
+	  Support the byte-lane 16550-like UART used by EN7512/EN7521/EN7528.
+	  The controller also uses a vendor-specific fractional divider.
+
 config MTK_SERIAL
 	bool "MediaTek High-speed UART support"
 	depends on DM_SERIAL
diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
index 66088b44..75ec49b7 100644
--- a/drivers/serial/Makefile
+++ b/drivers/serial/Makefile
@@ -55,6 +55,7 @@ obj-$(CONFIG_OWL_SERIAL) += serial_owl.o
 obj-$(CONFIG_OMAP_SERIAL) += serial_omap.o
 obj-$(CONFIG_MTK_SERIAL) += serial_mtk.o
 obj-$(CONFIG_MT7620_SERIAL) += serial_mt7620.o
+obj-$(CONFIG_EN75XX_SERIAL) += serial_en75xx.o
 obj-$(CONFIG_HTIF_CONSOLE) += serial_htif.o
 obj-$(CONFIG_SIFIVE_SERIAL) += serial_sifive.o
 obj-$(CONFIG_XEN_SERIAL) += serial_xen.o
diff --git a/drivers/serial/serial_en75xx.c b/drivers/serial/serial_en75xx.c
new file mode 100644
index 00000000..e578be06
--- /dev/null
+++ b/drivers/serial/serial_en75xx.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* EcoNet/Airoha EN75xx UART */
+
+#include <dm.h>
+#include <errno.h>
+#include <serial.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+/* 16550 register indices (the byte/word offset is derived per SoC below) */
+#define R_RBR		0	/* THR / DLL when DLAB=1 */
+#define R_IER		1	/* DLM when DLAB=1 */
+#define R_FCR		2
+#define R_LCR		3
+#define R_MCR		4
+#define R_LSR		5
+#define R_MISCC		9
+#define R_XYD		11	/* EN7512 fractional divider (32-bit) */
+
+#define UART_LCR_DLAB	0x80
+#define UART_LCR_8N1	0x03
+#define UART_LSR_DR	0x01
+#define UART_LSR_THRE	0x20
+
+struct en75xx_serial_plat {
+	void __iomem *base;
+	bool le;		/* EN7528: little-endian, 32-bit word access */
+	u32 uartclk;		/* EN7528 UART source clock (0 => EN7512) */
+};
+
+/*
+ * EN7512 (big-endian): the 8-bit registers live in the top byte of each
+ * 32-bit word, i.e. byte offset (reg << 2) + 3, byte access.
+ * EN7528 (little-endian, reg-io-width=4, reg-shift=2): 32-bit word access at
+ * (reg << 2), value in the low byte.
+ */
+static u8 uart_rd(struct en75xx_serial_plat *plat, u32 reg)
+{
+	if (plat->le)
+		return readl(plat->base + (reg << 2)) & 0xff;
+
+	return readb(plat->base + (reg << 2) + 3);
+}
+
+static void uart_wr(struct en75xx_serial_plat *plat, u32 reg, u32 val)
+{
+	if (plat->le)
+		writel(val, plat->base + (reg << 2));
+	else
+		writeb(val, plat->base + (reg << 2) + 3);
+}
+
+static void en75xx_serial_hw_init(struct en75xx_serial_plat *plat,
+				  int baudrate)
+{
+	if (baudrate <= 0)
+		baudrate = CONFIG_BAUDRATE;
+
+	/*
+	 * EN7512 (BE) and EN7528 (LE) share the divider: Y=65000,
+	 * X=round(baud*13/25), packed into the 32-bit XYD reg (11 @ +0x2c)
+	 * as {X[31:16],Y[15:0]}. 16-bit regs go through uart_wr()
+	 * (endian-correct); the XYD store is a native 32-bit write, valid
+	 * on both. For example, XYD == 0xEA00FDE8 at 115200.
+	 */
+	u32 div_x = DIV_ROUND_CLOSEST((u32)baudrate * 13, 25);
+
+	if (div_x > 0xffff)
+		div_x = 0xffff;
+
+	uart_wr(plat, R_LCR, UART_LCR_DLAB);
+	__raw_writel((div_x << 16) | 65000, plat->base + (R_XYD << 2));
+	uart_wr(plat, R_RBR, 1);
+	uart_wr(plat, R_IER, 0);
+	uart_wr(plat, R_LCR, UART_LCR_8N1);
+	uart_wr(plat, R_FCR, 0x0f);
+	uart_wr(plat, R_MCR, 0);
+	uart_wr(plat, R_MISCC, 0);
+	uart_wr(plat, R_IER, 0);
+}
+
+static int en75xx_serial_putc(struct udevice *dev, const char ch)
+{
+	struct en75xx_serial_plat *plat = dev_get_plat(dev);
+
+	if (!(uart_rd(plat, R_LSR) & UART_LSR_THRE))
+		return -EAGAIN;
+
+	uart_wr(plat, R_RBR, ch);
+	return 0;
+}
+
+static int en75xx_serial_getc(struct udevice *dev)
+{
+	struct en75xx_serial_plat *plat = dev_get_plat(dev);
+
+	if (!(uart_rd(plat, R_LSR) & UART_LSR_DR))
+		return -EAGAIN;
+
+	return uart_rd(plat, R_RBR);
+}
+
+static int en75xx_serial_pending(struct udevice *dev, bool input)
+{
+	struct en75xx_serial_plat *plat = dev_get_plat(dev);
+	u8 lsr = uart_rd(plat, R_LSR);
+
+	if (input)
+		return !!(lsr & UART_LSR_DR);
+
+	return !(lsr & UART_LSR_THRE);
+}
+
+static int en75xx_serial_setbrg(struct udevice *dev, int baudrate)
+{
+	struct en75xx_serial_plat *plat = dev_get_plat(dev);
+
+	en75xx_serial_hw_init(plat, baudrate);
+	return 0;
+}
+
+static int en75xx_serial_of_to_plat(struct udevice *dev)
+{
+	struct en75xx_serial_plat *plat = dev_get_plat(dev);
+
+	plat->base = dev_remap_addr(dev);
+	if (!plat->base)
+		return -EINVAL;
+
+	plat->le = (bool)dev_get_driver_data(dev);
+	if (plat->le)
+		plat->uartclk = dev_read_u32_default(dev, "clock-frequency",
+						     2000000);
+
+	return 0;
+}
+
+static int en75xx_serial_probe(struct udevice *dev)
+{
+	struct en75xx_serial_plat *plat = dev_get_plat(dev);
+
+	en75xx_serial_hw_init(plat, CONFIG_BAUDRATE);
+	return 0;
+}
+
+static const struct dm_serial_ops en75xx_serial_ops = {
+	.putc = en75xx_serial_putc,
+	.pending = en75xx_serial_pending,
+	.getc = en75xx_serial_getc,
+	.setbrg = en75xx_serial_setbrg,
+};
+
+static const struct udevice_id en75xx_serial_ids[] = {
+	{ .compatible = "econet,en7512-uart", .data = 0 },
+	{ .compatible = "econet,en7528-uart", .data = 1 },
+	{ .compatible = "airoha,en7523-uart", .data = 1 },
+	{ }
+};
+
+U_BOOT_DRIVER(serial_en75xx) = {
+	.name = "serial_en75xx",
+	.id = UCLASS_SERIAL,
+	.of_match = en75xx_serial_ids,
+	.of_to_plat = en75xx_serial_of_to_plat,
+	.plat_auto = sizeof(struct en75xx_serial_plat),
+	.probe = en75xx_serial_probe,
+	.ops = &en75xx_serial_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.53.0

