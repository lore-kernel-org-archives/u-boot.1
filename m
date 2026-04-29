Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BFEFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71422846F8;
	Wed, 29 Apr 2026 10:26:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="pzdwJtDQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96260846F9; Wed, 29 Apr 2026 10:26:32 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A392846F5
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZU8RAkdzvPEeupKaI8DewAtyqJCTbiNsSwmvBmKqcToC4eDhYZi6+CxHWu7WSoFJab1JBuANmHWAFsYGtkcHCFZqLqz42XdKI0md+o8JEDwKfXdwjsqN8a+PwZwiMvudnUYt00TvfcXN1zc2xQVaVou3KXn83CmSC6EzHTmuueLoloJTB+0bxGBXxDhfd7wSmT/yvSwHoMj4jWpR2wINMcId2hWDhhv8bxFKhT++wnlL1/wa7kCYpSmLt0kbFNV9CdYG2dMVPjWy5Z9vsBOQWCkMrBlD8NNfGXmQzdii2xs0JfsIYvNIpzAyQvU4sI60qvQjYp8zq1rSaZ5f4KEe/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLfL5mQZk3iYZt1SkgXu0rx7F/zRNmn5umaYUjsrACE=;
 b=DFulvAPRRCIyklFpEnGzHLJbCGJ2zVf7cFxOTHFFlXhH50RKtBo2soiHSKKQJ4ZXyFxfanoG8T1TA3YHAjKXKL8dj1vUJ0MAgAy1zU6o9Mej7GUK7qNLY3S0bneqnCj/sHvovqlMT9hhE7H3J4fcE/2E5PnJpb6GcoqsMzEBwZ4O9lI7uvNYDP0olQHElhOU+HbjosD7LBIpQOBRYqfmpTCjQSqHDfUcAn9PW/BtPFMPPs93GfCnbyaQ2kIM0V3TjPfbiKwhFHOLAZjtYSUcDBvhJMur3LCRbjZtA7j9sMmfeC6ZMUac+mUrDVEllFkF6ipdLOY3+E816oUuwfy9cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLfL5mQZk3iYZt1SkgXu0rx7F/zRNmn5umaYUjsrACE=;
 b=pzdwJtDQ4fMcVMlKLYNhMqptMLfVfCEruCWDFsmVgyLSfN6fBAaBRSZ7LEWc2TVNAsRag4vUl9p2pIy9entuJ7ESZRqTIQVKjlkBaa5rUSftWj/tFqlBszfIY8FZ3xnXqwhvgpgG8IC+b1Ucg1WBZk9tYFzJRi8ORfMivhfo8xyrGoIW440nDvMfKwiMV14QnRKLLqr7I/tQhaydA2iDO743yFhGScBxGIzpKBYtTjNCg775ydSvuDO99w+zM0MCtnW3GyX2pfmSXqUdYGQAt871mpbhe8S1YnHroUbBT+O9GaXYVIWArFdnXS3i6tWC07dpwG2eHdAlADIuB3dLJA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB7904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.37; Wed, 29 Apr
 2026 08:26:28 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 08:26:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "michal.simek@amd.com" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "pranav.sanwal@amd.com"
 <pranav.sanwal@amd.com>
Subject: Re: [PATCH] fdt: check fdt_pack() return value in
 fdtdec_apply_bloblist_dtos()
Thread-Topic: [PATCH] fdt: check fdt_pack() return value in
 fdtdec_apply_bloblist_dtos()
Thread-Index: AQHc16CTUSlpVUN+0EmeHyKaiBpvQLX1tHwA
Date: Wed, 29 Apr 2026 08:26:28 +0000
Message-ID: <3e682dbac6f3ef5f30ed99612ef8c78e256d3e9c.camel@siemens.com>
References: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
In-Reply-To: <3eeec4427b9ce9bb4abac4e27414ea1cb687e45b.1777443726.git.michal.simek@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB7904:EE_
x-ms-office365-filtering-correlation-id: 258eded2-3358-4fe3-2175-08dea5c90295
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|55112099003|38070700021;
x-microsoft-antispam-message-info: meZwh4cHlELD+KecLqdOFm2hAszWOSeW7Q2dMaNQ3baOhF3qqlZZv667sT1+FprZHXtoaBWdNT4TQDSSDb63bFKgTjmximZWH63UpmNcwWWprmjoUYCA5TWQc5mvyfcpAakjfGo8e4z2IC22yihSsnOND4pTWgBax6Luy5Um/x70m+Xt0ZduU3SrwUoqt+G98nkqmwojOsQakKem7cvyQPD5+I/tIgEkRofQ0xtvvjGjZIWUfNcASdgOcplzZoG0HNGSHJdsLWOKQ5LLTdqKp0GYkHPGzOtzUBXvPMcXHjgkeBB6OIxJckNkF3FoqW4BmP97Ws3Ot0hkPySPHJ3AS4IpAOixOyuYJ6NYPFjcvTZSxZ+TbLcSHdWAd58RGZnuMgWLQcys4+bHBPDEv5RhIVDXeS9vT8MHMByvZh0bFyqHZ9d9/Kqh808TDlaESVynfHCZnqxe3Qm4YawcWkrvgC/Ra4ZN88KYL4SVatWeloQBp+z65HHOyZ9MO7c3uMIhV88d8WU4+7Djnz5+Z/ld0hctILmxtKstKECLxwrWDRJWfpcJpUGDdW7r/FIlJ0BNFLQNBeVUgbW5YMFUcX3RZhHXZo2m8kI3YzsjJOsRYbL5bKY4LAInDnP2TeEAF+6WdJmzxayzOCEEk+cZOHvRDYgq33udF7/vkLruE0w3QQiMKlQvFr6K1cWn21cQwihcGcJteyqDprYdmSMzR+Tls8VEITFLvytZAJW7V6tFQyU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nys0UlpWeGlpWjdFc1ovbHQzdk02bVgwKzdzUXBqejZ5Q241MWttTlNNbHJT?=
 =?utf-8?B?eDU0TFcraGc3VnJwZUhMOE5qUU5oYnRyeEdNdGxnL3lhVnZJMG1BQjVHZU1W?=
 =?utf-8?B?ak1pY2hqbkNtM3JYUlhNelZuQ2ZLMllPSVZCZzJGbjl6MmU4ZC9XMVZCcHVr?=
 =?utf-8?B?UG1kMkd5MnF4dWtYRmZ5ZEQxdGNDUHRmbUdIMWlrbnQ2SDhsN29uR1RhWlI3?=
 =?utf-8?B?RVdvOEs5K21TQzVFdzUxd2NFLzVaMFZ4anVEMS9KdW0zaDhVL2UwVVZmWncz?=
 =?utf-8?B?cC9WVi9LNm4xZUhWdlJVbWpHMGRZOHh1MlFGdUhuYlY0Yk9WenB0eTd5ek16?=
 =?utf-8?B?dzZmbmxJWlMwa0VGNlRPMDlCalJhbDlWRHNCVHJqWDg1U0ZLcTZ4cnVmaVFy?=
 =?utf-8?B?NFd1cTcvVmVEa1l5cHV2aFJnL1ZmUkk2Wm1xZUlsd2xkTzY2VEtFUUk5L0Mx?=
 =?utf-8?B?Vk91Q082NWVBMkNUcmhQVlBBT2gzM2ZHay8xTnA1WXNZa3lENndiMzhoS0tm?=
 =?utf-8?B?L0phRmJSRVZ3dHJ1cXVwWWJaNTdiOGd6Qnl6aTRxT3Axa0VCb0haNmNHc0JQ?=
 =?utf-8?B?UVc3UmJBME5uUHQxRkY1dFZSNjJZbVl4WmhTU2FnZTR0a01UMkVPbHE2TVly?=
 =?utf-8?B?Sk8za2JNQVV6aExsL3VMOUtpZ1dUeStubDV4WGRmenIzM3VwbDNTYjBxc2Vz?=
 =?utf-8?B?TS90aHJrN3NUZzg5Q0tkRlBtSUNUcTFiNDZsS1RFMDE3dTZ0MnF3MXlLTVdD?=
 =?utf-8?B?QUV0SXphQnZyTFp3bmYzbFFSV0RxVEpKNVY4bkthUjZHd0Y3SksrQUl0cm5u?=
 =?utf-8?B?MW00NkRmZ3VaVDZ2bUplZEJkSzFBRHNpaUYvS0xuVnJqbFdNWXBqdUNTT3JZ?=
 =?utf-8?B?YTVaTElHMGw3RmR0UkNrSUV2Rkk2T1JjMGpocEp5NFYvRXhWZ2ZoVnJpdFF2?=
 =?utf-8?B?UVlZT1U4R2tiZ2w3YVNaV0Voc3k5UGpuOTVYdFNGWHVnTHB1Y0MrUkZSVGtp?=
 =?utf-8?B?K3hHMC9Tb1ZHK2xYUUNrQWZ2RG9UR1FzMjVScWhUV3B4WFlxaWoxKzh5RFlw?=
 =?utf-8?B?QTMxQ1Q3cFBRNGp5UU9zZmpnUWJPU0lQTkh6c3FONm4wWjBTRytKaXk3TFFQ?=
 =?utf-8?B?Qi9lNCt4WXVyZ2dsdTB0TEZ4VlV0ZXVFSmFmN2FLMlY0bFR3SWx1Q2xhNXlR?=
 =?utf-8?B?emJHM2o2SW1lWDRPMTh3YS9Cbjl1M0VJQ3FFYWtObE9icVJIdm5CcDJobGhD?=
 =?utf-8?B?dkdvditCNm5NOGJGRFpmT1RPeUVvVmx2M2dFcGxJaU5uWkRyOUJELzlIZk1h?=
 =?utf-8?B?aEdzR3luRmhqU1FKYTZrOFp1ZjNsWTdneUF2KzBQSTM4R2tsRUtYTWlRYUR3?=
 =?utf-8?B?ZExTemNSckZYMHdVdS9uSzA5emRiSklwR2JXclk3TlNtY0doZzFZaTd3aTEx?=
 =?utf-8?B?UFpJV1FtWFduMHJHZ2ZkTzVkenoyWUxaKzhPYVN5WXlJOEg3Wm1YeFpYY0JP?=
 =?utf-8?B?S3c4UXFORGVEVjdoVjE0VFNzZ0xkN1ZoejdFVUh6SC9HdGNrQ3ZKbHU3ME03?=
 =?utf-8?B?WkdqaXVyZnJpMWVKZjRjdnFIZ1doRjRhTThVNlpJRDJ0MG1yY05DYXZqNUVr?=
 =?utf-8?B?VDJMRkJOVmJZZG04M0dyQjN1SUpvRm9QdURzQ3dmTkpsM0lkcW9LcFBLcHBS?=
 =?utf-8?B?L1luZnhZbE01UFRvNmtiOU5iVW5uU1AvekQ5K0xhNkVydmFLNVZBNGxCREZl?=
 =?utf-8?B?cllnc1lYaTc0cXNVRTZWQUtzZy93NjlPNmpZSFJlQmVRVVJueW40Y1FsZjNz?=
 =?utf-8?B?aGhiNGNBVkUwRzFsS3lObXRIYmE3aXJ3WHd2VUNiNUdUL2pBTnRFVzllT2Fy?=
 =?utf-8?B?VGhCRUwwRzZ6WnFGRU5IMmRvMkZobHYrQVlpelZHVUZ3U1RURUJNQTB3MVZS?=
 =?utf-8?B?TUpDK2VyNUlEQ0RaSTdVODFjdGhQelIxWUNxK1RvaHhVWE5ueGxWcmpPcXgv?=
 =?utf-8?B?NUtEdk8rMW5tTDJIc0NPM1hhZmo2Rk8ycEdUQVplN3Jhb3VvSUlLcDI2OU5s?=
 =?utf-8?B?VkE4Z1A0ZTNZL0tCTFd3dUsrbTVGenM1SnBIbFFlZEUrR0NnU01SRmE2UWVL?=
 =?utf-8?B?ZmYxdmFRS1B6THNrRGJRa2dhUWpiQVRnUUpxVmF5SWhsaTA1QjdpVGZ0Q0dZ?=
 =?utf-8?B?WWFQM2xuR3BHNFZHeStHOXpsVmJxdkRKdUp4SzRhQkRtaGxUTVhDQVZ0UCsx?=
 =?utf-8?B?TjYrcHhyeWFXKzR0dlBNa3QyNnByMUJnSjVEMzZXejR0dHlMNTdjd2MxNDRS?=
 =?utf-8?B?ZkpKUTQ0aGJ5YWZuKzZ1Z2R4VXMyZDc0Tzd2WXFXYWxsQnhZbkhheHBSWWxT?=
 =?utf-8?Q?84iqtesdvciBxNbWXsmmWhsNpnW6mGNNxLt5m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FD24A577930A642BC96C46C2241353E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 258eded2-3358-4fe3-2175-08dea5c90295
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2026 08:26:28.3299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DT2vGQnoe87IAf0AHJYH6vV36VBpErPit0GottmoQ7yeqFji0mUVqnpw4o4rsZT8R7MtbOcDx2Ai0OGXE22kq+wS9eOMxAW/w4EiaCxO7W0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7904
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

SGkgTWljaGFsIQ0KDQpPbiBXZWQsIDIwMjYtMDQtMjkgYXQgMDg6MjIgKzAyMDAsIE1pY2hhbCBT
aW1layB3cm90ZToNCj4gVGhlIGZkdF9wYWNrKCkgZnVuY3Rpb24gY2FuIHJldHVybiBhbiBlcnJv
ciBjb2RlLCBidXQgaXRzIHJldHVybiB2YWx1ZQ0KPiB3YXMgbm90IGJlaW5nIGNoZWNrZWQuIEFk
ZCBwcm9wZXIgZXJyb3IgaGFuZGxpbmcgdG8gcHJvcGFnYXRlIGFueQ0KPiBmYWlsdXJlLg0KPiAN
Cj4gQWxzbyBmaXggdHlwbyBpbiBjb21tZW50OiAiU2hpbmsiIC0+ICJTaHJpbmsiLg0KPiANCj4g
QWRkcmVzc2VzLUNvdmVyaXR5LUlEOiBDSUQgNjQ1ODM5OiBFcnJvciBoYW5kbGluZyBpc3N1ZXMg
KENIRUNLRURfUkVUVVJOKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgU2ltZWsgPG1pY2hhbC5z
aW1la0BhbWQuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5k
ZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0KPiDCoGxpYi9mZHRkZWMuYyB8
IDcgKysrKystLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbGliL2ZkdGRlYy5jIGIvbGliL2ZkdGRlYy5jDQo+
IGluZGV4IGM2ZTEzYjZhYmVmZC4uMmQ2Njg2MGY2ZWQwIDEwMDY0NA0KPiAtLS0gYS9saWIvZmR0
ZGVjLmMNCj4gKysrIGIvbGliL2ZkdGRlYy5jDQo+IEBAIC0xNzgxLDggKzE3ODEsMTEgQEAgc3Rh
dGljIGludCBmZHRkZWNfYXBwbHlfYmxvYmxpc3RfZHRvcyh2b2lkKQ0KPiDCoAlpZiAocmV0KQ0K
PiDCoAkJcmV0dXJuIHJldDsNCj4gwqANCj4gLQkvKiBTaGluayB0aGUgYmxvYiB0byB0aGUgYWN0
dWFsIEZEVCBzaXplICovDQo+IC0JZmR0X3BhY2sobGl2ZV9mZHQpOw0KPiArCS8qIFNocmluayB0
aGUgYmxvYiB0byB0aGUgYWN0dWFsIEZEVCBzaXplICovDQo+ICsJcmV0ID0gZmR0X3BhY2sobGl2
ZV9mZHQpOw0KPiArCWlmIChyZXQpDQo+ICsJCXJldHVybiByZXQ7DQo+ICsNCj4gwqAJcmV0dXJu
IGJsb2JsaXN0X3Jlc2l6ZShCTE9CTElTVFRfQ09OVFJPTF9GRFQsIGZkdF90b3RhbHNpemUobGl2
ZV9mZHQpKTsNCj4gwqB9DQo+IMKgDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5z
IEFHDQp3d3cuc2llbWVucy5jb20NCg==
