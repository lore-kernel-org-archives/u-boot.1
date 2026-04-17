Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52704F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A0D48442A;
	Fri, 17 Apr 2026 14:44:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="W3dWOpyB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F384C83FC0; Fri, 17 Apr 2026 14:37:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFCA783FC0
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 14:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cK9cmf1D7EY2TVqxMHlRePpBE8+1CbTMhPTOrU9Y0MXl1HByd1jtsqw0H7tbIqwII0R4wU3L/2xijKeca0PVCbRUoJ5VaDmyB3ZVR2p8Ot+/qP9YZU0tNgm1dsdqNDFP5OyyAMC54pT4dZyWhy/31mI0G6ic/MDyAXwTHsTUHUI5/pnY9w7zSjopXtHKkat5yT9WhLDb9Hcr/neyE6oD1uMTJl8Zw9JmnSHWeB1t6JQeO/EFfP1koHBKFsHfb8rTb1cw/vCyZk+ufYu4QNJ3WWtBEkBYXnR3ZEDxL+6qBwmICmkMcRfcsWWxCxoGv38un49+8i2uwRsEHul3Ibx1vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znBl/+6cN42K3IhT3N409KM4ktV8xNIOgrLR/i+4zsk=;
 b=WvBIOMLKDNoormiaMrpPtiSGwBz4CVivSsZILWOvot8iBTktsbeIsRCc3Yl5YOhR3vMGSgLrfg9GIhfWkyNVhX4IA1wlwO+VIRH1jDgwBbJBF11dQCqdicRI/vUQl0WrKz2gmeExZcz9IEGLW2f6W0xPB10V2rzmUn/vdyQn16Cp8dOD4yslUofR92atXihUJsuS99yvfqrVb0kAkTYnuAqnO6zf2QQRDwww6UoqzDNqdw6gA6MmQ2lK8wYKDLWB5xXNdRGAJmaC8l/GiPEGF7g/LA4cj+RZdKKoqhwslcQMFf+1WDxLRbhv5p1a/jYzJmIjb6f8YO/lQFnko/pTmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znBl/+6cN42K3IhT3N409KM4ktV8xNIOgrLR/i+4zsk=;
 b=W3dWOpyBLI0568dMqb3+aH02xZFjQDum0g9+ZFxP3PgxFfX26HNl5ubO0VCTw5canzJ82VygZ2KTS9RlRkwLHXuFB1S0NaDBQPYOxfPBpsWkJzllNe2VJ4u8x3/dBcYFd7t8k6yoFe0H9HKCLA+2m/K2cofzPWPWq17ZxZHvR+OoLYhAlMIX2aJCJYuR/lW41W8IR2fj5u7PS+3lbD8EfgGTmCdAs658+H+Pj2qqex6brwPEiTKUeTF8Nmtzzp55BHxcE4wNXYNyVnlcdvvx/4J153+qDZdJlxyFS6xLfcejsXuYJWOoLOzaLONzwIeGoqnbw0MU43djCPb84As5sQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by AS8PR09MB4631.eurprd09.prod.outlook.com (2603:10a6:20b:29e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 12:37:29 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%2]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 12:37:29 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <me@ziyao.cc>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH v6 1/7] riscv: Add initial support for P8700 SoC
Thread-Topic: [PATCH v6 1/7] riscv: Add initial support for P8700 SoC
Thread-Index: AQHcvfOT04ZaizXAPkeedKvDKxrTE7XDnc0AgB+0M4A=
Date: Fri, 17 Apr 2026 12:37:29 +0000
Message-ID: <0292d670-abc1-4e45-ae40-000cb5ca3762@htecgroup.com>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
 <20260327141029.628483-2-uros.stajic@htecgroup.com> <aceRLGu6ytbHs1Qv@pie>
In-Reply-To: <aceRLGu6ytbHs1Qv@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|AS8PR09MB4631:EE_
x-ms-office365-filtering-correlation-id: 2c56b922-bdac-4f01-312e-08de9c7e16ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: QWu2AnGIiqzHQaCZWkjqLgrp7kqYGv2pPis44Lxx8Bb7cFxFJ5Kx5f8FofF6dwVnLbUk9tu3uR9mXhxVSal+l8ynnv6E8cmlhCSjIdICKB0l2nBMkgLQK1GYh2tT6UBMYxWU1AKuCs4heaqzM401UsgGAGXtva5FcxAoIJhJNVT4II96CKoYtLgTw9hXbTQ05M3d6yoDm++/V4MJpj2xZFdyO/uio+QnbaOqRiG0Y6AIrOMrXQMylcIC0ChNGsbeyMAO1TW/1yS9xxQkvVx72GPljA/W3lJ94OHQ8C14pN9RdhcpllD8/tf9N7M2OtkUhlcgX102nCR1sESsTHMp1n+kRoQTlDCy5ln0MlpalBHYBRUqeRcL1IzdGmjtqwWiu/wB8NRRCqwbSeUZneCnz9Tb+BVOLzkwqm0TbSxhB/aDhTdT8dC1lbrWACYpB+nin9fMKM137JaVe4quvnV2+FezsH9nm3VXVH0bMPdz7z6xDcQ6Kdn0Pp/qbU7gQgkPSgLsTkJvFwar25KaSa/KdAAOeXl2++RpXXrBKs6gq8koncAS9/BhWI+RdmMPbg+I/vJ+Y+HmMrHQW0DWvSMJYRZjJJVY6jzgecSmJu7ORQDppjifjn5Sgv+E6NJPIA3Wzlbcx/3lyXJL8tYL4tW1SqD58Coo6Et9NT23iJVgEs1I9ZW62h/HnjpvmcYtnSKhatgcz0lHqSsHy0/vfCJNeDfPU9+QTf8JZE0spWhiXAhNxEbpiQ+fjc9uAnQ84ddP3sdYbcJTueAxUHYAuSVbiz+u0x1wKQCpFOsiIQxW+rg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWVESFJhL3V3Z3RCZjVXY2Nma3JzVzlCL1pBN29OWjMyVmR4NFFwcWJLTWl4?=
 =?utf-8?B?U3dBL0FXaWc2UURyd2hFWCsxOHZNQXpiSGlHV203VE11S0Y4MTlPRzlmc2tC?=
 =?utf-8?B?YkxvenVSZUt0UWpaZnZzcG42M1JpcStoU0xTdklHTlBxQy9nWEZDaXViTzNB?=
 =?utf-8?B?dmVRcDBibjNVbkhKVjRxdlBtNFVWanZBbVpST09PbmtYa1RDYzBlMDZZSHly?=
 =?utf-8?B?MTJtYnBtbWdnUyt6VXNkR3VidXd2OEVnaTJDN2RLNmw0WU5RbzNIU2QvVXVN?=
 =?utf-8?B?RllYV1BzN1ZLd1Y0WXY0NjNZbzVIZ0xFNm5UUVZoT3g1RE0vTWorY0V5cHNZ?=
 =?utf-8?B?OW5Cdmlldzd0WGhUQmFjTmZqdEVMcFRmeE9VdWxsY2xwQmlEaEFRMjVHb2Ir?=
 =?utf-8?B?MDA4UHcwdlMvbG95N1lzQXN3N0ZLT1pOT21sbGRSTktNaGxMeWg3YUdGK0lx?=
 =?utf-8?B?aTFXREdLako5LzhVbmpCbnVpRHFjVkpTamhUelB5ZWFoM001d25JQmhsVlJM?=
 =?utf-8?B?NWxsNlBCaERBRDJwWkpZRm92eDNpdmZObGZ1czhBMVN0dGZhUDlXbnAyZnBi?=
 =?utf-8?B?ZG5jS1JiUS9TS1czOFp1UHJQQyt1YlFWN2FHV2R1b01qWjg2MUwzbFM0Rk9x?=
 =?utf-8?B?T3N0TXNTSU04UGhuZVpPTTJWV0xpWUd4R2I4QUt3WWtBdkE2eTZnNlM1cGhh?=
 =?utf-8?B?T3RYdS80MGplN0toaHQyNUZ0Tk5OalBHa01OK0FuMlVZZGVHc3NiWklyRTcx?=
 =?utf-8?B?R0Fob1NRZWdQV1ArYWJwNXNzYjZQN3dUQmZWYkROMTFmQURKMWIwZDRFZ0Jm?=
 =?utf-8?B?NTJvc08wSlYrMU84MzYxaEFKMmlVMnU4TWtDZFNQMGtmL3FFNzhMVUpuU3ph?=
 =?utf-8?B?QjRzLzZnY250dnkwbUVIcTFXcW1rUTZjVmUwMkZ1NUxBWHdQckl3eTNWTnNL?=
 =?utf-8?B?T2hUTDhZVGYvd2JzZVkyck9iNkQvdlRNdUcyMzczRC9LNEhQcitCMXV6SDJh?=
 =?utf-8?B?WG1PK3JCZFRMcWRqWXBsclliSllGaW1PK25KZHhjZzdwRngvQlVYNlFqUS9o?=
 =?utf-8?B?MHp4T21YeUJaMFdSVlZIenV4OStmb1JJTERQWXl3Q1NnMnJ5cUVCYk5oZDNp?=
 =?utf-8?B?S1hNZC9GeG5GSUdLS2pBV2JIaTkzQ1dPaDZCczVFN1JNMlh3a21nS2VBbFh4?=
 =?utf-8?B?dVh1Y1hDVUYxWjlzb1lQU0JsbEFGYk1lWUJudUhXeG55U01IOXpKK2xIME13?=
 =?utf-8?B?ZGR0K1JmL1hUcG5iWEdtVmJDTzlSbU80QzArdnY0S0dxSzZuTW16R0Z5dFNi?=
 =?utf-8?B?WDlkT014QzVYOWNyWHJEM3lIRTRiclg2M1BZZTdIbDd3R1d2bGxaTjl3Z3hw?=
 =?utf-8?B?aGZ6Q3U4QlAzWmhzUEJyV1creFpRTDVOYTlIOFVTQWpNYTFiU1JNUVc1UjNN?=
 =?utf-8?B?cUF5YUNzWmJpN1c3ZHZkaXdjYXdsNHJvZGIreFp4TEZLSndHK3RtS3Z5MThk?=
 =?utf-8?B?aDZRbEtjVmEzUnVtdlR2OStYbEptRFgrWENaNTBWRWlzbXBpaWRZdzFGOWRl?=
 =?utf-8?B?amJ6WlorR0M4TVVVaDJOVVlFaHpqb3p2N25ablNzL2g5UTFKU2NjSHY1YU5H?=
 =?utf-8?B?cWVaU2xnL0NwTXM3aWF3bWFqWWNQU2ptZXIxMTZhZS91dC8zVFIrSVd4aFAx?=
 =?utf-8?B?dDBoUDIvQ2pxVzU2UEdmMHVBVE95UXI3T2VDWHJUS1RSckdGaEZNUUphelRF?=
 =?utf-8?B?U1VaWTBJQUQvRDZqaldJLzJxWDdqblhJQVJ3ZFBnRmxqdTd2czRKNTgxb2hC?=
 =?utf-8?B?Rk5YZmJZR2RMWkx4NmdsTUUzc0h4ZWExdFZEUkhoRUh4RFhMcytEZHJNTUsx?=
 =?utf-8?B?VnZXMnZnMGFwRHcwam9qckEwQ0E3VU1ERnd2N2FQUENuVkxabEYwTUU2eUtT?=
 =?utf-8?B?Vm5ZVy9nenFDam1XeUM4M1dKWHRNT2YzZWVpaW1McStSWEpiMHhodWlsbnFi?=
 =?utf-8?B?SHkxNVJQYUllb1o1TERDYzRnWGhQMSs4eENXZ0dWRGM3ajFLZ0NuVE5zbG1k?=
 =?utf-8?B?dHdHZEZPUTRrbXJZOWllVjd3QkF1azRnMUxlWklSRHNIWmtSaFFpbjlENk9u?=
 =?utf-8?B?c3QxWXpoNzFVM0ZSeUVsMHhsVmJuZ2hWU3BZNzMyaUtmMHFXNjlqekJya2lB?=
 =?utf-8?B?enFIQWg5U2krS3NXc2dwd3F6dTVmWWJrUVZSS0ZkSzJ0SkJYQWhnVU5tWXRw?=
 =?utf-8?B?Q1R2SDVaR3Y3N083bjBnQ2Z0V1hpdWxDLyszNTZvSGE3YXV6aFNDM1dXd1ZY?=
 =?utf-8?B?N3hIanRpQ0xQNVJHeTZHWWE0bU1QaXc5a2pRTmZkS0FNaHZyc1JOdG9BV3BI?=
 =?utf-8?Q?erp6NxykQVCHG1kY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0087DF19FAFA0F4FA94EEEB76F417F57@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c56b922-bdac-4f01-312e-08de9c7e16ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 12:37:29.8541 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PaCCx0X0AdQ+28siLlTnW4IMKH8HRsYn7RFezKkvxO0BbUZ6UONbpRHdXIwTtnfGEHLRI3n2tN89ulHTQ9kDrV41ZvkCV+BNO5u+R2GcXto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB4631
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:43:59 +0200
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

SGkgWWFvIFppLA0KDQpPbiAzLzI4LzI2IDA5OjI4LCBZYW8gWmkgd3JvdGU6DQo+IFtTb21lIHBl
b3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9t
IG1lQHppeWFvLmNjLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2Eu
bXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IENBVVRJT046IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhl
IHNlbmRlciBhbmQga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIEZyaSwg
TWFyIDI3LCAyMDI2IGF0IDAyOjExOjE1UE0gKzAwMDAsIFVyb3MgU3RhamljIHdyb3RlOg0KPj4g
RnJvbTogQ2hhby15aW5nIEZ1IDxjZnVAbWlwcy5jb20+DQo+Pg0KPj4gQWRkIGluaXRpYWwgcGxh
dGZvcm0gc3VwcG9ydCBmb3IgdGhlIFA4NzAwLUYsIGEgaGlnaC1wZXJmb3JtYW5jZQ0KPj4gbXVs
dGktY29yZSBSVjY0R0MgU29DIHdpdGggb3B0aW9uYWwgbXVsdGktY2x1c3RlciBjb25maWd1cmF0
aW9uIGFuZA0KPj4gaGFyZHdhcmUgbXVsdGl0aHJlYWRpbmcuDQo+Pg0KPj4gVGhpcyBwYXRjaCBp
bnRyb2R1Y2VzIHRoZSBpbml0aWFsIHBsYXRmb3JtIGNvZGUgbmVjZXNzYXJ5IHRvIHN1cHBvcnQN
Cj4+IHRoZSBQODcwMCBDUFUgaW4gVS1Cb290Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8t
eWluZyBGdSA8Y2Z1QG1pcHMuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogVXJvcyBTdGFqaWMgPHVy
b3Muc3RhamljQGh0ZWNncm91cC5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC9yaXNjdi9LY29uZmln
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKysNCj4+ICAgYXJjaC9yaXNjdi9jcHUvcDg3
MDAvS2NvbmZpZyAgICAgICAgICAgICAgfCAgMTQgKysrDQo+PiAgIGFyY2gvcmlzY3YvY3B1L3A4
NzAwL01ha2VmaWxlICAgICAgICAgICAgIHwgICA4ICsrDQo+PiAgIGFyY2gvcmlzY3YvY3B1L3A4
NzAwL2NhY2hlLmMgICAgICAgICAgICAgIHwgIDkzICsrKysrKysrKysrKysrKysrKysNCj4+ICAg
YXJjaC9yaXNjdi9jcHUvcDg3MDAvY3B1LmMgICAgICAgICAgICAgICAgfCAxMDUgKysrKysrKysr
KysrKysrKysrKysrKw0KPj4gICBhcmNoL3Jpc2N2L2NwdS9wODcwMC9kcmFtLmMgICAgICAgICAg
ICAgICB8ICAzNyArKysrKysrKw0KPj4gICBhcmNoL3Jpc2N2L2NwdS9wODcwMC9wODcwMC5jICAg
ICAgICAgICAgICB8ICAxMiArKysNCj4+ICAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS9hcmNoLXA4
NzAwL3A4NzAwLmggfCAxMDEgKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIDggZmlsZXMgY2hh
bmdlZCwgMzc4IGluc2VydGlvbnMoKykNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlz
Y3YvY3B1L3A4NzAwL0tjb25maWcNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvcmlzY3Yv
Y3B1L3A4NzAwL01ha2VmaWxlDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2Nw
dS9wODcwMC9jYWNoZS5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2NwdS9w
ODcwMC9jcHUuYw0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9yaXNjdi9jcHUvcDg3MDAv
ZHJhbS5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2NwdS9wODcwMC9wODcw
MC5jDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2FyY2gt
cDg3MDAvcDg3MDAuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L0tjb25maWcgYi9h
cmNoL3Jpc2N2L0tjb25maWcNCj4+IGluZGV4IDc5ODY3NjU2YjE1Li45ZTJjYmU3NzVkMiAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvcmlzY3YvS2NvbmZpZw0KPj4gKysrIGIvYXJjaC9yaXNjdi9LY29u
ZmlnDQo+PiBAQCAtMTMyLDYgKzEzMiw3IEBAIHNvdXJjZSAiYXJjaC9yaXNjdi9jcHUvamg3MTEw
L0tjb25maWciDQo+PiAgIHNvdXJjZSAiYXJjaC9yaXNjdi9jcHUvazEvS2NvbmZpZyINCj4+ICAg
c291cmNlICJhcmNoL3Jpc2N2L2NwdS9rMjMwL0tjb25maWciDQo+PiAgIHNvdXJjZSAiYXJjaC9y
aXNjdi9jcHUvdGgxNTIwL0tjb25maWciDQo+PiArc291cmNlICJhcmNoL3Jpc2N2L2NwdS9wODcw
MC9LY29uZmlnIg0KPj4NCj4+ICAgIyBhcmNoaXRlY3R1cmUtc3BlY2lmaWMgb3B0aW9ucyBiZWxv
dw0KPj4NCj4+IEBAIC00NDIsNiArNDQzLDEzIEBAIGNvbmZpZyBTQkkNCj4+ICAgICAgICBib29s
DQo+PiAgICAgICAgZGVmYXVsdCB5IGlmIFJJU0NWX1NNT0RFIHx8IFNQTF9SSVNDVl9TTU9ERQ0K
Pj4NCj4+ICtjb25maWcgUklTQ1ZfQ01fQkFTRQ0KPj4gKyAgICAgaGV4ICJSSVNDViBDTSBCYXNl
IEFkZHJlc3MiDQo+PiArICAgICBkZWZhdWx0IDB4MTYxMDAwMDANCj4+ICsgICAgIGhlbHANCj4+
ICsgICAgICAgVGhlIHBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhdCB3aGljaCB0byBtYXAgdGhlIENv
aGVyZW5jZSBNYW5hZ2VyDQo+PiArICAgICAgIEdsb2JhbCBDb25maWd1cmF0aW9uIFJlZ2lzdGVy
cyAoR0NScykuDQo+PiArDQo+IA0KPiBTb3JyeSBmb3Igbm90IHJhaXNpbmcgdGhpcyBlYXJsaWVy
OiB0aGlzIHNvdW5kcyBsaWtlIGEgTUlQUy1zcGVjaWZpYw0KPiBjb21wb25lbnQsIHdvdWxkIGl0
IG1ha2Ugc2Vuc2UgdG8gbW92ZSBpdCBpbnRvIGEgTUlQUy9QODcwMC1zcGVjaWZpYw0KPiBoZWFk
ZXI/IEZvciBleGFtcGxlLCBhcmNoL3Jpc2N2L2NwdS9wODcwMC9LY29uZmlnLg0KPiANCg0KVGhh
bmsgeW91IGZvciB0aGUgc3VnZ2VzdGlvbi4NCg0KSSBoYXZlIGFkZHJlc3NlZCB0aGlzIGluIHY3
IGJ5IG1vdmluZyBDT05GSUdfUklTQ1ZfQ01fQkFTRSBmcm9tDQphcmNoL3Jpc2N2L0tjb25maWcg
dG8gYXJjaC9yaXNjdi9jcHUvcDg3MDAvS2NvbmZpZy4NCg0KPj4gICBjaG9pY2UNCj4+ICAgICAg
ICBwcm9tcHQgIlNCSSBzdXBwb3J0Ig0KPj4gICAgICAgIGRlZmF1bHQgU0JJX1YwMg0KPiANCj4g
UmVnYXJkcywNCj4gWWFvIFppDQoNCkJlc3QgcmVnYXJkcywNClVyb3MNCg==
