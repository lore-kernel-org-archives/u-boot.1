Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A0BC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 08:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35BC082C2F;
	Wed, 18 Jun 2025 10:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="S7TB2LeI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0638D82C55; Wed, 18 Jun 2025 10:51:10 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B5E382B18
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 10:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nn2kPMQn9PQeBl1OB0VDS7pmXF92nxeUFD7y+B7w6wx8k5UfH91L8vFBeoDO2vBd6yXZMDxbkad5OlLIbIarJTv9PPuVfv93J5lSmg/gyLh0ZjBEwRMPf8UGQa2rs647gt1QxoEWLpQ0u3FfXMnhF9D4qwcExoPmJNe5GSVVS6P2RBIDt+atBqok/m2cC2wYj8lq5pNv6Hi+3kFiwm3ipXcNayVjl7avqPh0slRvVhbf+qaRfCxLhy5hbKRgnOt17fAh5ZhzZzpVFTT4uvQEBzlY322ZaawUZsOtXEp+SN0d1Wc5/VBtovO4c0Y+32vQoeng0hrvEvTzCKWQtVGPvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ0w8TBNWuKi3aYH54eKXn0JJtewPsY/1+7JISOj4yw=;
 b=BkEj2fxRc7RdJ2SnwVaWpQZwohtZC6diAhRv3Hwv94XVhj3Y9nk8poD1zmPQPB1gOinZnZdbvcY7Z/YP2UrOlvVa+a1byHMzR4gLerFGCVhZDivfSEWHYd2s8QigyXuegW48gSF3xl0Z3TKJTg+dJVZcOcG+7mokCpNWxEtqJS1vxPmuV8i8BoeQIZVZGRJFQFypPnwiQZCpDwXTjMENJSN/1qSLWhbikAiJH4sAiIZ856blxfEuRCN/i6XwqbpZUBJPm6mGMIahyb2DiL8VWMyTWPucbb4TCtJWuGq2i5pCBwU1YekK6BKFyhq1pmrl11gBRDHUrjxDU+llW0YfWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ0w8TBNWuKi3aYH54eKXn0JJtewPsY/1+7JISOj4yw=;
 b=S7TB2LeIaQse0fYvmsi9+2FjzTZWhR9IFBJgnMNhsebE+bQsu73tXJVmo1ABBju7W+HT8SkLB/PMpA5xIwQV3nnTIqXcGoVmRz4TeeU1jer8sReIVSzbxTMRRHmqU1yq81MqOkL1UP9YiiofBeV5CIJ0YPxGTnilthIwrFuhVB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10881.eurprd04.prod.outlook.com (2603:10a6:800:27e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 08:51:04 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 08:51:04 +0000
Message-ID: <1479d629-bf77-4c73-8108-8d9fbedd8b1a@cherry.de>
Date: Wed, 18 Jun 2025 10:51:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: tlv_eeprom: fix typo errors in comments and error msg
To: Hugo Villeneuve <hugo@hugovil.com>, Tom Rini <trini@konsulko.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
References: <20250612140410.768650-1-hugo@hugovil.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250612140410.768650-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10881:EE_
X-MS-Office365-Filtering-Correlation-Id: c2babebb-a7f9-4b7a-ed0a-08ddae454202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U29iOUFJTmR6YTFHV01GR0NsUGxkd0psNkhnYTRTRDg2N2hHWDFnd3o0dFNY?=
 =?utf-8?B?TjFsT095NU91NWd3dzd6cG90dUJZZWFIclZQaWxpcmdTV3FsdGpwVUh3OHUw?=
 =?utf-8?B?R2taZHhuZGxEQ2w5TjBTWDRnN2FvanhkRzBmMWYxYlpPSm5VZWdMeWZPQzhR?=
 =?utf-8?B?WjdSTFRpMW96UXk5QmRxNTdEUUdvZkkxZ2U2M1lxdVR2aHRiTThLdENXdUlP?=
 =?utf-8?B?aXlQWEN6aWE1bmFEUXc3ZmljbDQ0MWVIL0RseGpYcUpDSjg4ZHhSbVBhdVBW?=
 =?utf-8?B?MGUzVU13TWZMUUdxNy9MUUlrVG9YZ24zc0YzVzVQMDBuVUFqaFBDQVFjWjRu?=
 =?utf-8?B?eHU4TkpvbHNTUFM5Wm9Mb1BzeWJxZlpzN2xtZnVuWkc5TGYwa0ZUY0hQT1Rm?=
 =?utf-8?B?NHJqSHlVWXBJUXZRMGtOdVdoL2paNjJWMzV6eVBTZ2w5cDdjV1lwbk1RV0xk?=
 =?utf-8?B?TWt5VXkxU0RsZGFYLzdlTmw2NVBZaFZTMGNsZjk2VytLRjkrWVJlSlRWZFNR?=
 =?utf-8?B?RTlPa2VMSFdCUjNpdzhQMUdUNG5GMTZjSnltNnVVd3FiY2drN2I4OHdWd1hJ?=
 =?utf-8?B?ekVuSXFMYytLVjVKbmczSkF3T3phSEFDRFNTZXBqRFM4MVhoR3EreCs1OGtV?=
 =?utf-8?B?cXF0cUdqQkpLcDFKNWRFNVFVMnBNS3RKbUd1clRITVNsSkJMaE51djlNbHFQ?=
 =?utf-8?B?M3IzQTZFTGwrR2pZcXNDUEkwdzVrMVpCMHpaV1NJUkFsTytaekQwcnoxNURq?=
 =?utf-8?B?ZTdTbzZJK0hXUVpnSnltbC9pSkxQWDdYSXpFTXgzeDZDZmU1anNYcUNPSHVT?=
 =?utf-8?B?bmoweG5HYjR5cjU3elQ4dE9qVHI4QUhTQ0s2a3JHdFR4d0Y4QUtRRGVYTCtr?=
 =?utf-8?B?NlU0Qks1c1lCMDljbzVkWGNMOGZkaW5XL1BrNVduVldjY1dyUXBXcmxBRlg2?=
 =?utf-8?B?Rk5NcGdEQnd4YkxXV3BWbWNjU01XZUNCRFpJTUdzZGFsOGtiUFV4Uzk2T0xp?=
 =?utf-8?B?NnhObzdqTlhuM21hczBpU3ZWVkFDNVpuQVpwc3E0dkQzOFJXRHRMdnFVTnVR?=
 =?utf-8?B?bXZMd1JZOXFaZHJHQjFCelJRbm1neFNzdHZTRlkzWjU0UGg5dXVLbXp0TU9G?=
 =?utf-8?B?eFRGdm5UR0FZQmt5Y3NFcjg3VDZZaW9LZFpJU1hFYjRFQXlYeVg0dDUyZEE2?=
 =?utf-8?B?YmdPcXJLZzl2SVI1SHhCVDhoNENaeFd4YmJaTWhRMzBBWFRBVFAvZ0dCT25n?=
 =?utf-8?B?WmRGYVV5cjJRRkRMWG9iMzVlL2xsY3V0ajFNdGkySnd0eU10TlMrT2U1a3Er?=
 =?utf-8?B?ZGNKNjhqK1NaYnJvWlFDSEo3cFVFcHdpQzgzK3Q3ZU5GNWZxTk54b1FLZFFp?=
 =?utf-8?B?cDBOUFVXMzBBSHBWOHBHcmY5aXdQWWdCa0pISVhERlA2NjlydytVcFdxT2Nj?=
 =?utf-8?B?aGhGeWJkbmh5emVQbENOZDB6YVpiVm02UFJvMTJIRzNrVG1PdE13ZlgvQmgz?=
 =?utf-8?B?dHA1RFBodEFEVUZZSHBOMDhkaGozclJvMTNUOTUrcFBMQzg3OWdRTnZIbFBG?=
 =?utf-8?B?WFhrOU8wNnZvZE9RZjEyVGZIZ0JJZ25HbFZvTTZJUTZiNDhyNnVDTnJYQ1F1?=
 =?utf-8?B?U3lFSFF0SjJHZ0JRM2gxMnJUanpSRTk5MzRqU1hJVXExQ25FYno2TmJmc2hK?=
 =?utf-8?B?U2swYUpEanhLaElTcFU5TXBEZzBIajlBMkgrQWplY2owVUMvYnhSRVBZamNa?=
 =?utf-8?B?SzVyWXdONWVQV2xvMjJyVEI4bDdUcFhHaERHWGkwMmZmMjFPL0tuM29yZDh6?=
 =?utf-8?B?WHdyL2MvTEcyL2hJek1NTUt2bmlQelA4SHJYd1FYMjN4ejlqNUl5Q2dHRjZT?=
 =?utf-8?B?bW16UWtNa2Q4eEhOSkIrQzErYkNiUHhadkhScndPRnUweklROUlEU0RYY0Fa?=
 =?utf-8?Q?2oC9cFe9yK0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ME81amlBRlh2a2ppVFlyb3MrUnZUNVBBa0lOWFVmNXZIT3NrZ3pnaklEeUpZ?=
 =?utf-8?B?OUxoODJKWFRtaitsYXZJVGpxbzRMSnpQS3lHUm11ZkFTMXNmWi9VNjk5VGZj?=
 =?utf-8?B?RjVWaFpZcjJXN05PY3V4MkRxTG9Hc1VOekI5MWk0RlBNTHRRV1ArK1B0a1lp?=
 =?utf-8?B?V1F2aVdDZE16blJsMllmNzJGdTBiRHhZdHpGcUlJRXBTcXJmZnFyNHdQTUNE?=
 =?utf-8?B?QnU4Y2hiRkFJTzZYT1VYNE1TSDA1ZmVrSWpaUVZBZkhFcHp1dHA1cUpJeFFO?=
 =?utf-8?B?Wm9rbXQxbVNDWUprSEVSU0QzVDV5U296bnljMnRLY0dINTQ2dm9GaVBraUI1?=
 =?utf-8?B?RkNoNmZXRUlsN2JhMXYvUDh6L0RVbmdTWGF0V0U1THd3M1Q4OGJmdklKVUhO?=
 =?utf-8?B?aTVaSW5sUXp3eGZsWE83bnVRcER6b0RtNHFUcGJRMlA5TEVPWDlPVGNyR0xM?=
 =?utf-8?B?ZWZjNnNHUGRUWVlJYW9TMmt1SVpBdElYaVRuN1pOd0w4ZncvM0NDODZLcDU3?=
 =?utf-8?B?dmtOZTJja3NXLys2U3c1eGhQazVFZWIvL21icWRONkhHU3UrOCtMbkVyck5L?=
 =?utf-8?B?cHVuek5aRm1LSzMyNDNtdmxEQ1VZdkRwTkxhMEVlS0JYalJ1VlJENUwwWU9x?=
 =?utf-8?B?cGZEZ0MzSk1GWGhiMEJ0Z3JHZm1HY2JVTTc5by9nZXdmUEMrTThUcEZzOTRT?=
 =?utf-8?B?dDVqbEdqT0VwMVN2d3RBZU8rZ21tVHRQNTluOW9CeGQ1elo2V1Vnc0F2SnJM?=
 =?utf-8?B?d1FaODZvdHdMVDdHUkdiZ2NtSTQ1Ykg5cTMwalBiOS9xaGx3K2VFbDJtM2ha?=
 =?utf-8?B?cWlWT21yYVlWaFNRU2pFT2locjk1QjF2c0FSeHdScEhiKy9RQWU5WXFoN21C?=
 =?utf-8?B?MGZ5SkFvNjNLVktPZ3BFM3JvRXFkQVUrUDRKWllqMi9lNjFvdFZMUGpwV1kr?=
 =?utf-8?B?emZ3dUhFc0kwMjFlMmM5Z2dIb3RJWk9vWk01Si83RFNDVWV1cVlGY21taGdy?=
 =?utf-8?B?My9Xa0xWcTNBNUlCdWxXYVozV2p6RzdOMGlCell2RW1KYWRlZWpzZ3U0NjBx?=
 =?utf-8?B?MGNHMWdGNlkxbFpxdHJsdE1aTFFJWCsvSWtwdnR6QlVWaWJZNVFiUmx3ellx?=
 =?utf-8?B?cGNlbDlrRFhMdFFKV0Z1aFd3TXIzcmwxcGF3amJiVE5sT3MydWJwYUpFQUgv?=
 =?utf-8?B?L2NTR3JiZWZMWWhDblZ0MTNRRVhLRDZMMTdMMzR4cWROd1N1RC9ZaFJKVXNQ?=
 =?utf-8?B?eklKdyt2Q0pUd1NzaVg1ajNqRUF3SVdvdWFDWUNZelBSV21xSHRrOCtMcGRO?=
 =?utf-8?B?QlpVY1FHQWJRSVViaERZRjFpU09MZzdkaUdoWHExczQ3NFJkbXlmdWd6eHdH?=
 =?utf-8?B?b2tDOXVnS2pZSDNGS010NWhCaHEwdm42eDBzQ3BtYTg4TndnT2Zvb2Evc0ta?=
 =?utf-8?B?MW9IQ3NhRTdrdXo4WXA5MWd3cU1yczVyTVJSWUNobWZFczVTUEhrV3lsT0do?=
 =?utf-8?B?N1ZpODl2TU9XbkNCMHJhSWZDZVNDNnFVUXJkQ21DelMwM25aWVR0cFhLS2ox?=
 =?utf-8?B?Y2lRUEpPbHhVZzg5bjJtY2FvSk00NXdrR0tKWWVOVGx5cTVHcm81TjlJdGth?=
 =?utf-8?B?SnU2RGpzTlF3ZytIWXdlK0hsY1VrUVRBRDRjRWthcWwyZGxpUXVUYlRWVCsy?=
 =?utf-8?B?VDQzdTdrZnhJWHJ4eTF5ZXc5Q284em9UUFpBalV3WGNHR3haLytweWFqOFps?=
 =?utf-8?B?ZUZIcG1PUm1UNGhPNDB5dFBhelJad1UzWThjdDRmUTczc3FPVzFZVjFpQm05?=
 =?utf-8?B?dmVuVURTL21rZFJzcll4aWNab2lwS3JUSjdZZXJ4N2gweHFtVHVuVjlxWUFJ?=
 =?utf-8?B?UnNVREJiVFQxZ25mZ250TnYrVERFZjNyVEc3Sk1KcDdlSVc0NkM0ZDlpNVBO?=
 =?utf-8?B?MC8xTFY1TDZFOFRzcjExNjBvVlR1eVc5RUVKdkRlakZ5ZmIrNjRZT2E0R1Ay?=
 =?utf-8?B?RlNYZHhZaUJMRitIaC90ZmR0cC9QWnBRd1UzbmJ5TGQwN3ByQWRTbWJzK0d0?=
 =?utf-8?B?cytMalF5NXZQckN1YUNxOUJGNEpRWEdBYitETWUvQm1IbXJxRmt1NExndWVJ?=
 =?utf-8?B?THZZb3VnOExWU2hMVUt5VDdaZ3ZSSTNWMFZaN2lGN3BZNHA3RUxpVUp6YWVn?=
 =?utf-8?B?VEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c2babebb-a7f9-4b7a-ed0a-08ddae454202
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 08:51:04.2899 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SgLtRZBdYKoYKDZVCS4D3fVhX3vPPhQ5bAXnqZwxb7Zt4zULNVNZFgaSzKBqm1pUkJaPAb3vxNjk7aCYe4npjpy8vUYuj4w2Gu1TuQoTPvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10881
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

Hi Hugo,

On 6/12/25 4:04 PM, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Fix typo errors in comments and error message by replacing EERPOM->EEPROM.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
