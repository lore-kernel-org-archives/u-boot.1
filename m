Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F067C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 14:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB85884A8D;
	Thu,  2 Jul 2026 16:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R8qneK0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E11F84A86; Thu,  2 Jul 2026 16:41:05 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7266C84A57
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 16:41:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTJY55xpRrMuabLtP6aLgFSYbUsk4Y0I7+tnDytMbFT1ppQ6XEHtwU1aguHgaGNxmLdloRLjDsX+gD89+WbWVtzXKXE8k05ccHmjj7fYnjk0QxEK0lxSYitjz78dpWycXwTqXVlMzUqFhgA117h6llg4bhSXwqvlTvjpKf3lpk4fj2R+IXMPf1qJwVVtgXYBHOW+6wDJUsUozxD+WnOFjruoVgwyc2QneEMtR/olV1LLnHFsW8nIdt5MiI3gkknBdq1XXfhxMXfAoPON3UYUSEwrfpOCEmq6keskaOFGPWcyoR3gr8+Z85jaZG/ER5EjfPlSlWTCg+6e+RRIoOzmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kT5RrVEYgk+S2lIOPzWHCnTaIkI4ijdDWmsWUFrhy5g=;
 b=BGnaKatkqyv+477gRIppXlUyAYJkWhToGXinX1E/Rp9ZJU5Y3uJcSYucdqVSGPRrgpxENqm3GdL/TMy8BxnlVgJvnUeFIxx3hxU7RNQEd71+FzV0bLzGaZzrmwyLeQmg9oomWl+wdZgH/q9TP9+MhRRWt0HEkJ1KhnacpnOAspoRcGfMo/1ihA4kKojK9CJ0KLBflBSrXt8p4/M40TYY5zY4suJPA5VsGpNAuDY42EyN50c5pCVJiB1WESbilS5gFYwTRjUDnASEBW1SFnuMVDpxEFVh6/5/r1q1fdIrRhub955z0E1v481UNHUGWXYJ7vU/n6F2bnbrj05jLc3ZyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kT5RrVEYgk+S2lIOPzWHCnTaIkI4ijdDWmsWUFrhy5g=;
 b=R8qneK0fNoohJg4OIqPhomtO/mMTZJkfGW3AxHjOYQ0R7eNkOzVo6mKpN1g5UpmiYsVSqP17Nrs0aObsVsYhJsKf4/bBygcdgoM5Luy53SWGPCYRFFNDHAZB2wqeHF0HTBovnf2q/5jDfdqMnXyQvD0/2fs0odEWD1ycXruvdD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 14:40:56 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 14:40:56 +0000
Message-ID: <ce38a9bb-4d54-44b8-b6e1-b88d8eeb9c83@amd.com>
Date: Thu, 2 Jul 2026 16:40:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: versal: Fix snprintf invalid size argument
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>
References: <BESP194MB280518E35381D7CF2CB50C60DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <BESP194MB280518E35381D7CF2CB50C60DAF52@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIXP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: dba1ec63-61f6-4912-a83d-08ded847ed1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 9s9r2V71qAmTY+S9AvHkKSMiAYqfa++D+kWJkD1ZTJL13YyCzrxYlc8PuFovgnAhw7hn5eoulPRZtWuwgrxlzIEjL2K33VSwfS9Uzb8qq8brjATGEjb/MQl+JwI7yH/LZ1VSGqVQoLAl244W4AI32USUgzeXzrhDBMcOtQhurJy0Ad25lEAeZDT7LVxyGecVabZoXe+9ilAH8L2FCoPtsfLNto8Inocf7/N93Tp2w5pKiGbvEJSASHRNGrgvwCLTcOc5zyqN8GcijVJC3RZnliAseaZJac84S2sUvUSbYWZKNIw2GAZJUQDDNzOe4gjxtWIsN3vH70QM/rx850FLxZ55dswyCWFPfFDwIZwsNB2TLNYhcfDwMyvEsdfWXH7/LwtpY9E2OlzsUi8ILKc+dpUyUohLeI7OgEtABYcYlacfYs/LCqGLKYuAci+M2ApVE1Ew6orCcnQhbY+WRUWjG72/+j3s5/BbDRH7Jb7M//i08LTw0yklVLbtsvbKc/RBfKb9S2CiWwkt12Mm3UedFb1nZtce1+AFqmK4DLc2sG8Y7vaj7YGyPHkgBEnkgM44AivqRBvXCpCH0rEDa1mnT4tS19LPxgwAt/MbZsUpu1rcVflMW+hfmAi3O02nKje8SAsxuoIVsB9bnMhx9WFVvThXghSJ4BQSN0aFhDyWmmw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTdKbk9OeURVeWQ1dXZDTlpoNmpmWmI1c1A5eHRSUUY1K25EeWx5QWhkRVhE?=
 =?utf-8?B?Tkk5SklzQ0o2ZWExaTc4czE0MzVQYVFLZW9QaVBnR21TRDZudGdFK2IrSG4x?=
 =?utf-8?B?WVp1cWlkZTJWa2xLb1pJcVBtTzZnb2tzalFLcVVGam44Z0NSaE5zcVBFNTFo?=
 =?utf-8?B?N2J6cHNybk8xS2hnS2dVSG5tY3JtSzVjUVhqOGF6RVo4bURHQ0M1NlM2Uy9m?=
 =?utf-8?B?ZEdHZDNrbm5IUTc5QTBSM0lLdGJPRDFCbHN4Z0UvOEVTaXBldXBZSnJCTXBI?=
 =?utf-8?B?RnZMSUZ2Zkh3c0JQSGE3UU9XUmx6Vyt1NU1CMG5RZjBPZk02NDIxalg3alBp?=
 =?utf-8?B?WlZnSk14YWtxZ1V0eU5hZytSVmVLN0lDZE1Ya0YzV1hYWkhSM0ZVUllGRWJO?=
 =?utf-8?B?dzF4VDJDVXpxRDg2dUtqTzNtaUc0WEhXUEZXSFNXQUYvbnQ2WGc2QmV4WFJK?=
 =?utf-8?B?aUtYaUZYTHdlQzFwQngrTHIySXowRk1zMzVrZjRjS0NxZnN6UVlCUjRjQ0Rk?=
 =?utf-8?B?d3VkblRYWFFHT2pwQkFGVm1TcEwrczE5NGQwVUFTaUM1Q2hlNkdDZU84VFRU?=
 =?utf-8?B?NCtud2MrMjhURlgzUlg0WjkzRURMQXR3b255NXlleG1uSGtIU1ZRUEVnVjNk?=
 =?utf-8?B?S0Z6NEw1T0kydU5IN24xdDg1OStaZ1hXWjdmdzFxWEJ1a0YxRkZsZ1RWOHVI?=
 =?utf-8?B?U2EvRVZsY2RCWlVTVGRNTlNzRnlDdCtBNkRRVDJXVGUxbUhMOFcrcjRwSCtK?=
 =?utf-8?B?MStXRkhNS1NMY2pYMG9QTzRsdEhPTXJ5QlpGRkw5L1R4eEt6OCtjUzNpWjRh?=
 =?utf-8?B?MWw3Qi9PNEptdGdxa1pBRDBwNGN3S3FpUGNhbGtKRUhBM1AvVmNXUjNEOWNS?=
 =?utf-8?B?YVZPNG0vbFczQTBOLzVLOTJTdHF1K0JCdDQ2VHh3aFBRNGVrZ0duQTB0RTk2?=
 =?utf-8?B?L1l1ZmR6OGwzNHpHVmx4WG0zemlERUJpWEJJbEN4RXQ4R05raUwzOHozd3Rl?=
 =?utf-8?B?Z3ZlRWFGVm85S0hPMUdGU1FXRXhSQThoaEM4UzFFb2VzcUd1U0FQRStKanhj?=
 =?utf-8?B?N2Vaa21teXFZNWViWHp6KzdEdUtvb2RQcFZxSTB5TjczL0dmZ2tCU3g2eEFO?=
 =?utf-8?B?dmRJbHVWUC8rUDF4WnRXVEs2UC9FZzVvVjNwcnQ0ZUxPbXNtVGhTbi9kK2Nt?=
 =?utf-8?B?TUphYUhqM09wUUxXUjNIckVKandtRDE3VmowQ0hvUWNmUkVHNWo1bGFiU21P?=
 =?utf-8?B?Z1JETm13UW5ka1ZXQ3kwUHlUNkQ4MjdoS1dXaTlMVVNaWitFbWlJU0pFVTNI?=
 =?utf-8?B?ZnNja3JKZGwzUWRscGE3bDcyK3pNRzlDUDF3S0hqeW1JZzNIT3pvWmVmYlpZ?=
 =?utf-8?B?YU8rb3FqZ1hrOEtqbUxiaWZLdzdwMWl2dGQ2eHBsZitmR1Bud2dYTWpPcHdD?=
 =?utf-8?B?cEd6YlY3SU91cHZJOVJlclkvMFoyd0JkdXlGYjZxV01HM1BFcXBVTTZaanNS?=
 =?utf-8?B?QXZ2ZWxpRXpLbFBTWUpkcGY1NGllcHBTbWpRWXlaVFJNcE1hSlJ4VktZZFA2?=
 =?utf-8?B?REVYL2IwNHdlb0V0K281MEUwRjNJQkV1VnRvMVRqN3RLeXVLU1BMTjJORUV3?=
 =?utf-8?B?Y3RnMkpYZXZwdFlUak5reGlhQVNIc2d2SkRMNXp2YXdoNDFSZGhNb1pUU3Vr?=
 =?utf-8?B?UmpUd1prbko2emFvN1JVRDFCQnUwREpXR1ZLa3pwbXdSbG9JVFFjVzh0em1T?=
 =?utf-8?B?SE5wYkt3cFd0cmlxWFRKbXdTVGZOVU5qbkQ2NUZXT3dHdCtjZDYxR3d0SDZy?=
 =?utf-8?B?aEVFSjRsRllqSHN1aFhFQ0xYWTBpcURkVWFmWEpMbUVNR1dTWkZkT2doQSta?=
 =?utf-8?B?dHBhV3RDSUtKVk9qdHNseWFPQitGMUt6VEdyNXdCYkthZjhyU2hlQSsxcG9o?=
 =?utf-8?B?dG01WnVKY0IxcUtqU2IwZTJwMk13Z0JHemdPajdqZjB5Mnc0TDI0Z3Q5b0k0?=
 =?utf-8?B?OFNvKzBDQkQ5YTVKdHhHTEIvVUhkNnV5Z21aMFdpeTVQVDRjaG5yc3I1d0s1?=
 =?utf-8?B?RzAvOTZUeTAvcDdFU2Q3VVZPSkhzMGFvRi8yNXRuTkMyQmV3dGNKcG8zdk43?=
 =?utf-8?B?U3dMTzR0RW1WSUc3bWhuWHVTdDdnMENmbExtWmpaaUlqcDBqRHlpcExWOGFx?=
 =?utf-8?B?d0xKaEhPci9TTlBJZXc3cFhVeXpWYWZPeUhFS0cwMFE4cXdHVm1DaWsrMkNp?=
 =?utf-8?B?MzZkdm9pVjQ2TEhhT3NnbzcxeUdqUjlRejBZdlp1QmtIUnZ6ZnlHOVlNVFBZ?=
 =?utf-8?B?eTQ2SFZ2NXZuelpzbi80RWlrekxaOHVLK252djRkL2E0eGR2TzE3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba1ec63-61f6-4912-a83d-08ded847ed1b
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:40:56.8118 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODJ0EXaHzYkX8bKHaLRTNIVColCkNudmLcRgDNIJ6DDi4mxRSz2q3zKBnrR2z0g9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960
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



On 7/2/26 15:54, Francois Berder wrote:
> buf is an array of size DFU_ALT_BUF_LEN bytes.
> It is gradually filled with data using snprintf but the
> size argument to snprintf is kept at DFU_ALT_BUF_LEN,
> making it possible to overflow the buffer.
> Fix this bug using the correct buffer size:
> DFU_ALT_BUF_LEN - len.
> Also, replace snprintf by scnprintf, otherwise len
> variable is incremented incorrectly. It is now
> incremented by the actual character count written
> in buf.
>      
> v2: Replace snprintf by scnprintf

this should be below --- not to be the part of commit message.

M
