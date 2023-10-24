Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7082C25B47
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 07:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5FD870F1;
	Tue, 24 Oct 2023 09:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="D72RL1HQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48442870F0; Tue, 24 Oct 2023 09:39:14 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEAB7870F1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 09:39:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698133148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=28s8n1Z5Ak++O5ElP9UzxiXtpRRJxIrzOQkHKOmt9wE=;
 b=D72RL1HQvgX5d2sVODtuPr7M4a/EWtB+LUjcCM3WiEKhNnBP9ppjXJxIRDjhy8ExWT1fZB
 cV9YaNGHYk6f9wkWAUgjF1DtgmKTtrLyGgv+qC1pGEEdNzuKM3XR6THy8v0fKQL6g8HGVV
 oflbipFLbH56AzREtxzthyVXlghwqy8=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-6o9YFvmIMJu72UgzhyZMNA-1; Tue, 24 Oct 2023 09:39:05 +0200
X-MC-Unique: 6o9YFvmIMJu72UgzhyZMNA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0070.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:23::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Tue, 24 Oct 2023 07:39:03 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 07:39:03 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "festevam@denx.de" <festevam@denx.de>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
Subject: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Topic: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Index: AQHaBk0pzkBxey4AX0CR0vSGBaUJ0A==
Date: Tue, 24 Oct 2023 07:39:03 +0000
Message-ID: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0070:EE_
x-ms-office365-filtering-correlation-id: d5604e65-0d91-45d8-8502-08dbd4644b9c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: 2ogf15TeFYvWW1YgByVsyI71u3AlJ045/qGmTybLBJRjxy3WTk0JedPKPPnI7Q6l7BbsvrVrUANclnZ7fMnA4ElZwXstUgSjybjXVAaCp0fxSwFjgilRRkrk3HHQaWkVXodGXJQay9FczzRtt9jnIEQL7IhDzqbCz0637Y8xIlGBQ7DI/Br15bwrtQvj9exIoxDlfsCFP4JwWyiIaUNTVD7nZzbxHyCi6PPzMXrLRxR4FuRwlBi8kWKgiPaKXtlMOa2lrL2And1noktLk0MlzSN6hUBr5GGAdNG1V4cYZU1lgpB+I5O1B1yTBkXiRxKFaMvPNCP9TYMofLsV5Jo5zm/xTdkFOuOc09m4bwC/KayWWYEZgqLRszzBxe+Y3wl/R5WdpKHO1HDUruX27DpSyG1J461Pn0DIgehc1Yr0/GM8/E2Q/pepNB04ZnqOhHKc4td3ghaqEene7Luz4Y+5/uQogn0B/0Om2/jVZPmYS+CvM2Ku9q6VLaCxPqFoC+BPe0qB+INz8S6f3GiRvqtQ51hQQk+SnVfbg/rrRNYSigtVh3pRjLtrO9oZECPN4uRxFm6YDiqikVErkZYuDn6ifVBHVBXGJP43B54puJJm80o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39850400004)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(71200400001)(5660300002)(8676002)(4326008)(41300700001)(44832011)(26005)(2906002)(6506007)(8936002)(2616005)(38100700002)(6512007)(91956017)(86362001)(36756003)(83380400001)(66556008)(316002)(76116006)(6916009)(66446008)(66946007)(66476007)(54906003)(64756008)(478600001)(6486002)(122000001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0o4R1NSbTBwTnFvSUl3MDJlclFRRHJMYlhiT1NGRkZLMzMvYzVtZzY1aHU4?=
 =?utf-8?B?em5hSXlwZ2hoWXB2Ymg3QmlyajZQQk9hanlsNTRpNTFiaEo3dmxWa09pdmJE?=
 =?utf-8?B?UFd1QmhMUGZNc05uUHRnK2psOUZqakxHa0Z6dmZuV0NFVmFwWnRQbUpRalpl?=
 =?utf-8?B?d3ArZUh2eUxUOVVZSjdxQksxeXhMTCtPWHFQV1piMU9ZR25lUnY2QVljN3pk?=
 =?utf-8?B?OVNocFNVTGJRckNCK21meDM0TkNKTE1JeUFYMVJqMnhXbFVmbFp0amVlRmx5?=
 =?utf-8?B?R252WHN1UFc1YzdWemxPbGdlZ0dpU21rTmhRMmo4SUY3NlVtdjM5SkJlNUFk?=
 =?utf-8?B?dDlVbk93TWp4ZWRKREVNVVVJVWNsR0M4eVpLWDFpaGd4aGlPMmVSVExqWFlt?=
 =?utf-8?B?bjdjc0ZvdFNmZm9JTVhhR1JHTFhSSHo2NTF0TnI1RDVuN1pid3FEZjF4L1ox?=
 =?utf-8?B?VkV6ZXR0L2ZIbm5hMnJZQjd5eVRDcEFNeFRnRTlwWVB3Z0Y2bVNDTWZGYUNi?=
 =?utf-8?B?OGNjODZqUGMxcTY3L0VPUFI1cDlwWXRwWHY5STVuSjBUVmloNUFGdWN4V1g0?=
 =?utf-8?B?azZNUllCNWNnSzAzUmxoTXVML0lvUUNTSEtsVHJlS1ZRK0pOb2NDRURWTlJI?=
 =?utf-8?B?MHNEc3JXYkE2bDhHSmdKRDhXT25vTjN1SHRKQXFObjV4ZkdIcDUxdUlHRWsy?=
 =?utf-8?B?SXErQTRPS28xZXdjdDRWQ0RGK2JybHRCdXBqbzA2UkJGeTFQU1Q1bk5yR2RL?=
 =?utf-8?B?dFhPZ1pmd2tHbHFHaGVENi9NNS9PUzlGYllPdEZuSkRvUXhMMHNQOXJnd1gx?=
 =?utf-8?B?Yy82TFBraGVRS1FRU2RFZks1UFdOVXQzQ2NsMy9jUjU5UTRuOThkZHl4c1Bo?=
 =?utf-8?B?UjY0TytYWklTUHVLSitoMmRvT2FGUG93clNaT1BZa2h5bGkvS3loVnl4Z1pJ?=
 =?utf-8?B?ak1KZW1Nam1Lbms3dnZHVUc1cldmd1lxakh3TC82VllNVzdqbTVNV00vU0ZM?=
 =?utf-8?B?bVZzeDFCYzRYVnlNU3kwaXhrSG92UnhrcUdqTi8xY1UyeXY4S1lmb0NXckYz?=
 =?utf-8?B?RnM4dFBCNGlWYXZzbHlONFF4c2UxMXpmSDhIRDMxYVEwYkE0eEFFbHBkS2Ew?=
 =?utf-8?B?UkhpbmV3WUwxTTJHMmMxOFVVTTIzN3VDR3JPc3Fnc0lFaE5iQ3lrQk5YUUVD?=
 =?utf-8?B?cFYrNTJoM3BvNXZkcGNTN1lmeHpVd01xditvVXhYbGVhZis3blJRdFJCVE9T?=
 =?utf-8?B?cWVrS1kxUTU2QitFbXpET3paQXdkMUwzV3R6Z3paTFZsSktldVlJTXJYQWlU?=
 =?utf-8?B?bVBqZVZZa2tUNzZKL3FhSjA0eXV0U1dkZ2dmWnQzSWZDK1JIMS9TUDc3UHlU?=
 =?utf-8?B?Sm5WZkQxWEYvdWNRTGxURTZsa2FJeFd1UU4wbWhBYjlUaEx5Nk5hclNxVndi?=
 =?utf-8?B?aDJVOG44RTlmYjl1S3BJOERhM2FDdDZBMFhVRW5VWWJNNUh3OFRvVEY5RU1m?=
 =?utf-8?B?ckpkdVhNU2kvN0k5d3hsOTFZREhyd1ErN3dVMEZDbzZDbW1XL3BNOTNXYmE2?=
 =?utf-8?B?QXhacENLYUxRd3BpRXRER2xpcEtGV25JbitUc0xYdVJkUWkvVUZrSDZWSmNG?=
 =?utf-8?B?ajR5V2IxcVdxOHZCcERXRGRicmhkeGhIemxlaDhmajZhZkdLMitWUkhTZWFa?=
 =?utf-8?B?Ulo0dTRycmEwUHUwVXN3UGJkbjhsRGsxdEZCWjZKMUdSZHZGUnZOSUV3blpZ?=
 =?utf-8?B?WDloT1JqMDQ1RXREWXFDVW42Tnl5VkdGWjYzTnJOYnEyWXEyZ3cvYTFZY0E4?=
 =?utf-8?B?ejdDd3lzK1FsYVM4dWhaZ21zRWNIb1F5OGhFV3FVR3BLVWc1UzhOd240Mlls?=
 =?utf-8?B?Vm9NYXNsd2dnaENTeEptYzUwWm1CSFhNb1Y2WUlKbk9PZWlEWVIzS2U3N2sv?=
 =?utf-8?B?bUg2aHhGdmJBLy9FZ0JnMDRrb0puUDhCVXpsMVJ6RkJFNlJidFd1dHVUazlE?=
 =?utf-8?B?T05KVklYTENNazlXNFF0UCsvOElnd0lUa1NUK0FCTXEwUk1UY1UrVnBhTHF6?=
 =?utf-8?B?dFdtY1FwK3N2OWlFdTRtQ2ZocmZJaW1IVW9PeGk2YmZHY1l0QlJpd3diNlc1?=
 =?utf-8?B?dzFBaCtUNXlEMjZ4NHhEUVhOaWxUWk92OHJpYjd2T05WMGZNQjBsMFZIN3ZS?=
 =?utf-8?B?VkE9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d5604e65-0d91-45d8-8502-08dbd4644b9c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 07:39:03.3204 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: htitFA3xcRzdgolR0YrfiJTJuTBckw9ibH9cE1ERCT+NRlvMewKJTmDrtyay/yTk4V6A6YaYd1LieHOzTVf2QdlmIXoWbnMR9rAuGf19xWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0070
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <673295B788253045BF7FA7A85506533B@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkNCg0KT24gb3VyIHdlZWtseSBtYXN0ZXIgdXBzdHJlYW0gQ0kgYnVpbGQgd2Ugbm90aWNlZCBW
ZXJkaW4gaU1YOE0gUGx1cyBib290IGxvb3BpbmcuDQoNCkJpc2VjdGluZyBwb2ludGVkIHRvIHRo
ZSBmb2xsb3dpbmcgY29tbWl0Og0KDQpjb21taXQgNGI0NDcyNDM4ZjVhICgiaW14OiBzcGxfaW14
X3JvbWFwaTogYXZvaWQgdHJpY2t5IHVzZSBvZiBzcGxfbG9hZF9zaW1wbGVfZml0KCkgdG8gZ2V0
IGZ1bGwgRklUIHNpemUiKQ0KDQpJdCBsb29rcyBsaWtlIHRoaXMgaW50cm9kdWNlZCBhIHJlZ3Jl
c3Npb24uDQoNCkJlZm9yZSBhbmQgYWZ0ZXIgY29uc29sZSBvdXRwdXQgKHdpdGggREVCVUcgZGVm
aW5lZCBpbiBhcmNoL2FybS9tYWNoLWlteC9zcGxfaW14X3JvbWFwaS5jKSBiZWxvdzoNCg0KQW55
IGNvbW1lbnRzPw0KDQpDaGVlcnMNCg0KTWFyY2VsDQoNCg0KQmVmb3JlOg0KDQpVLUJvb3QgU1BM
IDIwMjMuMTAtMDA5NjktZzk5NjBkNGE1NDAyLWRpcnR5IChPY3QgMjQgMjAyMyAtIDA5OjIwOjAz
ICswMjAwKQ0KVHJhaW5pbmcgRkFJTEVEDQpERFIgY29uZmlndXJlZCBhcyBzaW5nbGUgcmFuaw0K
U0VDMDogIFJORyBpbnN0YW50aWF0ZWQNCk5vcm1hbCBCb290DQpXRFQ6ICAgU3RhcnRlZCB3YXRj
aGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAwbXMgKDYwcyB0aW1lb3V0KQ0K
VHJ5aW5nIHRvIGJvb3QgZnJvbSBCT09UUk9NDQpCb290IFN0YWdlOiBQcmltYXJ5IGJvb3QNCkZp
bmQgaW1nIGluZm8gMHg0ODAyYjAwMCwgc2l6ZSAxMDQ0DQpOZWVkIGNvbnRpbnVlIGRvd25sb2Fk
IDEwMjQNCkRvd25sb2FkIDkzMjg2NCwgVG90YWwgc2l6ZSA5MzQ1NDQNCk5PVElDRTogIERvIG5v
dCByZWxlYXNlIEpSMCB0byBOUyBhcyBpdCBjYW4gYmUgdXNlZCBieSBIQUINCk5PVElDRTogIEJM
MzE6IHYyLjkocmVsZWFzZSk6djIuOS4wLTYxOS1nNWYwMWIwYjExDQpOT1RJQ0U6ICBCTDMxOiBC
dWlsdCA6IDExOjA4OjAyLCBTZXAgIDYgMjAyMw0KDQoNClUtQm9vdCAyMDIzLjEwLTAwOTY5LWc5
OTYwZDRhNTQwMi1kaXJ0eSAoT2N0IDI0IDIwMjMgLSAwOToyMDowMyArMDIwMCkNCg0KQ1BVOiAg
IEZyZWVzY2FsZSBpLk1YOE1QWzhdIHJldjEuMSAxNjAwIE1IeiAocnVubmluZyBhdCAxMjAwIE1I
eikNCltzbmlwXQ0KDQoNCkFmdGVyIChlLmcuIGNvbW1pdCA0YjQ0NzI0MzhmNSBvciBtYXN0ZXIp
Og0KDQpVLUJvb3QgU1BMIDIwMjQuMDEtcmMxLWRpcnR5IChPY3QgMjQgMjAyMyAtIDA5OjI4OjI2
ICswMjAwKQ0KVHJhaW5pbmcgRkFJTEVEDQpERFIgY29uZmlndXJlZCBhcyBzaW5nbGUgcmFuaw0K
U0VDMDogIFJORyBpbnN0YW50aWF0ZWQNCk5vcm1hbCBCb290DQpXRFQ6ICAgU3RhcnRlZCB3YXRj
aGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAwbXMgKDYwcyB0aW1lb3V0KQ0K
VHJ5aW5nIHRvIGJvb3QgZnJvbSBCT09UUk9NDQpCb290IFN0YWdlOiBQcmltYXJ5IGJvb3QNCkZp
bmQgaW1nIGluZm8gMHg0ODAyYjAwMCwgc2l6ZSAxMDQ0DQpOZWVkIGNvbnRpbnVlIGRvd25sb2Fk
IDEwMjQNCmRvd25sb2FkaW5nIGFub3RoZXIgMHhjOTAwMCBieXRlcw0KZG93bmxvYWRpbmcgYW5v
dGhlciAweDFhZTAwIGJ5dGVzDQoNCj0+IHRoaXMgY3Jhc2gvcmVzZXRzIGFuZCBib290IGxvb3Bz
IGZvcmV2ZXINCg==

