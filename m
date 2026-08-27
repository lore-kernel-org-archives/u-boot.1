Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D26C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 20:58:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5376E607E0;
	Thu, 27 Aug 2026 20:58:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZcayhuUkIYlj; Thu, 27 Aug 2026 20:58:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787864302;
	bh=sD2nUPUj/kY5k3FCFqpSYTpPgfO4ChYzn7i6lR4PTKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dRuW+bWUqiFtO0877PgYrcKnHh7LI8d0cksABM3c6Rc8EZY5QVqXu5PaIcEW8ZTiV
	 c1irSydC06MNB6qON4yIy6VM2qtuGWCTBKh22aFWTlfMTERprenglMncJb6vc0Na+f
	 pmOZWnBQ9REEaK224K7xszD4ThehoC5fkFr4kMMlali+KoGyl0fe4ebSvgiLrtqNAo
	 TgSbcg+MCyX/psfQ4HbXOeVk7gRfNzb8QHzFIi6DryitKfKZSmxePfIHgOKdk2xbzc
	 Y0u69AjnQMXSGuYGmU0+TAv+YHj/RKC+A2G03kr3c2ofH64EK2ObqQoxyOg9PnX0UW
	 WwrWgz9kJNYog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 64344607EC;
	Thu, 27 Aug 2026 20:58:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BC28465
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:42:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D8B94075C
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:42:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id N2FGar0OFPFv for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 20:42:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=nathanw@msu.edu; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=pa.msu.edu
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=pa.msu.edu header.i=@pa.msu.edu header.a=rsa-sha256
 header.s=selector1 header.b=Ixm2NTpl
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2263D407CF
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 20:42:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWY5fC+TkhtK6WdGqU3VTWaPgA5vjaMaYgqg53gD9lXBrVYb5njwoQBT32Yimd1cG2f091HZXFLt5PzJi0z839oi+DbWjcUyj3sDT83FNv0I0XV3jm3G7JflICfYpryZiZ8X/H89qwGhyjMUjB0MUu9pXs/3xmdofh9gXZ42ymPyUBo6HUUXThrloX/awKJBgPUvs4Wnn5mrMqZB6882Ka1MlPYFJs/227dF21Fg3Jq0yB6d0U9yS+2pwQ4XB/jLWRlVh7htrkJ7P02nmYY9Kmnf7plAlTYy+rq/47rsb+wWsnGnlBhZft1lzBbMAEw6Qf7WIWhuW2iTdvpiGch1Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD2nUPUj/kY5k3FCFqpSYTpPgfO4ChYzn7i6lR4PTKQ=;
 b=mUAxKV+3pCO0oZkJoUqEvdCAuWZN8qkF5cU5lMqYqrdbcaz6cuMeoFOnVRIMNFVeunTBIa1yxArR47VyWzLhp1UbLqUcQqfFembPujHbLUpMXCoOTQLbEJ/zIqiwsrIs5vWhfCOXOuVskoaM24z/T0QWPIjru/y11GaI6UKxf7GKTVEUfSzMTPnxYbiFM+j1gYnWKtiAwcUTX1l/diLdwspXzzcjV9+tQn9vbkLWOHM96qWD/6nOXRf0k24KNIhy9on8sqCkB5jd21pDm3+GgGEqWhUMdabDTR9p2IgcUs088w9YI5etcrTVF/nrtLEtbgi2fq3J5rxZ4rwv846mdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=msu.edu; dmarc=pass action=none header.from=pa.msu.edu;
 dkim=pass header.d=pa.msu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pa.msu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD2nUPUj/kY5k3FCFqpSYTpPgfO4ChYzn7i6lR4PTKQ=;
 b=Ixm2NTplH7j2j4q83NrNuAEvkZn+BsRPKzB/lzyurZ+sAoJtt3JY4f86KwXTuqgT2NFP6G6HI3OQrDj24DuibQmFchQhXCZ+RpyCl/evmytD4MA5sEOUNuHI+utRX5PzzDxA/Qgz6NW2RSmnLlrS9Vre25ZBDEiGsY9WuyrVzKYb+pWzZ1wtZyMJYaReXLWoLQPzy/R5rQD6+OlFOJ+JCTTCLhaHUJFKO2PCGkveFXePAWhUOGnliZGkvUUpUK7bhMl62A43f48zCuFCFx/HBMAp/Fnm++4Kk2O5AjAx2aBQ8SnUKJPyoGNxw0teU5PeYx3OczLLkcW70pNdd/ewlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=pa.msu.edu;
Received: from DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12)
 by IA5PR12MB999278.namprd12.prod.outlook.com (2603:10b6:208:603::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 20:41:58 +0000
Received: from DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5]) by DM6PR12MB4337.namprd12.prod.outlook.com
 ([fe80::b412:1b80:dfc:18c5%6]) with mapi id 15.21.0339.012; Thu, 27 Aug 2026
 20:41:58 +0000
Message-ID: <efeea694-d25c-4123-a346-d7e79ab29b8c@pa.msu.edu>
Date: Thu, 27 Aug 2026 16:41:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: mpfs: Read and store FPGA design information on
 MPFS hardware.
To: Jamie.Gibbons@microchip.com, u-boot@lists.u-boot-project.org
Cc: tim609@andestech.com, Conor.Dooley@microchip.com
References: <20260818124815.24470-1-nwhitehorn@pa.msu.edu>
 <600f5bbc320e19f9d82ef01dac5077e35a51d471.camel@microchip.com>
Content-Language: en-US
From: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
In-Reply-To: <600f5bbc320e19f9d82ef01dac5077e35a51d471.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0485.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::17) To DM6PR12MB4337.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:EE_|IA5PR12MB999278:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c7e471-4c4a-488c-1a65-08df047ba3de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|786006|376014|1800799024|23010399003|366016|56012099006|10067099003|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 3MSxpNeIBprpEfArSaJsR2CY11thGtwZnnSI/ZdvcxsiqdvVGCsV4K4gchc/R7aAvHgQ4BDZ9BtmVVMj1dSzxi56OEaEepXFQlyvj/73lfhpS8koQ6ri/RMZ21F7oiwiB0+ufhCVlZXW8iroSabxvDT9nicaWHhF1tAjDJRqGAMuIvj+Qcq6pFMLe4zIA1ruf9/iIb+zHCSQP/T/36TM9tKSKf7dqdR5IioTzFtX0d3g/kmUvo8EpmME4gCsRNX/3gPhK7xSi/GYliNZUxiKHQLaQInzTImV4ZHQ9vwSAEjLVFdLATC9xJ1Z4xRHh1h0wywTcDy2DwZahdLU7SVCBJwJfGtPoI16u595wvz5+8DyHm/znzUBg4eFxv8msINe2xK6VM8lOCvVgQKTq48LCHAP/GZ/gyJ5WXFXhm5BBSzNsMhf9Jgq9ZdE5L1r4vkqeVGblIY6vvwKGbm9Kwt6aZhtvnUTBAz+R0/B2IPwzdyphRsyQyz0nvYG/IyiRmliwNL4INeECbr6osd/AZQkOLuw5iK5MU8UjWleP3dk1dh/HUz6zu+afBaFerZ6yksu9SnMwuDGdlpt0OmG5Y+F3zkgVo8VqaF294noa+PV1MUZUnqiy1CoetmTSOMBuss24tF7bbIYacYaOAvaOVmBLxUktsK4o859DyzTxOgi2t8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(786006)(376014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q21hRVBkQkU3Ry9oTlZMUzYyOXNzWGVGZzJqWFlJeXNiZUp5UTlKTTNDUUtV?=
 =?utf-8?B?YjA5a2ZWcDNDNWx4NExNM0pIbk9udkVvT1lOc1pHV3cwMk1LZnpVd1pheTcx?=
 =?utf-8?B?ck5FblhnV3B0akVuOEx0amZIb29tbVYxb09ETllHNVlZOFZibHlNdjFBMkVu?=
 =?utf-8?B?T2dQVzRFL1FOb29MdW5xR3hmUVdkNVlwWVJBaTl3OVlZdk5ySForclNPaUsv?=
 =?utf-8?B?eDZMTUh4SXZ2T0N3TFNqbVFLcWNDYkVtNHd4K1VmbnpRbnVZenA0Wlp2L1JC?=
 =?utf-8?B?ZzVNMlluTm1GcHlaMWYwTTU2SzRPL0gxT0lTaytoU2dzKzNjeEtyamlEK1Zx?=
 =?utf-8?B?Z1lzVkgzUjk2dGg3eFJCUnQxVS9ka0UxTGtERHRvWnpPMXJwbXBwOThwNjVa?=
 =?utf-8?B?OElQQkt2NGgzSVlqR0hCUE1ScWVpYU9vekxSV0wrRDRmdjdZODdRR2pOQ0Nh?=
 =?utf-8?B?V1d0eHorWlFWRFhUZGR5RXlxT0tLeHlUcnlvSVQwczFiMlU3R3RCRFhEc00z?=
 =?utf-8?B?K2liVXIwOVp5d1VvZzZHTGc1MVdXcFNQNnlSdUx0bFRPWlpJQVlOa29wYk0v?=
 =?utf-8?B?bVNrRTBmcHRUeWFoWks3cEZBdlU5YXRFeEplMTZlQ3hvVDZwdXRabnZiVVEw?=
 =?utf-8?B?SXo5WERRY2VNa1lIUGQ0VVgra01DMzNvaUNQc0kwaURpVmM1SFYwY25FV0Q3?=
 =?utf-8?B?R2dkZ1pQRUFTcERuMmZIMlc1U095eVZzUDU5dHNLc0M2RzAvMDlCOUk0eVVv?=
 =?utf-8?B?cGxCQWd2NzJ4citSVVNuQWNkU0dKaXBPZ0pQa0VFeDRVcE9WZE9UU1NUQm5N?=
 =?utf-8?B?L3daS0lWSkFIRmhMdi90K0RoV0RVYzNzWVE5SlYwM1JkZVZOdWpMMHQvcXEw?=
 =?utf-8?B?OHlCN1BXd0hiMG10a2Fra3h2aHZXaGFhU1R4bEVXOGNrNEZlN3JnYlF3MlBO?=
 =?utf-8?B?ejI3eGxad1RrK3JKWTE1VmlvbjZlN2dsam1rYmk3ck9SYWU2NXAzR3pIT2lN?=
 =?utf-8?B?ZlFXWEE5Z3VuRDYvamxBMnNQWERLUmphUGFCTU5JZlVTbkFpTmJvSnFPRVRV?=
 =?utf-8?B?cElydzNvV0h5UDljQ2FDbXZmN09XSTNmcytQS21SUjhJbEJqOFRFZElWOFRv?=
 =?utf-8?B?M1BKKzFBWTRCcFVtL09tQy9mTzcxKzhFbGkzaTRCQjNNMUJ0N3pZNUlESzhC?=
 =?utf-8?B?OVYyZHc3d0tja1dFVG9uTmdJNU1EZVFIVTUxVlVncmFUd09Bd3pYL0NoaVhs?=
 =?utf-8?B?RnV2M0xsSmlwMFdqendZQWpjNzhHWGg0WXMwNVpIY01iUFQreVY5TXViQ2Jl?=
 =?utf-8?B?Y0x3UDVoUTNWM3JKZEhOQkRZVFFGMWdDZmZkTXhhQXhQS01RQWVwY1JxcjhZ?=
 =?utf-8?B?RngzZzZyZlViQnAwTVA2QmFTSmxPSUdObE5IcThvYkdPSFdFRVc3Qk1ZdWVY?=
 =?utf-8?B?Q1dGWXFwbXJFbXF4SnJBdU9VT3JxWmtwbFZUNndqQUsxWW81Ty9iQ3czb3hi?=
 =?utf-8?B?YjZvTmt1MlcxQytNdUpraTZiMzRtWjJEUThpTVE5dzFLNXV6alYzbTVHNUNi?=
 =?utf-8?B?TjB2OStyVzBqSnRvTFZZZi9peHdxUXlnOGpNbnNEVTlKY3VUZytWb3ZrbHdK?=
 =?utf-8?B?ZVV6TUwyUFFMTVJPcXVFM2R0eXBlcit1aStUUUdQTURxSnRVVFB3TXhmamxr?=
 =?utf-8?B?V2pYZEF0N081SFhZTWNFd0dpQVpKeVdDQWtpUjFMbFZYQTZvcFM3d2tCU0pr?=
 =?utf-8?B?bzd5SWFiL2trV1pXai94bVdvOTY2dVVLOWFnN1krL1AyWXBuQUJySyswZnd5?=
 =?utf-8?B?NG5MNUZ5NG9vd3JNK25SMkR6OXhwVU9oQmhjYkd4Wng0ZlphTXQ3VUhBMVNh?=
 =?utf-8?B?dlAyZTgwU1ZTb1ZJLzVFRzQxMHBGMW5rMVI5MHg4NmZnVCtXZHpMa2QxUHVl?=
 =?utf-8?B?YTlFMFZEZG5XVEtPOTZETXVNa3FualFnUHliVisvVWVBMzYyM2U1N1EzT0V2?=
 =?utf-8?B?dkQvRkcyT1VLZW9aQlVHLzV1TllpRG9IeFozZGJpdmw1VFp3aUFUU0ZLa0RB?=
 =?utf-8?B?QmYyU1QreDBLM2JZVGdTeGdvank0aUl2UURjcHBUb2psY004a3JaQlVXbkRo?=
 =?utf-8?B?SWpaY295dCtGNUpIYUlIYzdDejZsSnEwV1FManVHTm55dnRhWkZUZ0FhMHla?=
 =?utf-8?B?TjBYT08vSFFpeXM1R1BvalBXTVpmUXIvT1drTzZFcEpEQS9hbTRLZ096Mmhn?=
 =?utf-8?B?MUJQOHRNZ2diMFZNd1YzYXo1UWRvVjFnQWZHeTQ3WVhZVTFGbE1oRHdnRThY?=
 =?utf-8?B?WW81Qjd4V0pCLzBhVmZmTXpuM3Y1UHpESlJKS05Jb2xTd1JxcG05QT09?=
X-OriginatorOrg: pa.msu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c7e471-4c4a-488c-1a65-08df047ba3de
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 20:41:58.8003 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22177130-642f-41d9-9211-74237ad5687d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lKvDAl4veOxQwSx9ECrcDjOiTm1VY/coDyrCAlaFSqT23ogCkaXDEy90w+Oulb85
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999278
X-Mailman-Approved-At: Thu, 27 Aug 2026 20:58:20 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org



On 8/21/26 11:24, Jamie.Gibbons@microchip.com wrote:
> On Tue, 2026-08-18 at 08:48 -0400, Nathan Whitehorn wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> When working with systems with multiple FPGA firmwares, it is
>> sometimes
>> useful to be able to use the same U-Boot and script conditional
>> behavior
>> based on the FPGA firmware ID and version number. This, allows, for
>> example, flashing new FPGA images without flashing the bootloader and
>> letting U-Boot and the Linux kernel adapt appropriately.
>>
>> This does two things with the information:
>> 1. Prints the FPGA design ID and version to the console as part of U-
>> Boot
>>     startup, which is helpful to a human working with the board.
>> 2. Stores the same information, plus the already-acquired FPGA serial
>>     number, in a new set of environment variables (serial_number,
>>     design_id, design_ver [the version], and design_backlevel
>>     [minimum-version backlevel]). These can be used in a U-Boot script
>> to
>>     load different kernels, device trees, etc. depending on the
>> currently
>>     installed firmware, which allows U-Boot and the kernel to adapt
>>     cleanly to FPGA firmware updates that change accessible
>> peripherals
>>     etc.
>>
>> Signed-off-by: Nathan Whitehorn <nwhitehorn@pa.msu.edu>
>> ---
>> Changes for v2:
>> - Rename environment variables to remove the pf_ prefix
>> - Remove portions of the patch that added properties to the device
>> tree
>> - Style changes
>> - Rebase after a5f93037f28624c612288e2d97604d73e03af5a3
>>
>> Thanks to Conor Dooley and Tim Ouyang for helpful suggestions.
>>
>>   board/microchip/mpfs_generic/mpfs_generic.c | 26 ++++++++++
>>   drivers/misc/mpfs_syscontroller.c           | 54
>> +++++++++++++++++++++
>>   include/mpfs-mailbox.h                      |  2 +
>>   3 files changed, 82 insertions(+)
>>
> Hi Nathan,
>
> Happy with the patch other than Conor's styling suggestions and one NIK
> of my own seen below..
>
> Other than those:
> Acked-by: Jamie Gibbons <jamie.gibbons@microchip.com>
>
> Thanks for the patch.
>> diff --git a/board/microchip/mpfs_generic/mpfs_generic.c
>> b/board/microchip/mpfs_generic/mpfs_generic.c
>> index f57f5f4046b..4423dd1e38c 100644
>> --- a/board/microchip/mpfs_generic/mpfs_generic.c
>> +++ b/board/microchip/mpfs_generic/mpfs_generic.c
>> @@ -114,7 +114,10 @@ int board_late_init(void)
>>   {
>>          u32 ret;
>>          int node;
>> +       int idx;
>>          u8 device_serial_number[16] = {0};
>> +       char serialstring[33], designid[33];
>> +       u16 designver, designbacklevel;
>>          void *blob = (void *)gd->fdt_blob;
>>          struct udevice *dev;
>>          struct mpfs_sys_serv *sys_serv_priv;
>> @@ -144,6 +147,29 @@ int board_late_init(void)
>>                  return -EINVAL;
>>          }
>>
>> +       /* Store design info and serial number in environment */
>> +       memset(designid, 0, sizeof(designid));
>> +       memset(serialstring, 0, sizeof(serialstring));
>> +
>> +       ret = mpfs_syscontroller_read_design_info(sys_serv_priv,
>> designid,
>> +                       &designver, &designbacklevel);
>> +       if (ret) {
>> +               printf("Cannot read device design information\n");
>> +               return -EINVAL;
>> +       }
>> +       for (idx = 0; idx < 16; idx++)
>> +               sprintf(&serialstring[2*idx], "%02x",
>> device_serial_number[idx]);
>> +
>> +       env_set("serial_number", serialstring);
>> +       env_set("design_id", designid);
>> +       env_set_ulong("design_ver", designver);
>> +       env_set_ulong("design_backlevel", designbacklevel);
>> +
>> +       printf("FPGA Design name: %s\n", designid);
>> +       printf("FPGA Serial: %s\n", serialstring);
>> +       printf("Design version number %d (backlevel %d)\n",
>> designver,
>> +                       designbacklevel);
>> +
>>          /* Update MAC address with device serial number */
>>          mac_addr[0] = 0x00;
>>          mac_addr[1] = 0x04;
>> diff --git a/drivers/misc/mpfs_syscontroller.c
>> b/drivers/misc/mpfs_syscontroller.c
>> index b9aea7e1181..07a788db76e 100644
>> --- a/drivers/misc/mpfs_syscontroller.c
>> +++ b/drivers/misc/mpfs_syscontroller.c
>> @@ -152,6 +152,60 @@ int mpfs_syscontroller_read_sernum(struct
>> mpfs_sys_serv *sys_serv_priv, u8 *devi
>>   }
>>   EXPORT_SYMBOL(mpfs_syscontroller_read_sernum);
>>
>> +/**
>> + * mpfs_syscontroller_read_design_info() - Use system service to
>> read FPGA design info
>> + * @sys_serv_priv:     system service private data
>> + * @designid:          30-byte string name of top module in FPGA
>> logic design
>> + *                     NB: null termination is not guaranteed
>> + * @designver:         version number of the FPGA design
>> + * @backlevel:         programmed minimum allowed FPGA design
>> version
>> + *
>> + * Return: 0 if all went ok, else return appropriate error
>> + */
>> +int mpfs_syscontroller_read_design_info(struct mpfs_sys_serv
>> *sys_serv_priv,
>> +               u8 *designid, u16 *designver, u16 *backlevel)
>> +{
>> +       unsigned long timeoutsecs = 300;
>> +       u8 data[36];
>> +       int ret;
>> +
>> +       struct mpfs_mss_response response = {
>> +               .resp_status = 0U,
>> +               .resp_msg = (u32 *)data,
>> +               .resp_size = sizeof(data)};
>> +       struct mpfs_mss_msg msg = {
>> +               .cmd_opcode = 2,
> Could you put this as a define at the top of the file with the others
> instead of having it hardcoded here please.


Thank you! That's a good point and is fixed in the v3 I am about to send.

On this one, I will also note that the existing serial number service 
has as its opcode "CMD_OPCODE", which seems uninformative. It might be a 
good idea to rename it in the future. I haven't touched it for now.
-Nathan

>
> Thanks,
> Jamie.
>> +               .cmd_data_size = CMD_DATA_SIZE,
>> +               .response = &response,
>> +               .cmd_data = CMD_DATA,
>> +               .mbox_offset = MBOX_OFFSET,
>> +               .resp_offset = RESP_OFFSET};
>> +
>> +       ret = mpfs_syscontroller_run_service(sys_serv_priv-
>>> sys_controller, &msg);
>> +       if (ret) {
>> +               dev_err(sys_serv_priv->sys_controller->chan.dev,
>> "Service failed: %d, abort\n", ret);
>> +               return ret;
>> +       }
>> +
>> +       /* Receive the response */
>> +       ret = mpfs_syscontroller_recv_response(sys_serv_priv-
>>> sys_controller, &msg, timeoutsecs);
>> +       if (ret)
>> +               return ret;
>> +
>> +       debug("%s: Read successful %s\n",
>> +             __func__, sys_serv_priv->sys_controller->chan.dev-
>>> name);
>> +
>> +       if (designid != NULL)
>> +               memcpy(designid, &data[2], 30);
>> +       if (designver != NULL)
>> +               memcpy(designver, &data[32], 2);
>> +       if (backlevel != NULL)
>> +               memcpy(backlevel, &data[34], 2);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL(mpfs_syscontroller_read_design_info);
>> +
>>   static u16 mpfs_syscontroller_service_spi_copy(struct mpfs_sys_serv
>> *sys_serv_priv, u64 dst_addr, u32 src_addr, u32 length)
>>   {
>>          int ret;
>>

-- 
Nathan Whitehorn (he/him)
Associate Professor
Department of Physics and Astronomy
Michigan State University
Biomedical and Physical Sciences 3225
East Lansing, MI 48824
(517) 884-5563


