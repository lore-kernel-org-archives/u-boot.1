Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15341CCF9F8
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91E3483D00;
	Fri,  7 Nov 2025 11:23:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="EK5Bw8bc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9352983CA4; Fri,  7 Nov 2025 08:43:33 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8D3383B85
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 08:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=hans.gfirtner@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7kBNVhxvJ4jPWmil/0wEVJUOVyVTwT1lfYW7ocSlKNtrmhkbkKx+Uuer0xBUAOf0bWYrNY2L81p9kJOTgo3LZESYiaH1LQKYzWpYbn5QvNUz59p1k6p4PxoN0WmiF33zUnqEkL1dDgxUYB6YzyOvIq24QKMW4Z3GDyA3weSEcIOflzKL/M9YdhjBd+dq0DfnCABR9BhrxvXYBtfYtXGWpo2NJncZOSiS+WugqTTz3HPOv+pmHjEBJv78EUCfmkbX1aDk19OCPUONUEVbQ3snGDweyr5Yv06DjFCBuv2HoZ5dF8u4QhXIT6kob5q+o8+1tr61LcgGgtytcn5TzJZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laibpGWrBxT4uel7huJdG6A2Q07heG7P05W59CaKfHA=;
 b=PTdmThE2kjll8JMJvDMrVw4WLm5EYeX2sjKNKjXthQyt1vpBsQCKMbz0v6DPJJ380vG9oiqvJkkVJuEft60lLZ+2qjKNysQkoenLNYixa+ehkqol5t2sYLyG8+k0yTfiUGkxJWvkH4ldvlO+apr0d3/WhCOmDJrQsgnbJ9N2KpxnckR0UjimYvs5Db9c18zHIrxmGmR9jcnFge0b8wgj8VCfF4OF1i4dgWIcHK6xLEjNeaHl35U3ak85JAZ+Nhwy1wdb3JlvOFe2BuA7NyYIc2gc+490tUeaoSrf6w6o+b/6U9P15UkrWo51RNHBArHToc2a0iWitJs4mV9ha7V4pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laibpGWrBxT4uel7huJdG6A2Q07heG7P05W59CaKfHA=;
 b=EK5Bw8bcBetlz7MK712Rn1qu/wB+ujEOtbW24XJ2Ti9+pSxSbb8X6xmNNLfWKeHNUJsZZsjOSJKQzxhvY1pwqx9YWTDucY6SpSSMafaFJpOHR/JbNNdrFCDi1rl7kKRsZr0+cccGc3Z+tSqugGmAqlvGVRzpIEnhPRJvwc/nKn398TxHPjqei3l/0b5nWWjyArnD3L5SadYtsChhl5Gxu/y169+GhhcVT5sBKBfUaHyMsygpC8nm1GIA6uvKyJ1pY/iR4cwEbXDzY59ULWlgDv0/yX3t47pKACz+5bboVKwCfYSxdAmCU7m9nAgXVBIawEelhcbyGFdRX1qw1J/irQ==
Received: from AS5PR07MB9799.eurprd07.prod.outlook.com (2603:10a6:20b:651::16)
 by VI1PR07MB10017.eurprd07.prod.outlook.com (2603:10a6:800:1e0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.10; Fri, 7 Nov
 2025 07:43:27 +0000
Received: from AS5PR07MB9799.eurprd07.prod.outlook.com
 ([fe80::7360:123a:2446:5a3b]) by AS5PR07MB9799.eurprd07.prod.outlook.com
 ([fe80::7360:123a:2446:5a3b%4]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 07:43:27 +0000
From: "Hans Gfirtner (Nokia)" <hans.gfirtner@nokia.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: RE: [PATCH] tools: key2dtsi: Write out modulus and r-squared with the
 correct length
Thread-Topic: [PATCH] tools: key2dtsi: Write out modulus and r-squared with
 the correct length
Thread-Index: AQHcSkmvLRQerG+QA0Sk5iquSp9k4bTl6PEAgAD2tnA=
Date: Fri, 7 Nov 2025 07:43:27 +0000
Message-ID: <AS5PR07MB9799DFDE39B354BCBE7C6479FAC3A@AS5PR07MB9799.eurprd07.prod.outlook.com>
References: <f7068c43-db26-434a-b039-9a70e210e395@siemens.com>
 <176244838889.3056677.199439804412593821.b4-ty@konsulko.com>
In-Reply-To: <176244838889.3056677.199439804412593821.b4-ty@konsulko.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR07MB9799:EE_|VI1PR07MB10017:EE_
x-ms-office365-filtering-correlation-id: a7f9e244-73ef-4734-f534-08de1dd156e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eW9YZUI5cHFxRnA1NFJtQTBaVzNVZFZjWUdWTnMzKzNNWlBHVkFMZWNLcE5Z?=
 =?utf-8?B?QTVoYXlDU1BWTUppRFFPcldCLzV4S2cwUVVYaTIxVG8rV2JnRmo1ZWJKYjZs?=
 =?utf-8?B?Q2VMdTBHd2JYK1h4RGZTK1dSSHdjdGJESmRCdTVNS2xWdUZZSy9sRG9TVVNH?=
 =?utf-8?B?R1oySExWcGhQeHA3WHlOVk8rK1lTUUtJaWhIMGFsWHM1VnpLYStvUUlWK3pk?=
 =?utf-8?B?Q09HYVlXYXYrTFFFK2hFUXNjcWcyaVRHRERpYmF3U2lZMmVRbU42ZTdydm5G?=
 =?utf-8?B?UzhEaUpLSnhnVXdyaU9KdXFudkZBWjYvVzlRRi82WXFFSXNJc1d4VHE4d2FU?=
 =?utf-8?B?RFVpOXo4Z0hyNFlHY2FZWXBhdTQvbnNHeDYzTW9HUXZvbHcxajZlSmhTVGc5?=
 =?utf-8?B?YktnNzg2azZndWtURkNleU5td1NVNFRsRWIvbWVic2lNM3I3Z2FocTZzNzM2?=
 =?utf-8?B?ZzZEQm5lazQ3TGF2RkVMQWltYWw5K1p0MlB4dlRqbjg2UzdMYXhIdktKZFRx?=
 =?utf-8?B?WEVwYVd6OCszSnJjcmJCUEtMVno5TTRyQU9WTVc2OVQyRnZXRVllQi8wWW55?=
 =?utf-8?B?c0FVcWprWXZUeEY5aWs1bDkwS2ZYcUY1MDJUUlZUejFaUTdXWjcvVVhQUVYz?=
 =?utf-8?B?ZG9OOFRlOWVYaGtSY2VHNXdlRU1qTnlrR1ZQK2N0ejJHT1psUkR4YUdSQm0y?=
 =?utf-8?B?M3JlNExSL3VYTVVPY1lZTGh4ZlFPRlMrZStvTDNmbGZWRU5zVklLUUwxUS96?=
 =?utf-8?B?aG5hQUhEcC96aUFIYmplOFdxRGJQaXBQeUQ3dm9tSFZFcWlQVXdQanJLSHdU?=
 =?utf-8?B?czNYeGRMRkE0U0xWTy9YSjB5TVN5WXpzcnY4dXVKU21NZVlWUGJwTitxVkY3?=
 =?utf-8?B?VEg3S00xSkRJTVBHYWUvN3ZXcWxDeUN6bWZyTmJ0cjlHQWFWUjVtUHd6Sk0r?=
 =?utf-8?B?RW1ydWU2L1R4VTBOOUs3V0hYb3U1UzhIRmtaWXNnckVyVEl0VXR3Qi9GNndJ?=
 =?utf-8?B?dDQzVlpoWmhEdHc1V0pXSGs0OGI0N2oxNEh5SVlody9mZTRITVkwdnhmdTRL?=
 =?utf-8?B?ZnFUY0xiUHRaVEs2b1UwOWg4M3YyY1hGbm5WeFE0MjRzRVJaUHV0VU5OamZi?=
 =?utf-8?B?cC9kV0xWMWRhTWhwZGlmZ29VTC9WbHE5NmJSbDhnK2VuZGdmOVBGb3dta2NC?=
 =?utf-8?B?MENaKzlVTnFUaE0ydGhvMUlndTFDczN1VC9mYUVTdVFTdi9qZEtEL2I0UjR1?=
 =?utf-8?B?QVlGdi9jSTdtRTh2Ui9Td3JxbHY4YWNHTjhjUmVKZzA4N01YTGFHeHZ1YU83?=
 =?utf-8?B?UEZ6bk9td2FIQ2lNeDhrc2wzV2NMWmhKVkhlcDByMDJCcjZMOGJkTjNFTGtv?=
 =?utf-8?B?Wk95THpKU2lWdEkxc0ViUTVvY1RIZUxwYXAyY09rV2Z5T3JKcS9RblVKeUpm?=
 =?utf-8?B?TnJlZ3c2N1J0azk4YTlJaDk0eUM0Q25LUGJmMGdrOVJmazNWZ09BZi9Rb1Zz?=
 =?utf-8?B?elpNT0NSNXNtT1JIeGx3ak10U1ZLU3lDSERJWmhRMmxPS2FWQUdlNFFubk5p?=
 =?utf-8?B?RkluKzNKdEs1TXFxb3pZM1BhQ0dWVzcybS90RkpGcEZvRjZyay9MTlZrRWhE?=
 =?utf-8?B?S3psNTNzYmVrakVpNTc5Ri9xVDVjM2w5WEJvUUIwQVBTNDcycDBWenJVZTVF?=
 =?utf-8?B?WlhKRU5TeEZKVGp2eHVzYlVRRjgxdGMyRWtKRzdlQjk4N2NXUlYybmN1VGVH?=
 =?utf-8?B?Rmx6dklMcWx6SE1KaWx4ZlJZUk9hcU5KK0VXbEVTdFFBMmhsT21UbjErdzM1?=
 =?utf-8?B?bHA4TWp1eEtpcEJPVlR4RHRsc3RlNnF4NTdqV052MXJWeE9Sb2d4dXhIQ2Y3?=
 =?utf-8?B?ekFLejhPcFJ5Q0RMcm1NMW9pYzBZdndxb0diVW42U3VybFA2d2dBaDFpNGY0?=
 =?utf-8?B?RlNLYlZRR0F1Y1Z4UFN6MVFRTmU4YWN4Rmc0RGl1YjZ6R0F4ckQ0dWRGRmkv?=
 =?utf-8?B?ME9UV3VVQk05SXBmWmliRURPYjFqQVM4RHdYTzhtYjlJbWIwWWZjZEdCR0tZ?=
 =?utf-8?Q?tEEiXd?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR07MB9799.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0Y2TU1uaE1pNjFwYi9VODcvcmt0OGZJcHo4TENpNFF3K3hoWlpyMzk4R2xn?=
 =?utf-8?B?WWM4cGVDSlFOdkZzU1Y3UGlyT0FrTWlTR3BtbUpDeEZVaGtNN1BVTWlHaEtF?=
 =?utf-8?B?U1c2d3JXSW9naCsxdU4wUzBjeERaaWxPU0t2TVJVdlg1TkFabFAyV0RZM2NZ?=
 =?utf-8?B?b2tzdG5vZXFjc0hXdzU4cVdiRG0reHhmaFc0RWVNSW9Ca2Z5WTVLNk1oZEc1?=
 =?utf-8?B?aDVRMmZiSUV1Rm9RVUQ2NktCODFLVTFBYThreEI3bmRHbUpZM2lsL2h4VGxR?=
 =?utf-8?B?RXc3bXlqdGE1Rm03VkJIeFZJTWtyZWg5ZlkwZlQwbzJKc2tNWkFja2tORTNP?=
 =?utf-8?B?WnBTZFNSYVhWT2pVQ0llUVhSUFg2b2xUK1QyNXdzRm1ldXNLb2ViU285M1FH?=
 =?utf-8?B?Q2VVU2lDbW5oNEJLT2tFelRrM3p4bXE1M1Q4R2JpdXlzck1kUm9MK2hrMVd2?=
 =?utf-8?B?YXhRdXErK3NNVzRlMkduVitoa3VsQzNZWjNzazk1a05kVjJHbUd3ZDI1ZmFw?=
 =?utf-8?B?TjZPS09LZXIyY1krTTZOa1MxRkRtNDhaMzVQcUZtS0R3MVZ5QkV1a1czanl6?=
 =?utf-8?B?QTllck1nSDZjRzdmUlMwYzg0VDQ2MVlWVEF5SWxWSWE1V1FBM1pMV0RUNExa?=
 =?utf-8?B?aFBNNTVQRmw4QWgyZUM1SFM1bmx6Tzl0Nms5TUJxWGdldHJDZ1hjR2xYOTM3?=
 =?utf-8?B?ZVc5U1hJcXg4V2VZTnlQcFcvWTF6azVpWksvTHUzSy9wZmo5WE81cGZuUUU0?=
 =?utf-8?B?amtsTmZ0bGx3Wndid1cxUzJnTnJEMFJ4K1FaRlZKSDJnaTBUZytFOWo4S2x3?=
 =?utf-8?B?cmJhUDJPM1dHbVJVMWVSUnl4M1l1V2ZtT0ZyeEU2cjIyVnJCTkg0L2gyNEdj?=
 =?utf-8?B?dUxwbjRROSsySncvUEtacUVQRHdsMnc3L09ud3ovNEluRHNPd1RHclRrUzRv?=
 =?utf-8?B?RlZkN3lkZytpZ1pjNXRXS2dJZWF2MmVWM2dzblUyMXhaWUJNNXNLei82bDMw?=
 =?utf-8?B?THhBS2VJVzdoZ3dtMXZDcGxOUXdWeHJPakxsbHl0UWRqRXNwb0RmYVNCaE1U?=
 =?utf-8?B?c25VYmpCSGRoMG5PWlpXQTZSOFpZK0p4ZUdUR0ZNT3NZSjYxVCtMMXlURzUy?=
 =?utf-8?B?QjF6QXQ5bnhCbzdSeFRjVW5EbTh4SXVqODJQTjlYYnJmYUpiMnBDeDhvUzds?=
 =?utf-8?B?dER3NkM3WjdSRTFFdVc1SnZzWEk4MEN3ZDIva1BpZE04NzlsSXJOUHc5czc3?=
 =?utf-8?B?RGdBSTluK3RzSTBJNHZ6QW45Rk1DNWZ4NjZaYys2WFEwMEVxVE42UFJLY2ph?=
 =?utf-8?B?UURDRFhINnV5bnFLSzhReEdVTE9JZVRkQ2N2TEl4TjRPYWRvSlFjQ2tCdGpk?=
 =?utf-8?B?WlQ2anJyMENLd1NYZ0kvalBRYk5SNzlQZVk2R2h6RFN0c25kU1NyVGthZzhJ?=
 =?utf-8?B?cmlHRVhjU3RtajNGZXE1dFNFRitHYlBkNks1RDhBL0R3L0E3YjFMMzhFbHph?=
 =?utf-8?B?MHl6UW1oZXluQ0RFRHZreitYSUtDdDVuK1lzQk9MODVaQ1p5UlNuaGFPUGZx?=
 =?utf-8?B?OVZSbU12M3lHQ1FvU2FIeVRjeG4wd2RBT3YwZmJRQWR0eXpHVlhoT0RMWHdu?=
 =?utf-8?B?blMvcWJpRHVNbnN3MVNubXdmNnJ6a2ZvVGxPZjVicTdKNUhFRTVTaDVsVTZk?=
 =?utf-8?B?azF2d0FOZC9TV2tGMEVVdXN6MEhEZWtTT2gzVXV6cTF6cDdZOUpnUU1JS1RF?=
 =?utf-8?B?WEdWUFBlUzR6UE4xWnNaMGo5NHlhQllHTUdTMy9jK2JLVkZBOXBVSDh0NU9Q?=
 =?utf-8?B?dGhwV3BZNmNoTGFRK0J6V0hpT29XMEpkL0Z1S0d0YzdkYkNVNUt5L2o4cERz?=
 =?utf-8?B?RUE0UzB0alQ0SVkwVFM3WlV1ajZTOVNncUFycnlaaGZKVXpVa29tdExCamR3?=
 =?utf-8?B?ZCtvZkc4MUNTMGd1Tmh1SnlaSkZHRGtNZzVWZnFpMnJpcTY5QlFyQXluOTU5?=
 =?utf-8?B?Y2d6Zk1odlVUSHFndFYwTmdqS3dUZnNyNDFoZnp4U0JRVjJ2WG1vMTF0K212?=
 =?utf-8?B?UHZCNFRCM3lSc2pMVS9XMXdoMDViVmplSVFrRzRuYTM0TE9Kb2NtWjFtbXE0?=
 =?utf-8?Q?0Cy5FP/hARS9gRiX38cOVffsW?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR07MB9799.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f9e244-73ef-4734-f534-08de1dd156e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 07:43:27.6163 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fndrEUFlkvtjLxYrZhv3uo35e89WJdFpM5RY+twImmYkWf0sqc7k/ISfAgzKFVC+Fw6HpJK4Jpb3C0F99GGX8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10017
X-Mailman-Approved-At: Fri, 07 Nov 2025 11:22:57 +0100
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

VGhhbmsgeW91IQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT4gDQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNiwgMjAyNSA2
OjAwIFBNDQpUbzogVS1Cb290IE1haWxpbmcgTGlzdCA8dS1ib290QGxpc3RzLmRlbnguZGU+OyBI
YW5zIEdmaXJ0bmVyIChOb2tpYSkgPGhhbnMuZ2ZpcnRuZXJAbm9raWEuY29tPjsgSmFuIEtpc3pr
YSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIHRvb2xzOiBr
ZXkyZHRzaTogV3JpdGUgb3V0IG1vZHVsdXMgYW5kIHItc3F1YXJlZCB3aXRoIHRoZSBjb3JyZWN0
IGxlbmd0aA0KDQoNCkNBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBi
ZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KDQoN
Cg0KT24gRnJpLCAzMSBPY3QgMjAyNSAxMDozNToxNiArMDEwMCwgSmFuIEtpc3prYSB3cm90ZToN
Cg0KPiBBbGlnbiB0aGUgaW1wbGVtZW50YXRpb24gdG8gcnNhX2FkZF92ZXJpZnlfZGF0YSgpIGJ5
IHdyaXRpbmcgdGhlIA0KPiBtb2R1bHVzIGFuZCByLXNxdWFyZWQgcHJvcGVydGllcyB3aXRoIHRo
ZSBzYW1lIGxlbmd0aCBhcyB0aGUga2V5IA0KPiBpdHNlbGYuIFRoaXMgZml4ZXMgc2lnbmF0dXJl
IHZlcmlmaWNhdGlvbiBpc3N1ZXMgd2hlbiBvbmUgb2YgdGhlIA0KPiBwYXJhbWV0ZXJzIGhhcyBs
ZWFkaW5nIHplcm9zLg0KPg0KPg0KDQpBcHBsaWVkIHRvIHUtYm9vdC9tYXN0ZXIsIHRoYW5rcyEN
Cg0KWzEvMV0gdG9vbHM6IGtleTJkdHNpOiBXcml0ZSBvdXQgbW9kdWx1cyBhbmQgci1zcXVhcmVk
IHdpdGggdGhlIGNvcnJlY3QgbGVuZ3RoDQogICAgICBjb21taXQ6IDc3OTA1YzMzM2U0ZmExMDkz
MTU0OTg0Y2M2NTU3NWI1Y2I3Y2M5N2QNCi0tDQpUb20NCg0KDQo=
