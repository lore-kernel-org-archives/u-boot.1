Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5834C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 16:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31678869CA;
	Wed, 13 Dec 2023 17:01:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bz/U5Z1C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94BD2869B6; Wed, 13 Dec 2023 17:01:09 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA93D86F28
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 17:01:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7WduJWgncKA1CbQuPf7yRPN7izVAw8r6VfrHt2TKpPHmMd04cy8iqMGqJKzUai+rALS/VmuBF4/3tTi6NPEcBw3R/6YRi8HzWj+EwxjbruMeVQK/JgTnkgd/teaM0VbtWZSdoM2aJiinGNlNXROzwZjsI1YOYHbg7xOpW9fBqqQ0YTxI5mgx19/2QRNVLh8Ur9bfXyVDg3nsi5y/B6UHD6CVFg4iPtQ/3ugNhN8nVt/u5/IH+T4ndoVrP7vsaLeFAplEKn6a+8FCzFDnV7e8Q/c5LCFqPCpCeK/HVuQmnnRh7yA0hE3/g+DyVZPsNAFVwwqEK9f4zrgSMBDc9j/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GDIuSok+DJMD2yKORrcGC7c+GvBOH0M5fN7yJwppXw=;
 b=h/ikCUvnHo5YtR3fAFjy97P2N7RcZJIp+gtg3K/XS78RwikTPD07NUNRfrUkIhC5xMbhB3iGQ4Y3KEGRdwihfm6HJDKr8IeeEKnBf5iIy0D+C8juv/R8MYHUty27SSJLBL0519kcuh6fsUGCYRQahXQhmQ02itdwCF1sRNR+yQ3Fxl/iz93ZEk3Xd5ayyqaSR0Bwrbt+rPnEye9+yrNX6VZW+7xW6sCsHodx8W8MvGrjXtCbdhYzDxtGoYamJLm2Eg9utf0EcZ6AuHWYBUz88RX9cFCNQcPM1UORypLccRObaElx/2xxLR3VanYgpn5W7MmPmN+ZbueTIIbjxICILQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GDIuSok+DJMD2yKORrcGC7c+GvBOH0M5fN7yJwppXw=;
 b=bz/U5Z1CY9ZLBvNvfKS7tzwVURn/eOfm6vS+0C6d4BSL+yP1YPTSLZK5pjZ1QY6Cb9xzIpYoHNHuKfa4+7HNhIk++56WELZG2kRSgevVHoUCRsSQ8Qbxq30EEK2IIzNYFmVIQOrQQHzSmvoePLbOgOMWp6m8X0Xy2PS6zxzttMQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:00:58 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:00:58 +0000
Message-ID: <00a14e3c-8fad-427f-a41a-ced59e863b27@amd.com>
Date: Wed, 13 Dec 2023 17:00:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] arm64: zynqmp: Add output-enable pins to SOMs
Content-Language: en-US
To: Neal Frager <neal.frager@amd.com>, u-boot@lists.denx.de
Cc: luca.ceresoli@bootlin.com
References: <20231213134052.2818879-1-neal.frager@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231213134052.2818879-1-neal.frager@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0009.eurprd08.prod.outlook.com
 (2603:10a6:803:104::22) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6262da-0780-4ff5-a27c-08dbfbf4b215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wMv72jcdoa5uGHJsn6ISDTn9vOnonUdkTq9cr2XOCn262jJjZxXr5Z0y6q0RjcDbjxnLdJiT+EWz5xk3zUx/srq68M5UwA9TtDyf/Z/tF3T6nJQa0JaXKK6jUvvRlim/bKOFv/Zrg1vyySgYqbrn+bD3IHXrJzS+kg2xaqRmG7gSuVBpDwDIwfnjaAxjS72bAlR2ZPTfHQMIKZobb6gN8NE6/7s399YS4bP1ZgnTmbCiQ1Kjw046l6T4u6v9im8LQMQeN5cQHnD+/ntGz0eRCCa3bWxJPaTFBoxBKs0J0SDSdgPmKyJXTTf17OZUXYLvnODizs1f6S5Ydl6SzE+ACER8W2XLnGK7Ml+rXzUx42WCH36nycVUklMH0bxe/NzGvUqWH6OM6mriWtjHg3FGH2kh/SOcZIEPiufuhXPN4PDb+wiLSrieUX8yxf1nOXrQSCF6oKwRs7YgZzFM1nL+SBufKozs22nVKKcwHfapvwClpVNljLhEI7AmyLlP6mWjkFKJpSZN3AxTz8599e91dCcZKPrYg2fkAMvEZRhVFe5ivc6iFokNxN6RFGBYWJMTpRyAoNcGe1QWsd7XUm4tvV3VoAbBbOPtl9kZ/DQWL3BoK63a80KS/DArLHZHmK2e5PQq+KLknLhRc2dH0j0muA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(31696002)(36756003)(86362001)(2616005)(6666004)(6512007)(6506007)(66946007)(53546011)(41300700001)(66556008)(6486002)(38100700002)(26005)(2906002)(8676002)(4326008)(478600001)(66476007)(5660300002)(44832011)(8936002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBnS0xyRmVnUWxDcHF6V0lvdmFEaGlQd1pSS3JnSW0zbHZsNXhvY2YwUjlM?=
 =?utf-8?B?dmU4cGdBSFdkN1FGK3RDcTFwZnRweEFOajY3Vzl1MU5oNVJlV0pRMjRTOUsx?=
 =?utf-8?B?WDYxV2dmREVqSWEyY3FvajltVGEra0JkT2tVM3NsYXVINjNoY3hSaWpKSVNU?=
 =?utf-8?B?YUNmdklDV3dqVExTWWFiV0lKazM4dUtNZDNGSDROSzBUR3Y2NC9nNUxNQkgw?=
 =?utf-8?B?ZWg0MkhiVlN3dHN4bVBLbWg0alVDalYyZWJrOTBNd2dHOWdseG9USXhQeEF1?=
 =?utf-8?B?bEJJNmdoQkNtQ2RDejVZT21WK2FCNUdtd21oMHFsUmVqTGwzR0o0bXVuVVRZ?=
 =?utf-8?B?ZURncSs0aXA4ZGU2S0NkbVlnVTQ2S1ExaTFrb1gyem5QQ2FWQmh4QzEvUjBB?=
 =?utf-8?B?N3NTRXpBM1FxS2VIYStIOWhqMXZrWTl4c1pPQUVETFRTQW9QRHJNeFVyREcw?=
 =?utf-8?B?dWZZWUR0dXNqNlIwZlcyYm5EakdSaE1EVktUSWFUaFBpVFNuWW9aOUFVdmRP?=
 =?utf-8?B?WkMvUDhZNURxTmo1T1RPdUJCclN1QXVzYXpqZU1vdUJvRllNOXE5bjVsN2Fi?=
 =?utf-8?B?Sy9DTTgrdnVaY2RGbWNGTFlWSVE0ZXM0eHIvQS9EcS9JSnBabmNNV3VNNU11?=
 =?utf-8?B?ZTNWcEE2SXhDcHZzTXE3V3BZQzMxS09LMkRhY1I4a3RHSHAwWHhrVXBTNG1B?=
 =?utf-8?B?Vk5lbVpqWVN2M1JFYnVraU43VnNndHJETjhlTDZBYzhGSkZ0US8zNE51L3pm?=
 =?utf-8?B?bmNuQ09VR2ZER2tSYkpwemNiRVR4L0hwU2lwYUhzVGNzK01SYjk5N3dBTjU0?=
 =?utf-8?B?YTZRejVKZ2xUWU9Md3czM2Jwc2RzWnd5OW5SN0liZ1hXZEJxNmg1cFJSbjVo?=
 =?utf-8?B?S053VHI1MGhwZDRIMkFaak1xNGw4SEpXZkRSekVJWlVJYWFzMHl6Q1czMzI0?=
 =?utf-8?B?RisvMHJreFVDckFkdG9XME5qeVVpTC84a0FRMmZSV2xCbW1tODlDbldFMm55?=
 =?utf-8?B?RnM2ckJOdlBoMHVzV3lEcGwzQTZoQ2xYR2NQRmV1WCttaWVxazd3M0FPd0dH?=
 =?utf-8?B?c0FlT1lNU1A3eDJYZ1BuVGVWVm5Fa1Iwc2N4MUVMNU5KY3pCWG1Ed2YxNWVK?=
 =?utf-8?B?NzZOYmxNTjB2T1c4aktBS3VTUXdBMnBHTDFCUGRVWk15TEJVMmlDdG95R0ZJ?=
 =?utf-8?B?NEhEcEJBMkc1VEpEZGp0UFo2RHFSZm9FMXNXeUlERTlKblBUOExUUE85NkpE?=
 =?utf-8?B?WFZCRlp0WFVjN1lkV29SVU9FQUloaXJYOGRjeWoxS3BodVVFK09PYVhMbkxE?=
 =?utf-8?B?bFFhVmw3Nzc4Mk1mVUVXSnBxRUFNSWpES0pWcGhQM3NTQTByWG5YTVB4T3BB?=
 =?utf-8?B?OHpCa3lEV0JjeUlCSUpEeEsyN1YxMVFMT2xEek5rR3ArU0IrbllGSWd6L1pP?=
 =?utf-8?B?SWgrSmpjQ0tRZUhPSTFidk5ibTg4Q0NYN1p4TUljbGUzTHZkVko0d2w4UEFa?=
 =?utf-8?B?WWZCamtaQk9uUnRialp4Rnp3eHh4cnNIVUtiVmJTQXlEQWdnR3ZCNHNBa3ZR?=
 =?utf-8?B?NmduVS8yMWxNVWVCZVlXWm1valRRMk5jOUhWWXZtZTN4RldZYWNvVjdRSWth?=
 =?utf-8?B?L1h1L2d1YUtwcFBPU2wvTVBOSUZIUkQ5WU4wYkJtVGpQcFk3NmRmdHdLcUtx?=
 =?utf-8?B?bC9BcGN1REU5TWJUcTgvNC9iYTJRc3F3aUhXTmVwdWxFZEwrMW1hQ0lXekc5?=
 =?utf-8?B?eHV0MlFwbkFwMUdFYTBqUEYxMWNyODc1TEZMa2E4Nkc0UjZMNTBjTFFSN21K?=
 =?utf-8?B?bkhBbFhpK3BMalNIM2h6dTZwTEozWm43angvbEMyMENJZ0dwQVFpRUhmbjFI?=
 =?utf-8?B?VjZqZXMyNW1odUVKNlJ0RzFhK0oyM1FwS1UxNHUzZWJTTVJuUk5hTFBsZzdI?=
 =?utf-8?B?aEdBUU1LTG52NldpdXU2WDlKcmcvSWMvNklKdTliQU1HTzh4M0NLdDNwRERt?=
 =?utf-8?B?aU1oWXFtRW85amxiOHNwVkpnSDd2bDJJVllBdk5kMlB3Tzdib20xVnRhYWt0?=
 =?utf-8?B?dFl4NCtFRU1KSUxKSXZwRk1icmNVMW9uNm55bTkyUmpEMUx5UEllT2dDZkdH?=
 =?utf-8?Q?7neoRd1UwGKLxiPgYZkY8nVlT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6262da-0780-4ff5-a27c-08dbfbf4b215
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:00:58.4202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhbyBE8vjl089WeFCLobhR6WRclVu+wAOCWOltpH/gJbl0n8pwWwU6eJf9prSMhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
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



On 12/13/23 14:40, Neal Frager wrote:
> Now that the zynqmp pinctrl driver supports the tri-state registers, make
> sure that the pins requiring output-enable are configured appropriately for
> SOMs.
> 
> Without it, all tristate setting for MIOs, which are not related to SOM
> itself, are using default configuration which is not correct setting.
> It means SDs, USBs, ethernet, etc. are not working properly.
> 
> In past it was fixed through calling tristate configuration via bootcmd:
> usb_init=mw 0xFF180208 2020
> kv260_gem3=mw 0xFF18020C 0xFC0 && gpio toggle gpio@ff0a000038 && \
>    gpio toggle gpio@ff0a000038
> 
> Signed-off-by: Neal Frager <neal.frager@amd.com>
> ---
> V1->V2:
>   - remove output-enable from gem1 conf-rx pins
> ---
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dts | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
> index 56f3128528..12865392a3 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dts
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dts

This file never gets to upstream because it was merged as dtso.
That's why I think you are not using the latest tree for this patch.
Can you please rebase and send again?

Thanks,
Michal
