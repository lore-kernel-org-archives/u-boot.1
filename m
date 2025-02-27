Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A1A0C021BE
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 03:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6414A807EE;
	Thu, 27 Feb 2025 04:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="KBYt9CeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 560B180805; Thu, 27 Feb 2025 04:30:34 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15CF5805C3
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 04:30:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/Dhv3ErMZfFHa49zGeb5mjn5IBV1vzs4ahZxqldUqT+Woqr/yqnhrb6GVTE2hsuhV/s67vu9wKNQ1eVbbLBAGyMgmxJsdmjVuPpXpLYR2tRAlVNZ2QHDEQn3T3scv5iftUu2h1IfV9UM/tjD4tuFirebgeGrjudmmIhEdbfiJqdvW5IFiv3rHpd1dROLH7d7zKb9E5ZNXsBSjR3Hd+YXJrZAjQld49Vcb68w4nr9gChr+U9kYXuGcYNBBeX/cxuiZ9d8wk551snG5FsI8BEHw1nBvbj6FpmSZV6Fsc+mq18UeIQVAUTUTlLUkvk6lFwvZ4FjsVWUM+Ldjq5I3hKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bA3CGlccAbIulOak0rHX74b7PfHtxuU/qwjLegwcxvQ=;
 b=FohrL0GnJqZCJYwrJ1eKgRHfC6cko39QHAD1KQ+W7S7wWN/6bV1gkNBjAP4rPAxSCPo4Ayp2TMTxn+f8dxrFAniOoPWUWihiMTX6oBhqmKOAHN5q/HiHZ5Zyz0DGKOIFIFmcwx4tu+PC3dOvgn7cFm/otDd+yZDtAKghQeWuosAnufL9B1PzvuPIdovbTiB44iKLReJv0jtvrkwMNq6Fq3iChndGtpgfV+4fmLOywY+553TRxQnSObIMIeUR1bHoUbJm+7FjKahnytDpB2Mm4HYqhwdUjab/I2ZpaGitMa2L+SqMM3cMpnxPIZSixXDUWoKsc/zxssBuU4c2roQXTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bA3CGlccAbIulOak0rHX74b7PfHtxuU/qwjLegwcxvQ=;
 b=KBYt9CeXPIBSrzVk4pw+NJpSKlpmR2oTzH8vynhkTdCmQl+30yh09jODQlZKpVNDsIDNbIs5Nv0Hi0jJiRjjpVuVX55MB2QWhbdDKJGWp2cM2jR99fmdMzkfijNczOaUoC9zBlFk6Ag7KH18vPE+u4LwAACggZdD8w0c/nqjPFfFYqsypE6XE8OlZ+bQchZNf7vpCbYfQW0xIMkI6CFLpb9pM03AX1X6iTH4rhlZm9DZL/DsjQ3eVfUjoN/6rL6kHSXIiUkmylXsEm8LoxKDXiiHeXL3st6SbJw27qRPiVen3Sz2r8uw4LiB/+KDEGxVaSEHDyInj+uVXFjRyMQcuQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10535.eurprd04.prod.outlook.com (2603:10a6:150:204::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 03:30:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 03:30:29 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Ludwig Nussel <ludwig.nussel@siemens.com>, Simon
 Glass <sjg@chromium.org>
Subject: RE: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Topic: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Index: AQHbhRpY04AkkA2i5k63U7t2wu8txrNaNoCAgAA9rQCAAAiQgIAAAKYggAAEOYCAAAOyQA==
Date: Thu, 27 Feb 2025 03:30:29 +0000
Message-ID: <PAXPR04MB84590221EF186A1120443F6F88CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <20250227022748.GS2640854@bill-the-cat>
 <CAOMZO5CeOjL0iNSQeC-S0u10vx-T-Kkj82-E9Aes5jKTB227tw@mail.gmail.com>
 <PAXPR04MB84594EF4E0FFE527C9760D8588CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5AsDdS8qiscaFaYf+c6+GSH-rMPb6y-EFc_UgBV1NM+Sw@mail.gmail.com>
In-Reply-To: <CAOMZO5AsDdS8qiscaFaYf+c6+GSH-rMPb6y-EFc_UgBV1NM+Sw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10535:EE_
x-ms-office365-filtering-correlation-id: 107b76a3-ac51-43dc-73d8-08dd56df1546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UkxreTMrbVB0Qm52YnRnaThPRy8wN0ZNRkFxcXV4ZUIySEFpWm1XTVBoVnBo?=
 =?utf-8?B?THp4UERTb0tvcnlNQVRFMTQrQ2hkS0pLdFdCWitCbzBmQlVycHlxWlZNc3hy?=
 =?utf-8?B?YzVtcDhPMDdhaGkydmJRb1kyNVZSenRPV0hMQXljdjljZVZLNnBnS1o3a0RW?=
 =?utf-8?B?TEowK01XV1h1M1U3WFU0NStjWEZldU9sbDhtQ1g4TzhjM1ovNkNGeDR0Y2xl?=
 =?utf-8?B?dlBRLzg0Qy81ZVpWUk5TVDZFTVhJUmt1WDUzYnJZL2p0Sk4xMnZ2RE1sVEJ0?=
 =?utf-8?B?U3UrcXZlclFURFhQRTZueHg0NHhRWWdvWkVXRmFZUFR1WGRrQ1ZueW5aMFhm?=
 =?utf-8?B?Uzg5MGhQdDFIeDh5MzFGQnVGelBlWVNkejNjM241ZEVHTnZxeTBIVmUwNE5S?=
 =?utf-8?B?OU4rUCtHbThGRStUYnVzTVFMSDl5V0kyLzVQQ3p6cUlDbVJmb20vTWJkWVRC?=
 =?utf-8?B?ZStXRjF0MDhOTEQ0SVZsMVRnNCtmTy9DYkkvd2JJYUlqMDQ0eE90dXFSNG4z?=
 =?utf-8?B?azBtUGVXQnhNejV5M2VIZDJIdlJQODk3Qm1NMzBXSkU4NHJlSzZWRzNXbDY2?=
 =?utf-8?B?RmYxSmcyM2NDWTNOSmRLOGpXcWJlTXVYS2M2R0tpS0k3b2VDNWFTOVZwTEhv?=
 =?utf-8?B?VXBKYTZuV0FSL2lKeWNOU2VicGdEaUdiclJ5RjQycEZQZldjVTd3dTZGSCtJ?=
 =?utf-8?B?UnEyTWZzTzI0a2kybXZwR0Rmem5MMUc1N083RktTRnRNRDlkM2dWN2lrZzBx?=
 =?utf-8?B?QlQxVjBtNlhYYXlnUnRHdy83ZHJGNTd4RmsxeVBDSWxpeHl6bWpXMWc3Wm5k?=
 =?utf-8?B?VWVBc0NYZ3c0YTlTZFBBS3JiK3NEWUNBUE0rcWI0Ujd4R24rMVBKQWlFYjVG?=
 =?utf-8?B?VXlaMkRpZ1J4di9jaE0xbCt0cUpGQnhVaHl0Z3NpV1FBeE1wRHhhdWMvK1Q2?=
 =?utf-8?B?Ny81ZDVVKzBTTXB6RCtxSjI0RXBBTGNTaGZJT3p6alhMUWJhaXA5b2JSMVNz?=
 =?utf-8?B?V2NVWkxaMy9NeU5RQkI4Y280T3JPZUQ5aGhWbWdUV05BalBQUm5IQlIyMEts?=
 =?utf-8?B?V1RCVmRkMmdha2xvSzV6L1kvOGhrWjlyb1JCb1FadnVlQ3Y2T0VjMDlDdUxI?=
 =?utf-8?B?b3djTXJKNmRVOERJUE9najlUOCs4KzNpY2RxTU5pNWFyOWJ6RmUrakV0SWVn?=
 =?utf-8?B?SUtjS3E4WGxLdVdhUUgyRTcwcG1HdE5FQ0V5bDRMVGJvbDZGcXlHZGVYakxD?=
 =?utf-8?B?MUlEbUlpRnloRFNJYXhoMGhjN204T01HZ2s2amR5cjI0QmRURllneENGTUxE?=
 =?utf-8?B?SnhETkc2OFJWVWd2RFpRYzV6aUFKbExaeGwydDE5M3hJRVpBMTFCWEwvQ3po?=
 =?utf-8?B?eEQyQWIvVGNpQjJYcldTTnc3eVAraGQ0Q0xxVjh3Rlk2OEZQVGsxblRwY0Jn?=
 =?utf-8?B?TGZjcGFrWTJ0SGdpYnlhWitMUVlRaFBtOTZ1Rnppb3IyMlludGhrZ2FvejRH?=
 =?utf-8?B?NVdlcE5LZUZmSiswcnVYWHNrc3NlQUU0ejVSeklpVk5ydUd3OFRydlpFSmdF?=
 =?utf-8?B?WlBFK1FnYS9DTjgycGJjeFhzbTdjejgrYXFwNUN4bWZBYnJQUVJzK1V3YnpI?=
 =?utf-8?B?dVBPQUxqQ2NpNDB0aG5abUN2OW5hOHExZE9uNkFsMkM1bTFvNUhhSWtVRzlw?=
 =?utf-8?B?eldvMjNCYjl2RkNqdEFCc0tXYk1uY3pLU0pRMUw3SWlycm5XZmNvK3g4MlJY?=
 =?utf-8?B?ZEZNSW5WSis0TWRqdEoyYVAyMGdLWUpVN04vOWluZGRLb0NTMzRSZjNaYkVx?=
 =?utf-8?B?Y1JuUUJFR2gzaGtTb3JIUkp0UlRzbVBJem5IakpwYW5rN0Jrdzk4UmNiNDEx?=
 =?utf-8?B?RGQzRmdTTDViZjMxUEREdWdtZjdzenF0UGJPV3NYemtkNUEzTWdoTGZENkIr?=
 =?utf-8?Q?ul4dA3XaqZTUgf7yM1QjvOneTBxF5+01?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGQ0MG56UGIrN1NjWENBSzIyelFDZm01YXJtWWhtejBDOHVGLzhpM0ZjTjBL?=
 =?utf-8?B?bWNIUkpKcHUyZmp1YlhtYnEzZmU1YzZINS9NMTVqUFl2d2g4cU5kQ2xUMkNK?=
 =?utf-8?B?bmRTQmkwMnk2T3MydXhuYzMzSG1EOWc2VTdscll5TWhHaS9ucFBwLzE2c2lx?=
 =?utf-8?B?M3JmMStLaXJDcUNYWHdJbHNxb1BqczJpbjdOYkV2RHJrdm11UVV4OWQxUDk4?=
 =?utf-8?B?cmhxeEFVT29udkxpaE5UVVNxRHkxTWJNdDJ4WWd6TDd1OFg4SzVqTFEyeWNY?=
 =?utf-8?B?TWQ0TEdpeURvaHF3U1pjbktqVWtPb3ZnVFIzY3FPU2YwTDNIcjNqV1pRUkt3?=
 =?utf-8?B?NFhVZlVtWmRNZG5mZVRxUkgxUk10OHptSUVKTjJVMldJN2VJdlZ5WjVEK29V?=
 =?utf-8?B?SXZzTmFkKy9WakZIV2d3SjBLUDNFSTYyZnVnaEtMQmkycUl1RlZRTkRiU2R3?=
 =?utf-8?B?NHE5UFFlYXFNQVY2cm82VU5RMkszU1diWXY3R3puRVNDUG5Uamp0OGorbUJH?=
 =?utf-8?B?N3lmK2dQdHMyNTk3WDRiWXJ5ZFJrN2JHM0IrWmh1SDdVTmpTMmJ0Rmo4VWdj?=
 =?utf-8?B?bWk3NllrMjBwbEttTE1YaGszTFJ0QXVRbGR4b0k4LzRUMXZHRUVrbk5tTEo2?=
 =?utf-8?B?MndhckNneldmc3ZNK2ZFN2d1Uldtb2tsUmJoY2V0a2JrVzJzOVFEbWhjK1FO?=
 =?utf-8?B?eVJQSG5uZUVhLzI4MiswUGkvbS9seHZudXUxZjZpM29QUnpNTDVtakQyU0Q5?=
 =?utf-8?B?SzZiblloWUwyWVdYTG01NUlBd2JBUml5bTcyRkNSYXpjeFc5V0xEem9idytJ?=
 =?utf-8?B?Um9uMnhCY3ZSYmMxWnEwUG8wNXQ5aEpva0lhZFdTd0lOcXhVQ3VWUXVBVUkv?=
 =?utf-8?B?a3lMempTcTczSUFjRGo0TU5qTFhOdlpJQ1BZT3ZTNHJVWlhCSVdhd09mRlYz?=
 =?utf-8?B?MHN0SEhzdmNwRjhGK1ZOcU5GMzBBTUlaSWRpbnJqa3UyL2x2VmNBOHdKb0tl?=
 =?utf-8?B?NEFCcEh6RzQ4bjh4MGcvTnBjUzFWMHQrczVReE80VjhFVWU5REcvRFBhR3M2?=
 =?utf-8?B?akRKMkxqMWM2TWljVDBaQ0h3V29iREpEeDFLQnhmWkVQeDJrb1pVa2QyNTRr?=
 =?utf-8?B?emdFRUZKdTNnekZQZWVYdDV2ZzAxVXdTRVNLazcxNTJNeTNWMkpWL1ljM29k?=
 =?utf-8?B?M2VBM3FSc2Iyais3c2h5cSsvMnFvMEpSYU9hVGZEc2N6aGRUVUFXc2JmcW16?=
 =?utf-8?B?Q0F5N1BQMVdVaHExVXQ3SDF0QkRHWWhvVkV0RVpSUlFPRWE3K0RjME45U0Jq?=
 =?utf-8?B?Z012bnR6dWxvMGFENVpuanBrVUdKSHJTQVhZV04rZlppcExyZFc0Yk5zODJH?=
 =?utf-8?B?TDU3bk5zQ0pEdnY0NDdXY0lMeUJqL1dWMFdmU3pjVE1MSmpZS3pXOFd5L1Ra?=
 =?utf-8?B?aXdubW9FUmlnN3NNWUlRREhUb2gxRU1STzZ1V2NEd3Z6cWtOOXBlT0kxSElS?=
 =?utf-8?B?UWhYWDM0VlVMeXhzTHlsLzlBeFJZU0hieU4wN0FOdno2UHk1K01PajVDU29X?=
 =?utf-8?B?cnc1VVJwUzZ6Y2lqazdLYWlDbkpxK0hsZzBJUkNSaWk2OGhXMWIweWhBRXd1?=
 =?utf-8?B?eVM2Wm9jdGJQV01BbG84NG93Yit0dXNJUC94UG50VzFQK0xtWnJ0ejJKT3Bz?=
 =?utf-8?B?ZmdJRExmMjYyMTREUk9pVDdzUDZ2M2IyOTFxOEY4U1hBQ3N5OTdMcWR2YUJP?=
 =?utf-8?B?eC8yNXk1UHA1WkI1ODNmY0lmaVJ4RjRxenF5RkU1dFIraXgxZ1d3WFkzS3FF?=
 =?utf-8?B?RVFNTWpFdDNvM1NoR2ErZHhEclhaUkVyWlFPdFl2YXE2c2thNmVHZ2pKc3pE?=
 =?utf-8?B?eUY1VWlUZ0ZkdHA1M2d6MXMxV1pveml6bGZMejVmWW5hOUMzdXo2d0VCdjIz?=
 =?utf-8?B?TVNmdkxtWU9qdkRESkdremtyMXVvNHEyOVA0UjFBRFRIN3ArSVArc08wa2d2?=
 =?utf-8?B?Z1FOWmlMLytRTFhQNWoydFJSKzVvZlR1U3Z3WjlBZHBUNkdoY2tTOFNtZWN2?=
 =?utf-8?B?ZWhMTlhCSzJTejR2aTZBNXRIOEl3QkhSRTU2eGRmK25hUktZUXQ5TGVrZzhk?=
 =?utf-8?Q?Fvec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107b76a3-ac51-43dc-73d8-08dd56df1546
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 03:30:29.0533 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwx935gqS5vq4i/ugzZuJTvIf5EtO5vC3ZtUrc/D+HSW1g0dWa5sSfnG6MadD9VSpIcsb1qZDUQp2R2A60G2ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10535
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gaW14OG1tOiBpbXg4bW1fZXZrOiBmaXggQk9PVFNU
RCBib290DQo+IA0KPiBIaSBQZW5nLA0KPiANCj4gT24gVGh1LCBGZWIgMjcsIDIwMjUgYXQgMTI6
MTHigK9BTSBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IEkg
YW0ganVzdCB0cnlpbmcgeW91ciBzZXR1cC4NCj4gPiBBcHByZWNpYXRlIHlvdXIgZWZmb3J0IG9u
IGhlbHBpbmcgdGhpcy4NCj4gDQo+IEZyb20gd2hhdCBJIGNhbiBzZWUsIGl0IGlzIG9ubHkgaW14
OTMtZXZrIGFuZCBpbXg4bXAtZXZrIHRoYXQgbGFja3MNCj4gc2V0dGluZyBrZXJuZWxfYWRkcl9y
Lg0KPiANCj4gSSB3aWxsIHRlc3QgYW5kIHN1Ym1pdCBwYXRjaGVzIGZvciB0aGVzZSBib2FyZHMg
dG9tb3Jyb3cuDQoNClRoYW5rcywgYWdhaW4uDQpXaXRoIHRoaXMgcGF0Y2hzZXQgYXBwbGllZCwg
SSBqdXN0IGdpdmUgdGVzdHMgb24NCmlteDhtbS9uL3EgZXZrLCBleHRsaW51eC5jb25mIGNvdWxk
IGJlIHJlY29nbml6ZWQgYW5kDQpib290IHdlbGwuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+
IENoZWVycw0K
