Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78152FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CE584664;
	Thu, 30 Apr 2026 11:26:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XL1OQxE3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 864C684666; Thu, 30 Apr 2026 11:26:03 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C43BE84662
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:26:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxoB14iPAtkQk7gCZkkwjYes/4SIqEkPSZSgQisjBUKiUbJEJC1OHiIn0bY8th07nHfHvZaS6N0Qa1Q4yLfltgoUIGH8Woist1Ac4ce/s1iv2+HbnbNjOMqYAmICb5k1GnbtEM8nHNMBMdmn7BG3QWX+AN46YF7jMSjVG3zYDlSAw8HCdwN46rjiiEMorL/Jcka69yfmYiIPPJM7yeJ1YNdSagu91hmd3cHjGovr131f3Di2WlDnKtlckGwOiHTXMKLKJM7Nn7q2KkLEsMpNUyOIA1F4Ld4uP0CrRFeKtvE6ihHlCEBP85ppeMucsC6TgA2DICznbUygmWZryYSSTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf7ccU9/Y3SiSID/KT7M7ZkV5Uop2w9QXkeNmu3/fsc=;
 b=MVmvEdYHdqQ2OA+Vw73aqOLMHU5e0hFkQI+ZRnotv472y9LfkQZi5qGwsmcK7yGz4JYn+GZeVmTblerIf4Qm3xMBNHvbrh3iRVXTcaX21CoFVU8zq6nddtqwUd4a981jUWDTsvNov87XS7BFdcyl9hTpglHyJ8WD7V9ufUfcxvNIweZmcr2B/vqihZ05Dvih5tnqMz0Hkp+Upt/hUliqXWXtrtI79QAI++rvzsm2tKMShYUOd2HugHjBvlYSGX0a08iOXVhDyRjdjtVQjBCj/jZ1iAvq9cpNUmc7beKF7TKuUpMHKfRfHHe5pXEqV/cZGsi5G4ibLfnB6NGSY9P++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf7ccU9/Y3SiSID/KT7M7ZkV5Uop2w9QXkeNmu3/fsc=;
 b=XL1OQxE3DS++WXrrARPO14Qm0DTtGM862tcxyfAfT9+/w9mxxJjrWavIPdyV45FEUifB5Xb/n8SIXufDJHdGgaPqTetSPZhCbhtj6TuAEHr6devXK4MX/VcM6PQ/z+Pt+6kZid0x9W8AViq1eyX2f7TvHQNlQzMu+UOqzP9YdYdz3SJqqcsPw5EbjpRA8zyVPhp0d4sWkS+gw7t2n/ladw9K2NpQI+LL7loj0OqBeyvLoLq0mi4hKKDUD00eOnTyrgPY+ZBUmW5kY76YosdsrnBexUfgBMJtWjEyDIbtlGOqJUMFlqA3QeeKGMCV/IdW0YUdGCmbM2t3chAAXzhgLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by CH2PR03MB5206.namprd03.prod.outlook.com (2603:10b6:610:a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.21; Thu, 30 Apr
 2026 09:25:56 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.20.9846.021; Thu, 30 Apr 2026
 09:25:56 +0000
Message-ID: <950f0f1c-e004-4e70-a6ea-9a8053ac48dc@altera.com>
Date: Thu, 30 Apr 2026 17:25:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] configs: arria10: Enable random MAC address
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20260428013518.27331-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260428013518.27331-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|CH2PR03MB5206:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e255c1-f47c-4b4b-7757-08dea69a7b7d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|55112099003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: f1IIYRiR0+fEvwTauBq+keSQs9adhPoBkciUenVE8V5fivJkgYCFcPw02inKEkWsXQTXI8E0bi1Futh7uooaGtLAJzvEs9jZmv/tw2QODIh8lAWzYRjuBc73J/E6XzSKH12iqLm4JCuQujC0fZ4+aZhckeQNJWMEuMbLoZNas3ZSasSAtn0Adtj7rax8BQRZYzUJFVbHpmjsh2qnQQJM6n+0AyAXFq3Lset/qlLAFhkhfi1pPdDvpTtf3FPZYjB4x3SDLx6UCX/vxzw5Lvslx8g9JFXJS4eNIi5qONiQx6q2X7m7qPcVeR0ImMC/FBLy9kEjRJSaFoOOfuxud1gAS+aocroCs/xppDadbgO3asjU3SwvLzJl/flIOGZzm7QaB3vROlnSCeHG3C5lnihQMX+k6qsVTT/WIYADrmu+V6VlEeFQY3758KansDLLCNZZO2KJF4NUi1ev4rKMrLiUlWlpYLQ1RuRJn2SUJ3Zmy9MaxbMadCp7uCZ7LHbKQqznMrIE9KaNqIaFEhJcV90XSddVd/oZdcQ2s1dB65WDUp1uiRnQ9Dt9/mII6fABOuL+yU479un14axS2h7JaDKAFb/vBVy3CgmZRS7ouy2VV0i//WSHZ+FU+zw/GA2a74PQh8hSS/MNtwUK8yWDfIHi7kY4k7BBbJ0cLwiJYWM70BomThiE6tD+0V7FXBfxpRdSNO95v0/DvdTlOn8MFLN36z0b7L0GuW/73OsjpPBExy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(55112099003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2lFZlVSdENDSmRPdFZVRjBLRTlXUmc0N05JT3pUM1h3dXBHMEFRQzNoRDR5?=
 =?utf-8?B?Y1lEbEY4SHZKY0lDN3FTdERibnBOTjNub3hXQ0NIbWtUYm1BT0M1NUNPcm05?=
 =?utf-8?B?cnE3d0k0aTJtMjZMZ0xwTzFHQ1l6ajVFS0x0SEt1QXgxeEEvMWJkeVJJeHlm?=
 =?utf-8?B?WlBxTVA4MU1sYTBSMWw4M0pmanB3Tmw2RDcxcTl1VGhLN21NdHB5eEVKazQ2?=
 =?utf-8?B?NGVFa3RnV3orWWRCTHpBdFA3Y1ZtR2lkYnZsYndJejltQTkzYlZjR2RWZUZa?=
 =?utf-8?B?L1l5MklQaWNjV01ob1NMOWVhbzFWQ1E4Rk5WSjdNaGp4RHZzR3k5cXErL3JB?=
 =?utf-8?B?U2JqZTlMQkFjQVlpOUwyd0tkc1o5cWZoRWVDS0lEUzhSY21kVUJnL1dvMVVu?=
 =?utf-8?B?ZGFzQXVhcGFKbTlCb1RhUC90M0wzT0RDMDF3dFdXYkN0akhXN3NPL2xnZk1X?=
 =?utf-8?B?enBneExRTDBoSjA2RXduaUVzQitJSGZHNy9TbmFpUGQ3UDlOdkVHVTZPTXZ2?=
 =?utf-8?B?cjlIY3NSRkMwbjRac0pKNHFCeHgrVmhTSnF4aVVDRVNLVHZMeTIzY2VyeGZK?=
 =?utf-8?B?YkFVZjZqY1Y3aDF2RzZHZWQ0alVRY1NmcDY3NGhKdzNGeXpWODkyNFBGZEht?=
 =?utf-8?B?ZlRtWWZNT1Jkblp3OER2dlFaajlSOXVBOXZIQXRqWmN1U2pJQVEvMGo1ZEhM?=
 =?utf-8?B?Mk5hN3FUNm9kNXd5QWcxSjhlczNuSjdWT25kQ0VaVEZaalJneGVlU1hmVHlj?=
 =?utf-8?B?SWZ5eEpBd2VIb2h6by9rTUUrZkgyU1gwaUFKeGVtRkMzUkxEL3A4eURWR05M?=
 =?utf-8?B?K3hPSEI3aDBzQUE2MUZmSU4ra1BscHNOSG1wcjV3ditibTJFeTZFQkN6REFl?=
 =?utf-8?B?c2MxV0pXNVNpN0hCbCtJNlg2eU5PNGlZam1MQ21jVUtibW0rR3JVdUlLVlNW?=
 =?utf-8?B?cFJjSGN0UmV6enBqL3FhOWhFVGlYZG9MbnZ0Ukd2dmh2UkxBYlowMEZWUHBL?=
 =?utf-8?B?bGFVWjI3WEliZitPdTlkaldDWUNvcm41UWszZ0Q1WnZCYmZnNk1WZ0ZPMElk?=
 =?utf-8?B?YkhIQzAxR2NzNUJCaVZGTVVTTWxybTRJV1ZPV0xqM2xIL1ZpT1huZTducktv?=
 =?utf-8?B?RFZ4MUgwWHVoTEQyQVBOVTlOZWRIMGJGYzFKWWxLN0dZSW0wc0FDbDdya0Yr?=
 =?utf-8?B?SGF5ejQzNnNBc2NmVk5KWnNTVnZwckFUUlV5Wm14b0pKdFpXWHhZdndsbzdy?=
 =?utf-8?B?QldMZWpPV0VXRGI3VXpPRExPdHBIQ0tXUkdHNEhmTUlaRHNDUTV1cmJ6c2Jp?=
 =?utf-8?B?aEE0dHQ5OWd1VkwxbCt1bWJaUFhzQ002Z1c0YjBaYURDU0c1cFZyU2ZjcEFn?=
 =?utf-8?B?TllzL1BTVmZiRTM3eDh0QVNUdk13WTBsVEN0YUJuL3NsQUVEUWpmNjFVMFBs?=
 =?utf-8?B?MTd2djNIVDZ0SjJ1WCtuSU1QZXczSmwxMXlKTDVRQTRmSG9uc1BoYzJBVnJr?=
 =?utf-8?B?eSs3WEdUZk5KN2V0amxqS2tQZFZ6djlrc3RPUFRwTExsN2cvRm5KOHhWTWx4?=
 =?utf-8?B?SUJLbXJvL3BDQjFwcGx5dEtIUDBHRFVYTmpmb0dhNlRCaER0MVA2bFpBYjBj?=
 =?utf-8?B?VVVsNk1yRmJVbE5MVU9ibkNYck5zOFBPYk0zR0dtcGVwY2x0U05GcklKZzdN?=
 =?utf-8?B?WUVMa21EOFR6SW5qc3VSUTBqZkZheVdKMFEvWlZKYjZtU3RLdkhHTUtYQ0hE?=
 =?utf-8?B?NmhlV09KRUEyU2JBNkF1NlNvZitXNEswOXNIRDlpVXZPOGZIR2RDQTRycFBP?=
 =?utf-8?B?SmFiNVNQYnVSaDdqUlRneFFEKzhtYmVrODFNbU9VeXl0YmhXSitqOXQ3MG9R?=
 =?utf-8?B?Ums3eVR2NStnaVI1b3hJVmFTWDdQQmtoSDAyZDR3ejQzajVXSkovQjFOemcx?=
 =?utf-8?B?dnZFUG9lUmFnd2E3bytPdmNFaXJhRUM4ZDdiaGpaK2N4NUNxZGlWK2JWcXNP?=
 =?utf-8?B?VFdTdVJ1bDV0cTJWaUUrYmw1L0dHOE1UTVpCd1JZTnZMMUpKK3hqUGIxNUZs?=
 =?utf-8?B?bzVKRnhRK044aFFnaFhqL2hjSkd6MWZOcGtRajlQMG9EQzdaUmlnWmY1MHMx?=
 =?utf-8?B?OE5oNjcxSThNZTlrcEltdlRSYlo0QU5YQnhnQVAyWC9zZENnaTErTzcyYUJH?=
 =?utf-8?B?V250Z3ljRkFXOGNWQmNBb1MvZ3dvVVlqcGIyem92dVFRdi94NVpCTUFETHVG?=
 =?utf-8?B?aUswbjI4N0Q3WmR0MmRra0RydDlVQWpxcHUxSFVuUWRmMHNYOXlrZXMxams4?=
 =?utf-8?B?YnhhdnRsSWVCdWRkRVBHM21icjRTVDU2UURkTHp1OHkxbmhXQk1qSitLQ0Iz?=
 =?utf-8?Q?hjVGWP80998wst9Y=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e255c1-f47c-4b4b-7757-08dea69a7b7d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:25:56.4040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oF+GKwNvf4y3s3NbQ+tbLZExr7uZb+kR0MZt0hGnFq2E1vNlA5sgSWI3ui9v4qRm8zxVdPyEbiIAMce2bJYq3UYKb/t3r3N2nnx0pSfmKoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5206
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

On 28/4/2026 9:35 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable CONFIG_NET_RANDOM_ETHADDR to allow U-Boot to assign a random MAC
> address during Ethernet initialization when a valid MAC is not programmed
> in hardware.
>
> This avoids network initialization failures and MAC address conflicts,
> especially on boards used for development or shipped without a
> factory-programmed MAC.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_arria10_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_arria10_defconfig b/configs/socfpga_arria10_defconfig
> index b32f40ae408..4127b4ccbca 100644
> --- a/configs/socfpga_arria10_defconfig
> +++ b/configs/socfpga_arria10_defconfig
> @@ -50,6 +50,7 @@ CONFIG_OF_SPL_REMOVE_PROPS="interrupts interrupt-parent dmas dma-names"
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_DM_SEQ_ALIAS=y
>   CONFIG_DWAPB_GPIO=y
>   CONFIG_FS_LOADER=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>


Best regards,
Tien Fong

