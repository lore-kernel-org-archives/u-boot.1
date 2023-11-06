Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4E7C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 12:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50A886958;
	Mon,  6 Nov 2023 13:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fCeX54eG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBF0B86863; Mon,  6 Nov 2023 13:43:42 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E81F8867E2
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 13:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDsP9k63LdZYK2QkYAddKGfIu7SD16j7mRTu5S39q2Izs6ZtD6modnvpqtBwY2nXbKBDYL1axIgw2bulfT6M1dgDWSzaDSE3kydCAs9f9FO++MxgdHdu54I2d/1BhbaDPU3WUv9PjiPSEDXvsk1GqoKX6g6PMcFohFo5HpZ8GlGPR2rCIKEAUpl3mFHywEiME1K9yfpmoCSZqYPHPsvdeBFDkOL+iXthcA9TiBbIkM9zqpfLvFJPQIPEWsfvxh/hb028wTkXmbfm1eQkbczqDZwpzLQMHE1BsFGXd8wLNUzB6vM8VJCenhovLqgbp5ma3uWPiNgX5JxbQp7l9uiCog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbqWCdXxceQf4m2reF4Y2grq073LUkwDFEie/vaYOug=;
 b=kB2Sj1sey97xQr4mzh3Manu85ECPvPW6Iyra40lFvw/XYS7rvzPGcSJK4aR+K0rIpXfhqPkYYpFADD3sZY/fV3zcg4slt5uxXQh9ruIhZyFidXBYOlpcLGSo1gh1BHKLQGiViunf0X0p+j9th+Mkmln2O9RzvqUupxr54Svj+S1zgnRzkH0a2Hv6/rrEF4/Z7uHyaJZLMYAFruW7kccYB0d8Qrd9PbdCkVZND7F8nMI6msuOsZy2kxgYM16HvScDxk3XCvDNErhhdcRBP/nXpVw5DC15SGkQxyE80SI65hUKjqS6ELnkSrPEt2j/q3yuqOqAzd/tl/WCO0xx/zD30g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbqWCdXxceQf4m2reF4Y2grq073LUkwDFEie/vaYOug=;
 b=fCeX54eGqs2wN1Sbd9Jaj8J/oDC+PJ3BeEpCvCoL57buKp5mpWaHoyidJ8CT4heKKKBRxr9cWjc59ur0lQJuSvjwjFnDPMHGM9bw5iUTAbth2JBJtsozD72PV0BmjuFfqPima72hYt9crLZSc5FCTkXvnkTV91PffE76wC7IeeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.25; Mon, 6 Nov
 2023 12:43:37 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:43:37 +0000
Message-ID: <a476ba61-7979-4fbd-ad04-2cfb2e83e15b@amd.com>
Date: Mon, 6 Nov 2023 13:43:29 +0100
User-Agent: Mozilla Thunderbird
From: Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH] arm64: zynqmp: Fix Kconfig entry indentation
To: u-boot@lists.denx.de, git@xilinx.com
References: <ff28e719de82258c066f1fedae87f88597f367b5.1698302068.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <ff28e719de82258c066f1fedae87f88597f367b5.1698302068.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0024.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: edc84033-9c3e-45c4-8cfd-08dbdec5ff1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHsITRjAZg2MLXFBpPsAz7tl0hsujNopmjkF80rY36StcyXM5ykR4EeW1YZ+EpZTJlpujARz/FBDwdI4uBjh2lEbVz0+ev5a5zTLnbc752Lybs//L3SUzO89uTXovaW/A4S0LPSmjOVHKImzYINzfcLcGp7MRR7qP6mS94kv7RdDJObkSk6dFs7Fmm/mEBWFCG6HnGCpeWNp2uxXF8pFzF6Iz30aYx9FFb6vquACdYalZWfDlpjqb8fHLp1y0clZF5DwlP8aj6zS9mV4TPSiM76noGh9sKfCwMj0Gecwn+RrqrGKPhQFiwIuhrLvAx+CLM8ZXCByzH/DoQXAREe4WbNsMxWas9k7vhO/nOXy7oB+owgBB9Fvr+kvaxtQ+1EPvsctFK0RSLW/bhuI0eYWMWSrrVKxQJrhEsfI8tDDAxkoZTh5UdKCp0RN+PudFdWr4Myq9rOHdDJZsPxiL0FLqeEyKFM03Ov+8J/e2adiIlZlZyhvnR7G+MbrybbCRH9cLGjexwipMhiz25mycic3H+0JBz2dDeih1UEP36iOF3oqtlCZ9tXXEXAPKbll2K9qb61vHp6OoSd/FtcFgexk3eSBmLWkPT0jRYQA1DaUUaChd0wLoMJ0zEJ0XfrB3aNSohrzjlixGMTLgBCZ/RgK6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(53546011)(6506007)(6666004)(83380400001)(6512007)(44832011)(8676002)(6486002)(2906002)(26005)(478600001)(41300700001)(5660300002)(8936002)(66946007)(66556008)(66476007)(316002)(31696002)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUpSOE42V0xPVWlXdkpjYWFmWjM1Smd1UDVqVlB2Z1p1WExnN0xUK3NWcGlx?=
 =?utf-8?B?N2xRWmN5ZVNQamI1RnRwT0tGaU9kOEdBMU9kTmQ3Vzl5WlNESnRkanFia092?=
 =?utf-8?B?TXVXOGhJZ1NlclplRm5vRjkrOUdwbk01NUI1REZ3ei9Jb3JQMURUaFBGTTlI?=
 =?utf-8?B?WEdPTmd2UytPaUUvaG9wbSt4emJweWNSQ2luN2FFQXFWN3FRdmc1UDNVM1RX?=
 =?utf-8?B?T3VrN0hXUHBlemZYaW1LMmVHZVJPV00zeWZ4UHNoNHhQVlkxMHc5WjEvdjdu?=
 =?utf-8?B?UTRvKzdmdVl2MW5wWno1S1FRaVBFcnpVK2srWjk0c2R3MHlPNEZHQ2xvRHNN?=
 =?utf-8?B?Wm5IdHJVdTEyaUFoZktoMXpVd250NGZUQ0tPTU9DNzdWRnFGcG1pMVE2WWlp?=
 =?utf-8?B?ODNuQnQvYjFiT3g2T3BGSWlCdkNkejlkbGJyUnV0SlJxRmFmaEhBTEpxNE1Z?=
 =?utf-8?B?NkZrbGs2K1h0VGltWUF5TDVCc0RIY0hXRCttd3dnVzNYVWI3dXlyd2FoR2sx?=
 =?utf-8?B?aWZqSTNvYUdtU2VxMDBKYlZwV1hsRURPb1UwUlYwci9kdWQ4ZTRUczhMRDQ4?=
 =?utf-8?B?cDZhbjJ2WEVYWXBpNDlkVjZSZWVqM1RkcTBWbVloTFFnMnYwOXd6dG4vZ2lu?=
 =?utf-8?B?UktWcEROQlRralBaQWp6L1Vud3lQbHpvZW9uUjkzMTJXWUM4QzFQYnIvN05m?=
 =?utf-8?B?dUdVaC9hZW1oUzU1ZGgydWxmNFRUbE9kb3VSblh3OWZ1M2lRNW9mbXIrbFBV?=
 =?utf-8?B?U2ZwKzBLQ1dpSGd2TG95d0dqN2xFeVV0a3h4M2pIUmhmbjBkenFQdWtrb09m?=
 =?utf-8?B?WHZrNlB3OGZxTnVENWRITDVVRVYwRUp4Z1BmdG82WERvMlROSE1wLzdDTDh6?=
 =?utf-8?B?akkxUGR1T28zdmhpYVNhU2lPNkRxVldTR0Vmd2pqR0NzbVR3cDJSK2QxL0dl?=
 =?utf-8?B?RDZWaU96RmR1UXpHTnpMY2UwYWllTnlUVG04L3BIRkFoNkFYSXdscnVlaW1Y?=
 =?utf-8?B?bXZGT3A1NGVScjFER1g3dS9tY213bTg4T3p0akI3SVk0YmRHb2JjOUFReERH?=
 =?utf-8?B?RkE3aS9TeXdlM05QVlZvdUptNUd0Z040MDBsellhTnRxRTQ1NXdxTzZYMGpW?=
 =?utf-8?B?WVVYRy9Zci9jb2Y4OUZzR0dWL2ptaTlHNjRXRFJEWlNkUHEzL01qOUp1K3dm?=
 =?utf-8?B?MC9wREVjQmFrcC9RaEp5V1QwWE83Z1BGVTRlaVAwcnBjdTg1MmJuSjZiMWJE?=
 =?utf-8?B?bFJmcGw5VEtSaHJFYlZkQVFHTzljckpRT1JCWktoSlhJS0NDODdmU2I2OWdV?=
 =?utf-8?B?K2ZmYXpQb0pLR0xVVDJNWTJZa0ovWEt5Qjl0QmpTZmcvT1poMXNMMGJoOElL?=
 =?utf-8?B?cGd1bmcraTQ1YWpWUEZGdWNPajkyTXM1MmtTUmc4cVFGV09BWDFmbVljd2FZ?=
 =?utf-8?B?UHdWOVhaOG5qeG14UDNIU2tEcms5ajJsOU9vbVVTNWNBemJLQy9wMlFrbGlF?=
 =?utf-8?B?aWVKNFpyQUpzNnpXb0xWU0V1aWVValR2eExqSG1xbTR6RzNtbVJId3VtWXJm?=
 =?utf-8?B?d2F6NW13alJsOXhYWmpOYVF4dThKRTEvOFZmY1NQeEozb2VLNDFGTUN3WUtI?=
 =?utf-8?B?Q0Fzalp6aG5YRDU1WWg3N09GVmZuU2taZzBzanJNdlhDVzA5cGJDR084cWt2?=
 =?utf-8?B?dzlwL3kyMjZod01hMk55ZlNNWkV2U0UzN3RydC9UTFJmaTZMd2VUOTI4T1gy?=
 =?utf-8?B?bVc2a2kzM004dVRIOXpDYzBqM3B2MVBHcTM2N3Qxazc1ZUpPSlZ6OENUZ0d4?=
 =?utf-8?B?c3c3WVZCZnYxTGRhSThuTTUxa1lXWE5hTHg4WGl6ditCVDRRaVF1NkNvcitt?=
 =?utf-8?B?SGxPaUwrZmY3WFlGK2Z5Ukt3cGlIVElZNFVoSG1LWm9DbG5BOUtjNTBTUTVo?=
 =?utf-8?B?R0t6amphRDE4bjk1VnNROHlSem5NMlFnS0l4R2o4VXZiSm01QXVpcG42YmF3?=
 =?utf-8?B?UGMwSEhZd0NzMkZMeTZQeFgvRFp4T0tYV052K1JBT25UYmRYc0VnZHhlaWE1?=
 =?utf-8?B?TzhFN1Qxd0MxOWdpRFRkdTR6UWVremtFYnJMNGZrUmJOUnVpSy9GSHFMUjJX?=
 =?utf-8?Q?g7JKFB9rgCXYdTPQVIZXtDp0/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc84033-9c3e-45c4-8cfd-08dbdec5ff1b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:43:37.5436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfsfLr/fmKFyMRnxk8DQBgngElQm73szlov4pA3VY7bMDvYDNH6fOBl93WCjWOVP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090
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



On 10/26/23 08:34, Michal Simek wrote:
> Use tabs instead of space for entry indentation which is standard coding
> style.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-zynqmp/Kconfig | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/Kconfig b/arch/arm/mach-zynqmp/Kconfig
> index 26b80b7882c8..7e7c87d16fa9 100644
> --- a/arch/arm/mach-zynqmp/Kconfig
> +++ b/arch/arm/mach-zynqmp/Kconfig
> @@ -100,30 +100,30 @@ config SPL_ZYNQMP_DRAM_ECC_INIT
>   config SPL_ZYNQMP_DRAM_BANK1_BASE
>   	depends on SPL_ZYNQMP_DRAM_ECC_INIT
>   	hex "DRAM Bank1 address"
> -       default 0x00000000
> -       help
> -         Start address of DRAM ECC bank1
> +	default 0x00000000
> +	help
> +	  Start address of DRAM ECC bank1
>   
>   config SPL_ZYNQMP_DRAM_BANK1_LEN
>   	depends on SPL_ZYNQMP_DRAM_ECC_INIT
>   	hex "DRAM Bank1 size"
> -       default 0x80000000
> -       help
> -         Size in bytes of the DRAM ECC bank1
> +	default 0x80000000
> +	help
> +	  Size in bytes of the DRAM ECC bank1
>   
>   config SPL_ZYNQMP_DRAM_BANK2_BASE
>   	depends on SPL_ZYNQMP_DRAM_ECC_INIT
>   	hex "DRAM Bank2 address"
> -       default 0x800000000
> -       help
> -         Start address of DRAM ECC bank2
> +	default 0x800000000
> +	help
> +	  Start address of DRAM ECC bank2
>   
>   config SPL_ZYNQMP_DRAM_BANK2_LEN
>   	depends on SPL_ZYNQMP_DRAM_ECC_INIT
>   	hex "DRAM Bank2 size"
> -       default 0x0
> -       help
> -         Size in bytes of the DRAM ECC bank2. A null size takes no action.
> +	default 0x0
> +	help
> +	  Size in bytes of the DRAM ECC bank2. A null size takes no action.
>   
>   config SYS_MALLOC_F_LEN
>   	default 0x600

Applied.
M

