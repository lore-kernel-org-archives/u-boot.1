Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AF0C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 12:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6711587766;
	Wed, 29 Nov 2023 13:51:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="UYeAxUQ5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5F3E86F1C; Wed, 29 Nov 2023 09:09:32 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D107186EF1
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:09:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KztqEAH1GgRJaZ1UBzDaFCpQxF4aSd47D3W4NWZYSIA+cUEXZEZhMPp5DbT2B9YoiZYvR5+2uu7kgXFbO4gCVh/p7l2eR+va2xo4xNqBCSJwzWW0I5YiZk34GElFM8o6iy3lx0DI+lcIdKo5zPwhue1u2xOP4l5810sWlWznoq2q5PHd/Z1dXd4z+AZ17+QKMhcSC7drGqqkITXJdjo8xVZ8r6EJBLBji2owB3yAEn2WYR11FoNsirRivAPO6c0WTlpfMw4/GoamtxKJIjFopJGYlozysGMKSuBIBeNTzR3hbVVTpv6bnd3HRVqeE+OvLMtFEZOeQMZbj8OBXzz0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FK5NOaZs7q6zKVNdhIab/hNFAzv2XK2oG6cxXLYaKmk=;
 b=Wu5jnKr3APEq6RCjCIjGLsQJ0QhQ7Bzpw9H0PDKokEui3wVkwUtxBABdJcKXowpNFrWa8yDDczlyA8AneGtDtgUVS8cEKLj+Rbx37+YNalGQRvEp8TdMoZbr7VtK98X+HwKh0ThfLG2rIT2Amb02mXoYtEF2W5FfKAciOpVLURJQU1KOGY8NnjC6lEgH5ZiSBXUQbiEHTvVmPFIlFlBEb91FLOO7CmcpgKcCILYD5t7oRfhY9GTDZU2i5qyvibuxrkqe+zEesCGRTW+F46NxtmYtHOKDAlrwCR9zDwGrML323AxxIFKVuK54IprLSBytD/jEUuHsKBjrUJtEo7Yulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FK5NOaZs7q6zKVNdhIab/hNFAzv2XK2oG6cxXLYaKmk=;
 b=UYeAxUQ5Mq5S4n3OcQ0SW/IYd5ioNs3cdOFyyFaO10zy2Y8epYdvr0ML4eH8mTj5pmtK5wJijv+d8rqYRiaBh6/MvU9hrkbXHY0e98Hn5FkOnjIwiKyVwQGgnAWGzn2o7bvna1iUSZbwQflM1/XknGXwDFpDGXNhXSvub2OGejLV+VEvfcNtUy6SuH8M4hWfQ6hepg7EQc2h8fgSyKC/k012LU4+2mlb0ZnT0U2zW4XOEoeeYznYJ1+ArfHmHGZUpjuUVU/SN62Mhe1nMoyTSr6fdPl6lgA4Q9fFRzuuekdshj1hkBvgoFiie0fEaSHGdUXXS8CkKEtvA3nzQuySHQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3530.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:137::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 08:09:28 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f1e6:2701:4840:b64f%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 08:09:28 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "Leto, Enrico"
 <enrico.leto@siemens.com>
Subject: Re: [PATCH 3/6] siemens draco: i2c: use driver model for u-boot
Thread-Topic: [PATCH 3/6] siemens draco: i2c: use driver model for u-boot
Thread-Index: AQHaIpf3f73pWjde7kWj2vYCaX96sbCQ8Y6A
Date: Wed, 29 Nov 2023 08:09:28 +0000
Message-ID: <a139d805f0347fb3ee185716645c25efa45e3576.camel@siemens.com>
References: <20231121142134.2147652-1-enrico.leto@siemens.com>
 <20231121142134.2147652-4-enrico.leto@siemens.com>
In-Reply-To: <20231121142134.2147652-4-enrico.leto@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3530:EE_
x-ms-office365-filtering-correlation-id: 415a274f-fef1-4a15-6474-08dbf0b28218
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+QfugEUS+zbvx8R2J982DQ/1RFWWoJ8qAPyJPSJmeG9NWJcak8r83xvJ9J02idjkcR77St0kFzjjNS6IyD5pZdaxO3HQNNAGRtp7LmXrLiem6qh4T1j59siYT0DC/zvJRhGegYTOFWC0cM2Px7Qb5n/87B0TYa7lmaFRN9UusQtwVX4eJpdrCU2DK+TZNwy1c/Kvcoe89bptKcYc84vXmz4K5rpjO/VKIuGLz3ogSkEXxDj8c3xGZzvT4ph4EXVc6DVunyH+WwH7HVJIHEWW3KH9KfHU1HqKPRYgy8dMk9Gh6I9nBTyK14CEnoTlzu01jo7D2k2hlJ3/hw2dV/pafmWHKlGAR4c0E6FWhgCcXsHTTfMpxeSqdjMpvlIV2yO9VibmtwU0MktmOJGYvrloXiOMEK/e/GE8x/DfTUFRyFJp222CkqJk1H+lLAM+xLBMa6+wgh3mYwjknf98J4Zfl8MWsEnIXDQ/uHaHImYDkB20ealxszN1HTHYh3UmO94/nSYp3/DfhHaKOEERSB00Ff59yH5FSejoS0xXsznwUNJ5GSZd6aEKBhH+bzDRSmnFVzDXVk7SRxIJOQsXVywkrXvXfVi/zmGogqmlIq5V+H8LVwhpCccEtiRhH+ij+8KZK8LaUaGX+vm+U9IcBUhIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(316002)(6636002)(26005)(6512007)(6506007)(2616005)(8676002)(8936002)(2906002)(71200400001)(4001150100001)(478600001)(4744005)(5660300002)(6486002)(41300700001)(83380400001)(76116006)(91956017)(66946007)(66556008)(66476007)(66446008)(110136005)(64756008)(38100700002)(122000001)(82960400001)(15974865002)(86362001)(36756003)(38070700009)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnhkUldKQzdmdHhKN0lyQ0wzVzkvUW90bDUybDFYcDFhSkV3bkFZRStGMDA3?=
 =?utf-8?B?SzFpRDdyTE5rc2xVbVNpOWRuTHNWeUQwVmpieUc2WlVrbVdTaEl1aUZHc1h0?=
 =?utf-8?B?M3IwQWVvVHV5V3M3UnJJM2M0MVJDV3NMTXRqZFQxQzIwWERTQ2xsbVpsem9h?=
 =?utf-8?B?U2lHc2YvMFcxNTdVWG9rMHZJcitRdUplZUFTdXloQXFxMlhqdDA0SWt5ei91?=
 =?utf-8?B?RWVNajR4MTFZVlVzMWsvV2hsb1I2WnkrdWhPbFhpUmFzdDZOeUhBbEpwdDdx?=
 =?utf-8?B?VWlaV3BvMzczSWlpTW5xczZVSVpRbEhMRzhJQlFrVU9OSlNHZURLSlgxajRU?=
 =?utf-8?B?c3hka1BtVzVtaEhlcHZSaERMMWZITmNlWkl2NzkwZmlXeTVVenBhRmJlcUJC?=
 =?utf-8?B?bWV0a0ROMTN1R2R3WkpYbGZmbFlEaFJQL2pXWmxkMXhmNm1ZbzRxNkl6RzZD?=
 =?utf-8?B?K0tld21QcjdyN3dXMjg5TjNOUW5KZENjalk0T3dEZTZVWlNUNnUyRG4wU1N5?=
 =?utf-8?B?Nnc0aGpaOTMxbHVwN0p0RFUwWlJjbFhPb29RYkEwOEg1ZnpOTEIwdkVPOU44?=
 =?utf-8?B?QzIrWGcwbC9KWU5Ld3pOdTBkMmZJVGM5ckxZNTJnNWlBUk1PcHRaaDJra3lT?=
 =?utf-8?B?Zlhna0dWZTRuTGhRb210OGZsSndldVl1Q1dIUDlmOGtRVFRrbHE0UXpqWHVv?=
 =?utf-8?B?dERzaG1SWmNTNnRkWWNEUFRtdnRPdlZmeEh6MGNodFBrYmdVN0UzSFA2UWJE?=
 =?utf-8?B?eUw0Y3hmc0VuRnFSUUxSaWRiYnRTRUp3OFBtOXJEampZU2ZzSzRpbitLenB1?=
 =?utf-8?B?TGUyQTdoMytCM0xpN2N0SThTUDRVYXRSaW1DUkJYT09MS1lOckw5bmtWdGJi?=
 =?utf-8?B?RkwyS1poa1NXMHduRHFOcDFsbGlKd20xUEJPRytITG9OV20zRVVmemZocjdB?=
 =?utf-8?B?cDVSUk1rNzREWElyRktPUHAvUzlOT2RXb3FuZElqc3lZSnorL1pmWE81K2lZ?=
 =?utf-8?B?eENTbHdERlhUMGdCTE5mVU0yZnRGMjVkYjN3ZEZ5R3VjQnIwUTVDdXZWUjhY?=
 =?utf-8?B?NTF2bEYvNjZYNjdJZXZPRlB5SEFIVmI4bXRvaWMwVTNiOTl0ZVpkTEtQUjFC?=
 =?utf-8?B?bHJUUm5pQ0ZycWl2K0Z6d1c4dkV4bFY4OFlzK1hmVjA2YVo1NEVRSkR2M21n?=
 =?utf-8?B?QTQ1K2laa0ZlWFUyWXhyTW5UVWY2VHZPVXBEMjZodTM3cTNvV1pGNkZCSFVL?=
 =?utf-8?B?aUV3SURmdDNUWjQ3a3g1QXhvUFV5RTRQdTRwYUFyMFBWY1FhN2R4SDk4VlVr?=
 =?utf-8?B?M2lzR1hCKzBaZlZXanVnZDAxSE1lSkZENzAxWHQrNUtSVlkxUWdZVjdjVEZJ?=
 =?utf-8?B?YXJ1KzBnNGxENk9KdHI0NnVteno0L0kxbnRCb1lkV0M0UDFpd2RSVG43UzNK?=
 =?utf-8?B?TDVtT3U3UDU4QXFQcVBCek9YYVUwazN3N3RvTFlMSmdDUEpLRFpQa2JOZnln?=
 =?utf-8?B?N0srQUthYk9mQ1dReU01S1ZPRTh4c2dyQU5qYjljV01wSWVSSTBzZjVqRzg5?=
 =?utf-8?B?dGRPaU9Dc3ltUllxNEZNWTVNZTVFRFV5cUQ5SnlkcytvN1NCSXAwUTR6Ujg2?=
 =?utf-8?B?dkdwUWRMRy91NlBrb2xlT0VwblBkYmN3cDcycW94NHB2a0ZPNU9DOFpyRkdt?=
 =?utf-8?B?L3A0S0xQMXBROFZjSkMwd0Q2ZElZOU9lMStHUXRjUXkrNDVLZjhzKzduS1dn?=
 =?utf-8?B?VmtoRlFiUzhqTlpJdy8wVHhqYXhZR0dQOGtNNWQ3VlhZWmt5cTgzRXllYXZa?=
 =?utf-8?B?L0lpSVRDKzQ0amgrOEZSdXQ2ZkFJVXIvTFR3K1FOM1dsdGtNVTlNK2pHbkM5?=
 =?utf-8?B?RUVrdTcrR1luOGNtVkwrMDFqMERHSVN4eU1WdmRCSHBPbXc4K253L0RlS0s1?=
 =?utf-8?B?Ykp5YW5wSlhMbWM3emVjYmtxMkxTRU93ZkRsRGFRMjBDSXlsWjl6OVY1TEl3?=
 =?utf-8?B?T0hPdVBNZFBBSkttSXAxQnB1cjBsZUVYVEVzV1JWeDB6RTMzelNyalh2ZUwr?=
 =?utf-8?B?N0pQR1JDUUFUSHNFRUZzRnhKZkFiTlVQb2k1dVJhNFFCRTNOSVd6RlFRSSty?=
 =?utf-8?B?a0lrZk9veTRZdFNYRXhLeGY1MWJjZ1laSmlaOVk2a2R0K1l4R3Z6NTB6M0g3?=
 =?utf-8?Q?EkLEUpc6BtuTuUG3LMf1is0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FE92021B837F4419924FC80FA4EA9EC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 415a274f-fef1-4a15-6474-08dbf0b28218
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 08:09:28.0246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QERUof6CJGY3+AGrE/fUwDJXUj3NvGa+AEwGhTeiKGTB7EwlpcP/XDOuXxTxCH/8C+wwEtirWKbxsQPKxlHwP6KsABv3qjfZn08JD9T5Msk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3530
X-Mailman-Approved-At: Wed, 29 Nov 2023 13:51:19 +0100
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

SGkgRW5yaWNvIGFuZCBhbGwsDQoNCk9uIFR1ZSwgMjAyMy0xMS0yMSBhdCAxNToyMSArMDEwMCwg
RW5yaWNvIExldG8gd3JvdGU6DQo+IEFkZCBzdXBwb3J0IGZvciBkcml2ZXIgbW9kZWwgd2hlcmUg
RUVQUk9NIGRhdGEgYXJlIHJlYWQgaW4gZHJhY28gYm9hcmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBFbnJpY28gTGV0byA8ZW5yaWNvLmxldG9Ac2llbWVucy5jb20+DQoNClJldmlld2VkLWJ5OiBB
bGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAt
LS0NCj4gwqBjb25maWdzL2RyYWNvLWV0YW1pbl9kZWZjb25maWfCoMKgIHwgNCArKystDQo+IMKg
Y29uZmlncy9kcmFjby1yYXN0YWJhbl9kZWZjb25maWcgfCA0ICsrKy0NCj4gwqBjb25maWdzL2Ry
YWNvLXRodWJhbl9kZWZjb25maWfCoMKgIHwgNCArKystDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA5
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGlu
DQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
