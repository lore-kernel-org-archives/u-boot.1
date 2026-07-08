Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F153C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D314A849F6;
	Wed,  8 Jul 2026 18:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KMH71PcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF6A984A0A; Wed,  8 Jul 2026 18:05:37 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DADB98496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9MEz0XRAQpbsmVAL4/L7gp8i8io+apmcJPL5j7Z/gQQRAOP8hC++zfIa6n61plIBpeITK6qgrawIDogpJ6hqsp3A/U3rQyD7ZQnXTYtSrtmILR+PYxqZWdjlL9hCmLqmdDPxjWqYUKFLBM0AhLtMp9CDl9Lm58URJc6dwvO7i7jC8e4Nn94NIGKjtTyvj2lSh25VREE5E7zQHiTiOeWfoNOzTYLiywTEAry3SXyK6DtaF0w7Jui7hjFoJhTF5IMFeG74yHQ8QMG03Xty8avisSf1erkAHUal+BnR32XGFrE2qHqw2jAKRNUU8iXoeuOwrwNUrQl2lFbk8LON06y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KYKeJK7OYJkWUZSJYe0//3T8m5sc2U6fjXOdd19eYc=;
 b=FUS1Gva4S1273VozUw6yc8oyD2gdUFDRA34g5DzbKQK58UHupXDwQQobKGjJ81Wu8Z4oiOGLns15Iu0VJs2H10XZ+Ac0434myX+1bHuxXZ4FT1xUV+ARb7+b5iX8PUXL+X1my9hBPzXviFXplnpQYXUwLDAK93NIiMjpUacaeItXkSY5Ko7qlxDVi/mNtO0tOkGohvf7/gYjXxrYZ8IqSbaCLeDjGWAZTEW4gizR7jXEhyoYtlGVxVSUzkc6WAsszzE8lQKpXzVk5mF+dDulS0QFBEVWtrQnwRGTM2c52i/Q/Zt3xPtbPYcAflfN9EJpGVbiqusLU3Mr94zmWlkF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KYKeJK7OYJkWUZSJYe0//3T8m5sc2U6fjXOdd19eYc=;
 b=KMH71PcRp38YUmEeswEvvic/Xi0A8qoq+EYIJ9ZPzqb32qk1cijormNrwdsazZNtDyqB9TdVSPoIubRA4nrp60g34T4suTkRwHJdcXrm6xtw5ANX+dmt9BUk85UPpx/HK75/0i2Pjtdfob/T7JXqgkIGoxWjZ42u7L4JLgWxzOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI0PR04MB12664.eurprd04.prod.outlook.com (2603:10a6:800:345::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 16:05:34 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 16:05:33 +0000
Message-ID: <fb8590a5-d051-4ef4-ba25-efecfcf4fece@cherry.de>
Date: Wed, 8 Jul 2026 18:05:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: setexpr: reject division and modulo by zero
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <g7sabrrsecusu7p35zh7rjgksvxqtghrqnks2tshw4h3ft2cuk@x3fqhhdmwm2r>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <g7sabrrsecusu7p35zh7rjgksvxqtghrqnks2tshw4h3ft2cuk@x3fqhhdmwm2r>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0038.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI0PR04MB12664:EE_
X-MS-Office365-Filtering-Correlation-Id: c77ffdf2-cf64-4c50-d43a-08dedd0abd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 8akaQODf9hqVJmTvgOnvy/qIx1L7l3kwlACTZaIYOZ+ZDt52xlH3/QO92mVztCL2vTd4JFGRkATnNJWiyqEPkQ0ou2jcsbj9s8q5GCuRvMA136wH6bqwXw49NpOdPPUPGiOHkIDT01jS2WFxmSc2D6TUlFbndxmGVy86tptzSHiQaLLt2jq3MJUWhAHyCVpInG/V59uRqOY4rXOFZxGISjcW+XReqx0aKY0UO+Ef1Z3kneNpT8YlUZD9KeW/fvkb4HXB9HnbS3o+3pP8WkEMe5jNov8huqHCbVbRthb7SnTN7KgR93tGZPfx73E62NFwV6deCiHNV7lmmClVNzBBd/b+pw488bqa/PMuQmL7U0NEVzgsXCnVKzrEQkuQx1FmBx8OtuEfDRhGiuGkUmUJ1Lov9uYq07WtKmxOgaEH2XWejB4H9fPmWOfyIgKu7ui9XTG3x+6X0Juok1Q8OZNwHUalpkaXeyRVqtrXsX848PJO219FpPc1le8hwEJ4ugOLoR/siBDa75hc9oF0hRvY6ffACpCDTFCcrbITQKKGk1ZT1qokZVJu/1Lfktyxy/FwnHWItdcRoTCgNnNjxALsmlLaHX7fef2vvLpHn9QoDCShXmAZWBMUbgmiwiQfiS7Bixi+Mpz7WFblGtV6re1rJT8TmavSEE+P9vI1FO/m0jo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXZlNkQreHA5SjJxL3ViZXdoLzJrYVNKcTBTV1YxcCtsZnM1akZNMmZSMXgw?=
 =?utf-8?B?R0dXdlBBeGxrZnphYnA3R1NSWHc0aVNNZGxTRy90VzM3WkRhck1ZWlNvZFQ3?=
 =?utf-8?B?Q2VmU3U3ZHVURGxxN2JmV1RrVWVseUgyY2Mxb3RUcllUd0thMEhZK0RvL1dk?=
 =?utf-8?B?YlcyNzF4dzBvUkdYN2F1RUJrbVpvSHIvTjYwTHFyZTk5aHZLZnF3MHdxSCtT?=
 =?utf-8?B?VUFYNTBsQk5ROXlGUklvS1g5Z3lIemR3UWlHSkMwZERTN0xRcW1UQkxYbnlK?=
 =?utf-8?B?THZWL2kwSlVXQmVxcHBYcXpaN2Q5enplUTN5RVVwTG9QT05lTk9oVHUzU1BK?=
 =?utf-8?B?Vko2SVJsb01QVVMxUGYrQ1VWUHJqZFF2dGhseTV1K0tXZFJqREY4ZytQd0hV?=
 =?utf-8?B?ZzNqRzdiMjlReDNhZEhhRFJkNi9LN1doMjFLcHI5ZU9vZ0QvTm85NndxTmdR?=
 =?utf-8?B?bXptVS9SZjlSUTA0UlJIMDVQQmRRNEhMbE1yem1tK1RNVmFGZElSRFEvWUVG?=
 =?utf-8?B?VXpTMFRoVldMcUJ1MVg5akhxYXA3b1VkemJwRUh2aGs0Z2s3QlJkbXZrcVpq?=
 =?utf-8?B?MytjNGU5MnF2NkhFVEo5NGw1WUl1ZDMxSm0yeEhiWEEvbGpmNzl3UFlRU3ZQ?=
 =?utf-8?B?RWlaeFJjeWM3aUdFRkJwS0RTREFqQmtSaGk5cm9od1ljcjRKK2hLZ1crS2Yv?=
 =?utf-8?B?QW5NejhEL0hLcjkrTlZONTZYamZ1cE12OGkxZUZzcGJiK2t4VXlzSlNkN1Y4?=
 =?utf-8?B?dkRKNVdoOU94bExQWGd2T3BCTEluNHFlR1JoOFV1U1V2MWtpcnNsblNydDRN?=
 =?utf-8?B?MlJGNWlWNDlCRWltVDNsNTZSd0RzMTN6Vm14dmZrUnNJcnR1TStHaW9PdmFi?=
 =?utf-8?B?eVBEUVArUGNPOW4yOElKa0thZ2d1N3p2TmJwODJhTVlYbGNlUHh4anRsaTFh?=
 =?utf-8?B?OFJCYVpuVGx2RWlzTEttamYvbVhzeCtRbzR5U0N0TklRUUxZbzJVQjdjWkEx?=
 =?utf-8?B?blhSc0tXVklkRXE3OHNmZHA4a2JEcGpCV2FmajhXWUtjdUpkZURwa1ArQlB1?=
 =?utf-8?B?RTFlRmhvTnZ1SnVGNFJIM0VkTnhDMHBQMXZVR2xSYy9wMnl0ZGpndVFXcmpS?=
 =?utf-8?B?S1NoZkFLeTFld1ljdXVuYndINmxHMGFzYUhYaE1yVkFYVHhKVk9XeThpSUpI?=
 =?utf-8?B?QmNUeVBEalJwWGFFU3c2MUZTQWhwRktQQi9hdXB5VWpKTXcvRW1wcjI2dlpZ?=
 =?utf-8?B?STgxWEtCdCttaDFFN3RFQUN4dVJuM093SzVxY29ReDhqVTZIYkpEd2Z3T2wr?=
 =?utf-8?B?S0JjTktEbGpYWmNXQjg1UVJLRDhpOXJQcVQ2MkRKeHBxeEJZQWVmWWdrZHVW?=
 =?utf-8?B?Zk1DQk1jR3pTdThrV0tZdlUyYk1XWHpUZmpOYUdkeXdlYURpT1A2cXhsMVBs?=
 =?utf-8?B?SXQ5T3M3WFhTYnhGWldGWjZYMFhOOXpFa3VuQ2pmQ1d1clk3cXROY1JadGlU?=
 =?utf-8?B?Rk5nZHFpaEt4NTYySXhnbHA5clJtVWQzVE8vVTJ3QWdEU1hOMmMxbGhGZm5L?=
 =?utf-8?B?TG9CbS9LNmY5WDVUT09WWWZyWmU5NCtRbllWZjZyNTJ6VkpnMW1Db1h5cVA3?=
 =?utf-8?B?eFI4ODF3UXVVNitWQ1JDdHdiQ0tkY2ZldGJFVytBVWcyalJFMTRkTjNzVjB5?=
 =?utf-8?B?dElLZUpiQllRUVlIRlRXSkhXZ2twTWQvYVFmVkVMYXh3eW9GUjNycmJKMk1W?=
 =?utf-8?B?VFJ5aXMyVG9hQ0t4b1hXSDlQT2p6dXJuenpqbFBWbU5nUFY2N0hhQ1E1amYx?=
 =?utf-8?B?OXpzR0hUdy9ucWc2SHBEdFBkZyt0eGZpalpKcVBWeXdpNktPZzNsYnM3am92?=
 =?utf-8?B?VjJRemxSZGhmZXVJUkhId1lUcm0yYjV5UGV1SmhWUHVJTWU3bGJyd3FCSDNu?=
 =?utf-8?B?WTkrem56b0piK1ZvUnB2WXhKS1puM2JMbTcxSURDbVJhMjlvUHAreHhPZk9n?=
 =?utf-8?B?eHRYS0ZkUWVMSVFacFhxSTNUL3M3VzZYY3NFMFdHdmk4MVl6bUUyc2w4eWFp?=
 =?utf-8?B?WHJmbEYxT1Z0UVRac1luSDlpeXowWE1FWkhHYVJIU01lS0h2OUtDb0dUUEdp?=
 =?utf-8?B?NVBycm9qRDlHUXpucnlWRjJyVE95NFhocm94YmNaT01rVUt6dzBRMy8za2hB?=
 =?utf-8?B?L2ZHb3gzYThJa1AyMnpWeGUwd2dNY1NGclVOc2lQSnVyK0xMNEpvNVYvOVRu?=
 =?utf-8?B?dSsxZHJPK0FLNUhRQkxUeStjSnJUZGJkK1RTVys3Mi9DV0VaK3ZNVTA1SWM0?=
 =?utf-8?B?RE5oUThHeTFtVEI3akRUWE5mdnFIK3NWeVpPcjlBc0cvRktmUVE2dz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c77ffdf2-cf64-4c50-d43a-08dedd0abd99
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 16:05:33.4523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2SUx+PVDz4JUiWvy5YAuTmsj/iaJy0E2+wvh5FpnrefTxMjbbC5tiQYHX1w6ZHZeqMMKJs1gN9vQFefDAsiZF/QecE3FuXffkw6HACrbyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12664
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

Hi Naveen,

On 7/8/26 4:33 PM, Naveen Kumar Chaudhary wrote:
> The '/' and '%' arms of the operator switch in do_setexpr() perform
> a / b and a % b directly on the user-supplied ulongs with no check
> that b is non-zero. The consequences are architecture-dependent:
> 
>    - On x86 and sandbox, integer divide-by-zero raises an exception
>      (#DE / SIGFPE) which aborts the shell.
>    - On arm64, arm, and RISC-V, the UDIV/SDIV instructions are defined
>      to return 0 on a zero divisor and do not trap, so 'setexpr x 10
>      / 0' silently succeeds and stores 0 into the environment
>      variable, which is a plausible-looking but garbage result.
> 
> Neither behaviour is acceptable for a scripting primitive. Check b
> before dividing and print a clear error, returning failure so
> scripts can detect it.
> 
> ++++++ Before Fix ++++++++
> => setexpr x 0xa / 0
> => printenv x
> x=0
> 
> ++++++ After Fix +++++++++
> => setexpr x 0xa / 0
> Error: division by zero
> => setexpr x 0xa % 0
> Error: modulo by zero
> =>
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

Makes sense to me, though we definitely need new tests for those, c.f.
test/cmd/setexpr.c, so we don't regress in the future.

Cheers,
Quentin
