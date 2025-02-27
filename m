Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD3C021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 00:29:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A197780F56;
	Thu, 27 Feb 2025 01:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bH96tf4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A42480FDE; Thu, 27 Feb 2025 01:29:04 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56842808A2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:29:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SG7U9D8hVfhMXlZ6qsaO0L/+JdxjFTSBpJSj6UGtQgWEG3vEU4OD2PLAFP94ARgDXkGdyA4QqvVjMD7/axdLWWaWVt0SVIA2Nwdy77TA1DpEM06EEQ2Q+1zknWy8vZNEi4C3U9WS92OKHOvZ3O0H1QNzdqmow02fQgYx553X+ksKIGTLCt3lQuPtQsd+Fqyr8hXYZ2qLcZKPWRWeA+qLOAi5MaNX6pebnHx281lC+K3x1k8OJIRi1Mbw7cechcedXotD20hwUnkUzo3zH6igiK3gSPp9YXqyJCGJqHvkvRhVWYNMxRp2rI0y4UlK8FPcLyCdAfpoZmpjJ9YRPcRJng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBEq9v9haFAJf2D/dBoF1igGr+fWSIOCW8pd9LRFOwk=;
 b=wR93AM1nToRNkFFrBzpau7RtqwuSUHKQ2dBGtltI5p8vfndsYOO6Ri8wgFDBrO456xLOsKRJUUBZ6y0zLGs/ocpiQLjoXAvTM5KVjnmTAF51BLxqjVX8GAjFn6oKWtKr+MywNS/B3zAAdRCUCClU5TKi0QfR4YuSFnzDgIqNj+kYpizltSq7NNbo5IKJ4PF/DlTUpiHmdUGxd5pi1UwzqnK/CBKeQAv7og0FOWZfVjooMP2knDi6qcOXr2/5jduqasgLAUAlAHL7B2L8ALJfm1RS4qK2N5BQeAX0xKxhI8BA6lH5toCvjj3KsNnyh/K9+tePsuSFP0QbC+PnIV7TqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBEq9v9haFAJf2D/dBoF1igGr+fWSIOCW8pd9LRFOwk=;
 b=bH96tf4+BegsLLbAkHmFX+sj+v7N28+lyAdKt6HPmN91ktKvbuoWLjULDFkLtuwDTcg7WPc22fUFEmbv4w1tA8/8AQbpuSAAENKQkrh/aUAO47oqfc7Yoytngprc7ZqGG9mPKIkAo+WdkWy+lauxaAH3xkqT+2oQp9qhoc5IdZn0R3COI8WiC2qifi7hr847H6c/xkIXhjrYYQDryf4yU1qNHQVagKrUkebr/34Ee6P/Lj8Sm5s1tbNls18DRXqQl44cr2tuKFvySGE+WutKxPszaUBPrTd0uw0//W5GrMKDpmY0YKuKWjRv3e/JNGlSKCOlK8pWZV1GNCi1EuYvUg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8920.eurprd04.prod.outlook.com (2603:10a6:10:2e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 27 Feb
 2025 00:28:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 00:28:59 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: RE: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Topic: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Index: AQHbhRpY04AkkA2i5k63U7t2wu8txrNaNoCAgAAcFAA=
Date: Thu, 27 Feb 2025 00:28:59 +0000
Message-ID: <PAXPR04MB845927C1DF89F4BBBC6B929088CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
In-Reply-To: <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8920:EE_
x-ms-office365-filtering-correlation-id: 45499c4a-66b2-4b2b-7325-08dd56c5ba7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUNkTURHY2EwZkVvYXZzWDlPWmMxMjBOaytxS2tzeGtramVYWlhIZ3Zjb2g4?=
 =?utf-8?B?TnUxb3ZqcGh1bTRXaVlxWFlmUTl3SDM1UWFUM0VUM3ZiTWVRNmcxRi9aNU9u?=
 =?utf-8?B?dzl2ZGx5NDN1bzFxYUpFbUdaZEY1MUdyTEZPMExaaXdWZTl6Y0w0dVZqSEdL?=
 =?utf-8?B?Qzg5TUprN3JwdHZtRkd1QnlvTlBxNVhjSUxHWS9VVVhQeFdLbjhPZ1Vka1J6?=
 =?utf-8?B?eDV1MGZtNHBMeTh5WEcwTk1wTzdwWFI4c1NSUUN5Yk51MUFHbWY0bjJ2bFFF?=
 =?utf-8?B?a2k0djRYYVkrRnRuSXgxa0xnUnd4N0ljQ1FxcXV6QXYvczNtcUUwckIxVUpz?=
 =?utf-8?B?cnZxL28wYm1POTRYaGFWeEVScFZ1eVBNMC9BMk9GMjQ4QlhPZk9ZcmRFbHNk?=
 =?utf-8?B?RlVCZ3Z1VlpsbktDaUUzYkRuSE5RMktQQUFSSnl4VWNTNG1uamZHUjJVM3FS?=
 =?utf-8?B?RlZnTkMrWWZ2UWZXTGJ6NDhVV1hHaW1Rd05IeldRRG9qajAzeXYyZUk0bUpw?=
 =?utf-8?B?YW1TcmJIODlEblhGSnluZFlyYW52TStYKzZTS3dySXR4WHZpbmlxTGd3UGtK?=
 =?utf-8?B?MFVuRnZGNTZoYjdiQ2VrZ01QRzhEZEo2bGZabUV0TEw1YnQxb0haSUJOYm9T?=
 =?utf-8?B?alhJd210Z28zTFVmWEhncDNjdFl4K09ZSjZzV0hGWWRZVklJekdGZEl6U1U2?=
 =?utf-8?B?NWd3cTRLbEpJWWV1QVdmcStPRVQvWTJBV1FCSXVWTmhpMnE2NVcvWWMySG54?=
 =?utf-8?B?cEQ3NG5SanpnWVlWTzl6TDJpT0xrc2t2Nnh4Njk3cXpSTDNNb3ZONE1XTjlH?=
 =?utf-8?B?TnhzeWhUa1NVeU1LODdpRVhEY0xLZGVLbEUyVDNlUENVNWVrcjBYV2xmSGJo?=
 =?utf-8?B?NU5WVnBUWlpuNWxOMFJlV0N2VmRHa2pFMktEVW9GOUpEUWo1WCtReWRsdS9t?=
 =?utf-8?B?SW1EejVpd1Uvc05kY0lhWmg3N2pic1FFN2prVk1GbWNmMkJleGlqNmYzUTE4?=
 =?utf-8?B?anE0ZHExTkVXNzVUU0RJRUxvMVlDNXQxcSt6dUY3cmpEUktEMHRkK0ZleDlH?=
 =?utf-8?B?QW1sRHZFZTAyaHN1ZGZGT1owVFM4alhxUG50SzJKUWdQSG9oVjRIeHBQcVZD?=
 =?utf-8?B?Q1d1VHBQQUhiTU4ycENYaWZuWUc4eEdBcXVJTGhkemtlUWx6bGxEWkY3K0kx?=
 =?utf-8?B?eEd2cEowTmhSajVxNTk0OEJndHE1cDlBTkFUTlNhZ0hIRVUzTEcyYWlQLzV3?=
 =?utf-8?B?aUxGL0pkY0ttbDhKWUhqanMvRHFvbWcwRlNEWExCQ1RsdHg3b0E0b0N5Y0hs?=
 =?utf-8?B?NUw1Zkk0Tm9DQzcyWi9IWEVWc0tGQTNIem5lYWFCSEdiZHFhNis1RmNlMTVC?=
 =?utf-8?B?K0RlTHkxV1oyY0ZQRGp3RzY5Q1dtYnJLQjAyd3JENEpuc2s2YWNxeSt1L3dE?=
 =?utf-8?B?WnJYNU5SaldHUEtpTUxnQ3UxZ3hqNndIeGFaSEhybGFMS2xydVoxcCsvU3dC?=
 =?utf-8?B?S0pqY253UDBYQU5yNjk4WGwyN1c1MnhNQmtPVVlDaDM2OUpBVnF6Mm5KSXpF?=
 =?utf-8?B?UWo4NzVGemhMdHRrbC8rcWlYTEJYSjBsd0MrV1pQL2NsN1RjampUZTNIM1hy?=
 =?utf-8?B?eWYvZVgrY0NPU3o4aCt0ZkxxeDBwcS9zMEJlREcwbXdZNTdwNmlMQS9FNVdm?=
 =?utf-8?B?THRDZU9SeDM1ZW9CbGR0TDJTamF4eHlqNU1ZTUl3OGlJQSt0RXhRK0ZMdDJ0?=
 =?utf-8?B?Y1lnTnR3NVorM2REOEl3bldjeFppck1sQk9RYjVPTnIxcG0wS251MEtxZjBC?=
 =?utf-8?B?QXowRC9TUjVwN1hpdkJkMHV5NDhkdVVwU0hMMjNmbXFnR0tmUU1GWjNZUzlZ?=
 =?utf-8?B?S0ZuUXBKQ3hlczF6MjJ1RXhZVU1XYXdtWGYzQXpLNk9XT2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3dsVlFIS2ozdkpqSVVKS0kvdnRWYnQrandFZDE4WXRPU3U4MXNhOTNwWFNU?=
 =?utf-8?B?SC85b0gwRDl0b0pLcFpKRm56VDJlRVlBek9aYjhQazRYUEJjNG8zMmIxWmhH?=
 =?utf-8?B?bjU2c0dpcFFRcGtHNTVYbHdub2xHQ1p5bElYZlNEczdtakk5UTUrZEZ2Nks3?=
 =?utf-8?B?ZXY5Q0hOWVhuT1RQVjNkS3JmMTFNbWZqbFY3em9DRnBDb0t1N1BSZk1lbG9s?=
 =?utf-8?B?YWpVem9qTWtCMCtYZzVNdHVmWnpZRERSNzU2U21kOE1Fb0t4T3lHZDZFcnR3?=
 =?utf-8?B?WGJESEIzTTkxM1NWTG9VMHl0SlNFVWgzMUNVeGlTS1VmdjV4dXRTZE54R3Rr?=
 =?utf-8?B?UEw3bVVSOXVoK1ZPRWU1RkQxVUl1N3lMM2ZzQXY2L2NqM3p1WlU5b3JNaEtr?=
 =?utf-8?B?WVZhVmN0MkZ4cU0vWUdzVXdqL0IyckkwcUliS0x1cWgwSkNncWZYR3ZmWW1x?=
 =?utf-8?B?Q2swQmtuVFdFWTg2SnZudFhXaG1ENlpFQ2ozcTF1bll3Y0pxZ05rdDY0VEpR?=
 =?utf-8?B?aWhJSm9yckNrTjQ4eGdsWTB5azRhQWMxeW1PVUR2QnNUU2phTDd4dkkvM3Bv?=
 =?utf-8?B?blRPZkxwcUUxZmlCZVB5cEV2N3JXbGlwbGVGeXFxcklqWTVpaDk2OXA4cGVU?=
 =?utf-8?B?ak84emtsZHRnaWIrMStDWUZVQkFQZEQ3WmNrQ0hxbHl4dHFWS2NVLzk2UUtr?=
 =?utf-8?B?U3d4NUJHVmQ0YllKSGs5T2J4NnBEZzBZVDlBSkdicjVGS2E2aDFlTFNWZTZt?=
 =?utf-8?B?RmdieVkwNGIwYllLN3AvaTJ1M3hMZ2xOeWJXOFJVUmtOTGQzcEY4dUluTDNX?=
 =?utf-8?B?NUxmWndCd0JJckxqRm5XVHc2RUVkOXhSeUxCTXUrUStlNi9uYTZOYWg2bUhK?=
 =?utf-8?B?V0JEckxFV0h2Tmk5dnU1RHIvU1NGeWZmVFhEZkF4eXFCSDdqb1hiSm5DbVBV?=
 =?utf-8?B?M1YrVEFGWE9wKzEzM2hiWVRDSFl4a25LUnkrSnlIVFFYUHlMdUxseVd5RlZs?=
 =?utf-8?B?cDNnUFVzdHhvaDZXMERLbC9kYlBocytJb0QxZExaTndLWmdlYmZpcnhYYTJs?=
 =?utf-8?B?b21PNkgzY3V5enFvK1FiQ25ERnM3ZmN4Q1F5ekNIb24zYTFtY1pnbDg0Yk9R?=
 =?utf-8?B?MGR2MElIOVlDSEZuZ05sRE1mU3JHRmFkclJjd0lvakRKNnZoRG9uWUptTU4x?=
 =?utf-8?B?Tm92U1RNdHJsT3lYN2ZCekxTUFFPWFd4YysrWllTeXhuRWttK20wT2w0OXN1?=
 =?utf-8?B?Qk50bGhXN0p3VFRzNGR4OXRvdllRdkJzYnZGYnRYcnhKZ2RjQXFxbUhHWnhS?=
 =?utf-8?B?eTNKb2lNMUdQZTNSWUlmRCtnNHJNV1hkNE1lcUdHVURwelBCN3FlVXNJRTFK?=
 =?utf-8?B?eHFPYUptSGJjUmF2MkJuQm1zdC9GeDRGNFNJbCtxZ3k3eWJnZVZadzJlRTds?=
 =?utf-8?B?RTRvM05wcnQ5dTgxYURXVmM2SUg1Z09LRzF0UjNFWnBFWThvd0ZIRGkyTjY2?=
 =?utf-8?B?eVNCcjZta3JZZHROUUdVQU5VRk1wYkNtS0lTbERLOXYyUzVlK2YzOTNCcUls?=
 =?utf-8?B?U1ZuOThxR3JOQ3k1NVQwaE1HTEF1VEljUmVSc2NuWWlSOEhjZEVEMjR4VVNo?=
 =?utf-8?B?QTBRbVhwSTUvR0JucE01aXhJTnhnYlZNZU1lZWFOSktKbVpaY24zQytlYUZN?=
 =?utf-8?B?elRzUDlITWN4aitFZVBNcks3NFFmTE9oTmJpcFJCTVVYLzdueHJYOUFTOFNI?=
 =?utf-8?B?ZXh2c1dWNmg0b0pNL1E0SVNIUjVNenk5SFl5MnpXaXpsSGM1dDFEd0dmY1Vy?=
 =?utf-8?B?UkZEVENjVG85M0hYdktuUmJoc3dLVnJYcVpEdy9KazhSSFBTTUM3Rm5CV2o5?=
 =?utf-8?B?WjRZV1RTcEowbzcxWUNPU0ViVUZpa054RXB3QWY1aXZkbWlacEt2LzYwL3Rs?=
 =?utf-8?B?UXJpdEZrV1RLa2w0ZVVmQ3c1RjNsRG9yc2pCclJwd3ZIaGp2QzRGZ29KUW8x?=
 =?utf-8?B?NDBXRHJDTmgxSG5UZWh0YUpIaWt1S2xJekYwMlIrNWZmRmpicXdCOWljTUxT?=
 =?utf-8?B?cyt4WnMvSEtHWDZOWkxDTlIwYjl6U2tscUhMRVVBblZXaC96S0ZxUm5rUGU0?=
 =?utf-8?Q?TkCc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45499c4a-66b2-4b2b-7325-08dd56c5ba7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 00:28:59.3370 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArNIwKi8PMcLd4Okn4z0jG8QBnOBaQNAk2DsdlgpSnQq08cj6nVKlOjpe6fMZ2UXGQ2bG23hA5MvDr7hSm4Vhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8920
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGlteDhtbTogaW14OG1tX2V2
azogZml4IEJPT1RTVEQgYm9vdA0KPiANCj4gSGkgUGVuZywNCj4gDQo+IE9uIFNhdCwgRmViIDIy
LCAyMDI1IGF0IDg6MTDigK9BTSBQZW5nIEZhbiAoT1NTKQ0KPiA8cGVuZy5mYW5Ab3NzLm54cC5j
b20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+
ID4NCj4gPiBTZWxlY3QgQk9PVFNURF9GVUxMIGFuZCBCT09UU1REX0JPT1RDT01NQU5EIENvcnJl
Y3QNCj4gREVGQVVMVF9GRFRfRklMRQ0KPiA+IENvcnJlY3QgZW52IGZpbGUgZm9yIGlteDhtbV9l
dmtfZnNwaV9kZWZjb25maWcNCj4gPg0KPiA+IEZpeGVzOiAzNjRiYTY4ZWQxYSAoImlteDogaW14
OG1tX2V2azogU3dpdGNoIHRvIEJPT1RTVEQiKQ0KPiA+IFJlcG9ydGVkLWJ5OiBMdWR3aWcgTnVz
c2VsIDxsdWR3aWcubnVzc2VsQHNpZW1lbnMuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gSSBoYXZlIGEgcHJvYmxlbSB3aXRoIHRoZSBi
b290c3RkIGNvbnZlcnNpb24gc2VyaWVzLg0KPiANCj4gSSBoYXZlIGEgQnVpbGRyb290IGltYWdl
IHRoYXQgYm9vdHMgVS1Cb290IDIwMjUuMDEgb24gaW14OTMtZXZrOg0KDQpJIHRlc3RlZCB3aXRo
IE5YUCB5b2N0byBpbWFnZSwgaXQgYm9vdHMgd2VsbC4gSXQgc2hvdWxkIGJlIG15IHNldHVwDQpu
b3QgaGF2ZSBleHRjb25mLiBJIHdpbGwgdXNlIGJ1aWxkcm9vdCB0byBzZXR1cCBhIGJ1aWxkIGFu
ZCB0cnkgaXQuDQoNClRoYW5rcywNClBlbmcNCg0KPiANCj4gVS1Cb290IDIwMjUuMDEgKEZlYiAy
NiAyMDI1IC0gMTY6MjI6MDMgLTAzMDApDQo+IA0KPiBSZXNldCBTdGF0dXM6IFBPUg0KPiANCj4g
Q1BVOiAgIE5YUCBpLk1YOTMoNTIpIFJldjEuMSBBNTUgYXQgMTcwMCBNSHoNCj4gQ1BVOiAgIElu
ZHVzdHJpYWwgdGVtcGVyYXR1cmUgZ3JhZGUgICgtNDBDIHRvIDEwNUMpIGF0IDM3Qw0KPiBNb2Rl
bDogTlhQIGkuTVg5MyAxMVgxMSBFVksgYm9hcmQNCj4gRFJBTTogIDIgR2lCDQo+IENvcmU6ICAx
OTkgZGV2aWNlcywgMjQgdWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFyYXRlDQo+IFdEVDogICBT
dGFydGVkIHdhdGNoZG9nQDQyNDkwMDAwIHdpdGggc2VydmljaW5nIGV2ZXJ5IDEwMDBtcw0KPiAo
NDBzIHRpbWVvdXQpDQo+IE1NQzogICBGU0xfU0RIQzogMCwgRlNMX1NESEM6IDENCj4gTG9hZGlu
ZyBFbnZpcm9ubWVudCBmcm9tIE1NQy4uLiBSZWFkaW5nIGZyb20gTU1DKDEpLi4uICoqKg0KPiBX
YXJuaW5nIC0gYmFkIENSQywgdXNpbmcgZGVmYXVsdCBlbnZpcm9ubWVudA0KPiANCj4gSW46ICAg
IHNlcmlhbEA0NDM4MDAwMA0KPiBPdXQ6ICAgc2VyaWFsQDQ0MzgwMDAwDQo+IEVycjogICBzZXJp
YWxANDQzODAwMDANCj4gc3dpdGNoIHRvIHBhcnRpdGlvbnMgIzAsIE9LDQo+IG1tYzEgaXMgY3Vy
cmVudCBkZXZpY2UNCj4gTmV0OiAgIGV0aDA6IGV0aGVybmV0QDQyODkwMDAwIFtQUklNRV0sIGV0
aDE6IGV0aGVybmV0QDQyOGEwMDAwDQo+IEhpdCBhbnkga2V5IHRvIHN0b3AgYXV0b2Jvb3Q6ICAw
DQo+IHN3aXRjaCB0byBwYXJ0aXRpb25zICMwLCBPSw0KPiBtbWMwKHBhcnQgMCkgaXMgY3VycmVu
dCBkZXZpY2UNCj4gU2Nhbm5pbmcgbW1jIDA6MS4uLg0KPiA2NTE2NiBieXRlcyByZWFkIGluIDE1
IG1zICg0LjEgTWlCL3MpDQo+IENhbm5vdCBwZXJzaXN0IEVGSSB2YXJpYWJsZXMgd2l0aG91dCBz
eXN0ZW0gcGFydGl0aW9uIExvYWRpbmcNCj4gQm9vdDAwMDAgJ21tYyAxJyBmYWlsZWQgTG9hZGlu
ZyBCb290MDAwMSAnbW1jIDAnIGZhaWxlZCBFRkkgYm9vdA0KPiBtYW5hZ2VyOiBDYW5ub3QgbG9h
ZCBhbnkgaW1hZ2Ugc3dpdGNoIHRvIHBhcnRpdGlvbnMgIzAsIE9LDQo+IG1tYzEgaXMgY3VycmVu
dCBkZXZpY2UNCj4gU2Nhbm5pbmcgbW1jIDE6MS4uLg0KPiBGb3VuZCAvYm9vdC9leHRsaW51eC9l
eHRsaW51eC5jb25mDQo+IFJldHJpZXZpbmcgZmlsZTogL2Jvb3QvZXh0bGludXgvZXh0bGludXgu
Y29uZg0KPiAxOiBidWlsZHJvb3QNCj4gUmV0cmlldmluZyBmaWxlOiAvYm9vdC9JbWFnZQ0KPiBh
cHBlbmQ6IHJvb3Q9UEFSVFVVSUQ9NmQ1NWI5MzYtZWViMy00OWM1LTliNjEtYjY5YTEyMDdiNzYx
DQo+IHJvb3R3YWl0IHJ3IFJldHJpZXZpbmcgZmlsZTogL2Jvb3QvZnJlZXNjYWxlL2lteDkzLTEx
eDExLWV2ay5kdGINCj4gIyMgRmxhdHRlbmVkIERldmljZSBUcmVlIGJsb2IgYXQgODMwMDAwMDAN
Cj4gICAgQm9vdGluZyB1c2luZyB0aGUgZmR0IGJsb2IgYXQgMHg4MzAwMDAwMCBXb3JraW5nIEZE
VCBzZXQgdG8NCj4gODMwMDAwMDANCj4gICAgTG9hZGluZyBEZXZpY2UgVHJlZSB0byAwMDAwMDAw
MDhmZmYzMDAwLCBlbmQgMDAwMDAwMDA4ZmZmZjQ0MiAuLi4NCj4gT0sgV29ya2luZyBGRFQgc2V0
IHRvIDhmZmYzMDAwDQo+IA0KPiBTdGFydGluZyBrZXJuZWwgLi4uDQo+IA0KPiBbICAgIDAuMDAw
MDAwXSBCb290aW5nIExpbnV4IG9uIHBoeXNpY2FsIENQVSAweDAwMDAwMDAwMDANCj4gWzB4NDEy
ZmQwNTBdDQo+IFsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNpb24gNi4xMi4xNiAoZmFiaW9AZmFi
aW8tUHJlY2lzaW9uLTM1NTEpDQo+IChhYXJjaDY0LWJ1aWxkcm9vdC1saW51eC1nbnUtZ2NjLmJy
X3JlYWwgKEJ1aWxkcm9vdA0KPiAyMDI0LjExLTExMzMtZzVhMTUxNWI1OTc2YS1kaXJ0eSkgMTMu
My4wLCBHTlUgbGQgKEdOVSBCaW51dGlscykNCj4gMi40My4xKSAjMSBTTVAgUFJFRU1QVCBXZWQg
RmViIDI2IDE2OjUxOjMxIC0wMyAyMDI1IC4uLi4NCj4gDQo+IElmIEkgZmxhc2ggVS1Cb290IHRv
cC1vZi10cmVlIGludG8gdGhlIFNEIGNhcmQsIHRoZSBib290IGZhaWxzOg0KPiANCj4gVS1Cb290
IDIwMjUuMDQtcmMzLTAwMDA3LWc1N2JiYzRkZTc1ZjYgKEZlYiAyNiAyMDI1IC0gMTk6MzU6NTUg
LQ0KPiAwMzAwKQ0KPiANCj4gUmVzZXQgU3RhdHVzOiBQT1INCj4gDQo+IENQVTogICBOWFAgaS5N
WDkzKDUyKSBSZXYxLjEgQTU1IGF0IDE3MDAgTUh6DQo+IENQVTogICBJbmR1c3RyaWFsIHRlbXBl
cmF0dXJlIGdyYWRlICAoLTQwQyB0byAxMDVDKSBhdCAzNkMNCj4gTW9kZWw6IE5YUCBpLk1YOTMg
MTFYMTEgRVZLIGJvYXJkDQo+IERSQU06ICAyIEdpQg0KPiBDb3JlOiAgMjE0IGRldmljZXMsIDI0
IHVjbGFzc2VzLCBkZXZpY2V0cmVlOiBzZXBhcmF0ZQ0KPiBXRFQ6ICAgU3RhcnRlZCB3YXRjaGRv
Z0A0MjQ5MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAwbXMNCj4gKDQwcyB0aW1lb3V0KQ0K
PiBNTUM6ICAgRlNMX1NESEM6IDAsIEZTTF9TREhDOiAxDQo+IExvYWRpbmcgRW52aXJvbm1lbnQg
ZnJvbSBNTUMuLi4gUmVhZGluZyBmcm9tIE1NQygxKS4uLiBPSw0KPiBJbjogICAgc2VyaWFsQDQ0
MzgwMDAwDQo+IE91dDogICBzZXJpYWxANDQzODAwMDANCj4gRXJyOiAgIHNlcmlhbEA0NDM4MDAw
MA0KPiBzd2l0Y2ggdG8gcGFydGl0aW9ucyAjMCwgT0sNCj4gbW1jMSBpcyBjdXJyZW50IGRldmlj
ZQ0KPiBOZXQ6ICAgZXRoMDogZXRoZXJuZXRANDI4OTAwMDAgW1BSSU1FXSwgZXRoMTogZXRoZXJu
ZXRANDI4YTAwMDANCj4gSGl0IGFueSBrZXkgdG8gc3RvcCBhdXRvYm9vdDogIDANCj4gc3dpdGNo
IHRvIHBhcnRpdGlvbnMgIzAsIE9LDQo+IG1tYzAocGFydCAwKSBpcyBjdXJyZW50IGRldmljZQ0K
PiBTY2FubmluZyBtbWMgMDoxLi4uDQo+IDY1MTY2IGJ5dGVzIHJlYWQgaW4gMTQgbXMgKDQuNCBN
aUIvcykNCj4gQ2Fubm90IHBlcnNpc3QgRUZJIHZhcmlhYmxlcyB3aXRob3V0IHN5c3RlbSBwYXJ0
aXRpb24gTG9hZGluZw0KPiBCb290MDAwMCAnbW1jIDEnIGZhaWxlZCBMb2FkaW5nIEJvb3QwMDAx
ICdtbWMgMCcgZmFpbGVkIEVGSSBib290DQo+IG1hbmFnZXI6IENhbm5vdCBsb2FkIGFueSBpbWFn
ZSBzd2l0Y2ggdG8gcGFydGl0aW9ucyAjMCwgT0sNCj4gbW1jMSBpcyBjdXJyZW50IGRldmljZQ0K
PiBTY2FubmluZyBtbWMgMToxLi4uDQo+IEZvdW5kIC9ib290L2V4dGxpbnV4L2V4dGxpbnV4LmNv
bmYNCj4gVW5rbm93biBjb21tYW5kICdzeXNib290JyAtIHRyeSAnaGVscCcNCj4gRVhUTElOVVgg
RkFJTEVEOiBjb250aW51aW5nLi4uDQo+IExvYWRpbmcgQm9vdDAwMDAgJ21tYyAxJyBmYWlsZWQN
Cj4gTG9hZGluZyBCb290MDAwMSAnbW1jIDAnIGZhaWxlZA0KPiBFRkkgYm9vdCBtYW5hZ2VyOiBD
YW5ub3QgbG9hZCBhbnkgaW1hZ2UNCj4gdS1ib290PT4NCj4gDQo+IEV2ZW4gdGhvdWdoIC9ib290
L2V4dGxpbnV4L2V4dGxpbnV4LmNvbmYgd2FzIGZvdW5kLCBpdCBkaWQgbm90IHN1Y2NlZWQNCj4g
aW4gYm9vdGluZyBpdC4NCj4gDQo+IElmIHlvdSB3YW50IHRvIHRlc3QgdGhlIHNhbWUgZW52aXJv
bm1lbnQgSSBhbSB1c2luZywgYnVpbGQgYSBCdWlsZHJvb3QNCj4gaW1hZ2UgdXNpbmcgbWFpbmxp
bmUgQnVpbGRyb290Og0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxv
b2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkYNCj4gZ2l0aHViLmNvbSUyRmJ1aWxkcm9vdCUyRmJ1
aWxkcm9vdCUyRmNvbW1pdCUyRjI3YjNlNjc3NGZlNDQNCj4gN2RjNWViMTJjYzdmNDk4ZWM4ODY4
ZWI2NWM5JmRhdGE9MDUlN0MwMiU3Q3BlbmcuZmFuJTQwbnhwLg0KPiBjb20lN0MzOTdhNmVhOThk
YmI0Yjg5Njk0YTA4ZGQ1NmI3ODRlOCU3QzY4NmVhMWQzYmMyYjRjDQo+IDZmYTkyY2Q5OWM1YzMw
MTYzNSU3QzAlN0MwJTdDNjM4NzYyMDY4NDIwMTA0NzUyJTdDVW5rbg0KPiBvd24lN0NUV0ZwYkda
c2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXNJbFlpT2lJd0xqQXVNRA0KPiBBd01DSXNJbEFp
T2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95ZlElM0QlM0QlN0MwJTcNCj4gQyU3
QyU3QyZzZGF0YT0wekJiMWV5VktVN1Y2SDE3aSUyRktMTGRuSm13c0tpMCUyQnIlMkY2UQ0KPiBZ
Q0NBWmF1RSUzRCZyZXNlcnZlZD0wDQo+IA0KPiBIb3cgY2FuIHdlIGZpeCB0aGlzIGJvb3QgcmVn
cmVzc2lvbj8gVGhpcyBhZmZlY3RzIGlteDhtbS1ldmssDQo+IGlteDhtbi1ldmssIGlteDhtcC1l
dmsgYXMgd2VsbC4NCg==
