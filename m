Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69DAC52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 05:05:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3022B882F0;
	Sun, 18 Aug 2024 07:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="DfbX8Kqz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23552888BE; Sat, 17 Aug 2024 21:25:41 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20717.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::717])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F101A8811A
 for <u-boot@lists.denx.de>; Sat, 17 Aug 2024 21:25:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2ZvMAe8PsRsWrP0Rvem8HscB+h2wYYZwEeTuhaTvBZN0WVG9LtcvhmUbb/nGFIOd2zA1yj98Oj/4R6mIkYkuIMfVpSxF4QbkmIBzgU6u2YwkB5ndcjjM86Kfm2tTp2xUX1F1jY2PGeVR9gqTtcXSbD8LZtjxO0tNHDkfLLpJlDXyTutoG6r3he/dbXAP6KYjseQrPlzssOYWmLRjXJI5V3PUDIDUEpB94MoqseUq/24kNQSzKn4r/7YkvmoJmRmMv9mOxujBWvYuM/4EomuCRTuKIDPOhl+nCyBAQomAIauPHWUVsME4zcBraaiMI42NiSt6x4GUewhqqRWYeicrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkFX3o00ZgwHYwHcgaRLJVrPvPP/0QYDmc3C8wSGF5E=;
 b=jODpIFStLA+mvTSGDtzlD8wwmgzwraW+R2FuwZfgtsChz4wcDk+6jhgXwI5P2ua1pGgrih20l4rHGqD8wVi+p0GLrg+snFlV8qliPTWjVo29Q5ES7o4li1Y/7NBH5IMuGFmQ2TG9AMP7nnnFIrqkvzuaM9pPAYOE+LnOYugSi8wDhZvGtwSJ4vHXiGJ6mIR4jOLdgJa0NnZNCV/9QDMctorczBwdfl5+P8xXAWOydhDJ6t51lGVTZj4FrrkeE0hGLRkpBGhZw5i+k/oKn5MfSSLTipFGHQXreRJr8ma3zNFfE4Dhzb1vS3d7+A/8hKE3S8K1VSY9BjORy0VyTA9UrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkFX3o00ZgwHYwHcgaRLJVrPvPP/0QYDmc3C8wSGF5E=;
 b=DfbX8KqztFRnsa6ZzG+30JSI/qquR0Zq7LmUcNTRrVmFJdrpoUKDtPIbntwYH8HCDgGDO5786Azh5nEZvltn0s7sCT6g8OQegbC2nkKncpQaSDyGAQlDLJQRMKS3lKTWCCP657nsLpwS/W+n/LtX1bRep5KrZ6yqiENga/70oU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB6011.eurprd08.prod.outlook.com (2603:10a6:10:209::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Sat, 17 Aug
 2024 19:25:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.009; Sat, 17 Aug 2024
 19:25:36 +0000
Message-ID: <581c5b3c-fe89-4828-8d60-d56b7e614c1c@genexis.eu>
Date: Sat, 17 Aug 2024 23:25:31 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 10/10] mtd: nand: add initial ecc engine support
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 William Zhang <william.zhang@broadcom.com>,
 Chuanhong Guo <gch981213@gmail.com>,
 Martin Kurbanov <mmkurbanov@sberdevices.ru>,
 Igor Prusov <ivprusov@salutedevices.com>, Bruce Suen <bruce_suen@163.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, u-boot@lists.denx.de
References: <20240814101918.1347167-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814101918.1347167-11-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThDQqaUofT2Jetw7bYc5M_+oBMswc9r8Vq2ZPhC-V9xYg@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszThDQqaUofT2Jetw7bYc5M_+oBMswc9r8Vq2ZPhC-V9xYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e9f340b-0594-433f-d5ab-08dcbef25ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0dXK1ZicVF3dk15enVpdGd0OXNpTXNQZW8rVUw2UXFjQmVZc1Yrb0xzcTRi?=
 =?utf-8?B?elZvd3VsVVdvRWRTSnF1Mi9kbUpMcEdRWC95QktsWThISjdxWkJ2OVk3aGhw?=
 =?utf-8?B?ajBOM2ZVR2NEZUxJOUJZcnpWUFZDbENCcmx1Mmx0azE5TzFNQk9zSDFSekQ0?=
 =?utf-8?B?MXVjaWRKeHVBcnRlbWNGOWt4cm54TnIvTk54MkVXWkIvcVhoSk1DcDFBZGJs?=
 =?utf-8?B?cm1nNTZjcnVNTHJmWEwydGMrdS8wSlFIWDF3bFNETkNzMVFXdjlmdDJGVHFU?=
 =?utf-8?B?djRxOUs5VkpiNFRVK0xBa1dmL2pOdWIyc3JhbC91NjBaYnFuMWNCL1Zqc3dw?=
 =?utf-8?B?RE5zRnhhbjViZUxYZ2Zuclo3NStRaitDSDBvYytnUDZhZE1ESmdmUG5pR3dy?=
 =?utf-8?B?S3BQN205cGllUEd1eXZ2bElmcW1IeFkzdFdiRTRrc2hMaEVlTEJzVkpSMzgv?=
 =?utf-8?B?ZlhRclVQeTkzbjFXZThBRnZWYm1ZaG42QzJuUS9hRkpPQjczSG9TM1lmcE9R?=
 =?utf-8?B?OUg1MlRXTGlIRmxIQlpZU1dnejFYTlRxdmZUbllkS2xPYTFqNzVwYU5zU3Zs?=
 =?utf-8?B?TU8xT3FCR2Q2bjZUVEJRSWxTSGpqM0NZelNCTk9MNHFOWHprUCs3eUwwQzhV?=
 =?utf-8?B?YlRTelRTajBMc1RHc2J3cE1XN3V5UUN6MlI2N1Zuci8yNk9VVy90RXlTa053?=
 =?utf-8?B?WXVhWmVBSWh1Ri9nVk9hQ2ZDc1pNT1k5MXhhdkhINXFBVzkzQTlhUkt5YWhX?=
 =?utf-8?B?UjA2OEJ6QndEVktNc0dnT1hPcTIwaFdjZ3NGLzJrSlFxSjZOc3h6bHZPYmhE?=
 =?utf-8?B?KzlIMW02WUk1ZmlGbGNramVWREozQ1BFaGtpT3VQWEwzTWtRK1VZaS85SWwy?=
 =?utf-8?B?UGlWbEhmdzYvaERWalVrT1IvNjNOUUVRU1MwYjljamZVc0F6ZjRaUjZrRm9R?=
 =?utf-8?B?NkxxamJDODg2OENVREZsSld6b1N0RFhFSVoveVhBaENWYVlNV05KbmhnNDF5?=
 =?utf-8?B?UXhMOWJETUJqUHdOcEVscEtReTJRSlRHUmZQNS9YYWNkclNYUHJnWEg1cTdC?=
 =?utf-8?B?RFpXRllKcm1QRU9QWFN2eTRJYnlRK3paTDNsS1B4bWEvSEhJN2RMekZmamhC?=
 =?utf-8?B?L0FNQ2U2bExtTmFCaFRSNWV4NkdSZW1xMUk4UlFKdzZXSmJta1k2aGdPYzlu?=
 =?utf-8?B?MG9LbHBIREJSeGZydjE2bkZZWGJjc243bXVxOHBIZzVOQWVMQ3lJWWhNWmxT?=
 =?utf-8?B?QWJwMXJMck45dGpRcmNKMFJnMTZpamNYcU9ra0RxSVRXUUF1b0dSM0xTSVZn?=
 =?utf-8?B?aGtvM2xhZFBYMkRZYVJDSjlpOE5ZQ1ZheU81NTNjckdXb0o5TmNXYzV4MFZM?=
 =?utf-8?B?TzZ6KzlGMENuTEIzN1UwNkJObW81Y1ZUOTZuZndFOE12Z3dRdnFmMmwycmF5?=
 =?utf-8?B?Q3ZQeGhqdEhTTkZTQjRhcS9DN0lLK1pWcGc1SklIRTlnazRSS0p5dE1xUU1r?=
 =?utf-8?B?cjFzczd4dm53V1kwanRTMXMyV1pOcjhaenRGT0ZGZENpK2NJTHIwcE5jdWg3?=
 =?utf-8?B?RE10enh1U0M1Ui9Bd1VWekdQMVlicEVHTXBVYlM4dnpHSEZWR2hEQllwa2RH?=
 =?utf-8?B?cXVBS3dFOWw4WlEvbUdKSjhQc3RJTVovWGJIamxlZGVHa2NVZFhhU2ROSkc2?=
 =?utf-8?B?UytqRUU1V2wyeDV6WWxteGd4bGlKTXJkVGkzcHJQdExOZ3NYOUtlbWx5YmNp?=
 =?utf-8?B?N0psa2cyRXFYYjRNa292bGZrM3UrZ3NjRm9POFUvTkN6Y0pybWJub25SU1Zz?=
 =?utf-8?B?RFN6SDI4L0Z2ak5yMFVrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJqZlRQb2dXQ28reXZsdFhRSEI4MktQUXE4MXlIVkx6NytPOUxpOEllZ2E5?=
 =?utf-8?B?Z1lwKzJRSkh3dDBPb3NIK2VmRUJTTWRMaWZkMGNVV1I0NGRmMWU0SFYycjZs?=
 =?utf-8?B?cWJhOURhcG5Zc3hVZkVqN3Bmb2k5NVBLcmZCYW1iS1hJWFVUZUEvd25OVjlq?=
 =?utf-8?B?MnJzbDcyYjA0blorVFN1Y2MwM3FrdkJkT0RndStGd2o4UXBrMHJ0d00wYmgr?=
 =?utf-8?B?WXFnYWcwbUR6TVBjL2E0MUl2MTVrVWZBQ0R0Vzh2N2lKcjVIQWxLRG9XeXM0?=
 =?utf-8?B?M3ZQWGpvTmhHOVBrUjZoc0NnQXNxakZQNnJUb3BaNFBqU082WnFuM2QvV1l4?=
 =?utf-8?B?aFFFcndTcm5JZXlSb1ArbmxENzJjMVNMSUM1OFBlUHA0VjZzMkN1Y3J3VXdF?=
 =?utf-8?B?TzE3YWdzK2lYL2NxVnhsQW4xUGtUNkh6VWQwUXJGV0dSR0NmTXUzdkdhM3hW?=
 =?utf-8?B?NWhpZDlaQXROT1l4OVFkbUFjTytTRlVTejNIWWtJZ3g1bWdkRS85dUhVdmJC?=
 =?utf-8?B?Rnc0eS84a0k2Vk0vUU4zMEtVQXFaVUROeWRNa3ZTVXFCeVVKNVY3RDJibENK?=
 =?utf-8?B?YzdEQ3RyZUZpR2J6Q3VLSE14dXFtclQ0WVdYeXJ1UXVHNlIyU0twdUhnL1Aw?=
 =?utf-8?B?WnlMeEZNZHdIcXJ4K2ZNMFN1WGl1NnpWVFo4S1UvM0ZpbjlEU2FVZ051OEMy?=
 =?utf-8?B?TUJHMTVabTBuOWlOL0FTOVJ5YWZyVDhoREQvcGxuWnQxMGJkSjFQRUtTdzRY?=
 =?utf-8?B?NFBnWWE3Um5aay9TWWpXTXMwMXdNSGtaL1NpMVhJdm1SK1hDRkRBaCtvM0tG?=
 =?utf-8?B?dWVyYjN6TjU1bTA1MFlUYnJXZHBKN05pVWN0Y0Z2a091dzYzejRpTjdrOVNR?=
 =?utf-8?B?OFFNQi9UYkVnTlkrN0ZaVjdTOWNNbTJiV0dRNWEyL2wrZytjRU5Ud2dGSVhS?=
 =?utf-8?B?YUxyVTFJSzA0UWN4YzRwUDA0azQ5N25mU281bnhmQjg5YnhRaUQzYmVHMmk1?=
 =?utf-8?B?azUwaWJpVEU4V3RBdExyd1dZbkVmTzlGNWpUNHdLTkdFdko2M3pOKzJxWFpZ?=
 =?utf-8?B?U0hMczBsWFU5aDA4TytzV3lVejBYN3F0M1dsYzE1Z2FZVnZadnBPclUxTWZT?=
 =?utf-8?B?THR0WTdJMjhsbVByWmJWOEdTSkl6OFVoTGZZbEFaRnZVZDFpNXVROWhPQ1BT?=
 =?utf-8?B?c08wYlZVam9tK1FIQkhHWlBUZmJPWnM0dFkzVVhtRmhCdUJwZFE2Sm1qRlcr?=
 =?utf-8?B?TVRtWHJlSmcvTmYxOEdGU2EwL0RzZWo4UHJ3QVhSTTduRTRVdmtBZUFIdEMx?=
 =?utf-8?B?WmpEenF2d0xjZS81OUdybzZkRHFoVDBJS21Ocy90bllleHJVZXVHaCtBRmlM?=
 =?utf-8?B?c0FLK3NUM3hsbnp1cktIdWlxS3FEUWVydk9aMC9zSWllS2d4ZFVqUzdqMUdy?=
 =?utf-8?B?T3BWUTNQQjlhcGFQdWlqczNaNEJ1dHgzc3FYa2ZoR0l3Q08veUw0NFJLVzZJ?=
 =?utf-8?B?MExkMVRpd09pVmZMNmVmN3NuNlFja2hVcUVUTkw4WVh4eEhoQmlPZktPZ1F5?=
 =?utf-8?B?bW5HTUwwQjliYkdCOWVDeG9xL1lnM0wvZjAxVmdKeERRM0JYL25IQ01lOUps?=
 =?utf-8?B?UHhtU1JVZ0VoMHR3alZXUGFkSWlhbDNMNktXNitoVFA0WkdHTzdKNlFmOGhI?=
 =?utf-8?B?S21FWUtkMnRuK0hNaDFQenZNd2NWMnZQMWdyU1R3NGk0QW5qYW5CR1NTM3lR?=
 =?utf-8?B?QVlXVU52cVBKN1VmTGozdU1PODRCRm1COEc3U1k3cU4vR09SWDJzUWFhMFdT?=
 =?utf-8?B?YmJHOUZwdnFBaDk5UXpHMUhBRDZITzNocGZzcVV3L01aTldRc0FlTndJS041?=
 =?utf-8?B?MTNDUkxSV2MyYnpXR0FRbGJyb2Ntem9seGhsVmM1K09IS1c2a25YU00wV0p0?=
 =?utf-8?B?dnQrR2JCTm1CUEdZaDAyTmdsRWlFVmdMNGlMQ00zOXpXSVRDVWhzZGRYUE1q?=
 =?utf-8?B?bjNTNWV6MFpvSU91WDEwNWJCUTluZi9sOVMyeVM5ZjdMRk1Kc216aHo5Mk9a?=
 =?utf-8?B?RHkzaEpWa05QNElraTRTSGhQa05uWEF4ZC9BZkFxZ2NVanl1L29nMnBqU29M?=
 =?utf-8?B?TDhIWFVwOEdMVkNPd2ZBY1ZuVXArUHlBT2NCMnJabG9Xb21mZzBleGl3Q25z?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e9f340b-0594-433f-d5ab-08dcbef25ec7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2024 19:25:36.3826 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWkSDzFgUjakP/0csGdAG9Mf6hPvczb3uw9wGikPbrg6Ujrnh1HWLyaKc7p9Glcgzl2l5wvTSr/CVFSWNjH/IlbNRrjfet5FOOLSOy1RO/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6011
X-Mailman-Approved-At: Sun, 18 Aug 2024 07:05:39 +0200
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


On 8/17/24 19:58, Simon Glass wrote:
> Hi Mikhail,
>
> On Wed, 14 Aug 2024 at 04:20, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> only spinand on_die ecc is supported for a moment
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  drivers/mtd/nand/Makefile       |   2 +-
>>  drivers/mtd/nand/core.c         | 130 +++++++++++++++-
>>  drivers/mtd/nand/ecc.c          | 249 ++++++++++++++++++++++++++++++
>>  drivers/mtd/nand/spi/core.c     | 207 ++++++++++++++++++++-----
>>  drivers/mtd/nand/spi/foresee.c  |   2 +-
>>  drivers/mtd/nand/spi/macronix.c |   7 +-
>>  drivers/mtd/nand/spi/micron.c   |   2 +-
>>  drivers/mtd/nand/spi/toshiba.c  |  10 +-
>>  drivers/mtd/nand/spi/winbond.c  |  10 +-
>>  include/linux/mtd/nand.h        | 261 ++++++++++++++++++++++++++++++--
>>  include/linux/mtd/spinand.h     |  13 +-
>>  include/spi-mem.h               |   2 +
>>  12 files changed, 830 insertions(+), 65 deletions(-)
>>  create mode 100644 drivers/mtd/nand/ecc.c
> Somehow this should use driver model (along with a suitable API) for
> the ECC acceleration.

It's just a necessary part of ECC engine. Other engines (not on_die)
should be a separate modules.

Maybe it could be shrink a bit more (by removing traces of other
possible engines types). All what I want is:
1) get a working driver with on_die ECC support (it's actually a
necessary part of spinand driver)
2) make the code as close to linux driver as possible
3)  add the possibility to add other engines in the future.


> Regards,
> Simon
