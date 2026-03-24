Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EAAD58CCA
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 12:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0126280517;
	Tue, 24 Mar 2026 13:51:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pXKmQqFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5D8382A9E; Tue, 24 Mar 2026 13:51:16 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4ECBA80087
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 13:51:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQuUUT+ZAe6FHIO4xUoHGRghxodnu0jS/X9HUYQqrpwzvhrhzsPn4xF+KyPIHEihIyssDYFml8YMRxfc/N/ZzmTXW0uGka87IzTzhnKmS+hy+BKbqdCGgqp7t7NP8S2hW/huYiCiGDlL3q/DUGZ1w3UpnRpdDBEj3vTnKiIPsx1YgTpdAF0+k+jGm3zh2/VDWLmfldjoCjQiOxqdGPqhX0r68679NYfiYShaZADkPQAyvfkRJSq4qB1HLJmPFfOLJ8TP5yV9GnVw7p/vOJJcxKuU+v9h8jQyYx+9jjxTbzY9bXBpzO5bInVz3Xeh0jFhwb94ylOese1x64J2XBeRZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssIySOWhUsRBATsbDOsa8lsN3QswmG8RPHTA3ouK/EA=;
 b=C9Qpn2KJpw9nCvGvuYVIW3TsYAlLYTF2qiyd8Yqn27UuQxMmaenqwPPWP8dgG5k/2/+koinhSeJMCaZRVWiGPuu3S4Ia0uqAUw3ArZBWp2kATEuMvp8dBCXNv8TRXF2I3zWrH/9sUyaETaVNbdbE7/knGvWS3AaWkuYvyjsIMMuy2Y+pb52wrVuN+rCg07x5YaPXD1ejSNHd/wfnshw6cTeNngH70nDI9rcRlHXe90MDz5flh0mVN9Tjr/1zwTFBucIdVx12KK2mgHMDFW0RZJOzvcFisljVb8YPAS0BlMGKX94xbRZZp7NHKopEqhCRrZ0RwxEvtSIb3ERCqqUy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssIySOWhUsRBATsbDOsa8lsN3QswmG8RPHTA3ouK/EA=;
 b=pXKmQqFBQNd1RYXY8eYWuDPZXmlAoNIIBL3merOiOJ6X+6n9G4O9k+K7urFV+l5qoooFCAqAXXcerqR5hVfzNo08XQauuLUlxd+pnvRVn2LNQj64RFjsdBOTE+Q1FGpGOVO/Q3t4NatFLRcRIGopZ/egSgzQGQOUr28bEmCVwGU=
Received: from SJ0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:a03:39f::10)
 by CO1PR10MB4449.namprd10.prod.outlook.com (2603:10b6:303:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:51:09 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::38) by SJ0PR03CA0215.outlook.office365.com
 (2603:10b6:a03:39f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:51:07 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 07:50:49 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 07:50:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Mar 2026 07:50:49 -0500
Received: from [172.24.233.249] (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62OCojl92171824;
 Tue, 24 Mar 2026 07:50:46 -0500
Message-ID: <d0c3446b-2d74-4072-b0ea-14cbd495931d@ti.com>
Date: Tue, 24 Mar 2026 18:20:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: ti: am62dx: Separate resource management config
 from am62ax
To: Anshul Dalal <anshuld@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <bb@ti.com>, <afd@ti.com>,
 <nm@ti.com>, <v-singh1@ti.com>, <sparsh-kumar@ti.com>
References: <20260318073010.786006-1-p-bhagat@ti.com>
 <DH7BS8C2L3NF.PWXS36TL07GT@ti.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <DH7BS8C2L3NF.PWXS36TL07GT@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|CO1PR10MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f75040e-7f19-48ab-82c8-08de89a40491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: l92Fy2SRUQEpOCfiRIIdS/NTpy1+qmOrs1EdoE/mJHx1ACs5O3wBBNQKf/LR0JpMy0d4fHSwS5XhP6gqDODy7LRuZLa84U0pMhEmhmRf++DehNEigJa5UGpkrv9ZLfQlndqIOrKdL8E3/CpZZdiIXRLXfjl6xFBZlqjVn3IC4L1zIl/k6+r4JnVLk2Fp6wOiLj2Y94Qb7HgJp0xG2lzgoKQ8z1k2V4cji1YvwbjzjL2Y4yyyk0xwWAGXMVNsAsDnwkVDDfnqHSE0dDxkiqtxuiMliKyO3SRoiR3nsoSHGMXgrdKGeagtPg/17EWVmuSWXDTxSVThbMcbsyZYCEIOi3iUM1+W2ZuE56VtzMx9V/A+zpUMNdJx5ViBqO1nTFIOh+zAWsMg7KnSDrP8h5JOfy6fTrg65vakCM+XYo8h4S8Ay4Kjz6bYHFCmaTEAbhYVAf9ViRnOIyuP52ewbWd4DFY/wYJg/p12d4lUFT2WawJkyE7MAXHidf62Op2xtyaMz6Um2je6jFzVS8BhVDF7YZSCAoBxgCTWPYIstzBRr05TUBLQ8LMNhmSUMYsfuLD9qBQntl7Jp5tg4Y4rsPGT9n7LhdAUcai+Q9AaCkw7ZiNRMbgFRlUwFtsVovvGTX78ICH22BRSiefYKewM5b4dFs0WGvZzOQkktywEH+RIQuMBqd7cnIzv0AD/GQ6Um20yUYgHRSbEOw5HRFGE0GpwqxYCIdJNFR6VyxKwetA3VvQ=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(13003099007)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UrAfmv4eJm9j0u10eeywj7ZP2dMhqfMfOnzrkOLwf6sfTnoyhkvvHzt91k6W1MrEEuxXDB9qPuaZ3ai9ptzLwgezfM1l66ADIUtjW0tawwPlcmevqx84zERCNW3c73WmBPUUJt6MDhWZeb9h4pqAesk/iaO3ZhIeKxJcKNlL1LZ15kkJcdE66JllCMbDMac0u1bC8aF0dXYqtzyQyp+ZwaX3AHYjQ2scIsV40+J9GYWis4NfGF+Es2MbrGmTXafC9J1OMJLx/NIqbnKLG+qzlJNw347fpfmqc6D+Gb5VpX+dEhOgYVdUntMGa7gy4X2ZpoF12MoX/5aE3DdM6EJatJWBb1oxs4rGVEHRxsJ2Bz9kh8COGaLZt5gyaTlxdGI6doDsVqhs0iEV/wvo977X7Cb1LUjSuTBpKAa93elMuywOTZlEj6m4Jd8/b01GS7hV
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:51:07.6141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f75040e-7f19-48ab-82c8-08de89a40491
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4449
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

Hi Anshul,


On 20/03/26 10:00, Anshul Dalal wrote:
> On Wed Mar 18, 2026 at 1:00 PM IST, Paresh Bhagat wrote:
>> AM62d currently shares resource management configuration files with
>> AM62a. However, AM62a resource management needs to be modified for DMA
>> resource sharing scheme for CPSW3G Ethernet functionality to support
>> multi-core traffic handling.
>>
>> Add separate AM62d-specific resource management configuration files to
>> decouple from the AM62a changes and maintain proper resource allocation
>> for AM62d.
>>
>> Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
>> ---
>> Patch link for AM62a changes
>> https://lore.kernel.org/all/20260224120557.1476390-2-s-vadapalli@ti.com/
> The rm-cfg and tifs-rm-cfg for AM62d after your patch differ to the one
> for AM62a even without the above patch as follows:
>
> 	% diff board/ti/am62dx/rm-cfg.yaml board/ti/am62ax/rm-cfg.yaml
> 	2c2
> 	< # Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
> 	---
> 	> # Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> 	4c4
> 	< # Resource management configuration for AM62D
> 	---
> 	> # Resource management configuration for AM62A
> 	19c19
> 	<                 -  # 1
> 	---
> 	>                 -   #  1
> 	26c26
> 	<                 -  # 2
> 	---
> 	>                 -   #  2
> 	570c570
> 	<             num_resource: 496
> 	---
> 	>             num_resource: 497
>
> 	% diff board/ti/am62dx/tifs-rm-cfg.yaml board/ti/am62ax/tifs-rm-cfg.yaml
> 	2c2
> 	< # Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
> 	---
> 	> # Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> 	4c4
> 	< # Resource management configuration for AM62D
> 	---
> 	> # Resource management configuration for AM62AX
> 	27,33d26
> 	<                     host_id: 20
> 	<                     allowed_atype: 0x2A
> 	<                     allowed_qos: 0xAAAA
> 	<                     allowed_orderid: 0xAAAAAAAA
> 	<                     allowed_priority: 0xAAAA
> 	<                     allowed_sched_priority: 0xAA
> 	<                 -  # 3
> 	40c33
> 	<                 -  # 4
> 	---
> 	>                 -  # 3
> 	46a40,46
> 	>                 -  # 4
> 	>                     host_id: 0
> 	>                     allowed_atype: 0
> 	>                     allowed_qos: 0
> 	>                     allowed_orderid: 0
> 	>                     allowed_priority: 0
> 	>                     allowed_sched_priority: 0
> 	247c247
> 	<             resasg_entries_size: 880
> 	---
> 	>             resasg_entries_size: 872
> 	260c260
> 	<             host_id: 20
> 	---
> 	>             host_id: 35
> 	290c290
> 	<             host_id: 20
> 	---
> 	>             host_id: 35
> 	320c320
> 	<             host_id: 20
> 	---
> 	>             host_id: 35
> 	350c350
> 	<             host_id: 20
> 	---
> 	>             host_id: 35
> 	380c380
> 	<             host_id: 20
> 	---
> 	>             host_id: 35
> 	410c410
> 	<             host_id: 20
> 	---
> 	>             host_id: 35
> 	432c432
> 	<             num_resource: 26
> 	---
> 	>             num_resource: 34
> 	437,442d436
> 	<             start_resource: 32
> 	<             num_resource: 8
> 	<             type: 1802
> 	<             host_id: 20
> 	<             reserved: 0
> 	<         -
> 	444c438
> 	<             num_resource: 35
> 	---
> 	>             num_resource: 36
> 	450c444
> 	<             num_resource: 35
> 	---
> 	>             num_resource: 36
>
> Looks like this delta is due to the commits 7f9c2a6f7be7 ("board: ti:
> rm-cfg: Update rm-cfg to reflect new resource reservation") and
> 587b1a56752f ("board: ti: am62ax: tifs-rm-cfg.yaml: Add C7x resource
> allocation entries") that are only part of the next branch as of now.
>
> Is this intentional? If not, please resend a v2 based on the updated
> configs from next.
>
> CC+: Sparsh (Author of the above commits)


Thanks. the changes were based on master. I will send a v2 based on next 
branch.


>
>> Boot logs
>> https://gist.github.com/paresh-bhagat12/f111073108536dfdc9a2c6bc3c401a26
>>
>>   arch/arm/dts/k3-am62d-evm-binman.dtsi |   16 -
>>   board/ti/am62dx/rm-cfg.yaml           | 1047 +++++++++++++++++++++++++
>>   board/ti/am62dx/tifs-rm-cfg.yaml      |  909 +++++++++++++++++++++
>>   3 files changed, 1956 insertions(+), 16 deletions(-)
>>   create mode 100644 board/ti/am62dx/rm-cfg.yaml
>>   create mode 100644 board/ti/am62dx/tifs-rm-cfg.yaml
>>
>> diff --git a/arch/arm/dts/k3-am62d-evm-binman.dtsi b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> index 41c8746cf08..423b599dee7 100644
>> --- a/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> +++ b/arch/arm/dts/k3-am62d-evm-binman.dtsi
>> @@ -11,10 +11,6 @@
>>   	config = "board/ti/am62ax/board-cfg.yaml";
>>   };
>>   
>> -&rcfg_yaml {
>> -	config = "board/ti/am62ax/rm-cfg.yaml";
>> -};
>> -
>>   &scfg_yaml {
>>   	config = "board/ti/am62ax/sec-cfg.yaml";
>>   };
>> @@ -35,18 +31,10 @@
>>   	config = "board/ti/am62ax/pm-cfg.yaml";
>>   };
>>   
>> -&rcfg_yaml_tifs {
>> -	config = "board/ti/am62ax/tifs-rm-cfg.yaml";
>> -};
>> -
>>   &pcfg_yaml_dm {
>>   	config = "board/ti/am62ax/pm-cfg.yaml";
>>   };
>>   
>> -&rcfg_yaml_dm {
>> -	config = "board/ti/am62ax/rm-cfg.yaml";
>> -};
>> -
>>   &bcfg_yaml_sysfw {
>>   	config = "board/ti/am62ax/board-cfg.yaml";
>>   };
>> @@ -59,10 +47,6 @@
>>   	config = "board/ti/am62ax/pm-cfg.yaml";
>>   };
>>   
>> -&rcfg_yaml_sysfw {
>> -	config = "board/ti/am62ax/rm-cfg.yaml";
>> -};
>> -
>>   #endif
>>   
>>   #ifdef CONFIG_TARGET_AM62D2_A53_EVM
>> diff --git a/board/ti/am62dx/rm-cfg.yaml b/board/ti/am62dx/rm-cfg.yaml
>> new file mode 100644
>> index 00000000000..b9148e0d710
>> --- /dev/null
>> +++ b/board/ti/am62dx/rm-cfg.yaml
>> @@ -0,0 +1,1047 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
>> +#
>> +# Resource management configuration for AM62D
>> +#
>> +
>> +---
>> +
>> +rm-cfg:
>> +    rm_boardcfg:
>> +        rev:
>> +            boardcfg_abi_maj: 0x0
>> +            boardcfg_abi_min: 0x1
>> +        host_cfg:
>> +            subhdr:
>> +                magic: 0x4C41
>> +                size: 356
>> +            host_cfg_entries:
>> +                -  # 1
>> +                    host_id: 12
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 2
>> +                    host_id: 20
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 3
>> +                    host_id: 30
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 4
>> +                    host_id: 36
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 5
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 6
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 7
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 8
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 9
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 10
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 11
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 12
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 13
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 14
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 15
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 16
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 17
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 18
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 19
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 20
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 21
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 22
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 23
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 24
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 25
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 26
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 27
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 28
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 29
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 30
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 31
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 32
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +        resasg:
>> +            subhdr:
>> +                magic: 0x7B25
>> +                size: 8
>> +            resasg_entries_size: 1064
>> +            reserved: 0
>> +    resasg_entries:
>> +        -
>> +            start_resource: 0
>> +            num_resource: 16
>> +            type: 64
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 4
>> +            type: 64
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 4
>> +            type: 64
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 20
>> +            num_resource: 22
>> +            type: 64
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 16
>> +            type: 192
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 34
>> +            num_resource: 2
>> +            type: 192
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 2
>> +            type: 320
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 2
>> +            num_resource: 2
>> +            type: 320
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 2
>> +            num_resource: 2
>> +            type: 320
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 4
>> +            num_resource: 4
>> +            type: 320
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 26
>> +            type: 384
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 50176
>> +            num_resource: 164
>> +            type: 1666
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1
>> +            type: 1667
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 18
>> +            type: 1677
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1677
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1677
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 24
>> +            num_resource: 2
>> +            type: 1677
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 26
>> +            num_resource: 6
>> +            type: 1677
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 54
>> +            num_resource: 18
>> +            type: 1678
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 72
>> +            num_resource: 6
>> +            type: 1678
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 72
>> +            num_resource: 6
>> +            type: 1678
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 78
>> +            num_resource: 2
>> +            type: 1678
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 80
>> +            num_resource: 2
>> +            type: 1678
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 32
>> +            num_resource: 12
>> +            type: 1679
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 6
>> +            type: 1679
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 6
>> +            type: 1679
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 50
>> +            num_resource: 2
>> +            type: 1679
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 52
>> +            num_resource: 2
>> +            type: 1679
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 18
>> +            type: 1696
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1696
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1696
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 24
>> +            num_resource: 2
>> +            type: 1696
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 26
>> +            num_resource: 6
>> +            type: 1696
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 18
>> +            type: 1697
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1697
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1697
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 24
>> +            num_resource: 2
>> +            type: 1697
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 26
>> +            num_resource: 2
>> +            type: 1697
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 12
>> +            type: 1698
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 12
>> +            num_resource: 6
>> +            type: 1698
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 12
>> +            num_resource: 6
>> +            type: 1698
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 2
>> +            type: 1698
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 20
>> +            num_resource: 2
>> +            type: 1698
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 6
>> +            num_resource: 26
>> +            type: 1802
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 32
>> +            num_resource: 8
>> +            type: 1802
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 35
>> +            type: 1802
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 35
>> +            type: 1802
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 168
>> +            num_resource: 8
>> +            type: 1802
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 14
>> +            num_resource: 512
>> +            type: 1805
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 526
>> +            num_resource: 256
>> +            type: 1805
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 526
>> +            num_resource: 256
>> +            type: 1805
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 782
>> +            num_resource: 128
>> +            type: 1805
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 910
>> +            num_resource: 128
>> +            type: 1805
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 1038
>> +            num_resource: 496
>> +            type: 1805
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1024
>> +            type: 1807
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 4096
>> +            num_resource: 29
>> +            type: 1808
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 4608
>> +            num_resource: 99
>> +            type: 1809
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 5120
>> +            num_resource: 24
>> +            type: 1810
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 5632
>> +            num_resource: 51
>> +            type: 1811
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 6144
>> +            num_resource: 51
>> +            type: 1812
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 6656
>> +            num_resource: 51
>> +            type: 1813
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 8192
>> +            num_resource: 32
>> +            type: 1814
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 8704
>> +            num_resource: 32
>> +            type: 1815
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 9216
>> +            num_resource: 32
>> +            type: 1816
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 9728
>> +            num_resource: 22
>> +            type: 1817
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 10240
>> +            num_resource: 22
>> +            type: 1818
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 10752
>> +            num_resource: 22
>> +            type: 1819
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 11264
>> +            num_resource: 28
>> +            type: 1820
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 11776
>> +            num_resource: 28
>> +            type: 1821
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 12288
>> +            num_resource: 28
>> +            type: 1822
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1
>> +            type: 1923
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1936
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 64
>> +            type: 1937
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 64
>> +            type: 1937
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 83
>> +            num_resource: 8
>> +            type: 1938
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 91
>> +            num_resource: 8
>> +            type: 1939
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 99
>> +            num_resource: 10
>> +            type: 1942
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 109
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 109
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 112
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 115
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 118
>> +            num_resource: 16
>> +            type: 1943
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 118
>> +            num_resource: 16
>> +            type: 1943
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 134
>> +            num_resource: 8
>> +            type: 1944
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 134
>> +            num_resource: 8
>> +            type: 1945
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 142
>> +            num_resource: 8
>> +            type: 1946
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 142
>> +            num_resource: 8
>> +            type: 1947
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1955
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 8
>> +            type: 1956
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 8
>> +            type: 1956
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 27
>> +            num_resource: 1
>> +            type: 1957
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 28
>> +            num_resource: 1
>> +            type: 1958
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1961
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1962
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 1
>> +            type: 1963
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 1
>> +            type: 1963
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 16
>> +            type: 1964
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 16
>> +            type: 1964
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 20
>> +            num_resource: 1
>> +            type: 1965
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 35
>> +            num_resource: 8
>> +            type: 1966
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 21
>> +            num_resource: 1
>> +            type: 1967
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 35
>> +            num_resource: 8
>> +            type: 1968
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 22
>> +            num_resource: 1
>> +            type: 1969
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 43
>> +            num_resource: 8
>> +            type: 1970
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 23
>> +            num_resource: 1
>> +            type: 1971
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 43
>> +            num_resource: 8
>> +            type: 1972
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1
>> +            type: 2112
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 2
>> +            num_resource: 2
>> +            type: 2122
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 51200
>> +            num_resource: 12
>> +            type: 12738
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1
>> +            type: 12739
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 6
>> +            type: 12750
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 6
>> +            type: 12769
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 8
>> +            type: 12810
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 12288
>> +            num_resource: 128
>> +            type: 12813
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 3072
>> +            num_resource: 6
>> +            type: 12828
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 3584
>> +            num_resource: 6
>> +            type: 12829
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 4096
>> +            num_resource: 6
>> +            type: 12830
>> +            host_id: 128
>> +            reserved: 0
>> diff --git a/board/ti/am62dx/tifs-rm-cfg.yaml b/board/ti/am62dx/tifs-rm-cfg.yaml
>> new file mode 100644
>> index 00000000000..254e8115314
>> --- /dev/null
>> +++ b/board/ti/am62dx/tifs-rm-cfg.yaml
>> @@ -0,0 +1,909 @@
>> +# SPDX-License-Identifier: GPL-2.0+
>> +# Copyright (C) 2022-2026 Texas Instruments Incorporated - https://www.ti.com/
>> +#
>> +# Resource management configuration for AM62D
>> +#
>> +
>> +---
>> +
>> +tifs-rm-cfg:
>> +    rm_boardcfg:
>> +        rev:
>> +            boardcfg_abi_maj: 0x0
>> +            boardcfg_abi_min: 0x1
>> +        host_cfg:
>> +            subhdr:
>> +                magic: 0x4C41
>> +                size: 356
>> +            host_cfg_entries:
>> +                -  # 1
>> +                    host_id: 12
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 2
>> +                    host_id: 20
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 3
>> +                    host_id: 30
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 4
>> +                    host_id: 36
>> +                    allowed_atype: 0x2A
>> +                    allowed_qos: 0xAAAA
>> +                    allowed_orderid: 0xAAAAAAAA
>> +                    allowed_priority: 0xAAAA
>> +                    allowed_sched_priority: 0xAA
>> +                -  # 5
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 6
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 7
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 8
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 9
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 10
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 11
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 12
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 13
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 14
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 15
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 16
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 17
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 18
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 19
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 20
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 21
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 22
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 23
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 24
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 25
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 26
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 27
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 28
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 29
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 30
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 31
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +                -  # 32
>> +                    host_id: 0
>> +                    allowed_atype: 0
>> +                    allowed_qos: 0
>> +                    allowed_orderid: 0
>> +                    allowed_priority: 0
>> +                    allowed_sched_priority: 0
>> +        resasg:
>> +            subhdr:
>> +                magic: 0x7B25
>> +                size: 8
>> +            resasg_entries_size: 880
>> +            reserved: 0
>> +    resasg_entries:
>> +        -
>> +            start_resource: 0
>> +            num_resource: 18
>> +            type: 1677
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1677
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1677
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 24
>> +            num_resource: 2
>> +            type: 1677
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 26
>> +            num_resource: 6
>> +            type: 1677
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 54
>> +            num_resource: 18
>> +            type: 1678
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 72
>> +            num_resource: 6
>> +            type: 1678
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 72
>> +            num_resource: 6
>> +            type: 1678
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 78
>> +            num_resource: 2
>> +            type: 1678
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 80
>> +            num_resource: 2
>> +            type: 1678
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 32
>> +            num_resource: 12
>> +            type: 1679
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 6
>> +            type: 1679
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 6
>> +            type: 1679
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 50
>> +            num_resource: 2
>> +            type: 1679
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 52
>> +            num_resource: 2
>> +            type: 1679
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 18
>> +            type: 1696
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1696
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1696
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 24
>> +            num_resource: 2
>> +            type: 1696
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 26
>> +            num_resource: 6
>> +            type: 1696
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 18
>> +            type: 1697
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1697
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 6
>> +            type: 1697
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 24
>> +            num_resource: 2
>> +            type: 1697
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 26
>> +            num_resource: 2
>> +            type: 1697
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 12
>> +            type: 1698
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 12
>> +            num_resource: 6
>> +            type: 1698
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 12
>> +            num_resource: 6
>> +            type: 1698
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 18
>> +            num_resource: 2
>> +            type: 1698
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 20
>> +            num_resource: 2
>> +            type: 1698
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 6
>> +            num_resource: 26
>> +            type: 1802
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 32
>> +            num_resource: 8
>> +            type: 1802
>> +            host_id: 20
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 35
>> +            type: 1802
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 44
>> +            num_resource: 35
>> +            type: 1802
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 168
>> +            num_resource: 8
>> +            type: 1802
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1024
>> +            type: 1807
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 4096
>> +            num_resource: 29
>> +            type: 1808
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 4608
>> +            num_resource: 99
>> +            type: 1809
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 5120
>> +            num_resource: 24
>> +            type: 1810
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 5632
>> +            num_resource: 51
>> +            type: 1811
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 6144
>> +            num_resource: 51
>> +            type: 1812
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 6656
>> +            num_resource: 51
>> +            type: 1813
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 8192
>> +            num_resource: 32
>> +            type: 1814
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 8704
>> +            num_resource: 32
>> +            type: 1815
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 9216
>> +            num_resource: 32
>> +            type: 1816
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 9728
>> +            num_resource: 22
>> +            type: 1817
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 10240
>> +            num_resource: 22
>> +            type: 1818
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 10752
>> +            num_resource: 22
>> +            type: 1819
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 11264
>> +            num_resource: 28
>> +            type: 1820
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 11776
>> +            num_resource: 28
>> +            type: 1821
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 12288
>> +            num_resource: 28
>> +            type: 1822
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1936
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1936
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 64
>> +            type: 1937
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 64
>> +            type: 1937
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 83
>> +            num_resource: 8
>> +            type: 1938
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 91
>> +            num_resource: 8
>> +            type: 1939
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 99
>> +            num_resource: 10
>> +            type: 1942
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 109
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 109
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 112
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 115
>> +            num_resource: 3
>> +            type: 1942
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 118
>> +            num_resource: 16
>> +            type: 1943
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 118
>> +            num_resource: 16
>> +            type: 1943
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 134
>> +            num_resource: 8
>> +            type: 1944
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 134
>> +            num_resource: 8
>> +            type: 1945
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 142
>> +            num_resource: 8
>> +            type: 1946
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 142
>> +            num_resource: 8
>> +            type: 1947
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1955
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1955
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 8
>> +            type: 1956
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 8
>> +            type: 1956
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 27
>> +            num_resource: 1
>> +            type: 1957
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 28
>> +            num_resource: 1
>> +            type: 1958
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1961
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1961
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 10
>> +            type: 1962
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 35
>> +            reserved: 0
>> +        -
>> +            start_resource: 10
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 36
>> +            reserved: 0
>> +        -
>> +            start_resource: 13
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 16
>> +            num_resource: 3
>> +            type: 1962
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 1
>> +            type: 1963
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 1
>> +            type: 1963
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 16
>> +            type: 1964
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 19
>> +            num_resource: 16
>> +            type: 1964
>> +            host_id: 30
>> +            reserved: 0
>> +        -
>> +            start_resource: 20
>> +            num_resource: 1
>> +            type: 1965
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 35
>> +            num_resource: 8
>> +            type: 1966
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 21
>> +            num_resource: 1
>> +            type: 1967
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 35
>> +            num_resource: 8
>> +            type: 1968
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 22
>> +            num_resource: 1
>> +            type: 1969
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 43
>> +            num_resource: 8
>> +            type: 1970
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 23
>> +            num_resource: 1
>> +            type: 1971
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 43
>> +            num_resource: 8
>> +            type: 1972
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 1
>> +            type: 2112
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 2
>> +            num_resource: 2
>> +            type: 2122
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 6
>> +            type: 12750
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 6
>> +            type: 12769
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 0
>> +            num_resource: 8
>> +            type: 12810
>> +            host_id: 12
>> +            reserved: 0
>> +        -
>> +            start_resource: 3072
>> +            num_resource: 6
>> +            type: 12828
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 3584
>> +            num_resource: 6
>> +            type: 12829
>> +            host_id: 128
>> +            reserved: 0
>> +        -
>> +            start_resource: 4096
>> +            num_resource: 6
>> +            type: 12830
>> +            host_id: 128
>> +            reserved: 0
