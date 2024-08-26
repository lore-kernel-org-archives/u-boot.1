Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A803C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 01:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CD358842C;
	Mon, 26 Aug 2024 03:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="cygfPGqO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E787888795; Mon, 26 Aug 2024 03:43:46 +0200 (CEST)
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-sgaapc01on20720.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:feab::720])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6446088356
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 03:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chiawei_wang@aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFz3csP9MCl7JwmXdYQynJSXDDQtXmlAUy40DeU6SRfZd4YiHDakLS6tkU1F9aepihGOWV9hCSuWYhSddlLeMs6RufaJuG+BDc0DAvEmGWJXdZVyoQjfHNd8saBbmpioKbmgTDa3NN5uQEg1ZNCPzPU4m8BVconC7xcYM6NyAQsJ4b0mwdrjq+GD9rOfD6ntX8c1RjQMyrCZQ7de6hRsBlMU6K3BbKmAdmUnU+x4JPeWAXUC6OKmMfx5CYcxWlG+tnHIfU/f2OohNwKsQjFQ6RAuMhBg19pDU6TP3jS+rIoavYba7Oi2CxmrCy38hNTjy9uU2fKELyZJncL3wseIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHJMA1XdefRb8APFS5ePHbp6KiuhqcEDuG/Z9wOBqcA=;
 b=FuD3f5OGhX5/b2YvwMfYcCOuKettW5JA8sNV9jEnOMf/VvwbTYHGugVmt+JRoJmNZ6k1V/3Y6KOdvBCY7rCbgrXUYYKurjJwv1mI+r/VMPXHBHwXQpHqhvzZWBjMRKnCoy6pS2yVoRbTbuq86v/k/fusrqQHY+FfhcjSTefMkQw90mcYnlpkhzHMW6UbCKsuUkEzY/ur2bp7uw/cSVIEh4nP0YYf7OkEaPLuUgZzYBx1KlgpRbq1MGo/eQo2RZBaTf2zOLa4fODF+tAzG8a5byQhF1lL2A24QsPOupbcyB6cwOx/cZaEQZ/uKjO0aVzo6k7XUnyxwNeemVwSP2JCUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHJMA1XdefRb8APFS5ePHbp6KiuhqcEDuG/Z9wOBqcA=;
 b=cygfPGqOqy+mjV6wTyZPTg4fHuzlxOwGeg0NIpHVLzB1ECa6LAi5yr2A+VcU7qTt1UV8sdr1p89MUQ188y/QNr9fEofj1eF7XergohB0DL2JSwH4vZbIpTxpFu4OblCg8v3OQ8TYSqMzFrU2Cvw31aOaCmWWX+F2J5zSXtBOhSjseXdMDIDzWRgtQAKRG4RDNC8tBN5OesoD796Z9UL1w0I9OvS7mOCaD3ByjMVL1tRbMvjfUmJToCnAyO3Ds1D6kZyVl34U9qAIjU80sUukS4teVv6hDIR41sltoRGaO63r+xzrutS7XkBUy4FQGx6r+wvPDfX7FSZA4YSUBlQEIg==
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com (2603:1096:820:f9::5)
 by SEZPR06MB6925.apcprd06.prod.outlook.com (2603:1096:101:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 01:43:35 +0000
Received: from KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27]) by KL1PR06MB6652.apcprd06.prod.outlook.com
 ([fe80::edf3:95b5:1ae2:7c27%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 01:43:35 +0000
From: ChiaWei Wang <chiawei_wang@aspeedtech.com>
To: Jerome Forissier <jerome.forissier@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Javier Tia
 <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov
 <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>, Anton Antonov
 <Anton.Antonov@arm.com>, Maxim Sloyko <maxims@google.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH v9 36/37] [TESTING] configs: set CONFIG_NET=y for FTGMAC100
Thread-Topic: [PATCH v9 36/37] [TESTING] configs: set CONFIG_NET=y for
 FTGMAC100
Thread-Index: AQHa9WNpZNLl0kDcGEaHGrRKSQoY17I4x75g
Date: Mon, 26 Aug 2024 01:43:35 +0000
Message-ID: <KL1PR06MB665259A1C685C003719274DF918B2@KL1PR06MB6652.apcprd06.prod.outlook.com>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
 <29c7d3f8d92ef223c269dc4b27076b99cb3c142a.1724419624.git.jerome.forissier@linaro.org>
In-Reply-To: <29c7d3f8d92ef223c269dc4b27076b99cb3c142a.1724419624.git.jerome.forissier@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR06MB6652:EE_|SEZPR06MB6925:EE_
x-ms-office365-filtering-correlation-id: 53be92ac-f23e-4f00-a8fc-08dcc5707fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?RFNHSmg5MXZBY3dBbUVucEZEZjBXQ24vSEM0MjNFU0Z4L3NmWW5QMHBNRkVL?=
 =?utf-8?B?KzBWcmxkOXpoOE1jZGlKcUxYemtEdTFTYmZlcVl0R0kwTDJuOGlUZWNjbG40?=
 =?utf-8?B?ZWZCSThYQUw0MTgxWW4ybXhzVCtxVEVYd1NFMExkaEYrZS82eWFYWFl5c0pD?=
 =?utf-8?B?WDNBTUl0c3ZNbWFxcS9XUEhuVGpDNzk5Zlducm1veVJXdXluN1YvL0RVSlBp?=
 =?utf-8?B?WmI1UTZiNDNxZXFaeGREZ2hLazJmQU5FTFUvUDNOUkNFalp6UlNvTG4zRzZa?=
 =?utf-8?B?cmRtTGU2RTRHeHBQU2dlZi9IZDlHZFArdXpQU0FxTThvV0Q1a0V4QXZkOTNB?=
 =?utf-8?B?alc2ZmFOUnMzRnNuVmJFQmdUbjZRbitTdDNQZis5U21ZOVllZFRTemp4UVNF?=
 =?utf-8?B?ZTIyczdDSXU2SlZ1WGE0YTBTcVBCYllTYXMzcmxPTEUzcnpTWS9ZV2xKUDB5?=
 =?utf-8?B?eUhsWS8vL0RnKzE4S3ZEV2p2V2pBVEdaUTFjeFhwRjcxMnhRWEYxMVZ3b0J5?=
 =?utf-8?B?dHFRTEUrd0lSMmlUWkZjRHlVTzdkUCtvT0FKRlBkUGhObzhmK1NZUFZoV0tk?=
 =?utf-8?B?Y25qd0d6LzFZVlNRakM5KzFpWWxOWVR6MFNmTVRIcDVtZDhqVlBWZkhNQWJD?=
 =?utf-8?B?SnVQQU5FRjl4aUd4YTJoN3lLNk1YTzVFNnFFNytTOTZQS3c3OHJud3lTeVRM?=
 =?utf-8?B?NUhURERLN0RxWnhkZ01rU2FVZ2hCZlFSRmMvRnhVWGk0ZFJtclpJOEdyTGIw?=
 =?utf-8?B?c0gwT0NadUpoYnFPNHMvcFFtMlE5Ym1BbzhVekxnZk5jMHdPU2JFTXVtdVNt?=
 =?utf-8?B?K0ZzMVNZVXhkQlc1SEg3Q1NjOEtxNmVaUHQ0akw2STl4R3lLQzZhdHE1cVJW?=
 =?utf-8?B?ZUQ4UWRSaE9WVm9ucC9NWFdPU05BNGxGN040T0JVTzhpT0RQZGE3U1k5V2RJ?=
 =?utf-8?B?WmhNY2VJWkpKeG9oQS94Q1pGWUNRMDJVd3h6MWhQSEpxU1AyMFBqbTd6dHFC?=
 =?utf-8?B?WU0zREt5QWRUUUhxSklWVkg5cmhJZGhnT0lGSy9nRk9rT1hpNkQ1RGZRMnI2?=
 =?utf-8?B?M2xPWU1JUjZUcjFIQ2gybU5TT21tV1NrVUNWT1A5dzFRcmtlZVExU1dqV3dj?=
 =?utf-8?B?dmpwVlJGcHdSSGxKWUcxdlJzcTJ5TlBsN2JUdGliZksvbmUxcVhzU1AzZWV5?=
 =?utf-8?B?QnVYMjNSTEtpNDBoMjlOSW9qVUc3TjBSdXJ4T3pHMVM0WUUyVG5KeXAzYVJw?=
 =?utf-8?B?SHY1dFM3RHFIU0gzUWxteUJ6Nk02bFVnQ0JqMnBDU0JMSThONTdyTFZNWW5I?=
 =?utf-8?B?c01EUUxFNlBYSGNGbzR6MVRFRC9yVjdFeWlJVEdGMkJhN3dXM09waXVodUhL?=
 =?utf-8?B?WGRTUUlhRlpidXZiZlF0ckk4M0d3SWRQTUlPSUxCeXN6VjAycTY3R0pEL0dq?=
 =?utf-8?B?ckpabldOeDR3a3U3ZUtObjBMa0pYeEZNOFVqUWtPK0tKRW1iUW53bWRMU254?=
 =?utf-8?B?OGpkbk82d21ZNFhrY1BuMkNhU1FTamErTzdtZ2VKTnp5Y3IvLzkzb3BLdm1y?=
 =?utf-8?B?d3BwWHU1NmRRS2hwMVRiNVJWZThMd0FEeWhFOFlESWwxMk8yUzNjS3FQOW9Y?=
 =?utf-8?B?N1BzNDNYOSttUWhEd1BqTTlSSmpPSGVPeTBTelBNYUJGRWFUV3pua0pqYzls?=
 =?utf-8?B?RzNIN1FZYVBZSzRwc2lZcVpkMkptNXBra0w0T054bHVCT1ZzK1ZkcjZFY1Ax?=
 =?utf-8?B?SkJQY21uaC9yVGxYQSs1WkFHYnVBZUtkelJlV0krR25qQ3ByanpHOTIrUmh5?=
 =?utf-8?B?NDdzZTRiZmtEUzkwcGZsQ21JbG4wMnpFaGtLUDh4RXltRWJuRlNmdHFyRkpX?=
 =?utf-8?B?YUsxS2Q1bkJrbUdObERBT1ZBaHJOK0RMYkdlTTFiNmxpN0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:KL1PR06MB6652.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ry9VRm45dExZN1pWNm5peHVuSmpHU0NiZEl6NGF4RmpyNm1UcjJ0VDNBcWJz?=
 =?utf-8?B?RzFQL0M2MWExVHZYcjdoYkFSalRpbnJ2MnJnVzJZT0JQR0FrV1JNWVhSWGdv?=
 =?utf-8?B?dDNYbHM1TFhJMnN4b3BqZ2U2REpBUUFrNGdGY2dHYnBvc2dkMjJCVU5hU3lS?=
 =?utf-8?B?TmZDbVNHeTFzM0x2U2tzMjRza05ISGtZMFFnN1hmeFJrUTRxK3FTUldTendj?=
 =?utf-8?B?bHhHeFBOeHUra2Qza1ZsY2prWWJXd1Y2bCtQZ09xNGZCOUxLbmV5TTRGM2hZ?=
 =?utf-8?B?Qlp2SGlkOGtOTlRXb2JHMWJRWVdKejA5NGZObFoySEFBMXF6Yko4QTFPRENJ?=
 =?utf-8?B?bzBEdk9WV3JSSnBwTDQwbHNMbGpHZktTOXZScEpIOFZNclE4Q2t5VHhvSzND?=
 =?utf-8?B?eU5Ca2YvMlNBV1F6eWlrSDZVZzRwb2FuZDUzQkIrLyt0dll5VGtiR0dPSEJ2?=
 =?utf-8?B?VWowTXJhYnlGZXVWbmdKUlhsQ0YyenRzVVdBRzNHQmtIdHNmRGw1WW5qV0Ji?=
 =?utf-8?B?UmI2bWZ0UzVVSnN0UXU0K0VkSzV1ME1ERjYrU2tMaDFBeGtFb0ZJYW5kVXhT?=
 =?utf-8?B?WmJvS2xJOWlDY1BuSTRRVVhNZktVNWpZb3BGeHBrMk1wbnBtZjFZZERDMXdC?=
 =?utf-8?B?alRrdmdqcExxVkw0QnlBaGxRM0VMNUw3MTEydHNJNWkyZElKWVFkQk5HQUxU?=
 =?utf-8?B?akJLQWJncmk3eldXZ3RJaUoyU3FEUlRwMVRwZnpQUWZmdFc2YlprUTZ6OEVE?=
 =?utf-8?B?dHQ5OGFVUUJoTzRkR0VhY0Jxa3VhM255dDVWSTN5WVZLeUluYjl4eTVHalRq?=
 =?utf-8?B?bW50WlpRMUYvcDVpYndlMk16OXVOcWlkTG1EVzUvMSthdkpVWm9aUjN6MWJq?=
 =?utf-8?B?RnNUTWVuTFFiWWtZZk1rZE9veG03ZWQvb2NRWk5nVFcrU285OUd1blRzNkZ6?=
 =?utf-8?B?SFVHaS9zcnI0c0ExY1UrSWs2dmxBSVoyTElPNU8xL1loRGhmYndsNjUwVkFK?=
 =?utf-8?B?d1MyVUpNMzJVWTg0WCtSZnFvNnR2M2tMMGpkNVdGVTl6cGJlemFudFZGNHV1?=
 =?utf-8?B?VW9KZ0l5OE5DSWlzaysyUFZIdGJwUXVlQ1pXSGxjTFMrNkhvN09PN09pNjZF?=
 =?utf-8?B?UDVxQkpXV3FMd2MyeFcwOFpJK1ZucllYYkJNc1lHQ1phZlNSMSsxM1hSamF1?=
 =?utf-8?B?Sk42eHNVNXpVUklxUmJtc2I5MG5tNXk5RTY4U21YS2liV3FrRzVIWXhxSDgx?=
 =?utf-8?B?NTFwSEJKZjZIV1Zoa3BDSWs4bmFtRHFKY3VCMEl4ZFA4cmdncmEvbXozdERl?=
 =?utf-8?B?OWphZ050Zmp1bmEveHM3b1FDUXlSRjFpWjRpallZck5OVWZLSytGQmFPYWZv?=
 =?utf-8?B?Yk84L3VybFdpRE1lcXA3V2luWEVsQzhLcXJPWnpXQkd4czhWM0lNU1o2NTNE?=
 =?utf-8?B?Y29raW5TRUcxT1k4ZDFiS0t6UGhNMTh0dXpiVEdHWEJ2a0RjVXpJeGVIS0Zo?=
 =?utf-8?B?S01GTXArUXJaR2pYNWVZeTJnNUh1L3ZNYXYzU3llbzU0cXdGb2JoWUhmc05z?=
 =?utf-8?B?VGJwQzlhZ0tMTEM4cmg5U0tVNFh6N0N4b0tOM2JsVU5pL3RVeGJoTDVZZEpJ?=
 =?utf-8?B?dDN4czFuczFsSGRmMkxiVDRlazgxZTd1Y2ZmUVR5aVBmdXJ4MTdiY04ybDFv?=
 =?utf-8?B?a3ovaGFTb0c5SjUxQjlOM0pGQ2piaEl6YUtHMWg5aVlkeThYYjN3d2ZGQ0dp?=
 =?utf-8?B?aUsrY3AvSlFkSjNaT05UR2JNUjJDblA5QjNydW8yT3Z4T01uMUhuc3Z3SlRr?=
 =?utf-8?B?VCtyamZGVU5HOEt0bTZvNnYrT3k1eEVuYVFJQ2Q2TnVqT1E0RkJZamh1Qk9t?=
 =?utf-8?B?UTRVR05sYW5UQU80Y1FlOEd0Q2pBNjNyUm5YYVZyNWpVOUFSQW1qcjFaa2pO?=
 =?utf-8?B?L1luME0wcG12Qm5uQi9aVWhEZmlEUEZBNkdIMHdWNkxjTEVoZ3dCbzdnY2p2?=
 =?utf-8?B?Q0c4R3Z2QklYYm1DZ0JMWHd2YXpSajF3OGo3MDUxMDZVUEpibE5LM3k4WXZm?=
 =?utf-8?B?VWo0QlBFaENabDZHM1BFVnY4eXVIbWVDelljZ201N2NWSk02ZzdUTXlXdXJX?=
 =?utf-8?B?dFFTc1JpQXdXeGlXYlZHait3YUZOc0YwUCtpZjNVUnljNjJQRGhRa2M5M084?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6652.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53be92ac-f23e-4f00-a8fc-08dcc5707fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 01:43:35.2733 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9QbyVSSZ79GQQB1h+VZ9zayY/O0D9EfpUcgezNvGqihGkqCZ/1nnQx6aCobqQKUOmXqiDb4RJNMAtwbT4KYdRj+1wgG9mVv095CUqatK50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6925
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

UmV2aWV3ZWQtYnk6IENoaWEtV2VpIFdhbmcgPGNoaWF3ZWlfd2FuZ0Bhc3BlZWR0ZWNoLmNvbT4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKZXJvbWUgRm9yaXNzaWVy
IDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDIz
LCAyMDI0IDk6NDkgUE0NCj4gVG86IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IENjOiBJbGlhcyBB
cGFsb2RpbWFzIDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBKYXZpZXIgVGlhDQo+IDxq
YXZpZXIudGlhQGxpbmFyby5vcmc+OyBSYXltb25kIE1hbyA8cmF5bW9uZC5tYW9AbGluYXJvLm9y
Zz47IE1heGltDQo+IFV2YXJvdiA8bXV2YXJvdkBnbWFpbC5jb20+OyBUaW0gSGFydmV5IDx0aGFy
dmV5QGdhdGV3b3Jrcy5jb20+Ow0KPiBBbnRvbiBBbnRvbm92IDxBbnRvbi5BbnRvbm92QGFybS5j
b20+OyBKZXJvbWUgRm9yaXNzaWVyDQo+IDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFyby5vcmc+OyBN
YXhpbSBTbG95a28gPG1heGltc0Bnb29nbGUuY29tPjsgVG9tDQo+IFJpbmkgPHRyaW5pQGtvbnN1
bGtvLmNvbT47IENoaWFXZWkgV2FuZyA8Y2hpYXdlaV93YW5nQGFzcGVlZHRlY2guY29tPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjkgMzYvMzddIFtURVNUSU5HXSBjb25maWdzOiBzZXQgQ09ORklHX05F
VD15IGZvcg0KPiBGVEdNQUMxMDANCj4gDQo+IEZUR01BQzEwMCBpcyBub3QgY29tcGF0aWJsZSB3
aXRoIE5FVF9MV0lQIHdoaWNoIHdhcyBlbmFibGVkIGFzIHRoZQ0KPiBkZWZhdWx0IHN0YWNrIGlu
IGEgcHJldmlvdXMgY29tbWl0LiBTbyBlbmFibGUgTkVUIGluIHRoZSBkZWZjb25maWcuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFy
by5vcmc+DQo+IC0tLQ0KPiAgY29uZmlncy9ldmItYXN0MjUwMF9kZWZjb25maWcgfCAxICsNCj4g
IGNvbmZpZ3MvZXZiLWFzdDI2MDBfZGVmY29uZmlnIHwgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvZXZiLWFzdDI1MDBf
ZGVmY29uZmlnIGIvY29uZmlncy9ldmItYXN0MjUwMF9kZWZjb25maWcNCj4gaW5kZXggNjY4NWYz
N2UzZjUuLmQyMGNjZjE2Nzk3IDEwMDY0NA0KPiAtLS0gYS9jb25maWdzL2V2Yi1hc3QyNTAwX2Rl
ZmNvbmZpZw0KPiArKysgYi9jb25maWdzL2V2Yi1hc3QyNTAwX2RlZmNvbmZpZw0KPiBAQCAtMzUs
NiArMzUsNyBAQCBDT05GSUdfQ01EX05DU0k9eQ0KPiAgQ09ORklHX0VOVl9PVkVSV1JJVEU9eQ0K
PiAgQ09ORklHX0VOVl9JU19JTl9TUElfRkxBU0g9eQ0KPiAgQ09ORklHX1NZU19SRUxPQ19HRF9F
TlZfQUREUj15DQo+ICtDT05GSUdfTkVUPXkNCj4gIENPTkZJR19ORVRfUkFORE9NX0VUSEFERFI9
eQ0KPiAgQ09ORklHX1JFR01BUD15DQo+ICBDT05GSUdfQ0xLPXkNCj4gZGlmZiAtLWdpdCBhL2Nv
bmZpZ3MvZXZiLWFzdDI2MDBfZGVmY29uZmlnIGIvY29uZmlncy9ldmItYXN0MjYwMF9kZWZjb25m
aWcNCj4gaW5kZXggZTZhNGU0ZDFiN2MuLjQ3ZmFmMDVhMjQyIDEwMDY0NA0KPiAtLS0gYS9jb25m
aWdzL2V2Yi1hc3QyNjAwX2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdzL2V2Yi1hc3QyNjAwX2Rl
ZmNvbmZpZw0KPiBAQCAtNzgsNiArNzgsNyBAQCBDT05GSUdfRU5WX09WRVJXUklURT15DQo+IENP
TkZJR19FTlZfSVNfSU5fU1BJX0ZMQVNIPXkgIENPTkZJR19FTlZfU0VDVF9TSVpFX0FVVE89eQ0K
PiBDT05GSUdfU1lTX1JFTE9DX0dEX0VOVl9BRERSPXkNCj4gK0NPTkZJR19ORVQ9eQ0KPiAgQ09O
RklHX05FVF9SQU5ET01fRVRIQUREUj15DQo+ICBDT05GSUdfU1BMX0RNPXkNCj4gIENPTkZJR19T
UExfRE1fU0VRX0FMSUFTPXkNCj4gLS0NCj4gMi40MC4xDQoNCg==
