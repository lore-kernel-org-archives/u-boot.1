Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21316C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:32:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D7CB87EDC;
	Thu, 25 Jul 2024 16:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="SJ0Ijh3T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF25F87FFB; Thu, 25 Jul 2024 16:32:45 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1815586464
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF0NxfGTZ4no3+/NX5pgxBTVV7Hh+3YXnu61QP0FVA5N55YMg0fSrM2jJQRheDaUjrfnyuHG3Oxh3H8PTeXGkEja0Ts4Sy1pjfXfcyI3jidLaDNby8oOqPkmCHBr4WuA9zjFQmTpRhR9/sMB8KBcJwbA/jVWopRt3auvMCY+vOMdxkKGzMcA8RK4TV1aq46OFEzY+9VF9VfYv3ewez5GdAqSbbP1cwukeFs25/NvNSCTOUBUOGBZGtpj0ege9Yr9MFk/gUHj3tGqIura7bW+biNh3kj58q2z2QetBQJaVwMvx1x3WABd4mJYZg+4wKPRqDE1gNPrpUM1wmwRai3Pxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjcM+qGDpOs8erpFzIog8gXouqbu/72yFphRHAQtUX8=;
 b=HMtuCgshcigH7MIuqYKDMpduFnh4QQDh9yLGtsa04IgbN1iQcjlMYp9sox/K9MLsUjrGvxqnbZ2kxgdPa/P2BGWLMDN1l/ltDsYD9WgzEs9OttNxy8oJNgwvN1yfWNCNw468J3pVVB2Aaot5THflC5qv3ir54DEz+N+mUCeRSewf3dRSCBtYyd/aLrgU6WRRRiy5lRjJt5T+tdZkJRyPuzzrZMxyGCKG9Z8sYYMrEh2bAFn2zsCfgTr/e/padnPikjx0d0DXRjIambVJl+4Im6PQkkKqgeVdmIzcDYjXfn8/uBS3Je2cmUjue9gEzFLAMnYMhqrGIZWDCI/xqNOjxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjcM+qGDpOs8erpFzIog8gXouqbu/72yFphRHAQtUX8=;
 b=SJ0Ijh3TUOMPUUy1IuBkyHcyUVRiwVjLsAQHgk6Lhl46T0X4zOJ1REPTMSB9Dlu4e22WSkfpwIRZyXv3d6CSolXeh2CX3zT7erNEG/71t1R6aEBBKOXMmgFgQ5fyNSh8bOMxKmkULLrlqZL+Zs3tWz9kK72BezUYw2Y/qa+bUQYTYzUur1pZ+mxhbmtL/kFCsB9rJWdU/K9eoFPUQszueQqhl/ZagJAS85kLNgHj1KBSjdCta+Ed0lokFG24JdJ1vvS+olZlNndIetqQkmsJHoO6cbjDnUCmwLmUtjw2PEFNrtbBLmlI0kWxzsKbXZF/ahKQLgbEsSXHBy1KCPwskA==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AS8PR04MB8085.eurprd04.prod.outlook.com (2603:10a6:20b:3f9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 14:32:42 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 14:32:42 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "festevam@gmail.com"
 <festevam@gmail.com>
Subject: RE: [PATCHv2 7/9] cmd: cpu: add release subcommand
Thread-Topic: [PATCHv2 7/9] cmd: cpu: add release subcommand
Thread-Index: AQHa3nWhyc2/6qUZ1kSgJSaKZw7t4LIHebqAgAAHXDA=
Date: Thu, 25 Jul 2024 14:32:42 +0000
Message-ID: <DB9PR04MB923648F2C3B2AC8DB351FB5D84AB2@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
 <20240725095331.14245-8-Zhiqiang.Hou@nxp.com>
 <CAFLszTjDWn=1D+rraZ8eONq9Y0=kUSSU_G8bANg3-wpqXuEVdA@mail.gmail.com>
In-Reply-To: <CAFLszTjDWn=1D+rraZ8eONq9Y0=kUSSU_G8bANg3-wpqXuEVdA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AS8PR04MB8085:EE_
x-ms-office365-filtering-correlation-id: e415e2f3-c048-49ea-0a9a-08dcacb6a4a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V0ZSZ3NMQVA3OXdHUCs0UVJrazVYQ2JtTkkxTFRPRHIwOGZlNUMvMVVSMFFT?=
 =?utf-8?B?dFFiRnd6c2RvQ0NFSmtITytMVGVkWkw3MmU1KzBCRkhFaGpBdm92UWkzS1JG?=
 =?utf-8?B?SlFuUEdnUFBlT1lEbmwxVnEyYXMrWVpUR095eHJZS2EzSXBESElaUkt6S0NS?=
 =?utf-8?B?bHNLQW14bklrTWZUbGVTTlBPWURNNWszbmhuc2hUQm9meGVvV1ZJTnp6NDRP?=
 =?utf-8?B?NVYrMDFqbysxYi9pNnV5RUt2YUxKTEN1V3ljMEhWYk9aMU9tU0FDU1QyN3ZO?=
 =?utf-8?B?NmtuTGp3bFdyd3oxTVhxOTU4Q2ptZVZBUWd1SGFtQ2taQXF4KzQ2K3Mzd0M0?=
 =?utf-8?B?eXFXYmloOHdibFl6WVBDc0VRRTRRNmNYMlY2My9XZGxYcXNVQnVrQnM4Y3FX?=
 =?utf-8?B?NE01K2twUFhORTBHQzRjV2tGbFhRU21NY3QrMkJHRzFPbTU4aGxMVHpoSEhO?=
 =?utf-8?B?bjlwMDlqRElLYUU1U0x0Smd3aHh1b1ZhY2t0R3B6bDk0UUNEcCs5VEcvaFQv?=
 =?utf-8?B?QW15S3EyQWlwL0tWVTNQR3Y1Ny9DQThPZWk5MmxWTHBZMHUxMm5mWWVCeDQw?=
 =?utf-8?B?aWhXWlQvUEV2Nlh1UFBMcXJka280eHBrWWp2dnVFNG9hVFZ5WVdVTStheGRj?=
 =?utf-8?B?VTZWTVVVWWdjdC9zcFQwL1UvNkxSTGJ5MmZiVG1xUmxjYjFrK0t2Zy9yU2pi?=
 =?utf-8?B?bmlzSkRkNFc5ZCtYOUN6d1UyaVoxanVjTnFvQjEwZTdPYWF1NldTUDAydTJh?=
 =?utf-8?B?V1BhRCtaNDJ2WXhEamVPRG5JY2g3N0NyM01hRzNMSW9Yd1JSMUQ0Yk1RS09y?=
 =?utf-8?B?Y0l5VlFDVmpxci9LT2g5d2hVTU9rTDBFOFlwNVdRM1ZvUnl2S2dHZ0Q0RDFh?=
 =?utf-8?B?QnFrdTdQSDRmWU5zcGlicm9hUW42RFk0L1BmVnJPdzA4V1VLT1lUMjNRKyt3?=
 =?utf-8?B?SlJBa0lQSnF1QnFpVFpsREplQ3J5V0k1MnNIWlIxVVFpYVpyOEh0QzMzL3du?=
 =?utf-8?B?eHJLK1QrMHJmR3VRUElpampDd2UzNWxHdHNuQlFlQllZTkp1WVZEaDJWbzFh?=
 =?utf-8?B?cVF0b1dOdGc1TnpsQm5FTjgrK1FMMEVEVytBOUE1ZGxoZGZMRjdiTTIwWERw?=
 =?utf-8?B?dDFuSklZU0VsNlVGS0V5L2IvQlFXT0d4WDJQT2ZjQVBZZlpQOGhWWUpTU3pU?=
 =?utf-8?B?NytUZDBFMnJMR0w0QVl5NU1KbVR6RkdHaEZPRGVWcjhUajYzWWErL0Q1blhw?=
 =?utf-8?B?STZKZTcrZjdjSHpxUTVEUmFNS2JsQktGaktEV3RqWklydmpMMHRSeGRjdmxo?=
 =?utf-8?B?VEREZk9tNmFtOEFXenc4K0xhVFVQeTloRmpHVWh3N3NDVUJmNE5Lc0tic0dT?=
 =?utf-8?B?cnNMNDg1QnFWdkw3eE1vQ3V0dm91NVdrZ21OWlVyRHJnZ0JpR2pJS2dDT0pN?=
 =?utf-8?B?dDBmVi9tKzV4Umt5eE8zUk5JS0trb3I3VkhRWVZuWXpNUERGajcrbmFsK3Vw?=
 =?utf-8?B?ekxyclIvUG5xYndvczJodWU0V2c3NDc0ZXUvMzNUNFZPM0VEbTBHMnpPYmJN?=
 =?utf-8?B?MUhOaVk1VkZzUXRNdmNNZm5Bd1ZuT0tkVThpcERNeStBeTVDdUFCY3BuR0tG?=
 =?utf-8?B?UkpES1JSbkNmcjhvZVlWRkhVN1RiZC8xd3I0Yjk5K2NpeExCWDlJQ3hxNmc0?=
 =?utf-8?B?WUZnTHVFaTN1K2ROQnl1OXMxdk5VQXFBUEdVK2x0bExEQk1mb0c3bk9ubFhn?=
 =?utf-8?B?V3VaUVc4UWVjZjByZTU1bGIrR1FWcWg1N1c1RWc3aUorVW5jYkl2VVpVUE8r?=
 =?utf-8?B?a0xhRkxsVjJLUFo1dmxDN2dnZlM4U3ZXQ05iL2pqWGNSRytBeXE0YzkyS1FO?=
 =?utf-8?B?WmRhQms2VHpBUU1IVURKb3B2MFN2K2s2SmI2UmZPeVJRQXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnp0aWJRR1NuOG5jckdPbWM1VGNndWdRMzBTMWlkdElLZWNuTzdGRHl0RFdK?=
 =?utf-8?B?RTRuSW9yRlBpWElBbWtBM3Y1ZTNFdFVJVXJpQ3BETlRKaTd3UFZNS1p5Zldr?=
 =?utf-8?B?S2FTdDFzSW9CckRUeTFLamNDK202VVFXcmlJRzBXZWs1OXhaMVg0VnYwWDBq?=
 =?utf-8?B?QXJBYlRGWWhNZzIwSzhieTN0MnN3blA3VWFmalRwRDR0MktGWFZJd1ZNZ1ZG?=
 =?utf-8?B?Y2xiVWE2MUUvaTZwQzlXaS95cHd5bzhJUnhsZHNHREZid3RBU2pMSlp4U2dD?=
 =?utf-8?B?V0trZVRIbzhISUlPd0EyeWlCTUtteFZIVGVEdFMyM2M5ZXhmanozdHVpM0U3?=
 =?utf-8?B?dEJEdVd0QXhzdTFZeThWSVJSY21NWTR5NGlzalJoU2gxcE5FcG1Nc2d3TVR2?=
 =?utf-8?B?bEhyRW1RQmtCeGhjUFlaTjRCM0Z4N3pnMkt2M0RzeWpUczFhd3BWMlgzYllr?=
 =?utf-8?B?WlpBR1ZieUl1Q0RTeXJQeEpCWmNyY1lPRGVOTlpXZDZjT0R5VU1ZYktabDJo?=
 =?utf-8?B?UU1kUWRLejlweTgxMmFtTTdrek1LbjBmVzJtaGJXSVZFc2M0ZzJHeE1hV25n?=
 =?utf-8?B?aW11T3RlOXcvRm9jaDBvNktSVEcrMFdUcUw3bHVMNVhYMURMZUh5KzRLNi9Y?=
 =?utf-8?B?ZjdSRnRBeCtVOG5ISXdzc3NuUEN1aFN6ZzdsL2JKVHdnNU1wUnR1eGdOYjNy?=
 =?utf-8?B?b0JYQU51Myt3ekZVdXpQQkF2QVpTMnlmK3VHNCs3WktKOWI3Mk9aTWlPUjZI?=
 =?utf-8?B?MlZjMU5sSW0yT3R2Ukltdm82djBwWExnUmt4azZzNWY0cGJqTms0QWsxRUN2?=
 =?utf-8?B?VGpRYmlHRmlIT3ZsbjBlajE4aHQyclJpUEI1Z0EyUWl2VVN2SEpLZFhaM21M?=
 =?utf-8?B?NjF4MTVZOTU5TVliVFZhWElGT0NtZWVPVlJaKzVkTTlMcXZXeDlpSllVWXgy?=
 =?utf-8?B?dm83VURLUG01V2JsZTlMVWttMStubEhiQVdWTnNrWDNFS0swU200TmJQZjZx?=
 =?utf-8?B?Y1hReDZZRW5iQ3J6Y2RLc2FrOWhyWXJYYnllQm9KREJuNk56U0tLN1B2VWl4?=
 =?utf-8?B?TjhqK0tzTmpXN3JwTTdGeC9hbHNxVFFVZ28zdXVhRGoyTENPMFdFVDZwdS9R?=
 =?utf-8?B?ZzNDb2xHaWdBUTVudE9KdXBIVHNRSm9acXZKSWxZMGRQTzhIZTJRdUxqc01Q?=
 =?utf-8?B?UnZDK3FPUE1NNXBBZ1lxd1RUOWJ3MGlVV0YreXQ5cHZEZUM5K0ljcGhTSndG?=
 =?utf-8?B?Um9wVnRLODFCVTVHZ3hzRUg0UmgyOVhMdjd2bHpoL2NiQllLUm83UnFQSzVT?=
 =?utf-8?B?Z1g1YnVVdU10MDFNNHF1YUh6SzA1MFl3a2JoaW8xYzEydXBkRmxQUU8wUHBm?=
 =?utf-8?B?aUdRSlF1S1dxU3pIU3FSblFlMGlqd3pwUGFaVXV0QkhaYzhNY0xWVFpOSWYz?=
 =?utf-8?B?T1RzUHVTRHp2UFhSRTVMWGwzZzdKSUp4aG8rVGZxM05PbUtOeUJzQzBlakx3?=
 =?utf-8?B?aVI5YjhieWswQXljWmRESzFQNXJjKzVIMTJONmhCai9sV2p3NG0xdUJjQjVJ?=
 =?utf-8?B?VWFnb0svOUlQUEd6UlJ0VHlNTDdyWlJBTkF0TEJVY0dLZlR2bmxkelNOa3d6?=
 =?utf-8?B?bGthdGozb2pocVRoWTFhTXlWMStpN1dTL2VWSnZ5U3MydGE4WE4rRllrL0tQ?=
 =?utf-8?B?c1lkemlaUjJTUzVmQ3lpaVlaR2RiK0lXUFJ6V3BWU29sUjhDWG5VSnpEZVNq?=
 =?utf-8?B?clNjNE9rUEcvdmxuQ0tBSW40SW1CVEZxQUhVQ2pSN0FDMWJnRzVzaU1HMGgx?=
 =?utf-8?B?VUdLODNpZ0dkc1NETVE4ZjZ3VjNRRC9Pc2kwTlg0YTlTaFhNQlduOUViOFJi?=
 =?utf-8?B?bkZIZ2JuRGVBdUxJdnRFL3poRkE3blFHNjF3Ti9zdHJsUEpFVExFQkhWT3Vz?=
 =?utf-8?B?cG96YzFLKzZwYWE0WFNzdTVwdCtRdDZhZGZQdWdQQlR2NWlCc1huclVweFRO?=
 =?utf-8?B?a2hSR0pHZWJLWTl2NnczTHRGYTRqREVjSXo5Qm9kdGQ1TmQ2dldMQ1YzaXlW?=
 =?utf-8?B?dWZVR2grK3V5czZLd3FiblpTRndvbEJwdmRUc3hVamloaFJ1ZHUwemJFUmpo?=
 =?utf-8?Q?6HiqovDEYjUqefcWkW/wgAGTa?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e415e2f3-c048-49ea-0a9a-08dcacb6a4a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2024 14:32:42.5779 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMGtdib36tWsz/ioXu58Pcx8oZWaXwzj1DONkRlqvXUoSv+m61NI9thqLqj5d2BnJBYsln9OONU+DSPim1tTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8085
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2ltb24gR2xhc3MgPHNq
Z0BjaHJvbWl1bS5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDI1LCAyMDI0IDEwOjAzIFBN
DQo+IFRvOiBaLlEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiB1LWJvb3RAbGlz
dHMuZGVueC5kZTsgdHJpbmlAa29uc3Vsa28uY29tOyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5Abnhw
LmNvbT47IGZlc3RldmFtQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjIgNy85XSBj
bWQ6IGNwdTogYWRkIHJlbGVhc2Ugc3ViY29tbWFuZA0KPiANCj4gSGkgWmhpcWlhbmcsDQo+IA0K
PiBPbiBUaHUsIDI1IEp1bCAyMDI0IGF0IDAzOjMyLCBaaGlxaWFuZyBIb3UgPFpoaXFpYW5nLkhv
dUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQo+ID4NCj4gPiBBZGQgYSBuZXcgc3ViY29tbWFuZCAncmVsZWFzZScgdG8g
YnJpbmcgdXAgYSBjb3JlIHRvIHJ1biBiYXJlbWV0YWwgYW5kDQo+ID4gUlRPUyBhcHBsaWNhdGlv
bnMuDQo+ID4NCj4gPiBGb3IgZXhhbXBsZSBvbiBpLk1YOE0gUGx1cyBFVkssIHJlbGVhc2UgdGhl
IExBU1QgY29yZSB0byBydW4gYSBSVE9TDQo+ID4gYXBwbGljYXRpb24sIHBhc3NpbmcgdGhlIHNl
cXVlbmNlIG51bWJlciBvZiB0aGUgQ1BVIGNvcmUgdG8gcmVsZWFzZSwNCj4gPiBoZXJlIGl0IGlz
IDM6DQo+ID4gICAgIHUtYm9vdD0+IGNwdSBsaXN0DQo+ID4gICAgICAgMDogY3B1QDAgICAgICBO
WFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+DQo+ID4gICAgICAg
MTogY3B1QDEgICAgICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMwQw0K
PiA+DQo+ID4gICAgICAgMjogY3B1QDIgICAgICBOWFAgaS5NWDhNUCBSZXYxLjEgQTUzIGF0IDEy
MDAgTUh6IGF0IDMxQw0KPiA+DQo+ID4gICAgICAgMzogY3B1QDMgICAgICBOWFAgaS5NWDhNUCBS
ZXYxLjEgQTUzIGF0IDEyMDAgTUh6IGF0IDMxQw0KPiA+DQo+ID4gICAgIHUtYm9vdD0+IGxvYWQg
bW1jIDE6MiBDMDAwMDAwMCAvaGVsbG9fd29ybGQuYmluDQo+ID4gICAgIDY2MDA4IGJ5dGVzIHJl
YWQgaW4gNSBtcyAoMTIuNiBNaUIvcykNCj4gPiAgICAgdS1ib290PT4gZGNhY2hlIGZsdXNoOyBp
Y2FjaGUgZmx1c2gNCj4gPiAgICAgdS1ib290PT4gY3B1IHJlbGVhc2UgMyBDMDAwMDAwMA0KPiA+
ICAgICBSZWxlYXNlZCBDUFUgY29yZSAobXBpZHI6IDB4MykgdG8gYWRkcmVzcyAweGMwMDAwMDAw
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAu
Y29tPg0KPiA+IC0tLQ0KPiA+IFYyOg0KPiA+ICAtIE5vIGNoYW5nZS4NCj4gPg0KPiA+ICBjbWQv
Y3B1LmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IFJldmlld2VkLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCj4gDQo+IFdo
aWxlIHlvdSBhcmUgaGVyZSwgd291bGQgeW91IG1pbmQgYWRkaW5nIGEgZG9jL3VzYWdlL2NtZC9j
cHUucnN0IGFzIHRoYXQNCj4gaXMgbWlzc2luZy4NCg0KWWVzLCBJJ2QgbGlrZSB0by4NCg0KWmhp
cWlhbmcNCg==
