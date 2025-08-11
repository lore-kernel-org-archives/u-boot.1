Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08F1C87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:10:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 359B583280;
	Mon, 11 Aug 2025 17:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bY+f7VpI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D35183285; Mon, 11 Aug 2025 17:10:19 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BC683278
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywPP7cv808KeLVk4YqC4GzBQvgRplg3JovDhffTL4DMg82lC/NRjt2Eo9PEa32wMv24mVQLMXI426ixwdWKQq07AXufEKrgKr8V1w9CZDAHcu7+UzeZNFaMBRniXLoX88hJckNde59FNwTGpvMz08l7lNu3JKZBoAgHlR8FwB3smA+j3iASK8q3mfZqgOjW04KpnZfyU55rGAYT844wCGB8VhEBz+ToiS1AMadfraaSKggr7SB5do3bZp/wWd1DrX1uq6kFIUGH2Y7+NBSUoXb6rf/0UZ3gCtjPTbZcwwrm4Q9PcycVIvlYaiOUyrDs/yebbPWq1qInnBHoyHu30Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clEQ75N1Fp/S5oLvd/RNCe/MB+vHkmY3ZDu/SZbCd0Q=;
 b=RJdNsZDVkYUvSoSirw7v3eiqSg6ydhmkHycuwJxcMIm3B2QAFINLnaWMaucXe2gV4qeSnQZbKeagxgmskSDNkj3GeUHzRaOEtkAukqGrFUcDK3iLu+hZWfUm7KxtHFQq5zYtsG81MCbtrF41jcVxKiFjlkLpgu0XUVUV7YJI6ifFCkAP9YH7tJt3eKTPb2kQsrvAGafS3/RP2imO3+65hElyYzNrz0yMTN7+SNzcvd6YBXZpK5AKpe7g3FAe9YVvj3cvwx2pHhuIWz2lUFFcKVyslvM0clllBxl6+gI2ylO6lOO81XZNAwNRSEyimQg64usc5It5zD53JXIt0ZynQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clEQ75N1Fp/S5oLvd/RNCe/MB+vHkmY3ZDu/SZbCd0Q=;
 b=bY+f7VpIveWndF5oBPw/s5UtQ24JYIzs3wIgmnai+BePj3TAr8rJy9433WyRWsJzK4y5bvaXACZ33RMi+atD2qGDVirFA6bIyudQbMnm8A4FMJ9EX0OI4WYIidr4oSVog5cEDWp3MiEl2rbasV/TL3TRDUWnEPcQfyuQrtRYJGg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7356.eurprd04.prod.outlook.com (2603:10a6:102:8d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 15:10:09 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 15:10:09 +0000
Message-ID: <becbabe7-1925-4da0-82a6-ccc5420a9cff@cherry.de>
Date: Mon, 11 Aug 2025 17:10:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: axp: Remove redundant code
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250807-power_misc-v1-0-2ac672f15461@linaro.org>
 <20250807-power_misc-v1-1-2ac672f15461@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250807-power_misc-v1-1-2ac672f15461@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0044.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::6) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 1df3b393-d5b7-4464-d2df-08ddd8e9299c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3ozV1Q2U0ZOU1BpMFV1MjFJR2hsaHFBek1uOXpOd2JaU2FQRm9iSUsrNGsr?=
 =?utf-8?B?RUxNNGUva3p2MHJPRXVqamRLNVdueDhIY2JkNkhyc3NiS1pNOVlGZ3hUem1N?=
 =?utf-8?B?MFlhK2cwUTRHRFhrUDc4OFdVQUVieTR6Q0VzRmlGelp0VGkzUVJWanp3SHpM?=
 =?utf-8?B?QzRHNy9rNjcyclVYWE1zOHhZZUR5WlFxbVlCNmVzekoxZEFMUFIwWUp5eEp2?=
 =?utf-8?B?dXE3K01FMHlPeTZFT2tIamI4V1IyWTdQVGltc2loODF5U0xKWDUraE5DcGc2?=
 =?utf-8?B?RlJTRmVCZ1UyM0tJc0tnMm5Hd0tpaDR4cTVGWGZ6ZjJIZlJESmFTK01WekJn?=
 =?utf-8?B?cGlZald1bDhmcnZwN1BRbDFPeUR4NFpkQ2UzV2cxYnJuekV3clJjOUtBMkll?=
 =?utf-8?B?dTh5OUcwUW1jQWhnVzdzWkVSSDhUWUJuOHpwelVsZy9TU3RST094YUp1eEdv?=
 =?utf-8?B?VDlyTkFjdEFUeDlWWktuaGpJRTJlSU96QjBOeUdsUkl1SURKRENKNDIvSXFh?=
 =?utf-8?B?cTk5UHpla3VGeGNoMFF0dElFYTJoYkIxZis3ZG05VUx4UHRwZlQ2QmFIQ0Mr?=
 =?utf-8?B?ZGprY1gzZFg2TE4ydkI5cjNUWnhuRzkrbytkS0pzNHl1UDNrZGNlMVlxSTJU?=
 =?utf-8?B?RUc2M0hnaFVQNGtZRzhwR0ZYdmhPUGh0UzJnNmlHbmIwMDRqUlFhcGFzNU5M?=
 =?utf-8?B?TktwdjhlaDlyamwzWjVoRzRPc1JRcnJqUXREN1RlL2RJWkxOK3orOGhzdzdj?=
 =?utf-8?B?bWl5RlpabVluMzdZeDM3UDlkZHJKcmMwd21mTG1ZSGVjOFhvR2ZTbW1zdk1U?=
 =?utf-8?B?ZFpvTTFpZVIyN0wwREVIL2I1am5MaWU3MXVPVGVqN1FrUnFCK1pja0JZZ3ox?=
 =?utf-8?B?QW5Nc0JLWjY0ZXp0Rm5ZQ09zTFhlK1drTTJ2QjQwcWpiNUQ1OU5OZi9vVDJ4?=
 =?utf-8?B?bkhOOStIY3pzWmZEYkpidFhXVjRYWUQzOTlnZEVmcTJnbUxnVkVGU0RnL0FD?=
 =?utf-8?B?SDdGU1ZTeDEwTlpRcTBqdjFhWTZkaHhqc3hHdW1Jdk5SNlRQQ3kwOFJjR0hE?=
 =?utf-8?B?eWtNd3E0bjFORVBjb1oxdllHWGhhd3pDR2dmTDVlUFhVanB5ZUFCUlFtTklR?=
 =?utf-8?B?bkExU3pITElyaFo0dmpjWnRrZzJTY3Y2QUNkUUtnY0FidTlla1pFUUVoOG4w?=
 =?utf-8?B?d05SQmZUTERTSThGd3p4dUF0cGM4NkJML0g4M2FLUkNKY2VOM2hqMzFtWEtw?=
 =?utf-8?B?SnJ2aFoyWjlhR3dEMGVoM3JqSUR5RS95cWw2RW5wYWtONGNVeWNZNDFnamlp?=
 =?utf-8?B?d3J1VFF1azFicGlqVHRmNXYyYWg4WDRSTE1mOFdjNzU0Z0pqS2dMZVRobnhD?=
 =?utf-8?B?anFvOUgwWHJXV2NDMSt2dTRwbWoydkFZdmZzazhoVXQwa3J6VnZ6NkxoS2Vw?=
 =?utf-8?B?dzhmSEdMczBPMEoyMUEwZzcrWWJKelNNbEpiU2xFQjNMU3UzYUFyTzVOc0pz?=
 =?utf-8?B?eVVpeThsR1hpNTczTUhNR09WK1dYZk1FckcwclNDZEtMeFI3ajlBeXN4OG8y?=
 =?utf-8?B?NEI4eko0Wk43RHR1NW1SbGJxeE4zdFo0eE1HWk5VZ2JrUmMvamtPalpKWHdZ?=
 =?utf-8?B?WTNLd2xWMHFHQVFYK2lwb1AyWjNBVHh5TXZoVXBzNHQyUkJkRDAzNDE3TnM4?=
 =?utf-8?B?UkNJQ3VsNGNUZ2dWQm8wVXhkYzRTd2lQNlFiWHQ1Vi9LVno1WmJzNk1DWlNh?=
 =?utf-8?B?dlNNamZtK1loYS9XbnFEMFFEK2I3Z093Mm5WN0VsS2NPWkk4SUpZcndhYmlq?=
 =?utf-8?B?OGxCSmJYRFZLanpEcWF6N3VIUWZ6azFZWG5GMGVEVmhIY3lnek85WFBHa09q?=
 =?utf-8?B?SURCTHErbWw3YVVrOUNTSCtOS0M4d3VtQThRQTZSZ2RMQ2I0N3BFeEIwcEQw?=
 =?utf-8?Q?O1TV/xBgxIQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitBNXFZNTdlMFZDdi81SFFQZTl6bnBXRUF6eXcxOTlsK25oa3phSml3bVY3?=
 =?utf-8?B?ZG1NeGwxTnBOMjhDVnlJUlBBT2dLdTJOZlpPWk5HS0xjSnhWM0Y0MjVXM2Qy?=
 =?utf-8?B?ZVEzcjcySHFUTmc2TVVNV3R5VlhFaUR3dmJUZStZVFNJbCtOK0k2Szl2NFhq?=
 =?utf-8?B?YTBuYjIwaHo3clkwbTIwa3MvY0NlN1A3Umx0Sm9OVGdxRWZNKzhXcFZPSjR6?=
 =?utf-8?B?NjFQUkVmSGMzWXlTNkZ2M1NHdXNHdndobFhRN3RlK3VJREdPbDZBY0l0c2Ew?=
 =?utf-8?B?K2JKaGpaSDlQdkFCdmV4RitNd3JnQ2NKaDhvWmoxMDFhSXc0NmJOL2hsWE00?=
 =?utf-8?B?ZGdORkFZaFdTOGdyUmk4YndtQlZVTExKUDlveHVJdE96dUl1dFF4SmZYOHEx?=
 =?utf-8?B?Y1RpcHlRTEtLZ0NkMkw3WGVFNTYxUkhENHRjNVBub1NveTdjWUJQZms1U1lV?=
 =?utf-8?B?VmRRLys1ekZUSCtxc1haRmZoeVVDL2hXTVNBK1dpdVo4RU9uSGRnMTRHQ0Fm?=
 =?utf-8?B?SXZtTGM1a3gvSksrdk1KN0lCeWN6MVZ5Y0t6a3ZJbFlwMEZYTUozWDlrbDN2?=
 =?utf-8?B?OHVMak9XdEpIaUZZMDlLMlg1NHZaYTBXUFFWN092bjhGSVYveDhkbkYvNERu?=
 =?utf-8?B?VDlEeUJScEFkV05xZzZMU2RSZGlzNjIvWmw1UThGYmFjWE11SU9rY0xyaDBJ?=
 =?utf-8?B?bGFQVU5HcXpUQzY0OGgyV0crajBCME5PTXZzVzZrRms4SjhyOUtGYkpXWS9v?=
 =?utf-8?B?NEdYZUNNQXpobHNVeUxtTUxBektaTm9kRDNjS2hjWi9qRW5uQ3RhMG5kSmZi?=
 =?utf-8?B?L2dlZzNUMWtiWURnWkloeFZ6TDNLbTd5Tmo3dWt4UmNSTlgvRkFVNEFOOG1i?=
 =?utf-8?B?aSsrWElzMnRXRzVyNXJtRnlnUldTSWE3MEN1a2NKQy96QUVkaFhqekp5dUdJ?=
 =?utf-8?B?T2FaMVh1cWI2dWdZb0VaM3NGa3NqMnpJa21qRGxwVXhmVW9oRm1nWDFGenBS?=
 =?utf-8?B?dndHWWREWmlrVnFwR1d0dzhadGFEN2g0SUlPUXg3T2FISlNtR01McHBucXdM?=
 =?utf-8?B?bG1hdTdGYlQrYTMyMlFva2JwdlFOSm13UHdPemFtQUFIUGNSaEo2aHBHUjg1?=
 =?utf-8?B?QU5hMDR0dUZ3VXBscVdINzVQSDNLS1dIUzcvOXBzd05SWVpVWXdLd3hHa2g1?=
 =?utf-8?B?VmgySFFlM2M0Y3ZCSDhKVEhENGwzb0Jub0F1cTIvcVdtcE9XTWg2ZUJTSzdx?=
 =?utf-8?B?b0Q5dndtSVV1VXFGN1RMRS8wMVdQbDdyZmQ5Y1JlUlM1eWVlUHFsTnJvU3Yx?=
 =?utf-8?B?dFlMUVlHcmhUd3VxZlVFNEVYdmtleVVmc1V1MUdiRStmVGV0NUMwSmRWUmFO?=
 =?utf-8?B?WHkwbHVZZ1JCQ3FEWU82Tm13N2Q5bDhjWDZpcjdkbXE4NGsvRTY3MFpEMjdn?=
 =?utf-8?B?TFpDdmVIMVNnVlE2ZTRSeHdQTDZVQWMvWkd3Y00zTThBaGtGZjFNc1VTUURR?=
 =?utf-8?B?MUtISDNCcm00Q3VEaXl4aHlWbytLUkxBQmVkbGEwN1pSK0xybkpOd0hIVlhQ?=
 =?utf-8?B?cVF5N2orZllLR1hvZzh4MG02dnkwTGV2U3U1ZUY4VEphRW9BRktoampEbkgv?=
 =?utf-8?B?SjZlK1Z1bDR4TTZITm1ROFAyTVIvM3ZlbWQ0RjNZTDRxNS9DTFRvWVpoZWEx?=
 =?utf-8?B?TVFUZUpVdjRtYmgyangya1ZrVFlhOFlCZGVQdnozV1ZXSmZKd29uWkkrNVBW?=
 =?utf-8?B?alpOZzVQZlN3T00reVhOTEpOMXdxWXJQb0c2blIvYkZ5aS9YVGlLOFpFMjdO?=
 =?utf-8?B?SFg4U2FVaVkwSkZ4N2xJY3FXVUhyYUFOZHlWK0FWVmNyZURsSmt0ck9jbmlG?=
 =?utf-8?B?S29pNGI1SmVLdXNqZkFYaitWSmtaNk1VaTFLbmtTZUhMUFBPc3U2RHVHVEJI?=
 =?utf-8?B?ekhlTWVWb1pOemNYakdvNENVd2QyOHRhUkthTHovNk5oZTBlZk1jRDJrWnlq?=
 =?utf-8?B?M2wrZ1B4NzFYVTJjQWdFOTZWanNkbVR5Nzc1VHFqMFhnckY3bUhWdmRqTlFF?=
 =?utf-8?B?eGhVZmkyU2c4QmxHS09JZCtXamFLbkFjbytIQWJmcUI4TDBkQkRXQVhiaXVJ?=
 =?utf-8?B?QXlIbTFZZVFKOTNobUdMOFAxRGZGRWM2c1VremlJVjRYQUx3WTZLTDl0eWYx?=
 =?utf-8?B?eDBWSEsxa3N5Z0V6cWFrVHJKUXZpSUFCdHBTM1l6YVdtdEloLzUvbHphb1pm?=
 =?utf-8?B?dUJINE8zZkNrcmQ1ZmpRNGRpN1RBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df3b393-d5b7-4464-d2df-08ddd8e9299c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 15:10:09.7792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cciYAj0QK85Jz9C6Ajb7tORNl7+wW6VOy7e+hPrIQ7YWAgoAEUgM+EL8V6L5uwf6rI/LYt7yWKXcJrXNURP0eUFUF5LUY9TSWXyXWbBZVbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7356
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

Hi Andrew,

On 8/7/25 4:28 PM, Andrew Goodbody wrote:
> In axp_init after checking the chip ID there is an else clause that
> returns ret. ret is guaranteed to be 0 at this point as the code would
> have returned above if not. The next statement is a return 0 so the
> return ret is redundant, remove it.
> 
> This issue was found by Smatch.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
