Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16D3C83038
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 13:07:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A593282B18;
	Tue,  1 Jul 2025 15:07:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pKiSAV1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5DA482F6A; Tue,  1 Jul 2025 15:07:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E927482A76
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 15:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q33hJLBLuYsfrpgOlcmr6vgs7ABCiejhsiiKRUjLL3insR56wz/1BqRxZeh9dLhX50A5Imjf7qHtpAyH4dHIVgywBTd8dvt5btSljKkrXtB7O7BaTMkLBG7XOzHauJvvnA8jWI+1GGJxQ0xSh9tES1Lr+Am/fikl+K+bgOI2J5Xg91+XPoYp4LW30mcY2g5Oe+glV2eGehesSsq94eZv1rrxNjhoKfULk3hTvGP9Tj35MQouZoPANzgCifTCx451V0+nPqqtbHTGMkYNKv1O+Es84+PyUq+1Ime8D1uk8Gzj+I+CABQeWG2ssch1L/YVFvlUhg6479b6t+ktSHhXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MmF+v83JFO5q5JU4P+qp0fIHGi3TM1qN75Lw4OZUjQ=;
 b=ykGG0xYPfgrSl5p3EKhKDV4XHhehWRjUQgKAUjr5kV8hraD6xM7Yt29v/x+RV5BnXKp9LkEasBw7viQ7JphZVa/l5LMzjOZMHzbgyINf1/VOfp21195RVNerb5QMSPy5Nfks5U7BeHl4KKK3NKLfD4ZCB5LAUVXUOnyyWTuUGF7qIuCqJYfpafeH8rX6RlsE2ciaCusRmsbJy+dpFTVT3/4+yWlBvUL8f+rQH8cfH9Tm0no8Ay+bh4sZnKTOjiAowKqN/yWWw+zpQ+VzuCllVta1SdsVjk4NJUk1ziUBXT0b+lvcsmUndYX7JFO8x0ExyN/SUIc30SpRqm8DpIofbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MmF+v83JFO5q5JU4P+qp0fIHGi3TM1qN75Lw4OZUjQ=;
 b=pKiSAV1qyi1fL1ZLC8UjGVe/UEWzUUXPGhya9sa05l62xQpmggmRBmkJucGrgJ0isYG3yeWH440z77JbbKu8y0DuQwlvFFTHe6cNf1nAsOuifcxb9IN3QT2eM3zh0SeF2hVlWACioHSM6U2D/JkLPNX0pmgR1iY27ohVC8zrgeshRLdWNa92zRFOVg3ILkEZsZswDKJh/X1XlHy7qIwMIhqQ9+UVlC4YXtQi79X6cY36MzXCnDuQLe24NujTvZTh5X4P7MhBtnjVYTPPJlTWaZ8cdCJLlfhsXpa+t4RLG0kgcaniMjH83Xt/VKT4wOjPKSAyNsJmKC6J9nXcJb4MTw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6995.eurprd04.prod.outlook.com (2603:10a6:208:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 13:07:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.8880.026; Tue, 1 Jul 2025
 13:07:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>, u-boot
 <u-boot@lists.denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Fabio
 Estevam <festevam@gmail.com>
Subject: =?utf-8?B?5Zue5aSNOiBpbXg5NSBTRFAgc3VwcG9ydD8=?=
Thread-Topic: imx95 SDP support?
Thread-Index: AQHb6hwPSltqRiEQ1EiZiGF4RaO9ErQdPXwA
Date: Tue, 1 Jul 2025 13:07:29 +0000
Message-ID: <PAXPR04MB9644C2E63CE6649A1818ED82E241A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
In-Reply-To: <CAJ+vNU0p4BZX-853gmcgEMzXn+es5SV5aTUcU-kzTjPZLFtLOQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|AM0PR04MB6995:EE_
x-ms-office365-filtering-correlation-id: 2298dd5e-db07-4148-207d-08ddb8a03ba9
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?YTFDOTNDdHhkTHZ4ZFRuaFJuMEc1L3VPSFVKNHFxSlZRcnZ0NUhjWUpQclVY?=
 =?utf-8?B?cFV5V0lpZUQ2cXVZRzZ5QzV6RUo3V2Q2MkVpT3ZxY0RaV0Z3Tms4NHJFQ2pz?=
 =?utf-8?B?VzVGSGVhajc1WXRubFZBcUNFVnlZNCtMS2RBMUFUZ1F2SXo0ekxCb2JsM0xy?=
 =?utf-8?B?Vnd5OWJtRnZpbDFQcUhubmExOEJhWXpQK0dhaDlHUWN5b3AySDRmVTBoOFhL?=
 =?utf-8?B?ZVI0cG5oUWV1NnM5Z3ByR0VNeXdxSlVyVllFVkhWWThRZGpza3dTYzVTckd6?=
 =?utf-8?B?YzE2cmlnZEpDZ0p1dDJHK0pWV2RmM0h6NTJDbEpoTlVMYmNDT2FIRDBJQ0Jj?=
 =?utf-8?B?RHFQeXRtUEJyVUtWZmJoT2tmYWJlVmxrWUtDb21yV0hwV1JPbENBS1RpWmc1?=
 =?utf-8?B?R1VZdWRJcG9aNm0zL0NRak9qVmdpbHg5ZEQ2MEtpM2dsZm9GV0JZNVZCNVYw?=
 =?utf-8?B?dkRGVitLVUtqS0t4cVZwNnNocm5CbCtWSmptOHZKSmk3cjllSzk1eW1VbEt2?=
 =?utf-8?B?YnFUUExjZlFza0NNQ2VvK0J3dXlBNFl6UFdJNFpZd1lhNWRyclQrNThmeDBX?=
 =?utf-8?B?a2Y0TGlKL0wxRzRqWG8yS0puL0xaUTV3enJqZkhmYW9LMDB2L1ExbGJLT2lv?=
 =?utf-8?B?NUxRZTlrTDJqR2JkWkRlSUhyTG1odVh0TWttQnVIRlkxUWhmcWR5ZjQ0QXZJ?=
 =?utf-8?B?REdoSkRWcVdZOEhuM2pJdUxWaVlPYVpTdXIzUlFmekVOd0ZnNTYzZ0tPRjhY?=
 =?utf-8?B?MUNkeUNlVnZhN3FWT251cDR0VzBjdzdWWWN3aGJYWm0wa0dodlE0TWpZdkd6?=
 =?utf-8?B?QlRkK1VNR0E4Rm56eVBrSC9aMGs5dkZuVWJMNzd0dmk4Rld1eU9sNmNrUURH?=
 =?utf-8?B?NFFob05UcFBpK3F3d01LUzF6S1ZydmJkRDkzWm56NkhWUkFGTzlNbjV1cFQ2?=
 =?utf-8?B?eVBaVC9ENnJpOSt6NFlEYXhwL1JvY3Q5Ukt2UVp1UXNrQlhnY08rb0swQ09x?=
 =?utf-8?B?UUpaQytpNnNSaXEyWWcwY211eFJCcnloYTlVT3hkNTJvbFBTZmt6SnVjVHFm?=
 =?utf-8?B?YTNBWGRyaUh3aVNnZ1BzQlRDM2l2WnB6Z0prcVQ0RDlmSGtxaThXWlVMcTZY?=
 =?utf-8?B?UmdncUkrL1RZTWZtS2U5UlhKNVBTVVVROHpEblNCWkZJVFNpdUEwZ0VBUndj?=
 =?utf-8?B?a0tDTnR3WDdmSUw3RjZIMUhBNTI1dTVDY1ZzMitOWHA3aEtodG83aGdCK3FY?=
 =?utf-8?B?b2VZY0grZzhJb1VoVFc4a1RCUFlKWGErZVdtZ2o5L3BvTnBzalNLV3FvN29D?=
 =?utf-8?B?dGZWWkRvMExSTWp1T3RHdUdoVmdwem54cTMrcDNjQ1VsbHlTVTBDM0FBNXBL?=
 =?utf-8?B?UG5QdjhwRHVGR1pNUElVUkQrNHhWQmRlRGFIRE8vL0hCRXpCSlV6R1hmUVJq?=
 =?utf-8?B?TjVvMlRBS1BsQTdDWGJVTi9maWJNS0gxM1JRcGZqSFFqZjZ6Y0lQcStjNzBy?=
 =?utf-8?B?L1NiZ2FDdUcvS3E4TXRjaXcwZ3dsd2VUNVNDTkQ3Tm9Qd2pFMTRHSTlzaWhi?=
 =?utf-8?B?emxZbHBQM3h1QVR2UTFhSFpuM2xtQ21rR1RlQTRhMU4wVTVrMnJWZVNDc3ht?=
 =?utf-8?B?U1J4Z2hCRzRCTm1QU1NZY3haeFZ4UWp5UnUxOWFTV2tsRllCQndrVkFmT2pu?=
 =?utf-8?B?MWI2RTFzSElCazNneXNLYlU2VzNsOWxwd1RhaGFVekdueXRnREtNR2VyNEp4?=
 =?utf-8?B?eGVFSVB2WS9PSWNhdXdaanBjMWdrLzdZRXAxaEdDSy9TeGVnU2lXSG9WT3hL?=
 =?utf-8?B?R3dYbXVleUluKzBlUTFoMGFRUzNRdnBUVDZxYkNTWXRLTjdzVHBVNE5WT0Nt?=
 =?utf-8?B?RHhQUkpLRlJHTU05RFNiSGNEL1AzSys3OVJ4NzAzYjYwRXlWN1crVUdFWC9X?=
 =?utf-8?B?ZXhjcmFoTHNaWVc0QmJ4R0FtSE5lbjhQSWNBRHJsbXd5SnhGTm9NWVNJRlRj?=
 =?utf-8?Q?Mw5rErr4KbtvAhN7sDmUrxffUL1ogY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eE85dUJjZklrMGxEVXZ6a0c3QjlDRFJUVTZnSTJzTWRRcUs2ekRWb1RaWEZN?=
 =?utf-8?B?Wmt6MjJNOW5yeFFIQkIzUEQwM2pPTWlSRVZwWjVzVURFNnFQZ1pNRitNdlA0?=
 =?utf-8?B?QWY2WmdsTnZjdzZWdGZUQjc4RUlLeDhwbys5RXFIWHJTODdFL1FhTnBuNmZN?=
 =?utf-8?B?Sld1bFExdHdPNlY0dTdZWUltd2E0S2g2eFNheUltTFZQdXhPalBoeFFBQS95?=
 =?utf-8?B?Z2NJczlTbkZLcE54OUFqQS84ZHpFMVRwNmtrRzRsbWh6UHVFZHFJamxtTFZF?=
 =?utf-8?B?QzJQTlFaMUNOcWQ0QzJGZTN3enNpa2kycVNsTWtVT2hvRTBQT2l1QU9wcEJn?=
 =?utf-8?B?U2pFNjdSUFppOHNzVTVIdWFsZGxMSXNjb1hUSVdsN3dkUFJBQjFxUnhvek00?=
 =?utf-8?B?b1N2VlBsa29LaTlCb3hKcmRRYUlRZHpYSkI2ZEJUamtOaVV2bmxBaEY0S2FX?=
 =?utf-8?B?aFpwVWkxWnRCK2lkMGhaRzJjY3BMTkhqSW90OXc0RmxPRFlJU1c4Uk5ZekNk?=
 =?utf-8?B?dWtQRHVObUpRSllZdEVPTFVPQ244Q2E4QVV2UCtZS3lUS09mUG5qYmFwY3Bm?=
 =?utf-8?B?YUYzeEZIMWpqRHNZdXhmR2QvNktKMU1ySkhzb21ONFJ4a3FMZkFwSVZ3QTY2?=
 =?utf-8?B?bHJCdlRhVEFmc3hKNW1UMU96U3gzbTdHb0R6aXUxc0lqeEdMaCt3cWsrdVlr?=
 =?utf-8?B?ditST2FQTDZuOFRMY0Y1NXBuQWJUc3FPMCs1K20zQmtBL01tUU1NV3NOMWM4?=
 =?utf-8?B?NS9ld3hEaHQ3UTBXZjVIdFlNa2xOS2NkTkVUVitBYjZjanRCWkp1bXk3MWI4?=
 =?utf-8?B?UmlyMFRuNmpRblVYNFpjdXBYVkZQeUZLekkzT2xvWUpjckN4TkVmMlE5WnZM?=
 =?utf-8?B?emRuZnh3a3RYZjhsa3BNcHVUNXo5ZUcxaHUwSTh2VjJHeFYrK2pEelp5MTcv?=
 =?utf-8?B?OHpPamlSdkZhQitDTk5mNEdnVWdvcmtJMk1MOFRuRWpCcmRVYlVtWTd6Q2lN?=
 =?utf-8?B?RGlqNlFJTFBEc25hb2cxUlhRb2ZFMnJRRytzczF0azVaT1U0b3FGTzNuZnRH?=
 =?utf-8?B?M2VzWjZ3c0FwSVEyakw1VFBCYjJhd29sYm1KTXp4Z3RNM0ExNU4wYlRnMzll?=
 =?utf-8?B?VWwwNnhYVENPOTZIanU0azJHY3kxUFAwbGRmVHBPd0IyMUEwMDJ4aGlEVTdT?=
 =?utf-8?B?UHhRWVpGbzcrSnBxSEc1aTdiNzdiazVVa05nbGR1RjA2dXF5WG4zMFJJOU1Q?=
 =?utf-8?B?WjRrK2JwYjgyME9YU0h4RGFVTVpVTXVmRWJmM1JLZmNhdlpHRjVEdExRK2ww?=
 =?utf-8?B?K3V1b2FzY1JlOUpZWmpxMDJ6SmhERXpySnRHaXk2SHRabzNjS00wM0o4V0Zh?=
 =?utf-8?B?YkZEWjVWbXdwSHAvZUVERjNmR3VLK3h5U0dGSXo4M1RZdzZ1SE5BRHg2UHMv?=
 =?utf-8?B?Zm5OVlNVTzAzZE11SzZRbGpmenUzWVRBNmRQTjNVbDRQUHA2MkF2WWxPY2lB?=
 =?utf-8?B?YUxTZ09pSzhPbXRrUEJYMTlxWmhJZVJxUkVibkR5aWhmNjNXdWlLK0svUFhB?=
 =?utf-8?B?dWVmZ2tudmtrN2FGQmFseUpIOFBJeUZBaW9DQ3lGK1JRRmhxbHdsMVN4YSt4?=
 =?utf-8?B?bG8xRTdVdngzSjQyMW9zOU9RZlJYRnZJNGVFNmdtanhyc2ExK1plNUt1WmJl?=
 =?utf-8?B?eE1jaUFZRmgvTXJDVjRnbFZYZTB3S082blpUTGdGbnNnZDNyakRWaWhTbHlK?=
 =?utf-8?B?R29QZjR1b1FrRGFHc0wxNmFHdUgvelZkNkRvbjhzenlWSElYcW91Z0thS1Bx?=
 =?utf-8?B?aUtuUjhCMHEzQWYyeGdhM294OW9DOFpxenhlSStrUXJvYTZ2WURsbWg1MGI5?=
 =?utf-8?B?OTJDQnNrdmJqVXRTOUlIdmx0Y2tIQVR1aXdBK1YyRWdIa1UzTEdWdmpsNkpP?=
 =?utf-8?B?L3dxLzRUaXNicExZNW9sQXcyaXVtV3VlUFNDMnFNMXY0M1ZPVXZrMk44bU5G?=
 =?utf-8?B?Rmo0c3RrMVFIQ2kvLzlWbE1FcHRwUjBiNmp3ak5JWGZxVUdHZGRib0hpeUVI?=
 =?utf-8?B?NytwUDRBNXVnT041Z0ZMOVNpYmtzZ2pUU0pxOWljbjVuajk1NlZYcTBWWVp6?=
 =?utf-8?Q?XcCZgnQaioo8SQC7XbujQzNgq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2298dd5e-db07-4148-207d-08ddb8a03ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2025 13:07:29.1323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xtJ06j7KDvG7FGgie6GHOYkRCr0t3bphFnjnJcIvCQGdEWDqW6AvnW1Hm2gU+JKtU25pK2tU/TrByvjdwmWOuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6995
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

SGkgVGltLA0KDQppLk1YOTUgbmVlZHMgdG8gZW5hYmxlIFVTQiBnYWRnZXQgaW4gU1BMIHRvIGxv
YWQgdGhlIFUtQm9vdCBwcm9wZXIuIEl0IGNhbm5vdCB1c2UgYm9vdCBST00gQVBJLg0KDQpCZXN0
IFJlZ2FyZHMsDQpBbGljZSBHdW8NCg0KPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7
tuS6ujogVGltIEhhcnZleSA8dGhhcnZleUBnYXRld29ya3MuY29tPg0KPiDlj5HpgIHml7bpl7Q6
IDIwMjXlubQ35pyIMeaXpSA4OjA3DQo+IOaUtuS7tuS6ujogdS1ib290IDx1LWJvb3RAbGlzdHMu
ZGVueC5kZT47IEFsaWNlIEd1byAoT1NTKQ0KPiA8YWxpY2UuZ3VvQG9zcy5ueHAuY29tPjsgRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiDkuLvpopg6IGlteDk1IFNEUCBzdXBw
b3J0Pw0KPiANCj4gSGkgQWxpY2UsDQo+IA0KPiBJJ20gd29uZGVyaW5nIGlmIHlvdSBoYXZlIGFu
eSBub3RlcyByZWdhcmRpbmcgVS1Cb290IFNQTCBTRFAgc3VwcG9ydCBmb3IgdGhlDQo+IGlteDk1
Pw0KPiANCj4gVGhlIFNQTCBib290cyBvdmVyIFNEUCBqdXN0IGZpbmUgYnV0IEknbSBpbnRlcmVz
dGVkIGluIGdldHRpbmcgdG8gdGhlIG5leHQgc3RlcA0KPiB3aGVyZSB0aGUgU1BMIHByb3ZpZGVz
IFNEUCBzdXBwb3J0IHRvIGxvYWQgVS1Cb290IHByb3BwZXIuDQo+IEknbSBub3QgY2xlYXIgaWYg
dGhlIGlteDk1IHVzZXMgYSBzaW1pbGFyIGJvb3Ryb20gdG8gYXMgdGhlIGlteDggYW5kDQo+IGlt
eDkzIG9yIGlmIHRoaXMgaXMgZG9uZSBvdmVyIHNjbWkuDQo+IA0KPiBCZXN0IFJlZ2FyZHMsDQo+
IA0KPiBUaW0NCg==
