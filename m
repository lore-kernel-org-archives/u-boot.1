Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C945D4660A
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 18:07:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0F580325;
	Thu, 15 Jan 2026 19:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="d9B8ujiS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81FF382BF2; Thu, 15 Jan 2026 19:07:21 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59FD680077
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 19:07:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNyOcT1m7Ml6ZoYU2Tw+fkLP56UzZmN+xKicuRvC2Q8zVACghlIzKVxR+CuhhLkcmZPZlmE3nKFcDfWsV4trGtU9+ecQ4MgSG3DGjuaXMBwdfRX0w0llYJOrU73Ttp85ZzSQjIm/4j5OLFrnS374WGVNCXb7n2v15RcT55bgflOAR8tLC15/TkXbIMRuvolsylvqSzfrnU8Pk7V47U6io0IUs1GaDL+U10mDCTrPvxpKCg4A7Kzr3nPc0JM/wj3s4zG+H0NF3SnWUQbgU3nUCLGv/sjGgZs8csgc8pnUZb+GiAKfGN2jCOUeAgOJCEiKEzPVcvSyHnp02CmCIRKh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TUja9loSIIk+jjA4gZCK3Lf0hGrozq8OoTzlmqeb1s=;
 b=wkevJiq1IuS/WrI5911bwu/3xup8GbAYwgDv0UanYOvnxR+qsSBTftdiOYz8+SaxVmJHWpwNcoTifSx2IzsGMkbufiPnjJv2QvuDucOAv7iFBH24y4htVDakuXDMVXpzlL+qM611+xDxVYt4peL0J3nYcWEfIehmTzgXSycgz0YdaxDZsRZ6ZasdUEUUSWCdJ0i2XL6jzsY622IuQytjHAbHcdjBjFA4u6lZGQz8EcSuWgVbPq/w+2jsNcuEpbUcQqHCbUaiP1OuoW4ywdXmYBnljM4QxpXSI9m9Fblug3JiP1Fh2WAYeonDB9HT/QTqJ8H/OxSsW/SuJvx5Zpnj8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TUja9loSIIk+jjA4gZCK3Lf0hGrozq8OoTzlmqeb1s=;
 b=d9B8ujiSw6aDS5qb044lBFS0lHaO4eDr+Q9dK4nTxLGz1Vmdpm2UM2GzM20GW0wQ4RRonrNXhTCbgwRcSSCInWgbNUaqbs/E0zectswCbq2/hLEUYt2Xi+b9rrUBUfOqqacfwEq3b2D9+3/lFox3dCdhsYiQQC98jf/xSghWzfQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB11862.eurprd04.prod.outlook.com (2603:10a6:150:2f8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 18:07:15 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 18:07:15 +0000
Message-ID: <1deb86c0-3771-4453-ba98-01da71963b69@cherry.de>
Date: Thu, 15 Jan 2026 19:07:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] power: regulator: common: fix compilation issue
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260115-power-regulator-fix-compilation-v3-0-08b329543e13@baylibre.com>
 <20260115-power-regulator-fix-compilation-v3-3-08b329543e13@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260115-power-regulator-fix-compilation-v3-3-08b329543e13@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB11862:EE_
X-MS-Office365-Filtering-Correlation-Id: 175b513d-3753-41c5-d77a-08de5460e9f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UmhhcEF2eE1MQXdLRzBQV1hlbzc2SHlvblRvTTBMdld4NEdNYUN2RlNucVpr?=
 =?utf-8?B?TjNaMmVjWHRrRmNPald5K0lId2RWMHBXMTN5UjJjRlVQaXdJa3JXcm5GZzJa?=
 =?utf-8?B?b3BzLzdscEM5dk0xQ3NVY1pqSGtMMjNoaUF1L1l5TXB0aUw1cXJvSFp2S0VS?=
 =?utf-8?B?MFFPakN1SzRwcUNpd2g2RjIvMS9UblFSTFdKRUN4MHlTN2NKbURiSFUxd0V0?=
 =?utf-8?B?NEJBOGhRNTI5NWIzYm4wQktxTTU1UVhHUDJtV1Q5LzFyeGNHcUJrV0J4TnRI?=
 =?utf-8?B?dTR4QkVaWEVib2hRb2ZGaGQxS01qdGFXZDhqVnVCdXBKUnZOSldCUm5zM01C?=
 =?utf-8?B?U1I0Q1F3NUpPUnF2LzlCVTQ3NnRhU0VnNmx2aUIyZDE2VnorVlJ4UDVKak8y?=
 =?utf-8?B?ajVCVFNzYlBsTTAwT05iOWcydmgwamFsMFNPaU12YXplOXZiV3gzVXBza0k0?=
 =?utf-8?B?c0RuK3diOWN1VUFTdjBRMklGVnl0TE1wbk5vK25Zc1JyLzRvTThOUm04V09O?=
 =?utf-8?B?Ui9NTDduV3BZNFVLMzhDMjZBdGFlSWJKVTdQblI2U3QwL0xURE1sSHYrUU0z?=
 =?utf-8?B?cFlWc2Zta2ZyWlJwbHFIM3pqM3dVZXlORlk3SlNvK1MvTG9kOEJobDFoQkg1?=
 =?utf-8?B?eFBDa0FUWFpiaGhJbm45N1JTTUxwczRnQzIyWUl2ODVCL2xoRUJiOXM4S01C?=
 =?utf-8?B?Z04ybHpHMU1ab1oyd1A4S1NvZVJVd2hOZVFwb3FXbEdoSFJKRkhLVmQ4SUEx?=
 =?utf-8?B?Mkx0WHhCcnZJMkdhVXdOd2VuZit5NHJZQjlpcncwZ05oTEcrWHQ5ZFhsZ2J2?=
 =?utf-8?B?RDlQVVp5bHM1emJ3djN1NE9jcXNBaEVUUE53aFBFcEpJNkRTcXFOSWFvdDBp?=
 =?utf-8?B?V05RaFBITVVwZ0FzeGtRMzAvUGR6b245emwvaitMWEx3dTREL2pQTER3aE5u?=
 =?utf-8?B?ZmcyMzhEK1VpRVBFQ0sxNDRXU2x5OTRNWGdVRnF6WUNaM3BHRnhKc1paKzNk?=
 =?utf-8?B?MEhLQnYvZDVKZHBqakxjdFBVUXRIWFBVdkdLNmJYZUpheVZkWjQycjRNTExC?=
 =?utf-8?B?SC8rL1VJZTJLTVRzUjMrNDNwdU5LaStDVXVEQWJsT3hOSXdUckRPS01aR3NH?=
 =?utf-8?B?K3ljZ3g5d3o0UzlyQyt2YXBEeFJUWDhCZ2QvTFpHVFFjK291cTBOdVZmeVFm?=
 =?utf-8?B?SzNOc0F1cEZqQnRwcm1vK3E4WnRXbVhoQ3o0NnhrYU5uZGJZZ3ZldHF6ajdk?=
 =?utf-8?B?N3VDbXNndUQ5WFloeWl1YTdheWViM0w5NEMxRE55eFFCVm05ZFA1S0U4Qkgr?=
 =?utf-8?B?NldudG9NYzFhQ3NOTzJZNzdiZFdxR0RsTjkzOGxWbENVek1HK2VKdWo0Y0s0?=
 =?utf-8?B?cjdNaHFNMUdBMlBlZ1oyM01zMmFEN21pTXUrRUpEMWVORkZBTHJ2Z1g4UVdS?=
 =?utf-8?B?ZzV6Lzc5cUJZUnhsS1pOZTV2c3pWakp4M1lrVGNxcm1NelQvMURMZndFaTJ4?=
 =?utf-8?B?Z0dEZ0JIYmo4TjFjV3dNMk83MHNMNWdUQnUzVUZvYWxLZ0dIeGFhRnlsdldt?=
 =?utf-8?B?UERRRzRSZ2hoUVFPZFRuVnp5S1dMcnNlTzVPZ1ZDVkhwTTNJZzZwTzlEbitC?=
 =?utf-8?B?cjRpbjVkVW04WXIrcFNkRTltOFByV3BBV3QycVhWSmZ2S01FMk9sYU1WREo4?=
 =?utf-8?B?TlFUeFRQTG1ydmIyN1F4aG9RYlpPaTVNR0pIYjlyeDJoWEVXY3FKYVhTRnNP?=
 =?utf-8?B?U29WWkVFbFQvalhsaTg3N2tWdmE4b0xiTEFSZlI2RGhkNTAyVkRqRk1TbUs2?=
 =?utf-8?B?ZklKUE1hQlpoRG9tckEzZHZwVkVSUGo1WFcybUtOWHhSSm5iZFJvckpuM3o0?=
 =?utf-8?B?Yjd0MnlKZ09TVkJqeXhkZndjOCtLaTBHY292SVRqVlhLVEdPU0lQWUhWS0RX?=
 =?utf-8?B?T0wwR3Q3aWRhZXI0UkJuQ0xLOUxEa2lGWDlBWHZUMUZXdzgrVjFTSVJ6Vzlw?=
 =?utf-8?B?RGFxVnNHMCtKeUdiVllXdDg1OGlDREFzenE0bXlCc1dQUFUzNE1TSWxFWTZZ?=
 =?utf-8?B?eEV6TzRVcU83dG1acXJJZmcyd0VoSTRDNjZGeXZuMEgvTU52azRLRkFFMzFP?=
 =?utf-8?Q?TMY8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEd3OFZrSTRNd29QYU56Q29BZXVZN2Z2L3RhQjhBa3VOOWFBUDdaSmtjQkxM?=
 =?utf-8?B?ZnkwVnZGNXhpc0k2Ym4wOGd4R0RrTjFLTnNlM1BTeWc5Rm1PeGpRTVMxaUFZ?=
 =?utf-8?B?WnRtVVBpdWxCaUl0SlZmNTI2TjRzS1hoKy83cmEwbHg1WWE2OGUzTTBjeFcy?=
 =?utf-8?B?L2RhWWN4ZGJqRWY5ZVRlTHl4Snd6ZDNhZHpVZFZJeDlrNFpwdnZsSXYrUXVV?=
 =?utf-8?B?MVJVbFpZcHlIclY1UkhpZ3ZOYkw2aDJhOXlIbWZPcGJsYloxZjNSL0hHV1VX?=
 =?utf-8?B?VXZjVVdJcU9uTFZRRmRwMjIvVDdSQklhbE1TUU5MYWlkV2d0RThVWFNWSWRT?=
 =?utf-8?B?TU1BM1l5ZTRLbzhpQVZiOHpuK3YrcENXdFg5UE15bS9ub1hGVi9iNWMyck9N?=
 =?utf-8?B?b0JsSG5BVHVOTVp5VzdRSGdkazVISXNVUFhWN3h5NzMxWTVlOExaYXZ3Wm1s?=
 =?utf-8?B?cHk2ZUF0YXB4QU4wdlVxeVFCeXJxdk5UTFNEQlBtU25GL1JISVJBVjY1NlRQ?=
 =?utf-8?B?NmgvdlhjaXVsQ2VIVmU4eFdyN3RDRGp2emNzTjd2WURLRC9UQk5ra2orOHZz?=
 =?utf-8?B?VXl6WjRuNGlMSkhJOUxhMUduWTNGWWR3OGYrRmZwdDlqUnNkSHRmQXVmalhV?=
 =?utf-8?B?OURTWlJWM0ZlU1AvN0JlQjlKQVRJakRzdjNrSkR4TVJ4cm9QWG5oYk5LcXM1?=
 =?utf-8?B?eTJ4MEd5cHdMV0s5ZGw4MGh1ZDhmMDlOKytqMVRFTVF1MmtkR0pWeXVnMzJH?=
 =?utf-8?B?aFA5RC95Z0ZzOStXZStycUNXRFpzdTZ4WW9ucER3NHhBMlBETU5rb2NSdG5C?=
 =?utf-8?B?UW5iMFkxK250UStxZS9UNjRhLzVoSXFKeGVjY1NrOGI5Z3lWVzVvY3c3RXYy?=
 =?utf-8?B?RWxMN3lsdEFkYmx3ZDYwaklzYUdIT2hVbCtzc3BrMlZCTEtkR0x3WXBINjhq?=
 =?utf-8?B?aGQ1cGV6dXYxWGEwV2EvL0Y5R1JGdHM5SkNCeDBHc3Mrbzl4UmZvRGY1Tyt1?=
 =?utf-8?B?VlAvUnh1SlN1NHZkVzJ2OWZHcW5FTU1yTytuenZOWldpUDV0V2VyS0NhTXdk?=
 =?utf-8?B?eW9GN1h1U2liT1BmenV4MG1IQ0FkdXZoaHZmSHhkdkEzZ0M0eEhscHU4Vm9W?=
 =?utf-8?B?NjZ1MERWY2Vza2FraUpwdlk1Y2MyVUJPcHhkSFhDVlFkYjIrR2FERjZFR0dx?=
 =?utf-8?B?R0FEanNnOU1md3dFcWtJajFzUlpMRFhHN2poODlNbXNIZTBJQ2U5SXdnNUxC?=
 =?utf-8?B?Wi9mUFRFQTdNOC95dWhlc3lJUkloN21iaDZIUjAvcWloMGprOFVaa1RvMWt4?=
 =?utf-8?B?ZnlNRzlodnU4ekRxQ0lvOUQrRkllaGtRLzFaZkxydEY0OCtmVFVYTm4xRndQ?=
 =?utf-8?B?TXJ4ZmM1TDdYSWU4Nmd2bDJYc0pZWkRwKzUraHZPclk0R2FPUm9oM3lBQU1R?=
 =?utf-8?B?Sm5OSDNkdlpjRDdTYks5Q1BsakZIMWlUcThWTzlYd3FNYXFSRTdNVVNXTXBM?=
 =?utf-8?B?dnZiOGpOM2dpelBhck9pZ2xvbzd3cEtZcHZiQ0o5VzJOUFMxNHRmMEZsODEr?=
 =?utf-8?B?OEtsTmgzdlJjU1FobHVlTXFWN2dwbVFmMHBGWmZER2lJNUxyYWdLeGFONnlm?=
 =?utf-8?B?eTkzNE5yZ2F1RFFmUE5OY1dRRmNMQ2Q4MUpObTg2V2VtcXNWa3phVnByRzVZ?=
 =?utf-8?B?Y2JoTzdoWE9YRzJmbHpPUUtGSzJxUEg3cXJKVk9VNmU1azVnL3FVbWJoQnJQ?=
 =?utf-8?B?QUJGREtML21WRkdKQnJ2citWMGlKT3VVc2ZqcU0xTFVocGZJMGdTTU5lSitG?=
 =?utf-8?B?SWJOdXdKYVZoVnNCaFR2eUtXZ1QyYmk3Q21pR2lKcXkrOTV0RHhteFlFcHpU?=
 =?utf-8?B?L3JwdGZNY1hPWWdDSEcxdWdDZU1HbGh4MUlqdDdXeDdJTEhBTHRKc2ZFNGdv?=
 =?utf-8?B?aExxYW83NW9id09JSFREQlZxU0RVY2J6YmhUcXdSeTZMaG1pOFVmREdlY0k5?=
 =?utf-8?B?NnFqOWVVa3o2UWsydDNPSkRIdFhGZURsWk03TlJ1M1BVZGlmMHFMMHZ6eUtw?=
 =?utf-8?B?cmZZRTZYd29UeTNVVWExTXFBTnRzdFVpeitQdE04VDcwSnU3bEVYclB6eHRE?=
 =?utf-8?B?MUxMZnE4UkZOTURNYkpkenZzYi91S0dJeUVtWGxMVjlvZ01uRGZaZ1lQQ29s?=
 =?utf-8?B?VjhTb0xkc1BOaVFHcXc0cG1xMkxUTTNady9GL2VzZFRXRXE3R25YdmZiREp0?=
 =?utf-8?B?clNFbVZCRU5HcEpNcGVBMVQ3WVZ5NVB1REMrSVNjQkdCUi84OXpndTRXQ0xL?=
 =?utf-8?B?K0lCWjN5OVg4Yk1JZk1ndjVkWXRnekxSUld0YWdkd3B6QXlwR1JvQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 175b513d-3753-41c5-d77a-08de5460e9f5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 18:07:15.2776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RHEnBEvQ0aOzltHalttAJVRfupHpFpkWAQXIb8uqlS29mf8eZ64nWvzMqeBu0qIQ+iQBsblLllTMxD4tFLqNVAzi6lKxS02WVyFrDOldCv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11862
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

Hi Julien,

On 1/15/26 3:30 PM, Julien Stephan wrote:
[...]
> @@ -65,47 +67,47 @@ int regulator_common_set_enable(const struct udevice *dev,
>   	debug("%s: dev='%s', enable=%d, delay=%d, has_gpio=%d\n", __func__,
>   	      dev->name, enable, plat->startup_delay_us,
>   	      dm_gpio_is_valid(&plat->gpio));
> +
>   	/* Enable GPIO is optional */
> -	if (!dm_gpio_is_valid(&plat->gpio)) {
> -		if (!enable)
> -			return -ENOSYS;
> -		return 0;
> -	}
> +	if (CONFIG_IS_ENABLED(DM_GPIO) && dm_gpio_is_valid(&plat->gpio)) {
> +		/* If previously enabled, increase count */
> +		if (enable && plat->enable_count > 0) {
> +			plat->enable_count++;
> +			return -EALREADY;
> +		}
>   
> -	/* If previously enabled, increase count */
> -	if (enable && plat->enable_count > 0) {
> -		plat->enable_count++;
> -		return -EALREADY;
> -	}
> +		if (!enable) {
> +			if (plat->enable_count > 1) {
> +				/* If enabled multiple times, decrease count */
> +				plat->enable_count--;
> +				return -EBUSY;
> +			} else if (!plat->enable_count) {
> +				/* If already disabled, do nothing */
> +				return -EALREADY;
> +			}
> +		}
>   
> -	if (!enable) {
> -		if (plat->enable_count > 1) {
> -			/* If enabled multiple times, decrease count */
> -			plat->enable_count--;
> -			return -EBUSY;
> -		} else if (!plat->enable_count) {
> -			/* If already disabled, do nothing */
> -			return -EALREADY;
> +		ret = dm_gpio_set_value(&plat->gpio, enable);
> +		if (ret) {
> +			pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
> +			       enable);
> +			return ret;
>   		}
> -	}
>   
> -	ret = dm_gpio_set_value(&plat->gpio, enable);
> -	if (ret) {
> -		pr_err("Can't set regulator : %s gpio to: %d\n", dev->name,
> -		      enable);
> -		return ret;
> -	}
> +		if (enable && plat->startup_delay_us)
> +			udelay(plat->startup_delay_us);
>   
> -	if (enable && plat->startup_delay_us)
> -		udelay(plat->startup_delay_us);
> +		if (!enable && plat->off_on_delay_us)
> +			udelay(plat->off_on_delay_us);
>   
> -	if (!enable && plat->off_on_delay_us)
> -		udelay(plat->off_on_delay_us);
> +		if (enable)
> +			plat->enable_count++;
> +		else
> +			plat->enable_count--;
>   
> -	if (enable)
> -		plat->enable_count++;
> -	else
> -		plat->enable_count--;
> +	} else {
> +		ret = enable ? 0 : -ENOSYS;
> +	}
>   
> -	return 0;
> +	return ret;

Phew, big diff. Wondering if:

@@ -66,7 +68,7 @@ int regulator_common_set_enable(const struct udevice *dev,
  	      dev->name, enable, plat->startup_delay_us,
  	      dm_gpio_is_valid(&plat->gpio));
  	/* Enable GPIO is optional */
-	if (!dm_gpio_is_valid(&plat->gpio)) {
+	if (!CONFIG_IS_ENABLED(DM_GPIO) || !dm_gpio_is_valid(&plat->gpio)) {
  		if (!enable)
  			return -ENOSYS;
  		return 0;


is enough? The compiler is hopefully smart enough to figure out that an 
always-true if-block which ends with a return means everything after 
this if-block doesn't need to be compiled in.

The current diff looks ok to me, though unnecessarily big I think. In 
any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
