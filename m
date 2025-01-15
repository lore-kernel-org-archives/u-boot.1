Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C33C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C2E480737;
	Wed, 15 Jan 2025 14:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Rxn7orGl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8248280040; Wed, 15 Jan 2025 14:29:16 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D546806FD
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bcjXBTKN8Wrc7j9/U2IzCT+YZHikHaHf2DfxRPcrHPsJe7K8FQuujmGsgJH/LmmLbtBRrS2kYLrabh1kWzWr+d6F7L2EIsamsiFCDOa1NE3V1CDXIbwgJ79BLcMoz60aq+r13oqVJnaBWKiIGKF3B0Ku4xCCFugIgwSS2zFnqjfwUuy/3qJzsfmiByK/XsKRuWZqGDc5plwLC4EtuF4TDRHphRQZU5EZuHquJuaG00PjHG8DxlL/4SOnNcD/wi/0+L5PhTzO8RLZawiOm/HFypwioHZWwAZtCmkH9YUcbOTHc8jJTTak1KOR7AJYE4PNIO7NlCkNhioZRDunaRvU9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj66KKaLbxiClYYiWH2WVu9Xi9KABL8lJje4MLbZaUI=;
 b=c6P3pPWe1tIYSVC0TnEbw3wgEFGG+77dlUsy2ViQVEJNv8Wz7lkDlt+ruCyHZVP9qB40Tis1kTLU/mjJEsBNjzV67dS12U/jnl43T9ked3AK6XWElGM7jIvaGu0lbcCmBijZoZ3MT7INCAIL3BUUPD8TdrU6GJdJ4NvaN33jLHKZHTxaycSnCLHO3ClXsfSG+RoINOtFb+Oq2DGClmeS8wBsZJgHhNcGfo1xiCYmc2mB9Bul2AG2kAd6BKW4lEUUnIyjZqVROhg2fmdAV4rLJlTcsC+iudnYqaXaDPTsa/VuT5jp0JjhCo1m9WjRr/fY2Dpw7R/97DCTTA945M8Oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj66KKaLbxiClYYiWH2WVu9Xi9KABL8lJje4MLbZaUI=;
 b=Rxn7orGlHdRCAphYyBMea2fQ/47LeIx22Hlpo8NBzgqlZA8pLcbyLv7aqVcUD4xLlve/PkKIBCpuOeBe9+Y1j7A1CN4LEZm37FcflO6EsB4qGmD6YWxKio0C8evt4JypjePL7sUsCvysNsN83g38kQWVmhTUNeywNk0oPU9l6F4EsL2VNUXhXGicVQKycUsD8Vo5WpxvTWfcGP6TSnrFmm9I3gAPyF3WbBgMT39+na9EQ+4B2BxPcvMw6IBizXEBPIJoAdmnoNdi5snVocNZSDrskLyBKqugMw6WVWG94zJUQ3TtsrmCI/VS+PxU1Tw6qy4QAeQDZAnci3/lnRJC/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:12 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:12 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:48 +0800
Subject: [PATCH v4 01/20] mailbox: add i.MX95 Messaging Unit (MU) driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-1-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=13905;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=icqeWgzphB9+Ai+Mty2KawgLQC4GOPeTScxBMjmLRj8=;
 b=hFkSw+R3W22v9IDyx/SPgGedoPxYlyBkVstRRRuIZS2u0tlnANqzuoXR2r3SZSIiP1tz9Lnnr
 nOg/yMVYkJeCUM9MGOvCBEN3IWc9UzyQNkxkl5xOcZvmhjzTu8UTepl
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5613a7-5e21-430a-7438-08dd3568991f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUEyM0NWbVBCbEljaXN0TWxYZ2x1Vk9ROWJhMWJqUFlLcHViSVF0Y05mbThn?=
 =?utf-8?B?UElyZzlUSjBNVjlDdXZ0UTVSUHFLaTRDS3FnRWd1eml2Z2cvUmUrRXo2andQ?=
 =?utf-8?B?ZjBleElkYVdsdkZNd0ZDV2s1WHVEMjVBazhMWnRQcHR6V0hEK2c1a3BpK3J0?=
 =?utf-8?B?TjAyd0d5VjQwdVFvSEY2QjE3T3NoTDUzU0ZNRUVKa3ZDd2VHRjJWdDJuVzg3?=
 =?utf-8?B?K0ppTDhFWFFxOHdHZldwUDl5c2tOZU4yME9UbmJTZmVTREZLRkZCR3VIZVRj?=
 =?utf-8?B?ck5NbzcwMGRrMnZmeDY4b2k4OXkrMXA3WmJ3a1J6NXAzZmxBREJvakxWOEFK?=
 =?utf-8?B?dEtLMFh0NWFmcy9KcGZwcjQvUklOM0dLNld4eDZ4b3dENXdmQ3RhNzlJNy9D?=
 =?utf-8?B?WjNiN0xSZG9XMHJSb0J6NzBXSW4vU1F3bnhLOGc4bkk5WlppWG4wK09IaXFj?=
 =?utf-8?B?by9sM3lqZTdNVkNIYkRLcHJuRFptMDhzOElneWp6R3piNFNCQVl2LzFuSkRE?=
 =?utf-8?B?RkZHUThSMlRLb1A5RmZZNkNEU3RyUVBWdkJDRnppK2Z2MTlkd2VPaEcySmhP?=
 =?utf-8?B?VG9GcVo0R2pBSUZNZ3JUaXNlSlBuK3d0TTdBS253bG5TWEl1K0Zzd3Q5M2l4?=
 =?utf-8?B?Z0xoNGkvSVBuQUpwa2JndVdPUUVHeGQ5RldQa05OVVB3M3Y5bzBZckUvSTlm?=
 =?utf-8?B?cEJ2UDJFZGhvbUQrZlMxRGFvY3p5Mis4eUFEZnlvRzJCanc4R00zTWZ3RENY?=
 =?utf-8?B?U1BXN0k3WFRVdzRKSGFKbVYrWFlzbGdJQXhTd2s5Tm5JckdBbmFaRnZIb0VP?=
 =?utf-8?B?Tkk3Z0ZvK2N5R3NkRXBlNWNaNjlQUmZNQnR6VlNJZ2FZM2lkN0p0TU9tZGI5?=
 =?utf-8?B?Z1htZEJWS3ErdGQvYnR5L0ZIdGpMR0dJS29ucDJ4c0RLRnFBMWZ5UTR0c1ZJ?=
 =?utf-8?B?bE5JdHRsRHdQR1NYQ1FPYUdNL2R5aFNYOHMydFZSeDQrVStaVVpROUpKZmRZ?=
 =?utf-8?B?bllUMkdhUU81NytFVE9YdmQrYlUyRGl4eGJwTHdYQnpIZXU5ckg1YXZBeU9y?=
 =?utf-8?B?Ty9KbXJPTzJUNThOTGQ0dFBMQyt2dFlKUFkrRVpvV0I2YUpUQW9FcVEyRk83?=
 =?utf-8?B?VHJlZlp1Y09iNm5rS0RSYUdUTnc2bkVWMG92bkl3Z3VheWhFYk5tMHhpaUtt?=
 =?utf-8?B?OTFPaWhPVUE1dXVDSGhCU05BajJqS3dGRWIrQ2MyYmg4RTI4RTQxUHl0Wjdt?=
 =?utf-8?B?eTNaZU93YlQ1c3l3S1lvdnZYa1dwYjUwVVFvb1lUcmltYkordldPVCtWNU1Y?=
 =?utf-8?B?dGw2dTZZcEd3djVPa3ZPM0xPTW9OWS9NczA3TUdQNTYrVDBQZFpFTDBndDhv?=
 =?utf-8?B?WTFLTzE0dTlmNGlsYkJ1YVZ3WEl1M2hJeWtMY2VvQXUwYVZMbjBFS3p4Z2lt?=
 =?utf-8?B?Ulp1WTNLM25xTEc0NjN3RWc0UHBjL2g0ai9Bb3Q0NzJNWkdURHMvNVExNWpJ?=
 =?utf-8?B?eVlWakR5aTZJa2pNbDBPaGFiNjdlMnJGWFcvLzkwZEtsSG5YckpteHBva1JF?=
 =?utf-8?B?S296VHJFaDVkNERILzdVVjFUU0dWUnZUSlF0WlpqdjNHZ1F2VWNFcld2TkZI?=
 =?utf-8?B?RUlKR0VtYWNJWEtrazJGdmFEZE5sQzZjZkw3cXZqSzdTR1VrcTJBTTA3clZ1?=
 =?utf-8?B?ZGVuK2ZQUG04WUQ1YWhDUUlESjhVZDFtQXNxUU5RMEtaRG93S2FVUlhsTDlF?=
 =?utf-8?B?UTVyMmw2aVZ0b1ZNR3JQTDBqWndFZ2VwV2JTdENXZ0Y4MXc2VFArL3RPem5R?=
 =?utf-8?B?MnN6dEF3dm1OWnJSTzN0TDVycWk0d1hyREJaRTh2NzdUdkxBK1dpeHlYSUZj?=
 =?utf-8?B?YkVmSjBNU21EUTZSaE84eDZ4QS9CR1puVmxCNkRZNTNNNE5ZMXRQZ0w5Nkx2?=
 =?utf-8?Q?ah9xlk2hnbiWpRJaubyt6SglhmppklwG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlV6dFZOeHd5Z0FZMFVZb090c1hHNkIrVEFhNElBY1hxakpvT2tKdlAwcFRo?=
 =?utf-8?B?SjZhNHF3eVk1NjArelM4Y1dlS3d4VVJlcDB3N3JpU3dIaUFTTW8yMnE5VkRS?=
 =?utf-8?B?RmxrYmxqcGRZTGxLUzFGUDE0RU9TTWc1WXg0TXhlK3VCOTcvaGIyU3hBRFZJ?=
 =?utf-8?B?S2FGQUNzVVVFYjdlU1JoR3FhU1lpdG51Y3dvcjNVL0w4clhBZzhlRmdIc1d1?=
 =?utf-8?B?ZVBSRUN4d0padXMzalZhL0krNnRhb0wyM0hiWlNWOEhHSEdJNUFwSkJaNk1Y?=
 =?utf-8?B?TWlnUnk4RmFJR25GZU90NDNINHphQ0pOZFBTV0ZrRmp2dzVFeTJQcGlFYnE3?=
 =?utf-8?B?blVLaHRaTzN2ZW90ZjZVMnliUHJWT3hyS1ZLdi9lODJmdTRIRjF3WFgzY0FN?=
 =?utf-8?B?ZXJvTzU1dm5TU0hsdC9aM1QrazdXeUxlQTZSTkJ5eGFkcVEyYmRmRHZpclBi?=
 =?utf-8?B?T2pQb0xJRFJNWHRqaSsrdFdPa0kvemRHNFZyZHNSMUFDTkNoU2xTM2htbkdZ?=
 =?utf-8?B?eUt4aWhjbzdkSWVSTWMxODNYMWMxNXhNNmpOZDN4MXpiVDFhTTc4ektvdGJU?=
 =?utf-8?B?QmswNm9nM3ZkQzRNM1hiTVBzWmtZdGc3UVZ0dVN3aUVNWGNwMzYzVWVYM1Bj?=
 =?utf-8?B?MXd1SzM0VnlRU2NacTcrMVhWZlJPczFEaEFDL2g2VmZwTmJhcEFFNWhMQUc2?=
 =?utf-8?B?MzNWSjZLUHJ3aTR1SzBjVEFVWFpwVUc1TDRZK1U5QktDVm9RTWNIQ0RyMlV3?=
 =?utf-8?B?eC8wcVFWZVhvN2VOdlZPREpWV0RyYmwxSC9rNSszRGI3bmcvdUMwNnh6OHNz?=
 =?utf-8?B?MXRjaEx6OXN1djZVRnltRTNQKzMrRllXU0VFWEtGTCtVL2VTa205dVoxYzh5?=
 =?utf-8?B?ek0wMGt3ZzBoc3FwUXlqTVFqUEJla2Z4NWJFTkd1OVFYWVUyb0dpR2d4dk5l?=
 =?utf-8?B?SmF4MlY0THFocTZqMlZYK2p4YWZqNVNYWVFTNmFCZTJEQkxkNXg3bHZ2anBz?=
 =?utf-8?B?Z2thWnFKZ1ZDVVhQK1dSVmJSVzRES3lZbWFvNWtjZndqNG9KNmFnejBycjN1?=
 =?utf-8?B?UzIrYmFJOW94TlhNbDlhMitiUjdRb29GKysxakIzTmF2dnlZU1EvTW0yZXdp?=
 =?utf-8?B?Nkw1eUlmbUhHczJXYWk3Q2tGWUQyTlRhMExPckpSN285bHRxQ1lITlIvN3ps?=
 =?utf-8?B?cGVEaXFnWGxWYjZUYnNBUlhQMW1TOU5ienlPbkZBaU0wNDJHVWhxRUNZdmFu?=
 =?utf-8?B?NUxPL01JOEhZem1NUlhzdHNOcSthL3RiVTRZTkp1M0F2Zk1UR2R1RWptMEsr?=
 =?utf-8?B?SkcxYXdOSDAzNnJsS0srWVNQVUMySTRNME0vaUF6dUI2dWp3Q1RDMmtZUk9W?=
 =?utf-8?B?NkYxTTdCVnJNd3F2RXh3U01tSUxGREp3ZWNDdlZ0Y0FjM3Bqd0tZS09TVGlS?=
 =?utf-8?B?aXZDeG1jQjFXVWdaeXYwSGcyQlIyR0l3M21YKzA5d1hyb0NMNDl6ejZzejVn?=
 =?utf-8?B?WXFoVDA0dUI3U2N2S1ZXOEl4UFdLaGttWFo5WEg2SDV2RXF2QXVaSHQvSndW?=
 =?utf-8?B?T1BHaHFwcmJDdkcrR2lodXFGQ3RXUGw5UDBFTURYL1g5SmRmcmNEaFkrYXpl?=
 =?utf-8?B?MklqUndiZ3M3MmltZTZjNyt1MnR5RW8vMmxaUzMvcVQ2T2dCOGdySTk0c3ZR?=
 =?utf-8?B?NmMzZEhyL1pndzBnTjZueVBRajYvV08wOUIyWU9tRzE0TCtxRDRyT016bHRU?=
 =?utf-8?B?RDI2VmE1OUNQb1ZWVyt1djdBRVF3WHZSOUNBNE1qbllIU1NQSlBEQXBuQjM1?=
 =?utf-8?B?TjJLa20rMGF5SUVPVW9MS0RFeEJpK1M0Z1lJdVpQT05sUFpjNUdmVHFiTFV3?=
 =?utf-8?B?VHZGdmdEZ2Y5dHJIMk9kL2ZzZFJPNUZyZCsrTWxOdEw2VzBPdDdJNytmdUZx?=
 =?utf-8?B?RGhMdXV5TUdHMGV5ZmlFcHZzWDloOUJQWXdMUC9ibTVSNXFKbFNHdlNPUnFJ?=
 =?utf-8?B?UGhZcGEyTktPVytLa3JLZFJxTkJGVkZSSCtCcTlXRzQrZFYyamgrUHZ0ZWYv?=
 =?utf-8?B?dEI1L0Q3djBaSHl3OVFibEg4ZFdUbG94elY3UmdRQUtqVkgwVHJac2lMSmZh?=
 =?utf-8?Q?9ikv5GEj6E71igTI3gMTC+2bw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5613a7-5e21-430a-7438-08dd3568991f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:11.9668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNcTZ+NIZe0xiwqEj15HQnBSwfaQpLMu1vSmgc6WhT35otshZOzxq3hAxAPD2OKJpxcVhzoMEAHcLzV7+b1vSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

i.MX95 Messaging Unit (MU) enables 2 processors on a chip to communicate
and coordinate by passing messages (e.g. frame information, event
notices and requests) through the MU interface. This patch provides a
driver for i.MX95 MU using the common mailbox framework. Currently, SCMI
exchanges on i.MX95 uses a mailbox transport with SMT format, and the
hardware used is this MU.

This id ported from Linux (v6.12.8) driver
drivers/mailbox/imx-mailbox.c.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6da266cddd160a041d0594ac86d274..5ab2b72d0f93afaf70c4c2dcb8fc48210683b749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -313,6 +313,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74228ccd82b2725c0bb745354d099948..4d9f004ebad7f57034a6cdae3bff9645fa0ee67d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956b793636c35aa0d1419c9dcaae27095..574add60005fe73d2beba715a12e0157fe4b0552 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000000000000000000000000000000000..931844135325c5758e0adcd55d19f5837aa49609
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+			val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

