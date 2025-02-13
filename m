Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3986C021A4
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 07:21:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62CC680C77;
	Thu, 13 Feb 2025 08:21:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sSihqLsB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1147480C83; Thu, 13 Feb 2025 08:21:46 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0DB2807C0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 08:21:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip2L54nVliGGVud6uttPqr1hWCZAIN15SwKLPKfQN1ZgyEJ/4mf1h3sZiedjqPcl5vZJXWsOnp89EyXV2iFQoB8J/kQ5yzShDXb2CmwgsP2IK/3uv20HiEiTp2eMqIrE5YlaY5IplV/wFAtt71aMaKTzpyexl52vXv09D258HNhEmjdAML8P+2o0uTA+oSMMLCJGi+gPTvLmClwlaFHnu4m+nCm5V1kq+wzTPPD1sydBXnf9ZO0I+LQemyijgXb7BkQr8ieOY+4EDD1ruTvyGzA/8xRoPmDUDI5MZhk+lzrcGxuvOSOPtAgxOnfWWD/cUhjqpoILnlrscCeYKdll0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8SylgmJMgeQfJj+o2o/lN+bmpWy6fdMKBKGJIyh6+0=;
 b=yt7CemDY/34V3lWYA5SMwBmbPWgE9oSy5cKgJ6Ju/TsYKkZCpLREfghHtfqz+3aWcXHlwyQeNGLgAtrfgS6BgIVCDHgjiYccKz1BnNlxyK4qj4p7mnhJfuZy9ulid7HtPbwCxHKpUEV4Pxqrkmk0Vfq/93TNrkbICZjgMULe6LuNn+cF3Jiw32JkSclCK//0ewEVsQcAKvSSvTAxZKRRbQZf0RF/eJZXg8eDLrMTOJBi/KlqA2VuGA+eTNqSm6HOz+eSxdKFHSM901IaVyr2l3cyt5zw/p4gG2JH+YMdniwWyISykyqwrJXMGQqXO9JAVwL6pVdUWAA1Ey3/juELCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8SylgmJMgeQfJj+o2o/lN+bmpWy6fdMKBKGJIyh6+0=;
 b=sSihqLsB1rYDXBD5Ss/T0qF8NYpG1RNUW933iKHj3lSPsVMcunpqoekJHBbTMz7GGUv7qzIerzv74WGat6xkjTBz6yLShIfBCoBOddq1esIKKg8pMxHpLIurO1qnO1PTEAoRgZDsJvlh2mE8NQuMUKU889eQ+AZi3SzVKfSwT8AqO113BP8ZXll09DM4OjaqBLlwd4oU4XM3fldLyq5P1FQ3rkkvsEHBEoVIPeVqeo5cXEKtPHXTBxFqSqOkNKcJXLJWxLzA62+Tbkt+JB9RBhaU044fz1IG65neytWbOxTADG4zWDdjUNH+d1ZGy3TRHvwc9QScsf0X7t6EkjxEHg==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by DB3P195MB2229.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:437::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 07:21:41 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%5]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:21:41 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Topic: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Index: AQHbcjjLfXNkb9lhtEeZVLV5ci3/5bNAlVuAgARWDAA=
Date: Thu, 13 Feb 2025 07:21:41 +0000
Message-ID: <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
In-Reply-To: <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|DB3P195MB2229:EE_
x-ms-office365-filtering-correlation-id: 821d2065-7bfc-4e1b-a2e7-08dd4bff100e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?TEVIYVB2VFJocG12UWxoNWN5cldXTTZCWVEwcHMrMzZHRmcyRzJDaXF1czNS?=
 =?utf-8?B?RUtQMmZCcW5xZkdGRE1LMDhYSkxoWmFudHBLRml2Vmd4R3A3Ym5sSkVpRU0v?=
 =?utf-8?B?Q3VtY29kWnRBMG8xUFoza01BU1ptSnlLcWlmOUtHS1c2bm1jZE1ndVQwbWpS?=
 =?utf-8?B?dG5uQkhtUFJGR3ZxY1NydHhTK3dsaFVWckhwUFNVRGlrRUJqU0FHYWVNZ1BL?=
 =?utf-8?B?ZlZ5Q0ZYVHI3T21CeWhyNlpuZHN5YWtrTkNwRVVoRFYwSEc4V0NzeXR4VWxh?=
 =?utf-8?B?aXoxbE1DZTVGdGZQZ3Fuc1VjK3B2aHRwelJnT05QRnFTNDRORXU1c3crNUNL?=
 =?utf-8?B?bXBTV1ptMWxVL012VTgrUFRLaXl3Q2lCcG5EdXphaU5FTW9PN0VPRVlSNHZJ?=
 =?utf-8?B?SS8yUWtaRldxaEFKSXJWK3NVd0hMZVV1cFVwcjVLcWJxOVlHZHZPMGtjcjd3?=
 =?utf-8?B?aE5TZ3AxbVQzS250MkFTb0N4TzlBNTg0R1JiZjhoUmd4RGtOSkxFbnRpTFdR?=
 =?utf-8?B?ekhwNytBSDE5WlloTkZZQVl6dWZBZmgyVTFyanhhVVlzSkc3UTF5eTFXQ015?=
 =?utf-8?B?azRxdkRwdmlIRDRING9jRE9sK05PWk8yc3FlZ2VtdkdHT05JMUlEcFFrdmxj?=
 =?utf-8?B?K1NkUCtlc0djbkIrYms4TEo5aGdLQ1lXQm4wMjl1emtLc0NaSGtIb0pNS3c1?=
 =?utf-8?B?WVVJR0VpeFhGMjdTM0JBU2xJQ2VHQkdxZ25mbERXMTd3aTloTHVnMVMrN3lV?=
 =?utf-8?B?Qi9UMDRRL2oyOVllMEhjay92ZXVnZmdpeFp1UGlBWGhsVDF2aXMyc2pXWm1V?=
 =?utf-8?B?YSs1bDlZdGc1YXBodVBlNDd1SFdYRFR5alVjTzRrblNZVEN1b0hiN1IxbUJH?=
 =?utf-8?B?d0I2UGpOWUxMSk9FKzhJV1RkcVpsNkZOQ2NNM25RUHV3djA4M0t2NnM0eHdj?=
 =?utf-8?B?UXFST2gyRHBObGlDeDVxWG9KV1l4R3VDYTdSL1hOdXVaNUhzL2pkY2w4V2Ux?=
 =?utf-8?B?b0t4eWhGYXBPNUxOSmxFQ3R0S1FUU3VFVURJYXZBbEk3WEpNYnp2R0p1UmEy?=
 =?utf-8?B?UVI4RElsMEtNb1JQaG1JWCtqRUNiVnRwUjJ2UGdYWWw3UjhQWmovbzhVcnJy?=
 =?utf-8?B?UEh6d0VrQm1VYXNia001aGJPb3JGNFREZVlaUXlpaDJUV1Fvb2ZuaXRMMGda?=
 =?utf-8?B?UjFTeXNaRDZYS3dtNVY1aklBTERiY0c4U05iaWtwY1E0R3dVUUFhRmgyTUMx?=
 =?utf-8?B?WHVrOXJDL0V5dUdPeUJJYytOSG95eFZBUHdZbXk5dDA2K0FTQ0xtbmVpQzM0?=
 =?utf-8?B?Y0g2dERoN1BOWnVrMnNBNlVIa3ROUzlJUlFHb3A2MUJNenNVM2RQd1MyVG9Z?=
 =?utf-8?B?M1l6bUgxN0hlY08rYzBBazVQQUx2UlZaV051STVwaWtUcDJoeWFvQTdtSSth?=
 =?utf-8?B?MnpQalY3cDZobERlQndzeDI2dFBxaGlNU3hxV3BTSzkxRGx4V0t6bFM0NW1P?=
 =?utf-8?B?RlhsMEpOL0hlYUl2V09YQmFuZlJZaEtPSUVKN0g5UEtFRXMvY25qbmFqc2U3?=
 =?utf-8?B?V3BvUGhuZTluaE5xUjJpSjE2WmNJa3kyTzdzcTh1KzdJd2J3ck9PV0VGeHhi?=
 =?utf-8?B?bEkvdi9NbDlxcFhwU0tpNVRUMVkxVnZpWWZROFlxZXRLUjl2cG4yTVBzOThp?=
 =?utf-8?B?U01GUW9zbWRrVHgxaUVPaE13RlY2eEt2V0NraWJWYzg1RDEvTHRBbDBHcnpq?=
 =?utf-8?B?RDh1bE9qeHZmOHc2YVZZSjhJK1BFeHU5Q3dPcHpYcE1TMjdVTSsza0RPcDFN?=
 =?utf-8?B?WUxMeVhMcTErbWg2RFhKdE9lVTZlM1pEMFVveTcwamgvWU9QYVgwMW5WV0tF?=
 =?utf-8?B?dk9PbnFvdTRWYVZFYVIrclAwU2VuMkFIcnBKUWxMU0pURVprMzRRQk9PZmZL?=
 =?utf-8?Q?56Ho+/DwHR93mW15QOSMs6fSwp7d1Awl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlhMVzcrQkRtSkhQRkI2QkNCQ1BlbFB4WVVSbTJmZmQzWGJqRGpTcy9nRlU1?=
 =?utf-8?B?YVFWYldIaUdtUzk1RWZoUEw3SVpncmNYYlEwZUlVMEt5UmlZZXUrcVNhd3ZI?=
 =?utf-8?B?S2dKcGFWRysvVXQ0a0tPUFdWMndJVEQvQUZHUjR0UXAwZTlseSszbkJFaVVZ?=
 =?utf-8?B?bU9BZ2dDQm9ML1FwckVyaFJpY0ZQb1FwWE02S3d3dTJDbFduY20zRXFFVDJx?=
 =?utf-8?B?RTc4ak1ldi9xZ3dDSi9QditITHBlNXJ5Z05lN0p3NFRMOGVxS3N4bG1nazRZ?=
 =?utf-8?B?NzJmRXRGaUhwd2dOdE9PZnQ1R2lWakJIb0Z6NnFaL2kxZXR1VlhmTmNDRHRH?=
 =?utf-8?B?cnBEdjIvTlhnWGM1d2VtcWFWRCs4cGg4NXMvVDMySllwaU9HdkpJaGcyQ1Na?=
 =?utf-8?B?bEVuMjdpOWNPcVFvckFBcDBuNDBaV3JGek1TQi84V01kVnYvQ0VFalRsZi9Q?=
 =?utf-8?B?QXBHNldjVXVJaTlzMThhSHZkZ1BFSlZtbE5CQzBTRVk2VHNWWmhCL2hyaEFK?=
 =?utf-8?B?dmlhdEx3QlZQQUZIMmVPbVpkTzZnaE0xRHpxa3JoeUNhTEM0Vm9hbG9XU0J2?=
 =?utf-8?B?NTA5ZWxOcUFiUjlQTWZFVUJQc0ZRdFZqUU1IK0g2QUtLSzg1eTJsOERJaFRo?=
 =?utf-8?B?L3ZwVW43dTVjSFlHQjl0MS9SK1g5K1djV0tFRmpDandsbCtCRUZqd2c1SUFQ?=
 =?utf-8?B?VnhZM0t4Snhlb3IyMkNuVkZoY1FZSjh0STVrR3JqWHNjeGZ1Yzd0L3FTdlY0?=
 =?utf-8?B?OWUyUDRRVGNtUHloKytDVWhDK0ovbkk2T0tMa1ZobTFMa05KM2UrS0NsbjdS?=
 =?utf-8?B?dUN0dzRLdzJoS0VLZk9KYitkcDM1b2tVNUxGeU5VazJDTWYreHdQZHNGeTh3?=
 =?utf-8?B?WXkzeEF6ZmV6ejNld1c0WVpuTnplNndrdnBTb1RoSGFZVXh3dkl2VXJYOThs?=
 =?utf-8?B?YWlub0o3MUdRMEhGbFJSdnVyQnBJSXRTQkNVUjJnbnFpVUxJQ3BNTjZsTDh3?=
 =?utf-8?B?bUo4a1U3K0FuNFh0cjR3TGkwS3VuZ0VVS3ZEcStGQmYyUnk3WkZ4YjUzc2lF?=
 =?utf-8?B?eE5HMzZQS0l6KzFhVmR6bEI0NXZkUzRFZXV5N1RuQU9pYTNPT1kzZXZ1dXVu?=
 =?utf-8?B?b1JGZVZwUno3cFdLem5VL3VYcWlQbVlqRWE4UkVFcUtOM1htek4vYkFHNGxv?=
 =?utf-8?B?RXM1UHAwbElTbHZqR0VpMnlmNjcrVUpBQmRTQjMxa3VlTy9uNVBWVjROK09W?=
 =?utf-8?B?RnVjWDRiUThsYUhEVSt4M2ZDMi9jQmhWWHlHdlJBQlU2N2MrZGJQcXBLRisx?=
 =?utf-8?B?dXNvSlFOWnIyaDlLT293ajE1OEdCVkE4S1I1K2RnM3NRQ1Y1N1BYSEhMQkVY?=
 =?utf-8?B?OTl3SzJDdGxTNjkrQmFxNEdabGFDaGx5aUJXNGFIVGRhbTRQelVGWmFvL3Iz?=
 =?utf-8?B?OCtOZmg2dFZNUWdBSVFvRVQ2RFhRS0ZQdTVpTVlyZzErNHhsQkRyb0xrdVZm?=
 =?utf-8?B?Z0lOcjBJVVVKdUwzSEg0S3U3MkRiZG1WTkU3SDRUazJmakJ5Z2tRa0RZcE9y?=
 =?utf-8?B?TVFkUkkwT2ZZV1lTTTZXY01peDlrY2VPV3ZZYk1jL0hPaWVvRTRlMVc1ei9u?=
 =?utf-8?B?ZW50N0FZZWNUUVYwU2lHaWhUN2ZHWkNrT2J0T2d5YU5MeUludWh5eVV3d0cv?=
 =?utf-8?B?Y1ZwNFZ5a3RwT1JEYmg0dVJCT1hEYitCR1V2TDYrZWE5cG9WRGZIT0JmMGJt?=
 =?utf-8?B?ODA3a2QyNXRXWElTZEIxeEw1dUxuR1JOUEJBTnNsanN4MVY0SklxZDNyNFF2?=
 =?utf-8?B?VWorS0JTcU10YUo5akRYKzMxK1dKM0N5MzRUOEQ1THQ3TEpITXFTdDZ2T1Ft?=
 =?utf-8?B?QU1NZmlkSlRxYUdXSEVwZDljbEpMVmk0RDRncHY0K0UrRmdPb3hWUmtzVko4?=
 =?utf-8?B?UXhHdnZOY0licFI0aVFtRDZVUGtHeDdRRWhGQ0E2aXJ6QUczaWlEUEo2bTZi?=
 =?utf-8?B?b1lZRUhYREZTS2tibHlER21QdDZxV3M3RWZMRTdNQzJ2ZFVremsxS2pCVWxX?=
 =?utf-8?B?aHV3NE9zQjBwMG9XdTlIYnBlRnNaSktQdTFtUU9DVUFMTGUwMjZvL0hkWTN3?=
 =?utf-8?Q?1GM4k/l3Q7iOQXnpElesPe6hU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0D29AA2ACCF644A9C117DE0D1FB8D58@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d2065-7bfc-4e1b-a2e7-08dd4bff100e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:21:41.4405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ye2I08RqXfje/HeTNSz3Esg3sdvv929b5v83mf3wGc7cmLFMgkGTc+BSeOpP/8U2ahk1LL6cLR5CpLC3NR0B5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3P195MB2229
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

T24gTW9uLCAyMDI1LTAyLTEwIGF0IDA2OjA4IC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
T24gV2VkLCAyOSBKYW4gMjAyNSBhdCAwMzozMCwgWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMu
ZGU+IHdyb3RlOg0KPiA+IA0KPiA+IFRoZSBiaW5tYW4gZG9jdW1lbnRhdGlvbiBvZiBPcHRpb25h
bCBlbnRyaWVzIGlzIG5vdCBhY2N1cmF0ZSBpbiB0aGUNCj4gPiBzZW5zZSB0aGF0IGl0IGRvZXMg
bm90IGNvdmVyIGJsb2JzIGVudHJ5IHR5cGUuIEFzIHRoaXMgaXMgYWxzbyB0aGUgbW9zdA0KPiA+
IHdpZGVseSB1c2VkIHR5cGUgdG8gaGF2ZSB0aGUgb3B0aW9uYWwgZW50cnksIGRvY3VtZW50IHRo
ZSBpbnRlcmFjdGlvbg0KPiA+IHdpdGggZmFraW5nIGJsb2JzLg0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KPiA+IC0tLQ0KPiA+IMKgdG9v
bHMvYmlubWFuL2Jpbm1hbi5yc3QgfCA5ICsrKysrKysrLQ0KPiA+IMKgMSBmaWxlIGNoYW5nZWQs
IDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS90
b29scy9iaW5tYW4vYmlubWFuLnJzdCBiL3Rvb2xzL2Jpbm1hbi9iaW5tYW4ucnN0DQo+ID4gaW5k
ZXggOTkwZmMyOTU3NzAuLjJiYWZhNmNhNDA4IDEwMDY0NA0KPiA+IC0tLSBhL3Rvb2xzL2Jpbm1h
bi9iaW5tYW4ucnN0DQo+ID4gKysrIGIvdG9vbHMvYmlubWFuL2Jpbm1hbi5yc3QNCj4gPiBAQCAt
MTE0NSw3ICsxMTQ1LDE0IEBAIGNhbGxlZCBvbiBhbGwgZW50cmllcy4NCj4gPiDCoEl0IGlzIG5v
dCBwb3NzaWJsZSBmb3IgYW4gZW50cnkgdG8gbWFyayBpdHNlbGYgYWJzZW50IGF0IGFueSBvdGhl
ciBwb2ludCBpbiB0aGUNCj4gPiDCoHByb2Nlc3NpbmcuIEl0IG11c3QgaGFwcGVuIGluIHRoZSBP
YnRhaW5Db250ZW50cygpIG1ldGhvZC4NCj4gPiANCj4gPiAtVGhlIGVmZmVjdCBpcyBhcyBpZiB0
aGUgZW50cnkgaGFkIG5ldmVyIGJlZW4gcHJlc2VudCBhdCBhbGwsIHNpbmNlIHRoZSBpbWFnZQ0K
PiA+ICtUaGUgZWZmZWN0IGRlcGVuZHMgb24gdGhlIHR5cGUgb2YgZW50cnkuDQo+ID4gKw0KPiA+
ICtCbG9icw0KPiA+ICt+fn5+fg0KPiA+ICtGb3IgYmxvYnMsIHRoZSBlZmZlY3QgZGVwZW5kcyBv
biB3aGV0aGVyIC0tZmFrZS1leHQtYmxvYnMgaXMgcGFzc2VkDQo+ID4gK3RvIGJpbm1hbi4gKFRo
aXMgaXMgdGhlIGNhc2UgYnkgZGVmYXVsdCkNCj4gPiArSW4gY2FzZSAtLWZha2UtZXh0LWJsb2Jz
IGlzIHNldCwgYW55IG1pc3NpbmcgZW50cmllcyB3aWxsIGJlIGZha2VkLg0KPiA+ICtJZiBub3Qg
c2V0LCBpdCBpcyBhcyBpZiB0aGUgZW50cnkgaGFkIG5ldmVyIGJlZW4gcHJlc2VudCBhdCBhbGws
IHNpbmNlIHRoZSBpbWFnZQ0KPiA+IMKgaXMgcGFja2VkIHdpdGhvdXQgaXQgYW5kIGl0IGRpc2Fw
cGVhcnMgZnJvbSB0aGUgbGlzdCBvZiBlbnRyaWVzLg0KPiANCj4gSSdtIG5vdCBxdWl0ZSBmb2xs
b3dpbmcgdGhpcy4gVGhlIHRleHQgc2VlbXMgT0sgYnV0IHlvdXIgaGVhZGluZw0KPiBpbXBsaWVz
IHRoYXQgdGhpbmdzIG90aGVyIHRoYW4gYmxvYnMgY2FuIGJlIGZha2VkLiBBbGwgb2YgdGhpcw0K
PiBmdW5jdGlvbmFsaXR5IGlzIG9ubHkgZm9yIGJsb2JzLg0KDQpUaGUgaGVhZGluZyBpcyBhIHN1
YnNlY3Rpb24gb2YgIk9wdGlvbmFsIGVudHJpZXMiLiBUbyBteSBrbm93bGVkZ2UgdGhlICJvcHRp
b25hbCIgcHJvcGVydHkgaXMgbm90DQpsaW1pdGVkIHRvIGJsb2JzLiBCdXQgYmxvYnMgZ2V0IHNw
ZWNpYWwgdHJlYXRtZW50IGluIHJlZ2FyZHMgdG8gIm9wdGlvbmFsIiBkdWUgdG8gdGhlIC0tZmFr
ZS1leHQtDQpibG9icyBvcHRpb24uIEhlbmNlIHRoZSBzdWJzZWN0aW9uLg0KDQpXaGF0IHdvdWxk
IHlvdSBsaWtlIG1lIHRvIGNoYW5nZSB0byBtYWtlIHRoaXMgY2xlYXJlcj8NCg0KWWFubmljDQoN
Cj4gDQo+IFJlZ2FyZHMsDQo+IFNpbW9uDQoNCg==
