Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DFBC87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 09:42:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620E383D46;
	Fri,  8 Aug 2025 11:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="YGGMlBPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7114E846A4; Fri,  8 Aug 2025 11:42:54 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D40D83D3D
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 11:42:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgzZ/YfbXxKooA9RTeMxLe1Qgi6K0Tux3PTzaR2hDQam9IPyCkZ8lVs71LJPneQEZc0uX5iTRnCJ9dV5QMrlgaDoDX1nzPkeI3ArCem5DV6h3NV3OgeVF4Zcbxty4VYmQRzpWkF5UhCRERcEScJUdpchuj46ftmoGpyCs0sPYxQVrH/g5qsM49iIoOAfU4eVE4lnqs4sdRqWJgNLIpJiL25SSxR/DdtUOyahBbNKmlGfXDAO2t7keXKOo8XMBBnVL631SAdshdXxIUT48cNo5ZdsSupEKteEmeHlRfG9JSjpaRtTwB8Cx8DXlQUGMznX25Q/z0DAo0/JB3P9nOSKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjNj00z0l76CiWQgNsFg3HQRR9aFzShanPl3zs3nvlI=;
 b=nM45hVBnxRf3yfIURTTfgmLsoYulh+8AsHAf1IyD8ehqArn/f69MltjVxxa6BbkABoWgLQJGsh2hkcxMwd3KlXL8kFOjYTxbAo/qXjfV2x6GhBuMhXaysymj3Fp7Ctk36unkbFN22Hh9JzfmVB2XE7QEjgeeg/FIkBL0yXbXzXFLojPC66/wv7AZLsKzYCNl+G1AVsiC+3b9a+Xx6pCs9Nd3sSvK4kGEwfVc3z4YbLk80jPZqHnv5c6/RFV4ARj8pmpyau9GGO26aRJQpoHDUX5T45ZUEnTptXVot9OzHCBtnGv0norR6dt7wUEd/u/v5m0zQJA4PGxT9FVmEx9rHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjNj00z0l76CiWQgNsFg3HQRR9aFzShanPl3zs3nvlI=;
 b=YGGMlBPnmK3Nn62KKxlOb9sCF7hbpbKZpEJArt/qDnHzr7EXwrS1Xzvf3VGZk/eAXR6AY6olzT/bHJWzAbcm3Gxy1ixlh1BttaD0RhxlARh3DmpEb6LOlEj1nPiDdOgcAZan/eu+TFja5iu7G5sm3m9eHkfZz1sC5MvFcKBcV3p2gmUEHwIFNciH/J02J6WjQpM0M6VPhKYiblhfSDdJokXsvK4sb2C2w6a5u2MuFD3vq6BjleR48x5Tnhwv6HZaVwlmSrH6qaqEDsJgXzpyabiOPr9uMdZ3vSmSlpsXHJqh3nkhwm+tCT4j3+vvAeaTWk9sOzb1A01GV0uSy1h+qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by SA2PR03MB5724.namprd03.prod.outlook.com (2603:10b6:806:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 09:42:49 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 09:42:49 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: ddr: altera: Correct DDR calibration status check
Date: Fri,  8 Aug 2025 02:42:42 -0700
Message-Id: <20250808094242.26221-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|SA2PR03MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 58857dde-3ea3-4785-3fb5-08ddd65fefb6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?baLx8AVWRAGEPDO7gQ8xUr12ATHMT43wrISsdsnmca5bnbU/z3/E9pOhAU5E?=
 =?us-ascii?Q?t47PnFUjB5wnW0/y07Pvgkx0uc4IOFqR9TLhflESaLsBD/QlP2s0MUzzBk8m?=
 =?us-ascii?Q?+/GkcrT2D8v3IfYhKgS7UBHqVeI5eGXmKZML/btQsPsbJiifd2unOy/b+KYL?=
 =?us-ascii?Q?XMJ6OpEqyDUsrgJh65omxUet5MKXk1XS/a2EKecNvuUbw2sXjHKQIkc2jL11?=
 =?us-ascii?Q?l0b78O0TEoAKWVVGufyNWquoMURAXNSqqv4dDcK5qVB61JigdDw5rX1kuGCZ?=
 =?us-ascii?Q?X9ODiONZXHdj6F4n7GbI+AcPRiO6fy4fkfqzSm15T2b1M1fmGefUkcTGLVZ5?=
 =?us-ascii?Q?twLnUGoU6tSXZbN/BaEfIHhzhbbtzVOkYp5GMFxKobs7LRATrR2C8AnT6oE5?=
 =?us-ascii?Q?1nu65vmeS1Zm/vSlDZsAzbEN5qlyWCAogAW9Sjz4fSVVXI81N2oUxeqbjfCk?=
 =?us-ascii?Q?79pj/e1ZZRufzRx8yo8xxRMNpo5izcrBRS7UeRvU54sNKhTh1FzYXaW3V7Zk?=
 =?us-ascii?Q?xOkaTmv15yNW6fUNoSvV5oibOae6V+oxQseJWRE8Wc6CF8IAC/YjqkaRC4Wb?=
 =?us-ascii?Q?hGDs0bO0RQ1JfCpqzfg+JNsKTzro8J7AJIH92POdiLfkNnQO40GBnTBKX35I?=
 =?us-ascii?Q?8wwCq70qtBIGjCjcnxRk63HZZ6x1jBeknIJk1fpNdunvEuMSZQKHKpMFbuJI?=
 =?us-ascii?Q?3VTVfty4OdZGiX+pqe/ZlJ8BoTPOaT/r2D0ISxRH1mjinb9MbA1RwF6rch+X?=
 =?us-ascii?Q?wXiKkyDPUleUANL8T7eqQu1MvfWOmmsLJTqv5/mtgX5EwFas9QM4eVt4C7Rv?=
 =?us-ascii?Q?+Nbh8ppxE+Ac/JlB7vHDWRVRts60wFFQS9r2dn9TX1jFZIMx5+sGn/rR+KJT?=
 =?us-ascii?Q?Ij1bXbS80l+IrGckfEgbYMkYTRa9VAsCZgIdzPC9Zda6t87cLiEkroOHl1h0?=
 =?us-ascii?Q?CseYWKWRLid3Kd3o6qBZXBGRq4ia2J4c4elhtlvKImBNbm7OPemB7HyF+ZTV?=
 =?us-ascii?Q?/j1pH7kLboSp6gNsrAUF8tNY6dYzelu7uMckZmYyNTQqEVp98nJ40fzbp1w1?=
 =?us-ascii?Q?YrepJnT75UMxH5eGc7lriIAe2diO9qeJfi7dIqsjrtlKSAZ42n6Tfnlaki9G?=
 =?us-ascii?Q?fJA/xhPxxrF3cTsXH2DwH45Zo4L6r3vE8eYxQJuiAXwldmHDpFd7/SzWKR9o?=
 =?us-ascii?Q?S05F/fQ0shVq9+fkIjxNGMAuzJy6wp0k4pvbPuIVMZam4T/AqH38BdykD8Ud?=
 =?us-ascii?Q?bSCG81hkGLX0sMpioY0S84Lzp5Le38LMzgTqECXHJ1WABOF6srQdt0QfpdeG?=
 =?us-ascii?Q?7TYSCZz/W8aKMrbEzDW7u7maRj25eG85QppZIYriiFBN3dxVINLWFsuBDmtF?=
 =?us-ascii?Q?5H2oX76DfNc79zUC8e2BOKMWPKiSR/XTaCMxV3YwodJJptKsb1cDSWRV3qZh?=
 =?us-ascii?Q?w4pDAvWLnWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RdEDj6HOgz8ayBNhorjITvZQ3alH97dGeJE2VTzEUNrFKuav5oeB/P/uZIOV?=
 =?us-ascii?Q?j3+xVMpmxdbx0Jh6ju6W37CQFETeUc7YJGnNvRPYZkdBYIsPuTuPfPGDSL5t?=
 =?us-ascii?Q?Ite7S4Urp02WWu4Hd+2EzhK42j4cm6cKUzXTD6r9iy4vNzO7kREUm4vIiZbW?=
 =?us-ascii?Q?AYqMnXTJh10PGRO9cBtZcWAgaA7TBtiRKtk/uQYf84U7VsGIj7k6vzlTcnqo?=
 =?us-ascii?Q?NMH5yOE+LCcfhDCivBNCT6SHnw1H6V4E31cMux1LNnPdpwWDUibH03zW9E/X?=
 =?us-ascii?Q?rTfh//tTkWiBsNsMsVvLswsMmiNaoF4/TrvvGsKU0EnmPE4+9rl98N25RxPF?=
 =?us-ascii?Q?BYwmJlNSPFAFWLuVTMNiHdjTpjLll/rPNdaGgVpqL4A7Fd6MjlgvAf14b0iL?=
 =?us-ascii?Q?dUtx/EGMANOmv2LEQbyTxgmeEHm+hAAba1tC5LW7WiI2LyOnAHIBuIJ5gHLv?=
 =?us-ascii?Q?2erEaJX88Mu59D92zSmXY9XNv0J2mjkCRdeARskbdo+Flcl+UzEFIzZDMTsb?=
 =?us-ascii?Q?LVUlwdOm18Ax3iywgGhCuCnvBLQ/byiooee2SgDe7bTIkvh6jl48ZNqE2K//?=
 =?us-ascii?Q?g3zinl+W547r7hCu73a8ocju+nbVg8WDduo3LiRU8gSyKYOa8YQS44L8NIXg?=
 =?us-ascii?Q?EQbYvoact6S8amOuZk4qtW7zNPW+2htomofQFlknAZ/zw3z2q/QYTngoIz56?=
 =?us-ascii?Q?puoUs9aEc1hX7cZ/P+WLx4bEOJxES+kuBrYj7uAHwhr4PZHSJ8/+ZgS6Mctx?=
 =?us-ascii?Q?HMmNNdRoHShm9hNroSrK8LErECHKRGvh84gZ/vs+yct5JNYYSc2j/PCBJiJ3?=
 =?us-ascii?Q?I6vCFLUqzljwosVHA97H4vu0nSFJWENRBYZLNLTB3SWtWCMs2/MGF2+u/1IY?=
 =?us-ascii?Q?Hh7NaUrBfsz7DkHBEXaSuTsfcquZbtZi1BctfODUsFjw3iN2FCl/256qp5hx?=
 =?us-ascii?Q?9XqUbwq60Puoo+hwh72L2WgM4eWSPpj86945wdz8uOsQStTBE69WjLTRdlFx?=
 =?us-ascii?Q?YCmpUZP7EDcMjoWbACLsiK7aJ9oBpCIQvk8dyXUlnbFQYxohhyZiO/1xnMM3?=
 =?us-ascii?Q?OpeILodEzH8kQZF377cu+4UxhQny2FAjIFwy6bDjlF9kGCMD79S++OXHBKY8?=
 =?us-ascii?Q?H3di7vrdkEfQRqNKyDvSCdR/a1TquipCIe7jWI0E2Hadflc4moD6DYBao4u1?=
 =?us-ascii?Q?m5HCeUXbYMO7tAXoEe86BU9eaoPYou4O24UWGzPIOJtEu7+r+IyKa3mUe1+/?=
 =?us-ascii?Q?83fS9DpxEzbwCtpiLgnu7JPzly8sLuwZnM3bGfT1PWqaTzf/oZTpQidZrf99?=
 =?us-ascii?Q?qxzE7lWwecoBY+yM0AoqRWFS2kSh+0QgIPZZ/8/Xyid7EwVltlRWIyxpT1Bo?=
 =?us-ascii?Q?LDjMy21+ojPGowR1TnmKcDo0cA/DKNoKHWc9YocDmxii6eDHKlJ0MTbFsNjQ?=
 =?us-ascii?Q?TPB0K9OuN0Cdo0f6iaBaL9ExpjQkyl8rZgL7W6Jx/fhZ5S7L6rzfBZVdLu71?=
 =?us-ascii?Q?OlfaZsDq8s5Y7du+vDSMLT9Y/5bYFXQgNIDzzk7Xgq85emWk+JnP2ohkqXmc?=
 =?us-ascii?Q?TA9bzzV7BS1tAwjAId+LPrMDsP87AA67PHEF+N259j2sWRDlT9Bi94I9CzkC?=
 =?us-ascii?Q?7N2hfP42UE2PKclhXFKQhSc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58857dde-3ea3-4785-3fb5-08ddd65fefb6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 09:42:48.9511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y52Z/wvpUwcxSBYal4hCKOQl4SijH4cRDvb3/mK3cOl4MzXtYUGR51AeyWJ7585XSDjLu3T5bwEVQ50A+zaOItw8Z5+t8mUbgU8Yw1igxP0WR+HxdU1FvY09ibVo40ho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5724
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

Bit 3 of the seq2core register is no longer set to indicate
calibration completion. Instead, added polling of the seq2core
register until it reads 0b00000111, signaling that the Nios
processor has started the calibration process.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_soc64.c | 6 +++---
 drivers/ddr/altera/sdram_soc64.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 27fbe80ed41..4ce129f5e2b 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -82,11 +82,11 @@ int emif_reset(struct altera_sdram_plat *plat)
 	debug("DDR: Triggerring emif reset\n");
 	hmc_ecc_writel(plat, DDR_HMC_CORE2SEQ_INT_REQ, RSTHANDSHAKECTRL);
 
-	/* if seq2core[3] = 0, we are good */
+	/* if seq2core[2:0] = 0b0000_0111, we are good */
 	ret = wait_for_bit_le32((const void *)(plat->hmc +
 				 RSTHANDSHAKESTAT),
-				 DDR_HMC_SEQ2CORE_INT_RESP_MASK,
-				 false, 1000, false);
+				 DDR_HMC_SEQ2CORE_INT_REQ_ACK_MASK,
+				 true, 1000, false);
 	if (ret) {
 		printf("DDR: failed to get ack from EMIF\n");
 		return ret;
diff --git a/drivers/ddr/altera/sdram_soc64.h b/drivers/ddr/altera/sdram_soc64.h
index 183b1a33080..2ed31b99b29 100644
--- a/drivers/ddr/altera/sdram_soc64.h
+++ b/drivers/ddr/altera/sdram_soc64.h
@@ -64,7 +64,7 @@ struct altera_sdram_plat {
 #define DDR_HMC_INTMODE_INTMODE_SET_MSK		BIT(0)
 #define DDR_HMC_RSTHANDSHAKE_MASK		0x0000000f
 #define DDR_HMC_CORE2SEQ_INT_REQ		0xF
-#define DDR_HMC_SEQ2CORE_INT_RESP_MASK		BIT(3)
+#define DDR_HMC_SEQ2CORE_INT_REQ_ACK_MASK	GENMASK(2, 0)
 #define DDR_HMC_HPSINTFCSEL_ENABLE_MASK		0x001f1f1f
 
 #define	DDR_HMC_ERRINTEN_INTMASK				\
-- 
2.35.3

