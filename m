Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A3CCCD195
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D485E838BF;
	Wed, 22 Oct 2025 09:21:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EASR6L14";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CA28334F; Wed, 22 Oct 2025 09:02:57 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F87D82E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxlPAKqwcnHZvz9q4Tk6exPU+Zlr+WESexA65Jk4MiNA1hFM8OTRkvsOenapEl0c/sst7miqCu0Tow97M0zI9YCxQy5Gpu6DLN2dSUPTyeTWArI0kfAihlcj7AHaSvmxGA8M+fBb+AXBaK6pcl34xi2Bltsnxy7BnGyCT7dv9fqxyH4vZC4OBYmDNIWyR0BNauleIDUofE4T0dgiiFGLd907+Vbea+3Lvzs//ai0IZyFElCG+wOI4Q1mNlbTHhVlowxE+/FREZ3AnRgFcdf8jQMKzUvLTvdU0B8tYMkl6uX7Bt6Fs+YsZAriBgyF8EyH6pBvg+yJpg6sNuXCymARMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zg/kmo0YhQpOTEBBIPY5cOn3zTOclCSuslKpyENejRg=;
 b=drJOaHefj1jk9UA4oaWfM3trHHWxMKqch0+I2PLIJbi+Bse4IAduTJ10JWk38M1dEtmBAkByDjglRTmwyuR7IadQvNULUVyiUVGqgVKkvTfusanFTHTVCUZb1IP+0Yhy94LUW91s676nq275WYToGZaz3DgqXlnVJ6BlbYOOl7i6g5oPlPz/N8gKBUBVDyXUiWfliQ0BtspyezPVX6r15NzbLdtBfySFEuwZ1iBvLiAcmHPASLPBkOF5+566QLNfY4RF77TUnOhYhdmk+QKHoEEIK+ETheo7ryIDSq0ajhfiTIkskU+MKyOv5Mr48TkxxMVMmgZrrTVaLJxgHaT+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zg/kmo0YhQpOTEBBIPY5cOn3zTOclCSuslKpyENejRg=;
 b=EASR6L14UAvkDvS0iUR9rQP/VT7My7NBaMSD5/+18aYO2IUJ1ML9uMdNnIq8QKb4OvVa8zvlzvoU8louVQ1RfvCcT5Wv/rROtTBskmObL36AbyOX867LQS+GLGNUbNrUjIE7zC6jQ1K2DhJEmqwjN3v5qR0auWLMf5AuB72nB1SSgFHjuV10U+RfLxLSKinhT+zj7vh3tqf/RdUZX1U3Sttj8RC0eR5vf3FuTI5Hg7HeLgW0rh41aN0P3zhZ2YR2G6z9DDO+e1KqJ4ln+g3VyYA98jcOg2ZubR1/SvxCqm3bh4jZMVc3aeiSuvNrThYydhq2Qg8IFt7gzTdaIRuTOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6935.eurprd04.prod.outlook.com (2603:10a6:20b:10e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:02:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:02:52 +0000
Date: Wed, 22 Oct 2025 16:15:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Jean-Jacques Hiblot <jjhiblot@ti.com>,
 Ronald Wahl <ronald.wahl@legrand.com>, Anand Moon <linux.amoon@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 5/9] mmc: dw_mmc: return error for invalid voltage setting
Message-ID: <20251022081504.GD30163@nxa18884-linux.ap.freescale.net>
References: <20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org>
 <20251017-mmc-dw-exynos7870-v1-5-a2c5139d9afe@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-mmc-dw-exynos7870-v1-5-a2c5139d9afe@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: 98743c07-5173-4aae-ff25-08de1139049b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|7416014|52116014|376014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?prL+V6HzEaqL4FskrOjRBgzOHOdCP3/iwOrwGmMg+MZIWv9jJzFWGbTm5wUV?=
 =?us-ascii?Q?yQDoPrUHysgIz8dJo2BQxM8YjSwzRl4Q49IGV57Al1xHH8/9wuw9/jxzZlXf?=
 =?us-ascii?Q?LHrawfJBUXeev7PX82Ra2m8h2SjQkzqz9f8I8G73/pk+lE1h1u3y97U0ww5n?=
 =?us-ascii?Q?l6Pvsxz5j4DMlCRy0hrZaKnse62TyEXAONlu9wI71qb5CIL18p1rRxNuMnwT?=
 =?us-ascii?Q?ghd+p8MHN9eMPRIwGXrCxdV0Qms/OZ/sRaZ15o1fudcWiKecA6/tWeMCZ5BQ?=
 =?us-ascii?Q?MAA8k0vhu8k1BEuH13xc2DOKUsSuqgaooKurO4+FHUlWL0i2tHB0i1Gpbwkc?=
 =?us-ascii?Q?RFtanGXOYxErGhulVGgd6JZo5aylzIXt1PeEwz50SEska86qGWfe4Xg/CkQB?=
 =?us-ascii?Q?K1386srCUNEjJYuIuXXaBn5QIJy8oHKf7a6XOou0e4hl2EbYZEgRych8VsJ2?=
 =?us-ascii?Q?8jwnvYYddDUrmu9TYiLM/vrNkJSe4UbHhmHVFpWMhfe91IT6l16Cz7f0dWCe?=
 =?us-ascii?Q?Ej+kUMBCefOdFGc4SZCrA/NHMo5nQSRiTLuvc2Y96vSNjFKfuomA/s8SXnEK?=
 =?us-ascii?Q?xFhS7NKsksmXbXJxDjfRUhVw28vSYnLHNekR32C07XJmES5lBqlHg1hyk6iR?=
 =?us-ascii?Q?+AMOkmWmbhN08bgSQG3OudJvlHxQpoKqjZl+uczOlDViCzCmLI2kgbIi+FGn?=
 =?us-ascii?Q?9BGCm7HSnmbfLXSOLejK0lmhJpF3pSO4Phr0shJnUbHhzDsbtS9MVF0DDRpD?=
 =?us-ascii?Q?jaqzETVJV/+i7Eq309Tu2IOkLZ6ZNPMD9oxFhBvN9U2IfMwUkCB/2kdsW+ln?=
 =?us-ascii?Q?ykbdthWcjkSpSK5ZTyG/dtwn3H2MZUB2m9Cf8vlrgjJj2tYHagSds8AWAvHE?=
 =?us-ascii?Q?Xn8MvjPEvO6i23sZAuG3Ax3POGiGx/org1UftQGtbl9Q7QT7iu9E2qgHKtvs?=
 =?us-ascii?Q?twAfHmt62hGMokC49OWPC2+6LbMR4b6cqZTkFHoHW7GKSCuUXSo0JQ4//m3R?=
 =?us-ascii?Q?MydWhCmyHSt+dtUySXiuzs5jGhHhwL3saGP9mIEC/W90n4ljxDDtVyewGW6g?=
 =?us-ascii?Q?9R7ukheSoMNUNcVIzy9GKXyhwBXTIEbhuhre1TUbkfqCOA3eDsEd68B+sUtp?=
 =?us-ascii?Q?68xmHL8ww9kDQoQjOtfGxBW4ru3uQVbRSzX98QFPifmhhJYaK9bI090FDPmU?=
 =?us-ascii?Q?Js6yAKV4udu6eEtYPTRHUjLZsKTaxRv8/6Z3ZZkvaq0Px0hubp/7kriF3o8a?=
 =?us-ascii?Q?SGdjH3qPpOryQQDJqxsl+EaU+4a4WNMuGz60cEMgXwOhBi3+r1sAGTj+RwMc?=
 =?us-ascii?Q?VnImbD9XdNoEMHcSUCSFjtsoB2M6taUf9DAg8P8sOfv5ID0BQ74GTEsb8bBf?=
 =?us-ascii?Q?MFHZGrre7NO0JCbFJpoX9yZ5SBq5v6NK8wZuuwjz4ET6lpTzQnm4c/R/egmu?=
 =?us-ascii?Q?lUpO3XFy4q/19ArhdWIE588Mj1Pb0fnQNkg6NUPeUmEQMfHtA5h6Bnk9nqlS?=
 =?us-ascii?Q?U+vLQSYHJdSfykRu6zsmyymghgECnMv1NZpj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kuztsD0OnDIPUUD01Wj+qN2H3ZYu+n28iWJfdjmHUCdm3xvBm6v2BZRA4PMp?=
 =?us-ascii?Q?EM6L33MtNdBLq+SatQlccKBCXRDDrdbQeOxSSCdMhqPIMhq5DISRqDfrS4Sv?=
 =?us-ascii?Q?qzFPbfCdKyRlvbYq35l8YFfbuxb6EVgyCnoZ1i4n+1xgCEOqBPMSOaW/aFs2?=
 =?us-ascii?Q?qBe2/8IK/m8k+Y1iOPdi4OlTlfkKFoErn9yu7nSK8zS2KGD2++5hIRdk2hXB?=
 =?us-ascii?Q?LqtPIoLIV8pWWdoQ8Rz/wuA2b8P6zS4bTxt+vOD/ZYaaJo9S74vqHhWdNowa?=
 =?us-ascii?Q?ErkwN987MZRjj2jt1Ae3JkSo3dnIEmYQ02JVLuZ6TPqJAEsEz1qR99sTv2xQ?=
 =?us-ascii?Q?JUpR+1EUQXuOSZO+Ne+ZX1+SXJsTIqhhzWHMPr/MQkGhMCNVSm6w7X2XfOXW?=
 =?us-ascii?Q?Qa2PUJ1lwog2FBnGuN/LBLK5Hf/KR2Almu48vQ6GAEd2zXaHesQxygpnmr1M?=
 =?us-ascii?Q?FOs4aWNESP30VCaLGMuKZ+vfKdAhbrUppCmGpEhwMpWpUzKJAAw5j6SXF6ik?=
 =?us-ascii?Q?eO+RD5ee42Wer9J8xVHlg7IroRk2Xd2NLrGEcH0kb/zfjNunNXQiS9bPLwrJ?=
 =?us-ascii?Q?ejYhFj6+FQyrn3yZNxpymcitTwVLwQPFMUlM5eLf1FDcA96NSYEack82GLy/?=
 =?us-ascii?Q?rZXkCIvufRQYGFgyuhrwpOLqcZradiEj0zqqJCPNINxT4TTImqpCLakEjANv?=
 =?us-ascii?Q?7Yimx6GF99W9YSHBBvxCXA2GKehRanwCLyIPAU+PJmp+TT92tgPTpn8zMAsV?=
 =?us-ascii?Q?3nM7bjrofK4FQA96Wcw+STQtUY7X+BHXJwdZPizNNBG06DcPFFrmHvCs4so5?=
 =?us-ascii?Q?JC2hVjVkXgMsyYQYF6E7YSbKrYA/+2v4Ki99KOmTSzjZECXP4cNsbsuxDVCj?=
 =?us-ascii?Q?MrxaVqjh8imD8ZLiwW6VGAgfCnCLZbngnBq1MkaLTfdhRMaCN2VKk9Pt4NUu?=
 =?us-ascii?Q?YEhjuszumGXSqjK042EpBdheOrIOrYan+DV5Wem5pPNXkzwEMEk7n2Sn9VF8?=
 =?us-ascii?Q?+UwY2pOHRu9EI0/CL0R+lKFKXK0P4jPU6bsnNvjlc63J/k4i9w34BwywnXfH?=
 =?us-ascii?Q?lezGaiCH+eqQ0DVEXR/ijn0NU9nnqMjt8EwUquQ7WjR5ArgexAsi/SwSGptE?=
 =?us-ascii?Q?jAqcw0IkdBRLVDU2LUYX4jDJRqDgNvsSC3A0hlDoYeemGu1Kox6w3Xecq6IX?=
 =?us-ascii?Q?LMW/83TCQvctwc39TP4bAeVOAL33Re9q6G2ieU5P9CGFg8F+r/S74RkMk/vL?=
 =?us-ascii?Q?O6r2xh5SUceam0J5dhCk0f5rwTp1rspqyz4byjWfxKPhbu0Uec4Zfyf5V6jL?=
 =?us-ascii?Q?H8fPtWqm060HmUV8GwRM4Ur2nPLF53RPF5LglPeaiGapa+eTY949VODay6zK?=
 =?us-ascii?Q?pr59eZeYyafi2rRpEHdXKkEtgU2yANB3bRGI8TWjL17zvLr/Ge/FZs1pKtnX?=
 =?us-ascii?Q?YAkKZHxB8R99SHQ3aMg/aVbwP12rTGkszr/l+frZbov0MxBDeO+MWKiwL5WD?=
 =?us-ascii?Q?QlJ5mOk91bVrcZs9ils5A0UvHo6I6KzV3EglsbxFJqGlFtq2LRDCHhjgyMPj?=
 =?us-ascii?Q?i3BgfhdNJcSfF0VQ3ee0NT4DmIY4mTX2PA1rmMZ1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98743c07-5173-4aae-ff25-08de1139049b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:02:52.3170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2K3ie0faK9GO7scujqVave3TkX9KHx5t9bZXVb0kTK9EiCGAPLenv6JamMYCGc7StN6C0l7y0SCwJG0RLeHGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6935
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:54:10PM +0530, Kaustabh Chakraborty wrote:
>In certain cases, the VQMMC regulator may not support certain voltages.
>For instance, a VQMMC regulator which supports only up to 2.7V will not
>accept 3.3V as an argument. This is unaccounted for, and thus the driver
>incorrectly assumes that the voltage is set successfully.
>
>Fetch the return value in a variable and return if it's non-zero.
>(-ENOSYS is exempted as it implies that the voltage adjustment
>functionality as a whole isn't supported).
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
