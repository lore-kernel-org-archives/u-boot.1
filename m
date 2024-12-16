Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B156E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 11:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4BA08004E;
	Mon, 16 Dec 2024 12:53:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jdGqrxh0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DEDF8005B; Mon, 16 Dec 2024 12:53:08 +0100 (CET)
Received: from TY3P286CU002.outbound.protection.outlook.com
 (mail-japaneastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c405::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE11A8004E
 for <u-boot@lists.denx.de>; Mon, 16 Dec 2024 12:52:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP1mM25FBX3XZfw3lLTObP0FErymDdLi91h0CVP7IgNXZc/6T2r+PuyFYTdLBFEkaeG/+BcspHwh/YimQmtfZP5AGaduECNv9mlzwosqREjwJ5gx0GTbQ4yE56ztRirejQ8IYezWlv3/oqy1MlKQoDQ1/tH9pm1mkDTqDZzT1qUMjQC5eL2zs+d+BDcqsmugdSzphEg5OBF3N5bSd5lqrC0aq7itMRbe+NETtaPfnef790XLft8W/UE7bnZDU5hnta/E9dXn4c6Dcwk712bBUxq5IQUedH9EAUStQ+BOGfTEBa07o/FLey6abMiOx5c8FiEH7UoCAs+4P2kSTf36Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9ZqyQwP8wZKpuxC5BezJ1PxUkfWA4C/agfHVjTTBB8=;
 b=Z1wdPkknWE+qjyAx4ilPGlP1TaoOpYJAA/tiuekb1PW7ioFcytChMSsJNRvm9CrBmSCO00sVbitGimehLdBefPtW+SwDyJwQMrmfenaSjV0Ub3e9cJS4M0bytr0Lxcn+rDq+hRIktCLt3K4S+M6CqoYIg6vDyuxyMXSZRtbNv5Q68UNqVM5RqdqlOf/pMGr4YNskc6LXTnti0LvfdNNrZFVP5HzrWeL+2XzlecB/BaeEAuyiEmwJFRq6cZSqFT83HgT3qHyFsXFOmFqnp6hJZELH4r1Vq4V+kyIcdcsDKyFgYYv/E2bJDL1eqeIubGcgydvulLLyRSYUE7uIW7Z9YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9ZqyQwP8wZKpuxC5BezJ1PxUkfWA4C/agfHVjTTBB8=;
 b=jdGqrxh0dkJ348eTn3EbYRnMdPc46Orj/7jvsJ0Xw/Vr4+2WSZi2RfMHIN/xd6fJ/8Bmkt7hw7Cfm5n2rkTY64J5ZA+GtwdoFS5LpaVxQ+U3oR4t0oSM8Y46GNfESQfhBePU3mFkZ0KOkGGqbQ2IujJNQt1pcwI6LRApQImX4io=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYTPR01MB10979.jpnprd01.prod.outlook.com (2603:1096:400:39d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 11:52:54 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 11:52:54 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Chris Paterson <Chris.Paterson2@renesas.com>, Prabhakar Mahadev Lad
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Paul Barker <paul.barker.ct@bp.renesas.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
Thread-Topic: [PATCH 1/3] arm64: Convert core type check macros into inline
 functions
Thread-Index: AQHbTnmwjG67vquKBUCMIHR6qTOggrLoku7AgAAxbwCAAABUUA==
Date: Mon, 16 Dec 2024 11:52:54 +0000
Message-ID: <TY3PR01MB113460207C1C2A1B9CB534B2D863B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241214224344.303452-1-marek.vasut+renesas@mailbox.org>
 <TY3PR01MB1134681A786D500D575B1D2CE863B2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <18cbc9d6-847a-49ea-9308-b1a6ee4ae920@mailbox.org>
In-Reply-To: <18cbc9d6-847a-49ea-9308-b1a6ee4ae920@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYTPR01MB10979:EE_
x-ms-office365-filtering-correlation-id: 77fc981e-2f00-4138-591c-08dd1dc82d41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aWNnT2k1RlRoN0RVRlBxTlBuMlgxSzdkYVVDSG1McHJuaUEybS8vYmYydzZw?=
 =?utf-8?B?OGEzaG13NFQ4TXRVM01ZeXk4YU9hcS9Rd21jSExJSXpXNUgvWWl4NHRuYXA5?=
 =?utf-8?B?a3V2Z2hWL3R1YmpRT2lKVkd1VHFkOGVjc1loR2kwa0ZlMlBjcHFMZWQrZXNW?=
 =?utf-8?B?WENyVDR5TjN2L25PR0hJT0NpV0pZYWNSRUhZazZJYnBkQ3Q1eU0wLzdjRXcv?=
 =?utf-8?B?QWVmaHlPNTdsMllPN3hTQ0lUMUpNUXJVQm4vL2pxaFh4dFFCWVBCaUtaVzNX?=
 =?utf-8?B?NllDank5Nm92Q2xqdFJyVld5SUthRE90MGdkQTNKMEpvaTBTMFRoLzJLNVBB?=
 =?utf-8?B?c3F6Q24yRkZtRU1qWVBVK1p4VTJTaVJJUStIbTFtVnZrMFVvMExhTkdaZDBE?=
 =?utf-8?B?OFhUWHNhYlhsNXNvd3lWYXhuR1N5ekhHYTNUUittMFc0RmZEZGpYdFFtMTFL?=
 =?utf-8?B?WGhFeUdnSlVCMUppZHFVNkQrb25JRXRVTTc4ZFVUSld0eEk4TlRsVGFLcUUy?=
 =?utf-8?B?eTAyR0pNYWhPQVkyb3QvcS9oV2FScXZmMWc5TERFVjFMK2EydTFBL2xLUlVQ?=
 =?utf-8?B?QllSTlZkNG1ySlVaNHhjZlZkdzZjL2h4Umc2TmZNckFES2tlMUs4czA0S1do?=
 =?utf-8?B?K0dlbm9teWNOWlFNK2dVUmxGbVJaUG4xTE5relFybkFrK3ppQ09sNzZKQTMz?=
 =?utf-8?B?ZThmWUpIQkVPQzVoR3NCbXFQR0wxcHZVOWxXN1FHWVRnSXI0Z3pIWWR5YTVj?=
 =?utf-8?B?MWxqaXl6WTU1WlNsMlpoc2JZQWxsSkdFNnpramRnR2JNemtLVndBQW14cnIz?=
 =?utf-8?B?Q084bHBFL0R1YUM2c1RGZHp2YXpXTWdvV3lzcUhVWGJqajZlRWV2eGhTMURG?=
 =?utf-8?B?SGh5dnpka2FoeW9tbWQ2M2VVTkN1S2ZkdmRtaEdsUjd3M3pNNjRSWmRiMzZI?=
 =?utf-8?B?aWRBUmRYdmRPcmIwWXlsK0x2WTFtMlFSYVNuY25Va1pFd2JQSThIa0Fxd2o0?=
 =?utf-8?B?OEFOUkp4N050aEl6RE9PNXdhMzdTM3VLdWJIRVZIQS9PSkoxOFJQaGxMeUJo?=
 =?utf-8?B?S3BvOHNGemdIR2RVeEVRRnhaNWI0ZUZZYUZ4ZHk3cG5MSGR0QVhuT2VqME0z?=
 =?utf-8?B?WEp0VGpHZFhxemp4ZWJUZUlEdjIrUGY2ZEVEcnN5REw1cmJVaW83cjJXRWRR?=
 =?utf-8?B?T2h0YTVlR0R2K215V0w3MnBzeDg4VGdGMWhwTmpxbkdraEJOcFVOZFlXS0RS?=
 =?utf-8?B?aVVhWmtXMm5XSnkwNWFmN1VNMmxzUEUwWG41QVRVS1ZRdW1RVVZZOHphazB6?=
 =?utf-8?B?T2JtcXJYbGpWUlFyYnZxMWV3UDh6WmxBTU11VW45RXpLUitZS3JkNUxCMjQr?=
 =?utf-8?B?YnpKYy9qWk85WWNXYTRWd1RwUjA2NytiQ0pRVG85TVlWTFlzb3ptcWNrM3Aw?=
 =?utf-8?B?cC82QUxnTStEQTZYMEFTSkZxcmZoYXRqYU5UVmdHVCs0UjdBS0tIRjA4K2ND?=
 =?utf-8?B?TDdxN2ZpZzJybk5OMGxZZDZtR1J6R3FaU01kQ2NoRDRnbWZ1aXRzSG1Mc0FJ?=
 =?utf-8?B?M2QyN1FWTHo5MTRqaE16Ry9lQWdUUVY1ZGcwL01mM1VBVGRTbnBvR0d5SkRE?=
 =?utf-8?B?UzhQZzkzNUlqbjBnTG5MMldWREM2TG9SNzFtVGQ0RUFoMDFEaEcyaGtzOTFC?=
 =?utf-8?B?UEpzSDBKVEJQTnlEa0Y2Wm9QM3hSZUxmczRqbUJMclk1a0RzUUczQ1VhNzAx?=
 =?utf-8?B?MVlaUS9Ba1pramkzMmRwbXg4Z2pMRWtGZnZxek1yL2NwaUZwdkRTMFNmMjF3?=
 =?utf-8?B?RUdSZGEyMTI5Njgzbm9kc2hwdGFWUklPSFhkVlRnMCt2TmpKTjJLSloyM0or?=
 =?utf-8?B?SEhWM1RHcUs1WXZkU1ZqcStwek1KQ2lodnhwcUEvRkFxM1JxczB4eHdLbGtN?=
 =?utf-8?Q?MRn1xS3Jp3ISjNcE4wiEV0C+VR+rMaVo?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTk1YjVKOHhrSTNQRi9ZS2lYZEljWkFCS2d2L2lzRVpFSFdzc3VRbjJCcG5V?=
 =?utf-8?B?cWVDTHlYcE1DY2NDOG9yTXpQbmljQXlNNVZqWTkyYjF3VHJqNDJ3ckhqdTBr?=
 =?utf-8?B?bW9sN3JlNlU3SElmNjRXOGVFekovdllaRWhlTEJZZVNzOTF2cFBlOEt1WXk5?=
 =?utf-8?B?bis0V3V3d1p2dzdqSnlOWFdYM0FkNyt2dnZONjJ0ZTZnSE1KbTBCVXZ6dGlR?=
 =?utf-8?B?R3JOUnlWZFFSZi9pcGhTdjNoN0dKQU40dVFHR1FlVEI3QjNCQTcwMkJBdjFm?=
 =?utf-8?B?bDNoZEhxbThhejN5V1BSelN2ZmlDelFjcGhucnUwdG5IUWlTWnI3Y0RlSlBH?=
 =?utf-8?B?TFFLZEJJdVpibTFNMEt1ZDdmYlFIRWxoUjY3SnppSGExZ2JjbzdtMDZra2o0?=
 =?utf-8?B?STJ2V1NoZUZIY3VYMmg5TkZZZ2lFYmNxei9kRDh2bDAxWWNrckY3UkJCT1pt?=
 =?utf-8?B?cFpnT0dxWXhtN2tnSUxYb3VrM29xcEtKTTRoaGlUSHBFVEw0U0dWNnhsMnp0?=
 =?utf-8?B?ejRnaUVlT2kvbnFEY1JiVEk2b204bHZCMCtUMndyYjhDU1FuMlIzK1I0SWFk?=
 =?utf-8?B?a1REZmdYektYV0NnYk1CdFRCWGRYRVhKOERnUVJTOGFYSHNzU1A3WnZBZ25P?=
 =?utf-8?B?aHJ2WENkSkw4bzNjUmdJeHVxQlRXRVhFUE16dFBmVTBnbkpaYkhZU3pFd1By?=
 =?utf-8?B?Uk90MDdQNHh0QkgxSmgyOWZhbm92TFpFbHFMbFNXUTJSNlF2UWF0NnhmWG42?=
 =?utf-8?B?dnhBWloxRS9sN3FPQW8xVnNQaWNBdDRPYnZkOXoyRU9BbHRoWnp1U1lFOFBq?=
 =?utf-8?B?VWJ3SC9tYXYraUtXTG1HNmRYMFlyYVVKcWVVcnlqa0NVczl2di9CbHZPcFFW?=
 =?utf-8?B?Ujc5YUxaeWcwVnhyOVlUd1JyS1hxMUZWWDQ0Qit0U2czRGF2cm83UjlXTk8w?=
 =?utf-8?B?dXJBQVB1ZG9VZGlnN1Y0Y0xzdW90bGZXOHEwMy8wSGNVOFFQaThJdEgzWklQ?=
 =?utf-8?B?SGs1THNMYVI4TXpYTEhzWjhacExMUVlmY3Y0YVhGVmNncWJubGRiWkI5NTVx?=
 =?utf-8?B?T2EvRGtLTGF6TFRzRlhXcVlJVDk2anlUb2JSQjlSUVZkVjVRak9zdU1IOEF6?=
 =?utf-8?B?eWNob29IQjlWVzBiNWtDcXpub3BFczlKMVlveUdZOVdCczFUM2hJUlRtTmVz?=
 =?utf-8?B?aVFrb1lOS05Sd3FrZWdheUZRVGQyR0lVcEMrODdiYkNYOStwTVBsRXF3Q3FL?=
 =?utf-8?B?Ulk1N0pkb2J1WGMzVmZSRHhxeHh2WWpsbnJYTGRuL01qNEdXLy9oWGtwNGpq?=
 =?utf-8?B?N3hBeS85UFAvTlpwSzBGcWVNRG9CSmZlanZjdHlNY3MwR2dGUmRWSE51a01M?=
 =?utf-8?B?L1EydHJuekRYWXhmYzNmT2ZFMzMybUlLeUtOdUx2eTl3OE1vU2VrZVNBVldE?=
 =?utf-8?B?VzhpZW1wSG9JRTBOQjY1ZDQrd0RveFVlRTdlV01nMGV6MkFBaHV2M3lZVVVp?=
 =?utf-8?B?WVAvSTN0b1c5QVlqeXk5aUw4SS9nRnJmVDdFamhCQ0hNU0lPdTlwbFFvT1F2?=
 =?utf-8?B?L2p6Z3JhMnJXN1FveXdKbUNHK3Vaa2VnSmdVZzE0YXRNZmVyVHlYWHc5RUkx?=
 =?utf-8?B?bWJKSW5rbVNOMG11M0I3OGpHSWRkRFNDNWJPWThUZExKR0ZEWG5IcFZKeWph?=
 =?utf-8?B?bkR0T01RbVJhVThOZGZQTk5XM2hyeTR0M1RQV21rM1RzVFlSdXoyS0U0Zndu?=
 =?utf-8?B?UVd2YW5GbXBLeWlJeWFDOUJjNVpQQWxJdCtiUVREcTNERjVDRXVpYm1kY2Nh?=
 =?utf-8?B?ZzZvcFNjK3hUdDAzeHV3ZThhWjBmMUVQZzRiVjJGZjNCSzNSUDNXaFJ1bnhO?=
 =?utf-8?B?akwrRCtlQ3UxODlGL0xjM2t2L3p2ZFovNmF3U3IyY1A3WW13RndvVDM1R3p5?=
 =?utf-8?B?ZFdJUjhXU0k5M1QzbnUrRzVRUFB6aFE5Z0xSakxiUFhuZ0hOTW5kbEViRG92?=
 =?utf-8?B?emx1dlNQWmthYWJlcC9JZ2dXaGFqbDhPa0RjNGppRVlzSzRldy9GaW1PU2hN?=
 =?utf-8?B?dFhsblBnZXp6Vm1vVjR6TUpNSVVsZE9JaVJWTGVhNzJkazl1aWt1Z3BUWmdi?=
 =?utf-8?B?RkM2MUFOaEZqei9xdU5tZG9HZDdiMWZIaW1kOXJJamZlb2dLeEhLQnVWNU5n?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fc981e-2f00-4138-591c-08dd1dc82d41
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 11:52:54.5974 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4Jn4qeTWRH9OVDV0zLIoBhFyyfumqecvqW/bBNSXR0aDcX5jII1iEwHGnaKZEsAZIobqlmEeWpfiC6PNeXPphnfazOk9GZFU8b+pUSXhZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10979
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

SGkgTWFyZWssDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiAxNiBEZWNlbWJlciAyMDI0
IDExOjUwDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBhcm02NDogQ29udmVydCBjb3JlIHR5
cGUgY2hlY2sgbWFjcm9zIGludG8gaW5saW5lIGZ1bmN0aW9ucw0KPiANCj4gT24gMTIvMTYvMjQg
OTo1NCBBTSwgQmlqdSBEYXMgd3JvdGU6DQo+ID4gSGkgTWFyZWssDQo+ID4NCj4gPiBUaGFua3Mg
Zm9yIHRoZSBwYXRjaC4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz4NCj4g
Pj4gU2VudDogMTQgRGVjZW1iZXIgMjAyNCAyMjo0Mw0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggMS8z
XSBhcm02NDogQ29udmVydCBjb3JlIHR5cGUgY2hlY2sgbWFjcm9zIGludG8NCj4gPj4gaW5saW5l
IGZ1bmN0aW9ucw0KPiA+Pg0KPiA+PiBUdXJuIHRoZSBjb3JlIHR5cGUgY2hlY2sgbWFjcm9zIGlu
dG8gaW5saW5lIGZ1bmN0aW9ucyB0byBwZXJmb3JtDQo+ID4+IGJldHRlciB0eXBlIGNoZWNraW5n
IG9uIHRoZW0uIFRoZSBpbmxpbmUgZnVuY3Rpb25zIGdldCBvcHRpbWl6ZWQgb3V0DQo+ID4+IGlu
IGNhc2UgdGhleSBhcmUgbm90IHVzZWQuIEluZGVudCB0aGUgTUlEUl9QQVJUTlVNX0NPUlRFWF9B
biBtYWNyb3MNCj4gPj4gaW4gcHJlcGFyYXRpb24gZm9yIGFkZGl0aW9uIG9mIGZ1dHVyZSB0aHJl
ZS1kaWdpdCBjb3JlcyBhbmQgdXNlIE1JRFJfUEFSVE5VTV9TSElGVCBpbg0KPiBNSURSX1BBUlRO
VU1fTUFTSyB0byBiZSBjb25zaXN0ZW50Lg0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBNYXJl
ayBWYXN1dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz4NCj4gPj4gLS0tDQo+ID4+
IENjOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20+DQo+ID4+IENjOiBDaHJp
cyBQYXRlcnNvbiA8Y2hyaXMucGF0ZXJzb24yQHJlbmVzYXMuY29tPg0KPiA+PiBDYzogTGFkIFBy
YWJoYWthciA8cHJhYmhha2FyLm1haGFkZXYtbGFkLnJqQGJwLnJlbmVzYXMuY29tPg0KPiA+PiBD
YzogTm9idWhpcm8gSXdhbWF0c3UgPGl3YW1hdHN1QG5pZ2F1cmkub3JnPg0KPiA+PiBDYzogUGF1
bCBCYXJrZXIgPHBhdWwuYmFya2VyLmN0QGJwLnJlbmVzYXMuY29tPg0KPiA+PiBDYzogVG9tIFJp
bmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gPj4gQ2M6IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+
ID4+IC0tLQ0KPiA+PiAgIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2FybXY4L2NwdS5oIHwgMjggKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLQ0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2luY2x1ZGUvYXNtL2FybXY4L2NwdS5oDQo+ID4+IGIvYXJjaC9hcm0vaW5jbHVkZS9hc20v
YXJtdjgvY3B1LmgNCj4gPj4gaW5kZXggNDBkNTRkYzg1YWIuLmFhMTQ3MGJiNzJkIDEwMDY0NA0K
PiA+PiAtLS0gYS9hcmNoL2FybS9pbmNsdWRlL2FzbS9hcm12OC9jcHUuaA0KPiA+PiArKysgYi9h
cmNoL2FybS9pbmNsdWRlL2FzbS9hcm12OC9jcHUuaA0KPiA+PiBAQCAtMywxMSArMywxMSBAQA0K
PiA+PiAgICAqIENvcHlyaWdodCAyMDE4IE5YUA0KPiA+PiAgICAqLw0KPiA+Pg0KPiA+PiAtI2Rl
ZmluZSBNSURSX1BBUlROVU1fQ09SVEVYX0EzNQkweEQwNA0KPiA+PiAtI2RlZmluZSBNSURSX1BB
UlROVU1fQ09SVEVYX0E1MwkweEQwMw0KPiA+PiAtI2RlZmluZSBNSURSX1BBUlROVU1fQ09SVEVY
X0E3MgkweEQwOA0KPiA+PiAtI2RlZmluZSBNSURSX1BBUlROVU1fU0hJRlQJMHg0DQo+ID4+IC0j
ZGVmaW5lIE1JRFJfUEFSVE5VTV9NQVNLCSgweEZGRiA8PCAweDQpDQo+ID4+ICsjZGVmaW5lIE1J
RFJfUEFSVE5VTV9DT1JURVhfQTM1CQkweEQwNA0KPiA+PiArI2RlZmluZSBNSURSX1BBUlROVU1f
Q09SVEVYX0E1MwkJMHhEMDMNCj4gPj4gKyNkZWZpbmUgTUlEUl9QQVJUTlVNX0NPUlRFWF9BNzIJ
CTB4RDA4DQo+ID4+ICsjZGVmaW5lIE1JRFJfUEFSVE5VTV9TSElGVAkJMHg0DQo+ID4+ICsjZGVm
aW5lIE1JRFJfUEFSVE5VTV9NQVNLCQkoMHhGRkYgPDwgTUlEUl9QQVJUTlVNX1NISUZUKQ0KPiA+
Pg0KPiA+PiAgIHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgaW50IHJlYWRfbWlkcih2b2lkKSAgeyBA
QCAtMTgsOSArMTgsMTUgQEANCj4gPj4gc3RhdGljIGlubGluZSB1bnNpZ25lZCBpbnQNCj4gPj4g
cmVhZF9taWRyKHZvaWQpDQo+ID4+ICAgCXJldHVybiB2YWw7DQo+ID4+ICAgfQ0KPiA+Pg0KPiA+
PiAtI2RlZmluZSBpc19jb3J0ZXhfYTM1KCkgKCgocmVhZF9taWRyKCkgJiBNSURSX1BBUlROVU1f
TUFTSykgPj4gXA0KPiA+PiAtCQkJIE1JRFJfUEFSVE5VTV9TSElGVCkgPT0gTUlEUl9QQVJUTlVN
X0NPUlRFWF9BMzUpDQo+ID4+IC0jZGVmaW5lIGlzX2NvcnRleF9hNTMoKSAoKChyZWFkX21pZHIo
KSAmIE1JRFJfUEFSVE5VTV9NQVNLKSA+PiBcDQo+ID4+IC0JCQkgTUlEUl9QQVJUTlVNX1NISUZU
KSA9PSBNSURSX1BBUlROVU1fQ09SVEVYX0E1MykNCj4gPj4gLSNkZWZpbmUgaXNfY29ydGV4X2E3
MigpICgoKHJlYWRfbWlkcigpICYgTUlEUl9QQVJUTlVNX01BU0spID4+XA0KPiA+PiAtCQkJIE1J
RFJfUEFSVE5VTV9TSElGVCkgPT0gTUlEUl9QQVJUTlVNX0NPUlRFWF9BNzIpDQo+ID4+ICsjZGVm
aW5lIGlzX2NvcnRleF9hKF9fbikJCQkJCVwNCj4gPj4gKwlzdGF0aWMgaW5saW5lIGludCBpc19j
b3J0ZXhfYSMjX19uKHZvaWQpCQlcDQo+ID4+ICsJewkJCQkJCQlcDQo+ID4+ICsJCXVuc2lnbmVk
IGludCBtaWRyID0gcmVhZF9taWRyKCk7CQlcDQo+ID4NCj4gPiBNYXliZSB1bnNpZ25lZCBpbnQg
bWlkciA9IHJlYWRfbWlkcigpICYgTUlEUl9QQVJUTlVNX01BU0ssIHRvIHJlZHVjZQ0KPiA+IG9u
ZSBzdG9yZSBPcGVyYXRpb24/Pz8NCj4gVGhlIGNvbXBpbGVyIHdpbGwgb3B0aW1pemUgdGhlIHJl
c3VsdCBhcyBuZWVkZWQsIHRoaXMgZXhwYW5zaW9uIGhlcmUgaXMgZm9yIHJlYWRhYmlsaXR5IHB1
cnBvc2Ugb25seS4NCg0KT0suIElmIGFsbCB0aGUgY29tcGlsZXJzIGF2YWlsYWJsZSB0b2RheSBp
cyBtYWtpbmcgb3B0aW1pemF0aW9uIGZvciB0aGlzIGluc3RydWN0aW9uLiBUaGVuLCBpdCBtYWtl
IHNlbnNlLg0KDQpDaGVlcnMsDQpCaWp1DQo=
