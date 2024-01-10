Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B388C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 08:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2737878B1;
	Wed, 10 Jan 2024 09:22:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S6Ur/m5K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A03C8788D; Wed, 10 Jan 2024 09:22:43 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4190D8788D
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 09:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddf9PDNj16eW0bXjUU4ktmQjo8W5j+YMwn72CacFEwHdB/6yOcUZ0DSYqxkQFrkQZJM2fohdf3HD8z6uWOSDwxCFcs+oux/Bs+2Qo6W7R4ZEHux1/spXgwX3xnplQXKYShVWFiGu9OSaH8L6+TUtxUSz3fCgWazTQdmrmoLkyZ0QyS4bvi/P7WK8z7lEvzmONvJtF+jgVBUruiy+lz9hj7ZQTCD4fGd6i/b+OdyVUiwmd/YAXmHIrlSGaHMYHWFvkGBsVBRl8PscGs+VE+WwwZ17N3ppd9Kzfe/x9ImWAR/731236XDt8FzndSoPwrAYbhAJtwLcKt0QamOnh1QzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XJM1jQ/wE3U4VAx89sG2qOXpkssK33lhTLje/FkXf8=;
 b=KJQ/+IVA76YbxAgtx/PoHg7WHx7MZB0lglISPbkOcDtr1dpx/rXfr9D1MXrTvWN2lFi7RgerxDjCqc52fBVqeAoxu/4RsonlbwRj3WqyMgCMxw1QoRZt+4BqCL8zstfvT1DTTUUL2BUxvoxPZY0u+dNWTkr7Ug0xnEUTNN/vGCdXwiZpqZUFPPye2MsOnZtn+X8Kzashf2XjLexrEHD7i5vXdpAKhfykyFMmssySDfPlMAJ0Y64jp8RV2z8OJ8bSo/uydGZvMu2N4n3nbQIOZu+i+xeYeFbgEK7uDLTGFoF0+1y5VqnL+kN1N6TZton4mUc9afVONeBQflixY8fxPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/XJM1jQ/wE3U4VAx89sG2qOXpkssK33lhTLje/FkXf8=;
 b=S6Ur/m5Kdio2yDGJeg1tNAazZEWHEL3h+vXr31M58OZBrpV2yXWHgaCDNMrSRHofeS/Zk0xMYvUG+M+tozZ5tQtg661GuVc4AuyqpeFUMBUKz/4rz7muRjGv2717ky3T3cxp5vnPzmJ7uiv4NLSw1F+B4jJwVXQCwTwhvd0aULM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by CH3PR12MB8402.namprd12.prod.outlook.com (2603:10b6:610:132::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 08:22:36 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::2b19:2045:59c7:cde2%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 08:22:36 +0000
Message-ID: <cad4ffa6-799d-4162-9815-f9e3dfb12868@amd.com>
Date: Wed, 10 Jan 2024 09:22:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: r5: Include the sys_r5_proto.h header for future
 use
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@xilinx.com
References: <20240108105339.662755-1-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240108105339.662755-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0027.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::40) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|CH3PR12MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: 176bf797-b4c3-43e9-a153-08dc11b54d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aer9f7NUqt/pEodQW44bff3vRzkZeHW3nFgM9X0I08UVwF/rVclkNsrS8dikJ87oGkxFY8jWwQNfVO1jO7LxX+jV/OH0kpueyJQzEK+nY37m3kl1ADdl0Vr6ftNeFSEtaM+3LgGpMcLJUd6VjZpxHO8X2bVH9FGRqY3SSP1xAWr0wlIyq/SZC4ii8vzf9/Z2oqlM0zs1EcgxFg7t1qxjZ9WtSw70J6mKYFN27W16ljdtpxt93+F/N6Kl+Ha7JC1R+5h/1EcJvYKzt5/9zZkVIQQ2m8Nf3AKVGmMj89XTqnS//IFf09bE3sUqerd0WkhqO1HY6Mr7BKmWQgCzkX/M2TJ0/er8Mjy7JmiFy5IaC3EI0Iwbywj/LG+vXBgEFXdCnCU+P9pIvCIziN8KB9aOmOUeAapJEUdHBFjHSvmXIqBMvvdRNJ3APXF2mTP7mgE+1LOq9FQENUnah/mMZj//4Y2+8W4dipBXKXGDnJrDKKhp5GKe2ImA37E1Juym4vt0XFoRGbdSPiHZ15ZCeoilfkfyPqjCK6TbNFby1wRqTNUeOzZBNjsrXikUCcDJs5hHVeCwbN9rc0vygCNxg67Ttpbj/dDUfiLykm3ePsq6Q2GIdAj4qhoDlvhwOLQQZmZSbHkgw/kh1Zy0+5jrfkvnwSebqxXBu7MgcUl8hZ1Pnpj3hA1JaPhwnEz2glaCjMZe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(53546011)(26005)(2616005)(38100700002)(4326008)(8676002)(5660300002)(8936002)(44832011)(41300700001)(2906002)(478600001)(6486002)(6506007)(6512007)(6666004)(66476007)(66556008)(66946007)(316002)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1ZSVHpNM0RWMmFZOGExVE1ncGVPT0JVN25TaW1YVWlaNDJlOUJkek9ZVURQ?=
 =?utf-8?B?OVM5akZ0TE1nOTR2cFoyS1llcnZqUm5iOURNZDVqcTBUSTN3V2FXNURqeTJI?=
 =?utf-8?B?Mk0xQUd2SmhDN3B5YVFYVjRJVFNPeHV5dTg0ZmhhV0phbGpWbzZWQjhsTEMv?=
 =?utf-8?B?cWZoNVRpNmNtYUVuUmZ1T053WTFWYXZzSk1veWk2NzJIbElWbUNlQ01NcFdp?=
 =?utf-8?B?M09UM1VKMEVTbnptMlFSQVc5V1plM1pLTlF0d1c2dmlvSHU0djhKTUs2R2tl?=
 =?utf-8?B?bmxrWVhSc0t1NEt2Vlk5bUpmNDZCTWFMQld3TlJ0TE5ka1RRdzd6UWZVSmhF?=
 =?utf-8?B?OGI2dGlzVW9yTVBGTGpTTC9kdlRORm04VnFRMGhNYVpIWlZaN1dwVE5kcStN?=
 =?utf-8?B?dXdnVnhTM3k0bGJHbHYyK1RwQlFvODAxaUUrNDhJdEZ2TVBSdTZweDd3ZG8y?=
 =?utf-8?B?Q01URGVpcUMwZjNCVDRJYTZyV2pTN1RqNmd5eFArYUczY0wwaGpseDBuakNR?=
 =?utf-8?B?a29qT2doWlpld2UzbWJpNGNiaEhsaS9kazJaMnEzUGZ4RXNYMFBpYW0zUDBt?=
 =?utf-8?B?czlLQ3BzNEw1UUN6V0xBV2NzdlNFUHlJTjlacnhRZysvR0dtR3pJbFBvdzBB?=
 =?utf-8?B?ZmRlQk92TTBFVGZxWkRwWmt0U2RnT1pmOGhsbUUveDYvNHZPOUE1SFhCcTBu?=
 =?utf-8?B?cEpQT2ZDeDhJeDd2cVZLWnlFSHJaQVc4S0l6R2s1UlpORVJiUTI3SC84MXBF?=
 =?utf-8?B?dWJRSnNZMWlMUHRlc1VxSTBoUGZBMWtsU0krNHpUZ1NDME9hTUlaSTlkZU03?=
 =?utf-8?B?VmE2L3dhejlwcmFkTWdhWVNVR0F1NnZQK1VHL0ovZ1QrWnNVeFZ2YkFMWnd3?=
 =?utf-8?B?TXp3WTA4UnkwMVBUQXFWdk9sblBNM2lTbDJWeVU0R0U3bHVIYU5zdWVueXhL?=
 =?utf-8?B?OTFoZm1oOVFHWjFqUEZPdS9xWWhpQzdVSU96NzlWNjZOTktrb1lnbnRzSHpO?=
 =?utf-8?B?dzNleGdaV2oyMEhLS0JXZm5hMnptZmRvRzQ4SVdXYk0rL3JGQTVLRlVGdEQ3?=
 =?utf-8?B?bVZwYVVqdGtwQzNVOEFQbFJXR2gzVUc4NEkzWjE1d1lnYkorRmpUNGJSNnZh?=
 =?utf-8?B?UXM3aVZsYWJmUmFCak9EUEUrUG13ajljWDhJWFdtTTJtTmE5b2ZKbys3VHIv?=
 =?utf-8?B?T1U1MTZoZXlJcFVUZUJrWjYwRG9wTnM1eE56cTBLTFFIQ2Vvc3VteVdRcjR5?=
 =?utf-8?B?cm5ydjEzdGcyVE1NdkNZYitWaXNoSUdNV0pYWW9XeTJLdzZvQ0hpRjU4aDRw?=
 =?utf-8?B?RlUrQXFvRExMZktoQzR1anYxTGpGZmk3OUtFcHJTTG5CbGZJaHhMS2U5NytL?=
 =?utf-8?B?NW40WFIvMlk1aDh4N0xZNGhjQU1nbnJUb0dNK2ZhcnMxMWFYWXRYZlFZemox?=
 =?utf-8?B?eGZGeFdqN0dmKzVUN2IzOFljaG5tRm52Zmw4RnRxQnpzcVpGTEhRNFRjTitT?=
 =?utf-8?B?bHc2d3JjMFZwaVhWN3F0QXMySmhFZFBPZHpPeTdZUW9uZ0w5V2JhdDdueDJF?=
 =?utf-8?B?Y05zUmluelB3MDBEYXA3eTNVWEp5dzUwelZCYmo4NUtLM0JmYUZuOXFTM29C?=
 =?utf-8?B?ZzBLNTg5dWtRTWViczBVVUR4akFLeSsrcDVSU3RkQjJoa0VYb2pIQzZ4TlJh?=
 =?utf-8?B?TGlLMXBWR3RLdFBQMTJmVnRKSmE2aTcyT0QrdmVEcjdOZUFjcHV2bzU0bFBY?=
 =?utf-8?B?QmJ1cHZwbWJZa3dwTDhaSEpnamppL3k0T2hOK0E4eWZVeVcvdTFZVWZsSzlN?=
 =?utf-8?B?OE9IODZsUjFDcDRDWk1GYWJWZEtWbWRlS1M3K3lyNWg4Z29vYS9qTlZzcDJs?=
 =?utf-8?B?bE4wUjdjOHlmQm5TdzZpWG5qYWEyYlQ4TFFmMG1yY1VGT3Q5NGQ4RFlmRytr?=
 =?utf-8?B?U0pTQjJTdzBOd3h5dEgzeG1jWnVWMnRYRUFwSm44eTFXTEJCOERDTXlkZlQw?=
 =?utf-8?B?SDZ1NzNGbytiL2Z4eGRGUHpKb2dVc0cyRVBzMHhwbGxuUjcwck5XZlF1bzU3?=
 =?utf-8?B?UW5oaytycmc0clI2c052azRkaW03dVFQWDBEQThrSHdlRC9tQUFHcU13ZTlV?=
 =?utf-8?Q?QGCfun2CUiFGzW3xObu4BEHwh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 176bf797-b4c3-43e9-a153-08dc11b54d0a
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 08:22:36.1241 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sTEZsiYAGOCF/Fogc/mLOdYNDYv0J2mIghkTsIsNBX4sOkzglloO01UhPxeYCmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8402
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



On 1/8/24 11:53, Venkatesh Yadav Abbarapu wrote:
> Currently when using "W=1" with xilinx_zynqmp_r5_defconfig, getting
> below warnings.
> cc1.real: warning: ./arch/arm/mach-zynqmp-r5/include:
> 		No such file or directory [-Wmissing-include-dirs]
> Fix W=1 missing-include-dirs warnings by including the headers and
> sys_r5_proto.h file which can be used.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>   create mode 100644 arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
> 
> diff --git a/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
> new file mode 100644
> index 0000000000..3f75658c15
> --- /dev/null
> +++ b/arch/arm/mach-zynqmp-r5/include/mach/sys_r5_proto.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */

2.0 only please


> +/*
> + *(C) Copyright 2024, Advanced Micro Devices, Inc.

  * Copyright (C) 2024, Advanced Micro Devices, Inc.


> + * Michal Simek <michal.simek@xilinx.com>

please remove line above - not needed and should be amd.com email anyway.

> + */
> +
> +#ifndef _ASM_ARCH_SYS_R5_PROTO_H
> +#define _ASM_ARCH_SYS_R5_PROTO_H
> +
> +#endif /* _ASM_ARCH_SYS_R5_PROTO_H */

You can remove lines above because enough to have just that file itself.

Thanks,
Michal

