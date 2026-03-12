Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E284FFED2F3
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A90583F00;
	Thu, 12 Mar 2026 10:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="JpBvlQpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 987CD83F53; Thu, 12 Mar 2026 10:16:42 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD7E83BC8
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuvpW518iZ8JNvKJO8bSFYczEaZbyiX3Q6Z5aHrU18+fwcEnaOLlyREaguY+8Gsz/YKQ2vaIoESTI1c/v3/bhRyLjqOyE9fXvNmHBtWoVc5DtHFPsrw7XmIoWKGgGJRuhsm6PIGDnJ0cD69DsIlmOCl1NyIKyY/MxmlZy1h71tit76amJ7wuvmu6QY3mGHCNy5/UskvYhWml1wbz2am+R5wV1EWzlnQmBFpKNUIH3fewxQJOf9EW8OOVFmruzC83nzzQISKgVnKywxFn4acVqP0wYExLCzBw8A/6Y0TF0AEwq7CLv5FLjnPxxj8HrT5ctq7lpkyXkwh3Cfy9grKcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZGCMTAIg2lTz09JERDlyQeQulhz38IRozqYuG2g/T4=;
 b=aW9qaOwmE1Ncx73Lm6rzcZQM13iem19CcZiWdsotgAqfH4Mog/vUm774Cj8NAu520qWNVvhFDnYe8rgOp30fkwugsxVKiBJu7JmicwHmcZ0oAqMzDgKhMxdTQ72wWaquxJZFz1r0SdQdo7hbiMjnndjW85HcmAzLeMEZ5hz67dpT2cG8iPPJNZajKqhAHsXMndziBYfO2rEbCnO5pWAgQU2KGgYjqyDtiM5zwqR9/ial4mtuzQSjhca4ccvJq5/JsZ4Ih6yZvbxGKUwhIF6BCxxY3LZdlo2Cso0UEx4VAl0teH32MjaOA79kfHORYMTTJYtK4LbqMYzp3qJKkssZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZGCMTAIg2lTz09JERDlyQeQulhz38IRozqYuG2g/T4=;
 b=JpBvlQpfyerke9WzVWH8kGvTmVLwYoXmH5JkgLvts30Pul0HUQsE3iqfgPi9zVApZVMq4M2Qb3hQuHMv7ciuNIvZ3gQNnrBq0U3UPuIMilZDIk2WRZr9dhlC/VMN7CL7HhFSccryWs9HqXZntqOkOF4nCvqSC27pKPr5yMN+r58=
Received: from SJ2PR07CA0007.namprd07.prod.outlook.com (2603:10b6:a03:505::12)
 by CH0PR10MB5194.namprd10.prod.outlook.com (2603:10b6:610:d9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.16; Thu, 12 Mar
 2026 09:16:36 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::77) by SJ2PR07CA0007.outlook.office365.com
 (2603:10b6:a03:505::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 09:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Thu, 12 Mar 2026 09:16:35 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 04:16:30 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 04:16:30 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 04:16:30 -0500
Received: from [10.24.50.20] (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62C9GRuI2042406;
 Thu, 12 Mar 2026 04:16:28 -0500
Message-ID: <73203527-fae5-4e0c-9b2f-e14b56af00b9@ti.com>
Date: Thu, 12 Mar 2026 14:46:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: j722s_evm_a53_defconfig: Allow configurability
 of MMCSD speeds
To: Tom Rini <trini@konsulko.com>
CC: "Kumar, Udit" <u-kumar1@ti.com>, <u-boot@lists.denx.de>,
 <m-chawdhry@ti.com>, <n-francis@ti.com>, <vigneshr@ti.com>,
 <gehariprasath@ti.com>
References: <20260220072515.143720-1-m-shah@ti.com>
 <08cfa2f8-8fd5-4e82-91f1-7e73d80b8406@ti.com>
 <aaf3f58d-05f9-4b4c-913d-18fe2935279f@ti.com>
 <20260309231556.GA897647@bill-the-cat>
Content-Language: en-US
From: Moteen Shah <m-shah@ti.com>
In-Reply-To: <20260309231556.GA897647@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CH0PR10MB5194:EE_
X-MS-Office365-Filtering-Correlation-Id: df643d11-2e11-467a-ec44-08de80180ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 354iYOX5XzUhwDU67FwBW8VwlxK9rqv6QzjNtkO0CUpS+xQ6ruOd6YjIdU4jLRXkgtfn1beInB5ETbCG5oQMf8gmuj99CuBBdv2HYuPH+iXUmSFnXkmjfo2qlrD5hoeHMhh8AH4iOsQjZaz69yC6l3cLYg4PtJfZKwkY094ukdKXLCVlGgomLWN8hTwaa0YXSzzHRlCyKq3o8CRSGop2mP5Eb0FnxIo8+wuvpkT7Hq47hCKPtLJaoz2QxAfnvYiat3jIaTjZXartFP3+MSaeAs2lX7u6sosFttyp9UcNSOmQA3Ldq+gv4hB8/dbJtcHIpLG5XNcGXZ39fslGae6pODBKRr7f7LH66MboEYS0jttieJnLdgxuBSncrIkUOMbpYgU316WRw+EQbDM1xG6qxgS7A280zrxijGVGiKlwRqHcJP0xXT+h2JmhphFFweQNsTcFmRco6bpJcLhHsHtAxuwD0+m01tbwuvM8KPn/J2uH6CzC7fmAJwHonp6C/vGOj2oSy9TyuIRQIp7jRSt0zK+V1+w6RrZCUACN+f7aQdF5GQSAoxmYGBa9y9U92r6GX8Nd7UMdX5vlZnbUsfddtTwRinIL246owshjBuIAUgI2UEun+p/T2SDe4MfiU2ovlhAO9+ATvXEmCq06w9tD1wOP9RW0hwEZW3LRxtipsD4rHqe+m9tmyOb3By8mgyn/cm91lEN8F8wXfcXLT876o2SzqQe4DZglca5v+2idTdo=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JUvmr8gPl5Itxhh4ESHe5m5cKbrHPYxlYOjM5jKxat9lpNwQGUCd1aG29XgVJCItcp3sQRspOBV0CuQD4/Bc0nDR5ac9oKDWTVamWu8OeJGCgcybBm6H2Pg9InWWM5/86Bk2QnPRlOQb1fpCG7yoAO2LVoCgexf6rcCVs7msPLc0L+bWp5B80no9LDAD6WOMnz8TKPJgQB+HTQPoJjB4eMcUn9WVR03CBDDAyu6x3nI2hkIIZa4O6VFy+jIzMAPciCglJifZqa1bHQsrvXhoy8D22wZG/8yYT8ahSJAHpeUGWd0KeyRi6sVPdeEuY9wQONs2c0s3hSeerZfUwEIQmDm/Xo7A8eCpaoCTu4RWTRK1vR76A0tgGDMBZK9atPgnX6Pdo/DpSRSCq/kwE5X3jOyTE98Yf1G0+4wM2VjR9pg6yniLi9dDBZNncl/IQOBX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 09:16:35.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df643d11-2e11-467a-ec44-08de80180ef7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5194
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

Hey Tom and Udit,

On 10/03/26 04:45, Tom Rini wrote:
> On Fri, Feb 20, 2026 at 03:17:37PM +0530, Moteen Shah wrote:
>> On 20/02/26 14:05, Kumar, Udit wrote:
>>> On 2/20/2026 12:55 PM, Moteen Shah wrote:
>>>> Add config to allow UHS support, in turn allowing to select
>>>> UHS speed modes for the SD card
>>>>
>>>> Signed-off-by: Moteen Shah <m-shah@ti.com>
>>>> ---
>>>> Test logs:
>>>> https://gist.github.com/Jamm02/e8b8b8c95cb62a7145d73f7ef50b2d8e
>>>>
>>>>    configs/j722s_evm_a53_defconfig | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/configs/j722s_evm_a53_defconfig
>>>> b/configs/j722s_evm_a53_defconfig
>>>> index e84670c75ed..24ee293c803 100644
>>>> --- a/configs/j722s_evm_a53_defconfig
>>>> +++ b/configs/j722s_evm_a53_defconfig
>>>> @@ -107,6 +107,7 @@ CONFIG_MMC_SDHCI=y
>>>>    CONFIG_MMC_SDHCI_ADMA=y
>>>>    CONFIG_SPL_MMC_SDHCI_ADMA=y
>>>>    CONFIG_MMC_SDHCI_AM654=y
>>>> +CONFIG_MMC_UHS_SUPPORT=y
>>>
>>> you may need at A72/SPL stage as well,
>> Other J7 boards already have this config enabled in the a72 stage.
>>> and do you think , R5/SPL will need this too ?
>> Any of the K3 devices does not enables this in R5 SPL, though we do have
>> HS400 enabled in the R5 stage.
>> Adding the config should result in a little performance gain I think.
> Is this a function of board design, or a SoC-level feature?

SOC level feature, thought it has dependency on the board to provide the 
right voltage to the card.

@udit, I did some profiling with UHS enabled at the R5 stage on 
J784s4-EVM but I see no performance gain there, likely due to the fact 
that the R5 stage takes up very minimal percentage of the boot time. 
This patch can go in as it is.

Regards,
Moteen

>
