Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBE3E95363
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 09:50:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D0D83A24;
	Wed,  4 Feb 2026 10:50:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="bqHjYq+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C546C83A36; Wed,  4 Feb 2026 10:50:00 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF478839D5
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 10:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6MWYpiRQs2nWT95L33E3JpXUcqvSUkzQbQNdLkWZrAK0dXFg+yR877owXt9WBFeZh77LV5XxJDwnFLEtY+WNxvpqSooOjN5Zk3ZzqMVkQ1DApcPEU8PVk15PbhJnrPQdxv5ufmagpLkETyAj0wYAwKXr8uRvIRsfkdyRMCnKIPTKf8V8BNNRkqAZgG1ogJkQjm/Tct1wAp2jp9F77NrXbZ7VizEky1E3WKBt21WF230h4tpm05cgpwcdfyUDcnk/e+ZD/t7T9UYCtpifWkXDvXyPYmKVhifIbh5G0QND5z/RYvUNOCutDzZRjrIQKMIVSzr89IKeVbhD8cJyBLFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCVgDxw0OVeDPWvyBMie7PyCyPYyWuz0xcBfdde1Jdg=;
 b=y3p0UZaKlVxuhXhKoKk+09Ztx/d+iw37nT3ygl/7U8I17PiTFqZzSI39/kvjpaivjOHO+Q2sDv/BwsWolv8iCjYxQ0qEqRZ3t7PJJLxAMRdxlWJk4Ha3AE2ioDlkw/CpacfwdYYTi0M/B7ewLvf/ppv11FGB39dK7KH4BVjtlUu/kLEz7EvK2MH7hs8KWVebrBepqQVh5LMiSVjDHo5tj8TL6n1PKSpIaStQIsltQG1UT5rVE0iCvlmDDfCp435zQg1eONqgL23iopaiqdL/DOZqxWXt4aO+quTojldMXgDU4F2R6mf7ViwXrTz4IogKs4N95OYywn4PJQlObbUjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCVgDxw0OVeDPWvyBMie7PyCyPYyWuz0xcBfdde1Jdg=;
 b=bqHjYq+dzFOUZX+nW5eMUjizLKpruqA9d2Hs/24Il/rWRpuDqmn8a5PsLyvNTcOyIkHCLjdy/IxmHNaMEIB40glnwoMWo1Ko/K6Od5GoEg87LZX+5MPMvi2bmY9xWooswxaCl7DBlKKgehWEkMYNUcx3nwmfGJcDTw9CzajUJbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB9204.eurprd04.prod.outlook.com (2603:10a6:102:227::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 09:49:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 09:49:54 +0000
Message-ID: <73085ea7-6207-4a60-871d-daf0620f4df7@cherry.de>
Date: Wed, 4 Feb 2026 10:49:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: EXTERNAL - [PATCH v4 6/6] test: binman: Add test for pkcs11
 signed capsule
To: Wojciech Dubowik <Wojciech.Dubowik@mt.com>, Simon Glass <sjg@chromium.org>
Cc: Simon Glass <simon.glass@canonical.com>, u-boot@lists.denx.de,
 trini@konsulko.com
References: <20260120081206.251544-1-Wojciech.Dubowik@mt.com>
 <20260120081206.251544-7-Wojciech.Dubowik@mt.com>
 <dc9c88ee-d5a2-49f9-b8d6-629f6ad01c36@cherry.de> <aXDJ4PrbO2eL63B-@mt.com>
 <53afb4f1-ff00-40e7-8aac-3d0bd1275450@cherry.de>
 <CAL6eLbp5DjRMenAkYMH6zU=4NOakhk_7W+aYDeB8MjLtGXgsfg@mail.gmail.com>
 <74ead874-927c-4ece-aafa-808cd054ef3a@cherry.de>
 <CAFLszTjH=Yv72oDucXJHyhGrEvtRLRq_7EO8nRd2B2K6TttiRw@mail.gmail.com>
 <aYGvNb33Eoozx4zk@mt.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <aYGvNb33Eoozx4zk@mt.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::16) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 143f9665-d750-4cff-49c9-08de63d2bfd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTBJVk5td3JTSVJtMURSN2YzQjlVV09xNnN0czJ0S1kveU8yNmJQNS80ZzBG?=
 =?utf-8?B?Y2J4T0ZqdlJMQmcvdy9Vd1ZENEZvay84ekZWMjM5enE2SEhzM2JvU3RDeTBh?=
 =?utf-8?B?b29Fb0plZDFkcUVvVGVwaFFYMHBFVnFPcVJldHBxNlRJQnlLeno4VkxnZXJK?=
 =?utf-8?B?cmpLeGVMaHlzR0o2TEt6c3N1REFubUd5ZVFoaUd4Q1JRRHEvUExiUWZYWGF1?=
 =?utf-8?B?d3orQjE3TFRZQ2Z4MnltK3hDQ1U0cHF5ZHpybWF1dnFOVER2VnE1UXFacCtJ?=
 =?utf-8?B?MFVNNzBVbE9tazBEYXFDMitJQk5EMmhwUXdzank5YTdLMHlMSmVxRktSVk9k?=
 =?utf-8?B?R21rc0c1c24vdXhGdFdLSi90aGR1aytGNjF3aGcyMFVrTzhZcGZtWXJvWSs4?=
 =?utf-8?B?UmpQTVF3dFNTYUFJNVVRcFE0anRaeld3YjdhMVR0OHJIWmxTakFFbktNbkNq?=
 =?utf-8?B?ajF1K001UlNrSm96ZGg5aTBNU3RoYVhIL2pKMUJMYWJXRTViZ1g4eVJ5SCt3?=
 =?utf-8?B?RnFjR2FYRGd5UWFuSjFrVytIUUltWE5qTjBpTHJXZzlLdUliOVBQcXRuSG1s?=
 =?utf-8?B?UmRMOHp2SjFXRXNuUnpuV2tsZnVXVnpwNTZsWCtSZ1o0RnVxSG5TMVcrYUJG?=
 =?utf-8?B?M3Z1Z1ZQdTNCUVlLZ2tTZkZqZUdJY3RqUSszTENIODM5eG9tM0NsQU5RQmpH?=
 =?utf-8?B?MVRFN0VZVFhnSmUzSldqN2h0aGpvMlViZmwrOC9xcXgwZzloTjRNcm8yWWdZ?=
 =?utf-8?B?cjdibXQydzZUQUZJS0ZYeHF4Skk1TTAweDVsQThpTTdZMlJKVnlLWFlhTjhB?=
 =?utf-8?B?WGxUVDlRMndRbVQ0dXBzUHc5eERWYlRYNjJxcXlNWTZyZmJaSUdzWFh5NUVU?=
 =?utf-8?B?REE2cm5lbVBmeGtWL0N6VU1uZnIyQXVDcGpQbVpTNENRM0Qrcmt4bFRwTjg4?=
 =?utf-8?B?OE4vdndiQXJYMFU4KzdSZ1oyMlNDU21RQUJhNlNNblhUUFR6ZG9qTnpxWGtN?=
 =?utf-8?B?VHZQNW1VWGxUaHF0RkNKVzUrUEhrNVZMdEI5aVh4Tm5oWVNRcXpYbnBiMUcy?=
 =?utf-8?B?Ky9tcGd0a011YytTQU5mMDZKaDNWekRBUVZQT1BKZ1hrUHNrWk0yRTFEZ1N5?=
 =?utf-8?B?bXMzeHJkSDdHNkx0c3FiaXo4QWRPbnVSaTdDN3F6S3BFcmRCVVJzYURTdDEv?=
 =?utf-8?B?TUVNWFBIMzdObVl5bElxMkh3OFdLcGt4UElwVW5JdXBxU2J2VWhCL1JSSFFR?=
 =?utf-8?B?TUFhbjZVdExrcHA0QjRySW51WGdMOTdpZ1FObmEvZ3RmdHBCNVVxR015Y0py?=
 =?utf-8?B?eUNWb2I0UVJTdGFLM1V1SE1hMlFKRHRpMVNjTU5ocTU4UkRTV05Nc1diWnpp?=
 =?utf-8?B?akhjUHU5UmJwKzFadFg5L1lOUno0VlNmODRQaHBkTGlDSS9FMWZFTWFibTdE?=
 =?utf-8?B?dzJmbHk2Q2txQWh0OGNsbkZYNEEvcE14RGtIakVGY1BHWlczRGFCcXRLQzNv?=
 =?utf-8?B?R1Uvek90d1pCUkg0ME81K2p1dE5uTFZoeFhVRkNweGM3Y1FuNmRoNG9HVUYy?=
 =?utf-8?B?bkpNMnNBZlJYVWVsYjFUWXkrRE5uUUtLV1plR1FFbDd3bDFwTWl5RVljOCtG?=
 =?utf-8?B?KzJXcFdDQThrdTRaaTlXdEtoVXBFWG5yQ2dJZHEySHF0cEVITnNDU24zZ0wz?=
 =?utf-8?B?VzBQU0hoNnI1aTV0VXg2ZXFYbm92Zk1SZ0ZsZzVQbURRYnhVYndVd0JUZUFl?=
 =?utf-8?B?VGl2RlhmKyt2emZxVmhzcW01V2Q2R1ZHdCtmWGx0VWFOMnlhRjN1RTZJaG5q?=
 =?utf-8?B?NVBVVGtERmREaFhHaVJmR3FMdVZUaUNQUFBuRzZQUWxZdnlvazNIc0JXMjg1?=
 =?utf-8?B?UG1SNkJrSEZ6aC9kbDF0ZzFWbXdRU3VZRC9YVlZjdFNENjByVm1ZZ3RYNE9X?=
 =?utf-8?B?Y1Vwb1ArVWNVZ3orOExYdlFDSFZjaXpJNGhUTnl4a0QzVC9RMlpyanEraFVV?=
 =?utf-8?B?dVBjb1hBcUJFbFZKU1dJS29DbXZ4Z2ZCUUs3dUZtZ2FVL3NKbEE1blQrVElY?=
 =?utf-8?B?YVhHeHBqSTFVdTJPS2hKUC8wUGNGbWs5b29wV0pmZ01DU2JycWxrdGlaYWhw?=
 =?utf-8?Q?a9wY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(10070799003)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0F4a0lWUFozWHMxZk1XaU1udm9aUHREdHU3dEpFajYraUkrTnQ4dVBTWEJT?=
 =?utf-8?B?bjVZd2hVMTUzRUJHUDErVFcwaytVQWNSVHhsWUNzT0QxSFI2c3Zwck9QR3Iz?=
 =?utf-8?B?WldSR3FZYkFoODByMkloSExMSC95Tmd5SklWVUN4V2xqd2Z1Y1FGcnBoVm1v?=
 =?utf-8?B?QjIybFU1Mzg5WnlOZkN3OWNqMXhKYUE5WUt4Mi8vV21YK2kvY1RRWFRodDZa?=
 =?utf-8?B?SGFxZXVDWjVTMnMzZ0o5Kys0Ym45bWNUaVFDSFhwQm11RVJPSXVFOG1nS2g3?=
 =?utf-8?B?Q1dLbzYzZmNEeDdMMzNMWnViZ0xDd2dXa0FPc0tWN3A3czRvejRrY1paK3FB?=
 =?utf-8?B?UlUrNUJsS3dSSWkxaFpaVzVqamdUb2JjMXlVbzRaV2FsL1NCSmZhZWNLMFJn?=
 =?utf-8?B?YUk1NGJvM0xBK1lSVWtYQ1hGV1Z3NFhqVUR6dmp5YnRicUZhQTJsb1JIbFI2?=
 =?utf-8?B?bHNVUUZ3bGdMbm52N0FzSHZpcjlabUZPK3loa1dlQjdhYXFMR3NNbnVDSDJV?=
 =?utf-8?B?UEFacEE0L1phbk4xaURPQUVHN0pyanVsMVV0TlA5R1U2cGQvd3Y1YzNFeGdz?=
 =?utf-8?B?V2tyenZxeVdUVFg1eEFHR2Q3ZTJrc0RWNGc5c2JIRUZ5UHdoMUxiTVNaTG4z?=
 =?utf-8?B?b3lVY2p5ZVhRc1VpeTMwdnRHVldNdXJ5ejBnQTFzbzRRbU12WW9mamN0OGM4?=
 =?utf-8?B?d0ZVbnFZcnVpRkFYRm1IcFdWSWJqUmt1blBUTE05M0M2K2F6QndvaHhWOFFl?=
 =?utf-8?B?bGVxQnR2ZnBmNC9tWWk0RmJqdXgvTnlIeTFqVXNveTFmVm9qZ2kyRStDR280?=
 =?utf-8?B?dEtMY1lPR3E0VW5WNGpBQ0ltaWsySWFzejlsa0FzTlRwclFGamNHbGhSWUpx?=
 =?utf-8?B?VVRxZ3V6STlVODZybTF4TE50OE5tWHR5MXRNa3N6dUhSNXRHZE5MeXZCWWtF?=
 =?utf-8?B?cXRZbnMySUcwaDFPQSt0WFcyMjd0d3dXczQ1d2ZuSENQTnc1WEV5VUVwdkc4?=
 =?utf-8?B?M0tISCtKVnJjV0NicWpIT29QbWc3b3dhUkFXdERJR0M2b0ZLeVhWQUFpYnA3?=
 =?utf-8?B?TElzcFJ2TXk5U0NIWkFieXphb1Rpdm5FNFdGOXZHY29HelJtc1BFVEhpeUxj?=
 =?utf-8?B?R3BXN1JSQ0cyN0dnRGVCOFJubHdFaWZ6UGlmV0RHcCt4WVppeFBRR2FJMzhQ?=
 =?utf-8?B?NVBOdHYvREpiazhobk9kZ0RxVmZXRTZRb1ZKOWVXNGhtNlFXSnFrYjQ2VldK?=
 =?utf-8?B?cElxYTcvc0xwYldKMVhGSldUYXZXb1Q3WCtjcFVkd3JybTFRenlNU1YzWEFt?=
 =?utf-8?B?bEJxeUpSZ0U0ZGxoWmZsOVdXUjVPUUJmclIzcThkdGZHUXRkaTZNS2ovZHJZ?=
 =?utf-8?B?Z2NSYlhIOVgwUHNxV1hoNkh5akVCTDFwcU82NTBxeDlwREppTjZ4V1JMNjkr?=
 =?utf-8?B?b2F6bzVnM1ZTcmVBVDNJeE41c0Ztd1VBZXZqUVNLSzFGVW5leTdDb09LTHMv?=
 =?utf-8?B?RHd1Z2h5bmhBVUhiZ05kcEV6UmRqd0VQeVhEanA1bWd1SzNuZGhuZTBzTkox?=
 =?utf-8?B?eG9EMWpqOTZTR3QyUFQ1b3dYOGZTUHFMU2F3bTBQbjZXMUltbUpvWit4Vjhp?=
 =?utf-8?B?TXpqMUpMVVNabmp6Y21mSnp5cHA1emhlcmMvZUU3M0hnbU50MDdvY3BOVzBP?=
 =?utf-8?B?OFZZSlJ5TzY5c0hrNDc2RU12UGZleDhOaThzeVhUQ2xTRDdXdTVuQ29jVFlh?=
 =?utf-8?B?SUZUR3NYdUYwZ0dsbnp3NjFzalRqWlNZcUxoWmVRdkROUGtST0dzMVZ5OTFS?=
 =?utf-8?B?Q1RocWM2TVlSR2Zua1J4RzdqeWpWZmhQWjVRTGVrd3RiRTBRMjkvOWxYczdl?=
 =?utf-8?B?bk04dzJ0T2xrWFVBSEszWkwwc0M5WlJraEI2Zmd2ZGJOd3hMZ1pYRXp1eUVZ?=
 =?utf-8?B?UWxrZFRKY21FYmFkU0JnL0R4d1Z1aVRiTWxsZ2lTQWZJVHd4blZRQ2VaRzZv?=
 =?utf-8?B?YmtjcWxhS2wwN1E1ejRhZEtxdWg0TmllYm81TDZHaER5SmFVcENlUS9KRXYz?=
 =?utf-8?B?ckRtc0RubUtqY0h5L1RNdVZRcFVaSXB4SXlScUVYUUgrd2FidTRsQTVZaktN?=
 =?utf-8?B?ZENVVS9vWm4vRm1WN0ZEVnlCTDB1cFdPZU90M04vR0E5ZFMxSkhkYWUrY3A4?=
 =?utf-8?B?L0Nzb2VUZVlvdGFWYjRTYzYyM3dRODJKMFdYa0wydXpLWlVNYndHTFdQUDNV?=
 =?utf-8?B?cWI4aGRDd2YwUnhLancwWGZuWGh2aTB3UXQ1Qi9DbjdpVlNycUtqQ21xZytn?=
 =?utf-8?B?Yi9pY005VUxwdVlFWmR1RWVtYjJPZStnd0NnRFVDcUVvMDBIejhiS3gxa0Np?=
 =?utf-8?Q?1ortnejWd9gJfC+HxMYgwV9cikbDxlQVH0u5q?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 143f9665-d750-4cff-49c9-08de63d2bfd5
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 09:49:54.7035 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7l92jqOodZRL6cmwvJZXBh4J3FsuATg9Aggo2puWHnWSn5/5LTtX2lSJvVp3K7H/r84sMU0PfuKvdAz9+bKCKHH0N2T4aUdeTbCgtlwCA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9204
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

Hi Wojciech,

On 2/3/26 9:17 AM, Wojciech Dubowik wrote:
> On Tue, Jan 27, 2026 at 04:00:44PM +1300, Simon Glass wrote:
> Hi Simon,
>> Hi Quentin,
>>
>> On Tue, 27 Jan 2026 at 00:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>
>>> Hi Simon,
>>>
>>> On 1/22/26 11:46 PM, Simon Glass wrote:
>>>> Hi,
>>>>
>>>> On Thu, 22 Jan 2026 at 02:06, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>>
>>>>> Hi Wojciech,
>>>>>
>>>>> On 1/21/26 1:43 PM, Wojciech Dubowik wrote:
>>>>>> On Tue, Jan 20, 2026 at 04:53:04PM +0100, Quentin Schulz wrote:
>>>>>> Hello Quentin,
>>>>>>> Hi Wojciech,
>>>>>>>
>>>>>>> On 1/20/26 9:12 AM, Wojciech Dubowik wrote:
>>>>> [...]
>>>>>>>> +        os.environ['SOFTHSM2_CONF'] = softhsm2_conf
>>>>>>>
>>>>>>> This is wrong, you'll be messing up with the environment of all tests being
>>>>>>> run in the same thread. You must use the "with
>>>>>>> unittest.mock.patch.dict('os.environ'," implementation I used in
>>>>>>> testFitSignPKCS11Simple.
>>>>>>
>>>>>> Well, I have done so in my V2 but has been commented as wrong by the
>>>>>> first reviewer. I will restore it back.
>>>>>>
>>>>>
>>>>> Indeed, I see Simon asked you to do this in v2 and I missed it. It isn't
>>>>> how we should be doing it.
>>>>>
>>>>> This is likely fine on its own because there's only one test that is now
>>>>> modifying os.environ's SOFTHSM2_CONF but this will be a problem next
>>>>> time a test wants to modify it. I actually hit this issue when
>>>>> developing the PKCS11 fit signing tests as I had two tests modifying the
>>>>> environment.
>>>>>
>>>>> The only trace of it left is the changelog in
>>>>> https://lore.kernel.org/u-boot/20251121-binman-engine-v3-0-b80180aaa783@cherry.de/
>>>>>
>>>>> """
>>>>> - fixed issues due to modification of the environment in tests failing
>>>>>      other tests, by using unittest.mock.patch.dict() on os.environ as
>>>>>      suggested by the unittest.mock doc,
>>>>> """
>>>>>
>>>>> and you can check the diff between the v2 and v3 to check I used to
>>>>> modify the env directly but now mock it instead.
>>>>>
>>>>> Sorry for not catching this, should have answered to Simon in the v2.
>>>>
>>>> In practice we try to set values for various which are important, so
>>>> future tests should explicitly delete the var if needed. But I am OK
>>>
>>> This is not working. See this very simple example (too lazy to use
>>> threading.Lock so synchronization done via time.sleep instead):
>>>
>>> """
>>> #!/usr/bin/env python3
>>>
>>> import os
>>> import time
>>> import threading
>>>
>>>
>>> def thread_func(n):
>>>       if n == 1:
>>>           time.sleep(1)
>>>       print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
>>>       if n == 1:
>>>           time.sleep(1)
>>>       print(f'Thread {n} set environ var FOO to foo{n}')
>>>       os.environ['FOO'] = f'foo{n}'
>>>       if n == 0:
>>>           time.sleep(5)
>>>       print(f'Thread {n} read environ var FOO={os.environ["FOO"]}')
>>>       if n == 0:
>>>           print(f'Thread {n} removes environ var FOO')
>>>           del os.environ["FOO"]
>>>       else:
>>>           time.sleep(10)
>>>           print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>>>
>>>
>>> threads = []
>>>
>>> os.environ["FOO"] = "foo"
>>>
>>> for i in range(0, 2):
>>>       t = threading.Thread(target=thread_func, args=(i,))
>>>       threads.append(t)
>>>
>>> for t in threads:
>>>       t.start()
>>>
>>> for t in threads:
>>>       t.join()
>>>
>>> """
>>>
>>> This results in:
>>>
>>> """
>>> Thread 0 read environ var FOO=foo
>>> Thread 0 set environ var FOO to foo0
>>> Thread 1 read environ var FOO=foo0
>>> Thread 1 set environ var FOO to foo1
>>> Thread 1 read environ var FOO=foo1
>>> Thread 0 read environ var FOO=foo1
>>> Thread 0 removes environ var FOO
>>> Thread 1 read environ var FOO=None
>>> """
>>>
>>> You see that modification made to os.environ in a different thread
>>> impacts the other threads. A test should definitely NOT modify anything
>>> for another test, especially not when it's already running.
>>>
>>> So now, I implemented mocking instead (like in my tests for PKCS11 in
>>> tools/binman/ftest.py) because I know it works.
>>>
>>> See:
>>>
>>> """
>>> #!/usr/bin/env python3
>>>
>>> import os
>>> import time
>>> import threading
>>> import unittest.mock
>>>
>>>
>>> def thread_func(n):
>>>       if n == 1:
>>>           time.sleep(1)
>>>       print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>>>       if n == 1:
>>>           time.sleep(1)
>>>       with unittest.mock.patch.dict('os.environ',
>>>                                     {'FOO': f'foo{n}'}):
>>>           print(f'Thread {n} set environ var FOO to foo{n}')
>>>           if n == 0:
>>>               time.sleep(5)
>>>           print(f'Thread {n} read mocked environ var
>>> FOO={os.environ.get("FOO")}')
>>>           if n == 1:
>>>               time.sleep(6)
>>>       print(f'Thread {n} read environ var FOO={os.environ.get("FOO")}')
>>>
>>>
>>> threads = []
>>>
>>> for i in range(0, 2):
>>>       t = threading.Thread(target=thread_func, args=(i,))
>>>       threads.append(t)
>>>
>>> for t in threads:
>>>       t.start()
>>>
>>> for t in threads:
>>>       t.join()
>>> """
>>>
>>> Lo and behold, it.... does NOT work???????
>>>
>>> I get:
>>>
>>> """
>>> Thread 0 read environ var FOO=None
>>> Thread 0 set environ var FOO to foo0
>>> Thread 1 read environ var FOO=foo0
>>> Thread 1 set environ var FOO to foo1
>>> Thread 1 read mocked environ var FOO=foo1
>>> Thread 0 read mocked environ var FOO=foo1
>>> Thread 0 read environ var FOO=None
>>> Thread 1 read environ var FOO=foo0
>>> """
>>>
>>> I've read that os.environ isn't thread-safe, due to setenv() in glibc
>>> not being thread-safe:
>>> https://sourceware.org/glibc/manual/latest/html_node/Environment-Access.html#Environment-Access-1
>>>
>>> """
>>> Modifications of environment variables are not allowed in multi-threaded
>>> programs.
>>> """
>>>
>>> I'm not sure if this applies to any other Python implementation than
>>> CPython? But that is likely the one that most people are using.
>>>
>>> So... In short, I'm at a loss, no clue how to fix this (if it is even
>>> fixable). The obvious answer is "spawn multiple processes instead of
>>> multiple threads" but I can guarantee you, you don't want to be going
>>> this route as multiprocessing is a lot of headaches in Python. We could
>>> have the Python thread spawn a subprocess which has a different
>>> environment if we wanted to (via the `env` command for example), but
>>> that means not using binman Python API, rather its CLI. We could have
>>> bintools accept an environment dict that needs to be passed via the
>>> `env` command or the `env` kwargs of subprocess.Popen().
>>>
>>> Headaches, headaches.
>>
>> I would argue that requiring a particular environment var for a test
>> is not a great idea. Better to pass an argument through the call stack
>> and have the external program run with a new environment containing
>> what is needed.
> Would it be ok to call softhsm utils with softhsm_conf like
> SOFTHSM2_CONF=... softhsm2-util? Then we don't have to mock environment.
> I would still have to set SOFTHSM install dir location with the env variable
> for mkeficapsule in binman generation. I guess it doesn't affect other
> tests as we don't need to change it.
> 

I would recommend to hook this to command.run_pipe(..., env=env, ...) in 
tools/binman/bintool.py:Bintool:run_cmd_result() if possible, such that 
it isn't bintool-specific.

We already override the env with the path to our tools, so we could 
simply extend it. I guess we could have a Bintool:set_env() or 
add_to_env() and store the result in some variable (have 
tools.get_env_with_path() in it by default in the object init?) and have 
run_cmd_result() use the bintool object's self.env dict insted of 
calling tools.get_env_with_path()? Then in ftest.py, after b = 
bintool.Bintool.create(), b.add_to_env({'SOFTHSM2_CONF': '...'})?

I'm not sure, maybe there's a reason tools.get_env_with_path() is called 
at the moment the command needs to be run and not when the bintool is 
created, in which case maybe store extra_env and update the env returned 
by tools.get_env_with_path() with that?

Cheers,
Quentin
