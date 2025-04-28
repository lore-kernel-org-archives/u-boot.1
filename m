Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA41DC36005
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 10:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8FA6829C3;
	Mon, 28 Apr 2025 12:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WnZqGCBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAEEA829A1; Mon, 28 Apr 2025 12:39:56 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D57482145
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzLZuQOhF8DqD7XrIFr+ULWU7hl6TLvRfFLT6PAZr2NZWTHwxc8Dtqhp54kIy2m0oE56EV2sPB/7+Zkk3613x7Vfa36z/JIbbLVY9BPMBMZTX1hSidZwnRU8lK8eF3uVQdHu9ypVo1KkBTreEuvs34Z9N+5FCjMA31RmRYzHJeOoP7bwlNXnzpVTjYQYPt1ctR+seEVR92gR8QMo7KX1eAFLHSz+B/bBU8VwZJTf9jkYT90YmrqaKZ8musNPRnp/L2RkXM91a3+lGePRnkQdkT9eZSSI/kcwbTH3H5UYLMpx76QLANGSZri+TP81C2B7WBrSgZUIx3xR5MyWzh6PMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UusBT8o849bt4Aub4kwXuan8sQh1BCkBBqJT/fsmQuk=;
 b=Ts4fLfctb0/ij0ykPVh3PLhz2UUSK7PILok67WDoMdrcEEhwY5TAtFWmJbG1cposFWt1PC0382RMgPYFwE/0tyuUBQyF1amOSYB/5al0mTKJvMi9TQvxkt1FS2eS8o+zgxDDZq2cIv0//ViSvUyu61JbQjJbW2/vgJp21ux5UldPGMZ93o50ZmeqJEcG+RQgGvWMVN419Fd5swWgEJd1FwDtfPgKIH/j1HENO171d/Pq1FOwltMQyGx8nuIr+H4arMY0j8JWI+dLbdf1sYbt85tTWBnfhNCfP1rThzLY3JJ+55fGTSXxsxnAOPH66V6qkeO9siT/TF5ULuOtn2jxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UusBT8o849bt4Aub4kwXuan8sQh1BCkBBqJT/fsmQuk=;
 b=WnZqGCBWWZMMngZWP3C9RNA3APNLj70mu+TdbKl1J6TlOHNKyAyQ0N56D5Ra+tG3TWdG4D/zzwlZE3+x0PH4sX/mkSfYQkYBIuwBnbEkb83gpR8DeSxxlc/ByRdVFXu6+sCXvXVtVEMCVVWdwg+BuVObnJgfGAKZLCFjINdp8aEpm+1aIhA6A596I/k+5jV45mbXVVd5s9HJIoU9GMW+grQE3TrQMK5HP4fXso6kRjvEtBjkn221ykoi70jiUR2LA1rkvS/j1aq4sxlVfqgunBoGSQu1sEjNzOO34L0IyDd+k/d+MIGiaLKupxVBamdWspsBuDUsqZP33GBEdk0tqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 10:39:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:39:52 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Mon, 28 Apr 2025 18:37:43 +0800
Subject: [PATCH v11 20/21] imx95_evk: add i.MX95 19x19 EVK board basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-imx95-v1-20-a3df9c340ace@oss.nxp.com>
References: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
In-Reply-To: <20250428-imx95-v1-0-a3df9c340ace@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10393:EE_
X-MS-Office365-Filtering-Correlation-Id: a7225fc6-c566-4d8a-acef-08dd864101bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmNiWm9qQlFJRm8yaXRTVGhnK2FIMEs1NWp0ZjBHVU1VNXJ1UUVsVEc4S0I2?=
 =?utf-8?B?QW0waHJpT1JxdE1VQUN6N3B0S3NQd1Q0dEV3STdaR0oyM2V1V1c1UElNWlFK?=
 =?utf-8?B?dDFIQzZzbkxwajB2ZGhLZS9XTVhQUU1RRkRBZkxOaVNITHIrNnNPRFJOMTdC?=
 =?utf-8?B?YldlTVloY0oycmNVV0lBd0hjT1BKUUVWYTk2K0xYcVo3OUw1cEllTTJrMXMx?=
 =?utf-8?B?ZEQ3UVpwRVZuNDRhN3VmQzJTVWpFcWp5UkNIZGxURzlJbnBtK3BEaHhmVzNM?=
 =?utf-8?B?SGY0eFdhUyt4RVg2Ym44Wm1XczJyRjVrdWpYdmxTek9ZVVJQT2Q3Z1RkWFJk?=
 =?utf-8?B?SUY1VEVtbkxObDc3T0MvaUpNQUlQT3lWWUY4a08yc2xocVNteldvblAwaTRz?=
 =?utf-8?B?c09idE1seGFscFdwRnk0NHh2WjQwRmpYWlRJc3ZJblBjS25qdWRuYlpzZ1Qx?=
 =?utf-8?B?YldZOC9DZHpWVVNwcVpLVE4xeDFPVDk1T1RiUGdxZWV3QTBzSlVyaHYvMGky?=
 =?utf-8?B?VnFacXA4aW54Z2hETjRWKzZpaU96T2k2NVpKOENBeTNtWEo5MXJXVmxCVkF6?=
 =?utf-8?B?c3BhV0ZnblI2S1c2TCt6aEk3ZmxhS0ZiamlJNEZpS3N6dGJoYzVhYmMyR211?=
 =?utf-8?B?RmtUSEpRM24yNi83eWdBYmtjZ0lPcGNHYkhGMGVaY2k0L0JqY01Dc0t5SUZl?=
 =?utf-8?B?WnRRelVobUNpM0FlemFOUWtvTWtaOVJLRVNidFRWZ0dzeDB6cjRVTVYyT1ha?=
 =?utf-8?B?RkRCelBSVlJCcElUTXhSYkpqNWZjMDNpQTlzVGtRTE1obVl1a0NmMWhjU3Nk?=
 =?utf-8?B?Mk02R3R1cjluTUR1MkFWY3FrNHRjbzNyZ0dRTDhoZVBZSGs3ZFBqYTF4NC9W?=
 =?utf-8?B?WGkwM2VNN3h1MklXSmpFenI4KzdrRVdpQXh2UzV6cS9SRXJJR2lXTzF1TW00?=
 =?utf-8?B?SWc1Q0NTMHpNb3FyKzg4N2RsUlQ0cWlpSklISi9SM0NlYU83WVFTLzg1MWZI?=
 =?utf-8?B?SkxlcjlBQjN3QmVQUEZtVXpNS1R5aHJ6cHYxSUJFbmtpZENab3ZaK2dRY09a?=
 =?utf-8?B?RGVGMFRYdXNhYkJ4QUlOTHZVVU5JV01TblluNVFIck0wR0NkM0VaMXhZR3I2?=
 =?utf-8?B?MXYzMlMzanIyRHNQLzQyU3hBTjhVK0d2UXFPQkVZQ2EwZGVvMmFPNFF3QkZs?=
 =?utf-8?B?bWpScVNlSkZYQlY2WlJManpZUytvSHJ2NVdvbjd4b2N4MFEyZDZUMDg1ZFRj?=
 =?utf-8?B?Sml3TjJmNlZKL2dmdTJiTzRxMlc4Mm1xKzJCT2hHOUNrVkRRSGpqSHMwSmxZ?=
 =?utf-8?B?dWptVi9Lc2xRMU9PVmZvYmJacEZaZlNIM2N0WlBqTmJ0YzA2MjN0Z1Y5R05G?=
 =?utf-8?B?S3B6VFIvMUNFd3htbkRNNGEyKytrMGxvNUowWmUxblRoTWxaWlBCb2ltY3Y1?=
 =?utf-8?B?bzNOSDd5b3lRQmZlRURwUDVWZ3RKcmcrVmRNVGplQ01BV0szV29oSjBJbWJR?=
 =?utf-8?B?VVdab3R6cTdCMVQwUU4zZ2dZM01yUXVqYmRVcXZZM3pDSEFXRTNPdHRmUmZW?=
 =?utf-8?B?ZlRWRU0vd3pDcEl0aGpyRGdlQVNyTFNKczJrMFpZOEFSZm94MDVzTkx5SVB0?=
 =?utf-8?B?MUVBNytMakZiSXFYbXFVQm0zWHVqdkZTalR2Rk9TanJoUWlmZU5uRGYrenhX?=
 =?utf-8?B?Z3AzbE9nejRRVWRvVXo5ZWdhSFU4bC9qVWk2N0Q5Tk9IVUFNc25DeTd3eG1r?=
 =?utf-8?B?OFBGeDR0OWwzY25JWFAxeGFjY1BsQnptWkpmaUJzbFpDajIxN053clFUQzl2?=
 =?utf-8?B?QThYdklDR2NzejRzSXZSekhZUE1mNlNVQWhEZHFhaVdlTmUyWmprdnZDcGJX?=
 =?utf-8?B?MXZGdWNvTUVSRVRLa2w5YjFqUkNtd0p3a295bjllczQvZWkva1hUVGt2ZHAy?=
 =?utf-8?B?VUFLM3NJZVlvWWtCQ3Z6ZVNrWXlOemkvanFCcnNqUUdHNkY0WElCd3dFWTRE?=
 =?utf-8?Q?H3BJ6Z6F5s/VV+DQg2NC3thmYOTRyY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nk9OZ1cxNkJoWExPRkR6MzJHbHJSQmhyZ01JSk1CS3k1ZFZPQTJranY5S2hi?=
 =?utf-8?B?UjRHbWEyWkdCM1E4YldYaVNZM1FJTFREeDU3TGoyekVoYXhSZ0FHQzljVnpl?=
 =?utf-8?B?MjhVdDQvZWhCOVpia2tqb2VMeGQ4RFprTFRNUjgxL0JVMHhrYkJRdDN2ZjZz?=
 =?utf-8?B?YmRjRUIyMzdMTTJ6cTFTVDdVWWw5ZGhNWVk0VGNEb3NXeFFoU1N4WmJBRktX?=
 =?utf-8?B?aWxZNnF1RExLVGZqbVp1emRDZlFJd1BEZEgrQkR5eHQ0VDdySk5USmVwNHNP?=
 =?utf-8?B?U2VKZDIxMzh4UjRMSUNHcmhlektPNjQvZDRyblZLNlZXQjVaUUE2d0JQOGFV?=
 =?utf-8?B?U3l0RUxwZU5IVEN0czJSOFlPNWNNbUpLWGRrd1hwMHZtbHJKQlZ0YnlZa01x?=
 =?utf-8?B?MjVLbEdWOTBOZER6eUZ1UW1yRXpFREtKNWU5ZWtIRHRvdE5hY3RtM0MvR0ts?=
 =?utf-8?B?VW9IYVlsdUZHZjVIZ2ZvTVpEeVk2OGFuMmpGTk5XWGl4VCtMenY5RGNtbE1F?=
 =?utf-8?B?dkdMTldwUjRCVVpwdVlEa3pOVVhxWXk4WklkQTRGVWVIcFFFdFduVnVtcFY1?=
 =?utf-8?B?UVJnbDhQTUFqZVNvRTNKR1pzNEtMemRVTHJPemxudjh5OFJTMHNLSlJkQ0la?=
 =?utf-8?B?Y0hyNll5SkNjQ3BQQWxqbW40emZTUHhHSXl3eFE4QTNDTHVRbmlKUjlwN1pR?=
 =?utf-8?B?QmgyWHZLZk41dlY2SXJJUkJLV0VTVzdYWXNzck5zenhWbFVHeTlIeC9NUFZp?=
 =?utf-8?B?a3RZNzBma3hyUm1HcWR2YU84WFRFT3IyczlLbERyQkxJVGpPUGl0em5QMWlk?=
 =?utf-8?B?a0svVzFkZy9XWDlqLzkzM0VQY3B4NzRCMURnT2k3OHMvQkUwL3BueTZvRnhp?=
 =?utf-8?B?a2s4a2FEd2pKQWNSL05lRVlKQ1B5WWFMbUNpeHp2L0djUU56ZnVGU2JMd25U?=
 =?utf-8?B?V0w0YnFKc2lEdHRsSGlQUThlb3FDRzR0dFlFRUZneG16SnBMcnVkVmFXaWJo?=
 =?utf-8?B?ZEovYXBGTDdZcURwTS9qZGJaUGh0b3NPRjYxOE91Y0dJbGNjdlMyNFRIWHpp?=
 =?utf-8?B?RzBHRWFlcS85TlZVZG1jclhaR0RqL05kVm9Hb0RJNStZMVU0bS93TkdGZU9O?=
 =?utf-8?B?RVNzUmpnSzFIWG5EYmVWYkErbWRFVzQrdHgxK0xCZENNMExDNXQ4Mlc0dmJF?=
 =?utf-8?B?SEZjTm9QdGNDZThTanc2VDhONlpEOGxMR2ljRDZtcWlDeEFqYnYxa2lSaWFn?=
 =?utf-8?B?TktMTVZJUGZ5aUw0cHYveGhuUkNJVjBLRUxYaUVKbGY1UHlsd09WK2ZIeTBV?=
 =?utf-8?B?QTE1RE1hTmtaMzY3aFlCMitZUnY5UmRPbitTNU1hekw5TmZTV1M2WVUyVzBK?=
 =?utf-8?B?NHpmTkd0dnVkVXV1UnRrck1BdFFpR3RyWG5DeGVtRFlKOGFPeVQzZWR5WWYx?=
 =?utf-8?B?bmRsU0dDODFjYlNHMUZSVWd0dy9qTXhXTnV3RXNTZkJTR3czcVYvdGJyc0hx?=
 =?utf-8?B?ZXAvRlZzVVlJV29EdE9lVVJQOTlKSm8xTm5vQUdQK0NveWozdk92MUhpenJI?=
 =?utf-8?B?b0R5dThkVThBYStUU0ZKckxJdnlldG9DNVdZS2x5M2k0YW1Sb3BsNnZOaFZV?=
 =?utf-8?B?c09LWmNtUmM4d0hERXlKZ2RjTjJmRDdCMXcyVW5LMlZ4N0FPL0c2ZUU2RmVL?=
 =?utf-8?B?bnlOV3dOTit5YXN3Z2R0Nll6dHlsYXhkUHk5V2U1cXFzSFovU0FjUzVLenRH?=
 =?utf-8?B?dE5qU04wTm1SYWFMQTdKUVhaSE5VRUFKTHJ1aUZURFBRRTZDczBuYWRNSnZG?=
 =?utf-8?B?aTczOHFLQUNBMmZ1eElRNVBaK25MaERhejNsdDE1dnlzS1hyNmRCL2VGZ2RV?=
 =?utf-8?B?LzVpTGExY0ZYeVRFUm9ZcjlkVFBKN3I2bS9HbFJNM0phNGJBTVpDYnpGZS82?=
 =?utf-8?B?bjU4TjJ0elg2VElxTjc0dEk4OFJadHpHYmMzaW5XKzF2bGZmSVpweElzL2Vh?=
 =?utf-8?B?Ui9leG9kR2JJdkFGa1Y1a0tWVjBQUmpUdWppSU15cnlZaHpIS1NxbG1OREQ1?=
 =?utf-8?B?aldkYWpFU0pNSnZuQWpnNWVGdDVndy9sb1dmZEJnaDJhdHRnYktpczZoV2FP?=
 =?utf-8?Q?K4U/+7N81l8D+z22kvXRmEV9R?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7225fc6-c566-4d8a-acef-08dd864101bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:39:52.0081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrB4LPJF7ic5sykNFGxmxeL55Ku7ucw56JhppIpWXIWOoCKgGlN2rEWJT3KcSbeF3AKBwEhJUM3xiBlNz5Tgzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 19x19 EVK board basic support.

Messaging unit for EdgeLock Secure Enclave, messaging unit for System
Manager, uSDHC for SD Card, gpio, lpuart are supported now.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      |  62 +++++++++
 arch/arm/dts/imx95-u-boot.dtsi                | 188 ++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   8 ++
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 ++
 board/freescale/imx95_evk/Kconfig             |  12 ++
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 ++
 board/freescale/imx95_evk/imx95_19x19_evk.env |  91 +++++++++++++
 board/freescale/imx95_evk/imx95_evk.c         |  36 +++++
 board/freescale/imx95_evk/spl.c               |  69 ++++++++++
 configs/imx95_19x19_evk_defconfig             | 152 +++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst                   | 114 ++++++++++++++++
 doc/board/nxp/index.rst                       |   1 +
 include/configs/imx95_evk.h                   |  24 ++++
 15 files changed, 799 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
new file mode 100644
index 00000000000..2d1f02baa5f
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx95-u-boot.dtsi b/arch/arm/dts/imx95-u-boot.dtsi
new file mode 100644
index 00000000000..5ec3b1c51d6
--- /dev/null
+++ b/arch/arm/dts/imx95-u-boot.dtsi
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr5_imem_v202311.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr5_dmem_v202311.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr5_imem_qb_v202311.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr5_dmem_qb_v202311.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				align = <0x400>;
+				align-size = <0x400>;
+				type = "mkimage";
+				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+			};
+
+			u-boot {
+				type = "mkimage";
+				args = "-n u-boot-container.cfgout -T imx8image";
+			};
+		};
+	};
+};
+
+&A55_0 {
+	clocks = <&scmi_clk IMX95_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_1 {
+	clocks = <&scmi_clk IMX95_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_2 {
+	clocks = <&scmi_clk IMX95_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_3 {
+	clocks = <&scmi_clk IMX95_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_4 {
+	clocks = <&scmi_clk IMX95_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&A55_5 {
+	clocks = <&scmi_clk IMX95_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&elemu1 {
+	bootph-all;
+	status = "okay";
+};
+
+&elemu3 {
+	bootph-all;
+	status = "okay";
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+};
+
+&sram0 {
+	bootph-all;
+};
+
+&scmi_buf0 {
+	reg = <0x0 0x400>;
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index f6a9a13e4c9..0fd82dc0811 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -76,6 +76,13 @@ config TARGET_PHYCORE_IMX93
 	select OF_BOARD_FIXUP
 	select OF_BOARD_SETUP
 
+config TARGET_IMX95_19X19_EVK
+	bool "imx95_19x19_evk"
+	select IMX95
+	imply BOOTSTD_BOOTCOMMAND
+	imply BOOTSTD_FULL
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -83,6 +90,7 @@ source "board/freescale/imx93_evk/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx95_evk/Kconfig"
 
 endif
 
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
new file mode 100644
index 00000000000..441d9beedd1
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+CONTAINER
+IMAGE A55 bl31.bin 0x8a200000
+IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
new file mode 100644
index 00000000000..6af1c4ba628
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+APPEND mx95a0-ahab-container.img
+CONTAINER
+IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
+HOLD 0x10000
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
+IMAGE M33 m33_image.bin 0x1ffc0000
+IMAGE A55 spl/u-boot-spl.bin 0x20480000
+DUMMY_V2X 0x8b000000
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
new file mode 100644
index 00000000000..f9a67353e5d
--- /dev/null
+++ b/board/freescale/imx95_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_19X19_EVK
+
+config SYS_BOARD
+	default "imx95_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx95_evk"
+
+endif
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
new file mode 100644
index 00000000000..5caf763e0cc
--- /dev/null
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx95_evk/
+F:	include/configs/imx95_evk.h
+F:	configs/imx95_19x19_evk_defconfig
diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_evk/Makefile
new file mode 100644
index 00000000000..0f5cec385c3
--- /dev/null
+++ b/board/freescale/imx95_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2025 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
new file mode 100644
index 00000000000..a002767e874
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
@@ -0,0 +1,91 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
new file mode 100644
index 00000000000..d5f5e310b6b
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
new file mode 100644
index 00000000000..08f4da0bb73
--- /dev/null
+++ b/board/freescale/imx95_evk/spl.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	puts("Normal Boot\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
new file mode 100644
index 00000000000..fe968d5a239
--- /dev/null
+++ b/configs/imx95_19x19_evk_defconfig
@@ -0,0 +1,152 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_SPI=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
new file mode 100644
index 00000000000..9121f7561ab
--- /dev/null
+++ b/doc/board/nxp/imx95_evk.rst
@@ -0,0 +1,114 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_evk
+=======================
+
+U-Boot for the NXP i.MX95 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ sh firmware-ele-imx-1.3.0-17945fc.bin --auto-accept
+   $ cp firmware-ele-imx-1.3.0-17945fc/mx95a0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
+   $ sh firmware-imx-8.26-d4c33ab.bin --auto-accept
+   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+   $ make board=mx95lp5 oei=ddr DEBUG=1
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx95evk all
+   $ cp build/mx95evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.10
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ git clone -b lf_v2.10 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_evk_defconfig
+   $ make
+
+Copy imx-boot-imx95.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8ca4b561986..e7ec725cc04 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -15,6 +15,7 @@ NXP Semiconductors
    imx91_11x11_evk
    imx93_9x9_qsb
    imx93_11x11_evk
+   imx95_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
new file mode 100644
index 00000000000..2eebdadc51d
--- /dev/null
+++ b/include/configs/imx95_evk.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM				0x90000000
+/* Totally 16GB */
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
+
+#endif

-- 
2.43.0

