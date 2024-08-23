Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86281C531DC
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 15:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AFF588A0E;
	Fri, 23 Aug 2024 17:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="GoORyicx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D35D8852E; Fri, 23 Aug 2024 17:12:42 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA6E889B4
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 17:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/sfb/kF/UADmeq+Y73B9DZkEFrQfydk5ShLPuSXobrXvF39YDtow8HA412d5UiuDt/MM1FswkR7TttFca6lvotEo252ZCrDYn8UyNWz0/WIjHd32QyIUwPHNXQTpDLoLcOoK1spEgYG5P3tki5snu74VJWI6usJadZqvg/puKWnGX+wE7IfvilZGuJSzfiTh15eLaqi/uONveK8mZfevY2HLq6rWK35yACBT+I9akURD0/wm7FdzhbYFmpbObfucYrMWRGf6AyU6K+ebkt1zEBaR8dy2Oj1yc71JnLQTB6ZqgugPMOaaeVGET3CEsEJNhCQL+I4XfLIgi8c8Sndzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFfpCLuxvzx2T2XjbCkxzlHOyzZcBadsel0PU9doc0Q=;
 b=pzCiPpIVluxL+PtW9IBYzwNGagtZbirJ+NqKw66nnQR6qwNI6PENyJBAPbHHljuWiA68P1HYEFz6hfbGgAx4yNTAJnlcopsONEPFIYu2OY5Uaf93RYlNg2L8y0NkyCxl5Af3Ujn48jH3Ijd8dNLxscNemzH0wV5CzFQTaa0uyFlCjJ6B3WAMdVCKveGWJA+B2LlW1EgdQjNTQqAP+TV5ZTWd3scDcTjKYFUUz0WrwUlo0pLfDfQ8xXnHr1b1qUbtpdaapNo2bHIPO1y9PRNyWvuoUsdx5WC0GtdLeKDNmp87XpJON/BDiz8NP1x0FDfYdZ5+R8FC49AY3BcA1/P/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFfpCLuxvzx2T2XjbCkxzlHOyzZcBadsel0PU9doc0Q=;
 b=GoORyicx7f5wpOhLs4CJI8v5O2KDu8x9GKb6jILbXaBBOMvH3xevl5zWswzG7VuPAzi3wW31TpAhQty5sEnqvI590UiUrLFREPRr+vQibvM+NwYVlM7D1/LYo+XSa3OulpH+BoXtMGKx174Mtdt1XNtwIztsr3wZ5g7GWDSiRZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7633.eurprd08.prod.outlook.com (2603:10a6:20b:475::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Fri, 23 Aug
 2024 15:12:38 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7897.010; Fri, 23 Aug 2024
 15:12:38 +0000
Message-ID: <b7c9d535-9295-4a6b-9b8e-a62a123bc1fc@genexis.eu>
Date: Fri, 23 Aug 2024 18:12:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v3 7/9] net/tcp: simplify tcp header filling code
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20240814103145.1347645-1-mikhail.kshevetskiy@iopsys.eu>
 <20240814103145.1347645-8-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThroMFX-+G5r0uhkVsWwO9GWtK4qVZPTzx-2fiu+YLd2g@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszThroMFX-+G5r0uhkVsWwO9GWtK4qVZPTzx-2fiu+YLd2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3cd1c7-22da-4324-f658-08dcc3860639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OExaeUZBNGdSNUd3YTVIaUhrZEUwZ2dzaFpBbWZ0WE82c3JUZElyaFZlUXd4?=
 =?utf-8?B?aXVuZ2dJUmZyUXZPN0E2NjJKUUg5WVh4U0NJRFE2Z3dyTlh3bzlLRmVGaExO?=
 =?utf-8?B?K1k1QmtxVElNZ214TFFYbEg4VndxcmJubm5NQkpnb3JCQmFIc0RsalZTelov?=
 =?utf-8?B?SHJhK0hkdHRGNzZra3hSTkJLRVZxTmhCSDRjUWEwV1lFZXU0V1JlL0Rzb04r?=
 =?utf-8?B?a0w0WUNtcVdrb2ExRDN1cXpVS1NNMDBKclB2ODdCVk0wZzczNjU2NFROcUhl?=
 =?utf-8?B?OU42VDRpaXpLbEZzTEw2VXZINXpnbjlMdWp2QUZDdGNuS0dSTEZhT1BVT3A4?=
 =?utf-8?B?THljcnFWWkZSaGpVSk1lcmk3dWY1Qk5YampzV3d3T2dHdzVEVXRpaXdDUzUr?=
 =?utf-8?B?Z0FjOEtzd2x4VFMyVjRHanU1MGpzSC9CWDZweUQ1MTlnelEyT0VTUWFIWGdw?=
 =?utf-8?B?WFY2RG9NcjlFeTNWd0hDQy9xZ283TWtyQW4wRDlIb1V2TGFPU2tKVU9ac2p2?=
 =?utf-8?B?TExSN3pXVTBOZ1FPOERUVUVvWjBlQ2ZkVkpJUzJxMkdaQStlVXZZSVJWbkR6?=
 =?utf-8?B?R1FmNTVIYWRhcmZSRVVWaVlPZVR1UHhDTUxrWm0rUHh4dUVha0pQaFZZWWVK?=
 =?utf-8?B?TFVKNUoxaWRPQ0FWNHB6YkFkcFo2VnowZmtOUFdUQ3k4aG95OFFMY0d5ZzJy?=
 =?utf-8?B?UWxXclhzeFFTWW5MRFp3RXpxeVQvT0pRYkVKK3JHYkIySnFZZ0U4OEtFOCsv?=
 =?utf-8?B?a0VuQy9KRHk4eW5vOVpYM20wd051Z2pVRGZLQWJWQUxCVnRKYmFiS2NOZE5I?=
 =?utf-8?B?YXlRakxYMGRCVUl1d2xaMlRXTlh4VnR2Y25uUWJ5NzVoTnZwalYxNEVDWjVm?=
 =?utf-8?B?dkJ5dnVaeWRBSGlRVkpKQ3NBa3JHOWhoWkllTURpK3dHcjFDZHB0ZS95MTlr?=
 =?utf-8?B?VGdadkdoR1liMFo0dlFiTjZSNm9mNnFpWldnQk5KY0hLYjhUeDNtbzlSYzNT?=
 =?utf-8?B?NENkMjZsbE9Qb3UrL1RvZnU1L09jVXJkN0lOZVV0dmRjOEd6N1pWTHJYdjI1?=
 =?utf-8?B?UjBhOHdvUENJSmgwUjJ0OG1WVkU2UWE3ZHU2MDBDaTFPcXU3ZWh6NmQzTEJy?=
 =?utf-8?B?ajd1N0VoZGNiYWF2bEhnZTRMdjQxbWRjSXJpVzRVV3l3UVh3aWttQlZ1dm8r?=
 =?utf-8?B?TUM1dXJ6Y2hlU0x0WVdDcVkvdmtseUR4QTVNd3JzU1hzQTlWZDhDVEs5YWUz?=
 =?utf-8?B?YlRQQk04KytOSVlJVXBJbFNaMGZqOUduRnZacGg1QXFGU1JEc09VOGR3RVBM?=
 =?utf-8?B?Y0cvcVN1aUdjc1hYeDROWXNJV1JXU2RieElpMGRvdGlpdFBmZ25uM3dCdXZT?=
 =?utf-8?B?N2R1azlmd2s0QzNNdmRoSzlMWWNlcnRBWEI3aERRMVU1SHF4L04xU2hta1VT?=
 =?utf-8?B?eGdzaWVtQnNWV1BHRy8rN3UveitNZk5rK2lPRFBQb0FQUnhVam1jWlRoMEFs?=
 =?utf-8?B?OUtFQVNMNDJvR2NQd200YW1qc01rSmQ2RGdXa25DVCttL2hpOWZaZVN4Y3BQ?=
 =?utf-8?B?NmEvaXZBSjRscUdZaURFRDgxSEIrdGFLTWlxRUdiUFIwUTZOa3BLSWRhVkJi?=
 =?utf-8?B?eVpPemY1bHNuUFlBaytwakcrb2wwZG5ZVHd4NjZwdHpIajlNdE8wVHg3NzBR?=
 =?utf-8?B?bEtRMC9FektSakRWb1BsRHk2U1ZDdmxVR0kvRHJzQmlNYm1JTUN5RWxhRTI1?=
 =?utf-8?B?UkdjcDFySk5JVTY5K3RNVldIY05FTS8xL3BoTGQ0eHB0TUxoMmUrbUxCRVNQ?=
 =?utf-8?B?djdMbVNNRlRSRGpwUkJIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXpNYWlwR0pPaWFhZ1FhT0N3clJaU0k4TmdySU54cTZpbXFwQzhZVmZ5d3Zr?=
 =?utf-8?B?ckpmaVpyY1NFNFhkd0svS3B0eDZrWlVkdENhRHVxclNYajM0amkvUmxlZ1R5?=
 =?utf-8?B?bEd1NW02QzNzRW14Ky9UUVdBNElXUnA4WHZQOURFaHcvUzhYRUJjQnAvREw2?=
 =?utf-8?B?c1ArcmJFMnpCVmMzK2xPQmRmcHowaElQRVZnN2lZQ3FOQ3FKTTZrUVBwa0Jp?=
 =?utf-8?B?ejcyYysrZ25aSEw3WXZzODYvcWxET2hVaGY4S1EraXd0NG80S3Z1ZlRJajNl?=
 =?utf-8?B?R0FIS3hVR0dpRFNGM2d5UmxsRTBUM3JwMldYRytlVXhvVFFQTDZyaDVacHdq?=
 =?utf-8?B?dmc4cWwvTjgzcFZzUjlVMjl2dHJJTEYxWlFjNHptbGkyNFI4Z0dxUXFYVjVn?=
 =?utf-8?B?QW5aeitRWXNhKzlmc1dHOHJoVHZyTTRPUGxhdWRzMTJzK3VOQ3BsZXVzdFJM?=
 =?utf-8?B?QmRtdXpZdjJUWGNrRGQ5RmM3MEprblJUcGV6N0tPUWZ4R1RaRk1GQVUwU2oy?=
 =?utf-8?B?VE0yVHgrQ1lTbXQ0THJEUFhnQVY4ekhIemcydjU0K01hZGlzRjFjTHRNb04y?=
 =?utf-8?B?ZUVWQmJ0emFZL2lNL1dCUVBoTTU1MmJhTjltTkZrN3lzTGZlYkFuamNzV2ZZ?=
 =?utf-8?B?MTZodVVWZ3ZUT3R6SXlZN2RFL3VwK2VKV3NUN1RyUDdVNHVxUStlZml2NEQw?=
 =?utf-8?B?UGY5b0FPTjFCNnBZV1B2Q3h2WklOa29Nb0ZEVWxFV1drWk5sVmJ1VDRnbVVv?=
 =?utf-8?B?eXdCZ2d0T1B2OFkrdVQ0bTFpZ3N4cmlnWmk4MGIvanFxWmx3ZThXK25mZk5i?=
 =?utf-8?B?K3FEeFFjVm9RT3kzTWlIN0RCZHF3SmtrMGcrczRvdG01cWZOT2o5Z3NPSFJy?=
 =?utf-8?B?Tks5MGhHVGRsaWJUUlFBQkRSdVJmS1dvVG8rNHdxeFhha2dnVFpEK1o4NytO?=
 =?utf-8?B?Z3RYWDM1OURvSVY5WDlWYVZlNUFHSWRHT1VUYllGUGY5STkzcGp6N2VnVGF3?=
 =?utf-8?B?NEZweXVTdUFOWENZaXZyRHpqMndWTVFHSDhYcXp1VXAzK3lZNHdqZDBDVDVY?=
 =?utf-8?B?QjZGK2N4QnpjOTVWZ0hOZFJMNHhwbHJOMjhkSVFGdU1PdnhjL1EyRDFNRXY5?=
 =?utf-8?B?UGNyOEFpc2p3N3dtWTQ2N2NON1Q1YklUYkhaa01zUEhOcktuM1Q1ekV5b0x0?=
 =?utf-8?B?RTNBZnZKYUwxbXVYNW1MSUJ3U3psOFpMZUlDYzJkRCtvd0hqdkhCQm95NWRV?=
 =?utf-8?B?T1dwbnBnQ2JPaGdpOEsvSGpaVEVOMndzb3l3OXRyZzdYOWNkUVM2aUYwZGlV?=
 =?utf-8?B?eFdKMXhrRHE0ZlRvdmU2S285aWZWVS8rS2l0aUdtZnpnYkVlTFQxOTBUaFVC?=
 =?utf-8?B?V0pxU0g1TDUzb3VBZ3UzVVdvMUkxY2NDdUNIcUNpVUZjcVpLTHBDS3RvYXkx?=
 =?utf-8?B?bTJJRFFlZXRwaXF4cXhvektuZmtlL3RDWThxcFFId3JnWVF2WktyV2lGRTd5?=
 =?utf-8?B?dE9mTk0yRUNiNURTaWtqVEtscUlQOGR1SEFnS3FGQWUxVCswcThZTHZDdUhx?=
 =?utf-8?B?MlNrSHM2c0R4Z2kzYmgwTHFPSXRzUEV1S3VWSUZQbGVPL1VxVTJIamorSmhk?=
 =?utf-8?B?UGlTbnN6bFNkRmZkUlVUTDc3bEI3eEF5WkxHQlRrMVdJelBBN1NqdkdYaHZi?=
 =?utf-8?B?QklTYk1yTXhNcXg5NGhYN1c5RzdlcEVyMHpqbWlEYjRvSk0vYXVFR1kvRzFz?=
 =?utf-8?B?NHlxY1BmTkxMSFc3VCtjT1VuZ0FWUGlzdzFvcm5PWXRFNWJQNEl3SGt5ME9N?=
 =?utf-8?B?UllKNG1wSXdSOCt2dHA0RXE4alNtV0lTdisyREQzSENWaloxVE1HWXRFTG51?=
 =?utf-8?B?SWoxa29GMS82Mm1qbHB4T2QrNnBYbXFLNHBBbmd4UUlPN09WUGtsdjdhbGNz?=
 =?utf-8?B?NHV0akhqcFU4UkNmNWdwR2ZyVlpiZGx2TXd1TWwwZGJxSStwWUY3Z216RWwx?=
 =?utf-8?B?bkd2cnJGWk1ROWtaTVNhOHhtcnd3dUpRdnJldXU5ejdvRXdqYUQ0R2RvTW5U?=
 =?utf-8?B?VHE3YTFuVmlBK0ljYTJVY2k1S2Exa1RzYUtLQmVzWjJwbG5QZHdFZzNPTngz?=
 =?utf-8?B?QVhDeXE0SzZZRGFpYk8wV2tvMjY5U0VGOXdnZ01FeCtXYUxhT0ZSRm9RamhB?=
 =?utf-8?Q?DNQeT7lwDYmfF09fuy8AmTA=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3cd1c7-22da-4324-f658-08dcc3860639
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 15:12:37.8708 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2zE7uszOMBfNSHq/7+3xQU5FisXywhRTBfSKbq0wJ2cp07fZsIHU+hipeudgpDJcHCJTfxxyh14Dlx96gYCsjeUXs+IGYvLtP/cUVpWY38=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7633
X-Mailman-Approved-At: Fri, 23 Aug 2024 17:24:35 +0200
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

By the way, I'd like to know your opinion:
 * should I add a sample implementation of http/1.1 compatible
web-server to this patch series?

This can be used as a base for other implementations like firmware
upgrade web-server used by some vendors.

Mikhail Kshevetskiy


On 17.08.2024 18:58, Simon Glass wrote:
> Hi Mikhail,
>
> On Wed, 14 Aug 2024 at 04:32, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  net/tcp.c | 70 +++++++++++++++++++++++++++++--------------------------
>>  1 file changed, 37 insertions(+), 33 deletions(-)
>>
> Reviewed-by: Simon Glass <sjg@chromium.org>
>
> nits below
>
>> diff --git a/net/tcp.c b/net/tcp.c
>> index 2c34556c26d..7014d5b4f43 100644
>> --- a/net/tcp.c
>> +++ b/net/tcp.c
>> @@ -527,10 +527,37 @@ void net_set_syn_options(struct tcp_stream *tcp, union tcp_build_pkt *b)
>>         b->ip.end = TCP_O_END;
>>  }
>>
>> +const char *tcpflags_to_str(char tcpflags, char *buf, int size)
>> +{
>> +       int i = 0, len;
>> +       char *orig = buf;
>> +       const struct {
>> +               int             bit;
>> +               const char      *name;
>> +       } desc[] = {{TCP_RST, "RST"}, {TCP_SYN, "SYN"}, {TCP_PUSH, "PSH"},
>> +                   {TCP_FIN, "FIN"}, {TCP_ACK, "ACK"}, {0, NULL}};
>> +
>> +       *orig = '\0';
>> +       while (desc[i].name != NULL) {
> try to avoid comparing with NULL or 0
>
>> +               len = strlen(desc[i].name);
>> +               if (size <= len + 1)
>> +                       break;
>> +               if (buf != orig) {
>> +                       *buf++ = ',';
>> +                       size--;
>> +               }
>> +               strcpy(buf, desc[i].name);
>> +               buf += len;
>> +               size -= len;
>> +       }
>> +       return orig;
>> +}
>> +
>>  int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>>                        u8 action, u32 tcp_seq_num, u32 tcp_ack_num)
>>  {
>>         union tcp_build_pkt *b = (union tcp_build_pkt *)pkt;
>> +       char buf[24];
>>         int pkt_hdr_len;
>>         int pkt_len;
>>         int tcp_len;
>> @@ -540,55 +567,32 @@ int tcp_set_tcp_header(struct tcp_stream *tcp, uchar *pkt, int payload_len,
>>          *         4 bits reserved options
>>          */
>>         b->ip.hdr.tcp_flags = action;
>> -       pkt_hdr_len = IP_TCP_HDR_SIZE;
>>         b->ip.hdr.tcp_hlen = SHIFT_TO_TCPHDRLEN_FIELD(LEN_B_TO_DW(TCP_HDR_SIZE));
>>
>>         switch (action) {
>>         case TCP_SYN:
>>                 debug_cond(DEBUG_DEV_PKT,
>> -                          "TCP Hdr:SYN (%pI4, %pI4, sq=%u, ak=%u)\n",
>> -                          &tcp->rhost, &net_ip,
>> -                          tcp_seq_num, tcp_ack_num);
>> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
>> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>>                 net_set_syn_options(tcp, b);
>>                 pkt_hdr_len = IP_TCP_O_SIZE;
>>                 break;
>> -       case TCP_SYN | TCP_ACK:
>> -       case TCP_ACK:
>> -               pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
>> -               b->ip.hdr.tcp_flags = action;
>> -               debug_cond(DEBUG_DEV_PKT,
>> -                          "TCP Hdr:ACK (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num,
>> -                          action);
>> -               break;
>> -       case TCP_FIN:
>> -               debug_cond(DEBUG_DEV_PKT,
>> -                          "TCP Hdr:FIN  (%pI4, %pI4, s=%u, a=%u)\n",
>> -                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>> -               payload_len = 0;
>> -               pkt_hdr_len = IP_TCP_HDR_SIZE;
>> -               break;
>>         case TCP_RST | TCP_ACK:
>>         case TCP_RST:
>>                 debug_cond(DEBUG_DEV_PKT,
>> -                          "TCP Hdr:RST  (%pI4, %pI4, s=%u, a=%u)\n",
>> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
>> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>>                            &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>> +               pkt_hdr_len = IP_TCP_HDR_SIZE;
>>                 break;
>> -       /* Notify connection closing */
>> -       case (TCP_FIN | TCP_ACK):
>> -       case (TCP_FIN | TCP_ACK | TCP_PUSH):
>> -               debug_cond(DEBUG_DEV_PKT,
>> -                          "TCP Hdr:FIN ACK PSH(%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>> -                          &tcp->rhost, &net_ip,
>> -                          tcp_seq_num, tcp_ack_num, action);
>> -               fallthrough;
>>         default:
>>                 pkt_hdr_len = IP_HDR_SIZE + net_set_ack_options(tcp, b);
>> -               b->ip.hdr.tcp_flags = action | TCP_PUSH | TCP_ACK;
>>                 debug_cond(DEBUG_DEV_PKT,
>> -                          "TCP Hdr:dft  (%pI4, %pI4, s=%u, a=%u, A=%x)\n",
>> -                          &tcp->rhost, &net_ip,
>> -                          tcp_seq_num, tcp_ack_num, action);
>> +                          "TCP Hdr:%s (%pI4, %pI4, s=%u, a=%u)\n",
>> +                          tcpflags_to_str(action, buf, sizeof(buf)),
>> +                          &tcp->rhost, &net_ip, tcp_seq_num, tcp_ack_num);
>> +               break;
>>         }
>>
>>         pkt_len = pkt_hdr_len + payload_len;
>> --
>> 2.39.2
>>
> Regards,
> Simon
