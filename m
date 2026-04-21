Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29144F8FA94
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 15:13:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC5984372;
	Tue, 21 Apr 2026 17:12:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T+Vd0mYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BB3883A91; Tue, 21 Apr 2026 16:00:01 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9B083693
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzEUNuR3/kpy+Dnq248fi0Hab1XXYY5hc6Lai9pn/YJeA+qwbTkRBNrZoo80FKUREPVtXtbnt/V/o8TiYjnr6BgZlWPWKL+aYRzKsg+zCBaioWeqSknGMHtUu1ywjFuSqHZ4FnXSf0YR6ifAxLBGj2vJKREX5TEQivcZt8q7L/JfzHbja5CsNk28pcjIeTxM8hmHEcwOlLojtM3CKYjMd9CHX5xP/ZBzTWA3OrDI6w0fnzRrLrvOv899LNaGvgWNsbfFRny0wn1lpB6Pk51jSB+BaprIsh6f15J8BMjY5mvYW055m/NsuC8Oxa+1ggcDSVH7rZqRyQDXn1qL2HIK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTjFIvKdlOwC/WYwbUXMm9EwYRhzk8JHl0UUlWgvm7c=;
 b=SdFoUiSc9vJCZEe1+jGuJy3luFyZyNNMMNPvfKMahTsxWSzZcihSgggsKK6evCa/B8yBJju5742tAv+csh6KeqAd5QfOHGZzyMeumwt37VvJi6yeVtq1lCpvx5O8actyrW0IWLeVVtajVzYur0AfpXPBFEo4QKWnk89xddR8zYI/OEPm1VUISAdXatWaUirjf1H1RtCKaldKVL2C5Vp5jZ6AgQt6J9eCNhubzQMKXBM9kHXomhD6kx2b6K3ySwwOQdRrDKnkZu1gApi24tB287GDYCe92Aa1HB+wWNnXgQN0eFlqCJ3vur9Wju8gwlEq5cxCLwiBNpPNxk46KJ9Jsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTjFIvKdlOwC/WYwbUXMm9EwYRhzk8JHl0UUlWgvm7c=;
 b=T+Vd0mYNop9BR6mL8AwFnwKnKr7At8wQW+/FVdziHUjfQdyhHKV/pbwxZbaasn7smu5qJNgzV4tWi/l5FQFRzTzshDiYdQt3HoGUsW0GUs1ffOfq23DYQMCCjor2n/+wX18MvvJaUpZQ/YIXhzoRrSnty3hKdNmPWSVv5oUEVINgrgl5tcStq7iD/xjJsy2QUEvIZ26+ls/wL0W4f+zkZWRCVycNJrT/MZ/7OuMJ5rCKDjXDbxNR2XRpj9XpcbcL3fI7zM1DNmG2xdmA+YFwpGF4yWQkH+LFb/dqRemTu3Kec22wnKi4sMlq+3yWKBx7x/6oGftwo1Wa41Z9EesEoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10426.eurprd04.prod.outlook.com (2603:10a6:150:1cc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.33; Tue, 21 Apr
 2026 13:59:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9818.031; Tue, 21 Apr 2026
 13:59:55 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 21 Apr 2026 22:01:31 +0800
Subject: [PATCH v2 5/5] imx: Remove hardcoded watchdog base address macros
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-wdt-v1-5-0bd01ec6a7c4@nxp.com>
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
In-Reply-To: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>, 
 Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Tim Harvey <tharvey@gateworks.com>, Anshul Dalal <anshuld@ti.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Joseph Guo <qijian.guo@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10426:EE_
X-MS-Office365-Filtering-Correlation-Id: df3ca645-b70b-44be-a2ff-08de9fae446e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|366016|7416014|52116014|376014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: v+gE3O0hFSk7iY5jgH+/5jbJVXg4LU8ux/R83d0yOJvMGkrNU2mzUSlYhNVqfFkmvtTwptPki8UI/b4FOgbz0I1wqLVhU15NuxCg1A7OOzrgHR5VRcKA20P8F1G+eIBv7ch59QguEFt+pNQmxRzHirxwMNhtaqflpiFl7+HvMWly5+XcYc+wjIzi7aKSVP3ZuB451X8cBqVghi9W/P1qip92s9stj5vDyObzmMlFqg3xXR1V0hoCKS1/dmY8C0F7FZEFG4d5mHdEoDf6k1Fz2MFqunRf5NItrEGmajUaUKUZ/iB1VOAprw4Y7t2WLWAtLYgWgOpVfdjomo//kyqip+lO5GRgPQ89U857LnQoFv/pdGJfKQR5Ry7DvVSkxRkZAR7VBxP+W0icyHEBrxPXPdU8RRtjtMw0PgQgSBdEc5MJQoGRQYVQ7R1fBODG7JGLexBpAzdmfTLf7hfT+BtyO689O4I59ch+hFC5Gj4O0qP29T6RMf+lITR/TNy3m2RZzrF+jF/VSqN8b0Fm+OGz/nxhr95yig2lvs3i+ldp5/jdnbwYBHQW8rGjVjymjYZAkLkF2RB4e6YJqyZHvoI4M5t7WMH2BOZzKxZw6Z2cGpoJ7V0Sho4JI9MzEClkpHX5Xo9AETAt1KkPsacuRinLuj53R1NcKGtgfWJMw/VFGOkzKxuQ6PS6Rtlr6KNweTZZv/zEMtrCP3+bSbYARvtbbh7DMDZGCCQgj8GF6cnVq8vF/fKcSxGM/7xZ+tM5V9CRGrwa4L/6laVqLtc9vHzgOnsvYglotD3+CmGTjw80gBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(366016)(7416014)(52116014)(376014)(38350700014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3puQzVmcEZyTTcybDRkcnRzN1R2Mk5sb21EbnZFeHA4N2JUbGU1b3JyR0l6?=
 =?utf-8?B?d3dHOEFzWlUyVnZ5L0l0Z1BMVFNzR2tLUnA3VlFoUFhyRExZMXVhbnNzajdY?=
 =?utf-8?B?QnpRRFNtSklMVzhnTDEvQ0FZL3hnVUJoZ0ZTR1BQV3hDZkpCTGxuV3kzaHRr?=
 =?utf-8?B?YTU1dHRIRFhUTmZKRGJFbnBpNlptSGtPazZuY01nRVhwYldzV0EzdVl5WTdl?=
 =?utf-8?B?eXZlakFUeEFweWVDcEY3SDR3S2hNaVlYQlErQUhjS2JudnkyY292WS85TVpT?=
 =?utf-8?B?WEFDZnBtNUQyRUZ2TW0zS2g0V2ltN1JxODh6anVlL291YVBOcDgwZWZXanYw?=
 =?utf-8?B?cWpCdUVMOWgrZmZHdzZJbTFVNU0rYXVEMU94eHJvRHYvdlc1OGVFRkk2SFlS?=
 =?utf-8?B?K1QzUENKRUJvZk0wbEpXbGhlOS9mWHBBL3BRbUdyWXdNMGZrNUhIYlpjQXdh?=
 =?utf-8?B?am1TWGM2dGJ4dDFBMndMRmJ0NXNZZElGTndBc0habU5VQW1waE9QTlYzYnUx?=
 =?utf-8?B?bHBpZDV1MUpzYVY5RmZtSVYrVXVKZUgwNGEyV0h5aUlzT0R6SjlpSy9kQkxw?=
 =?utf-8?B?Unp1RVpvbEt6cEViQWpoWjBKMjNWaWRGVFZqQkJBQW1vM3NERlRHY3dRR1Z6?=
 =?utf-8?B?aXZlV20zZXdyb3pCMXBiOWE3MDBPNEVnZytHQWRtVSt0Zzd5STVFcC9TY1Ji?=
 =?utf-8?B?eFphL3J0bEcyelRoTjlvaEhrRHErZnN0b2ZmN3ZmaURNd2RrYmZZMmg5OFM1?=
 =?utf-8?B?SCtYbUF1dWh0NkhnazhOYkdzSitQenBGNnRtV0ljRmJKTk5aTy9pTEhKWjRh?=
 =?utf-8?B?eS9OelBKdkcvRnNpbkFQand5VU9ESzZEMXhNbHljRVltSXAvVE45Q2EwakVV?=
 =?utf-8?B?RE9lSmdZbU5tV3BJMENrL0cyOHIwekhxWDFMZWZQVm9WUHh5dTJKV1FlZzlM?=
 =?utf-8?B?d3QwQXQvSHp0Q28ydm5qVVlrMkpiL0x1Y3VwSzNRUDR0akU3R2kvNy9ZWUJ5?=
 =?utf-8?B?aHJNNE0xb2pGR3dLNk0yNEpQWTExV0Z4ZXlWaWQxSHlHT2hSRFV5Sit3dmhq?=
 =?utf-8?B?cGxEK2lmZGcrSXVSdTdFWTcwUHhLMXZ4YmVZdFFiNEczWjNyZUVXc0NaWEZt?=
 =?utf-8?B?SUJ3L2d0YTd5QStlWUFXRUZDaVV1U0orcWtCaU1UL2k1NEF0SHprSFR3aWgr?=
 =?utf-8?B?Q29RVGZyMEplcTlLWXoyNVFVeFF5TEh4cDN4RFB1Z3FNT2Q1dldHbHpGdG42?=
 =?utf-8?B?N2R2clpVMXJEbEpUZlNjTWh4aHdDSldIMUhNUkppYXhrVkRvcGhCMmJnOXV1?=
 =?utf-8?B?dFY5My80TjZJdjNGVmN2ZUJvVjZ6aVRtMTNxNytIaU1QQVNxaDhraEhOOVNs?=
 =?utf-8?B?cXRBR0NEaW8xYTEvVFVHcFl6QUNPbFk1d28zYTdmK2RBV1RFeTBRUkt0cjJT?=
 =?utf-8?B?L1FBMlBvUEpIT3VVNWwwb21ONkhSaGlYTGhsTEZBQU02NklBbXZ3S3ZEb0Fm?=
 =?utf-8?B?TFRFZWRoM2FmdHlmODV2U2h0bWJTN3dKTFJ3Y3dtMk1tT1ZBVWZWYmdTSEEy?=
 =?utf-8?B?MnVlajBiVWVIRFJZWU1SSWxDUktVT2pFTTl2VkxENTNNUEVVU1pjM1pGbnV0?=
 =?utf-8?B?UGc5K0lrYVc0bW1mSEY3U2xBaTlzV3VYTFVGWjhhWTNXaVI3NSthRVphODRm?=
 =?utf-8?B?ZThyaFdIOUVvcXlHaDEzZHJMdGZoZCtZQkJvRXpsdWtEUFc0K1dzZEF3cjB2?=
 =?utf-8?B?QVVDY2N3VVNoeDlvKzBpQUJVczR2N3c4UlNjV1lWMkhDVmRDL3BzdURqNkFE?=
 =?utf-8?B?djZHVTdRa3E2OUdYNElUclRHQ01OcnlvV25qTXlpSlBwaHdEQ2FHeklXZzRx?=
 =?utf-8?B?dFVTQU1pc0twSXpTOVhHUWVDMjBvYzVXamcvUFJZTjVBU0lWS3lYYmJTcWQ0?=
 =?utf-8?B?MlZuWnBNbURWMUt6Sk9HYlFFemw2Y2tGMlY0Q3R4Wk44ZnJHc3lCb3J1eTFH?=
 =?utf-8?B?ZlZ2bDlBNm9mbTdaZHVndGVwN2FpRWZYQ05PVXBkaUNIMkY0WUVsd3Q5ZGs1?=
 =?utf-8?B?K29jOGNNY0duOU8yM2UyUjFscEFxNWVGVVZZU1ZJR1BVVXZvQzZrbWp2VEhH?=
 =?utf-8?B?aGhwU2xBVzIzalpybFlyUlE2RXl3ZnRlZlZuM2k5Uy85WHZNaVgzajI4Nkt5?=
 =?utf-8?B?VkFmTXcrYzhHNGllZU9EWm5aYXI2VUZRYUlxTnBuZk9aTHZNejJId0RtVWxB?=
 =?utf-8?B?cWIyR1UvcFZhOU9TMkxhRlA3dUJRczVLblgxa0J5OHFHckxRNy93YWpza3N5?=
 =?utf-8?B?WFJvdnlQR0ZkeHNTRy8vUEtwaEJkbk9MalZ5dWNTRkFJd0lYOWhSUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df3ca645-b70b-44be-a2ff-08de9fae446e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 13:59:55.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9c/BOJywOlPMMiD5NtO6s1o5shjAyX1msJIyB+0zj5jpjRKX+kaqa2l3onbJCBnKfV4AL479fqE9qhsP3GAHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10426
X-Mailman-Approved-At: Tue, 21 Apr 2026 17:12:16 +0200
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

From: Alice Guo <alice.guo@nxp.com>

The watchdog base addresses are now obtained from the devicetree via
ofnode_* functions. Remove the hardcoded macro definitions as they are
no longer needed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx8ulp/imx-regs.h | 2 --
 arch/arm/include/asm/arch-imx9/imx-regs.h    | 9 ---------
 include/configs/imx8ulp_evk.h                | 2 --
 include/configs/imx91_evk.h                  | 2 --
 include/configs/imx91_frdm.h                 | 2 --
 include/configs/imx93_evk.h                  | 3 ---
 include/configs/imx93_frdm.h                 | 3 ---
 include/configs/imx93_qsb.h                  | 2 --
 include/configs/imx93_var_som.h              | 3 ---
 include/configs/imx94_evk.h                  | 3 ---
 include/configs/imx95_evk.h                  | 2 --
 include/configs/kontron-osm-s-mx93.h         | 2 --
 include/configs/mx7ulp_com.h                 | 3 ---
 include/configs/mx7ulp_evk.h                 | 3 ---
 include/configs/phycore_imx91_93.h           | 3 ---
 include/configs/toradex-smarc-imx95.h        | 2 --
 16 files changed, 46 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
index a038cc1df33..f9c5e21c14f 100644
--- a/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx8ulp/imx-regs.h
@@ -20,8 +20,6 @@
 
 #define SIM1_BASE_ADDR		0x29290000
 
-#define WDG3_RBASE		0x292a0000UL
-
 #define SIM_SEC_BASE_ADDR	0x2802B000
 
 #define CGC1_SOSCDIV_ADDR	0x292C0108
diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 2d084e5227a..fbf2e6a2b01 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,15 +17,6 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
-#ifdef CONFIG_IMX94
-#define WDG3_BASE_ADDR      0x49220000UL
-#define WDG4_BASE_ADDR      0x49230000UL
-#else
-#define WDG3_BASE_ADDR      0x42490000UL
-#define WDG4_BASE_ADDR      0x424a0000UL
-#endif
-#define WDG5_BASE_ADDR      0x424b0000UL
-
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL
 #define GPIO4_BASE_ADDR	    0x43840000UL
diff --git a/include/configs/imx8ulp_evk.h b/include/configs/imx8ulp_evk.h
index edfd6f70815..b4f80fb944b 100644
--- a/include/configs/imx8ulp_evk.h
+++ b/include/configs/imx8ulp_evk.h
@@ -30,6 +30,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_RBASE
 #endif
diff --git a/include/configs/imx91_evk.h b/include/configs/imx91_evk.h
index 9c5014fd0a5..13918e2b873 100644
--- a/include/configs/imx91_evk.h
+++ b/include/configs/imx91_evk.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx91_frdm.h b/include/configs/imx91_frdm.h
index 6d051ed88a5..480b3fb477a 100644
--- a/include/configs/imx91_frdm.h
+++ b/include/configs/imx91_frdm.h
@@ -20,6 +20,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		SZ_2G /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index ffd72a38bcb..67774f54790 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -26,7 +26,4 @@
 #define PHYS_SDRAM                      0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_frdm.h b/include/configs/imx93_frdm.h
index c98c10774cb..bcea360b399 100644
--- a/include/configs/imx93_frdm.h
+++ b/include/configs/imx93_frdm.h
@@ -20,7 +20,4 @@
 #define PHYS_SDRAM			0x80000000
 #define PHYS_SDRAM_SIZE			0x80000000 /* 2GB DDR */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_qsb.h b/include/configs/imx93_qsb.h
index a7b94f7ab57..350f094c2a6 100644
--- a/include/configs/imx93_qsb.h
+++ b/include/configs/imx93_qsb.h
@@ -16,6 +16,4 @@
 #define PHYS_SDRAM		0x80000000
 #define PHYS_SDRAM_SIZE		0x80000000 /* 2GB DDR */
 
-#define WDOG_BASE_ADDR		WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx93_var_som.h b/include/configs/imx93_var_som.h
index 9dc10aea407..6a425e6d1ea 100644
--- a/include/configs/imx93_var_som.h
+++ b/include/configs/imx93_var_som.h
@@ -38,7 +38,4 @@
 
 #define CFG_SYS_FSL_USDHC_NUM 2
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx94_evk.h b/include/configs/imx94_evk.h
index f93c3c4e4a8..2623c13db06 100644
--- a/include/configs/imx94_evk.h
+++ b/include/configs/imx94_evk.h
@@ -18,7 +18,4 @@
 #define PHYS_SDRAM_SIZE			     0x70000000UL /* 2GB  - 256MB DDR */
 #define PHYS_SDRAM_2_SIZE	             0x180000000 /* 8GB */
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
index 3d22740b3f4..1fdc9ce21ef 100644
--- a/include/configs/imx95_evk.h
+++ b/include/configs/imx95_evk.h
@@ -23,6 +23,4 @@
 #define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB (Totally 16GB) */
 #endif
 
-#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
-
 #endif
diff --git a/include/configs/kontron-osm-s-mx93.h b/include/configs/kontron-osm-s-mx93.h
index ab2b42298c8..fed75e6fa12 100644
--- a/include/configs/kontron-osm-s-mx93.h
+++ b/include/configs/kontron-osm-s-mx93.h
@@ -25,6 +25,4 @@
 #define CFG_MXC_USB_FLAGS		0
 #endif
 
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __KONTRON_MX93_CONFIG_H */
diff --git a/include/configs/mx7ulp_com.h b/include/configs/mx7ulp_com.h
index d27e9d2eaa1..501c3059cc3 100644
--- a/include/configs/mx7ulp_com.h
+++ b/include/configs/mx7ulp_com.h
@@ -15,9 +15,6 @@
 #include "imx7ulp_spl.h"
 #endif
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1MHz from TSTMR */
 
 /* UART */
diff --git a/include/configs/mx7ulp_evk.h b/include/configs/mx7ulp_evk.h
index ace1eee70cf..21dbec837f0 100644
--- a/include/configs/mx7ulp_evk.h
+++ b/include/configs/mx7ulp_evk.h
@@ -11,9 +11,6 @@
 #include <linux/sizes.h>
 #include <asm/arch/imx-regs.h>
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR			WDG1_RBASE
-
 #define CFG_SYS_HZ_CLOCK		1000000 /* Fixed at 1Mhz from TSTMR */
 
 /* UART */
diff --git a/include/configs/phycore_imx91_93.h b/include/configs/phycore_imx91_93.h
index 02fa1d9b274..d1bf086546f 100644
--- a/include/configs/phycore_imx91_93.h
+++ b/include/configs/phycore_imx91_93.h
@@ -22,7 +22,4 @@
 #define PHYS_SDRAM                   0x80000000
 #define PHYS_SDRAM_SIZE              0x80000000
 
-/* Using ULP WDOG for reset */
-#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
-
 #endif /* __PHYCORE_IMX91_93_H */
diff --git a/include/configs/toradex-smarc-imx95.h b/include/configs/toradex-smarc-imx95.h
index e1aebd70af2..8a880b96503 100644
--- a/include/configs/toradex-smarc-imx95.h
+++ b/include/configs/toradex-smarc-imx95.h
@@ -19,6 +19,4 @@
 #define PHYS_SDRAM_SIZE		(SZ_2G - SZ_256M)
 #define PHYS_SDRAM_2_SIZE	SZ_6G
 
-#define WDOG_BASE_ADDR	WDG3_BASE_ADDR
-
 #endif

-- 
2.34.1

