Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCD8C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 17:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CF4984C66;
	Mon, 13 Jul 2026 19:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jPg6eAoe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F277184C67; Mon, 13 Jul 2026 19:47:24 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DB9484C43
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 19:47:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FK97TLuWkz5c83uBs7pYQJSstedr89F4pWxdcvONRaPkHWBcOj2EYq/6kVCzXb81joZFT2TOXCmV4zyCGOHeYmKa/pSCzvo97SDosPET286gNL64G+eEu0tUCY39TTjCtnoQv6vpE7OE2bIXBbVWjBC0EuO0/B8uy5XceM+R83s8NYgCCdaIZsiQjClXgde803RANkQKPCPGDiq5cWLzRL4a/AzUzHxuRet41bCuNHXp2lwRbQwMvfIcqMfiYfr0Swn3tbdCFVdmW4m68jE0g8Xvoy3WMo8ksImf2k2vUbn8fSm23q87pJiPzT7XHWpnd++whlVQLQmQyXix35oukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+cfsl8a7itny9uCB+GMaI3xm+OCUg9weH6MOXAdE2Q=;
 b=GlcrS3nX5PK0OtWfo5oe5v5wXc0jy4xzo73a/z1eUjVev1TdH+avjX089gLdb35jpZhyXt7WEz8YY3xg1lX3KCduqAKeNV1zUNg4a47ttBR+j2xIT1VEwSzbDeIS3UTS8TOUag0+fq2tGr4U9u8/fvkO1KEq4miI3iTsTTsQtFFFFETMm5rzX5AGoF1ge4QOatX4LkpM7RSW7LlPGw+jVlIBHGQURn/y9ytxRkIj4LhjReQad9kC/HEuQPQXpVV/zOooQlpdhdVTbdj/MLZXjYcF8CgPWt0i20ykOBLZ85DXSxKLKvkqWTfhTzwVG7YqKC3osYXAK7+SOdaxTljn3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+cfsl8a7itny9uCB+GMaI3xm+OCUg9weH6MOXAdE2Q=;
 b=jPg6eAoeummxb2N7wpPLyvkdmYuk92DTstNQpmuFOwhBqJOUU0H6oW3YH5V6Hi9s+kfFT1NmSfpDTsktPZHAny31jo0ug3P05htm9cvjcZk2QBRWXX3anp6YWE2PG3BNOAJNblrNzXsD1mMKuhDEEMhXtfyNAKj0iOYpCa5KBnYLBZy8lXJjKNY+iCBmaS8n2Zfh/CGk6fnkNKpToP/Ki92qqNNyB7rbNOxue7LJ1GV/lgYh7opBq0x/b+A6Sp0xd+YDLJSEAFzsfjBE93ury3HOgfCpX3jE7WI2qtksVvm0tPB4zk6SKuGj0hvD8PYc6I9Ug7AFGRK+myqGhXOTBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB7655.namprd03.prod.outlook.com (2603:10b6:8:1f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:47:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 17:47:19 +0000
Message-ID: <4eb767c1-7e66-4caa-a786-459a15bbfdc3@altera.com>
Date: Mon, 13 Jul 2026 23:17:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] mmc: fix mmc_poll_for_busy() false timeout when
 card is ready
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Jens Wiklander <jenswi@kernel.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Yanir Levin <yanir.levin@tandemg.com>, Eran Moshe
 <emoshe@gsitechnology.com>, Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>,
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>,
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, Peng Fan <peng.fan@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
 <20260713-mmc-fix-v2-1-b0ba3b4a8d97@nxp.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260713-mmc-fix-v2-1-b0ba3b4a8d97@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: 59d1f01a-826e-46a7-fb05-08dee106c8c4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|55112099003|18002099003|22082099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5wannTjNPgs9ak/ufjgDHlNOM4RNzJQd/ZqE8dr6cJLKnIr1YzY2cUMsCKo5QEAe8czzGShr92w+v9qT8+4QiTcgXhut1EQBTtpI8DdRz7erCW/HBPANinhQFS8cev4Q1JJ9A8cHZC4Y07KRk7s4E1WEykAJyFTILBrrU4ln1pqHQz2Ri5qXWlQ16iGwb8x1ofVVpTCT6ZPtg3WZA2uHaXj1+ULLR8MP98OCDOg3iD067ZJLXgb2lK7PlbiNfsjF3N7XAqyohVoQsk6OAca+HJeNcaJst6D6Lzb1H/fJbXyegYTpUfpc8aJjGbxREoW5r2tREOqAWZMASDBT2+nux2hhRDBX/UZ6AAs5P0VvCdCoZXevEABtyGAdo+48AM5C1wSWumDC2x/x+suMhGEEp6GgC3kQqS7dLhryo+hNSVyUHpavKZ6asXLdVCVSiaf+hfVKFERIrTQOB4dojuxStU7c09TD0FvImGlws0KU5RRqD21DCJ6MLQ6oP7wXqhcxzTBbZcQT3JFz48m+/Va3E3t4sOlc4jfFwDSfAJCfWZ2aML0hu1//ZECC7hb+9XffnAl2U7qgHOK8V0IwMQ7dl+VQmYN9WmxpEtFDz2Wgau9zaIN3zdJ/rRVFrzVAoJMvV09rJbqtBxBA00O9GHX4VCP9McEym5ML5gi1/Zp0J0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(55112099003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUkwRkhic1lMb2VsdllQcXpQZmZDUWw0bHF4WE54T3NHanRuNDVFaDZoRExt?=
 =?utf-8?B?UnZheUxWUDJ6SWZ5RExyRHViTFdkanI4UXpTUGZLdHVCMXk4T1g0OUUzT24x?=
 =?utf-8?B?eXBDaVA3MnhOcmVjWk5Cbzh2VlN4c1h5QkdOT3IwK3BCVlBTS1dacGRUZ1dm?=
 =?utf-8?B?akk5eXdMd2o1V1FZTXlZWE5uK1JSK3lpblNadFRNNkhnTlZkUUhDVzErU2RW?=
 =?utf-8?B?ZWJ2U0JkTmVUUExPNU5Xem5TVk5jdFJzWHZmdXFVWkJUSmVNeVF0VUkvZTlK?=
 =?utf-8?B?TVNzK3Y5T2JpenhWci9rNWxpRGxRT0RXNmpMV3NGOThsblgvYjVNc1dXR2x4?=
 =?utf-8?B?YnVBUWpvdWhsZWIxbS9qSnBEYWVoV1RvNGt2Qi90aTdyanpNV0tBbXMwSCsw?=
 =?utf-8?B?bm92dVJPcURHTDg4YiswUnhBczFpZTdjTk9xSEM4VUZ3T1RZK1VURU13bnZ4?=
 =?utf-8?B?MnJJOUtTSml4S3g2VjRGNW5LVUt5YXU2VHFVZ0M1SUZzY2ZpTjFuczduMXg4?=
 =?utf-8?B?RjF4RDBxNEV3bFRYd0lyU2hwcWVIL1J0TlBLajFSeE9tMnhIMDk4T01TTFpL?=
 =?utf-8?B?VUVYYWZEVHJadzR3WVlWbnJreFJ1UXJ0SVNwaUhpc1QvM2lmQVhUU2tEQytU?=
 =?utf-8?B?S0FyWjJ6SExqbklYSVpTYkcxTmM4Qlp6L05wU2xGQjBBZm5QMU5ELzEzclpY?=
 =?utf-8?B?VFI3MjhiU1QrRW5ieFVwQTNsNXF0RGVzMldPTmdtdzJRUDJabzViaUZZSkdw?=
 =?utf-8?B?alZtUlhwYlhZTkVUdGJxYzl3S3NBQ1pQY2gyNURaajJjU0owZmorSGE0RDZJ?=
 =?utf-8?B?NzZNVXZOUTdUYmtOVHlMc3JsaWd3SXVvVUdxQkR4RWJaZ04zdENYMm8zcS95?=
 =?utf-8?B?Z083SzNRZDBlTVFjMVl0N0hnTUFFcUdjNUQ2dC9MTUFxZmJIdHFpMnF6RHdD?=
 =?utf-8?B?SzdyWVBkMzFlQ1R4SUhBL3R5WUdIZVY2TytWaFJaV25pUllqWEc5bUoxTFZE?=
 =?utf-8?B?bTBJblFoR2UreGtDRjNmTlpEamcwam1od3F0dUF0THM1MElnd3BOVjlBMHc5?=
 =?utf-8?B?Ym04WUNNaFozVHdTRCtkbkhkQXBGdllwVFRLMEk5TjRINzU4TjJJaGNJc2JT?=
 =?utf-8?B?WCt0ODlrb0RydWltTll3M2RqYTBrV0ZUbXg1c1M4MHI5M080bG9Ib0padVhn?=
 =?utf-8?B?QTlQQ09HTUhzZnpTWTFRUGlzT0x5U091Y0FUSG9ZWlNqMEtoaXE5clQ5TC9R?=
 =?utf-8?B?R2N2V1ZLQnR0eHljRTEreFRGeVVINnZRLzg4Vmtib2xxV0lScnpIdHZoNHJO?=
 =?utf-8?B?VmdJQ0V3cVZqdHI4M1kyVnFaZzViZDRFUExmaUZFem1ya01qU3plQmtVTjdI?=
 =?utf-8?B?WUpPdEhMNzc4YUIwQmh3U09yUTJ0ZVhHcys4WHlFSUtDb3NwVndISHFhNzlv?=
 =?utf-8?B?YjNEbVNwK0tTVEpCR053RnN2ODg1ZjlvY09wa0szK1VuUVdVNGR6ZjBKRlRM?=
 =?utf-8?B?aTUwbUVFNHFJMW1KQVVQdkVpWEhPZVhxelZYVmlUcmllU3lzT2VuQlRyQU01?=
 =?utf-8?B?R01ZL09KVkV1V1FZZlZPd21YYUYrVUJZVzhBNmxmcHFyMUFwSmtKODZGU1JD?=
 =?utf-8?B?VlVmaDhOTklJeWd5RDFicWNqK0d4UXBYK1R6L1JuWWM0dlFQNHZwdmg5MS9T?=
 =?utf-8?B?SG1OanQvQ1E5cXdZS0lmTGFReTlRWC9IbXFiOENRa1ZjTlA1elRqUWN3VnRM?=
 =?utf-8?B?eG1WeGt3SEJXTVFvdnl1TlJWMTRnbW9vRGtZZDFoUDlzK1cwUGVVOFlIWURF?=
 =?utf-8?B?ZnB1RmNBc2pySE9kOTIzM2llTG1ycXpBUys0dEhGbEFsRWlrdURLRE9ZdVdz?=
 =?utf-8?B?aE5Sd2xVNy9vR0pWd0l0TjlYMnk5RGdvb1RvZUZaSlhPakxvRmZkT2NvRXRw?=
 =?utf-8?B?MzNHVUU5Q3FaR2M2a2VHdlUrVDdnWWR4RjFYVmlHNlM5a3Fya1laenlKeHBV?=
 =?utf-8?B?Um9XZUVGc1N3eFpzS2dURkJMWWxPWVRqbnNFTEFIOVVFNTNxNXMwV3RrN3Bq?=
 =?utf-8?B?RnRMKysvWlZ2M01qVWl3bHlKZjNlaSt0dGFpWlJYM24yMGVhSlJqYTk4V3Rj?=
 =?utf-8?B?b1o4Y1dkQ09HY1dFY2YzVkFrNlZNYmtkTUJIMy9xbUtpVExrTi9iNG0rNDY2?=
 =?utf-8?B?Z2tYcndFRzFDMDVVYjdzM3B0Y2VJMXpveDVXQXNGd0RkMTlOdkZUK0Nsc24r?=
 =?utf-8?B?Qm54Ri8xMjZjZ2J3VE50TUNPNHFXM0NOSXVLK0VpOHVUaUtOR3RIZnpZWW5S?=
 =?utf-8?B?TzZDVWRZSjZSV2Nad3IrK0R6QjBnK0dycm01SXpUQXBJL3ZaZ1V2UGd3OVJC?=
 =?utf-8?Q?lpvhubMx6DMgSCY0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59d1f01a-826e-46a7-fb05-08dee106c8c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:47:19.1477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e3i9SL32mzv06ZnQLcvbHII/l4ORe6NeUN9pJ8d8jZ6F1RZ3tdOzcovW4ttQAzoTP8OBuhQ41vuMCf3GpJ3vYzabD2vunUDYVENebUVLUnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7655
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


On 7/13/2026 7:02 PM, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> mmc_poll_for_busy() returns a false -ETIMEDOUT if the card becomes
> ready on the exact iteration where timeout_ms reaches 0. The card-ready
> check breaks out of the loop, but then the post-loop check
> "if (timeout_ms <= 0)" fires and returns -ETIMEDOUT despite the card
> being ready.
>
> Fix by returning 0 directly when the card is ready instead of breaking
> out of the loop. The only exit from the loop is now the timeout path,
> so the post-loop code unconditionally returns -ETIMEDOUT.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

>
