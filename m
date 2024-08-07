Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E02C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 10:12:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFAA088B7F;
	Wed,  7 Aug 2024 12:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A/zCNQ9B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 558C288B87; Wed,  7 Aug 2024 12:12:26 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63C0B88B74
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 12:12:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9I9tOM06Rvbx5HTWUhnFWThkDjLOsN1IKEdU3kygkNHYPS/X9NERpo6uF2EBgn8y4aCyNEbayd1CKUH4Uqf4FeWBfrZlVb+8PEClw7FGHaLgM8fPE1wRryrF0cPz+W0keB5g2O7tRabHjHlEWYHNGU+zgFDzxJedgciIQyqFBX+prQI8tJNh02cvzscxsC1yEX68HU2UwoH07R7oJXlyWCNbkUf5SmFr8bsZUbGk8/lFLObylVg5uEWIYPJrTmgGqU37bd9vzdL7IGWYDO9ZioUUAZx8440diFaKEjLh5pHrguQ3JHLqpjsEY68242IKRkh+WMlxBUEdoXhIIxkLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3oZ1w+BUdSWBgAVYRgy9tBY04bX/n/33ZkSALFAgoQ=;
 b=g/dqH6SYwHPlbgEokIGeGU+FJ919wdS1B8k0kcvmapke2GsxRmyieRtUvFbeCXRTDvuRCvgpEqYGwWvHIoXFIKTPqvXT99OTZ9ZrKxOpK/tQ74yf3fww3Pd08cLm75wspnJtQxaL8WnJCZJqtlRAQkb46AVhLFExMaNYL9s97H4YWgprJCCvHsLb4+LrFtk0y9uUfRjADhgc94E0F40xKRJi3Y/e6DsOmmn0me4FZBhN7rQuLGsmwmdJAx509nUxLW0htfGbh9MKWtPi0xczlWwYbL21ks6UdvOnVVlzCSRgKebA958CdXNUBh86cuVEnKaUMIf9OB3rMWBVTduKqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3oZ1w+BUdSWBgAVYRgy9tBY04bX/n/33ZkSALFAgoQ=;
 b=A/zCNQ9BGHQBGHnSrfTzsVgMJ8BBU7q4W1T8rW2mcTnE8DagZcBKE0WzEDccbVR2RGk8+l8j1UgOIrnw1jUN1UZxSBQ0M/pRqtAh2Rl/S0zFzOvhTrmxIDSh1idk/axRjlA7UeqgPkkyomqNi1RKqhMh0H9PDsCzggfpfKwvvDg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by DU4PR04MB10530.eurprd04.prod.outlook.com (2603:10a6:10:55a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 10:12:22 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 10:12:22 +0000
Message-ID: <0b58cdae-8ab1-4dd0-8a8e-501f4e5c13a3@cherry.de>
Date: Wed, 7 Aug 2024 12:12:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/10] gpio: rockchip: Add request() ops
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-9-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-9-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::13) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|DU4PR04MB10530:EE_
X-MS-Office365-Filtering-Correlation-Id: d9d25f2b-a47b-4880-ef6d-08dcb6c96d71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTFRL0tObUJ4bU02WXNHMjZuSjd5blpBWURKc3VFV3BjK0tYQXpoK2o1MDJk?=
 =?utf-8?B?RXNhdFR0d0wrYjk3U0h5VlNPeW5ZcFl4SjlPZWdodHpRZCtkMmN2Mm0rY1N6?=
 =?utf-8?B?b3MrSC9IUmJqbUpmaEt3TE9DR1c1TEJ3TzZnYmlWRnBTOFR3UlREMlpjUGFC?=
 =?utf-8?B?VDhMa3NsWmdpaXZLNGlSRzArZUdaZmpkMSt5aFlUcXp2c3p3ZzBwaHp3RkVV?=
 =?utf-8?B?ZCtrVk1VdEhrVHVQQktxTHpxbGo5RlVYc0JtbmpnOVhnYTZvdmsxaXFyU255?=
 =?utf-8?B?aWtrbmxLQ3pUMndubk1mbGhUSE9qOUlkUU9IWDF3dlV5bmpuWFRQRFJ2dTR6?=
 =?utf-8?B?SEl3TVBkbTRHSXN4cWc4L1BJSWpjemZqUGRYS01FMUpDRi9ieVk2Wm43SDF6?=
 =?utf-8?B?QTV0RHhDaDB5WENORWxNVG1wZm13dElmTkY1YkZ1ZmRhM2ltU3YrYVBvckpp?=
 =?utf-8?B?bDFPR3ZJd2M0NS9oaEdsNkVLVTZvSGNVNVJObklLeGVLV0tWUENkeS92TzM5?=
 =?utf-8?B?T1J2VDZUbG9Rc3p1NWZmeUZ1Q0VTaUl3dTArMkt6M0toZ0I4VTBISXZ6amtP?=
 =?utf-8?B?RFRFY2crTHJnN3RnZGxoeWVlWEdvN3N0YmlZTmxLb2NLeERRSDhpc0VydnFn?=
 =?utf-8?B?aVNKWjVBR1BpcW1mZ0N0RmlrYjVuOTBUUFkwbC8zSmYrOFhlRWV3WFJTV1lN?=
 =?utf-8?B?MTBmaHVubm1JWGNIU2pVTVI1bkNYVEdiZFZJNkJzTU9UVmU0WlExVzl4QWVB?=
 =?utf-8?B?dzFNMStKSyt6TDl3eEc1U0lNSnZPMEZhaVptZXluNlN2b1hmdm56Z0tSUnBG?=
 =?utf-8?B?bzlmb0ZkVWRQQTJlWUlrRnk5RjF0aE1STDh0TFZhNnhkd1NCRGh6ZGQvN2pN?=
 =?utf-8?B?WmsxbTZzdi95T1FKQnlvWXF3c0J6OHpuYjZMTWtEM1RRQlJ0RTF4d1pnWEtv?=
 =?utf-8?B?VEtOMU44YmVYSXdOVkN0NTR5UjV3VkZUOVV4WVVVdnNjRWFkSTJ5VVM4VzRq?=
 =?utf-8?B?eFhxMUh5WWFCajRiSEYvUjd3d1dodTFTcFhRUkpJLzJpWUhEeUpTWDFVS1JD?=
 =?utf-8?B?OFVUdkxTVjN3RlZ2SS9nV0tPUXpBajlRY2tpclU0RlpFeWdGaWtrVDM2NCtB?=
 =?utf-8?B?bTdyV0xXcndZNTBRMVFEK1lBdVNpbDhUZlFKVkdvM3dTMkJGSlg4SFcvRkQw?=
 =?utf-8?B?c3J2WHBOdEpDcVJZRlRxQnloSEJmMk1jQXpBL1ZhVEFLZURlUlN5UmJyL29x?=
 =?utf-8?B?c0RrSXVHejgwaVRmSTA3dVlIbHBCb3V1aWQwVDV1blhreUdyN0E5YURkdnl3?=
 =?utf-8?B?WXRLdWNNc2EyN2pXSjU1NVJMcXU3WldGUzluMzc1WWd2TkFybXkwS0lKV2hk?=
 =?utf-8?B?WkhwUUdtNW9TQWFQNkZYVU5PVWYvSEhLOGZFcFcxTWJrczN0R1JmaE9pUDJp?=
 =?utf-8?B?Q3kvRUtHdG85NWtTL3ZJYkJ1RFFSVVdUcW5FMWpHa3RoMWN4cGNYZXlzK1Ir?=
 =?utf-8?B?eUduRTl1bHZyaVlVbFNBK0RGWFhzTzFkdTZtaXRYTzUrZU04dnZlcVNxQ0l0?=
 =?utf-8?B?RFF3anQ4SnZWM3RCM3RnSDlPYSt3a2NPKzBmUmVIcC94VEtLVmV5Sm5QMmdH?=
 =?utf-8?B?enNDWVpQN2RteXJsY3VtbkExVW5XejZPUmZyZW4vcHBSR2pKZTJ3Z0tIKy9M?=
 =?utf-8?B?WjhsR05QZmRwU2FwMjZEa2dBcGUvVDFiVHJmcm9RdElRNUR5dmhuOU52OG83?=
 =?utf-8?B?UHB0TUsrczFxaC94ZWYyUTkvRGlMM092TFlEbCttM3hZOVZ1NzVGZDl4R1Rw?=
 =?utf-8?B?SGVlOWdPbGk0Umg0bGU1dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0R6UExFMlhVU2xtWTlPSllxUEJnU0crNC9Ld2tqZzJsZDlwdE9RRWhMay9T?=
 =?utf-8?B?QTc2SmVoMkRhNGtnTjZQNTJKUFNDSkYvT1c0cWY4T0NHMzNvTldCbzZDRUtq?=
 =?utf-8?B?RFBNcnJYOGFNUUp5UGlwUHlBTGl1OEtDV0grUHFHNEN2Um96VzJoSFBmVU84?=
 =?utf-8?B?QVFvN1lwVEdGT1A4bFNCM1ZwU3VUa2gxZHVuMEp5MlN1ZmV1VDRMeGdJd2RH?=
 =?utf-8?B?UDlOb2pKQitNY3BaZE5Jby8wSUF0V2lHRU4rMkx2eDdBMFIyNkxxZHNDR2ZE?=
 =?utf-8?B?U0wvYjlFeVhWWXdxbDZPL1BWeEJvYVQ3L3lmNUxNNmNSMlg1eThHRGtSMzlD?=
 =?utf-8?B?cWFNY0xiTFZ6M21RRFVnVTVFOW9pRlJRTlA1eFNiZEYrbU41Q1hJOE9ZOFox?=
 =?utf-8?B?eFpsUWhEdkdGMjcvZDBjd01oeGF1bVhQUFM3K3BOK0cwV1czRk5NdkQrZ1RQ?=
 =?utf-8?B?ZHpiWnVtNGpxcDVYclhOaWV2L1RUNmw2TENSVDArUU5FaFAwcUk1OWNCdndJ?=
 =?utf-8?B?NlFFTmlwV3piZzhFK3hBcjBaUzUwVUtIeENUWVdrVFh5Nk1salJ0dlk4OExP?=
 =?utf-8?B?SCt0UkJvREZ2enF0NGZkaEIyTTRxdEsyZGRzeHlSRlpZR0d5cDlLVlRFZW5D?=
 =?utf-8?B?VXF5SEhmYlVyVG1ma0pKWEtyODVSWVZCYnBENkN5bGhBVjkwdHBVMHlWUHB1?=
 =?utf-8?B?MkZDSkhXWDVmS3FhN2JsTk8wRmZ3OUY1K0VTS3hnQTlZNDlRQi8zeWduRith?=
 =?utf-8?B?ZFpxdCtkM0VzMDlHeWhlbk90YWkvRTFOcnJwWHRmbjBMaGFyeGpWcFZQb3Zs?=
 =?utf-8?B?dnVWZ1pmdWMwMnZQYktzL2NETjhDTjI2a0sxd3NkaFpzdEhFVTZXSXVHSGU3?=
 =?utf-8?B?eFIzNHF3Y2l5bEZwZFl4akJjcFF5N01YMG9rRnhPRGsyYmxWUHZsVlJqM1Jv?=
 =?utf-8?B?bDJPMnpEQmdUOVEzZHU4amdIMkJwcThaeFovZHpZNUYxZlFHMjFJb3FuamRq?=
 =?utf-8?B?Uy9LaE1JendQelkrc0VHaGVESlpMODFlZ2dNRmo0blRMMWlpWnV2SzlkcXNI?=
 =?utf-8?B?VUJwU0pGcU1COFR0WVVkYkRhQ0tGb2RKR3ZqOVVOUUtPZHRJSzltdTVFb2x6?=
 =?utf-8?B?blVVZ0tXeXhzNjdUNmtORXhmeWNlclFsTU1wSytONmU2TE9hL2R2SHBPeGUv?=
 =?utf-8?B?bmpQL0Q4djRmK1BGdmxnQ2xUNGlDSnRoSHRnVHpnbWJnSVZUWGdBdmtLYTN2?=
 =?utf-8?B?TWp3R0lqclhOQmpDNW9YQWdwUVZrMFJjcHFiaWxMdnNVWVgvRkZSa3lSTWVP?=
 =?utf-8?B?eDlrNUNwOCtONFZ5WC9CUFpBN3c4RE1IcURNaFBPci91TWRkano2WXNHZVdL?=
 =?utf-8?B?SEpXeXk4NnVGK3g1czQwOEU2SHJHamppNUxJaVp1K1hwWUFxc3gyN2Y2TU5H?=
 =?utf-8?B?YVRoVmttR1pxSllkWWJ1Z1pUcWFObithWXdkYk00V3llbXJsU01tTGVSd0Nj?=
 =?utf-8?B?SUluSlR6bjFweHN0M3dhVm9jdElEcURXWU1VY1ZIRzc2b01uOUpjTTh3Szhr?=
 =?utf-8?B?MllKMlNWY3JSQWZyY1g1Vk51K2ljZzdQcm0vaVFldTFrdllzWjU1aWxJK2Js?=
 =?utf-8?B?VnY2Rk9LUHMrZ3NFWW94VEFTV1V4Vm5uS2dFbG1qWGJzZ3I3SGtzK2VUTHV4?=
 =?utf-8?B?Y3RwNFJ4UFRScFNJR1I0L1Zlbld6K3VEM0NiS2UrMW5wOVpTcVJ2alppTS92?=
 =?utf-8?B?akRVLzI3UjFUKzIxRG9USHNvRUU0dlBvYXlxeG9XZlZWQ0pkczFsa0VOZzlH?=
 =?utf-8?B?cG5pTnV5NjlnamJScXFpdlJ5emJjNWlmc0g3enFTNFcwQzBjTmUzTFJJUEJq?=
 =?utf-8?B?UDNsWEh1VWQzVEYzbUdMVTdHc0FYQXl0WWRKcEhwSVpuK25BYkxHUkVkajdQ?=
 =?utf-8?B?ajZhTVRxYWhjSGF3R0FiUjhNWCt1bVB0ZVZxL2E5c2phTEFDaDRlRlUwcTBO?=
 =?utf-8?B?aFBxWWNpbGZOeHhMZjB6RmhSekVIOG05RFJDanBITWZYVTFqcy9HdXdFOE01?=
 =?utf-8?B?OURXZmZPMzM3eStqelFadzI4Q3dNZnlhYlBXYnIveUhaV1NIT3BJQXgwczJY?=
 =?utf-8?B?Q2xYYk9VSkpMVHhEWENkR3RscWNsbzdPV01KWGRaNTRCUEw4WWZxNElmd0hP?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d25f2b-a47b-4880-ef6d-08dcb6c96d71
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 10:12:22.1653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPujCejg6o5SHOUeO143zpRc5p3qiRLV5x/Yk54wycY7gUl6PNS3kDO/mBoR1zY+20brYD881HF4/V3Zz8lI14cipdXZPyq3zdALpiFsAs0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10530
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

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Add a request() ops that call pinctrl_gpio_request() when the required
> gpio-ranges prop has been defined to signal pinctrl driver to use gpio
> pinmux.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2: New patch from "rockchip: Add gpio request() ops" series
> ---
>   drivers/gpio/rk_gpio.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
> index 5972f7f8612d..65811dbc78d6 100644
> --- a/drivers/gpio/rk_gpio.c
> +++ b/drivers/gpio/rk_gpio.c
> @@ -126,6 +126,15 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
>   	return (data & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
>   }
>   
> +static int rockchip_gpio_request(struct udevice *dev, unsigned offset,
> +				 const char *label)
> +{
> +	if (CONFIG_IS_ENABLED(PINCTRL) && dev_read_bool(dev, "gpio-ranges"))

I assume we check for gpio-ranges property because 
pinctrl_gpio_get_pinctrl_and_offset called by pinctrl_gpio_request will 
return an error if the property isn't there?

I see that you're adding the gpio-ranges to Rockchip SoCs that are 
missing them (as well as the aliases), wouldn't it make more sense to 
move this commit after that commit and remove the dependency on 
gpio-ranges property and let pinctrl_gpio_request fail if it isn't there?

Cheers,
Quentin
