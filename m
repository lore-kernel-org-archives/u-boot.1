Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E176FEFB7F6
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 04:11:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6064A82BF2;
	Tue, 24 Feb 2026 05:11:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="IUySFm21";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6F7C82BF2; Tue, 24 Feb 2026 05:11:00 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26E2E8063E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 05:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vigneshr@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI1ie11vQIj8BkXn2LRCnZmQFVtWbUSCn75PBce6TdGkSEhDC3HFJ74VmKlZWyJXiki3Lhdc3U7uNzZujjdbz20v83/pLVKur7DRonlyOt137h7NOOTWw79uj3EYvfXAXE9ZAqEicljO0lpDMDM5fRcnx7D4nzohpT2bh6PbQwT11ygnr6+BB2oJR2G1dWKvKEXh0/Iqpk2Oxyy3KtiZt83cBMUTRLwYO8dwsjpWQdh0uzVjy3MDvIKn3OQZA7zVvcD4QtaDhzm4KJiH7q75T0d2VSS39gMMXohblnNftVd21QCRw/pwDMwDcOA5dzd83ViIjgm9xKekx8RE8e/T3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XduWrxJUttQoX9ux6omiQTY4Phdb8z2xNet2Fw3cV9M=;
 b=VH4ityZWRVoIxa1wkUacqi3oZY0nfUUk9kvSfcfIxBvWwOkTKVevA4LJcCBefAEM22KCWwcVcCe5YAW1ZqTllYuVj1VYDBSY8VDzfxDCYDGM+4FkMjZ4GBbnvf4em9y5P3mNuRKlG9g4pyA7ZUHV0p9pPLRUnLcyHdNlvYV7g588/dnMl8WmV6r3pbNDgpZ1EfCSAGkDK4qrJO4mgYLe8qHFFbhX/dBVz6xmykMqOTKUoAYxs89+vRPYrtmxvYpSKldhC6vfgF+izmWMtm3jOrneDHw9YO21Ss+mLXON0M8cIdgjs4pbhnLZKRqnGiHNK/8Vx/Rb4HdRrBqNopcLRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XduWrxJUttQoX9ux6omiQTY4Phdb8z2xNet2Fw3cV9M=;
 b=IUySFm21dPTYSkKG1tQJvxNJNhLahExgAAs0M/6HxnOnEIX0TCaKCvGAKoaMCPI3muBjhZWsgGC308Ha1TA4BRqubzMVEhsnTAczial2qJZoQYspdyI0PbNKtLHY1/sAY4NUQv/NzhJz0M0eDKXSOTtL7bCE7m5w5n7TgRBhifg=
Received: from PH8P220CA0058.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::32)
 by BLAPR10MB5204.namprd10.prod.outlook.com (2603:10b6:208:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 04:10:55 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::e8) by PH8P220CA0058.outlook.office365.com
 (2603:10b6:510:2d9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 04:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 04:10:55 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:10:54 -0600
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Feb
 2026 22:10:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Feb 2026 22:10:54 -0600
Received: from [172.24.233.103] (uda0132425.dhcp.ti.com [172.24.233.103])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61O4ApTu2037709;
 Mon, 23 Feb 2026 22:10:52 -0600
Message-ID: <23f03e64-71e3-4fcd-a216-fef7de5a37aa@ti.com>
Date: Tue, 24 Feb 2026 09:40:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-k3: j722s: unlock mmr after spl_early_init
To: Udit Kumar <u-kumar1@ti.com>, <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <heiko.thiery@gmail.com>, <m-shah@ti.com>,
 <j-keerthy@ti.com>, <n-francis@ti.com>, Diwakar Dhyani <d-dhyani@ti.com>
References: <20260223144558.395289-1-u-kumar1@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-US
In-Reply-To: <20260223144558.395289-1-u-kumar1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|BLAPR10MB5204:EE_
X-MS-Office365-Filtering-Correlation-Id: 4229c128-e8f2-46cb-a386-08de735ab4ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXdCSTB3RU5qZkU0N29udEpid3VUenpHU0J4aDBIRHdKT0FPb0RLYU05RXBj?=
 =?utf-8?B?K2J3NlMzQ1JjWFhZbWhyS3QrRlEyOU5qM0lBbmF5cnVuTStIWnVDNGl5aERU?=
 =?utf-8?B?eDQwOVQ5UnFZbHdjQ3U2NmJJSGZjVmpER1ZTU21vakdvMGZmcmIzVGEwaWh3?=
 =?utf-8?B?NDIxUDVXRDJtaEtJOWw0UHB0cHhlK3FpNmlDVlFYc3Q1VHNFejdleWNkZ1hi?=
 =?utf-8?B?SXRzd3B0R1JPRmRteHJkODFnZDJ3ZFF0RENFNkloVDJIVG9zVkdrbnlqNHRa?=
 =?utf-8?B?dXE0ck5RZ3FLeWFRMzIwSjV0QlJsNFBoWE1obmQ5NXdDaHUxM3RpNWFUanVU?=
 =?utf-8?B?eTdCZjliRlRpUzRBVTc0YUdLaWNEaklhclV6bjdvYXBseHIzU1JDeHRIYW9r?=
 =?utf-8?B?QmR6anRIang2OVByR2RqL1FQdVIyMUxINXM5VTVIRjhycUpMT3h0R1ZWKzhz?=
 =?utf-8?B?UjFCbGlyZm9oMlRWdFV5bTdJZ0VmRHJQeEJack5Zb3hyODkzT0szYWNWTXRJ?=
 =?utf-8?B?bXNPc1l1bFkzOXRrTzBSYmNKb0F0NG9IaSt3dEFxQnM2TERpdURUYjMraXZZ?=
 =?utf-8?B?NjNrRkNTaFVENzVnSmNETFI4SDIrcjZmUWlhN0RQcE9NNHpPS0ZpRWpBb2dt?=
 =?utf-8?B?V0RLMHp2N0RlaU51U0phTVpKYklHL2pyUWJ4MXFtMGViVlJQYTJ6VHRLZFFU?=
 =?utf-8?B?cWtnR3luMVJFVlJYQkZsYVBoaUFuNUw5dGFjWWU2ZzVDbGhrTG9LU1JjbjNz?=
 =?utf-8?B?TC8zcnhMcS9PemIrTW43SVlDaC9ING5NakVkbS9wa3gvckJubGdqZzBhUTVv?=
 =?utf-8?B?WVp6ZitBKzdkaHdMWFAwZjFsVHVUb1FtQ2d5NFc3L3o0bzFHWHF0RHViWmRq?=
 =?utf-8?B?ZkV6NStMQVNHRkxVaFlSVlFVbmovb1ZBaWYrMWhIQ1dENGE0MkJLeklBaFdt?=
 =?utf-8?B?NXVnTVRoU2FPNjFGbXRVb0N1OUhYYjhXeWZTa1ZwY0E4NWlQSHBtdGs3K2FW?=
 =?utf-8?B?dXM5aWdBalg1ZWpUWFVueGRUWjdWQlpWR001b1R6M1lvTkp6b3U2bDFrbDVF?=
 =?utf-8?B?S1hnbVNsNkw2aVUza0MxTjl6aG93SC9PZFhGTzN1RkVTdFRuNHBDY1FPRjMx?=
 =?utf-8?B?aGw3Vm5XSjlVWGk3SVB6ZEIybVRjdWFwa2JSUkJNNXJTQVRHQ3BGeTl4K2hq?=
 =?utf-8?B?SXRkOXFCV2RIaldGcFE3UGhZcnV4NFZFVE1TN2o3MWVacHp1cDdWajFxajBr?=
 =?utf-8?B?SWJYK3Z6Ymtsc2pnUk9NU1ArR1JReUlxQ3p5VUUwNTRqS2RTODQvUnZpLzQz?=
 =?utf-8?B?Q213bHFocUpxbWhWZnFROVI2OU40U25aWnVzVldFaGYyTlNyT29kc01HQ0E0?=
 =?utf-8?B?TkhHODMwNzE1TzZOdC9sbDJiSFdrM1BxUkp5b0l6SHZIOVJ1K1NKbDFBU3lR?=
 =?utf-8?B?RE5hTmhQUUJ3NWVpUFZHUWplcS9GRkVKaEF5NEUvQVRvbmJWRUVlbnJQdTdB?=
 =?utf-8?B?MTlhQVB3T0llemtCcDNXUVVqaWhOaUU3c3U1OWNVSklrWTVINTRUc0IvWkRo?=
 =?utf-8?B?THIwMDhqSEZoL0dpK1FIdTBSdUV6RjVtWWVmcDByTTZZN1Z5a3BsRkJJS09J?=
 =?utf-8?B?U25TZ2JmSkF4VlFGOHUwd3AvQjlwdzVGcWlySUxIQWxjTEZCZXhtbldNL1lL?=
 =?utf-8?B?MG9aNGpqdnVMNXJNN0pzZFZmaG5FVTlpZ2M4Yjd6TFJ6amdEOFp5emVNUGEz?=
 =?utf-8?B?Umk4cDdOaTFIdFYxWnpuc21KMzhLM1NmMHVpUlR3MlFWcEU4T3NaMVVNSk04?=
 =?utf-8?B?L2tYS3RLMmZ5SXB4SWtwdnB1UHYxK1QzemRweHJMTEwwQjNjNUdNR1dGVDZx?=
 =?utf-8?B?NjNrcnRoU3p6cFdtTVBLMm9wTm95bkpTeXdxWEJJcnhkWGx2amNtY08vT0U4?=
 =?utf-8?B?Q1RNV3BSZ1plVzdvUWIwZTd4ZEp4RnhYeWEzZUI3aXpOS0NNQXIrZ0N6b3hs?=
 =?utf-8?B?SFFpak9tRW1MZnJFQ0VnSWxmSEsxbE91M1dLSlB0MGhWb2dVc0pNdTlKSVRh?=
 =?utf-8?B?Q1B3cUtoRE91NjR1TG9EaXJyT2cwNDhiOElyaFRIb2d1VlZGMmh4UXBybUNG?=
 =?utf-8?B?Tm1YRXBzQlVDdEZuMmQvd2NhTitYckcyNlVZc1FCeUVDM2VQT0cwZ3h1UnBn?=
 =?utf-8?Q?PTbhk3edtAKYu0cgmZCl5MA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j/jB3WCdZVaEdQXGLhD/w1wo9khz4mxCXZfhketsQhnNLDP7FChpSA4aoe7Hzh96NcrH/7QxSodPRFPdZD6LokU/rRavfsQP8qKyUoqj9BWZsS2I/KC/vm3JmoWEzBchUbO1h9BfarY90Ngmdpw6D1r0XwucI7AHYfBSapY9qUjivmEXjXfF5q2CxGP4YOqMeeQZ6LV86sMdlQLApRLU59X+yH2xzOA9SHYhKFlBbvHmVqrO/53Rib7ZfzwpglIWqqUseLMD4jKBz3OloTGjq3BRoK2KQuFVBZVWx+M41Myq6uNyp3lRhzzAOxC1jnU9QZfNe4rF3hJD57Yfa80yAzKuL5Z5rv+ifg/pioKL214ZaliGe+S7+10rm4MI+S0LzViQXi7rQZ4EtO/hwmHVx73b3HKMiOyR9l9ryYJjP5t/CSne48dvLWfyb5SinZp5
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 04:10:55.2226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4229c128-e8f2-46cb-a386-08de735ab4ec
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5204
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



On 23/02/26 20:15, Udit Kumar wrote:
> unlocking control mmr before spl_early_init leads to

Nit: capitalize the first letter

> unpredicable behaviour.

and run through codespell.

Commit msg is vague. What unpredictable behavior? How do we know moving
the ctrl_mmr_unlock() to after spl_early_init() really resolves this
unpredictable behavior?

> So unlock it after spl_early_init.
> 

Wrap commit msg at 80 char uniformly please.

> Fixes: 5e291ee34fd4 ("arch: mach-k3: Introduce basic files to support J722S SoC family")
> Reported-by: Diwakar Dhyani <d-dhyani@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---

> On HS-SE of J722S in particular, enable_mcu_esm_reset function is not able to reset bit-17 of ctrl mmr CTRLMMR_MCU_RST_CTRL.
> Which leads to wdt is not functional. With this change
> bit-17 was getting reset properly on HS-SE and HS-FS devices.
> 

This too needs to go into commit msg if not in $subject as this is what
user actually sees as the issue.

> HS-FS
> https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-fs
> 
> HS-SE
> https://gist.github.com/uditkumarti/4ba05c9335212630ce9240ac67e11c2d#file-hs-se
> 
>  arch/arm/mach-k3/j722s/j722s_init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-k3/j722s/j722s_init.c b/arch/arm/mach-k3/j722s/j722s_init.c
> index 1180c75f551..a0dab5d7032 100644
> --- a/arch/arm/mach-k3/j722s/j722s_init.c
> +++ b/arch/arm/mach-k3/j722s/j722s_init.c
> @@ -84,13 +84,13 @@ static void k3_spl_init(void)
>  	 */
>  	store_boot_info_from_rom();
>  
> -	ctrl_mmr_unlock();
> -
>  	/* Init DM early */
>  	ret = spl_early_init();
>  	if (ret)
>  		panic("spl_early_init() failed: %d\n", ret);
>  
> +	ctrl_mmr_unlock();
> +
>  	/*
>  	 * Process pinctrl for the serial0 a.k.a. WKUP_UART0 module and continue
>  	 * regardless of the result of pinctrl. Do this without probing the

-- 
Regards
Vignesh
https://ti.com/opensource

