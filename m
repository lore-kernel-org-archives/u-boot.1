Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC39C5AC67
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 11:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B67380E2E;
	Thu,  6 Aug 2026 11:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XNeJK6rw81t; Thu,  6 Aug 2026 11:00:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1E62780E36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786014045;
	bh=HrPgnIHeq4cFyK/AEvCe99MeH0e/iWUMnbxmzeRgrQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rhzvb1FvH0LKgWb/D2wbbgmSiCAV3Ae2GC4xaZ8+aAa9Y3bpWEFxCyrbPRoqmPfUn
	 sun/E9t6q4hMuPwdD7QsVaQPVWYgQh+TGGi5+L+ouRIeXpE4pzL91tHhjqERz1P8h7
	 g5TPg/gkQtI9VtuNa68SkjwyU35AzyVfVDoEz3vaXD99go4vj6SHsWryayPGfUv6FT
	 CXFP2VqDiOS3Ja3DdTgPrbba0m4vkCcnuLYIFr92mQXtwDx/R0HT+dAg2fSE6vh4ai
	 /TBkK9mutXIMurWlyJZkR8g39937gAk/H57UdsAlULIqErt9IGcvhbNPC799fCiBxK
	 uKItkkcO0fwCA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E62780E36;
	Thu,  6 Aug 2026 11:00:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FB383F9
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 017A880D66
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Dj8eyPmqZOop for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 10:18:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.52;
 helo=mail-wm1-f52.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E3CFE80D5E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3CFE80D5E
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3CFE80D5E
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 10:18:15 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso13295245e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 03:18:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011494; x=1786616294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HrPgnIHeq4cFyK/AEvCe99MeH0e/iWUMnbxmzeRgrQg=;
 b=qCjZuemIdtfzOOIPjyX08gSDWpJUTx4zxcovjMT8N5UWYYOxJDqcAEnYON7omKU3X5
 sFrDOTRxi/h4tzEVSvfU4t3p4PTZT0AKhvuF7gchPcBayAMyr6EtUCTSbxXYDSk/ADAn
 QVjj+UZuL0kMRwzIO0X5nrJ8HP44ERetSZYHtxl1bzFRNZHIwvrXB+WHcmW+kMX/cs4h
 yYPUj7I44RHcu6qiG+Z44y3Vmxoo2k6T+egqlzKzsWRpdEds1a2GFI0lKU0suQ2EBMi0
 ZtNVaacihb3Vlw5AX8Ig5rE3JsmSnt7iqDIMuqeIP4WxHmZxAfdaZiIxPI6b4ojcHm+O
 6TxA==
X-Gm-Message-State: AOJu0YwCg2ELO0sr/4K4ufSjG83gn1FnitssyV46xPaEJg134yii/+ve
 K8WAUI1j+zZAETf00DLuuRWf5A7pTZZK1WfAPUNUK68Lcc7I3H64Uj6R3WeEtQ==
X-Gm-Gg: AR+sD13u1FvUq5QjUXAGJLNQ2xvk1utsSYToeOpqnOL25ENFwV+MKir0Z/+ZZE2SkUB
 C7bgMW3X8kTPjYCSWx7VkRVyW0XXd0cfYl6BuxNboUig1mchavzyKgzaWdQ6hAUf4Wm4Bg+xJ4f
 0e2SJOC5YQWz/JDoL1wCaIt+2d2nPwAwQawGz+isag9OxdRQ54OVddYKp2FpWJcmUdjBsqQzjxW
 xGEg0HbvLWd/2Ne/V+crDxGBlmRvdDUVbLz0f99dlxe9a4jKs9Ary7kX9iKQhHudH8cPKrwJczL
 1K2Gg0BMcKuk467jQdCl0sS7YXBitBVoj/FF20ROYqqZFMVJRqvYHMzIVT5JqJ/fDhWRh05AiW9
 FA9H9EhLzUbX/qcLWZuPmElG+VP4hxCnFdzn7CRS+nwNa3m3An/UKoRABj11Tt8D6C+YnALEoQP
 rmqV6kkZ9e1qFZXIZV4s1jDpAnKHRqmhzNb1VFe7+F5Y+D8fX+Fl+pNPr6L4YIg7MQzFkRxGUG9
 x6NAsHN+Tbd67ZSieLniIez800=
X-Received: by 2002:a05:600c:4614:b0:498:8e6:d464 with SMTP id
 5b1f17b1804b1-4994e7c5c07mr113720235e9.14.1786011493700; 
 Thu, 06 Aug 2026 03:18:13 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e988687sm108654725e9.3.2026.08.06.03.18.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:18:13 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
Date: Thu,  6 Aug 2026 11:18:06 +0100
Message-ID: <20260806101809.72526-2-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806101809.72526-1-tanure@linux.com>
References: <20260806101809.72526-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Aug 2026 11:00:31 +0000
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=fail (p=none dis=none)
 header.from=linux.com
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

The S4-generation UART (S4, T7, ...) derives its baud rate from the
24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
baud rate register, while older SoCs divide the crystal by 3. Add the
"amlogic,meson-s4-uart" compatible with driver data selecting the
div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
the configuration the vendor BL2 programs on T7 hardware.

Older SoCs keep the existing div-by-3 behaviour: Linux also uses
div-by-2 on G12A, but both modes work there and switching would risk
regressing boards that have shipped with div-by-3 for years.

Also drain the transmitter before changing the baud rate so in-flight
characters are not garbled, as the Linux driver does.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Lucas Tanure <tanure@linux.com>
---
 drivers/serial/serial_meson.c | 51 ++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
index cc71381f87e..d909fedcfc4 100644
--- a/drivers/serial/serial_meson.c
+++ b/drivers/serial/serial_meson.c
@@ -62,26 +62,49 @@ struct meson_serial_plat {
 #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
 #define AML_UART_REG5_BAUD_MASK		0x7fffff
 
+/* Driver data flags */
+#define MESON_UART_XTAL_DIV2	BIT(0)
+
 #if CONFIG_IS_ENABLED(DM_SERIAL)
-static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
+static u32 meson_uart_xtal_div(struct udevice *dev)
+{
+	/*
+	 * S4-generation UARTs (S4, T7, ...) derive the baud rate from the
+	 * crystal divided by 2, older ones divide by 3.
+	 */
+	return (dev_get_driver_data(dev) & MESON_UART_XTAL_DIV2) ? 2 : 3;
+}
+
+static u32 meson_calc_baud_divisor(struct udevice *dev, ulong src_rate, u32 baud)
 {
 	/*
 	 * Usually src_rate is 24 MHz (from crystal) as clock source for serial
-	 * device. Since 8 Mb/s is the maximum supported baud rate, use div by 3
-	 * to derive baud rate. This choice is used also in meson_serial_setbrg.
+	 * device. Since 8 Mb/s is the maximum supported baud rate, use a
+	 * divided crystal to derive the baud rate. This choice is used also in
+	 * meson_serial_setbrg.
 	 */
-	return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
+	return DIV_ROUND_CLOSEST(src_rate / meson_uart_xtal_div(dev), baud) - 1;
 }
 
-static void meson_serial_set_baud(struct meson_uart *uart, ulong src_rate, u32 baud)
+static void meson_serial_set_baud(struct udevice *dev, struct meson_uart *uart,
+				  ulong src_rate, u32 baud)
 {
 	/*
-	 * Set crystal divided by 3 (regardless of device tree clock property)
+	 * Set the divided crystal (regardless of device tree clock property)
 	 * as clock source and the corresponding divisor to approximate baud
 	 */
-	u32 divisor = meson_calc_baud_divisor(src_rate, baud);
+	u32 divisor = meson_calc_baud_divisor(dev, src_rate, baud);
 	u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
 		(divisor & AML_UART_REG5_BAUD_MASK);
+
+	if (meson_uart_xtal_div(dev) == 2)
+		val |= AML_UART_REG5_XTAL_DIV2;
+
+	/* Drain the transmitter before changing the baud rate */
+	while ((readl(&uart->status) & (AML_UART_TX_EMPTY | AML_UART_XMIT_BUSY))
+	       != AML_UART_TX_EMPTY)
+		;
+
 	writel(val, &uart->reg5);
 }
 
@@ -109,7 +132,7 @@ static int meson_serial_probe(struct udevice *dev)
 		return ret;
 	ulong rate = clk_get_rate(&per_clk);
 
-	meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
+	meson_serial_set_baud(dev, uart, rate, CONFIG_BAUDRATE);
 	meson_serial_init(uart);
 
 	return 0;
@@ -165,8 +188,9 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
 {
 	/*
 	 * Change device baud rate if baud is reasonable (considering a 23 bit
-	 * counter with an 8 MHz clock input) and the actual baud
-	 * rate is within 2% of the requested value (2% is arbitrary).
+	 * counter with an 8 MHz, or 12 MHz for XTAL_DIV2 devices, clock input)
+	 * and the actual baud rate is within 2% of the requested value (2% is
+	 * arbitrary).
 	 */
 	if (baud < 1 || baud > 8000000)
 		return -EINVAL;
@@ -179,14 +203,14 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
 	if (ret)
 		return ret;
 	ulong rate = clk_get_rate(&per_clk);
-	u32 divisor = meson_calc_baud_divisor(rate, baud);
-	u32 calc_baud = (rate / 3) / (divisor + 1);
+	u32 divisor = meson_calc_baud_divisor(dev, rate, baud);
+	u32 calc_baud = (rate / meson_uart_xtal_div(dev)) / (divisor + 1);
 	u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - baud;
 
 	if (((calc_err * 100) / baud) > 2)
 		return -EINVAL;
 
-	meson_serial_set_baud(uart, rate, baud);
+	meson_serial_set_baud(dev, uart, rate, baud);
 
 	return 0;
 }
@@ -244,6 +268,7 @@ static const struct udevice_id meson_serial_ids[] = {
 	{ .compatible = "amlogic,meson-uart" },
 	{ .compatible = "amlogic,meson-gx-uart" },
 	{ .compatible = "amlogic,meson-a1-uart" },
+	{ .compatible = "amlogic,meson-s4-uart", .data = MESON_UART_XTAL_DIV2 },
 	{ }
 };
 
-- 
2.55.0

