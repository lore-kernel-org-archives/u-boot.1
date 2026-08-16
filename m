Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EF9C5DF70
	for <u-boot@archiver.kernel.org>; Sun, 16 Aug 2026 14:20:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 100FD406F7;
	Sun, 16 Aug 2026 14:20:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N76Nui8UhjrP; Sun, 16 Aug 2026 14:20:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A39B340656
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786890003;
	bh=/qIqtk3+OKTaS6CZOGcaGLjVT9i7tgzbV7HjiaxEBHk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ney1vJRKfN0APVn//Bq9WdCY53bClSEXiu5GSxBxHr+hjC/4e+LXKAP+gn9ftmDio
	 YQuIjN0fp3r2SUQx2Nmg4n5urYqbyQwbXjLggBJzb1iN6frX+6kRLCBS0pOKGoLjUz
	 r5hWIM7SqxM9jxjGWHGEEiS/mu1QSw5FqHLn4uNKhp/4+Gdr5Wq9pyYYbFVPgaaSnK
	 ixO7aOe8esUQR+Bt+E2EFBUH/X66+lb0IUD9SH9bIr5y6XJqpd/s8GX89ANNt64ycD
	 J0gxVCXhagtZUbqJ7aNsTkxC2RdkZBaQVdXKYA+ZeS0IFfEGC9csqsWM1CIUrLuaHC
	 AA8+dFRorrw1w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A39B340656;
	Sun, 16 Aug 2026 14:20:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5681A333
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 10:42:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 489B44009D
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 10:42:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lQKkIj4zyNJh for <u-boot@lists.u-boot-project.org>;
 Sun, 16 Aug 2026 10:42:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.128.54;
 helo=mail-wm1-f54.google.com; envelope-from=tanurelinux@gmail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org AE44B4005C
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=linux.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AE44B4005C
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE44B4005C
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 10:42:49 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-499840a2575so18361095e9.3
 for <u-boot@lists.u-boot-project.org>; Sun, 16 Aug 2026 03:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786876967; x=1787481767;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/qIqtk3+OKTaS6CZOGcaGLjVT9i7tgzbV7HjiaxEBHk=;
 b=q7cQ3KCwQ6+VfFv7XItgiU0F4C5QcJh49+XFMS+jlVfCIyy4B2nX1EC9xZQLIRz5oU
 bF/j9SDoynqiCdqJStdVOm48CmKqOYM9UmSnjthEIup2v5Kllw/vYYWY6n/BqHD4hdwI
 5kwQqFJgk48DR+KM44f2fQlEpxdudNhBNez9weMH1bPZVEdG3QGIna3XEVmjAXdr1k6H
 PYT+EXFO/JC+FJhAKB71srQJDxdvA1ksuP5sOoWKeZy2NgOXsTciOXDjfNDG2nZGb9P2
 Inrx+H7Ip131TlAsF4t4nuEbRevRF4i6L2qcyeNsKuSbrs+KcMnwQZV76EGTYFMgAqQB
 dUFw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rox+DDO0RnEAlYlV45aLOBXicWrwwBvy31ZF6ZNGTzq35ZuVb8w8CG2RxP5L6qgvleLzQJz91E=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx/LVBz4St/+C3fLtla3lPn5Wbm9Ib6H6+tTa4wOm0OUZMlpvYq
 t34qgoUiFv2N1d2Z5YlAPVI/ao+r7QQl9LOfZMMnmG61hBHmIRbhDFfK
X-Gm-Gg: AR+sD10cHSymGz2dfX/9A8Yj3FltV4PMbrc7j3vwr2dPJzJFD0xUe3UrL6SwSJcgfwv
 9bf7jvXeD3GuZnchQHO9ig3tpJjdA8MGVGdqve0es8IZhVurwyVACf7D7Hwnhbrbdi3M0nG+ySy
 s9QG6q0V7luhX4cbT2rEAWWKN2Z7CPZrDe6twBciTmYuDx7qrpgUDu2OCqXl6fKW042E/XiJkyT
 IdR6KKW77UFzlLaCLFxM47iJIeCEleklNkAyTPcV74wmEsgmO8lMHQJO6UphbkGF8t5u6G9JUFQ
 zaw9iCTGaaETcFAEsG1njv4ZZ1RLvezKQ9E11tYjtB9EhLVhtP6atqoogMKirDOwJIu6kriPR4Z
 E0XdKwAWuKBdGDk0Jg7BDPyko4kzQ3Nbf10GDDhlxiOFjD8ig1q0V7Wp7qnd/DEnaQeh8Iys7vB
 8FfhvrJbHswmnoRr0bKw+/k1hPjnmt5zqM981fnoLdneE5LxlD9CRBLZSExs0n4kd+NnPqqCcqJ
 LOO3SsAc34VKahWtMJ15A==
X-Received: by 2002:a05:600c:828c:b0:495:3da3:beb with SMTP id
 5b1f17b1804b1-49989345963mr255109655e9.10.1786876967129; 
 Sun, 16 Aug 2026 03:42:47 -0700 (PDT)
Received: from [192.168.1.135] ([83.106.158.114])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ddaesm50443565e9.7.2026.08.16.03.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 03:42:45 -0700 (PDT)
Message-ID: <e8d19994-1236-4984-be2a-058cc317d10b@linux.com>
Date: Sun, 16 Aug 2026 11:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] serial: meson: add Amlogic S4 UART support
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: neil.armstrong@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20260806101809.72526-1-tanure@linux.com>
 <20260806101809.72526-2-tanure@linux.com>
 <tjk4ry.249pxi1g19ygb@postmarketos.org>
Content-Language: en-US
From: Lucas Tanure <tanure@linux.com>
In-Reply-To: <tjk4ry.249pxi1g19ygb@postmarketos.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 16 Aug 2026 14:20:00 +0000
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

On 10/08/2026 15:01, Ferass El Hafidi wrote:
> On Thu, 06 Aug 2026 10:18, "Lucas Tanure via groups.io" 
> <tanure=linux.com@groups.io> wrote:
>> The S4-generation UART (S4, T7, ...) derives its baud rate from the
>> 24 MHz crystal divided by 2, selected via the XTAL_DIV2 bit in the
>> baud rate register, while older SoCs divide the crystal by 3. Add the
>> "amlogic,meson-s4-uart" compatible with driver data selecting the
>> div-by-2 scheme, matching the Linux driver (meson_s4_uart_data) and
>> the configuration the vendor BL2 programs on T7 hardware.
>>
>> Older SoCs keep the existing div-by-3 behaviour: Linux also uses
>> div-by-2 on G12A, but both modes work there and switching would risk
>> regressing boards that have shipped with div-by-3 for years.
>>
>> Also drain the transmitter before changing the baud rate so in-flight
>> characters are not garbled, as the Linux driver does.
>>
>> Assisted-by: Claude:claude-fable-5
> 
> As I understand it, LLM-assisted patches are not welcome in U-Boot right
> now: https://lore.kernel.org/u-boot/20260515220758.GM1858239@bill-the-cat/
> 
> AFAIK there isn't an official AI policy yet, but it seems the concensus
> on that matter is currently "please don't". Sorry.

Ok, I will drop this line.

> 
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>> drivers/serial/serial_meson.c | 51 ++++++++++++++++++++++++++---------
>> 1 file changed, 38 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/ 
>> serial_meson.c
>> index cc71381f87e..d909fedcfc4 100644
>> --- a/drivers/serial/serial_meson.c
>> +++ b/drivers/serial/serial_meson.c
>> @@ -62,26 +62,49 @@ struct meson_serial_plat {
>> #define AML_UART_REG5_USE_NEW_BAUD    BIT(23) /* default 1 (use new 
>> baud rate register) */
>> #define AML_UART_REG5_BAUD_MASK        0x7fffff
>>
>> +/* Driver data flags */
>> +#define MESON_UART_XTAL_DIV2    BIT(0)
>> +
>> #if CONFIG_IS_ENABLED(DM_SERIAL)
>> -static u32 meson_calc_baud_divisor(ulong src_rate, u32 baud)
>> +static u32 meson_uart_xtal_div(struct udevice *dev)
>> +{
>> +    /*
>> +     * S4-generation UARTs (S4, T7, ...) derive the baud rate from the
>> +     * crystal divided by 2, older ones divide by 3.
>> +     */
>> +    return (dev_get_driver_data(dev) & MESON_UART_XTAL_DIV2) ? 2 : 3;
>> +}
>> +
>> +static u32 meson_calc_baud_divisor(struct udevice *dev, ulong 
>> src_rate, u32 baud)
>> {
>>     /*
>>      * Usually src_rate is 24 MHz (from crystal) as clock source for 
>> serial
>> -     * device. Since 8 Mb/s is the maximum supported baud rate, use 
>> div by 3
>> -     * to derive baud rate. This choice is used also in 
>> meson_serial_setbrg.
>> +     * device. Since 8 Mb/s is the maximum supported baud rate, use a
>> +     * divided crystal to derive the baud rate. This choice is used 
>> also in
>> +     * meson_serial_setbrg.
>>      */
>> -    return DIV_ROUND_CLOSEST(src_rate / 3, baud) - 1;
>> +    return DIV_ROUND_CLOSEST(src_rate / meson_uart_xtal_div(dev), 
>> baud) - 1;
>> }
>>
>> -static void meson_serial_set_baud(struct meson_uart *uart, ulong 
>> src_rate, u32 baud)
>> +static void meson_serial_set_baud(struct udevice *dev, struct 
>> meson_uart *uart,
>> +                  ulong src_rate, u32 baud)
>> {
>>     /*
>> -     * Set crystal divided by 3 (regardless of device tree clock 
>> property)
>> +     * Set the divided crystal (regardless of device tree clock 
>> property)
>>      * as clock source and the corresponding divisor to approximate baud
>>      */
>> -    u32 divisor = meson_calc_baud_divisor(src_rate, baud);
>> +    u32 divisor = meson_calc_baud_divisor(dev, src_rate, baud);
>>     u32 val = AML_UART_REG5_USE_XTAL_CLK | AML_UART_REG5_USE_NEW_BAUD |
>>         (divisor & AML_UART_REG5_BAUD_MASK);
>> +
>> +    if (meson_uart_xtal_div(dev) == 2)
>> +        val |= AML_UART_REG5_XTAL_DIV2;
>> +
>> +    /* Drain the transmitter before changing the baud rate */
>> +    while ((readl(&uart->status) & (AML_UART_TX_EMPTY | 
>> AML_UART_XMIT_BUSY))
>> +           != AML_UART_TX_EMPTY)
>> +        ;
>> +
>>     writel(val, &uart->reg5);
>> }
>>
>> @@ -109,7 +132,7 @@ static int meson_serial_probe(struct udevice *dev)
>>         return ret;
>>     ulong rate = clk_get_rate(&per_clk);
>>
>> -    meson_serial_set_baud(uart, rate, CONFIG_BAUDRATE);
>> +    meson_serial_set_baud(dev, uart, rate, CONFIG_BAUDRATE);
>>     meson_serial_init(uart);
>>
>>     return 0;
>> @@ -165,8 +188,9 @@ static int meson_serial_setbrg(struct udevice 
>> *dev, const int baud)
>> {
>>     /*
>>      * Change device baud rate if baud is reasonable (considering a 23 
>> bit
>> -     * counter with an 8 MHz clock input) and the actual baud
>> -     * rate is within 2% of the requested value (2% is arbitrary).
>> +     * counter with an 8 MHz, or 12 MHz for XTAL_DIV2 devices, clock 
>> input)
>> +     * and the actual baud rate is within 2% of the requested value 
>> (2% is
>> +     * arbitrary).
>>      */
>>     if (baud < 1 || baud > 8000000)
>>         return -EINVAL;
>> @@ -179,14 +203,14 @@ static int meson_serial_setbrg(struct udevice 
>> *dev, const int baud)
>>     if (ret)
>>         return ret;
>>     ulong rate = clk_get_rate(&per_clk);
>> -    u32 divisor = meson_calc_baud_divisor(rate, baud);
>> -    u32 calc_baud = (rate / 3) / (divisor + 1);
>> +    u32 divisor = meson_calc_baud_divisor(dev, rate, baud);
>> +    u32 calc_baud = (rate / meson_uart_xtal_div(dev)) / (divisor + 1);
>>     u32 calc_err = baud > calc_baud ? baud - calc_baud : calc_baud - 
>> baud;
>>
>>     if (((calc_err * 100) / baud) > 2)
>>         return -EINVAL;
>>
>> -    meson_serial_set_baud(uart, rate, baud);
>> +    meson_serial_set_baud(dev, uart, rate, baud);
>>
>>     return 0;
>> }
>> @@ -244,6 +268,7 @@ static const struct udevice_id meson_serial_ids[] = {
>>     { .compatible = "amlogic,meson-uart" },
>>     { .compatible = "amlogic,meson-gx-uart" },
>>     { .compatible = "amlogic,meson-a1-uart" },
>> +    { .compatible = "amlogic,meson-s4-uart", .data = 
>> MESON_UART_XTAL_DIV2 },
>>     { }
>> };
>>
>> -- 
>> 2.55.0
> 
> Best regards,
> Ferass

