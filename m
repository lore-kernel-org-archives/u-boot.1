Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD0DFD2D79
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 384F1840AE;
	Tue, 10 Mar 2026 14:12:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MVrKsXaK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5D683F9B; Tue, 10 Mar 2026 10:14:59 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3879A83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvzrdBFc8dxYcCpcNilNTTDaK55qXV/hWEpiX4Cj0YNwDQDsEgO/PYd/QYG73+ztUJj1legVPUCen5S8HfDS2DohyY8XvGtpQL06T/wGOfqjpKgOZuGuA/q8Hp3E90D7YqdPqJ4H/GsuZODjvT95v9aeAZGuVk/DOJcIGnsak1JILfcoG4S7lXW4y++aQKAOCX/ApW25a4tKJ12YOGG0Bsbq8thZj0NQ5/0f26PV/6mAyeQHqwPEbwpvL/XFnHw3hSVbpNIAiGddmR87NFMVTH0Th2fQAvdvmfaKvKG9hNNjJbDOh8YGtGaDTS1MbsOnP185p61B10di/qZyFMJ9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZRMdz3KyqiZJ47hlbDnbnZkedSRcZJ/bnoXRmCr1tk=;
 b=QKnn5u9DVAldDs7g6lpRdnKAXWn+PKwjTZsFqggn5PX1JqPNahTD+Ih+4ZK5G/qQwgttxN2veej/GnEBDI0lY5GdiYPYgZHC+fgpzdRcNedTkb5YRmljgmoKaAk4YmpJKEaJ9nZOC55C5T7+6z2Ws+pGPHEqEZShT7NfrXYJaiQgFR5YCCAPm8RsWf0Ch7n1pDZpFhgaMGV1skTWv9ncynOXoeND70HYF7glw5DclAWeXfoDukOZeuZFbdXN/1ZokNwz8Nt+7qdJcDPbGsP1qWGLbCMZf3Y/S3wGw9BoNJBtFcjrFhYaFdFdBOfh+qz0vgsHjfaY5YlTvw/3n4GyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZRMdz3KyqiZJ47hlbDnbnZkedSRcZJ/bnoXRmCr1tk=;
 b=MVrKsXaK3hI/ihNEf9HGWjKbWffVc3Zb0KWpHydGzpqS2WbRaCwPVfVrTY11Iwa7G/PAxNSvG8SUGVKM9HI4a1Vup/PoRufp+oM9Zj/b2bHxD38GBJNDqHRpIh0fikNN4pn6SwGnTrm3wEwQNp7qDLTY4AEaQ70aMzghqyGIuAQK5tVuIv7vbc33OPnaESAgXz6oGudTb62mZry5y2QiHis+LdO3sOAgOtDveEDsbOBm7QWGI2yUBvJk1inkd2gqskJZj7hW6+pDREkbbRcQx2yJGYWXhf7JPeHJOOFnyxJjlXw/SzNwxMnDPMDbm3Msm5q02fVimXd2tiWWZZRE5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:53 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:42 +0800
Subject: [PATCH v1 08/10] imx943: dtsi: Add wdog3 and wdog4 nodes with aliases
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-8-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8ae3b1-e12a-42e7-a9e9-08de7e857d13
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: qpv4mepfqti6yNcyAlU2CEZrPbTcbL9urWEPX+z9WR8qwWpspO1/4UMVCbpdm7asKQXelDsDwYXyXmIkLy3+mPGy7f0HUNTOTcXvwtsiYvMDXEgpVzV//cXu9jtRkft4mrzJiBnmTWzijaT/LajeCYqkb0zhjLUA45Q+hGICsc734P4L27A3/0iiuwJjpclNTrTtMqaa/3Akhshe9Rq7bOqgVoZMDTbHbbc5edVn9ctLq401I4IQXtgBmBOIFfm0+lWsSUfJSAcsYejgIfpJJi93o9cJ7yVv6RTK9BSilnrU2AGY/yR53szE68Oq+QGat975u3rfRR2P6eC7EjdzWnv7/A0YRswvne01quMVlm/irMXvBFw4fuMIvI7c+bbDhFjbT7KAckxJRQjRBh5eMxO/UupyOrI/7sm/x0fIKkJooHGaPhhBQfEIJ6JdBeXnX1J7jiRUWCyAgxCk9ataDaPFM4IlpAznPs5h1YZWQQKLt324w6L7657yVtdDCGDnBB/MBbphU9D+GgB0QSqaNulATk88s3YoWqzkt2DEOd0p93Rnj1S9IRHgFaOExZsXpSvpWGniiiDSTBCOJ3Rcy3SwGOMK44l/kC08VNVgrAExE0xIxkrOU7jL6Sz5Nm/N4Xqht2CN48ZvQQaenzT7cLIx6ngfzN8ShB2KaqfPRiSUHRad9dsx/wqUxrTVCr9Hm6Q/VlTKCEkJe3rW9zFDP2XypC2JYM/rbg1uNjmkq0CuyGIA8LsieIwdYuWK2JmeUpfg9rcc2uDgw2fOFs/dw393d+MG1raADCJlaK9Kx40=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFyZnZCeGkvQ3hSeVN6SXNERWVXVGNINUtkUWVGRktmOTNjOUlBdSszVWRt?=
 =?utf-8?B?NjdocHAvbm1nUDNGeFhXOVc2QTlUMExINUd6QkdzcWNjT3RKNmFtZG5MSWF3?=
 =?utf-8?B?N0FhY0Vna3ZiZUs3a2tPamdNaFlEVDVTQ2Q5WnVrVHFCUlZwK0EvTkVGb3My?=
 =?utf-8?B?cVlpSVJTbDVlV1RxTVhOcjdKdy9CanQ2VUw4MWNuLzA1b21OTzIyeldoWXk0?=
 =?utf-8?B?MlA0OEg2YXJtcDZkamlNMFBjZVRWL0FTSyt4ZFlTdG5qTHVzWnlKOGZaV21T?=
 =?utf-8?B?MG9PMytrWHU3RDJpUzRrVWliY2NKQ2QvUGN1MlpNNnVlZzdDRmszcXlycVJh?=
 =?utf-8?B?aWNNYjNDTmVPdFVTVmhlSjRreCtDUkZFRWYwd2hjLy9Yb1llU2JxdDVDMXRX?=
 =?utf-8?B?TEpBZ3JOU2Y0SFYwRHpna2ZXL0RESTFXSVhSUUxTaGVDcU5GS0hQOGhOUFZM?=
 =?utf-8?B?YTlUSnNJY2lhVlFxUy9oUFlaeVkwSnlTbU5tY1R4U2FwS3pFK2dyc1ZJZU1N?=
 =?utf-8?B?SXkrQnEvOTFkbjNwblRKRGZCR1lwRU0wRDRVZ0dXU0FaRUFpWHlKQkxMOEhO?=
 =?utf-8?B?R2RPUGZBNUhQbzJmT0Z4U3Jvb0cxRU1UUHVlb0tsY0doWVk0dlZ3OEV3Z0tN?=
 =?utf-8?B?SVNEQ1ZKTWtobXlmc2ppaGthYmNUUjRkK1pHTHI0bzluNStBdGlDeG5nQWpT?=
 =?utf-8?B?WndMaEtyT1Jvd0FySkZDNW9mMHVZVGVZK29uMnR4QWlPQVlpOVZLaStrVmJz?=
 =?utf-8?B?eXRhTFVLN2FNbjVnZ0tkRXAvQnNhdnBaZm5KcENPdkE1VFB4TE9zYlZTT29l?=
 =?utf-8?B?ZDdjTGVKN29TeU1sOU1sbitJL1laTFpxT3FVVStUb085ZGVyRlFzVWxaS2d3?=
 =?utf-8?B?OGI2NjNRQWFrSXZ0NkpPWGl0MDFKNmdCOFJvUHF0cUgyZjBOU2R6eVEyM1Az?=
 =?utf-8?B?ZWZUZitMNFhKaURKYi9QM05lMVgrK2gvVlc4dnNQM3o3VURRUGRDWXhkekdJ?=
 =?utf-8?B?Zks2dk4yd1dSYzNOWEhRQ3hNOGZrR3ZjME1rSCtHQ0NPS2lWSkh4b0hnVDlX?=
 =?utf-8?B?czV3bFhnV1RQTVNramV1Z0pTQ3I3b1E0dU92ZU0xMEF5eSszWHBkU1lpOWQ1?=
 =?utf-8?B?KzVwVnJJaGt5c1JyY0lmTC9QNm15eG83Y3hVRnRmUi8wNGQ2MU40VWtmdCtk?=
 =?utf-8?B?Q3dEdndTUFFPQ2Q0RFRvNmlxK1pNbWFGNitzeW5QcDdpSkhIbDl0a1lNSXZX?=
 =?utf-8?B?dzNiQlBBODBwY2gwOExlTlJjcFVzVC9acEdTRnp2eG5hVlBTeXhaRURieVU0?=
 =?utf-8?B?UFVjZzliSkladFhlSUxPTDJodVp6eGtVZjFjUXNTRnZ3VU1HK3pKTmFZTzJz?=
 =?utf-8?B?MHE4bWJIbWxjSFZmWE5PcFZ1MHUvMXQ4VHlTZFVpQ3BsUDRRUkhKeitvVDZX?=
 =?utf-8?B?ekY1cUVqRWsrb1QyUzNOakp1eXJjbHhpT2s5NW50VjFNVjVMMk1RdjN1dzdq?=
 =?utf-8?B?cVFibCtMVXR5ODhUQUVUSTdwSFI4c3IrL09oQlZTeENmUlcwSmc2RFpuZG9j?=
 =?utf-8?B?ZnBDTE5wd2cva2ZJVUNOR0U0YW5lOUNLRWdwc25ScVZvL2dGVFBKaEVzN0Nw?=
 =?utf-8?B?SlNLVHU5cGlsQkZJckhSK3lIYUNLSXBNOFdtSU94Y2J3NFRiRGxzZkV2L0xo?=
 =?utf-8?B?VGJ1ZFQ1ckVxeVd6eS9YZzk4bXdXOS9mbDY0NXhkWTVzTlZHVDA5akZrZ0RK?=
 =?utf-8?B?WVc0QWwzaXZZbVd4RUZyU3VJaytuSy9lL3JHOGxjTWtVZkdrQU5HekxPcmQv?=
 =?utf-8?B?UXpZNDFlbDNjengwY1FKYmpnQ2NTNThVbEk4TEpuNmp3bkhTVlpHdHkxS3Zv?=
 =?utf-8?B?UFBUdUlBSU5semJ2TXZ2SEk0Y0ZiZkN5WlVKUlYzc2ozMnh6d2NnaDR6bHl0?=
 =?utf-8?B?ZlUyK0Mrc2FkbHhya2VsYmFFbUt6NHpJVEx6Y3lSM2ozaVMyQjlMSUVKWVVO?=
 =?utf-8?B?a2l4Sk5kOS8zOUlMRFBjbTVab2lMelFLcG1tZVZpZVc0cEdVUFdIMlpweXhF?=
 =?utf-8?B?NEdkYWpxVzAydDg3RDFOeThnVTIvUGhKM3ZNNndOaVlxUVdJaUZPTFE0am1S?=
 =?utf-8?B?SEFQYisxTmN4SjcwT0g2QTdsays1RTJKL01NcHhGeDhTQUwyNG9VRGdLd0hL?=
 =?utf-8?B?OG1zTy9PZU1iRjhtWkZtQldSQkx4ZUtTcTBJVmxwNE5SOHIzTy9Cd2NFU0tG?=
 =?utf-8?B?U0lHU0k1UVQ0VXRORUE5bmhsbE5HTVlFRmRuWG5UNS9PK1pPSlFsNzkwZzJh?=
 =?utf-8?B?czNHYTdTT2NzdmVudURDTitCd05sSlREYUxYbXBwcHJ2V2lRNEI2Zz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8ae3b1-e12a-42e7-a9e9-08de7e857d13
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:53.0173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SAtM7cVMRYvGWvWPxTOSq1ukQiJTYLOBRouUl9dETNmIYsVzZTwpW3MvNQQTT6aV34QG3vdt0r8+kRqHNgvCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

Add wdog3 and wdog4 watchdog device tree nodes and their aliases to
support dynamic watchdog address lookup.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx943-u-boot.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
index 2b93ba9a38b..0619bcd5475 100644
--- a/arch/arm/dts/imx943-u-boot.dtsi
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -4,6 +4,11 @@
  */
 
 / {
+	aliases {
+		wdog3 = &wdog3;
+		wdog4 = &wdog4;
+	};
+
 	binman {
 		multiple-images;
 
@@ -143,6 +148,18 @@
 	bootph-all;
 };
 
+&aips4 {
+	bootph-all;
+
+	wdog4: watchdog@49230000 {
+		bootph-all;
+
+		compatible = "fsl,imx94-wdt", "fsl,imx93-wdt";
+		reg = <0x49230000 0x10000>;
+		status = "disabled";
+	};
+};
+
 &clk_ext1 {
 	bootph-all;
 };
@@ -444,3 +461,7 @@
 &sram0 {
 	bootph-all;
 };
+
+&wdog3 {
+	bootph-all;
+};

-- 
2.43.0

