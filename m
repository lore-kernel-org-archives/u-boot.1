Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85AAC87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 13:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9188329C;
	Mon, 11 Aug 2025 15:02:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="VXhCMDTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73242832DD; Mon, 11 Aug 2025 15:02:04 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E45E8329B
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 15:02:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBZpq/yBRKhbaYYWEGASHvfIqogXJoqaAbWGg3mytSkibEmEsV5NlOxysljHNyqQb7rbknQkvqiqyCLUCOzORzBTuihW6fuzRrhIhXqpjQc6khcn6P0BSiD+J1apacZON99AnRWJmkDFr8/DLFfbus5IwQCDMGAz5mKGfPzPNy2ddaHy6SUuAj66sMJCEUeIDqt76tLlZyBLFdc7ELnyuuSD7P42Yjid+H1VQUI3VRK2/VHDRfur6MxqVJ2AS/lDIBzrj+enn4j/qSeyC0ttNmno18SRakUX5F7DCzs1e6dj3W0OKnMJbHpkGVz9ls2FRFCBN6Nt4yzg9Yf3WV6SGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJ3rTKuwgFn7OBD1Xvwtq0f8pCFE8omuufX57wehkGk=;
 b=N3QKYENaJ6hXw/uz+Ooj6+TKyz+Jq5kIkI2ADelj+p5sIXEheTgCPuDDW7haYySvip2ttaT9UGyiZo3ufKaryBYQat1WDhc6sywtgjQLE5eH/lkpXYuJd86aCL9eSWyHhEuFq5VPCPFBTnS46a/D+F/Izbx1Qp7z11LvH9CTEeIuoS6xEJiyAXRTthrvf4TdpzVPxMyzVtR3PNhmcRl00KzosXbRLgP3fyu0BL18eBLio5GWxN72kYVJ2lz4t/fEc4feiDEyoC9SZakgYjd6D8HlgTO8vqjQ3+5YV9rU/ZT5zonnj1jVFHh/jTNtagIWsc5Ll/v4g5Grwu/koMOqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJ3rTKuwgFn7OBD1Xvwtq0f8pCFE8omuufX57wehkGk=;
 b=VXhCMDTWXGP5GTm6ylHNFsjxj+gvJqjk5jSf4CdxNUFtjNp3whJr9G37lPraNyphLZ8rqQDnQaMaxR7LcmO2ZYuqQ7T5gdedPxOzhv5S7t7euh6do9LY+JT4RZnXzvUaFVzzpmlC3NmoHlYPijY8CMrpuRNYtPWaqxlZtsxHdUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10264.eurprd04.prod.outlook.com (2603:10a6:102:456::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.12; Mon, 11 Aug
 2025 13:02:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 13:02:00 +0000
Message-ID: <277eb50f-26a5-4b24-acfe-210dfe346e49@cherry.de>
Date: Mon, 11 Aug 2025 15:01:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: vitesse: Fix incorrect test for timeout
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-net_vitesse-v1-1-47f5a923d586@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250806-net_vitesse-v1-1-47f5a923d586@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10264:EE_
X-MS-Office365-Filtering-Correlation-Id: a298898c-d9d1-4de5-32a4-08ddd8d7423c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTVrTkJ2cUVPZlVwbUNpd0JZbExoaitrcTdOS3JrUVJSS2R1UUZvMG4wL2o1?=
 =?utf-8?B?QWhzZm9PUzhENjRtOE13Z2g3NE0rNFNYSVR4NzNQVWt2SDFMZzluSC9HYWpL?=
 =?utf-8?B?bEluKy9SWnZKMFhmWTFrQVdhYTFXWUkrcHZVb0ZzQ2p6YXhvZ1dSK3J0SkJw?=
 =?utf-8?B?eVEwTm1RSDU5ek9rQU5TNnJHQ2Npc25OekZ6VE9GQnVqbFY5U0VDdld3Zmgz?=
 =?utf-8?B?dnZYdlhWVzdOVHBJZjVEb1dLb0lFdFI4YUsrS1R6N3pCTlUxUHV0cXB5M1FG?=
 =?utf-8?B?TktCaTdWVzZmSW05WUp5QzBhWElqZGdhTDFvTng1RjhYaDlXQnhQYmdaQzBk?=
 =?utf-8?B?TytUYXdTcU95OGptMDRxYTNyZEg0U3ZXN2dMUFR2UXdZdUtmTTUybTUvbWt4?=
 =?utf-8?B?Vkt4YjI3ZmRodzBxTXJiMkVnWWxlSFphcG15TXFTWi92YWNyTDA2WlZEd0lv?=
 =?utf-8?B?NFhyK1RidzBFWnR4QThvYzZpb2t4SDFXUTB6TlBqQVlyc1BsckdhY3ZIZUd0?=
 =?utf-8?B?dkFVV2gzMUFpNjZZYXdTeVE2NytESWR4NWpFLzdpTWNGdjdoMzJGaFN2SU4x?=
 =?utf-8?B?dWZVcXBQdFZ0OUdwOE9qMnJQb2xNWGlBVGd0cXNCL1VOODBSZlJQa0RrTnZj?=
 =?utf-8?B?ZEpkc2ZjdFA2Rm5aNUxQdDBacElURHZVTWVway9KSjhSeWEwSjZVNHA2VWJP?=
 =?utf-8?B?dUVmSDcwSUNWS3lrc1k4KzdieUlZeHV0TVdmL25YSHptbWVNdXdiTFowM1pp?=
 =?utf-8?B?QXVtZUx0RGQxVm5XUkdaY0prSHRoc0NDNlFWV2FqZEt5c0JOTXN2dlFIQmVk?=
 =?utf-8?B?NXltNmp4WFJVUGdCK21oTGk1MGtpRUxoVFRGUnpsdFNxUVpKczZvL0hKMVBB?=
 =?utf-8?B?b1dHamk5YzArc29Tcmh6SzgzNEFxUUxrOW9yOGdick90L29VU0ZQZEY3b2k4?=
 =?utf-8?B?ZVp6dk45cXl2TGRtbTlQSjc1d3hOYXVUY0E0aXY2b05LRG5KbjRGK0NsZlZu?=
 =?utf-8?B?bGxQVGN4S2lzRVVtVlpzVTBMYW9kNVZYeXJycFZHTTh3TXpyZHh2ZnBpSy9x?=
 =?utf-8?B?T1lQdG9rc1lMMkwxZHZ2QlgvUDY2VnJ0R2hERWNIM0h3aUJwV1lvSjV6NEts?=
 =?utf-8?B?c2xsbzdkVUdxb0pMTTdrRmN2bE1XcGo4RmlyVFRDVFlRQWR5Y3pLcUIrN1Y2?=
 =?utf-8?B?Q3JlUlFEbUo3MnFyUFJkTlVvcmpWYkxOTFJWaEMzK2hZSVQxTnJQNGxTNTF4?=
 =?utf-8?B?U29Say9QTTA4eHFMdXppUm9tc0liMmh5aitOejNrWituSjFzUU5rZ1dTZnhV?=
 =?utf-8?B?Q0xqL2Vtempha0NWQnpzR0F1R1FLM29PQmJkbjZGZUhpbFV1OUZPY2RhOS8y?=
 =?utf-8?B?aTZlTGNVRGs5eXhMeENpK0x5aTIveTA3NDc4bUh5V1VLR2M4dWlXdktUeGRQ?=
 =?utf-8?B?czA4eUUvQUR3TUhuVHRMS3JwK2x1QU4xZmtnOGxwWEY5VzdmUStnUmo4Z2dI?=
 =?utf-8?B?MjdYTzhEdnRFK3ZyUTU0dVJiUmsvL2lFczJoUnFFYnpOMDVtOGVKTGVmblR2?=
 =?utf-8?B?SmdmSm9pdFNUNVZTdUlFSmdHYVBiYnUzY2xpb3R1bnJDMFQrYXp3QTdCYlZI?=
 =?utf-8?B?UWVtWjJnSURDSm1FVFR2bExNNmk1a0kzeTZhOExkNXZaSHlrS2NQcTZjSXpM?=
 =?utf-8?B?QjdzdnllckJuTnM5aEdUZ2NvZzZ5VUNBZTVVaHlnaDJwRmgrMTk4RjN5NVpq?=
 =?utf-8?B?SGZsbkZTL1UxM0JoVjh5UUV1SmpoQjJYSzZ6SGphNEFOalBxd21ZeTJCazBx?=
 =?utf-8?B?VFcxaDVlRkhwdFhkcXo0b3luTTBIVVd0MVk1WWtIMnI3a1BTUVdlSjc2aEtN?=
 =?utf-8?B?ZVVZMDFWaktuZElBWDlHNElZV2N1OTJ2RlZXSXExZzh5c1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnNmZDJpU0srdVQzMW1iQUk4MkdpSFhsRGlzNHdBK2UzU1B5Nms3N1dYaEs0?=
 =?utf-8?B?bEJsenFadU1oV0N2elNvM0NUckx3dTJESWw0Mk5HUW1HUDlES1h4MnhHeldU?=
 =?utf-8?B?VFh2R0xPN2VYQXNYSCsycy8rbUpyM2dQVVlOcDQrTWRYWDMyNXFVYzdhYXdl?=
 =?utf-8?B?anZYSzNIWHBaUkY3QkphclNrRlVoWVhXOGs4azgyaUJFbFdXWXNiSWlhT0NG?=
 =?utf-8?B?ZUNmNWVzZzNrdEEyOWtUQldKRUpMcUNXazY1aUJVdEROcVFDeFZUY0JyT0tU?=
 =?utf-8?B?QTYvNFh6NzQ2bmM0cGYvT0ZTT0pPUjZ5UTZkeGFkTDJCa0tjTzY1QmhKZllS?=
 =?utf-8?B?dTVLdzRhc0lGdG84UHF5azRadnd5TW1VZURUTTVMSG82dEZSMmloVzJmYm9s?=
 =?utf-8?B?dGlsNWlLMVBONXBWN0cyM0FGQVVyM1ZjMHlMQi9ObjNFM08xay9EY3VuWExs?=
 =?utf-8?B?VjVhWFllb2ZCdU1Hb2huWGw4WGlzeFJBdFFQWnJ4Z0pVVnhNdTVyZGRtOVRT?=
 =?utf-8?B?SzhRL3NoR202bi9rY09tUkEvTG1PSm5RVjBFcTBWVHN2WXpxMnVmY1dKVjB0?=
 =?utf-8?B?Sk1nZHpYSkJqSTNsZmhRU09sTEdMaUprVUoxRjhVQTNlVGR5MEtQcEpLeWhz?=
 =?utf-8?B?dHhjT0lsTktwaWV1QThsZ3diYTdRY0ozR3ZGeUdYUFN6d2RIeTJIejI3L2M4?=
 =?utf-8?B?cDJtVUZuQzNvMk8zYVMyVW5CbVl6N0U5cEVKWnlSMHgvQk9pRmtMM2NXQWls?=
 =?utf-8?B?MmhrQXYxaVBWUUxUMVRVbk0yVmpBUWdtY1RqM1dmOUtMejNPRURkZVpqK2NO?=
 =?utf-8?B?S1hxUXhkcllRSnUrcjJiL2hxa1RjT25RRVBVSDNENkxCVldLdjRnUjFmRlVI?=
 =?utf-8?B?d1dtQ0Exdk1RUHpJWXpCNUFMU2lOQ3gzOHQvM01tS1NoKzNTSnFMeWliTlph?=
 =?utf-8?B?aGlEM0RVcHFFTStScmlBd3V5NzRnSHI0dnpjV2g3ckhnWi84eGZ4L1VBWjRH?=
 =?utf-8?B?TFprTzVnV3VmRVZ0QWRjaTNIaDlCaHI1aW1pc0c0VTFGeS9hc3R6c3JsWEhQ?=
 =?utf-8?B?MEl2Ni9sYVVYL2wwWHZjRDl0S3hyU2V0QjNjVnQ2d2JoRnVQbGExK3VQMEtL?=
 =?utf-8?B?RVFlYlFIR293dlBOQjB0RWs4OXgvaUt0V2tvbEI2ODNuYmh4QzJ4cWhydm5w?=
 =?utf-8?B?Q01FOTNyclZTUWlwdzI3dDU2d2kxM2EzeExiMHYwNzVpZzNKMXRwdU0xSEFj?=
 =?utf-8?B?K0x6T0NHLzRmdkhrL3NHek0zWkhtZnpiTWREWnh3Sk1QeDJEOEtjNHpMbDdV?=
 =?utf-8?B?bDNMNzBzTWFPOXZaZVNPWFlENk1uTWxabHFOTG9QeXBQNGJCZEVTK3lxUUpi?=
 =?utf-8?B?N0xaanhia2VmVUtQbWY2N3RqTEw2bUp2aURKNEYrcWJSNWcyNGYvRDZvem9R?=
 =?utf-8?B?QW0ybTlycGo5eWZ6RDE3TTVjWXY4ditKalpta05PQnVPcEFacWtEeXFXam15?=
 =?utf-8?B?Nkc0V1p6clZPMVRzaGtLak51d05CUGtGRS92cFZOUnFSV28xc2FiZlJIenlQ?=
 =?utf-8?B?bERMNHRFeHdjREhtcVBUY1dXcGU3aFFFZVJTaGpPVXd4QmdSOXFsWFFqOTRN?=
 =?utf-8?B?d3FCL2ZTZUFPRm9yT2ZTS1dXSlQrV2lNVVMvNkFyaHVSa1psd3RSWDBnQWFi?=
 =?utf-8?B?czJxL2NvVnVieFRITnRVR283eDRCYnVGd1IxV1hINVZHa3RkSXdNT2hpdlNS?=
 =?utf-8?B?Z3Y3TFQvS1Z3SmlsWHJYOWtpR2xDRzNvTWtQZzcza1FWb3JhSFA0Z3MwaGxH?=
 =?utf-8?B?UWgrQTUrU20wVjY4VjZsaTZxQThXVWFHM2RaQ3RQenRoMGIvaWZVYzZEb1hI?=
 =?utf-8?B?TGhHQmFMK0hBcWJvM1oyQ0UwRE9CUFN5Q28xZ3dLRjNhTUUwK0NDVzY1MXZ0?=
 =?utf-8?B?SnNWQ0FtQmlZTW5FalZCUmk3NUtQRThKbU00YnA1UkNDcEVaSExsV0JZcC80?=
 =?utf-8?B?K2o1Nlc1elZIWlBLKzlHYWNoWG93UHRLbDRYT05qY2NNQXF4WGQvNURHMmV5?=
 =?utf-8?B?cW1qTjdXeHB2YU9QVXVwQXZoUGRKcmRtbGJQUWFVTlBEbk0vR2ZCUVkvVjYw?=
 =?utf-8?B?Snl4eUtVV3lXVWlwU2V1QnBMR05LTWVCYnYvVE9reTRUQjRYRjlSQ25CTTNr?=
 =?utf-8?B?NE4xaEM2OWQ2Q0tpZEpBc01hNW1QeGxYendyRS9nSWZuNnVhbEJIb0VIODFZ?=
 =?utf-8?B?UllHaFZnOTdXMmdPMlRudnVvTmZBPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a298898c-d9d1-4de5-32a4-08ddd8d7423c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 13:02:00.2146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fj1xqpm/6PlsfSJ8bPcjR568kjiX7tFOaCDM+E/4XxuQXKFSFHBsLNla48f6cnKpIV5Nu/EJfMaY1K4n6M6zI75QlEAyNETBw73MpslFKYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10264
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

On 8/6/25 11:37 AM, Andrew Goodbody wrote:
> In vsc8514_config there is a while loop for detecting a config failure
> using a timeout counter with a post-decrement. In the case of a timeout
> this will result in the loop exiting with timeout == -1 so use that as
> the test below the loop to detect that the timeout occurred.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/net/phy/vitesse.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
> index 4867d1931b4..821d3878236 100644
> --- a/drivers/net/phy/vitesse.c
> +++ b/drivers/net/phy/vitesse.c
> @@ -239,7 +239,7 @@ static int vsc8514_config(struct phy_device *phydev)
>   	while ((val & MIIM_VSC8514_18G_CMDSTAT) && timeout--)
>   		val = phy_read(phydev, MDIO_DEVAD_NONE, MIIM_VSC8514_GENERAL18);
>   
> -	if (0 == timeout) {
> +	if (timeout == -1) {

Could have used --timeout instead in the while loop and that could even 
have allowed us to change the type of timeout to an unsigned number type.

But that works too, so

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
