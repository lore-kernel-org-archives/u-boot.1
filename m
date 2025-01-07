Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD8E77188
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 01:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C24E805FA;
	Tue,  7 Jan 2025 02:40:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="J2MrkWHS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C22C0805FB; Tue,  7 Jan 2025 02:40:03 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF964805F5
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 02:39:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noc0D05fBO28WHj9rDUDJ+KEJB186S+U8fIgOX0K3TnTev2LGlV2HUPVj3PXs8QvgqUwh1ifmtaaD0njJM6ZAjdLtyh6wAz9+jV6n9fYFIrB4aXn8S1aJejt9TwSyW90Q9GlocpXio7DkJkQe47wevUCtGvWDELUYB+KaL0wr5XKeZiw482q024K4Rrf96XO3u0z0MeGZjNhddz2abVIUg43eZtOqvFvBvGsEEvfpCqZm3deBegy23ZOFGyPq2cXXX1VBvdTq39d7ZPf80+3pd7J22rOpvVPkJmvG1A7euDARaTggm1uRpbbAf8M0ylI6g5QUQ4eixR1ikwiH02emA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVCyu9Lk2oMRtmI8lITyUWoWlo7OCRS+ffcxgr9V4Ik=;
 b=fyr63PNDlww2ygRX177+4CUH4Qv6Kj2ki/nj7T0Rwr8T/IcOcTNcoMyHQ+8TvyHlFvXIFEXWs78Kywd6i6i179J683YP9NpeETaRnzDquzgoDjvKLXTpTAUIN0GUf8JIXibvMU4wgqov8mszmbofpdUwLoh9lvUzrSmFf3htFInG3QDUV/gkD/Nf2WQx5DDjwkhMKCbXtmuMDuuZ0rqkiass2q8cxFT48ghqFvHoc5kFO5fgoGWyBQelo0QBOVHWHKyTFrNELTkVDBEmnLpbZrgE86LHVcn4BkCjo3wsaJCQDQ3DDBGpFbsdm8154rjy2BnHgvqcq/sP6xFE6me/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVCyu9Lk2oMRtmI8lITyUWoWlo7OCRS+ffcxgr9V4Ik=;
 b=J2MrkWHSN6XhXI2b849w7sWHPhJuY9oGp4+VrBeJe+eQrNRgu0c/cPmDk7/HV4bgW03ATeeH5h5qpCGjdtK1hu+V5d4RuFDgnG0b2FrQQ68ZvKITG/MasYypyfZ3SlSKQfs+XS4V37xQWvs7Byz3wenm04D/6UmjRDJXpZVLBQtUlX0oH45imAjXWE66qS3XImMCVkCCeyvCB+fQeczuf25ip9otkvZ2bCF8xEO3GExRZucNWLgu10iu/EBngHImXNfNzdK8KFhW3UQGr/KZbqQ5x08vIeiZx3/AhGdG44XpFfX5aCF7nRXi3bYHI6Ovv7WRduCOqK8zP8qi+01sRw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6955.eurprd04.prod.outlook.com (2603:10a6:10:11d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 01:39:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 01:39:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Thread-Topic: [PATCH 00/12] imx9: switch to bootstd for i.MX93/1 EVK/QSB and
 i.MX8M EVK
Thread-Index: AQHbXld6xCBQC4CEyE6YAZmNM/UFurMHAamAgAH3jID///dggIAAAZTggAC6eoCAAOBAcA==
Date: Tue, 7 Jan 2025 01:39:52 +0000
Message-ID: <PAXPR04MB8459A3864AB97715CE45D52B88112@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
 <CAFLszTi_px3qRGvpcC5WKLw+r5BqqQciOP-Vg1LEN+rt9876wQ@mail.gmail.com>
 <20250106013311.GA8414@localhost.localdomain>
 <CAFLszTi2ya3V4SDfpZxLzzyAdyM9KN0MGuZPnK2XeO8wRNw69w@mail.gmail.com>
 <PAXPR04MB8459B6A69CA0713B0B51058988102@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
In-Reply-To: <CAFLszTg8UHbgHnFM-6JjYFK5pd_+HW61_jzMM-eeV9+hQgOspQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB8PR04MB6955:EE_
x-ms-office365-filtering-correlation-id: 824fd66a-d3e6-4ee6-0e1f-08dd2ebc2ecb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?RXh4My8xbEFweVcyNWFZWHZGYVA5Uk13MkRJYlNLbmxEUDlNUE9hOVNEVmp1?=
 =?utf-8?B?Q1NObVNuNHpWckt5VVE0d1ZpQktKN1VuTWl3eVYySS9mc3VTeW93MzZteE1S?=
 =?utf-8?B?Ylo1NXc1dk93UytUVFpuRkZ2NGI4NTdGa0xtYlE0TU1WSnloOFlCOTZMNzVL?=
 =?utf-8?B?ci9oRVNXV2xJbFRybkpQbWVINFVvSlB1SFVMWGNrdEFxdGcydm1jWUdPRHd3?=
 =?utf-8?B?aWVwOGc5THhLV2NWS25xTVpjUEhGaml3bFZaZWFkQ25yUWg2M3pwR2pTKzQ2?=
 =?utf-8?B?MllRS1JFVkJFVk5FcVdHd3RqR0N0UGxYT041YTdGcnBTT0RQUmx1QzFncjlr?=
 =?utf-8?B?SjUzRmtTc1hYOFhpbjRwYVVCRjVIcWtkU1NZMTJjWFBWbHhTQXRxMWlaV05K?=
 =?utf-8?B?QmV0ZitWVlZwYlozbU44Mjh3NTFtTFZjTHdDc1RZN2lYOUFMTlJTck9wVm4y?=
 =?utf-8?B?ZVlZY05GNFpDeGhrSkc0RTJYYmlmRUtESlZ0VTgzZ2tuY2wzRHhBSmQwRXNo?=
 =?utf-8?B?ekNwa05qN1VBYUl0T2dXNmRHRi8vcldMMzdQcHRPM0lUdzkvZ3JWMTBUSmtF?=
 =?utf-8?B?NHpPQ0lGKzZCdVBLMXZhYWFTbHgyQlNYREVkYWJXTWo4bEk3RzBlK0ZiU1Iv?=
 =?utf-8?B?V3NLaGJnWmVyODl1LzY3bjlsTE8rWVc3cWJqOEg2d3cyK201bDdMMzJhUU04?=
 =?utf-8?B?cnB0c21JblFaQUEweVI3ejk2aE91YndtZkhTenVqZFh5NDlCTkM4UjVCNkVY?=
 =?utf-8?B?elJjUkE4eVV0WDdDS21tT0Q2ZHk0OHIrOG0xcENHM3BzQmUrRGxNWENBQnBY?=
 =?utf-8?B?c2xlV0Qwc0JiNmF6eVJuQ1ppR0dKT1ZiTFkyelVjV3YyK0VBcExkeitYN0ly?=
 =?utf-8?B?ZXRyRTBRSklpVXVxQlF3TU42TEk5cHZLTzdEcTF1d0dNcVAraU8zdzlIdmdY?=
 =?utf-8?B?VWxGRlJKN2JMMjZENk9adHRHazduWkc1VitBdjh4R0g3NC9LanEwQ0liaUlC?=
 =?utf-8?B?NExQUFFISFpYK1NITW9CT0VJaDg2d0lKZXZ6OHBKUG1CeXZTU0hIWGlHTyt0?=
 =?utf-8?B?dUFNamhKMkEzZHJBZXp5a1NSUXlpY08vbnByeHFhdGQ1MjFkZHdPZXhCRHVi?=
 =?utf-8?B?QURwOVJXQnFyNno1WTJrN2JCZjVmRmxvMjAxcU9aNGNzZUJya2hOMG1TZlhL?=
 =?utf-8?B?QXlNa0dJY09mK0xza3RiK2xYc1BYWEVwbzFZQ0d1dmpWK0VXUytCTVJ4RkJG?=
 =?utf-8?B?Z1NWcTdnc0hBVFU3V3lwZHJSbU5lc1FGYzVKUFNnL0ZDNExhMlg3eXhHYjcy?=
 =?utf-8?B?UEN6aittUUVaems5TURZV0VlUit2QlM5Zno3NHVRcy95TCt1dituUHVTa1d5?=
 =?utf-8?B?eW5YNDl5M1lDZlRRV3dkZi9aZ0hRKzdka1VmMTRtd0lvQVBwR3kvdWNQOCtk?=
 =?utf-8?B?Yld5bHZ6dzBuaDl1a3lGemN5MlpMZzlsYjhTbmFud0R6TUNSU3AwUVFQcTZr?=
 =?utf-8?B?TTY1Rml1MEcxYlY1eXpGUHJ6VEN2cVBDd1M0bDgvT3AyQnJEYnBqaUFTZXZI?=
 =?utf-8?B?SWRERlZBaDhNWW9Dcm1nMWt0MEttNGhTSk8yZVNoeWVTZUtmREZYVVZTdVpO?=
 =?utf-8?B?YXE0MHVudjUvbDYvQ2s2eC9jNEJqMTJQOGtsQWI3bXg3ZE1RUVFtWFl3VC9S?=
 =?utf-8?B?Z2dWbWlwcU9DenhQTjl0VE56SExhWHJsTWRGUG54Z0xQZkI4MGFNV3NyZVBy?=
 =?utf-8?B?VHdTTWhaV001SGhsTm8zWWdYSitGVWZtaTlPZmpKZW1ralI4NkJSeVZDNnhG?=
 =?utf-8?B?bFRFeGJ0M1B5ZHFRSkp3ZkFvUndmWDVUVVZwejJFN2lBY1pyd0JkOGVoRE51?=
 =?utf-8?B?V2FNQWR1U2M0MWFnNmFvOHp3SmxiNHJ5a3F0cGNVSG82Uk5qL1JsRkJmQkJy?=
 =?utf-8?Q?EB0MWfB1dVw3zNNl9nwn9WETBfMF9i8K?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NndINE5IVEc0b0U5KzRteTF3OWpZWms0MDU4V0lDejNDdE1yYmlLSm9RbHkv?=
 =?utf-8?B?Zyt6K2Jmcy94T1NmK2tDaGJVY21SRlFmKzRUZll0ZiszNjYrSzlvRnRYOWxk?=
 =?utf-8?B?V3ZzcnFpTTBYTjArUHJOZCtRcEtSbXh5RVZiSDNOSjdjSHBNem5vTWZNd3hm?=
 =?utf-8?B?K016ZlQ1N0ppc1VWT1U0MjVsMm1qQUtyVUwwT0R1cFBKZmZUVmVBMk9BQkMy?=
 =?utf-8?B?a1pLQVhicHBCVjVRbHJNSWwyeDh5V2h1QU51aVZyb3NzVFBtZGNnVE0xY211?=
 =?utf-8?B?RlBmMEZGRGk2ZlZxamdwYVNkQlJVVzdTRDc1Y0JWVUNNMVlPUmJzT0M5cnBy?=
 =?utf-8?B?ZzIzK0hzZE1jRkZXS1dWRHBLRjgzN3ZPN2NJQk14OTlsaWlQR1Y4dC8vdjQ5?=
 =?utf-8?B?NlVYR2hzVmhpS1Q4aUlTL3QyNUc4dzhpZGsxbXEwZ3ZKL0tqaDdodXpEQ2RN?=
 =?utf-8?B?SFpuNENLU0hEVkYydFUvK2FJVFFqcGwzcFd1OXdYVVVpeVQ2UWdocHRiZStq?=
 =?utf-8?B?d2MrL0tvYWhjWmlhQ1NGRm9TTVczTDhVLzIzdmlhc3dDMEpxM2dqMyt1ZXVk?=
 =?utf-8?B?Sm1hTDFJM0ZSQnRsNm05TjJ1ZDF0Y0FmbFlXWGdoTEl6eVduTVk2VFI1alNP?=
 =?utf-8?B?aE92bCtFbFJKZmYzQlVkSlN5QVU0enNzaVVUN3JzU1NWdGlFQ2xiUnBjdE9w?=
 =?utf-8?B?V0dDVXo5ckI0aEszZk1Ob2tka09FTngrR0kyWXk1NDhGc1YxMWdsWUF4Q1hY?=
 =?utf-8?B?dXlLUGFwYWthR3N2NnJSQ2dmL292dUh6U3pMVFdlZWh2T210UWRJbUpWN3hP?=
 =?utf-8?B?YklpYmpIWE1PT1pCVjRnalZsOVEvUmN0eFBZTXR5Z2ROWk8vR3M1dDl0a00y?=
 =?utf-8?B?VzRyOXQwMXpXaEsyWXEvZ1AwVlRWclkrYjVScVJHbUNsd2ZXeldPU1doUGtY?=
 =?utf-8?B?cHR2U055MDJHMWU4Sng0YlpmbHN1Q0hQLy96aFVTU2ZWN0sxTlQ0ME5YRm9Z?=
 =?utf-8?B?L3RPWnFoRVNzUHdVS0FqRDd0ckpjK2pTQWN0eUUxdFlJSmF1RUxPSktiSitT?=
 =?utf-8?B?VVp1YU1DNzdibGpGL000OFhSS3lUTE9NelFvYTdoVGxtaFl1WDMyYVFwd3ZY?=
 =?utf-8?B?RFoxbzEyUFZpandYU1VnSjE0MEV1WlgrVXIzeHNRQ3lSZ0RzMDE3Szk0bTNF?=
 =?utf-8?B?cjY3Zkc4dzhFakpra2tzaXc1cm40YURub0prUHhvQitWYmdRMEIwOTJLQU9k?=
 =?utf-8?B?ZUxMenlPZkJjdnIxRGdhdVhBdjMwQXVMSFQ0MjdwSW54aXV1WGFTNUQ0R2M4?=
 =?utf-8?B?YmtvNUgrN1YrRmx2bmgvYWVtNDRhMWIvU3pRbmpnL3dmSGQxWWFPNUhQOFYv?=
 =?utf-8?B?UmhNQ01YdHdOWVJZd3g0djBGZDNLNHBzNmMyekM1elRUc3BTMkhwcnFvNWNP?=
 =?utf-8?B?QlRlb1B2WkxQaWdxcFlqeTRkZmgxc2xrWFN1V2s1a2cxakh5amlPcmhkdWxJ?=
 =?utf-8?B?MmdOMWIwOFlzcTBWc3ZCTEltaytKbVRmZlptQS85SU9YOEE0bC9sdUZFWDYz?=
 =?utf-8?B?OXM1d2pSMnZVRmk1VTIwQTdEY0JPemxkOGw0VnN4YWdmcXNweVFTaUlsLzlF?=
 =?utf-8?B?VTV2aEVuMWRFeEZSR2FhWGMzQ2VRWW0wa0p6NzBOa2t4cXdFdUJyaGxWVGJ4?=
 =?utf-8?B?YkdSSXl2djlxUVowdHFjZG5Tb0FZWSthcXNHM1VpMVpIZkJNc2RZK3RDWGNj?=
 =?utf-8?B?eUp4MDBUUzJGV0duVmxJYVdvd0oxMXgzU0ttdkd2Q3k3Z0RKZDJpOUo4a2Nh?=
 =?utf-8?B?N0JsTXdwcU12S3hNVUNZWk1TQTl1MUNvK3dGb3VQUDdRaVlmMHlqUVJhTTZ0?=
 =?utf-8?B?T25RNkJFWTJ0WUZDNXB2Q2FOaE5DM0ZtNHltb21JRGk5WGdZY3dxQ1NtRjUv?=
 =?utf-8?B?aWM3Vno5aGIzZVZWUTN6c0RLZXJBSnkzZmk0QzlsQkt1T09SQkp2SlltNW51?=
 =?utf-8?B?a0Vsb1BJWVZRVHo1cHFyVFVkN3k2SHhRQ2lia0NHRmFDWWpPYVlDL1AzV3V2?=
 =?utf-8?B?RzI4Vnpxbjc2Umgya2ZoZlRVTVcwTHA5YVpJZlNEb2FxZHVENkpwazFQRUpk?=
 =?utf-8?Q?u08U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824fd66a-d3e6-4ee6-0e1f-08dd2ebc2ecb
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 01:39:52.9757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcnjwJUYHhuHeGUvVbsKUcuvLN2IvtMs3YUK/cFDiCYX0GjBxEosNUPAiFm+xsQWgvFyhoR45sAsCtxFk73m1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6955
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

SGkgU2ltb24sDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xMl0gaW14OTogc3dpdGNoIHRv
IGJvb3RzdGQgZm9yIGkuTVg5My8xDQo+IEVWSy9RU0IgYW5kIGkuTVg4TSBFVksNCj4gDQo+IEhp
IFBlbmcsDQo+IA0KPiBPbiBTdW4sIDUgSmFuIDIwMjUgYXQgMTg6MTQsIFBlbmcgRmFuIDxwZW5n
LmZhbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCAwMC8x
Ml0gaW14OTogc3dpdGNoIHRvIGJvb3RzdGQgZm9yIGkuTVg5My8xDQo+ID4gPiBFVksvUVNCIGFu
ZCBpLk1YOE0gRVZLDQo+ID4gPg0KPiA+ID4gSGkgUGVuZywNCj4gPiA+DQo+ID4gPiBPbiBTdW4s
IDUgSmFuIDIwMjUgYXQgMTc6MjcsIFBlbmcgRmFuIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4g
d3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IEhpIFNpbW9uLA0KPiA+ID4gPg0KPiA+ID4gPiBPbiBT
dW4sIEphbiAwNSwgMjAyNSBhdCAwODozMDo1NUFNICsxMzAwLCBTaW1vbiBHbGFzcyB3cm90ZToN
Cj4gPiA+ID4gPkhpIFBlbmcsDQo+ID4gPiA+ID4NCj4gPiA+ID4gPk9uIFNhdCwgNCBKYW4gMjAy
NSBhdCAxNjoxOSwgUGVuZyBGYW4gKE9TUykNCj4gPiA+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4g
d3JvdGU6DQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4+IFN3aXRjaCB0byBib290c3RkIGZvciBOWFAg
aS5NWDkvOE0gYm9hcmRzIHdpdGggYQ0KPiBic3BfYm9vdGNtZA0KPiA+ID4gYXMgZmFsbGJhY2su
DQo+ID4gPiA+ID4+DQo+ID4gPiA+IFsuLi5dDQo+ID4gPiA+ID4+DQo+ID4gPiA+ID4NCj4gPiA+
ID4gPlRoaXMgYWxzbyBzd2l0Y2hlcyB0byBhIHRleHQgZW52aXJvbm1lbnQsIGdyZWF0IQ0KPiA+
ID4gPiA+DQo+ID4gPiA+ID5Gb3IgYnNwX2Jvb3RjbWQgaXMgaXQgcG9zc2libGUgdG8gY3JlYXRl
IGEgYm9vdG1ldGggZm9yIHlvdXIgdXNlDQo+ID4gPiBjYXNlPw0KPiA+ID4gPiA+SWYgeW91IHdv
dWxkIGxpa2UgdG8gdGFrZSBhIGxvb2sgKHNlcGFyYXRlIGZyb20gdGhpcyBzZXJpZXMpLCBJDQo+
ID4gPiA+ID5jb3VsZCBoZWxwIHdpdGggYW55IGlzc3VlcyB0aGF0IGNvbWUgdXAuDQo+ID4gPiA+
DQo+ID4gPiA+IEkganVzdCBnaXZlIGEgcXVpY2sgbG9vayBvZiBib290bWV0aCwgc2VlbXMgbmVl
ZHMgZXh0bGludXggb3INCj4gPiA+ID4gYm9vdHNjcmlwdCAoYm9vdC5zY3IpLiBCdXQgYm90aCBh
cmUgdXNlZCBvbiBOWFAgaS5NWCByZWxlYXNlIGFzIG9mDQo+ID4gPiA+IG5vdy4gSW4gTlhQIHJl
bGVhc2VzLCB3ZSBwdXQgYWxsIHNjcmlwdCBpbiB0aGUgVS1Cb290IEVOVi4NCj4gPiA+ID4NCj4g
PiA+ID4gRG8geW91IGhhdmUgc3VnZ2VzdGlvbnMgaG93IHRvIG1vdmUgdG8gc3VwcG9ydCBib290
bWV0aC4NCj4gPiA+DQo+ID4gPiBJJ20gbm90IGVudGlyZWx5IHN1cmUgd2hhdCB5b3UgYXJlIHRy
eWluZyB0byBkbyB3aXRoIHRoZSBib290Y21kLA0KPiA+DQo+ID4gV2l0aCBhIHNpbmdsZSB1LWJv
b3QsIHdlIHdhbnQgdG8gc3VwcG9ydCBGZWRvcmEvU1VTRS9ldGMgYW5kIE5YUA0KPiBZb2N0bw0K
PiA+IHJlbGVhc2VzLg0KPiA+DQo+ID4gU28gYWRkIGEgYnNwX2Jvb3RjbWQgYXMgZmFsbGJhY2sg
dG8gcnVuIE5YUCBZb2N0byByZWxlYXNlcy4NCj4gPiBOWFAgWW9jdG8gcmVsZWFzZXMgbm90IGhh
dmUgZXh0bGludXguY2ZnLCBub3IgYm9vdC5zY3IsIHdlIGp1c3QgaGF2ZQ0KPiA+IHNpbXBsZSB1
Ym9vdCBodXNoIGNvbW1hbmQgaW4gYm9vdGNtZCwgc2ltcGxpZWQgc2F5aW5nOg0KPiA+IHJ1biBs
b2FkaW1hZ2U7IHJ1biBsb2FkZmR0OyBydW4gbW1jYXJnczsgYm9vdGkgJHtsb2FkYWRkcn0gLQ0K
PiA+ICR7ZmR0YWRkcn0NCj4gPg0KPiA+ID4geW91IGNvdWxkIHdyaXRlIHlvdXIgb3duIGJvb3Rt
ZXRoLCBlLmcuIHVzaW5nIGNvbW1vbiBjb2RlIGZyb20NCj4gdGhlDQo+ID4gPiBvdGhlcnMuIEZv
ciBleGFtcGxlLCBib290bWV0aF9zY3JpcHQuYyBzaG93cyBob3cgdG8gcnVuIGEgc2NyaXB0DQo+
IGFuZA0KPiA+ID4gYm9vdG1ldGhfZXh0bGludXguYyBzaG93cyBob3cgdG8gcnVuIGFuIGV4dGxp
bnV4IGZpbGUuIFlvdSBjb3VsZA0KPiA+ID4gdGhlbiBjcmVhdGUgQyBjb2RlIHRvIHBlcmZvcm0g
eW91ciAnYnNwJyBmdW5jdGlvbiwgZS5nLiBhIG5ldw0KPiA+ID4gYm9vdG1ldGhfYnNwLmMuDQo+
ID4NCj4gPiBJIHdpbGwgZ2l2ZSBhIGxvb2ssIGJ1dCB0aGlzIHNlZW1zIHdlIG5lZWQgcHV0IHRo
ZSAicnVuIGxvYWRpbWFnZSBhbmQNCj4gZXRjIg0KPiA+IGluIGR0YiBhbmQgbmVlZHMgYm9vdG1l
dGhfaW14LmMgdG8gc3VwcG9ydCBpdC4NCj4gDQo+IE5vdGUgdGhhdCBteSBzdWdnZXN0aW9uIGhl
cmUgaXMgYXMgYSBmb2xsb3ctb24gdG8geW91IGN1cnJlbnQgc2VyaWVzLA0KPiB3aGljaCBJIGJl
bGlldmUgY2FuIGJlIGFwcGxpZWQgYXMgaXMuDQo+IA0KDQpJIHNlZS4NCg0KPiBBbnl3YXksIGFz
IGEgc3RhcnRpbmcgcG9pbnQsIHllcyB5b3UgY2FuIHVzZSBydW5fY29tbWFuZCgpIGxvdHMgb2YN
Cj4gdGltZXMgaW4gdGhlIGJvb3RtZXRoIHRvIHJ1biB0aGUgdGhpbmdzIHlvdSBuZWVkLiBGcm9t
IHRoZXJlIHlvdSBjYW4NCj4gcG90ZW50aWFsbHkgY2hhbmdlIHNvbWUgY29tbWFuZHMgdG8gZGly
ZWN0IGNhbGxzIGludG8gdGhlIFUtQm9vdA0KPiBmdW5jdGlvbmFsaXR5LiBUaGUgaWRlYSBpcyB0
byBiZSBhYmxlIHRvIGxvY2F0ZSB0aGUgYm9vdGZsb3cgYXMgYSBzZXBhcmF0ZQ0KPiB0aGluZyBm
cm9tIGJvb3RpbmcgaXQuIEkgYW0gcXVpdGUgaGFwcHkgdG8gaGVscCBhcyB3ZWxsLg0KDQpJdCB3
b3VsZCBiZSBncmVhdCBpZiB5b3UgY291bGQgaGVscCBoZXJlLiBBcHByZWNpYXRlIGluIGFkdmFu
Y2UuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IFNJbW9uDQo=
