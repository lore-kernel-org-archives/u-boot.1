Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C078CAC5A5
	for <u-boot@archiver.kernel.org>; Wed, 24 Sep 2025 02:12:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31F0883447;
	Wed, 24 Sep 2025 04:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="jp0yKRcd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA57580107; Wed, 24 Sep 2025 04:11:55 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D744D80B9B
 for <u-boot@lists.denx.de>; Wed, 24 Sep 2025 04:11:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HyMlYoT8pGVfJ1on1o5kCptFg0ekL/ThK6rgSwHSnZvwYRy7oIuiAmdZ9dBV2nngXv72dN5AObEtsNj43fhBNiMq2/RjIqCfuLVtTNvGQR/Icoo26YUQPnFpNGWRKjX5b8KmK04p1lkynfFTWHP9qQQ/iOqpEQMRHD2lb9syao2ETieKvzLsTOq2ZtrDekac2qhpBfEpRGnLMI60ejr3aFcwsHV6ZJu+FdW8nICvaxpNtCFmGinjYdG+ddtG1FIlt+Rh7IDz7ouLYT48kVlPa+TSCvtAa6XPU48rfxrHARaQBcc3xVYKCDFhuuCd0q++RblY+8UMFWCtQ4eS1jChZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou2PeIQT27ZbBTsezb4qL/8ftK/VIqb+AlFArSO6gm0=;
 b=xYJaP+1Eec+Fgo7QXK/h4OqaknKf2NXB5FL8D4o/CHR4D1Ochxh5or4OZPcFJyWoMxoh1brO/H0yNP9uDCdeJBZ6RmIGLgyVo3fqn9nEAQzmgX0VlSgy3d20qhAn22/FsqShn2tTW7wgAz5MRmNOGkfWTM1bzadZffO5/pG22GRhkpQASFeNCZWs5VuV26BVEb3iGVcVUWGBIwUI3mZbeQ/cBG6J+9MjYvAXPBwUaxG5Y9idbTXve7erRLSHb/UMPNdbYe6Q0cc3rgM6w8glvz8NZGFJbS3LCYDcMh1HWAIdLO74Up+/w2wM5b0jPv0BmvmkLU/1pNV7b4f5tP4X9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou2PeIQT27ZbBTsezb4qL/8ftK/VIqb+AlFArSO6gm0=;
 b=jp0yKRcdLuBWfRZ5hD1MQ9robbQ0UvHUeUk8V7sKdALda15sBY4yo6jHfeZLh934vRFRWZ9joy2b0R1zAL9CAUoomoFSC61wjslwW65cGUvPC280bXUoDqJ615QSKYWC08QPQrFhw1g1zUhxgvLTOKs3zWg8pQztumcds9lrR8Y+0TJ5dZoHsiXX+1MO3uake8HSI6H46BybXwNM3Inna+7ZzgavGrZSjeerC4jTOOCLS7oDMP3slFtpM/Fz9lwYraFBO6Rec8Lah0PNeLg7vb698y1cupgnjC9VZc5v7wYl6EDeKE6utjNVV+W4keEPqJ/6hyEWQcVCIBWqysnb8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 02:11:52 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:11:52 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	jagan@amarulasolutions.com,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH v2 2/4] spi: nxp_fspi: Support i.MX8QXP flexspi
Date: Wed, 24 Sep 2025 10:11:25 +0800
Message-Id: <20250924021127.2866184-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250924021127.2866184-1-ye.li@nxp.com>
References: <20250924021127.2866184-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::26)
 To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 89935c8c-3419-4bc2-62cb-08ddfb0fba41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WJp6AGpXMXD3+aHxUkyj2HhAX6bZYXcSXfVGB2E2JOKHIJkoaMhEJkQguxZs?=
 =?us-ascii?Q?WIIuQt+P6reEjgZg6mULJwEvqPakBQAADUIRINongJdxAXNLt0fxZ+sZ7KAC?=
 =?us-ascii?Q?kJyx7JboOgecxXO1hi36GVukOY0mnn6B3yJk/cj6vZRnjcb7mcnl2ey15FbK?=
 =?us-ascii?Q?A08d5JBFKiq/ZfK4OfxvTl7iuk2TjOtgB/38M2rK3TnxK9G3jFlxceyxIlB+?=
 =?us-ascii?Q?c5hYsYarmHuFQh7aMDOGFExxAhz5c7Qy4Vc+eJpCD6vFWpZdDlrd1ta3dnby?=
 =?us-ascii?Q?Pn0nj8/gETSnmB5EvA8wernvP1xpJqSByE3cHLSDPfYrj700hitgE6R7Adk8?=
 =?us-ascii?Q?irmxLduUvNEynnGvEnrdQ0zyh1NWWrifv3PBXtXokP/WaHmpvL574Q5uTPWq?=
 =?us-ascii?Q?9rrqOkmGfTPSCaoEXUp9chCGw5qw2Zffggd7OJV+CWzY9YH9EmgU9YEfaogC?=
 =?us-ascii?Q?yh9jOGL4wmXd3q+3qYplpzOMXzPifwm3gYuRpU/VtQ5weS45T/eKpC2tci+q?=
 =?us-ascii?Q?vZHxVuKtapxDihuWVQ6aXHwXzU+7+pieUTYe3cxV7NAdiLVwtLdCX43dBEI1?=
 =?us-ascii?Q?voydLj1pTpRs19gz1MYnCnukVlLw0fSna65ShGrO45wGwChO/kz7+br+b0lv?=
 =?us-ascii?Q?CR6nYohnBxSMULgeUSsbRA5lbuUyctjOk9E1fxbyd556Zwe0KJo5xBfEKAqQ?=
 =?us-ascii?Q?NQhvI1gk1yiitXvN+eXWU/aygFPd1NUQHd3lY21BzJxXuE7FB+6HOveA+B3p?=
 =?us-ascii?Q?AC+JJqmrErPsW+GWKwn6MdoyP1grMig41hgNEDaryn9IB3bmf042+STxJCtY?=
 =?us-ascii?Q?5gBWV5r9JY2TSa0CIUHGHYCPFAM3N7gKco836Io5CopaVPnwf5nQmyTKY3q6?=
 =?us-ascii?Q?ssKHm2TdcEjbH0PmQXCa0A4ccUT784tqRLL3eHSq/WN2V/GTgmwfbZ+wQXqT?=
 =?us-ascii?Q?WrbpSUYNV8Je5VhW4YeHRw6sXLo75xlx7AU1EPNIUkPPhZtZncOMN/bVyE63?=
 =?us-ascii?Q?YCmDyt+YTaoAYJ+mONwKt1J/ASj0bH/L0JPeNjXMoqKtqe5PSRXhvNAkhMPv?=
 =?us-ascii?Q?elDQ7neeCgSEcFVloKFFZUEmeRxp3fD3+2qIAGsoR60STsVTa6/7BtQvTpbL?=
 =?us-ascii?Q?HWbNAMX/BGvY4gPGNrY9qjnLNJrxiQVIhZcTYJ4GrKzoKaBsvCB0tQmdv23b?=
 =?us-ascii?Q?MholyYsrPMbJ1dcJZmArJZiUtSVuL10/wmwwRMpCi2YTh8dJSbwtsyqo5LgZ?=
 =?us-ascii?Q?Eeb8hrFQ/InuZy1vWVrxC2de6YzEmj1Qx8GXfIKs8/M+EPOmYTiZ2DYzBgwg?=
 =?us-ascii?Q?M96V6/UvPFwq711r4u/LGBLibGu9xbvYXsyoojVKzZ9hbvoXVbet0vrRhOxB?=
 =?us-ascii?Q?vuV0EcAESDenylLJvkM8mpkzUhCZ7pNhoGPiN1StNwSjrUHZXfKHyVvqauDs?=
 =?us-ascii?Q?2wwkzyyUAGsK45F4aJRI5hcFcsZ90Fba1pCSiXfTgJXh9eqZ1pVrwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PxvLdeUGRatoENO/B4yTCcmiUffvloFmkO4rz6LyCpYmwtu5YnasaYcdX9Zs?=
 =?us-ascii?Q?yIh9dLTSyilNOYzIArJbqvHUKXOf1IR1moIDQHR9U/zm36En9VW3qrFxSrrR?=
 =?us-ascii?Q?B0p3aKBPydN1p4UiqS8aGKFi9WEbW4aCBrAgnCpqXZjd23/nEmsc0CaT9ab8?=
 =?us-ascii?Q?OkuoEkXaMcL030BSsSw9nQlN5vgm5Nc1heY/OO9bzqbTB6xLod3V0MLDQecO?=
 =?us-ascii?Q?NmzalS2PyEl+RjRf8OdY9a1Ch1N0culKW5hrpbDIcAxt17aw/mmfDGy/RnBk?=
 =?us-ascii?Q?MIf25ytIt2yOPspsmKe7sqcOi+lIxdbsaBscst02c8I1mucGjz8cDNZyJIGr?=
 =?us-ascii?Q?hYPD7Y8nJDo7/4Ov+I3cl3mtVfIuLtd5hInNl8kAL4RAKN9PcwPcMaPgTcmo?=
 =?us-ascii?Q?P3fAkSbX22HfukOTFpjkaWVcfI+0ywVT6SzR4DxJgoEjeUm+wdZSOX6pTpmT?=
 =?us-ascii?Q?UT5AJ63EU5qgi+vqHU6W0tZostpOe1pccMeSFd64yh/4xs5FyAMXilsRLjxL?=
 =?us-ascii?Q?pRX4EoYfgwWM3vzeMXI6+veuEuuQnLR446RDjnLV512s0sA9fTwudl8YEBFx?=
 =?us-ascii?Q?W9avgkcDJhT1j0TzJPekZZwaxeh1Zu5+M+s1WuwCCBrmCUZaLcpgqo2376ty?=
 =?us-ascii?Q?ydb0mBAod86qn/itjbFW4i80G0/IDBGLIEAh96Esp5vDrytR6z+0mQPfWzMH?=
 =?us-ascii?Q?VVGxFftAfQeJrlVD33uR2oDvNskP/R7UmU+trvu3i7tnbmY8Uv6MC2iJNJax?=
 =?us-ascii?Q?XY5yudFAibZXSMsOZXmLZPMsym7q76I7mxiSak14Y+QgXOrfzGBcyiBGrYOk?=
 =?us-ascii?Q?fY59pbNeZAur1xvxjmEISj21QFVI/u3KN7z+pX5j3tEUpn2KKLNsohhNgSVu?=
 =?us-ascii?Q?O2pk15AWBiEIBtOLO65gWlH5lQf/JpRw3BsHggkxb2SVDLPvUIt+2rN/DHK3?=
 =?us-ascii?Q?txcuiaU72usLMfvDivD5YbxwxyNiF5KOOvMXywugooSGkvC2bJYdNuBMZSCZ?=
 =?us-ascii?Q?63wAyWyqHRjAIyZ/JH3qM9p5Er+zG7ma3J8wZVKaWQCDUcTdvAgHot/naqdC?=
 =?us-ascii?Q?01GOwZYGlhSxPS3QWLA6a5JCoZChr/fXe8lN9IUkhOBEsNU90NfCMMWkaqS1?=
 =?us-ascii?Q?Bg2TjSWyASkkKLieI8ITJAs/8C0kh/1allDhg40ymXsJ+Ebh3T9sjTujJ0+m?=
 =?us-ascii?Q?moqv6Iedv3AhoZwMTlUqSoStOToPRj/QbmfVn8hVzmEwE773dcU9orvsTJ1t?=
 =?us-ascii?Q?9a9HtH9LxUWwIs04gMtkB3rBOi6g6idcX5iTfdz3Kbd9j7fMpwY8XBm730sZ?=
 =?us-ascii?Q?gIBHiJEBiCRhFOX//JlG1sqdXG5WY5Q+0mglDmGR3QIKsi0XjBDu4DnpyVdJ?=
 =?us-ascii?Q?7/wKT4K49ko7UfU7a55oEBb2CCSbxnQNUAofFWHS+r7Yzx4g2MfBJm3oT+4m?=
 =?us-ascii?Q?QKvjZNdEKnOCFNAwVWyVrqCRgI8IXb61YZC3nN7frtTbl5fY93OPUVtDDvhd?=
 =?us-ascii?Q?oKUk55VhFA1gM7lmpBZ0DhnLGvOXvPZFpLntI3cIIjTiXxlKTQFMNTu4X6c3?=
 =?us-ascii?Q?M2XRYdG4swBTpAhdu/D+N6LKzUZp8LHd0uBmlF4M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89935c8c-3419-4bc2-62cb-08ddfb0fba41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 02:11:52.7671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qxOhpSbSWNdpZbqYQQQX/vSzFkYVS5Q660as99lE2z4a0gKryTTJdh+cmI7PhaUZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459
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

Add the compatible string and driver data for i.MX8QXP.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/spi/nxp_fspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 2f9abdc7795..6e2aee4672b 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -337,6 +337,15 @@ static struct nxp_fspi_devtype_data imxrt1170_data = {
 	.little_endian = true,
 };
 
+static const struct nxp_fspi_devtype_data imx8qxp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 32,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	struct udevice *dev;
 	void __iomem *iobase;
@@ -1081,6 +1090,7 @@ static const struct udevice_id nxp_fspi_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (ulong)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (ulong)&imx8mm_data, },
 	{ .compatible = "nxp,imx8mp-fspi", .data = (ulong)&imx8mm_data, },
+	{ .compatible = "nxp,imx8qxp-fspi", .data = (ulong)&imx8qxp_data, },
 	{ .compatible = "nxp,imxrt1170-fspi", .data = (ulong)&imxrt1170_data, },
 	{ }
 };
-- 
2.37.1

