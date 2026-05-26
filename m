Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816C9CD5BCF
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 06:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19D683FF5;
	Tue, 26 May 2026 08:51:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="bvtFmMHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36AAB8404D; Tue, 26 May 2026 08:51:05 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B96A083EF9
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 08:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JQa0kORffbM8OzDhnakYx//YTDwMSGA/qgbRutwjgiL12i5wAiLwINSHDsTVF0WlOKny2mQmilDNoYgw1+wkEc8pWxZk3z7EglIEPoHwmVttIRQdzaLwjV3Z5N4Jg1RQNiQZcjExOYyO7/Hm+9SAY6uQc9HZXz4WAXOj6SUtXf1HwT4aQIKOvbYWzMgooNXgqWuXhUxTZPZdu/3H7CUS0URNrwTyPu92gvcBGUekftQAASCNYRngo32NpUWWUM710GMcOg/aQt7Jpaz+5rPUYAMhj+5q4nDooCZRwEasV5g3YX9a6QKBOOWlHtoWnzBn9HrL8GtvIGB5EmQuWr7G1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d75HJhAVdnYnrDZSwF+UKd//Muf5pG0oSSxo8tiA394=;
 b=EoRkhd/0mCnuCe948PVq/GdszfVTK6eJrQ19l3Buue7o8vI0vxRkTrrIGN5NOGDYxvJeX4kwKHjLh62DMKPpI5zK7cVPHNdXjPo0HVrSt3AnYgfMufpYXJl3k+COEGEBr4fyeCy7jSAF/eIVCzO5BXfnKXa7zFhDwK8rcm+dlRGRxFpTlhw2ne8oq4y/4s09MuDKVEgGFLVKyJ1uWNtQrcupwIHjUrRBSFUO+WYIIf6Cs9wRByjFw6V1NNzOGqXSkgJy9GfkG4AFhfluGFhMarH7iZ0uBKqUppg8TMYKJVh2X4jEe/zRF8QBBaQwL/+wtVv9ZEyHpMN65FLsjatYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d75HJhAVdnYnrDZSwF+UKd//Muf5pG0oSSxo8tiA394=;
 b=bvtFmMHH6dyNh7pQqzR2ON1EkLJ4dIqfRdM10ESl7pVbw92WybEGj4qH6/kjQ/zijRtj5I+i3bqRB2YdgIRXKZYC5w3VPlpjwkSOsH2h+ejl+Dlmay8K5ftXTNKM7sSpCGDl0M+1Fa83JY1r1JOqK13pcTlcXw1FrEoeyq/lEXl/gR6w0H0SWxdiSmk9e/4WLPZP9plh91C82uilUubzdCMUA0f2Y51eWmtd65KDna2lKqcucrkIfScX9bKU5ivz3z9xOwmFmDwkcKiC2sgEKrC2SptTi8BwV+UQ+D03Sg48OvBlfcraq+Op2V8W1fDk6AMiF5TUaS9sdQrmnVUfEw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB7996.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 06:51:00 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 06:51:00 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v3 9/9] drivers: Kconfig: rtc_pcf85063: note unsupported
 chip features
Thread-Topic: [PATCH v3 9/9] drivers: Kconfig: rtc_pcf85063: note unsupported
 chip features
Thread-Index: AQHc6gFnAVhAtaKGQk26x3ZDaZlA4bYf5AGA
Date: Tue, 26 May 2026 06:51:00 +0000
Message-ID: <494910afd80143f9c32483e8ba6c6d75057d497d.camel@siemens.com>
References: <20260522153929.2472552-1-Alexander.Feilke@ew.tq-group.com>
 <20260522153929.2472552-10-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260522153929.2472552-10-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB7996:EE_
x-ms-office365-filtering-correlation-id: 95e38d01-b341-4a2b-4445-08debaf325a3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|4143699003|18002099003|22082099003|56012099003|11063799006|38070700021|55112099003;
x-microsoft-antispam-message-info: 9mDOisNi0YtOymyi7SZD/bQ8ck2ha6QxvKTZgS2FXBUYZFPbBeMJk1bhyrIX/saIDwkmaOHOlAyX33NAhAvZwgcqHqeMDiNZawpZIlyFAwQmhyiE1IqXWlLW6Rapj/eSdftCqYcmss6Surw98Ee5KMh8iOvTiLf4s9gXBNibf0cVno6/87+ZX9vDgOCZi+LUEUZX7J4AhqpTny8sfH0Z/cmGvbMfhjI2Pv03F4rhwXibSYYlFWwxYcgeyjwu09ZUjU0FC9lQ9QRUJMZWvQvWWFMe/Tic5K/ID26QlvKT2OhH1V8wAngrlo7t9+jyAU9cfo/9Wgv3bzx9IC94ZOJjJx1badWIVinwCMD46W1SoAGsW8805ETCYC4gQgG5fHW7VuTllqWH5fMOfD7uGgiq388vpdYpwLPR9Ee7tn1vtUxqRXarC+hHvTS3sasQrh+keCVZSORXKWT+BNg7t7jMlICXLptJoLelfJ/jgRUTBAjjOmf+pX49e0MQG8E5Zt5zCV2Mimu78dcPrRYDIQ5FOVLu07vtLvlRkNm6ygmMP0Iu+2ajtvO3/qrSdJihV9/hbzRpnSXS3CJbRM7EOsCv8LC7CIuWrxtYA9hqo2osrOzd4SWEmtHIlzjs0UQ1Fx7IrMC8s9rP6JlOdB9vImFacn08rP2i+Xim8SDaenn4gGZkgPcAffsXO8WCCi4u7K9k2gOFeHYIMUD3Dj3fGpvgkw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006)(38070700021)(55112099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sy9YNVBLenlodTYyTkVZMkhzVkRrZlhSQkhDWFVYQy9DVUJwbFduelBiZ012?=
 =?utf-8?B?SHhyWEFsalQ2ZDNsUUhXVEhoOHg1UTVXYVNPZVp2eDZHRDhQb28ySk16OHg5?=
 =?utf-8?B?aTFRQmdMQ1p1aDRnMDdNZDVKQnZUOUVWV1ljS091c3Blc0NFV040ay93MVZ1?=
 =?utf-8?B?WWZHYThkdDFrV2IvMXJsMzgzUGN2d1ZORjMrZ2pnZDRkSGEzS1BQYUo4M1g3?=
 =?utf-8?B?dlVscENVaTB3aktRMVZhTk8weVU1a3cySEE4ZloxbytobWZjQ25yeTBLaWI5?=
 =?utf-8?B?alNzWUxjUnI2a2RlcElnN09PSFhzdXplcUlac1o1Z2t4dEg3aXBqMzlkRVpU?=
 =?utf-8?B?bWhUaTRnUUdVSXVWZ3lqNnNVekJ6akYxNE5rZlFqWG9LRlZWTGc1SU5XVDJR?=
 =?utf-8?B?M1lLZS9ORDhIK1RzZEpSSzRQMGFxRThrWkIvZ3VWTFpHQnFkZldXY3FTd25P?=
 =?utf-8?B?N3pJMXBTUDMxTVJZTmpJSVIxanZhQUxUWWpjOEhpdExvTUlWZ3RicTFWZmk3?=
 =?utf-8?B?N0FpUXZSNmFaZ1NqUTU3Y25RS0swd0xsT1FIRnRmYU9uMXZrckJEZUM0NlNm?=
 =?utf-8?B?Y1IrRGRsZG9adUVOcXdubEV3R2pFZ1NESmtlUVNWblFlK0UrbU5lc0kydVhW?=
 =?utf-8?B?N0lzNURhZG9OOVM3MlBpOWVxL3NKR0swOEFRa04xS1dnNmVFR3VHZWxJUmk5?=
 =?utf-8?B?bk1wVDE2c1RadEdZU0lMU1JsUjFBL05JM2NFd1FtZGY2VStXOUxsUWh3bmNL?=
 =?utf-8?B?M0tiVU1IWGNiVk9sbmRuZjlnSURnUlRGMWhPU1o1bUwzSzAvdzlwL3JDL3dX?=
 =?utf-8?B?RGpZK1FWOGUrRnNnajdKS3QxNnJiYXY3SWpIaWlSQm1aRFI4TTV1OGQ2MzhJ?=
 =?utf-8?B?YlQ2N1JjcW0xTHBNMCtxZlhvZjY5R0FjQTZRN2NKMHpPbGZzTnVpWnpVaXAv?=
 =?utf-8?B?QmNaa2lHeFRITzM0eFZ6eml6MmNnWUJvNmIyZURMS3FKek9MUzdSMUlvTTVY?=
 =?utf-8?B?MW84YVUxdXR1bXVEME1obklvQnhiVmRWTVBHUlo4aWJjL00yd2laRDFUaXFO?=
 =?utf-8?B?SkprTi9zWERQRDg0cVpTcjN5RTNUMDIwZW5iNGVJVzM2WVlra3lBZnpOckYr?=
 =?utf-8?B?ZEFUenJXbGRmb293SmhnaUZ2MHZvcDRhZUZCd1VpRmNBek5wdU9hK01BeFpC?=
 =?utf-8?B?U3lOT0ZrOUkrUWRXNitRU3FVVFNHVktFVFZxSGgxNEhhSlV5bmFXd050Qnha?=
 =?utf-8?B?anBVbnRqNWxxbXhlWTZERi9FQWk0NUZsRURFY2Z4M0hDZVlFZ2swKzV1RTBW?=
 =?utf-8?B?am5wQkQ5RTY3MHhyZmJnblg2L2dJT1AzcFBESXdZdDBpWjdwTmg0c0Z2anRl?=
 =?utf-8?B?ZE1uKyt1T1o1YjRUZldjSktCNTJuTitFQVk5WU01VG5BYW5CUGtyOTVrOWRw?=
 =?utf-8?B?OGNzVVQyN2ZxNzZKTVpsQ3RtdUtvNDBERVcxcWg5MzdReU5PM2FSNWFucXlN?=
 =?utf-8?B?V1NRWTFLRG9ibW0wMjZxSWptNGRUZHErMjNIWjIvdkxleWVCQllMaWFZQmQ5?=
 =?utf-8?B?bVZuNTBUMHB6WXFWZGxCQlZlTVY2aGFRb0JwQjBQL3FiNWR3WEV5TE9ia1U4?=
 =?utf-8?B?eWZhS2F5MHl4K0cwS0k3WUFXVWwxY3d1STV6WFF3MTh0VjZseWdGbitSRzd4?=
 =?utf-8?B?TWNEV2tmbXlZQWlOYTNuYWQ2REdmRVRzaklQZEdzZG40V2pRMkN3Z2NDWGlU?=
 =?utf-8?B?bkZ6VDNpUkdnUi9RbFhWQm5lNVAzWXc1T050TmhueUQwaFR6VVpQNzY3Y08z?=
 =?utf-8?B?RFB0Q1lrYzZERThpdnhoSHpYV040dVNEKzlqZmRmNERURWhidUxzQzZoVS8x?=
 =?utf-8?B?aS92OEk1eEQwbnoxdFg4ZGRJVk91SFNUVHpXOGJDaHl1b0xZcnl5SHcvZEh5?=
 =?utf-8?B?MUx3SUNFVG1NUWREdjlQbVlsRlZXaE5Qa1hDR0sxLzd4SG1UV21HWTRvYkht?=
 =?utf-8?B?a05yaHUrdTlsb0tPTmErT1M1V0djMmZPVFo5ek1UdHpoOWNldkVlaGNzNEZZ?=
 =?utf-8?B?d2dRNm9DQWZEMTNxMFVHbFQwZVkwN0gyei9NazQ0blJ2OE9hNUlnaDFITk91?=
 =?utf-8?B?MXg3czlCWGt4dTR4eitKRzhUYkk5dkt5UmlGSWxna0I2ZFZqWHkyS0NKUEhk?=
 =?utf-8?B?YUJTT2lVV3QrNFAvNlI0L2RLR3FEUCsxc1ppcHJ4aXhOVVc3T3RKWWU5Z3lX?=
 =?utf-8?B?T2F2VG1WRHVlTkVwMkQyekdLR2lTYTJjQis1a085bENhcUp1UlAreDRaSE1E?=
 =?utf-8?B?bWQ1azMvcFo0QWFac3JOZDUvcVFRR2tzT01Yc0NGNkhvdDd3ZXh5TUhLRnAz?=
 =?utf-8?Q?9G/Nsohm6MAv/FUY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <56A9DB24F197E14997927D1AF44D9C9A@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e38d01-b341-4a2b-4445-08debaf325a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 06:51:00.3293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tofdJOQvhGMXWX8+eymBe+HKeCsntM9Jjv7boxAHZYeUkGbmQF5fDjvkE2EdqTD1AuW114yLDiHVPhHJIfYUxzsbhvkvHjk7SuXeKB85mLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7996
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

SGkgQWxleGFuZGVyLA0KDQpPbiBGcmksIDIwMjYtMDUtMjIgYXQgMTc6MzkgKzAyMDAsIEFsZXhh
bmRlciBGZWlsa2Ugd3JvdGU6DQo+IEZyb206IEFsZXhhbmRlciBGZWlsa2UgPGFsZXhhbmRlci5m
ZWlsa2VAZXcudHEtZ3JvdXAuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZGVyIEZl
aWxrZSA8YWxleGFuZGVyLmZlaWxrZUBldy50cS1ncm91cC5jb20+DQo+IC0tLQ0KPiDCoGRyaXZl
cnMvcnRjL0tjb25maWcgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0Yy9LY29uZmlnIGIvZHJpdmVycy9ydGMv
S2NvbmZpZw0KPiBpbmRleCA2NWQ5YmY1MzNjYi4uM2I3NDc3MGIxOGEgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcnRjL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9ydGMvS2NvbmZpZw0KPiBAQCAt
MTYzLDYgKzE2Myw5IEBAIGNvbmZpZyBSVENfUENGODUwNjMNCj4gwqAJaGVscA0KPiDCoAnCoCBJ
ZiB5b3Ugc2F5IHllcyBoZXJlIHlvdSBnZXQgc3VwcG9ydCBmb3IgdGhlIE5YUCBQQ0Y4NTA2MyBS
VEMNCj4gwqAJwqAgYW5kIGNvbXBhdGlibGUgY2hpcHMuDQo+ICsJwqAgU3VwcG9ydCBmb3IgdGhl
IGZvbGxvd2luZyBjaGlwIGZlYXR1cmVzIGlzIGN1cnJlbnRseSBub3QgaW1wbGVtZW50ZWQ6DQo+
ICsJwqAgLSBOVk1FTSBkZXZpY2UgZm9yIFJBTSByZWdpc3Rlcg0KDQpJIHdvbmRlciBpZiBhbnkg
ZGVkaWNhdGVkICJzdXBwb3J0IiBmb3IgUkVHX1JBTSBpcyBhY3R1YWxseSByZXF1aXJlZCBpbiBw
Y2Y4NTA2MyBkcml2ZXIsDQp0YWtpbmcgaW50byBhY2NvdW50IGNvbW1pdCBjOGNlN2JhODdkMTU2
MGJhYmM5ZjE0MzYwMzVjZjJiMzMyZjRmNjAzDQooIm1pc2M6IEFkZCBzdXBwb3J0IGZvciBudm1l
bSBjZWxscyIpIGFuZCB0aGUgcGNmODUwNjMgZXhpc3Rpbmcgc3VwcG9ydCBmb3IgZG1fcnRjX3Jl
YWQoKS4NCg0KSSBzdXBwb3NlIHRoZSByZXN0IGNvdWxkIGJlIHNwZWNpZmllZCBpbiB0aGUgRGV2
aWNlIFRyZWU/DQoNCj4gKwnCoCAtIENMS09VVCBnZW5lcmF0aW9uDQo+IMKgDQo+IMKgY29uZmln
IFJUQ19QQ0Y4NTYzDQo+IMKgCWJvb2wgIlBoaWxpcHMgUENGODU2MyINCg0KLS0gDQpBbGV4YW5k
ZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
