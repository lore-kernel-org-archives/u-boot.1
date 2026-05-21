Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB5CD5BAC
	for <u-boot@archiver.kernel.org>; Thu, 21 May 2026 09:27:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE1188341A;
	Thu, 21 May 2026 11:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="oC2SO++9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A50D83FF5; Thu, 21 May 2026 11:27:24 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6A81805D7
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 11:27:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8F0EB1A3651;
 Thu, 21 May 2026 09:27:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 6232760495;
 Thu, 21 May 2026 09:27:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D9342107EA1B0; 
 Thu, 21 May 2026 11:27:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779355640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=+MHN7JWgPcOYQlCqT/NZoiB2aA+P89i31ITAAu97wXk=;
 b=oC2SO++9VAhIhauQB7njwotTzXoCGDsOQjeuaF6NEurnvWf5Ni93J7hsR5M6hjssFWmasl
 ELiQXa0tIqrTpNIZbYuk3IEaI1uZ4RYZoj8tLHnEw7xmXTKA6KDC84/D2/YxUXc1ary78G
 8SJ5VaWmowx6l5pFdQsblX7HGTPLfDEEXyKsPo4zPcHyVSDtuQUNDN5Dr1JjmXx3QlYrHA
 ghr+HK5jZImtPs2LIkZK4qhywtySPNjjKwiYFIeed5/387M0eFd5lcZGJNxabLkt6HcR21
 scG/uS/bCzJEEM32zDcqIvdrJs78fjJg19B/+Bem9eAoiJ/H8HK5tr64/B01sg==
Message-ID: <01148745-2fd2-46b4-9dd5-415fce69e1f2@bootlin.com>
Date: Thu, 21 May 2026 11:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/20] board: ti: j721s2: Add resume detection
To: "Kumar, Udit" <u-kumar1@ti.com>, Tom Rini <trini@konsulko.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Vaishnav Achath <vaishnav.a@ti.com>,
 Jayesh Choudhary <j-choudhary@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Abhash Kumar <a-kumar2@ti.com>, Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
References: <20260430084414.1354490-1-richard.genoud@bootlin.com>
 <20260430084414.1354490-7-richard.genoud@bootlin.com>
 <18d03aa5-0c4b-461d-a408-74fb3eeafe0f@ti.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <18d03aa5-0c4b-461d-a408-74fb3eeafe0f@ti.com>
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

Le 11/05/2026 à 12:48, Kumar, Udit a écrit :
> 
> 
> On 4/30/2026 2:13 PM, Richard Genoud (TI) wrote:
>> From: "Thomas Richard (TI)" <thomas.richard@bootlin.com>
>>
>> Add the capability to detect a resume. This overrides the weak function
>> j7xx_board_is_resuming(void).
>> To detect the resume, SPL searches a magic value (0xBA) in a register of
>> PMICA.
>> This value is set by DM-Firmware during the suspend sequence.
>>
>> Signed-off-by: Thomas Richard (TI) <thomas.richard@bootlin.com>
>> ---
>>   board/ti/j721s2/evm.c | 37 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
>> index 92d5c8498643..e18ba1a540c9 100644
>> --- a/board/ti/j721s2/evm.c
>> +++ b/board/ti/j721s2/evm.c
>> @@ -22,9 +22,11 @@
>>   #include <dm/uclass-internal.h>
>>   #include <dm/root.h>
>>   #include <asm/arch/k3-ddr.h>
>> +#include <power/pmic.h>
>>   
>>   #include "../common/board_detect.h"
>>   #include "../common/fdt_ops.h"
>> +#include "../common/k3-lpm.h"
>>   
>>   DECLARE_GLOBAL_DATA_PTR;
>>   
>> @@ -304,6 +306,41 @@ int board_late_init(void)
>>   	return 0;
>>   }
>>   
>> +#if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J721S2_R5_EVM) && IS_ENABLED(CONFIG_PMIC_TPS65941))
>> +
>> +/* in board_init_f(), there's no BSS, so we can't use global/static variables */
>> +bool j7xx_board_is_resuming(void)
>> +{
>> +	struct udevice *pmic;
>> +	int err;
>> +
>> +	if (gd_k3_resuming() != K3_RESUME_STATE_UNKNOWN)
>> +		goto end;
>> +
>> +	err = uclass_get_device_by_name(UCLASS_PMIC,
>> +					"pmic@48", &pmic);
>> +	if (err) {
>> +		printf("Getting PMIC init failed: %d\n", err);
>> +		goto end;
>> +	}
>> +	debug("%s: PMIC is detected (%s)\n", __func__, pmic->name);
>> +
>> +	if (pmic_reg_read(pmic, K3_LPM_SCRATCH_PAD_REG) == K3_LPM_MAGIC_SUSPEND) {
>> +		debug("%s: board is resuming\n", __func__);
>> +		gd_set_k3_resuming(K3_RESUME_STATE_RESUMING);
>> +
>> +		/* clean magic suspend */
>> +		if (pmic_reg_write(pmic, K3_LPM_SCRATCH_PAD_REG, 0))
>> +			printf("Failed to clean magic value for suspend detection in PMIC\n");
>> +	} else {
>> +		debug("%s: board is booting (no resume detected)\n", __func__);
>> +		gd_set_k3_resuming(K3_RESUME_STATE_BOOTING);
>> +	}
> 
> Could all function be combined into common_j7xx_lpm.c for all supporting
> SOCs.
J722s function is a little bit different, but I'll find a way to 
factorize them.

> 
>> +end:
>> +	return gd_k3_resuming() == K3_RESUME_STATE_RESUMING;
>> +}
>> +#endif /* CONFIG_SPL_BUILD && CONFIG_TARGET_J721S2_R5_EVM && CONFIG_PMIC_TPS65941 */
>> +
>>   void spl_board_init(void)
>>   {
>>   	struct udevice *dev;
> 
Thanks,

Regards,
Richard
