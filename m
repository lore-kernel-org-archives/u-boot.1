Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA673C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 19:06:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB527875EF;
	Tue,  7 Nov 2023 20:06:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OPTHyffK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C612875C3; Tue,  7 Nov 2023 20:06:13 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 209C387584
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 20:06:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ce2c5b2154so3855254a34.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 11:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383966; x=1699988766; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M/pKtokJ16QvLgTtzXCD1ooraExBNQXaxs+a4bK0Yss=;
 b=OPTHyffKKwZwDPP+WzqNF9MAPhxNTN1bNvhzDeiv4J2gi/la/J2RpwPV+G5kYF40T8
 k87pQV2hYYwuftIt2OvFGCwN/03s0mAwZwtWmyGnLcpxQC94EpowKwncm76NbjTTmnX6
 WIRxPuCfcbS9doFvqU6zC4sn+oDTdiMK3XtasOLqLlSxD9A/XoCwPSfmIVfnH2SzhiWg
 EAMuGE4Lx+YkrOB0JplYsJ5/rKnk6vzqX+4Um4Fxm80pqOsXB4JZD7MpwzwBTpsoj4sS
 WmVTFTK/viVo1cHDU2qIwhOoiw8+3q3cD1+PDa+Wu04qZO2ntywcYUNnDsloOb7hmF0X
 1nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383966; x=1699988766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M/pKtokJ16QvLgTtzXCD1ooraExBNQXaxs+a4bK0Yss=;
 b=NYfRj/rxeRS/WZ/AcOYu4XzKdrCzcGLpsXrKgRuxOCkEO0m+imn3kKl4sNMznHHOG0
 Pzv5sdPZmTKqw19kiyZ268JR8L5CqTx7Kmg+L+j8G6ulufHAd4usJ9/pFe2qOSIdPWf2
 KQU+amVLY40LU71vvLOC/9VkSiwcepTMvkCIELsLNOJ/cOWU4X/5sjCUfqQcWJeov8YH
 dG+C9BZKAHr9W160Fv/KZu3wsh2q1XXpFjx5o8FKdQNN/owsizuLEAwhZGDQfMAAb+zD
 Ifj9WHDNLqv8Mmj8VUczptAP9QoszNE3dLVwj+OqeQhNVU5iHZ0QT8E/EnI+F65RgI/C
 gzQg==
X-Gm-Message-State: AOJu0Yy4vc6yavhMfCqa7szze7WGlCAOlsTovtCaRkh33w88bdRlWSqP
 ZaE/E0OFas0vwau0MT44yh665g==
X-Google-Smtp-Source: AGHT+IEeujef3uwH7xDmLloodziH5ruKnTJQJCYPep8jOX6JtYapvjz0JCrDX2iSAXfF8lTHJH94bA==
X-Received: by 2002:a05:6830:7181:b0:6b9:a926:4a12 with SMTP id
 el1-20020a056830718100b006b9a9264a12mr42774453otb.28.1699383965659; 
 Tue, 07 Nov 2023 11:06:05 -0800 (PST)
Received: from localhost ([136.62.192.75]) by smtp.gmail.com with ESMTPSA id
 bg19-20020a056830361300b006ce2ec1d000sm1665884otb.59.2023.11.07.11.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 11:06:05 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: Mark Kettenis <kettenis@openbsd.org>,
	u-boot@lists.denx.de
Subject: [PATCH 4/4] serial: s5p: Improve coding style
Date: Tue,  7 Nov 2023 13:06:01 -0600
Message-Id: <20231107190601.17151-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107190601.17151-1-semen.protsenko@linaro.org>
References: <20231107190601.17151-1-semen.protsenko@linaro.org>
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

Just some minor style fixes. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/serial/serial_s5p.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index 6d316ccaf31d..c24d9bca84c9 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -50,9 +50,9 @@ enum {
 
 /* Information about a serial port */
 struct s5p_serial_plat {
-	struct s5p_uart *reg;  /* address of registers in physical memory */
-	u8 reg_width;	/* register width */
-	u8 port_id;     /* uart port number */
+	struct s5p_uart *reg;	/* address of registers in physical memory */
+	u8 reg_width;		/* register width */
+	u8 port_id;		/* uart port number */
 	u8 rx_fifo_count_shift;
 	u8 tx_fifo_count_shift;
 	u32 rx_fifo_count_mask;
@@ -65,7 +65,7 @@ struct s5p_serial_plat {
  * The coefficient, used to calculate the baudrate on S5P UARTs is
  * calculated as
  * C = UBRDIV * 16 + number_of_set_bits_in_UDIVSLOT
- * however, section 31.6.11 of the datasheet doesn't recomment using 1 for 1,
+ * however, section 31.6.11 of the datasheet doesn't recommend using 1 for 1,
  * 3 for 2, ... (2^n - 1) for n, instead, they suggest using these constants:
  */
 static const int udivslot[] = {
@@ -251,10 +251,10 @@ static int s5p_serial_of_to_plat(struct udevice *dev)
 }
 
 static const struct dm_serial_ops s5p_serial_ops = {
-	.putc = s5p_serial_putc,
-	.pending = s5p_serial_pending,
-	.getc = s5p_serial_getc,
-	.setbrg = s5p_serial_setbrg,
+	.putc		= s5p_serial_putc,
+	.pending	= s5p_serial_pending,
+	.getc		= s5p_serial_getc,
+	.setbrg		= s5p_serial_setbrg,
 };
 
 static const struct udevice_id s5p_serial_ids[] = {
@@ -264,13 +264,13 @@ static const struct udevice_id s5p_serial_ids[] = {
 };
 
 U_BOOT_DRIVER(serial_s5p) = {
-	.name	= "serial_s5p",
-	.id	= UCLASS_SERIAL,
-	.of_match = s5p_serial_ids,
-	.of_to_plat = s5p_serial_of_to_plat,
+	.name		= "serial_s5p",
+	.id		= UCLASS_SERIAL,
+	.of_match	= s5p_serial_ids,
+	.of_to_plat	= s5p_serial_of_to_plat,
 	.plat_auto	= sizeof(struct s5p_serial_plat),
-	.probe = s5p_serial_probe,
-	.ops	= &s5p_serial_ops,
+	.probe		= s5p_serial_probe,
+	.ops		= &s5p_serial_ops,
 };
 #endif
 
@@ -298,10 +298,12 @@ static inline void _debug_uart_putc(int ch)
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
 #if IS_ENABLED(CONFIG_ARCH_APPLE)
-	while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL);
+	while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
+		;
 	writel(ch, &uart->utxh);
 #else
-	while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL);
+	while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
+		;
 	writeb(ch, &uart->utxh);
 #endif
 }
-- 
2.39.2

