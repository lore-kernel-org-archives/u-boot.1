Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BDDC83030
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 09:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD73A82F03;
	Fri,  4 Jul 2025 11:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMxY7wsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0459082F03; Fri,  4 Jul 2025 11:02:10 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4594682A76
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 11:02:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X9tRFdpRT1MIg8RnKGQNWhhv2/Xc6nydVme+fVGePkkmMQ7ZFskD5WwMnfWfKwNmJyp8VeofiQNZOBucEP5AuXCIj2fSU2Q4DEBNcWdmmrIc2/nmZUNZDW5z9QQDNsmtagMbvc5eRHkji6lrhMzSCWGhUZdb5yHzk0UIt5X+zCZNSG1OspILieUgx+WRI3f4r95ClrNhsEjXGLr6uq1B/lN4qlBFwuH9utTaeT3zLBGrmLVUNBaClJmWT0pm5YIDwDXGDVnQv9LgIYqjWrf2V7fMTN9WVv+gD9NviSiMbX++Orwou5mLkQu3QJOxIgj3I78pUIdfB2Rkd6kUciDcOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKGbuwoZ3Cbc/E2xdckDGGMhmFIS5SyWqRkKhKpuz4s=;
 b=Tej9WIw/ciYNTjCY9ZGsSYqLkgApgiVMQyuPfUcO3OzFrjKbLDaQGIJqnbM/VWzrxxjH3c64rPIS0EPlRgz5L6ir+LCVzYVy4chbwc9BBJjD4rwcLzU+3D1pPsUEmI1ZXdMm5M8jnKFgfXT1TgmY1+dmMjoY0W4LbPI03jHyKGM58wzaT7A38gjJu9AtJLqZlHYEFqctcHEGC66t2/SelnxgqAxOjV3aKUF+XTjgzz19OhB+PV3wHvc0vLfTbKyLOyXb0of4jkTBUOOplEg6eLbLVt3wLlh99TgHbyicrZYCtSUFgQjJUg8vY7D0/pf2cueZTp5bneRK6a82aypF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKGbuwoZ3Cbc/E2xdckDGGMhmFIS5SyWqRkKhKpuz4s=;
 b=hMxY7wspl67SeICMSO3r3EU67/6oxtCQfVj8ULi6l65/CLz/JdMSzS6AYGh0kPxBmI5Cp89/Nwkp3grOMJ0jkJzi5LHp+9uCg0S8axXSpmlbQZAMMhcKkhsnBBri0uc/snR+rtBKadNeBbS9wJ08lZJYk9ovjVu6jWaWxnMyZds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7482.namprd12.prod.outlook.com (2603:10b6:303:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 09:02:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 09:02:04 +0000
Message-ID: <6ece62ad-2bf8-4098-9914-c387fd4797ca@amd.com>
Date: Fri, 4 Jul 2025 11:01:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/25] fwu_arm_psa: Document FWU support for Arm PSA
To: abdellatif.elkhlifi@arm.com, u-boot@lists.denx.de
Cc: trini@konsulko.com, Davidson kumaresan <davidson.kumaresan@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Casey Connolly
 <casey.connolly@linaro.org>, Adriano Cordova <adrianox@gmail.com>
References: <20250702152528.1180414-1-abdellatif.elkhlifi@arm.com>
 <20250702152528.1180414-26-abdellatif.elkhlifi@arm.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250702152528.1180414-26-abdellatif.elkhlifi@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:803:64::15) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7482:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b7ca3f-0bcd-4ea9-6616-08ddbad971f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG5JVmh6dGRPNmRpcTB0ekNTSWhMWWRpd3FrSGJHZDdnRzB0cHR4WnoySHBG?=
 =?utf-8?B?MlJmamMzcGNhaW9MaTVnUCtJWUdGalBVcGU4NUk2NnQ4ejFGT01zNTMxanNM?=
 =?utf-8?B?amFJSkxKdWpkU3A5bFBJVFZsdnNQcTRnVU45YlFlajR0d1MvNVJIUWQzU0dC?=
 =?utf-8?B?cUxvN3luN0xvWUJuNWRhand1bURWRU5EUGFpTEZManpMemFYYTAraDZvSkR1?=
 =?utf-8?B?WDg4Zkw3VjZoSWFQaFdXS1A3RlNvYTZ4TzBHQmYyeEtzOUp6VEdyS2U4S0s0?=
 =?utf-8?B?RDZqREcxckgvQmMwQnJqM0RWWlFlY1FmemZzT29JRXFYMnN2UzNpT3A1ZnI1?=
 =?utf-8?B?WkdJeFY3c05OcExXcldnRjFsalE1S2RNckVHY09tVS8zck5yeTVweDlMY0hk?=
 =?utf-8?B?bDRuNzl2L2h5bnFtV0ZidjVPdTdWUGFqYndLam9IeFhkS2FzclQxS2RKcmtm?=
 =?utf-8?B?dDg4K3gyZC9JZ3M2V1ppNHlheVN2RFpjYjhXd0RIeWJjM29YVXcxeVAxaDZC?=
 =?utf-8?B?N05HelBWWDBrUC9hejRNcXdxMFQvOXZVY0ErUi9VMmRWWUd6cmlTWkFpVE10?=
 =?utf-8?B?ZSttZlFBNzV6RXg4UExXd0JkSTlHNlUyTVB2K01VUU5hczJUb2YwODBSZ2Fu?=
 =?utf-8?B?WUt5R2hob1FNbkRJcnRNVEhuSDdEWjNFdnphT2VvQm9ERFVTV1NiK2xUd1Zv?=
 =?utf-8?B?VkdVbjNaMWpUbS82Qlc2N2VzS2JnRGdiUEswQ0JzOUxHSXFYTUYrb1ZXbkE1?=
 =?utf-8?B?eTlKUFpBMzNDTTBYOHZ0di9jK0JlYXZ3QjJ1N2lMd21Rd3Z3RjNUQXRWalRW?=
 =?utf-8?B?UkwrVjVzNGV3R05YWThEcHN5VGs3aTArUEZ0aHFmbndFcnpwT2tOUTZmNVdL?=
 =?utf-8?B?aDZwWHFzMUpYYWh0NEhMUW9sR3psV0hPQzBzVnJTSTBGalNKa2R2cjdaZXN6?=
 =?utf-8?B?ZlZQMkVLTWJZNkNSNkU1RjFDMnl5WlcyWTVYWXArMW9uMHo3QWFkT2UvdUI0?=
 =?utf-8?B?eGxVNnBIK0dVelJSMmVzK29haTJaRXB1aFFsVWlydWkwQWR6UnVTcUVCZVJy?=
 =?utf-8?B?T1ZDVVY0bGFmVXNmYkUwR1ZmOUxnbkhqU1pVazJNa1hWMlpoSUlqaEF3YW9v?=
 =?utf-8?B?ZWJMcGQxNURDRzRYOGgzSEk4YmJDNVhlQ0JycDI5UFlhRnMzM05vU1hFY0ta?=
 =?utf-8?B?UDN4VUtuV0I4V3dGMWNVY21ZSXN1OE9kbklaQzU4VVpPZG1aSVgrcUhRSG51?=
 =?utf-8?B?M3RFVk1ZbDZOdjUrcUJ5TnF5WUk3ZEtMaHF5WWxHZTFxY0dkOUtyTmh4Y2w1?=
 =?utf-8?B?NVMzVjc5Q3VkTXJvU1JBRHozWm4rekpEYy9oSGsrZWlGNWdaNE14Yk13QUJy?=
 =?utf-8?B?c011MmlDd1RxWDJVQkJFbEhtL2VUYmlNdUR1YnFDMEUwQitTVjQxQUt4NkdF?=
 =?utf-8?B?a3pFdUwram9Mb0RKZHJsMExMcHpodXo1SURwZE1CWERpdzloSm9TOFFKcTdV?=
 =?utf-8?B?c1R1Rm5SbEhGd01vclN3bTlPV2RjVW1VQWNDWDV1V0VCV05IT29ZNnhDYjFC?=
 =?utf-8?B?N3VpMmxCWjlZbDF0L3J5QmJjTFQ0bnVDS1owakR5NlJ4NjVMZHFKaXViSHpw?=
 =?utf-8?B?WWdpSndHU0hrM3NPUGMya0J2VkFRMzFDUnVNSExJM0RvWHJ6SnMvWGVHZzFC?=
 =?utf-8?B?MW56TEROQ0wzWjJDSDVZb3VPb2JQcXhzV3A1OWx0aWZ1SFRPRHNnNEVGR08y?=
 =?utf-8?B?RWlIWVBvbm9HUEFBNnlpelJtUUVzZGRRUGxzZENhTG9lbVFIYUFRTyt1NDEy?=
 =?utf-8?Q?LF9R/2lA5/iBxukm8WiG6vEVIQb2FYrxcigUI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVVvWEp5MWhSazVYbVZpM3YxSFphWmpuQ1M4STk2RG9BaGoxMzNpR3lMUzRM?=
 =?utf-8?B?ZnV3TGIySE5yUDJ6ZXZ3UU9lWXZQeHZNWG1hRVVvOFdkRVVUbFJYT0x3bkd0?=
 =?utf-8?B?bnJhYzFoUEtmczdrRVNxdkxMUXFqNWlPRWFzVmV6Q1JBQUpqaVg0cUFTaVBF?=
 =?utf-8?B?bG05QmdJc2p6YTBpaVBIcUkwQmxEcHZtYUhjVGUxWVlTbmNod0MreDRCSkdz?=
 =?utf-8?B?WHgyTjJVRU5ZWUJnbGpPakxXZURDRXBlcE9vdUl3K2xPYVEvN1RsZnRVY2l6?=
 =?utf-8?B?YmVSNlBlVGpGY29DbUI3aGtpc1NheklCVm51SmVvWnUwS3Q1dmNFeVdJckxr?=
 =?utf-8?B?eURON2lzSCtsRW9wWU9ySklzTVRuSy9oVnh1VU8xOTVwWExWRXpCK3orR3BU?=
 =?utf-8?B?VjlhbkNLN0pTQ0J3MkllN3J0SVdnRjN6WDR3dzZRL0ZUanVIVm9LL0dyT1hI?=
 =?utf-8?B?YXhXVTVTYm9wWlFRcWtJckZhcFF0TTc4TzVENTMrb0NNc1lDWVNycXFEaWxz?=
 =?utf-8?B?ekxVN1pUL3h0RlA3eTJTT0xBWjJDUmFvaFN1RVpKWGx6ZHVjTFUzaThJZHJa?=
 =?utf-8?B?aHdNZWJ3NHFsQ3h0RFoyWGh6YlZPZ205Y3E2RzlqMWJneTNPVklTWXAzdmxE?=
 =?utf-8?B?NTNlbmp3RCtudE5DTG51eis2T09LOGlLY1dQSVBCcjZyL0g3NSt0K09XT25v?=
 =?utf-8?B?bTZGaDA5WnpRMFZ6aE5UTDdkUVlJRTlhclJFVzM1ZzhndE9NcFNlSCsvSGpD?=
 =?utf-8?B?QjB0OS9peEdyanN5L2Q0VUR2OGxFNUk1djlhczQ2TUZSZlBCOGJLd0d3Yy8z?=
 =?utf-8?B?Z0NyZTNDS3VBNXRWaFFPQmo5V0R3ZHhRYlZlOS9Xdk5zNCtnL3BMdEZpTnJH?=
 =?utf-8?B?RnRibWY0TldiV0lsaVFqUitQUXRuTmhnUjlIMG5ITks0NlZEZzVmUHZjVnN4?=
 =?utf-8?B?VGNxTDRWVXZGZGowOEJYK0J4eG1vUVB5QTZpVDNUYW4xcEVEZXd0Szd1MWxW?=
 =?utf-8?B?VWtZU3dOZ3c0SEFiVVR6SlA1VWpPdHBNZFZleDE2MVU2Z3FqNmV4R2MyMWRM?=
 =?utf-8?B?NzBjZThpTmhhU1VDQVB4ZVdvNHNzS2xTRjhkYlpSY1JELzR6RjlUb1lhWlVR?=
 =?utf-8?B?VWVkbnZIeXd2MGE5cHAvMXUrd2pJbkxWMVNlTDhONXIvUkRIUy9tTjZWTHIy?=
 =?utf-8?B?Y3NMTjRacWhNY2dqaVRaNUJZVXUrcE5nYTZRQ0d1eU5XUzB2aDRESFpQdzVC?=
 =?utf-8?B?UGpHVTRiNEVvZDN6eURtdWhhSkczejN2V2RyeDhGQzZsSlR3MTN1TkZ1Nyt4?=
 =?utf-8?B?TGw0MG82eThWbExQYzlLb3JHamJPNDJCc2wvUnpackZwZ0JSZUJwZ3ozQklR?=
 =?utf-8?B?c0tPK0xjZTFlMEFrM3NqV2g3T1d3emRJUmhlNTdCUU1ZNlU4MFBFRWFtb1ZY?=
 =?utf-8?B?ejlZN1NTT2lhTXJQa2RqMnNQSXBkajZkaTU0eTZJd3o4blNhTlZwZUg3VHNh?=
 =?utf-8?B?S2NtZzRQRTQyMkh3QkFWWHhmeWthV2JENnR0QStaempCV1RQbk1IeSttOE9E?=
 =?utf-8?B?em9mcllmS3Q3Ykw2L0tLUlpXcCtXTTZtZFFEZk9hZkJ3bExGVTRzVENoOU8w?=
 =?utf-8?B?VlczL09EMytTZ1dKdldOcWMybkFneE13Z1kwSE4wVENPRUxzYXhlMmFxdGhq?=
 =?utf-8?B?TnYvMCs2RUhhTklQZXZURlVkRjNIRm81U3VXRU1EaVBOTitUcHRzRUpTS0NX?=
 =?utf-8?B?R0d5UFRNU1FyQkhEMHNXc2dnSlJGQmNuNmdrSTk3RnBoc0doRTBiWGVJM25F?=
 =?utf-8?B?ZW1nblltT3h1cXM1NlB6bW5GRG11ZEtzd0lTRHVKVFRrbjlQVG1ONjU2MTBD?=
 =?utf-8?B?Q3orNTVjNzJCS0VyUzdNTG1UQXJMdFJzSmI3TURsZTBMSzNBVS9SNHllaWZV?=
 =?utf-8?B?SmFnVnNhLzh0eW5OYmYvR2J3VWhQNmxxbjNWNGdTY2ZTbmZJSUJBbmdUOXk4?=
 =?utf-8?B?bkVVTUZvb1ZsaC8vOWFReGVVMWF6MUprbGRtNk4yckRHMW43VWhJRE9XL3Qr?=
 =?utf-8?B?QnA5dVRuKzBGWFJKcGkrMi9QdDJzYjFOT0VrK0RHRGgwVDhONFpteGNNV3BZ?=
 =?utf-8?Q?tppj1ANpSEAx65vm92s/1f2+g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b7ca3f-0bcd-4ea9-6616-08ddbad971f8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:02:04.3413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wlOTr/FlqTqQ2Ed6ULCbSK5LsE3DbsRnOOtDV4EP6Xfc/yu/kt8f0rMhauwVLpHX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7482
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



On 7/2/25 17:25, abdellatif.elkhlifi@arm.com wrote:
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> 
> Add a README
> 
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Signed-off-by: Davidson kumaresan <davidson.kumaresan@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Adriano Cordova <adrianox@gmail.com>
> ---
>   MAINTAINERS                      |   1 +
>   doc/develop/uefi/fwu_arm_psa.rst | 153 +++++++++++++++++++++++++++++++
>   doc/develop/uefi/index.rst       |   1 +
>   3 files changed, 155 insertions(+)
>   create mode 100644 doc/develop/uefi/fwu_arm_psa.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fdf34c74049..a75bc1d2379 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1231,6 +1231,7 @@ FWU ARM PSA
>   M:	Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>   M:	Davidson kumaresan <davidson.kumaresan@arm.com>
>   S:	Maintained
> +F:	doc/develop/uefi/fwu_arm_psa.rst
>   F:	include/fwu_arm_psa.h
>   F:	lib/fwu_updates/fwu_arm_psa.c
>   
> diff --git a/doc/develop/uefi/fwu_arm_psa.rst b/doc/develop/uefi/fwu_arm_psa.rst
> new file mode 100644
> index 00000000000..f91fd85f573
> --- /dev/null
> +++ b/doc/develop/uefi/fwu_arm_psa.rst
> @@ -0,0 +1,153 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright 2025 Arm Limited and/or its affiliates <open-source-office@arm.com>
> +
> +Firmware Update (FWU) Support for Arm PSA
> +==========================================
> +
> +This README provides an overview of the Firmware Update (FWU) support
> +implemented in U-Boot for Arm `PSA Certified`_ platforms, such as
> +Corstone-1000. The feature aligns with the Platform Security Firmware Update
> +specification for the A-profile Arm Architecture
> +(see `DEN0118 v1.0 A specification`_) and leverages the Trusted Services (TS)
> +framework to interact with Secure world update agent.
> +
> +Overview
> +--------
> +
> +The FWU subsystem enables secure  firmware updates by
> +delegating the update management to a Secure world agent. U-Boot acts as the
> +FWU client, coordinating updates via a well-defined set of ABIs over the FF-A
> +interface (see :doc:`Arm FF-A Support <../../arch/arm64.ffa>`).
> +
> +FWU for Arm PSA supports both on-disk and standard capsule updates.
> +
> +Key Features
> +------------
> +
> +1. PSA Firmware Update Initialization
> +-------------------------------------
> +
> +- Initialization of the update agent using the FF-A transport and discovery of
> +  the Trusted Services FWU SP.
> +
> +- Discovery of the version of the ABIs using FWU_DISCOVER ABI.
> +
> +- Establishment and sharing of communication buffers between U-Boot
> +  (Normal world) and Secure world.
> +
> +2. ESRT Support
> +---------------
> +
> +Retrieval of ESRT (EFI System Resource Table) data from Secure world using
> +FWU_READ_STREAM ABI, enabling compliance with UEFI standards
> +(see `UEFI v2.10 specification`_).
> +
> +3. UEFI Capsule Handling
> +------------------------
> +
> +- Runtime checks for capsule flags as per UEFI 2.10 specification:
> +
> +    - CAPSULE_FLAGS_PERSIST_ACROSS_RESET
> +
> +    - CAPSULE_FLAGS_POPULATE_SYSTEM_TABLE
> +
> +    - CAPSULE_FLAGS_INITIATE_RESET
> +
> +- Support for keeping the FMP payload header in Arm PSA mode to preserve
> +  critical metadata required by Secure world.
> +
> +4. Staging and Update Flow
> +--------------------------
> +
> +- Full support for update staging flow as per PSA spec:
> +
> +    - FWU_BEGIN_STAGING
> +
> +    - FWU_END_STAGING
> +
> +    - FWU_CANCEL_STAGING
> +
> +    - FWU_WRITE_STREAM
> +
> +- Capsules can contain multiple payloads (including start/end markers
> +  and the update content).
> +
> +5. Directory Access
> +-------------------
> +
> +- Reading the FWU directory from Secure world using FWU_READ_STREAM ABI.
> +
> +6. Image Update Lifecycle
> +-------------------------
> +
> +- Implementation of get_image_info() and set_image() using raw EFI firmware
> +  services provided by the FMP driver for raw images.
> +
> +- FWU_ACCEPT_IMAGE ABI issued on ExitBootServices() to commit successfully
> +  booted trial images.
> +
> +- Option to disable automatic acceptance on ExitBootServices() via
> +  CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES.
> +
> +Configuration Options
> +---------------------
> +
> +To enable FWU support for Arm PSA, include the following options in your board
> +configuration:
> +
> +CONFIG_FWU_ARM_PSA=y enables the PSA-compliant firmware update client in U-Boot.
> +
> +CONFIG_FWU_ARM_PSA_ACCEPT_IMAGES=y Enables auto-acceptance on
> +ExitBootServices(). This option is enabled by default. It can be disabled if
> +image acceptance should not be done at ExitBootServices().
> +
> +Platform Integration: Corstone-1000
> +-----------------------------------
> +
> +- Corstone-1000 is the reference implementation for the FWU Arm PSA feature.
> +
> +- ESP partition detection is automated by setting Boot0001 in the U-Boot bootcmd.
> +
> +ABIs Implemented
> +----------------
> +
> +The following ABIs from the PSA FWU specification have been implemented:
> +
> +    - FWU_DISCOVER
> +
> +    - FWU_BEGIN_STAGING
> +
> +    - FWU_END_STAGING
> +
> +    - FWU_CANCEL_STAGING
> +
> +    - FWU_OPEN
> +
> +    - FWU_WRITE_STREAM
> +
> +    - FWU_READ_STREAM
> +
> +    - FWU_COMMIT
> +
> +    - FWU_ACCEPT_IMAGE
> +
> +ExitBootServices() Integration
> +------------------------------
> +
> +- The U-Boot FWU client performs several key actions during ExitBootServices():
> +
> +- Notifies Secure world about successful boot.
> +
> +- Accepts updated images in trial state.
> +
> +- Supports board-level override of fwu_notify_exit_boot_services() for custom
> +  behavior.
> +
> +Contributors
> +------------
> +   * Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> +   * Davidson kumaresan <davidson.kumaresan@arm.com>
> +
> +.. _`DEN0118 v1.0 A specification`: https://developer.arm.com/documentation/den0118/latest/
> +.. _`PSA Certified`: https://www.psacertified.org/
> +.. _`UEFI v2.10 specification`: https://uefi.org/specs/UEFI/2.10/
> diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
> index e26b1fbe05c..573630740a0 100644
> --- a/doc/develop/uefi/index.rst
> +++ b/doc/develop/uefi/index.rst
> @@ -10,6 +10,7 @@ can be run an UEFI payload.
>   .. toctree::
>      :maxdepth: 2
>   
> +   fwu_arm_psa.rst
>      uefi.rst
>      u-boot_on_efi.rst
>      iscsi.rst

Is there a way how to run this on Qemu/FVP or so to see how it is working?

Thanks,
Michal

