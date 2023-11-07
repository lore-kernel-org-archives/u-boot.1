Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB509C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56494867F6;
	Tue,  7 Nov 2023 13:40:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="egJW3Yto";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FE9386823; Tue,  7 Nov 2023 13:39:59 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD61C80844
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iULAY4Zi1MSueZW+A01wVhdTUlU3znU6KVPeZ9EfHMgxvZjG7y+P/D2otaCa+wkKN9jbo5xgK/4hZrYNA5ehfsg0B+dt8abBNUHOgno+8h5ATSSnbig/jVdyA8BQrdJm7X1SrwW0rksN4Ti/BYHgbNpU1EUwzVxqo0ceoFLXpM3LEIUYGMiRd0c3m2svIkZ1dh8gPJVdNadbA+amsmrlHCA3T8CHTH0FcLtceujPwua055M2FKpFlHXJ63BeGre1Pe0mb9QeRkNWHOynCu8UPNdy6TsbWhyUjVs75GqGr7knw8UGUs57k0hTmorsSkf36Bu+u6qYbxEsD4J04U66OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngc+pCXLlR+JDlqAF93rwcb1DLM7KQAHuCPplLH5p/s=;
 b=bzxoXkPd2qwedT7TzkyjCxl5vneM9estBl202+N6Fb1mTktuiYZOzzMJFtsy9Bq0ddxL/IgNNWMjOUY7MBsmI/nRDV7XvS7Q5Yv4ApMqPwpxZuCRQ1+UYtgN+CG+hEAtuuAR8NVf6sZJOWx0r4dw/XhAHqD8YCeB4UtnE1YsvSv6pzgg5WwqrevRsjm7nugMhLdTkDE6TIQTK3o6xzJS5lH8ljXMKDbAW24SCQGeLE/WobO2eb1hqcrGiRk6IF8mx/fC+ICnmKj3J9r6VxGKM3+BtQ8dQDVf9kJ33nkl9b2BiWOwZ085mjMQ8vPjjdtKyZk8cTO8wnj/tlEz6k2f8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngc+pCXLlR+JDlqAF93rwcb1DLM7KQAHuCPplLH5p/s=;
 b=egJW3Yto+ZKzyw6ZNuP0B2RXaQvhnDw6o0L6cSIP5wC0aEyoqsXO+v53QflWFY/hmMs9hlOaMxtF1CmNiBf+vmKvZXA1iRbLWNTGDYG38pZOEG+OD44UwQoTclDnp6ketXWQtpkLgL1mZQiMKkfBRp/xj3ekeZCaTMZjOP3ZK0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS7PR12MB6072.namprd12.prod.outlook.com (2603:10b6:8:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 12:39:52 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::1d07:c316:b830:70c9%4]) with mapi id 15.20.6954.027; Tue, 7 Nov 2023
 12:39:52 +0000
Message-ID: <8dddc9c4-1adc-46fe-9d46-fc7064698545@amd.com>
Date: Tue, 7 Nov 2023 13:39:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Remove VSC8531 specific RGMII delay
 definitions
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
References: <bbd343474856a67252f3b31d22b3b5a80ad04043.1698851109.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <bbd343474856a67252f3b31d22b3b5a80ad04043.1698851109.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0095.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::36) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS7PR12MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0df0ae-f6bf-4278-7bd0-08dbdf8ea314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZenQOyY2mBsvs8yu3iHsUHvWVJIvYJqeotiOvGNF6GoQpSm0y+sOo+Vb8lsIIDXx6aYK8+cZRMP4QtgBXzuv9m0XDo2JqSZnHyxSsLUayFO6EJ4kFSMOzfB8WPbiNlQzlVj68Le/+EUVtbkSGYUXKsaAJfZlAuzaaywZgyh81TmddBuEKfusFVVdRw22NV8LQyhwdNdTya8iyLT4pwOehAz6TTLBEBM+0H8mTuuJ4Rq4uzLCiyQIIwjXFdlrDxzuFqIpPqESxS0tyWoCC5RfbaqTjhOFkPNUr8Ypk0h+s5KIZuMGg8TWQu0a7cjV03lm8Wyyx3s+FN/6b4/JB85HZf+ut+OlbH6OSB/gF7V6RrFpsSWlIPOAFTT784Sy86xSf3l6aJsZbfne2meRCbDxxgpskmpSR4aDSRB1DuBQoA9eCGpVgHCBd6akELBrGU7o/zQ8ZA12E59b662Gr7nqjgB1Fb6UR2FgFWDmA3lJ/O7kWd6ejz0p/MBzvoNWCr0/fmLVTcfyS718wGVBVU8z0jrJtW36k6HVplTdcWZ4FBwfEujAzMVYErJSwmAIgyinWLI9/WFUqh95VSr5mBYlJnoYkaZYJ8/a1o+rv+Db0nXxUWjGaS7BNx/iifWiUXJxKBwjrqkVkoTBBTKIYVwbsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(53546011)(66946007)(6512007)(26005)(2616005)(83380400001)(478600001)(6506007)(8936002)(8676002)(316002)(66556008)(66476007)(966005)(6666004)(44832011)(6486002)(5660300002)(41300700001)(38100700002)(86362001)(31696002)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnVwN21iT0tFS2phbm9STzNpRlc3VjJldVc0djJyaFFwVG9IM001NWZCbFFK?=
 =?utf-8?B?MHZMSUgzOU5VbFpVVVVzQUUzcnl1SklQUzRoSUFWdUROVkJMbzZvQVFmOVBF?=
 =?utf-8?B?WmR0b1hGaWQyd2p5T0pUZks5RGRjTUxBT2hnTFNjZ1FObGsyQ3grTkNxcFN5?=
 =?utf-8?B?eWU5bnJCbWpTRWw1ajdTaXFBZUViSG9tb015ZTZMajRhNCtRZkYzcFRiKzJU?=
 =?utf-8?B?MmFhRFJwV0RVb1B1ZDAxTFpZYnUrWWV0dXBZYWVGSTM0YnFhU0pBdDlzU2U5?=
 =?utf-8?B?d3QxM01CcDBoVjh3VS9MWnNLS1k3L3BpRUt6QTJxVkM4cm9xUkdWd3FxVm9v?=
 =?utf-8?B?RWRWbnc3Y2htQjNMT2lGVDJzNzZSMHdXZ0tHYjQ4bGsrQ1FnMGpSSUU1eTI3?=
 =?utf-8?B?c293YlJkbWJXalhuanBiQ2w4Yk00UnRhaEM0YWIvUkZDTlVEelJieXRkbUNV?=
 =?utf-8?B?eXVtYXVTamJWSlNDUHQraUtmUGg3Y01JNjkrZmZBbEdaeVB6bndsd1MxV2tj?=
 =?utf-8?B?Nng1OHEwY3hsaWtnYjVWMkg5R0thbFo2cy91eS9nRzNCY2g1N2pnc1orYjBY?=
 =?utf-8?B?M3k2MXVFVHpKZ2ZpL2FRcXpJRzJhUHFnVGNZb3VJa2lHSTFXZVM3ZWRNREMr?=
 =?utf-8?B?a0JyYkR3RHZUVkE5M2Z5dFFqbHl6WlhrMWVtYVptd0VVYTNGcTlMZjRRNndJ?=
 =?utf-8?B?OTZBenJtaXdpN1VyTkI5bDlzYm5OWXQ4Vk4xZnRNSklVTHNBSXl0T25hMENQ?=
 =?utf-8?B?NWd1WHpOckl5QzhsSHlLa2dLclhYcU5ZbW5ReGtUTU1CYjR3TC9hTGpmcnpJ?=
 =?utf-8?B?QmNWVjhiZ0doeHk4SHhnNzdvM2V4RFFmUVVKaGJjczFKY2owUVBNeDRvMzUz?=
 =?utf-8?B?RkI1R2d6TmxubGVna2pCVEN4S043NnZQdnNHbXd1dC9NV1FockZaWnVLUEFM?=
 =?utf-8?B?ekUvQk5xVFhUM3VzYSt3d1pFeitwSmh4azV6czlmTGM0QktHalgzbFV5cWxt?=
 =?utf-8?B?SXRoZ0tnMnYydmVYRmVSbVIrTTJGakNlMWhKZVp2ZHFuTHJuWDRRbUlXNlRx?=
 =?utf-8?B?VUZEL2RSMTkrZVJkT3N3eExFcFRVMG9KSXV2a1FRcDlWTnorTEVMNSsxMkpB?=
 =?utf-8?B?UHJ6eVNkTXNwMkd2QS9jWEN0UVp4bzMrYVBBOHNsYUVzNlE3NnY1dTNZNERK?=
 =?utf-8?B?TlVCRVQ0WjJXTCtWbU1KVVJyejZyR0lNWnFidGtRYUJFbnB0RW0zaEFVUWpo?=
 =?utf-8?B?ejIzMnR5RzF5NzQrTGg1bi8vNjlFcDZGNEd0UDE5bDRkOGhBeWUzdHhaUm9B?=
 =?utf-8?B?T3RrSk1iNkVIMjZla1Vod0RqOFYrcXBEYmtGRXh5TlJkazdkOGlxdjlKNk1X?=
 =?utf-8?B?TCtubDRPaWNJYWNPUXEyK2NuNVp3ZWhESlY2a3dIY2RxbXc1RlJ4aE8wbkxi?=
 =?utf-8?B?aUlHRTZhTW9jTXMyQmt6SVhOc3MzZGtuakNzMW5EdC9uTjlHd2RTQkZoMjRw?=
 =?utf-8?B?MDF0aHpGOU4rV0FIeDYrb2l1WWNnYUJ4ejByUm80OGJJcWNYYVZ1S3MrMDIr?=
 =?utf-8?B?MC9iZ1VzVUN2ZFh5ZldLVTFUaVl4VjVGMkRiUUZkNGRNQW5pZmxsdnYvYm5B?=
 =?utf-8?B?eE9uOWd1Qyswa0l5WmtDVStFRUluWlZQczhrRHIrL3NGZTJqSHZMeDhGU2VE?=
 =?utf-8?B?SlpqTXIwK0RsY2U3OXM1UVpEcjZKM2pUZmk2N0RjQ200TEVyV2gxSCtvcnZK?=
 =?utf-8?B?amNtRUJ5Qk1RYTR6STkvRDZ4U1l6b2hxa0lFeUgxTzE0SStHcDdGa1VMejZW?=
 =?utf-8?B?VXBRbG1mUFBKUEgwZ2ZvNGhsUFB1dHVOVFY1Q2szQWtRTURRYURETlRiUG0v?=
 =?utf-8?B?V3JhTnA5UjZRbkJTaWxObXRhS0p2N204RStMeWFTTTVJYUwyV0NuNUZmbEF2?=
 =?utf-8?B?YkloSnlpc0kxNGFQU1NPZUgxQ1JteUd3VDZSZWlsTEo2M1hLWVhsU2JBOWxx?=
 =?utf-8?B?VVhoMU9FTFgrMjN6azdraEFic2tsSTR6b0s5bng5Q0hZb2luTEhZT1U3b2sv?=
 =?utf-8?B?NlNXU0oyNVM4Y3haSVhJVDM1aUpwNk9pUGdVUkZ2aUVYblc1UTByRWJWdHMw?=
 =?utf-8?Q?dPv6kXz0Jlm6oUBQ2WsmILLgN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0df0ae-f6bf-4278-7bd0-08dbdf8ea314
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 12:39:52.0068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZ2TmMFVNbwEHDLgsIUgdKgm0D5TyzGsKquRnOIOEfZNF+Y7B/lb1XJfgDeBT3hl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6072
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



On 11/1/23 16:05, Michal Simek wrote:
> Based on Linux upstream discussion value enumeration shouldn't be used.
> Instead of it delay in pS should be used that's why remove it from the
> header.
> 
> Link: https://lore.kernel.org/all/YNsm%2F0dmpBgO8mqr@lunn.ch/
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   include/dt-bindings/net/mscc-phy-vsc8531.h | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/include/dt-bindings/net/mscc-phy-vsc8531.h b/include/dt-bindings/net/mscc-phy-vsc8531.h
> index 61f5287d7523..c340437414fb 100644
> --- a/include/dt-bindings/net/mscc-phy-vsc8531.h
> +++ b/include/dt-bindings/net/mscc-phy-vsc8531.h
> @@ -28,13 +28,4 @@
>   #define VSC8531_FORCE_LED_OFF			14
>   #define VSC8531_FORCE_LED_ON			15
>   
> -#define VSC8531_RGMII_CLK_DELAY_0_2_NS	0
> -#define VSC8531_RGMII_CLK_DELAY_0_8_NS	1
> -#define VSC8531_RGMII_CLK_DELAY_1_1_NS	2
> -#define VSC8531_RGMII_CLK_DELAY_1_7_NS	3
> -#define VSC8531_RGMII_CLK_DELAY_2_0_NS	4
> -#define VSC8531_RGMII_CLK_DELAY_2_3_NS	5
> -#define VSC8531_RGMII_CLK_DELAY_2_6_NS	6
> -#define VSC8531_RGMII_CLK_DELAY_3_4_NS	7
> -
>   #endif

Applied.
M
