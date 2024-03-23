Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0BEC54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 05:06:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C00E687D06;
	Sat, 23 Mar 2024 06:06:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711170402;
	bh=QoVp0tLW/IhJAxWSbYCPRpLAZM52wbmMkIpo2EsGy24=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=OyeLCsy91hTmN7PLn2zSu9PRh7QEPz6e5gw5Cdrr77nHVCaQG9PRtJPybihFgprpO
	 0IAbPA8R8OCOEv8R8Klj8mPElIw3Y/C7cHT7r3VRs8IWg0IiuUA59HjXjnH283oXHa
	 PTXvf1a8nibA+DjOtlWBcTJ51mCXT+mRGqkWPXwnZthLzg+WaKJT61EUQPzD0XUK5U
	 Zsq7OhYhckvMH3yjZtKuVgQZOHGlwF+L0zjdzKreIdEDnOxuViMnq92JPo8iKEADVS
	 VqIIbRV2cHaPSuJ4ET7jHRdPkyEdqpjQAIL7QXqMUIoc6SULL3qoFFnElpX4robXcc
	 WYO3Ri6NzNlEQ==
Received: from [192.168.1.107] (82-131-203-241.pool.digikabel.hu
 [82.131.203.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CCB8687A00;
 Sat, 23 Mar 2024 06:06:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711170401;
 bh=QoVp0tLW/IhJAxWSbYCPRpLAZM52wbmMkIpo2EsGy24=;
 h=Date:Subject:To:Cc:References:From:Reply-To:In-Reply-To:From;
 b=w0v6TfIWDGSHZmuF1sNt9hOpdIOS7jubJO9aGtPArLdJPRdMr54uF08vKqPVZF7Uo
 OESJ4JszZQfUBOPa2REb25b5bj9zzNs/tiWBbLlbX+mTq64GVkIunb7soHWmEBEely
 1ai9X/4XaOcZJ12POvhOAiGcGGSDqlpR0LW4zXCvvPnJHk1RpqE6dIiqOllHviMaEB
 bqXv72awRsP/h+mgp2sOqBumMuzmkRNSmGYl02fR4H6PvR9k+eZmIbSG9RA2DLxcbY
 jVl68Q9Le7HbZxIbuV7tXI1o6REGE2+se6k361BYt/RW91acyHugEL7tz+Kq996V9C
 pmfTqidxIOUCQ==
Message-ID: <ace8d000-b6b2-e46a-7670-c77f40f6989f@denx.de>
Date: Sat, 23 Mar 2024 06:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v1 6/6] spinand: bind UBI block
Content-Language: en-US
To: Alexey Romanov <avromanov@salutedevices.com>,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 frieder.schrempf@kontron.de, kmpark@infradead.org, joe.hershberger@ni.com,
 dunaev@tecon.ru, sjg@chromium.org, bmeng@tinylab.org, xypron.glpk@gmx.de,
 tobias@waldekranz.com, jpewhacker@gmail.com,
 marek.vasut+renesas@mailbox.org, kever.yang@rock-chips.com,
 jbx6244@gmail.com, abdellatif.elkhlifi@arm.com,
 mikhail.kshevetskiy@iopsys.eu, jagan@amarulasolutions.com
Cc: kernel@salutedevices.com, u-boot@lists.denx.de
References: <20240306134906.1179285-1-avromanov@salutedevices.com>
 <20240306134906.1179285-7-avromanov@salutedevices.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240306134906.1179285-7-avromanov@salutedevices.com>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Alexey,

On 06.03.24 14:49, Alexey Romanov wrote:
> UBI block is virtual block device, which is an abstraction
> over MTD layer. Therefore it is logical to use it in combination
> with MTD drivers.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> ---
>   drivers/mtd/nand/spi/core.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index f2ec32e1d0..32705e1e2a 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -27,6 +27,7 @@
>   #include <watchdog.h>
>   #include <spi.h>
>   #include <spi-mem.h>
> +#include <ubi_uboot.h>
>   #include <dm/device_compat.h>
>   #include <dm/devres.h>
>   #include <dm/uclass.h>
> @@ -1182,7 +1183,13 @@ static void spinand_cleanup(struct spinand_device *spinand)
>   static int spinand_bind(struct udevice *dev)
>   {
>   	struct spinand_plat *plat = dev_get_plat(dev);
> -	return mtd_bind(dev, &plat->mtd);
> +	int ret;
> +
> +	ret = mtd_bind(dev, &plat->mtd);
> +	if (ret)
> +		return ret;
> +
> +	return ubi_bind(dev);

What is with boards which do not use ubi block or CONFIG_BLK at all?

bye,
Heiko
-- 
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
