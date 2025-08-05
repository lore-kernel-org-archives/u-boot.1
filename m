Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C95C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 14:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6D4A83829;
	Tue,  5 Aug 2025 16:22:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.b="YRl774P1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7351483108; Tue,  5 Aug 2025 14:10:36 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D57DB83214
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 14:10:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tomas.alvarez-vanoli@hitachienergy.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDHwVHWDpjlcyAt12Rqr3zkw96p/6iYTOl+v4IMSFaTo44Bk+PrcMySXTI65Vn/hm9TKIl2dbk4WDYnyS/wtGuo/tSKhz4hzC4AfYOZGf/nMoe2CeNZ6gk/hsmNhwzlwxjf6zImc9umgW5xtbg7hE0vaTyKR9vWjOivH0+R768m4x3APvZr/Y9LPxIt1VXSTXzyaeQ1UuyfNBAAuzs5beYyPl5BGx5tM+VioGiE3ay20kPn6PePGuAtbJorTxxNiTEM6XIWmbkq3QfYH3yTJouc8dweBlCuH66PBnI8okx0HUpyxLQROM8aWtDEhKhhjbyWs9QrJU9XNy3l+VBO02A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAC+mJZusSHuU+a4/1jGAj65A4eze1oO/mR18DExNOc=;
 b=xH7elPFCWaDWt262NRUwvW7REQFsHxl8ChYf0g67G4LnNfQWmBprsdZgQIJ5i0+FabIUDYXnnq7X3XxR+gQwEnf9Y6wFbW2jmYBxQSL4xcuHzuE0lb2bkKWrY+8NkBwttUNIZ0IIXPiK5+CF6GcLzAVJNix5cwbKEYk5UwQN4NTJDeDh1u2JBYUw186ujJ4pzmJehK1eXXsalN7NF00g1z391afi8BJW0Ug8S8FZEiXvoNtdBntPb0S/YUnAFT1Xhrh59bbMG1QH45dlIGSLOk+WHC+ApuDDAL/HdXhiZjToCdTDFtmp1zTebwISLJxeon4AzfZqYxWNIom7f+TVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAC+mJZusSHuU+a4/1jGAj65A4eze1oO/mR18DExNOc=;
 b=YRl774P1OhphFZCom8BBW7UgiPGPRsHk47pIVnf6DLPULrNJISU7q+ED+A6hj9rVRj9lZwQUB2KFL1WS2kEsksAp0TlWD7efHDsyeZYTpBCspO/GDM7jaPBhyGEmqtoSjMIhhij2nvNJJyHTLBe0mX5l7I2Bt/K6F/yhBdY8HYKPbQJgGQdP2nChvDP9S1sd4/V8/vy1F9AsMFBww8RxUuYfCmRmfOZ0tKzHaJLHI74mTIq89ai8NnbVvCpPQ2XOFR+RZZM6EhTJ+ukTfFVwNhEAnowkAnKOBGPkOccpKvVmn5m1+rgCIlb4LOdknJAywqdlIk8cXc/Il1FCHcKiNQ==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by GV1PR06MB9170.eurprd06.prod.outlook.com (2603:10a6:150:1ac::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Tue, 5 Aug
 2025 12:06:57 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::b9c2:ace6:6179:45d%6]) with mapi id 15.20.8989.020; Tue, 5 Aug 2025
 12:06:56 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>
Subject: RE: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Topic: [RFC 0/1] use lmb to calculate ram left for the kernel
Thread-Index: AQHcBe0S3kynZXd3OkScXc3RsybZB7RT4fIAgAADLRCAAAP5gIAAAjowgAAJUmA=
Date: Tue, 5 Aug 2025 12:06:56 +0000
Message-ID: <DB9PR06MB78497DD64948A080F9BF00DFC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
 <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB78496FE3E20E12819419D195C222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.22.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|GV1PR06MB9170:EE_
x-ms-office365-filtering-correlation-id: e9cf2f98-0da9-4671-3a4e-08ddd4189326
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bkhEUDlhYUVoOWxnbkl6Y1NURWVZVndRQkhpalZ4RFJ2TjlHNlRGSFhKS3pI?=
 =?utf-8?B?aVk1M0dUR2p0bXZZaHIraUJXSU9jUy9aL0xDOXBJbUtDeXl0MXNGd1JIYzVY?=
 =?utf-8?B?YnpBeG1JTVpjeHBMMmp5L2dDQWE1d3phSjd5RFdzbmw5S25OcE83ZFdLS0F4?=
 =?utf-8?B?YWNtZ25WT0w0RkNQZmphUmpmR0MxWFRjSWNLLzVnWDhJKzRDUmtTVHpLczVa?=
 =?utf-8?B?aDhjc05PT0RyK3dxOUo4ZDBydjBrSlVSZ2dnZXRvMjdsKzlpZFdVSkN3WTV2?=
 =?utf-8?B?S0VjS2Q2VXVIclZzRWpZWlpNSmdxQXRPRkJIajBxOEN2elVFOXlPbXRqck1L?=
 =?utf-8?B?NzNzdFdTcjVNaWlHb3oyaFYxTU54T0RVYmlaZGJvdytROG5LdmdHVmFCcFlz?=
 =?utf-8?B?RU92VkI2djlvaTRvbXh6NWFXTThTMlhpcEswenNIUnNOWkQ4dFhYdFROQ0hw?=
 =?utf-8?B?RzNFZ0g0ZWxjdTBoUHE4anc0eWMzcDdYaDVsZUtodGhRZHo0Ny9OaUVUZnFt?=
 =?utf-8?B?dFZ6UGgwWUdFTC9SRGZ2WE5lSHdNa0g4TlhuNm5XUytZUEk5UTArbmw5OWtw?=
 =?utf-8?B?b3ZQRU1FeHJCTS9nUGtzVjVvekNPak85WUxQakoxVHZBa0hiaThFdWhiQWhF?=
 =?utf-8?B?QzdRYW1Iaml5WlczSTEyY0FndGJSUFhVdVUzUk4zT2Z4bi81eVBXODBhY3lL?=
 =?utf-8?B?K0Q2citIL1lVNVBCWFUwUFJnYTNEOHFJV1RUTDZWdjhTNktBcFRXcllLU0FK?=
 =?utf-8?B?eG4wbG4wS2s1UFN5Y3BUWjJOQmEvK1pqYkp5eDRiMmtNTFl4Vm1jbkd5TW9w?=
 =?utf-8?B?SXp6N09vYWxjTnN1SUt6cEROVnB1Q0g0QWNWTVIyYldFSXZVOVNIUVYxZlBi?=
 =?utf-8?B?TlM0eXFNUmFnNEcxY3dySnJsM2NnN1lQUVVVa3k4Zm9GWStsMFhtNldLdU9u?=
 =?utf-8?B?aW1wTHplMDUrV0FXdlBXT3AxYWs3N2VXSjRZQk51b1RsK1hXV2N4ZEhnYVNR?=
 =?utf-8?B?czJyeW1nVHRlYjF3MUtEcjNGQi9KYmlWeHh4NXhUSnY2ZkR5OE1PSmo4S1VQ?=
 =?utf-8?B?UEdESTBsdUxxanBvZVpWa05Ga3RNTUlsM1FtRDhyZ1FzdzJTVlpyOUs1ZmlV?=
 =?utf-8?B?QkJLUVBlMkJjSmJOdUhKV3RGZGtORDE3bElKd252TnlRRzlETW1WcEg0QTh4?=
 =?utf-8?B?ajNDOS9xTjh3UHpNZy91YXFVSFlGcnRuLzR5aHNFY1pVNExlUFUyYjdBMDBV?=
 =?utf-8?B?TGRiUEt0STBFS2p0ZDJBRVIzVFgvTlFQU0xSTVZ1d2FUZkQxRHpMT25XTzUy?=
 =?utf-8?B?Y01CcmZ0RW03a1Z0TTd6Y0xmWGpvYldiQUlQV0VvODBqb1pNeXhPSjBQYWJy?=
 =?utf-8?B?d1FVMmM2S3N5OEVnc3BOMHk5NzJFMHd0UHlzajZXaCt1anNBdldORWpnOEZo?=
 =?utf-8?B?bTFqemxXV1Zham9xbEhMWkU5dHZCc092RWF5TDhQc2tKMURNUXBJMTg2R2hy?=
 =?utf-8?B?YjZrRGFqSjR3U0pqVUNFN3F2UkVFNURIL1U2bEVPWkJON2k3MUx6K3plL0c4?=
 =?utf-8?B?T3dyWnRQOFgwSmZsellNUVdUTklwbjU3NUxKRmhzbUJ0WjJOc3I3Q3BjT0ts?=
 =?utf-8?B?L1Rld0JaQ3lCMWhzMjBPWkFoZHk3R2VrLyswT1NnV25nTUVSa0Y4Z3p6Y1FD?=
 =?utf-8?B?RlVTcmpUMWFiMEV4MDdNUjlhZlgza1VINHY0Rkl5djNWWGw0Y0FERzlTNFRy?=
 =?utf-8?B?THMvVmFvK3pCRlhUK2lKbDQ1ZUlVRDdzekx5UjJLQnRQM2RId2Rvc2xPMEJC?=
 =?utf-8?B?MFVSblFycmZmVGVEbHRKR0tWempCWVhnWU1ZMDFiNEEzN0tYN1hjYThxaU05?=
 =?utf-8?B?clgraVRDWTVSdXhJRk5CckJ2dXVpc0tvZC9zMkgxY0FvL0JLSDljTHA3UEZm?=
 =?utf-8?B?SjRNaVY5MXhRaUdKeW5QZlJQRStVdll6QnlhMjd5TnIwMVdkMEJhczRpdE5M?=
 =?utf-8?Q?PXioMuXKJc9SDHTugG66YYfgnSA2dk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2xvWitFUlRBWGtOTnJCenhZNzNZWnlYMWUyNGdaMzdBMGNHOHk1T1NOUkRk?=
 =?utf-8?B?VjROMXFla2JXWTJLTXlZT0lDNWFnUFYvNi8xckRVQmVOUTdESWdlUXlRcHBV?=
 =?utf-8?B?SXAzcnBCWVllVXh3emx0U1JRemxpcU8vVk9pWUJjWDhIcDBhR2dmUEJSeTBj?=
 =?utf-8?B?dHlRbWE0UDgzSDA5aHpNMjR2bElmRXk2THR5TTkvZGxZVXRjZXpTR3lXczIw?=
 =?utf-8?B?eEtaQnBtOUYrK1N5bXFudC9Wdm1xZFFsd0Q3dUFZY3pPUUtLYVZoMDcrYVIw?=
 =?utf-8?B?ZXJUMUVFSFNVR2Y5N0k4M29VVXorTENTcVJyS25rd2lNODBnTUxqRHZISzh0?=
 =?utf-8?B?aHh1L0FsQjFrSnBCbWZmUWVuUmdBenY1dlpFQmEwL1l3NnNrcXFwZGU4T0s4?=
 =?utf-8?B?SllJZENWcThtSFowSE9mNkVSemxlUG1Vd2JQbVhmdXdKUkZvaENFcUQveldH?=
 =?utf-8?B?QzZPeCtkVDBma3dRSkhVUnRwZTJIS0pGdEs0bVNwNmdyS1N1NXgzaE5UenBQ?=
 =?utf-8?B?ektSRDd2MUdMTkNCUGdMbXhMRG1qcG1jWjYzcDZ0WWlCYVlMekdtMGNvVk9y?=
 =?utf-8?B?L3pLbjVsdVhVaFhGWURETEhEZEROS0wwaHE3UWdIeHVkcko5dktNajQ4Ri8x?=
 =?utf-8?B?S1h5Ti9PemNFWXA3WlFIRnpyUDUrVjI2RnYxcThLZ2lXeEMvVy9rN3FXK01B?=
 =?utf-8?B?bUJ6cklSNVVGSjg2R3BuNXFFZkxPbk5IcnpNS09GUXNYbGZxN3ZpWHI4UFVO?=
 =?utf-8?B?YlZhZGdaVmhIOUlKbEhHWnA0aVl6ZExrSno0QTdiU0c5NUVPYk90NGpoZk40?=
 =?utf-8?B?eUFaYXVkd2xrQ1ZWYm5aWHFtSjdCTjB3aW55di91UDBsZGpJUzB6Y080WjEv?=
 =?utf-8?B?eHRXek9sRkNLZ01kRHd5djNQejhRaFZRdVJSdm9ZU2h4VzZwdEZJUWJEblBY?=
 =?utf-8?B?SkJBWXNkcUZVQk5OR3NQd3dzbTJsUkJkbzgyVHlJRjRhYnlrRklDNThwRkdw?=
 =?utf-8?B?alYwSTVTRW1yT00yOS9yTmhJS0piMXErU3BQN2tVWFFxV0ZsZENHajJxaW5t?=
 =?utf-8?B?cVpyS1UzMzR6eUtSVGlndm9VQUZ1RG4vVXhKTlRUQkVzTVFIZ2pTL3lNS2lV?=
 =?utf-8?B?VzE3VUxkc1IwUGJtQk15M2FDT1RZOGc1anRDM3pKZVFjVjJCQ3pLV0hhQ092?=
 =?utf-8?B?T29sT3VLRnlhWmZIaGNXb0dXdkNmdnNZZU1hRVF5MVlQamJ4am95Kzd4MXpi?=
 =?utf-8?B?UmxTa2FsbWhWc1k3dW1nODlpai95TW9JS0dHVndzYzV2TUYyTzZxelRYd3NY?=
 =?utf-8?B?eEl4QjdJVno0MWUxMGFxT21Reld6K1N0bnpSR2ZFM3laK3EwV1BUNElXbVJm?=
 =?utf-8?B?WDAyVHgxWWJiOEk0eis2U0svU1AySDVaVmJIRlVtRUxpaGVTWnhvV3d0KzZC?=
 =?utf-8?B?SXd4N3pqZ2Vlcmk2Q1BqdU11elBTNGpqL0pYZlZNVHdHS1doNWNBUVd4K2pY?=
 =?utf-8?B?SUdIZ0xuR1NSNUxZTXprMVI5NTRJYXZaU21WVFNaMDdqT3o4ckt4cGVtQlFn?=
 =?utf-8?B?cHVNOVF1ZzBoVUpVTGQwaCtncmVzS0NjMmt4ZXhPZmphbjJZSWNHTGlHTjlO?=
 =?utf-8?B?NXZKTXR2R0tTdFJ5bnFhZWVXWmNJcFRsWjlkazZCTUcrM0Z3dzZUd3dSWmdl?=
 =?utf-8?B?OHdZbWVPMExmaGlZZ3VWenJQUE81WUFRQTR2bTNacGNlYUw0Lys0ZTJOTld1?=
 =?utf-8?B?b21iYVZ1K3REVEc1Ym5XbFRVS082ZmtpRk5Yd1BWSmNkUHg1NGx6bHhNVFBN?=
 =?utf-8?B?YkJUdjhwc1Bmd2MwVlB0VmlTZmFsQSt2TGtxZUFYNEN6V1p3blVsdVltMXpi?=
 =?utf-8?B?eHJ5SVpScGtDbjMvWkZySHg5dTlGUDNYNnZya3FwMkY5cDhmY05Sb1BHbngy?=
 =?utf-8?B?SDhzWlU4c0pRZ21yOEpEdjR3TmwzaytTbTcyK01lSXYrcHFQb2l1MkRVV0hl?=
 =?utf-8?B?ZzRMeEo0cGROY3VYdmdva1VaQUpDY25aM2pTd09GcEFRT0NBT05sWVBJSmN3?=
 =?utf-8?B?engzeUcwamZyczJDS3crUDZCWlpVMURLbHJhWDVjenR3SExNMmp0RmJHODRl?=
 =?utf-8?B?ZWEzamlCMHg2OStQZ2tHd3l1aHBacENiRnEzT05zYXVZNkw1N1ZBT0Zta00w?=
 =?utf-8?Q?368D5Q/9p8w0T6eR6qbqds8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf2f98-0da9-4671-3a4e-08ddd4189326
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2025 12:06:56.9472 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +WnS1Zis8uxM6ZHuoDl2VREFaF6+ItZA58RdmGqKBnrfgrc2dJ8Q5dVKK1cS2t57bMVyxSSQxzn5YOIjhE/dntjHZ1BY8zpV9VlByzTwRvyWBFf9ip28uJpNkyaMXzPC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR06MB9170
X-Mailman-Approved-At: Tue, 05 Aug 2025 16:22:00 +0200
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

Pj5JIGFtIGNvbmZ1c2VkIGhlcmUuIFlvdSBtZW50aW9uIGFib3ZlIHRoYXQgdGhlIGFkZHJlc3Mg
b2YgdGhlIHJvb3RmcyBpcyBkZXRlcm1pbmVkIGJhc2VkIG9uIGl0cyBzaXplLiBTbyB5b3UgZG8g
a25vdyB0aGUgbWVtb3J5IHRoYXQgd291bGQgYmUgbmVlZGVkIGZvciB0aGUgcm9vdGZzPyBBbHNv
LCBob3cgZG9lcyBjYWxjdWxhdGluZyB0aGUgYW1vdW50IG9mIFJBTSBsZWZ0IG92ZXIgZm9yIHRo
ZSBrZXJuZWwgaGVscC4gSSBtZWFuLCB3aGF0IGlmIHRoZSBrZXJuZWwgaXMgYmlnZ2VyIHRoYW4g
dGhlIGFtb3VudCBvZiBsZWZ0IG92ZXIgbWVtb3J5PyBDYW4gdGhhdCBub3QgaGFwcGVuIGlmIHlv
dSBkb24ndCBrbm93IHRoZSBhbW91bnQgb2YgbWVtb3J5IHRoYXQgd291bGQgYmUgbmVlZGVkIGZv
ciB0aGUga2VybmVsIGFzIHlvdSBtZW50aW9uIGFib3ZlLg0KDQo+U29ycnksIG1heWJlIEkgbWlz
dXNlZCB0aGUgdGVybSAia2VybmVsIG1lbW9yeSIuIEkgYW0gcmVmZXJyaW5nIHRvIHRoZSBhbW91
bnQgb2YgcGh5c2ljYWwgcmFtIGF2YWlsYWJsZSBmb3IgdGhlIGtlcm5lbCB0byB1c2U6DQo+IC4u
Li4NCj5JIGhvcGUgdGhpcyBjbGVhcnMgdXAgdGhlIHVzZWNhc2UuDQoNClNvbWUgZXh0cmEgaW5m
byBmb3IgdGhlIGRlc2lnbiBkZWNpc2lvbiwgc29ycnkgZm9yIHRoZSBkb3VibGUgcG9zdCwgSSBo
b3BlIHRoaXMgbWFrZXMgdGhlIHNpdHVhdGlvbiBtb3JlIGNsZWFyOg0KDQotIFRoaXMgaXMgdXNl
ZCBmb3IgZGV2ZWxvcG1lbnQgcHVycG9zZXMgb25seSwgaWYgc29tZWhvdyB0aGUgcmFtIGdpdmVu
IHRvIHRoZSBrZXJuZWwgaXMgbm90IGVub3VnaCBpdCdzIG5vdCBhIHByb2JsZW0sIGl0IHdpbGwg
Y3Jhc2ggKGl0IHdhcyBoYXBwZW5pbmcgYWZ0ZXIgdGhlIHUtYm9vdCB1cGRhdGUgYmVjYXVzZSB0
aGUgdGZ0cCBhbGxvY2F0ZWQgcmVnaW9ucyB3ZXJlIG5vdCBjb25zaWRlcmVkIGZyZWUsIGFuZCBp
dCB3YXMgZ2l2aW5nIHRoZSBrZXJuZWwgdmVyeSBsaXR0bGUgbWVtb3J5KS4NCg0KLSBJdCB3aWxs
IGFsd2F5cyBiZSBlbm91Z2ggaWYgaXQncyBjYWxjdWxhdGVkIGNvcnJlY3RseS4gQm9hcmRzIGhh
dmUgYmV0d2VlbiAxIGFuZCAyIEdCIG9mIHJhbSBhbmQgdGhlIHJvb3RmcyBpcyB0eXBpY2FsbHkg
MzAgdG8gNTBNQi4NCg0KLSBQcmV2aW91c2x5IHRoaXMgd2FzIGNhbGN1bGF0ZWQgbWFudWFsbHkg
Ynkgc3VidHJhY3RpbmcgcmVzZXJ2ZWQgcmVnaW9uIHNpemVzLCBidXQgc2luY2UgdGhlIGludHJv
ZHVjdGlvbiBvZiBvdXIgYXJtdjggYm9hcmRzIGl0IGJlY2FtZSBzaW1wbGVyIGFuZCBtb3JlIGdl
bmVyaWMgdG8gdXNlIGxtYi4NCg0KLSB1c2luZyB0aGlzIGluc3RlYWQgb2YgbmZzcm9vdCBsZXRz
IHVzIGhhdmUgbXVsdGlwbGUgYm9hcmRzIG9mIHRoZSBzYW1lIHR5cGUgZG93bmxvYWRpbmcgdGhl
IHNhbWUgcm9vdGZzLiBXaXRoIG5mcywgd2Ugd291bGQgbmVlZCB0byBwb2ludCBlYWNoIGJvYXJk
IHRvIGEgZGlmZmVyZW50IG5mc3Jvb3QgdG8gYXZvaWQgY29sbGlzaW9ucy4NCg0KVG9tYXMNCg==
