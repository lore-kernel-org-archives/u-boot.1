Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD63FD5B158
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 21:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4CDD89145;
	Mon, 28 Oct 2024 22:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="cuHCayB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C9C3890E7; Mon, 28 Oct 2024 16:30:21 +0100 (CET)
Received: from BEUP281CU002.outbound.protection.outlook.com
 (mail-germanynorthazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20b::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 925B688D06
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 16:30:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=iris-sensing.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=erik.schumacher@iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gZLxsolgaKbyb/TRTOkfjRUA4SsG5qsBigXukor9mXOj9vEdsFIB1nAkmCumeGMN5cJdq4wTW+kFMyIe5k+53EuTly+D3rZ9yrmtMGswbMgGZrPdXbnJ/xrz3ZWA+cKgbiD9eXiFxqmiR0wDcJvtOv26OfbZy1Xrfe1CLoesCg2zxSh7dHlaMUs0oOjYGwQrCC1vKpvtZiYz3ICsHNWgwl0mzVVHyFzhk7oLMv7dwjA3YrAAVmISt5kMMvR0huFyKeb/3LAxbqjPzHJsfQXIgK3nZGMVamAhctTQlZnpzwWYhXuOgZa+Y+/0XBLYxZZ7WAaw+n9p9vO48WEUScGRow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFIRSyl7Yvo1ug9fcLxFTQa/xS+khwqQgEI/ZdIfZ4k=;
 b=lxgHklpSzo/6YdYN4SzBJ/pncHPc1XmVyp14B0tDiiiLPxTN5/uCEgbxM7B4DVqfZYtHbaXUhNwPqnEkrjP+88iNjU683lMhOGeQiph20Y9/OEFK9VNJF6yQ1jkuyoH7S0AbDRouwLH99ENYT26+0y6ndmYwfN+eakxip6dwLeYVIukBsvnEgW3rF20HTE53kUJQfUGgQR+0MhoGrG+M+XqhEsDmYkhIEnfjCIKQpBisOBukrE3EfDHcMsqzZq6DtHg3A2yuu5zuAphYhJsfvGN4n3czmSpgjmGQ8vxiKeibJ0rdlVOje7MGw7yy+WFqq9mj1mRb6h7CvIIbz7GsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFIRSyl7Yvo1ug9fcLxFTQa/xS+khwqQgEI/ZdIfZ4k=;
 b=cuHCayB9/FpiPcissbL86u2YEIhaafD2PJxbSs0N1C0kT7MaknhiU84YfqKIVMcY1iJZn7aL7Flao+IjWGq1tMTWJH8a/a6F4ojpCaSTyqwMlAyTGJS/o6PygPLq4vzbq3Rl5RMZOFt/hmQhFR8eDTunCGb4SXWvCk9DH04KsAO13Cbng6dXkIuxUVoxT2YT9TvHeamAYyAbAbOkfyecvdkzja1Qm4dH4Ymoiaiz2wkPWT5WY2UJPL4j3kPbFwzPvUmCTqcaPk1UaVlJzPPKepqNTpX5eEz6ub9zWc5b81soAPEf9IDXyVSJ2afodw3eJmcOQB2pGEqQHY2T524vMA==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 BEZP281MB2597.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:2a::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.27; Mon, 28 Oct 2024 15:30:18 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.025; Mon, 28 Oct 2024
 15:30:18 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "pro@denx.de" <pro@denx.de>, "marex@denx.de" <marex@denx.de>,
 "joe.hershberger@ni.com" <joe.hershberger@ni.com>, "rfried.dev@gmail.com"
 <rfried.dev@gmail.com>, Erik Schumacher <Erik.Schumacher@iris-sensing.com>
Subject: [PATCH 2/3] net: dwc_eth_qos_imx: Add platform specific reset for
 i.MX93
Thread-Topic: [PATCH 2/3] net: dwc_eth_qos_imx: Add platform specific reset
 for i.MX93
Thread-Index: AQHbKU5Kt49x/cFYgU2RAJUdGsC+Qw==
Date: Mon, 28 Oct 2024 15:30:17 +0000
Message-ID: <ac0e9674f4a5aecc2026fe3e2364624e27231dc8.camel@iris-sensing.com>
References: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
In-Reply-To: <0b4ebdf6a0219a871eb031fccd9aa6d8c9cb2348.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|BEZP281MB2597:EE_
x-ms-office365-filtering-correlation-id: be6c6a92-aa27-4e1f-b1e2-08dcf7656d7c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?U1h1TDVGaVV6d1pkbHdRallMQUV1ZHV2LzVwdklWS0VFdnBOalROS3V3Yjl0?=
 =?utf-8?B?bG1UWmJ3UFp2cTR2REVPK3B3amZBOEtwd2xmSndieVZVckx3Y0kzazJZMkpi?=
 =?utf-8?B?VnZxeVkzWFoyN3plTzhPT1FBVXZLNHFOck9SVWhTWSs1MUdIbXNobGFIdmRN?=
 =?utf-8?B?aVdSWGpoUG51dlZxRlozZ21mSzA2RElNd0xacTg0NkZPWXB2aVBCKzhnWGxO?=
 =?utf-8?B?bVRnaDBGVVVLUVZQVzZ4WitPRTFZMTA3VHFVZHQwMEltWFNsSVEzYXBaSitp?=
 =?utf-8?B?Um1CWVdPUHIyNGxnS2F2WmxEbVBCUHJTK25UeXBMOE8zb0Jra0NPYnhvT2NO?=
 =?utf-8?B?OGZpaUM4VVA1Q3hta0NEZlMzZFdqTytnamZHL3I2NVJoUlRnRzAwTEZxdmhv?=
 =?utf-8?B?Zmx6WUxiOUh6TlpQYWRXK3kvMXZjU2tNY2VGWHNzV3pSMUVuWW1XRDh2bHNp?=
 =?utf-8?B?RjI0MzFHbkg1TjRTRVF5QklqVk5hb2JNY1QwYTArcktvYlFNSVcrMHJBUTNq?=
 =?utf-8?B?YTQvRjVuTU5hTHc4NmpVcE45SmJUUEJvZ2ZQYThYNEFZMHJuN0Q4ZmpTQ3Jy?=
 =?utf-8?B?SHo2R3Vxc1NmYVRZQzVuVy9YcmJ6WnhDVWRrRFRuOWVxelVLZE93N21JSmpo?=
 =?utf-8?B?ejZ6OC9IdXdkTmlBMzVWTFRJUTJZYW5RUHdkWWMvU0pzS08vZVJlQXpXQlk0?=
 =?utf-8?B?TXl5U0dhOU5HTmVjNHhoVFA4MEZVTGxDRTlmMnNzV2RRMXFmSVJVY3RNamIz?=
 =?utf-8?B?OTl1Mkk3aTdVeXBaZ0VxWEtycW0xOSt0cVhra1hraCtLMHFzVGdTT1k4MWQ3?=
 =?utf-8?B?dUFKTzBpRWtOWnduOW5OWElBZGl2RVFNZ1NmRHErVG1zbHZRcTlFSUJoWDNE?=
 =?utf-8?B?a2VaeVo2VnltZ1Z1UXVrYnYrRGFMTm1kOGs0NzJlN3NRdDIvZThIZUpZbWdS?=
 =?utf-8?B?WTNpTlhQRzFBZjMwS1d1ejBHY0FvZE1Cd1VqRWtzWVpsZCtNb21MNWkvYTZB?=
 =?utf-8?B?d0RKank0anh3S083NnVMYmtjRjhCdFF0Z3c3R3lpa09RSDhhMFVDTnZYbkxG?=
 =?utf-8?B?SkNQSEpMTitkbldDUElTSDRqTzlBV2NDNzZ0cnYrdkd4TXN4Vll4bTY0bUU2?=
 =?utf-8?B?OW9RNmlHanIvVjU4YmZZMTRaNy9peklPeExnendUanBreVhwUFAweU5iVjM0?=
 =?utf-8?B?cDd6eHFYREFiTDIya3lMUSs4OW45KzVXb3lBbjdpQ0ZwNzlMaFZJVkhSSDc3?=
 =?utf-8?B?WWRoNDJORGVONjB6RnBDbTBDWTBGeWhLK0xDTytxbDdRalZBQ3JEVWhJNVdR?=
 =?utf-8?B?dTNST1JDQzlxQ1d4UkhIUUNPZmpUditwbFkwQ1R5blE4WXBIWnVLVkJFRnhX?=
 =?utf-8?B?QloydTY1ZEFjYnkvL3pick0xbmV0ZU95Umh4cmdIdjhmVGhraFdpZHpTcWRv?=
 =?utf-8?B?M0tQc3lZYWxVeGxUcExVbDlFOFVjVnE4MFl5YzNlVWZtbU56UHlBS2tiSHlE?=
 =?utf-8?B?S3E5bmtETERZMWpFWFkxRTJYMHA5eHZEQjhvMWZHQmNFMGlCMnNYcjEyK3hr?=
 =?utf-8?B?elRWWURjKzJOTnhIajFROTJHaHJPR084bzdsRlBMcHNtRTNMNnBDMWRoQ0Ux?=
 =?utf-8?B?c29oU3BwS0UydUh0SnVwNWM4ZkhGNUNyYzdZY0d4YmdWTldyVnJxTlZuK1Q3?=
 =?utf-8?B?TEdsVkEwWGZmMElmTWdwYkdTS3IxdnhndjhpWURKeXpuVmFBVTF4TUhyUWI4?=
 =?utf-8?B?d2NuM3A3SHEveVlwR2hoZ0J1TFVFZ2JUVld0R1V1bkNtOXBTU25jSGY1UnRj?=
 =?utf-8?Q?BKFCZRDYvJW9EW3qCGlJFYIW70f8W4HIFLj7Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bVA4bHlUcHdNclB1clg0QVFkMnZodGNwdFZuWGFwa1ZSODI3MTdOVStzYnJK?=
 =?utf-8?B?ME0yQXQvckh3eVlhZWdLU212S0xpSTZnVjJUN1R3SWJhT2FEQWEzYUsrbjVm?=
 =?utf-8?B?bFdPSEVtbVBicW1YTHArZm5BcElQbmNkY3VsbEFUN1dpaEEvNjE4S1Q1ZkEw?=
 =?utf-8?B?ZlZhYmxwVkwxV2M5Z1hkOVUzRnkyTWxtd3JrZ3RzNmpTeS9scW4xdFI2T2Y2?=
 =?utf-8?B?dzE3NzNYN0d6bFNOT255WHU2NGNtT2RlNG05VE9tckQ3UG5zMkpNbi94ZkZ1?=
 =?utf-8?B?SDV4UHpVWm9rdjhzWU9MK1BJTDNsQ0FvU0tTNkx4cVc0ZEkyalUzR3o3Umhw?=
 =?utf-8?B?UklzQVZWeHgvMWlKaEd6dDlTZkJEU1NiQ0VZR3dITDAwOGR5b3laS3JPZTE3?=
 =?utf-8?B?SHJybklZNGNOOUdmNUhGUDFXalRUY2lvT3JkQS9yR2dhekJ1WDdJNlpwUG1U?=
 =?utf-8?B?R083bTIySUhZOHBqMFRYWFlxYXNUZ2tlK0grYjJiMEFzZ3FXclZlYmQ2elkr?=
 =?utf-8?B?TTZpRDRieDJ6d0RwOFJCMU10TVJYZ3MzdGIvR2ZEZUovUlNITzFOTnkyTmVy?=
 =?utf-8?B?ZmhmU0t2di9TTkJwcVBQaldLTUdkNGxWVnd0bEFEQ092SG50ejd3WFFHSzBj?=
 =?utf-8?B?cCtZM21KeUpsR2czQW40akd3RHpQakVBanpJam91NmIvVnRxcGVvQ0F5TVRG?=
 =?utf-8?B?cVEyY2c2VjQ0Z1VXMzZ5VWpYWnZ1VUM2NkRSak5zaHpCTm1STkN5ZjBFL1Rj?=
 =?utf-8?B?WmFiVVJ1M1VCdnFNdmpLbEpCam5RYTNvVTRQQkJsSWZ1dS9yZm5adm9WQlNW?=
 =?utf-8?B?bVEzcTdJM1FMaTExUnV3UHI1Q3ZyS0ZKckpFVDZSNDN5VkpPd0dENmJsSExt?=
 =?utf-8?B?b0MrMExWNjBaK1VaNExNL2ZMVHVXWkRBTjZSRkhtRHRINU9qNDBMa3lONGE0?=
 =?utf-8?B?ODFaU3R2ZDNTNXFkei9GMGkrblVBdnA1QzZabXpjT0RxRndDUWVFaGFuUDJv?=
 =?utf-8?B?TSt2dDVKVXU1UVZCN1pNemhqcHp0VGlXRC9EVjVOMktWc2hEcmZ5SWcyVmdU?=
 =?utf-8?B?T1dMazljSGJKWkhPNGYvN2ZwSHNid3NscG1BMXV3L3JQNnhZeHZiV2ZETmY0?=
 =?utf-8?B?eGE1aFltS2NMTFM1N3RoUjJJYjdxZXd5NTQ2SHBiWTYzTWMyVndMZTMwUUpv?=
 =?utf-8?B?N2QwYTB4QWxxUFJReFdaT0ZyN3FBSHBQc1hyTG1VS0lTYWNyZ2dLTWorQmxk?=
 =?utf-8?B?VmNMRitEamRPWmJ3SVBvYWRXRlFidUExSnM2WlV0MUNaUkFQcnllaVFsNUgv?=
 =?utf-8?B?b29HeHlJL1ZZUk5hRTZSQ0hlT2dSb2Y0cjlObHFOSFVNbnZKNDkrNDhGVmZZ?=
 =?utf-8?B?Z3dJVDV5U3c0QTFHR0t5K1FsYWtDSkl3MjM4ZmE1NHdPeE5zRkJzVUhHQlRZ?=
 =?utf-8?B?ZTVYdFgvM3VacmtBektrR2ZzUjdzeS9kVlllZ1R1U05KdGNMWHhLVzllampV?=
 =?utf-8?B?ZG1jZjRaQTNmZ0dvdkpzMFJOM1lkbTdBK0JCS2pZdVMzcjBTNzlhOHkvektk?=
 =?utf-8?B?TGtxeWVUR0R2ZGI3Rmw3c0MyV280dTU2eVZ2SmwvMDFTaGhmRjlPQm5JKzk2?=
 =?utf-8?B?YzZnVUFHTHpZYVAwMCs3SnppeDArdHA0M1BhVDNXbTI1SENrSXR2dUdIVVhW?=
 =?utf-8?B?cmVMSnd6aGFVaXZudmxYOG14TlpDR2pCYTNrU3ZGbTFzdVl6ZldMSVdFSFpx?=
 =?utf-8?B?ejVuU2h4cHJHc3FFek50Ung3VTFMQkdjMy9DZERVS1J2SkliZzE0K2JXSElC?=
 =?utf-8?B?a3BJczJ6Qk1YblcxV3dEZ2ViR1AyRFR5ekxsT3JZTWsycWNUL21udnh1Rlpo?=
 =?utf-8?B?Wk0rdVcvWDdmbkRqWHRXWi9jVk1CS3BWdU5tZTdvenp4WFZIMTdZR3pORTRw?=
 =?utf-8?B?SGdKekdsL2JaZ3g2UzVFS2p5RnpxMHdiMnpCOXc3RlB2KzNVMytQTkVNdWlC?=
 =?utf-8?B?TUJPODFjdytRdFJpdHlkWkJFSElPbFpRNDdBZEZGd01sU2xmUFZYMXhkVWx0?=
 =?utf-8?B?R0M2WXQxZDFOWnlVa0Myb1dWQmkvSC9lc1FUS2ZWbmt5RHRVMXZkTHdpenpi?=
 =?utf-8?B?ZDNTSStsQ2Zzek1VbDVDYU9BaG1CNkRqTExWQ3BQUVNnK3NSZExMcWw1NjMx?=
 =?utf-8?B?RUhhTDE3QURQSDRDdkZYNHNhWWdxTkxuSVkzZWtYS3d6TEh2OTE0RkpkOTJs?=
 =?utf-8?Q?t/OZPnnGwsjxSkDnY/E1Kungl/NIfyidLp8kuG0D5o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F01F3DCE0672749B351DB3CAA531EBA@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: be6c6a92-aa27-4e1f-b1e2-08dcf7656d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 15:30:17.9882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7Bj/4ofYNKbhiWDN7XtY6xYSFlPi/GgOY9FpUD8uf8ewuDuvHQ1vL3Ur2a7MTf1uj8Y61LKWEEih69bMxqOwheaT8ucenEqkJ45MOIoxMlpBjElSUhe96jR6iN14RA6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2597
X-Mailman-Approved-At: Mon, 28 Oct 2024 22:32:48 +0100
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

VGhlIEVRT1Mgb24gaS5NWDkzIGZhaWxzIHRvIGZpbmlzaCB0aGUgcmVzZXQgcHJvY2VkdXJlIGlu
IFJNSUkgbW9kZS4NClRoaXMgaXMgZGVzY3JpYmVkIGluIGVycmF0YSBFUlIwNTE2ODMuIFRoaXMg
cGF0Y2ggaW1wbGVtZW50cyB0aGUNCnByb3ZpZGVkIHdvcmthcm91bmQgd2hpY2ggc2V0cyB0aGUg
UFMgYW5kIEZFUyBiaXRzIGFmdGVyIHRoZSBTV1IgaXMgc2V0DQpieSB1c2luZyB0aGUgZXFvc19m
aXhfc29jX3Jlc2V0IGZ1bmN0aW9uLg0KDQpBZGFwdGVkIGZyb20gbGludXgta2VybmVsIGNvbW1p
dCBiNTM2ZjMyYjViMDMgKCJuZXQ6IHN0bW1hYzogZHdtYWMtaW14Og0KdXNlIHBsYXRmb3JtIHNw
ZWNpZmljIHJlc2V0IGZvciBpbXg5MyBTb0NzIikNCg0KU2lnbmVkLW9mZi1ieTogRXJpayBTY2h1
bWFjaGVyIDxlcmlrLnNjaHVtYWNoZXJAaXJpcy1zZW5zaW5nLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
bmV0L2R3Y19ldGhfcW9zX2lteC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKysrKw0KIDEgZmls
ZSBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9k
d2NfZXRoX3Fvc19pbXguYyBiL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zX2lteC5jDQppbmRleCA2
NDI0MzI4MzRmLi5hZjQyZjc0MzZjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvZHdjX2V0aF9x
b3NfaW14LmMNCisrKyBiL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zX2lteC5jDQpAQCAtMjE2LDYg
KzIxNiwyNyBAQCBzdGF0aWMgaW50IGVxb3NfZ2V0X2VuZXRhZGRyX2lteChzdHJ1Y3QgdWRldmlj
ZSAqZGV2KQ0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIHZvaWQgZXFvc19maXhfc29jX3Jl
c2V0X2lteChzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KK3sNCisJc3RydWN0IGVxb3NfcHJpdiAqZXFv
cyA9IGRldl9nZXRfcHJpdihkZXYpOw0KKw0KKwlpZiAoSVNfRU5BQkxFRChDT05GSUdfSU1YOTMp
KSB7DQorCQkvKg0KKwkJICogV29ya2Fyb3VuZCBmb3IgRVJSMDUxNjgzIGluIGkuTVg5Mw0KKwkJ
ICogVGhlIGkuTVg5MyByZXF1aXJlcyBzcGVlZCBjb25maWd1cmF0aW9uIGJpdHMgdG8gYmUgc2V0
IHRvDQorCQkgKiBjb21wbGV0ZSB0aGUgcmVzZXQgcHJvY2VkdXJlIGluIFJNSUkgbW9kZS4NCisJ
CSAqIFNlZSBiNTM2ZjMyYjViMDMgKCJuZXQ6IHN0bW1hYzogZHdtYWMtaW14OiB1c2UgcGxhdGZv
cm0NCisJCSAqIHNwZWNpZmljIHJlc2V0IGZvciBpbXg5MyBTb0NzIikgaW4gbGludXgNCisJCSAq
Lw0KKwkJaWYgKGVxb3MtPmNvbmZpZy0+aW50ZXJmYWNlKGRldikgPT0gUEhZX0lOVEVSRkFDRV9N
T0RFX1JNSUkpIHsNCisJCQl1ZGVsYXkoMjAwKTsNCisJCQlzZXRiaXRzX2xlMzIoJmVxb3MtPm1h
Y19yZWdzLT5jb25maWd1cmF0aW9uLA0KKwkJCQkgICAgIEVRT1NfTUFDX0NPTkZJR1VSQVRJT05f
UFMgfA0KKwkJCQkgICAgIEVRT1NfTUFDX0NPTkZJR1VSQVRJT05fRkVTKTsNCisJCX0NCisJfQ0K
K30NCisNCiBzdGF0aWMgc3RydWN0IGVxb3Nfb3BzIGVxb3NfaW14X29wcyA9IHsNCiAJLmVxb3Nf
aW52YWxfZGVzYyA9IGVxb3NfaW52YWxfZGVzY19nZW5lcmljLA0KIAkuZXFvc19mbHVzaF9kZXNj
ID0gZXFvc19mbHVzaF9kZXNjX2dlbmVyaWMsDQpAQCAtMjMyLDYgKzI1Myw3IEBAIHN0YXRpYyBz
dHJ1Y3QgZXFvc19vcHMgZXFvc19pbXhfb3BzID0gew0KIAkuZXFvc19zZXRfdHhfY2xrX3NwZWVk
ID0gZXFvc19zZXRfdHhfY2xrX3NwZWVkX2lteCwNCiAJLmVxb3NfZ2V0X2VuZXRhZGRyID0gZXFv
c19nZXRfZW5ldGFkZHJfaW14LA0KIAkuZXFvc19nZXRfdGlja19jbGtfcmF0ZSA9IGVxb3NfZ2V0
X3RpY2tfY2xrX3JhdGVfaW14LA0KKwkuZXFvc19maXhfc29jX3Jlc2V0ID0gZXFvc19maXhfc29j
X3Jlc2V0X2lteCwNCiB9Ow0KIA0KIHN0cnVjdCBlcW9zX2NvbmZpZyBfX21heWJlX3VudXNlZCBl
cW9zX2lteF9jb25maWcgPSB7DQotLSANCjIuNDcuMA0KDQo=
