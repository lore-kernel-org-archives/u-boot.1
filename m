Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB313C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 11:53:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECEE688129;
	Fri,  1 Mar 2024 12:53:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s6NngA4W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E56C68812A; Fri,  1 Mar 2024 12:53:24 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8A3788111
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 12:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iwm01CNmU08Nwp6kWveL8iUBfNQOEdyWJRByDjn2nr51AWgX65Tp25y7bVhUqa7+ajrvtOBgMyyGKfpUFFNM/QKO9PyBArIshqZIAoXNn5eCFaEXMcfV4gcpYOWnnOJdTMCX1CsMaTXbRq/NXAvUqVHvMVE/hwmXIYbxR0BOaYJQzJlbGzYNKgbUAoEjvg813WMSRpeLzouNQIj7KOHENBEaM4NtFRXoPFyUVPdWWfQQGJL5hsVAh+vFb0AMPB4Yz51+/xOvfrdlGBhZzTNOZamp/7LC3QYvFKvac/lM9UMYGE1yNqtBaj31lqzxDA8Ihen2RCDxRS2uLLVQ+fsqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tU/jrDiyrtD6AHN0GIvjxht2AJV1Vv+Vwfj6B27lTs0=;
 b=QTt20LkFuxnLcuiaK3Hf8XcY+vaHDME1C/xfa3qAag2DEF5kVQ+6YSZC/bZkUbq3S7KYOKfUunNfBZwTHbonVRwukkgP5AXR78CtPJGjCwMpV2p1jrGM/ePmVE1/+tXRtj6VpNZFJE77WwHRKxeld4TOV86NIohjClndpSh19Wykpa6f4P9Q7fbB8Zk0zcAdLhmMptOqUsveDFGJMTG1IwRkvBwegJE9R1vUdJrsbbIASSJJD7x+XalLW6syOHxbKYMcEbhXAQWCI46WL1Ne28TIztGKXYN7OZMQRbuzoLsA/O2/R9h+FJRWMicNy4ZJt/EaPE8zhi3fiNWne8GD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tU/jrDiyrtD6AHN0GIvjxht2AJV1Vv+Vwfj6B27lTs0=;
 b=s6NngA4Wl2+KewXA+oXt9Z3Fl8/XVSBrS9zmsqygz6ZvH321UVzO8LTI6mtDgC9FpS9a+an4CHP++7PVUEZHqHkeAhLFj/CCC/zVFBcaFVia2GmBxiAJeXJ0rc6GG0vkDIZhXNl3JGe0blwT9zecuuERUDX15EtmIfWIcEsldcw=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 11:53:19 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::1adb:ac7:ded9:8a02]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::1adb:ac7:ded9:8a02%7]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 11:53:19 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "git (AMD-Xilinx)" <git@amd.com>, Ashok Reddy
 Soma <ashok.reddy.soma@amd.com>
Subject: RE: [UBOOT PATCH v3] mtd: nand: arasan: Print warning for unsupported
 ecc modes
Thread-Topic: [UBOOT PATCH v3] mtd: nand: arasan: Print warning for
 unsupported ecc modes
Thread-Index: AQHaa8lowsmZ/VcqOE2DLvdXcT0417EivsGAgAAHc8A=
Date: Fri, 1 Mar 2024 11:53:19 +0000
Message-ID: <SA1PR12MB8697508C43817BD4B551480E985E2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20240301111254.3588162-1-venkatesh.abbarapu@amd.com>
 <d0349400-9889-4e0a-965c-6f3ac7f532b5@amd.com>
In-Reply-To: <d0349400-9889-4e0a-965c-6f3ac7f532b5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|SJ2PR12MB8943:EE_
x-ms-office365-filtering-correlation-id: bed098ba-5489-45f6-3832-08dc39e63029
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hd4jn0nhXtsxcVb0t1YpCbx2w/GIvyhAFLjLQ6Oka354yp1A16zIYPxG4mieUqY5pJCGQJu6LQ1y2iDUgCsv/Z/3JXvtjs8MVaF5Q1+rJultEtZGYINISHAEQjKxbxsX3IOI36dZwa9AN5vqtbNYL9FMB90aKFof8Ew4/V3KShIB/XTLi3KWI5wq55+I/ACARLfbFLCj0vUpKEulXp3rTr3/Y/XYuQHxH7IvtxwfD9GTvFvefPGrdVns5BpDri+LCTCtlgkor+TBFi4OMLshxjTvQGrn3qWh/MEHf3AILdoCkapBfQOvlPd3QTsSGgigwKK+m90dPoFiHfwO9+4YNkymeZNL0iDlVGTionh5QfNtutWAABFV/firaCK85w+gLB2Ane79PqKFWy+z/oQT5Q7BaclVlR7co88KYJPyzz5A/Fp8xn26E3sSkAnqDyvLqdnaQj0wqarL1NmNq8lyym5Rq4RUqIFrkCucHnRKag0jtVcsKBTMRgKxLsEvUzRxSP900ga8fOmjxhMzo8dzHQH8mGXksqNnx+x4l7xEsPBe8eIUezwitczLgeWNQPTV9DY681VoFK5xhRJyQDIls4MslRKQw5oONutzsJVWvfY+DJ+4avR2YLFNdvJYTv+avJYk7KmLFWdqXZy+w3miRVwncIQisW7bifu/Tj7taMIAdkJTYhjP7bB6Uwx6dcnci7F2SRTmfqaAuYgtLPMJgymYFvJtze3NeMPW7E/D9Vw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajNZMXNXWldSbEdGSko1bithR2k0UGh4clZzdUhWZ1UxSnlpdGRkWlFyTSt4?=
 =?utf-8?B?RWxxS1c0bCt4YXpiYXBaTGxoMnlJemVlaWxPM2VIVitmUjFVVlB4VkxtN1Rn?=
 =?utf-8?B?UVZkSi96RUt0OWJuLzRjTHFYc212YjF4clNpWU5QeXdvb3hYa3pmSE1GRjBj?=
 =?utf-8?B?Q3YrVlhWc243S0FEVjFIbnQzaVJmSnVDUVpEcXMwMFNUVWtCdFJvWXh5c2tW?=
 =?utf-8?B?NlpYSEI5U1BlempMTU5HUUxPQnJlbEh2RTcwazk2MDVyZWVHK0t5cnpmcXFi?=
 =?utf-8?B?eUg3R1Zoa0dSeHVYWGx1MndIdncrVG9URXRJQktBaFF4RDVWOFFDWnBoMkoy?=
 =?utf-8?B?WGlMNDlBUDZBZ0Z2cldsVHIyd1ZiaS81bXdRczgwWmx6VG14UE8vVXNsNFM5?=
 =?utf-8?B?RjBMd2tJNUplZFU4a0pROTM3bHBCczJFZ3pmSjJ3Z05xWlV2M2R1Rllvemxr?=
 =?utf-8?B?MVJHblk3aGlXV05CYVpidUdXVEIxSlVXTVJwaFhJQks1TFdSeHgwNHpkRDRQ?=
 =?utf-8?B?aFBlQVo5QURrMC9ieTl1SXZseUptUnhDdEtzRUNLbkhMb0Rrc29WR3Y0RFFt?=
 =?utf-8?B?NzV1MzdNWCtaZVlwYzV4V3c5R1BpUW9mSHg4WGx6bm5UT3NONlVFdDhabkpJ?=
 =?utf-8?B?ODVwOFpUR1h1dW50T0tNYzhiaWlVNTFISUw3OVNpY25aQWhYdW1kTk1UUkYv?=
 =?utf-8?B?bEMxTnI1N3UrNjFOQ05oVmdmdTBUY3Z5UUZVTjg4SzcwVkpPSHcyUWlSaXFT?=
 =?utf-8?B?enFiZHNaTXpZZlZObFc3LzFyNFg5UDFzMDA1Vm5VSk1zN1llV2x5ZFZXWVFQ?=
 =?utf-8?B?OC9IMEk2dnVwTWxYdi9SaHQ0cnpPWjhZTDdzYlozTjdha0hiYnAwUFNSdjIw?=
 =?utf-8?B?Yklxazc4ejBsSHpkSHVJSUV2cEFKUFJNVE1aVEQ5c3JNT3p3eitGNk5Pa2lz?=
 =?utf-8?B?c2ErYmp1MGZwUFI2NTZORnl4RE5wdWNrZEIvZWNVeE1IL1JjVExuL0N0b2Fw?=
 =?utf-8?B?eGNUZnFiY2J1c0tibHY3U2FmNkxGOWg5aHY3Qjg0Mm5XYS9YblhGNnBuaytR?=
 =?utf-8?B?WkZTRndnckRLeDJGT25mT0czUmlFRTExeW82ZEJSZXdBOVdjZ3FMcjhMMksw?=
 =?utf-8?B?WVR1Z1pYbUlCRHJML1Z3NzZWMHozTVhKM0cwNlF4NzhDejFkbHNLanJNMGtC?=
 =?utf-8?B?dUQxQis3cXlMbnpyZU1PNG5pUWdqUXI4UGlqM1hLVlBIRnYwem0xQnpnT1My?=
 =?utf-8?B?U2J0enJScEU3UjdjbkYxTzMxOFdEY29YQ2g1VC9jOVQrQkxueklhOXhvaFd2?=
 =?utf-8?B?NXRydGFTVXZSanlSU0Y2cGpzZWVVUm1xanFZUEhmUmU1MHRaNWN6VWQyTU0x?=
 =?utf-8?B?d0ZVb0hERFFEc29mTDl1ZzM2cFBLRlJpSUd0WktiVkg3WVkwck5ya0RoSjVS?=
 =?utf-8?B?RWtTYkhiV2dXWHdkc2lGMkt4NW1jUm43NVZDSzdGbVBFUnRHVmN4TW44M2hw?=
 =?utf-8?B?QjVGSnp3eGlQc3ByWkFnL3kvMUU0WmpMQUdBc3UyejZqY3ZVZEo4eTE5Qm81?=
 =?utf-8?B?NGV3aS9KTTBGUzRVL1pIcXRUb21sSHBkOWNDOGxLVGlrK2Fha1NYcVovOVFy?=
 =?utf-8?B?MkxDeTcrckxFVWFnZmpDK2lUeElHZmJQMHlwTmRnYnRndFNHU21La0ZmR04z?=
 =?utf-8?B?VlhRbGd6b1JUYmNWT21UUGtpeUxvTGFHRjZwQlpMVlkycGtDQmFxVHc0Z2sv?=
 =?utf-8?B?YVZDeGFEcFIxRXg2ZGZRb203Tm5zZVRac3VxajloSXRIRDlNWnZpMmZIUTEx?=
 =?utf-8?B?bnJvNmVNcXhYdSt4aFphRkpoNUQ3MnpvOXgwOWdhNlhrRE1Ndkg1VENQYmkv?=
 =?utf-8?B?ZGh0Q3pobEJ5TjZYV0RzaTdUb2ZrWGh6VTBLSWxOTkd4YWJOOStRckVseEFJ?=
 =?utf-8?B?dExjQ3hPZEZRU0lwWnVQWWtCQUdUM1JESVJmYzNEU0dIZ0kzTm96aUgzYjR2?=
 =?utf-8?B?Q1lCREU0TlhhZE1XRGp0YXVuWGlhcWE5b0U3STBOMm5iMVcxZ09OQXdVcVow?=
 =?utf-8?B?Z0pCcHV0dkFIeXBuZDZIUitHcG8wT3BITktrWEc5TmFCbVdub3BMY0VTRFpH?=
 =?utf-8?Q?YWWY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed098ba-5489-45f6-3832-08dc39e63029
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 11:53:19.2573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xP2I29PZTlSGaCFCVLT+pICgYp1xlo2xfg+ZsomxsL+qe7s9LuKrjEoll7w8uSplChzvRLzTCvw2my5MVRMTDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
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

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFNpbWVr
LCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIE1hcmNoIDEs
IDIwMjQgNDo1NSBQTQ0KPiBUbzogQWJiYXJhcHUsIFZlbmthdGVzaCA8dmVua2F0ZXNoLmFiYmFy
YXB1QGFtZC5jb20+OyB1LQ0KPiBib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IGRhcmlvLmJpbmFj
Y2hpQGFtYXJ1bGFzb2x1dGlvbnMuY29tOyBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0K
PiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1kLmNvbT47IEFzaG9rIFJlZGR5IFNvbWENCj4gPGFz
aG9rLnJlZGR5LnNvbWFAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtVQk9PVCBQQVRDSCB2M10g
bXRkOiBuYW5kOiBhcmFzYW46IFByaW50IHdhcm5pbmcgZm9yDQo+IHVuc3VwcG9ydGVkIGVjYyBt
b2Rlcw0KPiANCj4gDQo+IA0KPiBPbiAzLzEvMjQgMTI6MTIsIFZlbmthdGVzaCBZYWRhdiBBYmJh
cmFwdSB3cm90ZToNCj4gPiBDdXJyZW50bHkgb25seSBodyBlY2MgaXMgc3VwcG9ydGVkIGluIFUt
Qm9vdC4gSWYgYW55IG90aGVyIGVjYyBtb2RlIGlzDQo+ID4gZ2l2ZW4gaW4gRFQsIGl0IHNpbXBs
eSBpZ25vcmVzIGFuZCBzd2l0Y2hlcyB0byBodyBlY2MuIFNvIGJldHRlciBwcmludA0KPiA+IHdo
YXQgaXMgYmVpbmcgZG9uZS4NCj4gPg0KPiA+IFJldmVydCB0aGlzIHBhdGNoIG9uY2Ugc29mdCBl
Y2Mgc3VwcG9ydCBpcyBmaXhlZCBpbiBmdXR1cmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBB
c2hvayBSZWRkeSBTb21hIDxhc2hvay5yZWRkeS5zb21hQGFtZC5jb20+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogVmVua2F0ZXNoIFlhZGF2IEFiYmFyYXB1DQo+IDx2ZW5rYXRlc2guYWJiYXJhcHVAYW1k
LmNvbT4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHYyOg0KPiA+IC0gQWRkZWQgdGhlIGVjYyBt
b2RlIGNoZWNrIGluIHRoZSBhcmFzYW4gZHJpdmVyIGl0c2VsZi4NCj4gPiBDaGFuZ2VzIGluIHYz
Og0KPiA+IC0gU2tpcCB0aGUgZHJpdmVyIHByb2JlIHdoZW4gc3ctZWNjIG1vZGUgaXMgcHJlc2Vu
dCBpbiB0aGUgZGV2aWNlIHRyZWUuDQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL210ZC9uYW5kL3Jh
dy9hcmFzYW5fbmZjLmMgfCA3ICsrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9uYW5kL3Jhdy9hcmFz
YW5fbmZjLmMNCj4gPiBiL2RyaXZlcnMvbXRkL25hbmQvcmF3L2FyYXNhbl9uZmMuYw0KPiA+IGlu
ZGV4IDE0NzY2NDAxYmYuLjQyNjE2MGMzODQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQv
bmFuZC9yYXcvYXJhc2FuX25mYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tdGQvbmFuZC9yYXcvYXJh
c2FuX25mYy5jDQo+ID4gQEAgLTEyMzMsNiArMTIzMyw3IEBAIHN0YXRpYyBpbnQgYXJhc2FuX3By
b2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4gICAJc3RydWN0IG10ZF9pbmZvICptdGQ7DQo+
ID4gICAJb2Zub2RlIGNoaWxkOw0KPiA+ICAgCWludCBlcnIgPSAtMTsNCj4gPiArCWNvbnN0IGNo
YXIgKnN0cjsNCj4gPg0KPiA+ICAgCWluZm8tPnJlZyA9IGRldl9yZWFkX2FkZHJfcHRyKGRldik7
DQo+ID4gICAJbXRkID0gbmFuZF90b19tdGQobmFuZF9jaGlwKTsNCj4gPiBAQCAtMTI2Myw2ICsx
MjY0LDEyIEBAIHN0YXRpYyBpbnQgYXJhc2FuX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+
ID4gICAJCWdvdG8gZmFpbDsNCj4gPiAgIAl9DQo+ID4NCj4gPiArCXN0ciA9IG9mbm9kZV9yZWFk
X3N0cmluZyhuYW5kX2NoaXAtPmZsYXNoX25vZGUsICJuYW5kLWVjYy1tb2RlIik7DQo+ID4gKwlp
ZiAoc3RyY21wKHN0ciwgImh3IikpIHsNCj4gPiArCQlwcmludGYoIiVzIGVjYyBpcyBub3Qgc3Vw
cG9ydGVkLCBzd2l0Y2ggdG8gaHcgZWNjXG4iLCBzdHIpOw0KPiANCj4geW91IGFyZSByZXR1cm5p
bmcgYmVsb3cuIEl0IG1lYW5zIHN3aXRjaCB0byBIVyBlY2MgaXMgbm90IGhhcHBlbmluZyByaWdo
dD8NCjxWZW5rYXRlc2g+IFllcy4gV2UgYXJlIG5vdCBzd2l0Y2hpbmcgdG8gSFcgZWNjLCBqdXN0
IHJldHVybmluZyBmcm9tIHRoZSBwcm9iZSBpZiBpdCBpcyBvdGhlciB0aGF0IEhXIGVjYy4NCg0K
VGhhbmtzDQpWZW5rYXRlc2gNCj4gDQo+IE0NCg==
