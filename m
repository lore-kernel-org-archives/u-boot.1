Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65677EE642F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 12:25:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD6F683F8F;
	Wed, 31 Dec 2025 13:25:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YcCiTraR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 932C48401F; Wed, 31 Dec 2025 13:25:15 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B50483F6D
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 13:25:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 048753F861
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 12:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767183913;
 bh=zC8G0X3ojWPyrSPOLg15fZr96P+YQTJTkHXVWnUFAFs=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=YcCiTraRJw/zOoyuu8QlV9qxGo/zbgnV4rf8R4pnJruN+4eH3dfXhT3kFCQgSOnNC
 ssBlwO6e2frjXBzBcU/9Ck7DtuqJNWXgnTiRPBN6wdqzzZ/xPPOW3Qmddlw44m+vKo
 LypYKG6021edUrAj9obFIXw21A8r1Uq8rQ/T/zPO6/wV8juqN46ZDVNR4dzG62qMuf
 qBAv08Ix9sJSAj4EupeifMLdFwKkygwADu1wyN8RiTiNsOEiBcCr1JF+9UhJ4DluMw
 5QuNl+ASTMVmgAc5kKwNf+lm2d6EzYv0cxop5S/2u3Z6HhXpI7MO0n1qxlzDg6e5rA
 65xyDSF0cubw40SyKiW4zRNA7hCmHGG6QgUtiIYx0qvvJgbY7bDHQ/7LZUk5ll5XxN
 9yDvcuGHlqV5BEdnMUSefVzFXKP5VGxvWcp/QDE+FnFZ/aANAnb4pkPYIRDIcr5u70
 UH3V7l3gBmOQrDvd7SDa3ro9mQadww+2EqeGtSrniiIZ5+VO7yYWCHkgq+G31wf0/9
 kC7MaZ1Wu4mu0svy1fht0qLCugKx50yjKmj3oiXFNdPDnDAu1fQyqw+T7ODDegHzis
 nzarSv7OK6htMt5unSybLj9P1TIW+DNcCvNVgWjAAmEjHP+SxEqAPiS6pkDjvtsutV
 V/OoXwyesGl13aD0nOmSHMiU=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4775f51ce36so95602885e9.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 04:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767183912; x=1767788712;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zC8G0X3ojWPyrSPOLg15fZr96P+YQTJTkHXVWnUFAFs=;
 b=FGwcQC783h7AkVoG+o+sDnssbbmOZUU9/yRvZ5+/thKAMxQgOKLZlG4yM4pH+06gbB
 m+VzLu4irb819GmmO3r6m2V9cCVmn4qwauET1j4jNnrpiDvUfiPGyvo4AB0VeAl7568w
 6NAIbBOWJZ/DILspn5wAMrQsFL013PHmIow6xrJmqWQmdXyruSFhS1qh25qfugEU5glT
 roo+ytwzA/CGSu7Pu/23nW0M41wN78E2Ut+av+zX5/Spda7BuO5RdUASAJg9pj3KZNur
 LRv283X2UHAwyoPN5R8g+UpxVodbiCuscyvI8PN6CsI7YKTuH9VaEdYPiqftrBKsR3Am
 7qlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJBjrf1NOHFb28VbRORudq0s85fcQ1LTms0Kse9YqKBmUJMePhIGF/BBnOYh2pAELsUFOLtVQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzIjpt4J9C1kT9nh0lKFzeGIIpazslpSrx3JNyQYzBNu2Qg6mQX
 7Z1g6pWmFVyADAVwQMCHqJSFvv7rVyDR7MMwF8fou3GW8hY6U29GRQJGja818lx7aoLImoUe20k
 bXh6A6QDW+Ia75jQRiMMpSBSu/RVbqeJP7PCijsEvSgrN1AQJLvvytigamTQrH1HJAmwMmfs=
X-Gm-Gg: AY/fxX4hca/0UvZ5uqLWWRfelqsHlm/tOvoSgpeLZWPZ3ncX8VHraBg7SqY8yvGaAoN
 S3cELqA01C4rReYnwloW/onyuNFUM6BNhXuFmfwNcNjvc6nzr0zwVrWRstoWcaLp7+O3bqCMBDH
 aZXfWj9G4d0n/WtKVTGtNRRrndyz33TjaZjqRBU3eVzm60XuwyJvBdoOyWgig9VRhzRbNqbP8+E
 XAOYOh1sWppLW70VoUP+DRuiQnUIR35LrC3wLSud91brFQ/dXhbCfiN+r6g8YvJ4TW7S2sfej5s
 nxSpTnpSUWPsFJax+97o/lD7TAVo4Xoo5jw+q0aiobRMSroM4vF7f/knLxZsAlJLxM381CidGaS
 iMKeCka7Bb0A836g1yDFVRZ6u7QQJn7KOqg1AX37QQgJUDRfsCmR5ZD9EbndSz5Cz/g==
X-Received: by 2002:a05:600c:5487:b0:47b:da85:b9f3 with SMTP id
 5b1f17b1804b1-47d195a72c0mr474394425e9.23.1767183912414; 
 Wed, 31 Dec 2025 04:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXO9SE+/GgP3NkQggaKCv0qoVMSoG+y5ibbPiV8+8QbNbxGyVt3Gp3sJaR4Kn8nJjqTJFYkg==
X-Received: by 2002:a05:600c:5487:b0:47b:da85:b9f3 with SMTP id
 5b1f17b1804b1-47d195a72c0mr474394105e9.23.1767183912029; 
 Wed, 31 Dec 2025 04:25:12 -0800 (PST)
Received: from [192.168.103.126]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723b2bsm693683025e9.3.2025.12.31.04.25.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Dec 2025 04:25:11 -0800 (PST)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <4138cb5f-590f-4e80-b88c-2c2dd8894c2e@gmx.de>
Date: Wed, 31 Dec 2025 13:25:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] serial: Add Goldfish TTY driver
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: me@ziyao.cc, daniel@0x0f.com, jserv@ccns.ncku.edu.tw,
 eleanor15x@gmail.com, u-boot@lists.denx.de, alison.wang@nxp.com,
 angelo@kernel-space.org, trini@konsulko.com
References: <20251230160112.3045527-1-visitorckw@gmail.com>
 <20251230160112.3045527-2-visitorckw@gmail.com>
Content-Language: en-US
In-Reply-To: <20251230160112.3045527-2-visitorckw@gmail.com>
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

On 12/30/25 17:01, Kuan-Wei Chiu wrote:
> Add support for the Google Goldfish TTY serial device. This virtual
> device is commonly used in QEMU virtual machines (such as the m68k
> virt machine) and Android emulators.
> 
> The driver implements basic console output and input polling using the
> Goldfish MMIO interface.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
> Changes in v3:
> - Remove unnecessary type casts for MMIO register access.
> 
>   MAINTAINERS                      |   6 ++
>   drivers/serial/Kconfig           |   8 +++
>   drivers/serial/Makefile          |   1 +
>   drivers/serial/serial_goldfish.c | 102 +++++++++++++++++++++++++++++++
>   include/goldfish_tty.h           |  18 ++++++
>   5 files changed, 135 insertions(+)
>   create mode 100644 drivers/serial/serial_goldfish.c
>   create mode 100644 include/goldfish_tty.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6ce0bbce13d..da4a6e4d518 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1259,6 +1259,12 @@ S:	Maintained
>   F:	drivers/misc/gsc.c
>   F:	include/gsc.h
>   
> +GOLDFISH SERIAL DRIVER
> +M:	Kuan-Wei Chiu <visitorckw@gmail.com>
> +S:	Maintained
> +F:	drivers/serial/serial_goldfish.c
> +F:	include/goldfish_tty.h
> +
>   I2C
>   M:	Heiko Schocher <hs@nabladev.com>
>   S:	Maintained
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 371d7aa5bba..b84cb9ec781 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1193,4 +1193,12 @@ config SYS_SDMR
>   	depends on MPC8XX_CONS
>   	default 0x0
>   
> +config SERIAL_GOLDFISH
> +	bool "Goldfish TTY support"
> +	depends on DM_SERIAL
> +	help
> +	  Select this to enable support for the Goldfish TTY serial port.
> +	  This virtual device is commonly used by QEMU virtual machines
> +	  (e.g. m68k virt) for console output.
> +
>   endif
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index 8eaae62b0fc..fe8d23be512 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -63,3 +63,4 @@ obj-$(CONFIG_XTENSA_SEMIHOSTING_SERIAL) += serial_xtensa_semihosting.o
>   obj-$(CONFIG_S5P4418_PL011_SERIAL) += serial_s5p4418_pl011.o
>   
>   obj-$(CONFIG_UART4_SERIAL) += serial_adi_uart4.o
> +obj-$(CONFIG_SERIAL_GOLDFISH) += serial_goldfish.o
> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> new file mode 100644
> index 00000000000..1d2977d809d
> --- /dev/null
> +++ b/drivers/serial/serial_goldfish.c
> @@ -0,0 +1,102 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + * Goldfish TTY driver for U-Boot
> + */
> +
> +#include <asm/io.h>
> +#include <dm.h>
> +#include <goldfish_tty.h>
> +#include <linux/types.h>
> +#include <serial.h>
> +
> +/* Goldfish TTY Register Offsets */
> +#define GOLDFISH_TTY_PUT_CHAR       0x00
> +#define GOLDFISH_TTY_BYTES_READY    0x04
> +#define GOLDFISH_TTY_CMD            0x08
> +#define GOLDFISH_TTY_DATA_PTR       0x10
> +#define GOLDFISH_TTY_DATA_LEN       0x14
> +#define GOLDFISH_TTY_DATA_PTR_HIGH  0x18
> +#define GOLDFISH_TTY_VERSION        0x20
> +
> +/* Commands */
> +#define CMD_WRITE_BUFFER   2
> +#define CMD_READ_BUFFER    3
> +
> +struct goldfish_tty_priv {
> +	void __iomem *base;
> +	u8 rx_buf;
> +};
> +
> +static int goldfish_serial_getc(struct udevice *dev)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +	unsigned long paddr;
> +	u32 count;
> +
> +	count = __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> +	if (count == 0)
> +		return -EAGAIN;
> +
> +	paddr = virt_to_phys((void *)&priv->rx_buf);
> +
> +	__raw_writel(0, priv->base + GOLDFISH_TTY_DATA_PTR_HIGH);
> +	__raw_writel(paddr, priv->base + GOLDFISH_TTY_DATA_PTR);
> +	__raw_writel(1, priv->base + GOLDFISH_TTY_DATA_LEN);
> +	__raw_writel(CMD_READ_BUFFER, priv->base + GOLDFISH_TTY_CMD);
> +
> +	return priv->rx_buf;
> +}
> +
> +static int goldfish_serial_putc(struct udevice *dev, const char ch)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +
> +	__raw_writel(ch, priv->base + GOLDFISH_TTY_PUT_CHAR);
> +
> +	return 0;
> +}
> +
> +static int goldfish_serial_pending(struct udevice *dev, bool input)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +
> +	if (input)
> +		return __raw_readl(priv->base + GOLDFISH_TTY_BYTES_READY);
> +
> +	return 0;
> +}
> +
> +static int goldfish_serial_probe(struct udevice *dev)
> +{
> +	struct goldfish_tty_priv *priv = dev_get_priv(dev);
> +	struct goldfish_tty_plat *plat = dev_get_plat(dev);
> +
> +	if (!plat)
> +		return -EINVAL;
> +
> +	priv->base = plat->base;

The Linux binding documentation in 
Documentation/devicetree/bindings/goldfish/tty.txt has this example:

         goldfish_tty@1f004000 {
                 compatible = "google,goldfish-tty";
                 reg = <0x1f004000 0x1000>;
                 interrupts = <0xc>;
         };

The driver should take the reg value as address and use plat->base only 
as fallback for devices that don't provide a proper device-tree.

We already do this for the RTC driver. Please, apply the same logic to 
all Goldfish drivers.

Best regards

Heinrich


> +
> +	return 0;
> +}
> +
> +static const struct dm_serial_ops goldfish_serial_ops = {
> +	.putc = goldfish_serial_putc,
> +	.pending = goldfish_serial_pending,
> +	.getc = goldfish_serial_getc,
> +};
> +
> +static const struct udevice_id goldfish_serial_ids[] = {
> +	{ .compatible = "google,goldfish-tty" },
> +	{ }
> +};
> +
> +U_BOOT_DRIVER(serial_goldfish) = {
> +	.name	= "serial_goldfish",
> +	.id	= UCLASS_SERIAL,
> +	.of_match = goldfish_serial_ids,
> +	.probe	= goldfish_serial_probe,
> +	.ops	= &goldfish_serial_ops,
> +	.priv_auto = sizeof(struct goldfish_tty_priv),
> +	.flags	= DM_FLAG_PRE_RELOC,
> +};
> diff --git a/include/goldfish_tty.h b/include/goldfish_tty.h
> new file mode 100644
> index 00000000000..8777da4942d
> --- /dev/null
> +++ b/include/goldfish_tty.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2025, Kuan-Wei Chiu <visitorckw@gmail.com>
> + */
> +
> +#ifndef _GOLDFISH_TTY_H_
> +#define _GOLDFISH_TTY_H_
> +
> +#include <linux/types.h>
> +
> +/* Platform data for the Goldfish TTY driver
> + * Used to pass hardware base address from Board to Driver
> + */
> +struct goldfish_tty_plat {
> +	void __iomem *base;
> +};
> +
> +#endif /* _GOLDFISH_TTY_H_ */

