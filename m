Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E61CFB442
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:29:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22F0988B11;
	Mon,  7 Oct 2024 06:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ukMXogOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF5D588CA2; Mon,  7 Oct 2024 06:29:09 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95225889AA
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4974T5Jo102467;
 Sun, 6 Oct 2024 23:29:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728275345;
 bh=fusYpRBJZ9mAnIlv5UlHKYY+8iQzsZUxmcC8PhANeVc=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=ukMXogOP7sEvy8Tq+RbbV/JXzlni9RddVECEVJX/5zZOirLykC+zCB6joHPzlcfN6
 vmhCaqP133uOUFjNoqS5F6RuF/sggCMwesEYa7nN5yyDFJV2DQTPgOgmOPwMJ87XQF
 gI8awxx/HryAhpF+RMuTm71uGrszbRkap8OkZp50=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4974T5T2005943;
 Sun, 6 Oct 2024 23:29:05 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 6
 Oct 2024 23:29:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 6 Oct 2024 23:29:04 -0500
Received: from [10.249.141.75] ([10.249.141.75])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4974T0du127963;
 Sun, 6 Oct 2024 23:29:01 -0500
Message-ID: <6e772ca4-076e-4b0a-903a-0be20c1538c7@ti.com>
Date: Mon, 7 Oct 2024 09:59:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mach-k3: common.c: Add dma device remove in spl exit
To: Prasanth Mantena <p-mantena@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <vaishnav.a@ti.com>, <s-k6@ti.com>, <u-kumar1@ti.com>
References: <20241004132057.1449909-1-p-mantena@ti.com>
 <20241004132057.1449909-2-p-mantena@ti.com>
 <3f9a080d-5752-4766-9ae1-2a1049d82cca@ti.com>
 <20241006085613.obqtad5x7e3xut6s@uda0496754>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20241006085613.obqtad5x7e3xut6s@uda0496754>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Prasanth,

On 10/6/2024 2:26 PM, Prasanth Mantena wrote:
> On 20:09-20241004, Kumar, Udit wrote:
> Hi Udit,
>> Hi Prasant,
>>
>> Thanks for series,
>>
>> Could we update the subject of patch something like
>>
>> Remove dma device in spl exit, Sorry but
>>
>> Add dma device remove in spl exit looks little confusing , are we adding or
>> removing ?
> Understood. Should've been more simpler like "Remove dma device in spl
> exit". Will update in next version.
>>
>> On 10/4/2024 6:50 PM, Prasanth Babu Mantena wrote:
>>> [..]
>>> Are you thinking to have DMA device optional ?
> Not really. Sorry, but didn't understand the question completely here.

+	rc = uclass_find_device(UCLASS_DMA, 0, &dev);
+	if (!rc && dev) {


I meant , here if there is some return code or device is not found then
at user level there is no notification.
May be adding some error print in case either some return code or device is NULL
will help to user know, that DMA was not cleaned properly.

>> Second question, if we enabled multiple DMAs in u-boot, then would you like
>> to remove all ?
> Considering this function is specific to k3, here we have channel
> allocation done in probe and there is a need to clean that channel
> resources which has been done in remove function in this series, call
> that remove function here. If there are such allocations done for other
> dma devices as well and have their remove functions implemented, then
> they should consider adding those as well here. I don't think there is
> any such case with other dmas.

Understood this is k3 specific , But here i meant multiple dma devices 
like udma, pdma etc.


>
>>
>>> +	if (!rc && dev) {
>>> +		rc = device_remove(dev, DM_REMOVE_NORMAL);
>>> +		if (rc)
>>> +			pr_warn("Cannot remove dma device '%s' (err=%d)\n",
>>> +				dev->name, rc);
>>> +	}
>>> +}
>>> +
>>>    void spl_board_prepare_for_boot(void)
>>>    {
>>> +#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>>>    	dcache_disable();
>>> +#endif
>> Please suggest , why we are protecting dcache_disable with flags ?
> This is carry forward which was already present. This patch removes
> the protection from whole spl_board_prepare_for_boot() function to
> dcache_disable() only. This alone looks like it has been added in this
> patch, but if we see the whole snippet, it can be understood well.


Thanks

>
> Thanks,
> Prasanth
>>
>>> +#if IS_ENABLED(CONFIG_SPL_DMA) && IS_ENABLED(CONFIG_SPL_DM_DEVICE_REMOVE)
>>> +	k3_dma_remove();
>>> +#endif
>>>    }
>>> +#if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
>>>    void spl_board_prepare_for_linux(void)
>>>    {
>>>    	dcache_disable();
