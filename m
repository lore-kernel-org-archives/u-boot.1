Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E6FC25B78
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 21:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E0FC882CE;
	Wed, 15 May 2024 23:15:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715807753;
	bh=rsvxQJoAW0zI6dIxJ0kTB7qnBZ18MS/kaAOQxablp7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=czACtnHjyH2gCEyrRh7abICxz+JxHBGo6NhYnYjTn5A1H5BxRQzPhEv8SYJFCbbLN
	 hU1zMSXFVXtJQYA9M9yFanhhbZ07/F0Tm5hiKNcmHIfrC8o96rlgKVr8Lqf1e6se5J
	 ERDTk6Oz/VE70dAcztNYgJpe4j04COobIRK1aFdlK75iJt8m06YjPL83cR8zii5nVz
	 Lb2JXQE7cMj714k71ZfnXgtdSiPrTyQCtX+LHCnLorYCWNMEtu8UTi+3y7C1YPj0fM
	 dKRUUmFGYOpE3mLcJE5TUQmz2dCFR0KP+7N8qxykDTznu8omlj8eXfWfgL8sSKAn3D
	 1lItlF6e3psBQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0F0E286EB5;
 Wed, 15 May 2024 23:15:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715807751;
 bh=rsvxQJoAW0zI6dIxJ0kTB7qnBZ18MS/kaAOQxablp7s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Uuy8Xlb15XnVH4s/vqfbuFZHS9WEcii2w7Y3wdzXPTq2eYWcKZrTHoRP/twzQJzsM
 BOYc1BYyIou9E9EanMxlj4E30MasIdEMTRG1pHfuzJSuYiqepS9umwOIDOD2ce+CY3
 NHHI0cuhRew1DNC8sZMbs7Mvy7BkcpPrqKF8BoqLeRpAjBnqISxLgfMn8hduZsa//c
 UQFLt3VWzAMi1bmleG92q6w+co8YkCXAoWniGNShIM8lJMdNCtHRlHw9kLzub7LnhO
 RDOjl/WX5Q+DwanZpLR7Nf3JHOGqudCVeOomNxnpL65hLif4t2sLrSPtdzV4sYvmYy
 yT4C8K7jMEeWA==
Message-ID: <368ef3ec-aa73-4fe9-bd22-94cb1e4b392a@denx.de>
Date: Wed, 15 May 2024 23:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20240515205049.3005256-1-tharvey@gateworks.com>
 <f4e559f7-8b41-47e2-9b00-eb44b90dc97a@denx.de>
 <CAJ+vNU2Zfjd0du0xML8cQz-=2knndj5g_5_ba9KrL+jK20Kygw@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAJ+vNU2Zfjd0du0xML8cQz-=2knndj5g_5_ba9KrL+jK20Kygw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 5/15/24 11:11 PM, Tim Harvey wrote:
> On Wed, May 15, 2024 at 2:06 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 5/15/24 10:50 PM, Tim Harvey wrote:
>>
>> [...]
>>
>>> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
>>> index 874ca4d6f5af..3455d60d69dc 100644
>>> --- a/boot/fdt_support.c
>>> +++ b/boot/fdt_support.c
>>> @@ -8,6 +8,7 @@
>>>
>>>    #include <abuf.h>
>>>    #include <env.h>
>>> +#include <kaslrseed.h>
>>>    #include <log.h>
>>>    #include <mapmem.h>
>>>    #include <net.h>
>>> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
>>>        if (nodeoffset < 0)
>>>                return nodeoffset;
>>>
>>> +     if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
>>> +             err = fdt_kaslrseed(fdt);
>>> +             if (err) {
>>> +                     printf("WARNING: could not set kaslr-seed %s.\n",
>>> +                            fdt_strerror(err));
>>> +                     return err;
>>
>> Is this warning really a critical boot-breaking error ?
> 
> no, and in fact I'm printing a warning inside of fdt_kaslrseed so I
> can remove the duplication of error prints in the various other places
> it's called as well.
> 
> Thanks for pointing that out!

Glad I could help.
