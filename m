Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC513C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 13:03:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218F288124;
	Thu, 28 Mar 2024 14:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OQpihdu+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE038815C; Thu, 28 Mar 2024 14:03:31 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11D7488124
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 14:03:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCM/XA0Ri1YOtmZfUPg3hWSVRQdRN+klBJUF9vkZMHnZ1akW/W+TWjHGs/YEqe5wOlbYlojBOMkefaHQ0shtJWRAvWLZJq/vLQLebfzL/EGrgLaeUYdvPFut8S3zJab8ZG9D2Vjl3WsiZoU7YsHO9EfNV1lDH9Gt5hPlrDgHjyjL5JksMPoxpZqFg/QAVpmkIs5iXWKELzrO/YOz6ipoHM6lEdeSg+8RMTi3MdoL15/4ixCegGjH5lhDAXQCGvxR4SHYdo8tYMOGR1TYWiJvK/X+7LD6Sp51NxkaJx6Vc7qpbQcwid3uQjwpHdJ2rKbvqcrL6ubfk6mp9ODnMIxERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YW6kvT7ByuiKNMRk5dLQLlW5soZm6wVtUOXMCnV+rM=;
 b=mQnvjpKv6R9WMRkgmMTSlc7UT//3Ssu3RscTs6jyh1jxvOB7AhhmdTcvH+V5r3mRo7NbSll5dGTL9MBJ253NnbXKAcGL4Pu5f+1Z0AB2I3UtZXNs05OviqaCoB6sOChDB7Oi48L3FRAu5vDnVuPNoJL6LWRn5SZ4K4pK882LwyHcBsFSMfTdKlNLrXUa/f7lWhJfZ2K8yFgNzRLWHoanLoCgCuqA2HHknVTxECoHoDSf/wG1PNhEVzLTPM1v7Ilp5KTts//b/oII3gQ8tBmnO0+/YvunNq0Q+JSXqQE5wO8vLXzvksD33JwJcVC2kD/msK7dkpTK4wUPUNt/C8Q9gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YW6kvT7ByuiKNMRk5dLQLlW5soZm6wVtUOXMCnV+rM=;
 b=OQpihdu+Hy+zJavnPjgwRkVbhvoZixmLg3o71gilJtO2m9JL9OXoD/AIhFgiu5rE/NqOKF1z9zLPI01aFcvjhJC/cVmecEqj74wnBRbu8JEt16dETr5/CQX6e2uHjEw24wMObRjmFjX8ogNyLgMA3MCxPFRa9NWZzldKBZ6sJCM=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB9061.eurprd04.prod.outlook.com (2603:10a6:20b:444::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 13:03:27 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 13:03:27 +0000
From: Josua Mayer <josua@solid-run.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "baruch@tkos.co.il" <baruch@tkos.co.il>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "cgmeiner@igalia.com" <cgmeiner@igalia.com>
Subject: Re: [PATCH] mx6cuboxi: Fix Ethernet after DT sync with Linux
Thread-Topic: [PATCH] mx6cuboxi: Fix Ethernet after DT sync with Linux
Thread-Index: AQHagQqDZm+rU8RW7UKPuP1WrY5GmLFNGzIAgAADXQA=
Date: Thu, 28 Mar 2024 13:03:26 +0000
Message-ID: <fd3c8cd8-ac4a-463b-9f55-def931af77f2@solid-run.com>
References: <20240328122116.2460855-1-festevam@gmail.com>
 <2fe4eeba-c805-4dbb-a07b-9eb9382c019c@solid-run.com>
In-Reply-To: <2fe4eeba-c805-4dbb-a07b-9eb9382c019c@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB9061:EE_
x-ms-office365-filtering-correlation-id: d25c4d37-84d5-4064-e49f-08dc4f27754d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +ivq3IyLbg7V9CD8vWc14YnvQOXl8ze5jzXFucBs6xwo8xGA6hw8O4FdafqX+esfL4cMFofZdIHvNR2wfGj8iEbMNFcc3eOqNmNeV6gMiYAQ6Xtoa6dfqGZFOj2PiwgSGzw0P/+7NRC/lwY5tkLlU9bvJ2eDg27D1/klCp5RUyIaZ1BWGjLkebpxm47ldSqoLBLtTyMUDSvNHz4KnjKhBMeOnRKUU8Eu4yQPRtu9mkMun8UPMEhu8Q9nPzj5HkG0ge2xrmX1Tit+ZhDx3vj5q1b0MQOqaxfOQ/2IMK8oWdEWRLkGJSQBms0cBGr/NOaN5O+yUtx3jiqrOTYwGP7JQ6TWXQO6KdHDmKmD+elOiDybWfVPyNgn81940OtoZhYS+7GgZ06FaaonlU2N1Lsc508CL8kz1AHgsCwUXNG2pBC4pMx9EbMjK31cy5DZaqDIJ6P2YEO5RA6zUTkbIYGsuJaZYmwkyfX4LNkO45bWtFdldIY2falUc4fIcT1L2K4WY4tozWSwU2dBcsqvjyjN2OmaqqhOnmGOEQJCUlGijYlhVzephIP6LzpaK4jzgIQO0FHR39bxdP4cvMnJBQTBT2critiTbxe4YlKOnjdEyTMi5UnWcbTjZIwgFcSTw7741hGiwdjymoqq5FTbXbhveuAuFTtRIlFkRS9ldUT5Efhah8MsCwk2iMDncL3/dW4iwSTIvgAN2JCe2IdI8hoY3q8ZQOUjm++r9MmQUeNcGs4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGpWVnQ0ZlVJQ3p3U2NlTUNLdFBlZC9Ud0FraWZaSE8raVNORkRRbWVlVUFL?=
 =?utf-8?B?L3pKV0ZoTUxTSU5MNEg1ZVdPM2VEOVpZKzZOVWVZWVVDbjlhZkFncjN2dTRG?=
 =?utf-8?B?YkcrTlBTNjdWU2puZmZETXVWVlR6NkNYUmZiZlh6eXFIUXNrN2twVVQzbWgv?=
 =?utf-8?B?S0ZRZ0VVUElnbHdKRitadW1LZis3UXcwOGtiUjdDWU1SUlFJRk1RaklIRDYv?=
 =?utf-8?B?S1V5MmsxN0RLYXBYTFFPa0xndWJTK2pmT2dOUThVS1VVRFI0cmNBaWc5WlFP?=
 =?utf-8?B?M3JmalB4L2xOTEdBeTdFcDZ0OFB5amV0ZW8vV1I5ZWVoa05PSExENzFXOUlX?=
 =?utf-8?B?d2xOODNOUTE4UjZ4dEFXMzBmZ3p1ZjJZazZBeVBuWTBRZWdqQkFObHhQZ0tG?=
 =?utf-8?B?VnQrYUhwd0xkZUF6ZmRyUUhWYjNDendDRlc4RUtsTTR1elYzcCtxNm1DaG5B?=
 =?utf-8?B?RDNFUWNuTUJXL0Qzb3pmYURYbGd2a3JJNUI1VHBlSFhXVDRsdW02ZXVLNmM1?=
 =?utf-8?B?cjJxSlhXZGNVYk1iL1h6dzN1Y1pCTlRoVXFoU1RBejNQblZESHhyTTU5dnZs?=
 =?utf-8?B?eU5pbE1tT1Rmckc2L09zbGpoeHRkd2pzbXV6UVdBLzdKZkxlRndtaXNnOUIz?=
 =?utf-8?B?dVJwcGhsZjBON1FiMEJCSU01d2kxQUVwOHZYbllCeWUrNHFoSEtsYVNNVzNN?=
 =?utf-8?B?YmZZQkZnWWZjaDNKZDR4a0ZlaDlSU0lERXN5Y2RkVGlKdVF1aHpYUExtMVZD?=
 =?utf-8?B?cGsrQzJOQk50a0NpVm10cXMyTWFISkRwbGgxalIwOFVmcmZCNVE0RktqZDIv?=
 =?utf-8?B?TTBjeUtlMHFicXVPRm9USTUzcW9BczVmUjlPNkRaVG1wLzFESDhWczA0cCti?=
 =?utf-8?B?NGhKa0ZJajVZMWJtOVUvQUJVZXEyZkhPVTRRU1RheWRhMGt6YXB4dEExckhv?=
 =?utf-8?B?MHhCN09aNWlkK3Uwb3l0ZjNJYWN1RnA1Syt2NVNiWU5xdlY2cGtTTFRPYVVi?=
 =?utf-8?B?TFBPWmh1V3hzL1daNFFNRXQ4OGtNUW9pK0NlMzY1Ti9MWGx6S0VKM3ZzMDBx?=
 =?utf-8?B?ZGpQTUtFckxDMElVZ1p4OVgzbFFsZG5mRWMxS3lpbXladzRrcTBMVnNnNEEz?=
 =?utf-8?B?ZFJzWTJrMGVXaGVXWG5seVNCeEJhdzhJVCs2Y25QSm55MzN0THpaUU5zVlov?=
 =?utf-8?B?TlpTNFROTmxxRHdrRUdzc3NhS1RZcThDanhCVUdkZnJRMVhpM2VRa2tNN21J?=
 =?utf-8?B?b0o2bHZSZ3dERkpXdjk0Q3QwTEJac2QyeitaYWlMWDR1OHNDcUliR3B0dSsv?=
 =?utf-8?B?V0RlUlkyR0s2d3JEamJ0clVqWVdXNVg1eStPRjF5YmFlZ21ueEtsYUs1bXNZ?=
 =?utf-8?B?NzUreGFTWTNFYXAxQUEwRERKRXJGNDhManN3Zmp5Z3JtQjluZmpzUEVCYldU?=
 =?utf-8?B?aEZ3bDI4QnZRZ2kwMk10WXR5Q2tjcWwwNHRPRWNjN2NXV2VZUFBDcHZJWFZi?=
 =?utf-8?B?TTUvWUpCTTBJeGhsUzE2YUZDQ3VjdlNrRDJyZHJHZkpOSXV5am1tZVFQUUYy?=
 =?utf-8?B?cVdsWmxGK0Vyb0xIdDc5RDBQa3laYW1vdnNJS1U2TDJjQlM5WjZjSzZOZWU3?=
 =?utf-8?B?eUtuaDAvbVpyYlgrL3FhYXBxdEU0UzZOejJlM2lsd09TMEJLUVJha3l6ZEhX?=
 =?utf-8?B?dDZCeHJNZnVidmh3Vzh2UnJjaEVPYkhTR3dqSzVDcHJ5MkhiSWE5Nm0xT1Va?=
 =?utf-8?B?eUtJcXIxQi9Lc0V3cyt1RmFBM0IwTjBwd1VRSWQzd0hLQnJ2c0Y2K0lIdUsx?=
 =?utf-8?B?Z1l0VStkSTdHV1lNUlB0UUc5akhtTlE4UkFTU0NPcFVXMmNaejhnYkZxOTNu?=
 =?utf-8?B?d1BWRmF5VHVKWndXZW03TVRUZDIrbENFVFVMV1QvOUhCM3FUSUtxb25DbEgw?=
 =?utf-8?B?T0RXVUl0NG5NalN4ZVc0aE95RXNtd0tTWUVoWkFiRFhyK1NlUmtsdWxHOUlE?=
 =?utf-8?B?aE1KMnFPV2JQaW1hN2NhWS9xallNd3M1c3pham02L1QvMmlWelVqTlJQVm5y?=
 =?utf-8?B?Mnl5U3FUNUpmR3RvVGRaR2k2Z1ZZUk8xZ28rWXgzT2hZNXhVV2Q3bEgrSXo1?=
 =?utf-8?Q?sUDdkIrydT8r7kuEWuGLIELIe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <330CE65D68E9BE4CBCEE390C81189BD6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d25c4d37-84d5-4064-e49f-08dc4f27754d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 13:03:26.9852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1RbQ6CRpy3HZUZEwejrUJGMUhsgXz8ZqPLd6VuKnSkFL+Zf26bXg/mNKNJKUTf6KBeFzYDSqZlz9M86aAzuoEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9061
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

QW0gMjguMDMuMjQgdW0gMTM6NTEgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQW0gMjguMDMuMjQg
dW0gMTM6MjEgc2NocmllYiBGYWJpbyBFc3RldmFtOg0KPj4gRnJvbTogSm9zdWEgTWF5ZXIgPGpv
c3VhQHNvbGlkLXJ1bi5jb20+DQo+Pg0KPj4gVGhlIGkuTVg2IEN1Ym94LWkgYW5kIEh1bW1pbmdC
b2FyZHMgY2FuIGhhdmUgZGlmZmVyZW50IFBIWXMgYXQgdmFyeWluZw0KPj4gYWRkcmVzc2VzLiBV
LUJvb3QgbmVlZHMgdG8gYXV0by1kZXRlY3Qgd2hpY2ggcGh5IGlzIGFjdHVhbGx5IHByZXNlbnQs
DQo+PiBhbmQgYXQgd2hpY2ggYWRkcmVzcyBpdCBpcyByZXNwb25kaW5nLg0KPj4NCj4+IEF1dG8t
ZGV0ZWN0aW9uIGZyb20gbXVsdGlwbGUgcGh5IG5vZGVzIHNwZWNpZmllZCBpbiBkZXZpY2UtdHJl
ZSBkb2VzIG5vdA0KPj4gY3VycmVudGx5IHdvcmsgY29ycmVjdC4gQXMgYSB3b3JrLWFyb3VuZCBt
ZXJnZSBhbGwgdGhyZWUgcG9zc2libGUgcGh5cw0KPj4gaW50byBvbmUgbm9kZSB3aXRoIHRoZSBz
cGVjaWFsIGFkZHJlc3MgMHhmZmZmZmZmZiB3aGljaCBpbmRpY2F0ZXMgdG8gdGhlDQo+PiBnZW5l
cmljIHBoeSBkcml2ZXIgdG8gcHJvYmUgYWxsIGFkZHJlc3Nlcy4NCj4+IEFsc28gZml4dXAgdGhp
cyBmYWtlIGFkZHJlc3MgYmVmb3JlIGJvb3RpbmcgTGludXgsICppZiogYm9vdGluZyB3aXRoDQo+
PiBVLUJvb3QncyBpbnRlcm5hbCBkdGIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5
ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+PiBbZmFiaW86IEFkZGVkIHRoZSBjaGFuZ2VzIHRv
IGlteDZxZGwtc3Itc29tLXUtYm9vdC5kdHNpLl0NCj4+IFNpZ25lZC1vZmYtYnk6IEZhYmlvIEVz
dGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT4NCj4+IFRlc3RlZC1ieTogQ2hyaXN0aWFuIEdtZWlu
ZXIgPGNnbWVpbmVyQGlnYWxpYS5jb20+DQo+PiAtLS0NCj4+ICAuLi5xZGwtaHVtbWluZ2JvYXJk
Mi1lbW1jLXNvbS12MTUtdS1ib290LmR0c2kgfCAgMSArDQo+PiAgYXJjaC9hcm0vZHRzL2lteDZx
ZGwtc3Itc29tLXUtYm9vdC5kdHNpICAgICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKw0KPj4g
IGJvYXJkL3NvbGlkcnVuL214NmN1Ym94aS9teDZjdWJveGkuYyAgICAgICAgICB8ICA4ICsrKy0N
Cj4+ICAzIGZpbGVzIGNoYW5nZWQsIDQ4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
ICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL2lteDZxZGwtc3Itc29tLXUtYm9vdC5k
dHNpDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9pbXg2cWRsLWh1bW1pbmdib2Fy
ZDItZW1tYy1zb20tdjE1LXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2lteDZxZGwtaHVtbWlu
Z2JvYXJkMi1lbW1jLXNvbS12MTUtdS1ib290LmR0c2kNCj4+IGluZGV4IGU5YjE4OGVkNjU4Ny4u
MzU4Y2Y4YWJjNGZmIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vZHRzL2lteDZxZGwtaHVtbWlu
Z2JvYXJkMi1lbW1jLXNvbS12MTUtdS1ib290LmR0c2kNCj4+ICsrKyBiL2FyY2gvYXJtL2R0cy9p
bXg2cWRsLWh1bW1pbmdib2FyZDItZW1tYy1zb20tdjE1LXUtYm9vdC5kdHNpDQo+PiBAQCAtMSw2
ICsxLDcgQEANCj4+ICAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4+ICAN
Cj4+ICAjaW5jbHVkZSAiaW14NnFkbC11LWJvb3QuZHRzaSINCj4+ICsjaW5jbHVkZSAiaW14NnFk
bC1zci1zb20tdS1ib290LmR0c2kiDQo+PiAgDQo+PiAgLyB7DQo+PiAgCWJvYXJkLWRldGVjdCB7
DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL2lteDZxZGwtc3Itc29tLXUtYm9vdC5kdHNp
IGIvYXJjaC9hcm0vZHRzL2lteDZxZGwtc3Itc29tLXUtYm9vdC5kdHNpDQo+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi40YzVmMDQzZWE5MmENCj4+IC0tLSAv
ZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJtL2R0cy9pbXg2cWRsLXNyLXNvbS11LWJvb3QuZHRz
aQ0KPj4gQEAgLTAsMCArMSw0MCBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMCBPUiBNSVQpDQo+PiArDQo+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bp
by5oPg0KPj4gKw0KPj4gKyZmZWMgew0KPj4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
Pj4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfbWljcm9zb21fZW5ldF9hcjgwMzU+Ow0KPj4gKwlw
aHktaGFuZGxlID0gPCZwaHk+Ow0KPj4gKwlwaHktbW9kZSA9ICJyZ21paS1pZCI7DQo+PiArDQo+
PiArCS8qDQo+PiArCSAqIFRoZSBQSFkgc2VlbXMgdG8gcmVxdWlyZSBhIGxvbmctZW5vdWdoIHJl
c2V0IGR1cmF0aW9uIHRvIGF2b2lkDQo+PiArCSAqIHNvbWUgcmFyZSBpc3N1ZXMgd2hlcmUgdGhl
IFBIWSBnZXRzIHN0dWNrIGluIGFuIGluY29uc2lzdGVudCBhbmQNCj4+ICsJICogbm9uLWZ1bmN0
aW9uYWwgc3RhdGUgYXQgYm9vdC11cC4gMTBtcyBwcm92ZWQgdG8gYmUgZmluZSAuDQo+PiArCSAq
Lw0KPj4gKwlwaHktcmVzZXQtZHVyYXRpb24gPSA8MTA+Ow0KPj4gKwlwaHktcmVzZXQtZ3Bpb3Mg
PSA8JmdwaW80IDE1IEdQSU9fQUNUSVZFX0xPVz47DQo+PiArCXN0YXR1cyA9ICJva2F5IjsNCj4+
ICsNCj4+ICsJbWRpbyB7DQo+PiArCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4+ICsJCSNzaXpl
LWNlbGxzID0gPDA+Ow0KPj4gKw0KPj4gKwkJL2RlbGV0ZS1ub2RlLyBldGhlcm5ldC1waHlAMTsN
Cj4+ICsJCS9kZWxldGUtbm9kZS8gZXRoZXJuZXQtcGh5QDQ7DQpJIHN1Z2dlc3QgY2hhbmdpbmcg
dGhlaXIgc3RhdHVzIHRvIGRpc2FibGVkLCBhbmQga2VlcGluZyB0aGUgbm9kZXMuDQo+PiArDQo+
PiArCQlwaHk6IGV0aGVybmV0LXBoeUAwIHsNCj4gVGhpcyBub2RlIG5hbWUgaXMgc2hhcmVkIHdp
dGggdXBzdHJlYW0gaW14NnFkbC1zci1zb20uZHRzaQ0KR2l2ZSB0aGlzIG9uZSBhIHUtYm9vdC1v
bmx5IGludGVybmFsIG5hbWUsIG1heWJlIGV0aGVybmV0LXBoeUBmZg0KPj4gKwkJCS8qDQo+PiAr
CQkJICogVGhlIFBIWSBjYW4gYXBwZWFyIGVpdGhlcjoNCj4+ICsJCQkgKiAtIEFSODAzNTogYXQg
YWRkcmVzcyAwIG9yIDQNCj4+ICsJCQkgKiAtIEFESU4xMzAwOiBhdCBhZGRyZXNzIDENCj4+ICsJ
CQkgKiBBY3R1YWwgYWRkcmVzcyBiZWluZyBkZXRlY3RlZCBhdCBydW50aW1lLg0KPj4gKwkJCSAq
Lw0KPj4gKwkJCXJlZyA9IDwweGZmZmZmZmZmPjsNCj4+ICsJCQlxY2EsY2xrLW91dC1mcmVxdWVu
Y3kgPSA8MTI1MDAwMDAwPjsNCj4+ICsJCQlxY2Esc21hcnRlZWUtdHctdXMtMWcgPSA8MjQ+Ow0K
Pj4gKwkJCWFkaSxwaHktb3V0cHV0LWNsb2NrID0gIjEyNW1oei1mcmVlLXJ1bm5pbmciOw0KPj4g
KwkJfTsNCj4+ICsJfTsNCj4+ICt9Ow0KPj4gZGlmZiAtLWdpdCBhL2JvYXJkL3NvbGlkcnVuL214
NmN1Ym94aS9teDZjdWJveGkuYyBiL2JvYXJkL3NvbGlkcnVuL214NmN1Ym94aS9teDZjdWJveGku
Yw0KPj4gaW5kZXggOGVkYWJmNDQwNGMyLi5mYmFiMzllODAwYTYgMTAwNjQ0DQo+PiAtLS0gYS9i
b2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMNCj4+ICsrKyBiL2JvYXJkL3NvbGlk
cnVuL214NmN1Ym94aS9teDZjdWJveGkuYw0KPj4gQEAgLTQ0Nyw3ICs0NDcsNyBAQCBzdGF0aWMg
aW50IGZpbmRfZXRoZXJuZXRfcGh5KHZvaWQpDQo+PiAgICovDQo+PiAgaW50IGZ0X2JvYXJkX3Nl
dHVwKHZvaWQgKmZkdCwgc3RydWN0IGJkX2luZm8gKmJkKQ0KPj4gIHsNCj4+IC0JaW50IG5vZGVf
cGh5MCwgbm9kZV9waHkxLCBub2RlX3BoeTQ7DQo+PiArCWludCBub2RlX3BoeSwgbm9kZV9waHkw
LCBub2RlX3BoeTEsIG5vZGVfcGh5NDsNCj4+ICAJaW50IHJldCwgcGh5Ow0KPj4gIAlib29sIGVu
YWJsZV9waHkwID0gZmFsc2UsIGVuYWJsZV9waHkxID0gZmFsc2UsIGVuYWJsZV9waHk0ID0gZmFs
c2U7DQo+PiAgCWVudW0gYm9hcmRfdHlwZSBib2FyZDsNCj4+IEBAIC00NzksNiArNDc5LDEyIEBA
IGludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpmZHQsIHN0cnVjdCBiZF9pbmZvICpiZCkNCj4+ICAJ
CXJldHVybiAwOw0KPj4gIAl9DQo+PiAgDQo+PiArCS8vIHVwZGF0ZSBVLUJvb3QncyBvd24gdW5p
ZmllZCBwaHkgbm9kZSBwaHkgYWRkcmVzcywgaWYgcHJlc2VudA0KPj4gKwlub2RlX3BoeSA9IGZk
dF9wYXRoX29mZnNldChmZHQsICIvc29jL2J1c0AyMTAwMDAwL2V0aGVybmV0QDIxODgwMDAvbWRp
by9waHkiKTsNCj4gVGhpcyBub2RlIG5vIGxvbmdlciBleGlzdHMsIHVubGVzcyB5b3UgcmVuYW1l
IHRoZSB1LWJvb3Qtc3BlY2lmaWMgb25lLg0KPiBUaGUgdS1ib290IG5vZGUgc2hvdWxkIHByb2Jh
Ymx5IGhhdmUgaXRzIG93biBzZXBhcmF0ZSBuYW1lLCB0byBlbnN1cmUNCj4gd2UgZG8gbm90IGZp
bmQgdGhlIHVwc3RyZWFtIGxpbnV4IGR0YiBldGhlcm5ldC1waHlAMCBub2RlIGJ5IG1pc3Rha2Uu
DQpMb29rLXVwIHRoZSB1LWJvb3QtaW50ZXJuYWwgcGh5IG5vZGUgbmFtZSBoZXJlDQo+PiArCXJl
dCA9IGZkdF9zZXRwcm9wX3UzMihmZHQsIG5vZGVfcGh5LCAicmVnIiwgcGh5KTsNCj4+ICsJaWYg
KHJldCA8IDApDQo+PiArCQlwcl9lcnIoIiVzOiBmYWlsZWQgdG8gdXBkYXRlIHVuaWZpZWQgUEhZ
IG5vZGUgYWRkcmVzc1xuIiwgX19mdW5jX18pOw0KPj4gKw0KPj4gIAkvLyB1cGRhdGUgYWxsIHBo
eSBub2RlcyBzdGF0dXMNCj4+ICAJbm9kZV9waHkwID0gZmR0X3BhdGhfb2Zmc2V0KGZkdCwgIi9z
b2MvYnVzQDIxMDAwMDAvZXRoZXJuZXRAMjE4ODAwMC9tZGlvL2V0aGVybmV0LXBoeUAwIik7DQo+
PiAgCXJldCA9IGZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5vZGVfcGh5MCwgInN0YXR1cyIsIGVu
YWJsZV9waHkwID8gIm9rYXkiIDogImRpc2FibGVkIik7DQpKdXN0IGRpc2FibGUgdGhlIHUtYm9v
dC1pbnRlcm5hbCBwaHkgbm9kZSB1bmNvbmRpdGlvbmFsbHksIG9yIGRlbGV0ZSBpdC4NCkJlY2F1
c2UgdS1ib290IERUQiBpcyBzeW5jZWQgd2l0aCB1cHN0cmVhbSwgdGhlIGNvZGUgYmVsb3cgd2ls
bCB1cGRhdGUgc3RhdHVzIHByb3BlcnRpZXMNCmZvciB0aGUgc3RhbmRhcmQgZXRoZXJlbnQtcGh5
QFswLDEsNF0gbm9kZXMgdXNlZCBieSBMaW51eC4NCg==
