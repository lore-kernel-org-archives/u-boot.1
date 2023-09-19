Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD15ACD5BA6
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CC986B1D;
	Tue, 19 Sep 2023 14:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="laTckwpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70D9A86ADC; Tue, 19 Sep 2023 09:35:31 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1a::60a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F4686A3C
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDkLzgGJEvvT8YWtlMHknTURdxmiWAjX+XvRpyikpgvxfxKqLcnQSK9UPKUkUKJ822cLv7zHSDkVNbAnMmJo2bRRlFnagWPMYz3FtGc9y5c+sGhyr7gbtu76HHwtEES40JDHvf8Lx/hE7rjDtfkfIUvdg6a1iiCtwUKJjkwGYNvXjhPv/uElMm2WqBevfksv7UFeZUwQ4DdrjVXT0UoGL2YYXfLK96i9Z7unusbG11xGdwvXwRcLcauMgqtUyTc9/aPwcR4tgJqlpJ1kXFvrnMVcF+dbBHK4Mxy+MyonpcCqvhjdFtqmqlANjKErsnyMXEFN+yn/kLhKgfI2TmLlNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zWVwcBp+RTNZ504EW+ayfJqxTC8k1xrTOQTCStxD77k=;
 b=oa8BDs4R6u2LX2Ik05NLQ2LB82PBx77lnbBiaswTQjINWQ9SRQSwx+YW421jhYfXXp5mweMB5RIYKfYI9LSlnucA1yv9RdIcp5Heod39c1ApXcXucLnL6FnDeEH95mzrD7ZHxBtqokpmLni9v3i5lD9pgfy29XHohLitXsCEDl7h93dGGlIlFK9WcpTM8ZK5x3lPM8wxZNhcGIk4oLOutgTZP7T3BWY6fAlhkgJTiqpykgaex3+CLoDxXaGqiZTjzCLJBcEurumZWLStYbtonYxdYfG1L8y7fDLfH0I0wMgsBsYEyTzoSzwIIXzRGU0A+zIehmdhRxjJTu/BoycSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWVwcBp+RTNZ504EW+ayfJqxTC8k1xrTOQTCStxD77k=;
 b=laTckwpQ6ww5gZ9JUWtwO2FGZfKFWyI2JQu2nMDieUbhmMHDwkvmlZVw8MWrrzNlEmUCfrxnQIqt/goev1tdTvZD+OCWbvv/HwDNW/eqr7PU4a2e25QcAVTYQ3RfoZEiznxcgwKF4teP3HRcS7uuWuF8x1gIRNB6A+E7dOGUZW7VVUlh2jxraVKh5rWfl2xnUqOFSd4EyNbqr1nlGPFsEMacLFCgv17dOJI8OWRI/s034R7bsJD8yLZ0CH+adMDOhD+ptkIqDqHNoVGAVEEjShVKBdHEplv2khzQBwTzDhBMHm9n8YkChnC2GKch6yJrwpoo3EGUxqSdnFLR1xdscg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by PAWPR10MB7104.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 07:35:27 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 07:35:27 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>
CC: "a-govindraju@ti.com" <a-govindraju@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "g-vlaev@ti.com" <g-vlaev@ti.com>, "d-gole@ti.com"
 <d-gole@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "nm@ti.com"
 <nm@ti.com>, "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH v2 4/8] arm: dts: k3-am625-sk: Enable emmc in SPL
Thread-Topic: [PATCH v2 4/8] arm: dts: k3-am625-sk: Enable emmc in SPL
Thread-Index: AQHZ6svcxUhU/q6h+0WN8ZiIH87TnA==
Date: Tue, 19 Sep 2023 07:35:27 +0000
Message-ID: <4b593377588ba713229c6671edf0c0848a857bf4.camel@siemens.com>
References: <20230406185542.1179073-1-sjoerd@collabora.com>
 <20230406185542.1179073-5-sjoerd@collabora.com>
In-Reply-To: <20230406185542.1179073-5-sjoerd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|PAWPR10MB7104:EE_
x-ms-office365-filtering-correlation-id: a13b9f5d-b385-4d0c-f630-08dbb8e2feb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +TsbRm2au42TE7XwkNRi8uEpubJcoiU59ZuLCNtivfA5ni7wGbPoUdfW81nN98L9qTS1yADOI9d6A7lCuvtdFhDVK3Q24mkQiG2HBILAWw8NNqbg6zNvBkC/0i740uiAzhQs02jWOkMD59s8BAgGiT4p4ZeN8wyBcPmrwNTL4Pt77KnSOF4IHLQAr8VfavhJP/U37J7CbYj2Jr11I8o58knHOLjCw6uZf1/Emr/Vdsuxs7Nqzg18qEAsHZRlc3uu+z7Xaai17QWwPxfML6cELvyIpb3oqmxC2cRgRS63g3ZHyrAa6XpnosVWSYNyid3Xl689p+Bd50jwFNKyRThKSWk3qS7D2wtBLTOlxhJaja5b1ep2PnpYLS4wqO+T/fgk/hC/WfGGvS5/5YLccswdL9WJptYDTbU+K1jTL0MAFirmmTscH0GRPxvaOo0BvAkb2PBxL6/zzfFoVchij9d6wAFg8pW0GhITIK4hDXSVsl1w7M3+4bSZ1AFYglZ+jrABCAsb7+54l9DtT1cTy6pTfOD0sQpZW9V1zeHS2hw9/ivZF2LgmAkTCx3WphkewYOCj+IdxERVxfWBNcFRkjdA4oWELqHFp3HJR4odJ5ewklG4GYVQurQ2E/eSwDmOw0QfwAl0jJHz9sjZT/KJLSVNqQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199024)(186009)(1800799009)(15974865002)(122000001)(82960400001)(36756003)(6486002)(4744005)(2616005)(71200400001)(26005)(66556008)(55236004)(6506007)(6512007)(66476007)(478600001)(316002)(64756008)(54906003)(66446008)(86362001)(76116006)(66946007)(110136005)(91956017)(38100700002)(2906002)(5660300002)(4326008)(38070700005)(8676002)(41300700001)(8936002)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDFrWllLSjRtNFlZWnNOQnp6ZUpEczFUOWZhbWNYVWlQbnBPUFRoWGVCWGFz?=
 =?utf-8?B?QnBxd1dNUHJnS0M4Y1NoTCt1Q0dTZUVnVmVGNnl2dDZleit1cHpUenFLQzkr?=
 =?utf-8?B?SkJBdlUxaTkzUUlBSThMNWhEM3Q3WUlaNDlBU2hsUWxGTnFKSDJ1QnJDSmNW?=
 =?utf-8?B?dHlxUFFoT2lOQzJDVlZkZTg4MzcwK0RxZkNOYlZPR0Z5R1VlcG02ZlZsN0Fh?=
 =?utf-8?B?dkxDdnlpL3lpZnErek0vZzdxMzc2OWh3M3RDZkh4eDRIditXeXk2TWRZcTBm?=
 =?utf-8?B?akgxLzFUUFQzNEJydVJ5SldUeVJTTzd4eTF5WmtNMnZkOXJrU3JVVXVwMEJM?=
 =?utf-8?B?TjNzYzcrczlRZmRrclJaOTNDcDh3U3BWL3VtdHhOclRKbWVya09TbXkvUkJL?=
 =?utf-8?B?amlXdWNlckE0amMxUGFpeUhDVXdzWG8vWHZzZDNzMkd0b0tKOVpKVzRycWdC?=
 =?utf-8?B?MldGUEZWcXFyRFZZd2RET2FycmQ2aG1Fd1NzdGhmRzNzUTBidXQ5TjdlVmNN?=
 =?utf-8?B?Uk9PaU95SjJoZGZpb2NiRkFHaXRUWGc2ZU82SWsyVFpFanpUNVB0VjV6aXlD?=
 =?utf-8?B?bzBuTndnOFQrUERVcGdNYmtHcWpzLzdGdTdRRGhpWmRhOGkwYkI4d3c3ZDRH?=
 =?utf-8?B?M0dCR25FV2tiUkVsTmN4bExMbDhveTBKcEgwNU1pdklSd0Faa0llWkM4MVJ2?=
 =?utf-8?B?Q3ZPc0FLcG5PVS9WeHFyNmJJZGh2OWl5TTdrMU1mZ0FPdklTbmFNRUZOcmp4?=
 =?utf-8?B?U1YvcGFYNjFjODBhYlVqc2lyaXFhR1Jyc1hOUzFVWE9TRU5PK0kwemd0Z2NO?=
 =?utf-8?B?RnN5by83RHBsVjMrZStyZG1MWUVKbTdZdmR0Qm1RK21Rdnh4V1hUZWR1dWI3?=
 =?utf-8?B?K2h4UStXL2M1QUNUUEpCWXhkUFVkREJ0UHB3bWI1emk2clRtR0paa3MzL3FS?=
 =?utf-8?B?Zno5elJlMHZvMzQxS2llQnNpTFZ0MTE3YTZHMEh4MEZORDZkSy95ZzkzNzZs?=
 =?utf-8?B?d3NWYlpZRzB1Q2pmRG80RCtiSW9tcGlJUmprWDJTZGlVcHAvdms4Q1g0Vnh2?=
 =?utf-8?B?VU4rbG53MUV6MjdxaWNTZEJEQ3Jka3kvdHdrb1ExOEhHU2gwcTNNaDhKQ2Mz?=
 =?utf-8?B?MVg1UnVqVk03NW1DRkpRNEgrZ2xzZUNKVjlpNjFyL3JhVG9qR1llM0UzUjUy?=
 =?utf-8?B?bXY2NTdQdkhVbDFBUWhuYTJSU3F4dDNHTUZVb3lrTnNpY05jdmJCb29MOEhN?=
 =?utf-8?B?cmt5WUFqQmJoY3hDMU9Id2hQdEVqak5jcVQ3YktsbStmWS90djRHYk8zN2sw?=
 =?utf-8?B?dlU2SDBBSGg2MDg3NERqQnAxNXpTSHkyZVk3Z3BLQ1lvQ01VTW9VcDk1MlNm?=
 =?utf-8?B?K1gvMkhqY05NV1MzakM5N0tTTG9LWUNiL256VnAvN0kzeXVWd3lTa1czNWpk?=
 =?utf-8?B?aERBckdsMUFqQVJYTElkYk41dEpHQ1pwWnlOYjg2UDZiN0xHcVIxL2ZCTzFH?=
 =?utf-8?B?VEZ6azFoOFptN2pKV1ZsdkVZU3UrUWUzT2dhd2RyTGR0Ukp6K3VJK0VvdHlm?=
 =?utf-8?B?U3BKTGdvS2t2TlJ2QnpIL1cvWTZ1ZmgzWXRxU05kSWxRbUl1bTVGYzFDRDR1?=
 =?utf-8?B?QVZSWkRuYUQ0QlQra2tucC9jckVXOUpJU2c0OXAyU0Z6bWZidmpuWTIrWGUx?=
 =?utf-8?B?Vmg3YWNZckJRNGl6VjFxK25FRy9BVVI5YTRYVDI5YVIyYU5DblhvNWZjbzVS?=
 =?utf-8?B?YnB0UHBlNEt5QzA0enFlWDBNZU1kbGhSbU1ZaUQrY0dCbElEY1lVSTlscUNv?=
 =?utf-8?B?Wk1hcUlqNlR1cjNLWnRTT2pLR214cG9UN1lnTCtZYnAzV0JURjRlc3hFcU1W?=
 =?utf-8?B?THNHSWszYTVTVUFSakE1TmsxdWtpQU45Sm9NUkVmUGF4ZHcxbmE4Z0NmWUVz?=
 =?utf-8?B?UnZaVmo5WlhYbE1SUFprV2N5WVRDU01nRkdmdnlEbW0rbVh1Q1d4bTZwZTlu?=
 =?utf-8?B?QTlTREFmWEVKOVRxMnZGbDJ5bWpnYkxVdFlHcjRMVXg5T3kxeVVJaDczT2Zj?=
 =?utf-8?B?d0FDcDB3bkdkUXUrNlFpT3kzdmpwSys2dkI3aGhRL1Q3akg0ZGlJa3VXZGJm?=
 =?utf-8?B?RUc2Rnl4Q3k2NUlTSnZ4S0dDYUFKUEtrSG0zbjZzM2hNY0JJWW81dlc2d2dq?=
 =?utf-8?Q?kl0bZdm29E0z+YeCgNxI+jM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C34F747B6A48FF4392236714EAB0BC7D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a13b9f5d-b385-4d0c-f630-08dbb8e2feb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 07:35:27.7829 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: af0LgVHjeYpKLsaAgYWtlfRsisxHj2XCv3FSauj94aWQUItEIvwK1dl/y/vU4ehd2MyCsrR2WKdYOE543EWJdplcE2XWJrLJi3M+gwkPZac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7104
X-Mailman-Approved-At: Tue, 19 Sep 2023 14:08:23 +0200
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

SGVsbG8gU2pvZXJkLA0KDQpPbiBUaHUsIDIwMjMtMDQtMDYgYXQgMjA6NTUgKzAyMDAsIFNqb2Vy
ZCBTaW1vbnMgd3JvdGU6DQo+IHNkaGNpMCBvbiB0aGUgazMtYW02MjUtc2sgaXMgdGhlIGVtbWMs
IGVuYWJsZSB0aGlzIGluIFNQTCBhcyB3ZWxsIHRvDQo+IGFsbG93IGJvb3RpbmcgZnJvbSB0aGF0
IG1lZGlhLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2pvZXJkIFNpbW9ucyA8c2pvZXJkQGNvbGxh
Ym9yYS5jb20+DQo+IFJldmlld2VkLWJ5OiBUb20gUmluaSA8dHJpbmlAa29uc3Vsa28uY29tPg0K
DQp0aGFua3MgZm9yIHRoZSBwYXRjaCEgSSd2ZSB0ZXN0ZWQgdGhlIGVNTUMgYm9vdCBvbiBBTTYy
NSBTSw0KYW5kIHRoaXMgd2FzIGV4YWN0bHkgdGhlIG1pc3NpbmcgcGllY2UsIHdpdGggdGhlIHBh
dGNoIGl0IGJvb3RzIGZpbmU6DQoNClRlc3RlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IA0KPiAobm8gY2hhbmdlcyBz
aW5jZSB2MSkNCj4gDQo+IMKgYXJjaC9hcm0vZHRzL2szLWFtNjI1LXNrLXUtYm9vdC5kdHNpIHwg
OCArKysrKysrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvazMtYW02MjUtc2stdS1ib290LmR0c2kgYi9hcmNoL2Fy
bS9kdHMvazMtYW02MjUtc2stdS1ib290LmR0c2kNCj4gaW5kZXggMGRlZjg0YjRjZjAuLjVmOTBh
NGI1NmYxIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvazMtYW02MjUtc2stdS1ib290LmR0
c2kNCj4gKysrIGIvYXJjaC9hcm0vZHRzL2szLWFtNjI1LXNrLXUtYm9vdC5kdHNpDQo+IEBAIC05
Miw2ICs5MiwxNCBAQA0KPiDCoMKgwqDCoMKgwqDCoMKgYm9vdHBoLXByZS1yYW07DQo+IMKgfTsN
Cj4gwqANCj4gKyZzZGhjaTAgew0KPiArwqDCoMKgwqDCoMKgwqBib290cGgtcHJlLXJhbTsNCj4g
K307DQo+ICsNCj4gKyZtYWluX21tYzBfcGluc19kZWZhdWx0IHsNCj4gK8KgwqDCoMKgwqDCoMKg
Ym9vdHBoLXByZS1yYW07DQo+ICt9Ow0KPiArDQo+IMKgJnNkaGNpMSB7DQo+IMKgwqDCoMKgwqDC
oMKgwqBib290cGgtcHJlLXJhbTsNCj4gwqB9Ow0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0K
U2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
