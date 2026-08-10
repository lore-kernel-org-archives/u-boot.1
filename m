Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455DAC5AE49
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 14:18:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 085A860716;
	Mon, 10 Aug 2026 14:18:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pSWsordoSKqC; Mon, 10 Aug 2026 14:18:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 098466071D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786371513;
	bh=Jm32KvSZj2DisrAP9rVFkGYH6tKqenK40k/kDe4Kvik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PL4XNpcDs//rNkbriNLtk45/eyJkPkOl+jEGFtSOGApr7R3BjVLia/g9DWkte+W5S
	 KMJhB/N4XNsQt0ENipSKh3LNZwL5fGgn9Ka6nq4YLk2byiPlMyKDXGw+z/YH2QZYJ4
	 gj7zDIdnxK8Z5VcHinfmsmyzsboyetxyqg6UqjKQb9fibBSDcZmALK/CY2qTCKuHlq
	 ygJUkdJsBNSjjXnsW8tgcgB5XQQzn4qOEUA6y4Uj3m2bcP48zO9dPc6zdfZKKG/gIe
	 UJ2CyWGnRWeGL+8wsT+XNvXgU1ZL70UdHOb533xKBkWntM/naL06Je4rcaqMoJSK5S
	 nzqhQ9eTsYNJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 098466071D;
	Mon, 10 Aug 2026 14:18:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BBF61218
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B971B80DAE
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Lz_xJ_F6aVT for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 14:18:30 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 10 Aug 2026 14:18:29 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 2193F80CBC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2193F80CBC
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:41d0:203:375::ed; helo=mta1.migadu.com;
 envelope-from=funderscore@postmarketos.org; receiver=<UNKNOWN> 
Received: from mta1.migadu.com (out-237.mta1.migadu.com
 [IPv6:2001:41d0:203:375::ed])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2193F80CBC
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 14:18:29 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: from meli-email.org (160.90.43.132)
 by mta10.migadu.com with ESMTPS id 2c368b0935c02e49;
 Mon, 10 Aug 2026 14:12:12 +0000
X-Migadu-Scanner: mta10.migadu.com
Date: Mon, 10 Aug 2026 14:01:52 +0000
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot-amlogic@groups.io, tanure@linux.com, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 funderscore@postmasteros.org, u-boot-amlogic@groups.io,
 Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
User-Agent: meli/0.8.13
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
In-Reply-To: <20260806101809.72526-2-tanure@linux.com>
Message-ID: <tjk4ry.249pxi1g19ygb@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=7XbLZCsAOIqbZRXXdB9CkgHo93wmzQs8ym75tD9swfc=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786371507; v=1; x=1786976307;
 b=q2VWkzKprbQJkl+W0h1OyWrY029oa/vIEzE0sRNE2aWJ+E37dUqkO1YEuBvgPgClh2cwlYEE
 JYAcV59kNsoLTTkZn/ShDCnkL6bxPhp/qL7NE8k6yQzR92GWM+UMAhJotw0fCez+gZciAgDEW6K
 gXT4clCNGl9Ab1sM8lk2Gec3xMhnB7Ob/BlDBnYh/rLF0+mOFMDmZKYS/rW/VsybKw1GX2tAXHK
 wpseKf+zIxo713YJA/bR0TFREv8r46McLMo7oxoSfkOewyMvtNh/s5BjoUVczRqjYMd/yp11i8R
 Xf7tH5EIepBnvzsdF9vTVYINWWoBoabql0jLUC9HX8V7Q==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=q2VWkzKp
X-Mailman-Original-Authentication-Results: mta10.migadu.com;
	none
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

On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" <tanure=linux.com@groups.io> wrote:
>The S4-generation UART (S4, T7, ...) derives its baud rate from the
>24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>baud rate register, while older SoCs divide the crystal by 3. Add the
>"amlogic,meson-s4-uart" compatible with driver data selecting the
>div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>the configuration the vendor BL2 programs on T7 hardware.
>
>Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>div-by-2 on G12A, but both modes work there and switching would risk
>regressing boards that have shipped with div-by-3 for years.
>
>Also drain the transmitter before changing the baud rate so in-flight
>characters are not garbled, as the Linux driver does.
>
>Assisted-by: Claude:claude-fable-5

As I understand it, LLM-assisted patches are not welcome in U-Boot right
now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-cat/

AFAIK there isn't an official AI policy yet, but it seems the concensus
on that matter is currently "please don't". Sorry.

>Signed-off-by: Lucas Tanure <tanure@linux.com>
>---
> drivers/serial/serial_meson.c | 51 ++++++++++++++++++++++++++---------
> 1 file changed, 38 insertions(+), 13 deletions(-)
>
>diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
>index cc71381f87e..d909fedcfc4 100644
>--- a/drivers/serial/serial_meson.c
>+++ b/drivers/serial/serial_meson.c
>@@ -62,26 +62,49 @@ struct meson_serial_plat {
> #define AML_UART_REG5_USE_NEW_BAUD	BIT(23) /* default 1 (use new baud rate register) */
> #define AML_UART_REG5_BAUD_MASK		0x7fffff
> 
>+/* Driver data flags */
>+#define MESON_UART_XTAL_DIV2	BIT(0)
>+
> #if CONFIG_IS_ENABLED(DM_SERIAL)
>-static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>+static u32 meson_uart_xtal_div(struct udevice *dev)
>+{
>+	/*
>+	 * S4-generation UARTs (S4, T7, ...) derive the baud rate from the
>+	 * crystal divided by 2, older ones divide by 3.
>+	 */
>+	return (dev_get_driver_data(dev) & MESON_UART_XTAL_DIV2) ? 2 : 3;
>+}
>+
>+static u32 meson_calc_baud_divisor(struct udevice *dev, ulong src_rate, u32 baud)
> {
> 	/*
> 	 * Usually src_rate is 24 MHz (from crystal) as clock source for serial
>-	 * device. Since 8 Mb/s is the maximum supported baud rate, use div by 3
>-	 * to derive baud rate. This choice is used also in meson_serial_setbrg.
>+	 * device. Since 8 Mb/s is the maximum supported baud rate, use a
>+	 * divided crystal to derive the baud rate. This choice is used also in
>+	 * meson_serial_setbrg.
> 	 */
>-	return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
>+	return DIV_ROUND_CLOSEST(src_rate / meson_uart_xtal_div(dev), baud) - 1;
> }
> 
>-static void meson_serial_set_baud(struct meson_uart *uart, ulong src_rate, u32 baud)
>+static void meson_serial_set_baud(struct udevice *dev, struct meson_uart *uart,
>+				  ulong src_rate, u32 baud)
> {
> 	/*
>-	 * Set crystal divided by 3 (regardless of device tree clock property)
>+	 * Set the divided crystal (regardless of device tree clock property)
> 	 * as clock source and the corresponding divisor to approximate baud
> 	 */
>-	u32 divisor = meson_calc_baud_divisor(src_rate, baud);
>+	u32 divisor = meson_calc_baud_divisor(dev, src_rate, baud);
> 	u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
> 		(divisor & AML_UART_REG5_BAUD_MASK);
>+
>+	if (meson_uart_xtal_div(dev) == 2)
>+		val |= AML_UART_REG5_XTAL_DIV2;
>+
>+	/* Drain the transmitter before changing the baud rate */
>+	while ((readl(&uart->status) & (AML_UART_TX_EMPTY | AML_UART_XMIT_BUSY))
>+	       != AML_UART_TX_EMPTY)
>+		;
>+
> 	writel(val, &uart->reg5);
> }
> 
>@@ -109,7 +132,7 @@ static int meson_serial_probe(struct udevice *dev)
> 		return ret;
> 	ulong rate = clk_get_rate(&per_clk);
> 
>-	meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
>+	meson_serial_set_baud(dev, uart, rate, CONFIG_BAUDRATE);
> 	meson_serial_init(uart);
> 
> 	return 0;
>@@ -165,8 +188,9 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
> {
> 	/*
> 	 * Change device baud rate if baud is reasonable (considering a 23 bit
>-	 * counter with an 8 MHz clock input) and the actual baud
>-	 * rate is within 2% of the requested value (2% is arbitrary).
>+	 * counter with an 8 MHz, or 12 MHz for XTAL_DIV2 devices, clock input)
>+	 * and the actual baud rate is within 2% of the requested value (2% is
>+	 * arbitrary).
> 	 */
> 	if (baud < 1 || baud > 8000000)
> 		return -EINVAL;
>@@ -179,14 +203,14 @@ static int meson_serial_setbrg(struct udevice *dev, const int baud)
> 	if (ret)
> 		return ret;
> 	ulong rate = clk_get_rate(&per_clk);
>-	u32 divisor = meson_calc_baud_divisor(rate, baud);
>-	u32 calc_baud = (rate / 3) / (divisor + 1);
>+	u32 divisor = meson_calc_baud_divisor(dev, rate, baud);
>+	u32 calc_baud = (rate / meson_uart_xtal_div(dev)) / (divisor + 1);
> 	u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - baud;
> 
> 	if (((calc_err * 100) / baud) > 2)
> 		return -EINVAL;
> 
>-	meson_serial_set_baud(uart, rate, baud);
>+	meson_serial_set_baud(dev, uart, rate, baud);
> 
> 	return 0;
> }
>@@ -244,6 +268,7 @@ static const struct udevice_id meson_serial_ids[] = {
> 	{ .compatible = "amlogic,meson-uart" },
> 	{ .compatible = "amlogic,meson-gx-uart" },
> 	{ .compatible = "amlogic,meson-a1-uart" },
>+	{ .compatible = "amlogic,meson-s4-uart", .data = MESON_UART_XTAL_DIV2 },
> 	{ }
> };
> 
>-- 
>2.55.0

Best regards,
Ferass
