Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394AEEE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 12:16:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98895866DA;
	Fri, 15 Sep 2023 14:16:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="LO7ifKn5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1290B864CB; Fri, 15 Sep 2023 14:16:48 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CA9864CB
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=laurentiu.tudor@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+v84r+m3/Bd2db7TdPxPSruKTMp6wdG7YTg16ko3OvpF2euCx7MWoDOJei/7WMyVsSqzC2EqoD4wLB8uL8ZKFlGjrxDynNty5bjbCNl7BG6IRGcHi5MRxtv5avg+G3ABfvP9yFpXMGhi42VJ9THjSpKN4abRwCJkrajhgRh1rt491n4NMOsztJAv6n+pE9fHkA55WekVfN6ivquZHQQ+2YgL0GwqCeTEqsFZ+mdyNn9vZBawlDidSDm8RgWc7CB6vPq2dz8vt7aAwzF0IqNFOlAolcbbOiqQ3sfJqXv64lHZlahP8KWmxjgVH+ZLjiyI4gTiB9QnJtLLQEFRYqWpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJAmgE2qYW/lD5ZZPhi9ZhMaQo/W+Ezsy6LaA2j+OvA=;
 b=Mb20gJr3GDGleLQtbsGUXC+iNCsj0PQ7pCi8i8vmV1l+f1N8qL9XmoiMJ7E6dbj3SmailYwo0COu/dQO2PpHc10921iRzp87szFtbrsPsH+ccIYsvyIRBAEdf0PiD6T2/3CQplecTovGqtJC5aUVZU8OUcyOLvskdi8h/a+AHwmh6AD6z2+OjAWbtHmK6sL4EqmgLhRKKjxS5WPkGc/KeQRVC44NhrfgFck7rYZzEzfM/L0TA/g2aTqZ/og5xRqHWKLYM3ObxNm9UT2BAKoCTNR6cpzOZkz3Idkl7cB3k54FJ//TrqoaNGJ5dCQntpHklWLX/nkZBozNkF8GD/HAxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJAmgE2qYW/lD5ZZPhi9ZhMaQo/W+Ezsy6LaA2j+OvA=;
 b=LO7ifKn5wmDIYt5oobQ1GCOH915Mab4PU9z41o08KMpg6LUNmNdTbwsvYvOEzAK3TSyKRfCE73Op6qJ20zVeCiNhC20el9XAXzyVeLcBhj8QZeemgRQsIgOsLVCCZyrPDYri5j9ovl5dLBQDQz15ggEnifYv/YCC1W8AcN4UYPI=
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com (2603:10a6:10:368::16)
 by PAXPR04MB8687.eurprd04.prod.outlook.com (2603:10a6:102:21e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 12:16:44 +0000
Received: from DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9]) by DB9PR04MB9380.eurprd04.prod.outlook.com
 ([fe80::179f:1c4a:4573:acb9%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 12:16:43 +0000
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Robin Murphy <robin.murphy@arm.com>, Priyanka Jain
 <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>, Meenakshi Aggarwal
 <meenakshi.aggarwal@nxp.com>, "joe.hershberger@ni.com"
 <joe.hershberger@ni.com>, "rfried.dev@gmail.com" <rfried.dev@gmail.com>, Peng
 Fan <peng.fan@nxp.com>, "sjg@chromium.org" <sjg@chromium.org>, Sean Anderson
 <sean.anderson@seco.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/5] armv8: fsl-layerscape: create bypass smmu mapping for
 MC
Thread-Topic: [PATCH 3/5] armv8: fsl-layerscape: create bypass smmu mapping
 for MC
Thread-Index: AQHZ4Nt7SLKOQkqZikWTE4n2Oma53rAOC1IAgABADwD//+8hgIAMiCEA
Date: Fri, 15 Sep 2023 12:16:43 +0000
Message-ID: <DB9PR04MB9380F1FF21D37ACA85E04643ECF6A@DB9PR04MB9380.eurprd04.prod.outlook.com>
References: <20230906160152.24185-1-laurentiu.tudor@nxp.com>
 <20230906160152.24185-3-laurentiu.tudor@nxp.com>
 <56c3c58c-e871-5bfc-d256-fff30cc5cbf6@arm.com>
 <1931b72d-8345-73a7-7a2d-8c64a5168047@nxp.com>
 <9032b524-54f9-d74a-7be4-79b437e65324@arm.com>
In-Reply-To: <9032b524-54f9-d74a-7be4-79b437e65324@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DB9PR04MB9380.eurprd04.prod.outlook.com
 (15.20.6768.024)
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9380:EE_|PAXPR04MB8687:EE_
x-ms-office365-filtering-correlation-id: 2c46c827-bc99-4bf7-46ba-08dbb5e59f8a
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YswQlNtV3iYBv5y1ViVKNKoPOIUVm90tscsl4AWdT64q9WbDdqXNh4/07dqaKhQLCNvB/HfEvoGhasrMtt6pFticmZF1JjSbESNZieRZXdQKipxFZUz84OepEJkW5Kg3Cr0j1g4SSmnqto4Rr3mtDkgFjsjGHQAiQGl4h0fa5duHUN1Efc1LkWysKigXgXYUrheAPzjMFDRsZqQmZgouF3RLAMhopr90oRWupwLiWK+qkczW9EBIMup3ngxRCikXirOtXx+bnsgvg8WdcR5PQ1q/xnWe1lC6iHvBJ3a8YPkFQOyEjZKJsAG44aPniuUJUsfIEtaD7IlIwSrhZjJZ1LNwpX3vZKr2vi1IVb9lK7BOct21bh7tTnJMftLtQMVwh0BAYQobCSsUhux/ShPifmvvKl3t+w2odw6i9QiEV4sxy1gScaFRyavc5r8nFq94NA/81vlliRZ06vRC0S6UDhFeQq4gxv0uxhVBBJuuJcYAi10M6FBke7nqR88BwC7rkcSJ3I/RAeLj8/HvYGyjJkq1kNFQ8tpxQoQQ+QPJMaVAkcfHydwauyhMNGbcc/pVRVlBMzBGdRlHMGWXy5Sok2i41NpVMqjbUk63xKBWKF+/FTQ1FW14VqJ34lAXZBemS16/gxcBDmxFRZQL6XjIhtLE+ggPCeSxuZVhOgPREfkvDrth/jKh+UQqSD/PKAMA
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9380.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(366004)(39860400002)(136003)(346002)(451199024)(186009)(1800799009)(8936002)(76116006)(8676002)(5660300002)(41300700001)(7696005)(6506007)(9686003)(53546011)(66476007)(66946007)(66446008)(66556008)(64756008)(110136005)(4326008)(316002)(2906002)(44832011)(52536014)(966005)(38070700005)(38100700002)(122000001)(45080400002)(921005)(55016003)(55236004)(86362001)(26005)(71200400001)(33656002)(478600001)(83380400001)(65966003)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OVJuZWlBcjZhalFhdmVQV0hPKzlGNWVlN0Ryb20xYktzcDhzN0RyM3NMbzhE?=
 =?utf-8?B?SE50UHBoeCs3T3E5SzBSTXliSExvUkZIZFNNLzQ0TmVXTkZoTjg0MTlud3Zh?=
 =?utf-8?B?WEhEbHE4a0RLSFJSRUt1QXNhZUJjTXJxRjFFY2ZoamtRbjkyaXgvLzVPNEpR?=
 =?utf-8?B?amQ1cUVodUFEblFVREdBTithTXMvOTFzdytmcmwxTlNpZkVlQ0RyMEpXbVNK?=
 =?utf-8?B?TWtwelNBSVp2eXZObDNVbEt5NEpFaVd0WENwdldUeS9CVlk4bWUrbUJLenB6?=
 =?utf-8?B?eDdyYkMrZEd1K05rOE5EOHNISkxmNDdueXZyOVZXclMxY0ZMTndXRlh0eVJJ?=
 =?utf-8?B?VVU4dGxzeFd2VmpxU1h2Sko5K0ZKS211V3hxUWV3bk9ZWjlJUlJiK2dSdG0r?=
 =?utf-8?B?N3V0RXJaRk41VnB1TVNLMS9XQTBNcDlrcDNRTkNmaWpMWEpvNDBuZWVYUUk4?=
 =?utf-8?B?SmlWeHFDbXF6aFJIYXVUOUNaZjhWU0VoZmpwTlZwU2Z6NkJkVHJuZmdEZUpo?=
 =?utf-8?B?WkZua1FHbUl1NDJlZGlTOHBxSUdEbnlzYlAycjB0MnBVKzUzOU1hMkVUQ3Jw?=
 =?utf-8?B?UHRjZTVDUHBBMXpXejBYRm9MQVl2VEVBNEFJVldMQkF5U2R2d0hyaDAxY1VR?=
 =?utf-8?B?VG5SNC9rY2toTmdEcU5nSHMvN2RDWUFTTDV1Sk00cDZyL0lIeDEwREdSVjFs?=
 =?utf-8?B?UlZDWlorSWd2Q0x0UTlYOXdZMGUzZXlOMlBoVEFjSVkrYmRxc0o3YlkxMEV5?=
 =?utf-8?B?bkZsd3p5QWp6UmFXN1YzY21EQkxTanR2UFY0UEdTZGdFSCtTNEVzS3pqbEZN?=
 =?utf-8?B?TGUzelU5UG1BVFh0Mno0azJmQkhjdzZxeUhCcGwwOXdBbHk0b3FEWllHSGQ5?=
 =?utf-8?B?dnlVN1gwYWo0Q0FueStsZEg2V3RFRDR3VS8wT29GNVdnYkcyNWd6d2FxTnRF?=
 =?utf-8?B?UndHY1FNRzZRY0h2V1hCbnhwclhjSEcwbWdVT0ZFQmt5NzBuc0tlUElob3o4?=
 =?utf-8?B?cTltaVk4ckFtamtydUEyelhOd20wSGVSRkEyTVZGdHQwQ2JTWUtybzJWbTcy?=
 =?utf-8?B?Y0JYcVpzRy91T2pHbUphODlVa09oQ2Z6QmZwL056YmlMdjZVVVM3d0E2YmhQ?=
 =?utf-8?B?MkJzTUYrdWdEWmpoYmZYT1ZrbU9VeW1Ld1VUT21xNGlaeEU1TW1RdlZYOHJS?=
 =?utf-8?B?MFNGRkYrR3pRdk5FWnp0V1MvZ0hURXd6VktNNExEMjhYN2V1ZUQybjVKNnIw?=
 =?utf-8?B?Z3F5blBPYmlHNElLL05ieEhuV2xGWXJETHo2VlYzVHhFa2lZVmdObGZXMEND?=
 =?utf-8?B?NTc4QWtVQmVvdzNXdWZGdXVOaSt3Z0RySHl3R1hGdlB1V1Q2L0J4WW1ycXJz?=
 =?utf-8?B?ZzF3dzEyaUNCcm5XbnRYZjhCalNIRklTaTNxZnVCeUZ2d29xQ3FENFVGNG5O?=
 =?utf-8?B?d0VmVmpQOVNraWt0QWhWbGUwWHYxeWprNUIrVlZIM3I2WTQxN0h1U2x0Ynoy?=
 =?utf-8?B?WHF3OC93NWgvTjhpNXpiZHlPMG1HckpnbFcwUkx4aTlEb1RENzFpOXBBMzFM?=
 =?utf-8?B?N3ZNckJXMHB5Vyt2ZzVRamxZZHBFTzBGZ3B3RHpvWGlsU2hiUEJWK0x4N1Er?=
 =?utf-8?B?bFRsUnBoTk82MGY3ZmhJODNsYk0yMmZYNS9tbXQrZW5iSHJCQy9zZWtwSm80?=
 =?utf-8?B?K1dGZGt6ck4vWlRscmwzcGx4RDRhVnZVc2NuWGVBT3NDdE02N2lGeUJJWVR5?=
 =?utf-8?B?Wi9mZ2c4TElGSEhWL2FQbEc0LzE3RlQ1VGFSdlVUYmxmTitrbGovZ0piWUxP?=
 =?utf-8?B?cjVDV1JaWDFheDN5UG42UGdlSy95VWRqUDJUaUJNUWtnMUdLRDcwcHZsbDFr?=
 =?utf-8?B?WXlLWjJlYlIwVWJ0aE12MGpSMW1lbERZendrZnFmcnU1NDNVeTV3dmRLbWVZ?=
 =?utf-8?B?dTdPekc4WlNWUmJ5SDBRWEphYzNsUlFOL1ZEOUhmSkZ3djgrbmxxdEtob09R?=
 =?utf-8?B?akl1ZWFlRXlFTDBkZStVenVobFdVc0MrTWM3cXB6bFFNTmZNQk84c1cvbWMx?=
 =?utf-8?B?TXViaXVsSm1USDFOeDZoRjBjMXhuaGF1eFd5ME5MeTlyUDAwV1BHbXFPTC9V?=
 =?utf-8?Q?UH8DEg0u+l6X9lNp5+YjTHGLY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7023A3675B1C64591D69757364AF023@NXP1.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9380.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c46c827-bc99-4bf7-46ba-08dbb5e59f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 12:16:43.1314 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CW4R5dZ9bZ6LfSWUuHIvsIjRWKb0JAksmIALR/NaVk4SX8HCF2L3HXu900PjGNk79Vcfb0OpKOKJBF87fioV7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8687
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

DQoNCk9uIDkvNi8yMDIzIDExOjA5IFBNLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+IE9uIDIwMjMt
MDktMDYgMTk6MTAsIExhdXJlbnRpdSBUdWRvciB3cm90ZToNCj4+DQo+Pg0KPj4gT24gOS82LzIw
MjMgODoyMSBQTSwgUm9iaW4gTXVycGh5IHdyb3RlOg0KPj4+IE9uIDIwMjMtMDktMDYgMTc6MDEs
IExhdXJlbnRpdSBUdWRvciB3cm90ZToNCj4+Pj4gTUMgYmVpbmcgYSBwbGFpbiBETUEgbWFzdGVy
IGFzIGFueSBvdGhlciBkZXZpY2UgaW4gdGhlIFNvQyBhbmQNCj4+Pj4gYmVpbmcgbGl2ZSBhdCBP
UyBib290IHRpbWUsIGFzIHNvb24gYXMgdGhlIFNNTVUgaXMgcHJvYmVkIGl0DQo+Pj4+IHdpbGwg
aW1tZWRpYXRlbHkgc3RhcnQgdHJpZ2dlcmluZyBmYXVsdHMgYmVjYXVzZSB0aGVyZSBpcyBubw0K
Pj4+PiBtYXBwaW5nIGluIHRoZSBTTU1VIGZvciB0aGUgTUMuIFByZS1jcmVhdGUgc3VjaCBhIG1h
cHBpbmcgaW4NCj4+Pj4gdGhlIFNNTVUsIGJlaW5nIHRoZSBPUydzIHJlc3BvbnNpYmlsaXR5IHRv
IHByZXNlcnZlIGl0Lg0KPj4+DQo+Pj4gRG9lcyBVLUJvb3QgZW5hYmxlIHRoZSBTTU1VPyBBRkFJ
Q1MgdGhlIG9ubHkgdGhpbmcgaXQga25vd3MgaG93IHRvIGRvDQo+Pj4gaXMgZXhwbGljaXRseSB0
dXJuIGl0ICpvZmYqLCB0aGVyZWZvcmUgcHJvZ3JhbW1pbmcgb3RoZXIgcmVnaXN0ZXJzDQo+Pj4g
YXBwZWFycyB0byBiZSBhIGNvbXBsZXRlIHdhc3RlIG9mIHRpbWUuDQo+Pg0KPj4gTm8sIGl0IGRv
ZXNuJ3QgZW5hYmxlIFNNTVUgYnV0IGl0IGRvZXMgbWFyayBhIFNNUiBhcyB2YWxpZCBmb3IgTUMg
RlcuDQo+PiBBbmQgdGhlIEFSTSBTTU1VIGRyaXZlciBzdWJ0bHkgcHJlc2VydmVzIGl0LCBzZWUg
WzFdIChpdCdzIGxhdGUgYW5kIEkNCj4+IG1pZ2h0IGJlIHdyb25nLCBidXQgSSdsbCBkb3VibGUg
Y2hlY2sgdG9tb3Jyb3cpLiA6LSkNCj4NCj4gTm8sIHRoYXQgc2V0cyB0aGUgU01SIHZhbGlkIGJp
dCAqaWYqIHRoZSBjb3JyZXNwb25kaW5nIGVudHJ5IGlzDQo+IGFsbG9jYXRlZCBhbmQgbWFya2Vk
IGFzIHZhbGlkIGluIHRoZSBzb2Z0d2FyZSBzdGF0ZSBpbiBzbW11LT5zbXJzLCB3aGljaA0KPiBh
dCBwcm9iZSB0aW1lIGl0IGlzbid0LCBiZWNhdXNlIHRoYXQncyBvbmx5IGp1c3QgYmVlbiBhbGxv
Y2F0ZWQgYW5kIGlzDQo+IHN0aWxsIHplcm8taW5pdGlhbGlzZWQuIFVubGVzcywgdGhhdCBpcywN
Cj4gYXJtX3NtbXVfcm1yX2luc3RhbGxfYnlwYXNzX3NtcigpIGZvdW5kIGEgcmVzZXJ2ZWQgcmVn
aW9uIGFuZA0KPiBwcmVhbGxvY2F0ZWQgYW4gZW50cnkgdG8gaG9ub3VyIGl0LiBCdXQgZXZlbiB0
aG9zZSBlbnRyaWVzIGFyZSBzdGlsbA0KPiBjb25zdHJ1Y3RlZCBmcm9tIHNjcmF0Y2g7IHdlIGNh
bid0IGRvIGFueXRoaW5nIHdpdGggdGhlIGV4aXN0aW5nDQo+IFNNUi9TMkNSIHJlZ2lzdGVyIGNv
bnRlbnRzIGluIGdlbmVyYWwgc2luY2UgdGhleSBtYXkgYmUgdW5pbml0aWFsaXNlZA0KPiByYW5k
b20gcmVzZXQgdmFsdWVzLCBzbyB3ZSBkb24ndCBldmVuIGxvb2suDQo+DQo+IFBheSBubyBhdHRl
bnRpb24gdG8gdGhlIHFjb21fc21tdV9jZmdfcHJvYmUoKSBoYWNrIGVpdGhlciAtIHRoYXQgb25s
eQ0KPiBleGlzdHMgb24gdGhlIHByb21pc2UgdGhhdCB0aGUgcmVsZXZhbnQgcGxhdGZvcm1zIGNv
dWxkbid0IGhhdmUgdGhlaXINCj4gZmlybXdhcmUgdXBkYXRlZCB0byB1c2UgcHJvcGVyIFJNUnMu
DQo+DQo+IFlvdSdyZSBhbHJlYWR5IGRvaW5nIHRoZSByaWdodCB0aGluZyBpbiBwYXRjaCAjMiwg
c28gdGhlcmUncyBubyBuZWVkIHRvDQo+IHdhc3RlIGNvZGUgb24gZG9pbmcgYSBwb2ludGxlc3Mg
d3JvbmcgdGhpbmcgYXMgd2VsbC4NCj4NCg0KU3BlbnQgcXVpdGUgYSB3aGlsZSAoc29ycnkhKSB0
cnlpbmcgdG8gcmVtZW1iZXIgd2h5IHRoaXMgd2FzIG5lZWRlZCBidXQNCmRvbid0IGhhdmUgYSBj
bGVhciBhbnN3ZXIuIEkgc3VzcGVjdCB0aGF0IHRoZSBoYWNrIHdhcyB1c2VkIHdpdGggZWFybHkN
CmlvcnQgcm1yIGltcGxlbWVudGF0aW9ucy4NCkFueXdheSwgSSByZXRlc3RlZCB3aXRob3V0IGl0
IGJvdGggRFQgYW5kIEFDUEkgYW5kIGxvb2tzIGdvb2QuIFdpbGwgZHJvcA0KdGhlIHBhdGNoIGFu
ZCByZXN1Ym1pdCB0aGUgc2VyaWVzLg0KDQotLS0NClRoYW5rcyAmIEJlc3QgUmVnYXJkcywgTGF1
cmVudGl1DQoNCj4NCj4+PiBBbGwgdGhhdCBzaG91bGQgbWF0dGVyIHRvIHRoZSBPUywgYW5kIHRo
YXQgaXQgaXMgcmVzcG9uc2libGUgZm9yDQo+Pj4gdXBob2xkaW5nLCBpcyB0aGUgcmVzZXJ2ZWQg
bWVtb3J5IHJlZ2lvbnMgZnJvbSBwYXRjaCAjMi4gRm9yDQo+Pj4gaW5zdGFuY2UsIGlmIHRoZSBP
UyBpcyBMaW51eCwgbGl0ZXJhbGx5IHRoZSBmaXJzdCB0aGluZw0KPj4+IGFybV9zbW11X2Rldmlj
ZV9yZXNldCgpIGRvZXMgaXMgcmV3cml0ZSBhbGwgdGhlIFMyQ1JzIGFuZCBTTVJzDQo+Pj4gd2l0
aG91dCBzbyBtdWNoIGFzIGxvb2tpbmcuDQo+Pg0KPj4gWzFdDQo+PiBodHRwczovL2dpdC5rZXJu
ZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9k
cml2ZXJzL2lvbW11L2FybS9hcm0tc21tdS9hcm0tc21tdS5jI244OTQNCj4+DQo+Pg0KPj4gLS0t
DQo+PiBCZXN0IFJlZ2FyZHMsIExhdXJlbnRpdQ0KPj4NCj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBMYXVyZW50aXUgVHVkb3IgPGxhdXJlbnRpdS50dWRvckBueHAuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gICBhcmNoL2FybS9jcHUvYXJtdjgvZnNsLWxheWVyc2NhcGUvc29jLmMgICAgICAgfCAyNg0K
Pj4+PiArKysrKysrKysrKysrKysrLS0tDQo+Pj4+ICAgLi4uL2FzbS9hcmNoLWZzbC1sYXllcnNj
YXBlL2ltbWFwX2xzY2gzLmggICAgIHwgIDkgKysrKysrKw0KPj4+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMzIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2NwdS9hcm12OC9mc2wtbGF5ZXJzY2FwZS9zb2MuYw0KPj4+PiBiL2FyY2gv
YXJtL2NwdS9hcm12OC9mc2wtbGF5ZXJzY2FwZS9zb2MuYw0KPj4+PiBpbmRleCAzYmZkYzNmNzc0
MzEuLjg3MGI5OTgzOGFiNSAxMDA2NDQNCj4+Pj4gLS0tIGEvYXJjaC9hcm0vY3B1L2FybXY4L2Zz
bC1sYXllcnNjYXBlL3NvYy5jDQo+Pj4+ICsrKyBiL2FyY2gvYXJtL2NwdS9hcm12OC9mc2wtbGF5
ZXJzY2FwZS9zb2MuYw0KPj4+PiBAQCAtMzc2LDYgKzM3NiwxOCBAQCB2b2lkIGJ5cGFzc19zbW11
KHZvaWQpDQo+Pj4+ICAgICAgIHZhbCA9IChpbl9sZTMyKFNNTVVfTlNDUjApIHwgU0NSMF9DTElF
TlRQRF9NQVNLKSAmDQo+Pj4+IH4oU0NSMF9VU0ZDRkdfTUFTSyk7DQo+Pj4+ICAgICAgIG91dF9s
ZTMyKFNNTVVfTlNDUjAsIHZhbCk7DQo+Pj4+ICAgfQ0KPj4+PiArDQo+Pj4+ICt2b2lkIHNldHVw
X3NtbXVfbWNfYnlwYXNzKGludCBpY2lkLCBpbnQgbWFzaykNCj4+Pj4gK3sNCj4+Pj4gKyAgICB1
MzIgdmFsOw0KPj4+PiArDQo+Pj4+ICsgICAgdmFsID0gU01NVV9TTVJfVkFMSURfTUFTSyB8IChp
Y2lkIDw8IFNNTVVfU01SX0lEX1NISUZUKSB8DQo+Pj4+ICsgICAgICAgIChtYXNrIDw8IFNNTVVf
U01SX01BU0tfU0hJRlQpOw0KPj4+PiArICAgIG91dF9sZTMyKFNNTVVfUkVHX1NNUigwKSwgdmFs
KTsNCj4+Pj4gKyAgICB2YWwgPSBTTU1VX1MyQ1JfRVhJRFZBTElEX1ZBTElEX01BU0sgfCBTTU1V
X1MyQ1JfVFlQRV9CWVBBU1NfTUFTSzsNCj4+Pj4gKyAgICBvdXRfbGUzMihTTU1VX1JFR19TMkNS
KDApLCB2YWwpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICAgdm9pZCBmc2xfbHNjaDNfZWFybHlf
aW5pdF9mKHZvaWQpDQo+Pj4+ICAgew0KPj4+PiAgICAgICBlcnJhdHVtX3Jjd19zcmMoKTsNCj4+
Pj4gQEAgLTQwMiwxMCArNDE0LDE4IEBAIHZvaWQgZnNsX2xzY2gzX2Vhcmx5X2luaXRfZih2b2lk
KQ0KPj4+PiAgICAgICAgICAgYnlwYXNzX3NtbXUoKTsNCj4+Pj4gICAjZW5kaWYNCj4+Pj4gLSNp
ZiBkZWZpbmVkKENPTkZJR19BUkNIX0xTMTA4OEEpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfTFMx
MDI4QSkgfHwgXA0KPj4+PiAtICAgIGRlZmluZWQoQ09ORklHX0FSQ0hfTFMyMDgwQSkgfHwgZGVm
aW5lZChDT05GSUdfQVJDSF9MWDIxNjBBKSB8fCBcDQo+Pj4+IC0gICAgZGVmaW5lZChDT05GSUdf
QVJDSF9MWDIxNjJBKQ0KPj4+PiArI2lmZGVmIENPTkZJR19BUkNIX0xTMTAyOEENCj4+Pj4gKyAg
ICBzZXRfaWNpZHMoKTsNCj4+Pj4gKyNlbmRpZg0KPj4+PiArDQo+Pj4+ICsjaWYgZGVmaW5lZChD
T05GSUdfQVJDSF9MUzEwODhBKSB8fCBkZWZpbmVkKENPTkZJR19BUkNIX0xTMjA4MEEpDQo+Pj4+
ICsgICAgc2V0X2ljaWRzKCk7DQo+Pj4+ICsgICAgc2V0dXBfc21tdV9tY19ieXBhc3MoMHgzMDAs
IDApOw0KPj4+PiArI2VuZGlmDQo+Pj4+ICsNCj4+Pj4gKyNpZiBkZWZpbmVkKENPTkZJR19BUkNI
X0xYMjE2MEEpIHx8IGRlZmluZWQoQ09ORklHX0FSQ0hfTFgyMTYyQSkNCj4+Pj4gICAgICAgc2V0
X2ljaWRzKCk7DQo+Pj4+ICsgICAgc2V0dXBfc21tdV9tY19ieXBhc3MoMHg0MDAwLCAwKTsNCj4+
Pj4gICAjZW5kaWYNCj4+Pj4gICB9DQo+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNsdWRl
L2FzbS9hcmNoLWZzbC1sYXllcnNjYXBlL2ltbWFwX2xzY2gzLmgNCj4+Pj4gYi9hcmNoL2FybS9p
bmNsdWRlL2FzbS9hcmNoLWZzbC1sYXllcnNjYXBlL2ltbWFwX2xzY2gzLmgNCj4+Pj4gaW5kZXgg
Y2E1ZTMzMzc5YmE5Li5iZWM1MzU1YWRhZWQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2FyY2gvYXJtL2lu
Y2x1ZGUvYXNtL2FyY2gtZnNsLWxheWVyc2NhcGUvaW1tYXBfbHNjaDMuaA0KPj4+PiArKysgYi9h
cmNoL2FybS9pbmNsdWRlL2FzbS9hcmNoLWZzbC1sYXllcnNjYXBlL2ltbWFwX2xzY2gzLmgNCj4+
Pj4gQEAgLTE5MCw2ICsxOTAsMTUgQEANCj4+Pj4gICAjZGVmaW5lIFNDUjBfQ0xJRU5UUERfTUFT
SyAgICAgICAgMHgwMDAwMDAwMQ0KPj4+PiAgICNkZWZpbmUgU0NSMF9VU0ZDRkdfTUFTSyAgICAg
ICAgMHgwMDAwMDQwMA0KPj4+PiArI2RlZmluZSBTTU1VX1JFR19TTVIobikgICAgICAgICAgICAo
U01NVV9CQVNFICsgMHg4MDAgKyAoKG4pIDw8IDIpKQ0KPj4+PiArI2RlZmluZSBTTU1VX1JFR19T
MkNSKG4pICAgICAgICAoU01NVV9CQVNFICsgMHhjMDAgKyAoKG4pIDw8IDIpKQ0KPj4+PiArI2Rl
ZmluZSBTTU1VX1NNUl9WQUxJRF9NQVNLICAgICAgICAweDgwMDAwMDAwDQo+Pj4+ICsjZGVmaW5l
IFNNTVVfU01SX01BU0tfTUFTSyAgICAgICAgMHhmZmZmMDAwMA0KPj4+PiArI2RlZmluZSBTTU1V
X1NNUl9NQVNLX1NISUZUICAgICAgICAxNg0KPj4+PiArI2RlZmluZSBTTU1VX1NNUl9JRF9NQVNL
ICAgICAgICAweDAwMDBmZmZmDQo+Pj4+ICsjZGVmaW5lIFNNTVVfU01SX0lEX1NISUZUICAgICAg
ICAwDQo+Pj4+ICsjZGVmaW5lIFNNTVVfUzJDUl9FWElEVkFMSURfVkFMSURfTUFTSyAgICAweDAw
MDAwNDAwDQo+Pj4+ICsjZGVmaW5lIFNNTVVfUzJDUl9UWVBFX0JZUEFTU19NQVNLICAgIDB4MDAw
MTAwMDANCj4+Pj4gICAvKiBQQ0llICovDQo+Pj4+ICAgI2RlZmluZSBDRkdfU1lTX1BDSUUxX0FE
RFIgICAgICAgICAgICAoQ09ORklHX1NZU19JTU1SICsgMHgyNDAwMDAwKQ0K
