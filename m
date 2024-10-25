Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3482BD0C603
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 12:36:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCBEE89021;
	Fri, 25 Oct 2024 14:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="lj/g6SC2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC00A89020; Fri, 25 Oct 2024 14:36:35 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2072d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::72d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD26F8903B
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 14:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bs8CzY1N87K+DTNbpp82nercTq4HpfWvWCHu1+OzTX5uZRTtpfhQJQ9faJEjkVs749mhKR4HyRVHcBZD/eGsUb6uEvhO1YjkqAxQqiouEMBAQyqvoEeNB71phJbm2bZB5DO4DuZb4yL3WStbaEFFIA3UpVch0xkodRCfEvyJz7N5zKdjrcPQEFbAZreKx0QRuMl0QucdPoPTss5GiBzjHYaojwMyubTgDuNF4MJRIgfHXBMFCkFvbvMdf+jPtgACS5sgshnfq3cHgFq50MzHmgUNPFSRzCzIuiVV+snW90JkyoI4SLr2DwatYpW8FyxT4epUU/B80YSG6EPKOyFGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iQ/3EJrxXdrWFT2X85YuxEIWevEXnVyz8/fAA1rFm0=;
 b=tls/61/wrigcEDWYQSM4jddehy+CNunVjzhDtOzJwCf6f1CX5kiFZh/kVlDan+as13BaNbgx/P48QGIJkpkRT6w76lgHKcvmdQ1S4NUkNvDZ0ElqxegAGF3/lwhnxAfbKjeR9cHL+rl85LX1nMSEZrw1aNk2lp0YzzvwpkTmx04AjITKK7TJYYltOS4AEOGKFwO57pCfVwg+mlE/M5RAD2Xwo1lVKOpMj2jsCXFQzcyWytG573u+aKRkJHAeUW9P1Z4q83D6cIP2R7wcDo5UKGgPqn43h7fdQKeevD2AaR2lzKu+r8s742Sib1PvCQWjcVhNaoUO6mR/jWpAbGeW9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=gateworks.com smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iQ/3EJrxXdrWFT2X85YuxEIWevEXnVyz8/fAA1rFm0=;
 b=lj/g6SC2Y9mDA9hLkiecwC7gwcorWKZfOyuf+kY7jMPcvc4CGqamICmfOFPVrn8OU9g40mUcCwsGha7PhaZ3l1lEcFyOH89ovRqvxb23nD96c7499Qpipdklma33HAA+g2zQ4sMBDrafDY3LKXKhuvcRz9YJH/PD/3aD76WzQFQ=
Received: from DB7PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:10:36::22)
 by DB9P195MB1393.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.22; Fri, 25 Oct
 2024 12:36:27 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:36:cafe::20) by DB7PR05CA0009.outlook.office365.com
 (2603:10a6:10:36::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 12:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 25 Oct 2024 12:36:27 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 25 Oct
 2024 14:36:27 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 25 Oct 2024 14:36:27 +0200
From: Yannic Moog <Y.Moog@phytec.de>
To: "tharvey@gateworks.com" <tharvey@gateworks.com>
CC: "manut@mecka.net" <manut@mecka.net>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "sbabic@denx.de" <sbabic@denx.de>, Benjamin Hahn
 <B.Hahn@phytec.de>, PHYTEC Upstream <upstream@lists.phytec.de>,
 "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Teresa Remmet <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 0/6] imx8(m): add optee node to binman FIT image
Thread-Topic: [PATCH RFC 0/6] imx8(m): add optee node to binman FIT image
Thread-Index: AQHbJeLsQleb+mCFfk+ucgohzHwUuLKV5/yAgAFfugA=
Date: Fri, 25 Oct 2024 12:36:26 +0000
Message-ID: <730eb698b49281729d966c09a3035d14b800406a.camel@phytec.de>
References: <20241024-phytec_imx8m_optee-v1-0-fc6b78bf9a9b@phytec.de>
 <CAJ+vNU2vZM5B=BhNtsOHU-jGpSsAvR7Sfi91QCFRrOCMYX_Q5g@mail.gmail.com>
In-Reply-To: <CAJ+vNU2vZM5B=BhNtsOHU-jGpSsAvR7Sfi91QCFRrOCMYX_Q5g@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DA68785C1EC31D4F867F47F99ACEBFE8@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|DB9P195MB1393:EE_
X-MS-Office365-Filtering-Correlation-Id: 336d274a-b73a-4948-f864-08dcf4f1a53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R052aDErb0xKSC9Fc042NUh4aWVnNk9aOC9BN1poNFpmQjNsZ1hVUlV6MnNN?=
 =?utf-8?B?M2s2bjBSSlB5WUswWlZRWjJJRXErWHhjZzFlelptWW1SRWFnYjFUNU5taGxk?=
 =?utf-8?B?bVRLMmpSSVdtdXVISWd2UnNVVDhZYzFEK3Jndm5aSTZGbEhFNTlUYlU0d09v?=
 =?utf-8?B?cy9tc09veFc5M0dPTHg2NE93SU9UZUNYc0lqOHNoL013UW12RjRyc3dDVGFZ?=
 =?utf-8?B?U2hzTW1lZm1lSlRqN1dDQnlqemUwVTRkRlBoUExlYTdnZUxsVmtqNTNMbXFH?=
 =?utf-8?B?VVhoQ1FNTE1xOU9yVEphUXQzbnRuamVQUjRhRlNNRjJQUE5IcTVjbktVMzV5?=
 =?utf-8?B?ZlhPNzFKRkJxNWoyekpRRUdySEIvNFpsek9MUElORXVKUkJmUXRrL0NkNjEw?=
 =?utf-8?B?NEJGbzdzWlQyZ3pvTkJkY1A1cE5zdWpvTmt2NTRjTWtXNUlmOGtJd2UyeWov?=
 =?utf-8?B?WGZjWER2UVp6M2c0SndUWjhPaDQvMW9EYVlEaHEwRlhjUDJuemFZcVBLVGNM?=
 =?utf-8?B?QWlTVE01M0xIY0k2NTc0czMyUjE5NkxHZmR3OE9WOGFHbzFlcmZFa2lGQ0tj?=
 =?utf-8?B?clJvYmhUN2k4S25jQ2NUWEpMbHVlRTZzWERFbUN5Ym5JcTdzN2ZSMTg1OEVN?=
 =?utf-8?B?Y0Ewa0VMVloxNmVjalFmV3BNYk42WmpxQnYzaGM2Vkt2cUJ6ZmpRRWh2RDFV?=
 =?utf-8?B?d05yU0ltaVVyVHhIa1RSVzlNVHlpaERVdWhXTWFUTm81N3F5VWo4YllMSThp?=
 =?utf-8?B?S0Zjc3Q5bDBEZjRNVjFrR29GUEd6UmR4QSt5d2FIbFJXckgzL0ZGZGN3cElL?=
 =?utf-8?B?dWxEcXo2R0w2Qkd4Qm1VVUNTcDY2RXBDUkgzdnlRdGVINENPalM3QU5ueVBS?=
 =?utf-8?B?K0NPZ1JES2JGWHV6LzYvbGVWdlJBNXl5M3FUNkl6WTNPNk9mVktBd3p2aTNy?=
 =?utf-8?B?RG14NHk1enUyd09vTFZCK3dNSHJCVko1TVc5Z2t2OTlPblpTdTRvTnY4SFRJ?=
 =?utf-8?B?YUdBV3FBUDBHVzBBeUEwaVRxSm5zc0RsU08vTmpHVjVCQkpsRHFmNVYrSlRT?=
 =?utf-8?B?Y1NEZDVvSjFzbkFTVWpkV212QzF1VTkrdVZhWTJqTHBhbE1KSHNjNFRESmpG?=
 =?utf-8?B?bWVRV0hlZERKaERJdDdZdlk4MDhZYWJ0YjZZRi9Nd1VkVDZlWE0zYm9xcUNm?=
 =?utf-8?B?OGlGa3pVNUlJMzBoUkFNeVpyeUdDQ2VyU1dadDEyTWx6TDlHdDl5QWcvUU41?=
 =?utf-8?B?K0dCcGU0ZHR5LzkrdGtObEdUeEU0QkFua0dwbkpQK0tGeFBqMHhFbUp0T2JL?=
 =?utf-8?B?UDlyUlYvR0ZpSllYbVExRFBOcVc3U3RMVmxuWlRjSWRyOUVXSkFpK1RteXgy?=
 =?utf-8?B?ODh1SjdHbFIyYW1WUGZ0M0VpQTZaQUdYTXBLTFBuWWF6bzZQQVI3ZEJFQjMv?=
 =?utf-8?B?bHZpYk50QXRQNk5hMzBDOHBGZXZRYW9ENEN0VVppd2Z0OW81eG8rT205bS9p?=
 =?utf-8?B?aFJJZmJOZlcwRHFNUU43L0pSU1h1SklNUUdLR3FCUFB5Z2Q5S3lGNlV3V1B1?=
 =?utf-8?B?Q25QVTU2eXE4OWhBQmtNTURsckhVZi9BbmRqMVVPdnVSSklaOE85Q0krNHZs?=
 =?utf-8?B?Y0tBQjE5dEREQnB3SzJmZDduN3N1cXJZNmpCeHc2dFdGVTdGV1ZaTlJEbXdY?=
 =?utf-8?B?b09YR3VlUEZwZjg3UUdwVGdZNTdqdUhyTVQrMlNEL0pPNWxmWW9UOG1KckpL?=
 =?utf-8?B?d3dOV3RVTjFGa3krOGZONVUwZk5CeG5mbzVPeGFkMXI2VHhzUkdQcWVRQ0tl?=
 =?utf-8?Q?zfJ3BV/NpEpkX/wnMD28CXetbHpSjTQG7bwJc=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:36:27.5543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 336d274a-b73a-4948-f864-08dcf4f1a53a
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB1393
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

SGV5IFRpbQ0KDQpPbiBUaHUsIDIwMjQtMTAtMjQgYXQgMDg6MzcgLTA3MDAsIFRpbSBIYXJ2ZXkg
d3JvdGU6DQo+IE9uIFRodSwgT2N0IDI0LCAyMDI0IGF0IDEyOjA04oCvQU0gWWFubmljIE1vb2cg
PHkubW9vZ0BwaHl0ZWMuZGU+DQo+IHdyb3RlOg0KPiA+IA0KPiA+IFRoZXJlIGhhdmUgYmVlbiBh
dHRlbXB0cyB0byBnZXQgb3AtdGVlIG5vZGUgaW50ZWdyYXRlZCB1cHN0cmVhbSBpbg0KPiA+IHRo
ZQ0KPiA+IHBhc3QgWzFdWzJdLiBUaGUgY2hhbGxlbmdlIGlzIG9uIGhvdyB0byBoYW5kbGUgdGhl
IGxvYWQgYW5kIGVudHJ5DQo+ID4gYWRkcmVzc2VzIHdoZXJlIHRoZSBvcC10ZWUgaW1hZ2Ugc2hv
dWxkIGJlIGxvYWRlZCB0by4NCj4gPiBEaWZmZXJlbnQgU29DIGZhbWlsaWVzIGFuZCBhcmNoaXRl
Y3R1cmVzIGhhdmUgZGlmZmVyZW50IFJBTSBiYXNlDQo+ID4gYWRkcmVzc2VzLiBGdXJ0aGVyIHRo
ZSBmaW5hbCBhZGRyZXNzZXMgY2FuIHZhcnkgZnJvbSBib2FyZCB0byBib2FyZA0KPiA+IChlLmcu
IGRlcGVuZGluZyBvbiBwb3B1bGF0ZWQgUkFNIHNpemUpLg0KPiA+IEFzIGEgcmVzdWx0LCBJIHBy
b3Bvc2UgdG8gc29sdmUgdGhlIGlzc3VlIHZpYSBkZXZpY2UgdHJlZSB3aGVyZSB0aGUNCj4gPiBv
cHRlZSBub2RlIGl0c2VsZiBpcyBkZWZpbmVkIHRoZSBzYW1lIGFzIGluIHByZXZpb3VzIHNvbHV0
aW9ucy4NCj4gPiBUaGUgZGlmZmVyZW5jZSBpbiB0aGlzIGFwcHJvYWNoIGlzIHRvIG9taXQgdGhl
ICdsb2FkJyBhbmQgJ2VudHJ5Jw0KPiA+IHByb3BlcnRpZXMgZnJvbSB0aGUgbm9kZSBkZWZpbml0
aW9uIGluIHRoZSA8c29jPi11LWJvb3QuZHRzaS4NCj4gPiBUaGVzZSBtdXN0IGJlIGRlZmluZWQg
aW4gdGhlIDxib2FyZD4tdS1ib290LmR0c2kuDQo+ID4gDQo+ID4gVGhpcyBzb2x1dGlvbiBhdm9p
ZHMgdGhlIHJvdXRlIHZpYSBrY29uZmlnIHdoaWxlIHN0aWxsIGFsbG93aW5nDQo+ID4gZWFjaA0K
PiA+IGJvYXJkIHRvIGluZGl2aWR1YWxseSBkZWZpbmUgdGhlIG9wLXRlZSBsb2FkIGFkZHJlc3Mu
DQo+ID4gVGhpcyBpcyBwb3NzaWJsZSBhcyB0ZWUtb3Mgbm9kZSBoYXMgdGhlICdvcHRpb25hbCcg
cHJvcGVydHkuDQo+ID4gVGhlcmUgaXMgbm8gbmVlZCB0byBrZWVwIHBhcnRzIGluICNpZmRlZnMg
d2hlbiBubyBvcHRlZSBpbnRlZ3JhdGlvbg0KPiA+IGlzDQo+ID4gZGVzaXJlZCBvciBwb3NzaWJs
ZQ0KPiA+IA0KPiA+IEkgaW5jbHVkZWQgdXNhZ2UgZm9yIFBIWVRFQyBib2FyZHMgZm9yIGV4YW1w
bGVzICh3aXRoDQo+ID4gZG9jdW1lbnRhdGlvbikuDQo+ID4gDQo+ID4gVGhlcmUgaXMgb25lIGNh
dmVhdCBob3dldmVyOg0KPiA+IFRoZSBzZXJpZXMgaW4gaXRzIGN1cnJlbnQgZm9ybSB3b3VsZCBi
cmVhayBhbGwgb3RoZXIgaW14OG17bSxuLHB9DQo+ID4gYm9hcmRzLiBUaGlzIGlzIGR1ZSB0byB0
aGUgZmFjdCB0aGF0IHRoZXkgZG8gbm90IGRlZmluZSBlbnRyeSBhbmQNCj4gPiBsb2FkDQo+ID4g
YWRkciBmb3IgdGhlIHRlZSBlbnRyeS4NCj4gPiBEdXJpbmcgcnVudGltZSwgc3BsX2xvYWRfc2lt
cGxlX2ZpdCBmYWlscyBmb3IgdGhlIE9QLVRFRSBub2RlIChubw0KPiA+IGxvYWQNCj4gPiBhZGRy
KS4NCj4gPiANCj4gPiBbLi4uXQ0KPiA+IENhbid0IGxvYWQgdGVlOiBObyBsb2FkIGFkZHJlc3Mg
YW5kIG5vIGJ1ZmZlcg0KPiA+IHNwbF9sb2FkX3NpbXBsZV9maXQ6IGNhbid0IGxvYWQgaW1hZ2Ug
bG9hZGFibGVzIGluZGV4IDEgKHJldCA9IC0NCj4gPiAxMDUpDQo+ID4gbW1jX2xvYWRfaW1hZ2Vf
cmF3X3NlY3RvcjogbW1jIGJsb2NrIHJlYWQgZXJyb3INCj4gPiBTUEw6IGZhaWxlZCB0byBib290
IGZyb20gYWxsIGJvb3QgZGV2aWNlcw0KPiA+IA0KPiA+IFszXSBzdWdnZXN0cyAoQW55IGFic2Vu
dCBlbnRyaWVzIGFyZSBkcm9wcGVkIGltbWVkaWF0ZWx5KSB0aGF0DQo+ID4gdXNpbmcgdGhpcyBw
cm9wb3NlZCBzb2x1dGlvbiBzaG91bGQgd29yayBhbmQgaXMgYWxsb3dlZC4gSG93ZXZlcg0KPiA+
IFs0XSBvbg0KPiA+IHRoZSBvdGhlciBoYW5kIGNsZWFybHkgc3RhdGVzIHRoYXQgdGhlIGVudHJ5
IGRvZXMgbm90IGdldCByZW1vdmVkDQo+ID4gKHdoaWNoDQo+ID4gaXMgdGhlIGNhc2UpLCByYXRo
ZXIgaXRzIGRhdGEgc2V0IHRvIDAuDQo+ID4gDQo+ID4gVG8gbWUgdGhlIHF1ZXN0aW9uIG5vdyBp
cyBvbiBob3cgdG8gbW92ZSBmb3J3YXJkLg0KPiA+IC0gSXMgbXkgcHJvcG9zZWQgc29sdXRpb24g
dW5kZXNpcmVkIGluIHRoZSBzZW5zZSB0aGF0IEkgdHJ5IHRvIHVzZQ0KPiA+IGENCj4gPiDCoCBt
ZWNoYW5pc20gdGhhdCBjdXJyZW50IFUtQm9vdC9iaW5tYW4gaXMgbm90IGRlc2lnbmVkIGZvcj8N
Cj4gPiAtIFNob3VsZCBsb2FkX3NpbXBsZV9maXQgY2hlY2sgYW5kIGRpc2NhcmQgb3B0aW9uYWwg
ZW50cmllcyByaWdodA0KPiA+IGF3YXkNCj4gPiDCoCBiZWZvcmUgZG9pbmcgYW55IG90aGVyIHBy
b2Nlc3Npbmc/DQo+ID4gLSBTaG91bGQgYmlubWFuIGJlIGNoYW5nZWQgc28gdGhhdCBvcHRpb25h
bCBlbnRyaWVzIGRvIGluIGZhY3QgZ2V0DQo+ID4gwqAgcmVtb3ZlZCBpbnN0ZWFkIG9mIGJlaW5n
IHplcm9lZD8NCj4gPiANCj4gPiBJIGFtIGFza2luZyBmb3IgaGVscCByZWdhcmRpbmcgdGhlIHF1
ZXN0aW9ucyBhYm92ZSBzaW5jZSB0aGF0IGlzDQo+ID4gbm90IG15DQo+ID4gYXJlYSBvZiBleHBl
cnRpc2UuDQo+ID4gDQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L3Vib290L3BhdGNoLzIwMjMwNjIyMTczMDA2LjM5MjE4OTEtMS10aGFydmV5QGdhdGV3
b3Jrcy5jb20vDQo+ID4gWzJdDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9q
ZWN0L3Vib290L3BhdGNoL1plSERWci1Cem05MzUtNU5AbWVja2EubmV0Lw0KPiA+IFszXQ0KPiA+
IGh0dHBzOi8vZG9jcy51LWJvb3Qub3JnL2VuL2xhdGVzdC9kZXZlbG9wL3BhY2thZ2UvYmlubWFu
Lmh0bWwjb3B0aW9uYWwtZW50cmllcw0KPiA+IFs0XQ0KPiA+IGh0dHBzOi8vZG9jcy51LWJvb3Qu
b3JnL2VuL2xhdGVzdC9kZXZlbG9wL3BhY2thZ2UvYmlubWFuLmh0bWwjaW1hZ2UtZGVzY3JpcHRp
b24tZm9ybWF0DQo+ID4gc2VlIG9wdGlvbmFsOiBkZXNjcmlwdGlvbiBpbiBbNF0NCj4gPiANCj4g
PiAtLS0NCj4gPiBZYW5uaWMgTW9vZyAoNik6DQo+ID4gwqDCoMKgwqDCoCBhcm06IGR0czogaW14
OG06IGFkZCBmaXQgb3B0ZWUgbm9kZQ0KPiA+IMKgwqDCoMKgwqAgYXJtOiBkdHM6IGlteDhtcC1w
aHlib2FyZC1wb2xsdXg6IGFkZCBvcHRlZSBsb2FkIGFkZHJlc3MNCj4gPiDCoMKgwqDCoMKgIGFy
bTogZHRzOiBpbXg4bW0tcGh5Z2F0ZS10YXVyaS1sOiBhZGQgb3B0ZWUgbG9hZCBhZGRyZXNzDQo+
ID4gwqDCoMKgwqDCoCBhcm06IGR0czogaW14OG1tLXBoeWJvYXJkLXBvbGlzOiBhZGQgb3B0ZWUg
bG9hZCBhZGRyZXNzDQo+ID4gwqDCoMKgwqDCoCBkb2M6IHBoeXRlYzogaW14OG1wOiBhZGQgT1At
VEVFIGRvY3VtZW50YXRpb24NCj4gPiDCoMKgwqDCoMKgIGRvYzogcGh5dGVjOiBpbXg4bW06IGFk
ZCBPUC1URUUgaW50ZWdyYXRpb24gaW5zdHJ1Y3Rpb25zDQo+ID4gDQo+ID4gwqBhcmNoL2FybS9k
dHMvaW14OG1tLXBoeWJvYXJkLXBvbGlzLXJkay11LWJvb3QuZHRzaSB8wqAgNSArKysrKw0KPiA+
IMKgYXJjaC9hcm0vZHRzL2lteDhtbS1waHlnYXRlLXRhdXJpLWwtdS1ib290LmR0c2nCoMKgwqAg
fMKgIDUgKysrKysNCj4gPiDCoGFyY2gvYXJtL2R0cy9pbXg4bW0tdS1ib290LmR0c2nCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1DQo+ID4gKysrKysrKysrKysrLQ0K
PiA+IMKgYXJjaC9hcm0vZHRzL2lteDhtbi11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMTUNCj4gPiArKysrKysrKysrKystDQo+ID4gwqAuLi4vYXJt
L2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay11LWJvb3QuZHRzaSB8wqAgNSArKysrKw0K
PiA+IMKgYXJjaC9hcm0vZHRzL2lteDhtcC11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMTUNCj4gPiArKysrKysrKysrKystDQo+ID4gwqBkb2MvYm9h
cmQvcGh5dGVjL2lteDhtbS1waHlnYXRlLXRhdXJpLWwucnN0wqDCoMKgwqDCoMKgwqAgfCAyNg0K
PiA+ICsrKysrKysrKysrKysrKysrKysrKy0NCj4gPiDCoGRvYy9ib2FyZC9waHl0ZWMvcGh5Y29y
ZS1pbXg4bW0ucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjUNCj4gPiArKysr
KysrKysrKysrKysrKysrKy0NCj4gPiDCoGRvYy9ib2FyZC9waHl0ZWMvcGh5Y29yZS1pbXg4bXAu
cnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjYNCj4gPiArKysrKysrKysrKysr
KysrKysrKystDQo+ID4gwqA5IGZpbGVzIGNoYW5nZWQsIDEzMSBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQ0KPiA+IC0tLQ0KPiA+IGJhc2UtY29tbWl0OiBmZDNmMmUzZjBlZGMxZjg3YmU0
YzVhMzlhMGM4MTAzN2Q1NTFjMDY5DQo+ID4gY2hhbmdlLWlkOiAyMDI0MDkwMy1waHl0ZWNfaW14
OG1fb3B0ZWUtODY3NGVmMDEyYTM2DQo+ID4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IC0tDQo+
ID4gWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+DQo+ID4gDQo+IA0KPiBIaSBZYW5uaWMs
DQo+IA0KPiBUaGFua3MgZm9yIGxvb2tpbmcgYXQgdGhpcyAtIHRoZXJlIGlzIGEgbmVlZCBmb3Ig
YSBzb2x1dGlvbiBmb3INCj4gZWFzaWVyDQo+IGludGVncmF0aW9uIG9mIGEgVEVFLg0KPiANCj4g
V2hhdCBpcyB3cm9uZyB3aXRoIGFkZGluZyB0aGUgYWRkcmVzcyB2aWEgS2NvbmZpZz8gTXkgYXR0
ZW1wdCBbMV0NCj4gZmFpbGVkIGR1ZSB0byBzb21ldGhpbmcgaW4gQ0kgdGhhdCBJIGp1c3QgZGlk
bid0IGtub3cgaG93IHRvIGZpeCBvcg0KPiBoYXZlIHRoZSB0aW1lIHRvIGxvb2sgaW50by4NCg0K
VGJmIHRoZXJlIGlzIG5vdGhpbmcgd3Jvbmcgd2l0aCB0aGF0IGFwcHJvYWNoLiBUSSBrMyB1c2Ug
c3VjaCBhDQpzb2x1dGlvbiBhbHJlYWR5IFsxXS4NCg0KSSBmaW5kIGl0IHBvbGx1dGVzIGtjb25m
aWcgdW5uZWNlc3NhcmlseSwgYnV0IGl0IHdhcyBteSBiYWNrdXAgc29sdXRpb24NCmluIGNhc2Ug
dGhpcyBvbmUgZG9lcyBub3Qgd29yayBvciBpcyBub3Qgd2VsbCByZWNlaXZlZC4gRG8geW91IHBy
ZWZlcg0KdGhlIGtjb25maWcgcm91dGU/DQoNCllhbm5pYw0KDQpbMV0NCmh0dHBzOi8vZ2l0aHVi
LmNvbS91LWJvb3QvdS1ib290L2Jsb2IvMDhhZTEyYmU4NTA5ZGFmM2QxYzVhMTQ4YjhhNTBjMGZm
YjY0NTdjMi9hcmNoL2FybS9tYWNoLWszL0tjb25maWcjTDEzNQ0KDQo+IA0KPiBCZXN0IFJlZ2Fy
ZHMsDQo+IA0KPiBUaW0NCj4gWzFdDQo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJv
amVjdC91Ym9vdC9wYXRjaC8yMDIzMDYyMjE3MzAwNi4zOTIxODkxLTEtdGhhcnZleUBnYXRld29y
a3MuY29tLw0KDQo=
