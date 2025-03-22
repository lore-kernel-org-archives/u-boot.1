Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F0AC36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 436388197D;
	Sat, 22 Mar 2025 03:49:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611792;
	bh=p8nHAA8L9EU8DkIHE1DVMt/YUVTmWqT0W1o2rWwyJTw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fNmU/2i372g39tDddYOQJdivhHmQHrB1Si51R3kmZzmXEBSOFeVmLIY2Limb2XC4a
	 YAGv8RJXax/8F33mfNsVFYProAPN23Xq+jaLh2MyDoy1sZTXRzaW44gOAx2JO/0REy
	 btd/h9lSMm2mPE6+9HpkBw9tK3Y4PIwfE8Ao1D4IHaOpE4tFPNj76Er9t36ZhXyzuO
	 K3M1BpR64XR20N+wFjF2je0PSmdL0IQRnJuug0XzW+kjHNu6M3pkVDYb5jWumRPYw2
	 /KUWaI8kt/TBzU+0SLx4JA1fiHmm5EPoiFRxYcxwqA+2VbWJ0GG0wmU4GTZqSNUNXM
	 i2VdMv/jo2AHw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5A9F811AC; Sat, 22 Mar 2025 03:49:49 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96EE6806FC
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="ct10CpdR"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 27936101E90A4; Sat, 22 Mar 2025 03:49:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611786; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=p8nHAA8L9EU8DkIHE1DVMt/YUVTmWqT0W1o2rWwyJTw=;
 b=ct10CpdRwhw5lLaVWrWaBZ0H9a756L88le6AoKicVihsPP/GXEVUl3GsN/i3jCE4On10DR
 KVvG13dA5xEKoDzPPf1+/79qW8OwrOwzuDq5gyz0NYr85wTMM1wAjDvD+Y0XYcbONA1yGN
 aLGHb0gCp8KNTnSp03W/FSA9IB1u34bqACMSpywIgkViewC8LbNWSHb34SvsoYB+VHeJCt
 6UXiK7r2/hOTFppIjtb5ohVGzwiFQZ46myiK4FTr6FX93aJiZAiCyMWEHijAVcPjqeOiqf
 bzVaLD571u4uhv/5zAQa4RiTCdwgzNMNg6+PrAhnQX0xcoo2akZX88zknHZrog==
Message-ID: <f7f99759-abd7-410f-a03b-62edc9e2c22f@denx.de>
Date: Sat, 22 Mar 2025 01:34:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHY3IDEwLzE5XSBpbXg5OiBzY21pOiBh?=
 =?UTF-8?Q?dd_i=2EMX95_SoC_and_clock_related_code?=
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>
References: <20250305-imx95-v1-0-286d15acbb8a@oss.nxp.com>
 <20250305-imx95-v1-10-286d15acbb8a@oss.nxp.com>
 <20250306064158.4d7d708b@karo-electronics.de>
 <PAXPR04MB9644314215ECF61DAFA6E14AE2DB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <PAXPR04MB9644314215ECF61DAFA6E14AE2DB2@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/21/25 8:17 AM, Alice Guo (OSS) wrote:

[...]

>>> diff --git a/arch/arm/mach-imx/imx9/scmi/clock.c
>> b/arch/arm/mach-imx/imx9/scmi/clock.c
>>> new file mode 100644
>>> index 0000000000..9ebd380976
>>> --- /dev/null
>>> +++ b/arch/arm/mach-imx/imx9/scmi/clock.c
>>> @@ -0,0 +1,105 @@
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +/*
>>> + * Copyright 2025 NXP
>>> + */
>>> +
>>> +#include <asm/arch/clock.h>
>>> +#include <dm/uclass.h>
>>> +#include <scmi_agent.h>
>>> +#include "../../../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
>>>
>> "Interesting" include path...
>> Shouldn't this file be located under dts/upstream/include/dt-bindings/ like all the
>> other imx*-clock.h files?
>> Then the file should be picked up via
>> #include <dt-bindings/imx95-clock.h>
> 
> Hi,
> 
> imx95-clock.h is not in this directory dts/upstream/include/dt-bindings/.
I noticed this odd location of imx95-clock.h in Linux too , it is not in 
the include/dt-bindings directory . Why is that ?
