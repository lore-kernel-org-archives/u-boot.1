Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B15C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 11:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BABE7884B2;
	Mon, 10 Jun 2024 13:24:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="IPAdbSlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FBBF884C5; Mon, 10 Jun 2024 13:24:05 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C371884A7
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718018641; x=1718623441; i=xypron.glpk@gmx.de;
 bh=m+yZT0TNL1/I8lzQfyfmIRxzgblcJREh3+ijhIP2MAA=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IPAdbSlRTUsLX+AzR5Um5F8LYduZhQTaKVJH4tiK3Pdxhckbfy9AQ7H3YYrFxmSQ
 wr/Dclj9Y+YPzMnsPODUWQetYSW7rgBRRJFG2lyFIHRiHMbhGBVBJwqUU4Sxb4C2a
 2ccc0ROGM1TEB89POXVo/NX2iWIOwfcxuA1wufbwvqc79k10prN3X/bgi1qknNbmK
 RuXmhEtkWUEgvJUyjxspTVxWDnONWKbFA/HSH1t7zYY3pE2fYiNE7u88pRtqaOU2G
 KV9BKiedUQIOxLj1jJS3zCSQJdScclh7MG+ZWOS6BLyhD/GD/0CiANRb5C0GMZtgH
 g5iCznQlebz8KRJ1YA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.107] ([109.42.176.212]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfUe-1sA0MZ2B0C-009sEX; Mon, 10
 Jun 2024 13:24:00 +0200
Message-ID: <990cff94-f908-4058-9e19-dea8e0a05429@gmx.de>
Date: Mon, 10 Jun 2024 13:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/31] lmb: make the lmb reservations persistent
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-4-sughosh.ganu@linaro.org> <ZmdtVFiA835wvFV3@hades>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <ZmdtVFiA835wvFV3@hades>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2ipEa6qH9DSdsnC75xfL4ZLHRtlORBZb1ffhCm3BUDLRauasoLC
 RKEMI2gJRzLJLND/5sP/9wLf6Uj3IRGp3P+EZFnqhNzF5w+cl2JMeL+T243PLsGBaEnXL6i
 rn3nqnVYxeX65J9D7oHs9btlMFCVOphwPRXkq6SzMYl25D1u7l5jNfnGr76avmfWE95fEap
 ddCYNj1fsJWGzKg5WYo2g==
UI-OutboundReport: notjunk:1;M01:P0:BCy8PwB4uRs=;bUIMkxiYRV7HoQBnvL5jdoWDNCb
 vrLtSd5map4LgZ6F5VY19lGheXibPDGbYUHTcVtZ3pwO6SB+vENKEuop79lqECZeEj2npEHmN
 8D+/kWm3HkLQnPbIx9A86seOgDLJKhD0aNzfYsdLoBJVJii2/A+vraaQEo2Wh1V5qz1Ghpl2x
 Eubp8rHh+c7pz3W8udjb9Q/4FfR7P8U0pEPy5EF9W3/pGuWfyoMKwzYMOYjipCKuTZfF0ECtA
 eYGU/ldhTYHl3taKPzGSpqTcfjJFU2AqSvdnQYnIyIKhx12howWFsEri+XjV2UesB46kbPla1
 4GVXtkiG55WF8Tu6BLE1j4bgIdg88E6LMralTlwK9BtMDdeI+eV2WLX52gaUIU8XZKwTMwCUO
 vGXyWWq3Bu0a9dmp4zTbwuYifwH93xw9n24kLOIrYxL4CW+BxQv77EoU0Uy8R+VwqNBK8alIC
 6kxZemDcTTJQCVGmgbgAMG9auBtbObtBvNgjRz/e0jv1k7BrRAjL0xs212hUq9F2RnTq0wYm2
 5FETWqtksbW6XfJRT+zPV5T250l3KLTBUL9nFRC6P8qEaNOZxv2XN9r3KW3Qf7S7hLt/BLrhN
 aG4wD9kS9XwKLWFkLjZ8ur06SCX86jz8zvEgYdmnqnVhURGXRgvMyGb9v0bfVxs+jiUnFh2du
 O4nU5WnGNDJ+bRL1GEouuouah+c+dtVmZ/X5abRWfVMK7eIhyyFvfNcqL6QhAMgCVcRsuWNIv
 1h0Rt4kPUYis7Z9TBC2KiwEg8jeTx9Mm1XuU6YdzvneYt7qiXQO4Sqz9p8HybwVTAgklT91Sa
 FbVzX3u4/5efci/UXN4yFC3a7P6zE5Lm2nUcjxGAhJNxo=
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

On 1/1/70 01:00, Ilias Apalodimas wrote:
> Hi Sughosh
>
> [...]
>
>>   #define LMB_ALLOC_ANYWHERE	0
>>
>> +#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
>> +struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
>> +struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
>> +#endif
>> +
>> +struct lmb lmb =3D {
>> +#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
>> +	.memory.max =3D CONFIG_LMB_MAX_REGIONS,
>> +	.reserved.max =3D CONFIG_LMB_MAX_REGIONS,
>> +#else
>> +	.memory.max =3D CONFIG_LMB_MEMORY_REGIONS,
>> +	.reserved.max =3D CONFIG_LMB_RESERVED_REGIONS,
>> +	.memory.region =3D memory_regions,
>> +	.reserved.region =3D reserved_regions,
>
> This is probably a good opportunity to look into why
> CONFIG_LMB_MEMORY_REGIONS was introduced.  Since we are moving towards
> static allocations, do we still need it? Or allocating the size dynamica=
lly
> covers all our cases.

Up to now we used static arrays for saving memory allocations in LMB:

include/lmb.h:67:
struct lmb_property region[CONFIG_LMB_MAX_REGIONS];

As the EFI sub-system can produce any number of non-coalescable memory
regions we should use a linked list instead.

The fields memory.max and reserved.max seem to be unused except for
test/lib/lmb.c.

lib/lmb.c:136:  lmb->memory.max =3D CONFIG_LMB_MAX_REGIONS;
lib/lmb.c:139:  lmb->memory.max =3D CONFIG_LMB_MEMORY_REGIONS;
test/lib/lmb.c:689:     ut_asserteq(lmb.memory.max, CONFIG_LMB_MAX_REGIONS=
);

lib/lmb.c:137:  lmb->reserved.max =3D CONFIG_LMB_MAX_REGIONS;
lib/lmb.c:140:  lmb->reserved.max =3D CONFIG_LMB_RESERVED_REGIONS;
test/lib/lmb.c:691:     ut_asserteq(lmb.reserved.max,
CONFIG_LMB_MAX_REGIONS);

Best regards

Heinrich

>
>
>> +#endif
>> +	.memory.cnt =3D 0,
>> +	.reserved.cnt =3D 0,
>> +};
>> +
>>   static void lmb_dump_region(struct lmb_region *rgn, char *name)
>>   {
>>   	unsigned long long base, size, end;
>> @@ -42,8 +61,8 @@ static void lmb_dump_region(struct lmb_region *rgn, c=
har *name)
>>   void lmb_dump_all_force(struct lmb *lmb)
>>   {
>>   	printf("lmb_dump_all:\n");
>> -	lmb_dump_region(&lmb->memory, "memory");
>> -	lmb_dump_region(&lmb->reserved, "reserved");
>> +	lmb_dump_region(&lmb.memory, "memory");
>> +	lmb_dump_region(&lmb.reserved, "reserved");
>>   }
>>
>
> [...]
>
>
> Thanks
> /Ilias
>

