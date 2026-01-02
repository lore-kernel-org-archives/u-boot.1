Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E89BE9410B
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 08:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E633839B1;
	Fri,  2 Jan 2026 09:40:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MBejIUKk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E12F4839E2; Fri,  2 Jan 2026 09:40:44 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4D36839AC
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 09:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5B6593F5A1
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 08:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767343242;
 bh=BrhnXPU8M0jAPonE6inKcOjLL5fMRaF/xuzuOzra9uA=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
 In-Reply-To:Content-Type;
 b=MBejIUKkubdANXxlLkamYiISEYhSNeyvnsC5YfYBcGHS3P/0wBepuTYXuetA1/AZ1
 4cHu+tnC4YhUflnmZWfHAww5xcd0A9NGAxNaYo46UxkQ0dNRdpqFuAKb2umCAxsUng
 rA7Y4fOj8RgN+JuiTkj6RqvTVwBIwuZYj9cdzKtUiIwO2Zn2mOPesffpE4bpjl0Nuj
 tmXmnVrepUElLHpXqkya7XpJHoVDeaPyyhLV4odjwIXwDclJEGpiSMLub4HwxdkhK2
 qr+bSpXL8ws2QBgkUOgw0wh9lY03Sfq8b6YnnVnUylDVtZXYo8ofMaNphMpCfLobzi
 P7Fy9vLxOS11XMBodCSJxk8yonUYsmMUzq3QsJY2fCU6iacJX9V+TMVKSB2jQEPOSw
 d+4w7GxCShSqWXgl0cUHaC4vlwPUtrxjpSQHJUABaaaYhfAT3yMi4bejg1A90sl5ab
 kmVy/LO+O5v7bzJBdUwheVLGiwrrRcsGRiOcQlsY8YyBRPe5U2OEPB6flVw7mK3EMz
 xJbEg1rfER1PGRV8zlT/RYuek4iZybhN/It8+0IwdsPy/u6VQeuknTsGDN2QLnnkjv
 GMaYNjcqR6OubwusNYVhq8u6dzWu7lUxrm8QozuDzngW4LzhzCn+G7vLSzrg0coAq8
 yJMiPx+8M0DzuUag7kaXKnc8=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47777158a85so131966215e9.3
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 00:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767343242; x=1767948042;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BrhnXPU8M0jAPonE6inKcOjLL5fMRaF/xuzuOzra9uA=;
 b=eypzFPS2DRK0V/T+ibq2bCf/zvr0769LR/OKPew1nWa1/u7tgJ6OGJ95M8o6x1qC5a
 gxm3NgqDFx6gjoUfQJ5b+gviGEsZzinkjee4tF9yLtZL2Z2D01NHTnqjq9vmNsWt0PRK
 XL8Lvoc5p46hA8UGMwmvjaK5LdbuaTlndw4OS49H/D3CPijqrPrLt3aOdzZoDJ/2o16I
 CZQ4c8NhsBkmHOJ6VnGlq5zULaAg4bhzHw8tTlDHm+xquFDY0taHKTMXZDhL657fFcad
 ovBdrCfiQ359bm748xa2CT2NiDCc15UePJi8pOjy0+TIgIXVuaHjFLx7zFFVR5a7vvN6
 5E4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpFDGBThqplLiGp6g0DW8XQNJEPM+Ig5kDVAVB6sVbc9/yWaD2uI/8dwkFuuh0GeetCcYOprI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/D2yNu9uRmKtLMqEZlmqo6eCWQQcyO7yTA89Iees1OS6faMGm
 jqR55q+S8wPFkOQhjfXN/IoKFRY1azUGZOYA7azc7trsnAikGJIKwyAbbf8oFfS7l6V5k5UIGDK
 yRZhvhuVxhUASS/njdzUsyisNxj2tBE8GXFE2LPdCWuoSnNUXzj4UVk84dHBEiXP/AyKuHkI=
X-Gm-Gg: AY/fxX6MMEUeNShgPCgVMXtm5gOc1iOQhptu20OlhXq+kamIX9srXNiI9eHBPbZPOIn
 gGXzYeTNm+ZSdADxMW5vHXTkyM6VqdtzLfE8OHWTZNdKzL7ZkX/Lo2EoN1fQ4w5FrMFP9cdJCNs
 ywuiUB8m0MOpXn9LEIstbKVbMKNoSYDxpHrakspn099TfhiixPGyxhFNXo6epZPR6HAeZtcEzUb
 YO/yfd0b9szSYnieEjR+6nyWoeVu/q03MdOV24vVtQud/tVrTkWl4WQhLXB8EkaAcvxxaJ0oRQd
 3zB0Rzm0l8j8I09p6d61KAFilJtf4tkLuaENXyCcsObZ28TW29PRvneDtuCZFBmRtPm8MC8T9dt
 +q33lv43ucadbgkgQCfyTlotT5Z7K+UuUCBemrdZjB4fPQx2Aou9fhhZ60W/9kcKrF6kk/W3+hG
 SsUxAmxsY=
X-Received: by 2002:a05:600c:45c8:b0:477:7c45:87b2 with SMTP id
 5b1f17b1804b1-47d195843e7mr529006435e9.16.1767343241873; 
 Fri, 02 Jan 2026 00:40:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWO4NeVqMORrhPZpzrUc5q3IlwrK/pAnvsLVAJgG3aoZpBiQTdCh+/oqGDEO2YVfvIhR1FAw==
X-Received: by 2002:a05:600c:45c8:b0:477:7c45:87b2 with SMTP id
 5b1f17b1804b1-47d195843e7mr529006045e9.16.1767343241418; 
 Fri, 02 Jan 2026 00:40:41 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b28a7sm784882085e9.12.2026.01.02.00.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jan 2026 00:40:40 -0800 (PST)
Message-ID: <855488fb-4ae9-4468-aa2e-68575ce4dc8e@canonical.com>
Date: Fri, 2 Jan 2026 09:40:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] serial: Add Goldfish TTY driver
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
References: <20260101175420.4118024-1-visitorckw@gmail.com>
 <20260101175420.4118024-2-visitorckw@gmail.com>
 <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
Content-Language: en-US
In-Reply-To: <618be257-d247-4811-9cfd-e58017aba579@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 1/2/26 09:29, Heinrich Schuchardt wrote:
> On 1/1/26 18:54, Kuan-Wei Chiu wrote:
>> Add support for the Google Goldfish TTY serial device. This virtual
>> device is commonly used in QEMU virtual machines (such as the m68k
>> virt machine) and Android emulators.
>>
>> The driver implements basic console output and input polling using the
>> Goldfish MMIO interface.
>>
>> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>> Reviewed-by: Yao Zi <me@ziyao.cc>
>> Tested-by: Daniel Palmer <daniel@0x0f.com>
> 
> Acked-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 
>> ---
>> Changes in v4:
>> - Support DT probing with platform data as a fallback.
>>
>>   MAINTAINERS                      |   6 ++
>>   drivers/serial/Kconfig           |   8 +++
>>   drivers/serial/Makefile          |   1 +
>>   drivers/serial/serial_goldfish.c | 109 +++++++++++++++++++++++++++++++
>>   include/goldfish_tty.h           |  18 +++++
>>   5 files changed, 142 insertions(+)
>>   create mode 100644 drivers/serial/serial_goldfish.c
>>   create mode 100644 include/goldfish_tty.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6ce0bbce13d..da4a6e4d518 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1259,6 +1259,12 @@ S:    Maintained
>>   F:    drivers/misc/gsc.c
>>   F:    include/gsc.h
>> +GOLDFISH SERIAL DRIVER
>> +M:    Kuan-Wei Chiu <visitorckw@gmail.com>
>> +S:    Maintained
>> +F:    drivers/serial/serial_goldfish.c
>> +F:    include/goldfish_tty.h
>> +

Applying: serial: Add Goldfish TTY driver
Patch failed at 0001 serial: Add Goldfish TTY driver
error: patch failed: MAINTAINERS:1259
error: MAINTAINERS: patch does not apply

Should a respin of the series be needed, please, check that the series 
applies to origin/next before sending.

Best regards

Heinrich

>>   I2C
>>   M:    Heiko Schocher <hs@nabladev.com>
>>   S:    Maintained
>> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
>> index 371d7aa5bba..b84cb9ec781 100644
>> --- a/drivers/serial/Kconfig
>> +++ b/drivers/serial/Kconfig
>> @@ -1193,4 +1193,12 @@ config SYS_SDMR
>>       depends on MPC8XX_CONS
>>       default 0x0
>> +config SERIAL_GOLDFISH
>> +    bool "Goldfish TTY support"
>> +    depends on DM_SERIAL
>> +    help
>> +      Select this to enable support for the Goldfish TTY serial port.
>> +      This virtual device is commonly used by QEMU virtual machines
>> +      (e.g. m68k virt) for console output.
>> +
>>   endif
>> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
>> index 8eaae62b0fc..fe8d23be512 100644
>> --- a/drivers/serial/Makefile
>> +++ b/drivers/serial/Makefile
>> @@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += 
>> serial_xtensa_semihosting.o
>>   obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
>>   obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
>> +obj-$(CONFIG_SERIAL_GOLDFISH) += serial_goldfish.o
>> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/ 
>> serial_goldfish.c
>> new file mode 100644
>> index 00000000000..278d0cf3e0d
>> --- /dev/null
>> +++ b/drivers/serial/serial_goldfish.c
>> @@ -0,0 +1,109 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
>> + * Goldfish TTY driver for U-Boot
>> + */
>> +
>> +#include <asm/io.h>
>> +#include <dm.h>
>> +#include <goldfish_tty.h>
>> +#include <linux/types.h>
>> +#include <mapmem.h>
>> +#include <serial.h>
>> +
>> +/* Goldfish TTY Register Offsets */
>> +#define GOLDFISH_TTY_PUT_CHAR       0x00
>> +#define GOLDFISH_TTY_BYTES_READY    0x04
>> +#define GOLDFISH_TTY_CMD            0x08
>> +#define GOLDFISH_TTY_DATA_PTR       0x10
>> +#define GOLDFISH_TTY_DATA_LEN       0x14
>> +#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
>> +#define GOLDFISH_TTY_VERSION        0x20
>> +
>> +/* Commands */
>> +#define CMD_WRITE_BUFFER   2
>> +#define CMD_READ_BUFFER    3
>> +
>> +struct goldfish_tty_priv {
>> +    void __iomem *base;
>> +    u8 rx_buf;
>> +};
>> +
>> +static int goldfish_serial_getc(struct udevice *dev)
>> +{
>> +    struct goldfish_tty_priv *priv = dev_get_priv(dev);
>> +    unsigned long paddr;
>> +    u32 count;
>> +
>> +    count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
>> +    if (count == 0)
>> +        return -EAGAIN;
>> +
>> +    paddr = virt_to_phys((void *)&priv->rx_buf);
>> +
>> +    __raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
>> +    __raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
>> +    __raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
>> +    __raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
>> +
>> +    return priv->rx_buf;
>> +}
>> +
>> +static int goldfish_serial_putc(struct udevice *dev, const char ch)
>> +{
>> +    struct goldfish_tty_priv *priv = dev_get_priv(dev);
>> +
>> +    __raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
>> +
>> +    return 0;
>> +}
>> +
>> +static int goldfish_serial_pending(struct udevice *dev, bool input)
>> +{
>> +    struct goldfish_tty_priv *priv = dev_get_priv(dev);
>> +
>> +    if (input)
>> +        return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
>> +
>> +    return 0;
>> +}
>> +
>> +static int goldfish_serial_probe(struct udevice *dev)
>> +{
>> +    struct goldfish_tty_priv *priv = dev_get_priv(dev);
>> +    struct goldfish_tty_plat *plat = dev_get_plat(dev);
>> +    fdt_addr_t addr;
>> +
>> +    addr = dev_read_addr(dev);
>> +    if (addr != FDT_ADDR_T_NONE) {
>> +        priv->base = map_sysmem(addr, 0x1000);
>> +    } else {
>> +        plat = dev_get_plat(dev);
>> +        if (!plat)
>> +            return -EINVAL;
>> +        priv->base = plat->base;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct dm_serial_ops goldfish_serial_ops = {
>> +    .putc = goldfish_serial_putc,
>> +    .pending = goldfish_serial_pending,
>> +    .getc = goldfish_serial_getc,
>> +};
>> +
>> +static const struct udevice_id goldfish_serial_ids[] = {
>> +    { .compatible = "google,goldfish-tty" },
>> +    { }
>> +};
>> +
>> +U_BOOT_DRIVER(serial_goldfish) = {
>> +    .name    = "serial_goldfish",
>> +    .id    = UCLASS_SERIAL,
>> +    .of_match = goldfish_serial_ids,
>> +    .probe    = goldfish_serial_probe,
>> +    .ops    = &goldfish_serial_ops,
>> +    .priv_auto = sizeof(struct goldfish_tty_priv),
>> +    .flags    = DM_FLAG_PRE_RELOC,
>> +};
>> diff --git a/include/goldfish_tty.h b/include/goldfish_tty.h
>> new file mode 100644
>> index 00000000000..8777da4942d
>> --- /dev/null
>> +++ b/include/goldfish_tty.h
>> @@ -0,0 +1,18 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
>> + */
>> +
>> +#ifndef _GOLDFISH_TTY_H_
>> +#define _GOLDFISH_TTY_H_
>> +
>> +#include <linux/types.h>
>> +
>> +/* Platform data for the Goldfish TTY driver
>> + * Used to pass hardware base address from Board to Driver
>> + */
>> +struct goldfish_tty_plat {
>> +    void __iomem *base;
>> +};
>> +
>> +#endif /* _GOLDFISH_TTY_H_ */
> 

