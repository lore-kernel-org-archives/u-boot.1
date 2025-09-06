Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B9ECAC598
	for <u-boot@archiver.kernel.org>; Tue, 16 Sep 2025 09:46:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF96C835B3;
	Tue, 16 Sep 2025 11:46:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o2zsCV0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4068883287; Tue, 16 Sep 2025 11:46:01 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C49803CC
 for <u-boot@lists.denx.de>; Tue, 16 Sep 2025 11:45:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kc9Z4vUgKcIAxY63RXWIEB+siZsEgE5EjEAVCQSUYKRZuJtlYWHVnExM9Sykma3G2HTETJiJiN18FbL4KKyHko/yEZ9cY+e2KI2hHBABPbjMPdpBlbowpbujUcDwt2zHRiEsBQ/aoKj/Y2SYL7np+Ou/FyCmqZTfSam3mj6WuHhUn+TCmar5mkfw1lYYCJ3vMOqwpkAFAObE4jQZZyY9OBA53g3NNGYHeKJynBPi71j2p5EWAcuTyTAJF8qtguhY+pKLyhCr2ALDv4c2/ht7KWKuW7VBicpX1bXfBs0s0ubOsJqW5u6SszzXAQHaf4Cw0S9PrFxo45vN4uMpna9PEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GnrjU+wMl0t8YRDh9ynnyyDJUBzzappmcWfzQk5QCA=;
 b=uyhYgwF9sP4j7JS0m4MCSKLYvJoBmis7D7fo3zeuJUylXUCIbpLXSVMgkf1hGSYXFMBdEhy25IS5WBY5duQ37JedFMCHZPKNazTLHFY3twFERQ21wzAoqVR8AdO3/5di1y0fBWt02HU9m4pCe2/ERtDmZrWBj6sePiQvX2Nf4Bgi6UfeLTg8X+Kph1vCedTG4HoEfcwfwi0N9c79DyF2prG7hefyGryv8/ZIgFt1X4Th2sv9146oKkHeS2AYTG9RJi3GR5poy16L1JKZSfMZzNedE1XDGFIi4ue4xDBIM55iUMibGX0K71AYmhe6TucQLScMJJlnh0EQZA8WUEhYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GnrjU+wMl0t8YRDh9ynnyyDJUBzzappmcWfzQk5QCA=;
 b=o2zsCV0jklnArFyBuCfJZaR0Qi3Si5ZZRpy7rNB6yatUSKLrfddTInD8PbHEjGR46SjmYL2mXo7rOIaq5VevxkKkvbhMkHfKtzpGZn1hm8tkD1JXpIV1W46rSb7xDGsNteufBLKwDACh80hejPEEcPqcDU2kqJC6mOJv3JhJhbwKMKZgLggvfqBOGa2uOe02XLXvc2VRHkPxbdd1IrrTzhfJDlsfsEbYUGsRmjwwpG6bV6A7qrN9WK6joFwXZavwg94Q8LCLUe/Tg5/68D85mG7KDIX5UzXdxxIWfFpxHm+ucZP9Udnjwq7Knni/Ly1FjMaBuJviFPvetnRHFcySdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA4PR04MB9391.eurprd04.prod.outlook.com (2603:10a6:102:2aa::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 09:45:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 09:45:55 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: sbabic@nabladev.com, festevam@gmail.com, uboot-imx@nxp.com,
 trini@konsulko.com, alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [v2 10/12] imx: ele_ahab: Add i.MX94 support to display_life_cycle()
Date: Sun,  7 Sep 2025 04:37:40 +0800
Message-ID: <20250906203743.3352805-11-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
References: <20250906203743.3352805-1-alice.guo@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA4PR04MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: 39482f5c-2a79-4e16-50ec-08ddf505d4e0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZfuIVlk4EAfKJfrw404px4qPy22C0AZVwAck1pylnu5M5CBgbrPretmpLKA?=
 =?us-ascii?Q?7cImjttN8TUAY/aqNbf95hn8ymfmHO5o3moyiw2cx1dtKFvz9RnICqQembBw?=
 =?us-ascii?Q?vw1PKX+K4aYEYf724GjYspZWvzhyy26rwUbw+axd8JgaUyYbQwGc2j52v3zK?=
 =?us-ascii?Q?2KKIf1UZ8SdTXfWewe6Vq7dDzYMkLZgj02nbZtrudIRW9CaE2BnUy+RU7cq7?=
 =?us-ascii?Q?IHxnHXezeCyYQ2jUH/jgLWLAAF0vCv7+S1p0x42d+J+gO3Yd22w374eickSq?=
 =?us-ascii?Q?0Ua62rFlZUGSVCz/L8pPao26GZGYkNK3wZ+ZhJsVZI5KHds2Q7ywfKcqY3fR?=
 =?us-ascii?Q?2FLM+jFwxg/z4HZScVr8bp5Hw61ycoMM+PxQGhEI5B8dKoxCTW3YPJ0ykml3?=
 =?us-ascii?Q?LNGXq2N5cBtwv9gRA2WM2yzz7/G4GihmF/OYBVheJfD2eYBY4Pzyc3XNpQBP?=
 =?us-ascii?Q?3V+lYrm+WU7JPKrBw1ah1mr9fqWOYao3J3Qd+XNQn2409c3oxkM23P5TmOXM?=
 =?us-ascii?Q?fJ0pO/GEDVhiePmgyIknZpE7wJxLy0eD7lpaeDCUyh4LN1Zhbich/9+z7Cj7?=
 =?us-ascii?Q?/Q8xrsIFrSMyvraeV4OuqWGDMZRoSQFre6nsamtXXCZj5UIeztptCrF7nA+A?=
 =?us-ascii?Q?h7m0Iteg1TEdd6tMLDlIjFxKKRSeen/Tvy4+ZoiSf5UTritWZIctdH6oV9Tt?=
 =?us-ascii?Q?hHQ1r/LYAgnANzEnmWp6fFdSX8r1KS+Y/mRACvuP7IjffbZqQdkrqSdNiKmS?=
 =?us-ascii?Q?wjW0QCUBhX42Jbwa0UQx9KWU0IgFhJHvRA/3w7HXw2CKyL2O7ifOFlL4x14S?=
 =?us-ascii?Q?0NXL5St68g4KTYLRPOsUIXztFoAWK9nMhMFfCu7b8ha6jZap/T2hEsBaExIx?=
 =?us-ascii?Q?oQyEh+K2tcy3HEypiBLbT+gly/Db58unq6RQNLfJfWb1kTQUPpPdTtUJx9eT?=
 =?us-ascii?Q?vAJpO/4MdjOL92cuD78oYw2XFsJ451xu4+2x96DTARGxC+bBForvP8+3xXva?=
 =?us-ascii?Q?0NfbpluFKPDg9+ykB5g9pARHgdtRooLO6qD4fMtYR28766slXuUQrz9esmBx?=
 =?us-ascii?Q?AMi9gP4bjX3HAniNIKom5NRfv9b+y3kZcQPKAQzFD+hO9zHmOck7zO6tWIza?=
 =?us-ascii?Q?hxHHmL8Efh/qyr0RdKdlsHHqwwshl1m5vZxKySO4hDKulea9qaPKz711xEPe?=
 =?us-ascii?Q?sv8heyrCCuogKPqRrrBvDmM0sfusYWlArpXj1qdyHOpaAgH2/fByP1Hd0sHW?=
 =?us-ascii?Q?4XT3HyEO1uNjLsDtQrSCB8VYiofnBSCRbFT8HZp8FAUKeHAfNdbAI39AVqh3?=
 =?us-ascii?Q?8rqEMbxaryfSnxzO27Q1Rxptf8quIY45mMcOrLR6O4+m5bIO2oRZqNCK0rqF?=
 =?us-ascii?Q?BS3y6ByOxFkcpSoautYPueiMvh6l8jQtiIJym/lYZp8aZPX9GOyGP7v+iFHN?=
 =?us-ascii?Q?bdhLAJ/kkZfzIh5UWuQ8tYXhCwarFUl4D4jssmbR8bdNZvXiVdIAaw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pZI/lRYooNo1ligQsje/CsjCUt4OKeg0sEVyR1O/a7oVpl6fHcfXXaT7vbNr?=
 =?us-ascii?Q?12dNZcWlZdIb5TjXsBwdGR7oIgV2FpZN8dcJZYW8n06mqeV4pLloa+MyZwc9?=
 =?us-ascii?Q?VpiNuadGd74t3yzZ4pJ3CzQ7UwDCXIMFyyC1+pfIzL5mw2VT0nCaK8UGhfUd?=
 =?us-ascii?Q?vm4Eap3uUmiZOG5vmNw46G6Tjug5gURepBW3aXj82Lw28FPIQbGQiUvqTkjX?=
 =?us-ascii?Q?5nLDXkfWUhJgpDPc9mEr/OO9EfXDf3qde07etV3BsTr/M6Axhpa0gnbTuOgX?=
 =?us-ascii?Q?p2pqQFy3LoMsqKwrgxV1Td0ffMGw/NJDwQneZKZp8n4yW6FEp6Huci29x921?=
 =?us-ascii?Q?85LXefLH3eiWBYjgTxgciiTf3ko36HtOlZHdN22AsZhiXmi9dqBEb/64Yf8x?=
 =?us-ascii?Q?2Hd4qCuLTJQucxM4SQwY3sVFAH6HxaBa2Jv2C0HLCIiQzhr8AuohAVCNvNHm?=
 =?us-ascii?Q?nDllvIeSvr/FRZeUO1zeBwYX6vI9ag9hwK+kPJth3ZsJTheL8+yxv3VCFw2J?=
 =?us-ascii?Q?HSVJIMzvtLzeknuNHyMgNGpICyKaH6qcXGoTY7MQxSXnPbey0ZC9YbWToLBO?=
 =?us-ascii?Q?YAKe5u4B0ThcJXfFWKV8DauQIxQZdeAejybNl+9uQShbKSYBuAMF2qcRY3Y1?=
 =?us-ascii?Q?JIw3YU20ZBL1nNIgRPMwMnH07phbRp79jmmMMV5iLGhc4cNv7noe8wJl/E+V?=
 =?us-ascii?Q?Pvp9l5REc85dBh2Ru+RLgbYOXNHP73ngTVkaniImg8FAbpKbwF4Nm4Buf68v?=
 =?us-ascii?Q?ZFNOG/tLujkLjsZRYcSvZicLAoFKhF+Pf+668e8ldjRrlMR4yKRTqG3V9ciA?=
 =?us-ascii?Q?cz3jUTPVgnByyZo55pBVNylNJOQaS2kYNLF1mwAdxfnD/EFYYZZBzgF5iKJu?=
 =?us-ascii?Q?eVDbVcYmiP1yzIvXHAwsIXi3s/cf8IuRKgzs367oUeAmd0tXpugamng3SGXC?=
 =?us-ascii?Q?Qz1q+o1e+Qzg3v/20UeFe8JqpYD//Fh0APXonJkMTpZNeyZ2QGH75Qt/kihv?=
 =?us-ascii?Q?7lFgiRJ6dKfjXttMWliyQtMsWBWi6pShpSNgdtMS+LPP7RdRy4yPXselAeof?=
 =?us-ascii?Q?+aSAQnxwE85SjvH4klwIWPIBWxGoEGrS6J1WtElHjuCJeP5/dYtrhOQCgNCz?=
 =?us-ascii?Q?aqb2Xf2Y2b09qYCAlFKDir6VXZzTOC6nvhRLoxRPk2Uq3gnW1QFLSGDFL1rk?=
 =?us-ascii?Q?fmi5UE72Ad0r2JtvgYfccq6JWeFK1CexxtnvgehEkdtYu9Cj/tO+UhkZ9r9A?=
 =?us-ascii?Q?8qbriTqZI5Eh/z1pB+FJCk/BgsWFAfVwd4aUNf+oZ8vVvxjm3ibyRW1pJJuH?=
 =?us-ascii?Q?h+CIzHgkS6O5owPZsDIGc3qoHJv7npMHIz5gRkcmcOvV9nFaI65T68f8fFAH?=
 =?us-ascii?Q?qkJ4knMr7wPBPmMZpdRG8ADz1CI40XMCzFQpJ2zSAuMElKsESV+5p37Sj+WC?=
 =?us-ascii?Q?cXAPvtyw1P/rHF9Lg6TmLjXQSqzmpD1zrTzptwScunuGNOchGfsfl8dHC2Kp?=
 =?us-ascii?Q?p8zayfej++uN4XnmEshxgOlRiA1rbe44HG6lfjQXQTgIZV7trZbUnR8MEkJe?=
 =?us-ascii?Q?963x93mIBjU7dW/rXq8rihbn/jFmjeYrOg3CUhiX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39482f5c-2a79-4e16-50ec-08ddf505d4e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 09:45:55.4941 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQAZxYyLij2koLs4FtLPgtmIyjjfgXJFgXCnJgBeZjEuZuVg3/UMxL0HQV+wmydNP2JUoerNG2ocUXiiF7gVFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9391
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

Extend display_life_cycle() to support i.MX94.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 39aba65d29e..38e671e3935 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,7 +411,7 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#if IS_ENABLED(CONFIG_IMX95)
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
 static void display_life_cycle(u32 lc)
-- 
2.43.0

