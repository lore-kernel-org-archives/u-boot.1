Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30D4C4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 07:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD14887677;
	Fri,  1 Dec 2023 08:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701416273;
	bh=d1TsOjuJzWOOUm4lpFdMfJ+mhyTqa126u1YcvY4FfUY=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R28jMSLLzy9r5kH5zJAvNUs4VINECW2oyMdapGkNvzeCtnjA2uyeqYu6huMT2Vz8h
	 UjTdwleQmrgH5VzeB1O2AjBsqDyC3bQcxrgLvYsvxnLbrGAg99BRx7ZsZv570W49+U
	 BBhkzmS254ruqlHsQlIe3pFNzwkqGhUPi1SMlea0IKuazo9iqSS3A4aKN2yi2wvV4e
	 3ATuwUbg1VjqY6hwDoq0HeJoU6llmk7mIBbPFySR1DGzUcks4x3ZFNTF8G/0pMru09
	 cTA/IyegIy7RqSh7OOtHziknLoECjg5jwMjwFCqzvRyBX2nsPdF/fHHklWchoP5npt
	 g3Dk6oVn54Opg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A63487686; Fri,  1 Dec 2023 08:37:53 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB6787632
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 08:37:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4ShPzc5xL7z9sm9;
 Fri,  1 Dec 2023 08:37:48 +0100 (CET)
Message-ID: <9f5c0ad9-6e7c-4451-a06c-3d9989358057@denx.de>
Date: Fri, 1 Dec 2023 08:37:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] watchdog: Correct watchdog timeout print message
To: Chanho Park <chanho61.park@samsung.com>, u-boot@lists.denx.de
References: <CGME20231127010544epcas2p195e888cab27c0cbabd2f4b596404f5d8@epcas2p1.samsung.com>
 <20231127010520.3170033-1-chanho61.park@samsung.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231127010520.3170033-1-chanho61.park@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4ShPzc5xL7z9sm9
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

On 11/27/23 02:05, Chanho Park wrote:
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

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/watchdog/wdt-uclass.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/wdt-uclass.c b/drivers/watchdog/wdt-uclass.c
> index ed329284decb..65a4bc1f90ed 100644
> --- a/drivers/watchdog/wdt-uclass.c
> +++ b/drivers/watchdog/wdt-uclass.c
> @@ -141,7 +141,7 @@ int wdt_start(struct udevice *dev, u64 timeout_ms, ulong flags)
>   
>   		printf("WDT:   Started %s with%s servicing %s (%ds timeout)\n",
>   		       dev->name, IS_ENABLED(CONFIG_WATCHDOG) ? "" : "out",
> -		       str, priv->timeout);
> +		       str, (u32)(timeout_ms / 1000));
>   	}
>   
>   	return ret;

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
