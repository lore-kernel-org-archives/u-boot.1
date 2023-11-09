Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152C5C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 11:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E207C87128;
	Thu,  9 Nov 2023 12:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dQ6ikkGp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F4987128; Thu,  9 Nov 2023 12:29:04 +0100 (CET)
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82BBF87108
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 12:29:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thomas.richard@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1E7B60007;
 Thu,  9 Nov 2023 11:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1699529342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/kAczv4fecmJGZFUpadTI3kd2oC5FkfYW7CyfBBEv9Y=;
 b=dQ6ikkGpFOLIgLEBA59x2SZtWRaB89UmYwtJtsZFe0qVbtzbEGwR+UMGjruEwgExJLsBct
 MWqJx0/vQUdeNDMn4tre45du1PCp18cN6TMziwP0kEORTpTUyHJGVknSn7d1ImR1dQXo21
 AIa1Wi93PDGmt6bCtiM8pq6h6ErgmkmQZ46jT6IjMGJ0qrH1wyh9rBqt/mv/DOJvIHKTWn
 waPkcYmcfRYtKuvl7P6bfvLhBzjUf6OJsCZv4hU9cInRJODIO+Y1t32wqMMBVODAYCuhlN
 WCi2d5a3O1+z6DVCsHvYt1fgcPgPAatOy79501KxqLeoihDM/o7BGLBtHO+uFQ==
Message-ID: <b2a9a9db-9f96-491c-882e-de4efa4ff472@bootlin.com>
Date: Thu, 9 Nov 2023 12:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] board: ti: j721e: During resume spl restores TF-A
 and DM-Firmware
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
Cc: nm@ti.com, thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
 u-kumar1@ti.com, Tom Rini <trini@konsulko.com>
References: <20231107161802.855154-1-thomas.richard@bootlin.com>
 <20231107161802.855154-8-thomas.richard@bootlin.com>
 <a8ec9dbe-f3a9-4a4e-88b5-a297d576c075@ti.com>
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <a8ec9dbe-f3a9-4a4e-88b5-a297d576c075@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
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

On 11/8/23 18:30, Andrew Davis wrote:
>>   void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
>>   {
>>       typedef void __noreturn (*image_entry_noargs_t)(void);
>> @@ -235,6 +241,32 @@ void __noreturn jump_to_image_no_args(struct
>> spl_image_info *spl_image)
>>       if (ret)
>>           panic("rproc failed to be initialized (%d)\n", ret);
>>   +    if (board_is_resuming()) {
>> +#if IS_ENABLED(CONFIG_SOC_K3_J721E)
>> +        if (!valid_elf_image(LPM_DM_SAVE))
>> +            panic("%s: DM-Firmware image is not valid, it cannot be
>> loaded\n",
>> +                  __func__);
>> +
>> +        loadaddr = load_elf_image_phdr(LPM_DM_SAVE);
>> +
>> +        /*
>> +         * Check if the start address of TF-A is in DRAM.
>> +         * If not it means TF-A was running in SRAM, so it shall be
>> +         * restored.
>> +         */
>> +        if (*(ulong *)(LPM_BL31_START_SAVE) < CFG_SYS_SDRAM_BASE)
>> +            memcpy((void *)*(uintptr_t *)(LPM_BL31_START_SAVE),
>> +                   (void *)LPM_BL31_SAVE, BL31_SIZE);
> 
> This will not work. The memory where TF-A is running will be firewalled and
> SPL absolutely cannot be securely trusted to load TF-A. Especially from an
> unencrypted location in DDR. TF-A must be loaded as it is today using
> signed
> certificate images. You should know this, I explained it all when you tried
> the same in TF-A:
> 
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/23992

Hi Andrew,

We understood that GP devices are not impacted (we had this information
from TI, probably Manorit I don't remember), and Manorit confirmed it in
the TF-A review.

Maybe I could add a check of the device type to not impact HS devices.

Regards,

Thomas

> 
> NAK
> 
> Andrew
> 

