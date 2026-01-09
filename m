Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B46BD26D68
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 15:17:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB5D68432F;
	Fri,  9 Jan 2026 16:17:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="h+HuG9e/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CD8C8435B; Fri,  9 Jan 2026 16:17:23 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05B608430F
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 16:17:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frkkpvaENq/GzweAv/BVDPqucW+L1SSlgWjHvZ6jYC7/WEqPDqKJh/qr2rGKn0GO4kO2ltA8+Eq3OZTwLF2QO63f3qjyv/dwnVcRp/lPhgs5L2qcfux+b0xgz/f2P0xggbPPReB4phedoPE9/PfFL2rc+DPMZD6q6jh7TgmPXLB/T3zv7INHglGz71+ULIxrUCDGQ1v6ZHwzuahuF48bA83ueJ9Krcd4XP5nvAf5xW8iYkAdjSSpu2KGtSubdl3OWZSnIZZFDHr5R8ErWENIUxD4rg+tEUdBUPH5DPhcIs2sVtYQJxdODZB9YrMCm06eOupvZ30+hvZ1Dqso4htkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9ImOOC64v6Rg89KPUoqD16/ts9UkSv/zIIxgMOaA5g=;
 b=HZGRxiU2YJ5lTPnEq2RBaqov3tjZdw3e7T+7C4lS09HfhbKan+FaOhiB25T1PruKCz2yyseKChtekix3X6S95bMchLf8zmqYIjaklkPMMMyx9RiRzKq56SJobo90aO1vJuCXzqdjlB/opHAOAlN650/NtmhRHx7HnbXLSshqa/0K3HK0JE7jyIdiMPam8ok8tAyv5qNVqm8B8r8YT+Z7lcYKOwhCVxpZTBdGtwRBHnXEIwXmyx046Ne7KV/mFV81dbQJsN+4uMqrLdFgyNYXjxK5A3w5gNn15t6OvOXHpVfk3p/9StzLgLwuWCqkXZs7Vrh1zoO3CAD78znHU4WtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9ImOOC64v6Rg89KPUoqD16/ts9UkSv/zIIxgMOaA5g=;
 b=h+HuG9e/QJPM9KnJZIXMYBA5fb6tkCPpcTT288QlN3bbtaGQipZE5GRmG7BHUtDobIGIy0vX6LFdfPETMHuncqgrKjcs6VIdlzdj4urX7aMBImgKowH5JOnaRcONgUo1YOZ7N/4H3fqk/cOat6e3SK7Y+N/BzD/BaAOPJSCjhrE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7857.eurprd04.prod.outlook.com (2603:10a6:20b:24e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Fri, 9 Jan
 2026 15:17:19 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::1033:5a9a:dc18:dad%4]) with mapi id 15.20.9499.004; Fri, 9 Jan 2026
 15:17:19 +0000
Message-ID: <81044800-b1b4-4f37-911b-f94ea3c8a761@cherry.de>
Date: Fri, 9 Jan 2026 16:16:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: unclear license identifiers
To: Hal Feng <hal.feng@starfivetech.com>, oliver Fendt
 <ofendt@googlemail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Minda Chen <minda.chen@starfivetech.com>
References: <CAFoF8fC4foffYJgYm9CkViET83gDu05noVRxLxgs+KWXN_-LBQ@mail.gmail.com>
 <f22fe5c8-d98c-4b20-a9b2-a8a5af1542b9@cherry.de>
 <a1a22e85-8812-4064-8b9a-d779884edbbd@cherry.de>
 <ZQ2PR01MB13072ABFAC3D77E8D781C19AE6822@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <ZQ2PR01MB13072ABFAC3D77E8D781C19AE6822@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0159.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 054d4e4b-24b9-4a97-a387-08de4f922e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aE9NZjhNZ25UYlkxY1lPMXUyLzRPNUtpSklDZldkRHMxcDByRzR1NXNOY0xr?=
 =?utf-8?B?eTNIb0RHc1h5b2x6RWxyRlo1NmRTNzE4cXJrYzVtdnp2OWRVMnltMlVPNkd5?=
 =?utf-8?B?L29oTERWU3BpWlkxeEtBMjQ5NVNIdWFraUhrcy8zdkRLcG9OZWhIRFY4cVJM?=
 =?utf-8?B?OXV3VUdLT3U0THprbSsyOWlndnZkNDhjelVlQzlLN2g3MWhXb1B0REgrWm40?=
 =?utf-8?B?OE9QN21lbUJxeHF4S25ZQmRRMVBnU2JrQk5tMXpOSTg2L0NTNUNOeGEzanUz?=
 =?utf-8?B?Ym5JNUpObjdXRHRyNzFpMUM1WHFHQzNzRm5BRFJ0NFNEYXNsVTZmQ3NKOW1B?=
 =?utf-8?B?czduSlBVTmJSZTRSTHNaaW5yT0Q2a2VQSVRmdzNJcTV6Z3J4aURrck44d0hH?=
 =?utf-8?B?Ym5aR3dKM0g5MUlRbzJrK01RZGJWQk5YMUUyVFl4bGZiVEV6aDRQb05OSVda?=
 =?utf-8?B?eFNIRk8zQ1VYOWFobzF2eHV5VFQvR2hxbm1GMVZ5aVZCZ2N0ZWZYK2x3Wlh3?=
 =?utf-8?B?ZUVaMzJ2QTlNNER6aS9Kd2FnTGplS0VYRVJWclB5T01FYkkyNktPUEdrWjl3?=
 =?utf-8?B?Q3kvbm1aTVNTekF4OThlaGEraG1EbXQ3MVNDM21xbEFQalFkdWVHdnhXS3lE?=
 =?utf-8?B?am0wYTlXdmh6RmVKb0xlbUd4UTI4Vi9xNWZpWUxGb2xHZExxM29DakNKUUZ1?=
 =?utf-8?B?U2VVTzhPWlNZeU1Ea3pOUzN2MDZLcWIrbENBY3h5NXVYSUVFanEvdUNLeFhh?=
 =?utf-8?B?bnM5TmQ5UWFoSWpwQmxTNFdIZ2xJYWZFWGdTTmtqeDZoSTU2V1crMHYyNGlw?=
 =?utf-8?B?UFR2Y1RGVUNMSGNEcXFzR1ZlSmIrM2ZMbDF2bFg5R0R4WWhhRE00bDJUREZE?=
 =?utf-8?B?MFZ6WmJ6Q1kyVUpOYnNXamdCV2dHWGVSUGs5bDV6L2dTajNPK0p4aXNjanQ1?=
 =?utf-8?B?WjFxT0x0d0FaZFZjNUJ2RTNQVmcwODZQSnhWUzNscHFOUTc1OGlUcWl2U3Y0?=
 =?utf-8?B?K1hFbXN3S2hFdDczWUZGbWJJNFdEalJrTHFKOW8rMVJZRXpEQ3Evb1phSkxo?=
 =?utf-8?B?UVE3c0pUU09qbW9LNFBJbDBlL2UxNlRHNy9NMkt0Q2NHQ0U1TlVTY1lNcm03?=
 =?utf-8?B?OUZOOHhLbG94TGRtZ0ZMQzVYdjBZempINXFVK0U1MlBadm9EVkxsQ0NsQnUz?=
 =?utf-8?B?cUVjN3BCMUdKK2czb3ZkWWRaRHFyWTN2V1NYNWlYbUI1ekxvVWVuSmZ0eEFX?=
 =?utf-8?B?Y1pOZlZTYy82NE1hL2Y5NGM5d2JMNXpHUXZLUzg2bFhqY2ozcVZvWFJhRFk1?=
 =?utf-8?B?OFlRSDJmTk9tYXdHOTczMHkyQ3JHbE9MSzhoekxvM1VQcnMzdEhQMGlVays4?=
 =?utf-8?B?V1NSaUZJOTJaUnVxdVRHU2t5TzZIekh6eko5N2xHOE9YRmFnenNLVmJmNVBB?=
 =?utf-8?B?Nm5jMDNBQjFGOFJzNUhOZXgwYmlJLzk0MzAyMUMvMVd0T3NMQXd3VDljQkdj?=
 =?utf-8?B?d1lieEU5V1R4RTN6REw5cEJia2tWY09PRHZMRVI3SDZDeG9oSjdlUFpKTUFC?=
 =?utf-8?B?ZElyL1NVWFBVTHBEYyt6bnpvOXpTdEVXa3lycXl0MzVwOHZnOUkrb3NqZWVo?=
 =?utf-8?B?RjJhYXhjcHRPcWVWM1ZzUEswUEZhTVRuRUxyR1ZibWhyZUZLaUZkWEpteEt6?=
 =?utf-8?B?dW5LR0RUTGpYK0NmTnNybUJtdUFwRDBMK2k4OXlmLzJqOEVpV0Z6c21ENzd0?=
 =?utf-8?B?U2xYbXFqV1oweEJTaldTNjBNcHZRTlR5T2prV1ZYcEN6Ym9rOGZPRmxnMU5m?=
 =?utf-8?B?QnJlVi8zSkJxMkNHZk1zL0lBa2RSenl1aWZnL1VBYkl3dlVuRFhjaUI5dnpa?=
 =?utf-8?B?c1JxbUk1TTBBMTNNeDIvUmFNekdmdUFtVDY1WXVCZzMwV1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGt2WVl1UElheitlSm1yWDcxRS8rMHV4WEFNc0Y0ZXVVMlZJejZwK09KTkw0?=
 =?utf-8?B?MUhEZWR4U0F4UHVIV0Zwci9JeFcwTGFVcnFOMWtmV253SnVsVzl6MjFwWFNY?=
 =?utf-8?B?djJoa01USmJtN0hBbUEwdG1uTFF3eEhTblNaSGd5UWdkMkJCSE9DZEZ5bUJk?=
 =?utf-8?B?MnppWUczdWdoQ2NPUEJEeUlaeHhuSnlTZ3h3VlhJUHBBcWNWWk9jV3hUblht?=
 =?utf-8?B?QnovbGxGNC9yVkdNRjZBQm1OcUJjbjJFTGtCdFpYcEc4MnpsL2lVNWI2RHNO?=
 =?utf-8?B?Rk5Hc09Ib2IyaXJkZE5RbzBFVHpPYTYrUzNXY3hjMmJ0MEdMUnlENzBWL09l?=
 =?utf-8?B?OUV2ZTRnSWtuZUY2aWpzaGw5VlkzSWVDRWNXRW1WQm5pbVo2TStEMVpoSDht?=
 =?utf-8?B?Uks2UkFNRHJwMEsxQ0Y5TUdWMHFrVGtMSU1CbUdOVHZIeEJ1Z1JwMnBCOWgr?=
 =?utf-8?B?YnZOVm9YWFU3YWQwVm9hbjhBUERHZ29XU2d2RjF1bWgwK1E3Z3dyTnpJZEFz?=
 =?utf-8?B?elpoNDBjTGFBd0Fqaml6M04rdVg4RSsxcGhxZ3NtQ2RWSWI0ZXdoT1J6THo5?=
 =?utf-8?B?MUR2bDd6R0J6bGdrNlUwai9wOGFwSjhobmhQUzlRUHExemJ1U2lPMGd3QXZ5?=
 =?utf-8?B?UlNaeVdZcjB1MjBSZFlVNWY0VFZMOS9yUmhZVUtpT3RpS2oxR0xtRzZzd0d5?=
 =?utf-8?B?MW5wdUV6ZUdGS3FUdFZLZGNtRGV5UWErbzJqV0hEdjFhNkcvM1AvbGU0TnpQ?=
 =?utf-8?B?S3BIdUxHUFhncDlvaEtObHFjQ1ViN1d2VHppK3RzbEMwWTY3QVFTcjkwbEl2?=
 =?utf-8?B?eldnU1laeFhoKytBeklKdmlremI1by8xOG5DcW55ajU5QzZpL1ZycUVzT0Nu?=
 =?utf-8?B?b2xPQ3RHNkxFME1HTFBibm9aYjdDK29RM3lJd25BTkYxV0VvN2k1dGpZZ0dC?=
 =?utf-8?B?eUNCNDFUMHFEYnlpU1hFK2t0ajN4WFBmUm1NUnVQSFh5VDRHVVRhWVpSNVZw?=
 =?utf-8?B?WldwUHByV2hpYUtzUWpJc05weE9IeXgvRHhyaDh3cnRoRHliV3BjclVmaWxX?=
 =?utf-8?B?LysvRVl4NXVXNXNzbVl1QlhjTVRBTitUbnVtTXhaN1ZKL2pwOE42b3dENm9F?=
 =?utf-8?B?MVRtemVST0h3MEgzVkVDeEZlYW9KWWpmRjBsOStVRUlzOTlhbjJISDVya254?=
 =?utf-8?B?aVZqNkF3UW1MYjVhSXRpRXVHK2RaK0NJS3E0ZlNNY2VCaHY5bjhFY2NuS0tl?=
 =?utf-8?B?OEpnK1RwK0Jjc29ON2w5LzNBU2VQY3pPVzhtNW5qNE9pUGdvZzAwT3NSd3Yv?=
 =?utf-8?B?OW1IenNlVVdpbTVLZkRzL0wxdlpoZVZ0Yjg5YjdtandFWU5sblh4dDZab1B2?=
 =?utf-8?B?MG0wcEF1Z1B1YWtja0NQd242T1hoUmUvTU5pQkszN0t6bDZ5OVkvMnZiQ2I5?=
 =?utf-8?B?andhVjRDVVJ6enFLZEZoTzhhQ2d5R3JEMXZLQlVaMCszUkhiS3NtVnRKUHlN?=
 =?utf-8?B?LzIwZUZkUE5BTXdYT0lJaUtQMks1N0RMVUxUVmJidzVqeEdIN3VBcjhMY1ho?=
 =?utf-8?B?N0ZvTkdUVTcrZ0ZQbzMvYU1VRVo2UmtzSlk5dzFteGY3RzZlZnR0b2tqd3hr?=
 =?utf-8?B?cWtJK2dFa05IL1o0T3d5TnRIVGp6dzVrMnRhOERDQTQra0MzNVRISEptRVg0?=
 =?utf-8?B?Ny9CNG53TUFKYUlFNkoxbk54M2pOUlVyUWNtcEtJOHBwR2x3ZVF3QlpiQ3V5?=
 =?utf-8?B?ZStITU1LK1h2eVVUZXZZdStOcVRwckEyUUoxVWJCaXZxRjQ1T0lMYVIyVmJZ?=
 =?utf-8?B?NVNsWWZETDYrTG9HUzM0V24vc0NKRmJOd08wNzczUzFFbTVCQzZjaG1nZlV6?=
 =?utf-8?B?RmdNaDZZK1ArNFZlNDd4UkhURFp5L0xHVno3MFh2Nkg4QWUvRytQTDZiMlR1?=
 =?utf-8?B?aE5UbU1NVmVXdjVIcXN0MEFsZE83WS9Rd1ZaUVN6VUl2MUxpUzlJQk9ZdEVL?=
 =?utf-8?B?U0wrWkN1blZVZHRCVWZCV05zR0MyMkRVK2R4Y3ZjbjE3dlg4SXd3VHBhWldM?=
 =?utf-8?B?d1lGQlJDTnZPTzI3V3RzMjRMN25kNGhNMkM3N1FXN2JoVDdSVUhnTlpvZnUz?=
 =?utf-8?B?VktsanNxWGpoS01TOVpzd0hsRk1yTEsxeHhuZ0R3YmFjWWduZHlqM0NvYVlQ?=
 =?utf-8?B?NHRYQmpqQ3F1dEJIN0tTRE80RTNWRWNsMzZrNTdHRnlhSUU4Q2M1VzRpNHFK?=
 =?utf-8?B?aC9GUXkrNVAvUEsrN1FrUUpWMFFwcjZnOXNmbjBZZGM5akl3eFprbHdvc3hi?=
 =?utf-8?B?ZFNpVzFvdXZ3OGI5bHlxYWZPRXdSUkdpOXY2NjZ6UzF4bjFWYmxpUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 054d4e4b-24b9-4a97-a387-08de4f922e01
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 15:17:18.9739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpPYcOVWyph1knx8SMRpxfdyzEgolNQQeQKCaMmNOdhsZGhRgUHEv7EzY6NCGFDWx2ceBR3HVe9wa/B2/G7efcnMAAECShPAd3xABiI5V6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7857
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

Hi Hal,

Your mail didn't make it to the mailing list. It doesn't appear on the 
archive at 
https://lists.denx.de/pipermail/u-boot/2026-January/thread.html and the 
moderators of the mailing list cannot find your mail anywhere in the 
system (in spams or filtered mails).

Can you consider subscribing to the list (here 
https://lists.denx.de/listinfo/u-boot, Subscribing to U-Boot). You can 
disable receiving all mails in the Options (Mail delivery: Disabled) if 
you don't want to receive all mails (which I understand :) ).

Can you please resend your mail once that is done so it makes it to the 
mailing list archive and I can point at this in the commit log for the 
patch fixing the license? Alternatively, you can just send the patch 
fixing the license yourself (but again, it'll need to make it to the 
mailing list :) ).

Thanks!
Quentin

On 1/9/26 7:11 AM, Hal Feng wrote:
>> On 08.01.26 23:59, Quentin Schulz wrote:
>> On 1/8/26 4:47 PM, Quentin Schulz wrote:
>>> Hi Oliver,
>>>
>>> On 12/19/25 4:51 PM, oliver Fendt wrote:
>>>> [You don't often get email from ofendt@googlemail.com. Learn why this
>>>> is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>
>>>> Hi all,
>>>>
>>>> I recently did a license analysis of u-boot an I came across some
>>>> unclear license information in files. I do not know whether this is
>>>> the right place to put my points, nevertheless I want to share my
>>>> findings.
>>>> 1. the file https://eur02.safelinks.protection.outlook.com/?
>>>> url=https%3A%2F%2Fgithub.com%2Fu-boot%2Fu-
>>>> boot%2Fblob%2Fmaster%2Fdrivers%2Fmmc%2Fsdhci-
>>>>
>> cadence6.c&data=05%7C02%7Cquentin.schulz%40cherry.de%7Cc65d5ed72
>> ac94f
>>>>
>> 3ad7b908de4ecd611c%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7
>> C0%7C63903
>>>>
>> 4841193276491%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
>> dWUsIlYiOiI
>>>>
>> wLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C
>> 0%7C%
>>>>
>> 7C%7C&sdata=qKgOGalLMURaimcVrCtxVnwN0EEldwTGB1I15M7RdsU%3D&
>> reserved=0
>>>> contains the following information SPDX-License-Identifier:
>>>> GPL-2.0-or-platform_driver which is not a valid license identifier, I
>>>> think GPL-2.0-or-later is meant here.
>>>>
>>>
>>> +Cc @Kuan Lim Lee, @Alex Soo, @Wei Liang Lim who contributed the
>>> +driver,
>>> they should be able to answer what the intended license was (I assume
>>> the same as you).
>>>
>>
>> Mails are bouncing.
>>
>> +Cc @Hal Feng, @Minda Chen from the same company.
> 
> It's OK to change the license to
> 
> SPDX-License-Identifier: GPL-2.0+
> 
> Keep the same license as drivers/mmc/sdhci-cadence.h which was added
> in the same commit fe11aa0b8ca3.
> 
> Best regards,
> Hal

