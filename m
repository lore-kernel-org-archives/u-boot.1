Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD160CF34C3
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 21:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33CAD88EAB;
	Thu,  3 Oct 2024 23:28:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5406888EBA; Thu,  3 Oct 2024 19:23:45 +0200 (CEST)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn
 (mail-sh0chn02on2070c.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4420:2::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D3F88CC3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 19:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYoHJ8lSgA2MMKCUD2rUsuppPrJGAAdGhhKpfR1+5qb+8RON2Eon8UmSeBn2PtBuvzEdngvE6B5F4f/wb44f1fr0cYuANxMHIgMe5jCzrTFYUWywr6JatzMFor7jw79vtTZYvoSlAZHWxMtTRI2QXSnh3lGSUFy+OslLiOEnKyBT6651q3L5YhdHVVu0r372lolrouhxzrRipLY8PJkwVo8epWEQfS4RSySEFSLKOGV4Gs3BXpibAHokw6vRpyMo9XK5pOZBTGAqNwdEF30Oqdfj4cURwQaeyB2ZmsFNRxj2e0fHAFanIYMFYPEfoO/sdjSVsl/rkNuD9PW1gymqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9dA0lhsxNFSqb9FfftCY2jn/pXSmysbRkzaZNhiXLY=;
 b=DTsKruwwF+RQiYstOtDX9qN6JpbvkN4D6b/0RdIoyxsktjq6m5f++uYeyZ7S02vUYk5zBBfNTK3Gbk3h5zkfFImITdPdkES7+LHGX4w39wOCx7cqeQ6LmktJ4NYOjzfAvo8lEg2ybkM3AGddiWv+J6YANpFOWnjJ88GMybOxCYuQ2551vZOCJEfRILwu5oAxyG0or2TyhXU1mSfIWvoBIiDzYOKUjxRTW2wK+30kx0UogBu9nHJuCsqKDjnutvN/RH5boO0PHWac/1+8lALUotY1n5zeGHQR1AGpcnCdcr0VFsuhiFOG3olPQR7zhO9/QPA7yyxcJexQ7SgD/Gr9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1292.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.30; Thu, 3 Oct
 2024 17:23:35 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%4]) with mapi id 15.20.8005.029; Thu, 3 Oct 2024
 17:23:35 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
CC: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>, Sumit Garg
 <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>, H Bell
 <dmoo_dv@protonmail.com>, E Shattow <lucent@gmail.com>, Nam Cao
 <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Subject: RE: [PATCH v1 00/12] Support OF_UPSTREAM for StarFive JH7110
Thread-Index: AQHbE1G6UM71ZOVyWEyp8aL+XAUM7bJwnUKAgASonEA=
Date: Thu, 3 Oct 2024 17:23:34 +0000
Message-ID: <ZQ2PR01MB1307BD4AFB3EAB5254E979C8E6712@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1292:EE_
x-ms-office365-filtering-correlation-id: 6fbaa87c-caa8-4d32-d9c0-08dce3d01c6f
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|41320700013|7416014|38070700018; 
x-microsoft-antispam-message-info: 9VcalJL+kdUAorO8teV2ns9JzdtxywBtv0mzzIOppEs3iZJ1kPI+GKmQw5EOK+sXL1fGWTZHLaR52od/JvHl+nLLPPyvnqQklOgCIOb+2UYMW/eC5m9iuRTjdsQ7OqXebu+73MXIENtEryFBLT1t+LXcbkVGebz+NqRNmACCTARu4Smd9xvGEtxVHK+izh8Z45GtgJLmMpdt6/AsnIDgRaYYSJaF8LyrZ0Gib+xdmACY1NhfRGTXk5oW2RjkhlQp0SPn6JkMoA7TFyXvS7+kW+fBU2HUVYICpWJrjYaECuk40Ei87sVClwJix2IlHhM4o+iidB4BgUze782HozmVL42UKMoKKkftus5cueyvgu1TpsulMXuUJUUvsE4fJAgNpvNbF/zDGQSfl1rciPEt4AjIYWT8kf6Jy/pIVqkVt1Dyi68DicKb4Dy6dITNxn5WU2c67shdwql157kandCFaZgqAOV5UMR+tH4VkXYVAXwDNLap6mUrU5uNLtT7HJr0YPTK+er+ZT1KCebNLZMPVwif6UJItIVW6coKqYzRoOOR1SvUBwpo32CbgutaAQ7kvTXzhUT7r3aJLs+0QJwPgtDXMVV9NcBkf9L+Ab//Dsy0KCsabl9VIR0tRlDhDR7o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(41320700013)(7416014)(38070700018); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clNkLzJRT2lENW5GWjlhaE1SZWU5OElaM3RONWd5WXZNeXdwVE9oVE81ZEkx?=
 =?utf-8?B?SmhOeHFtZkpyTGFFUnF6T3BveEZrbU9SUG5EL1c0U1cwb056ZW9VYlpHZ1po?=
 =?utf-8?B?RXNFQkVDTkROWW1YTkxvVVU4TVlBNHM0YUNDZEVmNmlNaXFaNWNocERiVFE2?=
 =?utf-8?B?ZHhQSDFpZTNMTnRwdkRkTnU3dWFkMWIwRWlyeWhaTXBsTzVnM2tJSmJQNzc2?=
 =?utf-8?B?MDl6bkxMdXpkRVZLdURhdVpMbzBteVlSNjVaTUtWMmNZUmdaVjBCV2JYMW9T?=
 =?utf-8?B?M1Q3bzJROVF1djgxa0Nkckg4VXgxbjRvc21lRmZZQUhnV3BYVjhzSjNiNm5U?=
 =?utf-8?B?VXV2dW0rOFppV2hKMmtrMTQ1SjI4SVJGM1hSc2J6Y3hnTzBuaTRLRWs2TVlG?=
 =?utf-8?B?YUlRL3hDRUM5OG5wcTN1WlRyQnFNQUREcTlZM0RpMFU5cHNnbkFSUk05MXQv?=
 =?utf-8?B?YUxHbXdpZE83dGpyeGVibmpaY1hqazBCZzRJVUpQcHhHendVZXJIMHJ0SUdO?=
 =?utf-8?B?SEVUa3ZndkJBdkFhNEtaRWp4SkN5Q1BXOHh5TE1UWTNyLzg5b2cxVDFwQi9O?=
 =?utf-8?B?MzBUQTNWdUZZTVh3K0dCWHladXlIU2hwMkpnVkdtTzJsbzEzNFR2YkV5UWow?=
 =?utf-8?B?UE9jYUwwWUpRMXZKSnpJTHNBV2FTV3pTa3c1QWJqMW9QbUNLTEI3MTk3TzRr?=
 =?utf-8?B?ME5BVkpJY01OdHBzVVNVZytNcnAwM1hhZ001VXVxSC94UGgwWGpJV1ZzRjBJ?=
 =?utf-8?B?a0h6N3BqY2w1bENudnFYdDNjZWo2OFFOL2dPeXQ5djIyWHJnaTJoMzZlcTRy?=
 =?utf-8?B?MGFHc1djVk5TMFhwWE05b3JtMXVqSklqcFprSzUxZDVkQ3greVpLYkw3T1JU?=
 =?utf-8?B?R2JTZ29vc0srTE5mVGg2TDYwR08vZFY4bmxVMWhqaTJXbEJpalp1WjRlem1K?=
 =?utf-8?B?cDFRcmJ6YzV4TzNReS9QaE85dzBnYm5tcExaajQ2NHpGNHM0Vmx3UGtoSVJT?=
 =?utf-8?B?Z2FRVndvZWZZV2NRQ1NWQ0NreURxOGtBYmt1WWtwRUZoRkIwRkgvckV2RDlP?=
 =?utf-8?B?THJKZkFERlJJTUJ5Q3ZFNDc2c2RoWktGQzhrcEJOQzBhK0toTTVqYktJS1Ey?=
 =?utf-8?B?MGVyUFYxaFZhZlZMVUc3b3MwTW5vTGRFWmdjL1NRU2txeGZ2eHhlcWp0MkRE?=
 =?utf-8?B?RllFTWJqNzByY1paSkY2UFZlN2NKZitEU0d2Z3dTSVpoTzU5MG5uUFB3NVNI?=
 =?utf-8?B?RFR0N1k3K09rZkk0L1lobHUvR1A1RS9Vem5hS2I5NStwcFR4elI4VnZLakNx?=
 =?utf-8?B?cm1NLy9jdmlkYjlLc01GR3RHZnVNeXFtL3pzbUZaQU1BeHRoa0Qvak9iV3ZF?=
 =?utf-8?B?c1NWV0FzU3BxNGtzVEFkclp6Y0JLdTdUdjEyYnBKbFRDdWFWOExEN2JRTWw0?=
 =?utf-8?B?aFN5clRpZzZwaTJ3U3hRYWJsbUo5NHVyczhySG4yQjlhRisxSXdpSGJ3c2Yr?=
 =?utf-8?B?YlZ6ZHNJQTV3NGxqdDBDMkM5RUpjdkhLelMxWEtjQkM5NVpXcjFkR1pLTHhD?=
 =?utf-8?B?b04xT2RhQ3BwZ3AxRDMxT2pDNDZMaCtORkx0STdBbFc1WGozUmlMQTVBSnlq?=
 =?utf-8?B?ZEkweUpFYkE5dmg2dm5RWmdvTnBCOU8vckV6aWNDQjRwclpFM1M1dlNrNUlC?=
 =?utf-8?B?b3ZObGtYN0d6RUtzYXozNDRnUkVJWXd4ZHVzeGlZQVpvaEZ2a0t5ZEpQQnRJ?=
 =?utf-8?B?bGc1anZ5azRFM3JEdGNzNVFHY0dUK0loSTl4dkQ3MGkvaGpEK2JjK29LRGxp?=
 =?utf-8?B?OUFDdDY1eHlvbWt0M2ZVV3lyQkVKT24rRVpnUmxPSy9lVDlta3Z1TlpRV05w?=
 =?utf-8?B?ZGtXV1hiZTVKODdzNld1UWhzUlljZmpRRXM0TnR1cDRKMThMcnlDRUFuaG44?=
 =?utf-8?B?OFliV2xCRnhpK2QzUUNSUDJjTmZOdmpMYi9URlBNR3NnVkQwUGI4UFFybHZ2?=
 =?utf-8?B?M0t3MHhTMnRpcWpqUlMwYzFFeTVIQUtyd1dnc0lTSFNFVlF6d2ZBZlFTdTRy?=
 =?utf-8?B?ejltWE1XZkFIQ3Zzd2cyTXJEbU5RRGFvZE1Vc2RoMkpnUWJxcWZEVmozOGdj?=
 =?utf-8?Q?wGNZ6vCRbMCJ8uSem4XMUrdNS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbaa87c-caa8-4d32-d9c0-08dce3d01c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 17:23:34.9247 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDCOEVFPG3ZC6X7wBU7mMIQlau3XHt0SK99wQovIR4iFXBXEfB5bRBjpUnsab2XvzzolvLx6hHUx6iqYHwxJQUMbiF1VHGV61wRL5dQVPBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1292
X-Mailman-Approved-At: Thu, 03 Oct 2024 23:28:32 +0200
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

PiBPbiAwMS4xMC4yNCAwMTo1NiwgSGVpbnJpY2ggU2NodWNoYXJkdCB3cm90ZToNCj4gT24gMzAu
MDkuMjQgMTc6NTksIEhhbCBGZW5nIHdyb3RlOg0KPiA+IFRoaXMgcGF0Y2hzZXQgYWRkIE9GX1NU
UkVBTSBzdXBwb3J0IGZvciBTdGFyRml2ZSBKSDcxMTAgYmFzZWQgYm9hcmRzLg0KPiA+IEFsbCB0
aGUgSkg3MTEwIGJhc2VkIGJvYXJkcyBjYW4gdXNlIHRoZSBEVCBmcm9tIHVwc3RyZWFtaW5nIGxp
bnV4IGtlcm5lbC4NCj4gPiBUaGUgdjEuM2IgYm9hcmQgZGV2aWNlIHRyZWUgaXMgc2V0IGFzIHRo
ZSBkZWZhdWx0IGRldmljZSB0cmVlLg0KPiA+DQo+ID4gVGhpcyBwYXRjaHNldCBzaG91bGQgYmUg
YXBwbGllZCBhZnRlciB0aGUgRFQgZnJvbSBkdHMvdXBzdHJlYW0vDQo+ID4gdXBkYXRpbmcgdG8g
dGhlIGxhdGVzdCB2ZXJzaW9uLg0KPiANCj4gSGVsbG8gSGFsLA0KPiANCj4gVGhhbmtzIGEgbG90
IGZvciBtYWtpbmcgdGhlIG1vdmUgdG8gdXBzdHJlYW0gZGV2aWNlLXRyZWVzIGZvciBKSDcxMTAg
YmFzZWQNCj4gYm9hcmRzLg0KPiANCj4gV2l0aCB0aGUgY3VycmVudCBwYXRjaHNldCB5b3Ugc3Vn
Z2VzdCB0byBzcGVjaWZ5IHRoZSByZWxldmFudCBkZXZpY2UtdHJlZQ0KPiB3aGVuIGJ1aWxkaW5n
LCBlLmcuDQo+IA0KPiBtYWtlDQo+IE9QRU5TQkk9JChvcGVuc2JpX2RpcikvYnVpbGQvcGxhdGZv
cm0vZ2VuZXJpYy9maXJtd2FyZS9md19keW5hbWljLmJpbiBcDQo+IERFVklDRV9UUkVFPXN0YXJm
aXZlL2poNzExMC1taWxrdi1tYXJzDQo+IA0KPiBBbm90aGVyIGFwcHJvYWNoIHdvdWxkIGJlIHRv
IGJ1aWxkIGFsbCBkZXZpY2UtdHJlZXMgaW50byBVLUJvb3QgYW5kIHVzZSB0aGUNCj4gRUVQUk9N
IGluZm9ybWF0aW9uIHRvIHNlbGVjdCB0aGUgY29ycmVjdCBvbmUgYXQgcnVudGltZS4NCj4gDQo+
IFRoaXMgYXBwcm9hY2ggaXMgc2VsZWN0ZWQgYnkgV2FuZGJvYXJkIGRlZmNvbmZpZyBhbmQgb3Ro
ZXIgYm9hcmRzIGJ5DQo+IHNwZWNpZnlpbmcgQ09ORklHX01VTFRJX0RUQl9GSVQgYW5kIENPTkZJ
R19PRl9MSVNULiBUaGUgY2hvaWNlIG9mIHRoZQ0KPiBkZXZpY2UtdHJlZSBpcyBtYWRlIGluIGJv
YXJkX2ZpdF9jb25maWdfbmFtZV9tYXRjaCgpLg0KPiANCj4gVGhlIGFkdmFudGFnZSBmcm9tIHRo
ZSBzdGFuZHBvaW50IG9mIGEgTGludXggZGlzdHJvIHdvdWxkIGJlIHRoYXQgb25lIGRpc3Rybw0K
PiBpbWFnZSBjYW4gYmUgcHJvdmlkZWQgdGhhdCB3aWxsIHJ1biBvbiBhbGwgSkg3MTEwIGJvYXJk
cy4NCg0KVGhhdCBpcyBhIGdvb2QgaWRlYS4gSSB3aWxsIHRyeSB0byBkbyB0aGlzIGFmdGVyIG15
IGZpdmUtZGF5IHZhY2F0aW9uLg0KQnkgdGhlIHdheSwgSSB3YW5uYSBrbm93IHdoZXRoZXIgamg3
MTEwLW1pbGt2LW1hcnMtY20uZHRzIGFuZA0Kamg3MTEwLW1pbGt2LW1hcnMtY20tbGl0ZS5kdHMg
YXJlIGluIHRoZSBwcm9jZXNzIG9mIHVwc3RyZWFtaW5nPw0KSSBkb24ndCBzZWUgdGhlbSBpbiB0
aGUga2VybmVsIG1haW5saW5lLg0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbnMuDQoNCkJl
c3QgcmVnYXJkcywNCkhhbA0K
