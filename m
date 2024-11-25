Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D629D3B7F6
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 09:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD1E7899EC;
	Mon, 25 Nov 2024 10:32:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hIuvCNAj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE960899BF; Mon, 25 Nov 2024 10:32:12 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191ED899BF
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 10:32:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+D1kFYLimSNzrJHmr7iCKBLy83XCG72syFJA/er/Q2m6jCwHkpt5b4Vx1FVjvc40zPPSms9ioH/lAP34bUEARP4UgABfpXiYUMWjTZgck3T7RAV8Rf3JThwkdNktsKS1FSMzBoPiRrbygqxwroub1ChdH+F5RbXW/YCb4PYjy754HrExeGNhDCwk9ZvneH5VP3bx0qdLnKePVQcyx468iHLCvUSKlKqHucH6XKLlsrmH9qaYEWW3MowfYaG24xd1yV3Bi72bsZP0hnGfYxUh3GNoVbfIrzKaT9zYohLRLFjyo5aMeixGkEDR3BTaViofCZXF7M1TsjQ4bUjotSCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awCcR9MCH3KpoUy/E5oQcEnqH7lbWUUvVXMOnhay2Wc=;
 b=Q+ZbdkqrdWRxKxZNJA9rwhy9AXNLQ7fV7pFWMQXu2P1Kt/UHzahEUrC8m2wkh8e4UR45i8HsE9kVXxasoRTJvJfoI4ZqYH/T8LR3xPWABsQf7CAjzmsg771OKyY8qisUkM8xg9F5tGiIVzYwoyDabn6hArARBU4gPpkq39RYw++rPaWrGD0+ZinjHZeirrfi9YL2AcZM69b/1+RYqYiDTbsgoa/I0lpdUez6/2lPNOOLglQnFkfQPe3cju9qqxhbcIsum4sbA5vWtxJxIdGbM69OTw6rB2B3NEzKAqAofY4RPbxspNELlPiQ1+G0TebvkVtb8tjY52Oi3/UccWNbqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awCcR9MCH3KpoUy/E5oQcEnqH7lbWUUvVXMOnhay2Wc=;
 b=hIuvCNAjkBtyE0POYQMtj3oCf9XT+a59GwzqO0rxc9pMP+sAiDzqiaH1QvW4nI8hG2LJsurETC7YBbeq1y9y6OvjWX27wLQUwpDntwI/o81bOR2mlagrn5wbbM5Pzm2AgLiG6aY9qvWTxIUqHsCPkA0F6AsZTInfmr6PbhfbqoA=
Received: from SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10)
 by PH7PR12MB6883.namprd12.prod.outlook.com (2603:10b6:510:1b9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 09:32:05 +0000
Received: from SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c]) by SA1PR12MB8697.namprd12.prod.outlook.com
 ([fe80::dbf9:f1d1:7c67:f88c%4]) with mapi id 15.20.8182.018; Mon, 25 Nov 2024
 09:32:04 +0000
From: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "j-humphreys@ti.com" <j-humphreys@ti.com>
CC: "Simek, Michal" <michal.simek@amd.com>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "u-kumar1@ti.com" <u-kumar1@ti.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "william.zhang@broadcom.com"
 <william.zhang@broadcom.com>, "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>, "git
 (AMD-Xilinx)" <git@amd.com>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Dragan Simic <dsimic@manjaro.org>
Subject: RE: [PATCH] mtd: spi-nor: Add support for Macronix flash part
Thread-Topic: [PATCH] mtd: spi-nor: Add support for Macronix flash part
Thread-Index: AQHbPMOVg/ZzZCoIqk+XtMk/uWq/VrLHndUAgAAiGQA=
Date: Mon, 25 Nov 2024 09:32:04 +0000
Message-ID: <SA1PR12MB8697E330B56FCA0B43270E48982E2@SA1PR12MB8697.namprd12.prod.outlook.com>
References: <20241122094747.1398068-1-venkatesh.abbarapu@amd.com>
 <a81b811f-3ab2-4399-be07-1231d485d12e@linaro.org>
In-Reply-To: <a81b811f-3ab2-4399-be07-1231d485d12e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8697:EE_|PH7PR12MB6883:EE_
x-ms-office365-filtering-correlation-id: fb22c7ff-b49c-4ef2-124a-08dd0d34062a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VG0vTms4ZkQzQnNmNG1wRUVGSjNmbHZWSllvN2FFOHJCVkJDOXpxa3RiWEgx?=
 =?utf-8?B?ZjlYUnN3eVMxdWVEK3c0ZWpicWg1L3k5Z2p2SFFrZjlKdkVKYTMxM1VlelUr?=
 =?utf-8?B?MlFNN3dUbEI3dzFMdmhlOG94czBSYUJ2QklmaXJHamRrZHhjemlZOEYvYUtx?=
 =?utf-8?B?NnkwTnNVTU9YTm9VR2k2dExxeXEzQUdDc2I4eUFHVGpEaEpZbnFzbE83Y2tY?=
 =?utf-8?B?UEVNUnRMSVJ4d2g5amc1YXRUTm9MUUpvVFJXeW81ZDUyZ01XNHkxYjlsSzRa?=
 =?utf-8?B?YXovSFFYZ0Vkc1FTa0p1M0Z4V1lyR2FGMjh0MytEVGgvVTlIbVBOTDUxY052?=
 =?utf-8?B?eWJpRXEwaForUURtcTBDblB4UTJZSjUwMmtrenhnRTFKeXBaMVpUMjNTOUhh?=
 =?utf-8?B?UFNXUmN4VXY0UnVjYUxvQXY3K3J6WThreE9FUkRWUURNKzNRZG8rcm9paFR1?=
 =?utf-8?B?bm5nQ2xtS1p0YVNrK3RRc1dUbUUrK1ZVak91R0ViMEc1QXVJODFHOFNNcEpk?=
 =?utf-8?B?WGpqV0cvK3cvNUJKbmlRWTJBQ0ppbXdpMWtOWm93OHNpK2ZDT2x0V0MwS2Vh?=
 =?utf-8?B?SnRQWVkxUHRtSUVGRVJVa3RzTXhNV0Y4b0ZTREhnYkUzTzdadlpGNGoyQXpo?=
 =?utf-8?B?c2pibXVTQUw0d3hHZmE3WEZISjV4YXZuQzRONkJpSkxBVzM1WEViYkxJOTFO?=
 =?utf-8?B?a2IzL0JxSXQ4T0ZHOGd4UjNjL3pNSVMrMlVxcGliUXp0VTZ4VjMxNm4waSt4?=
 =?utf-8?B?NTFKRlpONGpIZlhpeDk2MzZoVld0dmdxNm1NOW5SZVNWSU01cFZLZ0lQdTJB?=
 =?utf-8?B?QlEwUnFhUjJPRmM2bmZmcFFYT0ZlL3FzMEtGU21qOU01VTFYQzJHczQzUUd6?=
 =?utf-8?B?aUgxZDk0V29aR29pUTdXYVIxMm5CMHJRWE9OUXdjUnlCbGJuV29MbnZXYlBX?=
 =?utf-8?B?cFhoWDg3L25hVXhWajNiTTVlUG94V3BwNnpuTHZqaldiUFk2Vk1Hb1pvZmZv?=
 =?utf-8?B?L3NxUGFmU1ZETi83UVk1SEQxSTFqNXZoeDhsQzlMZTNKL21SNk1sMExQZ1da?=
 =?utf-8?B?a1pvWmZub0FMN2JOZjVjQ1dqdzFVZTVlUTQwZWI2QTR4OXF2RnhjRUZtenUv?=
 =?utf-8?B?MFdDT08vSEl4U2IwelY4MUFHVWtRZ3pQN0w0RDV0WmxIVXprNkNmcGY5YnRl?=
 =?utf-8?B?WEZYOWk2S2FJQWFnRDgvdlk1eHg1RGhlaXRjTHNFUDZ2QmlmUElnZi9Zc0Mx?=
 =?utf-8?B?WXhIOTc4bE84WFRTditFMmUrYjdmemVKYS9URmtVSzh6TTMwYk8yVjFPRWFj?=
 =?utf-8?B?TGl1SXZWZVJ6SmNlN3BudWpTc2VOd1pPWHRackpIbUlYQU0rRGRwVGFUYWVZ?=
 =?utf-8?B?TUt1VXdoT2pEeUhZcmIxdTdsOXhGcXR2SUVPM3hyeXhkU1MwbEIvdjViNm9Q?=
 =?utf-8?B?eVpyMkJaaW1rZnlrQUo0b2JUaEYxUDJTTzc2Q00rTWtWMGpJNDRDQVl0Q1BD?=
 =?utf-8?B?SWNTdDV3OUVUQmN0b3NvVXVtN0szOVQ0UEZqaU9UU2xFZCtzb1libHVSb01y?=
 =?utf-8?B?ckdxNllsUStab1JUSUkxWWpHZm4wWVl2b2VvRXEzT0hnYmJoemNnSlBVVHZH?=
 =?utf-8?B?RndLQitvbGFYdlNsT3FpMnB6TlVNTmJwNXlzc0oxNG90c0lHZld4b01yOUlx?=
 =?utf-8?B?UmtoUWF1VmVySjh5T3drYUFPTDNaQlhwL2F0ZmxLeExMdy9lWTNaVTRXYVBt?=
 =?utf-8?B?MnJ3dHdaL01oanpud0s0RHhjdGw2WjJ6b0owQ0pMOGlQSHhGbU5PYndLdks4?=
 =?utf-8?B?dy9yZzcvTDJoWHdVOEQvZzJDTExEdHFUSzh2UlNuNENncEt0d3RSUHBvSVlU?=
 =?utf-8?B?dDFvckttWDBtZE5WVjc0bEg1SzQ4Rk9ZY25PZUtmYzF1dUE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8697.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0h1Z2VWU0o5YWUxTGxaQm1EbmYyRzkvMjhaYTBUekp4cVhwUzdjbDNYWXg3?=
 =?utf-8?B?QW5DR2ZYRUJqcGFKM05zYWtFTEdFUzVQVHRNZVArL2dubG1mdXZtc0l1ektQ?=
 =?utf-8?B?WVFGNmhEMVI0blFoWE1COVFVc3BpbHgyQnlMN3JGRWVqUk04ZGt1b0pTdktS?=
 =?utf-8?B?citPT21RNG9OUmM2b0RkSWxiWk13TFBEMmtFcTZjVVZSOVZaMmExZXBjQk5s?=
 =?utf-8?B?WHRYVDdOeEFpdzg3ZktlTmlhMVZaWEZ1M2dad2MzVkVKekxQU3ZIN3BNdUFY?=
 =?utf-8?B?c0grb3M0STNFS3dWNExGRXdjbGs4VTl1bWxwMGlvVVJZWmQwZmdTT21tUERs?=
 =?utf-8?B?djlsdUpqQ3hnWmtPYTJVN1FRQno1Z2NrMktiQ2NOZUoyenlZcG9pMEY5WENJ?=
 =?utf-8?B?MDd4SjErNllicTVCZ1BhYTc2UXhHWWFSZDBjN2pBTXpyRnRHdGE5aEU5aXYw?=
 =?utf-8?B?MS9kWndRUjl3YWRxMmd1ZHNlM3liRGlESERvSW9scmdQQmpuT0FLNnNkc1E2?=
 =?utf-8?B?Z3ZncDRnb1FEUjNSeHgrQ0cwMEFmcE95cFh4RGl2RXBuVkdVU3U3VnpQcWt1?=
 =?utf-8?B?YThrQ0I4UlF0ZmMyQ1Y0aFFKMGIrcWNFbStaMVlzWDE5cHA5OFJxZUVISEZN?=
 =?utf-8?B?M2thREd3emQzRFFvL0NqUlR5UDNYS21hNnhGNWlMMm5VOHlxb0VPRDdYekla?=
 =?utf-8?B?MDVsK2RPaG1NRnUvRE1EWnpwSzZqRkxqNGNHSDdhMlVsdGlsREtrN2xDcXZK?=
 =?utf-8?B?ZmFrTEVFWFdMUllyZnRkbGdYM0hQTmRqWVhKY2dDQ2txMDFBTFdBd0NhZ0V0?=
 =?utf-8?B?dmIxbTNwN0dySHQ4SjlsWG5tVGtXdDlxMUQrTzVZMTBxMUZ1SXBGeDhCSGJu?=
 =?utf-8?B?QW1BS3FDbTNSci9pRWM2dHRrUy9teEF0RHAvT1VQcUhEZ2w0dGZ3YnluWm5o?=
 =?utf-8?B?d0V1Q2ZheFA3dSt1ZTltbFRjKzB2NnowRThRWGFrZ3lyWjQyUGNUdFlET2JK?=
 =?utf-8?B?TTlsMHY1ZlRoQlFwNzhOZTlrY0NmeUJ2dFhPeUJmMVlReGlhQ2hhWmdwK0RC?=
 =?utf-8?B?dkJ1T2dWZ25SWU90b3JEanMxRHczSGpNYS9nSVo0U1M4cDFwNDg1d0ZiNjFu?=
 =?utf-8?B?ZTV2RjRwT29MQnplOGw3STZRV3ErSTE4TzlTNnhsbVJyRGYxRkprSEhQRG1R?=
 =?utf-8?B?eEUrNWhic3EvY1pCNTVRcmJCVnNUTWwyb2NPQU50ZUtjWlUvclZ3U1F5Q1JO?=
 =?utf-8?B?clJLbndsK2lzemFXSUlDYzloejV5U2N1KzRtOURQWElVRlIxS0pWeStRUE9j?=
 =?utf-8?B?dGtrOU4vYWhTamU2WkNkaktxTjc2TndXcFZpZDk3dGExU3h5VDh0UlBoQkJZ?=
 =?utf-8?B?UGVKbUExQjFoZHlJQ1ZEaDN5SmIrZmtKK3p6aWQ3Wlc3d1k0MEtXWkZuWmVx?=
 =?utf-8?B?RFl2cDlNR01lTlc3VGVMQ0FWek95YzduTzV1NFpWOE12YmxxSGtwL2hjblMr?=
 =?utf-8?B?TmtCbjdpdjRQcDZSRUZUcU13YTQ3QVF6R2xTUmpNNmExb0hWSGJEV2dJdDVu?=
 =?utf-8?B?bmgzdjVpd3hLMjNPSG9Pc1pNM3RsWHJBWElISkltL2taTDN2SVBkSGdnMWJW?=
 =?utf-8?B?QjlxWFJncGNmUnVNUCs5c0JLM1o3VWgxaEFWVmQ2YkhIMlpFMFkraDJZeWF2?=
 =?utf-8?B?YlpIc0dLYjZFbUkwSGV3V3p4UGxYaTFxTGpwck9LR3hwTUJwdzJIYmNRUWFI?=
 =?utf-8?B?dDh5ZkhtRlhDTWwzVHRFWXB1d0xZY3UzaER5Qm1lVkY2Ri9YQ0hvNElKYk5S?=
 =?utf-8?B?V01tNXJ4Rkp1dml3Y0Npb3lHOU9TSmJVbzEvMEZFK0xyOWlRazB5d1NQa0tI?=
 =?utf-8?B?bUlxd0ludDJyT1c0U2hJZFVzbHVqbEc0bmh1S3RxL2gvQkRiSzExMjYwRTB0?=
 =?utf-8?B?d3RuRFdpVjd4MmdtZXZIZ0NjN1JpaHpQK1Vzalc3RWNMRFZ5YlJiNzVrM3h2?=
 =?utf-8?B?c2dXRDJaN3ZzRllabXI3d0FxRGs4cHZmcU9UNW0wU01kM21lOHQ5emN5SENY?=
 =?utf-8?B?OVpjc0tKMWRNVzR2MFBoSWcwRDFFSTFsUlVZMnNNK2NhaHF2bjBxaENBNENi?=
 =?utf-8?Q?N7Qk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb22c7ff-b49c-4ef2-124a-08dd0d34062a
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2024 09:32:04.9218 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VF5bJBfZK5iTldPVIiUqvqr007u4s+OMIR/R2vtWJGQPH+/9zvG3lGA9QBmIbUzMfcnkxI/VpPs1diqCctit0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6883
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

SGkgVHVkb3IsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVHVkb3Ig
QW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BsaW5hcm8ub3JnPg0KPiBTZW50OiBNb25kYXksIE5vdmVt
YmVyIDI1LCAyMDI0IDEyOjU5IFBNDQo+IFRvOiBBYmJhcmFwdSwgVmVua2F0ZXNoIDx2ZW5rYXRl
c2guYWJiYXJhcHVAYW1kLmNvbT47IHUtYm9vdEBsaXN0cy5kZW54LmRlOw0KPiBqLWh1bXBocmV5
c0B0aS5jb20NCj4gQ2M6IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgamFn
YW5AYW1hcnVsYXNvbHV0aW9ucy5jb207DQo+IHZpZ25lc2hyQHRpLmNvbTsgdS1rdW1hcjFAdGku
Y29tOyB0cmluaUBrb25zdWxrby5jb207IHNlYW5nYTJAZ21haWwuY29tOw0KPiBjYWxlYi5jb25u
b2xseUBsaW5hcm8ub3JnOyBzamdAY2hyb21pdW0ub3JnOyB3aWxsaWFtLnpoYW5nQGJyb2FkY29t
LmNvbTsNCj4gc3RlZmFuX2JAcG9zdGVvLm5ldDsgcXVlbnRpbi5zY2h1bHpAY2hlcnJ5LmRlOyBU
YWthaGlyby5LdXdhbm9AaW5maW5lb24uY29tOw0KPiBnaXQgKEFNRC1YaWxpbngpIDxnaXRAYW1k
LmNvbT47IFRlamFzIEJodW1rYXINCj4gPHRlamFzLmFydmluZC5iaHVta2FyQGFtZC5jb20+OyBE
cmFnYW4gU2ltaWMgPGRzaW1pY0BtYW5qYXJvLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0g
bXRkOiBzcGktbm9yOiBBZGQgc3VwcG9ydCBmb3IgTWFjcm9uaXggZmxhc2ggcGFydA0KPiANCj4g
SGksDQo+IA0KPiBPbiAxMS8yMi8yNCA5OjQ3IEFNLCBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUg
d3JvdGU6DQo+ID4gQWRkZWQgc3VwcG9ydCBmb3IgTWFjcm9uaXggT1NQSSBmbGFzaCBwYXJ0cyBN
WDI1VU01MTM0NUcgYW5kDQo+ID4gTVg2NlVNMkc0NUcsIHdpdGggaW5pdGlhbCB0ZXN0aW5nIGNv
bmR1Y3RlZCBvbiB0aGUNCj4gPiBUZW56aW5nLXNlMSBib2FyZCB1c2luZyBTVFIgbW9kZSBmb3Ig
YmFzaWMgZXJhc2UsIHdyaXRlLCBhbmQgcmVhZGJhY2sNCj4gPiBvcGVyYXRpb25zLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVGVqYXMgQmh1bWthciA8dGVqYXMuYXJ2aW5kLmJodW1rYXJAYW1k
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBWZW5rYXRlc2ggWWFkYXYgQWJiYXJhcHUgPHZlbmth
dGVzaC5hYmJhcmFwdUBhbWQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBEcmFnYW4gU2ltaWMgPGRz
aW1pY0BtYW5qYXJvLm9yZz4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tdGQvc3BpL3NwaS1ub3It
aWRzLmMgfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYw0KPiA+IGIvZHJp
dmVycy9tdGQvc3BpL3NwaS1ub3ItaWRzLmMgaW5kZXggOTFhZTQ5Yzk0OC4uYTEzMDg0NWQ0MSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL210ZC9zcGkvc3BpLW5vci1pZHMuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvbXRkL3NwaS9zcGktbm9yLWlkcy5jDQo+ID4gQEAgLTI3NSw2ICsyNzUsOCBAQCBj
b25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBzcGlfbm9yX2lkc1tdID0gew0KPiA+ICAJeyBJTkZPKCJt
eDY2bDJnNDVnIiwgIDB4YzIyMDFjLCAwLCA2NCAqIDEwMjQsIDQwOTYsIFNFQ1RfNEsgfA0KPiBT
UElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEIHwgU1BJX05PUl80Ql9PUENPREVT
KSB9LA0KPiA+ICAJeyBJTkZPKCJteDI1bDE2MzNlIiwgMHhjMjI0MTUsIDAsIDY0ICogMTAyNCwg
ICAzMiwNCj4gU1BJX05PUl9RVUFEX1JFQUQgfCBTUElfTk9SXzRCX09QQ09ERVMgfCBTRUNUXzRL
KSB9LA0KPiA+ICAJeyBJTkZPKCJteDI1cjY0MzVmIiwgMHhjMjI4MTcsIDAsIDY0ICogMTAyNCwg
ICAxMjgsICBTRUNUXzRLKSB9LA0KPiA+ICsJeyBJTkZPKCJteDI1dW01MTM0NWciLCAgIDB4YzI4
MTNhLCAwLCA2NCAqIDEwMjQsIDEwMjQsIFNFQ1RfNEsgfA0KPiBTUElfTk9SXzRCX09QQ09ERVMp
IH0sDQo+ID4gKwl7IElORk8oIm14NjZ1bTJnNDVnIiwgICAgMHhjMjgwM2MsIDAsIDY0ICogMTAy
NCwgNDA5NiwgU0VDVF80SyB8DQo+IFNQSV9OT1JfNEJfT1BDT0RFUykgfSwNCj4gDQo+IERvIHRo
ZXNlIGZsYXNoZXMgc3VwcG9ydCBTRkRQPyBJZiB5ZXMsIGFyZSB0aGUgU0VDVF80SyB8DQo+IFNQ
SV9OT1JfNEJfT1BDT0RFUyBmbGFncyByZWFsbHkgbmVlZGVkPw0KDQpUaGUgY29uZmlnIFNQSV9G
TEFTSF9TRkRQX1NVUFBPUlQgaXMgbm90IGVuYWJsZWQgaW4gb3VyIGNhc2UsIHNvIGFkZGluZyB0
aGVzZSBmbGFncy4NCg0KVGhhbmtzDQpWZW5rYXRlc2gNCg0KPiBDaGVlcnMsDQo+IHRhDQo+IA0K
PiA+ICAJeyBJTkZPKCJteDY2dXcyZzM0NWd4MCIsIDB4YzI5NDNjLCAwLCA2NCAqIDEwMjQsIDQw
OTYsIFNFQ1RfNEsgfA0KPiBTUElfTk9SX09DVEFMX0RUUl9SRUFEIHwgU1BJX05PUl80Ql9PUENP
REVTIHwNCj4gU1BJX05PUl9PQ1RBTF9SRUFEKSB9LA0KPiA+ICAJeyBJTkZPKCJteDY2bG0xZzQ1
ZyIsICAgIDB4YzI4NTNiLCAwLCA2NCAqIDEwMjQsIDIwNDgsIFNFQ1RfNEsgfA0KPiBTUElfTk9S
X09DVEFMX0RUUl9SRUFEIHwgU1BJX05PUl80Ql9PUENPREVTKSB9LA0KPiA+ICAJeyBJTkZPKCJt
eDI1bG01MTI0NWciLCAgIDB4YzI4NTNhLCAwLCA2NCAqIDEwMjQsIDEwMjQsIFNFQ1RfNEsgfA0K
PiBTUElfTk9SX09DVEFMX0RUUl9SRUFEIHwgU1BJX05PUl80Ql9PUENPREVTKSB9LA0K
