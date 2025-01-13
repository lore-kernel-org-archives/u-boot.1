Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABB7E7719F
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 13:31:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68FB0801CF;
	Mon, 13 Jan 2025 14:31:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="axJU0Bul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C96805DA; Mon, 13 Jan 2025 14:31:46 +0100 (CET)
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C94D80141
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 14:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=biju.das.jz@bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2H6ezMD5spwi8q9XEJ5oiFHVysSGhf9wBoAshrTBk8wkDi0AQJP1OGcLNdZD8wGws3nyf9IiX/R6YV5DiqkzbhODdoTKHxJU4xpkzCRLnkCiG5hIUxGUqC7zIoLEa351GAF043awQc6PxenAFxxMRZ5FWltL1i6j6ZcEdn75OL1WfmqqaAdEnHiJ4lb4dEk0YsNgf6BP4UB7BbgFMLpkCYLgvWOvCEl0cCv/KsUeWASPeVedpBHA/zhY/+1PccjHkqUjPshlmLgqxfjBPdK8/fj+GyYFzl91YaxyB8SEJ4hRnps3za1Slild/valwXYDqKpVVqFJ7kKQ2tj9nkhgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4UwRXJRT3iMu90YwbEB6kxRERqHFIHc+tFLHoyIXoA=;
 b=c1EC2MInfMAaqAZon0RhOSfzCaI3GZ0eQ0bmc7pfSgcuF2DbFNmAO1jGeE24fXJw8fiuJ/NEcVYcTmnXkmXj8IdKMp7cFhX70Xb/qwaJ7o1ve2KXWXfU/fGE3LXthOeDYUe9xRga6nBOEC7T5JppYLlHyN7moWCTdUWsaxyKaBDw0gHFjpFMDzA7p9fXHHwY5eIwhYYfQt8/tshQ/z6umJ4gp8fZo1eRu1ejoIngvmHM49myVZLYTMzda7cuAIqa44oVeDbZfaUWpmkA52Cuhma8XWjBIteenrjmEm4hYfXxhBv32LEON70bSuWhsCkWf+A/r3+oQIbzOtliDjQBYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4UwRXJRT3iMu90YwbEB6kxRERqHFIHc+tFLHoyIXoA=;
 b=axJU0BulfxRH+ImMiK0h0T2sPHtFPsG60WqSSj+UJKezb3J2zYKmlAalqUGRRdSPFn05Q8cFDVTfc3yjslK4/abOIr09xL4Yqf05Ir6VtN9LhhebDkdFft64O3AejbvFtF8nrwbv51cQbnABlcqxg1IEwQeXCq6SwctiBYiVuDU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13153.jpnprd01.prod.outlook.com (2603:1096:405:16a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 13:31:33 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 13:31:33 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Andre Przywara <andre.przywara@arm.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Julien Masson
 <jmasson@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>, Sam Protsenko
 <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: RE: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Thread-Topic: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
Thread-Index: AQHbZUK9XZFiTRN8BESZIPlrQZlnMLMUni6QgAAHtwCAAA3twA==
Date: Mon, 13 Jan 2025 13:31:32 +0000
Message-ID: <TY3PR01MB1134659D36AECF2B84B772B05861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <TY3PR01MB113468B93D55B10C9D38ABFAE861F2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <4dddca99-dcc2-411e-af9a-b27115e60efa@mailbox.org>
In-Reply-To: <4dddca99-dcc2-411e-af9a-b27115e60efa@mailbox.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13153:EE_
x-ms-office365-filtering-correlation-id: 46ef1a47-05e8-409f-b46a-08dd33d6986f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?clVqRkY5NlhURGc3dU8vNi9Rc2lzUUtncldoSzZJa3gzYUZ4M2l2amhxYWNp?=
 =?utf-8?B?d2RzZWFucHZBNFE4ZDUybCsrK04zQkpkRkFqUUR2QkN0K2NDcUQ1S3JXSEpK?=
 =?utf-8?B?QUY1OXJDTC9IcXhTUjk2MFl0SnZ0Rm5EM1h3Tm1Da1VrVFltVzhLbFdNREhO?=
 =?utf-8?B?L2djeHBUNEJxVm9VUmx6aTRYTUp1dXVZMDFiOGV0RlFRV00rc1hLN3V3bkk1?=
 =?utf-8?B?eENidGVnMlBGQVNybGg1RktuakQwTlZtQlZVT1VQc2ZlZll0VWU0Yjh0ZEVh?=
 =?utf-8?B?Sjhaa3JzN0hXYVhWK283c1BteHBvV3B6WlhQVWFsamxoYmt5a2xrU05jYzNz?=
 =?utf-8?B?VEVGWEozQlNUYXB2Y2Y5bHNyRlBOSjd5M3JRY2NPelk3NkJ5bUppUkhuOWw0?=
 =?utf-8?B?VHU3bENJQVRXd0p0bVcrWCswbGFiYVl4ODc2SFFMOFl0SFc2b3BlUk9WV3Uy?=
 =?utf-8?B?VmRPMXFVVy91QnhTUzJST3BGRGRFTFFWSGNEWCtVYzBueXI1WlcvRG1jeDFE?=
 =?utf-8?B?U2s4U0l2L29manNNZ1hEYjdCMGN0cGllejQ4eHpibTFEcnBudGxEaUViMzM1?=
 =?utf-8?B?eWZkR0tjZVFNdUJVT1dzWGt4ZDlKSTZaZGJwMDBYeVgyNk1FTlMvTVlIcHFM?=
 =?utf-8?B?aENlTDZrc2xZMmVydjU5VmdSQWxpbWh2YWUvazl2ZTNvSzZMeVdob2YyTXVZ?=
 =?utf-8?B?VVRGSWYvMWdHYmRpMHVHWjAwR3JIV25Ka3ppNnM2UndGVDlpNTVaa2M3RXdB?=
 =?utf-8?B?UUJQL2pDaG5mSURNaHNWOGpTanpOcnBtSHcrbExnQlpoUm00OXpZeCt5ek9Z?=
 =?utf-8?B?TnlGcEh4NGdEMS9LWUx3TTRRdTB4cCtHUCtHdEhNLzhBTEFHRkNOcXhrY3N3?=
 =?utf-8?B?WlQ4K0hyTlF4NmZVMFBXUTh6MWNKQk91NHUxOTBWYUdndFZUVGFNSnE0UkN3?=
 =?utf-8?B?TWFseDhUM0kwdU9JTllsZytaaEN2ckFSeWcyaVBjTWdtblEwcE5kZDFQc3B5?=
 =?utf-8?B?WllzVkE1QVNJV2t1Tm9nc250clBhYkpVZU9ZMnJmNlpNS0prd1VFZ2RmTUpp?=
 =?utf-8?B?V3B6VVB6Y05xckYxbkJla3hsSis5RnB5Wi9tcXl0c1F0MWRPbitrR2RKbjgz?=
 =?utf-8?B?eFBaTGYwZnRnM1oydjJpc1JXejBtUU9NT25iK3F6cURlOWF5cmFUZ2E4a0Ra?=
 =?utf-8?B?bzJBSUUrZHhJSElwZ29FTVZMZTAwMWVqYnZNMy9EMjU3WEpnQ2FVeXRVTFl2?=
 =?utf-8?B?VVlFRGlqZjZOS2U3V0N2MlRRRUNSWVFDSzJYMTZoL3ArakRNajZYajRRUms0?=
 =?utf-8?B?ZlRJcjBGYjF2aFJpajN0eWFKZGVoZSt2NEZlVTdsdVQ5czBjbnhXNDNJL3lu?=
 =?utf-8?B?bDN0WTJCTHp2UHFUZENBTU9hK096MzJYWVNVbGhEdDNvWk0xT2gyQmlRa3B2?=
 =?utf-8?B?UWEybmhUN0w4YlJ4QU9YOXhBTzVaQmdXSElPU3grd1FJQUt4UFE5VnFoeUty?=
 =?utf-8?B?c2hrUmZUekNrOXB1b2RyR1lMcTdlNmp2RUJ2TXIrVkhSZURyZlRuSWdGZXYz?=
 =?utf-8?B?WWkzTUxrZTFSS2J2dFBqenY4VjBtcEFWMnc0M2x2TGVZOWxJYVhlNG9zNnFI?=
 =?utf-8?B?N1l2YXBzazRkOXBsZDBPeXhQRU9pK3RyWlhMU3pWeGlROEdibENGRFYxOUZs?=
 =?utf-8?B?dHJFUUpyY3R3dVovSVljdzVyTDg5dXNwVUE5RVRQay9vS1V5UHJ4NGkzRC94?=
 =?utf-8?B?QTNVeEZOVmphN2d3cENwYVJ3WjVHdVMvaXpESXdEMk9kRHRDbmZyOFdJdkk1?=
 =?utf-8?B?NDRkeHdwajFzTTNoZmJibXlQbHZrZkNqTnQ2V2EreDNOcTRLckFHRzVWNGdl?=
 =?utf-8?B?MDlBaGhqRSt0OW5xY0E0S0JBYzlVYXN6Z2pOS1FPNFVZTzljNUhaRyt3cjhp?=
 =?utf-8?Q?eMl7Yxr4PDsoebTQEvf9SQ6xYjhO6Aez?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY3PR01MB11346.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tyt6bitpdUdXUDVsSkc3U2FmWFBCRTdFYmpJeHBlYnl6YVhVN1pOeHI0SVo2?=
 =?utf-8?B?dlNBRmVXV05UT0xEY1c4Q3VpV0R1dXh2R0hTcStWS0xFN25yaGhxdGVnQmEy?=
 =?utf-8?B?V0R6SGgxdlAvZmlXN1RZMDlvMzQwMHBxL20rMy9Yc2NBRmxiM3UwTC81Tmly?=
 =?utf-8?B?Z21jZmlWb3BESlJVZWtaazNOa0Fha2d0WlMxTlFVVlV5dGY2cG4xZlc4QkJw?=
 =?utf-8?B?cnlPV2pDeUVxdGYzdlp4RHlpTmdIc2RHY0RqazR6OW5zTk1iM0pWR3QwNFVq?=
 =?utf-8?B?emtoL2Ria240MEovNDIxSG5aanBrV0hTaURvdmJlNWJmb2d2MmpWNUFGWUdx?=
 =?utf-8?B?LzVzRVB2SjdDeWlIUGlMbUpxV1MzWjUranpndUVtNlJ2dFNudm5kdGozY2dY?=
 =?utf-8?B?em0zd0d5dU1nQzMrcWVtUjFDODVGNnNXRm5GODhhVnNnSS85cGJsV1RZaUhu?=
 =?utf-8?B?TUJTYmZya25RWVppVFpSUC9MdGhCVWlYQ1RwcDZaYlZPVHlyczVseDQxT0gv?=
 =?utf-8?B?VGZ5SFlkaHhkSDRtbzN6UklpZlZjWk16ZitZa2UxckdPNEFITjREOXMrTy9V?=
 =?utf-8?B?VmN3dDRZbUFaUlBTOGtPdjdybm9MdXFUaWpaWmdZUDdoZjZDTEhiYi9UajNX?=
 =?utf-8?B?NUE3UGExMTFUZ0dMVk1DNWViakpzRk93Um9oWXlYZUloYlZlaDdOVmRPYStO?=
 =?utf-8?B?K29jU3dZMk1NVWNSR3NCSHRxM2wxZUNSaWNSLzNnN0VnRldYUGhubkVlczFx?=
 =?utf-8?B?VFhDWDRaVHJ5VXRVQmkvMjJuTi9yWXhpR1laLzVnVHpTSW5TckNiYkZvU1l5?=
 =?utf-8?B?M3NDTTBkQmJ4OGptclo1L0dVR2NJaEdkelZVTzRXSHQydFRZc3NqYVVWMC9n?=
 =?utf-8?B?Yjl1WWo5dCtPNEluMTJEREtHVlhRdGdUUG9zK1BWak1kUmFoQXFuUmk1bUt1?=
 =?utf-8?B?TXpmSDVhTnpvbko0UUgxM2paTkNUTXVYb290Nmw5c3lxNWlTcENJcUxJNTVX?=
 =?utf-8?B?Q2RwM1o3M1VENTZIR1hsNVRwK21zbnhEVUVFQnkveGFoRi83RjdYYzAwYTJH?=
 =?utf-8?B?aU5UdThLeHFTSngrQVdubG8zcXpud1VFbkQvV2VSWk1Jci8ySjJvLzJOTGgv?=
 =?utf-8?B?WGpTdk5UV3VYS2xnUXJnak5vQWo1MUxSSzNzTUtiNHlTdHRyaXBDdkNyWXhB?=
 =?utf-8?B?RkoxeGdCSmhua2ZjUnVXTC9CS1dWTWx1Z3I4cXluN2VvRXlpUDVQT1E0NmFi?=
 =?utf-8?B?VEx2NkVWRXVsUTFMQnd3UHBVMDk2b0pWYmxRMUNKYUVkQ3MwS0VDUzNsYzJF?=
 =?utf-8?B?bG5ZWXgrdG8vZzdwOXdIWEFWQ29aV2hXWFVmcUJQamIzMDRNUzRoN2VIbkd2?=
 =?utf-8?B?dURJWm1COHZkVkJmZGpnWldVaWNCOFFvZmxxSURkWVQvUUZEbXpaUEczdm1l?=
 =?utf-8?B?OGpOSEliQkFhcjJwMEFydGtpZ0xnWmRMWldzZGVRZVdZemNYY0pkWDEwd0lM?=
 =?utf-8?B?YXE4Qlk0Wm5haUd3Unl5aVQvNG91V3JzcWlPRnlCak8yNENSU25JUnpaNDdW?=
 =?utf-8?B?SWg5YnJ2WmVVamJnOW91SVRzOHNLOXMveU1wUm8wdmpUcUN4Sk1wWVFjWkU1?=
 =?utf-8?B?LzNlWUlrZ21SaFZhZEZpaGlLK0ttV3BYWU5aWUxQeFdSVk50d2l6SzFpeW16?=
 =?utf-8?B?UENWYk5uc1hPOVJPeHlzYnZkUXY0Z2ZoZVkxdHl0R2xIaDZhRDczMjFhaVVt?=
 =?utf-8?B?dHR4dlNmKy93TkpXbkVJTWdKMTZic2pHQ0R6ZUVsdE1tWjcyUWw0MTltUS9R?=
 =?utf-8?B?YzVtREt1enAxZUkvTXNUMHhkOTVXRkhGZ0JHS0FuejFvVVNyZ0NEYWRoVWdT?=
 =?utf-8?B?S0twekViTnlNcDl6NGNUYzNpV3NGc2txaXRGNjBTT0JNbzUxdExmMnhtVElx?=
 =?utf-8?B?YUhCOENVOUtmWVpDazhmUllNQmVpbjVTc2dkdWZZclBGY0s1a1pJTjV2SXpy?=
 =?utf-8?B?Qy9zYWFDTnZrNVlzOHBCb0NnSHA3SGRvb3FMSnJxNGFnZmUyTUQ4RTc5eVh5?=
 =?utf-8?B?emNQbkpLZ1U2QkFsMWY2SDNDaXYvQUVBMW10Nm56eThRNjNjRXRsL3VyQnFH?=
 =?utf-8?B?aFYzOHpwQ3Vrd2oxKzBnTzdvRkt6L3FiVFBYOWZNL3MyNDVSTVA2MHVNeWlj?=
 =?utf-8?B?ZFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ef1a47-05e8-409f-b46a-08dd33d6986f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 13:31:32.9759 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dah9uElXeZaheJZRQaKhqOqkleNPHLnuvLHGdalUv8/Nu5DP3EXUr5mQZTaO0IgQLLasBwhqyEujzA/qeG1SbxMq/HmdmChiIik+9z7Az9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13153
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

SGkgTWFyZXgsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsg
VmFzdXQgPG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiAxMyBKYW51YXJ5IDIwMjUg
MTI6NDANCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIGltYWdlOiBBZGQgc3VwcG9ydCBmb3Ig
c3RhcnRpbmcgVEZBIEJMMzEgYXMgZml0SW1hZ2UgbG9hZGFibGVzDQo+IA0KPiBPbiAxLzEzLzI1
IDE6MTUgUE0sIEJpanUgRGFzIHdyb3RlOg0KPiA+IEhpIE1hcmV4LA0KPiA+DQo+ID4gVGhhbmtz
IGZvciB0aGUgcGF0Y2gNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxpc3RzLmRlbnguZGU+IE9uIEJlaGFsZiBP
ZiBNYXJlayBWYXN1dA0KPiA+PiBTZW50OiAxMiBKYW51YXJ5IDIwMjUgMjI6MzcNCj4gPj4gU3Vi
amVjdDogW1BBVENIIDIvM10gaW1hZ2U6IEFkZCBzdXBwb3J0IGZvciBzdGFydGluZyBURkEgQkwz
MSBhcw0KPiA+PiBmaXRJbWFnZSBsb2FkYWJsZXMNCj4gPj4NCj4gPj4gQWRkIHN1cHBvcnQgZm9y
IHN0YXJ0aW5nIFRGQSBmcm9tIFUtQm9vdCBydW5uaW5nIGluIEVMMyBhcyBwYXJ0IG9mDQo+ID4+
IGZpdEltYWdlIGJvb3QsIHNvIHRoZSB1c2VyIGNhbiBzdGFydCBVLUJvb3QgaW4gdGhlIGhpZ2hl
c3QgcHJpdmlsZWdlDQo+ID4+IGxldmVsIG9uIHRoZSBwbGF0Zm9ybSwgYnVuZGxlIFRGQSwgTGlu
dXgsIERUIGludG8gYSBzaW5nbGUgZml0SW1hZ2UgYW5kIGJvb3Qgc3VjaCBhIGJ1bmRsZSBhcyBh
DQo+IHdob2xlLg0KPiA+Pg0KPiA+PiBUaGVyZSBhcmUgdHdvIG1haW4gYmVuZWZpdHMgb2YgdGhp
cyBhcHByb2FjaC4gRmlyc3QgaXMgdGhlIGFiaWxpdHkgdG8NCj4gPj4gcnVuIFUtQm9vdCBpbiBF
TDMsIHdoZXJlIGl0IGhhcyB1bnJlc3RyaWN0ZWQgYWNjZXNzIHRvIHRoZSBlbnRpcmUNCj4gPj4g
c3lzdGVtIGFuZCBjYW4gYWN0IGFzIGEgdXNlZnVsIGRlYnVnIHRvb2wsIGFzIGl0IHdhcyBhbHdh
eXMgaW50ZW5kZWRTZWN1cmUpDQo+ID4+IHRvIGJlIHVzZWQuIFNlY29uZCBpcyB0aGUgYWJpbGl0
eSB0byBlYXNpbHkgYW5kIHNhZmVseSB1cGRhdGUgb2YgYW55IGNvbXBvbmVudCBpbiB0aGUgZml0
SW1hZ2UsIGJlDQo+IGl0IFRGQSwgTGludXggb3IgRFQuDQo+ID4NCj4gPiBJbiB0aGlzIGNhc2Us
IHdobyB3aWxsIGRvIHN3aXRjaGluZyBmcm9tIHNlY3VyZSB3b3JsZCB0byBub3JtYWwgd29ybGQs
IHUtYm9vdD8NCj4gPiBEbyB5b3UgaGF2ZSBhbnkgbGluayB0byB0aGUgdS1ib290IHBhdGNoIGZy
b20gc2VjdXJlIHRvIG5vcm1hbCB3b3JsZA0KPiA+IHN3aXRjaGluZyB3aXRoIGtlcm5lbCBlbnRy
eSBwb2ludCBwYXNzZWQgdG8gQkwzMT8NCj4gPg0KPiA+IE90aGVyd2lzZSwga2VybmVsLCBhbHNv
IHdpbGwgYmUgZXhlY3V0aW5nIGluIHNlY3VyZSB3b3JsZCBtb2RlLg0KPiBTZWUgMy8zICwgVS1C
b290IHJ1bnMgaW4gRUwzICwgYmVmb3JlIHN0YXJ0aW5nIGtlcm5lbCBpdCBqdW1wcyBpbnRvIFRG
QQ0KPiBCTDMxICwgVEZBIEJMMzEgZG9lcyBpdHMgc2V0dXAgYW5kIHN3aXRjaGVzIGZyb20gRUwz
IHRvIEVMMiAsIFRGQSBCTDMxIHJldHVybnMgdG8gVS1Cb290DQo+IGFybXY4X3N3aXRjaF90b19l
bDIgd2hpY2ggY2hlY2tzIGlmIHRoaXMgY29kZSBpcyBydW5uaW5nIGluIEVMMiAoaXQgaXMpIGFu
ZCBkb2VzIHRoZSBsYXN0IGZldyBzdGVwcw0KPiBiZWZvcmUgc3RhcnRpbmcga2VybmVsLCBhbmQg
dGhlbiBmaW5hbGx5IGp1bXBzIHRvIHRoZSBrZXJuZWwgLg0KDQpUaGFua3MgZm9yIHRoZSBleHBs
YW5hdGlvbi4gSSBtaXNzZWQgdGhlIGRldGFpbHMgaW4gMy8zLg0KDQpCTDIoU2VjdXJlKS0+VS1i
b290KFNlY3VyZSktPkJMMzEoU2VjdXJlKS0tPlUtYm9vdChOb3JtYWwpLT5MaW51eCBLZXJuZWwo
Tm9ybWFsKQ0KDQpDaGVlcnMsDQpCaWp1DQo=
