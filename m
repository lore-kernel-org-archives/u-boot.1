Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661EBCD5BA4
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 08:42:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FFDD8341A;
	Thu, 21 May 2026 10:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="nT645eZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70E9D83E81; Thu, 21 May 2026 10:42:37 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 169BA805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 10:42:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 776B6C2C64B;
 Thu, 21 May 2026 08:43:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6429860495;
 Thu, 21 May 2026 08:42:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4C07E107EA6CA; 
 Thu, 21 May 2026 10:42:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779352953; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=N2bsq+Hv7LfslZ17wj+atGwD13Jc8khuINOqu6vhgks=;
 b=nT645eZ4Z4CYMIxuz8FPFIrJPZ6jmFyp03yE56k3NHKcF2Ep82FU0bkkxKm50L9LCHQ7xQ
 BHK6hylDriKslZBwMHaRpJtIbYa60/QC1WMS5li04h36Nn8whWpMVH/FAuPKicC0y393bb
 RxCj0KHzDUM10JecqE/wQfFX9L1OKgL6SQEQP/gYbGC5sWGMhoiwFlNkXrwO9VvoCZRzUc
 Rals92aTiM8hI1Y+HpbHjTSU838+iUQIFs+LYOkI/5ycb22c8e6xTKmHgVlTGp4hbhMdLi
 +gan9fWc/2c2Wz5I4/PHcKQQMtfcPO9dZrK2BXN1CYQdnb5Mm9PgR901i3kS6Q==
Message-ID: <e4b59ce5-f532-4991-8c06-d78372be911c@bootlin.com>
Date: Thu, 21 May 2026 10:42:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] board: ti: j721e: Add resume detection for
 J721e/J7200
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
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <ac17d4b9-e31f-4ab1-836d-b8b188dfe8b6@ti.com>
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

Le 11/05/2026 à 11:53, Kumar, Udit a écrit :
> 
> 
> On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
>> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
>>
>> Add the capability to detect a resume. This overrides the weak
>> function j7xx_board_is_resuming(void).
>> To detect the resume, SPL searches a magic value (0xBA) in a register
>> of PMICA.
>> This value is set by DM-Firmware during the suspend sequence.
>>
>> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
>> Co-developed-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>> Signed-off-by: Gregory CLEMENT (TI) <gregory.clement@bootlin.com>
>> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
>> ---
>>   board/ti/common/k3-lpm.h | 17 +++++++++++++++++
>>   board/ti/j721e/evm.c     | 37 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 54 insertions(+)
>>   create mode 100644 board/ti/common/k3-lpm.h
>>
>> diff --git a/board/ti/common/k3-lpm.h b/board/ti/common/k3-lpm.h
>> new file mode 100644
>> index 000000000000..a2141a0c25a8
>> --- /dev/null
>> +++ b/board/ti/common/k3-lpm.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2026, Texas Instruments Incorporated - https://www.ti.com/
>> + * Copyright (C) 2026, Bootlin
>> + */
>> +
>> +#ifndef __K3_LPM_H
>> +#define __K3_LPM_H
>> +
>> +/* Magic value in PMIC register to indicate the suspend state (SOC_OFF) */
>> +#define K3_LPM_MAGIC_SUSPEND 0xba
>> +
>> +/* PMIC register where the magic value resides */
>> +#define K3_LPM_SCRATCH_PAD_REG 0xcb
>> +
>> +#endif /* __K3_LPM_H */
>> +
>> diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
>> index 881392bd963a..67ff13828514 100644
>> --- a/board/ti/j721e/evm.c
>> +++ b/board/ti/j721e/evm.c
>> @@ -17,9 +17,11 @@
>>   #include <spl.h>
>>   #include <dm.h>
>>   #include <asm/arch/k3-ddr.h>
>> +#include <power/pmic.h>
>>   
>>   #include "../common/board_detect.h"
>>   #include "../common/fdt_ops.h"
>> +#include "../common/k3-lpm.h"
>>   
>>   #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
>>   				 board_ti_k3_is("J721EX-PM2-SOM"))
>> @@ -469,6 +471,41 @@ err_free_gpio:
>>   	}
>>   }
>>   
>> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
>> +
>> +bool j7xx_board_is_resuming(void)
>> +{
>> +	struct udevice *pmica;
>> +	int ret;
>> +
>> +	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>> +		goto end;
>> +
>> +	ret = uclass_get_device_by_name(UCLASS_PMIC,
>> +					"pmic@48", &pmica);
>> +	if (ret) {
>> +		printf("Getting PMICA init failed: %d\n", ret);
>> +		goto end;
>> +	}
>> +	debug("%s: PMICA is detected (%s)\n", __func__, pmica->name);
>> +
>> +	if (pmic_reg_read(pmica, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
>> +		debug("%s: board is resuming\n", __func__);
>> +		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
> 
> If you failed to clear magic word then, we are not in correct state.
> So doing all work with PMIC, set state to resuming
That's right, I'll check the error.

> 
>> +
>> +		/* clean magic suspend */
>> +		if (pmic_reg_write(pmica, K3_LPM_SCRATCH_PAD_REG, 0))
>> +			printf("Failed to clean magic value for suspend detection in PMICA\n");
>> +	} else {
>> +		debug("%s: board is booting (no resume detected)\n", __func__);
>> +		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>> +	}
>> +end:
>> +	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
>> +}
>> +
>> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J7200_R5_EVM */
>> +
>>   void spl_board_init(void)
>>   {
>>   	struct udevice *dev;
> 

Thanks!

Regards,
Richard
