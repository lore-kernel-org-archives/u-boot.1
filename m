Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AAEC3DA64
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 14:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ABCB88001;
	Tue,  6 Aug 2024 16:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jZ1Zk1eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9AB887F3B; Tue,  6 Aug 2024 16:22:41 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C8F188A2D
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jK47LOIeV01gn82QQ/YqK/eKi0xDcZVLQ5wKGjEMKf2IO/EeW94XPbWRy8lNKPNtOKsQbovC6hP9K98drMCuAukjT5I2PLYcuZRDDHN8GW5i3WeAAsPmqsXudWV1l/inpS/oftqQu29A6765/+r+ugF+WVdugXkDtPN4SnNUrJiBuhlWoNbWlWbvgJMDJnEtOWKHx9c80McV2txwYdhw5570p8fXtNIkyFKZQwGbehlq2Fp4DPlMyXfntAVzKlVqajFuFpCYyavHux5VYdCNeJvEi1VfY0WS59o4ZGHQnbUsMWPYqMA2ZJaBD0aaQ4OCCa3wlAdWDD0kOfZbkkpWNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxEUXudhcQboa1wpiSNpAZPwnGAFbFQ+S/WRlFwLBY8=;
 b=oH5vbMhTskE4ydxiTSBEgMKpvJCfL4LHeyx9MGqOuptw5ylpbmPw/nnVWhetgvemkx5M9STRQekawirBL5+3VqIN+byylyqt5WnW2yxW7jVZ2VR/WzPRsHOkpJYwlS3vEMUfnU1CtOhD/7qc+h+cL+C8vt3XTbsb/w6Bz9VP9Gi9oTrhk7a9Zeg75pxNoBme0PnQQivsq9NaDup9P6Bqx158lfUdS5NbfuyhvCigELFkbCbm6FQ5MUfKgjBD1jHWA/t+edTTT81/ZdAPhVK6CBaCXapB3QZYbGJvCh92boSwnA7HbGNKBR14PYe1lPRsFbDXU+VQP4ybTN2Od/dIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxEUXudhcQboa1wpiSNpAZPwnGAFbFQ+S/WRlFwLBY8=;
 b=jZ1Zk1eU84m83rjFmVlQ4Xm4W+/7ZCDvoN1r7zsN+1xQRG5Eo0wW4yCEmS5VOrs9kheSo3+SZiJ8PSrknl6P6m07kAMDsZTrCX+v53wy93rwf/0c9trcXY6eu3azH9oD9yVyDkGPPRDGAf0g1JNdmtJSKLkXdrQohkwaTldlSCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU4PR04MB10386.eurprd04.prod.outlook.com (2603:10a6:10:56d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 14:22:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7849.008; Tue, 6 Aug 2024
 14:22:32 +0000
Message-ID: <e727b180-d2e1-430d-bfdd-b7a5d2d2db2a@cherry.de>
Date: Tue, 6 Aug 2024 16:22:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/14] spl: mmc: Drop checks for
 CONFIG_SPL_LIBCOMMON_SUPPORT
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
References: <20240721152600.3212917-1-sjg@chromium.org>
 <20240721152600.3212917-9-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240721152600.3212917-9-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU4PR04MB10386:EE_
X-MS-Office365-Filtering-Correlation-Id: 749495db-d4bb-41ae-9472-08dcb623358c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVIrRVBzTVQyZzBNSCtUR2svY05VSzdDK3lFQXd1OTNhQmRPTUkxL3BjdTdC?=
 =?utf-8?B?QWhJUDJLWUZISXhjZWZhWWo2cjFGajlZckhDRDRFWlJnbUppMEFiWm15QUJS?=
 =?utf-8?B?Mk1uWU1qZEJCckdIVi9SZHJHMVBxL3NhWWJaaWdtNi9XdU5Ra3hMajA4clpJ?=
 =?utf-8?B?MVJWNjZlRnVpM1d5VWUxYnpTOTJZV2doYVZHODgvd09NTytkaFhEQVJ6Z25h?=
 =?utf-8?B?WVY1cFdCMHFZK3hsODcwbWZ3U1p6dFRZamhncThiSEJ3U2FoTTRUaWIvaVVj?=
 =?utf-8?B?dHU5Y3lsSkx1cVp3K003RmwydTNGd05HQ0tESGVOcGFlVDFkVE9uWktWZTUy?=
 =?utf-8?B?L2hDMk9qOWhCN0U3TWVRMG13WHJZLzFGS3VMTUNlSGNnY0hkZWtIc3FpOWc1?=
 =?utf-8?B?T09RSDdMT3RuY1BqVXpwdkcwWDRLRllDSmNuRkJWbEtqemdwYklOT1M3NmRt?=
 =?utf-8?B?dEk5c3dlYWc1R0d2cnRuRUtkUkZqYWVsQmVUbEoyTytiVlBIUDdEcHdXQm40?=
 =?utf-8?B?T3ZaT1VNWFpBUDM1QnVjVVo4empoOUl4YWZsV1FFN0VDekdHWCtzbTYwZzNB?=
 =?utf-8?B?V1dxUysySnFiZEp2cVFUcFdCTS9OQmV0MmdpYldmMFdseC9PZmJ0SGYwMGc2?=
 =?utf-8?B?N0NRUHRhNk91ODRaVy9CdXNVa055WjJ5MGVXNGZRbGZieGh1VnpjcjlRaVVh?=
 =?utf-8?B?aUhoSEtvSzNDWGxHcnArVTUzYklUOVo0cU1mNDdLSXhQVnlDRUpMUk1obEtQ?=
 =?utf-8?B?MHI5Qnl3Z1hTaTNBZ2xuZUppdVNBSVJoTnUwMExvN091VTUyNkQwWFZZZi9W?=
 =?utf-8?B?S1ZSNG5QLzZpa2xKaDJSQkg3UUswZ2t1cHp5VmlWRjNYejNUUHprbVQ0bDkr?=
 =?utf-8?B?T2QyUTU3NWJMWXRyWm5ZbURyeDNnMUxsS3pzQnZlUEEvai9DT3ZTNTZSd0pS?=
 =?utf-8?B?clhSZ3oxZjEza2RkRHp0TzdUeG9LNnZraS9kUm9zRFFjMjdmZFlTNnRWTTdN?=
 =?utf-8?B?QXV6aHBFUmFlODdOZFdKZUNsOUszWDFHYU11ckZOeXU5ZzlGcWRFVVdvb3pG?=
 =?utf-8?B?eFdwdy9aRG04eU8wOXhRcElaRDdnQkpyV05IajNIcmQ4V1B5UkY0MmlkL08v?=
 =?utf-8?B?TndzL09pYTZueEdtSEhFbnFZejU4U0VOYlFRZnU5SmxERUlFdWtGd1pGcWRu?=
 =?utf-8?B?M3RjU2hzVFlCcVBuUjRXMkpicE5GcFZHMW96akx2eVR4WU5RenV4L2huRnRC?=
 =?utf-8?B?anI0aHJ0R2FzVDcwUldWUVFJT2E0L25DVk82SmxQbFlOMTNmSktUQTdmcG9R?=
 =?utf-8?B?QU1pTTlOeE5ybGxVdE5Pei95N29RY1psN2RENVR5cDgrdWZvdGowdlVPT3F3?=
 =?utf-8?B?SkVQWGpBUG9VUUt5TG1PblN6alN0dWtEazNTTVdpaFNRSStsWE9HRnhnRTl6?=
 =?utf-8?B?ODNnWnRKTTdUY3JPSnhjUEtFYUYzdXZKWk9SVjlEajBuWGNCUzNIRUk3RFR5?=
 =?utf-8?B?dytxSFpDS3RqK0ZWc3dNdHRDbytMaHFuTkRTL2pqZy9PR3JDWmhOYjR3cGdr?=
 =?utf-8?B?a0xFMkN6RkNIZmRkSXBKL0UvOWFYUVZkdmhDN1RYVHJod011bmY0Ni9tckpr?=
 =?utf-8?B?NVNwbEtidlZiTFI3OTlIdFpYZ0FCVEszcmJZR2FDV3VZRzdCM0NKYVlSWlJ3?=
 =?utf-8?B?QndCNmhGeWU5WjgrZVBqa0p0Y1J4cDlLcXpWSmxrUThxR2xpUkN1YzA2RXMr?=
 =?utf-8?B?MTcvUE03OTlYNHdVZ2pJcEpCZnVqTjBJWkdxRUhrOXAyQ0M5VmdQQStwWWNP?=
 =?utf-8?B?YkVsMXVmQmFidG9yUk02QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UERuSGhOZXNheWNUQ1lUTUpWUFhIL2VNeGhXRm5ZbVkwWDRjU1pCTXlrc3Vt?=
 =?utf-8?B?bmtPUitDSkpIYTA1OHJ0K3Zpd21iT3o5dVFYc2k4eDlKZWpDd0NrSVBlSkY1?=
 =?utf-8?B?bzRwVnQyQVRBNEJJQTBVeTNrNkl0Q1VWb2xQWndBUXQyd28xczVnb0VYV3lR?=
 =?utf-8?B?VEh2NlpDVVpyVmRlcHBPV0NGc1paUDN6ZFN2bmxJRnA5TDB4RHhTZ0Z4b3hJ?=
 =?utf-8?B?d1FxK094TzNWZ0VyNGlyS21hNGRUL2swTkxJWm9PQUNFSW1RUnVlUE1pdG1L?=
 =?utf-8?B?V0NLclJtSExBQ0Fhb1dvRVk0aER6SFRrdkZSRWxXR0laNG02blhoZjhKK3Bj?=
 =?utf-8?B?c3pQc24xdURFODNob3JRN0RrUUdNNlNPSHhSbDI4eTUrVTJFUGxzR1NhWURJ?=
 =?utf-8?B?MllId2htZFBUWnhFVzl4bm5RSHRDaDVjT1JKQUtGMWVUcXNPUTkyWHFrOTlh?=
 =?utf-8?B?UWM1WXIwMjB3OTBrKy96KzNEYzNhYTJFRk5DWFkydFMxKzBVTjd4cFdOVnIy?=
 =?utf-8?B?c0R2NGFRZTJQZ1BFVmdWaVptbkZBV0xWOHJXbndkVjJFeTNuYUthMGVRYzlD?=
 =?utf-8?B?eXJ2ZUQ2b2FBelFBWlpFZG9vbzhZVnA0YXpzQXFrdGZtUFV4UW1TV3Q0WXI2?=
 =?utf-8?B?L2FEOUNobjdvSTBkYVVvRWxqcHVKS01PeldLZGwrVWNjTHVSVXJuelVZRndS?=
 =?utf-8?B?OEozZXBKZk5WcTd3OUxPMi9JK0YrZ28yM0JQT1lZQjl0d1dJVlppVjJXYVFr?=
 =?utf-8?B?eDZwMXBZSThFRzM4dXc5K3NIdzdQWkIrWWRDa1NleTVZNnlZS095eFpsUktC?=
 =?utf-8?B?SCtvb2RBcC9kZlZTeVZoVUJyVHlRNDZvM29tZWVXMnpuUGhXVHFmUFQwTnhl?=
 =?utf-8?B?L0FUOXpnamU5bmE2dGdVQ01CRmZrbVh0RXQrVHNFRjZKTnlnMWhGdnA0V1px?=
 =?utf-8?B?RkpCUnVDazVTSUtkbFM3cTBHSkptQ1YxRmJtNDUzNGJNc3QzNGZLWTJpazV6?=
 =?utf-8?B?WHBtOUVSMm5CVzdrbWxRRTlqSkRIa1dxWTdScVlscmpnQTF5OGY3b3U0cjlU?=
 =?utf-8?B?bHdBbHVGeWpOcnZUNUg1c3ZOVnhLa01DUmNsMjc2MFJuWGtjNmpvVEF4b21Z?=
 =?utf-8?B?Z2w5TGs2U01aK2h5WFhGYUdIMEVNNXBYeVBSV1IvUkNwL2VTVlk0ckR0bit1?=
 =?utf-8?B?TUh1M01tV1VxaHl2clBKSFZzOVFkSDhHQzFDVFk0Q1lFMVQwM29mK3VRbjdS?=
 =?utf-8?B?VmVsWStFTTFPQ1prR0VubnpEL2d5ZTZZQkpjRWUvTEJlT3NUUDdZYVI2cmkv?=
 =?utf-8?B?dHl0bjdGd1JKeVhrSjRIamRMM2paUFlVQW4zYmFDTENkWjlNUkV1N3NOWHQ2?=
 =?utf-8?B?SytGMXBRRmpKR1VLc1dLQzF1U3Q5Z0FzNFJkU0o1cHRPaHRMRDVQOW5QeUlF?=
 =?utf-8?B?c0dnSkJLUzY3NEgrbEhPNUFsRXliVUdveUtlTjl4NWJGKzNWU0dncElrOVhV?=
 =?utf-8?B?b2kzb0Z0YzlrbnVRWDhmeFdQR0E2NXF6SVB2SlV3Y0hEZ1hNUlNNWmdBZmN2?=
 =?utf-8?B?dHdOd05RcUVHbEc0S3pVSmF6SWZSSmU1L3NlMjc3VzZiL3ZtREJLOWFMOExk?=
 =?utf-8?B?T0RaL2NjaFRRMGFXWXJHQmZnTmZ6VkZId2hpOXZrZlFOUDNud1dlcFJIYUpa?=
 =?utf-8?B?Y3FQMFNJUVkvNXUrNXNvdGlGN3FxOEtUczlHOGxJWUQ0QUs5UmphOUVyczA2?=
 =?utf-8?B?YlU4Y1VXcm1VWDBDZS85MVZiZGh4WTFwM0FHUi9SeFR2RCsvYlJKV29PNFVL?=
 =?utf-8?B?cEJUWXRWbUU5MmkwSzZiT3hWU3ZhTThBZ1piZUE5cVkxemhLS21VMWlNYWZs?=
 =?utf-8?B?ZWlUV0pMd2srYkZaWTM5eGZHY0llS01RSmdiQU1sUklNK2tCeENBb1UySzln?=
 =?utf-8?B?dU5mcmZwcVQyQ2R0MG5XLzB0NFZVei9PbGhKM2pyL2tpb3JUMDd0ZE5CN0Y5?=
 =?utf-8?B?MjRMSEV6ekx2UmswbU5OSTlNaVZ4Zm1mUDRiR0ZnR2QrRmx4ZTd3VVZsQWtj?=
 =?utf-8?B?NWRTVmJwb1FXc3hTQjZ3TlBRQTllWmpWd2RDVVJtenFzK09Uc0JjQXdEZm5D?=
 =?utf-8?B?QnduazV6dlZWQWlkRGhIeWFXc1MrVXcraE9YQ0dBekxwU2tUUkdTdEFXcm5v?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 749495db-d4bb-41ae-9472-08dcb623358c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:22:31.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXGPO6/Y/M4bIvNrWg8zvHX45+rGK63wAB3Jb98s7ribdfejXNBwO1RHIXjK4DQqM/3wJ/blDAsVAAcd58GzFDfBgm74a47VwKQUWzwnnug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10386
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

On 7/21/24 5:25 PM, Simon Glass wrote:
> This check is not needed now, since printf() resolved to nothing if not
> available. Drop the #ifdefs
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Sean Anderson <seanga2@gmail.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
