Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673D2C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84469882E6;
	Mon, 17 Jun 2024 15:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Y+FZvrTx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEF5E8829B; Mon, 17 Jun 2024 15:30:04 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA2E8882DA
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 15:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6y85yWS8bzY/tdIiml5bDaqFg3LqQFF+0I0x82IU90b06I/I+F8xPSVDt/B6uJGlWT758X1I6DZFOD3GjJfMbTAmHN8ePVumgqQkIbnTd+AJ1LqXqlbVzrlBecXeetfO/xnF4Lfl2BZ1u/SRdTz42/DCXZ40/5P4g7dcUpsBhFISHFex67R0XtYUmwjUo38ZhpLq4/ZVCniBK6IXmOZbMH+GeW0E7LLJObcfUnBkNVzrV+qjBgoTg4eY480mJxorxxCMzNKJJoH+tZyhyO1QIzzIw1Tv1eH3y2+AqsfzFePgntSesR0JvUi7fpjogOQodVbHLIPb9u6X2ToiS5BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vl+mgd7zUvde4QSVbxIsRl6Q6kVRc3KPS8rtTPxdg5M=;
 b=JLqPCtwUD+liacbKwozjhsr/2BkBm5QbwpLU5Dps1pwOJtbKsB2Y4n+oClvrYNfppQ6LVkrW0ZfRDwnKAfYc/eU7kINbgPTn3q9ynEOgkVo9jQUxFiF+VaWvhan48jvyalKd9+gpLwDme4tEfQeNXHC5proVQrgBfu8nPH7k4vZ3xWSTlgakX7YTKeR/cz3CtI8k0MLCU7z7rp+3kGNAhmQ4PqPgIureWgnXd25DPKiQCR2DlN8HRzp1jsusZcntgTgZG9Dn+FJprRjdJrPuLzH4kvWoZ9llJ2/j2YmAWZnlyrm1yvSGJguMb6K/MyeyLyQR2kjgMpRXXqrVs5VfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vl+mgd7zUvde4QSVbxIsRl6Q6kVRc3KPS8rtTPxdg5M=;
 b=Y+FZvrTxbI8mh6xCVDUBwwZNBubW/PlMKyhE5hX+AU35XMv5jOk7b16JZmsKgnqVxeTRSg4dyCuMDrdsgIk6etzz99MEcunt0IKuwbo6R7NalOgsK9BC0qS4N3k+OTnvSxbApIQWBiXXHuJ9ozDa6DLXhwrARl1av4k0Ke5+NRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 13:29:59 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 13:29:59 +0000
Message-ID: <4a5cf733-68c5-405f-91df-f87583d9c6a5@cherry.de>
Date: Mon, 17 Jun 2024 15:29:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH COVER] rockchip: rk3399: fix SPI-NOR flash not found in
 U-Boot pre-reloc
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <foss+uboot@0leil.net>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240617-rk3399-fix-v1-1-69af21c2baed@cherry.de>
 <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <233bf248-735a-4564-8559-236a10ea89be@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 5edd980a-0e1a-4990-7ee7-08dc8ed195bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWtQbnpwaFB5cWN1ZEVnTVFxOHcvUVVEUGIrNk9TbTFYeXRhaTJaMDBEN2R3?=
 =?utf-8?B?aER0bFBPMzhHS2FjdDhmOXFyQ1E5aUxyWDVZVy9JWjFkbzgzTkFHVUF2cSs5?=
 =?utf-8?B?bERKMW1mNUw4Q2p0R1Y0bXRNKzhjQVM0TURUaGRnV2dlQkM4bk5WVVlrcm5Z?=
 =?utf-8?B?blg1UUp1QUJ2SE55d0FmenkzLzk0Q3dqNlU4Y256RXBhNTNOV0s4ZVZ5OHF0?=
 =?utf-8?B?Ynk0dmppN2dlMnNUTzBhcExVNEVuSEZuK2NNemo0S21qekJ4RnVyVWlhMnJQ?=
 =?utf-8?B?RDJ2OEVsNzEwRGxsYktOdjdlU3pNcDgrQWVlOGxqUkV0WlFQUjhQazVrRUEw?=
 =?utf-8?B?SFBNVEE0cTNJQk0yNXlCeFFMZWlNOHZwbExoN29WQ2pSd2NaVnNlNlhaT1hp?=
 =?utf-8?B?SWk2a3ZhV1czMGx3ZWc2VE1TMDdRdWNsejJMVCthSmw4dEthSzZHVUhodmJs?=
 =?utf-8?B?b2RYK0NDdWovT1RLcE13aUlRRE1XTHpnMytGY2dCV3l6MDJJT1o2SjNaTExZ?=
 =?utf-8?B?TUk0MWpERkpSWHFmaDdScjlsRzdxOXdnNVVUc0lhODM2SXMyR3lEUGJMVURV?=
 =?utf-8?B?SDArUlhobC9GNG91bUM2Ujd3SDNvcDF1TTNWNmo0ZFF0SU5jUDB3SXpCNWV3?=
 =?utf-8?B?WXJIRVNoUS9VT2VZWEM5U25wN1lJdlY1ZTR4cXdNQWFVcDVWUlpsN1BveU03?=
 =?utf-8?B?aFJ4YUxyNnB6dWxjSEp5UUo4SHkycWgxS0NFMXJDWDJPL2o3ckJGeE9zTGVr?=
 =?utf-8?B?aGZyNi9Kakh4T0dybS8vaGl4OC9FREZwa2JCU1VTd3UzaWRmNFd2a29JTWsy?=
 =?utf-8?B?K1JENW84eXNZM2N2elo3RDBOZ05RV0Fkc0E4eTJ3RCtmZXVjRzd0Ryt0LzRM?=
 =?utf-8?B?ckJhU01hRlZpNndxaUwyOHNkZjhaaU5JeUpuWVFLSXpibDB5ei9Uc0NlaW9L?=
 =?utf-8?B?NEZoMTRFNVpmV1B1UmU4RnlQbWlrQzVDdWpabnUrbmd6c1JNWEdmTjR6bkxX?=
 =?utf-8?B?SW93Y2V2dGV2OGkyMTVEQmN0cG5wN0dqOStia2EvVU1LbTY0L2JLM1lCNVhi?=
 =?utf-8?B?d2Q2VnlhSWtpa2N4VXFHc3YwUmNhN0xJeHk5aFJiY1JjaWRKbDFxT1lSMkJ1?=
 =?utf-8?B?ejhhV2dya0ZsMDlSdFJPaEhDaXVXdnVhSmxCQXY3bTRMdmRPMlVPWEJIaVJV?=
 =?utf-8?B?Ujc1dzU0QUlDVzNDVjgrWXhrVElzVmt6Y2hVZEw3OTIva3FnZWV0TkltNHFZ?=
 =?utf-8?B?dklCYlB4d05ia2R5eE9mWFBmbi9TL0c3Nm1Lczl1bU1iMGxVSmI4S1F6MEJV?=
 =?utf-8?B?Z1M4NlJLQlRiTmNmMGFoVUlvT3pSYW55NllNTVZONlAzWUdvMHo3cGxWVlJY?=
 =?utf-8?B?eXJod3RIWER6Yk85MjY2ZzZ6d1Z3Z1pFOW5ZZTMxYXU1MmJqN3V1aTc3TGJF?=
 =?utf-8?B?eUpOcGMvc1FnbjlWc3dLNWRrZUxxaEpSZkorcmhaaFp2RE5ycUpSTmtQS2s5?=
 =?utf-8?B?VVV4enBOSWNhOTE2b0U4d2ZaMUgrRk5xTTNUQlc0dXRtRCswdlFyTUtpNFlW?=
 =?utf-8?B?Ui9BZXpuSThYd29ITmprL3lvcDNzNUJPRXNxMVBrTHlod0NObythblpQdHM2?=
 =?utf-8?B?K0JFVTllckRYdmtzdTRZZmg4c1BoRVJ4cnFUY09CdnNZbHBKOGZVVGsrYnhn?=
 =?utf-8?B?MXE0Ri9FSUNHRmxJaVhHVGNuaWV2YkFnMnBEREpkOUlpNklTOVR5QVIzdEt0?=
 =?utf-8?Q?cgADqqYTwCXMxH3oylSqdpLzR4wH4JW9LcKKNPL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(366013)(1800799021)(376011); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnBsWDZzelFyNWd6eWNZaFRQZkFveGt4M21Sd0JQYXlWRnZKVWNEM0tmY1dF?=
 =?utf-8?B?czBuTHBuZXhhQ2tkQksxcFBoa1ZBRUhWVGRBWSt5T1VBTDNHUHZja1pFb0li?=
 =?utf-8?B?cDMzKy9UN2NvSVBKcy9hSUIzOEZrMjdkUHVldHhSQzd1T0tndFlDenFINmZ5?=
 =?utf-8?B?NVd0U2lDejdPVGNHSVQ1NUJPMUxTMXVnTkRjVFdYMmFXMSttQ3d2K3UzWkQv?=
 =?utf-8?B?R0lPZmE0MytVODJVaGZFVFZodVgwZmZyOHZ6Y29KYkkzczJxOVRkQzB0bWdS?=
 =?utf-8?B?MnVtcERqUHJXYWNnaGFnNEM2dUZMVEhCb0R2aU50ZmxRdlZpT1VmTzExeVY0?=
 =?utf-8?B?Um16b2EyMENUendmVmdGdG5TZC93MkphaWdydEt3ZWdlaWZQdkMvMklGMXZw?=
 =?utf-8?B?Z0ViTXRVcFAwQTRRSmt1cE1vVUNoOWp6aW5NL01tdld0Zk5EYlI2NjI0cHFj?=
 =?utf-8?B?b25rNVFZVXpDeE5RK3g2dHZGdnFoRk9ja3d0ZzhkbFNDNnEvVGg3MElNc1V6?=
 =?utf-8?B?ZXBoQWNpOCszMGxrTUs4dVF2MnRzcHQ2R2lpeml0T3NabDFldlFZWCt1ekgr?=
 =?utf-8?B?NWNVamJGcTllTS9QblVzbjZsc1VjbUR3RGlpakZlcTliaGJQSFI3VjY5bHIz?=
 =?utf-8?B?Yi9aVWltV1NOd0dYa3hLVWRZVkl2L0UzczI2c0xsaHBRWGVKeDZ6bUV2RHZZ?=
 =?utf-8?B?MThoZU1RODd3ejJvMnRUOEd5RG1VWGlhZ0NYQVBXZ1JjWHN6aVYwZ2NNNmM3?=
 =?utf-8?B?SVptRnZnc3VxN1Y5bTlUUlJDZWNEY1lFZ2hDaHpSTE0yOFk4d21vbnR2WVI5?=
 =?utf-8?B?WGFGWnhBa1Q3cURWTFlZejZHM0prb2I0cmFQMzFEenRoeENBODdueHJ5UUI4?=
 =?utf-8?B?NTBKbzlLZGRHRmdXMm4zTVFDSUl6c0NkWldZeFF1NThBK1p4YXhISmRUdXI3?=
 =?utf-8?B?Syt3RG82UDRiN0wxS2ZzdTQ3Q1d4L2JwRWRDRGJpRlNFVmU2My9zd2crQWdo?=
 =?utf-8?B?STFsTFlFSEF1MmRUTW5zYlkrOXFubUsyQkhyNmlRWjFrNkEzRWgweG9LaDAx?=
 =?utf-8?B?Z2JObTRoWFJzd1BrRGpxOU0wL1BlMjRNM05rcDFUa3dMV0tPRGx1MG1CcFF6?=
 =?utf-8?B?bURQWEN1R0ZtdFEvaERqRkZWRkpBQmZEbnNqR3RiQ005eGVYQnpvb0pMTXBF?=
 =?utf-8?B?L3NuNkJORCt0MVR1eHZScHlIV2p1anlRSDhWenoxZHJCS2pvN3p3bWUzTnZx?=
 =?utf-8?B?aVZxN2ZhVFQrVkJXNGNMVThsb1l4QUtSUUxqT0M0NExjaVJxQVRGOUc4dVhJ?=
 =?utf-8?B?aTlaRml4MGpYcDFQaUhETUlOeDNzTXVlb3dOWGdpRmIyQW1EOHQ4bFNZaTlk?=
 =?utf-8?B?THhRUkNCUDIvbUlET2djWmlLVlFMTGYxcVVyd2hKYlNqVjRNZUQvWmRnUjRj?=
 =?utf-8?B?WWxBcmc2eTltVmhhTDR0NWFub3RVWjJxQ0hldERxQUMzeDJtNVlBSE5MTEds?=
 =?utf-8?B?U1F5VFpJYmIyUExJeEZ1VFJGMGJnOGdwWUNIeTB5bll4MThGbWZqaDRtcGZz?=
 =?utf-8?B?L0JzTGpTNHNET1FQVUVuelJVSFdHd0Q5NnpRY1U5T00xeTVFODdjZWF2dmR3?=
 =?utf-8?B?Q0pUOXYzcG5rVkZVU2wxUng0Qi9FV0o0MERWUW01QURqU0IwMWlwbk9KMDBB?=
 =?utf-8?B?Rm1MenM0TThXYmFaLy90ZHZJU1NLaUZKM1ZoSmN6eEhWRHdTak44R0h5ekVr?=
 =?utf-8?B?aXc1cGNVcGdLZzE4VHhSNUJKU1V5ZDU1TGxWaUtrbENxdXU0OWRXNzUrMlMv?=
 =?utf-8?B?b2Exb2gxT1RLNFpsSUt2Y09PSXIyeENDekJHR2poa1orVEprN0Q2S2pXR2h3?=
 =?utf-8?B?Vkp6enA1WlFOTlVieUJkZWsvRXVsbThUN080Y3ZtcWZieEpQT3pPY0ErMnpn?=
 =?utf-8?B?ZHdSUEpNa3h6Z1ZhTlE1eFVwWWFhOUM1VGVJWEVXZDZxSFA5L2s0bHFLM0xr?=
 =?utf-8?B?Rkh5UXNoVTFrQXBYMjUvTW50L1hxL1pmNzJQeGVPSDNTdDhqWEVaWlhENFQv?=
 =?utf-8?B?Mlh0UHl4M3ZrTmVPVUpYQ2w3TFJFWTYra0g4MkE4R0lEQmEwR2FIMFh6Tjdx?=
 =?utf-8?B?NDlBbnl3bFNtV3lWeXVPdWRmaHoxOSs0cVRFdnBaYXpCeUJ5NFBYdHd0KzVi?=
 =?utf-8?B?bGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edd980a-0e1a-4990-7ee7-08dc8ed195bb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 13:29:59.2071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LUIcU5VVXLjbdKl6jOhE0AvjNrsIUntVFDaWC3bp4fDoOfqGltKlYpO6/7YhqulxhjsXBHjy0igD3VqjNoMyhOBnv69lxFjbgIc0U3QFig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927
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

Hi Jonas,

On 6/17/24 3:26 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-06-17 15:10, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> In commit 100f489f58a6 ("rockchip: rk3399: Fix loading FIT from SD-card
>> when booting from eMMC"), the spi1 bootph properties were mistakenly
>> removed meaning, so re-add them back to fix SPI-NOR flash not being
>> found in U-Boot pre-reloc as required for RK3399 Puma.
> 
> Good catch, for TPL/SPL the bootph props is propagated, something that
> is not done for pre-reloc.
> 

Can you tell us a bit more about this? I know that the pinctrl nodes 
marked for pre-reloc recursively apply the same to their parent, but 
couldn't find anything similar for other subsystems for example. What 
did I miss in my 5m search?

Cheers,
Quentin
