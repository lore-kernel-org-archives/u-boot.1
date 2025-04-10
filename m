Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6831C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:02:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32C0083A37;
	Thu, 10 Apr 2025 14:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=voltserver.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=voltserver.com header.i=@voltserver.com header.b="JREiwIk+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E226D83BBE; Thu, 10 Apr 2025 14:02:27 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::70e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F296B839F3
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:02:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=voltserver.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=thom.nichols@voltserver.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+y9cIsyTz0fhlF0owmvL4AhR6cHkLWTFfbuoCrxY2OaD8Rl240SwDn8+3j1dy3xqvoO0p3N6ppF3YH+cc5rW7hl/vMLo6y1v/34zzjqd/gHTvFXPuu105A8YzhDtEdDyrnazqEeLU/trxK787WtHDWC98DGudCL0UV0YjlW+b5jvm+jJR1T4Hfze3UxTDyAIMh1eyiE/JtnYkxBHOs2pli7yVa2hFNMiNXOiLr9H1kb1rVLHgS06JOuJBwpkL0oxUzTPZY3d9quy/5u0M1o5R4hpgrQgqwDM/mwM7PyuRov7jZo+Dqfko8a3hilAaF4KytQaJDAb+LX/qsDsHPhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk5UIX8tVI719W0SyVhai0ri9jKkK89NpS8k0Nhangc=;
 b=W9a489C7guuf1fEeEDbYgTQsRwc8rHslrnpPUrN+SAdRitY4Mq3oW5xv4+GAMHTcdLxAWZ5dINwnjeRMTiPu3tyaKD823AKwGtus6c/BNPZabQVlMaNXsc5eErmrGRWbb4cELOzoJHkYv5FpQpDjEJtfu2zHK/hxl+dX56LHVHnjWardgyuf+DWpsS8YatWEkFsPXp0eC4yWT+OPUQZPz/lVRKEtF6+j74rOXYRnFO2lIzgiXn3h2NEYq6DXJs4WFwJCDcQatPgh2fIEAXr085VuI0HAwRxZu0Kuk+XX4SdnfPxs06Y7SgQandS9FXjfCjsikKltjHyMZXcOT563kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=voltserver.com; dmarc=pass action=none
 header.from=voltserver.com; dkim=pass header.d=voltserver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voltserver.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk5UIX8tVI719W0SyVhai0ri9jKkK89NpS8k0Nhangc=;
 b=JREiwIk+HSjkE8y0Ei24xD6bpI8/mwUWxkG70Z9B023ANKvXE+XjNcoXBV6PMun38VwIqlilWjSfx2M/oz0vB8VM1dtju+Zo0vV7IV4KXJD08aBcRDq1N9iQw5X/wZoQSNgjX5u9s+VBoDoKEqDIdCsqP86gj8nLFWKoLBgisFE=
Received: from CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12)
 by SJ2PR11MB7474.namprd11.prod.outlook.com (2603:10b6:a03:4ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 12:02:18 +0000
Received: from CY8PR11MB7945.namprd11.prod.outlook.com
 ([fe80::c90:7c4e:4a9d:8b00]) by CY8PR11MB7945.namprd11.prod.outlook.com
 ([fe80::c90:7c4e:4a9d:8b00%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 12:02:18 +0000
From: Thom Nichols <thom.nichols@voltserver.com>
To: Bryan Brattlof <bb@ti.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: bootcount support for AM62 RTCSS
Thread-Topic: bootcount support for AM62 RTCSS
Thread-Index: AQHbqIOMYDmrrX/YGEu4sJZqgsfzfrOaIVuAgAFsb0A=
Date: Thu, 10 Apr 2025 12:02:18 +0000
Message-ID: <CY8PR11MB7945B4325CE428F1DB3253BAFDB42@CY8PR11MB7945.namprd11.prod.outlook.com>
References: <CY8PR11MB79456EA41EF6365020C89B98FDB52@CY8PR11MB7945.namprd11.prod.outlook.com>
 <20250408190529.qzi54waaxj3hzxr6@bryanbrattlof.com>
In-Reply-To: <20250408190529.qzi54waaxj3hzxr6@bryanbrattlof.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=voltserver.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7945:EE_|SJ2PR11MB7474:EE_
x-ms-office365-filtering-correlation-id: ee2392bb-1f95-4793-9b31-08dd78278ad7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|8096899003|13003099007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QkExVDFUUGxmcUZLT0d6VzJGZkREQUhveDJ1M2hXbE5CQ3NUeXpvNEs4SmtJ?=
 =?utf-8?B?M0krSmE0MVBqeWRwWVpBbTAwVkFhQ011TDcyOFhqdHgwOXhtc1hld2FvWnA1?=
 =?utf-8?B?WnJ6NmNybjhOQTdnNUdIcEFJQ2YzbFpsQ2x1bE1uZXNtREFCSWw3ZVNMekl6?=
 =?utf-8?B?bU5oaE81ZnpqdS9oL09PdUt6cFlCRG5SZ3FoYVNzc3o0OG50YTlLMTdpdGtQ?=
 =?utf-8?B?ZWh0cE9ZTkl1UlNlNnUrUWZaWXRFbW1VNzl6UHVMbE1WMWxqMWdzSW5jUmYy?=
 =?utf-8?B?Ym5OQXQvREpYcUNEWFpCaXpjek4xTVBDclZoeUZhZVBmd3ZKUmNqZFMyMUJS?=
 =?utf-8?B?ZzRUeTBuOXZ4T0pxanI5SVAzbHA1a29ndDZEK3BGZ2F3U0Z0RHBQVmVGQjFE?=
 =?utf-8?B?WmlKeEV5Vnl2S3l1aW1RZVRpSmlHMzN3Y0dQajZpemt0ODRkQThwMkIzYmpD?=
 =?utf-8?B?WGl6dC9ZNm5CYzFobHZvRDlEaUhkZHQyWkVLaDNYRUJpdnBCWGk0dVorS3pJ?=
 =?utf-8?B?ZDM1M1dnb3hPbHI1bGZmeWZ2Z1kvWkZzL2Jva3IzeXdPTUs0RGd4R0JlTktm?=
 =?utf-8?B?eWdWV0h3R2pqeFdsSytzN0tVNmx1WGx0bVBZaG9va2M0THAzZjFMVkMwUVdk?=
 =?utf-8?B?MTBXdkQySjVBZGs3Uk4rYnFaWVk5TGJaQzJJYkszL2lIMkQxRUE4NHpQMU5L?=
 =?utf-8?B?TVVoVWdBQ0hsaTVjUG1KSVFJRElLcWgxTTBseFpxamtiQWg5bEFXdlZBZ21W?=
 =?utf-8?B?bmVoQmdtck9pRnBKWXZuN0ZOY1dPR3EzT09jSm5BOHZlUllRNXhBVVVlZlc4?=
 =?utf-8?B?aXpxQkhjaEU1WFlSYyt2UnlTelFOdEp5Vk9ERlFQK2RyVm1acjRmV21ndnl4?=
 =?utf-8?B?Z210b0R1Zm5qeGJLZE16VmJNVlV0bU5POEJIRDFOT2NlVXVQZW1OcGRvTnFw?=
 =?utf-8?B?V2l2dHhoSnRreUpXc1M2NWFXYTF4TCtnNWlxWXp3ODV0QnpTWkdLNjNmS1VY?=
 =?utf-8?B?MGV0MkdHL2cwakRYYzl2UkhERkdaUVR6RUJmYm1Uc2JkM1NFbkswMnNLRmM5?=
 =?utf-8?B?WlczamNMZXVRcTZseGVONDRxdE4rc0RIcmhMM3JaRzYxNFdacU5wc3Y2SDha?=
 =?utf-8?B?NUhSbjdZdGN0N25FbEhPbnN1aEdIZXVOQmEvVndlVW16elVUcmdnNnB2c1pj?=
 =?utf-8?B?MVBFeGhEbjZWTjA1Rnh0NGpYcnhMYTA5RFZRcTZ0amRnaHlCRU9qQVR5SGtY?=
 =?utf-8?B?WUtFTFZMTnYvRTNLZmQyUWpWWUNwQ2grSzdaK2l4aXJSYlRrOVg3S2pYbmI4?=
 =?utf-8?B?dTZqRk91R2c4Y1h0cGp2d2pIWU9xTkhtSnFkOVdNc2ljZkR3Y2dyUWxudUhq?=
 =?utf-8?B?SDV1SDNJc1VORE0xcjlPbnRIYnlYYU5PaVFnK0NzQlVJcGN1NWNudW9Id0dw?=
 =?utf-8?B?clIzN1g4d1F1YStjaUE4eU05VW5MSi9TQXdwdEkwVjBiYTBmaE45QzFIUktB?=
 =?utf-8?B?L1laZmNlditDSCs2c2JPNXZCeDQ0c1FYRnR5b2hIdjkxT0lUdjMxWFZKSHk3?=
 =?utf-8?B?VWVmMU5jTmp5b0hrN2NOOUNtczlKbEMvdWFvbWdMMWFRdnc0RlgvYk41bFBW?=
 =?utf-8?B?Zk16M1FiM1Z4cVV1QWJhZXpCUWpQaVprK1hmRCt4ZFYzM3IwYk9OSGdmZWJH?=
 =?utf-8?B?VXBZeWphaDhKdGRXb0xwT3dCNTFSamZsRElFNDJRUDJ2ek10VS9CRUhsMlVl?=
 =?utf-8?B?WllrZTNmcUIwL3BVZ3Y1RlBvclpCT1RoVzVud0VDYnRyZ0gzTHlXbnRQTExn?=
 =?utf-8?B?dXB4MnNUcEhXSEVkWnVhQ1FOdlU0VXFkNmo5NkdhQzlvZ04zSWZXNWExWElK?=
 =?utf-8?B?T0VVVWsvenRJbE4xTmlWWTFwdVBkdVNhbTNOSStmd0pNTnZVMUg5bDQ3QU5P?=
 =?utf-8?Q?a4X+9Fl97mojcx7VwqzJ4G3H7553SMRI?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7945.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(8096899003)(13003099007)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXNjQUpkUEc2YmN4RlBCb2hoOGUxN0VhL21MSlhDRy8rRElCVHJ0bXNyck16?=
 =?utf-8?B?VzVwdnlRTFMrSVJBTkFUN2NRd0w0WmYrSWdNWlovb3o3T0gvekZTNk1lWUJH?=
 =?utf-8?B?RlY0OVZ3TCtZaVlmcmU0dzVzUjFhQ1FWVG9ySFVjdWV3M3ZzYWFmWVVoZytm?=
 =?utf-8?B?TjlUcGJTY3dxRDJCWlg1ZDIxbVNHZ3p1UE1keHZOV1A1bzBNYmdHcG5PcjJJ?=
 =?utf-8?B?L1pUd1V4ck9BcjNDQ0dmZmtmZ3RvaTNuVG91OUE0S1dja081c3o4ZCtCYmhY?=
 =?utf-8?B?cDRYOHorSE9jVlRScUtKTFg5aTBZMytVYzIvVUNuSjdXQmZoZE04UXdCeFV3?=
 =?utf-8?B?U2xyMkdwRjBKK2JMWXFjWHdUSFdmWldoNUJkODRvME1nMzAzZEs0dzFvMVJw?=
 =?utf-8?B?Z0x1YnRCclhNSnVyRUQ2WTJKZ3JTdmdkeTJLemFvSy85eUlPZnpvdzZFYW1C?=
 =?utf-8?B?MnNzK2FqeXZ5Vk85M2R1RURzbUROS2g3SUFzdk41S1Mxd3JhaEFZZjNSemtX?=
 =?utf-8?B?SlkxT1p5UHcvaEIvNlhkaldubmRIenB2emtMRnMxbGtUSjFabk1wblhmOFpa?=
 =?utf-8?B?VjNLSmRxaTJwT3JvUUZMY1F3MEhJOFNjeTZQWHNiOWZrWThKQ0VzK08rSWNl?=
 =?utf-8?B?dzlIWkFUd3V3cGlYNllSMHlwQmkwS3ZxYzVqMTM4RmxZdng2UkpKdnVRZjY4?=
 =?utf-8?B?Q1VPVmh2NzhuQTRUNm80RGRhazdvR2MrTDltSEtHSkdTU1FhNU9VMGs4QnEw?=
 =?utf-8?B?bEM5MWxpOVlzWUpkdmhFRDVOSVJZMnAyYTEwTmJzOGVHZWt5ZlE4citmMHFV?=
 =?utf-8?B?Rmo4b0c5M0hWbktQZStVRHQyM2o4OGQ1OGRXckVnTFYyQjd5cWxZNytoYjAw?=
 =?utf-8?B?anBVUXh2NzBEQWd5UDRkWkZBUzFZUGhCYVQ2bFlTUE5QSTdFMjBqdXBXWDRC?=
 =?utf-8?B?R0hVS1RWNlNzUjNNRzI4NVkwT3dTZmY3RTJhcHk4OFM5WnRjSDVoUVBRY3Nx?=
 =?utf-8?B?SzMwZkpld0s0ZlgwcE9EeGNGKzFnR1ZONGtZcHNrV1hIMmhQZW8wUXUrWEw5?=
 =?utf-8?B?a3p0Y1JyT2Q4bmsvdjdjTUNDYXpPcXlXb0YyRkFlRmhrLzNpY1MzMDV4Zjda?=
 =?utf-8?B?b3JyNE85SHl1N3oxUFhMZTgrWi9rc2ljc05GUHFhWURXMmFjaWFNQ2FHQnk3?=
 =?utf-8?B?MFBvaXQrcEVMRCtzN3RsZENNTDFQOG1WZCtLTVI4ZjJYQ0wxa0Z2N2JRdyty?=
 =?utf-8?B?T2FUejlNclZlWFl6eW9NVEx3RFhiYWVHTGtnZStBMDU2clZpWEV1alZ1b3hv?=
 =?utf-8?B?aGZXU1NNNUxLVThGc0FERkJSVjhmQ2FncVFrRGk4QXduM0lZUHVrT3dxN0FX?=
 =?utf-8?B?VXRaVi9jQjVHZEMvTnJ4K2FrUlY2OWVnSWxHV2JKRGxHVGd5b1BTMSt5VlhK?=
 =?utf-8?B?d2xqam9tenhzS1o1T1dvek8yMUVSYUVvdE1heVN3NmpjUjc5WnBpUmtXODNU?=
 =?utf-8?B?Y3YvUS93QzdITnFaMVJRMk5vQVNXSHhRREJ1ckdzaGtWZ1pUeHFveVhTam1R?=
 =?utf-8?B?VDIxbjVaKzJkQjJCV3RJenBqVCsveVRwcTROdjlYb3p4TXBjZTg3WlhFOWw1?=
 =?utf-8?B?akcwRyt5ZkQrcDltTDBFOS9xRkM5OW56RVloYzhmODNKZmZSdGNYYVlGWjk5?=
 =?utf-8?B?c2pQTjlTWlRvRnphcU1FYzgzNUFoelNnWTVqWnh4UTIyZVhFTENobmUzNk1v?=
 =?utf-8?B?ckxUKzJmbzRpVGsvbU1KT1plL01GT2V3WU5rdlRZYzhOajdBR3lGMWYxZDdo?=
 =?utf-8?B?R3UyYTBHdU1xWlJiazVnNG1ZMkgxL3Z0azl2c0s1VEs3OFN5NUlXUW5NWFpj?=
 =?utf-8?B?dTg1Z3FvV3dPLy9sdGhwbXM0NGtreFVWSFhocHBUaGFEeUVSZFN6NWJITWFC?=
 =?utf-8?B?aFhTdFZ3MkZaTWFiSWZqMWdNL056MzMxYXVpUm9Qd1Q1cWlPU08zUUdlcHA0?=
 =?utf-8?B?VEttSHdjTVRlK0hWa0VVZ1FpOXNBRFN4YVM2Z2VVT3p4K0w4YnJENzdaQ09y?=
 =?utf-8?B?aE5iTW5QSXNCdi9tNUFuRDAvR2NrM0h4QThWTHBpYzlXZ0dtZE9NdldMVkZN?=
 =?utf-8?B?VWNXWXMzbkovK2RpSDZDU2drWEJHdXV2NWRWbjJZQ1JYQW9qNU5aZUpnODNX?=
 =?utf-8?Q?DGhv7NOKgHTChQFtbLX7uAE=3D?=
MIME-Version: 1.0
X-OriginatorOrg: voltserver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7945.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2392bb-1f95-4793-9b31-08dd78278ad7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 12:02:18.4708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d954406-2c01-45a3-9cc8-be64a19fb626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 617pwmJxHKioJuunkSVUPUWGAhJY4q1aJKO6Yxuqhkmu3qplr6FKD3KF26CC3vPd7CJbU47kYoXGWHcBslazWJ+EWzTMwKfrTxpseABw6hY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7474
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgQnJ5YW4gLSBJIHJlYWxpemVkIHdoYXQgSSB0aGluayB5b3Ugd2VyZSB0cnlpbmcgdG8gc2F5
IC0gdGhlIGJvb3Rjb3VudF9kYXZpbmNpIGRyaXZlciB1c2VzIHRoZSBkYXZpbmNpX3J0Y+KAiyBz
dHJ1Y3Qgd2hpY2ggaXMgYSBjb21wbGV0ZWx5IGRpZmZlcmVudCByZWdpc3RlciBsYXlvdXQgYmV0
d2VlbiB0aGUgQU0zMyBhbmQgQU02MiBSVENTUy4gIEkgaW1hZ2luZSBJIGNvdWxkIG1ha2UgYW4g
YWx0ZXJuYXRlIGRhdmluY2lfcnRjIHN0cnVjdCBpbiBteSBuZXcgaGVhZGVyIGZpbGUganVzdCB0
byByZW1hcCB0aGUga2ljayBhbmQgc2NyYXRjaCByZWdpc3RlcnMgYnV0IHRoYXQgZmVlbHMgaWNr
eS4gIE9mIGNvdXJzZSBJIGNvdWxkIGp1c3QgbWFrZSBhIGJvb3Rjb3VudF9hbTYyeCBkcml2ZXIg
aW5zdGVhZCBvZiB0cnlpbmcgdG8gcmV1c2UgYm9vdGNvdW50X2RhdmluY2kuICBPciBjaGFuZ2Ug
Ym9vdGNvdW50X2RhdmluY2kgc28gdGhhdCBpdCB1c2VzIG9mZnNldHMgaW5zdGVhZCBvZiB0aGUg
ZGF2aW5jaV9ydGMgc3RydWN0LiAgRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24gZm9yIHdoaWNo
IHdvdWxkIGJlIHRoZSBwcmVmZXJyZWQgYXBwcm9hY2g/DQoNClRoYW5rcyBhZ2Fpbi4NCg0KLVRo
b20NCg0KDQpGcm9tOiBCcnlhbiBCcmF0dGxvZiA8YmJAdGkuY29tPg0KRGF0ZTogVHVlc2RheSwg
QXByaWwgOCwgMjAyNSBhdCAzOjA14oCvUE0NClRvOiBUaG9tIE5pY2hvbHMgPHRob20ubmljaG9s
c0B2b2x0c2VydmVyLmNvbT4NCkNjOiB1LWJvb3RAbGlzdHMuZGVueC5kZSA8dS1ib290QGxpc3Rz
LmRlbnguZGU+DQpTdWJqZWN0OiBSZTogYm9vdGNvdW50IHN1cHBvcnQgZm9yIEFNNjIgUlRDU1MN
Cg0KW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBiYkB0aS5jb20uIExlYXJuIHdoeSB0
aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRp
ZmljYXRpb24gXQ0KDQpIaSBUaG9ybSENCg0KT24gQXByaWwgIDgsIDIwMjUgdGh1cyBzYXlldGgg
VGhvbSBOaWNob2xzOg0KPiBJ4oCZZCBsaWtlIHRvIGdldCBib290Y291bnQgc3VwcG9ydCBmb3Ig
dGhlIEFNNjIgUlRDU1MuICBUaGUgUlRDU1Mgb24NCj4gdGhlIEFNNjIgaXMgdmVyeSBzaW1pbGFy
IHRvIHRoZSBBTTMzLiAgSW4gZmFjdCwgSeKAmW0gcHJldHR5IHN1cmUgdGhlDQo+IGJvb3Rjb3Vu
dF9kYXZpbmNpIGRyaXZlciB3b3VsZCB3b3JrIGZvciBBTTYyLCB3aXRoIGp1c3QgdGhlIHJlZ2lz
dGVyDQo+IGFkZHJlc3MvIG9mZnNldCBhbmQgS0lDS19XRSBjb25zdGFudHMgcmVkZWZpbmVkIGZv
ciB0aGUgY29ycmVjdCBBTTYyDQo+IHZhbHVlcy4gIEEgd2hpbGUgYmFjayBJIHRlc3RlZCB0aGUg
QU02MiBzY3JhdGNoIHJlZ2lzdGVyIGZyb20NCj4gdXNlcnNwYWNlIFsxXSBhbmQgY29uZmlybWVk
IGl0IHdvcmtzIHRoZSBzYW1lIGFzIHRoZSBBTTMzLg0KPg0KDQpXb25kZXJmdWwhIEl0IGlzIGEg
ZGlmZmVyZW50IElQIGZyb20gdGhlIEFNMzM1IGJ1dCBub3QgY29tcGxldGVseQ0KZGlmZmVyZW50
IGhvd2V2ZXIgSSB0aGluayB5b3VyIGFwcHJvYWNoIHNob3VsZCB3b3JrLg0KDQo+IEnigJl2ZSBu
ZXZlciBjb250cmlidXRlZCB0byB1LWJvb3QgYnV0IEkgYmVsaWV2ZSBJIGNvdWxkIGdldCBhIHdv
cmtpbmcNCj4gUFIgdGhhdCBtb2RpZmllcyB0aGUgZGF2aW5jaV9ib290Y291bnQgZHJpdmVyLCBp
ZiB0aGlzIHdvdWxkIGJlDQo+IGFjY2VwdGFibGUuDQo+DQoNCllvdSBzaG91bGQgZmVlbCBmcmVl
IHRvIHN0YXJ0IGlmIHlvdSB3YW50ISBVLUJvb3QgaXMgdmVyeSB3ZWxjb21pbmcgaW4NCnRoaXMg
cmVnYXJkLiBUaGUgbW9yZSBkZXZzIHdlIGhhdmUgaW4gVS1Cb290IHRoZSBiZXR0ZXIgOikNCg0K
PiBBbHRlcm5hdGVseSBJIGRvbuKAmXQga25vdyBpZiB0aGVyZeKAmXMgYW55IG5lYXItdGVybSBw
bGFuIGZvciBhbnkgb2YgdGhlDQo+IEFNNjIgbWFpbnRhaW5lcnMgdG8gcG9ydCB0aGUgcnRjIGRy
aXZlciBzbyB0aGF0IGJvb3Rjb3VudC9ydGMgY291bGQgYmUNCj4gdXNlZC4gIEkgdGhpbmsgZG9p
bmcgdGhpcyB3b3VsZCBiZSBiZXlvbmQgbXkgY2FwYWJpbGl0aWVzLg0KPg0KDQpTbyB3ZSBkbyBo
YXZlIHNvbWUgcGxhbnMgdG8gaW1wcm92ZSBSVEMgc3VwcG9ydCBpbiBib3RoIGluIExpbnV4IGFu
ZCBpbg0KVS1Cb290IHRvIGV4dGVuZCBzb21lIGZlYXR1cmVzIG5lZWRlZCBmb3IgdGhlIGxhdGVz
dCBTaXRhcmEgY2xhc3MgU29DDQpidXQgSSdtIHVuc3VyZSBhYm91dCB0aW1lbGluZXMuIEkndmUg
YWRkZWQgYSB0aWNrZXQgaW50ZXJuYWxseSB0byB0cmFjaw0KdGhpcyBpZiB3ZSBnZXQgdG8gaXQg
YmVmb3JlIHlvdSBkbyB0aG91Z2ggOikNCg0KfkJyeWFuDQoNCj4gVGhhbmtzIGluIGFkdmFuY2Uu
DQo+DQo+IFRob20gTmljaG9scw0KPg0KPiAxLiBodHRwczovL25hbTExLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZnaXRodWIuY29tJTJGVm9sdFNl
cnZlciUyRnVib290LWJvb3Rjb3VudCUyRnB1bGwlMkYxNSUyRmZpbGVzJmRhdGE9MDUlN0MwMiU3
Q3Rob20ubmljaG9scyU0MHZvbHRzZXJ2ZXIuY29tJTdDYmYzMDY1NDJkMGNlNDhjNGJjNDMwOGRk
NzZkMDU2ZWMlN0M5ZDk1NDQwNjJjMDE0NWEzOWNjOGJlNjRhMTlmYjYyNiU3QzAlN0MwJTdDNjM4
Nzk3MzU5NDAxNjI2NjQ4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lP
blJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJD
SXNJbGRVSWpveWZRJTNEJTNEJTdDNjAwMDAlN0MlN0MlN0Mmc2RhdGE9TWdJZmlaNU1uVGFGa09m
cEg5a1ZYWHh3YXJoaGoxZDczcW9YNzZUWVR1byUzRCZyZXNlcnZlZD0wPGh0dHBzOi8vZ2l0aHVi
LmNvbS9Wb2x0U2VydmVyL3Vib290LWJvb3Rjb3VudC9wdWxsLzE1L2ZpbGVzPg0KDQpUaGlzIGVt
YWlsIGFuZCBhbnkgZmlsZXMgdHJhbnNtaXR0ZWQgd2l0aCBpdCBhcmUgY29uZmlkZW50aWFsIGFu
ZCBpbnRlbmRlZCBzb2xlbHkgZm9yIHRoZSB1c2Ugb2YgdGhlIGluZGl2aWR1YWwgb3IgZW50aXR5
IHRvIHdob20gdGhleSBhcmUgYWRkcmVzc2VkLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGVt
YWlsIGluIGVycm9yIHBsZWFzZSBub3RpZnkgdGhlIHN5c3RlbSBtYW5hZ2VyLiBUaGlzIG1lc3Nh
Z2UgY29udGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGFuZCBpcyBpbnRlbmRlZCBvbmx5
IGZvciB0aGUgaW5kaXZpZHVhbCBuYW1lZC4gSWYgeW91IGFyZSBub3QgdGhlIG5hbWVkIGFkZHJl
c3NlZSB5b3Ugc2hvdWxkIG5vdCBkaXNzZW1pbmF0ZSwgZGlzdHJpYnV0ZSBvciBjb3B5IHRoaXMg
ZS1tYWlsLiBQbGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgaW1tZWRpYXRlbHkgYnkgZS1tYWlsIGlm
IHlvdSBoYXZlIHJlY2VpdmVkIHRoaXMgZS1tYWlsIGJ5IG1pc3Rha2UgYW5kIGRlbGV0ZSB0aGlz
IGUtbWFpbCBmcm9tIHlvdXIgc3lzdGVtLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVj
aXBpZW50IHlvdSBhcmUgbm90aWZpZWQgdGhhdCBkaXNjbG9zaW5nLCBjb3B5aW5nLCBkaXN0cmli
dXRpbmcgb3IgdGFraW5nIGFueSBhY3Rpb24gaW4gcmVsaWFuY2Ugb24gdGhlIGNvbnRlbnRzIG9m
IHRoaXMgaW5mb3JtYXRpb24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZC4NCg==
