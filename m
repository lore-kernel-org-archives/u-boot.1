Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B68C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 04:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9E1A887D2;
	Wed, 14 Aug 2024 06:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723610052;
	bh=q8Wt0BtGeYtE58obmVDSfX4PdLmtP64jxY6KbYRYc7A=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=0DSsiWAJaegLho1jZTYnN76onZnAv3jsLmufkebyvIfLKykMyDOeLpjXhvVtYNz1p
	 6of5L4Ye7apF35Y5eFDmpNM7GwN39W1THByOzREsq9obIt+NMibA6FBjSHnF7Bz5A4
	 gByQzkqQk5nqjWc2eMD+FPYJ4d926ECedbSrJ7LZ3p4gLxtXGXYNDVCA33D97Q1b7j
	 ACWbLta8DlCcJHqWxfKbK8hHUGU5sDAcgc25FHu/odgQa1lA9/oqp7seHECG535l9c
	 lR/X2hMOkib26/MHfHeeULOoaHp+w8xZMZhQ5wiyf/cErRBKJevqyIy8ErYhkrCigJ
	 6g0atCAZTbCgQ==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 95E0487D2F;
 Wed, 14 Aug 2024 06:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723610051;
 bh=q8Wt0BtGeYtE58obmVDSfX4PdLmtP64jxY6KbYRYc7A=;
 h=Date:Subject:To:References:Reply-To:From:In-Reply-To:From;
 b=ankyX6VhZ/CtNcuVq5J9ytsw4nBoIfh0mz6p0yvAAl6cErJHPlTNqhLNGo6sayH1N
 b6uyM1vw1GcNPkv+6e46pmqv4eC+s4eci8VVjRIEuGFFRnBH81/WEU+R/t9LKPu0XR
 udYte9C9Rob4R8PDPaQznH862YIelhvyfq//+RxBKKk6XU37KgHRN7xds8dTGsQkaK
 aS6pIyVoXHiFUedCvdmyXGZ3jQxG6R++waalyJvOIFZeF3vV/Kr7xiRJadwlBR/5F5
 yohKQbcOZvQ0cyS4yG7ATCl7Fl7HsKT13sxu7Y0lkE3Gi1WzgDG4cc3tt0v9KpXD6U
 lsXcKZYzGzfZA==
Message-ID: <32d0b8ed-3986-3011-a0a8-e4640ee10ff1@denx.de>
Date: Wed, 14 Aug 2024 06:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v3 8/9] ubi: implement support for LED activity
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Arseniy Krasnov <avkrasnov@salutedevices.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Alexey Romanov <avromanov@salutedevices.com>, Dmitry Dunaev
 <dunaev@tecon.ru>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <sean.anderson@seco.com>, Artur Rojek <artur@conclusive.pl>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Vasileios Amoiridis <vassilisamir@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Doug Zobel <douglas.zobel@climate.com>, u-boot@lists.denx.de
References: <20240812103254.26972-1-ansuelsmth@gmail.com>
 <20240812103254.26972-9-ansuelsmth@gmail.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240812103254.26972-9-ansuelsmth@gmail.com>
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

Hello Christian,

On 12.08.24 12:32, Christian Marangi wrote:
> Implement support for LED activity. If the feature is enabled,
> make the defined ACTIVITY LED to signal ubi write operation.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>   cmd/ubi.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/ubi.c b/cmd/ubi.c
> index 0e62e449327..6f679eae9c3 100644
> --- a/cmd/ubi.c
> +++ b/cmd/ubi.c
> @@ -14,6 +14,7 @@
>   #include <command.h>
>   #include <env.h>
>   #include <exports.h>
> +#include <led.h>
>   #include <malloc.h>
>   #include <memalign.h>
>   #include <mtd.h>
> @@ -488,10 +489,22 @@ exit:
>   
>   int ubi_volume_write(char *volume, void *buf, loff_t offset, size_t size)
>   {
> +	int ret;
> +
> +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> +	led_activity_blink();
> +#endif

Do we really need ifdef? May it is possible to declare an empty function
when CONFIG_LED_ACTIVITY_ENABLE is not set? May this applies for the whole
series?

> +
>   	if (!offset)
> -		return ubi_volume_begin_write(volume, buf, size, size);
> +		ret = ubi_volume_begin_write(volume, buf, size, size);
> +	else
> +		ret = ubi_volume_offset_write(volume, buf, offset, size);
>   
> -	return ubi_volume_offset_write(volume, buf, offset, size);
> +#ifdef CONFIG_LED_ACTIVITY_ENABLE
> +	led_activity_off();
> +#endif
> +
> +	return ret;
>   }
>   
>   int ubi_volume_read(char *volume, char *buf, loff_t offset, size_t size)
> 

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
