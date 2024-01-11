Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E34C4707B
	for <u-boot@archiver.kernel.org>; Thu, 11 Jan 2024 04:09:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD0648792C;
	Thu, 11 Jan 2024 05:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="lMFQQ1yM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F7E8794F; Thu, 11 Jan 2024 05:09:33 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::620])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B708786C
 for <u-boot@lists.denx.de>; Thu, 11 Jan 2024 05:09:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APkbchwccyOkUgbVuhd/qqnXMEI103/YY90sqNfuXVUSbD7QkhDfy6HAtF+uZyndnb71qHVCd7vaXEC0KvW6bTnFoXkTX1Fr6gKzsan8PbJwbE/YQEqPOaT/6HqBfRvi5OaQtoTChkRpB+Bv5KScS+sUuCnYl9Wmx7DW2BZ2FAEDOnIQFXqSuyVvpbCvgtU71ga42YMWWmLnHpO6lIrtlAsVG1dEeO4Q3CiN8teabG+HbrxQXe/F2lihbL6X5aSTdd7Lcf/ef3vej6FhqtlzJcxIDcB5G6OtoWgXKCNPnm2O1iYsYx5sNL+3zimHz1qsAVyzDPkXNqdq99JEGYJghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWMvvQ5LvfjHxT2llZJXco3diZYltVoTvmIcGlkd5cY=;
 b=QvzwtG6m2Gmf/UZTQVN6V2Ca0L3yEebEC1d0UkFL6MYuUgwpkG9+8iNS9jH1EWxmmzuhdznu/03ELqyiinDBSuBf7NaVhliordWpLQlj6y8moRFcod5bbSUGwA6o3nsuPvQl9nP71Bzo9Ecr/hAUMYpIQnxbftxy4PQxiKZiMupVB5Xd797lHkmMBkd3kVX4EEbM8dZw7UweVXHNRlxvMPaDsw0KmZs9S8kHMD+7fGPwkYLbMQJpLFmqPMw89cxx1/wFi/rO4M69DSN0DRXG9V/36R0gBJhITdMti4/uayWNaVRAj/QyTJUzbYecUNgMyUVF/MDru+ReDCqxrpRJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWMvvQ5LvfjHxT2llZJXco3diZYltVoTvmIcGlkd5cY=;
 b=lMFQQ1yMsIy3np1qw74v1zSnizJk8d/TuJ5XduwJiXRRHdF11RzxaSvdY7x80WY2zw+5q7oS2h8RZmup7JRRlpXZShMIvAtQzLNj35ChH4yqb2KM3+1gJH1savfBZqG6bNKhbRgLkBW+2xcsPJrbEE3ncluL7CIes0iU4NuQ1UE=
Received: from AM6PR04MB5302.eurprd04.prod.outlook.com (2603:10a6:20b:7::20)
 by DBBPR04MB7900.eurprd04.prod.outlook.com (2603:10a6:10:1e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 04:09:29 +0000
Received: from AM6PR04MB5302.eurprd04.prod.outlook.com
 ([fe80::d91e:b436:3bf2:14c8]) by AM6PR04MB5302.eurprd04.prod.outlook.com
 ([fe80::d91e:b436:3bf2:14c8%5]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 04:09:29 +0000
From: Ye Li <ye.li@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, =?utf-8?B?VGhvbWFzIFNjaMOkZmVy?=
 <thomas.schaefer@kontron.com>, "'u-boot@lists.denx.de'"
 <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>
Subject: RE: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Topic: FIELD_RETURN on i.MX8MNANOLPD4 EVK
Thread-Index: AQHaREF0N2unmKFe7Ua4zeP9gnUWrbDT/hMw
Date: Thu, 11 Jan 2024 04:09:29 +0000
Message-ID: <AM6PR04MB5302071D0CD6F54193CBB8EFE4682@AM6PR04MB5302.eurprd04.prod.outlook.com>
References: <GV2PR10MB6453B5A6CA444FD371798D65F76A2@GV2PR10MB6453.EURPRD10.PROD.OUTLOOK.COM>
 <1dd93112-b593-6d8a-ce56-1ffe7ebdf0db@oss.nxp.com>
In-Reply-To: <1dd93112-b593-6d8a-ce56-1ffe7ebdf0db@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5302:EE_|DBBPR04MB7900:EE_
x-ms-office365-filtering-correlation-id: 58126e25-2aff-4b63-256d-08dc125b1b85
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiE+duJI1PxUlftx4roy5KYtfOJzwR3dp1jW+5hv6ezzdxfmLjP5QxGdv3NS0tCsWDfd96YAbOvFmFxnwNa5lEeO7ZPsB75TjuHcDX3xIRlFWmDEZhLgLMlWHIA+mhlNtOZexC80RsHM9oTysKIW5xMntB1fCQtx4GRQ4ZfLOUWVOu/HAXZvgqImpGRu1aNEUr+yh+9pnwc6jx5G5C3wwKT2wjdnOYVyYobe1JlffAeltcYDiUoWlmAhuomKfGp8xp8ObH+EpoPz5c8djW2ba//fendC85WqvAO5NR4tPW6n9VPz3nfst+2WLhUsjN5mOSY2g/PPpebzXV0IGACYezbR+s1pqsKsqsrmnqjWrS0oJGG6mG5dLe03XzBYyecNilspXuo/XMMtUUY6uG+g0v2seUEzyDgG06NqW8B3hNQXf9WETYyUalLXmkjL6q9qXDiY5fhCemAia1TupdwxN/QzQcqLoF/inqJkfOm5VmIOa6fvI+QNRx48hm3OY+49niwHM349DZqHtnHfEeBXKbdb4DjomFlkPzD+TDoecP3s1YWQ4La++FaoX1wtWasfIP1pA1fUiq+vjqGPkxoTz38CJgqUv/q+e4IYlMTstCC6yAOyh3PCU5Z5cSX4vG+m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5302.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(5660300002)(44832011)(86362001)(26005)(15974865002)(7696005)(33656002)(38070700009)(53546011)(83380400001)(9686003)(6506007)(66574015)(122000001)(71200400001)(38100700002)(8936002)(8676002)(4326008)(478600001)(316002)(41300700001)(52536014)(110136005)(66556008)(66446008)(66946007)(76116006)(55016003)(64756008)(66476007)(491001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWE1U2U0SkxONDVlb1pWdnQ2U2ppRjJxNG8rcGtTZTArV1Vnc2JmRDduVG0y?=
 =?utf-8?B?ejczcnZDdUt6K3ZZRCswNUhEcTV1S3d3ZHV0TCs2UHY2OGtCNXRabGRiQ2tj?=
 =?utf-8?B?SnpEVDZxWFA4dmlWZE5jYzBDT3p5NUtxdm5DSXBSUHBPSFVOL0p6MVZFM3R0?=
 =?utf-8?B?d25DQjBDR0dNVndTNUxJZGVLVU0vazQ0cUNjSFJTdVdqUGVPaFRLUGFmdWJ2?=
 =?utf-8?B?bm5BL21iay9NS3J6TXNpS2tXZEgyRmV0MnZwZFJwcC8xcW16WmZuTWVoSnRu?=
 =?utf-8?B?MDZMQXlTWjF0VmwxRkFndFhjeDVQa2lSTE4zNHRleTJwMDBFaXU3cEFqaUZG?=
 =?utf-8?B?L3NxeDI3RlVGMnJrQkFRUG5acnEreSs2dEp2L0FBbjgxWUtKbTZGQ3hwTFdR?=
 =?utf-8?B?d2k5WUdqcUhwVEUyMWxFUFFBaGNHbFZQRFF5UmdNaGVxMFh1ZzhJc3Q0T01n?=
 =?utf-8?B?ZWQ0SUtpbDJpYjNaMHd3ZHliclRCZGlxUS96NmUvcTNhUm9VUDhnSHIwV2FD?=
 =?utf-8?B?WUlhRTFGekdicE92Ynl3amY0OWx0T2x5L0xJQWlZVFpqTDkrU0xrNHNvQ1Yv?=
 =?utf-8?B?OFljNlJoK1g3dUFDdUdjOE5vOG1URUtaeEpod2R4d045bDZZeXBTdG9mR3FT?=
 =?utf-8?B?WHNJOFJubEJGdzIzNEZLeFpnZUZuZDFIbHhOd0Frc1Z6ak5oY3pTUVJnSTV5?=
 =?utf-8?B?Qlc1K2J1UWkrUUFKbTdvTVp6dk5wbHhLclhyV0RTcWdKQ0hWQTZuWnRKKzQ3?=
 =?utf-8?B?ZG1FUHBBTVJXN2dGOUVMRnNLalVlaStMSkJUY0NjV2RGbkFxdnR4Y2F2VWh2?=
 =?utf-8?B?WnJTNGswbGxsOXYxeWp1eEt4czg0a2pSWmdUaGYyM3FGazVMem51SUh3S0pR?=
 =?utf-8?B?OU5DaUFwa1RISi9tUkh1WSt5QW1oTExjcHozUDA5V0JZYW1NcmxBY0Q4Qk15?=
 =?utf-8?B?dVRWYkp5Z3lBWGVwOFJGUVNnU0FSRElWcXdkazF3NjQ0STE2OHZuQm5JNG9Q?=
 =?utf-8?B?akkrcGlkZVFxcCtrK2tRd0NJY3NGNk1aME5Janl2OXZQT1ZzN1ZkVS8ydlpz?=
 =?utf-8?B?YXhIbkdiTXZHeGJQSzRMdnJwVTdkWWN3VjdYQXI1eCs0V1VRZjdhc20vd05U?=
 =?utf-8?B?SGtRR2dVK3BGd3NBMDVTN0JBVkRIdzRjcldicVFkeWY0dElreUZ5K2dwTUNP?=
 =?utf-8?B?bExCWDBOUUlpNWhldDdqZ29FRVpldmJkQ25TeWRSZCtXeU1oTTUvcWdmbGE0?=
 =?utf-8?B?YUFXVVFRUEU1clVZdHlLVmIvVHJQRTc2b0w4Rzh1czdHNFlibDc0MVhoNGUr?=
 =?utf-8?B?bVNIbzFUdjRIaXdzMlVValFxN3dSZllMSXhUN2MxZFhjNTJhY0xRWnFNMGtm?=
 =?utf-8?B?UGdmNFJwQUhxMVYxTWpYZFMvMk5LekM1RUZyakptMFd6eXY4d1VXT1EyZ0t0?=
 =?utf-8?B?aG5TSmxTd01zMXN5YkdheTRvS3NCODh6cEsza3B0MW16WkpFZFJ1cXlWZVV1?=
 =?utf-8?B?M2xQL0o2dHYzUXV3RFpES3JPVWloeG0yL1dFVWJ5NW5UUWFxTkJMcnBHb09z?=
 =?utf-8?B?QllyOUxrMHY4Y0JWeTVvcHp1NGFNaE5ncTdlaGdxSTJsYnU3bG4wc05wR2du?=
 =?utf-8?B?TGNocEU5eDRuMVVobkRQaGlvcWh2RUJ2dXd5WlJqL2Z3SC9hNEhXOVNOMW1t?=
 =?utf-8?B?cFpZNUdHeHRXUkwvS1N4ckZteHd5QzFLa0MwY3pNcTBvbktDVDVKMGViUDdQ?=
 =?utf-8?B?VHNBKzl5cjhkSHBLNnRsakZ5SElmSHZ6RXpkdUN1NXFoOWl4OEhMQUdYNUla?=
 =?utf-8?B?SE5semcyRVJQeUQ0c3pqWVdBVHZ0ZnRtUjRXWDZIVHRBS09rWXRsWUorUlMr?=
 =?utf-8?B?bUc3RHJJZDN3Y2JjN0hIdno4dHk2MkdIYUpYdHpQTTBZeUs0N3dzNldQcjh2?=
 =?utf-8?B?VklXWWxtNHBDNnZ5ZHFRY3I1NS9ZeERTTG9TdmRMSkZCM3BEdVQ5TURxSHNT?=
 =?utf-8?B?ZE1PQlluejRPNHd4R3U5YlQ3ZURobnc3cm5hNm16VmJSS3RhcXJpNlA2bTEx?=
 =?utf-8?B?WldBeUJ3NnFBVk9YaER6NmRjdjdvNG1hL25NaXY4SXdPUlJtSVFlUmF2SXpp?=
 =?utf-8?Q?1D1Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5302.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58126e25-2aff-4b63-256d-08dc125b1b85
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 04:09:29.2267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dxAzwYXI6TByhDL4phc2PvQEmmzWenULqQexaTajVAPn/d5EXoR9chyW6gFvFBV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7900
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

SSB0aGluayB0aGVyZSBpcyBubyBwYXJ0aWN1bGFyIFNXIHN1cHBvcnQgbmVlZGVkIGZvciBGSUVM
RF9SRVRVUk4gb24gOE1OLiANCkZyb20gd2hhdCB5b3UgZGVzY3JpYmVkLCB5b3UgaGF2ZSBtb3Zl
ZCB0aGUgcGFydCBmcm9tIGNsb3NlZCB0byBGSUVMRF9SRVRVUk4uIFNvIGFyZSB5b3UgDQphYmxl
IHRvIGJvb3QgaW50byBTUEwgd2l0aG91dCBzaWduYXR1cmU/IA0KDQpCZXN0IHJlZ2FyZHMsDQpZ
ZSBMaQ0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiAoT1NT
KSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDExLCAy
MDI0IDExOjUxIEFNDQo+IFRvOiBUaG9tYXMgU2Now6RmZXIgPHRob21hcy5zY2hhZWZlckBrb250
cm9uLmNvbT47ICd1LWJvb3RAbGlzdHMuZGVueC5kZScNCj4gPHUtYm9vdEBsaXN0cy5kZW54LmRl
PjsgWWUgTGkgPHllLmxpQG54cC5jb20+DQo+IENjOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNv
bT4NCj4gU3ViamVjdDogUmU6IEZJRUxEX1JFVFVSTiBvbiBpLk1YOE1OQU5PTFBENCBFVksNCj4g
DQo+ICtZZQ0KPiANCj4g5ZyoIDEvOS8yMDI0IDQ6NTIgUE0sIFRob21hcyBTY2hhZWZlciDlhpnp
gZM6DQo+ID4gSGkgYWxsLA0KPiA+DQo+ID4gV2UgYXJlIHRyeWluZyB0byBlbmFibGUgRklFTEQg
UkVUVVJOIG9uIHRoZSBOWFAgaS5NWDhNTmFubyBMUEQ0IEVWSw0KPiBib2FyZC4NCj4gPg0KPiA+
IFdlIGVuYWJsZWQgU2VjdXJlIEJvb3QgaW4gdS1ib290IGluIHRoZSBmaXJzdCBzdGVwLiBBZnRl
ciBjaGVja2luZyBwcm9wZXINCj4gZXhlY3V0aW9uIG9mIGEgc2lnbmVkIGJvb3Rsb2FkZXIgaW1h
Z2Ugd2UgY2xvc2VkIHRoZSBib2FyZCBibG93aW5nIHRoZQ0KPiBTRUNfQ09ORklHIGZ1c2UuDQo+
ID4NCj4gPiBJbiB0aGUgbmV4dCBzdGVwIHdlIGNyZWF0ZWQgdGhlIGJvYXJkIHNwZWNpZmljIHNp
Z25hdHVyZSB3aXRoIFVJRCBvZiB0aGUgQ1BVDQo+IGluY2x1ZGVkIHRvIHJlbW92ZSB0aGUgRklF
TEQgUkVUVVJOIGxvY2suIEFmdGVyIHRoYXQgd2Ugd2VyZSBhYmxlIHRvIGJsb3cNCj4gdGhlIEZJ
RUxEX1JFVFVSTiBmdXNlIHdpdGggJ2Z1c2UgcHJvZyA4IDMgMHgxJyBjb21tYW5kLiBCdXQgbm93
LCB0aGUgYm9hcmQNCj4gY2Fubm90IGJvb3QgYW55IG1vcmUsIGl0IHdpbGwgaGFuZyBhZnRlciBl
eGVjdXRpb24gb2YgdGhlIFNQTCBib290bG9hZGVyIHBhcnQuDQo+ID4NCj4gPiBXZSBjYW4gb2Jz
ZXJ2ZSB0aGlzIGJlaGF2aW9yIHdpdGggYm90aCBzaWduZWQgYW5kIHVuc2lnbmVkIGJvb3Rsb2Fk
ZXINCj4gaW1hZ2VzLg0KPiA+DQo+ID4gSXMgdGhlIEZJRUxEX1JFVFVSTiBmZWF0dXJlIGZvciB0
aGUgaS5NWDhNTmFubyBzdXBwb3J0ZWQgd2l0aCB1LWJvb3QNCj4gdjIwMjQuMDE/DQo+ID4NCj4g
PiBCZXN0IHJlZ2FyZHMsDQo+ID4gVGhvbWFzDQo+ID4NCj4gPg0KPiA+IFRob21hcyBTY2jDpGZl
cg0KPiA+IFNXIERlc2lnbiBFbmdpbmVlcg0KPiA+DQo+ID4gdGhvbWFzLnNjaGFlZmVyQGtvbnRy
b24uY29tDQo+ID4gd3d3LmtvbnRyb24uY29tDQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPiBLb250
cm9uIEV1cm9wZSBHbWJIDQo+ID4gSGVpbnJpY2gtQmFydGgtU3RyYcOfZSAxLTFhIHwgNjYxMTUg
U2FhcmJyw7xja2VuIHwgR2VybWFueQ0K
