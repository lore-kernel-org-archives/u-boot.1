Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 191C2C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D56FF6073E;
	Tue, 25 Aug 2026 22:50:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id acTKBgrVg30P; Tue, 25 Aug 2026 22:50:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698225;
	bh=1wl9vBDPLcGcZTieTz0rGz4wS8dyZe82Z5RDTF6rBf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NELmolM4KTYiUbhzl1p2ecTgueUbK4FzOYofXqSGkbTOJb9LE+dYLpD0L5Pe6kpPx
	 R1ttXJCNFK1DzIuvzyx583N1KlNULrSzlxeusOmOJ1hzLgsLQUDiSTd0lxDmWKVq1l
	 gtJwP/WACvrLwl1Kt++tKre023U5/DIxoZy88y44TSmsGw+TaVlMk/5WyAmekNgtlR
	 TapbFE+fTbZxXrjGtJMI8MyzVFlYa8i9SEsncEggsBznc1v5Sdnk0o4bgwH2k93Gfg
	 sadTpEKNo7mghkXVoketmCMNG380T4jPQ1XTPMa+jy9hajXZQd0lGfyL425VpTY1fp
	 6DOtDIB9KhCuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EA35C60785;
	Tue, 25 Aug 2026 22:50:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D9247230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC10F80B48
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AD9LwjbhQYoq for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:44:05 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=34.2.90.19;
 helo=sonic.asd.mail.yahoo.com; envelope-from=maskachoska@yahoo.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com
 header.a=rsa-sha256 header.s=s2048 header.b=a2mC2hxr
Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com
 [34.2.90.19]) by smtp1.osuosl.org (Postfix) with ESMTPS id 621C880AC5
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697842; bh=1wl9vBDPLcGcZTieTz0rGz4wS8dyZe82Z5RDTF6rBf0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=a2mC2hxrniG9JR2wl64DcFRiuqZVKfloeQ0mbsEyWIW8/YmDD3RIvN1/+IS+pppJ+gSD/2/SsBmh0tbVGIF6LyMulhPDxXlFTGdcQcCz3/T3OR7Tu9KmsZ6ZhKWbbz2uIkA8QKkCEuOyCnl0d4aY8NwXiVkPLAf7ICd+qOyyNGlpyLEraQe5EEsrC75iYNB9k6jWwaMhFona0EGMhEStV7qP490Wbjw2mftOwlJ/GOoP887QUkP1jDAuOv0wjCxx8DUTUUU+tpQGO3B8eH23fgA1sdbpVljIX0zb3lbHxD9TtA8nKCn93/+jbOsm1jgYMfTEYbE/4Y7RoMf8sO9QHw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1787697842; bh=vDNw8jfJPlr47aTFZuWsqM51hFg+3/E4nleaY0Xxtft=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=jXFGat63o2L2BzjGA7b29KfmQREbrX8ifu6mlbUqX2EJtNhjtdyJ4RVr4js29GPCNf2hOAGpx+9S1smcEnIML4HMf1a8zPJYZ1zryBK25n510EVDWLfj8w/yFn2vxyHzBcEY3lG22Y+4E3ss7c58f5nGp+35PZGU9InBlNgLgFLgYLVCQJ1KfiCRHUj2Yo7xQyJCghOgcqHZat7AT3M5deIRDZ9h23z7serFjXlZe6v97Up44XeAsG3togUujchxiKwJ9lHK8ciOP/aSwsMDAHItKIPQWj/oWgDxdxzlkv/kj0lw3D8L1I90xYvR2iZ8NqgCQR/1zDTY6cqIzFTlgA==
X-YMail-OSG: Dg3rF3EVM1lF_oYmOano6DJTnVIXcT5EE8ftT8wz3xQp_.TVpK_bf8dUJfMMosz
 FCIng2.IaaND1lOVHwERcO9XRwPJlcmHHjh8Ej6HVGcbxdbZ3UBoh0ngUH.iHRhFtOER2_oeTqry
 jBljBr5cNlsQrOYW0wK1AwMZ3vreR8Hc2dl1jNkT_hjXJHYGbHp26jQVsf6AFyXKdieVqfhpnE7d
 x51OKN8h_419ZK69xbzbcbrRf6I9KZyB1CwbsyyegZPglmpvlhUFrpc1Hg0LJmvNOFw6kBYiULY9
 Kh5QrdiqF_6UX.LFI6yB3xz33CPj3UvNBK.HjvK506B3QVxKhTqoxaWolRTpBcyt4TAM1iGvBzqz
 HO84N9z4segmZ1gsBdSXURW1ozDSEZxStkW1CdYNJRFg_tr_p6UysgSyDGEHQT06Qv03n1bfSXzZ
 qRUKtb4pFjVRlum5_CwILpqH8razRS1xyjkyubBZObjvGZF05d1ZjF6OHWd8wFGoyyeLFs63NLJw
 CjZuR6pGsVnpc20ZE_arWpSTiqueDBfzqdtt7aAbSztqrDrLZ7vTMSAR4utsxWsYGJtW2XOzMnUB
 HMHSGJMdZ5jD7_aIO8F2VHCHcwVq6I76o.OReb1ESVCOrPZ2ipyh8yBm0Ajg2LqH7sCaV3MMdKFw
 99cGIkSk3PdpGTOgqvp2A8w3VkpFK2nwVn1k1uRAJQ3I.d0motEx9ovucw6l_EwkfzsS1mVlLZsQ
 cgKGD2A9otYd1ajOMWeqkrvQDKvMwrNoKr108N8VQuPp_huECrhFNG60_.EboUzwkFCXxAZxAmmA
 bA1LX3fXRgluJb9MIMpZHtG0FsPFefMhb3jUIoocmMwMyzkAd74pKBuYP_QajOB.xaMFqkt2DGpf
 Pys96yHjokQQV7w.1_g7MLuhw6hvuN2_fTbHIo9KnsY4.kfzhWmCq5Hh8tWofxG6LbiXybuPRpKp
 NH2Ab441.EARmOzfiPwuTSftX8LNCFzNqXQB3KWLP8qMvacCJtvmLvfDU6Z8Cul8fatsRirHGiH5
 oF_j1UTShZtPofY5WEieoYydjSMfcDv94lEPkweqh41A5Af3zl_yduh7pBC7YemIasmKKJKZaVws
 tJ6HXdl3AYPZGYVmBIoF1g3oXG7Is4cXQrIlYnVdZpI3re7a_Pd4ALK71jbo8YmBdca1x1yTDcmr
 v3Wn_.v15BUL1pr7qFQ_DTBQA4tls6xZ_vK_jARCn76xvnt2c2aFQxVbqKDNNMUaLospphIshOW4
 tI4Jn1oJg6A1QqbtMk48kW7AP9A64E8qJ6YUdkzQf_oblPOgj7k4cSj0_QPe0Io9SUvjJ7i2tzQD
 e4zuXzBVB.MdAgtmptQSgPvjwv6WLIKmNebNBDKW9TleeZrPhdV7gkx1c4k60ND81eQ5IIV9rK6l
 zmOHI_LqXvnA48C__w2Ew3EacTiiGdCJrxrAHiy.N4qy8Wnvqr_l6zJQNToVAkVAnEjlO8.iFIbd
 XMjQZjtG0AvReQQb.j3LTyOXpUaMIFm0eiQWcMFzagbJcEed6TtLmSZ1qaGLSJOWOXrmNthklUyB
 9HFb2Fb8xQmNSXirQIjZjH0KJqXcYqgSCpsDmfHfBumFvE5iGzApRDQ7BhyaKruY4ZC5fPZeEXr_
 NpH32vfoyhSZblTC5T_MyHFs3vnrureDHL4.9qpNvn8ihJSXJ4Nc6n2oTjaCxGeRT89usyRKVLjF
 sl8jUAsUppLILi51_mJWYL97ZZpQIJQgcM7ewpXhK0WcGAIbFHF8Cidi3GWZGJqVtmBJAvBkuzfL
 CU1RUJW6FbHibtWZtyl6yRP3iO1n4Irt0h5auZtBnhP3LvgTJpBp7DY588__cKP5gYO0W7lrL0nV
 C3NEZNnTYYcbgIvY3wTcy6XmpWqt_2Y4WDZ69drxracPmn9aQShW.fidlJBJRTTjvb_E_MmWgWXt
 d4XI6pQzlJv57xrJrfqUQBZhwZig.DfHLQ9lh0wyfpa67DsGFy0A6I5OoqaSWFNE3QXsmjLOTVow
 oxlGJKR7pmwmrD98jo2MhZPocWeLoGPpTNM3wFtq4QReZemNWxTialmaHT6EUZqBCpBkcgv0YwDz
 Ce.DjXw--
X-Sonic-MF: <maskachoska@yahoo.com>
X-Sonic-ID: 337902a6-4a79-4f2b-a1c7-0474f167c899
Received: from sonic.gate.mail.ne1.yahoo.com by
 mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-102 with HTTP;
 Tue, 25 Aug 2026 22:44:02 +0000
Received: from dip125.lsn.sg3.yahoo.com ([106.10.223.134])
 by hello (SMTP) with SMTP ID 692ceff9cbf31ebf3ce1df27c5387b11;
 Tue, 25 Aug 2026 22:43:58 +0000 (UTC)
From: AK Sharma <maskachoska@yahoo.com>
To: u-boot@lists.u-boot-project.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Subject: [PATCH v1 03/12] serial: en75xx: add EcoNet/Airoha EN75xx UART driver
Date: Wed, 26 Aug 2026 04:11:58 +0530
Message-ID: <20260825224330.713151-4-maskachoska@yahoo.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825224330.713151-1-maskachoska@yahoo.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 25 Aug 2026 22:49:58 +0000
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

Add a DM serial driver for the UART on the EcoNet/Airoha EN75xx SoCs.

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
index 00000000..8753ce55
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
+	 * on both. Live-verified on JCOW407: XYD == 0xEA00FDE8 at 115200.
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

