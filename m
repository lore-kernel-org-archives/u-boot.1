Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E96C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B76AE82CA4;
	Tue, 15 Jul 2025 08:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Q4Sy7D6Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD9DC82F8E; Tue, 15 Jul 2025 08:00:13 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6911F8277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 08:00:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ix2yyqibKyyPsCOPNBtagxhw03f4RVq7zZU1vAJM5NBZtJiDuDp1PkKSk7SsQ/+6Rv2PnnCNKyA0Apv6+r21acqJ7P8z4EZpkxM9drdKkUupAntRqrxrfCRAs7lV6YAAYshvRGOm4FTJPfvkoBQnWC7TgJNQV+7QfdwlbmuJVNfb+vw2kES79fq29ukbzOzC6QAJAplm9tPaNU+ytoSnp8dFlHQqKR93CXRvy93kjCGpNwr5PbbLJpAwtJ8qXqt63WcxMyW2Bz311qu99nOTGWQLkOwFHIwSoSRHHJlzuZ68EN4kH25CTEjpoeD+5GGbTF64xWypTeFB2ohd+urv4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9Z8y8IoOhSR5+02QKv/pIF3WDXPFR7te93+SyfWpJ4=;
 b=uiiyT5qSN7OHYjMkspp+chaLL8C58xmtCOCyRIP7R2j3uZ0nNlKwv9s+zNzAIposhnXGDgPc1HKzFIAmPhuJpfCztCokuGuxMuNvlHG7AoL8UApm04N1RasFMgm7/FiUI9bl8+QBuo96I/1oQWPhKTS9456bhUJ63syoIiwsA2U7jEy8jhwd6ocGYNmH0rdy25VG6onDyhPzJCbsfMekfNYkLGzCLOXUpiay0miiNYVn4YrGRCUiWkE0FEyPFGbNl6hf7uG2jFWoqe/0KAwGPIehq+oZP9DSZZEM7x+U4TBlMp8k15V5vaVwUSqvSKqKZZ5SayI8eVPXNHty9OE62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9Z8y8IoOhSR5+02QKv/pIF3WDXPFR7te93+SyfWpJ4=;
 b=Q4Sy7D6QiF9c8JuWeTx0j1nt2YzCNbKz8TSCnOFss/cfuCA5x6AdZAJ5s0H8fGvNxV1EXEtLbQLswgGB2NrdV1Zr0rFx6McnRGAdafW6GPeTNsDSm3jK65lC0LRZ/HMH7ovkJ3EF0TPeKhIL1asf8/miw+M4ltttixmpTgg8zY6OgmCWSOVxwt1mdtkC1H8vrfz4Q2g8Hzp2w5nCK7AFfz7llatB7VEbDhVu0LuOgP90YxaHy7Qhi32MEhKEBk6Itwur1dJSV15gRorXCsm76wDuYwMXqSlrFWqKv037XXOcQ1SRMSjS+cVIesEGBnrscwX0GVERzNhRBa0pl6xK6g==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AM8P195MB0994.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ec::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Tue, 15 Jul
 2025 06:00:08 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 06:00:07 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2] binman: Fix typing for python >= 3.5
Thread-Topic: [PATCH v2] binman: Fix typing for python >= 3.5
Thread-Index: AQHb9IJntkmqyvKq10uFoFUqymKbzbQxhVEAgAAKIYCAABXcgIAACQwAgAAt24CAANY0gA==
Date: Tue, 15 Jul 2025 06:00:07 +0000
Message-ID: <90a2f28603f81fbb43f941e38f85a99f2a05767e.camel@phytec.de>
References: <20250714-binman-typing-fix-v2-1-dbe6519c43a0@phytec.de>
 <20250714120228.hkxkjzlxapyo4mmw@bryanbrattlof.com>
 <86c6b776c425e422290f72830d6a568123f740b5.camel@phytec.de>
 <20250714135657.fpa35alz45otqyj2@bryanbrattlof.com>
 <20250714142920.GE13084@bill-the-cat> <20250714171327.GJ13084@bill-the-cat>
In-Reply-To: <20250714171327.GJ13084@bill-the-cat>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AM8P195MB0994:EE_
x-ms-office365-filtering-correlation-id: a8f262d1-5f8f-406c-4181-08ddc364da12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QmhkTjBVSVN5dk0wZE01VkptaHk4R1h3WHJrcVQyZDQrTmxTTnQ1RmF3dDYv?=
 =?utf-8?B?SUxFcFcvU3BwcEQ4UEMvc2dUVEZNbnRiU0NBUm9qMXViNStkN090a1QrRWsz?=
 =?utf-8?B?M1ZEUzFXSWt6RUUzK09WT3pPTmNqRnlyYUJMR294MjdGYnRrdkU5UmJtZHNl?=
 =?utf-8?B?UzU2aEY5akdhMm4rcnUzdFcrMkVDSmVTREw2dzRhN1plMGg5WXB4aXJML0Y4?=
 =?utf-8?B?SXNiM0VZeHVXR1BVNjUzNDF0ZkVXM0lZS2xYQW02SUI0Nnk2OUJwOE9nM0Mv?=
 =?utf-8?B?Nm5NNTV6QjY5UXZScHAyLzc2OGJpc2RvT1JubW1Obzc0U0pvckw0ZTJDTHBH?=
 =?utf-8?B?czgvQmhxQTYyZWZNamhjRUgyVW1QSklBV2pTMFFGL0NuNDRwK1pGVkZSdlBl?=
 =?utf-8?B?L042MWlKK0JZM3FMcmVKSkdRdVNtSXVqK2NxR25Mb00yc3Irby82dUFwamgx?=
 =?utf-8?B?eHQ0azZFMWt1dWYrQzJWUjJ3V2JvZkl2WUV2VnVBT0NYN2tqS2szL2FIUFh1?=
 =?utf-8?B?TzRCS0llcDNFNVFHTlY2OUh4eTRqUnM5bmU3RGgvM05XV2RCTXR0d2VqVjU2?=
 =?utf-8?B?UktzdmZFM1ZYTzMwNFVFK0h5VGpmMHlJakZtS3BOUCtqNU8wbENFVUZpRk9N?=
 =?utf-8?B?M2ZhSFk5SlVDUFFheUlGQy9DbmE3bW5NTXBaVDlNNHVqU0JjemF4QjVpajZu?=
 =?utf-8?B?cVdZOXU3Zy8zUnFqYVpFTGZmQWozenQ4a3VYSURVMmV4Y3U3VWJNdjYrUDV3?=
 =?utf-8?B?alM2ZTRWYlE1aG91SUlNQUt0RGJrSGNvWHhaUGZKdlZ6MVUvcFY3bGZNOEZI?=
 =?utf-8?B?MEgwOElZQUQ3YlNHNzI3ek1oVHJvZUJMTXNhNWhrbkNnbnp2eFZIVHFrYzBu?=
 =?utf-8?B?TzNTb1dWMFo4NXJPQkVQRzhTNFkrQUZ1VUFVVHcrQ1ZRV0JWKzFjV0t0TFlF?=
 =?utf-8?B?VHZpUHdNc3cyQ1NmcEVWQWZpbE9zdHkrQVcrRno3bWR5akp1ZFRLcXFkVk9K?=
 =?utf-8?B?dXp3LzJBOEhWS05SNERnNnhjNkEzSlhWTG5XOVNNZU5idWdSajRwUDQ3N3E4?=
 =?utf-8?B?eDFRc21nL0ZnakZBYUxENVczWG5FSWt1bU53SnNBWlA2ZGtwWHY2TEVCMVpa?=
 =?utf-8?B?aE9qWWRXK1RuZWdYMVNpWCtxa1J1aFJ4TWJERmJiR3FNejhsRlZCMEJBRlIv?=
 =?utf-8?B?UFlEYktaNlFvQnNlMG15NGR0N1NPb0hud1QrWkxOWjZrMXQ5U1NDbnRiQ3ZU?=
 =?utf-8?B?UFhPK25hejVFWGhFS1QxQ0c3WFAySFBIZS9XbWtpYUJEa285eU8rdG5odFo4?=
 =?utf-8?B?MWxkV1YvTlYxUXdlcFo5UlRVNUxXamcvRzMrQThJRDlqOFBTaVZJejhDMXFx?=
 =?utf-8?B?U2hCcWQxR0FvRVZRWGJmR0dRbzYxQ01IWkpUL2RmUGtFTUtveEo3UE9iVlRS?=
 =?utf-8?B?OTBiRGNXQjFZNHd6WXB2UlU5SnhJM0d2ZEx6MnhWcmh4TGFxN1dKUUpDZjVK?=
 =?utf-8?B?MXM4MEYvTzR6TDNES1pDTCtHV0Q2c0w2ak1KNGlYWWNPbnlTMDNVTHhwY2tu?=
 =?utf-8?B?TWgxenBxMituUm42VjlJSmFXa3BoUUhEd1lua0ZUMlZxTXY2ekU3Q1J3RnpD?=
 =?utf-8?B?WkRkenE4ZGlSR1lqZnA2RE45ZDVScUt1TXlpSXJBTzFidmVOQnZGVjYwRTF1?=
 =?utf-8?B?TC9BWWtnbjNqZXNOc1RseldvUFVxcERKMk5PR2xYUEZDdGp0SytVTjJudXJx?=
 =?utf-8?B?cUZGYzgrc2lJcXdWWlVNQkNUUkN4OUlsVEFaVWxRdEx4dHB6N2NWRUtZN3cz?=
 =?utf-8?B?WDdqRjI1UGt2TXRja3h5YUhrNy84bFFRbmI5dG5RcjgwSzNVZmRmOXc4cHM5?=
 =?utf-8?B?eHVWc1ZFUy92bU5EZlYxNm11SVZ4TFhQM0xIZVBYQjVOU3NSRlRtSnZGd2RV?=
 =?utf-8?Q?dMgsm5sRe6c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2JIWVdaWnVCVUgwVkFUcjJDc25xdjJpa3Z2Ynh3T2ZUUVFhdS9naWd2a3ZO?=
 =?utf-8?B?UUhIU1c1STE2Q2M0ZElIeUhVM0QxRFlYZkFRYzhKbmM0R3djTytXV2NwdTNy?=
 =?utf-8?B?dVhtaE02QTl4a2NlV2cyYTNsdnRzYlV6aTBVb3AyMXpwdkNUbkhvU1F1aVhm?=
 =?utf-8?B?RU9QeTBXRWtaZzBpTG9wUTJxd1VBczFsR3Iyenl5Y1ViR3JQaXJ2U29PNWJz?=
 =?utf-8?B?Y0sxa0w1SDRFVmUzNHRtbVNuNXRyM2Q5V25EVllxaXQvblZ3RHg3Q3o1NFY2?=
 =?utf-8?B?SzlLWUxqd21EcTR6S0dpZzV3bVltcEhjeEF1UjhKeWhSbmpndko2d1d1VDUw?=
 =?utf-8?B?NzA1Znc0c0dqZjI5UlhzQzh5QmoyRjlTMkdVN1IrU0oxbVg4aVFqbENNLzNa?=
 =?utf-8?B?MXNQQVI0d1liTnpKTGhsS3J3V3J5L2pFVWRpb2doem15d1BzM1dRb2JWQ21R?=
 =?utf-8?B?L0FObFpudTRIMEpoU2JGYnIwWEhmS28yQ3JocUFLQTZSMm9kQ1ZBUEhoTTY5?=
 =?utf-8?B?SDBzckxSTmdYMXlZQ3Aza3VrSHEzSWs3TVNWSW0zYVlkQ2VGUVgweUU1Vnpr?=
 =?utf-8?B?YVIyeFZ3bWM1aUowWm15WDU3citlNms3QWh5R3duWmhLK1RKYmhXWTZKZkcv?=
 =?utf-8?B?TnBkUUttNU04QmtNN2Z5MmZLejJ0b0R4ZlppNFlRa3cwZ1ZmV1p2Q3B0WUx0?=
 =?utf-8?B?emIxbXlha2hEMWd6UmwvWjhOUno5WUQyVHBVbzJ2Mk1hTWlzUS90MlRoa05K?=
 =?utf-8?B?WS9tMXFoaG9vbnhJM05aeFBicGU1Nzhmb29sUkdiV0hzcWd1QXlJS2lqMWps?=
 =?utf-8?B?cmR4bG9NNWdQT0JvMG9VdzBiTk5ZSWNSajJtemQyT3oxSVZrdEU2aXVGR0d3?=
 =?utf-8?B?L2lrZDJvYndJTVptYWxiM2Y3dkRrbVA4U0p4SWNtSnlyb290RW95Z1dpcFVr?=
 =?utf-8?B?MGFRbVlqdUJicGFNRVdGeG1Gc2dIQzFZc216TmJBQlhzWGk2ZU5zZnBEaTF3?=
 =?utf-8?B?MzNEUzhGeEh3R1RicWJIRjR6TWdDdVZyRVc3ODhRRXRpZ2krOUxtMlhMc1M5?=
 =?utf-8?B?V2h2TkkxekNFZmpVcWp2b0VGS3V3bEYyUFc1a1hnWnFSaGUzVDU2ajc0alVI?=
 =?utf-8?B?WDlGNkphby9RM3A4R0hnMlJPWHRrWTV4U1lwTXZROFpZeGpMV1BzZUNGbTlH?=
 =?utf-8?B?Rks3SHVTaTlGTENFYjNzck56TWdCT1pONFh6aTlaOEl0RGpGRURJa0NmcU5H?=
 =?utf-8?B?bjNpOVFUVUxaTVlFSXB3ajJSaGw0YXdJMFZRbjNKdWw3eW5KTDFxOWRLRjdP?=
 =?utf-8?B?SnI1bjYycThqb21NZGxWZmx5OUM4cEQ4S05yNDRNSkNEQU9TMUh3YkFaY1Y2?=
 =?utf-8?B?RmJZd215RUkxSXErUlptMUxaSWxOR3JSWGFNOFp4aldzemNJcG1XMzRTc21v?=
 =?utf-8?B?ZTFlLzVrQW1rQldXbkJ2TkdkOGtabHRJemZsTU1uZm90QXIwc2kwcitNNU9k?=
 =?utf-8?B?bjBkb1NsNlRxeTcxSGtzRW96OVdyLzVxK0ErU2dLM3U2b0RVbElrMDU5MEFq?=
 =?utf-8?B?RUxjVkVjU1lzV09DaGpqNi9aaGZyUmx3T285QmFsVFR4elFFWmpyb05iU3ZH?=
 =?utf-8?B?dCt4RkZHU2xtK1Zjd0hCVG9SaUJ3Rm54TS96Rm5Oc1EzZzI3RUUrUi9rR3g5?=
 =?utf-8?B?T0ExS1F5UmZOK29jN0xKam1ZQVFhVXhmRzJqNjRzNGgvME83UUFodzZ5c2dY?=
 =?utf-8?B?b0J3OW42bkpYenRCb0xUM2hYVmxzS2U3eXJ2SmpUUnh3Rmp5ajZWTWhaVzFX?=
 =?utf-8?B?ZW95cC9Kd1VSYk9UdHYzbW5ReExmSUZZRFpXbmNBdTZZKzU2aGE4ZXRrakd4?=
 =?utf-8?B?aVlWZEFXU2VhUUxuV29pSXNpbERha0xIeTVwYnlSOHEzODNaOHRUcWF4MFRM?=
 =?utf-8?B?SUxiMnJVWkowU1B6cnFKSndOZWFvK0NTNEtsUzhlSHpsbC8vL2VRd2t3YURP?=
 =?utf-8?B?ejFRSGo5UWlVbWJZcTNPTFh4bVpnZXI3elo2ZTlIaWxNRDF6N2ZVYUN2TDZP?=
 =?utf-8?B?SFZjMzhkejU5V1c1Z05oSlJWK0VDbEJVU2VCN0l5TSsyRXFQMDV6bWdjV2RK?=
 =?utf-8?Q?IyIA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7FEBEAD6B92254B96B9C199DD8A4173@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f262d1-5f8f-406c-4181-08ddc364da12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 06:00:07.8920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +eFmcvaMLzodCwQVepLZ3Rv1J7FBDm/37zoBTpbpnwL4CQDIhUvXpWRb3RRgpL5w67Ea2RXIsIujiPY6CaFv7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0994
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

QW0gTW9udGFnLCBkZW0gMTQuMDcuMjAyNSB1bSAxMToxMyAtMDYwMCBzY2hyaWViIFRvbSBSaW5p
Ogo+IE9uIE1vbiwgSnVsIDE0LCAyMDI1IGF0IDA4OjI5OjIwQU0gLTA2MDAsIFRvbSBSaW5pIHdy
b3RlOgo+ID4gT24gTW9uLCBKdWwgMTQsIDIwMjUgYXQgMDg6NTY6NTdBTSAtMDUwMCwgQnJ5YW4g
QnJhdHRsb2Ygd3JvdGU6Cj4gPiA+IE9uIEp1bHkgMTQsIDIwMjUgdGh1cyBzYXlldGggWWFubmlj
IE1vb2c6Cj4gPiA+ID4gQW0gTW9udGFnLCBkZW0gMTQuMDcuMjAyNSB1bSAwNzowMiAtMDUwMCBz
Y2hyaWViIEJyeWFuIEJyYXR0bG9mOgo+ID4gPiA+ID4gT24gSnVseSAxNCwgMjAyNSB0aHVzIHNh
eWV0aCBZYW5uaWMgTW9vZzoKPiA+ID4gPiA+ID4gVG8gbWFrZSBpdCB3b3JrIHdpdGggcHl0aG9u
IDMuNSBhbmQgMy42LCBuZWVkIHR5cGUgaGludHMgZnJvbSB0aGUKPiA+ID4gPiA+ID4gdHlwaW5n
IG1vZHVsZS4KPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBUaW0gSGFydmV5
IDx0aGFydmV5QGdhdGV3b3Jrcy5jb20+Cj4gPiA+ID4gPiA+IEZpeGVzOiAyMWJjMzQzM2E0M2Qg
KCJiaW5tYW46IHJld29yayBkcm9wcGluZyBhYnNlbnQgZW50cmllcyBmcm9tCj4gPiA+ID4gPiA+
IHBhY2thZ2VkCj4gPiA+ID4gPiA+IGltYWdlIikKPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTog
WWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+Cj4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4g
PiBDaGFuZ2VzIGluIHYyOgo+ID4gPiA+ID4gPiAtIGRyb3AgbmV3bGluZSBjaGFuZ2VzCj4gPiA+
ID4gPiA+IC0gTGluayB0byB2MToKPiA+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
ci8yMDI1MDcxMS1iaW5tYW4tdHlwaW5nLWZpeC12MS0xLTY2YWIwNzUwMTVhY0BwaHl0ZWMuZGUK
PiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+IMKgdG9vbHMvYmlubWFuL2V0eXBlL2NiZnMucHnC
oMKgwqAgfCAzICsrLQo+ID4gPiA+ID4gPiDCoHRvb2xzL2Jpbm1hbi9ldHlwZS9ta2ltYWdlLnB5
IHwgMyArKy0KPiA+ID4gPiA+ID4gwqB0b29scy9iaW5tYW4vZXR5cGUvc2VjdGlvbi5weSB8IDMg
KystCj4gPiA+ID4gPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCj4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdG9vbHMvYmlu
bWFuL2V0eXBlL2NiZnMucHkgYi90b29scy9iaW5tYW4vZXR5cGUvY2Jmcy5weQo+ID4gPiA+ID4g
PiBpbmRleAo+ID4gPiA+ID4gPiA1ODc5ZjM3NzIzMWJmOTQ2OTdiZWE5N2MzY2ZjM2EyNTE1NjY1
YjhmLi5jNWU3N2YzYTBkZjIyZmY3NjhhYTcyNTRlNAo+ID4gPiA+ID4gPiBkZDllY2JlNgo+ID4g
PiA+ID4gPiBmODE2ODQgMTAwNjQ0Cj4gPiA+ID4gPiA+IC0tLSBhL3Rvb2xzL2Jpbm1hbi9ldHlw
ZS9jYmZzLnB5Cj4gPiA+ID4gPiA+ICsrKyBiL3Rvb2xzL2Jpbm1hbi9ldHlwZS9jYmZzLnB5Cj4g
PiA+ID4gPiA+IEBAIC02LDYgKzYsNyBAQAo+ID4gPiA+ID4gPiDCoCMKPiA+ID4gPiA+ID4gwqAK
PiA+ID4gPiA+ID4gwqBmcm9tIGNvbGxlY3Rpb25zIGltcG9ydCBPcmRlcmVkRGljdAo+ID4gPiA+
ID4gPiArZnJvbSB0eXBpbmcgaW1wb3J0IERpY3QKPiA+ID4gPiA+IAo+ID4gPiA+ID4gSXQncyBi
ZWVuIGEgd2hpbGUgZnJvbSBteSBQeXRob24gZGF5cyBzbyBJJ20gc3RpbGwgdHJ5aW5nIHRvCj4g
PiA+ID4gPiB1bmRlcnN0YW5kIAo+ID4gPiA+ID4gd2hhdCdzIGdvaW5nIG9uLCBidXQgbXkgdW5k
ZXJzdGFuZGluZyBpcyB0aGUgJ3R5cGluZycgbW9kdWxlIGlzIAo+ID4gPiA+ID4gY29uc2lkZXJl
ZCBkZXByZWNhdGVkIGFmdGVyIFB5dGhvbiAzLjkgd2l0aCBQRVAgNTg5WzBdCj4gPiA+ID4gCj4g
PiA+ID4gVGhhdCBpcyBjb3JyZWN0LiBBZmFpayBpdCBpcyBzdXBwb3NlZCB0byBiZSByZW1vdmVk
IHdpdGggMy4xNC4gKFNvdXJjZToKPiA+ID4gPiBGbHVlbnQKPiA+ID4gPiBQeXRob24gMm5kIEVk
aXRpb24pLgo+ID4gPiA+IFB5dGhvbiAzLjYgKGFuZCAzLjUpIGRvZXMgbm90IGhhdmUgYWNjZXNz
IHRvIF9fZnV0dXJlc19fLmFubm90YXRpb25zLAo+ID4gPiA+IHRoYXQgaXMKPiA+ID4gPiB3aHkg
SSBhc2tlZCBpZiB3ZSBzdHJpdmUgZm9yIHB5dGhvbiA+PSAzLjUgc3VwcG9ydCBvciA+PSAzLjcu
Cj4gPiA+ID4gCj4gPiA+ID4gU28gaXQgc2VlbXMgdG8gbWUgdGhlcmUgYXJlIHR3byBwYXRoczoK
PiA+ID4gPiAKPiA+ID4gPiAtIHJlbW92ZSB0eXBlIGFubm90YXRpb25zIGFnYWluLgo+ID4gPiA+
IC0gd2hlbiB0aGlzIHR5cGluZyBtb2R1bGUgZ2V0cyByZW1vdmVkLCBtaWdyYXRlIGFuZCByZXF1
aXJlIHB5dGhvbiA+PQo+ID4gPiA+IDMuNwo+ID4gPiA+IAo+ID4gPiA+IFdoYXQgZG8geW91IHRo
aW5rIGlzIHRoZSBiZXN0IGNvdXJzZSBvZiBhY3Rpb24/Cj4gPiA+ID4gCj4gPiA+IAo+ID4gPiBH
cmVwcGluZyBhcm91bmQgc29tZSBtb3JlIGl0IGxvb2tzIGxpa2UgbWJlZHRscyBpcyBzdGlsbCB1
c2luZyB0aGUgCj4gPiA+IHR5cGluZyBtb2R1bGUgc28gaXQncyBwcm9iYWJseSBmaW5lIGZvciBu
b3cuIFRob3VnaCBJIHRoaW5rIDMuMTQgd2lsbCAKPiA+ID4gYmUgYXZhaWxhYmxlIGJ5IE9jdG9i
ZXIgdGhpcyB5ZWFyIGFuZCBqdXN0IGluIHRpbWUgZm9yIHRoaXMgbmV4dCAKPiA+ID4gcmVsZWFz
ZSA6Lwo+ID4gPiAKPiA+ID4gR29pbmcgb2ZmIFB5dGhvbidzIHZlcnNpb24gc3RhdHVzIHBhZ2Vb
MF0gaXQgbG9va3MgbGlrZSB3ZSdyZSBzYWZlIHRvIAo+ID4gPiBtb3ZlIHRoZSBtaW5pbXVtIHJl
cXVpcmVtZW50IHRvIDMuNiBvciAzLjcuIFB5dGhvbiAzLjUgaXNuJ3QgZXZlbiAKPiA+ID4gbGlz
dGVkIGFzIGVuZC1vZi1saWZlIGFueW1vcmUuCj4gPiA+IAo+ID4gPiBEZWJpYW4ncyBvbGRzdGFi
bGUgKGJ1bGxzZXllKSBzZWVtcyB0byBiZSB1c2luZyAzLjlbMV0KPiA+ID4gVWJ1bnR1J3MgMjIu
MDQgKEphbW15KSBzZWVtcyB0byB1c2UgMy4xMFsyXQo+ID4gPiBZb2N0bydzIER1bmZlbGwgaXMg
dXNpbmcgMy44WzNdCj4gPiA+IAo+ID4gPiBJIHNlZW0gcmVtZW1iZXIgUm9ja3kgOCB1c2luZyAz
LjYgYnV0IEkgY2FuJ3QgZmluZCBhIHNvdXJjZSBmb3IgdGhhdC4KPiA+ID4gCj4gPiA+IEl0IHNl
ZW1zIGxpa2Ugd2Ugc2hvdWxkIGxvb2sgaW50byBidW1waW5nIHRoZSBtaW5pbXVtIHZlcnNpb24g
YnV0IEkgCj4gPiA+IHRlbmQgdG8gcmVmcmVzaCBteSBzeXN0ZW0gYSBsaXR0bGUgbW9yZSBvZnRl
biBzbyBJIGRvbid0IGtub3cgd2hhdCAKPiA+ID4gcGFpbiB0aGlzIHdvdWxkIGNhdXNlIG90aGVy
cwo+ID4gPiAKPiA+ID4gWzBdIGh0dHBzOi8vZGV2Z3VpZGUucHl0aG9uLm9yZy92ZXJzaW9ucy8K
PiA+ID4gWzFdIGh0dHBzOi8vd2lraS5kZWJpYW4ub3JnL1B5dGhvbgo+ID4gPiBbMl0gaHR0cHM6
Ly9wYWNrYWdlcy51YnVudHUuY29tL3NlYXJjaD9rZXl3b3Jkcz1weXRob24zCj4gPiA+IFszXQo+
ID4gPiBodHRwczovL2dpdGh1Yi5jb20vb3BlbmVtYmVkZGVkL29wZW5lbWJlZGRlZC1jb3JlL2Js
b2IvYzRmYjdkMWYwZjE1N2ZmYWZkOWY5MDdmNDllYTc0YjkzYjJjMWQ0MC9tZXRhL3JlY2lwZXMt
ZGV2dG9vbHMvcHl0aG9uL3B5dGhvbjNfMy44LjE4LmJiI0w2Nwo+ID4gCj4gPiBXZSBwYXJ0bHkg
aGl0IHRoaXMgYmVjYXVzZSBVYnVudHUgMjAuMDQgaXMgb24sIHVoLCBJIGZvcmdldCB3aGF0IFRp
bQo+ID4gc2FpZCBub3cuIEJ1dCBJIHJlYWxseSBsaWtlIHRvIGJlIGFibGUgdG8gc2F5IHdlIHdv
cmsgb24gdGhlIG9sZGVzdAo+ID4gc3RpbGwgc3VwcG9ydGVkIGNvbW1vbiBMVFMgZGlzdHJpYnV0
aW9ucy4gV2UgbWF5IGhhdmUgdG8gYnVtcCB0byAzLjcgb3IKPiA+IG5ld2VyIGFmdGVyIHYyMDI1
LjEwIHNvIHRoYXQgd2UgZG9uJ3QgcnVuIGluIHRvIHRvbyBtYW55IHByb2JsZW1zIHdpdGgKPiA+
IGJsZWVkaW5nIGVkZ2UgZGlzdHJpYnV0aW9ucyBpbnN0ZWFkLgo+IAo+IEFoLCBJIHNob3VsZCBo
YXZlIGxvb2tlZCB0aGlzIHVwIGFzIEkgc2VlOgo+IGh0dHBzOi8vd2lraS51YnVudHUuY29tL0Zv
Y2FsRm9zc2EvUmVsZWFzZU5vdGVzI1B5dGhvbjNfYnlfZGVmYXVsdAo+IAo+IFRoaXMgc2F5cyBV
YnVudHUgMjAuMDQgaXMgUHl0aG9uIDMuOC4gU29ycnkgZm9yIGFsbCB0aGUgcmV3b3JraW5nIGhl
cmUKPiBZYW5uaWMuIEdpdmVuIHRoZSByZW1vdmFsIG9mIHRoaXMgaW4gMy4xNCB3aGljaCB3aWxs
IGNvbWUgb3V0IGluIHRpbWUKPiBmb3IgdXMgdG8gZ2V0IGJ1ZyByZXBvcnRzIGFmdGVyIHRoZSBy
ZWxlYXNlLCBhbmQgYWxzbyB0aGF0IHRoZSBvbGRlc3QKPiBMVFMgc3RpbGwgb3RoZXJ3aXNlIHN1
cHBvcnRlZCBpcyB1c2luZyBQeXRob24gMy44LCBJIGFza2VkIHlvdSB0bwo+IHN1cHBvcnQgdG9v
IGZhciBiYWNrIGFuZCB3ZSBzaG91bGQgYWltIGZvciAzLjcgb3IgbmV3ZXIgaW4gYSB3YXkgdGhh
dAo+IHdvbid0IGNhdXNlIHByb2JsZW1zIHdpdGggMy4xNCBhcyBzb29uIGFzIHRoYXQgY29tZXMg
b3V0LgoKTm8gd29ycmllcywgVG9tLiBUaGFua3MgZm9yIGNsYXJpZnlpbmcuIFdpbGwgc2VuZCB3
aXRoIF9fZnV0dXJlX18gaW1wb3J0Lgo=
