Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A39EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 12:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E7988649D;
	Tue, 22 Aug 2023 14:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="cdWTS0T6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B6118649F; Tue, 22 Aug 2023 14:45:27 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6823A86496
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 14:45:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BMdWHdeAD/puDS44xCnfV9Jx0ZtXghrh/SxObgdLhnB7WdtcbV7i1dQO+LssuKa+Ct9/R1t8CjxDFZvFA8g7MP+jWt7GI5XfQ7+TEzGk+CXXgtVeKe14aaivV4v66KebjnIuuHhAZtvhbtt3ucJGHvjigQK5wfZ04w60HYjJ0xMV+kLVqWIQ4gHC8dCwQmFI5pyiKc3/l35Vnokr2TBpRplZwOATQDS6CXSqFNVBz7ZlUbV26pW6lv5eN8eKe4KgRlmW9hn1j5DpcKUlRNh52qqm/rU87eWRE3blv2CpspEjdwmAmazBsslBKUGFWeNBUajPmBf51x0w7wQlLMYcNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Nko5XorC76+9intL07ru8HUuBeMyL9mo1bApgAW4ho=;
 b=LGUphswVnlDnL7xvQiB+Vp+l5WWBAIIOPInwf7DH/Tnb9V/nOzTQYixR60/aKfZYuKll4QkLHUAjYOGNWMdlcHjByimNhPSRw9/a3teaeoRk9yevAFePYNU9SLKIHKaJ7oEjZCcifw2u+HuJVu6AgHsjFt4MfWzsNq2/mdqcjOND3xqvnOYLIj4VUY7mRMTj2tcewUo8kU8yhdi1E42SuULs4OyLbvWJrdwM7FwIRb57vu1QgKf0VRup9GIHslIhyTgMxPoV/LyRwNpN5W3KrOMIEp4ujZ3uVJqZY6O/efAMwskOk28NP7UTj56LFClhVxhfldwF8hHKE5jQ2TJFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=de.bosch.com; dmarc=pass action=none header.from=de.bosch.com;
 dkim=pass header.d=de.bosch.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Nko5XorC76+9intL07ru8HUuBeMyL9mo1bApgAW4ho=;
 b=cdWTS0T6wrHNaVhKn1+BEvZX7tbATGX3h6GCCnq3oQaJV/0LNuUAypRBV2TSIQOVR9vJOFuXZU2gtKept0nh73KJ9OuuOROmk/Wq5KYWa6vMyN2Srct4a54eU0+YzJML31EUToWHBGCkmVTQ2dyDNfUcVOtWl9cBFGxsxMbLrGlFEyeymmcIEI9q1HFFyAYw4HQDccxDLoa+X+Z+3o3k9d8pcv13e5ajrkZIdVjHVMy7NVWt/m1cFUq+8iuLwfYoNGO8Hoam61BGy8TKIBO8x6ybmM7a/FAwUW8Ru/hgyv1ZGigwGv8wTKkfn6TQOzDLUa3bT6O8Q83ZCNVWxfTgGw==
Received: from AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ac::16)
 by AS2PR10MB7687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:642::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 12:45:23 +0000
Received: from AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a13c:eb75:513d:e382]) by AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a13c:eb75:513d:e382%7]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 12:45:23 +0000
From: "Mittelstaedt Thomas (XC-CT/EBV3)" <Thomas.Mittelstaedt@de.bosch.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: AW: [PATCH 1/1] Documentation extended with specific information for
 VirtualBox
Thread-Topic: [PATCH 1/1] Documentation extended with specific information for
 VirtualBox
Thread-Index: AQHZ0RFUeecVxtEYdU6U9M1A56N8I6/vuz+AgAaNyyA=
Date: Tue, 22 Aug 2023 12:45:22 +0000
Message-ID: <AM6PR10MB28230063DD5F5B52305747C3D31FA@AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM>
References: <20230817134647.49259-1-thomas.mittelstaedt@de.bosch.com>
 <20230817134647.49259-2-thomas.mittelstaedt@de.bosch.com>
 <2936e5c1-d401-e26c-9cea-83315273ddb7@gmx.de>
In-Reply-To: <2936e5c1-d401-e26c-9cea-83315273ddb7@gmx.de>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=de.bosch.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR10MB2823:EE_|AS2PR10MB7687:EE_
x-ms-office365-filtering-correlation-id: 78f8ad45-cb43-4931-a0da-08dba30da6b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ku4tgxKGo/VgZhR4xkLeVNKaJMsMQyie+t3/hbzZhL7Vqdhn6RaOh8MXEmYjjgZ3DYj5xoG3bFz1e3cqy5jFt8Ls64b/V5xth5zanJOwD15nfBtNisqI/tHqZXd5Nz1uDEwKdWTjw9gtRwxI9lQePfKg6TTWAtCPPnIqArxsyViMmpq+t66D5AzRM3UlopAKVa0XFxZ1a6bXjLImKOg4+3BT/vzVJXjSpn6tbSJVosB4JyVxn/7U4wFSliinVx38p61almDm1CYOetEutS6sMMsFWqtCtcL8hD4FSDNSXok+/07vA7mM1FYoXFLt9TAtgbaIn1BnSnLIMz+VadIvJZ0/cr/d5fcnr63ME+OXfep7aGFdGoUKRIXo5TAY+/ZizTmucYQaNyaMEHi3k2LLE1P1ZMtc6kEtUi5QBFg3HzGmaMZLrSxDiN0oNneccASocFxnMXGd7fEXWXBD7MfwfbXJAdkp1EJKncTDcxR5EugZpewUSY+uw6HvpONIJ7fYcpEyr+HwUCoJcM+0bMDpeP4vOlXLntrVXGjSYXpdi8szENnWz2hFzzLyGFO+6aay/KS3IG5GrCctAlAY/gYDiqmItFrNbIQ7xoEJ9faSk3VNtDXDuPDAioYDs58igynG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(54906003)(76116006)(6916009)(66446008)(66476007)(66556008)(64756008)(316002)(9686003)(66946007)(82960400001)(8676002)(8936002)(4326008)(41300700001)(122000001)(478600001)(55016003)(71200400001)(38100700002)(38070700005)(53546011)(6506007)(83380400001)(66574015)(15974865002)(2906002)(86362001)(7696005)(5660300002)(26005)(33656002)(52536014)(139555002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkJjT0sxb1hmTC9CRFVvRkcvSTJodFhwNVh3UDdFL1dvdUxaV1VVZGRTdlBz?=
 =?utf-8?B?VzlaUlhpTEE1UnlkZjh5R0p4NnpXR2RHM3dCZmgyTnNKbVVsL1dEZ1YvL3Fa?=
 =?utf-8?B?MllRU1hPRXBIcjF3WEdVT0lKSXF3V08veE8zeGVvZXZlbWdpQ2l5bDdteEw0?=
 =?utf-8?B?NWtDaGFYM0hEMk56ei85VC8zZm9XM1RvY09UMGw3ODhrck1BUkFIUkVJYyti?=
 =?utf-8?B?T0FiZlFDZnEwY0lZb0M4SkR3UVhya3FwUUg3Y2pod2tRMER4R3hHSUthL0Jp?=
 =?utf-8?B?MjJDdjBPYkdYMmJTRHlpRGtZNWl2R1M0dkNqT2N2Wk5nSThVZmUvb21lcmJa?=
 =?utf-8?B?S0huT2d2Wk41cUZPWjFucEFEK0haalBmdnZ4akwrdDF0R3ZSZXVPZFY1MVNQ?=
 =?utf-8?B?cHBlNVJPOUFLYklKUXNsVm5yWkJaT3lSRnZGZXFVM0lBOW5MbW1EREwzUWVK?=
 =?utf-8?B?MmcxVCtoTm1sOUkrcVhDV3pEUW8zRmJZSmZKQ1dNQjBOSCtlelZOdDdOK3d3?=
 =?utf-8?B?ZGxrWjQvV1hobVgwQzE1RHAxQWQ4OExVTk54ZUFVRGdJZGM4bU9LR2xkcFkr?=
 =?utf-8?B?UWNnMTBlR1JTTXNzTG9NSWdkdmtVV0l5cDdycXVYSEJ2M2hMbnFIdXZTWndF?=
 =?utf-8?B?bFl3VmpSWEEyUCtBQllLTkZ1SDVoOVhjbnRDNmdQVVBTaXQ4VkY4Sjd5N0sz?=
 =?utf-8?B?Nld1UWREOHQrUk1lWDlZRWh2VFQ4dUtRYXlNeWZCTDhnV2NUQmE1MVZBU29p?=
 =?utf-8?B?a1p1UGZON210NXdPME9sSDhDTWU1RUJvbXluVCtxOHd0YytVUmVqWUVRbDBD?=
 =?utf-8?B?SUJqcDNvdGM0bzVFMTNvN3FyclRkWWMwek9EZWtteHQ4OUJhOW1tcWkwdkQx?=
 =?utf-8?B?M3VYQTJJTU0vRnV3OFpoNzJET05Cd2hlNVZPZVJ2a2ZjVWtrTzJWcHdxeEhw?=
 =?utf-8?B?eHBhaGJ2djV2aVNucWowTEw4MHdyRUhFV2JBb1dvVlFiQ2lxeWlGQjdJbk5S?=
 =?utf-8?B?dWw0VE5TeXBNV09KOXNMdVlXbkJYdDVsZlVXV2FwVzNuaE5aY0V1ZjJ2aFU0?=
 =?utf-8?B?WmpFS3NtazJaWmJvb2U0R0VJSkZ4djRJT1lvbjRlanBpTXI3SXRSQ2Z1VnhH?=
 =?utf-8?B?RWFGdnRZUkx4ajdhU3BXTmk5LzJldzVTT1lXN1dIZTF5dGZscHZ0elZkdkpt?=
 =?utf-8?B?R3hvOGcxb24zUGN2ZjUxeUdUeWxMbVY0aVVTaVkramVzUE16blNaMWQzZ21t?=
 =?utf-8?B?N0VBc2xldVRCdE9tTUs1TEZqTFJLWGpHL0RsSnRMVHRMcG5FU3FNUndLTnBK?=
 =?utf-8?B?bmNCR2xrL1c2K1BVL0VpcmloUmhwbnd4SExocElreVREVGVYOWV1UDE4TXJN?=
 =?utf-8?B?V29PQWtMMzRLQjRWeDgwaTBhUUdtUkNpU2hLM2ZTVWtVZSt5eWRSNXBBK3dZ?=
 =?utf-8?B?SHF2VGNzWWtpSWVBYkJZcFRYUEgzckdvZUV2VVlTZzcwZGJVQzAxeU45czhG?=
 =?utf-8?B?S2VpNzdoT2VWVEh5eFdOWEpTdnZZOUh5NDNRL1pLNHVwSjFFU0NUVFFJUThR?=
 =?utf-8?B?czQ1NGRZTnVldGZMQXh6NFdyYWluZ21ZZk1WZXh2Yy9XeExYak9VLzNCbk93?=
 =?utf-8?B?eHRqMEFpN2xQa1JFNDk5S0RwbWVTSmZtcWdOOUgwV0lFZWtEZHVSZmlrYmJF?=
 =?utf-8?B?UWpmbXAybFp3a056aDROeGcvZ045SVA4c3lCS0d5QkFwMmVUV041anNsR0dN?=
 =?utf-8?B?L1pUQndyTURWUFBFOTZieFlkbUxuRU1Tb2dlN0cvcnVKbG9GRy9EZFdvZXhS?=
 =?utf-8?B?RENPRnVBd3grdzkwTUZnRUtWcWpDcHlidjdzTnJBbTRVaWR3QTd3T3lIRlM0?=
 =?utf-8?B?TklFZTF5ekdXYm9jSFF4UU9LUm53TUZTbHNKcDRnY2pEZU1NbUNyQnZiT2hi?=
 =?utf-8?B?Tld6ZWNnYnNPdFdPd3Q4R2pWYmI4UGQxNGFabWNWMU1VcXNEeitxSGQrNWww?=
 =?utf-8?B?aUt2MExZeWgvNUZNUlByaTFqUHp2NWZKcnd0WS9PTFFWd0lXejhCYmVERVRY?=
 =?utf-8?B?cXdFUVNWVEU4aTRMNUxPVWR3LzM1aWlTQTJZb2VQMDRFQ3hOWXU0T0RNNERa?=
 =?utf-8?Q?uy4g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f8ad45-cb43-4931-a0da-08dba30da6b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 12:45:22.9748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpCaIMj2zCnLtQXxFwv8zaPqsmxO51JLvVY97sZGqMNycMuB2HIRWykR5nxu+cNoVNi6ND6MIZHW9hRPf9YYvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7687
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

SGVsbG8sDQoNCkkgYW0gcmV3b3JraW5nIHRoZSBwYXRjaC4gU29tZSBjb21tZW50cyBiZWxvdy4N
Cg0KTWl0IGZyZXVuZGxpY2hlbiBHcsO8w59lbiAvIEJlc3QgcmVnYXJkcw0KDQpUaG9tYXMgTWl0
dGVsc3RhZWR0DQoNCkNyb3NzLURvbWFpbiBDb21wdXRpbmcgU29sdXRpb25zLCBFbmdpbmVlcmlu
ZyBCQk0gVmVoaWNsZSBDb21wdXRlciAzIChYQy1DVC9FQlYzKQ0KUm9iZXJ0IEJvc2NoIEdtYkgg
fCBQb3N0ZmFjaCAxMCAwMiA2MSB8IDMxMTAyIEhpbGRlc2hlaW0gfCBHRVJNQU5ZIHwgd3d3LmJv
c2NoLmNvbQ0KVGVsLiArNDkgNTEyMSA0OS0yOTY1IHwgTW9iaWwgKzQ5IDE2MCA5MDQxODg4MyB8
IFRlbGVmYXggKzQ5IDcxMSA4MTEtNTA1Mjk2NSB8IFRob21hcy5NaXR0ZWxzdGFlZHRAZGUuYm9z
Y2guY29tDQoNClNpdHo6IFN0dXR0Z2FydCwgUmVnaXN0ZXJnZXJpY2h0OiBBbXRzZ2VyaWNodCBT
dHV0dGdhcnQsIEhSQiAxNDAwMDsNCkF1ZnNpY2h0c3JhdHN2b3JzaXR6ZW5kZXI6IFByb2YuIERy
LiBTdGVmYW4gQXNlbmtlcnNjaGJhdW1lcjsgR2VzY2jDpGZ0c2bDvGhydW5nOiBEci4gU3RlZmFu
IEhhcnR1bmcsIA0KRHIuIENocmlzdGlhbiBGaXNjaGVyLCBEci4gTWFya3VzIEZvcnNjaG5lciwg
U3RlZmFuIEdyb3NjaCwgRHIuIE1hcmt1cyBIZXluLCBEci4gVGFuamEgUsO8Y2tlcnQNCg0KPiAt
LS0tLVVyc3Byw7xuZ2xpY2hlIE5hY2hyaWNodC0tLS0tDQo+IFZvbjogSGVpbnJpY2ggU2NodWNo
YXJkdCA8eHlwcm9uLmdscGtAZ214LmRlPg0KPiBHZXNlbmRldDogRnJlaXRhZywgMTguIEF1Z3Vz
dCAyMDIzIDEwOjM0DQo+IEFuOiBNaXR0ZWxzdGFlZHQgVGhvbWFzIChYQy1DVC9FQlYzKSA8dGhv
bWFzLm1pdHRlbHN0YWVkdEBkZS5ib3NjaC5jb20+DQo+IENjOiBTaW1vbiBHbGFzcyA8c2pnQGNo
cm9taXVtLm9yZz47IElsaWFzIEFwYWxvZGltYXMNCj4gPGlsaWFzLmFwYWxvZGltYXNAbGluYXJv
Lm9yZz47IHUtYm9vdEBsaXN0cy5kZW54LmRlDQo+IEJldHJlZmY6IFJlOiBbUEFUQ0ggMS8xXSBE
b2N1bWVudGF0aW9uIGV4dGVuZGVkIHdpdGggc3BlY2lmaWMgaW5mb3JtYXRpb24gZm9yDQo+IFZp
cnR1YWxCb3gNCj4gDQo+IE9uIDE3LjA4LjIzIDE1OjQ2LCB0aG9tYXMubWl0dGVsc3RhZWR0QGRl
LmJvc2NoLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBUaG9tYXMgTWl0dGVsc3RhZWR0IDx0aG9tYXMu
bWl0dGVsc3RhZWR0QGRlLmJvc2NoLmNvbT4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRob21h
cyBNaXR0ZWxzdGFlZHQgPHRob21hcy5taXR0ZWxzdGFlZHRAZGUuYm9zY2guY29tPg0KPiA+IC0t
LQ0KPiA+ICAgZG9jL2RldmVsb3AvdWVmaS91LWJvb3Rfb25fZWZpLnJzdCB8IDc2ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDc2IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kb2MvZGV2ZWxvcC91ZWZpL3UtYm9vdF9vbl9l
ZmkucnN0DQo+ID4gYi9kb2MvZGV2ZWxvcC91ZWZpL3UtYm9vdF9vbl9lZmkucnN0DQo+ID4gaW5k
ZXggYWNhZDYzOTdlOC4uOTI3ZTFkYzI2NiAxMDA2NDQNCj4gPiAtLS0gYS9kb2MvZGV2ZWxvcC91
ZWZpL3UtYm9vdF9vbl9lZmkucnN0DQo+ID4gKysrIGIvZG9jL2RldmVsb3AvdWVmaS91LWJvb3Rf
b25fZWZpLnJzdA0KPiA+IEBAIC0yNTQsNiArMjU0LDgyIEBAIFRoaXMgc2hvd3MgcnVubmluZyB3
aXRoIHNlcmlhbCBlbmFibGVkIChzZWUNCj4gYGluY2x1ZGUvY29uZmlncy9lZmkteDg2X2FwcC5o
YCk6Og0KPiA+DQo+ID4gICAgICA9PiBRRU1VOiBUZXJtaW5hdGVkDQo+ID4NCj4gPiArUnVuIGF0
IFZpcnR1YWxCb3ggKHg4NikNCj4gDQo+ICVzL2F0L29uLw0KPiANCk9LLiBXaWxsIGRvLg0KPiBC
ZWxvdyB5b3UgYXNzdW1lIGEgNjRiaXQgbWFjaGluZTogJXMveDg2L3g4Nl82NC8NCk9LLiBXaWxs
IGRvLg0KPiANCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gDQo+IFRoZSBsaW5l
IGxlbmd0aCBtdXN0IG1hdGNoIHRoZSBoZWFkaW5nLg0KPiANCj4gPiArDQo+ID4gK0VuYWJsZSBF
RkkNCj4gPiArfn5+fn5+fn5+fn5+DQo+IA0KPiBkaXR0bw0KT0suIFdpbGwgZG8uDQo+IA0KPiA+
ICtBdCBzZXR0aW5ncyBmb3IgdmlydHVhbCBtYWNoaW5lIHRoZSBmbGFnIGF0ICoqU3lzdGVtLT5N
b3RoZXJib2FyZC0+RW5hYmxlIEVGSQ0KPiAoc3BlY2lhbCBPU2VzIG9ubHkpKiogaGFzIHRvIGJl
IGVuYWJsZWQuDQo+IA0KPiBMaW1pdCBsaW5lcyB0byA4MCBjaGFyYWN0ZXJzLg0KPiANCk9LLiBX
aWxsIGRvLg0KPiA+ICsNCj4gPiArSW5zdGFsbGF0aW9uDQo+ID4gK35+fn5+fn5+fn5+fg0KPiA+
ICtJbnN0YWxsIHRoZSBuZWVkZWQgc3lzdGVtIGF0IGEgVkRJIGRpc2sgYW5kIGNvbm5lY3QgdGhp
cyB0byBTQVRBDQo+ID4gK2NvbnRyb2xsZXIgKHR5cGUgQUhDSSkgYXQgc2V0dGluZ3MNCj4gDQo+
IFByb3ZpZGUgdGhlIHByZWluc3RhbGxlZCBMaW51eCBzeXN0ZW0gYXMgYSBWaXJ0dWFsIERpc2sg
SW1hZ2UgKFZESSkgYW5kIGFzc2lnbiBpdA0KPiB0byBhIFNBVEEgY29udHJvbGxlciAodHlwZSBB
SENJKSB1c2luZyB0aGUgc2V0dGluZ3MgZm9yIHRoZSB2aXJ0dWFsIG1hY2hpbmUgYXQNCj4gbWVu
dSBpdGVtICoqU3lzdGVtLT5TdG9yYWdlLT5Db250cm9sbGVyOlNBVEEqKi4NCj4gDQo+ID4gK2Zv
ciB2aXJ0dWFsIG1hY2hpbmUgYXQgKipTeXN0ZW0tPlN0b3JhZ2UtPkNvbnRyb2xsZXI6U0FUQSoq
Lg0KPiA+ICsNCj4gPiArRm9yIHRoZSBmb2xsb3dpbmcgZGVzY3JpcHRpb24gMyBwYXJ0aXRpb25z
IGFyZSBhc3N1bWVkOg0KPiANCj4gdGhyZWUgR1BUIHBhcnRpdGlvbnMNCj4gDQpPSy4gV2lsbCBk
by4NCj4gPiArDQo+ID4gKy0gUGFydGl0aW9uIDE6IGZvcm1hdHRlZCBhcyAqKnZmYXQqKiwgdXNl
ZCBmb3IgVS1Cb290IGFuZCBhbmQgaXRzDQo+ID4gK2Vudmlyb25tZW50IGZpbGVzZW52aXJvbm1l
bnQsIGZsYWcgKipib290Kiogc2V0DQo+IA0KPiBmb3JtYXR0ZWQgYXMgRkFUIGZpbGUtc3lzdGVt
IGFuZCBtYXJrZWQgYXMgRUZJIHN5c3RlbSBwYXJ0aXRpb24gKHBhcnRpdGlvbiB0eXBlDQo+IDB4
RUYwMCkgdXNlZCBmb3IgdGhlIFUtQm9vdCBFRkkgYmluYXJ5Lg0KPiANCj4gKElmIFZpcnR1YWxC
b3ggaXMgVUVGSSBjb21wbGlhbnQsIGl0IHNob3VsZCByZWNvZ25pemUgdGhlIEVTUCBhcyB0aGUg
Ym9vdCBwYXJ0aXRpb24uKQ0KPiANCj4gPiArLSBQYXJ0aXRpb24gMjogZm9ybWF0dGVkIGFzICoq
ZXh0Mi9leHQ0KiosIHVzZWQgZm9yIExpbnV4IGltYWdlIGFuZA0KPiA+ICtib290IGNvbmZpZ3Vy
YXRpb24sIGZsYWcgKipib290Kiogc2V0DQo+IA0KPiBleHQyIG9yIGV4dDQNCj4gDQo+IA0KT0su
IFdpbGwgZG8uDQo+ID4gKy0gUGFydGl0aW9uIDM6IGZvcm1hdHRlZCBhcyAqKmV4dDQqKiwgdXNl
ZCBmb3Igcm9vdCBmaWxlIHN5c3RlbQ0KPiA+ICsNCj4gPiArQ3JlYXRlIGFuIGV4dGxpbnV4LmNv
bmYgb3IgYSBib290IHNjcmlwdA0KPiA+ICt+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+DQo+ID4gKw0KPiA+ICtGb2xsb3dpbmcgZmlsZXMgYXJlIGFzc3VtZWQgdG8gYmUg
bG9jYXRlZCBhdCBzeXN0ZW0gZm9yIGJvb3QgY29uZmlndXJhdGlvbjo6DQo+ID4gKw0KPiA+ICsg
UGFydGl0aW9uICBGaWxlICAgICAgICAgICAgICAgICAgICBDb21tZW50DQo+ID4gKyAxICAgICAg
ICAgIEVGSS9CT09UL0JPT1RYNjQuZWZpICAgICMgcmVuYW1lZCBVLUJvb3QgRUZJIGltYWdlDQo+
IA0KPiBFRkkvQk9PVC9CT09UWDY0LkVGSQ0KPiANCj4gUGxlYXNlLCB0ZWxsIHRoZSByZWFkZXIg
d2hpY2ggZGVmY29uZmlnIHRvIHVzZSBhbmQgd2hpY2ggVS1Cb290IGZpbGUgdG8gY29weS4NCj4g
DQpPSy4gV2lsbCBhZGQgc29tZSBkZXNjcmlwdGlvbi4NCj4gPiArIDIgICAgICAgICAgSW1hZ2Ug
ICAgICAgICAgICAgICAgICAgIyBMaW51eCBpbWFnZQ0KPiANCj4gUGxlYXNlLCByZW1vdmUgdGhl
IGJsYW5rIHNwYWNlIGF0IHRoZSBlbmQgb2YgbGluZS4NCj4gDQo+ID4gKyAyICAgICAgICAgIElu
aXRyZCAgICAgICAgICAgICAgICAgICMgSW5pdHJhbWZzIG9mIExpbnV4DQo+ID4gKw0KPiA+ICtC
b290IHNjcmlwdA0KPiA+ICt+fn5+fn5+fn5+fg0KPiA+ICsNCj4gPiArVGhlIGJvb3Qgc2NyaXB0
ICoqYm9vdC5zY3IqKiBpcyBhc3N1bWVkIHRvIGJlIGxvY2F0ZWQgYXQ6Og0KPiA+ICsNCj4gPiAr
IFBhcnRpdGlvbiAgRmlsZSAgICAgICAgQ29tbWVudA0KPiA+ICsgMiAgICAgICAgICBib290LnNj
ciAgICAjIEJvb3Qgc2NyaXB0LCBnZW5lcmF0ZWQgd2l0aCBta2ltYWdlIGZyb20gdGVtcGxhdGUN
Cj4gDQo+IFBsZWFzZSwgcmVtb3ZlIHRoZSBibGFuayBzcGFjZSBhdCB0aGUgZW5kIG9mIGxpbmUu
DQo+IA0KT0suIFdpbGwgZG8uDQo+ID4gKw0KPiA+ICtDb250ZW50IG9mICoqYm9vdC5zY3IqKjoN
Cj4gPiArDQo+ID4gKy4uIGNvZGUtYmxvY2s6OiBiYXNoDQo+ID4gKw0KPiA+ICsgIGV4dDRsb2Fk
ICR7ZGV2dHlwZX0gJHtkZXZudW19OiR7ZGlzdHJvX2Jvb3RwYXJ0fSAke2tlcm5lbF9hZGRyX3J9
DQo+ID4gKyAke3ByZWZpeH1JbWFnZSAgc2V0ZW52IGtlcm5lbF9zaXplICR7ZmlsZXNpemV9ICBl
eHQ0bG9hZCAke2RldnR5cGV9DQo+ID4gKyAke2Rldm51bX06JHtkaXN0cm9fYm9vdHBhcnR9ICR7
cmFtZGlza19hZGRyX3J9ICR7cHJlZml4fUluaXRyZA0KPiA+ICsgc2V0ZW52IGluaXRyZF9zaXpl
ICR7ZmlsZXNpemV9ICB6Ym9vdCAgJHtrZXJuZWxfYWRkcl9yfQ0KPiA+ICsgJHtrZXJuZWxfc2l6
ZX0gJHtyYW1kaXNrX2FkZHJfcn0gJHtpbml0cmRfc2l6ZX0NCj4gDQo+IERvZXNuJ3QgVS1Cb290
IG5lZWQgdGhpcyBmaWxlIG9uIHRoZSBib290IHBhcnRpdGlvbiBpLmUuIHRoZSBFU1A/DQo+IA0K
SSdsbCBjaGFuZ2UgdG8gYSBzZXR1cCBvZiAyIHBhcnRpdGlvbnMsIGJlY2F1c2UgSSdtIGFsd2F5
cyBzZXBhcmF0ZSBib2FyZCBzcGVjaWZpYyBwYXJ0aXRpb25zIGZyb20gZ2VuZXJpYyBib290IHBh
cnRpdGlvbnMuIEF0IG91ciBEZWJpYW4gaW1hZ2VzIHdlIGFsd2F5cyBoYXZlIGEgc2VwYXJhdGlv
biBib290IHBhcnRpdGlvbiB3aXRoIGJvb3Qgc2NyaXB0cywgZXhsaW51eC5jb25mLCBMaW51eCBp
bWFnZXMsIGRldmljZSB0cmVlcyBldGMuIEJ1dCBmb3IgdGhpcyBkZXNjcmlwdGlvbiBJIGRvbid0
IG5lZWQgaXQuDQoNCj4gQmVzdCByZWdhcmRzDQo+IA0KPiBIZWlucmljaA0KPiANCj4gPiArDQo+
ID4gK0V4dGxpbnV4IGNvbmZpZ3VyYXRpb24NCj4gPiArfn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0K
PiA+ICsNCj4gPiArQWx0ZXJuYXRpdmVseSBhIGNvbmZpZ3VyYXRpb24gKipleHRsaW51eC5jb25m
KiogY2FuIGJlIHVzZWQuICoqZXh0bGludXguY29uZioqIGlzDQo+IGFzc3VtZWQgdG8gYmUgbG9j
YXRlZCBhdDo6DQo+ID4gKw0KPiA+ICsgUGFydGl0aW9uICBGaWxlICAgICAgICAgICAgICAgICAg
ICAgICAgQ29tbWVudA0KPiA+ICsgMiAgICAgICAgICBleHRsaW51eC9leHRsaW51eC5jb25mICAg
ICAgIyBFeHRsaW51eCBib290IGNvbmZpZ3VyYXRpb24NCj4gPiArDQo+ID4gK0NvbnRlbnQgb2Yg
KipleHRsaW51eC5jb25mKio6DQo+ID4gKw0KPiA+ICsuLiBjb2RlLWJsb2NrOjogYmFzaA0KPiA+
ICsNCj4gPiArICBkZWZhdWx0IGwwDQo+ID4gKyAgbWVudSB0aXRsZSBVLUJvb3QgbWVudQ0KPiA+
ICsgIHByb21wdCAwDQo+ID4gKyAgdGltZW91dCA1MA0KPiA+ICsNCj4gPiArICBsYWJlbCBsMA0K
PiA+ICsgICAgbWVudSBsYWJlbCBMaW51eA0KPiA+ICsgICAgbGludXggL0ltYWdlDQo+ID4gKyAg
ICBpbml0cmQgL0luaXRyZA0KPiA+ICsNCj4gPiArDQo+ID4gK0FkZGl0aW9uYWxseSBzb21ldGhp
bmcgbGlrZSAoc2RhIGlzIGFzc3VtZWQgYXMgZGlzayBkZXZpY2UpOg0KPiA+ICsNCj4gPiArLi4g
Y29kZS1ibG9jazo6IGJhc2gNCj4gPiArDQo+ID4gKwlhcHBlbmQgIHJvb3Q9L2Rldi9zZGEzIGNv
bnNvbGU9dHR5MCBjb25zb2xlPXR0eVMwLDExNTIwMG44IHJvb3R3YWl0DQo+ID4gK3J3DQo+ID4g
Kw0KPiA+ICsNCj4gPg0KPiA+ICAgRnV0dXJlIHdvcmsNCj4gPiAgIC0tLS0tLS0tLS0tDQoNCg==
