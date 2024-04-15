Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB28C04FF9
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 09:10:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA50881D0;
	Mon, 15 Apr 2024 11:10:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Tpg8l4R7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFE97881EF; Mon, 15 Apr 2024 11:10:39 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D706D881D0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 11:10:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhgJtkjvuGRq6RNgTTZKLXrEV8UCe/VEFkFoIueJTerK2y1c8DBAH59+DMCiIvTagoI0tAT4vnH425AMz5+prvLNk1IIY44lvZBgrAnyOLjRun8NevsLLFnM9kIIPAwKfQrT6PgpVWk8FnPziSXFnTSkoIgxnr43os60w+u1TxfaoSrucTgybw2cDo+UhYdliF+0ruVIbWoT/rOkz9+9KAg1KyPrP0a1SAkLRX4o7Ion6XeNirWLl1B89GMC3PjbGv2Z1xIFrw89u71umARuscrISUHKaVgxHF5u/CdydFq6AjdaDrHBxyvArnehSxBWIa0K5kT6brGzcd5Wc/wIkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+i387yRcwwSOKP7EEA6IhIWnOXcuOU89JNl4RzC3us=;
 b=To5rbe4xEEKk6P/pXoA07a4yoHbx2uZYL8AL0N0fclc1s+NmJRzSg5x9LfGSY7wr0m0MwLFrzp+nCvFqpI0O3M2K+O1XPhPwADrNXETxyClmVMz0/y/YbNzWmZix0cewNW3Lmol8+xM/TDgrZFi6VasTr+Cz5rmf19iIacxzams4SHgqCkF9rlii5yo14rfqtOD9AGCtvjVEL733ALyrvishyl8N9VfBDBg8brNn/nha6Tdz9+vcrJtrb8/cQsMXEuW5xOXLMtwT0UYXZ/9URY/igK1RHX3KjJfGkmRapG+QevYRPJTAB65x1RMRknJz4Bd1DWXyI1i87+uD7gOPrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+i387yRcwwSOKP7EEA6IhIWnOXcuOU89JNl4RzC3us=;
 b=Tpg8l4R7HPDicM5+YzR6GdCWheXJbjUdU76Jpd6Osx9ALPsJP6vilQI/eMikEG51rjXQ3lQakAKHuR6MO0XYMCaJg8d9+pQRfrWPk6UoBN01d5hsNGCXvb6FAwaJOIrs9dJBNY4IllvnwEdxVmNaKA2EYrpGDFarM5mGIiH6e9tQ2lzTohxXSr9Zd2h3S0c7rG3AnwfpoV6RjG3eeLxiTFkyIY9f+coXmTcj6Plb50RxEsmgfzbRTolHmrkPHRg2R/GX6kJNhd15N7gUJuDOks8G1LHQs9lN/e2K7o4GkTomgOhYOXMR6fafYkShTezIuGto7KPtU7ZWCbWnCBX3Eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com (2603:10a6:10:1b::13)
 by PR3PR04MB7402.eurprd04.prod.outlook.com (2603:10a6:102:89::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 09:10:35 +0000
Received: from DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504]) by DB7PR04MB4842.eurprd04.prod.outlook.com
 ([fe80::bdc7:4b2c:e74e:1504%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 09:10:35 +0000
Message-ID: <cda686e0-a5e7-4e42-b696-d66563eb8866@theobroma-systems.com>
Date: Mon, 15 Apr 2024 11:10:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/23] rockchip: rk3588-toybrick: Add missing Kconfig
 options
To: Dragan Simic <dsimic@manjaro.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Elon Zhang <zhangzj@rock-chips.com>, Weizhao Ouyang
 <weizhao.ouyang@arm.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 u-boot@lists.denx.de
References: <20240413181425.1384357-1-jonas@kwiboo.se>
 <20240413181425.1384357-16-jonas@kwiboo.se>
 <ab33123f-05a5-4edd-b720-a5b8792d5443@theobroma-systems.com>
 <6a057b12fe264f752f641f3eccd7ff23@manjaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <6a057b12fe264f752f641f3eccd7ff23@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0020.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::24) To DB7PR04MB4842.eurprd04.prod.outlook.com
 (2603:10a6:10:1b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4842:EE_|PR3PR04MB7402:EE_
X-MS-Office365-Filtering-Correlation-Id: 98385b49-5adc-4cbb-583d-08dc5d2be8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZFdha05XVmVoSUhCRGNyTGp6cDUvQ0lYbHVuVlhjL1BaaWVPOEsvN1lqdFU2?=
 =?utf-8?B?bTQwYjBtZUVIZFZ5dHc0NjNCclNjMXVmMjV2NjRQUEtucWhzWjUwRzRha2Yy?=
 =?utf-8?B?aWVjUTBEbDZJWEp1ZWtBNk5DL215RlgzVitRUmlnc1ZJNThKOXBxa3N4K0Vp?=
 =?utf-8?B?RVJiV3B6YnEweUw4SERsWlBhM2g3dS9rUmo2Y1NoT05zWG45Vncyd2ZkdU9y?=
 =?utf-8?B?T1R2bVplTzM5MHA4dmpCeFFhUmVEdWQ3WUg5RTBlMzZOMmpDZVBGZVordTRN?=
 =?utf-8?B?UHM4SDVIWHNVMUdlS3dKN3E3UXU0RWYzWCtnUklPMFNsUHQ4UGlpMTEzS1No?=
 =?utf-8?B?VkNoMVdpWXVweUJnMnVZaElvWFFJY01CTnNvSnJSd2I0WDUwMnR2Ukk2YkEw?=
 =?utf-8?B?NjhJd1ZaWDZVY21Ka0hZZmN2czIzRTdNdlJnYUkwbE5GSHRodndFYmdxSnBn?=
 =?utf-8?B?V05ZaEoxS0JWMlYrSmFmeWN1dDlXS3dsdkl2WTdORFNqOWhxSjVtVmxrRVkr?=
 =?utf-8?B?M1Y4Y0NYREM3SlRWV0tGbHFKYzJEalBDUEJHb25rU0JudmMzNTZmSHZkajdO?=
 =?utf-8?B?c0JXSnY4dkF0ditCdzVnNGUyem45R3hzZUFyYzJPZm5HYURoaVFoVTNCYjJW?=
 =?utf-8?B?TlhkUDRnUi9qb3RxSjFQMU81UDB3Mm5DRGh6VG9xaTBSQnhjNEtpMHA5bGkx?=
 =?utf-8?B?OUhoWkFaK2ZYcWJ1ditHdmkzbkM2QlluQTBsdGRuMkszME9oUmJtYWJabUpO?=
 =?utf-8?B?WFNTU1ZCSndDaUZZaldWc0FFWmh4Q0l4UTE4NEJBVWwrTG4wZG5lME1ZT09n?=
 =?utf-8?B?UENNSWtTZmwrcTI5bFR3VDM1VllvMm45K29ZNVpIS3pOSW0wWVp2TWlpVzVG?=
 =?utf-8?B?RlVEMCttWitzeFRqZ2FiWkwvSExZTnk5ZW1UNFlqdCtFT1JZcDIvdXIvL0Zy?=
 =?utf-8?B?UEU4VGZQOStJY202YUFvbVZKQ2xIVDJYeW5pc3lDSTBoUlJhSnFGeFNmUFBV?=
 =?utf-8?B?L01uS243MzJwc1B5SHFrUXFNRFN3TFE5SjJIZ2NUNi9YajVjWFZxZlFYN3dq?=
 =?utf-8?B?WWFlT2pJWkl0bW8vQjQweEJ4d3FKTW1GcnNKaTNzUDBhZ3VRanEvaldKbnp3?=
 =?utf-8?B?RHpPVU9wL0hkTllkZm1YUitvOHdlSGdSWWRKd1FUZXZUTnI4L3RLc1BrOUVF?=
 =?utf-8?B?N1diOElXNFE0QUNtNEtCeVkzaTVBRzdMOHEvZjZSelJ6UEpCWEE0RHYrKzBm?=
 =?utf-8?B?V3lFcTBva1UrZ21wUDQ3S2wvcys5Zkx2VE8wZXN3SzRySlc0NlN1VGtzZlVo?=
 =?utf-8?B?MWdoL2hqMnpiaE5DVkdpQm9NT3k3NEZHNTU2T1dlaXpvbytXUTFTUFptbVZ6?=
 =?utf-8?B?OTJKUUZ5Mi9pYmc4V3NEWElhOXI3UGNFK0lFeisxYXRwTk85TG5yS0RBU0tN?=
 =?utf-8?B?RjAvRWNmYVp5YjZsckVEbEQ1REpMQlExVndTNjJCajEyVEsxSzc2TFBwY29z?=
 =?utf-8?B?SktqUHk5djc5WjNFbjhNVTF1eXEzUmp2cmlDc1g2WGhvUFd6M09RSmMzT0Nl?=
 =?utf-8?B?QzFxTFJZSDBDR1Z3UkUxcTVFdHhKNEM5UHppckwzMjZTVm9KdU4ra3Q3U1VP?=
 =?utf-8?B?OFR4NjlxRFp0UXczb29JUDdXd1hFVXFUSE90RHlONm1oTWJtQVpOaGJDVG5V?=
 =?utf-8?B?OHJkVmhFNGV2SURZVlRLZ043YVpEd0pnUWFvUkY1czJnR1ljRnh4RklnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR04MB4842.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzc4cnd1ZWZydlZYamN6RWJwc3Fwa2t1ZS9xaXJHODJxQWFvVWFLcWQ4WUo2?=
 =?utf-8?B?MGtDVnlUKzVDMmRka2pYMFJzdkx6UmJuSnZXby9BZVpQRFdsc2xlR0pIekFz?=
 =?utf-8?B?d2hqZTE4VUMxNkdiQTNha3lFalVWZnBwd1I0cGY0UHlQcEd4eURZSkZGc2ph?=
 =?utf-8?B?cncyVVRHTDNsYnF3UUVkcEt0dDY2TFByYUMrL0kzTU14c29aZmpnMWkxZWtB?=
 =?utf-8?B?T0xSV0dNNnA1cVR5ZWZXLzgxNFNndkxZMSszV2d3V2NRL085UjdEa2Z5ZTh6?=
 =?utf-8?B?WmRrNFh2eTdOa0ZtSS9vd1huV1VRSDVzYngyamxVZ3pubzk3M3ZjQUkzaEY0?=
 =?utf-8?B?K2tNTVU2YWRBLys1RzdHWXArdm9RZ3F3cVRZaTdJYnNha0RwanRuQmVpQ0RN?=
 =?utf-8?B?RWh6VUdDV2ZiZzBzSFkvbkFzRHdZQUNrOHV0bndVejBFWStORUQ4ZmtMTTR4?=
 =?utf-8?B?L1RvOUtPaGdsOVQzTjREcEVLOGk2QU9HZXpqY1JSekRTR2Q2MlN1OERLdmZk?=
 =?utf-8?B?TlhPVmE1WTdlTlphb3pMdFFSL1ZPM2FKOTJvL2o2UGw2SkMwZmh0b0I3UUJ5?=
 =?utf-8?B?U0loSFBQZXRZd01zNit3d3MvWWFHUnpiWHFhZ1BZalF1YWVmbW1VSi90RVBa?=
 =?utf-8?B?ZDNpamNsWVV2WXNDVndqUnZEdmtsczQwQ1FvY3ZNY2h6MHllbEpyai94dThh?=
 =?utf-8?B?dzhWa0FEcVZDSStJb1F6L1Jyd05NZk1JT3lWaVN3VU1oQW5TWlBnaTQ5M2hh?=
 =?utf-8?B?NVNiMnovNUV0NzhNK0FvZWtybWdiT01OTVh4YzZ2em5FaFNMWFhyalBtNkRs?=
 =?utf-8?B?MUdpNVgwdXNzUWdjc0krN0xNTlNWNXFxT3ZRdGloZE9RK1dpVW5PQ0FDU2NF?=
 =?utf-8?B?L0RwR0VJOVZub0dKZ3lOcmpaeU13TVRVejFXQUNtVVV1aUh3Y0pOS2k4WWlw?=
 =?utf-8?B?NGNpcmZTaC8vR0lmK1hva3VVanJCQ2VzWUxRTTUyenFJWFZoU3JFYXlOZzNt?=
 =?utf-8?B?bEJqb0FjVEVYUC95NllGZTNPTE5jSzBxODZLSmJnSW1YMUxVcmJIQUZIY2dv?=
 =?utf-8?B?dEswblo3eGcrSXVQeUV6TTVUcmFwQjJsbGM5c1JjY2Q3YVN1Z2t4RmtJSUJP?=
 =?utf-8?B?NHVPZTRXeTBGaDk1bFYyblljMzAzTHJpMVM2RWZKN2lqcGV4TzBSbXFxVUw3?=
 =?utf-8?B?L29KY0twT0ZGUjNXdXJOdzN1U0ZyczMwcERMdU5TMHM1VGZDSjNpZ1VlV3B3?=
 =?utf-8?B?SHFjc3FMbHhWa3ZpM1lWRDJzZkRyQmhYQ1N4Q0F6aHBSa09UMXJ3R3l3bFIx?=
 =?utf-8?B?QnNHdlI3SEV6OW00WktsdHhOcG5oUFYvb3QwWG5Dc00yaERkdHNicUpMTVgr?=
 =?utf-8?B?bG1jNFgxay9pZm9BUWttdGZjUHN3d3BCTjZFaEVDeXZvN014NmNNMTBGT0NG?=
 =?utf-8?B?eW15a2lrMFgxZXNFUUgrVE83M1gzT0pZZFcxaHE5VEhDSDVLMkFRUUZ1ZEhO?=
 =?utf-8?B?NkZsajBPQ2M1RDJhdHlvbGZpeTQ5a3lrNi94MmF6emhINGJIdUg2YWU5Z0hF?=
 =?utf-8?B?OUo5aTZHTDRBTStJa28zcTIvSFphWlU5aHQ0dlpXYVovNjZNWjJOSHBUZVlC?=
 =?utf-8?B?TGlTcWFtaDgwSWNQQjIzTkFSSFdZd0ZMVVM4MlQ5MzB2TkFRd2JOTThhWnBI?=
 =?utf-8?B?WWQzRUZtOGVwQWF4NWVFbXJNVmV0eGFzZ3VheGd4L3o2dXhYVUxueTdCUjk4?=
 =?utf-8?B?RzV1b29QVnRXN1UwbzRZcDVUUlBkVzF6NldGbDh0MGVLcy9KOEttUkxCdlMz?=
 =?utf-8?B?L1g4c0VvY0NBU0c0N3Yrc0plQWw3V1l5VkROVnVWWnJwUXpRZWwxNjJzM0Vo?=
 =?utf-8?B?WW9QQ2hNdWZ1d0c1T0JacVdyQ29vbDRuTlFaemZ1V1RJcDFubFdFMnB3a1dh?=
 =?utf-8?B?bFBiQjA3VGtOVElzYW50Y2dINTNETmZFbWxocU1UTlh3M1UyZjhIZVlpNjJ3?=
 =?utf-8?B?K0dKMGpmd082NFprOGk2SkxmYnZYRUJoMng3ZENwbXRRSytjK21rUlVOS1Bq?=
 =?utf-8?B?SXE1VVgxSVlGNHVnQU0vWWk3WVF3SjhOcXVnWWowek1yeEpkdEg2bWVjMmhy?=
 =?utf-8?B?YmhObUlGcDJ4MS9wVysyYnQzcVoyMlJXdmhDNG9kUVZ0cVdoMlM1L052KzZC?=
 =?utf-8?Q?mM618fZ5Ex4zrDccPJGFXpY=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98385b49-5adc-4cbb-583d-08dc5d2be8fa
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4842.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 09:10:35.5499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ipW+DlrMqWYD2B2woXd+lT39853gx4RXF0pLBMQHwpkYtJCmcKi6N31FAiL9TbOL3aehA5syUrskXLuegLSY20BjOiUTyYIn4ugnVtdyGayqyfFBIsqK1HVe1xkg12Hl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7402
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

Hi Dragan,

On 4/15/24 11:04, Dragan Simic wrote:
> On 2024-04-15 10:58, Quentin Schulz wrote:
>> On 4/13/24 20:13, Jonas Karlman wrote:
>>> Add .dtb-file entry to Makefile and enable Kconfig options required to
>>> configure pinctrl in SPL. Also add missing PHY_ROCKCHIP_NANENG_COMBOPHY.
>>
>> Separate commits please.
> 
> Perhaps the Makefile changes from a couple of different patches
> could be put together into another, separate patch.  Those are all
> related changes, and it would result in one less patch in the v3
> of this series.
> 

That would be fine with me.

But always better have too many patches than too few, it's easier to 
later squash than separate them :)

Cheers,
Quentin
