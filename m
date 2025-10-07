Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E72CCCD184
	for <u-boot@archiver.kernel.org>; Tue,  7 Oct 2025 08:22:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4D5D8388C;
	Tue,  7 Oct 2025 10:22:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Xzh2jD6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB3F38388D; Tue,  7 Oct 2025 10:22:13 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBB0483881
 for <u-boot@lists.denx.de>; Tue,  7 Oct 2025 10:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vF8gl3Dom+YZhmnJbD3nFVPVEHptpmvx0+AL4i2vOMp0Te5FZOAiC8pCydlBC3aQbVhplG9CgCU9xildAaaj/Bl44h3aXkJ6Vhypa3miHvgq+5VJfdUWM2v9WrEYSAYzQ/CnY1wq/Gwzu4iuMlNPcZRYZwlL7mx/c6M9x9PZT953jk5ShZS4qB5JhW17mxiD8LHRyk3OZsqx8VcRe+UM866IKF3qFj+jGuxJYFgM9SzUbDgZ5HF9gSk8FhGM1wBbU5V3WEEi0SWQWaHwKSW7OgfzJm/jHPlPT91ChTmFEc08EA29uetUYEFKkbTZkxZbfYuBptLBBcMeDIlTHGjp4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkQNJUI4A8tQuZG16YvbK//6E2cnQ2JoZh9G8gQzt+c=;
 b=tstKDsdbLjzmAoBiSkL4I/wylQP7LfW7bRRPYFlobekH7s5ED7VaQMMj7ST42b5rkKv++EiYxhd2JIEyyKJiSSyT+yTnD0Yn/aPBZmUd/UdM26luXDcIi1co6cGEDllNJ4q3a7GygEJmak5en+OuHp/WiB9eGXgmE4mgMdjJebFotctUrl94+43ot+2AWViCSLphdeZ+mj/8AfxgOw4zjVOtnSw0/Zw8mezgyUrxE8U1/TTsMfBTwLxszVEJIDC8/IgaFdUY+tuCsfOz+LhiUVrogq3O0q6uz3yUXYh4BGxQnp/R049nrTK3l87/5WqqcutNCSZ9giXhNGQDQSNc2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkQNJUI4A8tQuZG16YvbK//6E2cnQ2JoZh9G8gQzt+c=;
 b=Xzh2jD6ZvhdYKHYR7QBCaaMahLsFgYBwQRFMJb5X5UWLS8xNfnIXZW1nkwKpOaNMecmhIik3Xa/l9Ffk5NMZahjUcuJkgXKbuMKaeLQTcFwKcNWSKVtP6YF+WwVrSQEpWukySJDlIJCY0z+aTc9aztOm0AsZLJ+59hUatrmPV/DtU66s19+FATkvxA9EyiRlgge6Qx4flzxGZOuNGg2cdz/NK7B0grnPfgVP6Rgfp1Pe3SLHBw39MjP0wW1sCYLCD37GAr50WCQ86A6wT9I+zajqJYvk1xGCpQGs8yrbVV7zcdUvDgN0vbpWPinY7bCzK8ZEwuuMBnlF27EmkJQwsA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by PRAP195MB1460.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 08:22:06 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 08:22:05 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Martin Schwan <M.Schwan@phytec.de>, Tom Rini <trini@konsulko.com>, Teresa
 Remmet <T.Remmet@phytec.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>
Subject: Re: [PATCH] board: phytec: phycore_imx8mp: Add rauc to bootmeths
Thread-Topic: [PATCH] board: phytec: phycore_imx8mp: Add rauc to bootmeths
Thread-Index: AQHcM46hgAR65F11CUaBpbSMP2v6o7S2X9CA
Date: Tue, 7 Oct 2025 08:22:05 +0000
Message-ID: <fd8d46a2c6fc2f15a632de44b291ce30deb46cd7.camel@phytec.de>
References: <20251002-wip-config-imx8m-bootmeth-rauc-v1-1-e54d43a6fd70@phytec.de>
In-Reply-To: <20251002-wip-config-imx8m-bootmeth-rauc-v1-1-e54d43a6fd70@phytec.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|PRAP195MB1460:EE_
x-ms-office365-filtering-correlation-id: 0e55a87e-4c1a-44bc-db7b-08de057a99c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ekJyYldRQU9yYittbmdaendCZzZsRmgxdjd4TmdJckVLV2N4VkM4UEJvczEr?=
 =?utf-8?B?aDZuQkdIdTFNUnR4WE53V0wvT3ZrT0tZZUh6bnpTYVVQM2tGL0J2aTc2bmpB?=
 =?utf-8?B?RGRxL2JlOERYOVY2MlBUb3RBUU9tNk8vcWRnejE4ZU5VbmFCdk9hOWRKQ3Jj?=
 =?utf-8?B?c3FFV2VlNm5uc1FGWE51QVZJREpQSVNXaFFQckhmR0g3cERLVWlocWtENEU4?=
 =?utf-8?B?TjdFRnlLOHI4K004UUovZzdwVURobE1UcTFISWIwSlI3eDB6eXM0d2ZQWEE3?=
 =?utf-8?B?Y2FuUDZzc3M4RzdjTlRneldpSnhUYzdHRTRqSzNkOCtZUWlHRVEvQjl5aEJo?=
 =?utf-8?B?MkZ1SWtXNHZqTWREeDRROHFZUEZMN1h6RW53MXNiUUR2UXVvUmdGckRSTW9U?=
 =?utf-8?B?RHphU0o5SEFNOXFhUjE0RXpnLzJJMGVjK1NpaWluaDV4OWtGbjAxSFRsQ05M?=
 =?utf-8?B?QWFwaDBCa0d1ZVM0QkczOTlGV3VTRkc3M1M2Y2JKdnlzcm51anFnMXRyS0RC?=
 =?utf-8?B?N1pjMFNGSE9NMkpEM2t2a25CZVFoUGhzd1ErREt6RGhkU2hDQTArRDdYNWFy?=
 =?utf-8?B?dG82Wk9xVXhvRmNoWU1PQVZob0ZXbkJ4Y05XeW5RWWZUL2NTWmNSckRKWUNW?=
 =?utf-8?B?QWMrZDNIa1k0UldncGdhd1pSbUJ6R3hxUnhidFd0c1o2b2FldWZaT0ZDaWVD?=
 =?utf-8?B?NlhkZzNHTmJkOWFQTXpZWnBrdnhqU0EzU2pzNS8yNnRzQWozcy9OTlhMbjJY?=
 =?utf-8?B?ellJdlJvY3ZRUFJXb0M2eFB4a2RvK1piSWdFeUpVNTd0VkhUS1ZOejVURjdl?=
 =?utf-8?B?RFltM25sMnM4UUs1L0JoWFBVVXZMSitXYnczQUFSY21DWGpETUl1OFJqQmFq?=
 =?utf-8?B?ZnZOeU5ia0RYVGs4Z0RFKzVoWVQyUzBQaUx1cU5ZYWZQTHh5cXNLY0w5TlNE?=
 =?utf-8?B?V3BrSlVQTWQ5NFNiTU5qMVQ1ZzVzSThlU0lzdkIwNkVtVGVZcmkwcnJFUTlZ?=
 =?utf-8?B?d1BMSzNYeXh3T1RNVVRpWHRsZGpEWUs1VHhRTlJwMDg3L3pYbi8vWHIxMTFN?=
 =?utf-8?B?T3c0cjJwWTM1cElHRUM2RXJaVVhCTk5jcnBZMUtuSWdLTUhxQ3R4NFNodHVn?=
 =?utf-8?B?cXl6QWd4bXJjQWZucTBYV0hTTVJreGppS0RIblhoN0taZ2RPZk1TMDdMNytD?=
 =?utf-8?B?dGZGd1lDTk1jUkpxTktmQ3pzSEJrTjJZckRDYVprdFVzMGF0bXplbmQwZWU1?=
 =?utf-8?B?bnBQZHkxa2FLcWdlVUVCVk41TGQyYW5yTGtQZ0FJQy9ZUGNkTDF4VFdaa25N?=
 =?utf-8?B?WEcwdmwzYzN5VnVCdWVIYnNiN2JrM3JuQkFOMVNNblEzNDdzeS9JQlV4WktB?=
 =?utf-8?B?WTZ2VlFoK1hmM083R09sRzNCQk1OV0ZMRzRVazdKcHFEYURHdnIwUUhNbnNn?=
 =?utf-8?B?YmF5cmpyV3Z0elFZNXBoKzRkYnE5MlQzNTNPVHNpMTg1ZDlkVGp3aTFJdFRC?=
 =?utf-8?B?by9PdVMvZU5YRlVCS2t4S1kxcWpnTmtKRkVwYWxWcTE0dzNaWlVMQWRERGZT?=
 =?utf-8?B?SHROM1JLWmo3UEwydmhjeFFOeXJiamY1dGo1cHZ6N0xGSmVZM2pFODBHMEhK?=
 =?utf-8?B?aHZiSzVZVjN3Ny9wUVhsajAvdGhSWDJZVmtuYkIwUUQxaDZjVm9Vb2djbVhC?=
 =?utf-8?B?dUcrMUEwRjZGL2FQdTc2Vm5STHNjUE5iN1hGamE5SnhMUFZPWjF5T25uWWNJ?=
 =?utf-8?B?bko0Uklrbm81UmdDVGQrR2RZSTRyaGd4MXhnUkJiQ3M0OEdwdHNHaEJhT1Ra?=
 =?utf-8?B?M3E1Zk5rRDY4YnRkKzRRSWQ0UE5aOUtySnd2RmVCOGd2R25CeG9USmpaaUQz?=
 =?utf-8?B?alZpaDByRHVxWE84RVJpMEhLbW94dDRrOFF2NEl1NVBJdXpRV2w5anBXR081?=
 =?utf-8?B?QXY5b3FNaWFUeVhCYTltd2FsaDdCVGp6L0tZaDhjUjZDbi9CY0dlZnBSY1cz?=
 =?utf-8?B?MU9jYTF4dlRTRVNuakRHcTYvZzA1SnBPUXFiaFV4OXhYTGVNanhuYk5qR24y?=
 =?utf-8?Q?wKsmbg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGl4WkF6WnFqajJud0xncnArcGcxUjc5NVFIR0haTElCVkVQK0tWQU15Vkxk?=
 =?utf-8?B?b0lKeDlnVHlCVC9randnZXE1d2Nodjh1SW81a0NWV1B0MWRySkdmalRxZ1ZP?=
 =?utf-8?B?WVRUOGh2OFV2NDkrMXJ3WEJZQ0czSUwyYW03clg2ZFlGbExDV2tydXlCRkNs?=
 =?utf-8?B?bW5nVHBTK3E0K3NSTlZSeE5qbFdheEFVRHpJVmVwNFlyZjUxdkx3SldqZGx4?=
 =?utf-8?B?T0U1L25jTVVrc1BtdE1QcjYyK3drYk5uVE5hTHlJbVdwalFNVUNSU1d4OTNh?=
 =?utf-8?B?VkM2OG44T1grVW9HKzVwbVRCdjVKNU02QTYrVkorNWlQT3VnVk9ja2x4QTB0?=
 =?utf-8?B?N3B3RFdCZENuZ1Q5V01XRFhkTlU5L1Y1RE1NYk5aRGgrRE9OMXZyS0sveDQy?=
 =?utf-8?B?K0JNVVQxWW15M2VRZElXOEo1WXZKdmVoMm5HblQwZ2o0YndXUGlXelVsdEFi?=
 =?utf-8?B?WHZFakFFMll3NGpqRGdWWlhuZy9VMGd2YWdvNHg3dFE2bFZ6eEdDSUVIYXdW?=
 =?utf-8?B?bVhRRzc0Tkp6NTQxVG1xWDBrZlM3Q1dpRS9sQUZxalNYOElNUm5KcS9Femt3?=
 =?utf-8?B?eXVZYmlWRitVejN3blBibUd0Qjg2T25GbDRTU21GNmlzU0w2dkczRVd2SXBa?=
 =?utf-8?B?dFhwYzYyOWxtSWNwKzBIM2ViN3hpekJmTkVaOWFDTXpLYjc2c0JYb3ZHSXV6?=
 =?utf-8?B?YWh0SGZtUzFSQVlHOUZUY0VIbjczU0VzSVBzMjQyeDhnZzM1MVpld2hqbXdT?=
 =?utf-8?B?QU0rd0pyOUZObmVNNStKaWRaU0g3V1NvdmJBTDI1M1g3cjRjRjI1SFZlWDdl?=
 =?utf-8?B?d2gwak1XVVBJcENkMWtDRWlXZytkVE5uUEdiV1dWTWIvTUlXaHpZMEsyUDhy?=
 =?utf-8?B?eGZNdGNoQTlOQUt0ZEhWaFYvaWlmMHNGdG5WSEp6Vnc5MmFPVXJlNEwyc1Vu?=
 =?utf-8?B?UTZsNmx3VHlYbjE2TjdpQjJveGlwVG1kVWk4SjQxTTc0S0tQdkNXdVNUVUcv?=
 =?utf-8?B?UmlTN1lhYUpnVlhnNVE4b0xLRnFQOGk2YWczUzduNG8ySEJSVkIyUm1KMWZv?=
 =?utf-8?B?TnBIbzM5YW1oMWtBQUZoYk5BTVY5RmhKbEEyUG1wM09TUXF5d1VQWTFGUmhk?=
 =?utf-8?B?NFY2YjUzY2p3U043NXFNVis3TGRjcWplT281TkFqNExaVWNPU09HMlQrME9j?=
 =?utf-8?B?bGFxQnp3L3dTcGdqMnhxSDhXWmNCZ3dDWjEwZkVuMmxybzl3cW91MERPZjlW?=
 =?utf-8?B?QzRsQ3VBWlRobllTTWlmakhtNW13WHFkZUwvaEE1SnYrYnJFQTI0eVVZbW1z?=
 =?utf-8?B?dHlCTGtXajU1MjIzUHNtRFBQYWFyR3o0YXNHSGJBTW5XaFZZMFB6TFQ2R1FW?=
 =?utf-8?B?NEpRV0RobmtGdnpxR1ZrS2o4V29mK1pUbnc3a1RpTklEa0pqMi9SZEFKU2VY?=
 =?utf-8?B?VzRUTlgxSWdSZ1llUnEyUDk3N2FwTEdnRUxXTytScXAwR04xNHB2b0g2bVcy?=
 =?utf-8?B?VGR5QXRLQnpEWkp2b3VTUUNaM2k3R1c1SGlZTU4wY1VURjU5VlVQUWhzcUdG?=
 =?utf-8?B?S1RrNGJWMUJnRUE4NFFJVmJUSzNQVU9jcDd1WFZFQlUrUXFIbWN6cXdXN1dt?=
 =?utf-8?B?dTA2enhyRFJJcGU0SXVEclhzcHZ6QTBPaC9ZQy94ejJlU1lMM3hXYkRGV1hX?=
 =?utf-8?B?NVpYa1RncWZ6ZVpYTmRyeE1OYWNtRzhZKzdUeHVGYndCMXlCSWFZNTZ1cHIz?=
 =?utf-8?B?NlRMQ3lqbGZHTVNIeUNmRittSWMxNy9lUU5paXNOSHpXZG8wb2l1VU4zb2t5?=
 =?utf-8?B?MnpRcE9GL21VYmhPVmwyM09UaHo5ZXRuNW5VU3NkT3BkaEMrczVpQXlaUytt?=
 =?utf-8?B?cnFid1NoNzRHODVoNjA3OUd2QW5PNmFSK3pJYk1DRHZjQnJQLzZiR1JuV1pv?=
 =?utf-8?B?TDRESFFleEd5WUM0Z0pMWXdvcXdEWGJ6MVN0NDRCNVBOaG1GTGY4YVcydUxS?=
 =?utf-8?B?ZkJ3V3BoMFpwRzNYbi81OUJGRmE0L3NXZEhNS24yaG5NelZKM0t2UFk1alY1?=
 =?utf-8?B?Syt2WWxNT3ZmLysxUUNZaytZTEwvSnhkMWJjazRrQjJzSGJ5cENFMjdNRmVn?=
 =?utf-8?Q?rvpI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29BF0BB7BEC1794389D16DC64813A531@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e55a87e-4c1a-44bc-db7b-08de057a99c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 08:22:05.6443 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qe3+qUkAE8JEFi9Ag9A83ReNbphroW2xXJqdRkifdM/SuJ6W2RZFjPwwJ9tYyaHSYI/H6fR2jzbgHFQrE45QSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP195MB1460
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

SGkgTWFydGluLAoKQW0gRG9ubmVyc3RhZywgZGVtIDAyLjEwLjIwMjUgdW0gMTM6MjAgKzAyMDAg
c2NocmllYiBNYXJ0aW4gU2Nod2FuOgo+IEFkZCByYXVjIHRvIGJvb3RtZXRocyB2YXJpYWJsZSBp
ZiBCT09UTUVUSF9SQVVDIGlzIGVuYWJsZWQuIFRoaXMgaXMKPiBzZXR0aW5nIGEgcHJvcGVyIGRl
ZmF1bHQgZm9yIFJBVUMgZW5hYmxlZCBzeXN0ZW1zLgo+IAo+IFNpZ25lZC1vZmYtYnk6IE1hcnRp
biBTY2h3YW4gPG0uc2Nod2FuQHBoeXRlYy5kZT4KPiAtLS0KPiDCoGJvYXJkL3BoeXRlYy9waHlj
b3JlX2lteDhtcC9waHljb3JlX2lteDhtcC5lbnYgfCA0ICsrKysKPiDCoDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvYm9hcmQvcGh5dGVjL3BoeWNvcmVf
aW14OG1wL3BoeWNvcmVfaW14OG1wLmVudgo+IGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1w
L3BoeWNvcmVfaW14OG1wLmVudgo+IGluZGV4Cj4gOWExMjlhMGE0YmZjNDhmMWZhNzBlYTZlMmY4
OTVhY2FjM2NhMDVkMi4uNzAwNDQ5OTdhZGI4YWQxZTRhN2MyNGZhYTUyZjlkNzhiZWNiCj4gMjI5
ZSAxMDA2NDQKPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvcGh5Y29yZV9pbXg4
bXAuZW52Cj4gKysrIGIvYm9hcmQvcGh5dGVjL3BoeWNvcmVfaW14OG1wL3BoeWNvcmVfaW14OG1w
LmVudgo+IEBAIC0zLDcgKzMsMTEgQEAgYm9vdGNtZD0KPiDCoAkJZmFzdGJvb3QgMDsKPiDCoAlm
aTsKPiDCoAlib290ZmxvdyBzY2FuIC1sYjsKPiArI2lmZGVmIENPTkZJR19CT09UTUVUSF9SQVVD
Cj4gK2Jvb3RtZXRocz1yYXVjIHNjcmlwdCBlZmkKPiArI2Vsc2UKCmNhbiBzY3JpcHQgYW5kIGVm
aSBzdGlsbCBiZSB1c2VkIHdpdGggcmF1YywgaS5lLiB0aGV5IGFyZSBub3QgbXV0dWFsbHkKZXhj
bHVzaXZlPwpUaGUgbW90aXZhdGlvbiBpczogRG9lcyBpdCBtYWtlIHNlbnNlIHRvIGxpc3QgdGhl
bSBhcyB3ZWxsIG9yIHNob3VsZCB3ZSBvbmx5IHNldApib290bWV0aHM9cmF1Yz8KCllhbm5pYwoK
PiDCoGJvb3RtZXRocz1zY3JpcHQgZWZpCj4gKyNlbmRpZgo+IMKgYm9vdF90YXJnZXRzPW1tYzIg
bW1jMSB1c2IgZXRoZXJuZXQKPiDCoGJvb3RlbnZfYWRkcl9yPTB4NDkxMDAwMDAKPiDCoGJvb3Rf
c2NyaXB0X2RoY3A9Ym9vdC5zY3IudWltZwo+IAo+IC0tLQo+IGJhc2UtY29tbWl0OiA1YjkzYzNl
YzdmOWQ2NmRjNDBkMDYyYTQ3YTRhODgwZjdkMzQ2YjdhCj4gY2hhbmdlLWlkOiAyMDI1MTAwMi13
aXAtY29uZmlnLWlteDhtLWJvb3RtZXRoLXJhdWMtNzI2ZmQ3OWY4MTQ1Cj4gCj4gQmVzdCByZWdh
cmRzLAo=
