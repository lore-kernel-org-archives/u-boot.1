Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC3DCD3420
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 09:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DFB38871E;
	Tue,  3 Sep 2024 11:42:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="MsO40ivc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE6B5888FB; Tue,  3 Sep 2024 11:42:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A8B882EF
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 11:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fY5G3C/BjsjyA5ohaDGv6OV+p5xHcbJqrLI/ySXNFOiX0baKp9GAsZRxTaq/iU6jERy+phW4q/bdxkBSfts6gvF4db3hzHnQQgPfQEDVIlmt228yMtBOwnf88hxMs0WcLWibKZgtz2EWORHydx22MtKaun3Ure9ommfj/QThjr/bD2xKToZezoP52Dc1xtW2KOy7+VIN2oCGok/zSdKT2ylVJYcTxsut1dfp5FWbuY/xKF+bfHjGA9tyRiG20Lhes/CcYgbo0U94/iMp3G/UOaRYUQpcvqYlPvTINZ7lifkf3WCTDYjNnhV3wvO3PC/lvpAcJcPuTUgjNlCdhdANow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoiC7SDlKlEWdQgZMLQ1yUnlCjJz64WV3sh7zg+XFf8=;
 b=zErh5tffHo3IvcaCKKwz4Pp6qLKs2jVm8SfoATXNb3eEXJRcD1+fS9HPYxIIpJbJxPeG6aQgBPG0yQ/D5N6DVq5kTyIfw1SrK2L7g1v4eoGP8Tk0MiJ6dyHN9U3dcvm2qL270lYfz1oXH2XPWS6cxiXrf5sF4HMF8NOyLEYpv7xd+LlsB7+wmMSNYp/RQxrruKpPA1bdRf41BUMTFbmzkvOZwmxMbDCN0pbImVy+2uodFrcOhxylEMhsV127Y0A65pZRRHwBMMNSSZjHlpEvSpnNImcmMVGC2A2D2hh/dPuGB0u38L21h0MOrcXIj/WMz6RpSQ8YG9C2LC9vslp6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoiC7SDlKlEWdQgZMLQ1yUnlCjJz64WV3sh7zg+XFf8=;
 b=MsO40ivcvAM3xSYhM430GHrbZiTc2rNwk/QJm9NQwKwucNLwAK5N+T0evDM25Y7JgkNAYQdrlEgrU5TywgHp1z4nJzztvmH8saUP6QAYfiUPI6yIGq+hOnppqdoPcI66NreV7BhZwgM8Qlh0TzToOrjnmim0in2kquASHYj32so=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS1PR04MB9383.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 09:42:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 09:42:21 +0000
Message-ID: <8ff14ff9-eadb-4d75-a7f4-49a548110899@cherry.de>
Date: Tue, 3 Sep 2024 11:42:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/23] cmd: Fix memory-mapping in cmp command
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240901222634.460873-1-sjg@chromium.org>
 <20240901222634.460873-20-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240901222634.460873-20-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0004.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS1PR04MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 85031d61-61a9-4f57-868b-08dccbfcb544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZS8xd21zVEtjcHZDNzZjclF1c2VVQWtkZ3FHRWVpM0JnN2gvNTZhR1lVdVow?=
 =?utf-8?B?YXNlQTVldXUvZjl1ZWdiY1VkNjBsZU9iaXVZZkh6NUIzcXErNldqRWo1ZmQ3?=
 =?utf-8?B?cngvd3duTXNSdk5wbmpJZk9wOE5nV3lGUVprdk9LVVU1K3Y2QUo0TTJGT2dC?=
 =?utf-8?B?SU0wekxKeDZyMk4wellrM2JZVGQ5Z0xJL295NDVaSHVhQm0vdU9XM2g4OEtE?=
 =?utf-8?B?OUVhVDNIRXRQRzU5ZGM5UHBPVjFROERobUVsRlE1RTk2bzQ4NDNWMnJYMzNl?=
 =?utf-8?B?MEZxcnR6WWgrTEFYTFA2WWNzSkpJb1p6dDVVRnVmMmVUSTRYMklESDVXQWlv?=
 =?utf-8?B?RFlzaGdiRWNXckRtbmdpMUs0cUlPSmJ2ZUIvSHB2Mno3NVdYa3p3MjB3RkpE?=
 =?utf-8?B?UEVCR25BbXFObFc0Rm5kQ3pmeUZ4SXRRV0lycDk4TkF3c3lVbmhDYWlWb3Jx?=
 =?utf-8?B?OW1ka1ZEbm5RdjFuRXAxa0ZZZG9rNzJBYXNXR3N4dGFLMGtMS0lzMFZhL2VF?=
 =?utf-8?B?SnhGTjh5eU1CQWptSjEzeFNZVmtVS1R2UmVDQzZrangrbUgzSFhhRWVUeEdo?=
 =?utf-8?B?Q2poQmdNTHhvL2ZLUzUrck9vd2VxSTlxNHRkd0p5Ull1QmFTMmlKc1E1bVJs?=
 =?utf-8?B?SHhjbEpEMWM0d1F2RHlwVlkreXhHTGIyb0VOSFljZ1UxY1F6cGZwYmZIVHR0?=
 =?utf-8?B?aVdNTUNBQ1BsakFpZlNvNlMrcEdnWWtlL3JvSWxETHVxc3BGUGY0U0gyekkv?=
 =?utf-8?B?dUdpRFdtN3NKcnVSMURjQ1FocmJEZzJKTXR3d1hpTk14L1N6QVREcEV1S3c2?=
 =?utf-8?B?UVQ2a0NOUDZnbFhKSFJCcFJLYm5rZ3ZaZjNQM29NQVdmbFVQM1lORTJ1eGFH?=
 =?utf-8?B?TVFFVncwbml5aFBtRHFnSElKeGhwRDBIYSsvNGJpTE5VbjhlMkx1eEFodlhw?=
 =?utf-8?B?K0RBeWt0UVZySG5vTm5ERWxGc3duY3EyanErNU9vbzIyOUtzbmlKbXhvQlll?=
 =?utf-8?B?TnM3Qnc4WDl6cWFWV3lsL05QdE1FdXBlcE0zYnlsOWRSUnluaHFRQWM5eXFs?=
 =?utf-8?B?cEViaUJLek5mS05KODZ2ME5TdXkyQU1kOWFaSVlBVk9rclZKT0VKeC9TQkZ1?=
 =?utf-8?B?RWhMVlhGK2tlZ1czRGtpSHZGYmNvcmV3K3ZYQXozMzJ2SllvcTEwTmJ1UE9k?=
 =?utf-8?B?OHl0ZkI3Z2o1RjR4MHZ6OEJNYWVmOXJPRlZtbE1Sc2J5bUJud3Fpd2RCS21n?=
 =?utf-8?B?OVlLSGc4N0lZRmlOeUtzaGFQK0wvUy9maUNFcW5Zd3dPWmVzZC9PNkU5MUtX?=
 =?utf-8?B?YTN0Z0FGMkZPdTk0Y1NGVG5YUmQrRElPMGw0aWI2QmorVlhUQWR3TEhhcDBI?=
 =?utf-8?B?aE50T1EwNHNEQmZmZm1TTjMrV3NQdThZdWIxbVZzYWpzZENRc00xWmFNY01W?=
 =?utf-8?B?ajB1NjZNNE1FbjladEdKOTdRbmdObHFTOEFYa0dZTmxtRVBxMjB5ME1Jcjdk?=
 =?utf-8?B?SUFzb09LS1gwWUR5c1pXcHJsUDFtakhjdFlZUmtDS2YwRk9TUUV0NE1KYllr?=
 =?utf-8?B?dXFLWGFqM2ZHS0FIcCtLR2tJSitueDRaaHFFYjMyQXBSM0VLajlzcE9LdnU4?=
 =?utf-8?B?dnRjMDFuMmN6M04xRmpqeWFYbkUvU2MrTmZPNUtJOVVtZ01wVmswM3Q1TmEv?=
 =?utf-8?B?dWlGZjY0UUVnQjV1OGRZTWYzNW52cHdESEl2VXE1SHNXZ3dHL0RtS1ZsNHE2?=
 =?utf-8?B?TDIxWnhXQk1Ed3lMQXB6WWlBZGh2b09JSGQ1aVppWVliMlpERXVhSFpGR1VV?=
 =?utf-8?B?eGtGSmtwMU9KTUd3OXFtQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk9FbmJMUENjc255R3MzVWNJeFFFWDFKVWFSS3h5WWdkVm11N256KzM3VVBP?=
 =?utf-8?B?bFREMGpCaVh1cHNOcWdNYkZ6MDdNSjJZMFhMS1pzMmVud1psZGhjb0NnNzNG?=
 =?utf-8?B?K1ZJUmtzaVMvcUZIMXU2SmxMNmJONTdjanUybVNtbGdwZkF2bGY5bWxBWDBE?=
 =?utf-8?B?MTZiRDJCM3d2VTZBMWpqTXErdzBwUS9Mem9NQ3JKSSs4cGx5YkpBR05Ia1Fq?=
 =?utf-8?B?QjRHcTkxWG0zL1Z2d2VwNUxGQnFUUTY5Y3U1MGl4ckZQRmY3c2tqS2h6ellL?=
 =?utf-8?B?Vzd2WDNoN2R1NkNNL2xyb29IcFFsRTVmOTdoTUZJclUzVjU2a0x4MG9KWFJO?=
 =?utf-8?B?K3RJRlRPU3F0Y3ZnT3N4VU56TGJxWTNDNjRUc29hcXI1RUNlNE43SWxlU1Ba?=
 =?utf-8?B?c3RwQkxlaHVEZ0NSOEhVbHhLN1FPdldBZ0ZuY2d3aHhYcE1YZ0UxK2crZUx4?=
 =?utf-8?B?M2RLYzljWUlEYWhVTkVhbmZ5dG1LTGFuaEhNR2xYb09haU02K3FOemJ5TlQr?=
 =?utf-8?B?TzJhSjNteUNVSnpIUXhkc3V1TDZ5QUNpUkQzNEFWR2JYcDVub0dkbU5haXd2?=
 =?utf-8?B?Q2lqamd4TXdlYlBoRCtlT1VoOHIxbEdPMkhtWXZyUmZtcXRaRExlUlV5SXhu?=
 =?utf-8?B?aE5XZEhVdG9zKzZFeE0zbjB0d3NTUStvaGdicklGMGZBc0hiLzEzZ01IRGtO?=
 =?utf-8?B?UUg4c205NEx6TS9hT0ovN2lnOXU0bUoraUFVRkx5OXhxVjVTQ2tmOTBvWW5W?=
 =?utf-8?B?anVuVEhtLzN2ZGI2Ry9LWEpWOWNyUVRQV2FPRElXdHUwekV0ZUIxTTBqeTJh?=
 =?utf-8?B?U3RFNTF2NVhTNkphRzZQcE9RUk1pZWdvM1B6N2wwdDI0L3hlT0VkMDJFajhV?=
 =?utf-8?B?d2lKc1dJKzcxVW8veXM5MC9xWTVJUVJCZ1dJbUE4aVZVdUFDR1NuU01sTzFs?=
 =?utf-8?B?WG9FRExmZmpqM0JTSUx2NEpOVkZ1U3JKQVB3UFFEa0l5NzlSeXFsUmFGS210?=
 =?utf-8?B?SEQvZ244TS8vWWNxU2FVZzR5aUxYMzJiZ2RMUmQ5NWp5N0ZlUjBBZ0RlOFd3?=
 =?utf-8?B?b1RFTHhBakZ3NzQ3RWhmV25VMFNXN2RPM3p4dWFzWTM5ZW5sUjNYTnpnN1pJ?=
 =?utf-8?B?TVRmekJTcVRQaXNvajY3VHA1d2h6blVSdkU5UWJnQytlcGRHbnVkTVY1OXFr?=
 =?utf-8?B?Zkp0MEhVNk9GbDdGalkwL2dDbEF0VkdubGhkbTNiOXh2dkZna0hNSFM1UTd3?=
 =?utf-8?B?dkM3bFh6MUJQRkZYeFlpbWpxbWRhOU5GUHY4VnJocm5QbG9SNW1TYjVrZGQx?=
 =?utf-8?B?VGJHTkE5VUg2VzZwQlVnVEZnZEtsbXdsR0NxTGJteDV6QWpkdCtMYktWdkNr?=
 =?utf-8?B?VUNmZmFWZ1M5T0drQUI4V3ZsSmF6VVBLUlZXY3pjLzVOUWJhTWFqVUhxeS93?=
 =?utf-8?B?dnJkWjhYakF4dWVsZVB4WGRSa1Q3TE85TGNkL3pVZld5dVZ0NzczeEJmM2g5?=
 =?utf-8?B?dzBMTUFwMGFKaXJPUytEa2dxcUwxcU1tYnhCbFRkQ0w4bmFYZ2hudzEvZVJL?=
 =?utf-8?B?R29ybDNqNW4wY3B2eU9oY3RzMlVqaW1uSDh3RU55c2dORElCWHVkL3dVOXRQ?=
 =?utf-8?B?cU8xRmtMcHpuUGxXZWhrdnBDYWV4ZTVaeTc2TlpLazl3UThlZVZOVGIybllE?=
 =?utf-8?B?OGpQRTNHUTJWK3FJRHF5MGJEc3VVc2tzWnNwMkdUWEFEc05iLzRWV05LUDJp?=
 =?utf-8?B?WGJNVUNJVzBiRHJzb3dGS3RJUjFjamw3ZzUwQ2lDSmN3NUdoQUxQVkp5bFdU?=
 =?utf-8?B?dkZtTHN5L0pJeGFuT3RLeldUTGFTSWI3b1lTQW42LzVBWlh0bitBWSt6S2F1?=
 =?utf-8?B?ZEdsZ1VsUExleVZqcndScWdsSS9TdGFGUGJZQ1N6eG5hS2tiK1BjNFh1S0U5?=
 =?utf-8?B?Vktyc0hSREdubDBrQXhDYnRUdS9DMXFTcE1MOHBoRCtnYTBsT0xud0x1OWVB?=
 =?utf-8?B?MlUvRmVVZUZFOXlRUzFrUnV1aVN3WUtXWE1GRGlVeWJlV2VCdFVvaGNLMHdk?=
 =?utf-8?B?N1Z6NWZMVDRhSkJjT1JyaWQwUFFFTWxqQlNzYllWYkwvZHpUeFRka2dabnBi?=
 =?utf-8?B?RStidE15ZUo0dlg3NU56cmJOaGFiOHFWOVl0WGJUWG9Mam1KenpCMG5xRXhP?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 85031d61-61a9-4f57-868b-08dccbfcb544
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 09:42:21.4495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ank5uolhBojiUjYrgfTVSK7tFKOh94/zbYaAYeLePxUkdfKSqV8u5Ru8D0Lgi5P3WXw9eWNwSd/WxugW7ywYTi+stzdDemJR95cuYqaOQHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9383
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

Hi Simon,

On 9/2/24 12:26 AM, Simon Glass wrote:
> This unmaps a different address from what was mapped. Fix it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   cmd/mem.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/cmd/mem.c b/cmd/mem.c
> index 274348068c2..4d6fde28531 100644
> --- a/cmd/mem.c
> +++ b/cmd/mem.c
> @@ -245,7 +245,7 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
>   	int	size;
>   	int     rcode = 0;
>   	const char *type;
> -	const void *buf1, *buf2, *base;
> +	const void *buf1, *buf2, *base, *ptr1, *ptr2;
>   	ulong word1, word2;  /* 64-bit if MEM_SUPPORT_64BIT_DATA */
>   
>   	if (argc != 4)
> @@ -270,22 +270,22 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
>   	bytes = size * count;
>   	base = buf1 = map_sysmem(addr1, bytes);

"base" isn't changed in the rest of the code, so we could just reuse it 
instead of declaring yet another variable.

>   	buf2 = map_sysmem(addr2, bytes);

We could also set ptr2 here... Allowing to avoid the diff from here to....

> -	for (ngood = 0; ngood < count; ++ngood) {
> +	for (ngood = 0, ptr1 = buf1, ptr2 = buf2; ngood < count; ++ngood) { >   		if (size == 4) {
> -			word1 = *(u32 *)buf1;
> -			word2 = *(u32 *)buf2;
> +			word1 = *(u32 *)ptr1;
> +			word2 = *(u32 *)ptr2;
>   		} else if (MEM_SUPPORT_64BIT_DATA && size == 8) {
> -			word1 = *(ulong *)buf1;
> -			word2 = *(ulong *)buf2;
> +			word1 = *(ulong *)ptr1;
> +			word2 = *(ulong *)ptr2;
>   		} else if (size == 2) {
> -			word1 = *(u16 *)buf1;
> -			word2 = *(u16 *)buf2;
> +			word1 = *(u16 *)ptr1;
> +			word2 = *(u16 *)ptr2;
>   		} else {
> -			word1 = *(u8 *)buf1;
> -			word2 = *(u8 *)buf2;
> +			word1 = *(u8 *)ptr1;
> +			word2 = *(u8 *)ptr2;
>   		}
>   		if (word1 != word2) {
> -			ulong offset = buf1 - base;
> +			ulong offset = ptr1 - base;
>   			printf("%s at 0x%08lx (%#0*lx) != %s at 0x%08lx (%#0*lx)\n",
>   				type, (ulong)(addr1 + offset), size, word1,
>   				type, (ulong)(addr2 + offset), size, word2);
> @@ -293,8 +293,8 @@ static int do_mem_cmp(struct cmd_tbl *cmdtp, int flag, int argc,
>   			break;
>   		}
>   
> -		buf1 += size;
> -		buf2 += size;
> +		ptr1 += size;
> +		ptr2 += size;
>   

here - making the commit all the more explicit (for me this commit is 
basically only renaming a variable, since unmap_system doesn't appear in 
the git context) - by only changing:

unmap_system(buf1);
unmap_system(buf2);

to

unmap_system(base);
unmap_system(ptr2);

I believe?

Additionally, my linter tells me that:

buf1 += size;
buf2 += size;

is undefined behavior:

arithOperationsOnVoidPointer: 'buf1' is of type 'const void *'. When 
using void pointers in calculations, the behaviour is undefined.

I suggest the following:

buf1 = ((u8 *)buf1) + size;
buf2 = ((u8 *)buf2) + size;

since size seems to be size in bytes?

What do you think?

We already have test/cmd/mem.c is this something we can augment to test 
the unmapping is proper too?

Cheers,
Quentin
