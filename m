Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5FEE63CBE
	for <u-boot@archiver.kernel.org>; Sun, 25 Jan 2026 20:24:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE9D983D8B;
	Sun, 25 Jan 2026 21:24:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="XrpAd0j9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3253983D07; Sun, 25 Jan 2026 21:24:03 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E942983D0F
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 21:24:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oONv5i2pug4ngTOUiObVAkNrpnsuMHbvZmdjy3P57Yh8DO8VH9ZGjpCrm/SD8fVTI41reoi9N/9Swu4WdFWoBcZddxkck99Yn0UHJZPZd2iScUdrkde++1nvKPz1qL/SrXtLxR1BNjDLOwq+xhSidbBUd+lN4Kb8QkTD4KqSKOEvi5lRFNQyYFcXZOKh3Jz9pDs3L0bnrAWOSzwszcLM+uHgtTs2zccLLg24bOrdfmWDDnRLG+6c/jdLhE/OzHS5+YBbpadB0fYeiSXdEkIxfz9sUAV8lX3/uKFtnh0DK2O6qjGshLJpDq1ohTgtN6Hu+Ve3rFFX+Qua5J0b2vOEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Bkp5c6DzNfIG9FOwV3xl1GB4+BCvMqIVy+7C4594lg=;
 b=b6nx+Y06ds5sw4fMk1hSHciSZJ5MOmJj2K/jPK/zkFEhfiiilHbgbaXSBm8a6Idyi4fkdAFBxVrxpULy8uMXBtdLOXSKNOAcTUY3cQTNF1OonAMy4cGbdRbsA1jhq/fXT8QyG/7q5voJA9Cs/HWOWP9fxwOwwSIkP36JTjEW/2obUQYQDNaqEgwIiYTg93arTZEdf5hTqH7/iD3j5id2N/i6SCpqL3KeSU849PkEQERmp8ddeFnT2Sm6UPApQqN6kqIQ/2ezKwxVWLP9XY/oYSjUCMsHtU4vbu0cK+Fm5NsKVYlLkm5u9hZKJcoxISnhuKw9kkpqtHUh9hn7r2F29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Bkp5c6DzNfIG9FOwV3xl1GB4+BCvMqIVy+7C4594lg=;
 b=XrpAd0j9/MHFrMD/zesY873f5tzrJFWtcBxsJyerN/KWLBreEnVVxkDTGCVE03XX28J2Qoc72JF8/im1KI1T5F49wJgJGckJLpxTREPG0p+ln5eOWG2W6yVElBVEul/FemjnF2w7cw1xQ8V2EzbJ6kOoPY0xkWfgV6bFAf/gwa973cvh40sz4VYiCCjwOpRnsWDqKdLLyjAuOfq95mDG9FPX/2J8DvAsoPA5iR0VdR7wOwCRqQzclzIdErhM3Rx+Poa+kzjomMnWi9zlewzZ+PXXEI8fd79iH/C4oNUGwK6CKnhlRKtH1/cz70zsLHIb9kYenD3nhDLGq0iaEZmJsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5794.namprd03.prod.outlook.com (2603:10b6:303:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Sun, 25 Jan
 2026 20:23:54 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%5]) with mapi id 15.20.9542.010; Sun, 25 Jan 2026
 20:23:54 +0000
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
To: u-boot@lists.denx.de
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 marex@denx.de, tien.fong.chee@altera.com, tanmay.kathpalia@altera.com
Subject: [PATCH v1 1/3] arm: dts: agilex5: Fix DT property naming convention
Date: Sun, 25 Jan 2026 12:23:27 -0800
Message-Id: <20260125202329.12738-2-tanmay.kathpalia@altera.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
References: <20260125202329.12738-1-tanmay.kathpalia@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::18) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CO1PR03MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: e89b545b-c9df-4dce-0a43-08de5c4fa909
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nxir9RFa//rckoVS7zHal9TZeaDqqZ8xbEVv2ybidGk9adcnAUCEEtDM4lc3?=
 =?us-ascii?Q?P0tZNbj/4rW/RnpySxOTkr7FXPGasLZ0IwC3229/l/g9csLWw0ebExGbYYgv?=
 =?us-ascii?Q?RXET61civvb6Wp+6ztCIbxbJackeJjjn6x+YMm6ZaZijKOIGlB5v+msiU7qa?=
 =?us-ascii?Q?7NZ6JGvPt9NqgYlyfyhsliKJy9Y2zY52ryq5CWwteOy3pjFu6XPnIOySamSZ?=
 =?us-ascii?Q?K86TLeaQ2SJh0j689mq4lo/K0IUk0GfeNEdBQBbD0p5UEbxLDahTk1o6aTqa?=
 =?us-ascii?Q?tytqAp6KYUwHBeazQSGuRskGkXGQmDAZBx6qdTf5iJu3qHO12gqFfUE1jPkK?=
 =?us-ascii?Q?r4iSipqV1RkrUSvyuJM2NyjSaHi1Xp80dVLJZMRYeH5NYmyIhlL8TF3eG2Ad?=
 =?us-ascii?Q?7fXy98o/4oxEz3z4hCvFG+yy52BtQH/QeiTsF5LSjr1oTRa8WesAv5J3tbZ5?=
 =?us-ascii?Q?91SzrWBQo/yHpwgmiahCkdpV361CDfN1lRx7pU4JRjHXu95/URjH7dNwwzj6?=
 =?us-ascii?Q?L51+sQeryn+lKJ3nv6CIV9vsT5xiYA2v69zSSyaZDiL/vlEHOupCImw0nKUE?=
 =?us-ascii?Q?6kNj0YMubYKmIuz3l9qMNtKnKkk9znd36MeOl8KRMn0hm2t0fwaRoJ86E23d?=
 =?us-ascii?Q?iXA7bz10+WLO2Lk5gXIXwNv8I0Xcl0TP0O+y9uhmz87dKGEQ2q+uPcGbiDqt?=
 =?us-ascii?Q?RIAx8tjsaJTr7thyMzDp520060y40186m9DI4+2ci/Vu8knr7wzQLMvqbLVm?=
 =?us-ascii?Q?j2sejQiB7Y9XnnIpTekJ7fbLl8Kx4L4IptUtA8oseAYdb4w1ExcYUQvQAubV?=
 =?us-ascii?Q?kbv5zJNuJEn+7B+hZPNqIEozeFgJQCw6Q88mT/9xNI7jtcK+ys5jAZI2R17x?=
 =?us-ascii?Q?iRnTCvb92WghyngXtKk1Vab0e9gLMx0Kmq8hgre8eYCRWvZHw6t6B/6BjmmP?=
 =?us-ascii?Q?TxVxX3cE8/Alq1WDLcQwhbMV3l1d2VsoCwPdXAoH5TWUVpsMTlnNeKFfe20a?=
 =?us-ascii?Q?2dH+3qgqs1kmu91IqjUKTb9yLfgySwLWcpGb0rRaS55EVjN96HNaBKHKNC6J?=
 =?us-ascii?Q?YPG4FNoEgFKgP3mDBWeT9qhaDOCj0Qffve3ryaVd2HPmY+b+a2hQ8kXEhB53?=
 =?us-ascii?Q?QzuIBd+e++lE7CTr3PPPPcIchh0K9yRTPHFONIkHSoVu0IVGYcyejnWCducp?=
 =?us-ascii?Q?wupQCR1b8W1rwYdjo7JaB5qEhdxSVzXkdGNUCCpDEmO9HZ+2o7zhW7PALWGt?=
 =?us-ascii?Q?cnirUhJMqUvjFNpAaMoHxM3e7Wh1bCyTaCs5efexED2AcJ+4/M69kq8+C8hY?=
 =?us-ascii?Q?K9F4OMP1SZzi8Fk24VFiVRFVGSLHC9trZJNK7tTJ0fQXC/sbQq6CJPYS18Jd?=
 =?us-ascii?Q?zwfds2QwraVmQjLXLCw0gcHCN1F4v9HmqqFQQCdWwYl32/tu8RIlfuEFgQbx?=
 =?us-ascii?Q?7+c16pS3fYooSA+Xgkk5UctGMHezKBomKVJgEiBR7ncr37jxGmRb/7tqXu5M?=
 =?us-ascii?Q?DmPNzLhRkCSAy3+O3G2suxl45lqIZALfImJf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pEd6y1sYva4i5b9G7TkaqkroOf7PPeF55vurnnPMKFafkfgzda79lKZyQqkl?=
 =?us-ascii?Q?kD2NeXH+a6+NRN4Lo6fkIAvdl6oiZXNVkAQJMBiaTYDcL6CuG2Sq3ufHVl5l?=
 =?us-ascii?Q?1ymd3zb7VoBz8PQB+lkQ3vUF7GifE02RPWokTARQEuk6E5ND5B4rL/bFEkWw?=
 =?us-ascii?Q?PSIObnjZswrBlGQfQWi+5Jf7nhIyf23npcWhcpcSnsaxpzoUUcisXqt9dO1J?=
 =?us-ascii?Q?LIhOWxomgM6NZ8Ph0UTsiyZOejcyzQVG/0Jj+e7z4NbiFgjoUpZN00aYNG5c?=
 =?us-ascii?Q?Zx4eJwX+nYZXJRVlZ/z1l0fl9xta/8+RxfUAyeiY+Tg90Cn8iOV83tCHTl4v?=
 =?us-ascii?Q?sRbT9DxH5BY9yZlJFzuXpBPqkp0ip2eGyKnu41B23Y/MgKjumETvPUrZ5wDR?=
 =?us-ascii?Q?F29XcsBPVCTkC99xzVFdv2mNnwMD9zItAcqUR2YgyMJVc2nKXoPYuIcF2TL7?=
 =?us-ascii?Q?ZuZi3e/S/0rM9hc1Cy+AK8bO1uZIfLW0ke69cyPOgfo9ARB6pqe29uE1+v1q?=
 =?us-ascii?Q?V9XU41UgNV6GzWYtXxdlFiGy0XkXfzmR2NC3bsIWoXMLQ6J6eVPhqs4IKzP3?=
 =?us-ascii?Q?XhlSMkqUxEcNyUpYIJhkWoGpL3tQpeeB9e3Q2FbOwHB4fQRULoxagdK/clV2?=
 =?us-ascii?Q?invBYW12D7gladoMQlwu3rTm0HwQyUINr7m2Jb+TrDVSjcZADI89f5gJjmwh?=
 =?us-ascii?Q?MZU9YQw/GILJGl226Tafizg252hI7PWoXftpkSM1Ykp/eq04fVpSPxck5gVc?=
 =?us-ascii?Q?602mID2a/fWPNjfQB318Z3uujO5SwgOLmRIm+gn9wxS9SzDo5AoeMIlH9UDb?=
 =?us-ascii?Q?jCRYwBJOLh2VX027Rsr34w+ADfWOdPGibvWwvyyDuwax5ZrnzqOJ6bMw+zoo?=
 =?us-ascii?Q?sYfwSvm1q7EZ8GgoVcL7qwxbJwnV2/+A1pcxKCiVyEl9dI2qGljUa8PperiV?=
 =?us-ascii?Q?z9TUc62mk1N+qpFrxnBefuz9ZBFjVFBbbw0qlmfuxidKgvb3rd3LQqVg4mvs?=
 =?us-ascii?Q?xxLs3mAeo/RlQdOw3+P2qXUC9W3LtwTS2z+5Qj5yACrxVGJ+6ZYjdaTy8gEd?=
 =?us-ascii?Q?YZwJpxiYEZ4w/ssUEzKGuynU2XE6ANRlOVVyd3BbEH9u5/+iwuRrl4qcpVub?=
 =?us-ascii?Q?N7X2IdOtZ4/i58oAsdDAGRIcsBP0SvUnv1JLv7aXPIv4qD8yBRE5ntrnm9Uu?=
 =?us-ascii?Q?vgNkbzJBUySRQ2k+5iGjnJAMuPauL4/QcPx6956LM2owkAEr/x42yN+fiYB6?=
 =?us-ascii?Q?wJyK9aIrz1FSgT2U21C+9M6FRYiHSElU+ks4BLhOfg3ZLl17DiAK7fb9f2DK?=
 =?us-ascii?Q?ekzHU1y3oCi9kvXIIBfNFmeaB5yJGF9Jqh/Jpaitxrv/gc2GVLeCZimzjQxA?=
 =?us-ascii?Q?IvW4dONZ9AELfEfVnom/7+1IRormAOTMwXA45xnjK+Tp+Ul2trPKEqAW2PIx?=
 =?us-ascii?Q?5Wj6ATCE73CLrwE1uKqexBUZoGsfXsh/RLMLCC5bgNwikbbV+x02vL4AnYJ/?=
 =?us-ascii?Q?3YgNPifjZz1HvbojgQseGSn5a0n0bjKvQJHl7cvdSIoir+CluhWgfoDC5Q3k?=
 =?us-ascii?Q?fov+4m1aCY/KT89FPtZrSn6TSp2x2qR4CjZyMhAf0PWD05RPT7cUpe8XZB3C?=
 =?us-ascii?Q?/8C2iWH/t13uTFpkNDd+Lr2A4av7vh418S5dsWktxpHGOkKDQyB909Bog8ve?=
 =?us-ascii?Q?JTBXWbys9TXcfM6wBorqKzuXRicved9HCP0tXSFV2vTiLwRVg9kaY/CqA8H8?=
 =?us-ascii?Q?DK9P2AW+VVFUwaw9DZrL1osrVv7jlB8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e89b545b-c9df-4dce-0a43-08de5c4fa909
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2026 20:23:54.6251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qhTKqeYGxqf+eROkqyH1EajTPEp7B3fNalKKvCj1qCrvsOJv6JAl+eTH9eMwLstTWkhinzp/RheZ+9rl3Auq//MP5NTEf2E6mk1+OvscB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5794
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

Replace underscores with hyphens in the PHY timing configuration
property names to follow standard devicetree naming conventions:
- phy-gate-lpbk_ctrl-delay-sd-ds -> phy-gate-lpbk-ctrl-delay-sd-ds
- phy-gate-lpbk_ctrl-delay-sd-hs -> phy-gate-lpbk-ctrl-delay-sd-hs

Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 5a7aa5841e3..417575fa0f0 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -3,7 +3,7 @@
  * U-Boot additions
  *
  * Copyright (C) 2024 Intel Corporation <www.intel.com>
- * Copyright (C) 2025 Altera Corporation <www.altera.com>
+ * Copyright (C) 2025-2026 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_agilex5-u-boot.dtsi"
@@ -119,13 +119,13 @@
 
 	/* SD card default speed (DS) and UHS-I SDR12 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-ds = <0x00780000>;
-	cdns,phy-gate-lpbk_ctrl-delay-sd-ds = <0x81a40040>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-ds = <0x81a40040>;
 	cdns,phy-dll-slave-ctrl-sd-ds = <0x00a000fe>;
 	cdns,phy-dq-timing-delay-sd-ds = <0x28000001>;
 
 	/* SD card high speed and UHS-I SDR25 mode timing configuration */
 	cdns,phy-dqs-timing-delay-sd-hs = <0x780001>;
-	cdns,phy-gate-lpbk_ctrl-delay-sd-hs = <0x81a40040>;
+	cdns,phy-gate-lpbk-ctrl-delay-sd-hs = <0x81a40040>;
 	cdns,phy-dq-timing-delay-sd-hs = <0x10000001>;
 	cdns,ctrl-hrs16-slave-ctrl-sd-hs = <0x101>;
 	cdns,ctrl-hrs07-timing-delay-sd-hs = <0xA0001>;
-- 
2.43.7

