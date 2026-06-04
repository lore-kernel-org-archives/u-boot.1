Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C18CD6E68
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 04:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F5FC8467E;
	Thu,  4 Jun 2026 06:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DDf9pIOo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF235848A9; Thu,  4 Jun 2026 06:13:58 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAA47840ED
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 06:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2+IfPivpbwmY7VvwbVn9oPNxijs2ihvBKsKiU0q73PnH8Sg2ddSElxOtrqYJ0ADUNLE7Lxm/E4ORBvUxD4LD12hxKUu0FI3b/rXCBPyk4f+Bh+x4EG5x+zCPMYXPG4jPRfgVzhJU2yWs4mfmbH6NA3rkezMS+UePFsuPwnkLcB2a5p9iaLsGU0Sm/uTPzgE7Ooi08hgyfgJHCEdwUai6oP9uQERtaCvBdLUWxDf7oArQvb+CJIIUiEQkYRp+NLwzVu9iDLP6u6IUn+Gc7yBWe+IW16bPDEsLNqmMUfadnEK3ResqbTDaSfJjGSkEfvZTxgcEcy60ZJNWt04B29I+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fidzIyAhMFtaq5RTxJPggF0f+W7mmmfb3ETyGRKT6E=;
 b=K9jNLqEJJFkI4iTXhYwdKuhRu/jgidcl0rMyvuECrgWjyWKimRsAt/OHIYGBo0fFJEQU+ddW29r+Yv8gAR72af3NjCoYSFQ0L454Uf7TLVDOTDS/ehkPn9laYRKgO7g8c5u4oOQEuRiywijVYIpIrWub9icDjjCtsj6Vy7gFZyBVQHjsuK0Bm3vKMAGjzw8+P5kp83yHoFvkCTHyoICrqhyZzL5KLsDI48naIp8IdMeWsIzVlShjp/RIvc+vXPnEM5/rvPYrg4YKqUHBRsfOXLalmNiSS4nBWuNICS0kbt3h2Yl4klVv9fhK9ScuaVv5g3WiUgH6IeSZjNn5p98R3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fidzIyAhMFtaq5RTxJPggF0f+W7mmmfb3ETyGRKT6E=;
 b=DDf9pIOokn2NjJQL1LkMxMvJyokhIrhUSSw40mNPglZSUroQ6UuQzSZG8S1TLlO9iRluGR8IRxNW+ilca7nl3X0kgPE1joP3e8jt+kkqS6bZqTTJ48em4NdkQaX4Ly7cc96J7i4IgA5FzjziMAl9M79HhPMassn8mZRkk3+Qb4BFXED22QG8IVyq9jkQy3fSQ/oOFK6Yft6tr34VMd12ZqgFuaQ0symmtLcmFsvhn/Ba5w/3nZ2Q5xuSo5sn+wo6Uwk+eTXWe/VbFlqLKT0GUNyAQnfCuitDFtDOk3HYBrzN209Xw+6GBf3Vo0vyuqk2ni6w1SY7lSLKX++qfpE5Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by CH0PR03MB6115.namprd03.prod.outlook.com (2603:10b6:610:ba::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 04:13:52 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 04:13:52 +0000
Message-ID: <a8738356-c784-4038-b255-607f29ec4c02@altera.com>
Date: Thu, 4 Jun 2026 12:13:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/9] arm: socfpga: Move firmware register settings from
 source code to device tree
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260518011245.19083-1-alif.zakuan.yuslaimi@altera.com>
 <20260518011245.19083-4-alif.zakuan.yuslaimi@altera.com>
 <d79e4b7b-9e38-410e-90a7-0f9cc0ce9899@altera.com>
Content-Language: en-US
From: "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <d79e4b7b-9e38-410e-90a7-0f9cc0ce9899@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:196::13) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|CH0PR03MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: 81b4594f-1740-4c5e-23f0-08dec1efaf53
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|55112099003|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sKCJv5caaZyetaYlKB/5u0F2hD8nMBPEJxLwA7Ia5rDqpZkT3yIDmiVQxJM5yE5VFur3jurylA4OOwym/7mAw2MOxjV/Tm0zO6iKg+9IvFBHJ4VYoO46DyZS5iO9N91iFZIKDWwuBICznUh6dfJHvIQniXoErDdE4Xm+XpmiYoNa5P77de7SQDaYOJPvHQrfOt3XdEUv03lqnsyitUr0jNuBiPwYy/dFI7rMDJRwoCPJmYk+1T3sremRubtKqpPFZE7QlC39uWJ/SgYYldyi/990O7aqNAxS9H9PJmW3VZ4po0zi9k3CrQ1IclZYeVJkst9g/1ZZCGUWTzDowY5RQMa5zh3PJsl/G7lClmTq3CuCOnSlxiGdVL6+O7EovUnxYIfWuofSRRF5POjp9exB4uwBTKubyUwz9sQOYLI6UJKz8u9A6HYXz0xVEY8n2+ak5pkF5ld8thXdiuyCq92hHyYI2oG1E+1DOkGHkmKcLQl4A1Zt4FxZ+QQ2OsYaHwsTqSjoMNeHwbwsX8g7k5xT+j5sOW8qcE77JWd1lZhsBGXyDtFx4Ud87UPqyOwXpxNQkB+5KrSpSs6lk2heQ9roe0Js5nj+S12Zj1Kdp5lW+Vr2wpCsRPI8PAtQRl1kRyWFaT64YAjZAmiMdAKCNlBIwxUPge03SIxYWFRgv17ng2PMs0Q28frWNrkhVUXYvvi/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(55112099003)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk9TNk02MlZMMkhkYWdDTHZHWUZTcld1NWRINUpZeE5zZ1YwUkJjZUVkbmJD?=
 =?utf-8?B?a1VnK2lla2lMenRTRUFGbGxCc0U5S1pLR3UyU2RYYWlVRWx2WEl6VzBuTVpj?=
 =?utf-8?B?TmhUWTRpZkdEUjJxKzQwNkVMbVBSTFVpU0x0dXdjbVJ1a0YrRkU4WW9teFRX?=
 =?utf-8?B?eXVYT0tRRDVFVURmM0JEU2wwQ2JqSWo3NTR2cExLNWpGdEN1Qk1NYUNoUmdD?=
 =?utf-8?B?YjFIWmRFLzBYVEY4d0NUUXdUKy9QWTlkVGdTRnY3S3dpdzFyQ2JBUTBXMm9j?=
 =?utf-8?B?UXVON1hhNm5zeVZ2TWt4QzFHQTV3OXYrbE1QQy9qWmJCc2VkS3dGRnNlbjZw?=
 =?utf-8?B?M0sycFY3b0RSR2luWjB0S2ZoQ3pNZTJwdTRqTURUZW55V0ZpWDYvNTdOWDFv?=
 =?utf-8?B?ZWZEQXQ5ZnVrMWtOQXlPZmczWCsrN1E2QVo1UGRrS2o2UDV4T1U1K0ZtcHpj?=
 =?utf-8?B?dkgvRHB2THkwVWNBS2pPRE5TMTFKOU1oTDE1b1VGZklPRWlVSHJXNDdKTXRn?=
 =?utf-8?B?U21LSkdXand1bkZyR0N2cmgvNWtYVzZiVktnMFF0SmtvNGtpZVdyZlJWaXU0?=
 =?utf-8?B?b3Z2UVptTUN0a2NDOHUxTWV0cHQ0L0dFTG1lOEhkRGtRYytuQlY3M25zU1o1?=
 =?utf-8?B?Q1YzbEhmYjRweDN6a0tRa0dEdDFTWmR1UVVRVnMybkovV095WkI2U1kxakRp?=
 =?utf-8?B?eGxmZkVBLzBXN3NkN1ZHQ2MzbDMzdXJYUnY2Vk5IL1F1a0NXSjlGM0xQRUxD?=
 =?utf-8?B?akFPQXloSnNQTHo2ZnFIa2JGZWhkTEwrOXN6UlNNMWlkYWpETU53Z1JRZlVK?=
 =?utf-8?B?NUdSVnB4azJCOVo3bko3RE9wWlFXSHkyY3VQRnZiWDlWYml1UUdWaGtLcmFX?=
 =?utf-8?B?Tnc5SzRLNlN0c0t4T2ZPRWRyanRQRDRTRWZYYk5NY3FQUjlWQnphNmlLTXRz?=
 =?utf-8?B?MFhJc3VJc1BSM3hBRzVMQzluLzBzYVNIdThoUzhmeGZhM0xyRWU1cVQ4VXNy?=
 =?utf-8?B?SnB0bW9LOE5VTTI1SWhUQjNnWUZnYjR2NnhoQlpCYjF3VGxwVlpvWEYweGE3?=
 =?utf-8?B?RzBwWEZPOVJ4akNzY1h1OFNnR3AzU0lDWjUvNWFzZ29GZE5QRjJCazB2MUV2?=
 =?utf-8?B?Qllabzh2RzJNTFpFQ1ZPNG95TlFtSVV5VUE5NmpzUHV4b2Z4QTk4VnJtS2Vn?=
 =?utf-8?B?NWZBRTRhYlBiWUcxeUcrenZNMnFHV0ZCOEszTG5YYk40NWo2OVYrM3pCQkJw?=
 =?utf-8?B?QWg1N3dZSVBrV212VmEvc2F4aGhNcUxObU1PdC9PWm1DQ1hENnJvZmhpQVFs?=
 =?utf-8?B?MDdKUEpycGJrenZYUFFzcGx6OGpWRFBpakNxUWtNNjE4RTB5aDhKdjZib0Er?=
 =?utf-8?B?UUtST3lUT3dHa2Y5TWR3czc2eC82aFNVUzJIN0lhaFo3ejh0VTFmMkpnUWl3?=
 =?utf-8?B?T2xLMkgrWmNPdXdSQXdHY3BXT0dKNWNBaTFsVWkvaFlSZElzd2hyeEdMZmpQ?=
 =?utf-8?B?enRQZmsvTjFQZjN1b2x4UFVXMHc4TjQwZGw0UEZQUVVwNkErQzZ6eGszNXNk?=
 =?utf-8?B?Nm5QM3lzOXpwbHVrcGM2b3ZMZVZnaWMwZmlBL3A3U2NIYm96QU83ek1Bai9r?=
 =?utf-8?B?VnV6dFg0RExOei9qbGhwWHBUbXFHTUNRcUNHWGR6VDlqNndCb25KdElQNWdh?=
 =?utf-8?B?WDZjb0VNaVhvcWE0K252N0RIR0RRNUNwQXZmWGpjdkc0L2wzQ2xSQi9Ud3RB?=
 =?utf-8?B?alhYTDRsZXdUbFU1OFgvV0JJenpRbEwxZjFyZHc3dVlock9oZHQ4NkQ3bjhC?=
 =?utf-8?B?QStpTGw0Q0w4dW9EWG5nUk9kY08vV1NBeVZSMndhemgwK2t3Z3BKYzZ2TXY4?=
 =?utf-8?B?TFBpeEFtZ0cxSk1CWDVpS3BDUDdSby94dmMxS2pQYS84Rjg3T2dZc0orMlRz?=
 =?utf-8?B?UTV0Wlh5L25xRHJ6QnFXSXE1a2dmQ3N4QVk5S3VmY1RQNXFiOUJrNnVBRTZP?=
 =?utf-8?B?b0FGdHl1OGdmaUVSZm1EZmZVc1kwUHFpUTh3Q005MytpTm04a1JvbXYxZjBN?=
 =?utf-8?B?RGVHanZaNSsxRThhM05PSzF2WXBaRFAwNmswLzZPWUdMNkRlWFdUQkJhcnkx?=
 =?utf-8?B?M1JPVmwvV2hWdkVVdHgyV1hSVTA0cUZwWlVaSDBqc1JrbEJBTUkvbjFxRllQ?=
 =?utf-8?B?MG1BcnZ6TXFNbzk0a3UxMGYvZUZjejd0NFpZVExUT040V2N3eVJYaDAvU2wv?=
 =?utf-8?B?YXJEMVNjdGZmVnBhbzRTbWJoTXZLM1pWdlNmUnBjVTYybEtLTloxK0o3YWQ4?=
 =?utf-8?B?QjRKbnd6WmFEcyt3QWcvZlJjeXV6V3F1RW5wZXh2dTNSWStiUUVIeVN3U0Vm?=
 =?utf-8?Q?NM/n/u7br+LQp6a8gdiVvh6/k0x5UqWpxGGZn?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b4594f-1740-4c5e-23f0-08dec1efaf53
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 04:13:51.9770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmNTfaM1TALNlK+S2n/SW5MZqSqGqsMhfz9Wd2V55m3PP2m2ctBLo96018/UiUPdlLdgpUmoFXL3SEOdzUt+rz4hzQDJ+V+JzB5Jtd1CAg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6115
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

Hi Tien Fong,

On 3/6/2026 3:35 pm, Chee, Tien Fong wrote:
> Hi Alif,
> 
> 
> On 18/5/2026 9:12 am, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Migrate the CCU, firewall, and high privilege register configurations 
>> from
>> hardcoded values in the source code to the device tree.
>>
>> This helps to centralize hardware configuration, improves 
>> maintainability,
>> and allows easier customization for different platforms.
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> 
> Add at least one header - L4 per/sys firewall moved to socfpga_soc64_u- 
> boot.dtsi (same tables Agilex uses); replaces firewall_setup() in PARENT 
> spl_s10.c.
> 

I will add this point in the commit message for this patch in v4.

Thanks,
Alif

> 
> Best regards,
> 
> Tien Fong
> 

