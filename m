Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4E5FF60C2
	for <u-boot@archiver.kernel.org>; Tue, 31 Mar 2026 05:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E40D83DA7;
	Tue, 31 Mar 2026 07:28:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="mqt3z4gS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF94983DBF; Tue, 31 Mar 2026 07:28:04 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB69883A41
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 07:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SH4e8A9QlFTO4E8ZMwK/gKdeLFIhClTR6n45t41BP7mTx25LKqIQf6J8dUJktlg0CVoXTNOL9CVVMmoMldfszNO9gpaPtlH0qB9mBj4leGgTt7j99JRBt3lE3OFZkAVDz4/XdTNDeKSjgG8meCKL3RdggFbpNKzHLIs5+xJJo23vi6/i+yXRIJFcm1W0C1dSVOoqI1JbVcXM6W62FcwHwPyuHxqzbZC0kTibFE8VCPjwWVZ0bBEVUFLOvUVT2O+nlww+7fYzqTLKZJuSn4qbpoCjM7Q5RBjZo+BPTuarLsU9MdhgYUvm46+mB/AstQi3Qz+4T2LjP2CZfTBRLbZIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArYXAK9gPqO1Uo8nPVd1/1DajuOEoqN5Ix2qb6hrZI4=;
 b=NRwIfg1Ko48KnVEDidwrgEALhxGSqWoNhxthFeFy2/cwzMoDe2gWQhX/CK0QD8QLTeH0RbFC+w3eKleM0UkS7XhQ+UGxVF7lNNt4DxSjHl9prF0vG4LYsZVmNL5VGrcUKm86UjwLCDXEVq6CCToCT7TTjnnXmkueK0agppEtBatxz9WiIXeyW27FCCQh55deqsgjj48r3JwgSmIgAjBTDFkIv6oRiNolBfcyqYDG5q8ylKJYufIt+SBwuASd6OKe5LI+jNUmuxmwhFJ2okeKGPYck5k4eJYN6ZM0uZYOED++WZTMckkox6j0oI6FzghF/F/UZeD76hDoxa7K+RIpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArYXAK9gPqO1Uo8nPVd1/1DajuOEoqN5Ix2qb6hrZI4=;
 b=mqt3z4gScSi4W9XlB5/Bu4t06H+LDTadrVF/YHjCJBUN+Tboba/MIERQ0vkU4lSO4tQSQWxYF+fpd+lE+OfGzPRDu/AfQRInkBmsIG3KKTpIm6J5o43hgTI5cALaWwqsCRn8faoFDjEc4KFcpe5hm4zJsz66AgVGVNOWB5b5el6KoqpEKhEK/fUr0GmFNEPggU9/CwW4/TDWtpcpYKxcpVMY07qMtXlqOEHOESv1WKAAin6MXQUJ8xK6dwk91JVF8EAPFtOFn+jh5vvkBqpCxFTlqStajverVAURJRL7qEvrj1YKR0h09Kf9UJ2tzgCD8sFkqUFTkKXdhdeG7HjNtQ==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by AMBP195MB2790.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:6a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 05:27:58 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.20.9769.011; Tue, 31 Mar 2026
 05:27:58 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom Rini
 <trini@konsulko.com>
CC: Teresa Remmet <T.Remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Leonard Anderweit <L.Anderweit@phytec.de>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH v2 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcwEN92dOpOmWvTkObH9NnHfIBorXIHbyA
Date: Tue, 31 Mar 2026 05:27:58 +0000
Message-ID: <d84c187f2f6d84378a1257af71c3b8436bdc8154.camel@phytec.de>
References: <20260330-power-legacy-v2-0-47dde3182a2c@nxp.com>
 <20260330-power-legacy-v2-1-47dde3182a2c@nxp.com>
In-Reply-To: <20260330-power-legacy-v2-1-47dde3182a2c@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|AMBP195MB2790:EE_
x-ms-office365-filtering-correlation-id: a75ab1e2-ead2-4160-fcd1-08de8ee64506
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: ZHdqrby7GLxJlhjSmG/3n7JAjvWVQU7sIGIN13fLnsq2YR+tdwwJVcJ/DTQPOlJ8dmEv0gU90/aZQiIKLzut6C8Tbv8s/6FHctArSusZRLdMoV43iPzwiEvgR680dgZS9xnKLKXSY9eWpHb+9ydk2GkXgob1V06/bYULLj/srRLKYL9h0ySNZ5L3/HL+wM3v9fbDwHqSus2LI4wtRy0FXcE6nO2SwGft1yJv5kkvtZr96hzW3aBVxtOnJrSgXJ8kmaqkLfRPWqEyrvUGzhJgopGJwCq+wE5tZ9Nj/qBNf8TYPQWFozmDexNi7d8cot07BbV5zYez7T8TE0NrEtvklHwN98YSUTXJf7U2yay7y2IP0u8EUxEbdCZVpHe3rSlolhENxE3ITNrfWcf/8jwVyezK4OIvYLzz3pToHWHkuRG3rGGVXPIw5uBc4G7BYNZIGyCrJZjK2Q9DWJNvD6hGTNZhVgMqblVoPa5JmK0lZmAed0Jv0IKjVxMXW/rH8LCYaztdNtspwjn2fdUUpT9o2qpg1dIOj2ctWq/ZFLYRJmqlvwgtStTLWCltqOms9xiHIT1yTZWSZHfLJlXLIJQr4nt0d5r6mFBpf15TkMJXkLcdEb1ql1p4K34UZ8EctFraMX0ENCGGA/8XYApdN0CHXYEHXoJmxbLGk0mZU0zZmJxfc4OJ5p3pA4+7Jlkj9d9HWNW65BPS9BcsN/p7HYBAR5i31D7LbIFzyJmMy0/xDj3O9m8c9DgKWQtvI2L2RAKxIBlQhR9hhOzRL5FGnozICsUAWnuntNBIcBeCYHng++k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TnZGSGxhVHFDdW45SWdxMENQcUE2eVQ1UWJXb3l4NXNXNndOUzdDSWhxc2Uw?=
 =?utf-8?B?QlNRY1lUd0h0ck1idTFCYVgwdTNTVzBuQVZtOXRrRDZuYVRBOFpmbmJNRXpU?=
 =?utf-8?B?QXpla3VtUktieE9jMnhEanNrckV4dDltWGxYUFg4VzhEbmdNeStwYjNpb3RQ?=
 =?utf-8?B?Q2tXWHFnSmMyMkRwckMxTUFYWjZpMGZiN1MrdE9VbThSWkZib3QrRFp6aldo?=
 =?utf-8?B?ZW1pOWFhdTFTakRSRWhxL0lSdVkwUkl6QjRtSjhLTk9nWlpxTEd1VU1Mb3Ey?=
 =?utf-8?B?RThNbEVsSXRvRDN6Q3o4YVZteVZoSW83cTM4RTNJRDAybk5LTGFoczBCb3dK?=
 =?utf-8?B?N0lBMVU3Y2F3cWZoakpmbktpUk55eXl2SmdLOElndWJpM25OWGNmejJiZmxr?=
 =?utf-8?B?VjNaNUY0VEtxZlZMVG9EZW4vM2ZPOEttM2s0bHBiUVhrZ2o0YnlYakdXWlRF?=
 =?utf-8?B?aXhiUWxybFhMSTFGL3BkUmJ6cHkvTVhONTdPQzBzVkdIYkg2c0VqVjdiamxi?=
 =?utf-8?B?a1RCVTIvZW1PSGsrSE5vRU4va2NPSGhRZUpLZlpTUUl6U09LTjlBN1dIRm5q?=
 =?utf-8?B?SE8xRnlJYVRPajI5bUtaWmRSdFJLNmVFSzI4ZnZNMjNwQXA5VXpwc294VVVS?=
 =?utf-8?B?VVhlZ1ZIN3c3VC9hNVNlOU42N1FQdzJOS3AyQVdnb1RHelpwWVBkeTAvdWtM?=
 =?utf-8?B?TUJadnRBWGU3Ry9tK3k4bVoxdmY0MjJNZDA4TkxNTjl0b2dVZ2hFRDBxeVp1?=
 =?utf-8?B?L3ByRzNZVnN3UFNxa2phZ21OQ3hwYVlrQ2tDckg2TzhqNkpENGErTFFDcFRr?=
 =?utf-8?B?R0NnbjZmVVI5RXhHSVlQdHJ5cURJbkVsL3hzdE9QVVZPTEJncGVqS0NURWFp?=
 =?utf-8?B?UEk2aHFjTmNRY2JGQkE4UWZHZ1d2NXlmdkM5a1dPMkYvM1RMR0hoa0FyT2l0?=
 =?utf-8?B?akxuT2ltVVFMd3cxOXo1WGxlUisvcGFoUkRZZkpDbHVVVTJBSzRzVHJsZ3Vk?=
 =?utf-8?B?YkdiNXZ1QTVhU0ltbVcvc0pxQ3RyaERnUnd5bU4yVGoxNlVlaFltMU9INTE1?=
 =?utf-8?B?NWFGYnpsbWxNSFBNaWN6RGdHcVBtdVpSdnRLdnJpOVU0QzN1K0d2dzIxb1Rw?=
 =?utf-8?B?dUhMREp0c29pWHNiOW5kZWFmbzdOL3dwTGlWOFdPNVFFUEQzendrUWNjb0U2?=
 =?utf-8?B?bDFmNjlDMFI0cVkvMVZyZ2gyMXFHVjAyVHJSMG9DVXJOVU5YaUdaZ2JvQ21r?=
 =?utf-8?B?NnJnOGt0OXNXVWlLMXl3dFlra25jMnRjMGoxc2F0d2c4WExQalBHR040TjZ3?=
 =?utf-8?B?Q05KUENvS2JPY21oZXdzalpkOWhvOGNqcGkxWUE0ZUNMeDRpQjZOVE01U2Np?=
 =?utf-8?B?NE9Qbjg3MWlsSzRsbWZwZzdKVEFOL24rWW5obXZKdW1NU2RDR254SG9mczlQ?=
 =?utf-8?B?N1VpcCsyeHhGUE1ZdkNZZ2FHQ1JWOHFVR0lJUDZsMklYZ3RuL0E1TXA0Nng3?=
 =?utf-8?B?cTJBSmFZWUZFeE9JWWlwMUJoUitsNU8yVnNudDE0ZXphUHRJdlo5b3NqTVZt?=
 =?utf-8?B?YUlTOHNJSGs3OXRGNFZ1b3c2UXNOUzhpVmR4NHJXQjFEbkVwbFpKYmo4RjRS?=
 =?utf-8?B?TGhEZkp2eEIxc1AybmRhdEMycXBmNXdsdkVERVRPZTdJakJ3RDVXV3Y2L3dB?=
 =?utf-8?B?M2pndzVBa3lsSVV5MGtNNVV3WWVMMC9pSHJab0srd1ViUVczaC9qcUhQU0RZ?=
 =?utf-8?B?dHpUNmVhUGJZbDdlUkE4U2J1MldEVjRZMzVHWDhwajROR01nczVUY3pVcG5K?=
 =?utf-8?B?bFVEdkx5NkRKRytBd3pkcHMrRUJiWFNNSXpkS3B2OWxJMWMzSnY2UWk3MGlu?=
 =?utf-8?B?WjU3aEl1VXRkcFQrcUd2M0dZZXpFU1AxSUk2MjVaNmYrMEVCQVhWTEt4WDg0?=
 =?utf-8?B?cElKSzVsQ0dsRVRCOHJCWThmdzhEb3hHSnQzL2tVYlhzZWVuRlNHVHZyZTh0?=
 =?utf-8?B?VDlSUmxMTDY2VU1Nd003L1RleS9STVMwSGFJVldtd0xseGNkTmF0MjNYdjdU?=
 =?utf-8?B?YUNKZDE2NG9kWHA1UnNibGRKOTExSURWS2IvbXJEMExuOUFNUlprMktWc1ZE?=
 =?utf-8?B?alE1OUlJeHpFR1MvWURVWmR4clY2M25aRmxiVEY3dExlc29SWldReTE4OTk5?=
 =?utf-8?B?dTZ2bWlHVXpZUFltczFnMG1MY1FPc2lxcGtZVDRiMjJ4M1l2RWhoK3F4dGpy?=
 =?utf-8?B?OWZzenBMNURaSkcvME9FNlp4R05ZREFBaGFwQU15ZDVNYXo5NWlqcTF0c1lz?=
 =?utf-8?Q?ExVvXylq3FWTdwUBdO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B66F4BC1C5497B4B9615CEF9A903DC20@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a75ab1e2-ead2-4160-fcd1-08de8ee64506
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 05:27:58.4464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jL9UQHJbMIoP7v0AY0HseO0ZmwccF5x0W0hycqwQN+yKhZT3unYRjal9w8D5zb23CIz7vYuqofNLRUSAzELDLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP195MB2790
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDIyOjA0ICswODAwLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToK
PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4KPiAKPiBDb252ZXJ0IHRoZSBib2Fy
ZCB0byB1c2UgRE1fUE1JQyBpbnN0ZWFkIG9mIHRoZSBsZWdhY3kgU1BMIEkyQy9QTUlDCj4gaGFu
ZGxpbmcuCj4gCj4gQ2hhbmdlcyBpbmNsdWRlOgo+IC0gRW5hYmxlIERNX1BNSUMsIERNX1BNSUNf
UENBOTQ1MCwgYW5kIFNQTF9ETV9QTUlDX1BDQTk0NTAgaW4gZGVmY29uZmlnLgo+IC0gRHJvcCBs
ZWdhY3kgU1BMIEkyQyBhbmQgUE1JQyBvcHRpb25zLgo+IC0gUmVtb3ZlIG1hbnVhbCBJMkMxIHBh
ZCBzZXR1cCBhbmQgbGVnYWN5IHBvd2VyX3BjYTk0NTBfaW5pdCgpIHVzYWdlLgo+IC0gVXNlIERN
LWJhc2VkIHBtaWNfZ2V0KCkgd2l0aCB0aGUgRFQgbm9kZSAicG1pY0AyNSIuCj4gLSBVcGRhdGUg
UE1JQyByZWdpc3RlciBwcm9ncmFtbWluZyB0byB1c2Ugc3RydWN0IHVkZXZpY2UgQVBJLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPgoKVGhhbmsgeW91LCBQ
ZW5nIQoKUmV2aWV3ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgpUZXN0ZWQt
Ynk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPgoKPiAtLS0KPiDCoC4uLi9hcm0vZHRz
L2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLXUtYm9vdC5kdHNpIHwgMjIgKysrKysrKysrKy0K
PiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9zcGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfCA0MyArKysrKysrLS0tLS0tLS0tLS0tLS0tCj4gwqBjb25maWdzL3Bo
eWNvcmUtaW14OG1wX2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDEwICsrLS0tCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyksIDM3IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14OG1wLXBoeWJvYXJk
LXBvbGx1eC1yZGstdS1ib290LmR0c2kgYi9hcmNoL2FybS9kdHMvaW14OG1wLXBoeWJvYXJkLQo+
IHBvbGx1eC1yZGstdS1ib290LmR0c2kKPiBpbmRleCA0ODA0YTIwNGU5Mi4uZTk0MDNkOWVhODIg
MTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRrLXUt
Ym9vdC5kdHNpCj4gKysrIGIvYXJjaC9hcm0vZHRzL2lteDhtcC1waHlib2FyZC1wb2xsdXgtcmRr
LXUtYm9vdC5kdHNpCj4gQEAgLTM0LDYgKzM0LDE4IEBACj4gwqAJfTsKPiDCoH07Cj4gwqAKPiAr
JnBpbmN0cmxfaTJjMSB7Cj4gKwlib290cGgtYWxsOwo+ICt9Owo+ICsKPiArJnBpbmN0cmxfcG1p
YyB7Cj4gKwlib290cGgtYWxsOwo+ICt9Owo+ICsKPiArJnsvc29jQDAvYnVzQDMwODAwMDAwL2ky
Y0AzMGEyMDAwMC9wbWljQDI1L3JlZ3VsYXRvcnN9IHsKPiArCWJvb3RwaC1hbGw7Cj4gK307Cj4g
Kwo+IMKgJnJlZ191c2RoYzJfdm1tYyB7Cj4gwqAJYm9vdHBoLXByZS1yYW07Cj4gwqB9Owo+IEBA
IC04MywxMSArOTUsMTEgQEAKPiDCoH07Cj4gwqAKPiDCoCZpMmMxIHsKPiAtCWJvb3RwaC1wcmUt
cmFtOwo+ICsJYm9vdHBoLWFsbDsKPiDCoH07Cj4gwqAKPiDCoCZwbWljIHsKPiAtCWJvb3RwaC1w
cmUtcmFtOwo+ICsJYm9vdHBoLWFsbDsKPiDCoH07Cj4gwqAKPiDCoCZ1c2JfZHdjM18wIHsKPiBA
QCAtOTYsNiArMTA4LDEyIEBACj4gwqAKPiDCoCZ1c2RoYzIgewo+IMKgCWJvb3RwaC1wcmUtcmFt
Owo+ICsJLyoKPiArCSAqIExETzUgb3V0cHV0IGRlcGVuZHMgb24gU0QyX1ZTRUwsIGJ1dCBubyB3
YXkgdG8gcmVhZCBiYWNrIFNEMl9WU0VMCj4gKwkgKiB3aGVuIHVzaW5nIFNESEMgY29udHJvbGxl
ciBWU0VMRUNUIHRvIGNvbnRyb2wgU0QyX1ZTRUwuIFNvIGRyb3AKPiArCSAqIHZxbW1jLXN1cHBs
eSB0byBhdm9pZCBmc2xfZXNkaGNfaW14IHJlYWQgYmFjayB3cm9uZyB2b2x0YWdlLgo+ICsJICov
Cj4gKwkvZGVsZXRlLXByb3BlcnR5LyB2cW1tYy1zdXBwbHk7Cj4gwqB9Owo+IMKgCj4gwqAmdXNk
aGMzIHsKPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jIGIv
Ym9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3NwbC5jCj4gaW5kZXggZmM3YWVmZDAwNzMuLmZj
NmY1MTA0OTI1IDEwMDY0NAo+IC0tLSBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9zcGwu
Ywo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9zcGwuYwo+IEBAIC0xMTcsNDUg
KzExNywzMiBAQCBvdXQ6Cj4gwqAJZGRyX2luaXQoJmRyYW1fdGltaW5nKTsKPiDCoH0KPiDCoAo+
IC0jZGVmaW5lIEkyQ19QQURfQ1RSTCAoUEFEX0NUTF9EU0U2IHwgUEFEX0NUTF9IWVMgfCBQQURf
Q1RMX1BVRSB8IFBBRF9DVExfUEUpCj4gLSNkZWZpbmUgUEMgTVVYX1BBRF9DVFJMKEkyQ19QQURf
Q1RSTCkKPiAtc3RydWN0IGkyY19wYWRzX2luZm8gaTJjX3BhZF9pbmZvMSA9IHsKPiAtCS5zY2wg
PSB7Cj4gLQkJLmkyY19tb2RlID0gTVg4TVBfUEFEX0kyQzFfU0NMX19JMkMxX1NDTCB8IFBDLAo+
IC0JCS5ncGlvX21vZGUgPSBNWDhNUF9QQURfSTJDMV9TQ0xfX0dQSU81X0lPMTQgfCBQQywKPiAt
CQkuZ3AgPSBJTVhfR1BJT19OUig1LCAxNCksCj4gLQl9LAo+IC0JLnNkYSA9IHsKPiAtCQkuaTJj
X21vZGUgPSBNWDhNUF9QQURfSTJDMV9TREFfX0kyQzFfU0RBIHwgUEMsCj4gLQkJLmdwaW9fbW9k
ZSA9IE1YOE1QX1BBRF9JMkMxX1NEQV9fR1BJTzVfSU8xNSB8IFBDLAo+IC0JCS5ncCA9IElNWF9H
UElPX05SKDUsIDE1KSwKPiAtCX0sCj4gLX07Cj4gLQo+IMKgaW50IHBvd2VyX2luaXRfYm9hcmQo
dm9pZCkKPiDCoHsKPiAtCXN0cnVjdCBwbWljICpwOwo+ICsJc3RydWN0IHVkZXZpY2UgKmRldjsK
PiDCoAlpbnQgcmV0Owo+IMKgCj4gLQlyZXQgPSBwb3dlcl9wY2E5NDUwX2luaXQoMCwgMHgyNSk7
Cj4gLQlpZiAocmV0KQo+IC0JCXByaW50ZigicG93ZXIgaW5pdCBmYWlsZWQiKTsKPiAtCXAgPSBw
bWljX2dldCgiUENBOTQ1MCIpOwo+IC0JcG1pY19wcm9iZShwKTsKPiArCXJldCA9IHBtaWNfZ2V0
KCJwbWljQDI1IiwgJmRldik7Cj4gKwlpZiAocmV0ID09IC1FTk9ERVYpIHsKPiArCQlwdXRzKCJO
byBwbWljQDI1XG4iKTsKPiArCQlyZXR1cm4gMDsKPiArCX0KPiArCWlmIChyZXQgPCAwKQo+ICsJ
CXJldHVybiByZXQ7Cj4gwqAKPiDCoAkvKiBCVUNLeE9VVF9EVlMwLzEgY29udHJvbCBCVUNLMTIz
IG91dHB1dCAqLwo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNLMTIzX0RWUywgMHgy
OSk7Cj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzEyM19EVlMsIDB4MjkpOwo+
IMKgCj4gwqAJLyogSW5jcmVhc2UgVkREX1NPQyBhbmQgVkREX0FSTSB0byBPRCB2b2x0YWdlIDAu
OTVWICovCj4gLQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxT1VUX0RWUzAsIDB4MUMp
Owo+IC0JcG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNLMk9VVF9EVlMwLCAweDFDKTsKPiAr
CXBtaWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9CVUNLMU9VVF9EVlMwLCAweDFDKTsKPiArCXBt
aWNfcmVnX3dyaXRlKGRldiwgUENBOTQ1MF9CVUNLMk9VVF9EVlMwLCAweDFDKTsKPiDCoAo+IMKg
CS8qIFNldCBCVUNLMSBEVlMxIHRvIHN1c3BlbmQgY29udHJvbGxlZCB0aHJvdWdoIFBNSUNfU1RC
WV9SRVEgKi8KPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMSwgMHgx
NCk7Cj4gLQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxQ1RSTCwgMHg1OSk7Cj4gKwlw
bWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzFPVVRfRFZTMSwgMHgxNCk7Cj4gKwlwbWlj
X3JlZ193cml0ZShkZXYsIFBDQTk0NTBfQlVDSzFDVFJMLCAweDU5KTsKPiDCoAo+IMKgCS8qIFNl
dCBXRE9HX0JfQ0ZHIHRvIGNvbGQgcmVzZXQgKi8KPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0
NTBfUkVTRVRfQ1RSTCwgMHhBMSk7Cj4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBDQTk0NTBfUkVT
RVRfQ1RSTCwgMHhBMSk7Cj4gwqAKPiDCoAlyZXR1cm4gMDsKPiDCoH0KPiBAQCAtMTkzLDggKzE4
MCw2IEBAIHZvaWQgYm9hcmRfaW5pdF9mKHVsb25nIGR1bW15KQo+IMKgCj4gwqAJZW5hYmxlX3R6
YzM4MCgpOwo+IMKgCj4gLQlzZXR1cF9pMmMoMCwgQ09ORklHX1NZU19JMkNfU1BFRUQsIDB4N2Ys
ICZpMmNfcGFkX2luZm8xKTsKPiAtCj4gwqAJcG93ZXJfaW5pdF9ib2FyZCgpOwo+IMKgCj4gwqAJ
LyogRERSIGluaXRpYWxpemF0aW9uICovCj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvcGh5Y29yZS1p
bXg4bXBfZGVmY29uZmlnIGIvY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcKPiBpbmRl
eCAyZmNmN2RiOWU1Yy4uNTFkOTczN2FmYjMgMTAwNjQ0Cj4gLS0tIGEvY29uZmlncy9waHljb3Jl
LWlteDhtcF9kZWZjb25maWcKPiArKysgYi9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZp
Zwo+IEBAIC0xMCw3ICsxMCw2IEBAIENPTkZJR19TRl9ERUZBVUxUX1NQRUVEPTgwMDAwMDAwCj4g
wqBDT05GSUdfRU5WX1NJWkU9MHgxMDAwMAo+IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHgzQzAwMDAK
PiDCoENPTkZJR19FTlZfU0VDVF9TSVpFPTB4MTAwMDAKPiAtQ09ORklHX1NZU19JMkNfTVhDX0ky
QzE9eQo+IMKgQ09ORklHX0RNX0dQSU89eQo+IMKgQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9
ImZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkayIKPiDCoENPTkZJR19JTVg4TV9P
UFRFRV9MT0FEX0FERFI9MHg3ZTAwMDAwMAo+IEBAIC0xMTMsOCArMTEyLDYgQEAgQ09ORklHX0ZB
U1RCT09UX01NQ19VU0VSX1NVUFBPUlQ9eQo+IMKgQ09ORklHX0ZBU1RCT09UX01NQ19VU0VSX05B
TUU9Im1tYzIiCj4gwqBDT05GSUdfTVhDX0dQSU89eQo+IMKgQ09ORklHX0RNX0kyQz15Cj4gLSMg
Q09ORklHX1NQTF9ETV9JMkMgaXMgbm90IHNldAo+IC1DT05GSUdfU1BMX1NZU19JMkNfTEVHQUNZ
PXkKPiDCoENPTkZJR19JMkNfRUVQUk9NPXkKPiDCoENPTkZJR19TWVNfSTJDX0VFUFJPTV9BRERS
PTB4NTEKPiDCoENPTkZJR19TVVBQT1JUX0VNTUNfQk9PVD15Cj4gQEAgLTE0NCwxNSArMTQxLDE2
IEBAIENPTkZJR19QSFlfSU1YOE1RX1VTQj15Cj4gwqBDT05GSUdfUElOQ1RSTD15Cj4gwqBDT05G
SUdfU1BMX1BJTkNUUkw9eQo+IMKgQ09ORklHX1BJTkNUUkxfSU1YOE09eQo+IC1DT05GSUdfU1BM
X1BPV0VSX0xFR0FDWT15Cj4gwqBDT05GSUdfUE9XRVJfRE9NQUlOPXkKPiDCoENPTkZJR19JTVg4
TV9QT1dFUl9ET01BSU49eQo+IMKgQ09ORklHX0lNWDhNUF9IU0lPTUlYX0JMS0NUUkw9eQo+IC1D
T05GSUdfUE9XRVJfUENBOTQ1MD15Cj4gK0NPTkZJR19ETV9QTUlDPXkKPiArQ09ORklHX0RNX1BN
SUNfUENBOTQ1MD15Cj4gK0NPTkZJR19TUExfRE1fUE1JQ19QQ0E5NDUwPXkKPiDCoENPTkZJR19E
TV9SRUdVTEFUT1I9eQo+ICtDT05GSUdfRE1fUkVHVUxBVE9SX1BDQTk0NTA9eQo+IMKgQ09ORklH
X0RNX1JFR1VMQVRPUl9GSVhFRD15Cj4gwqBDT05GSUdfRE1fUkVHVUxBVE9SX0dQSU89eQo+IC1D
T05GSUdfU1BMX1BPV0VSX0kyQz15Cj4gwqBDT05GSUdfRE1fUk5HPXkKPiDCoENPTkZJR19ETV9T
RVJJQUw9eQo+IMKgQ09ORklHX01YQ19VQVJUPXkK
