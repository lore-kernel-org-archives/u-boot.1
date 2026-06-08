Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A31FCD8C8E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 06:58:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C06983FEC;
	Mon,  8 Jun 2026 08:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="rZbQkyJd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99F708405A; Mon,  8 Jun 2026 08:58:17 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35D6807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 08:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kU6z6Dtzyd2uvHvmz3twiIPHPPwRaUHdsBClxpVqVyUtAmGDidkPVKNzrTJ3yIPDab09PDtAZVzh88O1IjYoZNsZABCrZTCY5GI7vbr+gxDhu0ldl7Q6XGGSG6RWKV4TpfuPBqTxah4ou3nxLLSiHeJn/X/23Xc+7eLYH7DU3Hbvf5AL2+iY3+j7b+CBhRdii92V9IMEUlm1J0BpZ3iuLdouNaCGqbyKJzXXu8uIiJZYzEvL5rLvRk+SqpM0+7jvTQuZ9IbtBd2LWg7xQ3AJRuphiGt6/8WTjYbyf3xtsH2/DvD34VWW3Ye7oYLIN7+MuUPeByga8gvL+j2C2N+roA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3UIOaMOFk234DnVP7QkkQ+ECFy6FvUUDnGuGf9X52Xo=;
 b=eCDmjsatw8l2tzy30IdtIOF/lzrTHafOxETevkMsQv8gIEUA9SpiEMiW0Tkb4+mb7J7l8UdZn8TMf1ECXBTQspZfdItmH4JP2yfsMrLSRz3SmfvR622b0TGrMCfVH/XgUhXcbaT4UuZOWwC9g8CxLjD402WFyb1Keu8Ivt1sIwjMPL3GmN0pRWg2hnVfXTe8CJ6f7Ia24YmgoZgmCbfpJa6/C+vXFA/hYOzQsy6sCZIaUCc/CvUPt3uOFTEmOZ7aBEUhZUNoQct6pS++lcpRzD4JPzLNk6mUyiCq9CE7T9UUkFZL7GQESIwo8aIN8seCNi3cXpCwSL1/Y87IhjG+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UIOaMOFk234DnVP7QkkQ+ECFy6FvUUDnGuGf9X52Xo=;
 b=rZbQkyJdD/oV3QNy3VkTNZ0JlaS++TCd2CRtbGAPd7SjSWjQwcQB6Rno0oBo3PpyZEITo/VaS5WKM0W6irihXhIqCbY3xf382FnbnLYtgHsgBlUyMa/v5N59kSZBDvA5wcXyy0Kvaxk3JWBhUe8QZO8ZgzQRK0bEwAJZUQRm74D8AkwqYeiKI3Q3v8MjvE4oWf0WKuBqsMBLJCsVa687lhH06oUNsz/YPPDMi1l8zcRfwL1OXhbbK4WIdjT5SeeH84stkbvV0Jjzkt5o41fwdx+trqI414HK3iSsSXPjvcmfKgWJBPdYbngf+J/k+fO0TgMcMc/YGlT55/8ENy3OGQ==
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com (2603:10a6:20b:428::10)
 by PAXPR04MB9219.eurprd04.prod.outlook.com (2603:10a6:102:222::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 8 Jun 2026
 06:58:12 +0000
Received: from AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5]) by AS8PR04MB8721.eurprd04.prod.outlook.com
 ([fe80::ca16:532c:71dd:39a5%6]) with mapi id 15.21.0092.011; Mon, 8 Jun 2026
 06:58:11 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>, "Alice Guo (OSS)"
 <alice.guo@oss.nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Jerome Forissier <jerome.forissier@arm.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMy8zXSBuZXQ6IGZzbF9lbmV0YzogQWRkIFNH?=
 =?utf-8?Q?MII_support_for_i.MX95?=
Thread-Topic: [PATCH v1 3/3] net: fsl_enetc: Add SGMII support for i.MX95
Thread-Index: AQHc9xQr9PJj+TAol0GStOhhd/DxHg==
Date: Mon, 8 Jun 2026 06:58:11 +0000
Message-ID: <AS8PR04MB8721009281873A84A411AC9BE21C2@AS8PR04MB8721.eurprd04.prod.outlook.com>
References: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
 <20260603-sgmii-v1-3-c4a0af0d5d3d@nxp.com>
 <4a12deb6-b10f-4bb3-a6ab-6a4c508dc2a9@nabladev.com>
In-Reply-To: <4a12deb6-b10f-4bb3-a6ab-6a4c508dc2a9@nabladev.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8721:EE_|PAXPR04MB9219:EE_
x-ms-office365-filtering-correlation-id: 3337093f-ae18-40b6-aa5e-08dec52b4dbd
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|5023799004|11063799006|4143699003|56012099006|6133799003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: EfOQ04Mvo2Pml+vCDTIH3pq7Pr+uj7qbcQodxdm5rz63bWO2P/vdhxLOWFwZMM9w8RswVJSZbxTU/UviP8XQdNdemJM/WfY9SGhWnvjc1mhDFwTYx9NiNN4HLKeqkZh78Ni6IuK2/IaEcAb3s7FXIXyUakuLgw4vUqJvhn014R0bw/IhSc/RcFZ/loiKEDS8gAjVbXRKOESSNRvT9toMGZkaH5ed+T6zYv3LRrufdAXWdAE06D1pka/zdgjJoRIahPk50H3VwBXoTZ458P3t42T3Zyjxohq8aqeQeK1RWWCzSYnU9QQJrjs7rn7dmfHl+Aq3wDFrDcPXpweSidx3IscZA9nIgQv12TUMyPc9qx6zyO5bMECG3ZtY9IU/n4VIW4WsgBcm/vPSQnMVL7UpkXNYajwUHtNgbiPwA9Ez4dtjzkoeE9Q6POyALcIxROOYKU+NqLTZJNYsYLyMEjdsNCHYjdXOaFFQP9HyPgUZjqBxjZisEQa+Q0rON4iPjtJqwk68jh5zzB7dw8+5N+3vgwNkPiaxRMiEBLmbVn7IZxyikSzqDj+0Dl8yQFwAuA2IfSbdgdNe5AB49z7fUOLEFd9vku1fa6KTzj3SqsJ5+rgwmOggNUwtTFfDYoYcgv8PbuAIeyi33OAVuulA+wGxjauGwve7TZARt06ENdMU5M6yOniw8LOAMh0rGV4+MQRvD2Seb0Zq0O8IQIlU39INgjJA5mvzj4jJPxEEOu+jitOpx9b2adLAPCmqLIGb140i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:AS8PR04MB8721.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(38070700021)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?alpOU1YxemxYSnc4M2JBMUp3dTZwR1FEbXYzRnRqN3BvcFEzdGVGWitvb1FY?=
 =?utf-8?B?aWZuRm1KOVBJWURyV2l1c3RCK204VVN5WTEyWDhWcnoxKys0NjNEeHJONmhh?=
 =?utf-8?B?dTM1YmR3eWFUNnA4M2xmWnh6cmVTbzdNSWRGZTVIMzY2aFNrZllvWS9TczFx?=
 =?utf-8?B?QVFHN2JOVGFrQ0NHcktTaXpQNnBjaG0zNTdWL1l6UkxRZ0lQMmxrcGxwUHVL?=
 =?utf-8?B?UEVwSnFEK1Ayd05pbWNPak9CRWFDZmc4VDRMbEw3SUdsYzZLcWZEanNOMC9G?=
 =?utf-8?B?bFh6blZEdTVJaEN4UmFEcENDNWFqNkdhL1UySnNiMGw5MzJHUFp0WUlpc2E1?=
 =?utf-8?B?TndUNUFCWm9DVFpLVTBYU0lvTW9WaFpKZFFlazVPd2l0TGdtcm5pSmE0ZDBF?=
 =?utf-8?B?WHpkOFhESDBtWi9JMzVxMThKVkVBQW5vdGV0bWF5TGpnSUc1MnBybWsvRGxo?=
 =?utf-8?B?TEZJM0dGMEpmdkFlelNVeXhxb3hOT2luNGE4Tk1CMHA2RlgvR0RoNEUyZEhF?=
 =?utf-8?B?RDBMa2VMWmFlQ0hwekF1Sk1HeTdlMTAxRnpUQnNPa2E0OTVaUUtJeXNOTW92?=
 =?utf-8?B?NDBHN1dVRlp1ekJ4UG15MG1rdG80c1FidG1RbWIyUFhLei9HajFPUTJCZUhm?=
 =?utf-8?B?UXdrMVB1YnBZemg0cDNZQWNqVzBRbkJRR1hVK1ByUmM5bkNXMnZobmJEVjl5?=
 =?utf-8?B?Z1RUK0ZzdFA3QlpWdjVDZHRBcUh6d1BMNElOODh4Q3lFRSs2MWZ3QW1mQVhM?=
 =?utf-8?B?UEN0cE5rQmN5R29QVUR3UGsvZDFBZmE5aTJnSDArNk5rT1B5aDZnUkFBTkNN?=
 =?utf-8?B?aDEzN3ZaZnBlbnBMYVVMeW52aUZ5RXo0N2lFRXU3Q2pydnZzc3pmaHpmZUwr?=
 =?utf-8?B?eVkrbWNsOTl2cUNmOC9EOG5hNHY1Wm9SbjNrdFhWdUhtektKejBkUGZPSjRr?=
 =?utf-8?B?SjhGbXdSME80RnRpV2tiOE11Um02REpNMHJUczNCM2dKS2JuTmVCdXM0M0cz?=
 =?utf-8?B?RHI1WDltSUloUktuUlR6RGNZc1RWQ1cxcVIrWlVvMy9lcmNKL3pxZHl1Z1Rv?=
 =?utf-8?B?b1ZKUWQ3RVZZcHJ3M3NicEczdGtJcFlnenI2SVcwclpmeU5Bc3IzcWw1WmUz?=
 =?utf-8?B?OFVOVXVBeDM2UDdYUVFpcHRiWWlaQ28rekdsendoaHBuWUF0QWpNRyttTnM2?=
 =?utf-8?B?WXRwRWFkUkxoVzlkMDN3OHZaOVpFQTJQcGs4NXlKTGx1dnZQb3VsYTlwNHlo?=
 =?utf-8?B?dkxsNmxZUzFQNDJnVkNDSVdOZzl2L015RlZRWmN4ZWZ2cm5VV3pMUXRIYVEr?=
 =?utf-8?B?MmFVcTdMR3JkQ2h5V1p2UFkrQVkrK3FEdGF5TE0vV2RLUDg2YXpJbzFBb01P?=
 =?utf-8?B?ZEhlYml2dEtNTkJjSERrbzd4c2dMOERucDlaZTVVV3hvYmp0QS93U2xHOFpK?=
 =?utf-8?B?d1hVNnMwR2FJRXdkT0FtVkxoaFRUS3FMUGFzNUppeVFSUGFOTjBVRjQ4VkJy?=
 =?utf-8?B?dU00aXpOZkJ5WElhZzlVcU1YVzB2RFRGazRYR2ljSUVsTmZGK08vdGVmQVN1?=
 =?utf-8?B?VTBXdEQ5RHZQWXRvTzYxb0J1U0I5RnYwMzljODJqUy95a1BITVVZNkE0SC9r?=
 =?utf-8?B?RjhCbzhwcE9qYnB6RHZNak9iOThsSFZGalN3Q29MQTlqd1hRZ2JjcGJwSDRL?=
 =?utf-8?B?TzQ0Tm9tcVdzcmpaYjZoUk5Wb3ZGKzk3SkphZGFIWld5ekhzSEpTWWFZeEFo?=
 =?utf-8?B?dTZtNWpJN201OHl5NTFnYjl6TU5tUW8zclJzdzhSVmh5ZS9GcHY5S3JXSTNH?=
 =?utf-8?B?VElnSUswNkh6VHEvTEZNMk5QTEhESTE2Vk9URS9NS1FQWms0SWErUDE1WHlC?=
 =?utf-8?B?djJKSTNzeGVKREFqNjVWNFBwckIyZmIxRklEMkk3dlRMdFdZQnFKZ3crOGxp?=
 =?utf-8?B?bEhPdmxGTlZ2dk52aXBPUEhKaEoxelhZZWxkOEpQSEw5THAyT3NNd0lFWnNl?=
 =?utf-8?B?Q1hQdWwxQlp4czZqai90TFQyVVk5ajUzc0lualVqNW96Z0EwckhJcEJhWGF1?=
 =?utf-8?B?ZFVUbzdXdFU5NDdCQkZ6Z09lTlEwOS80WnB0Z0h1ZnJIMmkrUzRiaGp3QnZS?=
 =?utf-8?B?Z24wUUlLWlhUOHYvdlJvNDhhZFcvaGdVSTRPV1NXcW9ZMC81N1hxL3c0cUcr?=
 =?utf-8?B?RG5qb1FUeHZ0WnlHS0tEaGNVV3FSVWJ3eWtYT1ljUkhsNG10VFV6cjA1cndh?=
 =?utf-8?B?MWpwOVJTaC9pTEJoNURKOW8raDJBVzNZUXB0Rk9GM3RhUG9jaVFqckZDcHZM?=
 =?utf-8?Q?0yHY16HzjwiMyYNK72?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8721.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3337093f-ae18-40b6-aa5e-08dec52b4dbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2026 06:58:11.1640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eo5RQDpQfVl/siN48iASXN7CzpRXy/nQaFKapsp1KhHMiZwB/diYKj3BpJH75NOZ6pfNGDH0Ok7JxOrjJZXiWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9219
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

PiAtLS0tLemCruS7tuWOn+S7ti0tLS0tDQo+IOWPkeS7tuS6ujogTWFyZWsgVmFzdXQgPG1hcmV4
QG5hYmxhZGV2LmNvbT4NCj4g5Y+R6YCB5pe26Ze0OiAyMDI25bm0NuaciDTml6UgMTE6MzUNCj4g
5pS25Lu25Lq6OiBBbGljZSBHdW8gKE9TUykgPGFsaWNlLmd1b0Bvc3MubnhwLmNvbT47IHUtYm9v
dEBsaXN0cy5kZW54LmRlDQo+IOaKhOmAgTogSmVyb21lIEZvcmlzc2llciA8amVyb21lLmZvcmlz
c2llckBhcm0uY29tPjsgVG9tIFJpbmkNCj4gPHRyaW5pQGtvbnN1bGtvLmNvbT47IFllIExpIDx5
ZS5saUBueHAuY29tPjsgQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4g5Li76aKYOiBS
ZTogW1BBVENIIHYxIDMvM10gbmV0OiBmc2xfZW5ldGM6IEFkZCBTR01JSSBzdXBwb3J0IGZvciBp
Lk1YOTUNCj4gDQo+IE9uIDYvMy8yNiAxMjo1MSBQTSwgYWxpY2UuZ3VvQG9zcy5ueHAuY29tIHdy
b3RlOg0KPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4NCj4gPiBB
ZGQgU0dNSUkgaW50ZXJmYWNlIG1vZGUgY29uZmlndXJhdGlvbiBmb3IgaS5NWDk1IHBsYXRmb3Jt
IGluIEVORVRDDQo+ID4gZHJpdmVyLg0KPiBXaGljaCBQSFkgZGlkIHlvdSB1c2UgZm9yIHRoZSB0
ZXN0cyBoZXJlID8NCj4gDQo+IEhhdmUgeW91IGFsc28gdGVzdGVkIHRoaXMgd2l0aCBhIDEwMC9G
dWxsIG9ubHkgKG5vdCAxMDAwL0Z1bGwpIGNhcGFibGUgc3dpdGNoIC0tDQo+IGRvZXMgdGhpcyB3
b3JrIGluIDEwMC9GdWxsIG5vZGUgb3IgZG9lcyB0aGlzIHdvcmsgb25seSBpbiAxMDAwL0Z1bGwg
bW9kZSA/DQoNCkhpIE1hcmVrLA0KDQpJIHRlc3RlZCB0aGlzIHVzaW5nIHRoZSBBcXVhbnRpYSBB
UVIxMTNDIFBIWS4gVGhlIGludGVyZmFjZSB3b3JrcyBjb3JyZWN0bHkgaW4gMTAwMC9mdWxsIG1v
ZGUsIGJ1dCBpdCBkb2VzIG5vdCBzdXBwb3J0IDEwMC9mdWxsIG1vZGUuDQoNCkJlc3QgcmVnYXJk
cywNCkFsaWNlIEd1bw0KDQo=
