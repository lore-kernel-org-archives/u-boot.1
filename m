Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04245D3E78C
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 09:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4756E88DB6;
	Wed,  6 Nov 2024 10:44:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="BRCXdCfS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6881A88E89; Wed,  6 Nov 2024 10:44:14 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20730.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::730])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E8B88CD9
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 10:44:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COeeULCJj/ZWoGt8veFB2RD9ACOfw6mo3Za2BENPp2fdn3Hn9ac4iNywAh/bGnBgn9QKbBMI7PyuOObnw85KYcqsWYsVy+5ovL2VtRjP4vf5yL4LN6OxN6oLWH580TYoif42EIHS4cdtTOk3RmhrbotC89qIOhX23ERo3fPKeSDoXzd5WXx1m91Gq2FzUhftAfembkb6Xmf99IZEsI+ub7xMY2oyaNYAJhjWXcKZ7GQ/MNn+EH5eASUU7LR13yTV33N4Vw36p/aELTc7YSgeH8eVt8qcKs7odpfN/0XK7FTjqlo118plJZScFsG9IFedur4IMG/MjLE+aGK5prJmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/vbK6Lh2nVXcgmSw7hCFinVU0jDRMhGpxtGl+FZLlk=;
 b=pytMAMcdGaXtknZBNWe/FDXnsSi/OkVHdVD9d6JUGffp8goK6BWKTQ+KUDmq8A0jvGZlr4bZRbE4eTciqGT+Y5SKoJw8VlBP1bsiitwq3KpUBgSgtDYmRc5izc5UlhuiO19uY2J0iyG7LatVnAo6dDiBDyI2qquWUgSTGu/NQ6ZD9HPpdeNoa6eCmGrsT6UZYz3Tjh3XJ1LskFHRoTzl8gf92uzO6vybY5Qkcy5Sm/785TxgE92zI1v2zLJoS6FhN8IC1k7wFaTyg1L4U025cReEIEUjalQ/8mftN4g74dzZzwHFMS48vZSAL7bGQEL3h6xmiZnjtMvzKZpOvwBk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/vbK6Lh2nVXcgmSw7hCFinVU0jDRMhGpxtGl+FZLlk=;
 b=BRCXdCfShX9XmpwJxnjMTz8TDbCFM9obZ3IySxalbHFJjoHhGlA40I+973sCfBzhqVs8Ttaue2kgRPqJjfcjqtj0qaIiRy1fd/j9828KqaCPoqSpBu71HzG1h22HzVBCuw/cnQGpfOv+fbhqY9ewEegu2+tlyxmlC1PysSbQMPQ241ZiKepyc/G8SNJ1kGL8aiT5sgTuyIlKGIPcEE8buC9VJbPP/0YBkRd5gw1LyYwECQoGLH4xiNoQxIRP2Es31WDSCaMLUVpE/EWrv64qpIwSbLTNgShn5L4+vwwgTHdc6Tzl380jTjDilqRUQ41BoQRt4eOi6yxMOex0NPgaTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM0PR08MB5332.eurprd08.prod.outlook.com (2603:10a6:208:17e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 09:44:09 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8114.028; Wed, 6 Nov 2024
 09:44:09 +0000
Message-ID: <4d2dbc6e-e441-4fd7-bdfb-d353b2f0b882@iopsys.eu>
Date: Wed, 6 Nov 2024 12:44:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/13] net: tcp: improve tcp support in legacy stack
To: Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Anand Moon <linux.amoon@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Christian Marangi <ansuelsmth@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, u-boot@lists.denx.de
References: <20241028143143.1807305-1-mikhail.kshevetskiy@iopsys.eu>
 <20241104233227.GA3600562@bill-the-cat>
 <CAFLszThXiK=EzrUStsOBiSQ_pe1-Vdwtg-238BjQd91SMBym7A@mail.gmail.com>
 <CALeDE9M1PDFmm-oZvSEGwBaN_J77CSKUa8kbkEPQf9XATv8STg@mail.gmail.com>
 <CAFLszTjs-7uWNWdaZjhQe-rA5z0qSZxiFeX+WgFofYemW6qiwg@mail.gmail.com>
 <CALeDE9Ps9hua1+AhZDkA+WtxG0phB_0E7j8RJJa8kY5eqn24NA@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CALeDE9Ps9hua1+AhZDkA+WtxG0phB_0E7j8RJJa8kY5eqn24NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM0PR08MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa98715-6b75-479b-ebd1-08dcfe479013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rk9HMzRIdGRJY1JXeGFPQTRZNHcvWmpEcTQ4UFUyR2FhaVVqdmdnMjNGUTlR?=
 =?utf-8?B?WERtaEFUSGMwTGJlVHBkTVVnbDhmUnVuelI2c2ZwYVFocEFKT0tya0pZMWxl?=
 =?utf-8?B?N0c3QmQ5QnVqUjNqczNSdEVQVDRhNHVmNGFrY2E3blFzaEtQMWVaazlZOE5E?=
 =?utf-8?B?ejV4a1JWblZFUGJreE9XZ0o5eXUzRnp3bmk2c1VYaEJGZGRybUR2ajBPR2Jv?=
 =?utf-8?B?NURWZXZUUGMwMzRmek1pbjJnbm9tOUdqcVlEaHFoQWVyTGkrblVlNDRPb2Rp?=
 =?utf-8?B?WkVwTG9ibmVaY1I4dnlFWkkyeU5qRjFDR2lKYklMbVV2d2hhTWUxZmVEMzBM?=
 =?utf-8?B?Q2xrZjZQbG5uMGJJU21Yc0tZaDJ0d0hXbjRFekZ0QjRuL1pmZWxvdi84UHpu?=
 =?utf-8?B?bkZKWHByaTM2R2RtQ2diYU9LcnlqREdvRytiSVBiTysyWXRFdDBEeGtwbXNt?=
 =?utf-8?B?aUdpYXVQQ25RaStZbGREQ09zWTBTN2VtN0x1Tks2U25kNE0xZzZaZ3NtL05T?=
 =?utf-8?B?K3hIS2R6RlFvYzFlTjdYQmxXd1VSdmZQOEJhNUxJZ0MzQ3p0dTNSZDRCZ01w?=
 =?utf-8?B?cnJJc210b2Naak5RYkUxRVVoU0JuZXRYMlUrRXdhR1FTMzBIMFdCZFVIVDFI?=
 =?utf-8?B?d1BPVnY5bnJpOGpGNGFLL2hIbUNsejR6a3hPWFI5N3lrdlN2ZmZqc1F5ejRr?=
 =?utf-8?B?bWxvL3dmbUkzTEJYeGtHUThabmVTYUxVVGZzUFh3MmZXZU9WRGdDMUlmdzRl?=
 =?utf-8?B?ZjlTRnIzK3NBd2l3Y2wvYTEvM05SQi9oUmw1TFFFcWNEVHBFWEt4V3REVTdS?=
 =?utf-8?B?OUowaUx4N2RBOGtvWGhOZHh3QTk2a0FnZURBWUMyTkFsN0tBSWxlVFlkVlRk?=
 =?utf-8?B?NWV4djBMWDY4QkgwbjdwR3A2MlgxS0hRY0VFZS9VNWhmcmd0Smk1VzdKVFpi?=
 =?utf-8?B?TWdydTF3QmdZbUw1azhacXpoSEY1OENJZ1lKN3VuazJRckxva3krK1I3d25K?=
 =?utf-8?B?Y2tCL2V4S3lBcjZLVWRxcnJETTk3MVM5Y1k1dDJpSG9CRGZsbE5DR2ZCdk13?=
 =?utf-8?B?MkRrbWZSZmg3RmRXd2JtWlNkVUR2NmhZN3pWNWdUZDh3dkhMWEZvd1FSaWRY?=
 =?utf-8?B?NklGYWFTNnVVZDYrMlAyZWZ6Lzh6RnBZK3dLL2VISGNoZVpLWXV6dGVWQUEy?=
 =?utf-8?B?WTdkQmlBbTFwWlh0VTJHbThqZzFMenFyWjloZjRLSUlvTHNXU0xHaGx3VTY1?=
 =?utf-8?B?NWMzeHRWMGpUaWdBY0ZRWEEvUC9WSE5Ta3ZhRE9OU3NXNDdxWEdCN2xiaSto?=
 =?utf-8?B?cGkvRWlGaXF4WEpsbEJxM0c4RytwdFBqN3Y0aDRCNHZGM1ZzNUNVUVE2dnVi?=
 =?utf-8?B?ZFpLNVlxU25oVEFBZ1lndzB1cVZvWU8rZjIvRXlIRkxvTmpaOUhhbENUU3kv?=
 =?utf-8?B?VnQvTEZidjAvRDVUKzk0TjdTTXowcXg2WFJ0ZW9xanVSalZleHhLd0paODli?=
 =?utf-8?B?UXovOGwwLzl2cTM2WkZ6K3paeEtYL3kyVXRPVjJ0bXF5WE5WQ1ZZNjhHYVJ3?=
 =?utf-8?B?SmxJNGRVbnpNbzFNK1dsZkNxeThLVnJ3MVkrZ0NmSWZUbldCN0hqdlZKMkpj?=
 =?utf-8?B?Tm9XZFgwWnhlT2MzcGROL3RNdWY4S2JWRmJ3ditpdVFBc2t1enNzKzlmRHZn?=
 =?utf-8?B?TG5RMURUK0FDc2cwY2xIQkRFc29mZkRMMlFOYmFsbVFrMXpTK2dXZjBLVHNI?=
 =?utf-8?Q?yxWB7o9AHF3MLTWGXrSPwQv2hKWFm2frqXJaicT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUc2d3JXT0hYTGY1MFB1b3VaL3lna0ZLbjdIcFdmWVcxNmRsM3NpVEFJaGhN?=
 =?utf-8?B?Z3E2SUhobUU1ejc3ZzA1MzZ6MG0wQ0U4VHE4OE1HYitTVHRrL3c4NnQ5RWxJ?=
 =?utf-8?B?N0tHanFwTHN2MGRaaW00ZHRCZDNrT2V1RmYvYU5hby9Pdk9VWnZGV3lTaEor?=
 =?utf-8?B?N0xLa2xnWWxBR3JqNDMyd2lObTJZa0Z1aE8reWdKakpDZXZ5S1pNaEdhNDBU?=
 =?utf-8?B?U2NVT2FxRUpyZHIxa3hPb0s3eWdyVFNPVkNiaVhKekpMbExIb05JZkRXclRH?=
 =?utf-8?B?dWxMVkFRM1MxZEFUVE5uVlRlbDUyMDZKcFhmMzhPdTlRNUY3eGJNM00yTkRu?=
 =?utf-8?B?SXorL1FTWjZvNHh5eFVFSmp6Um4yeTdPeCtjYXFZTFZReVFuczN6RVRjVVFJ?=
 =?utf-8?B?SFo2Y2ZMeGg4ZS8vTVZlWEE3eXBuYytHME5ydW1DL2F4N2FmNm82OVZLc0VX?=
 =?utf-8?B?UWxYcnUybnRPOWRRcXV5dk9YSnViejVjemhRbWlkdjhPcEtvR2NDMndIdGE3?=
 =?utf-8?B?c0Y0U2hjTE5mR0J0RUorTjRvaUExM2N1YXZ5WnNUU2o2M3pDQkk4TElhb2U4?=
 =?utf-8?B?M3FkR2trV2wyYXF4L1ZmMis3RjhXK0tNZVFxYkhDbXE1Slk5bXpXeXhZV3BK?=
 =?utf-8?B?UGFpT2VGYXljbjBhaG84SER0NlY5bnpHUkhuTXltOHJYTmZ1YjQ5RkRUN2xy?=
 =?utf-8?B?R29uNWdvS1dWVTFTbFVyaWZlTlMrM1RpR2F6ZjR1aERSRGhHQjlBd2JSQTcw?=
 =?utf-8?B?ajY2K3pJMGxmUTFWdTIxWkVTRlJ5RlJKVHFMSm9TZktWUXBER0JQUWtXNUlC?=
 =?utf-8?B?K1JCVTc4RWVQaGRRbTMrZmVvREg5MDBRSkRMODBod2FIbjVGRExyOEp3eTdR?=
 =?utf-8?B?SEtJbHhOdGdBay8ycmxINXFsWVZsaFF1MlJoK3B3eFh2ZE5rL0liRnNISW1N?=
 =?utf-8?B?SGRMQ0JxeTZnNHlLMGtuRDRmTHVaWWF2NXNHZWl1dEgwRjd3NldIMlJHVDNP?=
 =?utf-8?B?akgrdGV3cjBpcWlMdUtMRC9jRzdpT2oyT01NNXB0bmJYU3E1d0hrMjdDcjNF?=
 =?utf-8?B?bHBOa0RxSjlHVis5N1k2dkZDTzBoZ1FSRm9qOXkycEVJdWhydFk4VHFNRWJw?=
 =?utf-8?B?VlVvaWdWQXZhZFNBVExYVmNEL3VKTHVhbEZCaU5KTVlmeTVvN2VzVXZDZW8r?=
 =?utf-8?B?ZmdxVlJubTIxZ0hid1B5dW10S29yWFlSYlREbWhWMGwrdlZoRkJHMWJBbnNu?=
 =?utf-8?B?V1k4YStjUWxHZnpHNzRWTWlBcFFteUhhY2NTSjE2TlB4a1ZpaEhoVHEvUmd5?=
 =?utf-8?B?N043d0k2eVpEcCswcEF4ZWtXSWplK3RNUGVZcHNFRHBDczBSc0ZoVHhnTEVT?=
 =?utf-8?B?RkpzTEJ0amY0YVp6eEY3V2tZSmdWbExmZlJsZlZ0dFkvMmpQODQyNU9DL0Rx?=
 =?utf-8?B?dGxheEQrVnRlZm9Cc2wzMWFXaDgvZGtxK3A3ZWJrNzdXbjlSVUdrejFueW81?=
 =?utf-8?B?elJoblR2a3BPZndPSmp2WXAwRkx5eExYd1lrM215SGh4SWYyVXg3aFZGN1ZT?=
 =?utf-8?B?N1dlL3QyYzRONGJyZlRJanYrQkFBVmFJQy9TZlY4TENadFNyYm5HU00yeDhT?=
 =?utf-8?B?Zy9VTDJqVWZ4a1BZTmFhTitSN3hOaFQ2VVlIY2J4WDRtSytXR1I3QWpRS2xW?=
 =?utf-8?B?Rm5zT3VVYUdjOHRxZHRPK1NGQmF5RTJmT2FVa2xFZnR1Q3RXclMzVmhzTkl3?=
 =?utf-8?B?cmwzZmVSOHFUWWRJNWl2TXYvb3RYZ1NSZXpsR1pUS2hiaHM3TlNuSG9EcFhG?=
 =?utf-8?B?QmozaWdJR3l2TGdIeUQwY2xWT3IxMG5tbmsxUm1yejg0K0JNNnRjbm5ibit1?=
 =?utf-8?B?NFBEMUd1Q3cwNFdNN0hjVEcwaWw3eFpHdW9tVFVOTk1INmx2MUdLcHpoQ1k5?=
 =?utf-8?B?R24zM3ZqcERyOC9kMDVOOEZGK0w4WmZ5dnNkOSs2Tjd4NjdaaVN5VnNpK2xM?=
 =?utf-8?B?SEtXbU1YOEZqakVVU000WG4wQU54RFZwWXpxYUZ3Ym8ya1F2K0xVbE5KVW9s?=
 =?utf-8?B?U3IzM09DUjRSNGMzKzdnemd3SlZEdHZmajhnUXhlQTRmaDJHWGVlMFExeE4w?=
 =?utf-8?B?TGkvSmwxcHFqajdobmFHUkVpU0twZzRSb1hoZ2RrcmFvOGJ2T25OdkFEMXAv?=
 =?utf-8?Q?rZsf3SxLnamItSWxl0qA1Bg=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa98715-6b75-479b-ebd1-08dcfe479013
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 09:44:09.5013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVQpaq8B1T87rp/I3lLba9a1nqKvz1GvBQv8ICdWcNGMUjGNrvjpYXAFncPKCFJQ+MI5PC+wKQ27tgEbDgD6OVMj3kJoblb539jQ29c1Bfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5332
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


On 05.11.2024 19:02, Peter Robinson wrote:
> On Tue, 5 Nov 2024 at 15:15, Simon Glass <sjg@chromium.org> wrote:
>> Hi Peter,
>>
>> On Tue, 5 Nov 2024 at 06:10, Peter Robinson <pbrobinson@gmail.com> wrote:
>>> On Tue, 5 Nov 2024 at 13:03, Simon Glass <sjg@chromium.org> wrote:
>>>> Hi Tom,
>>>>
>>>> On Mon, 4 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>>>>> On Mon, Oct 28, 2024 at 05:31:30PM +0300, Mikhail Kshevetskiy wrote:
>>>>>
>>>>>> Legacy TCP stack is bad. Here are some of the known issues:
>>>>>>  * tcp packet from other connection can break a current one
>>>>>>  * tcp send sequence always starts from zero
>>>>>>  * bad tcp options processing
>>>>>>  * strange assumptions on packet size for selective acknowledge
>>>>>>  * tcp interface assumes one of the two scenarios:
>>>>>>      - data downloading from remote host to a board
>>>>>>      - request-response exchange with a small packets
>>>>>>    so it's not possible to upload large amount of data from the
>>>>>>    board to remote host.
>>>>>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>>>>>
>>>>>> This series of patches fixes all of the above issues.
>>>>> I know Peter asked on the last one, but I want to ask as well. With lwIP
>>>>> merged, why do we want to add features to the old stack? I can see
>>>>> fixing issues, but not adding new functionality as well. Thanks.
>>>>>
>>>> Let's apply this. It has tests and the old stack is still used by a
>>>> lot of boards. At present lwip is only used on one. There is more work
>>>> to do on the new stack, including finishing off the sandbox
>>>> implementation.
>>> I agree with applying the fixes pieces, I do not agree with apply the
>>> HTTP server pieces. This series should actually be split into 3
>> But what is your objection?
>>
>> I would much rather just apply it ASAP. It has already gone through 12
>> versions, during which lwip has been prepared and applied.
> I highlighted my concerns about it all being together all the way back
> in v1, the fact that it should be 3 separate sets of patches.
>
> The fact that it's at v12 is irrelevant and should never be used as a
> reason just merge a patch set, it makes no senses.
>
>> The HTTP server is a useful feature and we should be able to use it to
>> test networking in U-Boot in a more self-contained and performant
>> manner.
> LWIP has a HTTP server which is widely tested, that is what should be
> used *if* we have to have one, I still have yet to see a useful
> usecase, and no CI is not because ultimately how useful is testing
> against ourselves, the fact is testing the HTTP client against apache
> or nginx is a better real world usecase because the reality is that
> U-Boot being the client and the server in that use case isn't really a
> real world use case.
We are using httpd server in u-boot for the emergency firmware upgrade
purposes. It have the following reasons:
* No need to install a special tools like tftp server on clients PC.
Only a browser is required.
* It much easy for support and client both -- the less specific
knowledge is required the easy recovery process.

Mikhail

