Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E16F55431
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00B8A83EC8;
	Wed, 25 Feb 2026 01:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R3Ze3/Uh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F069683EDF; Wed, 25 Feb 2026 01:14:37 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E244883D17
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bf7r+AyAU4oKEl+O89KgHCusZ+YjW4126gz1SWX95LcJHWiaRTR9b6miqULZY4ieAWrL9KyzsyRpXs/eh0aHj34XhbsYka9YhZ5rqnCkakiGesUtGujmLDBjY/Aprxy08GXNYse1Ejr9OUYZODoJs7FlN1sJvv8cNLDcf/iQL3pZTYeG0XP6G+qlJqjIBThURrYhRySwcGL4yg6R2E5/aP8BL9+5H0nfNhopGlA7janEGkzTTRgPWPdwalhOFJyx0j+HPlI8cjdoQnOr3zDmrF4Wdcx1dM3+JPxn3VsE0zGIgSPpztBStUndKgEOl0m5HSxJPPclGMqEi0rUANF5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKFdbJ3eAYJbtNDaY4Bvh+j2uC/9rdp5fI/bvi/y6Ng=;
 b=MLaJRz2sYSjas0qXMIHIrlg/jesVSmiMLImsmJ47ttOmN2UoEU8iQe0zxlsQtnEH9BcLkgLXhWqhFe//KhX/tKIEpyxm/9X0AWzmhdB1w2uclIUnk3nwzuYH1d/hbvnAfBPgdVu0zcmJlkVoq5i3quudN6DQlgGhz6ZPE7i5TlrDi4fQ4YiGGLOj/fK4J75XfJ8RYLr3n8HG9QZ1Bwok9WhVaIDKfKZJ8azdI8qP32VfgAIQcHLT32ZFBabRPHz0pOg/wDuQHe7MsmJirZTAGzqHsBhXqJLiyJeBJo17a11QmsQl/upYFP2pOr78Yjw/nVjtE6Iza1i0taOXEGVXHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKFdbJ3eAYJbtNDaY4Bvh+j2uC/9rdp5fI/bvi/y6Ng=;
 b=R3Ze3/UhbMOijqi4tHGzGUofrRiKLFZbpr5jniOi6ddHQm8Upx8nvdb/beJzhgcJREWdvrji+vQwYecdTUj23ZQrnvK1ps7wWBOrFAg+v3vTJObSmdSXplP40HefxwFHFCE9Ue/pyHK4aLEHzHvZI8N2hO8OmUtcY/7e1Kzn00Ff6T/+IehgOiHD3pLAiVpBBY/BMzLRyrXqWyMYWvqZRMfp/RH6SiLAT6Blwkgyu/xEx/QL3bECPhVuI+tw0bX7tex1ZtuoWcirn+7L+pa2tGhKA+5ssvcNJbpbki/5REog/G9aKgwmFsSPMm7KEsN1hm4BOpv679OCA/ZAi037sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:33 +0800
Subject: [PATCH 07/10] pinctrl: nxp: imx93: Rename to imx9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-7-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: e0edad35-ef36-4329-84ab-08de7402daa3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K0tGekIrSlozdUhvRWxRYm9Qb3Evbk10dk1hMDQxem95dHc4a1hzeVFLK0RN?=
 =?utf-8?B?S2xxbEU4QW9jdVMvU01CMmkwOFJxU2c5RDZ2T2daRHBtcTQ0T3dzbG14NXdo?=
 =?utf-8?B?OTl1N2Q5WjVzSFhFTVJTZ1loeU1ZVVVPaGtWb0xnQlp5V0RqZURnNHdaM09a?=
 =?utf-8?B?UUVkaGx5cm1BU2lNTlNLUEZleTZqTE9QRXZ4Q2FHekpnSHVuZ29COUVRRUpF?=
 =?utf-8?B?WFMrU0F6KzdhUTU5SERSY2lzVnFodkhySFlkVzRKcUg3alJ5MEltUVAxbGtP?=
 =?utf-8?B?YXBCbit3MWRjZ2pUcEpRdWltVHFWMGFVUW80Z0QzejNDU2NUQjRtbjdxRFFG?=
 =?utf-8?B?ZENMVGpsY01wUm5ubVI4K2VzWnh4bFJMY2o4TzE1NzRFbE5VU0tqVFE4Qk9Z?=
 =?utf-8?B?WWpZbnpoMURiL1dXSUNhTENpVmZyT2Jmb0Z0b2ZMM2cxOGVZNDRXSnFWbEFB?=
 =?utf-8?B?N0RXelFCaHJVV0h6enYyY2lhWWNYVEZ5d0swbWRaakdGZGJZVHFubEl0NXk5?=
 =?utf-8?B?QjFpeUhiT21qR0hTU3pEZk9nb0VPbCs2d1FoU0ZuMkpVbFgrL0RUeFFSQm1k?=
 =?utf-8?B?aTYwaGxuenM0QW5HMUh3WHIzYXkwdHZ5aERWQ2hUeXFyRDFJRHZlT05FbEw2?=
 =?utf-8?B?UExldFF6WXUyeUNSK294U2w5N3JDVHdSbEZDMGhoOC9JRjFZZUQ4dXhmMnZi?=
 =?utf-8?B?d1U3VHJkSVFlTGxsTlNPNHZ3Nlh0YXFRNjloYkxnWVNHRTNxeDJOYXZCbncv?=
 =?utf-8?B?bG92TzhGd3lHeUowOWx3TGRWZHlTWDhSZWtZdUdFKzhzTVNNa2s1OVRKQ3R3?=
 =?utf-8?B?R3FORU5RcGt2RytsNjg5UjgwS2pmWHN1TnhQMWloeEg5K1Q3dkdQQjJMWHJp?=
 =?utf-8?B?b1JaR0dBcW5UTXU3L1VMeE9LQ3NGeUp2T3dlQmFhQ1pJOVRPTFF3akVSdFh1?=
 =?utf-8?B?YXA4N1lBRUpQa0VYZEk3QS9ETktWLy9zOWs1Y0FPK3NIcUxBQStBWVRsMExQ?=
 =?utf-8?B?dHNyMnJ0OE1EQlN5ZVpjSWRLLzlKQkNITGpoSDF1dFRqaHlCZGxDZmFraFY5?=
 =?utf-8?B?OCt5RVpIYi83Ty9SclVqWmFPcmlxU0o0RjM3OWU0cytPMnByOWZxSjV4QkV5?=
 =?utf-8?B?NVlydHAyc20yWk9EdTE2Yi9NV2hZejQrWHpUdTVsMDJIZ3lVS0Y4UXRMd0lq?=
 =?utf-8?B?UVFkWWd0QVlSbCtyYXNxUmdxV0Q3QzM4NFYzSTN6SEI5MUxWMnVwUVJRU0Zj?=
 =?utf-8?B?VldhaFM5cXV6NGVQanJtNjhQTGFaYksvOWRkVXNOVnlvSWJMbTg4SnRGYmZJ?=
 =?utf-8?B?M2ZVS1lZTHFxN0VCN3g2MC9qMGdGaFJxZWVCQXB2ZUtHVTJTT0ZWbHRVZUFr?=
 =?utf-8?B?NjVrZzc4eDRobFA1V0lUK0hzbzNuOGRuU2xBSVh3TURYa1ZWS25xaTd5eVpV?=
 =?utf-8?B?ZUpvKzJXSXpmV0REZm50bkJuMnFaeE1kUjZYcGZPb1RNZXcrandjTnU2d3A4?=
 =?utf-8?B?ck5jVjV0YlFuaFZHa09qb1JRZGxvRkUwU3dqRWZZbGRubXVXTFAxRFMrTmdO?=
 =?utf-8?B?eE1XMzA5djRZdWtuOHVydHVjbHVIbitIdS8xbjQ5WXhLSk45eitjU25iallN?=
 =?utf-8?B?UktabVMyd1JYT0VONzIxYXoxM3lZQ1I0cjNFYkNESzJSNVhJNkZTYWtWS3hQ?=
 =?utf-8?B?dFRTdUp5WGU3U1UrbkVFRG5XUE5FdU1TL0xNblJYQlVlMEZha0xGcnhjS2to?=
 =?utf-8?B?UUVtRzBOamduajcycFdnWmhvbEo5MWJFOFQ0c2sxS1lqOEgxekppYWtWSzZ4?=
 =?utf-8?B?ejRFaWpHT2tOcWxZMWo2aFJmWllPY3FLeC9YUVFBMlp4U09lU0Jsalp6MmZQ?=
 =?utf-8?B?OUMySlRxbllMaEVnS0plYWFBRUJBeEN1TGNFRU1SbHRzcGhaYzBTQVEyc29H?=
 =?utf-8?B?c2ZPQXlUMUN2dHh1cWowcVNVaHRFZlZSZWNwY0lhV1JNd1pTYWF1MlU4SWhU?=
 =?utf-8?B?MUJrbjVDK2ZZeEx1Ymh0bjlCNWxwRVNUL1Zka2I3ellYQzR3UXRXdlpGdkNL?=
 =?utf-8?B?RW1ubmVVTDJNWFVyRHFUY3ZEdjROWXduTVZ3WG94YVBtOHNoT2ZuMit2QS9n?=
 =?utf-8?B?MlpoRUpLU1NlK2lLMnVFQ1BHMmlZbmJObkE2cnM0T2hiWlYraExYSUh3NFMw?=
 =?utf-8?Q?YSE7ZHgp2+CaAD9IWqfH6sA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUREMjhVNHV5NWQ4NytXejB1bWpia0hrMFljRWNoMGNQb2xwbmlHRFZKNmlE?=
 =?utf-8?B?M2NlbEtVTkNma21yMFIxeEF2S2NyeW44Rm1RS1lBVmVmcHZDc3p5Uk0velBU?=
 =?utf-8?B?MWVTQVZnZEdaSDBFejZWaGFNLytmZTlBK3p0U05LY2JOWXBCeDE2Z0pHMXBh?=
 =?utf-8?B?dzNLTTMxdGZXY3ZiS3hzTlVsUFRIYkhNV0pMMkFuODhNY3NKTXZNVEd0Rm4x?=
 =?utf-8?B?LzZweVlDN0NBK2ZGNU16cTMwRUtvTFRxdWxTMUhya01oNUJBQjVoc1FHZlA4?=
 =?utf-8?B?alFGeElRQnVrUGFnd1RHTTY4elBHMWtSNmJra3g2N1BmblpTSlpNWHNaNXZ3?=
 =?utf-8?B?TC9MRGNtRkR3UjREcDJXSnBlK0lTVXJnNGVIS29Ha3FxNnIvcVo0VmJCaXFt?=
 =?utf-8?B?U25Vekh3Q3p5NlFYdnZyVTdZSFl4M0hBNWJvYi9RRFFtOSszM1duSkhuYnVU?=
 =?utf-8?B?K2tmdTRVclhnOUhqNEFwSlMyelYyU2FVWHdjaUhtOTVHOUN6QWlYenVRVnFF?=
 =?utf-8?B?ZWNaa0k4Qm9SQW42RnkrdVpVSlA3NjY4N2FTaHh0M0ZJNzFRVnRtcTMzeWRz?=
 =?utf-8?B?OHZQTjhSS0RENXM1bnA2ODBaUnhlTVhESSs2UUEwcGR2azZlamF0bjZpVjh1?=
 =?utf-8?B?M2l6Q2xtMWJzQjI5dnpJa2ExbFhnYlJxRVBzOXIvSlhWN09RbnVsUEFMWk0r?=
 =?utf-8?B?SFBSQVA3UnhZaFNIeDZMYzRwWEF1Slk0Smo2UTg1Z0U3U2RlOVJwUHdpcm1X?=
 =?utf-8?B?T1kweHJrSzhxK002QkpaWnNOMHpqaDkyWVluU3VoZFBjY3ZuQlNibUFDM2Iz?=
 =?utf-8?B?REExdVcwdmhZbzNyeHdEVzJBTHUrZWErTlRaWE1ONjZBdVErV1gzY0JHVHB2?=
 =?utf-8?B?Z1VBMmZNM1ZqdDJlOHV0UEtoRFVlb1hvTHBYOVhoRCtpWnB6MUxqbFAvbWln?=
 =?utf-8?B?UVYvemZyZ01xT0o5c1JxUXM4V2xZaXJNLzVnSFFjYUJXb1BHVzczYWNLenZZ?=
 =?utf-8?B?WHRNcWtIbE1XKy9USlVjSWZPUmVPV01Gcm10c3MyVVFWbitoWUtWSUErL21i?=
 =?utf-8?B?Wm51UXVZWjJaRkpYM0dZL3d1LzZRWkV3bndkS3U4V2RkcklsbkViUkgzYS9F?=
 =?utf-8?B?ZWVNeFBqYjIyUkFzaFZsT2dwTEVvRmNIOVdMNFBWeTVjLzFvQjFmbmo0U0ZF?=
 =?utf-8?B?YVZUSkEycmFmNXU5NVl5cGoyTnF4b09pVm9rWjFzb21zZmlOc0pxY01GRzhw?=
 =?utf-8?B?cXJiTWFTdjNVdnVneW1TRDk4UWhjanc3R3RuNDQ0TFBSNVNONEF6SFJBT1VX?=
 =?utf-8?B?NktYdHEyZ2gyWUc2L0FKbXNseFRJQkJRRTlqTTU3OWtQQTBqdXBpcVdTWWJD?=
 =?utf-8?B?WVpjaGtJaFNoeWdGQlNoRWRrLzZUNnJUTEFmWlROZjExdXFnMC9qbFppRHhX?=
 =?utf-8?B?cnFYeER5MldkNFdNS1RQdlBUWmdTY1AzeGxGS1NTL2cwZWVSNDdWdXRsNEVa?=
 =?utf-8?B?MStTS0tic3JiNE5IUXVZaXlKa2ZLb1VWcjIyZXpEUjB0R3dnUmk4RWxEK05m?=
 =?utf-8?B?eEkzMHoweDlNR2JVcG9lUWFLL1Y1ZndneHlNTW9PVTdrT1pCckNDK0d3S250?=
 =?utf-8?B?bXl1U1hwL0VsUUxmL0s5aTRZZ2dxbVRsa25scjI2N0RMM0RpWGJCQ1o0QVJY?=
 =?utf-8?B?YzJTZmFpNmhNaU43SE02VDgxeHZnYW1PaG1oKzI0em1RSS82S0FYcDB4OWU2?=
 =?utf-8?B?dlBkUjF0UXZVMHVDMG1jQ20rcHltcTQvRmZ5QlUrKy9JR2FCU2dUcnNxQ0FT?=
 =?utf-8?B?elFOaUNFODhtZUYxRkpCalpxSU1qazVkdE8yOW40RzJNaGQ5elBQcDJrcnRw?=
 =?utf-8?B?YmZhOEpHL1JySmNyU2p5eUhRTmM0U2ZnWUpzOS9ad3M3M1V0RDlKemNZQnlW?=
 =?utf-8?B?MFNkMXFHZEZSaGgreGdzTC91K3MwT05kN3RZT1BOa0xhRFhweWdYR0p4dDkv?=
 =?utf-8?B?dll1VjZkSzdIZDVLaXNURzVGeVJUOFh2aHJGbU9SMm8rSXpXMHl1d1MzQitk?=
 =?utf-8?B?anFlTmZMRzhCZ0xLd3orQmFiM1FnNWNRUkUya2Y0cWJxYW8xbVlJYjJ3S05U?=
 =?utf-8?B?aGRWMVB2MC9qZ2FHeEZBVTArSTR1cjR0SW5tT0JOa1l5bDJ4MmdMTmI1L0N2?=
 =?utf-8?B?MGovN29TMUlBRHZJcjVWNnFkbE0vQ0JrVE1lYnBuMFhUNDBpdUNyYkNzUzg5?=
 =?utf-8?B?YUpBa0pmQ3NENGtIdzViK0lSSENOcElvQVROM1dsZklab0lwaTFzWkpmdXBo?=
 =?utf-8?B?SjhQVnNQK2lKb0N0YjZaWGdxcEVXaXhMeGhNOGFrTnE5ZHlIcmk4Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0edad35-ef36-4329-84ab-08de7402daa3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:34.1591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35GLcJuP3mtD0gBYRoe7v+ZPRGM/3HX18l9QTnA4Q1HK72TEhRVJY1ScoPWH7AZDC8/6YZv+6p1ObNmoDe/liA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

From: Peng Fan <peng.fan@nxp.com>

We are going to add pinctrl data support for both i.MX93 and i.MX91.
Since these SoCs share the same pinctrl driver structure, rename
pinctrl-imx93.c to a more generic pinctrl-imx9.c and update all related
variable and function names accordingly.

This prepares the driver for supporting additional i.MX9 family SoCs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/Makefile        |  2 +-
 drivers/pinctrl/nxp/pinctrl-imx9.c  | 34 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx93.c | 34 ----------------------------------
 3 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index 7d861ae52c1..7f1cc5a182f 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
-obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx93.o
+obj-$(CONFIG_PINCTRL_IMX93)		+= pinctrl-imx9.o
 obj-$(CONFIG_PINCTRL_MXS)		+= pinctrl-mxs.o
 obj-$(CONFIG_PINCTRL_VYBRID)		+= pinctrl-vf610.o
 obj-$(CONFIG_PINCTRL_IMXRT)		+= pinctrl-imxrt.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx9.c b/drivers/pinctrl/nxp/pinctrl-imx9.c
new file mode 100644
index 00000000000..39bcdeaa753
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx9.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2022 NXP
+ */
+
+#include <dm/device.h>
+#include <dm/pinctrl.h>
+
+#include "pinctrl-imx.h"
+
+static struct imx_pinctrl_soc_info imx9_pinctrl_soc_info __section(".data") = {
+	.flags = ZERO_OFFSET_VALID,
+};
+
+static const struct udevice_id imx9_pinctrl_match[] = {
+	{ .compatible = "fsl,imx93-iomuxc", .data = (ulong)&imx9_pinctrl_soc_info },
+	{ .compatible = "fsl,imx91-iomuxc", .data = (ulong)&imx9_pinctrl_soc_info },
+	{ /* sentinel */ }
+};
+
+static const struct pinctrl_ops imx9_pinctrl_ops = {
+	.set_state = imx_pinctrl_set_state_mmio,
+};
+
+U_BOOT_DRIVER(imx9_pinctrl) = {
+	.name = "imx9-pinctrl",
+	.id = UCLASS_PINCTRL,
+	.of_match = of_match_ptr(imx9_pinctrl_match),
+	.probe = imx_pinctrl_probe_mmio,
+	.remove = imx_pinctrl_remove_mmio,
+	.priv_auto	= sizeof(struct imx_pinctrl_priv),
+	.ops = &imx9_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/drivers/pinctrl/nxp/pinctrl-imx93.c b/drivers/pinctrl/nxp/pinctrl-imx93.c
deleted file mode 100644
index 5d250db1081..00000000000
--- a/drivers/pinctrl/nxp/pinctrl-imx93.c
+++ /dev/null
@@ -1,34 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * Copyright 2022 NXP
- */
-
-#include <dm/device.h>
-#include <dm/pinctrl.h>
-
-#include "pinctrl-imx.h"
-
-static struct imx_pinctrl_soc_info imx93_pinctrl_soc_info __section(".data") = {
-	.flags = ZERO_OFFSET_VALID,
-};
-
-static const struct udevice_id imx93_pinctrl_match[] = {
-	{ .compatible = "fsl,imx93-iomuxc", .data = (ulong)&imx93_pinctrl_soc_info },
-	{ .compatible = "fsl,imx91-iomuxc", .data = (ulong)&imx93_pinctrl_soc_info },
-	{ /* sentinel */ }
-};
-
-static const struct pinctrl_ops imx93_pinctrl_ops = {
-	.set_state = imx_pinctrl_set_state_mmio,
-};
-
-U_BOOT_DRIVER(imx93_pinctrl) = {
-	.name = "imx93-pinctrl",
-	.id = UCLASS_PINCTRL,
-	.of_match = of_match_ptr(imx93_pinctrl_match),
-	.probe = imx_pinctrl_probe_mmio,
-	.remove = imx_pinctrl_remove_mmio,
-	.priv_auto	= sizeof(struct imx_pinctrl_priv),
-	.ops = &imx93_pinctrl_ops,
-	.flags = DM_FLAG_PRE_RELOC,
-};

-- 
2.51.0

