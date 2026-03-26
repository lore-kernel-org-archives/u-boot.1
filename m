Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FC82109E558
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 06:51:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E3A181E18;
	Thu, 26 Mar 2026 07:51:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="tDc2y14P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C465B838BB; Thu, 26 Mar 2026 07:51:12 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB84480517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 07:51:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLkomSTbcDlnfiLHTHittvlFm8pcHQoNIwdhrWKW+hcQL9ccz0Oi3kuz3ThrLacv5L/29mFx3ZIjjPLWr2TeLNG3jueuNPs5I1rw3L/H/FwpRCBrP50duDOMG0LDenummO7rzv8PBFyhKz9hwFlJ01iTlqxFN4B2HDhZ5CeWLagXbai/sXD3XVuLXmxdZFD/+PejE29CJgOIycP14AtYWLvG9eumagi5hDKR+JMSm3Zx7V3cwG/h64WzOM8NDzgMJuRDUTChvvX8jpLkfG+hmx9oVnqPMjyLhjfnWnlIqOubUtVbAIpP0IjwzqR9CnQ76ySHzlM+S7T3BL7SqLevtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDIaeX28ycYBy8xXupgu4f4nuwqvS1aZjbVN/fnZ2vE=;
 b=hsRUvDSjlEqRwUudftgXWx7ZAa4rFGYPzYN2MksoGIezRJ/pbdKQHplwi4OeIeAarZPpd204WPtgnHcicpDqsmoncFCn7RnLbHMDVx3gwEV0lLlwpJx8+D0kh7TNtOH98meZ+OzZsRccY/jM1JyY7y+Mpm97Ff4LuAoECBujGV1oo36miX6BTKCpSFVNh9SYaDmOrDaEJTS/shL3Kl91PeDc0lRwRaE9h19oqbXD9EUDF2GSzQ7dGtS6oLSiHs/4JIwERIDR7fn9sDg+cVmsKun+x3sQCyhI1Cn17wgA3Qv7aZCxbPWJV9O7QdrzMZ1GEl/NoDQqdjupzXzVEaerag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDIaeX28ycYBy8xXupgu4f4nuwqvS1aZjbVN/fnZ2vE=;
 b=tDc2y14PFiw4peZFQok8aG+YjnWuyuOXjo/8bAl1A5xcvsIqyz3VtSav3OZUpEV8xpoySuHTPmcNGdyz8au1IH7W/l84g5jTdWMmNAN3TroEwRDr+YZ2POQTvmO3LrkmtGkMBg6RMf8jrVt/0/JRYKzdjguRZCS9ePzUs/Z125jpyKJ/DQkugigSGzqz1iO4OIfPnO5o2EtvPAYUhZxtK260ZVtUjD8FCcg4+Dobusobzp0/+6wSLuPYR4aWOSsMhZLpsiln/VukRyHYuqL6Fe8Wyoobatpf2p2b6nginXgK9WDVBIJU1FHbMjmbW51gcjOI/DBASrZiickfDwXRXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by VI1PR10MB3296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:131::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 06:51:04 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 06:51:04 +0000
Message-ID: <f08650c6-921c-45c7-9fd1-4b9d89dafed0@kontron.de>
Date: Thu, 26 Mar 2026 07:51:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] osm-s-mx93: Drop unnecessary BOARD_EARLY_INIT_F usage
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260325190034.3428684-1-trini@konsulko.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260325190034.3428684-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::6) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|VI1PR10MB3296:EE_
X-MS-Office365-Filtering-Correlation-Id: 66886fdb-f92e-4bd1-061f-08de8b040cdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 0BmputT06+/EGy7Vy0GztnHvHfnzYrubCpx1tN4BrdlK2vLBfyh1jfh+/9XYaRJWuLzcCMFRuMVBPccvC6Q2lHC1LMFXxQbJbVTOKIkogRFRAo5kfTeomDFR05yNJzyURPOLOU9pRUEWZ5muvefLaX/Qps4w1ePW1v06Kfj2/XermEjZNV/0a1WlYG/3TNfZns+mPilmjSGnSdrDiynH51tA6/+RBQLAoMz1ey+UcJJYi71SIg8Z5YKcAf/mN432qQtHiPqnIHCsCV903Fjy3sYiWXNN3zDFXixji/JHxzdmNoYncg3qn5tE3qu8zrqlrpv0NNomGHvxwz8pd+E/x3LNcSd/0prJ6xRiGEgQQXSIWfr9tW5vE+PoB+Wwx3Hx4LTsTPDnBtXd+2G8zmg2Y0av5x4M45oSYiKqGupyBL/sSaPKSnOy8Cxc5xw8/hyRwaPcy3D/W+ZqD7kP9RPw3cP8rvxLqrOqh6UQ3wgBcGd7BGEUuwKYlvnmc/phJvGfjZrQG9TOBQu56c0mWb6JPmqwgm0sNTltdnxn9NEyoFUib0uwfSQVSFGtymw7wfgzVck9taD9wdplPvfSypLoHPhzv+/v9ewRp2FMat+muPje23WolVIJS5tMV3bpCmGr26wC+q5YVA0ToC4Rr26PHiIXtNP0XYbVB96Lxz0bNg+MQsJia9LxHTM36GbzPbF9/quKOFHKPoPg2JSwS93QbiDG+CG/8Bf4E2frGcTY4AQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhOT3JwQjloNXR3NnhjYVY2RnJvekJ4ZnBua3VHdVVoaW4wZkpRWWN0SnRs?=
 =?utf-8?B?SUtiMzNwMXRoZU52dTJydGppUElJN2JhalJSTWJQeU5Wb3VZdGdmekFYOFB0?=
 =?utf-8?B?clZUbi9yVWhiRzNFdXN3dUxrWmJiSUp0dUV3WWhzOUkzeG1QSmdBd2drMzBL?=
 =?utf-8?B?dXNyQ0NaOW9nV3JVTVFaQ1kxNHhaSVFhSHVVeEpIUWtTdktEWlk3dGVmZ01h?=
 =?utf-8?B?bHdhWlpCT2x0ZU5DR2RnMklISGdXeEJPQnd1YXVtTitPcXhjaU5yNTUrbmhL?=
 =?utf-8?B?Y25HaXJSOVJXM1RsdW9CS3RXYzZjbk9OTmM5Vmw1T01qWmw4aWp0RWpZL3Vq?=
 =?utf-8?B?R3JvMHBZZWJ6Rno2RWRBZ1d6Z0hHemNtL1ErY1FsQzdaaE0zV2NGWUVhSEUx?=
 =?utf-8?B?cmxCMmVpYlZwU2RyU0pNcGdMa2FPNlNGOFJrK3QwblF4ZXZyTkJvampqV2lP?=
 =?utf-8?B?NkFzSUYrWUhLTWpNV0N5ZWJSR3FoVE9GL09nWEZHVDRQVVQ2RURtK3h0bk5C?=
 =?utf-8?B?Qkh5cDg5bC9QR2Qwakp2Mm9DWTBnbi95TEN0OUk3dG5WNEJwNVlDV2E4VDdB?=
 =?utf-8?B?c2VEMXhFbTVTaHdkK2xWWHkvRWxEc3dLV0IvS25sSlZidlV6bFRWT1E3NUxn?=
 =?utf-8?B?OHlBckk5VTlZVWhwV1BhNWR4VVN3TUhHdjBjT1pvSXJwOXNSdVk3cENmeHFY?=
 =?utf-8?B?b3J1d3pNK2V2UnliYUNzYVRneDh2S0pIelVsK29UU1FBMUYzZERPd1RjY3RQ?=
 =?utf-8?B?VVA4YlVLdlVCckhaT2dlNlJVcUs1VjZNalpnMjhMdDhWZ0UwYkpWYUlkMFhx?=
 =?utf-8?B?U0ZteXhoNFBCMlNpSWhsS0NCNmdtcm1FS1pEVnh6Nk5kN1NSTEhUb3NmWFRp?=
 =?utf-8?B?SVpBRUFaT2J3aHFZMGoxaGtKd3RXQTdqWStGYUF2M2N5emY3YmlpZEF0ODNa?=
 =?utf-8?B?dy9VMmVWaU9IMXpZckU1d21malFjWUt1M0ljRUl6bTdzTEhBaXI1YWhVNEMz?=
 =?utf-8?B?TFo0SzZCZWx5WllaVEJEZlpDL0U1aHFRVDN0Um9sVDUzYXUxdUp2eU1KQzdm?=
 =?utf-8?B?aXJzeklObERSNEQxRTZRMTBjbVIwYlA2OTZUYlhheHhFS3FIVnBrdkNZUHp5?=
 =?utf-8?B?RXExS3B5L2gyY3JKSHc1OWRFb3czTGhmNDNqd2Nwdmd0KzlZWmhaZFpSTDc4?=
 =?utf-8?B?Zk5LWndpcmttc0RjNUxMdm0wSWFsRE14YU9YZGlObmlKcnZHcHVadVVTT0pt?=
 =?utf-8?B?cHpxKzJZeERIS05ua3I4cmxzUnd2MjFiRmkxNlRpbjlkOVBCM0FVQmdibS9Y?=
 =?utf-8?B?cTRZOXNWU2lVRFJNaEVxVTMrWkRnWVYwWml1cjU3Y0xDU1N4RlEvNElPR1ht?=
 =?utf-8?B?em55UU9SVHNxc3pqQjlDVGFxY0tmZmtvc0lDMDhEekFaTFdzMkFpOStRR3Zs?=
 =?utf-8?B?TjFlNnhCOTN6cnprcWZjVFMwUHd2T3ZMbDBTT0tVM3RJZDhMR3lLcTdGbkEz?=
 =?utf-8?B?c1N1MFduMGpJc3cxUWVjVnR1RkJzSjFwSWEwcjF5ZnhLMTJLbjd6dHB2Sncx?=
 =?utf-8?B?OVIyQ1BhKzRFb0J2Q2R3RVY1akZ1QTRLNzUxZk9adkpSb296cGYrRHBnQXdk?=
 =?utf-8?B?SUFQdFF0MUpxNDBJRXEyZndxUm16aCtFTVFDNHcxOW94c3VNR21HdmZTVHVO?=
 =?utf-8?B?MkFOcGVRVDhjWGw4dUNxczNwbXBwckMyaXhPTW9Nc2w4b2lxYkIwTGZVN2wr?=
 =?utf-8?B?UG1yRmxSZHM4aVpiMVdEd0xEZlVQKzMxZUJzUkszMnU1L1ZuSG9oSVQ2SDIy?=
 =?utf-8?B?ZUp4UW5tSm9XTGZSaE1TZjhNeVBwcjN4azEraEJNbS91REZ5SUtwRHEyd3A4?=
 =?utf-8?B?MHh6U291MitTRmRnUUc3bUJlTnE3UllaUDR3dlIzTUxKZk5pK2dRb0hyUjlr?=
 =?utf-8?B?YytxQnljOE5Rb3o5a1ZiTDlnRkZTd1NwT2Y2dmJ0WWlIU3NaY2FFdTlZeGh4?=
 =?utf-8?B?R2M1b3hOd2MrZnA0dU03di9sMTdQYXhlRCsyejArRWErZThMaVgwUkRubU9i?=
 =?utf-8?B?WmlEcjVORU9PTWVzTE1DbXBTOHY2L3krTm5PamZ6K0Qxb0xTMXo0ZVpuNXVL?=
 =?utf-8?B?SFRvOWdBbUphMUxnNVVDN3hLQzIwUHBpaFVqcFY3NmdJTDNEN3NHS0Facyti?=
 =?utf-8?B?bzNpMFFwMXhHYlpVdUFieVhmR0hpYzdrMjFDeTBQR1p1dW05Tjh2bXZoY29q?=
 =?utf-8?B?c2ZzcmYvWnNSOFVIM29oK0JMK2liSjhoVTI1ZUhPZXYrMlZqWXhtMGNiK0Vj?=
 =?utf-8?B?ZWZpZitCT240b2lldkdDdzRFcjZZUTdSdUNDV3RHZzlwS3NuOENObTBPbVhH?=
 =?utf-8?Q?69VMyx+sebgn+EPg=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 66886fdb-f92e-4bd1-061f-08de8b040cdf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 06:51:04.6810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjaeqa5MbnEeG17354DTJeMdJAAvjk7swSnng2Q+qMfZ4ruBZ1OdM8z+8nTH4o3qiogEBR7ZfaiMrPA/94GJzpVeJz9bueTE9lVv7XLYXg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3296
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

On 25.03.26 20:00, Tom Rini wrote:
> This platform enables CONFIG_BOARD_EARLY_INIT_F and then has a
> do-nothing board_early_init_f function. Change to not enabling the
> option and so not needing an empty function.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

The description seems a bit off, as it looks like this board isn't even
enabling CONFIG_BOARD_EARLY_INIT_F.

But anyway:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> ---
> Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
> ---
>  board/kontron/osm-s-mx93/osm-s-mx93.c | 5 -----
>  board/kontron/osm-s-mx93/spl.c        | 2 --
>  2 files changed, 7 deletions(-)
> 
> diff --git a/board/kontron/osm-s-mx93/osm-s-mx93.c b/board/kontron/osm-s-mx93/osm-s-mx93.c
> index b6feef549d16..02bee34ac663 100644
> --- a/board/kontron/osm-s-mx93/osm-s-mx93.c
> +++ b/board/kontron/osm-s-mx93/osm-s-mx93.c
> @@ -22,11 +22,6 @@
>  
>  #include "../common/hw-uid.h"
>  
> -int board_early_init_f(void)
> -{
> -	return 0;
> -}
> -
>  #if IS_ENABLED(CONFIG_KONTRON_HW_UID)
>  struct uid_otp_loc uid_otp_locations[] = {
>  	{
> diff --git a/board/kontron/osm-s-mx93/spl.c b/board/kontron/osm-s-mx93/spl.c
> index 23a90e351fe9..a47fc43c6aa9 100644
> --- a/board/kontron/osm-s-mx93/spl.c
> +++ b/board/kontron/osm-s-mx93/spl.c
> @@ -132,8 +132,6 @@ void board_init_f(ulong dummy)
>  
>  	arch_cpu_init();
>  
> -	board_early_init_f();
> -
>  	spl_early_init();
>  
>  	preloader_console_init();

