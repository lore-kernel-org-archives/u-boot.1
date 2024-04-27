Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F4CC4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 23:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2DE88216;
	Sun, 28 Apr 2024 01:20:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1714260044;
	bh=vGglAMLc7lTor4wQe8xgp7FwKCYFgIotSD8z9N8TU5s=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f4+J3D3+cj8fetYZ2MTnDnrebqZt9u4n7jr9QHHMa5QZ4y6Ox8gRWRAY8tAe5E82A
	 ycsAg7h+conmseUo5pshLYVrSIbqPgViDL7PoPK9R/xujhcUrlG72+s5KDcsOp4DKO
	 QBvqkES76XKRdhMso88QAzQ3deKjwUGJals0oQdOp5g8NR1yr/llFQWy1+c/DtE5Rq
	 iYrgHcs6YnClcsMr4Qj4/O6exNdCl4c0CqufsG5PhW4mMQCzCoxqO6AD5mavAZ/KpF
	 +7TbMCWNiqB4sWfzTmHmnzGJcSFy7BfFJaSIXn5coa/cX/CQWyGjDTL8B/6cvj9MGx
	 277zFgUFoscew==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6BD66881F6;
 Sun, 28 Apr 2024 01:20:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1714260042;
 bh=vGglAMLc7lTor4wQe8xgp7FwKCYFgIotSD8z9N8TU5s=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=g1/d0d83Nt7H4PZjhzUlDKYHmpsHw9efxbHgJkNI4QrX0EtQJ0i8uoZwGSApmWi6X
 01MtRslo+Y8Sl6Q4953vGVXE7jbv56o6At763R3z3hMn4hOrCl8wza/M63O6Npmvxq
 Z6Zi3dW/3Ml+MtWp/XBe1wD4vpJZQoM5zloLom/W9hnJHBgrecRUQXJFqj0exDz34n
 dH9QEblKMwcmmWKqJrSHYL77oBYALv8Y8PJsizu6jNmk4xGygPwZTvJakF1VZ0mhQe
 Vb12cFBn6P0vrm+cLXeEvlNGpRQetnoy19uUi03lgL+Bu7HHBsEd7LUAi631mB+yZO
 xdUM1B+bF6AIg==
Message-ID: <495f60d6-6ff2-4c53-8b2c-867b5ca05993@denx.de>
Date: Sun, 28 Apr 2024 01:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mmc: allow use of hardware partition names for mmc
 partconf
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Dragan Simic <dsimic@manjaro.org>
References: <20240427001157.1460302-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240427001157.1460302-1-tharvey@gateworks.com>
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

On 4/27/24 2:11 AM, Tim Harvey wrote:

[...]

> diff --git a/include/mmc.h b/include/mmc.h
> index 4b8327f1f93b..7243bd761202 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -381,6 +381,21 @@ enum mmc_voltage {
>   #define MMC_TIMING_MMC_HS200	9
>   #define MMC_TIMING_MMC_HS400	10
>   
> +/* emmc hardware partition values */
> +enum emmc_hwpart {
> +	EMMC_HWPART_DEFAULT = 0,

One more thing ... eMMC hardware partition 0 and 7 are both referring to 
USER HW partition. Have a look at the git log, there have been patches 
which handled this case in the MMC subsystem from about a year ago.

> +	EMMC_HWPART_BOOT0 = 1,
> +	EMMC_HWPART_BOOT1 = 2,
> +	EMMC_HWPART_GP1 = 3,
> +	EMMC_HWPART_GP2 = 4,
> +	EMMC_HWPART_GP3 = 5,
> +	EMMC_HWPART_GP4 = 6,
> +	EMMC_HWPART_USER = 7,

[...]
