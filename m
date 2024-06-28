Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02851C2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 02:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E51C88093;
	Fri, 28 Jun 2024 04:48:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1719542923;
	bh=d/evnGfoO9s8v8iyVpVal9CdYNlML59pAW6UNLVtsd8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iQWk9ew562+BVo7jhQ6CKZEJnuHfj27wS4RyVy6uNQ3Rc9SurYfP0eD9Zox8oDLKg
	 pLSkbpsIjcotpwiuQ/SthSxLWq8FZUkC+gnCeV/KURkzQ7g77uLBr8FVF9JjTmDpvB
	 XVTi7VtN24WecEVQREWvw68Ee/zHyUjYNkvC1kdCzW1prDtYZaQnNPhseexSpzrLK4
	 rFpj/Hd0dj0w0UPDfFJt4YjUX/L5wR4aMhJoQsHOS4Vi8cfzsEUbETMCO6avrlB2fq
	 qIln8aWhhkdj0+27c45gpncbq3+TVQmRIVZIvAwAOKn6yhL07afZNvwrg9EZtq/zF8
	 Anbuw7NW2BUUA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 200648857D;
 Fri, 28 Jun 2024 04:48:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1719542922;
 bh=d/evnGfoO9s8v8iyVpVal9CdYNlML59pAW6UNLVtsd8=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
 b=XW07iDefTxR6BNA1X7xtcNaRGA2sPEWD9X6oYowZ5bHi6XCJeO+dNi8mHlKifTfm+
 F8m2KB1b+YWzlSDdnGHlHz699Efbi98PlKxhSGCJ6HHqfC1pt00YpgLeU7/pkRyAgJ
 CkBKeVjt+3oU2ZLYfs89G3EL6idDrNBDZ5pYpVGgqjEOmnCp/ImWSApQG/wBj/s5rc
 HY7Fdj33iRaxmhFLFDZNl1FrsVITQHTiMWfewTcsPjB//MMpFsiktef0AnhxZnQclM
 JcRxBnFm8A66aDGWzoc2JX7QQfJL3z1bZeXbn49ELDE8FGn3UFQYY/fjAiyA3b2kKM
 YDGQ1fxLiAa4g==
Message-ID: <175f4508-4d9a-4de4-81a2-d3c03074030f@denx.de>
Date: Fri, 28 Jun 2024 04:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] spl: fit: List DTOs applied by SPL in U-Boot control DT
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Sean Anderson <seanga2@gmail.com>, Suniel Mahesh
 <sunil@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
References: <20240626235857.272264-1-marex@denx.de>
 <CAFLszTjskBvo9j=34sMHQgSy6LVwBGhYSAqt4s06H_-AFvdZ_A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAFLszTjskBvo9j=34sMHQgSy6LVwBGhYSAqt4s06H_-AFvdZ_A@mail.gmail.com>
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

On 6/27/24 10:37 AM, Simon Glass wrote:

Hi,

>>
>>                          /* Make room in FDT for changes from the overlay */
>>                          ret = fdt_increase_size(spl_image->fdt_addr,
>> -                                               image_info.size);
>> +                                               image_info.size + strlen(str));
> 
> You may also need space for the string terminator (i.e. add 1 more byte).

Fixed in V2 with expanded comment, thanks.

>>                          if (ret < 0)
>>                                  break;
>>
>> @@ -464,6 +465,26 @@ static int spl_fit_append_fdt(struct spl_image_info *spl_image,
>>
>>                          debug("%s: DT overlay %s applied\n", __func__,
>>                                fit_get_name(ctx->fit, node, NULL));
>> +
>> +                       /*
>> +                        * Insert /u-boot,<dto-name> = <index> property into
>> +                        * the U-Boot control DT. This can be used by user
>> +                        * to inspect which DTOs got applied by the SPL from
>> +                        * a running U-Boot.
>> +                        */
>> +                       snprintf(dtoname, sizeof(dtoname), "u-boot,%s", str);
>> +                       ret = fdt_setprop_u32(spl_image->fdt_addr, 0, dtoname,
>> +                                             index);
>> +                       if (!ret) {
> 
> This means there was no error, right?

Yes, this should be inverted, thanks.

>> +                               /*
>> +                                * The DTO itself was applied, do not treat the
>> +                                * insertion of /u-boot,<dto-name> as an error
>> +                                * so the system can possibly boot somehow.
>> +                                */
>> +                               debug("%s: DT overlay %s name not inserted into / node (%d)\n",
>> +                                     __func__,
>> +                                     fit_get_name(ctx->fit, node, NULL), ret);
>> +                       }
> 
> log_debug()

The whole file uses debug(), so let's keep it consistent.

Thanks !
