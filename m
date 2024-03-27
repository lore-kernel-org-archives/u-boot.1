Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81F4C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 13:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CDF088054;
	Wed, 27 Mar 2024 14:31:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NHoXHBwN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B344488087; Wed, 27 Mar 2024 14:31:16 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8400487971
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiPp9QhnKQklQv0Rkn3NkLO7pzCrlDvjeBGXtTvIDhR0ISvd0yYiCIr2q9+/xQuQFnZVo6fZrdl9au0Hc6UiJjSmwi02eb5YqFSbosyQPtXplD26Fq3rSL26HG15z2J9lsXRAcfwn99RY/sj9wT/NwjaRajmcbCnpke6NEG+u5hDCXOe5jX1MZ5VS5GD1FR6UavXY0bS1rvb+pxnp52MKcrLY48E2hEcLzODSK1epJgZEjmZqmiaC7kj2NhKAvIYNBDB1WLER3igbMVd5Qp7GEnUsQmJCwgr/Rd5HVi86Za2K1bRGZ7MsI9UZb/o13Df7qbHhiGH/fSE58hcZKDdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSRfci4vwgXwQ8EUWRLwvdPoW2DAvAp9CxlFEjmcvj0=;
 b=AuHyCt9bPVL5CZXUIMJlMfwM99cai09gGhB8KInHC21DOSnSQWfGmpvDxctALmWVurCSff34EG/CB+nzsvdcKynLXewFs0cwWyiydfCksB588ecCO3wumewcWMmANdYX6eONVhtUS6FXSqkQR8GU95KIkoI9B0J40Ee76gG96MmvmFR+UGTn0xotL2/eq1GXBMRsA7h0OAQLD8tIIVjD2sbNZH/9tlTd3pbPARqQO20GuogncgHCB2GLICenVG3FGgypM6BkSw7tpeXehu60NbF21ag68qhNAgmjCmmNNG3Ru2SMVvyhpLq89Ig3BPBL6g5kc/cJeO8uxa5cb1qHCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSRfci4vwgXwQ8EUWRLwvdPoW2DAvAp9CxlFEjmcvj0=;
 b=NHoXHBwN+d72HS79hmkeYFHleAE925HEutI2pHHAcltkcTNqcQvzR0A4+0CJa6WQfmCNQzTSbqz4OXnyVgocnsHP0IKJkBhy2/l2pIEWUk8YoLH/qH9MtSBSf5Xbseeh6LQmQpZDI0sEyJqlGzQXn7cg7AGUQZW3SAXtFjfE8q0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8075.eurprd04.prod.outlook.com (2603:10a6:10:25d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 13:31:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 13:31:10 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sumit Garg <sumit.garg@linaro.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 5/6] Makefile: tune the include order
Thread-Topic: [PATCH 5/6] Makefile: tune the include order
Thread-Index: AQHagEhEEUW9hvn0CEm2sSYSH2SYfrFLktkAgAACODA=
Date: Wed, 27 Mar 2024 13:31:10 +0000
Message-ID: <DU0PR04MB94178343791A449EEEB4811788342@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240327-imx93-of-v1-0-afab6b31422a@nxp.com>
 <20240327-imx93-of-v1-5-afab6b31422a@nxp.com>
 <CAFA6WYPb9wg128rYu_76d1vh2q47TfRgkF1e3LOaJfGMpGEaQg@mail.gmail.com>
In-Reply-To: <CAFA6WYPb9wg128rYu_76d1vh2q47TfRgkF1e3LOaJfGMpGEaQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8075:EE_
x-ms-office365-filtering-correlation-id: a039a0f5-c198-409c-f4a6-08dc4e622a52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8RFQMlgv4SnNE4Hf0gnz82UGE9cj8KypoDQuvfQyKWB6+2i910c3zaS2LQk+algE/Ob0QaV7nMu2Ig17qHmuDVmvJhjNKkwo9GwTCdZxysr8ET48YRJIu72N5a4f3a82d5G248f/cyAliceTxexrhz3bQtvGVTQBVccyCX0uHI+yL/AXv3IikiB5HgX8cB7grkrsM0f6zZ0TfnvoGLhzWy1rAejTdshKo0k2D46Mte6g4vhhDuFXY4WoEQjjwydSjY8zLhrw0Olls/qZPH1sFWVIlRR4D+y7dhIAEe/491ic7K/tNLkx3VqLBsb12xM2Y4Rf8CJ6L28vIMVWa8aDHb9ZHrXA2M9EwO2sUyLF64REg6sXf9NWF2UBdBGVyfPGb1iEzHu7UTOmdus42cnqyLS+gb+im/ko5kypE0W7FWLN6bgQ5A2KqNDjSW7J2er+rVs1njQYzYqK71ikDOVALtEQWWkRE9/V0SVs831jPvWXQh1dn2s1vO6l5+A0op1br4Rr8WVuZJYGWvvnoG1TMWthNqCwvXfKC22Y3p5p4LpELfZFH/1ZfSBZwIlZPYtMqFIeJfq5YB39vZs2jHWAWERF4su0p38Gc1JVKHQqHvILdIz94v1ujhIjgKpg6jRt98sOByZN328xVcZKyt2FnmTC90Nv/FEHMZK5foQRW87qEnPrsUT9BLoMSW8gfUyXZf4fF9wBFIZN/DBWlVdP454pvOaN+n4mPJsSz9jKh4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2IzNndZSkoyMEVqYVFQRkJMd2IzVEE4OVBwcVlPNjdMaGFwUlJzL3BXMkl0?=
 =?utf-8?B?Nk1UdDlqZTNqbGdtNnZ3S1ZFMVhQRy8yOUtUYUJqQWFMTnJwbHpBek0yRkVo?=
 =?utf-8?B?RWYvRC9WUUlabTVXdjdxYWNvREN4STl4UWNqVC9IdEUrdDhNL3gzSWNvbC9p?=
 =?utf-8?B?djZzSU03TER2ZFBVWDFiYVVRdlBhbmo5U0IrVmhKaHNnWFlSbXBUM25XUVVk?=
 =?utf-8?B?RGhGd2hPR1B1SXlEa2gvTXFMUjRCTW9QWHF4TExwUjdoQmZDQmhsWmpFUUlt?=
 =?utf-8?B?WldIKzJsYkpPR0dYY1pFVHRMSktsN1M2WmpSdTR6THVWL25mS2pmSFhKdzlv?=
 =?utf-8?B?UDNsSlJTYllyY0RjSHlkMHJTU0VxUzllbmVkcnlPSWFpdFErcnI2TmM1NGM5?=
 =?utf-8?B?UFA0THVyMlZyWkFGUExjWkhSUG41cXZuaEpjNFZzRjdWUlV6UDRTSHVvSlJn?=
 =?utf-8?B?ak4yZUtqVWFNZG9pTEMrZkVrVHlYWFhTWG9OQjVMbUFzcmF0RVNFZW42dFQv?=
 =?utf-8?B?dm55WURUR09KRjU0Y0Vkd3hJYmxWaDFKYVVCektQbmcySHk5T1ZETGRJZlJr?=
 =?utf-8?B?SFhuVkJDcnJCUFlxM2tiYlpMVUI5ekRyajNCZ01pS3RmZWxEbDJPLzR6cTl0?=
 =?utf-8?B?TVhiWS9XOUJGQXlyekR2R3lKdGlMb0VIYUpqN1VUN0FmdVRNU1lVVmtNWGRN?=
 =?utf-8?B?czZNMDArdFJXVmxodnFaL1VHVFZvSE9iM1lWMHpGREc3WG1nZnEvdmE0MGd5?=
 =?utf-8?B?U3hQckhqZWE4V1Yvdk1ZVzk1alF0NmJpNHhWWnJQYW96TDNXOURwZ1RPYVpo?=
 =?utf-8?B?OXpjcUtrMTZjMGVydWprRUc5c05LMG8rKzQ5MUN0YS8rbUJmUFdDY2tDWmdi?=
 =?utf-8?B?UXdURWxJdEV5SklBbm1nQ2hrYmMzWDFabFlydEpVdUIxL3ZyYU5ZMlRoeVg2?=
 =?utf-8?B?TzlEUFFVdTBiZWh5a09WN3VhUTcvN3loNlJSOFhSYmhGUzd3SmxQMUUrMUp5?=
 =?utf-8?B?UisxU0VLaTQ3NFViUjBLOXUzVTNrTXZzd2hBTVpHQ2JYVlU2elNmNVVnSjBv?=
 =?utf-8?B?ZGR4bDFnNGJUZW5lclRMMXlMT3lwOE1TMy9hVXFqS1EvV3ZIaGp2Sm5Tc0xs?=
 =?utf-8?B?L0hSVi9JSE56NVlqU3UySTNFemwzbGRsYkVDUlY5bitNTlFYK3JONzJhTk85?=
 =?utf-8?B?YWtqRlc3Nlc1bEp2RGFIWkJEUUtNa1FQdHRIbktqNVhFaDhsTlFSa1JCNXVN?=
 =?utf-8?B?ZGNNcnVFa0NjUzZWbHo4MFFvNlpQUERtN0dtbkNyWXJWaFhBdW1rbVo2TnBz?=
 =?utf-8?B?M21RdDVwWVlpNmc4ZjY3WGpLbENiM25mdlQ5dkREUnBwVlRvNFdrUVRNZjZG?=
 =?utf-8?B?bVNzQndYZWlxcnNhT2g2Y0lrcUZiU2orUmdYQnZUNmQ1c0hOb3NadUJwV0w3?=
 =?utf-8?B?NnRJZHNDczc1dU5QbVE3M3BRaGp2dGpQZnFFS1NVMHNJN0V6TGdyTGwvenVz?=
 =?utf-8?B?OVFWYk5oMG5zMmxQK2gvU3lsK2hNb0xFQTFZcGoyMmpSZThoRnhaVlJLcXk1?=
 =?utf-8?B?MXovOXlRc2llL2dGQ2swK0hhM3o5UVoyTnJ0MXFSeFQ1QnlkMElWZ0pFbjkz?=
 =?utf-8?B?aGpnSVZqdjVxczdKdE5PdGNNaGJ6dEh3bHArdk43YnYyVzRkZlU2TVl3a003?=
 =?utf-8?B?WXA1dVZUQ2w2SDNJZk55TzZYdWFDUVhrY2JQcVNGeXVuelI1bTRZU2ltYStt?=
 =?utf-8?B?SzBQblRJRGhoSDJrbmxoOFozNFp3eGUzaGVOdlFoZ3cwZTlhYnhQOUt0QnVn?=
 =?utf-8?B?MG1xbW8rU0ZsV1l5L3l0R0p3dGRJd1ZTNUd2eXRab0tuSnJua1lXVWFONWhY?=
 =?utf-8?B?L0xsZEtSQ2p2WlVQSmxQRjNVNVhpazAwNnRBbDR1dDFHSnV5aUYyOVFVOGNE?=
 =?utf-8?B?R0hlS1lLUjltRi9tQWdJNWNMaTNUK2wzczIvQ0xvZDVvMUVwQkIyTk1ZN0xO?=
 =?utf-8?B?dU1Ma0huUm1lMmVlVXY1YnB3WGMvcVRycStwTGRPMVVxaTM1L1E1T3lRaGJL?=
 =?utf-8?B?bVM2bGlIYnpUdFZ5VVlhWkJETjlXaU5HNlVBbEp0RVNnWGVMRU5rOWJUaU50?=
 =?utf-8?Q?UrsQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a039a0f5-c198-409c-f4a6-08dc4e622a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 13:31:10.3536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yeLOYGyOAmTzcbj69fStYd58DN5kLsQ2vXJ4IAGIwwIeuR4FaToiZsLBVUJUazBQMm3wQtgcazBip6anBz6hTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8075
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNl0gTWFrZWZpbGU6IHR1bmUgdGhlIGluY2x1ZGUgb3Jk
ZXINCj4gDQo+IEhpIFBlbmcsDQo+IA0KPiBPbiBXZWQsIDI3IE1hciAyMDI0IGF0IDE4OjQxLCBQ
ZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4g
RnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBGb3IgT0ZfVVBTVFJF
QU0gc3VwcG9ydCwgdGhlIFUtQm9vdCBoZWFkZXJzIHVuZGVyIGR0LWJpbmRpbmdzLyBtYXliZQ0K
PiA+IGRpZmZlcmVudCB3aXRoIE9GX1VQU1RSRUFNIGhlYWRlcnMuIFNvIGxldCBPRl9VUFNUUkVB
TSBoZWFkZXJzIGJlDQo+ID4gaW5jbHVkZWQgZmlyc3Qgd2hlbiBtaWdyYXRpbmcgdG8gT0ZfVVBT
VFJFQU0uDQo+IA0KPiBObywgcGxlYXNlIGRvbid0IGRvIHRoYXQuIFRoZSBjdXJyZW50IGluY2x1
ZGUgb3JkZXIgZ2l2ZXMgcHJlZmVyZW5jZSB0byB0aGUgVS0NCj4gQm9vdCBoZWFkZXJzIHVuZGVy
IGR0LWJpbmRpbmdzLyBzdWNoIHRoYXQgd2UgZG9uJ3QgYnJlYWsgcGxhdGZvcm1zIHdoaWNoDQo+
IGhhdmVuJ3QgY29udmVydGVkIHRvIE9GX1VQU1RSRUFNLg0KPiANCj4gU28gd2hpbGUgbWlncmF0
aW5nIHRvIE9GX1VQU1RSRUFNLCB5b3Ugc2hvdWxkIGp1c3QgZHJvcCByZWR1bmRhbnQNCj4gaGVh
ZGVycyB1bmRlciBkdC1iaW5kaW5ncy8gaW5zdGVhZC4NCg0KQnV0IHdoaWxlIGluIHRoZSBtaWRk
bGUgdGhhdCBzb21lIGJvYXJkcyB1c2luZyBPRl9VUFNUUkVBTSwgc29tZSBub3QsDQp3ZSBjb3Vs
ZCBub3QgZHJvcCB0aGF0Lg0KDQpJIGNvdWxkIHN5bmMgdGhlIGR0LWJpbmRpbmdzIGhlYWRlciBm
aXJzdCB0byBhdm9pZCBicmVhayBhbnl3YXkuDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiAt
U3VtaXQNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPiAtLS0NCj4gPiAgTWFrZWZpbGUgfCA2ICsrKy0tLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL01ha2VmaWxlIGIvTWFrZWZpbGUNCj4gPiBpbmRleCBiODA5MjQyNDFlYy4uYjljMmQ4OTZj
MmUgMTAwNjQ0DQo+ID4gLS0tIGEvTWFrZWZpbGUNCj4gPiArKysgYi9NYWtlZmlsZQ0KPiA+IEBA
IC04MjcsNiArODI3LDcgQEAgS0JVSUxEX0hPU1RDRkxBR1MgKz0gJChpZg0KPiA+ICQoQ09ORklH
X1RPT0xTX0RFQlVHKSwtZykgICMgVXNlIFVCT09USU5DTFVERSB3aGVuIHlvdSBtdXN0DQo+IHJl
ZmVyZW5jZSB0aGUgaW5jbHVkZS8gZGlyZWN0b3J5Lg0KPiA+ICAjIE5lZWRlZCB0byBiZSBjb21w
YXRpYmxlIHdpdGggdGhlIE89IG9wdGlvbg0KPiA+ICBVQk9PVElOQ0xVREUgICAgOj0gXA0KPiA+
ICsgICAgICAgLUkkKHNyY3RyZWUpL2R0cy91cHN0cmVhbS9pbmNsdWRlIFwNCj4gPiAgICAgICAg
IC1JaW5jbHVkZSBcDQo+ID4gICAgICAgICAkKGlmICQoS0JVSUxEX1NSQyksIC1JJChzcmN0cmVl
KS9pbmNsdWRlKSBcDQo+ID4gICAgICAgICAkKGlmICQoQ09ORklHXyQoU1BMXylTWVNfVEhVTUJf
QlVJTEQpLCBcDQo+ID4gQEAgLTgzNSw4ICs4MzYsNyBAQCBVQk9PVElOQ0xVREUgICAgOj0gXA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLUkkKHNyY3RyZWUpL2FyY2gvYXJt
L3RodW1iMS9pbmNsdWRlKSwgXA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC1JJChzcmN0
cmVlKS9hcmNoL2FybS90aHVtYjEvaW5jbHVkZSkpIFwNCj4gPiAgICAgICAgIC1JJChzcmN0cmVl
KS9hcmNoLyQoQVJDSCkvaW5jbHVkZSBcDQo+ID4gLSAgICAgICAtaW5jbHVkZSAkKHNyY3RyZWUp
L2luY2x1ZGUvbGludXgva2NvbmZpZy5oIFwNCj4gPiAtICAgICAgIC1JJChzcmN0cmVlKS9kdHMv
dXBzdHJlYW0vaW5jbHVkZQ0KPiA+ICsgICAgICAgLWluY2x1ZGUgJChzcmN0cmVlKS9pbmNsdWRl
L2xpbnV4L2tjb25maWcuaA0KPiA+DQo+ID4gIE5PU1RESU5DX0ZMQUdTICs9IC1ub3N0ZGluYyAt
aXN5c3RlbSAkKHNoZWxsICQoQ0MpDQo+ID4gLXByaW50LWZpbGUtbmFtZT1pbmNsdWRlKQ0KPiA+
DQo+ID4gQEAgLTkwNyw3ICs5MDcsNyBAQCBpZmVxICgkKENPTkZJR19VU0VfUFJJVkFURV9MSUJH
Q0MpLHkpDQo+ID4gUExBVEZPUk1fTElCR0NDID0gYXJjaC8kKEFSQ0gpL2xpYi9saWIuYSAgZWxz
ZSAgaWZuZGVmDQo+ID4gQ09ORklHX0NDX0lTX0NMQU5HIC1QTEFURk9STV9MSUJHQ0MgOj0gLUwg
JChzaGVsbCBkaXJuYW1lIGAkKENDKQ0KPiA+ICQoY19mbGFncykgLXByaW50LWxpYmdjYy1maWxl
LW5hbWVgKSAtbGdjYw0KPiA+ICtQTEFURk9STV9MSUJHQ0MgOj0gLUwgJChzaGVsbCBkaXJuYW1l
IGAkKENDKSAkKGNfZmxhZ3MpDQo+ID4gKy1wcmludC1saWJnY2MtZmlsZS1uYW1lYCkNCj4gPiAg
ZW5kaWYNCj4gPiAgZW5kaWYNCj4gPiAgUExBVEZPUk1fTElCUyArPSAkKFBMQVRGT1JNX0xJQkdD
QykNCj4gPg0KPiA+IC0tDQo+ID4gMi4zNS4zDQo+ID4NCg==
