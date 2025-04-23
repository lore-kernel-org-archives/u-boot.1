Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25D6C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7AD381F0D;
	Wed, 23 Apr 2025 16:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=hotmail.com header.i=@hotmail.com header.b="o6vnBI+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D8A80EE5; Wed, 23 Apr 2025 08:43:04 +0200 (CEST)
Received: from MEUPR01CU001.outbound.protection.outlook.com
 (mail-australiasoutheastazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d40e::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D80A800D7
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 08:43:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Zone.Niuzh@hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6zrHt/1VDYb3qv2j3Kz+9XJ3TKL53m0EQndz23EzUhJcRFnOgwdA2fCHnYCQD/Cdv7uArtF8vWqPjAHUUGkaLmbi0BTXwk0xtZbFy+/19zUSCWRqYIWXMWr7k7ZFhkb0qlG9U9igXcSRHthlngYC1Mcg8mPydRGf2wVj/qpgv986YodA9b7rnrJeEDFC/uH2fJGV/qnfDPTtrVTN5NzW0iVafVZ+nyMTr/j78IqOQIuudL7K+FiqW5+1Ca6Svl4RNTjRLFhxXbjwDEFz2tm8tCJMo48ZCLykNmg6NxbwHkLeMi3od8GP0oONzkLOfYTq9i6seczYC9fxBjbDQCPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbgPp14lvk2ntj7GSDZnsPwxPLo0XyuTP5skQQ+cmBc=;
 b=cwVs29PGUAk/Au5ZYxqxkudmNT2lhpi9tNj09WVEvb+/hiJ+92K5U6Ueu03WM5PjUwFu79WeKxiz1ufdvDIbwnclllhYpsuH/polDHzODqHzA0sD3ctuqv1ZyoWQS1XUqu9KWHb97TmLULhy1h8guk/wj8amx0YIBgyb7pKm3hLAgo6bFazflz9EgG0A7WABbpVUn7Fl2yfrkngEpN/0p2ZLNlKyXo/XY9jTMHZak8zrRfPPWTYmLG1wXQU51GXgeAT+axcADro3bhfLpPNqN+0E2W0yfQRLGD3bb5KlI3QZhkAouqoMfbcEpLQUl6PO73+epOUi/HhAhIzLKeHpLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbgPp14lvk2ntj7GSDZnsPwxPLo0XyuTP5skQQ+cmBc=;
 b=o6vnBI+IdIFw8qRa7A8PYu7X0TIh5Yvm8ehJEqggoKJnddAtVgfwd0H9iTeJPXXH1iy6itqhwp9QAETphNgTA1cFNYB460+BeUGekCwZ6m/eKxViZlhuY/pGEOAPybZPoea0P00olDUXfdRofC2mFPzE34CWZE2IzIj9QJuyoGgzML6G6PZ+zmkNAXlAY+eQzKx1Ik1kYWqMLI1ccqQg1FVqkEqKcRw9rGox7/zVTfSg9AFLwT7yJe6sKFUgxXL4KM+AdmLkAELt7znciL7lZQQRZd01hPVzXqTED2+JG/FLUMmm/xv8WQXIhw4YqBWXhnVZPcfP5RIDounnvrCoNQ==
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM (2603:10c6:220:241::8)
 by SY2PPF3E4CD81A3.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::394) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 06:42:57 +0000
Received: from ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b]) by ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
 ([fe80::b19a:4f0c:b8c2:555b%4]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 06:42:57 +0000
From: =?utf-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH] bootm: Support get entry when setup.bin were not found
Thread-Topic: [PATCH] bootm: Support get entry when setup.bin were not found
Thread-Index: AQHbtBrWE3khq6v4Yk2PTtTDifX4/w==
Date: Wed, 23 Apr 2025 06:42:57 +0000
Message-ID: <ME0P300MB1309FC6877427618264372F69FBA2@ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P300MB1309:EE_|SY2PPF3E4CD81A3:EE_
x-ms-office365-filtering-correlation-id: eaa08c86-0d5b-4c7e-c36e-08dd82321530
x-ms-exchange-slblob-mailprops: 30ekHghIwFqEsjkffpKof8tREN/5Pxyr1BvIs66MmEcIEwxE8PfhQ6wpsnWxoqwwHFFrZXMnS0FbRyqN7D+JEwWC9pfm6TwMO8QIxXPbw+F3kIirA4XlWdLMr3wbxbsi9c5yRnrQzTDpS0qLKixToqF6LuTb9toQnkksDihkL9GMTBNoosvZCvU9npEqMhCjIT3a1bhUZKqimhnIjPfnbuBoZF7X425qbo//dQHSwRlU3tghT1hCcECXp/PLVtZ1HZoeV0j24aHrqZB8Si5FdlHUxEPVpdjBwR7wAXARe9tAKzMMC1f8kFOcLyrKBrfVaquwduaS82F1APQ4cRpmh8U4Q6PS0t6t1L9Z17S1gaPrljuoXrbihUMo2RtEWWBbgFPWJyzVnXhGxpiOvGUf/s7XSQ61Oa3eczjIw+VHyaBISiFFMclABDPovzF5JQ5Yea2s5Dfq4buDEJ22Gaeo6Neh9D/BoR7ogIDEiGktRbdCqO5Pz8GVS7nBlyI2ssYe9/X4oP6L7pDa9VMZYHDgxTMOl5uqfJnBUWZUrKS9bpthlDsZQ9MQCW7+r4HM57V9XULOuQTPRBaeLvkn3B6HJeCzsnFuzFMkfSopfwuxouYgM9yQBk/CzSBEi5XumeuqbsfjeypFvsg+gQXrEDhvmk4Oj5rI3qt0u4mfmVdGbZp1s156O/mtFSw4nnIDFmZD/Yz0B3VyyIlylwNtUG65DmPu2JE3YuIiByc1YCpYkTJbZsiwT9bwbWg/h6C3UJUV
x-microsoft-antispam: BCL:0;
 ARA:14566002|19110799003|8062599003|15030799003|8060799006|15080799006|7092599003|461199028|5062599005|440099028|3412199025|41001999003|102099032;
x-microsoft-antispam-message-info: =?utf-8?B?SkhQQW5BZ3FSdXY3Qkg3bUxOdFhuZXVybWpBdUtYa0d5ZnNid0JVYkY4TXY5?=
 =?utf-8?B?andRbHFMdXN4L3dYQTdPYTk4L3luYnVUYm1rbURSV3ZCamZrMDN5SHdiMjZr?=
 =?utf-8?B?akN2SzYxOEk2NUtrTDBoQWU4aGJqYjFTODJub0JnMndWUnBvNGRTQ1M2T0dv?=
 =?utf-8?B?Wi9TdkI0Rnc5ZldBMVRKVEQrMVFZVlZNTHlyZGxVNVVuVFloM2hJRng4elpN?=
 =?utf-8?B?RmxsVXpDc0JRa1ZDUVI3Yk5Lcm5hVmRJRW95ZUdmMjJhTXJqdUY0S3RtMGZl?=
 =?utf-8?B?d3hQdjdpWThIZVQvUkljNEkzeXN3ZUlHNlA3VzN2QjJleUxkQVRmajIvZ0xZ?=
 =?utf-8?B?anMzSUpLTkpoSzJvRzRuTElKeHVUaUd5S1o4eXJMcjZ5ano2U0RYT3hLRUpE?=
 =?utf-8?B?ZGlLMGdmZ3dFeGtiVkoyV1Foc09ObWFUY3hBZGdPUmo5eUVLaTBUZVJYRk9F?=
 =?utf-8?B?MmZCbGRnaWZFWi9wanljeExVUGF1WVlDRGVDRzRjRkNxM2x2d0h2blN0U2ZL?=
 =?utf-8?B?aDRFS3VVQTVrMnBySkpsUHluRXhUd25DdC9IZXQ0Q3A1QkhyWTQ5L2Jyanll?=
 =?utf-8?B?c1N2K0toVFFGMDFXeUExdFVZZitXMnQwN0MyZ0E4UzU0L0ZHV25LUkw1bUVK?=
 =?utf-8?B?UGxIUnhSQTU5aHpQUFpSOEFURmhDSUc5bHdlYUg4cFFDbC9FazR6V05Ydm0z?=
 =?utf-8?B?STJ1NEhQaDg4aUlYOUhqTVovVHdjRm16b1RKK3hGeUtmZG9nNFpRb2V1Rk8z?=
 =?utf-8?B?SVI1b2JyRWwzcC9ockZoNC9mTjUrcVlKVHZENXQ3YUtKN2d4U00zWlZpcVhu?=
 =?utf-8?B?enhRelFIbisvTENpT2pYNWZjUGwrNFJ1RGhOaHdsWlcrU21malZzWjN1WmN4?=
 =?utf-8?B?Ujl5bHk2RGx0ejBtb3ZudHhGbW8rM1h6eExyZ1BJQ0htaGpSTjF6dDVOMEZE?=
 =?utf-8?B?Ujd0NFJ2ZWd1MzhoeUpCK01XY0hUUVFzUjNBQndTYnVMM3NiWGJYQ3JrOU1o?=
 =?utf-8?B?QytTemQvSDcrM1MzeVVJejhaS2ppaUJ6SW5yVXNjZGhUTXZ4a0dnNGVpaUhi?=
 =?utf-8?B?N3lsdTVHM2s5SHBwUjNZNUdNK3Y4a1Q2NnpzWFltY3I4WTFiZUpWbisxVVFm?=
 =?utf-8?B?R2R2UHRmbzFoR1dlRjFnZlhRZ0w4MzRNbWl4QXQyY1VHZ1l6TkFoQUJmRWhv?=
 =?utf-8?B?eUUveFVPYXVTczVkajlpaEVINEJlZ2JvOHFkc3lzSGZrTDB0MHNIWDYzVFY1?=
 =?utf-8?B?U1VlQkRiUGViUml0VndtVk5ndEZhU0IvSDJsdkxQc3IvNk52V1g4V3ZTczNu?=
 =?utf-8?B?ckpScUw5Rnk3MnQrQ2lTbUFVSzZwdkI3RGE5V3ZqTWRPZVYrNTFzZStqZnR5?=
 =?utf-8?B?azhwYWhGTmlwSHo0bmphb3gzTWd1ZHpNRTlock1wUzlxeEE0Y0F1KzhUN0RW?=
 =?utf-8?B?VzVxdjUwcjVZeDF4d3hpd25xV3RKQmc2bmNMcDNJOFJnWkxUNXo0QVJVblFU?=
 =?utf-8?B?Y0g2K1ZicUFjanYxV3dZbHRkOFcvUWhrY0g4YzdpU2VVR0drUVF0ODMrQkFC?=
 =?utf-8?B?bUpic0YyeDNBa084WG5ZeVgrajlYRHBPOFRLTzRqZmJVN2JpMHVBVm8xUFNt?=
 =?utf-8?B?MC82K0xMSEM4QlJ5WkN5WGIwQWhuaGc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3oraVBCTU9ZcDVKcG0vR2ZIOXhKNTJPcklOTEd1TXpWRFkyNVVFZHhCVjdI?=
 =?utf-8?B?SHB1aXh0NVVIY0RmVU5uMU85ck9VeFQzRENTUGo2WlVxTlBYbUx0VGIwOHdo?=
 =?utf-8?B?QVdXZHJVQytSZHIzSjRoYUJUaGR2QW9VM1VBV3A4S0FSU3BRQ1lIZ1U4UGhm?=
 =?utf-8?B?ZzBnZFgrL0k0Y2xiT1VQMEFTTU1lNjJrdkJnME1VSkxCZHg5UjczT3ZYcVVj?=
 =?utf-8?B?dy9QcEhqdHhScGxzbnpPaGF3bVpScnlLQlQrV2RUMlhBZUoxeW1tNTRBRTVo?=
 =?utf-8?B?T1Zpa05YL1lBWW8wb1dlSzN6TVRIalNaa0JXZE5EU2EwQjBySXZHUU10dytl?=
 =?utf-8?B?YUNSMnRkZHpZZTk4ZTlTZWduRXFwSkd3K3BEUjFFb29jUmE5b3FpMVZDYmFJ?=
 =?utf-8?B?Zk1vYklpcmUxMmdBSDZZYXpqSVdvRHExTUFvTWJ2MHk4WWIrS2RCMnlCRllu?=
 =?utf-8?B?VUlZTTlSdnovdWtkemFmanp2WEc1eXhiSTJoRGoxNk9oSWhFajhTaUZIQ09v?=
 =?utf-8?B?Vk5qYU1tWFYvakRTS3FQL2xtdjJtMjR1NmxuYXVUK09kUzhScTBRK0RHdnJD?=
 =?utf-8?B?MlNxYjNGMUQ4RmZzNnBGYzBDQndZeEFQaTVtSU1IY1I5YlRaUVJZSmY1OWNl?=
 =?utf-8?B?YlgwQU5Pb2xQOWt3OHk0SnNqRTBqeU5hWEFaWjRleFRPOC95QnVEVXZJZ2Rr?=
 =?utf-8?B?QmhIeTJja1NIT1BmRi9BVGRsNFUzNVh1Rmo1SHpFS1V6ZWNlczFGK0YvVnJY?=
 =?utf-8?B?RHJQclo2MzBFN1hkdTdyQ3hYN1p4L1c3aW5rVUlIVTY2Znp0Wmw4eVBpWmpt?=
 =?utf-8?B?dGFLa3JUQUlYa1lYeTdDbkdSRlc3Y0wrd0NUaXpFZlhWMzBZMEpEc1ducHZx?=
 =?utf-8?B?dERFOU11TytUb2NBQXZSR0JHajJVV29WRmNsMmF1SE9sczNkQ2pCa1FadzJ3?=
 =?utf-8?B?SnJqbkg5Ym9yOWFBbVdDMlBlVWYyUTJ1NzI5OVFiL3BrNi9IdmJQYnQrelFp?=
 =?utf-8?B?RjNLa2s4TmdEdFFTYmxzRSsxMW9PSHVyTGhoNzVaOEY1eU0vZklqTmM1VmtX?=
 =?utf-8?B?U3hqam1XcmR5NTY3WCtnc0wwc0NjbGYyS0VFSmdYUmlsRXQxN3BjYUtzQzcy?=
 =?utf-8?B?d3Fyc3NsbW1ESVlieGF5M2I3OEoxWGlOcXFuUWRaVGVhVTduY21Nc3BWQjJD?=
 =?utf-8?B?ekFucXc2ODZVejY3eUl2WHMyMWNaR0pMMmVYcTZPVkQ5MndySGZvVnk4WUtp?=
 =?utf-8?B?TlZPNG9jUDZUYVBLaEtoMTF0eDNidDE1ak1hRjBmc1AwZjdudWlrYUNuQkJv?=
 =?utf-8?B?aEhNV3piYlh6Y2RUMUQ3NU9SV2JMcmR5OWxlMVVXVS9qSkxvWUJjL3ZkMnV1?=
 =?utf-8?B?UnhTR3BXeWh0bE5Lb1hDZTNMdlZRUE9iUFF2c0tZeEoyUEgwNTIyMDh6eXU2?=
 =?utf-8?B?RENpUGN6SDZIZFhjdEQ5cE0zcncydHFCOVlKSVhUQTZUNVpJakJ1RW5NeWY1?=
 =?utf-8?B?QkozUm56eUZYTVovRHlKYWR1MkJoVXhobURhWks5UlVGZUdBcjQybHN3VVRC?=
 =?utf-8?B?S25sMk9NN0FTUVlpcmV3ZVlDVHZyNzhvNjNkd0tBZDJkYVNjQkhieVozR3NU?=
 =?utf-8?Q?fk7+Iyo1ubiIq6YYKssu6K/KRBtmfwCHmsp3QlFhVObI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-448bf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P300MB1309.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa08c86-0d5b-4c7e-c36e-08dd82321530
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 06:42:57.1953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY2PPF3E4CD81A3
X-Mailman-Approved-At: Wed, 23 Apr 2025 16:25:16 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

VGhpcyBleHRlbmRzIHRoZSBib290bSBjb21tYW5kIHRvIGFsbG93IGdldCBlbnRyeSB3aGVuIHNl
dHVwLmJpbiB3YXJlIG5vdCBmb3VuZCBvbiB4ODYveDg2XzY0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBO
aXUgWmhpaG9uZyA8em9uZS5uaXV6aEBob3RtYWlsLmNvbT4NCi0tLQ0KIGJvb3QvYm9vdG0uYyB8
IDE4ICsrKysrKysrKysrKysrKy0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCsp
LCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYm9vdC9ib290bS5jIGIvYm9vdC9ib290
bS5jDQppbmRleCBmNWNiYjEwZjBkMS4uNTBiYzU5MDAwOWIgMTAwNjQ0DQotLS0gYS9ib290L2Jv
b3RtLmMNCisrKyBiL2Jvb3QvYm9vdG0uYw0KQEAgLTQwMSw5ICs0MDEsMjEgQEAgc3RhdGljIGlu
dCBib290bV9maW5kX29zKGNvbnN0IGNoYXIgKmNtZF9uYW1lLCBjb25zdCBjaGFyICphZGRyX2Zp
dCkNCiDigILigILigILigILigILigILigILigILigILigILigIJ1bG9uZyBsZW47DQoNCiDigILi
gILigILigILigILigILigILigILigILigILigIJyZXQgPSBib290X2dldF9zZXR1cCgmaW1hZ2Vz
LCBJSF9BUkNIX0kzODYsICZpbWFnZXMuZXAsICZsZW4pOw0KLeKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAgmlmIChyZXQgPCAwICYmIHJldCAhPSAtRU5PRU5UKSB7DQot4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcHV0cygiQ291bGQgbm90
IGZpbmQgYSB2YWxpZCBzZXR1cC5iaW4gZm9yIHg4NlxuIik7DQot4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmV0dXJuIDE7DQor4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCCaWYgKHJldCA8IDAgKSB7DQor4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCaWYgKHJldCAhPSAtRU5PRU5UKSB7DQor
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCCcHV0cygiQ291bGQgbm90IGZpbmQgYSB2YWxpZCBzZXR1cC5iaW4gZm9yIHg4
NlxuIik7DQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmV0dXJuIDE7DQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCfQ0KKyNpZiBDT05GSUdfSVNfRU5BQkxFRChGSVQp
DQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCaWYg
KGltYWdlcy5maXRfdW5hbWVfb3MpIHsNCivigILigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigIJyZXQgPSBmaXRfaW1hZ2VfZ2V0
X2VudHJ5KGltYWdlcy5maXRfaGRyX29zLA0KK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmltYWdlcy5maXRfbm9mZnNldF9v
cywgJmltYWdlcy5lcCk7DQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCaWYgKHJldCkgew0KK+KAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAgnB1dHMoIkNhbid0IGdldCBlbnRyeSBwb2ludCBwcm9wZXJ0eSFcbiIp
Ow0KK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJldHVybiAxOw0KK+KAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
gn0NCivigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigIJ9
DQorI2VuZGlmDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCfQ0KIOKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAgi8qIEtlcm5lbCBlbnRyeSBwb2ludCBpcyB0aGUgc2V0
dXAuYmluICovDQog4oCC4oCC4oCC4oCC4oCCfSBlbHNlIGlmIChpbWFnZXMubGVnYWN5X2hkcl92
YWxpZCkgew0KLS0NCjIuMzkuNSAoQXBwbGUgR2l0LTE1NCkNCg0KDQo=
