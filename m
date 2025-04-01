Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473BEC36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 11:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C924482075;
	Tue,  1 Apr 2025 13:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PBEynZL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD09D82075; Tue,  1 Apr 2025 13:42:39 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20729.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::729])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2324381FC8
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 13:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nemcpV/qZbBSGxGV2/3cyWFIpmIvgFT267r47Go4ktQqSMG9aNzXjmI28MSPaaeqnpnxd1OGTFcX8kRo/bbK9VRGaAvMoBOv2S8gziTOjIUx8WAcY96Q/3RaagEcJ4fVual2iLbk0+G5taX5OBEKGYZXAL/vY141KipEl7a0WU97/2mpqCObNCsRp+Egpe15ifcEnKqcyM/0BRH9ygoOiudhn2OT/4gkXF6N3c6rBq0PrAzXr5QYQ/lfnnbNjvNcvP287zxUPwLBhat14A6sMN28DxusF1QppGEK791H3w4XCaQtASGq4Xiecy1hbqKA5+dfGUzINV4KbAJD/osUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMAWSmxRcUGSthyp/Ye7IE0fe42Hj1NVe44F4jk0O5Y=;
 b=UGHyFOEu40yGQfG7rlxm4JNg9AoFUeoeHqa/hGgbJFDz3262UY0mzBIxxCIhIpuFqutdVSwIckh5SBmjQa6+7NxBzz0XTRrZndiFP09ZrjPQqs1APmJIb1ACqmh/AhYFdTaUM3SvsNFHwTCsI19Pux6oBnLvPiCmjz7nJfF6SYgpd1/wDQsjRnajTGjpfBpq6uMidNDNTtUAmWOGNFYBvJtmQW7uDNEUxY1ybBsZKfSfFawD7NB08fW/wmn1EQ0IumOh1SHNL0WUK/xkaVtmvzWsKW2qUMTbddsXZ8ZpebHt/YPMSBuORorMyJ562R3CuHUCyBvcEjCQxQeeAp6O2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMAWSmxRcUGSthyp/Ye7IE0fe42Hj1NVe44F4jk0O5Y=;
 b=PBEynZL1e1H6cojbj7R9fj7nfJK43Y6nwLhhwRqMISQbn+VqbBXHgeRfngCrr78h9a+eOeBEkc5CJFhbsS4yWaKbujlaSwUgXs+jbr5JXs40u6pDN4i8TJlsj6sulUbqU3lyRIOGNOf/YiDU0GcbRD8pbcjqjMWe4SgUNuhpACjvq9zBrLVBAr2h2X6jUvJ5LdjushwkMWKc1RRS43XulClg5Wccqi8GeND3bx0Nh/hFXQLmTVog5pM6B8IF4fLqn37Ynk/nSmSQyQBlMOoz6CBHhslE7Dr+qUQaeYGsX3/oJHnIc7eQeuQKw4f02c2l08IuFTCBYNelQwC6fh9LDQ==
Received: from PAWP195MB2176.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:330::14)
 by DB9P195MB1516.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:337::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 11:42:35 +0000
Received: from PAWP195MB2176.EURP195.PROD.OUTLOOK.COM
 ([fe80::ea1e:17ff:23ca:3c0]) by PAWP195MB2176.EURP195.PROD.OUTLOOK.COM
 ([fe80::ea1e:17ff:23ca:3c0%5]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 11:42:35 +0000
From: Leonard Anderweit <L.Anderweit@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, "marex@denx.de"
 <marex@denx.de>
Subject: Re: [PATCH 2/2] CI: Build missing binman tools before binman tests
Thread-Topic: [PATCH 2/2] CI: Build missing binman tools before binman tests
Thread-Index: AQHbovcLqa+Ad2JDsU+pOXwXhDZLsrOOsGSA
Date: Tue, 1 Apr 2025 11:42:35 +0000
Message-ID: <5eb9bf4c4b30bf09fab544081f5733bf278103fe.camel@phytec.de>
References: <20250401084642.216933-1-l.anderweit@phytec.de>
 <20250401084642.216933-2-l.anderweit@phytec.de>
 <CAOMZO5AzKUUt3YpVWteiwb-DaqPdBjxXKwhXOo_5aZtacpkXzA@mail.gmail.com>
In-Reply-To: <CAOMZO5AzKUUt3YpVWteiwb-DaqPdBjxXKwhXOo_5aZtacpkXzA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWP195MB2176:EE_|DB9P195MB1516:EE_
x-ms-office365-filtering-correlation-id: 89fab813-c910-4340-d887-08dd71124c19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZVdQL0xuMmgrYnRkNmcyc3c1WWtQUmcrUVVzUnFNMS9FTVp1NUhtMVZxKzNz?=
 =?utf-8?B?VDY2eWNxTzRpWGd1YXMyM0NLVmJhOHlncWQrM2Zub1dTeTRjSU1Fd0Z1b2h2?=
 =?utf-8?B?TVhITmlnVElrMXhmbStGZi9nQURuVDFBeUQ1UzYvc1NFbUNLcnpuM3p4K2U2?=
 =?utf-8?B?WURCWHUyOU5IR0lxT0Z0WlB2MXB1dExoc0hRQnhhSm92bkpOV0MxQ3o1cWhC?=
 =?utf-8?B?L2FSR2R3WGFTVUN4eHdraXdWTmpyQUFQWE9pVmVCTzdEQWJPN1llZ1BCTDZ0?=
 =?utf-8?B?N3RmSkFBSWUzYkpxWDIxbGpoYzYwdVlRa3RMZXRXRUNUbnRzUWJvQUZya3V3?=
 =?utf-8?B?NkVKSjZ4OVFaSm1VZEUzNWVwNUZkTkJZU2JPMzB4d3Z1QTVXYXlmTVV5QTR2?=
 =?utf-8?B?N2xzZWJnT1NGZVRuN055bmo5ZXhSQTl1cUU2UGQ3dlUwQzY0LzAvb3pCTG5E?=
 =?utf-8?B?dWE0d1lkSzRob0JNSUpIa0VVOFA0c3d6VzVRTU4va0k0Rm5QZTlWY2NRTkgz?=
 =?utf-8?B?Q3hybWI4MkttbzZHYWNtdXdrb0l2Y3ZJTGRnQzB2eXlCMkhnR3hZR0QwVVZC?=
 =?utf-8?B?MHJxM0F2UEtmUXBIR3IzS3dha0dRK2x6T2s5TEtDR2VYblFObko3WXB0VzNR?=
 =?utf-8?B?WGNhbkhtQlRLbUFVQlUyYUxqQmU1dXFlTmxKYUFwaGZEWHRkdUptQlVEczFD?=
 =?utf-8?B?WGw4cFBReG9lVG9Ranp3S1p1enpsVnAraGV5RXk2U3VLV1JSY1kzMjRDR012?=
 =?utf-8?B?UmJYYnp2LzVRMUdvNDVTNUlvY2dDZG1XbTA5QzlFKzhFeTIrTHJqT3BMK3Ru?=
 =?utf-8?B?dmdQOUlqK2dvV3JDSGJVbGpscThrSmYwTFNkekFjUGx3eEtQcDQ5aWFSUUxk?=
 =?utf-8?B?eC9UTXc4VEhaL29MU0wwRzJWb0N2a2M4ZnczVHgveEQya0FFSjZKQXZMbU9Y?=
 =?utf-8?B?bzA1MGVmOGdYdks5Rkh3bmpYYkdrZXFmWENnMmhoRkY2bWM4ekZKNzM0UWNB?=
 =?utf-8?B?L1ZTd0ZnZVhsN1hiLzc0OGFqRHpmY1pNSWF1K3BtdERYTk5qVEZsN3c3MUY1?=
 =?utf-8?B?dnBJaHlzOWVCMTJLc1FOZVYzVmtaQllXdkJyWXZhOElkR1BLSkhMNVVkYm12?=
 =?utf-8?B?MHJJaTJKOWdBYmkrcWZOMlV3bzBJNFhKVmRZVjNyeHJDenU4U202UjBrS010?=
 =?utf-8?B?RkZCckkwdWhYQ1pBeTM0NkJXWWJjYnlON2ZHbXVCcHBJVGMvb25VcUUrQU1o?=
 =?utf-8?B?ejZFRzhzQktBTXhkOWh3K3RUZStGRHdqVnozUTJRN2JWWVh1T1p2WFdGMTZH?=
 =?utf-8?B?TnRRbkpoR2Mzc2lkanBBVnMwZThXQ2xLMGI0bXVGTXUwYm9pemZPU3AvMmtn?=
 =?utf-8?B?U3hqOUVmWTdZb2pPRnNvSGlqZ1ZYMjRFcVBURXZwYnRFdm9aTzhKaDlkMkVy?=
 =?utf-8?B?SzE1WHVXNU1DTDFudnBXL2NRUVFWQ05DbHArUytuTElPUjh2NWltd3pIeU9E?=
 =?utf-8?B?RS85V0MyZFNJRko1VllvR2JSODdYYWVibDJMbDE4QllpYVpsMUZHaFowQkp4?=
 =?utf-8?B?UUQyREJiQ0Y2ZWwwYWVRSi8vN3hLY0ZMVm54NFZ3Y29IUU96WDk2S3ZNOVkx?=
 =?utf-8?B?RzBVK01GZDdobGtweHkrWVUvYTJtNGk1WTg2K1NnVmtUa1NvRTMxems4YTdY?=
 =?utf-8?B?bVRRK2xxR0g2Rm1qL2xJR3BpdTJ2NVpUQTJzN1hoN3ZnN08yVjQ2U3F2MDll?=
 =?utf-8?B?TDl3SGtPVGQzL3dRWWJaem8vYXl5V0l1RkY2UHd1dVNKOGNRbnIwckYvS1pN?=
 =?utf-8?B?bnBYN1hCalpEYXRqTWwrQlVQK2tEWld5UE9JWnlWeDlvUjZuS2RoOVRuVm9L?=
 =?utf-8?Q?8Oi9kvWze65O2?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAWP195MB2176.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTJvRWJWM3VWZi9QQXRGY2s5ZTd2RERuaGxBZkVxMXJxSk9iNVduUjJRZEpn?=
 =?utf-8?B?Wmo2QUNncE9qUU04djF2U3pmbGpGUGpQOGNGREEvVUFNaVRsNTc1ZzI0azVW?=
 =?utf-8?B?Nzd2a05jR1pmekh0N2V5bHRBdXE5bnV4blYvdUNhWUM1UEIxc2RvVlZxdjU2?=
 =?utf-8?B?QjhIUzZGbFlrYWQxY2VSQVM1QTFIdlBKTmJ3T2tjM1Y4UnhkdnQweHZSMGVK?=
 =?utf-8?B?ZXM1MHZ2TE1JbGRZbHUyc00wTmE0T245ZWxvOXZWai81TVNWYXpGVGNXRUpR?=
 =?utf-8?B?WkV1VUxrMmhCNEF6d2FqSUNGS3R0TGlMVW12N2NhcmR3RUsydDJyUXBqeGNn?=
 =?utf-8?B?ZGN4YThpeE5RQ0tXNWNVL2hITTQrL0dZRXovemswdWt2dGFNZSt5TU1UbFpw?=
 =?utf-8?B?VzN2L1FOYU1mLzdmNXhNWWkyek8xWnBaRElxSjFsOWFmQi9WekhVWnBhdjVJ?=
 =?utf-8?B?dUJoMzBaeERQYVgzMHZjZzg1QUVmNzhEYUduMGN4SkZVZ1FRcitIT1d0emdT?=
 =?utf-8?B?MzJ3SSt1Tkg2M2NVOVRWbGVjM0w3TjVDeVRvcTRaTVNteWFpczdEeGlydGF4?=
 =?utf-8?B?bXhyMXE3a0JnRzc3R0ZIRHdwcm5kWStGZEQ5UE9MN3NTZDVBQlRTeVpIbjVM?=
 =?utf-8?B?QzBnRVdnUWdSMzhHcUw0V2lSQkc2OVkrSFo3R3h3R1BQOUpPTHBDVndvVC9C?=
 =?utf-8?B?T3FYeVFUSTg1SCtUYmtBK0xBS2tVY2owdE5MRXI5eERMTEwyTjdjUVNSaVd1?=
 =?utf-8?B?bkE3b2l6V2RDS1hxVmtPOTZKWjYvOHg1U2ljWjgzZVFqTjVUaGhTQlUwTW1s?=
 =?utf-8?B?OFlKZFlFSWd3ZTRpNG80SE1sR29ZdFlPcWJqTWpFd3M3MVcwN1BWQWNLSkdH?=
 =?utf-8?B?OCtTMVhWUFdvaW9PVEZRSi9xODlnUjVuZW15MHg0RnMxR3BGZjVHUkovcmZy?=
 =?utf-8?B?b1Y1Mm5kMGZOMllBVDVoanpVS2JTT0UvWnFqNVY3NHVFZ0VqeXNkM1FyRXp3?=
 =?utf-8?B?cTltOXBIbVdqRWpJOXJNWFJkRlpMR2FvVmxKZU1xdmFrRThjUzNTQnZnKzB5?=
 =?utf-8?B?dUhyVENacjFUV2pqL0RHV2hYL1E1bUlLR2JXdTh3MVF5Z0xTcUtZMlRyMFdl?=
 =?utf-8?B?aW5UdzBGR1EyR2V0TGJzN0czeTlGS3p6OEJTcFErLy9GOXRTTXFhUGpkMWEr?=
 =?utf-8?B?Z0x1TkU4enAweno4YXJCRUpma1NHUlJRdHVZSzA5bVJpMFZpL2ZrYWJXMWcx?=
 =?utf-8?B?Y21Ca1J0bVo0SGwyby9mcldUM0pqaVBRUnV5RFFCbVQvaHc0cFlTaWVUQ0Jo?=
 =?utf-8?B?NENaOUdFVm5jN1JxbkpxbFYwdUozaW5mRldvcWtJY3FSOGRJa3VZRVpHaXlT?=
 =?utf-8?B?Mk1WSHRMN0EzZjVIemlaZUNwODFsSjE1MUdwdGUyRW8zRHhCOHAycERhSHcx?=
 =?utf-8?B?RzZjMHpWdjVFYkpDcExrcXpzVkRkV21LZ2xUSVloM2RBb0gxcXlNNXdjeHFa?=
 =?utf-8?B?Rng2bGFwa1VibVBiVHNOek51US9sTUlDWUQvaXlQRU5zenpGRVFFSE5lNlEy?=
 =?utf-8?B?UWJiemtsUG1EdUh0N0VnWFpmUENERFFrMjJrTXdwYzI4NWVvNTdOQ1kzYk1h?=
 =?utf-8?B?OGxrZnI2M2N4QW5QRTdDSlYrNkdyRzQvZVRVRXh3SFIwMVZsOWcrK2o2c2ph?=
 =?utf-8?B?c09tUlkzZTdpSE9tUGg3ZG1oUHNsOTJaZkozc0xNS3l2czFsL0lRY0NlSlJD?=
 =?utf-8?B?djVZeHAwMFdRdlF3UzY3RUNOZkJraTlId2NKSmlFMUx2WU44Y28zYUdDWTFy?=
 =?utf-8?B?MjZQN0JIT29jNVBEZGhSY3B5bXFoaGVNYmVJdzloZXRURVZhUEZLT05PZm5R?=
 =?utf-8?B?VXVWQ1JwL3RlelNaZFRKL2ZhQkJLYmo3Vmk0bWg3dlVId0pHVTJueWdMQS9F?=
 =?utf-8?B?dVMrVE55Q0lNWUxuMjZjOElONmRFUHZUd0xXdVhrNXhoZ1YzNWRGNkdWVHNT?=
 =?utf-8?B?M0tZSUJuUUE4cXRtR1lFYllQMEpFMThQak8reEROWXlpREY0dHBVdXhrYzhQ?=
 =?utf-8?B?d2tpUlk1SDc3dU0xbHRkYXJ0K2ZqYlRQNU1pMzMxWUI4dS9FeUttV2dDUHBs?=
 =?utf-8?B?bFpvNFYwTkVURERadUw3dlZsN0d1M3ROTWV5VEJObDhEcjEzOVRPNE1uYkk0?=
 =?utf-8?B?TUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D7E87094758594BBC69986E7B118E49@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWP195MB2176.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fab813-c910-4340-d887-08dd71124c19
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 11:42:35.6110 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jhAANl8P2z4WKXkJEITNFvTOnPoo6gQBzrJ/QBTFSjye85yt3U8fwKhlI0X2AvFXyWJTw2gUA+EXGNhEzwSoIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1516
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

SGkgRmFiaW8sCgpBbSBEaWVuc3RhZywgZGVtIDAxLjA0LjIwMjUgdW0gMDg6MTIgLTAzMDAgc2No
cmllYiBGYWJpbyBFc3RldmFtOgo+IEhpIExlb25hcmQsCj4gCj4gT24gVHVlLCBBcHIgMSwgMjAy
NSBhdCA1OjQ24oCvQU0gTGVvbmFyZCBBbmRlcndlaXQKPiA8bC5hbmRlcndlaXRAcGh5dGVjLmRl
PiB3cm90ZToKPiA+IAo+ID4gVGhlIENJIGltYWdlIGRvZXMgbm90IHNoaXAgd2l0aCBhbGwgdG9v
bHMgcmVxdWlyZWQgZm9yIHRoZSBiaW5tYW4KPiA+IHRlc3RzLgo+ID4gSGF2ZSBiaW5tYW4gYnVp
bGQgdGhlIG1pc3NpbmcgdG9vbHMuCj4gPiAKPiA+IFNpZ25lZC1vZmYtYnk6IExlb25hcmQgQW5k
ZXJ3ZWl0IDxsLmFuZGVyd2VpdEBwaHl0ZWMuZGU+Cj4gCj4gSSBhcHBsaWVkIHRoaXMgc2VyaWVz
IHdpdGggTWFyZWsncyBwYXRjaCBvbiB0b3AuCj4gCj4gSSBnZXQgdGhlIGZvbGxvd2luZyBDSSBl
cnJvci4gUGxlYXNlIHRha2UgYSBsb29rOgo+IAo+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1i
b290L2N1c3RvZGlhbnMvdS1ib290LWlteC8tL2pvYnMvMTA4NDEzOC9yYXcKPiAKPiBTdGFydGlu
ZyBidWlsZC4uLgo+IAo+IAo+IMKgwqDCoCAwwqDCoMKgIDDCoMKgwqAgMCAvMcKgwqDCoMKgwqDC
oCAtMcKgwqDCoMKgwqAgKHN0YXJ0aW5nKQo+IAo+IAo+IMKgwqDCoCAxwqDCoMKgIDDCoMKgwqAg
MCAvMcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRvb2xzLW9ubHkKPiBDb21wbGV0ZWQ6IDEg
dG90YWwgYnVpbHQsIDEgbmV3bHkpLCBkdXJhdGlvbiAwOjAwOjIwLCByYXRlIDAuMDUKPiBGZXRj
aGluZyB0b29sczrCoMKgwqDCoMKgIGJvb3RnZW4gYnppcDIgY2Jmc3Rvb2wgY3N0IGZkdF9hZGRf
cHVia2V5Cj4gZmR0Z3JlcAo+IGZpcHRvb2wgZnV0aWxpdHkgZ3ppcCBpZndpdG9vbCBsejQgbHpt
YV9hbG9uZSBsem9wIG1rZWZpY2Fwc3VsZQoKYmlubWFuIG5vdyBmZXRjaGVzIHRoZSBtaXNzaW5n
IGJ1aWxkIHRvb2xzLgo+IG1raW1hZ2Ugb3BlbnNzbCB4eiB6c3RkCj4gRmV0Y2g6IGNiZnN0b29s
Cj4gLSB0cnlpbmcgbWV0aG9kOiBiaW5hcnkgZG93bmxvYWQKPiAtIGRvd25sb2FkaW5nOgo+IGh0
dHBzOi8vZHJpdmUuZ29vZ2xlLmNvbS91Yz9leHBvcnQ9ZG93bmxvYWQmaWQ9MWd4TnhSdUpnRDBJ
aXk5TEFQQ1NCXzA5NTllSkNwOThnCj4gwqDCoMKgwqDCoMKgwqDCoCAwIE1pQsKgIFvCoCA0JV3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDAgTWlCwqAgWwo+IDklXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gMTQlXcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBN
aULCoCBbCj4gMTklXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gMjQlXcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4g
MjklXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gMzQlXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gMzklXcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMCBNaULCoCBbCj4gNDQlXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gNDklXcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULC
oCBbCj4gNTQlXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gNTglXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gNjMl
XcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMCBNaULCoCBbCj4gNjglXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMCBNaULCoCBbCj4gNzMlXcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MSBNaULCoCBbCj4gNzglXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMSBNaULCoCBbCj4gODMlXcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMSBNaULCoCBb
Cj4gODglXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMSBNaULCoCBbCj4gOTMlXcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMSBNaULCoCBbCj4gOTglXcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMSBNaUIKPiBbMTAwJV0KPiAKPiAKPiAtIHdyaXRpbmcgdG8gJy9ob21lL3Vib290Ly5i
aW5tYW4tdG9vbHMvY2Jmc3Rvb2wnCj4gRmV0Y2g6IGNzdAo+IC0gdHJ5aW5nIG1ldGhvZDogYmlu
YXJ5IGRvd25sb2FkCj4gLSB0cnlpbmcgbWV0aG9kOiBidWlsZCBmcm9tIHNvdXJjZQo+IC0gY2xv
bmUgZ2l0IHJlcG8KPiAnaHR0cHM6Ly9naXRsYWIuYXBlcnRpcy5vcmcvcGtnL2lteC1jb2RlLXNp
Z25pbmctdG9vbCfCoHRvCj4gJy90bXAvYmlubWFuZi5lbmJxNGtsbicKPiAtIGJ1aWxkIHRhcmdl
dCAnYWxsJwo+IEV4Y2VwdGlvbjogRXJyb3IgMiBydW5uaW5nICdtYWtlIC1DCj4gL3RtcC9iaW5t
YW5mLmVuYnE0a2xuL2NvZGUvb2JqLmxpbnV4NjQvIC1qIDQwIGFsbCBPU1RZUEU9bGludXg2NAo+
IEVOQ1JZUFRJT049eWVzJzogbWFrZTogYnlhY2M6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkK
CmJ5YWNjIGlzIHN0aWxsIG1pc3NpbmcgaGVyZS4gVG8gc29sdmUgdGhpcywgdGhlIGNpIGJ1aWxk
IGNvbnRhaW5lcgpuZWVkcyB0byBiZSByZWJ1aWxkIHdpdGggdGhlIGZpcnN0IHBhdGNoIG9mIHRo
aXMgc2VyaWVzLgpUaGVuIHdlIG5lZWQgYW5vdGhlciBwYXRjaCB0byByZWZlcmVuY2UgdGhlIG5l
dyBjaSBidWlsZCBjb250YWluZXIgaW4KdGhlIGNpIHBpcGVsaW5lLiBBZnRlciB0aGF0IGJ5YWNj
IHNob3VsZCBiZSBhdmFpbGFibGUgYW5kIGNzdCBzaG91bGQKYnVpbGQgd2l0aG91dCBlcnJvcnMu
CgpMZW9uYXJkCgo+IG1ha2U6ICoqKiBbLi4vYnVpbGQvbWFrZS9ydWxlcy5tazo0NzogY3N0X3Bh
cnNlci5jXSBFcnJvciAxMjcKPiBtYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2Jz
Li4uLgo+IAo+IC0gZmFpbGVkIHRvIGZldGNoIHdpdGggYWxsIG1ldGhvZHMKPiBBbHJlYWR5IHBy
ZXNlbnQ6IDE2OiBib290Z2VuIGJ6aXAyIGZkdF9hZGRfcHVia2V5IGZkdGdyZXAgZmlwdG9vbAo+
IGZ1dGlsaXR5IGd6aXAgaWZ3aXRvb2wgbHo0IGx6bWFfYWxvbmUgbHpvcCBta2VmaWNhcHN1bGUg
bWtpbWFnZQo+IG9wZW5zc2wgeHogenN0ZAo+IFRvb2xzIGZldGNoZWQ6wqDCoMKgIDE6IGNiZnN0
b29sCj4gRmFpbHVyZXM6wqDCoMKgwqDCoMKgwqDCoCAxOiBjc3QKPiAvdXNyL2xpYi9weXRob24z
LjEwL29zLnB5OjEwMzA6IFJ1bnRpbWVXYXJuaW5nOiBsaW5lIGJ1ZmZlcmluZwo+IChidWZmZXJp
bmc9MSkgaXNuJ3Qgc3VwcG9ydGVkIGluIGJpbmFyeSBtb2RlLCB0aGUgZGVmYXVsdCBidWZmZXIg
c2l6ZQo+IHdpbGwgYmUgdXNlZAo+IMKgIHJldHVybiBpby5vcGVuKGZkLCBtb2RlLCBidWZmZXJp
bmcsIGVuY29kaW5nLCAqYXJncywgKiprd2FyZ3MpCj4gL3Vzci9saWIvcHl0aG9uMy4xMC9vcy5w
eToxMDMwOiBSdW50aW1lV2FybmluZzogbGluZSBidWZmZXJpbmcKPiAoYnVmZmVyaW5nPTEpIGlz
bid0IHN1cHBvcnRlZCBpbiBiaW5hcnkgbW9kZSwgdGhlIGRlZmF1bHQgYnVmZmVyIHNpemUKPiB3
aWxsIGJlIHVzZWQKPiDCoCByZXR1cm4gaW8ub3BlbihmZCwgbW9kZSwgYnVmZmVyaW5nLCBlbmNv
ZGluZywgKmFyZ3MsICoqa3dhcmdzKQo+ID09PT09PT09PT09PT09PT09PT09PT09PSBSdW5uaW5n
IGJpbm1hbiB0ZXN0cwo+ID09PT09PT09PT09PT09PT09PT09PT09PQo+IC4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgo+
IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLgo+IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgo+IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uRS4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgo+IC4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Lgo+IC4uLi4uLi4uLi4uLi4uLi4uSW1hZ2UKPiAnaW1hZ2UnIGhhcyBtaXNzaW5nIGJpbnRvb2xz
IGFuZCBpcyBub24tZnVuY3Rpb25hbDogY3N0Cj4gCj4gU29tZSBpbWFnZXMgYXJlIGludmFsaWQK
PiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4KPiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4KPiAuLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uSW1hZ2UKPiAnaW1hZ2UnIGhhcyBtaXNzaW5nIGJpbnRvb2xzIGFuZCBpcyBub24t
ZnVuY3Rpb25hbDogY3N0Cj4gCj4gU29tZSBpbWFnZXMgYXJlIGludmFsaWQKPiAuLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLgo+ID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID0K
PiBFUlJPUjogYmlubWFuLmZ0ZXN0LlRlc3RGdW5jdGlvbmFsLnRlc3ROeHBJbXg4TUNTVE1raW1h
Z2VNaXNzaW5nCj4gKHN1YnVuaXQuUmVtb3RlZFRlc3RDYXNlKQo+IGJpbm1hbi5mdGVzdC5UZXN0
RnVuY3Rpb25hbC50ZXN0TnhwSW14OE1DU1RNa2ltYWdlTWlzc2luZwo+IC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+
IC0KPiB0ZXN0dG9vbHMudGVzdHJlc3VsdC5yZWFsLl9TdHJpbmdFeGNlcHRpb246IHN0cnVjdC5l
cnJvcjogdW5wYWNrCj4gcmVxdWlyZXMgYSBidWZmZXIgb2YgNCBieXRlcwo+IAo+IAo+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+IC0KPiBSYW4gNTgxIHRlc3RzIGluIDguNzE3cwo+IAo+IEZBSUxFRCAoZXJyb3Jz
PTEpCgo=
