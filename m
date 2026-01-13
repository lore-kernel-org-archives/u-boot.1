Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17605D29DE2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76F88398C;
	Tue, 13 Jan 2026 09:42:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="kTOES5mu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C924C82C7F; Tue, 13 Jan 2026 09:20:31 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11023091.outbound.protection.outlook.com
 [52.101.83.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70B13803F5
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrZAFuHOxJhJdIu+xjsr+OCBkFvGlp2PkiQMpPXGP6I1hhD4FryO7U2fKyKoc9mccjgJ7lQ7NS1k4Qbr6q1r6bKC7taOhkb2g0kBzw2jVszep50qnW23vByToovtElrnf6auaRbxqaujl/O3aAFGa9DcXCiAP7kHvbAp7oTwQW3kDtOD776ymgBNeJo/U2g0eridQ1ENVutGIif9GDMjLx1c5SRZJA8hBkXuIysFDePYN4Qjg7+ESucs57AUo0NNUaEgNPhOeB5q75eHQRKT1ml12ZFj6jJtc15LT9gh+ZigLPmkXvrdAnA6vfMNVudsZcahu6Mmt3yAgEfKsY9tww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ignfUBs3jcwm2qgo26e7mPwdLXMYmbd7S0yiA+OE+Q=;
 b=NtGsPSW1H/Aaq7y0zFnvWpd6Ey1x601HX93aG/dvpiJ8aBBcWFTi1RxqPEhi6MXDVEMKWKIPmCEdoTYZPS4vwYu6b3Hn0yWPzL4TZ+vve7bweFIalNC4q8NhzXZVEk1ar0TwczJ7bI4Gdrwv90IDCjq140OoAYxBGxI4D4fedm5lCoJvIrezLRIKX4ySnyMJHRhZOmD08FCYRkGbDpNB2NOMe3/W/TwCOW7rQoJDER/Cm2MzdiFP2xavG4JPb1IDhTcAygd5ke7x4QZVAOoENGNSymKhQOihp+P6aiYTFgM3M/qZVtrxZLXDj6KHYzfsCcUqEvIuNYjo34KOv05bDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ignfUBs3jcwm2qgo26e7mPwdLXMYmbd7S0yiA+OE+Q=;
 b=kTOES5muNdImepLEuME1bZjhcRyvvkXjAJyeMqXWDMxVCRrC7T3D1xX1c99qT9kPehkfrXkY8Hd1aSnj5rRSYJfpWwKHZYJsHE9KEOSNCCB3dInR9cws7Y7ijt+tP+vKQbTLy+sGizVzfm7Szo8w8gM2Sq0g9IA4BRFTbqad4LsPQAUjEK/UWqgTnYfTA15gkmtbnvym1QQb6rXL+QRvhUTmm68QH8WRy+s9jQ0xrt1BJJERbtuiNtiASpMj6kOLNayODjL+zeLHnIG8VP+2IIXV7JXQB2ZoYLiWp9PFF75zmiVfBITx237mXefqVVWPMgIB09uOWMGSJzsU6evGHQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by AS4PR09MB5600.eurprd09.prod.outlook.com (2603:10a6:20b:4b7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 08:20:08 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 08:20:08 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: Yao Zi <ziyao@disroot.org>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 10/10] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Topic: [PATCH v4 10/10] cmd: riscv: Add 'startharts' command to start
 multiple harts
Thread-Index: AQHcEPTd8PlOhGnmQkitS5QV2fnTybS6AhGAgJam34A=
Date: Tue, 13 Jan 2026 08:20:08 +0000
Message-ID: <508b3beb-6e56-4f72-ad42-db17dc846ff5@htecgroup.com>
References: <20250819103021.1518687-1-uros.stajic@htecgroup.com>
 <20250819103021.1518687-11-uros.stajic@htecgroup.com> <aOef-6YZKbyk9RsD@pie>
In-Reply-To: <aOef-6YZKbyk9RsD@pie>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|AS4PR09MB5600:EE_
x-ms-office365-filtering-correlation-id: 8a1102a4-5b0c-4265-d056-08de527c9062
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OURCNFBNM0VlVzA2U0FHeTFEZkM3TllmT2ptVkdMZmc3N0NUc0Q4VHlkWGZr?=
 =?utf-8?B?WVhva2tFVS8yczB4WHdvbkRVUWZ5d2JVR0Q0Q0ZGTmhKOUU0Zmp6RktHRnVD?=
 =?utf-8?B?RUxxQTFnamFIbHoyZndwVWJNOTJCTEFLVDc1eE1MYkVQKzlVMWIwaUV4MldS?=
 =?utf-8?B?NTcxeDVjek8wZVhpbWdQR2Z3RzZWU0c5eU9BbmsxZFlLNktSQ3lWMWZFVC9q?=
 =?utf-8?B?UHg5dE1uV2NUYStEU09odld5Rm1BUzhCTElmc245akp6SE9nblFyWXRMVWJO?=
 =?utf-8?B?clVxSUFEdmhMUVlMaGt0NGZBTEVSYUdkYmJBZ1VXdHk3c0wyUVN2azh0VjRI?=
 =?utf-8?B?MllNWGNweTI1QWJ6cnJsdE5YVDJMZGpqL2xRVEpjRkU3THBwUW1hMWxyU1py?=
 =?utf-8?B?ZldjcnVMczFMeXJFMUQrSmJwVFFXTVcxK0FhdExjdmNXVGc0cHNobmMxL2FU?=
 =?utf-8?B?ZFlhOXRZNW50UGt6TkxGVm9nNDlLS2gvOTlGK2VkLzFmREFQajUvcTE2ek1z?=
 =?utf-8?B?aWNBSkFyMTB1cEdXa2Y2c1dxQlo5WktKdkdndE41TnRpVjkvNTJZZ3c0bEJV?=
 =?utf-8?B?R2VtVHFGREtaZkRMRC9aZUE2MDREWGFBckcwN3B1eFpZRUJ0RWJ0NWIxcThJ?=
 =?utf-8?B?ejBzTlU4MEFFU3QvaTc5M3EvVFdhb1dXQWs5TTdqenlwUEYwaEtKc2hGLzRh?=
 =?utf-8?B?QUN3dGpIclVGaDBqRmpnVWpOcm84MDdBMytmbFNzcmd6S0V2VHM2UkY3MmdM?=
 =?utf-8?B?djdta2twM0FQK29FVHhaWXJyaCsvUXA1aGo3L1FjNm1Dc2cya0RFRFU4K2t6?=
 =?utf-8?B?NlkxMWVvU1ZwY1FxbUI2dW9lNElHWHhaM21IZnJucW1CdS9wMkl6OXl5alJP?=
 =?utf-8?B?SkxmenhsR3p0c2tWVDNCS1lOM2g4OWlsenk2dTBVcXZwNk5TOTk5clJ5N2hF?=
 =?utf-8?B?dXlFTjdUeFJDbFlaMzhzNXJCdjFJbkFJRllCYlIwVXVIb2dYMm1qZFRqOUZl?=
 =?utf-8?B?OFlxOGlpN1hMOUhvQnl3SDM5cnlLSExvckIxNlRJSUhpYmRwckdSM2dIQTFW?=
 =?utf-8?B?MElkQnp0VUpXUkVaNWk0V1Ixd3V6VXluc2NoU244NXBxYkdWWnh1a1c5QTZo?=
 =?utf-8?B?ck9UTzRaRXRGdk4yTWQ0VFZ4bktFT09yT1VhN2lmTDZBVXVsQ2JreW5NNzVr?=
 =?utf-8?B?WWNXYi95QkY4WVdadzliaDArZFZCOXE1cmV2WDlhZFo5cEd4L2E1TnFpRThq?=
 =?utf-8?B?ZUlhUm9CejJ0UTYwK1lEbzVUbUdubTBWdjFrdTRtQm5FTjVYVVlvRU82cmpD?=
 =?utf-8?B?LzJycElDM2VEZ3VyazQyM3JKY2RQM1FPMnpxRGh5R3BHVXgxdkp6ODBLdjhJ?=
 =?utf-8?B?akk4T3RGK3lUeHoxZHdZOHpOeXVyTGNSSnB0SmZ4ZHgyNTRtR3NZRUpwSnRD?=
 =?utf-8?B?TEgremZwMUpoVyt3MFplQlViWUdINng4SUJNbFg2aDVSeWtMQ2xWQ3ZQQm8y?=
 =?utf-8?B?WERYUjMwQlh5Q1JCVEVJcFE0dlB5aitBa2RzbjdEelZwZDNJSTNldktMMGEy?=
 =?utf-8?B?dXlkNTBUSXZSYXpFazJodzRxNjJjYVBlbGUyZG1TSzMyR1gyQkE2d3ZyYXN2?=
 =?utf-8?B?MHMwY1NkaXFzQXlBK1JqVEdqcEFlZlBwcFBBSW41RXBWblFKckc5cEt3QkhH?=
 =?utf-8?B?RWpLejd0V2p0OURkdFY5N2xkQXpaTDFvbCs3b1c1TThWVDBTL2hQeTVVMHh1?=
 =?utf-8?B?eWtYWTNINkR3T0ZYUGlJTkdEdEY3TTN2Sjd2YlNhbnNZNnZxNzh3bm9jWXlp?=
 =?utf-8?B?YUtrZW5xQjJJVVhkV0dqK1RneGR2QW9tQ3prbS9xbGdxS1N3L1BBZXdVeDZt?=
 =?utf-8?B?NENrMm9tTTJmRk5jOE1raFpvdjlSMCt2aXo4ZjNXeERIL1dSM0l5U1BPS2c0?=
 =?utf-8?B?by9MenJSUVlZZzkyQzA3YURhQW8xeWtQODlNb1h4OWY3SXFoSFhGSVB0RWlI?=
 =?utf-8?B?TDZuSEZLUXdaUjg4bHNrVHU0L1pNWk9hMmZ4LzFaNnFvaVlMYWRnL2RmeDlh?=
 =?utf-8?Q?DS+9KH?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTRqaElFeE8zV2wxckltUkdqS2h4Q0o1N3paNG1iVG5CUjFRMVhpMis4dGRy?=
 =?utf-8?B?OHJSUWVGMUZaTm9oNWo4ZEJTU1FkSEIvRjdzOUx3dFk1YTdaV2p0RmRpTzBs?=
 =?utf-8?B?bjhYSnQ3VFgzRnpVYlpQUVJTVzJVQzgwSEZzeHJ5NFpialNaMHRkWEdMWGlh?=
 =?utf-8?B?NGtXdE1xYkhVTXA2Y0MyeHh1SS9IUDFSVThOUkthNmZlSEpHL2drK1liZVdi?=
 =?utf-8?B?b1cxVjZTVXZua0xGYTBqTk1OWGxjK084aXNYNXlpam5TRk1HekI3NThoTlVG?=
 =?utf-8?B?WElHQnNLNVltb25OSXdtT0YyeXRGSTBXUzQwMDRucU5mb28rMU5hai9tSHZE?=
 =?utf-8?B?YUlibUJoa0hVclNDc3RoSHBsdTM2cTlQaFVYUWtzNDlGNitreDlpaVYvL3Rl?=
 =?utf-8?B?ZnkzYWNkQnJ2SjNWUkxRUkg5TTRyOEMvOVlWa0EvbFRDQ1pyZHBsN2svRkI2?=
 =?utf-8?B?dWxITGFpWWkxZEZWdi9QcUloVFBLTStiRG4vUjlBVjJiQkZwL1hoaWNrYWlU?=
 =?utf-8?B?enFqK1lGOUFsdmhURk5JdG9MT0E3Yk5XTS9ibWc4R2hSbXhMOWZMTU4vbk40?=
 =?utf-8?B?VlBiMHZUdW1oTU5XNTVrWWVva2Q2NzNxQ3ZodGo4Y2FzNEF2bU4rbnBVQ0Nt?=
 =?utf-8?B?WGoyRjY1V3grOTdXdldldTNpa0Q3WUxMUzdsQW16RzFqeElKbUhGcDJQM2c4?=
 =?utf-8?B?QVJWQlRZVndhazBid3pSZDRweW5rVzcwdThUdVRYWllYN3N6bzhkTW1iS1Zz?=
 =?utf-8?B?Um1yZVBFZXlVTjdZQXF0bndZMkllMkg4cTFHc2RXMXVISzR4Yzc1MTBNR1dY?=
 =?utf-8?B?dW9hbjJSSVFDa3RNQ3BMelNwRk9FK3J5cDlVVEtnVGVRVWNyN2FVcldkN01P?=
 =?utf-8?B?UG5nNlNDSjVPSDM1YTRvOThjMUZrcTYzNThkajV4Ym5NMmRwejBBeWFvRGho?=
 =?utf-8?B?Qmt0ek4zSHJEb05HUU1lM1Z5MnQ2a1RWVUY3dXJzRHNkK0xuc0NDMnM1cW5Y?=
 =?utf-8?B?cSs5QWUyYm9wM29BRzBNMndrbjhuM3pTcTB6NkhIdFFNRWcrdzlrMytEWHF5?=
 =?utf-8?B?TG5PekxJTHpqdEtyb3RMZWI5U2d1UG1Pdk52Mk04bXhTTWtyM3hMVms2aVh2?=
 =?utf-8?B?YnZ6aE9jYkpLNXlEV3UrckozU0JNOXZhM05LV08rL1pkL3BOVmVTVzUyUUV2?=
 =?utf-8?B?TmRuZ0pwM3ZJZ3VYcXBmQjJFdGo2R1FycVRVb1dUQ3NMaS93bU1tS0ZqWFdN?=
 =?utf-8?B?My9aQldPNU5IWExmbUFrL2dxSGpkekpybnRUcys2U0I1dWpyT3dlYXFPMTg1?=
 =?utf-8?B?QkFCZGF4VENMeUEraWxVcFRLczlRMmpqZW1VU0JTSXh0WG05V3FIZHVTcnJK?=
 =?utf-8?B?TXhEVWhzVzFQNURMNFAreWEwblEzbFExRUNNVE1lQlRCOXNUY2pmWTZRNHFE?=
 =?utf-8?B?eW83amdwNzk3VE1kWERkYkZPMW1EQnZLWXhoREExUGF5TFhxeE9iN3FpUk1V?=
 =?utf-8?B?T2dTclVpQmk5TGdKZE45bzRmS1RUcXhlbm5kVHloNFE4L21IeFQvVXpxZ3Bt?=
 =?utf-8?B?eEZQSEp5UzhTRktUaFRnSlRBRkpnZG4zYTNBQS9tNjVVS0JUV2ljNUlGZGdv?=
 =?utf-8?B?MzlmaU1zdGljM3hGSHNORm9SK0c3bDVET0luQXVGZGZtNElsWWMwcndENlNZ?=
 =?utf-8?B?ZTU2UWZLZkhTZjUwMGhKNWc0QTJ4aTFZcjNUSDh3dDhVNWx4NDBjZTRLLzZn?=
 =?utf-8?B?M3FWeTBIWExXb3g3SUFhenpVbjJzd0J5Zm1ib2t3cE56Z2tLMjE2Ni9LY2hk?=
 =?utf-8?B?VlBCaUtJZVJjZURWdWliblR4QW9ucGFUaUV6cE13TXljNjdJZUtGd3pld0tu?=
 =?utf-8?B?WDhBODRXNzNwaUpCNUN2cVZ6b09RVHBSTFJ0VWFCaG5hWnJhblZvaElJVEdp?=
 =?utf-8?B?UDFVWERoYVNkcFhqVVA1anZYUUtoTWZnQVE5b1NQV3pFcmFwWllJcS8rWTZw?=
 =?utf-8?B?b3Z2S1NkNmM2RDM4UnJYbjV5RDdaVmtTQlg5K09EWDdhb1FqOXJDendRYXVO?=
 =?utf-8?B?THFqMzlDYW4yMmJCZjhBZmY4NlZHN0VGN3NEZkVZRE5NTlQvYXErRTB5TGRk?=
 =?utf-8?B?K2svSFhQQnFNV1ZLT1lnWXhmQzVrd3ZsVVBCQXZrakNMQTZpMktjTlIwZUpr?=
 =?utf-8?B?anlnRXRrelFQNUtFTDFmMVFsU1p5dGptdUl6SHhxZTdBUEJtbjlsWXM4Z0Vm?=
 =?utf-8?B?TjgyL2JrZVIyRUd0VDdVTU9DRjdhblNEU3ViRnNndnQrSWJST2NKMGdPcUZX?=
 =?utf-8?B?WTN4SGZ1eXRrTEZTOWRMMysxK1R6TFhVTGJXbUJXbG8xanNXV0dPOGxTdjFz?=
 =?utf-8?Q?dVdJEwiT0S0EmjIs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E33E8C47F5BFF94E8F3CF4ABA0D2D46A@eurprd09.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1102a4-5b0c-4265-d056-08de527c9062
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 08:20:08.3639 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oVroCfGKb62DxtJFxrw+lEsGdQJ66KpDIQd9nmQgFhyrcIM2WVuu6lauI4DDSaxOVdMrny7sFB2pZAeFnHKDVRBWlzYPFeBjL4Tl3BwsgWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR09MB5600
X-Mailman-Approved-At: Tue, 13 Jan 2026 09:42:06 +0100
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

DQoNCk9uIDkuIDEwLiAyNS4gMTM6NDMsIFlhbyBaaSB3cm90ZToNCj4gQ0FVVElPTjogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6ZSB0aGUg
c2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gT24gVHVlLCBB
dWcgMTksIDIwMjUgYXQgMTA6MzQ6MzlBTSArMDAwMCwgVXJvcyBTdGFqaWMgd3JvdGU6DQo+PiBG
cm9tOiBDaGFvLXlpbmcgRnUgPGNmdUBtaXBzLmNvbT4NCj4+DQo+PiBJbnRyb2R1Y2UgdGhlICdz
dGFydGhhcnRzJyBjb21tYW5kIGZvciBSSVNDLVYgdGFyZ2V0cywgd2hpY2ggcHJpbnRzDQo+PiBv
ciBleGVjdXRlcyBjb21tYW5kcyB0byBwb3dlciB1cCBhbmQgcmVzZXQgYWxsIGhhcnRzIGFuZCBq
dW1wIHRvDQo+PiAweDgwMDAwMDAwLiBUaGUgY29tbWFuZCBzdXBwb3J0cyBvcHRpb25hbCBjbHVz
dGVyL2NvcmUgY291bnQgYW5kDQo+PiBpbW1lZGlhdGUgZXhlY3V0aW9uIHZpYSB0aGUgJ2cnIGFy
Z3VtZW50Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENoYW8teWluZyBGdSA8Y2Z1QG1pcHMuY29t
Pg0KPj4gU2lnbmVkLW9mZi1ieTogVXJvcyBTdGFqaWMgPHVyb3Muc3RhamljQGh0ZWNncm91cC5j
b20+DQo+IA0KPiBJIG5vdGljZWQgaW4gT3BlblNCSSwgUDg3MDAgYWxyZWFkeSBpbXBsZW1lbnRz
IEhTTSBleHRlbnNpb25bMV0sIHdoaWNoDQo+IG1lYW5zIGl0J3MgdXN1YWxseSB1bm5lY2Vzc2Fy
eSB0byB0YWtlIGNhcmUgb2YgU01QIHN0dWZmIGluIFUtQm9vdC4gRG8NCj4geW91IHN0aWxsIHdh
bnQgdGhlIG5ldyBzdGFydGhhcnRzIGNvbW1hbmQ/DQo+IA0KPiBJbiBzdW1tYXJ5LCB0aGVyZSBh
cmUgdHdvIHBvc3NpYmxlIHNvbHV0aW9ucyB0byBzdXBwb3J0IFNNUCBmb3IgUklTQy1WDQo+IHN5
c3RlbXMgd2l0aCBVLUJvb3QgYW5kIE9wZW5TQkkgd2l0aCBtaW5pbWFsIGVmZm9ydCwgd2hlcmUg
U1BMIHJ1bnMgaW4gTQ0KPiBtb2RlIGFuZCBwcm9wZXIgVS1Cb290IHJ1bnMgaW4gUyBtb2RlLA0K
PiANCj4gMS4gUmVsZWFzZSBhbGwgdGhlIEhBUlRzIGluIFNQTCBzdGFnZS4gV2l0aCBTTVAgZW5h
YmxlZCBpbiBVLUJvb3QgU1BMLCBhDQo+ICAgICBjb3JlIGlzIHJhbmRvbWx5IHBpY2tlZCB0byBy
dW4gdGhlIG1haW4gcGFydCBvZiBVLUJvb3QgU1BMLCBhbmQgdGhlDQo+ICAgICBvdGhlcnMgc2lt
cGx5IHNwaW4gYW5kIHdhaXQuDQo+IA0KPiAgICAgV2hlbiBhbGwgdGhlIGluaXRpYWxpemF0aW9u
IGFuZCBsb2FkIGFyZSBmaW5pc2hlZCwgYW4gSVBJIG1lc3NhZ2UgaXMNCj4gICAgIHNlbnQgdG8g
ZWFjaCBzcGlubmluZyBIQVJULCByZWxlYXNpbmcgdGhlbSB0byB0aGUgbmV4dC1sZXZlbA0KPiAg
ICAgZmlybXdhcmUncyBlbnRyeSAoT3BlblNCSSBoZXJlKSwgc2VlIHNtcF9jYWxsX2Z1bmN0aW9u
IGNhbGxlZCBpbg0KPiAgICAgc3BsX29wZW5zYmkuYy4NCj4gDQo+ICAgICBUaGlzIGlzIHVzdWFs
bHkgbW9yZSBhcHByb3ByaWF0ZSB3aGVuIHlvdXIgcGxhdGZvcm0gcmVsZWFzZXMgYWxsDQo+ICAg
ICBIQVJUcyB3aGVuIHBvd2VyZWQgdXAsIGluIHdoaWNoIGNhc2UgeW91IGNvdWxkIG9taXQgdGhl
IGNvZGUgb2YNCj4gICAgIHJlbGVhc2luZyBhbGwgSEFSVHMgdG8gVS1Cb290IFNQTC4gVGhpcyBy
ZXF1aXJlcyBhIHByb3Blcg0KPiAgICAgaW1wbGVtZW50YXRpb24gb2YgSVBJLCBhbmQgcHJvcGVy
IGRlc2NyaXB0aW9uIG9mIGFsbCBIQVJUcyBpbg0KPiAgICAgZGV2aWNldHJlZS4NCj4gDQo+IDIu
IEltcGxlbWVudCBTTVAgYnJpbmctdXAgY29kZSB0b3RhbGx5IGluIE9wZW5TQkkuIFUtQm9vdCBp
dHNlbGYgaXMNCj4gICAgIGV4cGVjdGVkIHRvIHJ1biBpbiBzaW5nbGUgdGhyZWFkLCBzbyBpdCdz
IHVubmVjZXNzYXJ5IHRvIGJyaW5nIHVwIGFueQ0KPiAgICAgY29yZXMgaW4gVS1Cb290Lg0KPiAN
Cj4gICAgIFJJU0MtViBTQkkgZGVmaW5lcyBhIEhBUlQtU3RhdGUtTWFuYWdlbWVudCBleHRlbnNp
b24gKEhTTSkuIFlvdSBjb3VsZA0KPiAgICAgaW1wbGVtZW50IEhBUlQgYnJpbmctdXAgY29kZSBp
biBPcGVuU0JJLCBhbmQgZXhwZWN0aW5nIGtlcm5lbCAobWF5YmUNCj4gICAgIExpbnV4KSBicmlu
Z3MgdXAgdGhlIHJlc3QgSEFSVHMgdGhyb3VnaCB0aGUgZXh0ZW5zaW9uLg0KPiANCj4gTG9va2lu
ZyB0aHJvdWdoIHRoZSBzdGFydGhhcnRzIGNvbW1hbmQsIFA4NzAwIGRvZXMgcmVxdWlyZSBtYW51
YWwgc3RlcHMNCj4gdG8gcmVsZWFzZSBub24tYm9vdCBjb3Jlcywgd2hpY2ggbWFrZXMgb3B0aW9u
IDEgbGVzcyBhcHByb3ByaWF0ZSBzaW5jZQ0KPiBpdCBpbnRyb2R1Y2VzIG1vcmUgcGxhdGZvcm0t
c3BlY2lmaWMgY29kZSB0byBVLUJvb3QsIHdoaWxlIGl0IGhhcyBiZWVuDQo+IGFscmVhZHkgaW1w
bGVtZW50ZWQgaW4gT3BlblNCSSwgYmVjb21pbmcgc29tZSBkdXBsaWNhdGVkIGNvZGUuDQo+IA0K
PiBJIHN1Z2dlc3QgbW92aW5nIHRvIEhTTSBleHRlbnNpb24gZW50aXJlbHkgYW5kIGF2b2lkaW5n
IGludHJvZHVjaW5nIGFueQ0KPiBTTVAgY29kZSBpbiBVLUJvb3QgZm9yIHlvdXIgcG9ydC4gT3Is
IGlmIHlvdSBzdGlsbCBwcmVmZXIgdG8gaW1wbGVtZW50DQo+IGl0IGluIFUtQm9vdCwgcGxlYXNl
IHJlLXVzZSB0aGUgZXhpc3RpbmcgZnJhbWV3b3JrIG9mIGJyaW5nIHVwIEhBUlRzDQo+IChzbXBf
Y2FsbF9mdW5jdGlvbiwgcHJvcGVyIElQSSwgZXRjLikuIFRoaXMgY291bGQgZGVmaW5pdGVseSBo
ZWxwcw0KPiBjb2RlIHJldmlldyBhbmQgZnV0dXJlIG1haW50ZW5hbmNlLg0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiBZYW8gWmkNCj4gDQo+IFsxXTogaHR0cHM6Ly9naXRodWIuY29tL3Jpc2N2LXNv
ZnR3YXJlLXNyYy9vcGVuc2JpL2NvbW1pdC82NmFiOTY1ZTU0MDE3MjkyZDUzMDAzM2ZmYWFlMTI3
Mzg5YzQ1NDU4DQoNCkhpIFlhbyBaaSwNCg0KVGhhbmsgeW91IGZvciB0aGUgZGV0YWlsZWQgZXhw
bGFuYXRpb24gYW5kIHRoZSByZWZlcmVuY2UhIFRoZSBzdGFydGhhcnRzIA0KY29tbWFuZCB3YXMg
cmVtb3ZlZCBpbiB2NSBhbmQgc2Vjb25kYXJ5IGhhcnRzIGJyaW5nLXVwIHdpbGwgYmUgaGFuZGxl
ZCANCmJ5IE9wZW5TQkkuDQoNCkJlc3QgcmVnYXJkcywNClVyb3MNCg==
