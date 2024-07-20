Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093F6C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 12:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4C5188CBE;
	Sat, 20 Jul 2024 14:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oePYYHsH";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="PrcSauOM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87F2E88655; Sat, 20 Jul 2024 14:44:02 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B22F88655
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 14:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WR5nr2WS7z9sQJ;
 Sat, 20 Jul 2024 14:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+csXlT8OEERZgmA2etKW9+U3PI+ru+scG9KI6lnhwXo=;
 b=oePYYHsHykEpSUu+mPqOnMwvNxguV3Li6npDRs7+7QKg2InlobaE4xfeYndu04NrSDA/gH
 UHPZgkysnuMYPVbYSX47YnoJu+F7wN32+97z6AVEud47JGjwD0YJkWQ55b/TOGyuVupPc1
 h8JDKsTerK01O+GfEFACECmkLHZvCmDShZMwbVW+ls+7jdPuSh4an+6gFaqHRMjhRSeChJ
 VTnB/D11bQ1N3mjVi9qXvEsZfSZ3W/KIjPZwQghqhPBcwApLwckk0l+GP9BgnI7tI+jZwr
 Oi3KbVsT54leNxo2YZ4TUXawVM/Sw7EIpF7jzKvl7jyk4DREGy1g5m5zdRb1RQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1721479438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+csXlT8OEERZgmA2etKW9+U3PI+ru+scG9KI6lnhwXo=;
 b=PrcSauOMVdmPSqX6l/85p3ThIiYgBU74VSc49tt3oNoBnW9ddTuVfJe/6eSq+dovBl/k/Z
 XKiJYglHXmEx5etKXITGjuLenSTkoLBHNHNNikEpjcVRSWfNA5Ob13KsvzpnNGRHQVyrRM
 t3UAASKPBm8TO6VjqbfyGam85EtQpspLI64ZMha1HckiaFKuPpTHUbeWltlq1B8fmSp5QR
 Ku+iskW6dznlLNBXuM51gl4YFNAsHZ84Zzqi013WcyYk2LKmfYYhZizXgQ5JPxZ8+ljeFW
 88Yh/GKCWuvqNrjj0q9bWlJJrguRFUtuFpy/cwXbrKMvFRRKRNQpQT52t98jbw==
To: u-boot@lists.denx.de
Cc: francesco.dolcini@toradex.com, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 30/40] drivers: serial: Remove duplicate newlines
Date: Sat, 20 Jul 2024 14:40:55 +0200
Message-ID: <20240720124239.7553-30-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
References: <20240720124239.7553-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3e80bcf4ebc073bf570
X-MBO-RS-META: cf3k6e8zzqgu17ksbncrucj6gqxoxwh7
X-Rspamd-Queue-Id: 4WR5nr2WS7z9sQJ
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 drivers/serial/serial_arc.c            | 1 -
 drivers/serial/serial_linflexuart.c    | 2 --
 drivers/serial/serial_lpuart.c         | 1 -
 drivers/serial/serial_nulldev.c        | 1 -
 drivers/serial/serial_pl01x_internal.h | 1 -
 drivers/serial/usbtty.c                | 8 --------
 6 files changed, 14 deletions(-)

diff --git a/drivers/serial/serial_arc.c b/drivers/serial/serial_arc.c
index c0930cf7334..a7e566bd23f 100644
--- a/drivers/serial/serial_arc.c
+++ b/drivers/serial/serial_arc.c
@@ -24,7 +24,6 @@ struct arc_serial_regs {
 	unsigned int baudh;
 };
 
-
 struct arc_serial_plat {
 	struct arc_serial_regs *reg;
 	unsigned int uartclk;
diff --git a/drivers/serial/serial_linflexuart.c b/drivers/serial/serial_linflexuart.c
index ff66e69b9d7..24ecb236d51 100644
--- a/drivers/serial/serial_linflexuart.c
+++ b/drivers/serial/serial_linflexuart.c
@@ -69,7 +69,6 @@ static int _linflex_serial_putc(struct linflex_fsl *base, const char c)
 {
 	__raw_writeb(c, &base->bdrl);
 
-
 	if (!(__raw_readb(&base->uartsr) & UARTSR_DTF))
 		return -EAGAIN;
 
@@ -197,7 +196,6 @@ U_BOOT_DRIVER(serial_linflex) = {
 
 #include <debug_uart.h>
 
-
 static inline void _debug_uart_init(void)
 {
 	struct linflex_fsl *base = (struct linflex_fsl *)CONFIG_VAL(DEBUG_UART_BASE);
diff --git a/drivers/serial/serial_lpuart.c b/drivers/serial/serial_lpuart.c
index a06e6dc2505..93602797b83 100644
--- a/drivers/serial/serial_lpuart.c
+++ b/drivers/serial/serial_lpuart.c
@@ -101,7 +101,6 @@ static void lpuart_write32(u32 flags, u32 *addr, u32 val)
 	}
 }
 
-
 u32 __weak get_lpuart_clk(void)
 {
 	return get_board_sys_clk();
diff --git a/drivers/serial/serial_nulldev.c b/drivers/serial/serial_nulldev.c
index 78a9e0b195f..e2c6dec5e32 100644
--- a/drivers/serial/serial_nulldev.c
+++ b/drivers/serial/serial_nulldev.c
@@ -31,7 +31,6 @@ static const struct udevice_id nulldev_serial_ids[] = {
 	{ }
 };
 
-
 const struct dm_serial_ops nulldev_serial_ops = {
 	.putc = nulldev_serial_putc,
 	.pending = nulldev_serial_pending,
diff --git a/drivers/serial/serial_pl01x_internal.h b/drivers/serial/serial_pl01x_internal.h
index 71c52bb5312..7ae3ae50908 100644
--- a/drivers/serial/serial_pl01x_internal.h
+++ b/drivers/serial/serial_pl01x_internal.h
@@ -92,7 +92,6 @@ struct pl01x_priv {
 #define UART_PL010_LCRH_PEN             (1 << 1)
 #define UART_PL010_LCRH_BRK             (1 << 0)
 
-
 #define UART_PL010_BAUD_460800            1
 #define UART_PL010_BAUD_230400            3
 #define UART_PL010_BAUD_115200            7
diff --git a/drivers/serial/usbtty.c b/drivers/serial/usbtty.c
index ae3ac8070d3..b7d77fbb6a9 100644
--- a/drivers/serial/usbtty.c
+++ b/drivers/serial/usbtty.c
@@ -54,7 +54,6 @@
 static circbuf_t usbtty_input;
 static circbuf_t usbtty_output;
 
-
 /*
  * Instance variables
  */
@@ -77,7 +76,6 @@ int usbtty_configured_flag = 0;
  */
 static char serial_number[16];
 
-
 /*
  * Descriptors, Strings, Local variables.
  */
@@ -257,12 +255,10 @@ static struct rs232_emu rs232_desc={
 		.data_bits	=	0x08
 };
 
-
 /*
  * Static Generic Serial specific data
  */
 
-
 struct gserial_config_desc {
 
 	struct usb_configuration_descriptor configuration_desc;
@@ -575,28 +571,24 @@ static void usbtty_init_strings (void)
 	str2wide (CONFIG_USBD_MANUFACTURER, string->wData);
 	usbtty_string_table[STR_MANUFACTURER]=string;
 
-
 	string = (struct usb_string_descriptor *) wstrProduct;
 	string->bLength = sizeof(wstrProduct);
 	string->bDescriptorType = USB_DT_STRING;
 	str2wide (CONFIG_USBD_PRODUCT_NAME, string->wData);
 	usbtty_string_table[STR_PRODUCT]=string;
 
-
 	string = (struct usb_string_descriptor *) wstrSerial;
 	string->bLength = sizeof(serial_number);
 	string->bDescriptorType = USB_DT_STRING;
 	str2wide (serial_number, string->wData);
 	usbtty_string_table[STR_SERIAL]=string;
 
-
 	string = (struct usb_string_descriptor *) wstrConfiguration;
 	string->bLength = sizeof(wstrConfiguration);
 	string->bDescriptorType = USB_DT_STRING;
 	str2wide (CFG_USBD_CONFIGURATION_STR, string->wData);
 	usbtty_string_table[STR_CONFIG]=string;
 
-
 	string = (struct usb_string_descriptor *) wstrDataInterface;
 	string->bLength = sizeof(wstrDataInterface);
 	string->bDescriptorType = USB_DT_STRING;
-- 
2.43.0

