Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299D4C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 16:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D809F870BE;
	Thu,  9 Nov 2023 17:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SgtT/4N4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A78E87232; Thu,  9 Nov 2023 17:17:48 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D10286552
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 17:17:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A9GHe3G120793;
 Thu, 9 Nov 2023 10:17:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699546660;
 bh=XfkxQ0b+iJrGqxCDUFIW8sVbT7VTmjpMCdKXAxYlFqo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=SgtT/4N4zrw0iWOHifKGqTK5Ra7Fxq2uZfxtPu9xaxtntYXthJta4oAtgo8upnGyd
 zBL8Jdvwc9qEn9OzKKDQlfbUULvGh8onTa2YZAYKCQD5GhHFA6MbLqEfcR2INm5GCK
 M4dOiv0w4GY+gNzQ0Sf0mhKU71a3uLxXZ2OHw6QI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A9GHeV7070169
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 Nov 2023 10:17:40 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 Nov 2023 10:17:39 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 Nov 2023 10:17:39 -0600
Received: from [10.250.33.216] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A9GHdXW026182;
 Thu, 9 Nov 2023 10:17:39 -0600
Message-ID: <6f24d3f5-8624-4dc2-bea3-fa893c8b10da@ti.com>
Date: Thu, 9 Nov 2023 10:17:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] board: ti: j721e: During resume spl restores TF-A
 and DM-Firmware
Content-Language: en-US
To: Thomas Richard <thomas.richard@bootlin.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <thomas.petazzoni@bootlin.com>, <gregory.clement@bootlin.com>,
 <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-8-thomas.richard@bootlin.com>
 <a8ec9dbe-f3a9-4a4e-88b5-a297d576c075@ti.com>
 <b2a9a9db-9f96-491c-882e-de4efa4ff472@bootlin.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <b2a9a9db-9f96-491c-882e-de4efa4ff472@bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 11/9/23 5:29 AM, Thomas Richard wrote:
> On 11/8/23 18:30, Andrew Davis wrote:
>>>    void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>>>    {
>>>        typedef void __noreturn (*image_entry_noargs_t)(void);
>>> @@ -235,6 +241,32 @@ void __noreturn jump_to_image_no_args(struct
>>> spl_image_info *spl_image)
>>>        if (ret)
>>>            panic("rproc failed to be initialized (%d)\n", ret);
>>>    +    if (board_is_resuming()) {
>>> +#if IS_ENABLED(CONFIG_SOC_K3_J721E)
>>> +        if (!valid_elf_image(LPM_DM_SAVE))
>>> +            panic("%s: DM-Firmware image is not valid, it cannot be
>>> loaded\n",
>>> +                  __func__);
>>> +
>>> +        loadaddr = load_elf_image_phdr(LPM_DM_SAVE);
>>> +
>>> +        /*
>>> +         * Check if the start address of TF-A is in DRAM.
>>> +         * If not it means TF-A was running in SRAM, so it shall be
>>> +         * restored.
>>> +         */
>>> +        if (*(ulong *)(LPM_BL31_START_SAVE) < CFG_SYS_SDRAM_BASE)
>>> +            memcpy((void *)*(uintptr_t *)(LPM_BL31_START_SAVE),
>>> +                   (void *)LPM_BL31_SAVE, BL31_SIZE);
>>
>> This will not work. The memory where TF-A is running will be firewalled and
>> SPL absolutely cannot be securely trusted to load TF-A. Especially from an
>> unencrypted location in DDR. TF-A must be loaded as it is today using
>> signed
>> certificate images. You should know this, I explained it all when you tried
>> the same in TF-A:
>>
>> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23992
> 
> Hi Andrew,
> 
> We understood that GP devices are not impacted (we had this information
> from TI, probably Manorit I don't remember), and Manorit confirmed it in
> the TF-A review.
> 
> Maybe I could add a check of the device type to not impact HS devices.
> 

I'm not interested in GP devices, and neither are most our customers.
Those are development devices, customers go to production with secured
devices.

Saying "let's make it work on GP only, then we will figure it out on HS
later" was a mistake we made back in OMAP class device days. It made
bringing support to production secured devices (HS) miserable as we had
to unroll all the hacks that only worked on the development devices (GP).

Your method here is completely unusable on HS and will need a ground up
rewrite for HS. Since the solution for HS will also work on GP, but
not the other way around, you need to start with the HS solution.

I'll make this same point over on the TF-A review then let's continue
discussion over there only. If you cant get the TF-A part in then no
need for this U-Boot part.

Andrew

> Regards,
> 
> Thomas
> 
>>
>> NAK
>>
>> Andrew
>>
> 
