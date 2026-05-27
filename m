Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85982CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 12:21:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09B2283FB0;
	Wed, 27 May 2026 14:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="p2dHyih/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C38383FF5; Wed, 27 May 2026 14:21:18 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55EF98341A
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 14:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gQTHZ4cmLz9tZv;
 Wed, 27 May 2026 14:21:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779884474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JbAZQ3cZOB+NQdqObjGlNdMo7pBrCEG8xjpj6GjWsPE=;
 b=p2dHyih/kx9LnuFFLE81Hbv1OBLNlu/0vr5pZ9D+K6IIbUGrzbWQWkLxsOvsoOPi5ZAinQ
 ajynMEwB9VE/xK+Vu/yv2mdFoxri1NjHqjqV9/PrCrX6VNjIFHBxx4hGTPecoBYoB+S6PY
 wLuXLtOKfPTV/ZU6pKHBzTKSQROZtlleoq/D/0boF25TT8szs2Hjs/1mOi4D8ub/Cs5yK9
 PlDNqBh/zn4FjGXh84v7CCqPs8Sua6WH5qRqpiVjuI9KHzmDEZSU5s3UW/2vkxZsz+gXKs
 zBt0U4sEhI3mk3zOyGqFUyo7EoJHuVzX2C3etjKBRdw3P5xYMIk8jk7xv//8Tg==
Message-ID: <43bc93c1-01e1-4442-babf-55b25b0fe3f4@mailbox.org>
Date: Wed, 27 May 2026 14:21:11 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] drivers: watchdog: Fix dev_read_addr error check
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Minda Chen <minda.chen@starfivetech.com>, 
 Hal Feng <hal.feng@starfivetech.com>, Tom Rini <trini@konsulko.com>
References: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <BESP194MB28051DF5B61C4ED0C8C0F297DA0A2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: qw9dazxc9intreu5xzqhw53fjw9a6s45
X-MBO-RS-ID: 8e37482e811aa53e599
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

On 5/25/26 22:33, Francois Berder wrote:
> dev_read_addr does not return a void* but fdt_addr_t.
> Replace invalid usage of dev_read_addr by dev_read_addr_ptr.
> 
> v2:
>   - Replace dev_read_addr by dev_read_addr_ptr
>   - Change error to EINVAL
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   drivers/watchdog/starfive_wdt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/starfive_wdt.c b/drivers/watchdog/starfive_wdt.c
> index ee9ec4cdc3a..d2c16150f4c 100644
> --- a/drivers/watchdog/starfive_wdt.c
> +++ b/drivers/watchdog/starfive_wdt.c
> @@ -290,9 +290,9 @@ static int starfive_wdt_of_to_plat(struct udevice *dev)
>   {
>   	struct starfive_wdt_priv *wdt = dev_get_priv(dev);
>   
> -	wdt->base = (void *)dev_read_addr(dev);
> +	wdt->base = dev_read_addr_ptr(dev);
>   	if (!wdt->base)
> -		return -ENODEV;
> +		return -EINVAL;
>   
>   	wdt->apb_clk = devm_clk_get(dev, "apb");
>   	if (IS_ERR(wdt->apb_clk))

