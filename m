Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90ABBC71153
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 10:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 920B6847C3;
	Mon,  4 Sep 2023 12:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="uZJOyNLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24CC4864A7; Mon,  4 Sep 2023 12:22:01 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3858280B98
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 12:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C8C7A3F20F
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 10:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1693822917;
 bh=v8vBYDUfP4Pxg54LTfqEoRk5rDjyrccww3PweKIxMD8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=uZJOyNLdoGK7gPJWSxgyKUQNt7FO2zp1WS0G2V0my1pgzeE2/Mj118oO8VXV71U+q
 xSzOq5EvmN4faOg9ODta1EqqFVDh1R5zNLEMKp7Q3WdD+2VHSO+ZwcKjMYoDsVTTFh
 AIxGvXk0sgDK+yCQGfB5bXEq8eJIJxUkmktgk7JKdx+eaTQh+MTooB4oMAZa9lvvQ+
 NzLJED9mOBuPk+ZG1WSp+aXlWUm2Ryrs6ekY8vXx03arkvKRR/Ha9AVmka2DxMUVn9
 Y3JQG3j4L0SYBCvaapZFze7flyV5CTkU78SYXxSzRtUJngJtKysULsMNR3UP1ytvd4
 aXq5YCGfmOXRA==
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso89360266b.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 03:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693822917; x=1694427717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v8vBYDUfP4Pxg54LTfqEoRk5rDjyrccww3PweKIxMD8=;
 b=NoTvUqcUfuCgMEN4haNgHiHWJ2+UQEMeoozRzJlUweGKKaXM+GiwXwBvrSG39HRTWj
 ngIXaji+z9TJtzYSqFwibJR5wpHuOyq2ov6SvhO4CayR2q3rtPi2sNnUNLrbmuyfGfL/
 UxdWmvanCbjwcxt+R4cJ/Zd+tmiU2oQQ7eX7C7XgB5+pLqJq7d3i78sI5PTWiY/G99Gv
 8dRQJJ+OpTi69qAqYj9aX0ovcMq7Gpk97nMPtG5E2eIvGwFYR960GRgj9i5zRQHOLw0U
 dihR3ZAKL8EBDf5L8Lvx7P1Y5aRUNq4yTErERjdclGXVZkwSyGjWXFOpc8+dlKNbeVPU
 3SPw==
X-Gm-Message-State: AOJu0YwmaqsW98xXlPyIA0Hi4Zqa5Il0eUs5pUvoIemSSj7Ywj8iRYB8
 PVzyIeJtsos4tY4EbWyYGAldmUxO67rDXKMQiUgERnyDtCIZDB2Kq9OjkiNjLEotpbjguqKmJEX
 002BC56OwfEJ5xw3mReIB5gfFgceATmo=
X-Received: by 2002:a17:906:224a:b0:9a1:b144:30f0 with SMTP id
 10-20020a170906224a00b009a1b14430f0mr7663335ejr.53.1693822917513; 
 Mon, 04 Sep 2023 03:21:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYd3BiZ5mI9CTWHB2EASorOOQRpnkoVKOH/sG6uIIhBPDgXQdSIpu1+q4y+Rq1dc9/tckTRw==
X-Received: by 2002:a17:906:224a:b0:9a1:b144:30f0 with SMTP id
 10-20020a170906224a00b009a1b14430f0mr7663319ejr.53.1693822917096; 
 Mon, 04 Sep 2023 03:21:57 -0700 (PDT)
Received: from [192.168.89.42]
 (dynamic-046-114-152-014.46.114.pool.telefonica.de. [46.114.152.14])
 by smtp.gmail.com with ESMTPSA id
 rn5-20020a170906d92500b0099cc402d3ddsm5867768ejb.202.2023.09.04.03.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 03:21:56 -0700 (PDT)
Message-ID: <288365fb-80f0-42d0-a960-e7adf45c28a5@canonical.com>
Date: Mon, 4 Sep 2023 12:22:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] risc-v: implement DBCN based debug console
Content-Language: en-US, de-DE
To: Chanho Park <chanho61.park@samsung.com>
Cc: 'Bin Meng' <bmeng.cn@gmail.com>, 'Anup Patel' <apatel@ventanamicro.com>,
 u-boot@lists.denx.de, 'Leo' <ycliang@andestech.com>,
 'Rick Chen' <rick@andestech.com>
References: <20230819131250.10251-1-heinrich.schuchardt@canonical.com>
 <CGME20230819131306epcas2p115da29b1053ca3f7d852317e7c61b831@epcas2p1.samsung.com>
 <20230819131250.10251-3-heinrich.schuchardt@canonical.com>
 <004301d9df12$6e749600$4b5dc200$@samsung.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <004301d9df12$6e749600$4b5dc200$@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/4/23 11:30, Chanho Park wrote:
> Hi,
> 
>> -----Original Message-----
>> From: U-Boot <u-boot-bounces@lists.denx.de> On Behalf Of Heinrich
>> Schuchardt
>> Sent: Saturday, August 19, 2023 10:13 PM
>> To: Rick Chen <rick@andestech.com>; Leo <ycliang@andestech.com>
>> Cc: Bin Meng <bmeng.cn@gmail.com>; Anup Patel <apatel@ventanamicro.com>;
>> u-boot@lists.denx.de; Heinrich Schuchardt
>> <heinrich.schuchardt@canonical.com>
>> Subject: [PATCH 2/2] risc-v: implement DBCN based debug console
>>
>> Use the DBCN SBI extension to implement a debug console.
>> Make it the default for S-mode RISC-V.
>>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   drivers/serial/Kconfig      |  3 ++-
>>   drivers/serial/serial_sbi.c | 19 +++++++++++++++++++
>>   2 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig index
>> a1e089962a..8421c5c047 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -218,6 +218,7 @@ config DEBUG_UART
>>   choice
>>   	prompt "Select which UART will provide the debug UART"
>>   	depends on DEBUG_UART
>> +	default DEBUG_SBI_CONSOLE if RISCV_SMODE
>>   	default DEBUG_UART_NS16550
>>
>>   config DEBUG_UART_ALTERA_JTAGUART
>> @@ -289,7 +290,7 @@ config DEBUG_EFI_CONSOLE
>>
>>   config DEBUG_SBI_CONSOLE
>>   	bool "SBI"
>> -	depends on SBI_V01
>> +	depends on RISCV_SMODE
>>   	help
>>   	  Select this to enable a debug console which calls back to SBI to
>>   	  output to the console. This can be useful for early debugging of
>> diff --git a/drivers/serial/serial_sbi.c b/drivers/serial/serial_sbi.c
>> index b9f35ed36e..093c7309d3 100644
>> --- a/drivers/serial/serial_sbi.c
>> +++ b/drivers/serial/serial_sbi.c
>> @@ -3,6 +3,8 @@
>>   #include <debug_uart.h>
>>   #include <asm/sbi.h>
>>
>> +#ifdef CONFIG_SBI_V01
>> +
>>   static inline void _debug_uart_init(void)  {  } @@ -13,4 +15,21 @@ static
>> inline void _debug_uart_putc(int c)
>>   		sbi_console_putchar(c);
>>   }
>>
>> +#else
>> +
>> +static int sbi_dbcn_available;
>> +
>> +static inline void _debug_uart_init(void) {
>> +	sbi_dbcn_available = sbi_probe_extension(SBI_EXT_DBCN);
>> +}
>> +
>> +static inline void _debug_uart_putc(int ch) {
>> +	if (sbi_dbcn_available)
>> +		sbi_dbcn_write_byte(ch);
>> +}
>> +
>> +#endif
>> +
>>   DEBUG_UART_FUNCS
>> --
>> 2.40.1
> 
> I've got below error when I tried to build it with VisionFive2 board
> configuration(starfive_visionfive2_defconfig).
> To test this patch, I enabled CONFIG_DEBUG_SBI_CONSOLE. Seems like spl also
> includes the driver when DEBUG_SBI_CONSOLE is enabled.
> Do I need to do any more configurations to test this?
> 
> LD      spl/u-boot-spl
> riscv64-unknown-linux-gnu-ld.bfd: drivers/serial/serial_sbi.o: in function
> `_debug_uart_putc':
> /data/risc-v/vf2/mainline/u-boot/drivers/serial/serial_sbi.c:30: undefined
> reference to `sbi_dbcn_write_byte'
> riscv64-unknown-linux-gnu-ld.bfd:
> /data/risc-v/vf2/mainline/u-boot/drivers/serial/serial_sbi.c:30: undefined
> reference to `sbi_dbcn_write_byte'
> riscv64-unknown-linux-gnu-ld.bfd: drivers/serial/serial_sbi.o: in function
> `_debug_uart_init':
> /data/risc-v/vf2/mainline/u-boot/drivers/serial/serial_sbi.c:24: undefined
> reference to `sbi_probe_extension'
> make[2]: *** [/data/risc-v/vf2/mainline/u-boot/scripts/Makefile.spl:527:
> spl/u-boot-spl] Error 1
> 
> Best Regards,
> Chanho Park
> 

Hello Chanho,

thanks for reporting the issue. SBI is not available in M-mode. We need 
a check in the driver like

     if (!CONFIG_IS_ENABLED(RISCV_MMODE))

I will send a new version of the series.

Best regards

Heinrich
