Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B469CFD0049
	for <u-boot@archiver.kernel.org>; Sun,  1 Mar 2026 01:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4EE583A8C;
	Sun,  1 Mar 2026 02:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jSWbVL6K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23FE283CDF; Sun,  1 Mar 2026 02:02:27 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03FBD838BB
 for <u-boot@lists.denx.de>; Sun,  1 Mar 2026 02:02:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q0FTQSM4acIWztLVBkZF0r4E+tKQNacuJqfgsRL8QsUJReeZZ3aSZSUDnH+Ip0ZI1HTl6dTRKkjVguWSUa4m2TM7baWVyP4q+e22e8UNHbdXuF2IxKU7856WgyugrNC6NDnDfYjNAAsHN+C6FBjFeGlIkjMfy+fPeZ7BHzbdFhtyyjuMZWoA1hBPHsbzLH9HLmQh5VhHsDKl07S3Z8h7mvMVu/5zmrFv2Pt7doVpnZQFhSp8Cx/u8v0vCnu19ShMa0CB7qjv6x6rfO/BHvoifXzm093JLa1Rmv8jj27Gf/hgCB+HdtrRMtHzeSc0T+31WH5zPQgZ7RnLdGHRZrnpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2CTJx2d9NiWnaLZ3pfEbCxQqugXxk9Gia5slJjHnjM=;
 b=vzaw5BN1Rig7Zo8MabreyT7BZVrKYv0Dws/8YClaIhKMUcNHBMucINARuPokUZMqq+fGYTJdM/+IHqbU2taCWVPXoXCT8d2N/df4UO9vo7EsgnhZ/1T7NpAXlVKWEs/woD09enpbfH3t9Z5/aV6x3dkqgMXlptzyO1jurO9cjSvNP9dmv9ZHwJArgEbh7cP7/B/e+OwsgX99h9wlqqgHoIa16mgo0SfSHjfyxXfGUBMPmkIdwPl+p1I4CdeVmIG4fbyWhOALyTs5BHL7BMOzu0/XZZTPKzBy19AqlrDv3/E6qV+69f494G7oxPybKfxuNsP5xe3O+IbWfLJ4xmJ6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2CTJx2d9NiWnaLZ3pfEbCxQqugXxk9Gia5slJjHnjM=;
 b=jSWbVL6K5wI/WiHUR1YumsPfaNi54+pXWTJoC4unn+vUf++Ewv5IDFAU/GTA3YFIrLjnv0fwQgDYdLHooMpMVB3ooobik/eST4f+xkEiVcTr3PF7F5DM+be81gfJYE3FY9WSAprATi2n9DJTJzF5gBJGeTqfI+eoku8xDYIY27A=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by CH3PR10MB7702.namprd10.prod.outlook.com (2603:10b6:610:1a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sun, 1 Mar
 2026 01:02:20 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::ab) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.27 via Frontend Transport; Sun,
 1 Mar 2026 01:02:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sun, 1 Mar 2026 01:02:18 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 19:02:18 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 28 Feb
 2026 19:02:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 28 Feb 2026 19:02:18 -0600
Received: from [10.249.139.123] ([10.249.139.123])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62112FMQ2570132;
 Sat, 28 Feb 2026 19:02:15 -0600
Message-ID: <c5e0e61b-a8ab-4186-9460-84221d843542@ti.com>
Date: Sun, 1 Mar 2026 06:32:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: cdns3: fix cdns3_bind() to avoid returning error and
 probe parent
To: Marek Vasut <marek.vasut@mailbox.org>, <marex@denx.de>
CC: <trini@konsulko.com>, <minda.chen@starfivetech.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
References: <20260227055954.3916518-1-s-vadapalli@ti.com>
 <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <4d8848d2-3a4e-4025-aeac-c15592b16276@mailbox.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR10MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee5482f-c9c5-4d9b-e86a-08de772e2ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|34020700016|36860700013; 
X-Microsoft-Antispam-Message-Info: OfytZp7RTK2uibEcce6fC19vooqAlwK8I+gMDLUrbglAVzluPgj75ZjOhliWAJY5Va/PJf8VR8Q+PmRt94Lq7LvNHL4sBCQfQDSyDOBpzWBNi88JnmY2YEf2/ccXRjWahUadUvwkIvAi7O2ZslK02H+azXyhExsOYLuLPrKiE8tmC9afz6syEMW4kjaT+HWOULDQp2H/3T5cc7/UIroYMywKhYC/WdwbwgQdoVh59WHO6Kqc2o7iOvAZtTqLy6Kim8YWLeWdJJe+awYkSHvjjRxiQcCCt1DRyaX27Machp0WcFCjFhqb4YWGi4e+h6czmKLVPLyJbm0RH6EBs1G5D8CNPD6JLJYrC2UJBXK7C0vo4v+HnuYXWeepPESAp0QnIjjRaOGrhfDoVUVl9DkKB5vbPlG3t4YP8dRjKzPVU0fEstsoGlUKva7tIz893woRIg4lty/nmxVZecFYGroVOS8rCWs58cedJa7ZOvrb1qnB8+4D93868gHLAfaGGCGfdgt3FPa472CAuWEpkJfJ2k3zfj4oaQpJpu2xsmE9s2f3wadzROMfVVZ40D/IyJs0g3pGKEmWs8lHRyiWYq7M0mp6GRcllgoh9KA/ETo5BkBtW0trzu/D0vj4D1b7V8cGaupapoHqEgIkXcvBfNIdQ0FS+Fnw2KDuj5QF5g+aOAJFevCx86PZ2439fEBs6Bg53CJb0FfKFBI0ZzUZcy3f/A5FXh9Oug5yTjTgpmlWP0LbpZj9doPi04Uk8kBYJp5tqK2nryIvhz0H+s4MKOSMtwJij0/hzF2X86CW5XGie0cowACpLTZT/crJVVUX5TnaA6lHkJAtextz0x1wPI1Niw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(34020700016)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xm7cgL91d8oq3chFX3VwBFBL7DXioqV3NSxqzUG0iovMAjcFKByAhT22CnHSDKLhHt+9dex7iBKdjTjSCFwVPF6l4bnckDlttKuY27NEFKwETXHdeNuDyY3z2U3ThiavQTGc+1ay6T0tmOs5XOZ/KacFS/qXfXGzpO7nrSbfqaAXQP5WRwakBfrR7XD3BjFrJlxbbViUFuaeKZQJvLcHIw1LmCL/sxcN4fohBYQgWgb8TPuFRJQW57RLtVysR/imWjW0RAyr5tyMQ+tUcHzCq36GbHXVI9QxnDHroZxgjEFemBx24urFcRobE7bv/URJM4LW3SV4f02K64A5g3l3TPolRen8pn/UEESsgY6MMieY3b6T6jdk71le1aIBAZ2Ilp1JGv3WU6B1HF92eS/shtQMc9DrqXVtkEutYd2DybAUvqvDJ0GtJMLe6mIV62gz
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 01:02:18.8586 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee5482f-c9c5-4d9b-e86a-08de772e2ff1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7702
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

On 27/02/26 5:21 PM, Marek Vasut wrote:
> On 2/27/26 6:59 AM, Siddharth Vadapalli wrote:
>> While commit bfb530e06ca6 ("usb: cdns3: use VBUS Valid to determine role
>> for dr_mode OTG") enhances the driver, it causes boot failure for non-USB
>> boot mode when the 'dr_mode' is 'otg'. The reason for it is that the
>> cdns3_get_otg_mode() function reads the USB Controller registers to
>> determine the appropriate role. If the boot mode happens to be USB, then
>> the USB Controller will be powered ON and the registers are accessible.
>> For non-USB boot modes, the USB Controller is not necessarily powered ON
>> as a result of which the register accesses cause boot failure.
>>
>> Another issue is that the error code from cdns3_get_otg_mode() is 
>> returned
>> as-is by cdns3_bind(). The cdns3_bind() function already has a comment
>> near the 'fail' label stating that an error code should __not__ be 
>> returned
>> as it will cause the board to hang.
>>
>> Fix the aforementioned issues in the following manner:
>> 1. Probe the parent device before calling cdns3_get_otg_mode() to ensure
>>     that the USB Controller is powered ON and its registers are 
>> accessible.
>> 2. If cdns3_get_otg_mode() returns an error code, instead of returning
>>     the error code, jump to the 'fail' label and return '0'.
> 
> [...]
> 
>> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
>> index 10bc4cabed4..a775567b3bc 100644
>> --- a/drivers/usb/cdns3/core.c
>> +++ b/drivers/usb/cdns3/core.c
>> @@ -461,9 +461,18 @@ int cdns3_bind(struct udevice *parent)
>>       /* Use VBUS Valid to determine role */
>>       if (dr_mode == USB_DR_MODE_OTG) {
>> +        /*
>> +         * Since we perform register accesses in cdns3_get_otg_mode(),
>> +         * we need to ensure that the parent has been probed and that
>> +         * the USB Controller is powered ON.
>> +         */
>> +        ret = device_probe(parent);
>> +        if (ret)
>> +            goto fail;
>> +
>>           ret = cdns3_get_otg_mode(parent, &dr_mode);
>>           if (ret < 0)
>> -            return ret;
>> +            goto fail;
>>       }
> Can you instead move this logic into driver .probe() ? Then you wouldn't 
> need the device_probe() hackage.
> 

There are two users of cdns3_bind() which have registered their own 
.bind() callback as cdns3_bind():
1. cdns3-starfive.c driver
2. cdns3-ti.c driver
Since .bind() is called before .probe(), and, since cdns3_bind() is also 
the .bind() callback of the above drivers, device_probe() has to be 
added here itself. Moreover, it is only due to the register accesses 
being performed by the recently introduced cdns3_get_otg_mode() function 
that we need the USB Controller to be powered ON at this stage.

Regards,
Siddharth.

