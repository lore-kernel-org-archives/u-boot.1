Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE843CCF9EB
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 07:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF02836F0;
	Fri, 31 Oct 2025 08:49:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eV/+C7uf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 044CC83849; Fri, 31 Oct 2025 08:49:57 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 13B018331F
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 08:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUMsjX1W7CaUfYVX20DcKHi7swgdsDD9PXH/e+A6P7KMM1GduzoMJJ3HCLnzDFzv5HRAlDx1kVVLaG2OrMORyOnpZ+rviJDmUYeb1R8aR7dmxnAqhFq/5Vhz4f8k6ur+5FPcxGLr37Di2L6Y2+PkSzTWvA4qmamhdzI2fhu5UBerF+RuBQ2frUWl8WE32RE/hgYe4pZvK84frQkoEPI6akumCU3WHdRPh3Lw1BNwrpubZwPnrU4CmrTOSpcp9qL25y9PSf9Wc0RBmUZw5gRmz8DB66zaeN/fL8ZLcVU0FTqjHtHeNPB9JcCfuf0tpMPXQhmOt0ZliqHgIKOSTaNsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1rTRbwdYcrmPkG5YYOqM5IrTiR2paZnTUXI/KC24zw=;
 b=ehESGfPcDtMYP7XfyHAJuRrTHaTmeOvbX3WWBsjKOE72T++fNPycZAuR3rpYDmBY/cPccnRlvUIWGDjZacZ5iud0JR0JKM2w4e+vJzxYdXh6/tUj7F6HzDSa9VmqD4KBXEXKpTJVFPKkXr1YJ90SqsUbL2enbWtQ4qnZzxuaypgeyR8J7wl92Fvnm5HLkKjC72H3c9WxaodeuIIzL1dgnp+3GiWb5x1FTiBsvw8W0CQij37+JPHlmEv7ZrfJk483jp4JNSBxA2Elwl5Yx7Or9G2Z6YYRHpnqF5Z9DqRLDxy0HbrBR/jmElchw+vIs0u6eCgx26yzV28mqvDDkwk+9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1rTRbwdYcrmPkG5YYOqM5IrTiR2paZnTUXI/KC24zw=;
 b=eV/+C7ufkAlzOlRLaS9mnUg2TU1MfYWa2FNbTIVU+/ucbJfcObm+gxGVkMYPcz0xvLDDwopSO6o8UQ9wrkB59Rq8sWhZeEGuv5m5pgCV7awrvLzpe7RBHnC2IIaJBcxvZh3yS7iZh5xw1fTVQYBEmvmk9LAYyWW2kfVTWlJii0xHmK3HwmVpJkir0GSfU3VJNNYqCHtIQWiaxSh7xQdorKygbUaxMlzu3QWpuPZa0bqVU1Gqix4PlqLGPdgAOLw1ERBL6fujjTrqjbLAZJFH/FtZlniyy+OjE5otRXVvCgov3dtOt4gm2jXfqxWlZTedAifWT1wsB2VLLEAH8N7d6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU4PR04MB11434.eurprd04.prod.outlook.com (2603:10a6:10:5cc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:49:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 07:49:53 +0000
From: alice.guo@oss.nxp.com
To: u-boot@lists.denx.de, uboot-imx@nxp.com, sbabic@nabladev.com,
 festevam@gmail.com, trini@konsulko.com, marek.vasut+renesas@mailbox.org
Cc: davidzangcs@gmail.com, sjg@chromium.org, ye.li@nxp.com, peng.fan@nxp.com,
 alice.guo@nxp.com
Subject: [PATCH v1] arm64: imx8ulp: Split SRAM0 mapping to isolate the SCMI
 shared memory as non-cacheable
Date: Fri, 31 Oct 2025 15:49:02 +0800
Message-ID: <20251031074902.2066064-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0053.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::22)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU4PR04MB11434:EE_
X-MS-Office365-Filtering-Correlation-Id: 959e072e-21db-4bda-1eed-08de1852137a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|366016|19092799006|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZKAUkxyOmymPeGkgX/ujXbVyh0jDzjGmpJ0kfrcRdcLKPXTPLLut8RgMnh8Q?=
 =?us-ascii?Q?kaXvUZ6YpIhgtIsjr84GFsjvbInVpr2sTnquaGbGrQF0gks86sm2e6JPhSS5?=
 =?us-ascii?Q?eD2F/U3XtK0VAPtg4/RhB1TY21uVarYGacBbw25nvbTDY+NOWhdLxUNblxLc?=
 =?us-ascii?Q?Z9xx/JcX8ZeIRLz8EaSWByeSjmIch0KauHvC1CR3BxMAVbKx4dZIGAec9yQX?=
 =?us-ascii?Q?mlsks4vdvYg9IVTl8erTz+/ef7hbUiLyBWopcuweODn7Gz3s+xkAW/KsYGFN?=
 =?us-ascii?Q?BLwlaI2hDzcazdVmCm5ZGivnoR3Szoszu+tlUSFBziLvix89/2R/ysglCWWO?=
 =?us-ascii?Q?Q9n6UZ8579Gknk7HeG17i35Hb8KhSwuh0QPf6BTUThIwfB/NOD8BBXsGBY5E?=
 =?us-ascii?Q?ulQLM4aMUt86jks4H+nREId7V5+V6rmushlu4chTLpsDiq8UTA5xNETVD+DY?=
 =?us-ascii?Q?rtaJA3Zk9cgEJ4DS6O4YGtx+YgGO3PnHjPhVx1tCliZdV7tvtU3dwOsDcT6s?=
 =?us-ascii?Q?2djWweeHXEDT1NEmPmZaMJ4QHOjfr2+1xUNmBfFySRd52bqA7XdyczIGTmjR?=
 =?us-ascii?Q?g388MhIX6xui29DS0QainkesImrW5F6yfb4hZ4TQ9yJMxWQy4nfFwAQgqdK5?=
 =?us-ascii?Q?JmzitGeXakVD5KODxSlgeTKLl2Ure6oVTfCSK6XGW63xQZUn1bBP7XlfR3B7?=
 =?us-ascii?Q?Kmf3Qg7T3ogxERstx7hDy2LGeOmJ/ngoP/UzAPdcZy6fIqOfHjFwdazxePd2?=
 =?us-ascii?Q?C/6tbbWm5GNwPMBXWPM4nuL3072w+mToQ0uM9WU2ZERm6hNfWgutmEkqltcI?=
 =?us-ascii?Q?Jic7n7Iw8LanjFgpIidiOpoq64uo75KCnKsZcREQUE1IE5vA36lg5RXtSW6m?=
 =?us-ascii?Q?4UG/nB8pWAfi8wv658RZGdW9rIXQ/H5rmG6xlD3fBwAPDohoQDqscBUSiAjR?=
 =?us-ascii?Q?3usXDZ9RzhX1xd2h/Y+ksFgOj8U7o23cdUnAvQU05vKxWDLVjWOkjD8ExxwL?=
 =?us-ascii?Q?m2CuDO6Ugsa1MNq9kjQmTvWyC2GL/DI3GjiLYgbjsyPiMAltkVzrQ5Mg0Yba?=
 =?us-ascii?Q?CREoPW97fPnW5lpetx5Pa12VAgM0FRedZZjHQ4LbHjP638Yfbbo01F2ujTWq?=
 =?us-ascii?Q?AIyGNT5UAdZPm2rcZB7/+N3qFRnh/AbYmnFZ1TS7J5bVydj1FdZlA3rmBaAz?=
 =?us-ascii?Q?4/7DL+2YjuGyBX9/uz3BKw3qAboBpCDu9xxR4vPkJ+GBMb4RboHdNVb/6xWz?=
 =?us-ascii?Q?3uWP+HACjXl0pQ/bNOqY3lx9/ot4ehEc0NyIubxO7fMcBWsxvMMqzl/+2uCj?=
 =?us-ascii?Q?yKy5yT9AB2j1ImjbCXDHDtvH0jhW5gFtk/f+3vwOy9mXqoHl03GrUQn1gK09?=
 =?us-ascii?Q?EFjKjhvORwohUcNY1DfLOAsnDlrr4eO6U5axWA8jqhUwO/CO5p9kede3a/aI?=
 =?us-ascii?Q?3nsgEZJX0Jbbfbx/QIQHrfWQarz9gvFQUAdqyzrPYj69sZhK6xLchVsV+nLH?=
 =?us-ascii?Q?teGpkPo5vkc+N2Q9sbWyDXf0a/bwr+nyzqBI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(366016)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRz9inDDqrJMmS6/xk5zc/C0pUaaGjo3Cp3zY3vxG1SJVulPLigPK3eZPClt?=
 =?us-ascii?Q?01s/D9ENtHgeAa1H/5CwLqSN+I1BmWCMYAFaoc453g1FhlNIVEFNgCJf9OyI?=
 =?us-ascii?Q?g9ubik0hOdeVb3hatZNLScMnvdvmEk2sbhv+zIWjWD+2eEGDjcskDNPzaudw?=
 =?us-ascii?Q?S3MD8qyrv+uhyZDu/JWNtiWvUtQdWLryvsmwE6D22aRNmgHhbK/Q4LAmqgCM?=
 =?us-ascii?Q?bdoL6fCo88Yx/ilOgxGnBVtCW/nI630J2dfnjPkCmcR2DU2u++lEnnkkdXg5?=
 =?us-ascii?Q?0rl7ARKM4GYqNvWimr484ni3OQvQHJLR1EhTxb7OoJt1XU3fF84q3k1fTo3X?=
 =?us-ascii?Q?XbIh+HFmSm5ydQPW7NnpMzMpuPgyaqVldFVUSa16+ihGGoAyl1vu9ltb4Aaq?=
 =?us-ascii?Q?nJrGBZGP7AMiHoRYasHZ3/7OROIYuXLoqBRoI3o/PabJ7HHYFbGGzATC0WV7?=
 =?us-ascii?Q?iORl8OKJJ/I3ZA3X2FZjXannNVCt0ybm/ZDl3MD9sGXUZXfpjswkFLXf5jvZ?=
 =?us-ascii?Q?prxLVHklN2ptzLlv1QWuyqSLG/mrK6Al9CAJbGStPpNrCb4pwPFn3Ir0Fjwd?=
 =?us-ascii?Q?o6H1Xwy9Vrvi5lTFm63In60oA8ycy2owMinjDqaQ9Y+wXtOfjEVQR4DNnK4P?=
 =?us-ascii?Q?r+rrFA1pP9f4Bir5ZRynk/BdptxeBLdV4k+s4zJ/ZEsFTTS0tNw0L3HWU10N?=
 =?us-ascii?Q?wOF2EgR34q76WdaUp6hVsdKv7NFWzDXPI1ODzCghl5Huwz60KCEc+nuiX2Nm?=
 =?us-ascii?Q?Xir+KSsacTHiHa+gAUpRcFh21KSCR20F5vgXsipt92ksJzqGZnplasHSko6C?=
 =?us-ascii?Q?VLBCf4bvLZaOsC7Xf+pb3J3rZnd2efgWS+vOl9Z/JzMbbxYvLwjkvntZhZP+?=
 =?us-ascii?Q?r9Hkbl3aNYT+MjfFIN7FXpfxjuo2OvRlYoUMc+vUooACGq3gONJHzUFdQGEu?=
 =?us-ascii?Q?D0+MfwF4f8ctSLaBwxmXgqI6ZYmR30PSzbhyWJDPepLfBdOYPMMteQJD+42j?=
 =?us-ascii?Q?mEmgnHew0uu5rsuLsirVjPwxMNGt6AorOGGSwiSY1yuIp9ANlueQlmkJzmb1?=
 =?us-ascii?Q?xrjpILQGpI315J6hQekTdtqa22Sm/ZhrV/0SL0/DnFpLwm7qXs7Pg7USUCjW?=
 =?us-ascii?Q?UBLI9Zjia90+LsgAc+62ofe8Y75V9pyF9vwV8qSvqzGf96yBmtrkh2hdtmib?=
 =?us-ascii?Q?Ir3vgPrEiGgXMgkPJte6C+nOWmknL4YdhrMqxzJGCNAFCGyA+my2T2uwqxBt?=
 =?us-ascii?Q?i8GKIxuLXBDeYZAeQ8/9UFtUyyWmsAcWLfkdeEVbzNITkLCZGbmn1jUozOtr?=
 =?us-ascii?Q?zca41TmaqylxrlvQmIcjEu+558X7W3o5Nt15O69+Cv5de8STzGm1WebWEUOw?=
 =?us-ascii?Q?FbCxiOaqu7dPWy9awJm88ek5YCFnoK6fhI+OnEf5XMnxk1tP+ZEVHepJo6xm?=
 =?us-ascii?Q?GGK2kYlmwOAO6QRv2K7g5E81Axr7auU8PM3Yg8qQg60s2jjerNJdKiQyH/ou?=
 =?us-ascii?Q?OM/10+b/pt9Cz48iAr73xS7sCp9A6BV4U4WYJceE8WZ1PJbjBWmVc0euiaox?=
 =?us-ascii?Q?K/SnkCpn3spsovWAVuboHu7e77ZcYxMDiY2mLBqk?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959e072e-21db-4bda-1eed-08de1852137a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:49:53.0501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDf0EobMzDJUwWkg5mx1sbeJoYPwG7QvHKBwe619Rl6EKI1VCP5O4OVw1A4G6d5lhmEUzJLBzZ6xSzURgdZOnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11434
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

This patch splits the 2MB SRAM0 mapping into three regions:
- 0x22000000~0x2201f000: cacheable normal memory
- 0x2201f000~0x22020000: non-cacheable device memory
- 0x22020000~0x22200000: cacheable normal memory

The change ensures the SCMI shared memory is non-cacheable, which
avoids cache-related issues after removing
mmu_set_region_dcache_behaviour() from scmi_dt_get_smt_buffer().

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/imx8ulp/soc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx8ulp/soc.c b/arch/arm/mach-imx/imx8ulp/soc.c
index 04c6f064130..6cb6b0e7429 100644
--- a/arch/arm/mach-imx/imx8ulp/soc.c
+++ b/arch/arm/mach-imx/imx8ulp/soc.c
@@ -384,7 +384,21 @@ static struct mm_region imx8ulp_arm64_mem_map[] = {
 		/* SRAM0 (align with 2M) */
 		.virt = 0x22000000UL,
 		.phys = 0x22000000UL,
-		.size = 0x200000UL,
+		.size = 0x1f000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_OUTER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x2201f000UL,
+		.phys = 0x2201f000UL,
+		.size = 0x1000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		.virt = 0x22020000UL,
+		.phys = 0x22020000UL,
+		.size = 0x1e0000UL,
 		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
 			 PTE_BLOCK_OUTER_SHARE |
 			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
-- 
2.43.0

