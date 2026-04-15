Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0430DF419A4
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 13:08:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64D6583B99;
	Wed, 15 Apr 2026 15:08:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pS14fJi0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5287F83C2B; Wed, 15 Apr 2026 15:08:14 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6E2783936
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 15:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEc0S3CTGp1EmS0l7i6gL/16eIhksMY9h26335mbf5d/U+pxMU6ULAE1thOfZQSrCV1Ew91qwWUSq8zm3KbVrUMQQlarXD6wRRJuycTtPjk5ZNqntiQ0387Jdo51+4H2sGzmgo/+CMit3+cX3HUoSiUZCoBipMsrsCmO9EtWWGoZEjvsGoPMf4ie7kSXL3mvJVWya9g0YFYV95GgzacubKX3wWDozR+DzPUD+S6KwcFYd4WNi+VkGGrt6JM93kiXm2ugI2AOkRnsjNehgK7C5RiOz4BH1zYCtFBovNEwiTR6+Pc2IV72doAt/IB2jZkxh1QrAfIa57KdkSBBw/LaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhhKpu7aSsN4h6Ge7drQ4UcEqTHB1ly0xYFMWXAgIMg=;
 b=ibPFALycEKtQP2pQxv+V7P5s3T6C7DToH00V+zuTKptkf50+tFcRYRL+KCNjoNwYYhFPuYTujDPlGI51+ZBglhjho3VBa4IT/oD/UtltzMFQYHSYNiTfnoe7BgoiL5EeRmIWh+v+49fma7rNSPnRGXOS3rt94r5bbEZhtIsl0tbL7V9NqYSIEqm7Iod+hyTklZR9fnLhXV/07sHJemzmk9hveyaLtXC7vR65UhZkn/21WV4AaCI5V7D6BxIWA208u9dhh4Mfx3CARXWlKlUTClnFQ+w8m68TCfsyjlD4aspMUaHgRyIXgm0A9lyw5LIdfjO9LTbxAnyi81fNY1jr/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhhKpu7aSsN4h6Ge7drQ4UcEqTHB1ly0xYFMWXAgIMg=;
 b=pS14fJi01nDgiE0939z2HbsXAj2NelJLV+9p044zg72cpTPVWmYZMwvr71J932vfYhVLg/oaG+2pSErpMDPfNaIv2j+W4sKLUd/nZrc41y3dAO2L/N6W0g1u9pCFdCAXzCgl9Me6jepC0a5ER7bqqHL21ydFJ8wujpUJHZP82bI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7864.namprd12.prod.outlook.com (2603:10b6:510:26c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 13:08:06 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 13:08:06 +0000
Message-ID: <813cd37d-28b0-4707-a4ad-08612a4b989a@amd.com>
Date: Wed, 15 Apr 2026 15:08:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: xilinx: zynqmp: Add support for new ZynqMP devices
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: =?UTF-8?Q?Frank_B=C3=B6wingloh?= <f.boewingloh@beckhoff.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <330098196cc84115899ea7a14665a8df7e279fae.1775557948.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <330098196cc84115899ea7a14665a8df7e279fae.1775557948.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::15) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b60e207-140c-4b4c-a5b4-08de9af008cb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: brHnvhf0Y/ncuer+9wZ3nJ2UA56JSVJADY8FS5HSess1mSirSpGoZzhAiIVuR1VejjhxgMUxq70bcfh+CfoM+jsvigsR4cPQFNfq1PTIHQd858m8G13bly4g3jT7Cj4ls5uJAxtR5o6cizu2wbvRjJflZI1xyKIZWlXVTWj7CWrVKok+It5nv8kG9WCGLZlCbwKaUsAiYWJeAtoA90NhWUF0VuJWK0aPwx2js/g3auiqxuSxivH8mEiCfxymjbtsubgWca2PkGpldnmDufkjLYe9o4G1U+1u9oAt2F1Y1TGJWxW2zoO4BPZ/FdUzzroutvnVX7gYVeYl593+NJXGOmjpS38YmzorUeNeel+sxUGqBjJhLU5hm1WnVMYDuPB5skkMfP5FMKHgL8yHitXCmAmk6TM3X7gYAYN6ozV4nKWEN9qABBDyzr/U9baiBSUJScmxiue8+Og5b5pHuQh1owWeibdiQyM52Tfy6RM3R7mI1jZ/vZUsutxBPA13G/iaEettiwg+Uo2oOefhZDJuITFD+FXbP4Hf7vmLCis6mlfx6iJRKr6FYTuf7rBRrXwWT1BhNYO242UuowtcaG2I4OOjYhGk8I4u2/1idVn5hFIp9BObb+wRQWqoA0NuyjONW1dMrJWD0h+Hvxs9WWdguECmq+bgYEkPH2eEJid8WHk7y003ejd+6tz+oLjpzAup0nU1ChoSDsnBPjFhlIuG1nqaoCiPR00kghAbtBFN4G0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBFMVpZZTBOZTVGMm1Sb0VVVVJTUjh5eWV5VlQ4dThaNkdnS0I5Mnd3RVpI?=
 =?utf-8?B?b3BObVJYY0JFOHNWRUt6VllYY3l5Z0ZVTXVTS2FhcHFQU1grSm12ZWxSTWVw?=
 =?utf-8?B?cVhUNGtrYURkM29wY0l6b2FyZGlubEZPWlZqT3o4cUZpcVZ4cEJaSzVmOGtY?=
 =?utf-8?B?U0lmOXBzTk1HWlB2cis3L3oxaXV3SWdFRXgzdks5UFR6dFgwZU8zQitpY1dv?=
 =?utf-8?B?Vm8zTEdVeEpUOEdydWNGZmFhNU5IdFJNNWpocXN0OWFaaEdyRHlEbGN6M2RW?=
 =?utf-8?B?djE1ZzgxN3l3NkUrMUg3bHJFMjg3YzJaK000ZVBDY2l5N05PRG81dGJCN2Vu?=
 =?utf-8?B?Wnkvem9mWXVwOCtHRG1tWFRqek1tVVFWSW1Ld1ZrSmc2akl2UW5TU1IxZys4?=
 =?utf-8?B?RTVEWktUMTFCcHl1cTJyS21DNWFNZlErVjBscWtUOU1xZWRnRkU2OURpdDFz?=
 =?utf-8?B?eXhEL0lOaFN2TXFPTUh4azM1eHFqeGU1bXhoYmFSS2szbElQSEdoVW5jSzBr?=
 =?utf-8?B?ZkZjblNjcWRyemgwOUVZWjJrSG1jL0Z1QjUrSkYzMkcvdXRLL0V4bG44SjZs?=
 =?utf-8?B?dFViVnE1WWV6NFBidE15OXVMMVJVSjNPUXEvMGRucnRkSGJOdnpRSjlmNjcr?=
 =?utf-8?B?S2JEKzlkQkZ5Qk1SQlBzSDVYNm1ZTjI1TzViYjkxa3RPZVJaMW9qUFJ1SkhL?=
 =?utf-8?B?MSszc0poREJHR3g3L01sbzdFQnVyV0tDYlh2NFRNbklTNDBENGZDVmJ2NHJL?=
 =?utf-8?B?blpBZ2EvR1BhbHJuOFI0dndORFU5QU1GK2grcXcxckJQZlJkM01MK09UUHBI?=
 =?utf-8?B?MnRGNmJpV2d1RE56MTBiNTFhaTlya2s2TlRsZWxNZzRuU25sVmthNlZ0eFRB?=
 =?utf-8?B?SlpNbE80Z284SHZvM2hwZnVwQjVSUEFDY1p0RG01UC9TU1FFTEZOV1d6ZnEv?=
 =?utf-8?B?T05YZVVYMW41bmFBd0dCeE41VWdzc2hpMnhpaHYyWXhtUE5pT3ZlNXg4NWM5?=
 =?utf-8?B?NFFJSWRsODEyR0Z4dkxkODd5Q2RmM0xVTmpjMjZyUDlwenFxV0ZwNDVlQWMx?=
 =?utf-8?B?MzJQNUxtd0ltdHRweGxGa1E4dTRkcUZLYVVKOXI3SC82QWNrWTMzajF2Wmx4?=
 =?utf-8?B?UTh1Z3RTYVVZSUE5VFdtSHNxM28vZzZINW5jU3pOOHVwQ1l3cFNSV2E2b1Zo?=
 =?utf-8?B?T1NzZlpXaXl6MVFBTzVleHd6MG1ibERLR1VSdjFxTXU2dEpETkg5eEZaMFBx?=
 =?utf-8?B?L29VclMrOWpobDlHVHB0Wkg2MjdNRGk1SWI5UE93QUhpNkI1K01lMTdlU1Nh?=
 =?utf-8?B?ZlVwcWZESFFWWlNPOEgrOVIvTldCb3VRdUc5bURzSzV2Tnlid01nZ3NuTFk5?=
 =?utf-8?B?VUlZbVVaTFEzR1B6ZlV1VUJPNUNEY2RkZjg4cE1ZaHJSZmxETGJjaE4wSCtG?=
 =?utf-8?B?anNhM3dBOTNUdE90MHpHUWxiMnBWUjlqOGtZbDh6eHZmUnQvR2N3R0pXRWNw?=
 =?utf-8?B?TUhBYWNhMjZ6eG1GblFtRkNHMzNuWXVyMWY5U0syYzdzUmhFTDBPbitKUmRr?=
 =?utf-8?B?bGZIZ2k1SW8yTjkyMnA1d3BidGRFNkZIUGNxc0JnM0ZERTFld0srUDNXbTBC?=
 =?utf-8?B?bWFHdTdzM2hQN1ZuUFJEVE0vQWQ0SGhFVDRNUHpBY3krNjYzZ3VJTDhtTy9E?=
 =?utf-8?B?M01wRi9GRUlRMjhoTUN0NDdBQUJsVWVRNUpCSDBsTWJkMUNlc001VUVsUk9S?=
 =?utf-8?B?L1RoOXNPTkJUZFp1eEJWdDVwUFFzWVd3SW9hSmFJU0pBaWhtS0NaWHBoRkEw?=
 =?utf-8?B?WU5Fc29WOThVTnNtQTBEa3VGcGltUWdleGZDWmd1ME8xWndqRWlxVkRpcEZo?=
 =?utf-8?B?MXpIWVR5Z2t3S2tneENDd3dyUEJ5d1RUTlZ0dWdFR2ZBQjBqWXJ5Y1lsNjBj?=
 =?utf-8?B?UmZJRzRGb2N2WHN0dElCYkNLcWkyc0piRFZyKy9ua0h6dHgzL20veDF2UDJI?=
 =?utf-8?B?aXJ2eTV2VEZ6NUdrREFpMXI2TXJIZnFYWkJBTUR3TXlOcklCQzJXTkc4SFpy?=
 =?utf-8?B?VlJVSEJXMWVtR09sOEF0VFJxaWhVajc2Z1pJMDQxQ2dZZHhkZTVKOWVVaUU5?=
 =?utf-8?B?b3JJWjR3TXhrRHVGTkdUS28veTZoL0w0R1VaenBlWEVEak9xNmRnN1VtQmk4?=
 =?utf-8?B?TmY3WmdBbnM0eGdERFVZRVdlMmh4QUVUdS9mUTFvVVlWQU1yalhPdFBCdXh5?=
 =?utf-8?B?YlgxVUgvTmUzZDZTNnRSa0xvL1NVdzlZZlhPL21DSktYR1QrVnMwOWRDK3RN?=
 =?utf-8?B?Z2VvMk5QenlWQXN1NDQveUZObHhpU2FZVWVLZDFJK0dPS2dLV3h3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b60e207-140c-4b4c-a5b4-08de9af008cb
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 13:08:06.5240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mas4oyUScNLy/Qldmi28HvciLGXNVE9bnaeq37aWR2v57VhnStpyybKBXfSDqxFv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7864
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



On 4/7/26 12:32, Michal Simek wrote:
> Add ID codes for the following ZynqMP devices:
> - XCZU1EG_LR (0x0468A093)
> - XCZU42DR (0x046D4093)
> - XCZU55DR (0x046D2093)
> - XCZU57DR (0x046D3093)
> - XCZU58DR (0x047F9093)
> - XCZU59DR (0x047FC093)
> - XCZU63DR (0x046D5093)
> - XCZU64DR (0x046D6093)
> - XCZU65DR (0x046D1093)
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/soc/soc_xilinx_zynqmp.c | 45 +++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
> index b97cd443c607..4abc73013eb1 100644
> --- a/drivers/soc/soc_xilinx_zynqmp.c
> +++ b/drivers/soc/soc_xilinx_zynqmp.c
> @@ -70,6 +70,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 1,
>   		.variants = ZYNQMP_VARIANT_EG_LR,
>   	},
> +	{
> +		.id = 0x0468A093,
> +		.device = 1,
> +		.variants = ZYNQMP_VARIANT_EG_LR,
> +	},
>   	{
>   		.id = 0x04711093,
>   		.device = 2,
> @@ -208,6 +213,16 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 49,
>   		.variants = ZYNQMP_VARIANT_DR,
>   	},
> +	{
> +		.id = 0x047F9093,
> +		.device = 58,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
> +	{
> +		.id = 0x047FC093,
> +		.device = 59,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
>   	{
>   		.id = 0x046d0093,
>   		.device = 67,
> @@ -218,6 +233,36 @@ static const struct zynqmp_device zynqmp_devices[] = {
>   		.device = 67,
>   		.variants = ZYNQMP_VARIANT_DR_SE,
>   	},
> +	{
> +		.id = 0x046D1093,
> +		.device = 65,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
> +	{
> +		.id = 0x046D2093,
> +		.device = 55,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
> +	{
> +		.id = 0x046D3093,
> +		.device = 57,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
> +	{
> +		.id = 0x046D4093,
> +		.device = 42,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
> +	{
> +		.id = 0x046D5093,
> +		.device = 63,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
> +	{
> +		.id = 0x046D6093,
> +		.device = 64,
> +		.variants = ZYNQMP_VARIANT_DR,
> +	},
>   	{
>   		.id = 0x04712093,
>   		.device = 24,

Applied.
M
