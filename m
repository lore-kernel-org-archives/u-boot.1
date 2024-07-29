Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F9FC3DA49
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 03:14:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D82C2887B9;
	Mon, 29 Jul 2024 05:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="QgfecoO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C53B887CD; Mon, 29 Jul 2024 05:14:52 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21706887B9
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 05:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjOoF8LDVwt7moNDjiSOj+e9/B+BdVeRECruWFLZNa85SlCAoPhnl93h8jxx3eEA4xjyBB4JcncJrhrI/bLhn+U+iWZ9vHZ3Q/uoGezEPD5/tbFaRuFklFv2UDEYK4A6Xr+KscXLgT/EI4LK+4lYsOYF/6eig/Ml6KXxotxZjTQg4+SbEZB9Oo1smACV+yFRfjD3b5fskNeRcll47eCJXdj64QZV1JwFrKOQylXQu8B5W86ulf6q5HRz4iXoMesdbcAlxMjpq8+Qxq8pF/zNLBW5Xq+pj6Zddke81cWERu2gcib5alAHTNVQE0Uhcy7FtmNgH224cRHlHbtiVnC1dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvvdEs8MZwNzrj9RqFyj/UzIjm07RSDReKR4XsfDtEU=;
 b=dCKNFF35jMjqKQ7S9FYoidj+w8GZ+SOqJwg30syjK6G2OsQc56aLdbUOmRbvQvV7Wp+BvVg+MH+nw2E2AMVWa268JkNksq8I0QarE2hfLtHV+2M0VOncyOIc42tXr7qIDuKPntuk95wuPedKB4CeW3uo9b9ITr9iZOp6njMDzeyNc0osFtlPmf4eAsidjKUV5NrN3Z3OeIr1oTqxj36Jr1oG47oK3rpQ/PsFDggVkPjmmJMyQ/ZwyLnXS/B/Y5IOGu9lpnQJZd/CIF4bYPE4RNh8Ob0HTgpQy95JmFO1pqoO7M0gGIXlZmzjUUp5pxU1s/cTlr5tFNNEI6l9qSifLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvvdEs8MZwNzrj9RqFyj/UzIjm07RSDReKR4XsfDtEU=;
 b=QgfecoO3Bs7+cId2rsku1tyEgJdxybVXMRN1XgyheGNgM1fNVIV/AOyy68KKOlQC3nNgLqD0FjtwsLcBqrsbqEHoG7a8sSVtF8aLyoJwt0p/fRBBdkMa0xVaR38NgH2wvZmQTdvmHVKZMLTxMxMmlsxA++s7uSzBD6skVqfuKizBXrC/RlBo61sYdXSpx9Yr2NZw94fiHFyExELkIXL8BU0DBl3s6YVOk5Z/YKUeWsIn2wWKzEyT4vE3nux99KYgtNMBIddZHH3srgCrd7Q+gsIpGZXNd+7hNk0RZgk5hg/tqxmH3wH5CudLYLkjQBQWGj9bIreHj+FkI1YXMfiNsg==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Mon, 29 Jul
 2024 03:14:48 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 03:14:48 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, Marek Vasut <marex@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>, "seanga2@gmail.com"
 <seanga2@gmail.com>, Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Topic: [PATCHv2] clk: imx8m: register ARM A53 core clock
Thread-Index: AQHa30Pexqt2O5+IbECip2K9bcxtxrIJCysAgAAa8iCAAFLTgIABUJEAgAJByoA=
Date: Mon, 29 Jul 2024 03:14:48 +0000
Message-ID: <DB9PR04MB9236C42A2E595ED1D10B575A84B72@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240726102954.14546-1-Zhiqiang.Hou@nxp.com>
 <0a40ee6f-1fa1-469b-ac9a-f7d8b6ca9f40@denx.de>
 <DB9PR04MB9236DE687B0FB9543836F55084B42@DB9PR04MB9236.eurprd04.prod.outlook.com>
 <2abff6ea-7669-4023-b71e-bb9605ffb214@denx.de>
 <CAOMZO5C+b0-9FSdugkeje70RozqnedPNQoHfPPcuvwuJ8MfRvw@mail.gmail.com>
In-Reply-To: <CAOMZO5C+b0-9FSdugkeje70RozqnedPNQoHfPPcuvwuJ8MfRvw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AS8PR04MB8465:EE_
x-ms-office365-filtering-correlation-id: 2f933379-9a9f-46f9-b9bc-08dcaf7c9a85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MjZWVWVweWhpUFJPYVpCYnVIWG5OaHZCb0M1WWVLQWFsRmtDeEVMRmZrZTNX?=
 =?utf-8?B?NVRvN0VpRDBQdk94NEtuRGFwelgrQnhRNFNBRzNmQ01tTG9ObTF2dHRzalUw?=
 =?utf-8?B?b2dxY29kYVNUWlJOUFRoUGhJb0JVZlNzNjMwemVhMzNnVlFOTWhiZVJkVXN3?=
 =?utf-8?B?VFBCWW9WYnhZREVrU2FLcGROTG1tM3g2Ui93QURUNkxwbXI3YmpmTjVna0Q5?=
 =?utf-8?B?Ym5QRlE3Qk93dzFNOGZwcWxZMTZNOGxjK1piQ1BaNHZteWM2RWZuTmN4bVdD?=
 =?utf-8?B?VWhtS2RGQ0dqeGR4TlFIUFVrNkNnTGV5MjdqM1llQm54Y0pRV3JKSkpjSkYw?=
 =?utf-8?B?WUl2U3RTY0hiQXFTWmZmRHN6d1VmWVU0SG5zT2t0VC9STFBLUTd0a0RoamY3?=
 =?utf-8?B?Ulh2RkxUd1oxNGtvWnZXdkV2VUpUSHNtM2o2UDdNWTZJRWZwOWdwd0lEMmpy?=
 =?utf-8?B?Tmd1amtCeFdrN0pHYW5vV2NhVlFZdDZuc0hNcW5YcWF2UURLV09uL3N4azBF?=
 =?utf-8?B?eFpqeTliQllGK2IvVXFRWFkvWEVwZU14ejRXS3dNYkVwc2YrVDZiWXlFZnlY?=
 =?utf-8?B?ajNPM2NqMkh2ZUtwSjJZbmFkQlkyR3gvcklEUW1nUWZQREdiOTNacDVmUXE4?=
 =?utf-8?B?MStGOWpZK2xyS21yTGJwYUw1SEpiRGtzQW5SVHhtdHdXZndQcytRbzBXVDJ0?=
 =?utf-8?B?Q0x3K09BNGRsWG0vbCs2QW5sMitlU0xSTlI5K1NzTjFZYWF2L1NseFRrUmsy?=
 =?utf-8?B?VGNUWVg0djBlMVJyRjVoZVBMQkxkM0JwRENLcnl4Vm1WNVdTaVo0VDYxbkQv?=
 =?utf-8?B?NEJTRFJxOVZpSnJWbTVjMzRYTFdyYW5IdHllWWt6L2NPZ0RvTllVZS9LVitJ?=
 =?utf-8?B?R0d2dmt2KzZIelIxZWF0V1ZSL01qZEFOcjFSRWdHNzVoWEVoWFIzSStJc0tX?=
 =?utf-8?B?MWNSN3ZFbjMzLzFBeHZXWGlSRVY4dGlGdW40WnR3a3J0aHRpWXZHY2lTS2Yy?=
 =?utf-8?B?VHcyeHloNk94dk1ZYXg1cWRWWWd1ak1zQ3RPRUhsTXlBdkhSZTBvdlhRNnUr?=
 =?utf-8?B?aHFDKzZVZnowaElXQ2pwcllHZUdWSk5kTVRCUGZaeUE2cGI4Z1VpZFBrNGl4?=
 =?utf-8?B?dVVjMFI2TDYxNitaemZBYlV6UTQrc0NOZml5VWpuWUh4STllMWFpOGlqSE9z?=
 =?utf-8?B?MnAzK3NwVEgxNFJnSGFRS2RaNFdoRWYyNmV3YkVJekcxYit3ZWlOQ3JUd3do?=
 =?utf-8?B?U2NDRHRMa3NuN0R2Tmo5UUtZMVcyQUV0R2lKL2RmSFNOeHFJZ3lzQXV1Rktu?=
 =?utf-8?B?VWlvcnlrY3NCOFFwSXVDRTNmY3d0NHpNMkYxckhKcGw3bXl6V3F3Z0NYcmFD?=
 =?utf-8?B?S2hmWG5ydmhzaFQwSGNLY0d3ejhLT05mSDI2WjlKUVJndzVMOVBpdE9mSEZi?=
 =?utf-8?B?TVZVcEpqTFpCRXJHVDRsZzhoVG9BZHoxR3JIWkNkcHJhQzZOdmhlbWdBL2Jo?=
 =?utf-8?B?YnBBQU5IV2RZM282cjN1TGtyZjZQNVc5VU1xSXZPc0x2a040S1BFa0RQS1dk?=
 =?utf-8?B?aW1QRHVWbVhrUFlYK0w1aFVwYjRTNE1lYlZYNWpQK1Aralk2R0VHQkdYcFJY?=
 =?utf-8?B?UjUrc1UxRCtVMkRwMk1tODVCa25ScHdubXNtQmUvd1dDcWYvMmJnSDVLalpJ?=
 =?utf-8?B?dnYrbzFYbytTRThaTjlETFZTcHZpMzZRZTRrdzZKd1dNM3lHTEVSV1pwT0pR?=
 =?utf-8?B?MjcxUVJIY2MyYndOZWszZnZibkE3ejdLYTErd3doWCttYzdCTkdlekNwT0F6?=
 =?utf-8?B?NGEybk9PbEFITWw4TFE5WUU2ZmY0SWZrUm5jZm01U3RERGlFbVVaaTczMnBP?=
 =?utf-8?B?MW1PWS9oM2g4SW4vclFOaXNkUDFveHZuckgzRjNZdlZuMlE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEtqdWUyQ0pONUVGSU5kSjFCVzNWL0M4b0hTSkloU0tVS3RUb0NCeFlWMEND?=
 =?utf-8?B?RGkxOC9PaU15M3lOKzR4NjBPcGxNVVVSeFM5bVd5THVKSEVyTXZMQys1RG9N?=
 =?utf-8?B?ZGlLdUFDb0VWOGtxY2FaYXlaS2hMS0JTYWNaRURTSjNMaC8wdGUrM0g1cEhv?=
 =?utf-8?B?cERUVmhPUFFoZzVOemc0ejFZYXdHaFQvMnl1UU5DN3Z5cUU1d3ZVaUc4cnVL?=
 =?utf-8?B?UzF0aWE4K1JmTDFMSjBsZ0IybGRWT0psQWFSRnJ0QmxELzk1QXpBQ2xJaTNY?=
 =?utf-8?B?bjRKQTMwTXIzR1NMaWtGR1Z5bEFLYzRzaUI5bjlsRG9OTFB3azBEVmVnOVJS?=
 =?utf-8?B?cVJDQmhrU2hHeW11dTRFT1dLMUpqellkczdyWDZHT1RvUGJuMW1UaFVSQWti?=
 =?utf-8?B?K2MxSkRJUEFLc1F2dks5WSsyQkx3MTY2SVcvQ2k0Uk14bW5wUkdrUVNNUHJl?=
 =?utf-8?B?a05KTmxtNlJSQjVUamZwRmdRYTdKYjFUekd0eWE0WFVsQ1FTUDFMR2RMaFMw?=
 =?utf-8?B?Yzl6eXdKZDBUOHMzV0loNWRnTVJtYTJsZjFBK1duUCtIQ21NVlpYRHU1QUV3?=
 =?utf-8?B?VzdFN0N3WkszUmw5aHJBYVhRcGJuVDJINjZjZ1lPREc5eHFxVjBkVWczcURo?=
 =?utf-8?B?Y3EyUlNyZDlDY1FjNjhNZW5wdmxmaUJlMmdWWHNpYytSYzExdGp0MmJMYjB2?=
 =?utf-8?B?bWE5MThobFZzQTMwMmxOazhDcnVHSllzanZWQUplU1ltcDN5YlJtU05mUFli?=
 =?utf-8?B?TjRtWmRKajA2cXRZYnEyS3BpMGI3cTlTVk9TNVpIOEJZbmNna25zV0ZwYkd3?=
 =?utf-8?B?ci92Ymx6WVR6eEQrd241eG1GdnVUSnNnbXVxWmh0SFFMOW1Vd01zTzljQU5v?=
 =?utf-8?B?ODFiYTVnb0J1VUVvOEh5UVJNMkRwTlpTSURKNGZUeFNOQnYvcVo3VmNLa0RY?=
 =?utf-8?B?T1ErUXlLYkY0bTRVaUh4R2VJbm9ycmEvdmxYaG9xZnBMd2EwTzd1bW4wVmFL?=
 =?utf-8?B?Qk1aVXVRWGgrQ1kyc05wRmFRd0UraVpUazhxQVk4VlhaZnhwc1RuZC9Ba1A4?=
 =?utf-8?B?R2JweVkrNVRDT3EwbTFubEZLNytkRXdhdHZDWU04TGRyNGpyMTQ0MURHOTh0?=
 =?utf-8?B?VXRsalVHamk3UGlsL1JRODBZR3F6ZWVCOGx1WmV6MjJkc1NJcUxvRm4zYUs1?=
 =?utf-8?B?enZ6aXN0c0tEM1NBam8xMU1WTFRxaVlzdHpvRVY3OTdwdG9ncWJ5aXFGSjRl?=
 =?utf-8?B?UjNkK1o2SzlhM0pVOENZeTVxU09nelBGRmppNndlc2EzcCtwSWRaTFZIUE5v?=
 =?utf-8?B?WXEzb2pqSGpLUUgrUWtEMWJ4L2J5dFVlWEVLdzk5d0htakFaTGc5Tkc4a21q?=
 =?utf-8?B?TG5DQnRsbzlCcVM3RUZLSnF5ZnVRWS9KSUl2YkI5RnRNZFhrSmdDdjdBVEpB?=
 =?utf-8?B?YlBvMWg5K0tSa1VOS2M2N1MxdjREbnM5TEZYNjNrSFJMSndMTVIrSjVHcUt6?=
 =?utf-8?B?VmtaRlFaZk9ldE15U1hjR2tRQWNMNUkwTGc1VVVwMmVkQ292Nzk5L0t0Vm5s?=
 =?utf-8?B?Y0xVVDhpV2k3ZEp3TWtWQy9jWXcvYkE4bElxL3hXOGFYRWx6c2hVcWhCTDhk?=
 =?utf-8?B?TzZoOHg0ZTBRZlA5ZC9pNDdQOXFtSEN6cFJhMGN3V3prQmphak5MTHEwUDRM?=
 =?utf-8?B?cUFKL3Zaek40b3k1bm9NL0d6ZXZiREp0S3FvaWt6UWg4eEJSQzFwZFpMMVBw?=
 =?utf-8?B?ZEVoTEdSNTRmdld2aW0xcXphSFFvU2o3Ty9CeWYxTVJkb2s0TVVTcTZ2OE1I?=
 =?utf-8?B?WkVYdjg2RnpYcWU3MmRDV1pSMncwR1NkR1NyaElDemhla0hoNEpzL3ZhYUtE?=
 =?utf-8?B?RnBWU0I5Und3T01PTHhrNFZvRjRKRmVLZmE4V3E4RVYxOGVHaSsvREx1eExp?=
 =?utf-8?B?NkNwc1c1cSswWGxaRHJsUnlkbVQ0ZlBHbk05TkNscUJxZWlKZ0s1T1FWZUQw?=
 =?utf-8?B?OUIxSmxoZnA5Nkd6ZW5PbTJicHRzaHBJbWE4OGgwZXVHSmlaWWpMUm1PQXd6?=
 =?utf-8?B?aGt3Zk84cFpGdHRoU0F4YW9DTjQxVDlqb3A1K2xTY1hqb1NKT1VYQjNmMkJp?=
 =?utf-8?Q?GvuzFWd8vn9++kluHQh42hTBB?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f933379-9a9f-46f9-b9bc-08dcaf7c9a85
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 03:14:48.2671 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XuquCJkfULMaQKsGLzL6O+kgHhoh2ixAQ64ZITOB+FZtRzT4xTgBRBDDSFMiy9Z7ofzIvjjlEx7qDhZBRI3CKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465
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

SGkgRmFiaW8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8g
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBTdW5kYXksIEp1bHkgMjgsIDIw
MjQgMTI6NDMgQU0NCj4gVG86IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgWi5RLiBIb3Ug
PHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5p
QGtvbnN1bGtvLmNvbTsgbHVrbWFAZGVueC5kZTsNCj4gc2VhbmdhMkBnbWFpbC5jb207IFBlbmcg
RmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjJdIGNsazogaW14
OG06IHJlZ2lzdGVyIEFSTSBBNTMgY29yZSBjbG9jaw0KPiANCj4gSGkgWmhpcWlhbmcsDQo+IA0K
PiBPbiBGcmksIEp1bCAyNiwgMjAyNCBhdCA1OjM44oCvUE0gTWFyZWsgVmFzdXQgPG1hcmV4QGRl
bnguZGU+IHdyb3RlOg0KPiANCj4gPiBVaCAuLi4gd2h5IGFyZSB5b3UgYWRkaW5nIHRoaXMgcGF0
Y2ggaW4gdGhlIGZpcnN0IHBsYWNlID8NCj4gPg0KPiA+IElzIHRoZXJlIGFueXRoaW5nIChkcml2
ZXI/IGFyY2ggY29kZT8pIHdoaWNoIHJlcXVpcmVzIHRoZXNlIGNsb2NrID8NCj4gDQo+IE1hcmVr
IGJyaW5ncyB1cCBhIGdvb2QgcG9pbnQuDQo+IA0KPiBQbGVhc2UgZXhwbGFpbiB0aGUgbW90aXZh
dGlvbi9yZWFzb24gZm9yIHRoaXMgY2hhbmdlIGluIHRoZSBjb21taXQgbG9nLg0KDQpJdCdzIG5l
ZWRlZCBieSB0aGUgY21kL2NwdS5jIHRvIHByaW50IHRoZSBDUFUgZnJlcXVlbmN5LiB3aWxsIGFk
ZCBpbiBuZXh0IHZlcnNpb24uIFRoYW5rcyENCg0KWmhpcWlhbmcNCg==
