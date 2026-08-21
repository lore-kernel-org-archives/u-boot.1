Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD14C5DF89
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6990740C3E;
	Fri, 21 Aug 2026 13:14:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dkEZgmnBhB0k; Fri, 21 Aug 2026 13:14:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318079;
	bh=HrPgnIHeq4cFyK/AEvCe99MeH0e/iWUMnbxmzeRgrQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CErbuiJM5PIvz3H3igdbSMLEjPeniPV5kdQoJvE05YA1Qsf37a+iEtoFwlCahz5La
	 FuX641XgRshAQ/NJO1seudEDTtM+FzpqHwPUgqeXLdoI4sGKXdBwhy4jcJDBmKF1P+
	 to4jgJncDBsUpZW9bVygxhsDkwUlWSiTyxArWsS+YHd8FYDnKIBtgZ9jHmFYmjOYT7
	 RZGjiT7qdNFS/GWuNm+n6LH2zcdEknuHJQ6gd4yTy2czndBGm1f1IRYQbUQ/QlR+oJ
	 /FYaPA/Odm7pCPP77D8S4goDCoermT2EMTX7MKlFHcAXHfC7Fepo8UpJ5hi85siUVB
	 /OX7vOq69dCAQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3119840CB7;
	Fri, 21 Aug 2026 13:14:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id EBC3E4B8
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDB8160661
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id weQ_x7lwsu3M for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:46:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.49;
 helo=mail-wm1-f49.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=linux.com
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CA0826061D
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:46:10 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so7237315e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787301969; x=1787906769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HrPgnIHeq4cFyK/AEvCe99MeH0e/iWUMnbxmzeRgrQg=;
 b=QZxDYmMh7ZwHRbwMMX7hbXtAEjIRai5qTjn7MaGFt3ifCal+FC88y5yYarhie+0q4s
 4wOGTnxddT13xRKf5Jh2OzWQ3oiKdfG7njkQIjgJpcmIy1jFCbmZL16fkRXNXsuYkrub
 o8sOfPM5vHicBMr/VrpT83TPmq7nSrs923zrWK/9KXGDxBRHfAhNiGuFf7/0Jb6Qtw8L
 roF8FTMY5qg9/LM2ndQMeyuB0OE9w9/amFGvf1iHJlXc1cvVPdD5X8QI6KYN19kPXa8B
 obKCRekPXi5yqECIM7DqLaKwyp9mEQVk6Enj3qFxmRB998zEMS9/fodmi487Ois7sqGc
 VHgA==
X-Gm-Message-State: AOJu0YwnZvRauIf6Mi/AYIKFfFQYfRgS2T6Ni2hCo7YbxK0hHnxVXLH6
 hhzCG+NKjs1FncJcgBZcnVQqp0iGm5FRxTFqXVKsIa5lFDNHej0qo/oQzH6ARA==
X-Gm-Gg: AR+sD13t4TlaNwiJiQkeaDNnbHl1xR4fLKK2yLv/oMmO4ZuGDE6h+dFa5y+eEx8mVO/
 TLvHKetp4RXhMEGS5fBEwYywXp76eZkDn9AauAKshjcTPrtw78agGKDfnXivW1SafQL0q1K/KDs
 aJPksOUBg7ilzlFPOivXQtpVQCIC0cX4HRzsQrB+D2fSR28G/T1jaLnN7805EkWLv5grO//SjxJ
 EMu6dFbunQFlHL5oMozG4Fy1IR5Wx5776jJidiOaIxikU0AXBMgC5xaWHQ05niU1slu5Kz5EPn5
 2nxjs3b/6r2s9K2/AXkboXQR1h6iIhrbPCiZ5hiYFSDiGF4QmhTPoh++XEDeWbuAt5pjfGoHHCv
 vMvmQvZptBXNhv0Xep6x3NK8Ap/Wt86wWEplqzPFnkDkTQQH2Xv38kmn6AC+HzHTgyzB2LdbMpu
 0Igts+iGllrCHyMG7u/qMhVDs3XpJgKsWodN/KlHXe1VBAynfkUnr2qjoCADBxSsANV/ULTVxQP
 k7aIl918eRQdi3dKa2W0YluteM=
X-Received: by 2002:a05:600c:6211:b0:499:621a:2ec2 with SMTP id
 5b1f17b1804b1-499b82e8e9dmr74210185e9.3.1787301968300; 
 Fri, 21 Aug 2026 01:46:08 -0700 (PDT)
Received: from threads.localdomain ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e747esm22978115e9.4.2026.08.21.01.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:46:07 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io
Subject: [PATCH v2 1/4] serial: meson: add Amlogic S4 UART support
Date: Fri, 21 Aug 2026 09:46:00 +0100
Message-ID: <20260821084603.25974-2-tanure@linux.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821084603.25974-1-tanure@linux.com>
References: <20260821084603.25974-1-tanure@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:12:32 +0000
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

