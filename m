Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD83C25B75
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 14:14:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA4A18837B;
	Thu,  6 Jun 2024 16:14:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AgZHotVN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5F1E881D3; Thu,  6 Jun 2024 16:14:18 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBF028837B
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 16:14:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLdGtONlC66hiRk67Wyd5mJB0mVIWSNe+NI74XXfRJ95vuelvgMhQJKHva56U/xVuqTa5xveUAmr6GSVy3URUcSqa97cRH7b7aUMSZ2D3Kr2Cu2cvJIv9VPiJb7sbt+X10MdxNgnIH9nhVOsZ6NIJx6hSdJhB+i7gvjdzXqF23yNbBLInCtGylQxyINS0ZeFRB+/DqtPw69gUI6b9rPNrJi7PPO540m9Ze/pSMdaSssz98s4djxGdIpzCKDVpdOP8HAw5Kk/P6lEFEL5t30DoBMQqgzhvOsfqXCxYQjOiUXWpKhVKEdU6FPS9L9IOe6CDgm3UaMtlDZDQaPlFNzNdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izQGDtLQJQMw/mEQyi6QHFOjdGcrhu1Axv/12kryKgU=;
 b=eMVUEim3Q35YJuWiojujmXtajRyUnNordyOo34X6G1ltpSMag8676JlbeJfXh3AeAPklyGx7sbRF6DtcdSBfY1jug50WoJMv6V7jfW4bjB0YTIJOEHWeIj3ACiAuWkezP6ZRKMCJ5Qyy8nht64CsbWAgzlY1nIv4j0Gs9FF3xSbaZ6SWznppw1Hehbr1zyyS8ZCqM2Xe865bENeoq9TT1PMC7V5ypIBJHh85razdtpgJiQMW5l0Bd4INNdsyPfIRZL/8/baEy30/VDGhM9ItTi/jE/wL+VUQdLUGg3xbZRLfVbhKohoe8EAkL5V8j3deTI1PZFqRPjhstMFBacfF0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izQGDtLQJQMw/mEQyi6QHFOjdGcrhu1Axv/12kryKgU=;
 b=AgZHotVNfxX1bReK2r98IQ3v/pOdqK8rbtU+kQAewysp/zH1xZK9F9D8fdwvsZeTqyvQnxmX+AEprhSbFt0BX4FGjoeXNZV1GIIlHwLGo+F/3P9v65bjsyS7m/kVW18ioJW0Lx8qNizttPQhTskaR0xjkWN8GTPpWgdEWesS7Fw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 14:14:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.7611.016; Thu, 6 Jun 2024
 14:14:13 +0000
Message-ID: <904c5855-98b7-4b3e-9882-26136a8f3160@amd.com>
Date: Thu, 6 Jun 2024 16:14:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] soc: xilinx: versal-net: Use
 zynqmp_pm_get_chipid() to get chip revision
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Stefan Roese
 <sr@denx.de>, Lukas Funke <lukas.funke@weidmueller.com>,
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>
References: <20240604142741.425307-1-lukas.funke-oss@weidmueller.com>
 <20240604142741.425307-5-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240604142741.425307-5-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::17) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: bcea6454-4fe2-47e0-41b0-08dc8632f150
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1UrYURza1NIcHdXQ2cxcEt3MXRXMWVocDBqR05FT2tlRHJVTHViNi8vRTIv?=
 =?utf-8?B?aUJSS3p2WmZtTkdCdFNPRzkybUdZOEp4eGpZbEZkb1VHM2VFZENTc2ZTMmc1?=
 =?utf-8?B?ejRtMkVEY0JBYkJLTmZTSmJyWmVZUmIzeHQxRnFPQnJtUDNGRVJqTGVxS29J?=
 =?utf-8?B?UHJZK2kyN3hCS1V4MHVRdlo4TTgrWmY2V2FJQVBuRTBzaWRhbXdTc0NGMW9N?=
 =?utf-8?B?THhnQityYmRMQUtvMUxWWGx2Ykp4OW90QVcwQnNKelplSGFxUVhlWjZYK2NK?=
 =?utf-8?B?MStxMmdFT0VqMVd5VExhMWg2QUY1WlB0MzhWVmtITDYrWThodERpVXBEZHRT?=
 =?utf-8?B?ZnlwRHJXQjBDQ09PUW9qVlAvRGZEam1ZR0V6ZjVBdFRDcFpwVFBQTWwra05N?=
 =?utf-8?B?OHVCT0c5bU9OcCtRaGVxSExTNlhWRXlQRlhpd3I5TVNYTEo0YTRpcGhmVkFN?=
 =?utf-8?B?NVpJQ1FyMVg1M2o0OUtKbFVyM0syYTVmTmlKNDJtRFVBT0xCaFVrZFZOZ0Qw?=
 =?utf-8?B?OWI0K21DdHd1RnNLRGdxQTUrN2VCWlZSd0F2dDBlWnRmSlE1WVFmbmtuODFy?=
 =?utf-8?B?QTZEa3dIOGExanBZRjlwc2xMdVJ6QURUM1lIVG4xZTdhYUloZnlxZHhTeVBZ?=
 =?utf-8?B?NXRDZjNhVWxYYks5YVlqU2xTbk1TaVBEcFRiOGczNzZTZlRJUlBmRzV3b2ZS?=
 =?utf-8?B?SkR0VzUySTNYQXZrQjQ4WVBucVFPbmh0Q0I1eHdlQUQ5OTZydEN0V1lJZUVM?=
 =?utf-8?B?YlJKcGxnMzBqenZmaGE3YmxjOUJ3cUh0UUlzRm1yejRuV1Jra2EvTXhhVEd4?=
 =?utf-8?B?Vk42eXNkaUpFa1I2ZkRIRnVJbnQrY0xKMjZwNmcyU3dBeWpqNTFWSzloS2Nt?=
 =?utf-8?B?WnVlbjl4K1QxNVFWcUZUMHVmNVp4cmZoYkJEOEppYkY3Tk9RTmMzQkVwWEg5?=
 =?utf-8?B?bGdSTXBXVG1FWnRoVm54c0lKcWdKWGRrVElsRDZHWEVERjYvUER6QWZzMXZN?=
 =?utf-8?B?TDkzalpBZWRnb3g2NC80Y0Y5bHZIZk42RVROZ0hoNmJRQjY4dEgvcmpKcDZ6?=
 =?utf-8?B?ZTAvbkt3UnY1eDFBeGIvdUVzTVNWRWpuRys5K3VUcjkrS0xDQVVlTUJMT2xw?=
 =?utf-8?B?S3AxczRiM0FNRnNpRG4yWlZSWDlwSldoUURWMnpPc3VIM3dFYVhRUmkzSzhG?=
 =?utf-8?B?VjdXVHlubVJ5Vkp0NVA4c3REcnJ2WFF6UHd3RUFhZUNyeWd4dkNtWUlIRFZi?=
 =?utf-8?B?dXU5a0UzcEdFcldhZDNML2NySU9XczBUQndxM0NsczJCUk1TNnJFSy9ISW1Z?=
 =?utf-8?B?OTZVSHlFenREL3J3bWJYMlFLd2laYW81b1RNMWJ4c2dyV0FSRDZyOFJBZzli?=
 =?utf-8?B?OEtoVDN0R01NRXpSUTNaL05jUDRrdnBJYTdIb0lTRHA0K25jNGoxSDUvcWxE?=
 =?utf-8?B?UzQ1bHZaLzZDdGcyWHIvTjU4Z1dwKytNUTh4c1M5ZUEvS29iaDV1YVF1dmFU?=
 =?utf-8?B?OWFLazIwcDBhdU1NNktVMEZMdXc0NVgrejE1aXNWNnNDYkpuL0pxcGZXZTgy?=
 =?utf-8?B?SkdPOU9jZCs4UzJHeTFteFhRYVhnUnNtVHlBNG41bHI2NGlGSHJMd2djYkJK?=
 =?utf-8?B?QmIwUUpFUURuQnowQnVqN2lJTkF0WFBXa3J0clN3QVRBaURvc2phdDhUQXhI?=
 =?utf-8?B?YS83MXZxWDNTb0NiOXMvRE1ob2tFQ1U1Q3cva2pEMm0ydWxLTENqMkRlQ1Zk?=
 =?utf-8?Q?TYmwwWakzFgtVbipv2OBAvr30JkAp/WavtoRQOL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1FjNm9DU24yWHNnYSsxMW1Ta012RUl1eHdVNlJUbE05THRjNEo2NlN3VWh6?=
 =?utf-8?B?aDNPVEdkTDNkNGtSaWhsamdhZ3MxdStsSXlieW8vejdyaGVtcFVPWlJIVkp1?=
 =?utf-8?B?L0dBV1lUcVRZeHZHOENRb0pGODZ2RXRxaEpaWWVtWEFKYjJDcTRNdkl0R3BW?=
 =?utf-8?B?cVZlMzJ1SkEyZGdvbmhWS1gzSnFPd3U5czJ6QkhqUFpRQnh0bWpoaWtVUTdZ?=
 =?utf-8?B?STJTOHBBSmhqMmpMOEI4b216VTkzcng1Nk9tTWV5T294RTFDWGdzdEdqcktX?=
 =?utf-8?B?aTJYa1hHM2V5YTVrWFE4cm45aGdiWFUyTHNucHgzNjlkOXJxMDBqQW5oUXNK?=
 =?utf-8?B?MEp6TmZVNnl5UTdQaS9GMG01eXlodFZoeVRIdnFCcFB3dmtDcHhwNCtFRGdM?=
 =?utf-8?B?UFlMcVhFLzAvYzhFMlN5VWlHY2cyUlMvZnNwUTM2NzlJSzhFeEViTXh6M1BO?=
 =?utf-8?B?dit2dW9xOG5wdkV2cW9NSFNVN0ZDRTg4Ym1Wb05pRkM4K1puV1NFUENkU3h2?=
 =?utf-8?B?bXFKMnFPMW41TGJmV2hqUU9MemxSZTY4VHE3VG85dy9yQ29BSGR1eFMvTSth?=
 =?utf-8?B?TklpeEs2THgzYnBjNjE5a1lpUDhuUkFha1g0YVpEU21NMm5qTE93TzlIME1p?=
 =?utf-8?B?NzdnblNDMDE2Y0krcHRZOFdHSzJSSE1hSXJIOERGOWNzdkYwdGZRNUg4dGNT?=
 =?utf-8?B?NFF1cTgyaDB2eHRSbEd2dlNhWVJpODBJbUF6WlF3WEd6R2lMMjZmT1IrV1V3?=
 =?utf-8?B?VStKR2NKZXFxQ2dSRTVqL3cvSDlIRm9oZDQ3OTlhU2VGNXlxYjM1c0U5S0dO?=
 =?utf-8?B?c2F5akVtaFVYWTRvdXJaYTk4eEZ5aVhUbmFqWURQUEo2cXNuNDJocUpDellr?=
 =?utf-8?B?bkJzZHRkYUdldG9BMURwZFJnWVNqM3RmNGlCZWVlam1EN01veG44c2hxcHBp?=
 =?utf-8?B?MWFnRUtnOHlYaXNqNDVuMnZNQjZtQWFHQU5EK3M2eHRFSlEwL0NDYmM4cVY2?=
 =?utf-8?B?M1dxampLY255L3NHNXFYd1JKRFlhRkF3dVpHTitzNzQ5V2s1TmFnRFpnK2F5?=
 =?utf-8?B?MTlqY2hPT0pmaUdCZlFZcDh1NjZLK0p2SjBOVENFeFJzdmQ2R0w4akU0TTBw?=
 =?utf-8?B?ZG1FV211YkVzTkY3VVhacnZjTUtPS3FiWlRCYXNqTmNMVmlRQWc4RVcyaGVO?=
 =?utf-8?B?MkVTZ3c2L2l4eHhoSDNQcFlldkpteUQ2MFc5SGovbUNlYXUwbnIweEpZZCtq?=
 =?utf-8?B?Q1B2azk0NWQrdHdvUUdVZEU0NVhhZDU1VGlqY0JYK0ZJejhNSnFuRGJFc1pI?=
 =?utf-8?B?OE9TNXYwcXlNbVlUdXRQU0JHNkFhLzZNVHRlZ3kzNzErdGd6TE5iNUdHdWRI?=
 =?utf-8?B?OWZaWm8rTmUwcVA5ZllPWGE5SlU4QnRndWZkVmZDZkw4cFg2emZqZjRlZmlY?=
 =?utf-8?B?ZUwweDYwVkdGUVVzL210QWNlTGlMbjh3ZkpjQXBOcTBCeW1BUWJxU2xBeUxQ?=
 =?utf-8?B?MmdRNVZYWDZBcTBxZWkva0U1SFh2eUMxWjFIQVpjVVNDc1BhK1FGeG5uQWdF?=
 =?utf-8?B?TDhLWndyc2RaTHRzc1FoSkE4bjRTQllFZzI2amNNczA4aFBSbW5Ia2JUQnhF?=
 =?utf-8?B?VHBqUmgzN1hrejIvU3lnYUZkQ1VDd0ljOENuWVFXdExCRHhQdi8wTWw4SjhH?=
 =?utf-8?B?L2lZaTg0Z0dadXdqQ0N4ZnBTaDF1dnlUUHhZSjd4VEIxakRkNzRxQTdSd2xM?=
 =?utf-8?B?anZubHdBZTZvRUFMcHV2eXhtcDJQa3dpaWRlUHErSmVWNmljcE13VVd1TVZv?=
 =?utf-8?B?eWRKN01YN3VOTVZ2dTUrNVIvU0ZQenJ1MDNUUmdOcXBXcjZib2Y0S05jN0Zw?=
 =?utf-8?B?VVR1Ympla1oxMGlvUm9oMnlxNWxVam5Nb1loaFRFc1BBWmY0eW03WDgzanN0?=
 =?utf-8?B?VzB2V3FiSlZlQ2VYTEw2Q013TmlVVDdSZEpsdXU1UTFZMm83MmE5RHZ3NDlO?=
 =?utf-8?B?ZDhERGZoL1hXVm5CeG16MXVZWVBEQ2NNRHBvRVIvUTFzWm05QUEyQVlUUzhm?=
 =?utf-8?B?VHRpOWVjSEovMmd1TVE0WE4wRFd4WVJiTTVzMTNLeXhwc1M0Q2FSMEg1OHUv?=
 =?utf-8?Q?13Kx0vE1NcuqJWRLYYfWuetom?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcea6454-4fe2-47e0-41b0-08dc8632f150
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:14:13.7099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2AAxkQ5KhB25eaokoOLbV7SyVuUuaFJMWIxdWnyRaGdvnLSr1/ksyxVsrJvA0WS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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



On 6/4/24 16:27, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> Use common zynqmp_pm_get_chipid() function to get the chip revision
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
> (no changes since v1)
> 
>   drivers/soc/soc_xilinx_versal_net.c | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soc/soc_xilinx_versal_net.c b/drivers/soc/soc_xilinx_versal_net.c
> index 146d068bb4a..76467a3bbb5 100644
> --- a/drivers/soc/soc_xilinx_versal_net.c
> +++ b/drivers/soc/soc_xilinx_versal_net.c
> @@ -47,23 +47,22 @@ static const struct soc_ops soc_xilinx_versal_net_ops = {
>   static int soc_xilinx_versal_net_probe(struct udevice *dev)
>   {
>   	struct soc_xilinx_versal_net_priv *priv = dev_get_priv(dev);
> -	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	u32 idcode, version;
>   	int ret;
>   
>   	priv->family = versal_family;
>   
> -	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
> -		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
> -					ret_payload);
> +	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
> +		ret = zynqmp_pm_get_chipid(&idcode, &version);
>   		if (ret)
>   			return ret;
>   	} else {
> -		ret_payload[2] = readl(PMC_TAP_VERSION);
> -		if (!ret_payload[2])
> +		version = readl(PMC_TAP_VERSION);
> +		if (!version)
>   			return -EINVAL;
>   	}
>   
> -	priv->revision = FIELD_GET(PS_VERSION_MASK, ret_payload[2]);
> +	priv->revision = FIELD_GET(PS_VERSION_MASK, version);
>   
>   	return 0;
>   }

Reviewed-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
