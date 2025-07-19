Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C87EC83F34
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 12:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F1F2833FC;
	Sat, 19 Jul 2025 14:51:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nsMgn7fj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6A4683700; Sat, 19 Jul 2025 07:02:38 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 740B1836C3
 for <u-boot@lists.denx.de>; Sat, 19 Jul 2025 07:02:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kusay2RSaXacyKHgterHgFWa1lNmKR1ptqM564/b5IOstJVLua/fH9DnrBi3nYUkH/ywJHUrUKjQoZFW4dGkXGkcBfquvs18rdS5T3vPojXpDUN8/iw6aJUdYpeZ7jcz7M8SOVPb2mYmzw5lg/7tjWbO8GzdugwcF2/o5IxB1v4pPE2s4hdjd0ZS3ll4b/u5Oj2BDvBSRETFHnhR1r8rCaWw8CU7ywz3ZJPN2ORdi86YbuZUB+FT8BpDqOwTu1/CI4uXckazsOmereKwbQ18fjeiII6BmUzKbPuJhgJMDAhEqoZNn8GCHbXrFU1jn7aZZYn5L8wedSDTf9w6dIdb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SDp3jr/BD6K/PK2l9kkViHXVmof4tbq1jHO8uN3wo48=;
 b=rIKvIJntxmeOf9WvJwz7tJZ59HMIBpEnBUpOHtnDWOs0JymuvkXxvil8yQlo334U9xHsYybmqz6xvUqbVr1ssCnwzo51prnZr4XgL1fwgIrubC+wdOe8K+xY1pxMpmpeoTa8W6vFsJhBGVKX7A8V8gyqV6rHWpvYjgoJlyBNsX+GZkmefDjt+I2XBheH1TMRJE89q9eyrCDPmjhvbCXRMhC/NdCBdUX2w/DTRFsWuhKLOyXII+05P9Soc12m1l0A30wrt7JJdoCcNwN/FRMCzY9b+In2PF4BPtp6gg7RgjKj1Sun+doqeuNsUZv+XOR+/5gWKOCv4tz1mrp6SosgPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SDp3jr/BD6K/PK2l9kkViHXVmof4tbq1jHO8uN3wo48=;
 b=nsMgn7fjNgA2crOQfNjDGmY0hlGNHaFd1OjtiO4xRfXZeIrHLk5eJVAFqd2dY+kW5mIIh+ydVqCQfEiplGYwpW6FCFUgi+lZG0MhlgQ6NU1etTiHzZOFsvoP+KpvlOntyTL7cVKFcn+KaUp6aXuq79ESMeEEZieVKuic7/KLn2ccKxbEsPF3oAWCwG1mzoYQBTZH41wzA0yd6ZkLZCETfVnu+ZBgAsCihK9s9UZ5uSLBttbHFGSeOYSu4GDKUmRnN0BGVQMCATatoVZkqUlV0l3SGUIkUU2V36F4btVuL+Sa+UIv8NOvA+bMNQDJ8gbuaSlDBjoss4uAoT1g+S/xCQ==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5201.namprd03.prod.outlook.com (2603:10b6:a03:221::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Sat, 19 Jul
 2025 05:02:29 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.037; Sat, 19 Jul 2025
 05:02:27 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "hs@denx.de" <hs@denx.de>, Tom Rini <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Frank Wunderlich
 <linux@fw-web.de>, Padmarao Begari <padmarao.begari@amd.com>, Holger Brunck
 <holger.brunck@hitachi-powergrids.com>
Subject: RE: Please pull u-boot-i2c master
Thread-Topic: Please pull u-boot-i2c master
Thread-Index: AQHb9uFosvkYZdGL30u2Ob/WcJ1ijrQ3+9iAgADfWYCAAArt0A==
Date: Sat, 19 Jul 2025 05:02:27 +0000
Message-ID: <PH7PR03MB69424603B76A18A20C7C7994F753A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <06c2b16e-1e3d-7632-70be-d6df4232ff71@denx.de>
 <20250718150113.GU193579@bill-the-cat>
 <3ef949d6-9c42-0876-d5a7-a055340d52df@denx.de>
In-Reply-To: <3ef949d6-9c42-0876-d5a7-a055340d52df@denx.de>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|BY5PR03MB5201:EE_
x-ms-office365-filtering-correlation-id: 64d28860-22b4-4152-eaee-08ddc6817533
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?UE5qMldHTGZEc2tla2dZZWNRZmN0ZisyMkZrQ3hIWUt6YzlETThBYmhuWW0y?=
 =?utf-8?B?TXRxSDhYNnUwS0hvTGV1RlZTZlNCcFlwSnVaOC9LQ1F3Q0c1ZFRrRlhvbTQx?=
 =?utf-8?B?TmdNSGpUZEgwYUVINkJoRk5iZVBjUStISzJuVm1UV2xjOFVYNVA2RlRSbXZT?=
 =?utf-8?B?VzFwcWtadDZmK1ByT2Q5cVZsdUd6SjdpcXh1TmlaSG5SN0hER0lMcENmOWpa?=
 =?utf-8?B?V3Y1VFJSUHFoVS9iVldaQTYwSzByeHlUcVlONTQwVk9lemFoVTA3MHFmUmVi?=
 =?utf-8?B?RTNXUEN6aGdOblA4a3MvcGdrYk1VNzlpNFBOVVlzTmI5ZHFQTFlaODJpWUtM?=
 =?utf-8?B?c2d2bnZsYXZPc3l1WGFwK1ppMFVKQ0xyRDNzdzNjMUI3SDR3N1hSUzRTbWdF?=
 =?utf-8?B?dlhYdmNub0s0di9WMUxTekRDZGVmdVd3ZElSaG5aWGpWRVVrVzI3UTVZN0Ra?=
 =?utf-8?B?Sk9MMmJsM3FiU08rMHlDM3dxcUNnUVRKQU82R1hsOHZ0ZlhQeXBnb1FzaFdI?=
 =?utf-8?B?Z2Z5c0JTWk81MTU1bHpxbjJzQ1VpMFpZaTVHcVl4MzhkdXdxZXcxeDBjaGxO?=
 =?utf-8?B?MWkvL0NuM0hvRGpHVU0rMUpHTCtlNFVIb1ZaT1YyN3JnV21ZTzRkSGVZRTV4?=
 =?utf-8?B?T1F3KzNIWnlsU0lEV0dINDFmSlQ4VUFpUGJocTY3Q3c3ZUV5VWxBWGZ6a1A3?=
 =?utf-8?B?QkYvMUEzemJDbHRVRWVsa2l2S1BXbXpjN1dINkMyNWkwRmJTSk5TUmhJcFh0?=
 =?utf-8?B?N3IwNWNaSWhFUEJIL04xMCtOWGJjWFI2OGtDOStmck1zc1JqemUrTmJaakdy?=
 =?utf-8?B?OTk1RG5JeSt6ZGliTmttUzhVUlpBTWQ3cGlBSDZxRjdyYUJsaVdJdXkyVGlI?=
 =?utf-8?B?ajlGcndNTnp6cTFXR09rQnRZdWRsN0hCQzJWc29MU1RheWduRWswd3NEeVVO?=
 =?utf-8?B?Vm9ReXg4MXN2T1lHaTZaeWRxNis4RU1zeTh1aG52SDYrbEFDM2N2c25pdmpm?=
 =?utf-8?B?b1VpL3k2LzAxeGtac1R0elN1TktuU3FJdEx6RUg3ays3UVpCZjFGeXpNK1Y1?=
 =?utf-8?B?aElGZnBXaUdOdW9TdkpYaVpFcnROM1FOd2xFTGRtTnRmUGlHRWVmMnhybmNj?=
 =?utf-8?B?U0VCREZFeXpsOVd3SWZkdzBXRzlkTjdFbCtidlBYeWw3RDUyb1lFRnh4c1Ra?=
 =?utf-8?B?QzV0SVZYMURhSURxYytseWtqZ2NkSzVQLzVRZG1PeXJ0WFZOTitLKzJIRUIv?=
 =?utf-8?B?R3A2REp4WlRlYU5QMDlTQTRld25xUnBhcVdpTDJkSnZ2dXkwNmpicDlvQVk1?=
 =?utf-8?B?OU5LYnh1SzIxSzFuVWZ4RkVxaFlLRi9kSWdDUGYxN050b3loaGJSeTlqeVRQ?=
 =?utf-8?B?cmhVOG5ydjVMaXdhNDlXRE1sODY3NVYxVXNRRUxBTjRlS201c09qM2RtVUZy?=
 =?utf-8?B?QU1OdHovOUJaOU5nLzF1N3k4UXV1M21EZ2VWUCs0TS9wQ3JBMGk3ZEZrWWw0?=
 =?utf-8?B?NE9uc0Q1MXozemk4b1BRRHdvZHJNcG03cVd5MktWcFEyZnB1amxFOUUzMkhH?=
 =?utf-8?B?NVhqOFlEOWpUbDFad2hqZnJSYUtra1Nhc2czZWNHYWxiZGJvNVdxZ2N2K1Nj?=
 =?utf-8?B?VE9Idk9mY3JJWWFheGd3TUlqWWJzb2dCRVRnTTV5a0JoY2ZjQmxtNWllaHdI?=
 =?utf-8?B?MDRKU214bWwxSnlrZGc2cE1HOFRTR1lnd3dvckZPYjNlem45OHk5ZXQ3aEN6?=
 =?utf-8?B?WnhLMDd6OExoVEgyR0d5NW1uWjRLZ29SODhDcmFXcGhHZkdsZkJmcGJQV3Ey?=
 =?utf-8?B?Z0xPOGpBSkNBa2M0VndSV3owS2FxR3ZxS2R0WVJUVENVNmZldFFhbHlPK3NH?=
 =?utf-8?B?VklxNURIdXc2cmdjOVF5VTM2R2tDZ3FlWXN4ZkttVHhLNExlbWF6ZWk0cVp2?=
 =?utf-8?Q?EIkNTxQPANg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2FjRGEyMldKVzNzTFVBR1F4bFRpcXluR2sxWTNvK2lnVnJtUUdjZngxRXh5?=
 =?utf-8?B?bTJhRWdwS3pMMm5aemcvYk9SYVl4aTBFZXFXTElTQStKd1NSb3dGSDRVaUZv?=
 =?utf-8?B?V2dHYjM1L3QzRnRXQnBHN1VwME9OVkFkUHRLV3pGcmhOMjQ5STI3RlVpSy8r?=
 =?utf-8?B?Tno1S3M1Tm5rekJDN3YvNkl0VkpuS0RvTDIvVStRbW9Wby9LaUVIVHFqbG0v?=
 =?utf-8?B?V2J5dVJMcW1XUENVYnlXQ3JSZVREc1lwb3RTbWR1N3Y3bkRleW12QjhXY1hN?=
 =?utf-8?B?d0drRXZjYVo2ZnI1Q3lWTy92U0lDQkVVVjhheW9HVDA5WDhSYWJ2RDUwNjkw?=
 =?utf-8?B?L2tHUGFuTkd5RzFsUjBFelo2RmdQRTYxTTVncXFZM0p1TUJPUUEwNkNhZmNl?=
 =?utf-8?B?Y1JQejlBRlN6YStCSlBKU0tWVTJaUjVybGc0cUJzVzBHNmRaQ0M4dmVDWUFQ?=
 =?utf-8?B?U0hKaGZVd0VTOTBESUJyZ25XWmJKYU82NHAreGQzUWhtbW1WSVBHaTYyUWF2?=
 =?utf-8?B?MEM0V0djWGRDeU9qTEtsNGxVV1U1N0lrNFkzVy80NHRnM0dVbkNNMjh2UWp2?=
 =?utf-8?B?aHBhSWd1MEJCL0RUL0pXaHplckU4TVFmMEtpSlVQY2hUQkVlMi9mdDlzSkFR?=
 =?utf-8?B?VTFYTUhtaDY5UnpMTHpWMUdQMjNKcGUzczFsMDhjMmJacGEzSDR3Nm1kV29J?=
 =?utf-8?B?YmZCYWw0RnNQL0Z6dWxacC8yb3hKOFBDb3dpdnMrM2drVGxZWU9ucVk2NXly?=
 =?utf-8?B?WERIMGNvajhMNjc4Vzkyb25tZmF1emNiUHJJdGxHSHlIb2pQR0ZHNU9maVBz?=
 =?utf-8?B?dFd6dEd4MXRWeDVmN2VYWmxEMXVJaDBQUkZmSVhPUlRDR1NvZzBpZENuY05X?=
 =?utf-8?B?aDBZLzk4WEtzSjFKY0hVT0cvNGJobTNiN1pORVVNblFlVVI1eVFYdXpIbWlq?=
 =?utf-8?B?QncvZE5xUStXNWZ2d2NHTFNlWHBpYS9sY0hLblVPK3lCSDZoODM1WVYyemtI?=
 =?utf-8?B?dXhqbjcrdzhmSysxbUxCcHdZalZna0JyRjZWajNEZkgyaGlxYkxaYkJiSkdO?=
 =?utf-8?B?QklmSnN1SWhySlRwNkY4cWJhSmRsY1lHaGJDNXh6SDFwbTZ0Y2pEMDFaRU42?=
 =?utf-8?B?b0x5emR1dE5JUUxpUHFuTHdsa0tnNVJCdE5wN2tRTXhvWXN1dFNCVWdpMnd3?=
 =?utf-8?B?SkxMaFZCOVora3EreWgwcXdGUUJRYnZnTWxXZHl1WjFGZ1FlU1F0Q3Izd3RE?=
 =?utf-8?B?NHY4N3BLeTZsT0kzVHBqcUR6QjFmT0g1MTM2Q21SU0hsSkpHdmZNMTZRMkxj?=
 =?utf-8?B?ZVJWaktwdzZNOFVKb2NEUG96bUYvcVBOWTA0UXkxcm1YNXhZdFRCUzRLdHBB?=
 =?utf-8?B?R3Z0VzZwSHkxRW1mS29NOFdGYjVnU3ZoWmNSOGxHcFpWZ1MzY0x2WnNZUkxR?=
 =?utf-8?B?UTlSRW12TFNmM0hKVGhLRzFicjk0SWpMc2Y5T1M5cTFsV0lNVGdiS3kwdVBV?=
 =?utf-8?B?V20xYy9GSjNsZ0JoRWhONTBQQXoxNnhyNk1vVUVlRlZmOWRoSERScFZWSTRB?=
 =?utf-8?B?RVBISHVDSStVeFVaZzdiZHNnSTdQTUF4Uk9ZNTU3MG5IR0ZFc0I5SmxCTDl5?=
 =?utf-8?B?MVpHR0FSbkJpdi9yaW1MZDRoYlZ5ejNNOUNhemFQN3ZXK1dlRm80K0VHS2Jj?=
 =?utf-8?B?ZGU3Wmp3aXI3S2VjQ3VFMTVpQ29Gck9vdGtkTXNJTzBzYXg5V1VMZnJWdnlz?=
 =?utf-8?B?QXQwZFprNEd4SGQvNTBrbmtGaGRlcnRJMUc0NEt3SUJaU2J5VWZjanN2ZVBs?=
 =?utf-8?B?S3d2RHoyMlcwQmtlZDBCQ1VZNXRsak5LT0NiU0VMUEE0bWNoWnJCZ2paRkdB?=
 =?utf-8?B?U1RTTm9RZ0JEYUIzUjFRL2U1MXRKeVVueHg2YkdxZmNsZ25ZQ2NCOVVDVWNC?=
 =?utf-8?B?clE1bWFWZm8yV3ZhakIxRjVpRFB2UUJINEtxRmRkL2M4U3JmVlVLRVFVMDlm?=
 =?utf-8?B?Qm0wYlN0Ym1EK3VnYWNvemZYdFVWTzM5ckRrZWl2NjNsNkdYdjk5RW1WVXdi?=
 =?utf-8?B?VlpublFWVXhRZFFQVXM4SkJGNWFDUHdidTl3MWdMTklkUVhuY3ViNmtJdUli?=
 =?utf-8?B?dzQwVG85N3JiejdFUkdHMU1VdmNnOWYzOHNHeDRaanpZbHNvYXE0WUE1ZEt2?=
 =?utf-8?Q?vLeXFeFGJmCXEOigmPcP61yD4xz+l/pkmTP0vlk+Am+o?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d28860-22b4-4152-eaee-08ddc6817533
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2025 05:02:27.5651 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfsx/JgCjfyAcJQ1OUXT0D3f6NNgVUMdTh6PQ9NrewyGAIW1e9pav7L0ZZn7AwZlS4rpd7ynU9eFcDQaGBS4Luip3uvoeuMxhPUdYMrergw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5201
X-Mailman-Approved-At: Sat, 19 Jul 2025 14:51:39 +0200
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa28gU2Nob2NoZXIg
PGhzQGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCAxOSBKdWx5IDIwMjUgMTI6MjEgcG0NCj4g
VG86IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVu
eC5kZTsgRnJhbmsgV3VuZGVybGljaCA8bGludXhAZnctd2ViLmRlPjsgUGFkbWFyYW8NCj4gQmVn
YXJpIDxwYWRtYXJhby5iZWdhcmlAYW1kLmNvbT47IE1hbml5YW0sIERpbmVzaA0KPiA8ZGluZXNo
Lm1hbml5YW1AYWx0ZXJhLmNvbT47IEhvbGdlciBCcnVuY2sgPGhvbGdlci5icnVuY2tAaGl0YWNo
aS0NCj4gcG93ZXJncmlkcy5jb20+DQo+IFN1YmplY3Q6IFJlOiBQbGVhc2UgcHVsbCB1LWJvb3Qt
aTJjIG1hc3Rlcg0KPiANCj4gW0NBVVRJT046IFRoaXMgZW1haWwgaXMgZnJvbSBvdXRzaWRlIHlv
dXIgb3JnYW5pemF0aW9uLiBVbmxlc3MgeW91IHRydXN0IHRoZQ0KPiBzZW5kZXIsIGRvIG5vdCBj
bGljayBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIGFzIGl0IG1heSBiZSBhIGZyYXVkdWxl
bnQgZW1haWwNCj4gYXR0ZW1wdGluZyB0byBzdGVhbCB5b3VyIGluZm9ybWF0aW9uIGFuZC9vciBj
b21wcm9taXNlIHlvdXIgY29tcHV0ZXIuXQ0KPiANCj4gSGVsbG8gVG9tLA0KPiANCj4gT24gMTgu
MDcuMjUgMTc6MDEsIFRvbSBSaW5pIHdyb3RlOg0KPiA+IE9uIFRodSwgSnVsIDE3LCAyMDI1IGF0
IDA4OjEwOjE3QU0gKzAyMDAsIEhlaWtvIFNjaG9jaGVyIHdyb3RlOg0KPiA+DQo+ID4+IEhlbGxv
IFRvbSwNCj4gPj4NCj4gPj4gVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdA0KPiA1
M2JkODc2NTFlNDViMzJlZmEzOThkZDVlNDMzZDhiOTNkNzgxNDQ1Og0KPiA+Pg0KPiA+PiAgICBi
bG9jazogc2FuZGJveDogQWRkIHN1cHBvcnQgZm9yIFNZU182NEJJVF9MQkEgKDIwMjUtMDctMTEg
MTE6MzM6MjUNCj4gPj4gLTA2MDApDQo+ID4+DQo+ID4+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdp
dCByZXBvc2l0b3J5IGF0Og0KPiA+Pg0KPiA+PiAgICBodHRwczovL3NvdXJjZS5kZW54LmRlL3Ut
Ym9vdC9jdXN0b2RpYW5zL3UtYm9vdC1pMmMuZ2l0DQo+ID4+IGkyYy1mb3ItMjAyNS4xMA0KPiA+
Pg0KPiA+PiBmb3IgeW91IHRvIGZldGNoIGNoYW5nZXMgdXAgdG8NCj4gNWU4MGM2NzU3Mzc4ZDA5
OTUwMjM1MDgzNTMzZTdhN2MzYWVhZTNiZToNCj4gPj4NCj4gPj4gICAgY29uZmlnczogYWdpbGV4
NV9kZWZjb25maWc6IEVuYWJsZSBpM2MgY29uZmlncyBmb3IgYWdpbGV4NQ0KPiA+PiAoMjAyNS0w
Ny0xNiAwOTozMzo1NCArMDIwMCkNCj4gPj4NCj4gPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiBpMmMgdXBkYXRl
cyBmb3IgdjIwMjUuMTANCj4gPj4NCj4gPj4gLSBpMmMgS2NvbmZpZyB1cGRhdGVzIGZyb20gVG9t
DQo+ID4+ICAgIC0gYWRkIHNvbWUgZHJpdmVyIGRlcGVuZGVuY2llcw0KPiA+PiAgICAtIGFkZGVk
IG1pc3NpbmcgaW5jbHVkZSBkZWxheS5oIGluIGlwcm9jX2kyYy5jDQo+ID4+DQo+ID4+IC0gaTJj
OiBtdXhlczogQWRkIFBDQTk1NDEgaTJjIGFyYml0cmF0b3IgZHJpdmVyDQo+ID4+ICAgIGZyb20g
UGFkbWFyYW8gQmVnYXJpDQo+ID4+DQo+ID4+IC0gcGNhOTU0eDogYWRkIHBjYTk1NDUgc3VwcG9y
dA0KPiA+PiAgICBmcm9tIEZyYW5rIFd1bmRlcmxpY2gNCj4gPj4NCj4gPj4gLSBjbWQ6IGkyYzog
Zml4IGJ1aWxkIHdoZW4gQ0ZHX1NZU19JMkNfTk9QUk9CRVMgZGVmaW5lZCB3aXRoIERNX0kyQw0K
PiA+PiAgICBGcm9tIEhvbGdlciBCcnVuY2sNCj4gPj4NCj4gPj4gLSBhZGRlZCBpM2Mgc3VwcG9y
dCB0byBVLUJvb3QgYW5kIGVuYWJsZSBpdCBmb3IgYWdpbGV4NQ0KPiA+PiAgICBib2FyZCBmcm9t
IERpbmVzaCBNYW5peWFtDQo+ID4NCj4gPiBVbmZvcnR1bmF0ZWx5IHRoZSBpM2Mgc3VwcG9ydCBs
ZWFkcyB0byB0aGlzIGluIGNvcmVib290Og0KPiA+IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1i
b290L3UtYm9vdC8tL2pvYnMvMTIwMjk0OS9yYXcNCj4gPg0KPiA+IFdoaWNoIGxvb2tzIGxpa2Ug
Y29yZWJvb3QganVzdCBnZXRzIHN0dWNrIGluIGEgbG9vcD8gQW5kIGluIHR1cm4sIHRoYXQNCj4g
PiBsZWFkIG1lIHRvIGRvIHRoaXMgbG9jYWxseToNCj4gPiBjb21taXQgMDNlOWQ1ZjRjNjFjYmE1
ZDhlMWRiODFkNzU5ZmVmZDYyMmIzYWQ0OQ0KPiA+IEF1dGhvcjogVG9tIFJpbmkgPHRyaW5pQGtv
bnN1bGtvLmNvbT4NCj4gPiBEYXRlOiAgIFRodSBKdWwgMTcgMTU6MjI6MDggMjAyNSAtMDYwMA0K
PiA+DQo+ID4gICAgICBoYWNrIGRyb3AgZ2VuZXJpYyBjaGFuZ2VzDQo+ID4NCj4gPiAgICAgIFNp
Z25lZC1vZmYtYnk6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9kbS9kZXZpY2UuaCBiL2luY2x1ZGUvZG0vZGV2aWNlLmggaW5kZXgN
Cj4gPiBjNWNmYTE4ZDA5ZDYuLjY3OGNkODNjMjcxNiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRl
L2RtL2RldmljZS5oDQo+ID4gKysrIGIvaW5jbHVkZS9kbS9kZXZpY2UuaA0KPiA+IEBAIC0xNjks
NyArMTY5LDYgQEAgZW51bSB7DQo+ID4gICAgKiBAZG1hX29mZnNldDogT2Zmc2V0IGJldHdlZW4g
dGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UgKENQVSdzKSBhbmQgdGhlDQo+ID4gICAgKiAgICAg
ICAgICBkZXZpY2UncyBidXMgYWRkcmVzcyBzcGFjZQ0KPiA+ICAgICogQGlvbW11OiBJT01NVSBk
ZXZpY2UgYXNzb2NpYXRlZCB3aXRoIHRoaXMgZGV2aWNlDQo+ID4gLSAqIEBvZl9ub2RlOiBBc3Nv
Y2lhdGVkIGRldmljZSB0cmVlIG5vZGUNCj4gPiAgICAqLw0KPiA+ICAgc3RydWN0IHVkZXZpY2Ug
ew0KPiA+ICAgICAgIGNvbnN0IHN0cnVjdCBkcml2ZXIgKmRyaXZlcjsNCj4gPiBAQCAtMjAyLDcg
KzIwMSw2IEBAIHN0cnVjdCB1ZGV2aWNlIHsNCj4gPiAgICNpZiBDT05GSUdfSVNfRU5BQkxFRChJ
T01NVSkNCj4gPiAgICAgICBzdHJ1Y3QgdWRldmljZSAqaW9tbXU7DQo+ID4gICAjZW5kaWYNCj4g
PiAtICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgICAgICAqb2Zfbm9kZTsNCj4gPiAgIH07DQo+ID4N
Cj4gPiAgIHN0YXRpYyBpbmxpbmUgaW50IGRtX3VkZXZpY2Vfc2l6ZSh2b2lkKQ0KPiANCj4gVWZm
Li4geWVwLCBvdmVyc2VlbiB0aGlzIGNoYW5nZS4uLg0KPiANCj4gPiBXaGljaCBsZWFkcyBtZSAo
YSkgYmVpbmcgY29uY2VybmVkIGFib3V0IHdoYXQgb3VyIGNvcmVib290IHN1cHBvcnQgaXMNCj4g
PiB1cCB0byBhbmQgKGIpIHdoeSBpM2MgbmVlZHMgdGhpcyBnZW5lcmljIGNoYW5nZT8gQW5kIEkg
ZG9uJ3QganVzdCB3YW50DQo+ID4gdG8gc2VlIENPTkZJR19JU19FTkFCTEVEKCknaW5nIGl0LCB3
aHkgZG8gd2UgaGF2ZSB0byBoYW5kbGUgdGhlIGRldmljZQ0KPiA+IHRyZWUgdGhhdCB3YXkgYW5k
IGlzIHRoZXJlIG5vIHN0YW5kYXJkIG1lY2hhbmlzbSB3ZSBjYW4gdXNlPw0KPiA+DQo+IA0KPiBA
ZGluZXNoOiB3aHkgZG8geW91IG5lZWQgdGhpcz8NCj4gDQo+IEl0IHNob3VsZCBiZSBwb3NzaWJs
ZSBpbiB0aGUgbWFzdGVyIGRyaXZlciB0byBnZXQgdGhlIG9mIHBvaW50ZXIgd2l0aA0KPiANCj4g
DQo+IG9mbm9kZSBub2RlID0gZGV2X29mbm9kZShkZXYpOw0KPiANCj4gYW5kIGlmIHlvdSByZWFs
bHkgbmVlZCBpdCBpbiBkcml2ZXJzL2kzYy9tYXN0ZXIuYyBwYXNzIGl0IHRvIHRoZSBmdW5jdGlv
bnMgeW91IGNhbGwuLi4NCj4gYWgsIG5vLCBhcyB5b3UgYWxyZWFkeSBzYXZlIHRoZSB1ZGV2aWNl
IGluIGkzY19tYXN0ZXJfY29udHJvbGxlciwgeW91IGNhbiBzaW1wbHkNCj4gdXNlDQo+IA0KPiBk
ZXZfb2Zub2RlKGRldikNCj4gDQo+IGluIGl0IQ0KPiANCj4gWW91IGNhbiBzaW1wbHkgZHJvcCBv
Zl9ub2RlIGZyb20gZ2VuZXJpYyBmaWxlLCBhbmQgdXNlIGRldl9vZm5vZGUoZGV2KSBpbiB5b3Vy
DQo+IGRyaXZlci9pM2MgY29kZSAuLi4gbWF5IHlvdSBzYXZlIHRoZSB1ZGV2aWNlIGluIHByaXZh
dGUgZGF0YSBvciBpbiB5b3VyDQo+IGkzY19kZXZfYm9hcmRpbmZvIHN0cnVjdCBpbnN0ZWFkIGlm
IHJlYWxseSBuZWVkZWQsIHNvIHBsZWFzZSByZXdvcmsgdGhhdCBwYXJ0Lg0KPiANCj4gQFRvbTog
SSB3aWxsIGRyb3AgaTNjIHN1cHBvcnQgZnJvbSBteSBwdWxsIHJlcXVlc3QgYW5kIHNlbmQgYSBu
ZXcgb25lDQo+IA0KPiBBbmQgeWVzLCB0aGUgcXVlc3Rpb24gYSkgcmVtYWlucyAuLi4NCj4gDQo+
IFRoYW5rcyENCj4gDQo+IGJ5ZSwNCj4gSGVpa28NCg0KWWVzIGFncmVlZCEgSSBjYW4gdXNlIGRl
dl9vZm5vZGUoZGV2KSBhbmQgd2lsbCBxdWlja2x5IHJld29yayBvbiB0aGlzIHBhcnQuDQoNClRo
YW5rcw0KRGluZXNoDQoNCj4gLS0NCj4gREVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILCBN
YW5hZ2luZyBEaXJlY3RvcjogSm9oYW5uYSBEZW5rLCBUYWJlYSBMdXR6DQo+IEhSQiAxNjUyMzUg
TXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5NCBHcm9lYmVuemVsbCwgR2VybWFu
eQ0KPiBQaG9uZTogKzQ5LTgxNDItNjY5ODktNTIgICBGYXg6ICs0OS04MTQyLTY2OTg5LTgwICAg
RW1haWw6IGhzQGRlbnguZGUNCg==
