Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE79CD5BA4
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 09:06:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D2E8341A;
	Thu, 21 May 2026 11:06:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="AIHYD8vO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B83B183E81; Thu, 21 May 2026 11:06:01 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A006805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:05:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id A408B1A363D;
 Thu, 21 May 2026 09:05:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 70CBA60495;
 Thu, 21 May 2026 09:05:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 384A4107E9F09; 
 Thu, 21 May 2026 11:05:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779354357; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=BL3faI50sm6OacqtyGOHv4WlMYXj2Czjh/qPXlQeVrk=;
 b=AIHYD8vOZ6bQ4bv1FZ2Z9uzEj6BAuiR0kn2r8t1+qpCAbx7vHdyUeD3572/C3iTfeMySQc
 gTbdFPbKrXp32nUxM5E9W9Q2LIJaJ7e3UQxvyDWNtsVMushndGc3paMjxEJZLLQsBFS/45
 Cl4Juppq2VT8SUlHL+7YNyyET5KUpxpmNZ/kkvQya2PeGID18LZNKaZyhy+/2pltl2AXhR
 SKXTGdiULiYi/WCoMV1knjJCUHznYMGY8tT+wOivNuRNLvufj9e9DDY/zn2wg23l4bPOxE
 EgBUkzphgBhXfXgA81BHTyV0z55tgkhhv8sHeURPOOcy+c7is29wLm1JwvGyoQ==
Message-ID: <73755db2-8737-4803-a1a2-676652702e97@bootlin.com>
Date: Thu, 21 May 2026 11:05:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] board: ti: j721e: Add resume detection for
 J721e/J7200
From: Richard GENOUD <richard.genoud@bootlin.com>
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-4-richard.genoud@bootlin.com>
 <ac17d4b9-e31f-4ab1-836d-b8b188dfe8b6@ti.com>
 <e4b59ce5-f532-4991-8c06-d78372be911c@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <e4b59ce5-f532-4991-8c06-d78372be911c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Le 21/05/2026 à 10:42, Richard GENOUD a écrit :
> Le 11/05/2026 à 11:53, Kumar, Udit a écrit :
>>
>>
>> On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
>>> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
>>>
>>> Add the capability to detect a resume. This overrides the weak
>>> function j7xx_board_is_resuming(void).
>>> To detect the resume, SPL searches a magic value (0xBA) in a register
>>> of PMICA.
>>> This value is set by DM-Firmware during the suspend sequence.
>>>
>>> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
>>> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>>> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>>> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>>> ---
>>>   board/ti/common/k3-lpm.h | 17 +++++++++++++++++
>>>   board/ti/j721e/evm.c     | 37 +++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 54 insertions(+)
>>>   create mode 100644 board/ti/common/k3-lpm.h
>>>
>>> diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
>>> new file mode 100644
>>> index 000000000000..a2141a0c25a8
>>> --- /dev/null
>>> +++ b/board/ti/common/k3-lpm.h
>>> @@ -0,0 +1,17 @@
>>> +/* SPDX-License-Identifier: GPL-2.0+ */
>>> +/*
>>> + * Copyright (C) 2026, Texas Instruments Incorporated - https:// 
>>> www.ti.com/
>>> + * Copyright (C) 2026, Bootlin
>>> + */
>>> +
>>> +#ifndef __K3_LPM_H
>>> +#define __K3_LPM_H
>>> +
>>> +/* Magic value in PMIC register to indicate the suspend state 
>>> (SOC_OFF) */
>>> +#define K3_LPM_MAGIC_SUSPEND 0xba
>>> +
>>> +/* PMIC register where the magic value resides */
>>> +#define K3_LPM_SCRATCH_PAD_REG 0xcb
>>> +
>>> +#endif /* __K3_LPM_H */
>>> +
>>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>>> index 881392bd963a..67ff13828514 100644
>>> --- a/board/ti/j721e/evm.c
>>> +++ b/board/ti/j721e/evm.c
>>> @@ -17,9 +17,11 @@
>>>   #include <spl.h>
>>>   #include <dm.h>
>>>   #include <asm/arch/k3-ddr.h>
>>> +#include <power/pmic.h>
>>>   #include "../common/board_detect.h"
>>>   #include "../common/fdt_ops.h"
>>> +#include "../common/k3-lpm.h"
>>>   #define board_is_j721e_som()    (board_ti_k3_is("J721EX-PM1-SOM") || \
>>>                    board_ti_k3_is("J721EX-PM2-SOM"))
>>> @@ -469,6 +471,41 @@ err_free_gpio:
>>>       }
>>>   }
>>> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && 
>>> IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
>>> +
>>> +bool j7xx_board_is_resuming(void)
>>> +{
>>> +    struct udevice *pmica;
>>> +    int ret;
>>> +
>>> +    if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>>> +        goto end;
>>> +
>>> +    ret = uclass_get_device_by_name(UCLASS_PMIC,
>>> +                    "pmic@48", &pmica);
>>> +    if (ret) {
>>> +        printf("Getting PMICA init failed: %d\n", ret);
>>> +        goto end;
>>> +    }
>>> +    debug("%s: PMICA is detected (%s)\n", __func__, pmica->name);
>>> +
>>> +    if (pmic_reg_read(pmica, K3_LPM_SCRATCH_PAD_REG) == 
>>> K3_LPM_MAGIC_SUSPEND) {
>>> +        debug("%s: board is resuming\n", __func__);
>>> +        gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>>
>> If you failed to clear magic word then, we are not in correct state.
>> So doing all work with PMIC, set state to resuming
> That's right, I'll check the error.
Sorry, I answered too quickly.
I mean, yes, if we fail to clean the magic value from PMIC, the next 
boot may be incorrectly detected as resuming.

>>
>>> +
>>> +        /* clean magic suspend */
>>> +        if (pmic_reg_write(pmica, K3_LPM_SCRATCH_PAD_REG, 0))
>>> +            printf("Failed to clean magic value for suspend 
>>> detection in PMICA\n");
But what could we do in this case?
We could hang() the board, reboot...
Or gd_set_k3_resuming back to K3_RESUME_STATE_UNKNOWN and hope that the 
next call to j7xx_board_is_resuming() will successfully clean the magic 
value.

Otherwise, we can reset this magic value in the DM startup?

>>> +    } else {
>>> +        debug("%s: board is booting (no resume detected)\n", __func__);
>>> +        gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>>> +    }
>>> +end:
>>> +    return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
>>> +}
>>> +
>>> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
>>> +
>>>   void spl_board_init(void)
>>>   {
>>>       struct udevice *dev;
>>
> 
> Thanks!
> 
> Regards,
> Richard

Regards,
Richard
