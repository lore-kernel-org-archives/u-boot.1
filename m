Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 170DED2C544
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 12:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAF788E78;
	Tue, 22 Oct 2024 14:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CYoRPSdT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2294A88E78; Tue, 22 Oct 2024 14:23:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE57D88D97
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 14:23:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlMOsmJ8xxgttM4eIocLOGTon4Iq6iL2urUI7F1fzdzI5f3Oc5kdb9JaST+JcT2XU5y+P7pdFMIWwTht8h40rWH9mvn7nrG/se0RZQxBL5no405krI9V+njYdHr/eK+feKZiH98hU9Qu6CXWAKbfp8V2DC7l6t0pU9m1xoPL0s3PXEulzKDNcWOIbXdyyLP520CSYJDyn2AWCkxdAM7A9UJVMdolY1Z8iJEF0R5Es4+XC3i8weAc+rtNrCKeJXefK8ByoPPU48HHauCAecOu3+mUEMoESGWngZV1FsT5SiJtbVlyAIUkouL6Dm02WFFhhxbJT6uezf9bVZhmA6boFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyM899+STZCQcQJeTJq9q+sEWEb/LvzFyczZZtNNFVc=;
 b=cIIKuSQdZGpv6dpK5ZdGPQGcfZbjIYlaRligtLWbx2XqJ7dX1yQAwrozaQSZk9bCnqgHp2MO13OL1oDOEb4yr4b0wA9fZDjfjT5MY24fiqrrC5TlcDXNxVxAqm5Vj+jJR/ID6iD2tiJ9IWdgcYsDkXFeR6ZNVrfnne1px+Dsf+HXr8KqUAkvmGWQZvONX7LGTnUHBBgfyIp1ovgSAFBxyJztc+gQXgycXC9WV3V5I0+eWB5uQXiTO52qAI+62xZ40qYg+BrEMH6j2NQxF4q+QQvoDAMTRI0QUndznQNfBMu+bk0GilnMKQA4R8S68AwmQa59Fxq6p1g1GVGqm1UmKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyM899+STZCQcQJeTJq9q+sEWEb/LvzFyczZZtNNFVc=;
 b=CYoRPSdTq8sVADBXypkGSTR+BrVPBm+/UzxUG3MRopHaSzQ6SBqm71JpXZMMCXC9Q0vsUltnnERBJC6az+5Emyal7PdLXo5GaldwQyaX7xUoYqP8acIt/edNe0+cdcmDKUCKT6zOiWpdL+6HxFb/zMKkybQpPOIK65CL/cFefrbou9K3k7n93tIDmGBaM6Hx1O8XRdxtkgoK4obnPP+3mCszMKTat/P0BvNJjfEkmRxn3RSYqMeUYXP83uagSEq8MOp22AjCRBtzGSMXxP3h538Naw231bGbUAWgWAQD6pufTIrUY5M/N2Hjkj4xzTbUF73R8xiTl0Wy09mOSv5Yxg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 12:23:21 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.8069.016; Tue, 22 Oct 2024
 12:23:21 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, =?utf-8?B?U3rFkWtlIEJlbmphbWlu?=
 <egyszeregy@freemail.hu>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>
Subject: RE: [PATCH] imx9: Improve boot device auto-selection
Thread-Topic: [PATCH] imx9: Improve boot device auto-selection
Thread-Index: AQHbHZdg9PRX9ypEMkGYCrSJBu+Zw7KFYtiggARUeICAABQ9gIAI4jmAgAAQ8sA=
Date: Tue, 22 Oct 2024 12:23:21 +0000
Message-ID: <DB9PR04MB8461C9D5EB7ADA89A2D335CE884C2@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20241013174120.1872-1-egyszeregy@freemail.hu>
 <PAXPR04MB845929FE951FCEC327F9F54788442@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5DBDDYr+9K8rq56L-=5EGWDNXY514rz5zoqPdXOQ2x=jw@mail.gmail.com>
 <93d2989d-7d55-40a3-a44b-ef64e1feb511@freemail.hu>
 <CAOMZO5Bvkqj6uYpSU=JsWd_t7yfvHAqhs9J08fGiEa1nfCX3Hw@mail.gmail.com>
In-Reply-To: <CAOMZO5Bvkqj6uYpSU=JsWd_t7yfvHAqhs9J08fGiEa1nfCX3Hw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|PA4PR04MB9367:EE_
x-ms-office365-filtering-correlation-id: 6deb1f0c-80e6-4e75-c516-08dcf2945165
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bUlGeUY4ZWxOUXdCOTJCWlQ4WjY4ZjI3VXc4QTF2TlNaemY5MU84dmh0NW81?=
 =?utf-8?B?dk5sVWpUNHI3c2gwQWsxRTVhVTVQWGd3UWpCVjFuUkQ4QkJxaWxtcCs0OE8r?=
 =?utf-8?B?OGpDV2pmZ1lxck85Ry92R1hOZkpsVTczY2xyN2NyMk9JemFENHFmNk44WGF6?=
 =?utf-8?B?anBsREs0WlRJbmNFaExGcjdFMytUb0kzMVEwL0JzLy9BWThLOVd3aUJ6bXU2?=
 =?utf-8?B?SlozcDlUSjc2WXlrWTBGdG5WVThBeGZ4aHdvOW5XeUlxVkx0K2hJVXloUi9s?=
 =?utf-8?B?cHJ0RmliNEdybWhLbDBLUjUvcUsxbmVEOEhpOWh3blJRQThoNUxQN2NWOU1h?=
 =?utf-8?B?Y0hhaVltWkpZUFBGcTdCRjNBVlYwNDBsTDhpNnVmUEptTXQwRnZGSDVRVUFI?=
 =?utf-8?B?UzhzMkNYRk81eFI5eHh4T3FHdkppQTFEckJDei9HTHpaVldRcHpqTHlnd3NC?=
 =?utf-8?B?MmVsM0hEb2ZRZVBZRDVoakZPL253c2dseWxvbTRLcTNsbDk0V1l0RnllTzhr?=
 =?utf-8?B?c1hTL0FEbXJiVHpQVkc1OTM5NXVEUGRFYVh4L1RYeVZ0b2xjbHd6SEF4d1Zy?=
 =?utf-8?B?d1VENzZIQXBoU3d6UXlpZVhveTNFVnV4SUtDTExRNCswNG9EUnVhdlZkVHAv?=
 =?utf-8?B?ckJaalJUYWtoWWlRMzVaQmVHUnBGTER4VzgwUFRzRS9hNG11UVlHR0hlTG4x?=
 =?utf-8?B?NW54aGlFY09OVmhFT3BIVkdtV0JmdEtNSFM0S0htM1ZZU2dmSFNERU5KMXd5?=
 =?utf-8?B?Szh0TzlEdmI0b2x0NWFad1RRbjA2aCtHQTUwQjVXM2ZBUkJzYk9oYmNGWVpo?=
 =?utf-8?B?aEJ5ZFZ1VzBaMHlNb3dSblFWYi9URHRSQUVsdjIrUGk3aGNGekxYNnNDQzNV?=
 =?utf-8?B?YmN5b0tkSi9lSEtpQXl2M29xMGhCTSt3bEZIWVFGMCtiM3pRblFWazhYdERW?=
 =?utf-8?B?dGtnT1FoRU0xWmRNbkV0blZEcnpCS0lQYkxiQ3V2YW1kdTlESDR2VVUvWEdM?=
 =?utf-8?B?eUlCR0xDbE90U0lRM2NWUjNWQXhCWGIzUnkvSXZSTkh4MWZUd0NHZzFOVjJi?=
 =?utf-8?B?Tjd4TVlBMFdtU0tkMXlaT01KaytONnQ5Tnhhc1VFVEd3UG1MZGQ5TzVRVXFZ?=
 =?utf-8?B?QythbCtzcU9vWGl1Z2g0YVMrN2svUnhLc2xMZUhTaVJqNXdaSXg1ZTJFK2hv?=
 =?utf-8?B?Yy9QazY4dEcvNEFVcWhlM3hHYlE4K1NLWEpIVGxGWFpadTBPREhxMzcvOHM3?=
 =?utf-8?B?d1lrQWx5ZUZZMS80OW9yRHVCZ0lxbmY0ZTFkaW5ER0pTNUtMUUNWWU9rNzRQ?=
 =?utf-8?B?Y0FmT0lSR2h5M3NVcFFFaHF5QmZYVHgrTzlWTlRrb0k2enlrZTQ3emZTRWt3?=
 =?utf-8?B?L1R6SXhqbTJsVmtDTTd5bFc5TVJVSTVPU1NHLzNKZ2pUZEdVTmdaa3p1VGQw?=
 =?utf-8?B?dmY2TURKVzh6cmo3MEhDTW5BL1BVU01oVjRxMDEraU8xQWgxVU1kYk1qQ3Rn?=
 =?utf-8?B?MFRDS2xKTVFNYkI0R3RnZTJRMm9oMTg4WEtMZndveTdRYnNGeEh3R3BlL2FO?=
 =?utf-8?B?Ni9oT1d6VWM4RFpna3dOSWQzSnk3Qkg0cVc0dG8wV2hBcW0vb2xUM1ltUGp5?=
 =?utf-8?B?cUgrYkdCNVdXZVRGUWYwU2VwSmhTTTJtaEVuMTgrb0pVTERLNTlNcE80V3J0?=
 =?utf-8?B?Sm03QWhYUGIvemtaejNjMkFBVVN6SjY5eHNjTnRWRnNmNkdoTkptVzliMjJu?=
 =?utf-8?B?cVI0YW1zVGlCZHJKYjByRXVOOEFPcW1kTEZrRHFlUVczTTFBV0U5VVlhb1Yx?=
 =?utf-8?Q?fvPsrCH5w9fKZbkDBSmd7yXea0ANnLKYhVzWY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTNIRjg4VU12cVhiWTc2Z3UvQzNXbG9IYWlTRnlIYnljRWoxbjJYMFhST0tC?=
 =?utf-8?B?VXNUTXp6Wm9pSnJMcEM1Mk16K2loM2JZV253ZnBqUGVReUN6dDFPNjR2T2Fo?=
 =?utf-8?B?bFdFUmRCdk9abi8vN1JMSVN0akU2OGU5THFWTzY5QzZhTDVBWjFFOVRRMk9B?=
 =?utf-8?B?cExPRVZBODdpR1FQZXdZbTh5c05iNVRReUF2NnBUNDFLYU9ocG1TaTlYUzJC?=
 =?utf-8?B?VHJNUnJQNXZnM3pHaEdqaWZQVzREeFk2cGdVS0EyUllRZGxLcTlTSTRIYkxY?=
 =?utf-8?B?Qnp1WFF2Y0t6L3VLTlQ0TTFmdkw3d1pBZ0hGTE93ZS9mR0lDb2tMMXY3NVlT?=
 =?utf-8?B?TjdJNDNpOUJTamE1dGxCRFI3OUxBWjhKd1lKNGtyRHJiRVNVTzAwQ1VERU9z?=
 =?utf-8?B?aDJ3YnlYeXN3Q1RpaHVDQlZOSmo5cHRTNThLNFgram45NEp6MzdoMndoVXBs?=
 =?utf-8?B?aXNSeHliWHFrOUFRbWJQTDM5TEg5OFlJMENsOGtiaFNUTGZpekxvZWRGQ0Fo?=
 =?utf-8?B?eFhrR3pCU0dWQ0ZoWjJGb2Y0Q0IraXRZdE42MExQQ3RkditMRDF3cHg0RExv?=
 =?utf-8?B?cm9JOFBGSUUvN1VjeDVvV0Q3Zys3elVoMmlvNVdEUTdHMEdZaXhFNFF4L1cv?=
 =?utf-8?B?OWFYVGhpVlJ0QU9pMmhxMEpmbVplak54elNQRW9JSUJTdk9mM29UT1o4OUxR?=
 =?utf-8?B?ZnkvcUtoMC9VSGZZSjFzS003NklPdXFGQjIwbit5OU5zaDA1aGJDY1o0b3I0?=
 =?utf-8?B?YmV3TkphSG90U0JYcUFrdGZsNURNSDBmZnVhZXZIb3g1Tlh2WTl4VzgvL1Nz?=
 =?utf-8?B?L2FValBWczMyNm5ER3hQR2xxSkZEK01QZEhKWTFmb0ZQc0xMV3JKd09ET2VB?=
 =?utf-8?B?RGd2bzk4L3NKK2w2Qm95dzhRWDNlaDNwcndNWTJjaEh2dGR0SXM1a3FlWkdO?=
 =?utf-8?B?d0ZaRlE3WDBzR1QwZDlPMlNxdDlma2t1WG5LTUJVMHpmNm5zLzBhQ3JIRkFk?=
 =?utf-8?B?TCs2a1ZiNzZJcWwyOSs1V2pDSmh5UGd5ZWw2QngvN2tUOTN5OUJmb2lsZ1pq?=
 =?utf-8?B?Rzg5MzU5Ymo1MWsrWjFOMHJXVDJxOHFScVF0NlJzbHVnRHEranZyRHp5VDVo?=
 =?utf-8?B?djVBZVBrTHIvV1NsMVQ5cWhTM2ZvWmRlVkJtWG0wajZGTTl2WnZMd0dOeCtx?=
 =?utf-8?B?MXlIQW1Ra3dUdFJlM3orSzdJMFNWSHlPL1U3dFBNY3dITVZ1OVhkRDdZKzBO?=
 =?utf-8?B?YzdkK0o0NWx4ckFPc2VZWlM3dml6SCt5QzN6MEVQQmcyZVBrUU9McTErMVRD?=
 =?utf-8?B?cGVEU05WNWZudkNEbk9GZmdjamFoVzBpRFZmTDdrRHFhaXB0RGEvR1lxVmJS?=
 =?utf-8?B?RlhoM2QyVi9YNkVWczZIZFB3dWJQcWlyZmhUT1FieldpdmRIWWpHcm1kWVNQ?=
 =?utf-8?B?UGhWVmtTMDZHdzR2elpKd0E2MEd4K0FwQVlkajZjMjVONXYzUzJVTlIvOSt4?=
 =?utf-8?B?VVRCNXJuWFpoQk9SRnlnUTAwdElDdU9rTGZNTHJJNnBpK001ZExjZm8yYzdS?=
 =?utf-8?B?Y2lEV3ZGZHFZZ3FHS1I0Q3JhUEJkQWd2c3dXTW9Xa2l0TUIyV3hnSGI4MUtj?=
 =?utf-8?B?Q1RxTXNiN2RQWGpJVDFjUjVncFRSZmFxWThaaFV0Ryt3UjV0V3VqS0U4dkgw?=
 =?utf-8?B?KzR0a28veE9saFp3ODk0T1FIcnlIR21JdGlUcDRuenprR09leWljYzVXemFv?=
 =?utf-8?B?U1dLTjMxT0U2N0dPQTNQRXVjRno3S2tEbHVmaGZYdENsaDF1SklyUC9lQUw4?=
 =?utf-8?B?NlZwR1B5cmJnSFI3V2FqVXJqNENBaWxvUXhrSmIvUFJyT3QzeittVkszUjkr?=
 =?utf-8?B?V1FzdGlXSWhlUURBK2x5eCtyZTV1NW0zM3Rrd3oyVTUvcnA5TnFERWRvY0ls?=
 =?utf-8?B?YTRYTVZIclJQUlRTNER4OW9OdkxzTmJ0Y3J1WVliaytaN1I1SktPL090ZDNy?=
 =?utf-8?B?MWNVWlkyTGZIZElwRU5mT1c2U0ErZnVtZlFJWUJxQ1NxYm1Fb01JRG1sK1pn?=
 =?utf-8?B?UnpKQ2dNY1ZYMEZFQVFXdm8vMm82S3cvL0tyMCtRZFdObytUZStlNWVpNHhq?=
 =?utf-8?Q?QYxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb1f0c-80e6-4e75-c516-08dcf2945165
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 12:23:21.4428 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ytt30PQ4oRX+EJpXwClFPYj6Oymh7h+xxW+53p6Aau1NEQNUP7sL8Qe1315YlgxLpmq+eNGZo+eo+spy8kJvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbXg5OiBJbXByb3ZlIGJvb3QgZGV2aWNlIGF1dG8tc2Vs
ZWN0aW9uDQo+IA0KPiBPbiBXZWQsIE9jdCAxNiwgMjAyNCBhdCA0OjQy4oCvUE0gU3rFkWtlIEJl
bmphbWluDQo+IDxlZ3lzemVyZWd5QGZyZWVtYWlsLmh1PiB3cm90ZToNCj4gDQo+ID4gWW91IGNh
biB1c2Ugb25seSBvbmUgb2YgY29uZmlnIGZyb20gQ09ORklHX0VOVl9JU19JTl9NTUM9eSBhbmQN
Cj4gPiBDT05GSUdfRU5WX0lTX05PV0hFUkU9eSBpbiBVLWJvb3QgY29uZmlnIGluIHNhbWUgdGlt
ZS4NCj4gDQo+IGlteDkzXzExeDExX2V2a19kZWZjb25maWcgc2VsZWN0cyBib3RoIENPTkZJR19F
TlZfSVNfSU5fTU1DPXkNCj4gYW5kIENPTkZJR19FTlZfSVNfTk9XSEVSRT15Lg0KPiANCj4gPiBJ
ZiB5b3UgbGlrZSB0byB1c2UgQ09ORklHX0VOVl9JU19OT1dIRVJFPXksIHRoZXNlIGNvZGVzIGlu
IHRoZQ0KPiBwYXRjaGVkDQo+ID4gc291cmNlIGZpbGVzIHdpbGwgYmUgbm90IHBhcnQgb2YgdGhl
IGJ1aWxkLCBhbmQgdGhlIGF1dG9kZXRlY3Rpb24gb2YNCj4gPiB0aGUgYm9vdCBtb2RlIHdpbGwg
bmV2ZXIgd29yay4gQXQgdGhlIG1vbWVudCBpdCB3b3JrcyBvbmx5IGlmIHlvdQ0KPiB1c2UNCj4g
PiBDT05GSUdfRU5WX0lTX0lOX01NQz15IGluIFUtYm9vdCBjb25maWcgYnV0IGl0IHNob3VsZCB3
b3JrIGFsc28NCj4gaW4NCj4gPiBjYXNlIG9mIHVzZSBDT05GSUdfRU5WX0lTX05PV0hFUkU9eSBv
cHRpb24gYWxzby4NCj4gDQo+IEJ1dCBsaWtlIEkgc2FpZCBpbXg5M18xMXgxMV9ldmtfZGVmY29u
ZmlnIHNlbGVjdHMgYm90aA0KPiBDT05GSUdfRU5WX0lTX0lOX01NQz15IGFuZCBDT05GSUdfRU5W
X0lTX05PV0hFUkU9eS4NCj4gDQo+IEkgYW0gc3RpbGwgY29uZnVzZWQgYnkgeW91ciBwYXRjaC4N
Cj4gDQo+IEkgd291bGQgbGlrZSB0byBnZXQgYSBmZWVkYmFjayBmcm9tIFBlbmcgRmFuLg0KDQpJ
biBVVVUgYm9vdCBtb2RlLCB3ZSB1c2UgdGhlIGVudiBpbnNpZGUgVS1Cb290IHByb3Blciwgc28N
Cml0IGlzIE5PV0hFUkUuDQoNCkluIHRoaXMgcGF0Y2gsIEkgdGhpbmsgdXNlIGNoYW5naW5nIHRv
IG1tYyBmb3IgTk9XSEVSRQ0KbWF5IGJyZWFrIHRoZSBydWxlLg0KDQpUaGFua3MsDQpQZW5nLg0K
