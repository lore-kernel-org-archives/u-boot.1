Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E23EC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 05:04:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F26C81F66;
	Mon, 19 May 2025 07:04:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="IRgL+P0g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21A3981FFC; Mon, 19 May 2025 07:04:57 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20722.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::722])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6E23803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:04:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgaq7b4A8S8y/UtSF0Mj9DmJFFcwEQ+c9LPG9UfbpuTFDMQIKoT/C821fHGzXy6458pagE0Br5GMaZOANgNvMBgWxGHf1UZoPMCjMtHL1PiuiJywftBiClFhtryhjMNcv9Z5xXhu6piRiVS7SfT2FW+SqQaNIwEJqDQHk8sCsCE/vQM1OmtrybNDO68Yf8SdAyxnLeXnH1QFs5GI/eXCkRCzOzzo48VE8rW93nqBQVrbAz+VFAlvCkep7jDxQfiazzSLKaoL/FNSl1FSVTqqtLO9xQjo12EEpQteLrmfYKQNtjWdOtRlQvSBKKZXyDZbCKM3v3oKk9EHNtScEdNbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xll+Bdss8a/ITGgrl186xIrwW7z60MQqoRy8IlV+Jw=;
 b=iFuXpBlFT1/zPXtkDKpnEnM1YZM6+o6eE2Seg8lyMOVCb25WNBjZr+5xS+5X8JX4UUUazx1swxAsPZsHLx1Z6qIpeTyxyjQFIBr2hjaKUcs7B5ub57/pFldp4auhiQbA04ZIoQF8PnepgMJbxaFuoogp28cIq8i7Jr94Upct+BuaAhNblXakyMabgqF37eOczfoB8Y2+xKqRfO3hhwSMLxpJ8Gn2Io6k3b3si8GQrR87l7eVRedslPRCYXWEjFKK2uZSTFlOydK3BMexlrzSPHlZa+FTXwQUXuPL8t8P9zjCSk9BaViSqG+5bcg2Wl1sYOIJTyeyV6Z/1+Qhck5+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xll+Bdss8a/ITGgrl186xIrwW7z60MQqoRy8IlV+Jw=;
 b=IRgL+P0g0tAsNk+hH/xt8WcoKCTDIwBsO+PPjzdTMAiZFjE0hYfvCd9V5RhBPUk/e8WvDE+N1zY842habhYXGP1XOAbXcA/V4lVOO1X/IZXSc3YW9X/b2UXCMwWLuEQAfIawDKmhoIrJSYFI/EWLvQjkOlcAREVNm5EBtnnA2bYg8mgTyLVebqOM6xwb2Mw6ixvnRhfq5ldy2CZVRxlOs4WKwJ56RYLA+ubK+Pn1knHnnW33O0FPGl9wIhMIGpbR5KX9VsPqoHWSv0Q5mOWLloz2Tb2muwyCZ6KcIp3QA1fjerUVLTSEJLOcgLqcZag6kzlF44H+raoI+DOqG2IYhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AM8P195MB0945.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1e8::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:04:51 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8722.027; Mon, 19 May 2025
 05:04:51 +0000
Message-ID: <f48d6497-2524-4dc7-ae35-2af7d3a295eb@phytec.de>
Date: Mon, 19 May 2025 08:04:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH] ARM: dts: imx93-phycore: Migrate to OF_UPSTREAM
To: Primoz Fiser <primoz.fiser@norik.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 uboot-imx@nxp.com, Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de
References: <20250516104602.2445510-1-primoz.fiser@norik.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250516104602.2445510-1-primoz.fiser@norik.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0114.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::43) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AM8P195MB0945:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f6fa77-a766-48a2-e673-08dd9692af9f
X-LD-Processed: e609157c-80e2-446d-9be3-9c99c2399d29,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDYvMllLeTlRclZlYkhpVlBIMEhuMjVRaTFwYmJCOGxiOFJLOE81VEkzNUsr?=
 =?utf-8?B?R1FpbE9jQjVNbHViUzdHQ2YyU0F5TFN1OW55YkZKUnJ2di9jT28yQVFQa0VC?=
 =?utf-8?B?NVNaZkVjclhoakN2QlQwUjhYQ2hsWWJueGE2M1JEMXYveHZWTndmSm9XMWI2?=
 =?utf-8?B?YmUrV2M1TWJRV3Y2WEZrTU5wZVYxc243alk0U2piK0sxRlVLU2RQU25ZVVJM?=
 =?utf-8?B?MFNtRVF4eE93aVRjS2dqTTBFVGs1UmcrK2ozZDI5akJNaC9jT2pkZ1ppYWcw?=
 =?utf-8?B?NEFXOTJsSkZ6SDhzc1hNek93Qmx1ang2VkNGa0lLU3hkektuUUlxcXlycWk1?=
 =?utf-8?B?WkUvNEs0UUd4ZWQzT1lSdFFJMWp2bDVpUjMwRUxHSkdmMUpoYlFLSUs1eVZP?=
 =?utf-8?B?SmNRZHBBK1ZFR09UTXBodnpEaUkvRGdjTklEQXdGbGZiclN2WVp1TVFGRTMx?=
 =?utf-8?B?RU42VjdLQUhnaFVEWTJIbnY2SE03Qm5Sa04ydXh3WldIejB4YXNINlVYc1hu?=
 =?utf-8?B?WVJZbG8rMXhtdVNqVkVuVjJlcTVPaDlmRm5qZ2FOSHE0TVZ6U1RjRjBncXVQ?=
 =?utf-8?B?ZDlVV0syaG1QZzByRkJ5WmlmTm5WZmNKTUZJNkxYNWQ4YW0xVEhSZHpDU0dt?=
 =?utf-8?B?SUhyRmVPSWVaZGVRc0Y3RmQrbXh0enIrREcvVnNTZERuR2VrSFpTYWduTGhz?=
 =?utf-8?B?WnlJMnpuNWd0Q2l2RjQxcDQzWGJ4T3JPR25CdjdrWE1YZ2tsdWRMUEt4OU9x?=
 =?utf-8?B?aEpycnJ3cythdDRraG0vUEUxQWN0c3paVkFDbkFVVWZXYUtFRXd0NUY5dm85?=
 =?utf-8?B?NzFwRG96VDJweTBnankrT2lPeGtncUNHZkl6bDJvOC9JSVRmeXg3NjhzL1kw?=
 =?utf-8?B?VkJrNGhNTk9CQVlCQUtpOHk0anZ0WW5Od1EwNnRuT0w3U1FQVTlYZkhadWdi?=
 =?utf-8?B?SXpEQWhrWElOMkJuVVQrS3U5ZG1Bc09PNFF0TUFweUFINHJUNTNpM0ZXN1lP?=
 =?utf-8?B?WTZXQTRjZnpwYjNCaTlxSWdON05nS3RITjdiazczUmZDN1Bmb2VoTW5EYkRT?=
 =?utf-8?B?bXoramQ3VTBDRW1RbjM3aXoweDVocXdOdDVxVFkxMUVVQnVYMWpCUmo5eGdi?=
 =?utf-8?B?dkpxV1Awc0U1OUVFTVNHV3ZuTjRxTENKcCtwZHBqV3lZbVVVSnAwMXl4cTk1?=
 =?utf-8?B?UDJ0UUdnRWR0TE9mL1JhV0FsVWVwb1dYQ3RleS9NQ1VhOFRZN1pkbzN0dDMw?=
 =?utf-8?B?cFIycy9kbVBSR094bmFEZjZDVXVFWm5BZ0JSeDJEUDBrcW9IWDFBV2Nqdi81?=
 =?utf-8?B?N0lzOWZIY3Z1TG1vSzU5RUF4YjBnellhd25rM3U5SEVHaXUzNDg1Wm0xeVA2?=
 =?utf-8?B?TnpNYkpSb0lNdzZqS1A1QjhzRU5nOU8yNTFrS1pQRmt0OWZxcS9VL1U3YnFo?=
 =?utf-8?B?d205bFRKemt4RXJyWGRJUk9nVDQzK1psanl2WDY2UTRVWFhiTjd2eUFMRitm?=
 =?utf-8?B?MVlKV1Vya0JXMWRCZ1h4SUxqNTBiNVdpRkRVU2NHK2ZzY3Y1MXN0Sk5NanZE?=
 =?utf-8?B?Q3p6NmJWbzUxZyt1WEs0cHlMUU5RYVlmQVdjNnA1a1ZJMm5HVTdJdTFmTWJo?=
 =?utf-8?B?Z3pOd1lhdHpmeU1XaEkrYlYxN0ZNK2xrNTdvSm9IN0ROOHFiY0MxVFhNNHFv?=
 =?utf-8?B?VFJSTHhUZjVDNVFzSkhHUEFnMTN4OVNBNjh2ZnlMdlVBRzVaakZIdjRadFU3?=
 =?utf-8?B?ZXhyWHR6RVBYU0FITHVoMVpsYmtac2ppUlZaL0Irb1BwYUQvcHcwSERzdTBE?=
 =?utf-8?B?cUIycnYxQmJ2Tm1pc0F1VnkydVRmUEIrZ2kvWHJGS291ajF6YnNZZFcyTGY4?=
 =?utf-8?Q?MicLaRD/zVbv7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2o4UFdKd05CbFZJamFaWFh4NHhyY1c1amlKQWZLbnB3UzIvYi8rbnVDMmF0?=
 =?utf-8?B?TnpKYXM1dFdJaTJWeW5RZm1RUzl5SHFPc0RnbWswUFdZMzRQdW1uaUcrR3hw?=
 =?utf-8?B?WjVzcUdYem5RYitYaVhHRFptS01tRkNMa3BGSGk0NUh3Y09wcXcxQ3d2aTUw?=
 =?utf-8?B?QXB6YlBuRmZYd3VyRS92T25WNXJNd1hBSm0weWNoKzd1R2RTRU9NdUJKTlNa?=
 =?utf-8?B?SjJNcU5RbC9BbUM1b2tjODJMZ2trRGsxay8vL3M5dGo2QS9kUUdRcVcrVTh3?=
 =?utf-8?B?R0xDc3J4VEJoVVI3N0hVZXE5OUczWEkvcUl6bjRsS0pLREpUVGtpb3RVZ1VM?=
 =?utf-8?B?UWt3MXZLMlpPMFBFSndkbXZpczlEdG9RNUlGVTN3VUlxOVhSaEo3UXhROTlX?=
 =?utf-8?B?TEs2RGpTKzkxdWgyOSs5SjdwMmorVzVGenRUUXNzdjNSd1Jhby9GSmpGc2lk?=
 =?utf-8?B?RUY3NDErZ3NWdU85K2llNTcwNXVSNUYvK2sycUxPSjZwS1hlQ3oxSStjeSs1?=
 =?utf-8?B?U0g4aEhrN0JLdTh1RStCZlVwTEZBUUdpOEozZzJ3dERNWkxXaHdtVWIxejM4?=
 =?utf-8?B?QTNFRURxWUdUY0ttdHpmdC9ZL0NScit4VUJMRVIvSVkwc1V4UmdvWnhGOThq?=
 =?utf-8?B?dmJmcnN3dEFJUWM1WHdubVVmaFRleUhsZzZxSVBVR2lVZTdGeklwM1dtVWhM?=
 =?utf-8?B?dFAzTjhlSnYzZlhudkNMdU10NmovVGxLR1JVaExJbkJpaTU5U295TDRzdzNB?=
 =?utf-8?B?UHk5VWE3bmhGVnpYYUhycGFoVWxTMFEvUWd2Tmw5RnJNa3hsREpyVzNrOUhw?=
 =?utf-8?B?alk3T0JrUmZhQ2F4T2FWZDhPeldlaytxUFhwQ0t5akZFU1V6bmJvRGdpNWFv?=
 =?utf-8?B?L1J3MXZSNEcrYjA2YUhxZ1ZXNlZ2b0ZWa1RSNWZhbVcyODM1ajgyRThXRHlR?=
 =?utf-8?B?MEFEcFRldmZxcVF3eE5rV2RGTTlNVllJZGg4ZHBrUzVNMU5VN3QxNVVnUXlO?=
 =?utf-8?B?NEFVZzd5aDNHbS9QanVqdTNmUTZQZUZ6YStrTnZ0M1hGRnpqM1dpYUFEUzM1?=
 =?utf-8?B?YTk3cVFVcHNXRnBPUEZ5dFVaN3VPRmcrUDNIZFFXcUx6R3J1dzEzTXplZFlp?=
 =?utf-8?B?dHZxTzNVTjJvKzd5M1o1M3RQSm01K2haOGtPNEpkZ0FCc2Zta09OdFFCNXZ5?=
 =?utf-8?B?QTFCR2NuZTJad000MVNJYzh1anZrK0RTR2hBZDVhTlFwalN2OW1kTHpSUnZw?=
 =?utf-8?B?czVUZW4vZzJweVpkK1U1bTA3RkRsakhneXQ3MDhSUXIwMER0QndUc0FYSkZo?=
 =?utf-8?B?UXYwY2FEZDQrc2hRUXVQY2VaOVZ4MEpYQTZ2MFJ0R0hvQVErNlhvRGFzbE9T?=
 =?utf-8?B?dkVkM1Z3TE1mZ1V5UmpITG41Smc0WTQvZXI3TEptMWw2ODF3c1k1d094VHFk?=
 =?utf-8?B?dUh0cDRyZW5KRWczcm5TNVR2NFZ3QlE2aTl6TEV1Nmw0VE0vNkkrNzZYeFpG?=
 =?utf-8?B?RmxzaGFtRUkrR3pNam1CaE9JdkszZXNXOEx2c2VIRTJHaXQ4NW5ackFhUWow?=
 =?utf-8?B?YUsyK1NwazJMcllCOHZmY1RSSXIxdG11ZzR2NUpNNzVsaTZQcFZBaHR1cnRU?=
 =?utf-8?B?Zzl4WnhWUkQrbTJSMWxFa0huV0tXRXpUTFpza3JwanRrYWNPdy9aYlZJaTdR?=
 =?utf-8?B?ZVJuQ2lCT3NRVjlVbml5T040MnBhTjgvUVFMdEo3WkozQmJ2Y2dFU3hjWENq?=
 =?utf-8?B?Z1JoYm1pSWt0UGlwZ2R6cDMvN3pZZFJLTTQvNk0vSWRpR3pyQWdUckxkSUNr?=
 =?utf-8?B?V000ZU5VT2J4WitqVDZxdldWdXNHTStsaWN4Wk5uWXZRd3Q0NHUwazl3TjZU?=
 =?utf-8?B?VzMwZkdHbWxGQXk4T3dkRFRPWHhNL0RJZXlNZDFUZnpzb0YwYUNPbVFUMEhh?=
 =?utf-8?B?OFV0UXZRQnR5OWZ0R2RDdmo0R0hlRXdXdnhXY1ltNXN0bTFaY2dqSWNEeW9L?=
 =?utf-8?B?WUhRckJQMnV4OVBkMGNOV0RSRU80SmR4RG00d0FoeStzMXAyWW9ZM1lJZGlw?=
 =?utf-8?B?ZnhrcHJzZFhINTcvbTk3TUZ1ZlE0b0pZUzZWb09tZmZWaUVqdUhYajlRR28r?=
 =?utf-8?Q?ZuJpQ6EapwpZARuJzJQheV73k?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f6fa77-a766-48a2-e673-08dd9692af9f
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:04:51.4378 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yAPyb9lNO4/F9zr9buzRemvgc7dHL0dBj4W4nLNoZFOlhkl3wQrKoC9dC18XSUf48Xg1et7gYSK4cN9hHEj7ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0945
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



On 5/16/25 1:46 PM, Primoz Fiser wrote:
> Migrate to OF_UPSTREAM for phyCORE-i.MX93 since board can use upstream
> Linux kernel device-tree for phyBOARD-Segin-i.MX93.
> 
> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/dts/Makefile                  |   3 +-
>   arch/arm/dts/imx93-phyboard-segin.dts  | 117 -----------------------
>   arch/arm/dts/imx93-phycore-som.dtsi    | 126 -------------------------
>   arch/arm/mach-imx/imx9/Kconfig         |   1 +
>   board/phytec/phycore_imx93/MAINTAINERS |   2 -
>   configs/imx93-phycore_defconfig        |   2 +-
>   6 files changed, 3 insertions(+), 248 deletions(-)
>   delete mode 100644 arch/arm/dts/imx93-phyboard-segin.dts
>   delete mode 100644 arch/arm/dts/imx93-phycore-som.dtsi
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index 32b698a7f411..976dbda48c37 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -918,8 +918,7 @@ dtb-$(CONFIG_ARCH_IMX8M) += \
>   	imx8mq-librem5-r4.dtb
>   
>   dtb-$(CONFIG_ARCH_IMX9) += \
> -	imx93-var-som-symphony.dtb \
> -	imx93-phyboard-segin.dtb
> +	imx93-var-som-symphony.dtb
>   
>   dtb-$(CONFIG_ARCH_IMXRT) += imxrt1020-evk.dtb \
>   	imxrt1170-evk.dtb \
> diff --git a/arch/arm/dts/imx93-phyboard-segin.dts b/arch/arm/dts/imx93-phyboard-segin.dts
> deleted file mode 100644
> index 85fb188b057f..000000000000
> --- a/arch/arm/dts/imx93-phyboard-segin.dts
> +++ /dev/null
> @@ -1,117 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> - * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> - * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> - *
> - * Product homepage:
> - * phyBOARD-Segin carrier board is reused for the i.MX93 design.
> - * https://www.phytec.eu/en/produkte/single-board-computer/phyboard-segin-imx6ul/
> - */
> -/dts-v1/;
> -
> -#include "imx93-phycore-som.dtsi"
> -
> -/{
> -	model = "PHYTEC phyBOARD-Segin-i.MX93";
> -	compatible = "phytec,imx93-phyboard-segin", "phytec,imx93-phycore-som",
> -		     "fsl,imx93";
> -
> -	chosen {
> -		stdout-path = &lpuart1;
> -	};
> -
> -	reg_usdhc2_vmmc: regulator-usdhc2 {
> -		compatible = "regulator-fixed";
> -		enable-active-high;
> -		gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		regulator-name = "VCC_SD";
> -	};
> -};
> -
> -/* Console */
> -&lpuart1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_uart1>;
> -	status = "okay";
> -};
> -
> -/* eMMC */
> -&usdhc1 {
> -	no-1-8-v;
> -};
> -
> -/* SD-Card */
> -&usdhc2 {
> -	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> -	pinctrl-0 = <&pinctrl_usdhc2_default>, <&pinctrl_usdhc2_cd>;
> -	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_cd>;
> -	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_cd>;
> -	bus-width = <4>;
> -	cd-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
> -	no-mmc;
> -	no-sdio;
> -	vmmc-supply = <&reg_usdhc2_vmmc>;
> -	status = "okay";
> -};
> -
> -&iomuxc {
> -	pinctrl_uart1: uart1grp {
> -		fsl,pins = <
> -			MX93_PAD_UART1_RXD__LPUART1_RX		0x31e
> -			MX93_PAD_UART1_TXD__LPUART1_TX		0x30e
> -		>;
> -	};
> -
> -	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x31e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_cd: usdhc2cdgrp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_default: usdhc2grp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CLK__USDHC2_CLK		0x179e
> -			MX93_PAD_SD2_CMD__USDHC2_CMD		0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x138e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x138e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x138e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x139e
> -			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_100mhz: usdhc2grp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CLK__USDHC2_CLK            0x179e
> -			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x138e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x138e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> -			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> -		>;
> -	};
> -
> -	pinctrl_usdhc2_200mhz: usdhc2grp {
> -		fsl,pins = <
> -			MX93_PAD_SD2_CLK__USDHC2_CLK            0x178e
> -			MX93_PAD_SD2_CMD__USDHC2_CMD            0x139e
> -			MX93_PAD_SD2_DATA0__USDHC2_DATA0        0x139e
> -			MX93_PAD_SD2_DATA1__USDHC2_DATA1        0x139e
> -			MX93_PAD_SD2_DATA2__USDHC2_DATA2        0x139e
> -			MX93_PAD_SD2_DATA3__USDHC2_DATA3        0x139e
> -			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT    0x51e
> -		>;
> -	};
> -};
> diff --git a/arch/arm/dts/imx93-phycore-som.dtsi b/arch/arm/dts/imx93-phycore-som.dtsi
> deleted file mode 100644
> index 88c2657b50e6..000000000000
> --- a/arch/arm/dts/imx93-phycore-som.dtsi
> +++ /dev/null
> @@ -1,126 +0,0 @@
> -// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> -/*
> - * Copyright (C) 2023 PHYTEC Messtechnik GmbH
> - * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner <c.stoidner@phytec.de>
> - * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
> - *
> - * Product homepage:
> - * https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
> - */
> -
> -#include <dt-bindings/leds/common.h>
> -
> -#include "imx93.dtsi"
> -
> -/{
> -	model = "PHYTEC phyCORE-i.MX93";
> -	compatible = "phytec,imx93-phycore-som", "fsl,imx93";
> -
> -	reserved-memory {
> -		ranges;
> -		#address-cells = <2>;
> -		#size-cells = <2>;
> -
> -		linux,cma {
> -			compatible = "shared-dma-pool";
> -			reusable;
> -			alloc-ranges = <0 0x80000000 0 0x40000000>;
> -			size = <0 0x10000000>;
> -			linux,cma-default;
> -		};
> -	};
> -
> -	leds {
> -		compatible = "gpio-leds";
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&pinctrl_leds>;
> -
> -		led-0 {
> -			color = <LED_COLOR_ID_GREEN>;
> -			function = LED_FUNCTION_HEARTBEAT;
> -			gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "heartbeat";
> -		};
> -	};
> -};
> -
> -/* Ethernet */
> -&fec {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_fec>;
> -	phy-mode = "rmii";
> -	phy-handle = <&ethphy1>;
> -	fsl,magic-packet;
> -	assigned-clocks = <&clk IMX93_CLK_ENET_TIMER1>,
> -			  <&clk IMX93_CLK_ENET_REF>,
> -			  <&clk IMX93_CLK_ENET_REF_PHY>;
> -	assigned-clock-parents = <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> -				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> -				 <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>;
> -	assigned-clock-rates = <100000000>, <50000000>, <50000000>;
> -	status = "okay";
> -
> -	mdio: mdio {
> -		clock-frequency = <5000000>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		ethphy1: ethernet-phy@1 {
> -			compatible = "ethernet-phy-ieee802.3-c22";
> -			reg = <1>;
> -		};
> -	};
> -};
> -
> -/* eMMC */
> -&usdhc1 {
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_usdhc1>;
> -	bus-width = <8>;
> -	non-removable;
> -	status = "okay";
> -};
> -
> -/* Watchdog */
> -&wdog3 {
> -	status = "okay";
> -};
> -
> -&iomuxc {
> -	pinctrl_fec: fecgrp {
> -		fsl,pins = <
> -			MX93_PAD_ENET2_MDC__ENET1_MDC			0x50e
> -			MX93_PAD_ENET2_MDIO__ENET1_MDIO			0x502
> -			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0		0x57e
> -			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1		0x57e
> -			MX93_PAD_ENET2_RXC__ENET1_RX_ER			0x5fe
> -			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL	0x57e
> -			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0		0x50e
> -			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1		0x50e
> -			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL	0x50e
> -			MX93_PAD_ENET2_TD2__ENET1_TX_CLK		0x4000050e
> -		>;
> -	};
> -
> -	pinctrl_leds: ledsgrp {
> -		fsl,pins = <
> -			MX93_PAD_I2C1_SDA__GPIO1_IO01		0x31e
> -		>;
> -	};
> -
> -	pinctrl_usdhc1: usdhc1grp {
> -		fsl,pins = <
> -			MX93_PAD_SD1_CLK__USDHC1_CLK		0x179e
> -			MX93_PAD_SD1_CMD__USDHC1_CMD		0x1386
> -			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x138e
> -			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x1386
> -			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x138e
> -			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x1386
> -			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x1386
> -			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x1386
> -			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x1386
> -			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x1386
> -			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x179e
> -		>;
> -	};
> -};
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index 0fd82dc08110..e6cafdcd8133 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -73,6 +73,7 @@ config TARGET_PHYCORE_IMX93
>   	bool "phycore_imx93"
>   	select IMX93
>   	select IMX9_LPDDR4X
> +	imply OF_UPSTREAM
>   	select OF_BOARD_FIXUP
>   	select OF_BOARD_SETUP
>   
> diff --git a/board/phytec/phycore_imx93/MAINTAINERS b/board/phytec/phycore_imx93/MAINTAINERS
> index 718f89a084a2..7393061707de 100644
> --- a/board/phytec/phycore_imx93/MAINTAINERS
> +++ b/board/phytec/phycore_imx93/MAINTAINERS
> @@ -3,8 +3,6 @@ M:      Mathieu Othacehe <m.othacehe@gmail.com>
>   R:      Christoph Stoidner <c.stoidner@phytec.de>
>   W:      https://www.phytec.eu/en/produkte/system-on-modules/phycore-imx-91-93/
>   S:      Maintained
> -F:      arch/arm/dts/imx93-phyboard-segin.dts
> -F:      arch/arm/dts/imx93-phycore-som.dtsi
>   F:      arch/arm/dts/imx93-phyboard-segin-u-boot.dtsi
>   F:      board/phytec/phycore_imx93/
>   F:      board/phytec/common/imx93_som_detection.c
> diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
> index 7187fd708333..66a431244b0e 100644
> --- a/configs/imx93-phycore_defconfig
> +++ b/configs/imx93-phycore_defconfig
> @@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x10000
>   CONFIG_ENV_OFFSET=0x700000
>   CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
>   CONFIG_DM_GPIO=y
> -CONFIG_DEFAULT_DEVICE_TREE="imx93-phyboard-segin"
> +CONFIG_DEFAULT_DEVICE_TREE="freescale/imx93-phyboard-segin"
>   CONFIG_AHAB_BOOT=y
>   CONFIG_TARGET_PHYCORE_IMX93=y
>   CONFIG_OF_LIBFDT_OVERLAY=y

