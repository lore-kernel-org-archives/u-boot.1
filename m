Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE40BCD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 19:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F310C84855;
	Tue, 26 May 2026 21:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="exY0A4ev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A45B784843; Tue, 26 May 2026 21:39:56 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF48B84843
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 21:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=d.haller@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JnbYL5HMALuNlZlELVQgpAuhmiH9HmNYlrSNzTudM3/XqCRXRxTYun1n1bZpuU1K1rZnjQfFRPEmkItH6PdqINm+0+9IHMcRiz7cxXuPjMFvKggzm7NuhX0GBVBedcUIYF1b/fHpSag+Xz6UzG31W2QzUQ0eEo00g5IjYGn4QnTT1ChrXlAxKV7qOuPY2NqtHrIdRUy0JUxSVD4VFJB6C5w5bU7s+xr+0laaavWIm3YfTKwdteme4au+WKFbkTyXY+5yJ3cFhDRnpi4kkz/ZdJ7qkI+/D3U6RhpHIQvAUIdwLXSkj9lnV1ND7WklHIssUnJ5XtLyUbHVoE4P0I4N6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiUoSiggXMV4O8h344Tg4FzcEm/vCTuOiGq/6jhX0/c=;
 b=jzHUpEYpsYIT8ST26dYh4+H0MTX/kHboWYx+/UGWEsnk54nUYNmPeRoa6BKdKkv3XtC7kW5xPVLU3cEcMq83rEztOkUFa+IS9My/ToqFFhpZOtJI0TW7zbXy222/e4+1ASPb4pKrX2pMfDrXj8bSDyy2jW8n6xzbclvdqCQ2uxTnaGtpSvSLV7Rqoqdr3tf4Me9XqwFiokzhqX0n4Ifq6Ypj7CkASJQbNeJDNeJgBXaMhaPg9E5eKDOlWJD44bWXnTz/JwcD4cTG7+IoMBd3D0vFRONMSFtEm+qdpydkIXioT2cj3jUzROJwtMRvGHWMYunKN2JlIn0scxdV70MnUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiUoSiggXMV4O8h344Tg4FzcEm/vCTuOiGq/6jhX0/c=;
 b=exY0A4ev1UIR2/Y6195oLTb3z8NVh4QF/d5xWcYror5AET2yMDsJ2hSWAJzKfqY2Y1AzxSi6qpVCkygIFN0Q7bNmaYFQTvaKOYy3Pro/vciO/squ/SH12Cet/MlK9ibbcOUebYNYH5rL4/DuvEcgqLnDmyOMIgQUZSnVYAgTbEIp/Ld1Xipi03l0mBLUcspbZfQZySrMKZq9UB68xlzlz2m5Lbn9ymyw4QYlPq2JcMNwU6PTm9xCJCeG3RyKwisNEfCzHGIQIevu8MMc/cLED6OsvgWfMUhECAIKE+/TM1GEl1rvAU95Y18MO2CUzBzaFNv4uV1jaPClE9+H0BuK5w==
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:dc::8) by
 GV2P195MB1943.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:7e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.20; Tue, 26 May 2026 19:39:49 +0000
Received: from GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::f5b2:c6b4:ffb4:9e76]) by GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
 ([fe80::f5b2:c6b4:ffb4:9e76%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 19:39:49 +0000
From: Dominik Haller <d.haller@phytec.de>
To: "peng.fan@nxp.com" <peng.fan@nxp.com>, Wadim Egorov <w.egorov@phytec.de>, 
 "trini@konsulko.com" <trini@konsulko.com>, Martin Schwan
 <m.schwan@phytec.de>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/7] board: phytec: phycore_am68x: Update rm-cfg
Thread-Topic: [PATCH 3/7] board: phytec: phycore_am68x: Update rm-cfg
Thread-Index: AQHc4qjP2wpmvzyqok+ZRR0bXacua7YgyYEA
Date: Tue, 26 May 2026 19:39:49 +0000
Message-ID: <0e92da6b8b4d7c01f8f088c177faa8c7a3307954.camel@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
 <20260513071905.83522-4-w.egorov@phytec.de>
In-Reply-To: <20260513071905.83522-4-w.egorov@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2P195MB2328:EE_|GV2P195MB1943:EE_
x-ms-office365-filtering-correlation-id: 1dabef12-06d3-43f5-f5da-08debb5e8c96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|10070799003|13003099007|22082099003|18002099003|56012099006|38070700021|6133799003|4143699003|11063799006|3023799007;
x-microsoft-antispam-message-info: k8blxcTiKyFy0L02qxcJXzSbEk0r3Q2AEgzwMMjyVksARpTmKlseMtlxlMe2X05OzL1fUW+XaJfGPB4ilyd0pz6PBQ2r+aP0QuMg9cbVpfCXlWMciBwTg7qd3F2+Cx6FqZ6sfCbAE7jTQgVyZkLczszUx/wMa6OC3aEk9Jo1G4ucU77DEepaxtGgcuJnPWi8WVp5TnZti69uLnU1b1JryyeGiKrDtMTDc26O+xNDBZqpY75cKwPdoxOLlXF5omZ12q46aAwFTMsXou83GIk3x8UdzQYAIaXqWD42IS4J+MZ8S3lXDRri4ZBHEiMX6nObZZkwEpct3lnQoUevCgz4mdkuC4d48D/r3oMiM0ifYxomzKH5v9xFzZNfU0oErBO/0dDBpszoEJUoaRBYl5fHGbdSIFQq6JeRuC3O1mVXBFUk8LzuGe3LwdDTu7NLVcZf6fT4KNG96KNXqt23M38GGDrFs3rb3pT8g3+scjeBJUNszOwz76qKcQwah7eH6+dnRqCW7SCjZGdbXUAX8Vku9zhxQOTpdLjP8THa/GoZkmJGCvtA8DTzEN+9Zx6AGRwWlD7r2Rsk46ezYKmm3gNpLzRlqImjpcOL8s/fun5mbobaPNpXEVv6SWrLvCs4adA4ZImIy+lbmwBlrGBMgGt7PByqZD2/P4/PrvvLrN0KOqOE9XCpoRtJgEUTjQUXpXuxaEvbCY50943CDUJ5jml4bQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2P195MB2328.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(13003099007)(22082099003)(18002099003)(56012099006)(38070700021)(6133799003)(4143699003)(11063799006)(3023799007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUFycUhvZGtZWmVDTDJrUHBHakNWNHJGb0U3REVjQjAwcDRHWXNBZEQ3dnBJ?=
 =?utf-8?B?RytQY2ZubzhubnVMVnNxUyt3d3lPWEdSMG5KejlGUTVaZVVLSVdDSHRRYkJT?=
 =?utf-8?B?NnF5RjlRVnkyaTU2bEgrQmJBNmpPYWtEVWVrczBWQjQwMUY2TUpaM3ZWQXFU?=
 =?utf-8?B?YzFCUVB3SWhpcEwyS0IyV1hFZkRNSmxiMWhmQkcra2FmSzVpZStPR2l1ZjU2?=
 =?utf-8?B?azhFcUk5VHlrWEVFRkxTaTdSbWtBMUx6Vk42QVdUMTJEQkJGQ1loTzczR2Iz?=
 =?utf-8?B?aDVYL1R0bVVYVXhqRjFhNmRNTlBxMThxL2I4dE15UXVGWXZLQlBSYms1VXg2?=
 =?utf-8?B?WXkzWGFsTHV3ZkxWNnhvamtLanVJckJrUnJSbVpzalBoNURDeWIwMk9yVURT?=
 =?utf-8?B?MEpwTmg4VzNDRDhyWTlHSkVoZk1OekppVGo0OG9jSWtRVzhTSS8zR0ZQMFVV?=
 =?utf-8?B?T0FabUIxQU5UdlVXMGVzQ01TZFBnTDNpaXkwVlFmanlwYTZ0RVA2WWljczhF?=
 =?utf-8?B?TDNMR1RpNWJwcEwxaDRGNDNxbnkzaFpiWklXVmtpQ1cweEVnUUZoQ2wvZnNM?=
 =?utf-8?B?SFVKcTlZZXFkbFBUVDN1ZmplQjZvSStUVlVEaDBRY3kwdXpuV01tMm1PNXlK?=
 =?utf-8?B?T0FHYS8rZ3lYa1JITE1YZzR0eTJQN09idkZESWZSRzdFOFVpYVRmYVpzOFk5?=
 =?utf-8?B?UEZadWt4SnNkdVNzOGNpZmh0Y0ttWmNYTk9vaU1ieFpuSi92d3BETktPNEl2?=
 =?utf-8?B?YnV2cjUvb2M0U2NFQWlzVVd6NHArRmVIUi9LVDdKb2R0dW1Rdkp6VkgvMlJP?=
 =?utf-8?B?NE1Tb254cGFGYW9FNEJ4d0c3NGVCRFB6ckRRUHFKU3IyVWtTWENXQ0ppRlRS?=
 =?utf-8?B?dHVYcGhEY1RKSDRZQ0grSFRKTVhISllSZ3MvbS8wdHk3bFVyd2srTkdqYlFs?=
 =?utf-8?B?Mm1ETnZVNWlpUnQyNzF4bEEveHhsSkpjeTVnMVMwOWRxUkxZcXM5ZGkzM2dh?=
 =?utf-8?B?ZkxBMEI4VDVtR01JSFlJM1JXRkE5VU9jNkk1TVRQZUVkSWlTbStQRWhBVzY3?=
 =?utf-8?B?NnVCclcwTEI0VmZ0RjhaSnJ3OXJ4Umd4OElibHNYRi8rb3dTRzdOSVRLbE5S?=
 =?utf-8?B?Wm5PM1AycXl4azdFNnAwWjJtbWI0WmVqUEN3ckFKa01LZFcwRzJYT1NjNkdi?=
 =?utf-8?B?Z0VIa0NEM3JrMVN4VFRad2dINFplc211N2Q2QmVwSExROUZ1b3FrQklpQjBM?=
 =?utf-8?B?MzVLamRaWDBnZm13bFBTclA2aDdjcXRFdWI0Y2xxb1daYi9CWEVVVm91V0tE?=
 =?utf-8?B?T3NtRFZLWitkMjF5NHlBNW4zUFZIWXQ5bUVYbU0raEt2WkpBMExzRmc2dlVT?=
 =?utf-8?B?OG1hclcrNVIxZmZ3ODlyMXAvUTVmYTQzUS9LQTgyOXhEdXNBTmNQbEM5RDdH?=
 =?utf-8?B?VjZNSjFYb2tpODFNM3haeXU4azM2V2RIQW1aT3BxM3pEdFZqMWc4Yi9VanQ2?=
 =?utf-8?B?N1A0Qk5QdzlNdDYxT3VLZjVZOUl5WGZWVkVnbVFndUV5Tk1mMkNULzM0dU5s?=
 =?utf-8?B?cHlrVE5WQllWMVlqdlYxQ2lCNDBkOHpndk83NlJRejVLVWo5WHB6SCt3Q0Fh?=
 =?utf-8?B?K25XeEI2WnBobDU2ekRKdVlRUUF5QWVnWW9idE9MVjdqc3FqQzVPZlFkU1Q5?=
 =?utf-8?B?cGRPWlRyU2cvTFhyM09lSzMvU3YzTVBCVnZoVXBhSkFkZU16eG42THowSDNK?=
 =?utf-8?B?WWwwS0N5YTJiMmEvUGJUZ0E1bHk1eEkyT0pFZXpTdnppcXFWZWlnYVdTV0dM?=
 =?utf-8?B?QzJlMFR4bk1Wc21RajVTbzlWeUZrU05CSzJHZjhIeTR5WVNwT21PZ1Q4Mmsx?=
 =?utf-8?B?NUFDVmlzMm9RS1pMNXIvamFSbkV3clhpTThxeitUdW1YQWdjUHc1NnVJWGR0?=
 =?utf-8?B?aGJhZzJoLzFkWW50OTdMOUNJSG1EN0Q0UGh2STQ0ek80NzZmTS8vODZacU12?=
 =?utf-8?B?WVJhNENpd1N3QUdJTTNORkNjRDhROU41YXdBd0ZsR29Qa2JiUTNnQlFGQTQ4?=
 =?utf-8?B?a2R6YVpXaTdmejhXMlp0Mmx2MnErTmkxcmY1NkN2TFJSTWZzMTZram1ZWmpm?=
 =?utf-8?B?TktBRCs1MXR4OVEyNklJUStMVE5IOFh3enlhZmNvb0NzUTJldENHdGtnZXpO?=
 =?utf-8?B?aUpEZzFNRHJGbUtQbHg5aUpnM1JXaGdYVGxrbVN1aEVwZ29JYldOdnR1TmdB?=
 =?utf-8?B?NTJkZkloVlNUZHQ1SmlUQndxcEVEYVVyc0R4VTllNjg0cUxMVXFYbk80bENl?=
 =?utf-8?B?TUx5dVdUOFlwTnhYcWNyeUlnK3NDUyttU1ZISGExOHFwRnY0cVdHODBDNWtJ?=
 =?utf-8?Q?dHfbDpA50Zm5ToZqkbWz2qy+0BU+XkDZy7rWZrIC+4myO?=
x-ms-exchange-antispam-messagedata-1: B0LbxXHi09XfEg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <22BE0276EDB4634CA609B17394F3E10D@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2P195MB2328.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dabef12-06d3-43f5-f5da-08debb5e8c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 19:39:49.3063 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fGj+pgE1KFyrBdJzBm7pdyfLzBFAp2xxAo1A22XFZyUAbPVsxrmJNQvCPOORWCjTYrN8mWe0dQQ4Arh8DorBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB1943
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

CkFja2VkLWJ5OiBEb21pbmlrIEhhbGxlciA8ZC5oYWxsZXJAcGh5dGVjLmRlPgoKT24gTWksIDIw
MjYtMDUtMTMgYXQgMDk6MTkgKzAyMDAsIFdhZGltIEVnb3JvdiB3cm90ZToKPiBNaXJyb3IgdGhl
IGo3MjFzMiBjaGFuZ2VzIGZyb20gY29tbWl0IGM0ZmNmOWI4MDZhZSAoImJvYXJkOiB0aTogajcq
Ogo+IFVwZGF0ZSBybS1jZmcgYW5kIHRpZnMtcm0tY2ZnIikgdG8gcmVwdXJwb3NlIGFsbG9jYXRl
ZCByZXNvdXJjZXMgd2l0aAo+IHZlcnNpb24gVjExLjAyLjA3IG9mIGszLXJlc291cmNlLXBhcnRp
dGlvbi4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBXYWRpbSBFZ29yb3YgPHcuZWdvcm92QHBoeXRlYy5k
ZT4KPiAtLS0KPiDCoGJvYXJkL3BoeXRlYy9waHljb3JlX2FtNjh4L3JtLWNmZy55YW1sIHwgMTQg
KysrKysrKy0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVs
ZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3BoeXRlYy9waHljb3JlX2FtNjh4L3Jt
LWNmZy55YW1sCj4gYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9hbTY4eC9ybS1jZmcueWFtbAo+IGlu
ZGV4IDg3OTY0NjMxMjlkLi43MjhiZmUyNDFhNCAxMDA2NDQKPiAtLS0gYS9ib2FyZC9waHl0ZWMv
cGh5Y29yZV9hbTY4eC9ybS1jZmcueWFtbAo+ICsrKyBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2Ft
Njh4L3JtLWNmZy55YW1sCj4gQEAgLTEsNSArMSw1IEBACj4gwqAjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wKwo+IC0jIENvcHlyaWdodCAoQykgMjAyMi0yMDIzIFRleGFzIEluc3Ry
dW1lbnRzIEluY29ycG9yYXRlZCAtCj4gaHR0cHM6Ly93d3cudGkuY29tLwo+ICsjIENvcHlyaWdo
dCAoQykgMjAyMi0yMDI2IFRleGFzIEluc3RydW1lbnRzIEluY29ycG9yYXRlZCAtCj4gaHR0cHM6
Ly93d3cudGkuY29tLwo+IMKgIwo+IMKgIyBSZXNvdXJjZSBtYW5hZ2VtZW50IGNvbmZpZ3VyYXRp
b24gZm9yIEo3MjFTMgo+IMKgIwo+IEBAIC00MjksMjQgKzQyOSwyNCBAQCBybS1jZmc6Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc2VydmVkOiAwCj4gwqDCoMKgwqDCoMKgwqDCoCAtCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0X3Jlc291cmNlOiAxMAo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIG51bV9yZXNvdXJjZTogMTAwCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bnVtX3Jlc291cmNlOiA5OAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlOiAxNDUyOAo+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBob3N0X2lkOiAxMgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXNlcnZlZDogMAo+IMKgwqDCoMKgwqDCoMKgwqAgLQo+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0YXJ0X3Jlc291cmNlOiAxMTAKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dGFydF9yZXNvdXJjZTogMTA4Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9yZXNvdXJj
ZTogMzIKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHlwZTogMTQ1MjgKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgaG9zdF9pZDogMTMKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVz
ZXJ2ZWQ6IDAKPiDCoMKgwqDCoMKgwqDCoMKgIC0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
dGFydF9yZXNvdXJjZTogMTQyCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnRfcmVzb3Vy
Y2U6IDE0MAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fcmVzb3VyY2U6IDIxCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHR5cGU6IDE0NTI4Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGhvc3RfaWQ6IDIxCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlc2VydmVkOiAwCj4g
wqDCoMKgwqDCoMKgwqDCoCAtCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhcnRfcmVzb3Vy
Y2U6IDE2Mwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXJ0X3Jlc291cmNlOiAxNjEKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3Jlc291cmNlOiAyMQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0eXBlOiAxNDUyOAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBob3N0X2lk
OiAyMwo+IEBAIC0xNDMxLDcgKzE0MzEsNyBAQCBybS1jZmc6Cj4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHJlc2VydmVkOiAwCj4gwqDCoMKgwqDCoMKgwqDCoCAtCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0YXJ0X3Jlc291cmNlOiAyMzYKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBu
dW1fcmVzb3VyY2U6IDIwCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnVtX3Jlc291cmNlOiAx
OAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlOiAxNjk3MAo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBob3N0X2lkOiAxMjgKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVzZXJ2
ZWQ6IDAKPiBAQCAtMTQ5Nyw3ICsxNDk3LDcgQEAgcm0tY2ZnOgo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXNlcnZlZDogMAo+IMKgwqDCoMKgwqDCoMKgwqAgLQo+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdGFydF9yZXNvdXJjZTogMzQyNgo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG51bV9yZXNvdXJjZTogMTE4Mgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG51bV9yZXNvdXJj
ZTogMTE4MAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0eXBlOiAxNjk3Mwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBob3N0X2lkOiAxMjgKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmVzZXJ2ZWQ6IDAKCg==
