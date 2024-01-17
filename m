Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA70C47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 11:39:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D816C87A80;
	Wed, 17 Jan 2024 12:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BEZl1ndi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3485187B1D; Wed, 17 Jan 2024 12:39:26 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF5687A07
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 12:39:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZepQKDFFE5OlH7DNx817UYRd0mosAGP4fYXXhNlMzRWy7sDHiFvsUOuawF2azeCbe7VP7q8c+JBFL33dwLKGn9HC8FCthtPviXuFtb/ZOfeqeECCdGSYy33w0Qsm8343m9EYe0TYu2QxjnY4xCdDt/TXaVmh6y49krhlH400xxUWFFRQSJDKv5X08B9VBJDgaXvH0yEhlrtmOrQbZ+kYGoJOsh4pt25zPanrM+RF/4/iY/Z67tbz/QwTd4Yiybc3ctasKC9wJALyjTBVM2zFT8pRTNWG8ZTlYL9WeL+9xXZVZhGKH9go1gLP6amGX2oRLWD/w+MqR3aEfPCNpjw+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIdZqE8l2F97PtyXPmWtvVuzdE9lxYEC/STD0puPHE0=;
 b=ncWBun+6cpJnyoz3mtse8ON5nHcJmMzc6aZt5NcNrqgn0MEXpAmAP/UTWdA8lYJuF7ypmHj56xQES7khXWMtWAuSU4grm/uE9Yf4GlYIOixZFFYpGk0yUNOTGT82rfzSpY+LHxKPkXuMdvpXRifuY5mz+2Jx5RCt4cAWzgea4fllynRzL9tc9ts3kaVrfPzcA9ekn2iA1tF9kq3hw0Lg6C0e/ezQDkmaFmYq7Z3tas48kiU1sb+Khgh5UEwx4w6y9cM6fsVDohbyxW45qaF9V8ptstgTWto8Shz8G1yr3ZYNxfE7m2Zt3dHYqesVXaYYsa6n1FnvLbBMoFotkPABqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIdZqE8l2F97PtyXPmWtvVuzdE9lxYEC/STD0puPHE0=;
 b=BEZl1ndioMuzGI+a02FXbOAmirNs95UZOs8Sdq21t8Hmj75s5XL6WHqipaEr65N7Df91WC3Ws4rKsVVammlyuWqkGgUa1GM3njcMmGBFaTnyD7/gfv9km8cuhLA1fEWi/ssltZVr8dDHbLznN9NC3DQBXStWdCasYuIQcKLh9sA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 11:39:12 +0000
Received: from CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45]) by CYXPR12MB9337.namprd12.prod.outlook.com
 ([fe80::772d:da3d:154b:fa45%7]) with mapi id 15.20.7181.018; Wed, 17 Jan 2024
 11:39:12 +0000
Message-ID: <014e03fc-65d1-4933-b84c-836f0dbb9419@amd.com>
Date: Wed, 17 Jan 2024 12:38:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Remove ltc2954 node
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Manikanta Guntupalli <manikanta.guntupalli@amd.com>
References: <f26b1a780ec44444d62e2dd696a05e2a37fa0993.1704890056.git.michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <f26b1a780ec44444d62e2dd696a05e2a37fa0993.1704890056.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0027.eurprd02.prod.outlook.com
 (2603:10a6:803:14::40) To CYXPR12MB9337.namprd12.prod.outlook.com
 (2603:10b6:930:d8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9337:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb27901-1741-487f-82f4-08dc1750ed24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RrjvDBq8wPguM8bVfNWVZXnPem5poQgdKbuZBydOJg7xgrf0WQdEA/gP3cumT4HIcW2SydjeAZ1QtWmILjZT9LjcS5QO3rdjrp0NaPyYYaPSd1Ip7TRqe6KaB6vlJUKhRZV4eFaiIBfkVoZgt0pXGRJQYmOKM3wHqoi75n+KfgmSZS7RbjAHEIzU5+5kXi0SMiCoucww4sFLP2JWBCCO4RNIrjBPmd721uK62Xe6zev+jI1I4SgihDbQiEWFdD6mLoB2faM3gEw14KiokIqD9tGd/eALdPZXrjCaLUgDwGTg27xktCTNtYGg8ib002Jq9AOpMDF4MjC7JITcBxr3tj6abhYcEMl2ZRm5tSXOYzCjOC8K6kR90UYAkJAA91Dy8Y4PLoD8X0F8ZfE4ouzh1xzOi2x4+RjnlyX97R4dHkpZxbXqCPkMwrDW+ODAV4fsGJf+XE6aj/3ONGmhN6vV55+RG9O/vWxTdROS6OL5/d/Fnp02MwHxivnUdoQog2utuAQY1sHHkpSpEw2buohnFgaywX0nmn4bB0KunWeZQUN6WfEzpml0DxtE1R3e+F60lnapQRKWJkPsYrkG4+sMMCIXVSPm3HnPmLE3iXReoflYcEtFMkxi3qv4+mtQl9UPbIqZiS4C/DBVGZzsWK/0Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR12MB9337.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(54906003)(4326008)(8676002)(5660300002)(86362001)(44832011)(6486002)(66946007)(66556008)(8936002)(31696002)(66476007)(2906002)(36756003)(6666004)(478600001)(38100700002)(2616005)(6512007)(53546011)(316002)(6506007)(83380400001)(26005)(41300700001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXNQamk4Y3Q0VnFyOG5lTnQ0Rzg3emV3aFJ6Yk8zaHZkYUhDajgzN1lNT0Iy?=
 =?utf-8?B?UFFIRHcyLzJManFOSGlMSUxRMXp3Qng0YVFLUEZBOGk1dEIxZCtEcWdwbUFs?=
 =?utf-8?B?RjJYZXFhK3FhUzBZd0NzZUFJdUxDRlhDdDFqZjRWelZyUkxNU29RaW13TnBF?=
 =?utf-8?B?Q2lITTVaK0xLYUVzVUJZNzRPbEsvVkk4dThTY2QvQUZZMnV5UTJrK3lTalRq?=
 =?utf-8?B?amhhZG11eEhkc29la1BTQ002UGtBWGlNelA0STV2SDN6dXZBbm5YaHF3OGty?=
 =?utf-8?B?aHYzZ1JIc2RHOElpdW16UjhRTmxIOUd0OTRzYnhXdXF3NzZmV2ZOb2ZvZVJK?=
 =?utf-8?B?RlFxZWJiK3ozaUQxbEJjbURnWEJUalVRbXdpR2t0WnNqR2F3YkJFeU5qUStW?=
 =?utf-8?B?NDFEY3BJZmNQZ1Evb25BNUNXUUpEeEZVaVhCaHVaZWZMT2tLd1VUd1pvZ2VZ?=
 =?utf-8?B?MGhodTRPeGJNanBHNW1BWTlTRDVvQVZOUWVWYnVQMTRYbEM0dnp0ZHBIY2k1?=
 =?utf-8?B?MU5yMGpaaW15YXVXMnNPb0F2c2hHd2tuOGVMU05FazRLWlhYb1ZPSFBHZ3dV?=
 =?utf-8?B?RjltQ0lPempmcXg2REV5RjhkTlZQelNPcWkyWFlvNTBhbXBjUWlyb0pHNjdq?=
 =?utf-8?B?eEhxOGJYZGFJTjBwUDg0dE5LQmJZQ0hCM2Q2UHpPNDF2WVBJTjJFNG1YejM3?=
 =?utf-8?B?MzNyNjdQbDdKQWFtNWtBVDlmVWNxWGk3eWd1ZVg3aDRkOCt0OG1XTlhOUlp3?=
 =?utf-8?B?RmJPcCt2UUhIVUhwZUFKd2JnNWIxWkFoa2dFV3dBa0RMeDRmS2xLdHlROFR3?=
 =?utf-8?B?YUlFck1QM3pUYzY5dDM2L000dEdmRkNEL2xhSUplSDNKWUp2VVVDMnl0ejQv?=
 =?utf-8?B?MWg3ZllXRlExQ3djYm96WmUyaTVPL1J0cGdJb2xHa0h5TEE3M0dKa1pEZDFY?=
 =?utf-8?B?Q1Y3dCtKa1puL0dhM3R6aWMxditOS1kxRUxySVBXcldiU3FCdG91dDJ1VzhN?=
 =?utf-8?B?aDVDWnJiTFc0SmkyL0lZbmJCUDFZcHJ2Y0xLMFdrQm4zWjM5am1TSmMvdi9Q?=
 =?utf-8?B?SHdHQURMNndyTCtYUURUY2Q4SjZia2RTQ295anMwUGlWME11WWVMVXYvckJz?=
 =?utf-8?B?QTlxL3pNdDQzQ1hVSjhmN3pkR0s1SUs4RVNFd25iN2dHMjk4VnJ4alAxUUFv?=
 =?utf-8?B?SHJhVTk4S0s2Q1FuamlqRHJLaTB3YTBmZDhpQU9HeVhkenVEdTNsM0o2VXFF?=
 =?utf-8?B?d1NXb20zSFV5ZlppQXAxUTJUUUNLUUhJYWI1YmdxS3hZUWErVTEvODIwT3ZY?=
 =?utf-8?B?alk4eWNiR3VhVG94b3BpU0RENVVPRmQ5djlYeFJpeHFNelJQV05ZcWQvMldp?=
 =?utf-8?B?QTIvZXhva0thR1ZjY1VpVjVxZk55ZHpOMHpkMlhzdnZJcEIwTkJFSVp3QnBj?=
 =?utf-8?B?NUk5SytBMk5sV0V4UFJmaTd3TnBpYmV3U3RmZkdMSk1vNm95S3diRlE1blZy?=
 =?utf-8?B?YWczZHM4R0pmVkJzREpqTmxNWFQ2WmtsK0FuZFM3WFRVaDVNNVJMaUtGWGp2?=
 =?utf-8?B?M0FNR25QbnRaT21nenFZY1BlMms3ZUJ6YWIxN2YyZ2tVVjRBUHc5UmNWcFh6?=
 =?utf-8?B?WWJDOHhiMktRMytUN1phS1pvYng3MWRzdHJnam8vTlRvTEZOY3dVSm8ybWNy?=
 =?utf-8?B?a003N0RBWFhGMTN0aldMNDRXM3U5bGFvd25TeTN1d0xiTGE1YlF4empDb25I?=
 =?utf-8?B?dWlUalJrQk4vZmpWeGdCY29Oek1MVGFjUC9hNUI0RXF1NFNoamw0N0RUdE9a?=
 =?utf-8?B?YVpHYisra2NuSDNreHJyUzBQUUJJYjZmMjdMeTg5eDYrU1hGQWhIS1lFcHBG?=
 =?utf-8?B?dlZPVXZzTEdWOWdFMW5UQWIzQTBoV2tZNHhDZitpQzJQUXBHckxaR1VCWjlE?=
 =?utf-8?B?Y2doQTJtMDJlQWFKS0hzRzFOUnFpQU1yTktDa1M0MStXY3ZWYjVTU2FJQUlo?=
 =?utf-8?B?UkllWmk5WklDcHFCZzdIbVZyWDZNaE10Mnk5ZEhmTWtCM2p1NnhQb3V0K1pp?=
 =?utf-8?B?MlZmODBtckNxM29ua3YxamJibHdXZzNvdGNLVk01Rm5JUmN4bEtKSFNrYklu?=
 =?utf-8?Q?2QFklpEYJlLKMewl++JOZT9mJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb27901-1741-487f-82f4-08dc1750ed24
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9337.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 11:39:12.5089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUxbflwIDTj99Yap0icK+CA3SjZTmXD4qYqrUGyXG0i36g7dZ+ALPqAtQWnZcNbE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173
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



On 1/10/24 13:34, Michal Simek wrote:
> Remove already disabled node. GPIO connections are handled by pmufw that's
> why there is no reason to have it described for non secure firmware.
> If someone wants to handle it from OS revert this patch and also update
> PMUFW configuration and pinctrl setting for these GPIO pins.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-zcu100-revC.dts | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-zcu100-revC.dts b/arch/arm/dts/zynqmp-zcu100-revC.dts
> index 49d5cdbba585..c5945067cd57 100644
> --- a/arch/arm/dts/zynqmp-zcu100-revC.dts
> +++ b/arch/arm/dts/zynqmp-zcu100-revC.dts
> @@ -103,15 +103,6 @@
>   		};
>   	};
>   
> -	ltc2954: ltc2954 { /* U7 */
> -		compatible = "lltc,ltc2954", "lltc,ltc2952";
> -		status = "disabled";
> -		trigger-gpios = <&gpio 26 GPIO_ACTIVE_LOW>; /* INT line - input */
> -		/* If there is HW watchdog on mezzanine this signal should be connected there */
> -		watchdog-gpios = <&gpio 35 GPIO_ACTIVE_HIGH>; /* MIO on PAD */
> -		kill-gpios = <&gpio 34 GPIO_ACTIVE_LOW>; /* KILL signal - output */
> -	};
> -
>   	wmmcsdio_fixed: fixedregulator-mmcsdio {
>   		compatible = "regulator-fixed";
>   		regulator-name = "wmmcsdio_fixed";

Applied.
M
