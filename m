Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F02EE6C61A
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 09:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33FB88961E;
	Tue,  3 Dec 2024 10:23:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="wfXTHV1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C64FD89624; Tue,  3 Dec 2024 10:23:35 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83FA489535
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 10:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPaKDLgHOUFI9eevtku9RMa4M+FWQpkMqfe3tcx9cDVfp3CcZunprXnYe9fJe1wQT6cx02OTirBv3YXJZoJSOTwTU7FY7Lp7IjrRVsNnGTbPIfnGNnRcFXm6oehJctjajTS/rcwXrVQSdeErvo6rq545d6LDtpyMPsTjsww4x/forWb0htkGM7RLsrkLvEV2ndUFMv0wYGRx9UOqj8vqLHwCY7rs8a61L/v3YI3EZcXar1sd9ji+TaXKgnEONe5/SJQps5dnyicu/sTiUIadp+t7Yok1XvebtYgkdg2F1uEzH4i60u7elaYI/4Z9j2esV4MZ0gBWK78lzfli6ouIYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnfalEODEqIfMbA/I+m5CzRKOwgRQg+5GQEtbZKQGd8=;
 b=DvDYZyDsGLRdyykXht/ZiKH68I+eWm19RXbJtwx+H4/lgUKbKHhkqIYV5Y4aFYN6kYH9at2fi3dkXRv3o7i1gbpvULk8aV0hd3yM+0kNOKOpsmoLYjPFVBvyXrTZGstp4za56zpIlDR5g0MXmY4hW3PWfqTKQc44VeAwsmrRcMd8/Bm7Qlvt3ZUq6PxzqHauad98OCb/IotzEvgxwwdLG8wVEGQTTZiiGofvUieTwyogHdNhkCZXurImC+Mo1WPTqGh01swjKT07686au+YVaJz4467pTiuJQJK0K4W/qdJho3geU2MGTGJbq7oSh8w+z5uObcLshvieql/C82OcLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnfalEODEqIfMbA/I+m5CzRKOwgRQg+5GQEtbZKQGd8=;
 b=wfXTHV1aLA4hEyGfmIRudiqBpsKtYnY46oculwV9xNKQb4mvfZ7YpvCOUMqLqkpsGUPw+VTgB/Whx0G+KvRb4TjlCVhoktzDLW5SmqoUnUFP2eXLj9Uz4oDIunXJvySiyuNOvLAgNi1ITZyr80HKgMGt/Auc6y7ChD5JIrDDzG4=
Received: from DB6P195MB0439.EURP195.PROD.OUTLOOK.COM (2603:10a6:6:4f::22) by
 PR3P195MB0682.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:27::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.19; Tue, 3 Dec 2024 09:23:32 +0000
Received: from DB6P195MB0439.EURP195.PROD.OUTLOOK.COM
 ([fe80::b8d4:b2f2:8681:9b8]) by DB6P195MB0439.EURP195.PROD.OUTLOOK.COM
 ([fe80::b8d4:b2f2:8681:9b8%3]) with mapi id 15.20.8182.019; Tue, 3 Dec 2024
 09:23:31 +0000
From: Yunus Bas <Y.Bas@phytec.de>
To: Yannic Moog <Y.Moog@phytec.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] phycore_imx8mm: Switch to using env text files
Thread-Topic: [PATCH 1/3] phycore_imx8mm: Switch to using env text files
Thread-Index: AQHbPOed/h4s/VGKck+YMdiVnJXAubLHqq8AgAyli4A=
Date: Tue, 3 Dec 2024 09:23:31 +0000
Message-ID: <da64a476b1e8437de4b70f84f299ee9a6e22eecd.camel@phytec.de>
References: <20241122102833.4061689-1-y.bas@phytec.de>
 <95a6dfb696d005ee5e84c903f39d100133f22710.camel@phytec.de>
In-Reply-To: <95a6dfb696d005ee5e84c903f39d100133f22710.camel@phytec.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6P195MB0439:EE_|PR3P195MB0682:EE_
x-ms-office365-filtering-correlation-id: 6c107a0d-b2f6-4ee7-2d2a-08dd137c2790
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Mkc4aU5rRmx6YlBGeHE0VWRIdTNJQlRjNCs0N1RaRTRzVFVwV01YRWpXTGNm?=
 =?utf-8?B?ZTAwdDFvREs4Wmk2WVpLeERLV1pLaTBUQngwK2hWTFZUaUpad2FxZk14V3U3?=
 =?utf-8?B?M00ydEY4THM4OWhpc0RBVnNTaWcwbDUvUlhLN09qNWxrVSszaHlidGFPT3Ex?=
 =?utf-8?B?Q2FROEVTQklUUklFblpDUzJEdm5hMVVQengxOU0vQXE1enJaNVdrNWlpaG9i?=
 =?utf-8?B?VnVEaWhSSlBPdjZPQUc2Sy9yL0pnTHFFdlFpb05pYU1OTXdYOWx6RFcrTW1K?=
 =?utf-8?B?NGliY21MMjFCRk91R045aHU0ZnQvNGFOakVESG02YTNnZDRQakU5U3NGVVFo?=
 =?utf-8?B?SlJPNkF6UEVEdGdscDcxcFhReXJlNEVhY2p2bWd5a1JjUlpTSzJSdmdRMFUx?=
 =?utf-8?B?ME1TM0ZyUjFQQXM0dXRPWHhUWEoweSttTmlvUzF1a3NwckpRTHVqR2x3Y1VH?=
 =?utf-8?B?cDFyb21DMHFXckpLM2F2QUNWdkhTU0FMWWE3S0VERlJrYUR4QXRTNE5DcDBW?=
 =?utf-8?B?NEJRelhpeEs5QlhjY09xRExBZ3dRTU05Z1RYRU03SUVXTWlpNGRTK0NOMHNW?=
 =?utf-8?B?b3FYVHMrUGxOVi9CT3l6aEdLckxHYTZPMjVHTHB5MklGRFhsOE92QmFnZmxl?=
 =?utf-8?B?RFEwZVRrQUNMZ3BwNHlHS2pwZ1pMeHIzQjZQZmdLeTl3VVBhYTVWdG5KVUR2?=
 =?utf-8?B?V2pZZ2t3M0VaazF5aUhONlhCckVaTWZ6Umdqem9GWVhMYzcwK3JEaHFUemFD?=
 =?utf-8?B?SDg2bzNjVldISG44WjZBTm0rZDV1eWk5aWNVdENvdldBeVlPTEMwbDZjTzhq?=
 =?utf-8?B?Y1p0QXZiOXBNRUFWT0Fya3JsU3V6RFZ4RjVQOG1sNkg1ek5CK2tScjM3eDFz?=
 =?utf-8?B?QTZ4bFlRbkNrVHJyVnZUUUVrYVRLWUtNWWhTWVNpM1ZncXNrRE95ZlZVVUhW?=
 =?utf-8?B?cVZxcUJ6REZuNmtLdWViczFKN0hGYTY4eW1aVmRzbTRYNUwzclJDKzdsU2cv?=
 =?utf-8?B?ekg4dm5PWForR0hCSmpvUUh6L0FpY3BtTCtEdk1GL2gxYURva3RycWR6S1R5?=
 =?utf-8?B?VWc2ZFhaZ3o0b2F4d2dscWFZNENWY05yWFBvUG1JOGt4cURUdjEvK3ByNCtx?=
 =?utf-8?B?cHN6N2F3R3hoV0NwWXIwV0R6L2l2MytRaFo4MjE2TncrbVpPdFZGQkVxdm5K?=
 =?utf-8?B?a28zQ2lZc0JzcC96UlV0SWpHSTJWZUhMZ1grbUhvbUhkTmxrcGtQSU1GWlha?=
 =?utf-8?B?Yk1qb1A1bUt0YVNNZEhIQlBoSkVnY0VHa29oT3dkdHpaRG1BQVRLaXNEWEdR?=
 =?utf-8?B?RFBlSlR1dDFxSG1yNWo2QnBhSWM1bFgvU0pWQTFSZnBrYzZJcldkdHFCVlRW?=
 =?utf-8?B?a0RHOUxxbmtFYzF2U1VxY3JEcVo2ZDd2ajlsRWx0c21lLy9tcTBqR2tsd0lo?=
 =?utf-8?B?SUhqZ1l2UlVtamVaVlZvMnB5K1RBY0pNejlqaWt5TVJYM1U1Q2JwaUZ3bDE4?=
 =?utf-8?B?RWwwNlVBOWp5bk9veEI3NGRUTVVvVW9tUlpHMHFrK0xIV1U4Y2ZxT1V3RENM?=
 =?utf-8?B?VmxPdVgvUGdRV3ZmUHhUQzhYaUo5bFBEYkVJREFZWmxNRzBtbWdncTEycFM5?=
 =?utf-8?B?c2pBQkhsai9TZ0kwUXBnTTErV2xhaXEwdXBwTmhvZEpiSCsvd2padFUxRXNo?=
 =?utf-8?B?VGhnSDM0Tm8xV3JtNzhaWjBKTE9SRmxEOVZkTUpoL0VlVVo5UHVFcTk0VU00?=
 =?utf-8?B?VkNMVHRNRURvTW1XR21lOGUzWVZUWkF5aDhEQWZLWDBsbVd0Zlp2dnpONkFT?=
 =?utf-8?B?aUpxYzQ2SzZIc245WGEyMjhXdElpNElrYTlRdnJTdmlScmFFM3dFNGdHenVQ?=
 =?utf-8?B?S0xwM3ZzZ3IxZ1JrWDkwWlFENzVmM0RVejZscnV2bFFjN2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB6P195MB0439.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTB3QkhoRE9VNUR4c1l0ZmtBY3dBYXlqUWdVQkwzLzBtQ05semdiWWZnYTht?=
 =?utf-8?B?aWxSVFdlZEJDelQ2TzBkVjlFVEo4NFhYdHJSa3BLbWk5cFBaeS9QUExObXla?=
 =?utf-8?B?UDEzaUhtNUdqK2w4MExFemNib3VKREYzWGUrNU8wSmtwMmExWC95aEI2c1lv?=
 =?utf-8?B?NVdBeHJmd1Q0c1JrREY0Uk90ejdpREUvY3VEQXNzKzZ3ZHRzdnJuN2hBb0or?=
 =?utf-8?B?TTlHQVA3U2ZXYUdLV21ETHZkZjlKOGtHYWRHVTVxSmVseTNMSHVCWDV6dzJi?=
 =?utf-8?B?QU9palBHSjVWeUJyTjQwVk9VYU5majRRNkVZaXE4MU5kWUVTN2NCcWg3d1JD?=
 =?utf-8?B?azVWdUFVWWRUaWl4ZHBsYUxxQkgvOFp4azlFeVhsYnNMcmhYcHpvZm9SOU1x?=
 =?utf-8?B?RlFnMzJwTVJFVVdDWHdnL3ExU2w1RUpQam1MajJEVVRVMVBGRzNVVGxtZVlx?=
 =?utf-8?B?bElKdzNPQS9rdDdkMGtsWDg4TUdVMXZSNWZMTjBRVGpDcy8wYzZBZ3l0bTIr?=
 =?utf-8?B?NzVNcW44eVdQYW8vdXVETU5aekxDUFR1WWdsU0V5dVNodGs4SnFlRGZLbDg1?=
 =?utf-8?B?NmNEbG9BMjlRK21TZks2K3pnVHZrOFNmaHZJZFJZWkJWWWNtSjZra01KdEFU?=
 =?utf-8?B?VERuU0hkNHdoY2ZTSkFjbGRkNnJLd1BMSldPNW5Dc1hQOGpMWWNueEYvRmg1?=
 =?utf-8?B?Mk9vdzc5eWJWRTR3c1RrZXVaYjBkbFBUNTAyY1FRQWRoK3lMY0wzSXRhVjJT?=
 =?utf-8?B?SkRQM1BlVjh5SnEzbG5jbUhEMW9raytGQ3A1RjZMbk1IaFBWZmFENDRBL0Vs?=
 =?utf-8?B?VUlEN1lsT2grZVE4YnNhMGtyY2NJRTVzZkdTRXJZTDBXQ0d0d0cyc290M3FO?=
 =?utf-8?B?cVJqVzFSWnl4bnNOVkthZGVKcHRQWmNSSnFXWDRDSmJNSzZibGRVUEp3aTgv?=
 =?utf-8?B?M1JkclpCWFh3UzBkenlQOHJlOUlGS0RBQUR1b2NYTDliR0psOHo2NDdodFY0?=
 =?utf-8?B?MHVsb1BOSDVGM0xTRll0eXJQVS94eTF4RmpJUTJSQnYzcGVKNkVjREo2Wnlk?=
 =?utf-8?B?b0NYK0JlS2ttUmN3VnNKRWFBSzUrb0lDSXhOeC9KRHRlN1B2Q0ZqcGdtRDRa?=
 =?utf-8?B?MGNCVWVmVytHZC9Ya1B1Rld6NW9DSmZYQW5ISDRyZVlwMnJ3T2FsUzBFS2x5?=
 =?utf-8?B?QldobW5hWnNOemlxUTlLSU1Xb0dpMjI2dGlGK3Q2bEtPWU1VK0ZJSXVPOUlm?=
 =?utf-8?B?cVBVRzJWc005aitDdjhkdTRwN2k3Qk9MeHRwaDZBN1lHSWtjRTZWSDFQMENT?=
 =?utf-8?B?QzNGcVFTYnpkc1Q3M1NhRWxreUJoclhURTdWOEFrN0Frc0xlU1BEaHJrVXlq?=
 =?utf-8?B?YXp6Uk9JaitMYVpmL1J1WDFteUVXcTZYWTgxcjFqUWdkZWYvckNTSmxKbEND?=
 =?utf-8?B?OGwrMFp2WTMxblVOdFc4N1F1bjFOMlZMczYwTFFlWk4zTUNWK20rZE82ZXps?=
 =?utf-8?B?RGZqbmN3akkwNndMMGZIL0NQdHJYWTJxVGU3Vm00QkI5RDJrR2VpdHBTWGg1?=
 =?utf-8?B?SnVsRHAyVVRnWnVWdEJ2eGV4VGxEdGVPTUFzSnlDUEVuZWUwcTQ0Zmo4akJU?=
 =?utf-8?B?U2tMOElKU2RmU1Z0U1QyNEdNMkVLZUFQd1RjTlEzamUzRG83L0JZN2N4MlVL?=
 =?utf-8?B?M2VaaWwzUVk3emMrSmxVZTllelJscHlrSTNVeXplZ2kzS2hZQjhlWnFNU256?=
 =?utf-8?B?ekhMWjg2TUpmZTdTOGUwdXNSOHp0eHNPQUR0V2hDV3Z0UGZ0MlB5R3JYWDJY?=
 =?utf-8?B?RjdiZGs2YlBtaEdQdUw5K1g3bzZCQ0JsUFdIRFROYlQ0NS9UM09uc1BxR0RX?=
 =?utf-8?B?a0s5M2hIMmZtZGhMcXFjdXBmTjNUU1ZRdGcwQitydG5qcUNCWDdrSksvZFhN?=
 =?utf-8?B?WFFvcEVDZ1dsbWxDd0o4Q3l0RVpaRTQvd2l1WU8xcmRFSXlqT2ZNK1NIbFNl?=
 =?utf-8?Q?UGuG0N/OD5h97xKJY/DOn2PYF7TNO4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB4205E32E1E4844AE415636BC47044A@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6P195MB0439.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c107a0d-b2f6-4ee7-2d2a-08dd137c2790
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 09:23:31.6492 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERuZ5TbEY5bArkYocfhQ2PXPC7nlS3j8g0+P8w+cnGDS5FXk+3CC/Zjd5j2poOlQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0682
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

SGkgWWFubmljLAoKQW0gTW9udGFnLCBkZW0gMjUuMTEuMjAyNCB1bSAwOToxNSArMDAwMCBzY2hy
aWViIFlhbm5pYyBNb29nOgo+IEhpIFl1bnVzLAo+IAo+IHBsZWFzZSB1c2UgZ2V0X21haW50YWlu
ZXIgc2NyaXB0IHRvIGdldCBhIGxpc3Qgb2YgcGVvcGxlIHRvIHNlbmQgKGEKPiBjb3B5IG9mKSB0
aGUgcGF0Y2hlcyB0by4KPiBVc3VhbGx5IE1haW50YWluZXJzIGFyZSBwdXQgaW4gVG86IGZpZWxk
IGFuZCByZXZpZXdlcnMgQ2M6CgpXaWxsIGRvLCB0aGFuayB5b3UgZm9yIHRoZSBub3RlLgoKPiAK
PiBBZGRpdGlvbmFsbHksIEkgc3VnZ2VzdCB1c2luZyBhIGNvdmVyIGxldHRlciB0byBzdW1tYXJp
emUgdGhlIGNoYW5nZXMKPiBtYWRlIGluIHRoaXMgcGF0Y2ggc2VyaWVzLgoKSSBkb24ndCB0aGlu
ayBhIGNvdmVyIGxldHRlciBpcyBuZWVkZWQgaGVyZSwgc2luY2UgdGhlIGNoYW5nZXMgYXJlCnRy
aXZpYWwgYW5kIGFsc28gbWVudGlvbmVkIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24uCgo+IAo+
IE9uIEZyaSwgMjAyNC0xMS0yMiBhdCAxMToyOCArMDEwMCwgWXVudXMgQmFzIHdyb3RlOgo+ID4g
TW92ZSB0aGUgZW52aXJvbm1lbnQgaW50byB0aGUgYm9hcmQgZGlyZWN0b3J5IGFuZCBjb252ZXJ0
IGhlYWRlciB0bwo+ID4gYQo+ID4gdHh0IGZpbGUuIEluIGFkZGl0aW9uLCB0aGlzIHBhdGNoIGFs
c28gYXBwbGllcyBmb2xsb3dpbmcgY2hhbmdlczoKPiA+IAo+ID4gLSBDaGFuZ2UgZGVmYXVsdCBu
ZnNyb290IHBhdGggdG8gL3Nydi9uZnMgZHVlIHRvIGNvbXBsaWFuY2Ugd2l0aAo+ID4gTGludXgK
PiA+IEZIUyAzLjAuCj4gPiAKPiA+IC0gUmVuYW1lIHNwZWNpZmljIHZhcmlhYmxlcyBhcyBzdGF0
ZWQgaW4gdGhlIGJvb3RzdGQgZG9jdW1lbnRhdGlvbi4KPiA+IFJlbmFtZWQgdmFyaWFibGVzOgo+
ID4gCWZkdF9hZGRyID0+IGZkdF9hZGRyX3IKPiA+IAlmZHRfZmlsZSA9PiBmZHRmaWxlCj4gPiAK
PiA+IFNpZ25lZC1vZmYtYnk6IFl1bnVzIEJhcyA8eS5iYXNAcGh5dGVjLmRlPgo+ID4gLS0tCj4g
PiDCoC4uLi9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5Y29yZV9pbXg4bW0uZW52wqAgfCA1Mgo+
ID4gKysrKysrKysrKysrKysrKysrKwo+ID4gwqBpbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4
bW0uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDYgLS0tLS0tLS0tLS0tLS0tCj4gPiAt
Cj4gPiDCoDIgZmlsZXMgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0p
Cj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDY0NCBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bW0vcGh5
Y29yZV9pbXg4bW0uZW52Cj4gPiAKPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29y
ZV9pbXg4bW0vcGh5Y29yZV9pbXg4bW0uZW52Cj4gPiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lt
eDhtbS9waHljb3JlX2lteDhtbS5lbnYKPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gPiBpbmRl
eCAwMDAwMDAwMDAwMC4uYjJmNjE4NDM5OTUKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsrKyBiL2Jv
YXJkL3BoeXRlYy9waHljb3JlX2lteDhtbS9waHljb3JlX2lteDhtbS5lbnYKPiA+IEBAIC0wLDAg
KzEsNTIgQEAKPiA+ICtjb25zb2xlPXR0eW14YzIsMTE1MjAwCj4gPiArZW1tY19kZXY9Mgo+ID4g
K2ZkdF9hZGRyX3I9MHg0ODAwMDAwMAo+ID4gK2ZkdGZpbGU9Q09ORklHX0RFRkFVTFRfRkRUX0ZJ
TEUKPiA+ICtpbWFnZT1JbWFnZQo+ID4gK2lwX2R5bj15ZXMKPiA+ICtsb2FkaW1hZ2U9ZmF0bG9h
ZCBtbWMgJHttbWNkZXZ9OiR7bW1jcGFydH0gJHtsb2FkYWRkcn0gJHtpbWFnZX0KPiA+ICtsb2Fk
ZmR0PWZhdGxvYWQgbW1jICR7bW1jZGV2fToke21tY3BhcnR9ICR7ZmR0X2FkZHJfcn0gJHtmZHRm
aWxlfQo+ID4gK21tY2FyZ3M9Cj4gPiArCXNldGVudiBib290YXJncyBjb25zb2xlPSR7Y29uc29s
ZX0KPiA+ICsJcm9vdD0vZGV2L21tY2JsayR7bW1jZGV2fXAke21tY3Jvb3R9IHJvb3R3YWl0IHJ3
Cj4gPiArbW1jYXV0b2RldGVjdD15ZXMKPiA+ICttbWNib290PQo+ID4gKwllY2hvIEJvb3Rpbmcg
ZnJvbSBtbWMgLi4uOwo+ID4gKwlydW4gbW1jYXJnczsKPiA+ICsJaWYgcnVuIGxvYWRmZHQ7IHRo
ZW4KPiA+ICsJCWlmIHRlc3QgJHtkb2ZpdGJvb3R9ID0gMTsgdGhlbgo+ID4gKwkJCWJvb3RpICR7
bG9hZGFkZHJ9IC0gJHtmZHRfYWRkcl9yfQo+ID4gKwkJZWxzZQo+ID4gKwkJCWVjaG8gV0FSTjog
Q2Fubm90IGxvYWQgdGhlIERUOwo+ID4gKwkJZmk7Cj4gPiArCWZpOwo+ID4gK21tY2Rldj1DT05G
SUdfU1lTX01NQ19FTlZfREVWCj4gPiArbW1jcGFydD0xCj4gPiArbW1jcm9vdD0yCj4gPiArbmV0
YXJncz0KPiA+ICsJc2V0ZW52IGJvb3RhcmdzIGNvbnNvbGU9JHtjb25zb2xlfSByb290PS9kZXYv
bmZzIGlwPWRoY3AKPiA+ICsJbmZzcm9vdD0ke3NlcnZlcmlwfToke25mc3Jvb3R9LHYzLHRjcAo+
ID4gK25ldGJvb3Q9Cj4gPiArCWVjaG8gQm9vdGluZyBmcm9tIG5ldCAuLi47Cj4gPiArCWlmIHRl
c3QgJHtpcF9keW59ID0geWVzOyB0aGVuCj4gPiArCQlzZXRlbnYgZ2V0X2NtZCBkaGNwOwo+ID4g
KwllbHNlCj4gPiArCQlzZXRlbnYgZ2V0X2NtZCB0ZnRwOwo+ID4gKwlmaTsKPiA+ICsJJHtnZXRf
Y21kfSAke2xvYWRhZGRyfSAke2ltYWdlfTsKPiA+ICsJcnVuIG5ldGFyZ3M7Cj4gPiArCWlmICR7
Z2V0X2NtZH0gJHtmZHRfYWRkcl9yfSAke2ZkdGZpbGV9OyB0aGVuCj4gPiArCQlib290aSAke2xv
YWRhZGRyfSAtICR7ZmR0X2FkZHJfcn07Cj4gPiArCWVsc2UKPiA+ICsJCWVjaG8gV0FSTjogQ2Fu
bm90IGxvYWQgdGhlIERUOwo+ID4gKwlmaTsKPiA+ICtuZnNyb290PS9zcnYvbmZzCj4gPiArc2Rf
ZGV2PTEKPiAKPiBUaGlzIHVuZXhwbGFpbmVkIGNoYW5nZSBzbnVjayBpbjsgYXQgbGVhc3QgSSBk
b24ndCBzZWUgc2RfZGV2IGRlZmluZWQKPiBiZWZvcmUuIFBsZWFzZSB1cGRhdGUgY29tbWl0Cj4g
ZGVzY3JpcHRpb24gb3IgcmVtb3ZlIGl0LgoKQWdhaW4sIHRoYW5rIHlvdSBmb3IgeW91ciBhdHRl
bnRpb24uIFRoaXMgb25lIHNsaXBwZWQgaW4uIEknbGwgdXBkYXRlCnRoZSBwYXRjaCBhbmQgc2Vu
ZCBhIHYyLgoKUmVnYXJkcwpZdW51cwo+IAo+IFlhbm5pYwo+IAo+ID4gK3VwZGF0ZV9ib290aW1n
PQo+ID4gKwltbWMgZGV2ICR7bW1jZGV2fTsKPiA+ICsJaWYgZGhjcCAke2xvYWRhZGRyfSAke3Vw
ZGF0ZV9maWxlcGF0aH0vJHt1cGRhdGVfZmlsZW5hbWV9Owo+ID4gdGhlbgo+ID4gKwkJc2V0ZXhw
ciBmd19zeiAke2ZpbGVzaXplfSAvIDB4MjAwOwo+ID4gKwkJbW1jIHdyaXRlICR7bG9hZGFkZHJ9
ICR7dXBkYXRlX29mZnNldH0gJHtmd19zen07Cj4gPiArCWZpOwo+ID4gK3VwZGF0ZV9maWxlbmFt
ZT1mbGFzaC5iaW4KPiA+ICt1cGRhdGVfb2Zmc2V0PTB4NDIKPiA+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaAo+ID4gYi9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29y
ZV9pbXg4bW0uaAo+ID4gaW5kZXggZTc0YTNmMTg0YzYuLjIwZTJhYjgzMmVlIDEwMDY0NAo+ID4g
LS0tIGEvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmgKPiA+ICsrKyBiL2luY2x1ZGUv
Y29uZmlncy9waHljb3JlX2lteDhtbS5oCj4gPiBAQCAtMjAsNTIgKzIwLDYgQEAKPiA+IMKgLyog
Rm9yIFJBVyBpbWFnZSBnaXZlcyBhIGVycm9yIGluZm8gbm90IHBhbmljICovCj4gPiDCoCNlbmRp
Zgo+ID4gwqAKPiA+IC0jZGVmaW5lIENGR19FWFRSQV9FTlZfU0VUVElOR1MgXAo+ID4gLQkiaW1h
Z2U9SW1hZ2VcMCIgXAo+ID4gLQkiY29uc29sZT10dHlteGMyLDExNTIwMFwwIiBcCj4gPiAtCSJm
ZHRfYWRkcj0weDQ4MDAwMDAwXDAiIFwKPiA+IC0JImZkdF9maWxlPSIgQ09ORklHX0RFRkFVTFRf
RkRUX0ZJTEUgIlwwIiBcCj4gPiAtCSJpcF9keW49eWVzXDAiIFwKPiA+IC0JIm1tY2Rldj0iIF9f
c3RyaW5naWZ5KENPTkZJR19TWVNfTU1DX0VOVl9ERVYpICJcMCIgXAo+ID4gLQkibW1jcGFydD0x
XDAiIFwKPiA+IC0JIm1tY3Jvb3Q9MlwwIiBcCj4gPiAtCSJ1cGRhdGVfb2Zmc2V0PTB4NDJcMCIg
XAo+ID4gLQkidXBkYXRlX2ZpbGVuYW1lPWZsYXNoLmJpblwwIiBcCj4gPiAtCj4gPiAJInVwZGF0
ZV9ib290aW1nPSIJCQkJCQlcCj4gPiAtCQkibW1jIGRldiAke21tY2Rldn0gOyAiCQlcCj4gPiAt
CQkiaWYgZGhjcCAke2xvYWRhZGRyfQo+ID4gJHt1cGRhdGVfZmlsZXBhdGh9LyR7dXBkYXRlX2Zp
bGVuYW1lfSA7IHRoZW4gIglcCj4gPiAtCQkic2V0ZXhwciBmd19zeiAke2ZpbGVzaXplfSAvIDB4
MjAwIDsgIgkvKiBTRAo+ID4gYmxvY2sgc2l6ZSAqLyBcCj4gPiAtCQkibW1jIHdyaXRlICR7bG9h
ZGFkZHJ9ICR7dXBkYXRlX29mZnNldH0gJHtmd19zen0gOwo+ID4gIglcCj4gPiAtCQkiZmlcMCIg
XAo+ID4gLQkibW1jYXV0b2RldGVjdD15ZXNcMCIgXAo+ID4gLQkibW1jYXJncz1zZXRlbnYgYm9v
dGFyZ3MgY29uc29sZT0ke2NvbnNvbGV9ICIgXAo+ID4gLQkJInJvb3Q9L2Rldi9tbWNibGske21t
Y2Rldn1wJHttbWNyb290fSByb290d2FpdAo+ID4gcndcMCIgXAo+ID4gLQkibG9hZGltYWdlPWZh
dGxvYWQgbW1jICR7bW1jZGV2fToke21tY3BhcnR9ICR7bG9hZGFkZHJ9Cj4gPiAke2ltYWdlfVww
IiBcCj4gPiAtCSJsb2FkZmR0PWZhdGxvYWQgbW1jICR7bW1jZGV2fToke21tY3BhcnR9ICR7ZmR0
X2FkZHJ9Cj4gPiAke2ZkdF9maWxlfVwwIiBcCj4gPiAtCSJtbWNib290PWVjaG8gQm9vdGluZyBm
cm9tIG1tYyAuLi47ICIgXAo+ID4gLQkJInJ1biBtbWNhcmdzOyAiIFwKPiA+IC0JCSJpZiBydW4g
bG9hZGZkdDsgdGhlbiAiIFwKPiA+IC0JCQkiYm9vdGkgJHtsb2FkYWRkcn0gLSAke2ZkdF9hZGRy
fTsgIiBcCj4gPiAtCQkiZWxzZSAiIFwKPiA+IC0JCQkiZWNobyBXQVJOOiBDYW5ub3QgbG9hZCB0
aGUgRFQ7ICIgXAo+ID4gLQkJImZpO1wwICIgXAo+ID4gLQkibmZzcm9vdD0vbmZzXDAiIFwKPiA+
IC0JIm5ldGFyZ3M9c2V0ZW52IGJvb3RhcmdzIGNvbnNvbGU9JHtjb25zb2xlfSByb290PS9kZXYv
bmZzCj4gPiBpcD1kaGNwICIgXAo+ID4gLQkJIm5mc3Jvb3Q9JHtzZXJ2ZXJpcH06JHtuZnNyb290
fSx2Myx0Y3BcMCIgXAo+ID4gLQkibmV0Ym9vdD1lY2hvIEJvb3RpbmcgZnJvbSBuZXQgLi4uOyAi
IFwKPiA+IC0JCSJydW4gbmV0YXJnczsgIiBcCj4gPiAtCQkiaWYgdGVzdCAke2lwX2R5bn0gPSB5
ZXM7IHRoZW4gIiBcCj4gPiAtCQkJInNldGVudiBnZXRfY21kIGRoY3A7ICIgXAo+ID4gLQkJImVs
c2UgIiBcCj4gPiAtCQkJInNldGVudiBnZXRfY21kIHRmdHA7ICIgXAo+ID4gLQkJImZpOyAiIFwK
PiA+IC0JCSIke2dldF9jbWR9ICR7bG9hZGFkZHJ9ICR7aW1hZ2V9OyAiIFwKPiA+IC0JCSJpZiAk
e2dldF9jbWR9ICR7ZmR0X2FkZHJ9ICR7ZmR0X2ZpbGV9OyB0aGVuICIgXAo+ID4gLQkJCSJib290
aSAke2xvYWRhZGRyfSAtICR7ZmR0X2FkZHJ9OyAiIFwKPiA+IC0JCSJlbHNlICIgXAo+ID4gLQkJ
CSJlY2hvIFdBUk46IENhbm5vdCBsb2FkIHRoZSBEVDsgIiBcCj4gPiAtCQkiZmk7XDAiIFwKPiA+
IC0KPiA+IMKgLyogTGluayBEZWZpbml0aW9ucyAqLwo+ID4gwqAKPiA+IMKgI2RlZmluZSBDRkdf
U1lTX0lOSVRfUkFNX0FERFIJMHg0MDAwMDAwMAo+IAoKLS0gClBIWVRFQyBNZXNzdGVjaG5payBH
bWJIIHwgQmFyY2Vsb25hLUFsbGVlIDEgfCA1NTEyOSBNYWlueiwgR2VybWFueQoKR2VzY2jDpGZ0
c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHVi
ZXIsCkRpcGwuLUluZy4gKEZIKSBNYXJjdXMgTGlja2VzIHwgSGFuZGVsc3JlZ2lzdGVyIE1haW56
IEhSQiA0NjU2IHwKRmluYW56YW10IE1haW56IHwgU3QuTnIuOiAyNi82NjUvMDA2MDgsIFVTdC1J
RDogREUgMTQ5MDU5ODU1CgoKCg==
