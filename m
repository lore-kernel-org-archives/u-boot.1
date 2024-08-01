Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18242C52D1D
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 00:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AD9388A6D;
	Thu,  1 Aug 2024 02:24:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="b+lbdyp5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2457E88AB9; Thu,  1 Aug 2024 02:24:53 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A666B88A00
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 02:24:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=zhiqiang.hou@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFp9hQz3O2pMI5hMlCaU0EtnwT8MuoUT9U975Ptef3Tlcpw5zfR+84cvNf2ebiMxZ/ANjxUA/ClEsFpK2kKBdOKgTebsIu2106XyyPY7gNZYLmgjZbBiItVjKjJCKiLTEiJH2rlFEcx3bwlXXIYZWpYsNqCRddZKpZL9ozbxztKTRoi4ccpW7s7yw3q4KPDnJyglzx+MHbUFgc0RzXFCs3DZvk7Bl4Tvx1q2YYQy7V8RyTmJJ4U72vRnsjSSdmz62e50RaUK4Sdl7Sg6x1XLJwUTlV6Sx0k5i5F6ui4TG0MFPhXgzo3Vt+Qe+N7hQDfdtvKN0suxfnPbYvi2ecFN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SjxhZ9l2GXb/o4gM8Y2n2US9sfilhKL4SeM5Onnt+xc=;
 b=T7JSB0lTNBB4YdXPF2se8EK5Qyy+YvMm2uJgVNqDiPMGgIPjjcUDVdcX0eNtg5gAeq4io/ImLOq1y7joeKMol/TSzOfNYJA0hyq6OFyAXUUpl6xfwxbfd9RRSOrschn0QHSsY/ZsPCGh8XE833aejS7uJT1cHKXJo7VUvrSRof04+sFK+xEIxPK2UYgBh7lQu6mv7jymGcjlIijaZYHeQkpfWBlJU3ziGTO0wR1HiY3vV4sQz7RoGXMfSC8ldNHVaAc3QgTGGSw3l2n5vaNll03w0CzD2UymLbY4uniJ8g/W6Q9rXkflEyZ/kz3RIDR/Ejmv89DxUnNPcG9qn2TUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjxhZ9l2GXb/o4gM8Y2n2US9sfilhKL4SeM5Onnt+xc=;
 b=b+lbdyp5DQL7z99Qa25E+d8nc1GpJcfT0suucVQg5aB0unJZdZxg5FdzJD/Mcv3T3/jRABuk/yyyZBUrv7nsVyGSrmkEGVFV2IlijFWkhu40lqduoo8mdiEtGj2GHEm4Hw8ODciMejnYVMUr5UlhapAIvAbLxvyTvtyj8TOw8qeFDBnR5hi0QFE7T81Dt2hI4/F1IeT6SPtulXFiQTdUOWq7kmTJplniJSNJ+5iCx7UvMq/kw5YYZ2irZZplDNn92shSY7rzftz4mExnVeRdIIPkyz52iBY0Mwv03k+bk37dmd+rTNwAo4KBrogN0JspwRqZQ/gwi6ybKHH/aYzmNA==
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com (2603:10a6:10:370::16)
 by AM9PR04MB8164.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Thu, 1 Aug
 2024 00:24:48 +0000
Received: from DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f]) by DB9PR04MB9236.eurprd04.prod.outlook.com
 ([fe80::9903:6f05:ded5:924f%4]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 00:24:43 +0000
From: "Z.Q. Hou" <zhiqiang.hou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, "sjg@chromium.org"
 <sjg@chromium.org>, "marex@denx.de" <marex@denx.de>, "lukma@denx.de"
 <lukma@denx.de>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: RE: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
Thread-Topic: [PATCHv4 11/14] doc: cmd: add documentation for cpu command
Thread-Index: AQHa4k97s9yzc7hH0UO37OZ8go0zHbIQ2JKAgAC0lXA=
Date: Thu, 1 Aug 2024 00:24:43 +0000
Message-ID: <DB9PR04MB92363EC2D43B34E7F1FEDC7984B22@DB9PR04MB9236.eurprd04.prod.outlook.com>
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-12-Zhiqiang.Hou@nxp.com>
 <CAOMZO5Du4Ty8rka9g+RJ-TE+33YrKdeQGMgP98eTvB0UJfMv=g@mail.gmail.com>
In-Reply-To: <CAOMZO5Du4Ty8rka9g+RJ-TE+33YrKdeQGMgP98eTvB0UJfMv=g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9236:EE_|AM9PR04MB8164:EE_
x-ms-office365-filtering-correlation-id: d3351f46-36b0-4855-8ec3-08dcb1c056f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VGt2bUU1eXBoVDFOKzJyOVMyMmxqdE1RZWxOYTdkVHAxMGl3RkZYa0RhdUZq?=
 =?utf-8?B?UCthcCsxWWFVcUM4aUpDdU9OSVY0bEk3UUNGUG5COVU5VDBmN09jQ29NRkV2?=
 =?utf-8?B?Q2FDZFZKTk1PeHZMNG51SzVoV2JOeW5VVWJQYVl2S1Z1YS9xQ3g4SmxYYTdQ?=
 =?utf-8?B?MllNYVhTNFY1a1FCR2xoTWE2Q2JpYXBKZ29NbXpORG1aUzBJYklyV3ZjSy9V?=
 =?utf-8?B?WWlkZzBUMHVxMWxsTGFVWVlqY2xXd09zMUtlRFpGR1VUdXZGTEtvL2xvamdx?=
 =?utf-8?B?d0w2UllMVVQ4dEd4OWd2MUoxYnhPdUdQSjNzRXNlaFJuL3lCYXRzL0JoTG5I?=
 =?utf-8?B?NHFxMy96YlBtOTI3L203L2VNQWlheDB1TXRnZStLVm9jbytZWk54V0toNThw?=
 =?utf-8?B?RzQ0U255YkNqS2pqejJGMnN0ZHR0MjVnRkpDT2kyYkFDUHU4c3VCOXU0dlkr?=
 =?utf-8?B?NjFnTGh6aVNJYW1LVFEzM05KVlNVRHFSZTl5OFVBNTY5bkRUQXIyK0hpa3g0?=
 =?utf-8?B?MjFnZWN0MUVjdFVkeG5XYXFSaFQxTGJHK1ZEVlVKOTdMcmRQUkMrQnFWR2lJ?=
 =?utf-8?B?N0wvMHdGa0dESVVBVGNTMVRvZVo5ZG1BOUtsS0p4RlNzWHA2OWZxTXB6WGk3?=
 =?utf-8?B?WTJ2NlI4elFLcWtEWk9VcVpiWGQxbkJPUlJQUHM0VkhMcFlXaTU4ck9FUFdo?=
 =?utf-8?B?Qno0cFlKQ3F1d09reVh0QTliV3VYVXhvTUt3TDRJalh2enF3Wlc1Zm8yN2VC?=
 =?utf-8?B?V2Rvc0h5ZGZ0dEVKVlBndlBHdHV2UDhZMVZhbzZQdC81ZEhFVzBobm1waW5n?=
 =?utf-8?B?REVFb2hMOXR1bFhyRkRWL21ZcmRtcHZiYmhFZ2ljd3FYelRaemp6bUQvcGov?=
 =?utf-8?B?NzdOSjRqbS9RMFROcTcxZ1d5U2VDSERLNkwvTGRIdmU1OEVTeHYyOWR6TDNo?=
 =?utf-8?B?bEpXc1duS2FlMnpuTHBZSUg3eitYcVNVSW5MNkF5d09QTkJ3Snc0Q1RjTkNM?=
 =?utf-8?B?b2wvUnhDYkFBS0FvNFpPYzN3Z2tqWEtFZVZHV1hUZVJrUXkwdlRLS2I0bnAw?=
 =?utf-8?B?dHFQTUg4Tk4vak9obFNmV1VLdTM3cVdybTg1N1J0YmZjY2I2cVpDZEVFVnVE?=
 =?utf-8?B?VzE1ckl4SnhtTnNaOUEyQlR5ajVhS0pzTTZrQktJWHVzQ0NaVUJzTjNBbXJW?=
 =?utf-8?B?dnVnRXhUOTVNdmdkMUF5YmFVQ3RWVVZjSkJBUGV5cHpiekdtVkZ1YllwZEV6?=
 =?utf-8?B?VXlhbGZpSFV6U2JKbmM4UVdFV0FGMzAzNWZxVnJTZ0JKSkxINnoxNTE1YmdL?=
 =?utf-8?B?aTdpakVqZEpiRVdXckcxeHVsT1VvR1c4RDlkekV2cGJkb1YwV1lGdmFWS0pB?=
 =?utf-8?B?a0RLWG1ibS94cTB4di8yU0JsYzZiZGFYMkFuazV2bGtyU0h0VGUyYUJLQ0Qw?=
 =?utf-8?B?a2NHQlM2bjVRMll0NzdzSlZMVjFWT1NKNFJibmQzWEx1VVpra1c1Y1dDclRv?=
 =?utf-8?B?a0dzK0JGVUMwQ2dKdndpQUd5OUo0TlRkQjdkR1hXR3ZSQjhuc0hwQU1EYVRp?=
 =?utf-8?B?Q2pmOUN0ZHo2WWs1WkZwbEt1eEVKbXAwbk1RaHBDTVpQaGhPUlRGbjE3ZUQx?=
 =?utf-8?B?akNFK3pJc1VXSFY3em5VSmdzQk5KbFcrUE85RXJXV0NWOWpHSzdXanVmSzZC?=
 =?utf-8?B?Y20rTWorQUNzTVVKaUZSRkxITXdOR2NZd2krTzVma2s5Y1VvK2hGdER6VEVS?=
 =?utf-8?B?VTZ6TWt0K01DeE9MM1hsTCtmQTJQb0kybTNGZUpJc0ljK3RMSFdaOGtLZGVC?=
 =?utf-8?B?dC9MWTJpVzR0UzUxd2czUzBKenB3RGVZdXZBdldRMm1PV3Z3K0RZUk1BUG44?=
 =?utf-8?B?YW1hZm9SajVudFk5Zm8vNlhCQi9pZnZVbmlPeW5pbnJ2WEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9236.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0M2MHdOd00xdGZrcFhKTytNai90eUY0WUtjOGtTNnhTOEt4RUhoaDQ0M3Vn?=
 =?utf-8?B?RFZRREg3RTk3UTZWMGNrSURMWWVTYnFFcDFBbDVWK0dWclY2MG8vSTVYaTRK?=
 =?utf-8?B?Y29kUHBqTitKVGJFR1FTYk83L3ZvMDdmMUs1ZEFST0w1dWdUVjAraXRZeDZw?=
 =?utf-8?B?U0hpbzZ3NVR6dmFJVDNNNThTaEltYWs3cSt3TFJtQW5xTCtoVjJ0Y0s0T2lP?=
 =?utf-8?B?R1d5dXV1YjFVZnd5MWNoS05ML0J2V0tOTVFWYmRnT3FISktJMUVkZ1VKV01W?=
 =?utf-8?B?R3R4ejlkUTVYNC95cmxCUllPYStOYnNOUldMQXJFRkJxMFVDbUoyRzZGc0E2?=
 =?utf-8?B?c09TU01GQ0d2WDl5RHpNclNrcHFra20rNzVTR1ptR2RtVHVhbVgzNzlhclRU?=
 =?utf-8?B?WG02R2k5aWhNMWNTaXRhcEJzUmdBaGpCODU3dTB2d0grTmV6YzR1NmZkNkc5?=
 =?utf-8?B?bXZZTnBpbngxN0V1cXByckFseFQ2QXljQkk2YXFHd3U1VFFTSHZpTDBsT3Vv?=
 =?utf-8?B?Z2ViU0EvVk5yTWtmMnRndDdaRzBHZjBuNXB4MHo4d1RlVzZWNHJJRDl3ZTBH?=
 =?utf-8?B?MjVGbW4yYUhjSUQ3cy9Mc01uNXl5T2liS2plelV3WWhTTThrZElaOHJzakxN?=
 =?utf-8?B?aDVWdmxRZ21nL0RhMVBLZ29WNzlYMWUvT1RPRVpEZXVXcEVwdXZ2cVZneW1N?=
 =?utf-8?B?QnVFT1ZRRTR2cUJoV3FZSStaR1hDZ0RXekpPc3RES1N2UFQvODNSNU9GOHJE?=
 =?utf-8?B?cUdpSFQ2ZWJEaW9UeGJVVG80VnJDbjVnOElVb3BQM2s3QjJ2eUtxRzZiY2Ro?=
 =?utf-8?B?OWM0NlpzRnJjUE9HZ3pYRzF2R3EvQktEbG9ETTIwUlBySmhmeURPUVVxR0px?=
 =?utf-8?B?RklHcE5YdDlXVWZoenltcXdHeERYaXZLK21EYU9STmU3UUVhSlhCblVDTEN3?=
 =?utf-8?B?dDZnSFQ3cUlZNEdmWk9FR1ljTjRITy9FL0pXZDluQ3V6NENUK0wrM0dWVDJM?=
 =?utf-8?B?bzVxaUMwRDJ4bXVyRTMzUElJSkQzelcxelNhRmppSGdWL2Z6Y0U3RFVaZmtx?=
 =?utf-8?B?bDZtZm1YU1BkbzRRMnRqdE1vT0d2aGJMRXFUMW1UZ0ZPcXQ2aENZUHYyUlor?=
 =?utf-8?B?QVFHS0pZRlp3MXJaL3BOSkpWVk5qS2lTSzF0dURyV0hZakNZMnpLVk44NUFj?=
 =?utf-8?B?WkdzTTZhVm1wa091cHJaaGhsL3JGc1ZoQlQvZEh1QjdTR2RucEt2ZnJzVVp3?=
 =?utf-8?B?VlQyTEhpWWQ1MDl6cEJhVWhTYUZ6L0wrNjJ6SU9tT3FIQStxdmhNZUVqNThS?=
 =?utf-8?B?NzNRdGoycE81K2I2VUsrVFJKWDZXRHg5WnhMcnFoejRGRXVjK0NtbU5QWmh6?=
 =?utf-8?B?WTFMeDJ5YVVQRk9tdEdmbW54RlJJOTVSbFg0K3VUSnQrZDk1UFJDOUxNRlNw?=
 =?utf-8?B?aEl6aktPVWU2NUxndndpck9rVU0yczBObmdUV3BuNUlObmFaUEg1ZllqbFVK?=
 =?utf-8?B?UE1VbzlVM1gyR3NwUU1WVngveVBudTc2QUsxemZpS0lzUW56K09XLzN5OHFG?=
 =?utf-8?B?WVNLL1dZUXZ0a0NNdm5hWWVjUlJ0MjJCc1hxZjN3azUwUVpOdjV5cEJ3cGpm?=
 =?utf-8?B?NkRwc1ArWHVEd3Vtbnl1ZmxNaXdpUGlPM1NGVEN6d3Z3MVJ6bGE2UVEycDBI?=
 =?utf-8?B?VmM1MXorLzdOcFhMRHF1c0JaTEo0dUZTRk16Z1RrV1BCMitSUkdNb2MwUmRR?=
 =?utf-8?B?MFRtTVo4bElwbDdKWnNaUUFmbGFVRkh3T283STBlZEprREFWYjhDR2RXUitx?=
 =?utf-8?B?Q0QvTm9XZjhvV2ljTXVaZnQ0R3RFYnI0c1I3ZTRkaUp4cW4vOWhZOGQzbHg2?=
 =?utf-8?B?VklKeG4ra2lkZHpSZW9hZTJpbG9rVFFBNFpvY3dpcC9hWmJNZDhUeFNud281?=
 =?utf-8?B?alR1SnpGdVhjREN3TVJGdkxxNERXd0QrUzNyUkI4Tk5TeFJwWE8yeSs5bExj?=
 =?utf-8?B?d2U0SzFxSXkrRDdaZTNiZHNQQ0Nha0xVak9KVTgyMXJpczAxbVl0T0dHOHBD?=
 =?utf-8?B?VnFUQVRMMnRoSnBBZkJsTW1jVVhjWjhhdmpVa01xWlVLdU44SEQ0ZUQwVmc3?=
 =?utf-8?Q?a3qXoyV4Im+PcZhaR7jn/+32j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9236.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3351f46-36b0-4855-8ec3-08dcb1c056f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 00:24:43.0589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uGx+RtfQwvfdjZXu7sgXY0strpwmz+NoeuPXruaVYtzDcZcaNbD+d3iFGGwzfHP5WSmL2PxIMk7ICParPEpZTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164
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
RXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEp1bHkgMzEs
IDIwMjQgOTozNiBQTQ0KPiBUbzogWi5RLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBD
YzogdS1ib290QGxpc3RzLmRlbnguZGU7IHRyaW5pQGtvbnN1bGtvLmNvbTsgUGVuZyBGYW4NCj4g
PHBlbmcuZmFuQG54cC5jb20+OyBzamdAY2hyb21pdW0ub3JnOyBtYXJleEBkZW54LmRlOyBsdWtt
YUBkZW54LmRlOw0KPiBzZWFuZ2EyQGdtYWlsLmNvbTsgeHlwcm9uLmdscGtAZ214LmRlDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0h2NCAxMS8xNF0gZG9jOiBjbWQ6IGFkZCBkb2N1bWVudGF0aW9uIGZv
ciBjcHUgY29tbWFuZA0KPiANCj4gSGkgWmhpcWlhbmcsDQo+IA0KPiBPbiBUdWUsIEp1bCAzMCwg
MjAyNCBhdCA0OjA54oCvQU0gWmhpcWlhbmcgSG91IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4g
d3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29t
Pg0KPiA+DQo+ID4gQWRkIGRvY3VtZW50YXRpb24gZm9yIHRoZSAnY3B1JyBjb21tYW5kLCB0YWtp
bmcgTlhQIGkuTVggOE0gUGx1cyBhcyBhDQo+ID4gZXhhbXBsZS4NCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
VjQ6DQo+ID4gIC0gQWRkZWQgYnJpZWYgZGVzY3JpcHRpb25zIGZvciBlYWNoIHN1YmNvbW1hbmQu
Lg0KPiANCj4gVGhpcyBnaXZlcyB0aGUgZm9sbG93aW5nIGVycm9yOg0KPiANCj4gV2FybmluZywg
dHJlYXRlZCBhcyBlcnJvcjoNCj4gL2J1aWxkcy91LWJvb3QvY3VzdG9kaWFucy91LWJvb3QtaW14
L2RvYy91c2FnZS9jbWQvY3B1LnJzdDpkb2N1bWVudA0KPiBpc24ndCBpbmNsdWRlZCBpbiBhbnkg
dG9jdHJlZQ0KPiBtYWtlWzFdOiAqKiogW2RvYy9NYWtlZmlsZTo3MDogaHRtbGRvY3NdIEVycm9y
DQo+IA0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91
cmw9aHR0cHMlM0ElMkYlMkZzb3VyY2UNCj4gLmRlbnguZGUlMkZ1LWJvb3QlMkZjdXN0b2RpYW5z
JTJGdS1ib290LWlteCUyRi0lMkZqb2JzJTJGODc4Nzg0JmQNCj4gYXRhPTA1JTdDMDIlN0NaaGlx
aWFuZy5Ib3UlNDBueHAuY29tJTdDMWM1NjAwZmM1ZWZmNGQ4Y2YwY2UwOGRjYg0KPiAxNjVjMmRm
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODU4MDI5DQo+
IDc4MjIzOTA4OTklN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlM
Q0pRSQ0KPiBqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCU3QzAlN0Ml
N0MlN0Mmc2RhdGE9WGINCj4gVXB6MHRqa3dGSlNuOWNqVkJkUllVUXNkRGNQRTRtTHZ0aklUU2pk
V0UlM0QmcmVzZXJ2ZWQ9MA0KPiANCj4gUGxlYXNlIGZpeCBpdCwgcnVuICdtYWtlIGh0bWxkb2Nz
JyBhbmQgc3VibWl0IGEgdjUuDQoNCk9rYXksIHRoYW5rcyBmb3IgdGhlIHJlcG9ydCENCg0KVGhh
bmtzLA0KWmhpcWlhbmcNCg0K
