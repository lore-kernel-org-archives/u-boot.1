Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 873B9D44C40
	for <u-boot@archiver.kernel.org>; Thu, 15 Jan 2026 12:57:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5C780325;
	Thu, 15 Jan 2026 13:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="lYKWn4mP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FE6B82BF2; Thu, 15 Jan 2026 13:57:36 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 866CA8003E
 for <u-boot@lists.denx.de>; Thu, 15 Jan 2026 13:57:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unnjSfuajdiewyrft5882HomXTUU62GwUo0exatMKZ0xuVJLfZuOkq9g3EysH5kXCp1jEpxCGurJ0B/RzduzX16uxpcN8Yyk9j+hl7EIze7Vq66KAGuEtyhU/5BgTNXZjJPczlJT0s02b7GmfvjIz+Nnh/3g+BrvOzJrzMg3TRTlNdYZmjpH2B6/+rB+k8e2sqj2qZLihchrDBLqQffx77T2OYIO6FjBIh9HpMUC+E+/pTsWAQ2Zfn65ItIapxC8hHPa1eWPzNNnswMdYeb8c9MSc8ASS8MMp9eprY+QX2M8OHt0idf4oPdrRjReYQ2BLqWZtjTJMtO1NxOBBCjo2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7aHw8W7dsYec2BgiOq0PJvi6zXjKPdSDYpF8r3HllY=;
 b=GjgI6Z1w0szD7hkkZOj6E5ziCdLveo2qXKXG2RZqbGM1nHuZpmlUjXrLtK8nZeScr9UAKfI1tyiJefpzl2oB3rH9pr+Y6+i92F4obkYgFPvjI8DYP7WX/SHyAQfKGNQB3YESuGz+VKXgHndM/1HK9miM5APTa4i+uN4845hMRFi+c3JwgVmkPHwZzwltkrEEgan+ct/tjKa62JmNbEwigFCEoHf8qMDQ4fS56ei2DgUX7F0qQr5LQ74VP6Q1K7t5a0zD3Vk8ijqWePRw4Up4FAIyBKQBXHf+pMAw+hPUUSY7WQGajo9qtdKuYr0pn8zBMir9JrX5/pWbWYYDttxEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7aHw8W7dsYec2BgiOq0PJvi6zXjKPdSDYpF8r3HllY=;
 b=lYKWn4mPKAlXzAKiAFFTXRWBlpmR+Xvx2mibhZF4A5e05sCUIMeruzpq0jjWBF1Xg8lYGctQC09Wb71V6nsXJwfa6tvDn2XI2ZEA8BrnruuD7RhAYdmX+l+4rN0Bp3yrtAtIrUeMIoVVmL6zhmT879w4PyvIi5A3IX5i5gBVs0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:57:31 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:57:31 +0000
Message-ID: <a850f6cf-bd2e-442e-9898-7b1bb059a27e@cherry.de>
Date: Thu, 15 Jan 2026 13:57:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] power: regulator: common: fix compilation issue
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Ye Li <ye.li@nxp.com>,
 Dragan Simic <dsimic@manjaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
References: <20260108-power-regulator-fix-compilation-v2-0-b00cb3268059@baylibre.com>
 <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260108-power-regulator-fix-compilation-v2-3-b00cb3268059@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: f1564f6d-5ec6-4295-775d-08de5435a524
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWIvaXBuOEVud3ZaV2htb3RlTVh5eUc5a0NrSmZjN090UlJGWFRwOExzK1VF?=
 =?utf-8?B?MFlndjVXWHlheWovRzA0RktXcnlXQVY3aklZZFphMDcvVjhYVFBtVEt4NEZj?=
 =?utf-8?B?b2NOMnhUSjRoY09OaTJkOU5WSTRsalBxSFhJM3U5enVJZzQ5UmNSbWt6Q3VN?=
 =?utf-8?B?MjJZQnhFVTRjM2dMdGNkUU1OR3hPcFN0WWxPUDB3cHVycGdpT1MyTjFzOW4w?=
 =?utf-8?B?Uy9EQWQ3ZE96Yko1TmlHa1lyb3ZWRFhDd2o5K05UWTB6L0ZWZjBXZlgvWkxw?=
 =?utf-8?B?UGU0RkR6cjEzb1g5cTBSbDAwSmRQYWdGQnpUNlYrM0ZCZy91ajZTYUltNkwz?=
 =?utf-8?B?V0lnQ3M1OXcycWY0TTBQaGZZNzVUSkJZdmJUSmdleFVQWkwzcktURUJmOGFD?=
 =?utf-8?B?cSthUlBvNEZudjRBNEpHMlR0cTB2R3lKNFBQZzIwdVdoSW8xR0xFOWhUR1Q4?=
 =?utf-8?B?RmpXS0tZNDV4L2VGQUdQQ29uMDlBRnlIL0VKdHdLNmszZVVJZFA1UE1hYWZ6?=
 =?utf-8?B?S3U2S3lRZFJ3bzFJNWp5eEFXYjA0RFU3cVlheUpVMENxMFcwNmxTRjhTM0xh?=
 =?utf-8?B?QVphTXllQ2crV3VzamIvY2FVaXZyQUwrMTJBRnM4VWZSQUwrY29VZGsrR2hO?=
 =?utf-8?B?UW9oNnRNL3V5ZHQ1VzJnc09VN2haOW9hZGNFUG5tYmJhV3NyTjUyRFRaa3hw?=
 =?utf-8?B?ZlBET29kVmZMSXNQSHVvT1o1U1dXM1QxQml1NzZXanZGOXdYZXdQSTlpN0JY?=
 =?utf-8?B?ODNpK1V2a2crYUM2Szd4M01KeGlUaElJZWs4SzJjRm1rMzhYT2t1dkVBNjFM?=
 =?utf-8?B?algxL2RMUnBmdGdVeGYxMnZNNVRsdVFqZ3VFdytHS3dOMjBHYis5UG1PN2FO?=
 =?utf-8?B?NkQ5dmNNcXJDRmVCK29ONi8zL1YxQld3Q2xvU095UVFmM2Y2ZnpockVBVEtp?=
 =?utf-8?B?bE1uVWpWQjRZSDROU0RsVldBTWdtc0dlUW5zaXdSazMzWGpLVlFUSGhKMFc3?=
 =?utf-8?B?clphN2JpODJ1ZGxRRk9PSHFwdnBjZG5zcWVHejBnbnBzcGN4alAwRjRtWStN?=
 =?utf-8?B?V1cwcjBrdmw2aGRGdStzZ05sWDJMdkpTMFdOVjJpdmVoeUd1VCtLYnZpbk1H?=
 =?utf-8?B?clBQbVB6WHFJMTdSWVA2b3BHQ29TOStjcmg5c0dzU08xZ2ZRdS9CZnAzZzBS?=
 =?utf-8?B?cWN1d050ZG93QmJZUklFYnRRYjU0VnBwUVZLNXRMRGg4MlB0TmtnMVpBWEg3?=
 =?utf-8?B?UzRYcFMxNFpxYTBVVUh0VWhEZmdSSXY5ZUNXRG5YR1BpeHpUZHBYUTBkbVR3?=
 =?utf-8?B?TG1oR1BXbk5XZTJ2RGxRWnA0SHZYdUo3YjdlVmtjbCsyNVA5VGwwVlJYMVI4?=
 =?utf-8?B?dENxUlpTeWV4a3oyZS9GbytMcjFUYUxySnZoWW85M080NStSQ0hKMld6ME80?=
 =?utf-8?B?MTdaQy9SUDJoTnBKeE1LbDV5TDhicXoyWjBwNjhlaUhtbkRTU0JpRUJIYjlx?=
 =?utf-8?B?d3BWVUlKbUc2UEkveXdRWmRJZi9OdmN5MUJUWGZjWmdmVXAwL3ZoSTcrZDVL?=
 =?utf-8?B?UWlmM01kN0xFUXJ2M1puZWxwd3ova2tPVkVpZGo1MDd2UWxYU0ZydFJ5TnQv?=
 =?utf-8?B?OWZzU2dTbGNBTndKL2lMejFJZWpGd3FnUkhXMTNFR0xXSURpakpkTmxEdm1o?=
 =?utf-8?B?VnlIMFRzK1FkMXdFSXEvVVoyYUlvM09HMzBRUUVlenkyUnphSGtOUnhNbUtH?=
 =?utf-8?B?M2xhTFJVNVYzd01SYklUMk5DVlNYeWJhcnFGc0Q3aURoTzV2djdVZGg2SlIz?=
 =?utf-8?B?ZmR3WGM5dXJTeHdOZWZNTDRrQmE4VFNSc3E0a2Rpcld1N0JQVFdHT3RtZnBk?=
 =?utf-8?B?aVY5NE5vdDJmUG5mRTVONkYzenZFbjhLQmFiZFhhVVVDaW82dzIwTjdMT3Rp?=
 =?utf-8?B?WHlITTRnbnRxZVQ2SDhBTUJpbzZ4QnA3MEhQK0VVbE41V0tobGE3dVVzZVA4?=
 =?utf-8?B?emQvYjFkRkgyNFNwWWZEODJ0V3ZTaWlVNWE5OWRYeGd5Y2dieHVjcDkzbWp0?=
 =?utf-8?B?VXJEdTllNEJGaHhLWUsrUnJYeXBOWFFXait5cTFzdGJlcS8yWFhwNXBMZVVM?=
 =?utf-8?Q?A6To=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGY4RXNJd01yZUVESHpsbEdWWkxrN0FuQ3pEeG9UYXArcGhBcHhmVVZmajRy?=
 =?utf-8?B?RUFKaHBNTFhoYk5vazBjS1pFSGgwQ05nL1RaQlhhRGpDRFM4cUpNcEtMeElk?=
 =?utf-8?B?ZS83bVNJcjZpdENSa202SmFpRzAycHovRmtuWGpPVXVFTkR3NVlNLzFzd29B?=
 =?utf-8?B?TmR3aGNGcnN0SUZVSU9qM2p4OEZvU2JZU096bVZhUU9MOS8ybEN4ems1cXNm?=
 =?utf-8?B?VDBDNEtkelJqWTgyTHhlNGpMVkdleFZReXNxcklSK1FUWnBVYmJzd1VRTnZU?=
 =?utf-8?B?bUZGMG1Ra2MzUnE5OU1taFZOaUFjblhPUHdDbzJyNlpRSUhFcDZyMzc2UGlR?=
 =?utf-8?B?dmxxalBFSG1sTjRXZmJXK2pXRGVzOHhGWDBtV08wa3k5d1dreVJnZTNyZnpZ?=
 =?utf-8?B?ZlQ0TFo3MXlsaEVnMjdoNEZnODE3NTFpWWVMMk52RDZNUVBZaVdIblJ0MVZH?=
 =?utf-8?B?endWRzM5Ui9lVHNueEJsMnMzMU1OOGNXMTVMVEFqWStRM3B3dmpXd0FtY2Jn?=
 =?utf-8?B?MVNJcVFiWmJxUW84WkRrSnI2NUk5S3YxOEFBZTZvUUdMd1FYeElBQ0Y2VWgv?=
 =?utf-8?B?MFpNNXExVWxmalBIWE0ySzRwTVhMUUJaNnRSaVlCSTluUEpTWjVJN2NMWUkz?=
 =?utf-8?B?dXNIOXRLcW0vOVc2T1R5TU5YSGJTVGdxb0s5WUw1aExoVy93aU51MGp2NHVn?=
 =?utf-8?B?WjFtK0FzdlQ2d3ExTXk1YTdGMTRCM2FXcW1kZDBQNkYwS1MwaEd4SHFzVG9V?=
 =?utf-8?B?dDRLbitkdytpa3NnendnZlVVQTVtLzlWUGxXTDI5VG85UzRFUGl2TVptSTd1?=
 =?utf-8?B?dmNVVlR2V25oQ0ZSdnFFQjRsUk5sSnB6bGdlNXFxSkwrZ2h6ZmRrSFpqQzRR?=
 =?utf-8?B?elVsVnFlOVhqZXlrZ2VDV0kvOTNWSmhEY1M0N0JLY1Z4UzVQVXBqalczVUpK?=
 =?utf-8?B?VmhQeFFQalF3UWpWUkh1c2cxTmx6ZlA0N2lqS2h0VmhPRjVGbnpkQWg5Ylcr?=
 =?utf-8?B?Vm9LSmYrWXg2Wkh2ZlZxRmhvb3FjTWFaRDREL1hzSHVKVHYrb3NaZjNFekNX?=
 =?utf-8?B?akdSMS9oa3BnTHpVSytCUVozek83bXVFbExCSEhLR2NWR3pheTdhRDNIMncz?=
 =?utf-8?B?VDljR2UwWm5Hb3JJYkRjOW51TmhHWUpQbnRvWVhySTRYRlNYTFhlSlhtby9R?=
 =?utf-8?B?Q0FkRWdSMGxiRXBKMk5HNTljOTdwRmJ6bEdicng5ZS95MTNzZnV4M01GeWlk?=
 =?utf-8?B?dGVVVUJMMERNNHdiYmdIN0dqbXlNQlNJUGIwTkNlUnVXOEg0Nitpek8zZ2RN?=
 =?utf-8?B?dVlOUGp6RjE1eE5rblZUeFJkOVd6cDEvT3lScUsyb1ZrQnlFS3VOR3FMejVO?=
 =?utf-8?B?dEpVM3czOWVGeEx4cVdRbzVhTi9hWmg2OHJsamwxV2tMdXozekF2OUJtWUxL?=
 =?utf-8?B?T0lRVjhxRFUycGdlOXY2NE5leFVTZUU4UUtBUjFFRGswcS9Xa3luV1MyN1d5?=
 =?utf-8?B?bDR3azFXOCs3VWF2WmpDME81SjUraU9MOXRNVUxKckg0VGorUDhHcHhNK3VQ?=
 =?utf-8?B?cUp2WkYzb01vMllocWpjUklGUi9yZXVhYTcrVjBvb29DTWNIdndSRmNkQXJ2?=
 =?utf-8?B?cGF3NDVrOXA2Z094bVlHL3daSHpGUUloTXJudGVGdERERjBBU1dKeDV3Ujk3?=
 =?utf-8?B?T0N0U2hVOFdhdHFjVmRvQWlEVjZiVGtlWHZpMnpxS1VFYU1nbzZvT05pR01V?=
 =?utf-8?B?K2RhdDJVVDgrV0ZTUEVnSS9FaHB2TUNpYkh2YXg0L3hGaVVURnNRVEwyQmdI?=
 =?utf-8?B?cDFodkpWZGEzY3pYNzRIdWVTeWRJWFFEMkpuSldXQytET1B5Q1dDb1pPZnMv?=
 =?utf-8?B?ZEw3ZFZwc3RWUUF3T3YxYXFpWlk3VzhPWFliUkNFelFHcGw3QjRvRHo4WXRl?=
 =?utf-8?B?cHpTQW01bDJ6S28zcHE4RCs0cEtkUGhac3VVZWNXM05EaCtPdjZOK3dEZDdw?=
 =?utf-8?B?SmRRckxaSkk4WUF3b2JxVkVWZHZ4b0FyOFBYTzRoZ05sejlLOUpIOU1YTHBD?=
 =?utf-8?B?WmtmaGhmSHNhaklIWnZFT29zcDVLb1IvUGxwS2ZQQUZFNmtFNlUzRnlCbUdX?=
 =?utf-8?B?YjlqdmNtdmZicndCZ2FCb1VoQk9BR3VwRkMxbnNDS1JmT3pLNWtwbW11SFN4?=
 =?utf-8?B?NDBVM1JaK0JhUkp2UXdCbTVVZ2l3aThtTW9vdWNiSmpjTUZGdFlIalh0cDRz?=
 =?utf-8?B?di96S1hsSHNCVkJZZGVmVWxpSW1nNGgwK1NEcEZFMnBlTmE5TWt5ekJkWXkr?=
 =?utf-8?B?eFdXSG85ckhnMkorRXYxdTZhWStxQ0pqa1BQZEFuSmNRbjdoQ25RUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1564f6d-5ec6-4295-775d-08de5435a524
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:57:31.4749 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONKsj11h9A1HTo1nTLzZ9Um4/S0TSXQxI7LmlQgKBEOEBVpHDn8k5r70Tr/UQulxigWPyNitukugiRsh3CdW1XSMXB852Gn/RrUjmdym+MU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234
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

On 1/8/26 3:42 PM, Julien Stephan wrote:
[...]
> @@ -51,10 +53,10 @@ int regulator_common_get_enable(const struct udevice *dev,
>   	struct regulator_common_plat *plat)
>   {
>   	/* Enable GPIO is optional */
> -	if (!dm_gpio_is_valid(&plat->gpio))
> -		return true;
> +	if (CONFIG_IS_ENABLED(DM_GPIO))

Missing check on dm_gpio_is_valid() here?

Cheers,
Quentin
