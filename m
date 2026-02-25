Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C02EFD20B
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 08:39:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4279E83AA9;
	Wed, 25 Feb 2026 09:39:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="DDAODo6Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C7F483E13; Wed, 25 Feb 2026 09:39:19 +0100 (CET)
Received: from mx-relay109-hz1.antispameurope.com
 (mx-relay109-hz1.antispameurope.com [94.100.132.99])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0359582A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 09:39:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=0509038307=max.merchel@ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate109-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out03-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=uuQqoaH5oaQilXzY61hf3QJwDUMTNAc66gMoMzTQ1AU=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1772008755;
 b=pIDgspzMmMWgBg5F8vP/BwbKnSDHb8aA7LFWPdA7UY/E9CO0DNpi+GbY0Y7k/VVsrea8VyR9
 N0iUmn2nzrnbJGD8cnWF6HnSpMmXl+JEZbtpoDJO7QYY9ORV2WNL0SOhBAMEMYGZ8fud0VVIK3w
 JlJkN17HciQ2Nijiju31IApO/AgXGo/OLhaZ9Xqpf936xbqDUtzhHja/UGITb1NS+qvInnIGEkD
 J3Wy6sYwPnE1tNC0+DI4/20yBaIrgoThYqtwt1rh32o0FCtMn2XdQNXLipnCaVb1uku9NOWBfaN
 w4Re1JI1b4JsiXtfAWmV+CXYbR87/x1fDrApqWfw3iQ7A==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1772008755;
 b=cLL4zbWPYKVXQLhAwo5T+7Vl2LVyZIAiqgtDCOF9pOSrPferk7hkfzUHo6jJZ9xB5hXI6Zo5
 ApwbFhXWiqkXljMxX50VHofC1q1kvwSlh8Lb6MVCUtAH59ExlwO1DThxgc4l35aCiPRpKXSn3nI
 9FV8ZCvszkCkO3uSWrNRJ5Um+SxR+4nbxXkmqZxAo70ad51RcdazZlEEdCXryNnpYjHh6mj+0Np
 zChhL7rGz6/sX+UUfGXABqs3OCh/17bKbZrosMzR6CLXbv/VTAUg/alU2MAH8DvB9+EmgWGAvGB
 5++cAtx+LfAG4V96Vov92QEejsRvcRpqyyiR4zMtslqGQ==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by
 mx-relay109-hz1.antispameurope.com; Wed, 25 Feb 2026 09:39:14 +0100
Received: from [10.123.75.134] (host-82-135-125-110.customer.m-online.net
 [82.135.125.110]) (Authenticated sender: max.merchel@ew.tq-group.com)
 by hmail-p-smtp01-out03-hz1.hornetsecurity.com (Postfix) with ESMTPSA id
 41F67CC0D2A; Wed, 25 Feb 2026 09:38:56 +0100 (CET)
Message-ID: <80f12fd7-b63a-4419-ba41-519e117c1f69@ew.tq-group.com>
Date: Wed, 25 Feb 2026 09:38:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] x86: Call bootm_final()
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Guillaume Ranquet <ranquet.guillaume@gmail.com>
References: <20260224142553.1608883-1-simon.glass@canonical.com>
 <20260224142553.1608883-7-simon.glass@canonical.com>
Content-Language: en-US
From: Max Merchel <max.merchel@ew.tq-group.com>
In-Reply-To: <20260224142553.1608883-7-simon.glass@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-cloud-security-sender: max.merchel@ew.tq-group.com
X-cloud-security-recipient: u-boot@lists.denx.de
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: max.merchel@ew.tq-group.com
X-cloud-security-Mailarchivtype: outbound
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on
 mx-relay109-hz1.antispameurope.com with 4fLSg44J5rz2Cw5b
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1,
 IP=94.100.132.6
X-cloud-security-Digest: 5f1af0beeeaf0949fd745f34010b366b
X-cloud-security: scantime:2.626
DKIM-Signature: a=rsa-sha256;
 bh=uuQqoaH5oaQilXzY61hf3QJwDUMTNAc66gMoMzTQ1AU=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1772008754; v=1;
 b=DDAODo6Y8bL18OLvcAWPAHZx3s3UPmosah60nZ05d89HF4EbRqJktqHBGDFJLEMD/NzLzbhb
 560fR8Ogna55T0BNhFdoPy9O2saJN0J2wMiIEylqMYicPhFnfQParAku6VBRgA4C/C6lXc8J0D/
 8xCIcrxrosA/7ZPTEMuXSz04hNG9k2XPPRUTEsKT9O+yh39YEtSLBoUc0ea7eJImp8Rfldi4p1h
 ppavPdGPa2pR2bgc585z0fwfPFf89zYf12fAkjoH29q5OqPi+4tYP6vJL8iyqDAU9TXJA2lvBHa
 diBSEFS3IdAjHy3cAmsYmNcUSAqIguHhayPLvYMvtp92Q==
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



Am 24.02.26 um 15:25 schrieb Simon Glass:
> The x86 code in bootm_announce_and_cleanup() is very similar to the new
> bootm_final() function, so just use the latter. Move over a useful
> comment.
> 
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
> 
> (no changes since v1)
> 
>   arch/x86/lib/bootm.c | 14 +-------------
>   boot/bootm_final.c   |  5 +++++
>   2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
> index 7a94dc877e3..cde4fbf3557 100644
> --- a/arch/x86/lib/bootm.c
> +++ b/arch/x86/lib/bootm.c
> @@ -34,22 +34,10 @@ DECLARE_GLOBAL_DATA_PTR;
>   
>   void bootm_announce_and_cleanup(void)
>   {
> -	printf("\nStarting kernel ...\n\n");
> -
>   #ifdef CONFIG_SYS_COREBOOT
>   	timestamp_add_now(TS_START_KERNEL);
>   #endif
> -	bootstage_mark_name(BOOTSTAGE_ID_BOOTM_HANDOFF, "start_kernel");
> -#if IS_ENABLED(CONFIG_BOOTSTAGE_REPORT)
> -	bootstage_report();
> -#endif
> -
> -	/*
> -	 * Call remove function of all devices with a removal flag set.
> -	 * This may be useful for last-stage operations, like cancelling
> -	 * of DMA operation or releasing device internal buffers.
> -	 */
> -	dm_remove_devices_active();
> +	bootm_final(0);
>   }
>   
>   #if defined(CONFIG_OF_LIBFDT) && !defined(CONFIG_OF_NO_KERNEL)
> diff --git a/boot/bootm_final.c b/boot/bootm_final.c
> index dd7cac55f1e..7077702d8c7 100644
> --- a/boot/bootm_final.c
> +++ b/boot/bootm_final.c
> @@ -18,5 +18,10 @@ void bootm_final(enum bootm_final_t flags)
>   	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
>   		bootstage_report();
>   
> +	/*
> +	 * Call remove function of all devices with a removal flag set.
> +	 * This may be useful for last-stage operations, like cancelling
> +	 * of DMA operation or releasing device internal buffers.
> +	 */
>   	dm_remove_devices_active();
>   }

I think it would be better if the comment were inserted together with 
the function. In Patch [PATCH v2 2/9] bootm: Remove active devices in 
bootm_final()


-- 
Best regards,
Max

TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
http://www.tq-group.com/

