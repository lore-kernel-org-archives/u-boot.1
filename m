Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9167ECD3447
	for <u-boot@archiver.kernel.org>; Sat,  9 May 2026 02:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F3DD84E0F;
	Sat,  9 May 2026 04:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="V5hN4DO9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89A6184E28; Sat,  9 May 2026 04:25:02 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C1084CD2
 for <u-boot@lists.denx.de>; Sat,  9 May 2026 04:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gC8vs5lG0z9tx3;
 Sat,  9 May 2026 04:24:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1778293498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kG9h7xj8ft9p8IetjuIf0U+sbvx394n2Wz09dXQ72lI=;
 b=V5hN4DO9S97J9iXtBRONxvPN9ldR23ixA5AzHYx+cUc8vWYeGKIRdVaAJ0u7d9VipK4kT7
 /kelQ5lpHrIBf1TeiKsRXkljmOpdJeFZIfDujsuQT0J8xartWfKiRpqR5vsh1XhWbzGgfj
 SlTMnrvlf61L7jhFMe1EN/kTv6wb6ouBekHskCJYvfuDjW/BozCKor9xTIPze75ZAnpjMI
 jQDbCm1k4nSYffarMXEcFm2wPDi2LFN9TsMzUx35AW+zR4W/HGtn/03NUso+YUrcQpLUR4
 /CbsBmcxfG2+GEvXH3tOe0L5WiCkO/4CISGPxKVPsqk0zZEjPtiZtno5UMrktA==
Message-ID: <4047820f-cf83-4db2-ad27-ddc10b37c37f@mailbox.org>
Date: Fri, 8 May 2026 23:23:09 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] usb: gadget: f_acm: Fix memory leak in acm_add
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
References: <BESP194MB28057EE4305A2535D0607448DA3D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <BESP194MB28057EE4305A2535D0607448DA3D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: owjjowwry9rr4wjp98i1e1axkxfhwkid
X-MBO-RS-ID: 1101224642141e2db9d
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

On 5/8/26 9:46 PM, Francois Berder wrote:
> If udc_device_get_by_index fails, the f_acm struct was not released.
> Free it before returning the error.
> 
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> ---
>   drivers/usb/gadget/f_acm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/f_acm.c b/drivers/usb/gadget/f_acm.c
> index 8f7256069f5..0d8a3183330 100644
> --- a/drivers/usb/gadget/f_acm.c
> +++ b/drivers/usb/gadget/f_acm.c
> @@ -547,8 +547,10 @@ static int acm_add(struct usb_configuration *c)
>   	f_acm->usb_function.setup = acm_setup;
>   
>   	status = udc_device_get_by_index(0, &f_acm->udc);
> -	if (status)
> +	if (status) {
> +		free(f_acm);
>   		return status;

Please add a fail path:

goto err;

> +	}
>   
>   	status = usb_add_function(c, &f_acm->usb_function);
>   	if (status) {

goto err;

...

err:
   free(...);
   return status;
}
