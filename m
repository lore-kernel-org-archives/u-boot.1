Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0017DFD0048
	for <u-boot@archiver.kernel.org>; Sun,  1 Mar 2026 05:24:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A1783A8C;
	Sun,  1 Mar 2026 06:24:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vPiBBIMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 304BF83CDF; Sun,  1 Mar 2026 06:24:12 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96434838BB
 for <u-boot@lists.denx.de>; Sun,  1 Mar 2026 06:24:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOFMu6lKzIfXKkWavx0usGW/g2dCii/fXhV4GoNIsxk3+liVQETMiuo7unPCTAyjm18I1SYm3Og9+pDja36OEe+0OcX1w4UCK6nMt37sVQdTmSIT/7UPTTl9+SAg7N9PnDbb+qPhlPTn/4OObITMBkcXqklUPWZu44MJihLdU1sMyyAetXWO4LB3y+Lz/HERvyHYvGxuLMdp3t8dvC6kIPHz/i2L6VtVVzfEmgRpUEVkmJxa1L6Vd6tCVcIU6C32HW5pvK+XouvnGXCY5k4DgyaGqQr092Wh9a898B5o9DBi7YPd58cQaBer+32oQzabKRUTEvNSeDVMJ1wGudhPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K0sAjdHFJaqS+XJYGoVhcbeJZq5tKug34javziDXgo4=;
 b=qPrW77wY2nUmatx7Vabbk7mHgzaQB2pjYM67pka5oeU3ouzqVUmLzzZWVmqwAHxo6mzhvzXBRvYQfEww+KA4QuaA17OHeJIMH0MndS/VWTk2pu+Ekffg/id582EXyAkLuw2F7cwT9qXOUkgPlJXlzAN92fGiLTsF+T1y9Y+ecSo/VueZMPz3PO9rmS0v4hSdN9RMbPBBTfeig76iZH+XLi6wB1mHXt4UzgjqcOjSgNdnUzaBJEyjXnsD9Jk+h23EeMx638yRitjYKXoH/ZBokc74SSNvm7SDLQtjVhyz06spUtdoM+scNMDpki8ZX80aymTy/L5d74rC31dVs/Y75w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0sAjdHFJaqS+XJYGoVhcbeJZq5tKug34javziDXgo4=;
 b=vPiBBIMrRvUhAiKlq/DSwpRjAv5ak2HVuJwchlZaIj/CQBk+8ThmVGDLJc0Q4K3VtiB/VwznERdj52apMz9gjhwcJYzkYKtwhjP2x5H2vcXuGMA0V/yCJ4Lsz5ZhyM5Bo5LmUcxBX7Y62BpbnzdwXnNwMksTVP1U7H4Ps7wFuKI=
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by IA3PR10MB8705.namprd10.prod.outlook.com (2603:10b6:208:583::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 1 Mar
 2026 05:24:06 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:3c2:cafe::b8) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16 via Frontend Transport; Sun,
 1 Mar 2026 05:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sun, 1 Mar 2026 05:24:05 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 23:24:05 -0600
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 23:24:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 28 Feb 2026 23:24:04 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6215O2FU2343201;
 Sat, 28 Feb 2026 23:24:03 -0600
Message-ID: <992e9023-48dd-460e-a783-9caf58f5e944@ti.com>
Date: Sun, 1 Mar 2026 10:55:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Marek Vasut <marek.vasut@mailbox.org>, <marex@denx.de>
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
 <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
 <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
 <f19e58ad-58ed-4d5b-a348-6d2270e546f0@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <f19e58ad-58ed-4d5b-a348-6d2270e546f0@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|IA3PR10MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d428397-3409-47d6-caa7-08de7752c217
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: gAShbXTwB846OIYxMEE9QPVN/Ln9cnWZTBfnpXV1sSWV/bF1HAI3/dpxX3kVuwctcZYrxFCskyjHe1D5Z8t8aySar8qSBOni2p0Xs7oFSvegjRf82vd1ax6neV2Am4Oe67NArY23hPRTs+Kz8bxXlvQos2WjRBXcz9/kAl12oMGFfgY6u9S9PlswPnrDZegdnA65K/KvF/ze0HkO7vIbjqOzhAi2Hw3RJ09XY67OjREYixiUPKkK469fy7r/5INB4PVnU7TDmXcU8OIwdlXtAN5yaOesoig2L20sdqWggxVtsi4pZzl7JChxChcVU27JQpGSnTjm7WU+ECVdGXwGr4bYgMCh1Gub1Zum9rEoKpI0vzyXP6htLKfGI9gaydzwPQf61hjwSb8si6MpL+VXlB38BbtUf0tz6y27AD22AQWBPoEcOVCCm1RAY8dDkL0sTiCD3RW4IIeW86DOJpdzsIbcrkwuCY3tcmGEiCKcbS2RvaFpfYLGOVq0BCZDy2SqFy+rmmmxltSiAmTyfjKEeD9Y3WeM4FauIkT9zLLO9xj0oW95jIgcGrE5QU37259O8Gvd7Z2HYmnJx2JZm2Jj7YeSRljZac44KeKeHZLZpJXx+jSTTZdpIw4ZPMkvT7eYJBwTJq0H8vRO8MI9vqwF5QV4VLA62ZQyeiJ5gd+txqZ98MZuF9P09+JP6YLfNq3eC3IPaVzAWnvp2rrw8N2ZIlivMgks9Yh8HQ3YMEMCvHwnD0pHPrNVEbkm0gDV3mkKyXtsokhuk3bEzuC0FIOyc4a+LcCLiKJ7PHHWYfyfjtPAFnYL9wXT+iKrinCfr5HmEo+bsFWHQVG974QyJ8kQdQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(34020700016)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yAF6VlIrhTrzhFwushF5Y9m6wJxRJ15Neeum1W78LIhPxZt756s4l3MdWM0MftlYyPTSW7nGAZX+6LfDe3/UQw6mg2icPOm4LfqTrgpAM1YDIJU7dfsaYsJyXbKqByv52UDmNb4iL67m9J6qQ4WCVzMo5vz8Rw2XDTgbTB+Nx0ERZxP2eWEKnYkYb38dUPwURKiBkE52C5BdHsFN+E/v4CNG66mzkdre1Up29ZyMN8rg/PAdY3mSpba7Yk/2ooE5LlFhfdsBAhgQWvwb4U/dEY0By99Ez5TAnr9ZqFC8eS1FpEnvpqFzJX+bMFcGz+45mCGngKxeET1xscXvwMKfylOb7gXMX/ZQRE49p6qEphGg2AytRXCmH24ygGOytpMfKMA/4jGcmaNsg3cOg1SfXmRZdWuUYmNRr/yWkaAlyevR9UlV8wluUMnS+ZEtXw6C
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 05:24:05.9844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d428397-3409-47d6-caa7-08de7752c217
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8705
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

On 01/03/26 06:50, Marek Vasut wrote:
> On 3/1/26 2:02 AM, Siddharth Vadapalli wrote:
> 
>>>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>>>> index 10bc4cabed4..a775567b3bc 100644
>>>> --- a/drivers/usb/cdns3/core.c
>>>> +++ b/drivers/usb/cdns3/core.c
>>>> @@ -461,9 +461,18 @@ int cdns3_bind(struct udevice *parent)
>>>>       /* Use VBUS Valid to determine role */
>>>>       if (dr_mode == USB_DR_MODE_OTG) {
>>>> +        /*
>>>> +         * Since we perform register accesses in cdns3_get_otg_mode(),
>>>> +         * we need to ensure that the parent has been probed and that
>>>> +         * the USB Controller is powered ON.
>>>> +         */
>>>> +        ret = device_probe(parent);
>>>> +        if (ret)
>>>> +            goto fail;
>>>> +
>>>>           ret = cdns3_get_otg_mode(parent, &dr_mode);
>>>>           if (ret < 0)
>>>> -            return ret;
>>>> +            goto fail;
>>>>       }
>>> Can you instead move this logic into driver .probe() ? Then you wouldn't 
>>> need the device_probe() hackage.
>>>
>>
>> There are two users of cdns3_bind() which have registered their 
>> own .bind() callback as cdns3_bind():
>> 1. cdns3-starfive.c driver
>> 2. cdns3-ti.c driver
>> Since .bind() is called before .probe()
> 
> .bind callback is meant to BIND the driver instance (to a DT node), it is 
> not meant to initialize the hardware. .probe callback is meant to 

I agree. But that's exactly where the issue lies. When 'dr_mode' is set to 
OTG, cdns3_bind() is unable to determine if the driver to bind to the DT 
node is "cdns-usb3-host" or "cdns-usb3-peripheral".

Since [0], we attempt to identify if OTG should imply 'peripheral' or 
'host'. But to do that, [0] needs to read the VBUS Valid field of the OTG 
Status register. And register access requires the USB Controller to be 
powered ON.

[0]: bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role for 
dr_mode OTG")

> initialize the hardware. This is fundamental part of the U-Boot DM lazy 
> initialization scheme. If something does initialize hardware in .bind, then 
> it is very likely wrong.
> 
>> , and, since cdns3_bind() is also the .bind() callback of the above 
>> drivers, device_probe() has to be added here itself. Moreover, it is only 
>> due to the register accesses being performed by the recently introduced 
>> cdns3_get_otg_mode() function that we need the USB Controller to be 
>> powered ON at this stage.
> So, can we fix this so the HW initialization won't be happening in bind, 
> but instead in .probe ?

That isn't possible when 'dr_mode' is OTG because the .probe() callback 
itself is determined by cdns3_bind(). Whether it is "cdns-usb3-host" 
driver's .probe() callback or "cdns-usb3-peripheral" driver's .probe() 
callback depends on cdns3_bind() being able to decide which driver to bind 
to the DT node. And for cdns3_bind() to decide the driver when 'dr_mode' is 
OTG, we need to read the VBUS Valid field. So cdns3_bind() needs to ensure 
that the USB Controller is powered ON (device_probe() of parent).

