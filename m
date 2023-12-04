Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF37C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EAC8773B;
	Mon,  4 Dec 2023 11:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701684955;
	bh=oesHpRj8L9ZzEObFuekX+oSugA6wLrWxuMbVAl7F+sA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BBx6cCbDJmM3ITNMbfhiHdWO840qtfDNHajhEcYfdqnEDVOGveVDuYmWCFr0S/YHp
	 ftHsKSH72okSQywiiXulDT2Bo0BoEPmouWAWL1PzqVWBNNLqj9pw+Dh+9FFuaOTKyX
	 ATWcrsOQmn+Xg1U5VqdKv0Lks7lMc8j7NBjFM76yPjurQ8S7a2LF4zvfkpQNjFaUrn
	 rSULH083dXIMYgxIfdyLhGpqho6/BDRi52TxQv5rroKzcJkpv8nuQonsZjpQXwFf7k
	 F7K3nCDTd4A5jgqeSNw6wD5RmfuDks1TBoV9NRn9cz2pDtFQXs0eLqqExFWTqAHHDA
	 1CUhdB0v7SUiA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4DC87717; Mon,  4 Dec 2023 11:15:53 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8F94870D2
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:15:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4SkKLX1DH2z9sTX;
 Mon,  4 Dec 2023 11:15:48 +0100 (CET)
Message-ID: <90fb61a0-ba3a-4cc2-8555-6340e2e9f625@denx.de>
Date: Mon, 4 Dec 2023 11:15:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] watchdog: Correct watchdog timeout print message
Content-Language: en-US
To: Chanho Park <chanho61.park@samsung.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <CGME20231203083110epcas2p334ced52c055603ce66b4452fe4cd5586@epcas2p3.samsung.com>
 <20231203083040.3113114-1-chanho61.park@samsung.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231203083040.3113114-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SkKLX1DH2z9sTX
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

On 12/3/23 09:30, Chanho Park wrote:
> The wdt_start function takes timeout_ms as a parameter and starts the
> watchdog with this value. However, when you output the message, it shows
> the default timeout value for the watchdog device.
> So this patch fixes that part to output the correct timeout value.
> 
> Before -->
> StarFive # wdt start 3000
> WDT:   Started watchdog@13070000 without servicing  (60s timeout)
> 
> After -->
> StarFive # wdt start 3000
> WDT:   Started watchdog@13070000 without servicing  (3s timeout)
> 
> Fixes: c2fd0ca1a822 ("watchdog: Integrate watchdog triggering into the cyclic framework")
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>

Applied to u-boot-watchdog/master

Thanks,
Stefan

> ---
> Change from v1:
> - Use lldiv to fix a build error of m68k arch
> 
>   drivers/watchdog/wdt-uclass.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> index ed329284decb..417e8d7eef95 100644
> --- a/drivers/watchdog/wdt-uclass.c
> +++ b/drivers/watchdog/wdt-uclass.c
> @@ -7,6 +7,7 @@
>   
>   #include <common.h>
>   #include <cyclic.h>
> +#include <div64.h>
>   #include <dm.h>
>   #include <errno.h>
>   #include <hang.h>
> @@ -141,7 +142,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   
>   		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
>   		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
> -		       str, priv->timeout);
> +		       str, (u32)lldiv(timeout_ms, 1000));
>   	}
>   
>   	return ret;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
