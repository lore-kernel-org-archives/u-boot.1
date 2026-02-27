Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0173FD9E26
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 00:11:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019CE83D1A;
	Fri, 27 Feb 2026 01:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="WPCruU4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E60983E61; Fri, 27 Feb 2026 01:11:42 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59A0883BB1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 01:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpyGVVWGRe/yd8f+qEluWhtEvMNIpAXRQu4ycRQYCM36kDgF1KMMhyFfjYU1cp1E2ndT6mdBwtC/Uyt2qRWI1CdH832PLUj2YVwsIWtbQ4fB8B7LGUaUzIVWuqaR60zICkb+Bb5USzL+kOYHuSI7TntHx3WB/5iLTnyOkGSvc11wly45K5Hy6Elql4ADNiE6KvD42Qenx6JQnCLahNm1uzLd/hCIH8jhTG26Sjl7kS5tnb3AMUa1+lcgqXjCs6Ku1IOUWVYdwK6p2bEmbxpKuv99CpP/Eu0M2MMnw9zLZmIorIw2uq/ilP0M/yJwjckeF8FVF5MXUOQ6X6xyLQJVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzqhLKgmGEndp7v4NOoNb5AFuqV526tiJsFLaWLtDlo=;
 b=K7FXBlWbyw7kyV+6hjRvUk2jx3tCQr454hylLB3lyvoKTKWec08rsAC8x9u9hVbYIAp2fnY3oaONtED7UxnsddofQ8KkMejYZ8b4353pZvGbFPQgTloYvmxlALVZuxklF3s3ydnwCUekJnC9g699MaJtFE9FRcdTR0G7Z5wmdPilM3YxDB8gQQayU5+0tTXEVLjhQqc2GdM1GVVN7THbMozTQVIsr14CQzuIWZvYoRx88W8M7xcBPF6ppGcVqWBtUZiAoijGtkGPPXvmAxSQ0FPoDT1gbL15HWvVa4T9rxULequJIUqUhvEr8uGIFrzTBJQi1L+augqHF2QB7MRySA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzqhLKgmGEndp7v4NOoNb5AFuqV526tiJsFLaWLtDlo=;
 b=WPCruU4ywteJWRr2J1XaEKtTEcw8Ipz3YDbkB1mNa6X6XXOKDk8kXacQTvjBU8RcR5TojJvpNokGzDv6I39BuNhYVK3pWFRL2rBMUTQFAG0Xa3qKGez0crDHRCh5cLyYJboUMW3XM/DorGoK9L9PA46z24965yNP3BCemrIn/n7jJHfuWTiyB4fFR7btGoiag0FUgDB2xm4ql3NABwLCrWP0AAzj/zX4Y2f3Ga8qo7Khm7Mdkk1s0YY2h5sy5+Vy4laN8QuJQlgOHrCRlihMJ99sV+gdWrGOb93LRa4KnMtL7vqyWOBey5rh4quMSVlvKtsdcNniGZTn4TiVtVsF7g==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA2PR04MB10160.eurprd04.prod.outlook.com (2603:10a6:102:407::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 00:11:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 00:11:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Stefano Babic
 <sbabic@nabladev.com>, Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 07/10] pinctrl: nxp: imx93: Rename to imx9
Thread-Topic: [PATCH 07/10] pinctrl: nxp: imx93: Rename to imx9
Thread-Index: AQHcpeu4xHXHq/ORdUyyjjYw7wuAqrWVPKSAgAByXFA=
Date: Fri, 27 Feb 2026 00:11:35 +0000
Message-ID: <PAXPR04MB8459B88A5F92170EA16D75BE8873A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
 <20260225-imx-pinctrl-v1-7-7a149ab8feba@nxp.com>
 <CAOMZO5DH4ptUyVnQeW+b-ocswXYSfZznepjyKXppzhCDnvCezQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DH4ptUyVnQeW+b-ocswXYSfZznepjyKXppzhCDnvCezQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PA2PR04MB10160:EE_
x-ms-office365-filtering-correlation-id: c3830d55-3ec0-4c0f-c7ae-08de7594c510
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|19092799006|38070700021; 
x-microsoft-antispam-message-info: Hqq9aBwxfteaguhvwtEJGAYplaHNJC0Tz0xrqh5JDkpLGvikSgoOvR4H4DL+4O6EJAS2UkZJEY70iZlVXGXTpzePOUGyocsGJ0JT7NHcOa7aXydb2mCTDefNTrsbLYnXqC5lOouiZ/JvNaiogwi7stwu/PW84G3W70iZBLbSZGCyJ2r5DVX4zB1McD7Owr71I3tIfX+IyW+DvIaHeC5NXmfDC97i7Wd5agJPtLmp4OB/7Hgf7f6/hjGQD1qG2aHP5dDlqvjGsLV5SDgsuDqbfsICi8Q2C67vf9psNgKDjlDP7JVQe1o6jjdIITX0xaVAypj4bWgeGiCj7l/Ea7FxjYR41G+BQ09Y5me1OaejbXl2b2vYhOQ/muWHhDgVIXHUGEI+I9DqIQbO6hA8PZaJx8nzIBk35Nx9zaghorow/DfUMOt/Il8HbPMRn6LI3DpMF6vEuwYqc0RtE9+XFp8OyTWnIu5Un6vnplkTrEZBt9CvvkkOxJ8NayE4lqs3QhQKb2je3qRUqzZO0wCtRoiWvhYVWeaQeGsyHscVWAz8ujNWb01+hktxch6SuMfA3o1eLOx+KHXQofKeA0FkgBkirqPAEzWPlgaoWbgr4SXDPzcvlw/9z+tNcIWQGUwnPCJxGKDJN5uSHzZgoFfyfT1J4uV/rW8p7sUZ1wsuzk74S6k1XIC991PpoWXREaaQjE4C2tB7RklXpeo2iPaEJkad3Z0fSzWniPiPqv9Eq6umKE+hewOx+ZseiC8bR2TVymMPq9IgUGcVKXfJg26cI/dOvC4lOn3HdoruSXl26GqZb8s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJ0UXFuaTcxOEh3d3hGWXhyTVg4UTB3cUdVZi9QZlNpa1ExTmNWcUs3dWRZ?=
 =?utf-8?B?YXZ0cSs0azdHSm5xdTlnNUg3WmtqUW5SQmhTL2M3NTByMy9HbS9oSWxrdy8v?=
 =?utf-8?B?aVlyaGVlWTlUVkNkaW0xdTNtcys2YU9GRmplUVJ3d3R6QkdHd0FxY2E4MlM4?=
 =?utf-8?B?ZXZzTUZreFM3NU9YOHlxeGpZQld1V3ZsRlBkMVdySHdYU2tZa3FSTFhvUUhD?=
 =?utf-8?B?NkpRaUtsUjNYTEVoVVRSWnhyWU54aFBROFpVODJMQis3STQ3OTlEOUE3M2ZS?=
 =?utf-8?B?dlkrdW1ORjh0QzhsejgrMUx0bTlsUkhMQnpRbU5HZDZUR21xRGxETWpKV2NL?=
 =?utf-8?B?eEQxUE9qN0xaRkg1SDcyMmVTYlBxeXBjakN1cnZTaVZOS3FNWWYzVS9UUWNM?=
 =?utf-8?B?cVdCL3Nrb1NTOUNUVFRNNG1iQ2szVGVmZXBKaXpsY2ljWmp4Q20wSG1lc0Nt?=
 =?utf-8?B?WEx0UUdBWUlOL0ZWSmtjNkk1MVFPaXZiZEhCTUpnS3I5UG5ZZkV3VnFKckc3?=
 =?utf-8?B?UWp6VlhlMGxEaXNYdFdJOUlUS25Jb3RvcnI5SHE3WHZMMzgva1dRbjZLYkFv?=
 =?utf-8?B?T0xLRmV4MzZvdHp0R0w0alhNRndTWDZHRW54akV3aUg3RVBVRW9mR1hKdStO?=
 =?utf-8?B?TmlENHJXZzBQTExjblhiTEo3V3JILzVjNHNnUEFhdUFwSk9xdGtMR0ZWTTVN?=
 =?utf-8?B?K0pNNEY5UHpHeG9aQm5RT2NVZStmakdFTkJaeXFZbkhaRFZFcW15WDVYUytx?=
 =?utf-8?B?MCt4c05XT1krZURab0NZdHRaT20xSXNUUWV3NG5FZ1NTTFlTVnlBZkxXT3Z1?=
 =?utf-8?B?U2ZuQnAzNXNuUGlSVTNJUzNSU0RjSTVGSEhLSTVLZ054VFRyQkhnVG05TEJJ?=
 =?utf-8?B?cHF0UTVHTWtFd3dQdmk2bmNabk9ld0NyZTRYU1hCd3lMaWVsNmw3bHBEcUUz?=
 =?utf-8?B?Q2gvV3RRdGNJK0QwcXhVcmJRZEx3TDQ0dDBsNFFqNzRzbmk4UUUxcldzOGdz?=
 =?utf-8?B?clkxR0kvYm9LalllQ1pTdzZYdlFFZ1JrOHJpdUd0VXZxZmcyYzRqanp1TlhV?=
 =?utf-8?B?OXpLMFdWaTZxMmZhaEpRR255YzF2SEZQM0ZJZXAyd0Z2ZEhYWmdSMU5zVGdG?=
 =?utf-8?B?aXVtT0RrRmVEM2Vta0pkc0ROZytQM1NPaW1BZmFEbHBqSFlYVHVZTyswNmYz?=
 =?utf-8?B?MEJmeE1FQWwxWlhEbHNvVmhoQmVHMEVTR2UrTmFGdlRrK3NjR3ppQ2JaV3k1?=
 =?utf-8?B?R3RtKzBSYlpYK0UxQ0RJL3Q4b3VIUGJpNm1qQWhEYVRURkI1ZDF4OWZkQ1pK?=
 =?utf-8?B?dS9MZkJCcytueU1ocHppSE5HMExVY1dHK1JWZUMwUDViOTJYV09wK1NLSHZT?=
 =?utf-8?B?MExLVzk5enV2OFYrbVlUeFRxTXFzTER5aUZhMnhPNDdtYU0xQS9WNnNkdWNz?=
 =?utf-8?B?eWlFbGd3aGxHcmRhRmE0QTl3OWJxc0xTMlViMitPTTZnZ0hlN3FKa25RR1RU?=
 =?utf-8?B?WFJnRm5FeFliU3pEcFAvUE95V3JvamtzU2pNTDRYUkE2T291T3V4MSttc2Ra?=
 =?utf-8?B?QzVsOHRvUzBaRW95dE0vYWlZTWYxUzA5VjdVbWV3cWdsVjZqQnJ0SGZiZ0pS?=
 =?utf-8?B?NmQrUG1TZTl4elErcDgwRld4Qk9FWjR3Y1p5VnpYWXNoUDJydE1ERXZhUWtU?=
 =?utf-8?B?TlFBNjcySjZkVEFQd0VRdis2aU8rSGFpTG90MjQxQmpBUU11TGdFVjhhM3lD?=
 =?utf-8?B?dlNkNlFPQ0krM1dONjdmYkExV3F3dGdXZzVpMjg3VGN0YkV2Tmo1cU1VN1Za?=
 =?utf-8?B?L1VNUVUyOHFMT05NSEpYbXdHTTZ1MHh3UjMvK0hLM1FGWGxLYklwK3dRdmRp?=
 =?utf-8?B?V0FIeEZ0aGtLZ3RZa004cnVLdDBVam80TDZXRGQvT1dNdXJ6QTVwQzNBN3VT?=
 =?utf-8?B?SytQYUl2cmppTDA1aEFaMC94MXEyd1lGN085U0kyK285eWVaZUNUMnVPVS9E?=
 =?utf-8?B?TG5OQnJnakEreUhyci85bzRqSWxkdzJJNTUwZ3RsVVhlVUh5V0FEUmhadlVU?=
 =?utf-8?B?bC9HZlphS1g5V1EySHhTZVBoM0M1SnpZKy9LZjFzeE02aFkzb20waXN3a1Uz?=
 =?utf-8?B?RlZCZEJteEFTRVFCNG9NMnJNcHg2WG9TbHg5NHdPWldNL3NTWEdVcSs3Mk0w?=
 =?utf-8?B?K0pVSWl6VktmYWFyUkFFVzUveXR0WUJzT1l0djdnUjdzYmthMTl5Z2ZQbFFX?=
 =?utf-8?B?bVYzUHZCazVyMzBlaHRUTVpxUlExMGxXSmFyWVJ4U1d3OHM1WVluUzBscUxz?=
 =?utf-8?Q?9ycsWOqFyK9knmwqda?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3830d55-3ec0-4c0f-c7ae-08de7594c510
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 00:11:35.4785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCTAyr6v15TNdj6he+0nH0wdMreBq61lJOmcm0+9KaMKioguqL4KTcWdvb38FseXsiFs03Gsmv7dWzauAtKr7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10160
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwNy8xMF0gcGluY3RybDogbnhwOiBp
bXg5MzogUmVuYW1lIHRvIGlteDkNCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBUdWUsIEZlYiAy
NCwgMjAyNiBhdCA5OjE04oCvUE0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+DQo+ID4gV2UgYXJlIGdvaW5nIHRvIGFkZCBwaW5jdHJsIGRhdGEgc3VwcG9ydCBmb3IgYm90
aCBpLk1YOTMgYW5kIGkuTVg5MS4NCj4gPiBTaW5jZSB0aGVzZSBTb0NzIHNoYXJlIHRoZSBzYW1l
IHBpbmN0cmwgZHJpdmVyIHN0cnVjdHVyZSwgcmVuYW1lDQo+ID4gcGluY3RybC1pbXg5My5jIHRv
IGEgbW9yZSBnZW5lcmljIHBpbmN0cmwtaW14OS5jIGFuZCB1cGRhdGUgYWxsDQo+ID4gcmVsYXRl
ZCB2YXJpYWJsZSBhbmQgZnVuY3Rpb24gbmFtZXMgYWNjb3JkaW5nbHkuDQo+ID4NCj4gPiBUaGlz
IHByZXBhcmVzIHRoZSBkcml2ZXIgZm9yIHN1cHBvcnRpbmcgYWRkaXRpb25hbCBpLk1YOSBmYW1p
bHkgU29Dcy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BpbmN0cmwvbnhwL01ha2VmaWxlICAgICAgICB8
ICAyICstDQo+ID4gIGRyaXZlcnMvcGluY3RybC9ueHAvcGluY3RybC1pbXg5LmMgIHwgMzQNCj4g
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvcGluY3Ry
bC9ueHAvcGluY3RybC1pbXg5My5jIHwgMzQNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IA0KPiBQbGVhc2UgZ2VuZXJhdGUgdGhpcyB1c2luZyAiZ2l0IG12IiBzbyBp
dCBhcHBlYXJzIGFzIGEgcmVuYW1lIHJhdGhlcg0KPiB0aGFuIGFkZGluZyBhbmQgcmVtb3Zpbmcg
ZmlsZXMuDQoNCkkgdXBkYXRlZCBhbGwgcmVsYXRlZCB2YXJpYWJsZSBhbmQgZnVuY3Rpb24gbmFt
ZXMgYWNjb3JkaW5nbHksDQpzdWNoIGFzIGlteDkzX3BpbmN0cmxfb3BzIHRvIGlteDlfcGluY3Ry
bF9vcHMuDQoNClRoYW5rcywNClBlbmcuDQo=
