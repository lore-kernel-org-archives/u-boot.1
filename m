Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BE4FA0C26
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 04:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C247841D6;
	Wed, 15 Apr 2026 06:10:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NfWSfLD4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 179CF83E36; Wed, 15 Apr 2026 04:03:13 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E305380086
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 04:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tze.yee.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgJDoMdrmNoR9AhmoVBGZvc/FAvn82x6XoLdtrDGQJJmVNunqJ0nrn4SxuTUE6XGuLhF+/JKVFbL7iWiCi+MnLlHroEXasFiGTlWDV2+b3eghFpPH2MjDzKB7KpuPiUCIbavzIJHZfcNsAJaURH35lRbAx6Jy61gpzMffVQA1BD97NmlUOdQ88kmPeOZyT1jZ3LOCLtvRkh1E5Pk8fILesMiX0uV5JWqVXymZcgJ1bfYg0RIPMvmoFhfw0EQJicSE/yb7ziSVarSEC1xIXEALsZkPH5c2SZRTiPEkUHP8IA7MJUKH4cCtcbaaXglk9kghBXnkvS2szAPhpyOMSBbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8yBE3XhvZxdNE5l4LBdE/7n5Xs6XYqbQqrbwkgmH0w=;
 b=kf/1AQYRnL7Op2Ae/8pJN4chY34K0Fh66NF+YHJeOLZtsSDsem9gNyi1QPf8WFb/+K77o3td0Yb+XRHlbmnjQpJRsHMdijkM2+hgRudpZq/5pbLOmwk8D2J2VMHpXpsl+P3EmqwR5lh/DgwWh9mkTEZuwP4K7asXwCYGwxoqUpgHk7woSIj5gUHuojmyDFUa1lSJl1KC6XjtrcMAvXqb+DidDxt9r346dA8S8ge2ZgpUZp5jPDiZr14K7pSq7/ZjP6GZr8BWH0sudkBWMEUhllCzAJfJAo1KXsITprAn3B5XvRjxBVr1gK9cQ7BSd3RH4+ks8+v7BrjnRLyV/g0eZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8yBE3XhvZxdNE5l4LBdE/7n5Xs6XYqbQqrbwkgmH0w=;
 b=NfWSfLD4qYKX732T9sNsxlgfZkC/uqm92aviI23xBzNpg+IYpG0QF3q3i1rThnzHp6ehyp2u2ug0ugfLAJgjOrMLpsRgQwfpXoMg9EgiCxdaQtiaOCg3OS9D6/2HTWjMziiGnSBEm5HR/oRR+414mo9AWKWFk5laJYxunDI7WqzYadRD+bF9/zzJXsjyuC7WW40bdFSciIJP74enKrodz9HZ/1gKKhFiMljhZl/SNHcpdyir2eit3il9QMtm494ZVdDrlXgRFbyQCKf+2nTMJOKDvQ1FdPpjK7/1LaH271h8Gbh61PlInZtLBBrbUaMovff97xeD0yAddK23MoYPCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by IA3PR03MB7596.namprd03.prod.outlook.com (2603:10b6:208:508::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 02:03:07 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%4]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 02:03:07 +0000
From: tze.yee.ng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 0/2] arm: dts: socfpga: agilex5: Improve MMC/SD device tree
 organization
Date: Tue, 14 Apr 2026 19:03:04 -0700
Message-ID: <cover.1775640837.git.tzeyee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::28) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|IA3PR03MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb9281d-cc48-4c1a-2009-08de9a932335
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|55112099003; 
X-Microsoft-Antispam-Message-Info: AK/kCziaoLQ5TPdL0/08v5W99vij4LXS47Wj42z7MoI3h3pfgxV7stDoABxoByvsTwJ3keIy2TpaLUeGwOym5dRWcySivxGOC0LrIdA1opE3e2CGEr1A7mUNgfiGxZnF8EBlRjs+7a/fhdSlL5d8/X+nsVkFf8l6r4R8w8JRk5Aeu3Y1lVli7klujhjUEyuMcWMB7N6QL463avzraX+H2dmglhS4nMXM+RRDANnTumeK43RjwHTsEyZeS9zu5xSLhdeUvWp03bneacsCVPbj9dvKkDNLXwrroxlAOtRLdFJG/0qDEKPLhHpmCMDVmXr1MpBoFWenGVXYy6FnxI9/GP7p87VNF35GqFq4He286psghlxXdX2BuwjuJu1cCN/kn/1A0dhXXPzXA563KJljUG+KpvdjSEVeyeFct1nQOubQ5+DF6pSA3MEdZqvmSt3vmAkVs8BBPKnku3wcUpHuxhfa4iFPXRydLkQ6EJwYc4GfU8nMzNg3cVFQ58sd6m4yVkXtFzJ56qw4oHxAGHEY68RpD6tQNPchKbtiGn8JYSFq6B1wDLIwswsAAkUAxHE0Swd6F3S9m8qFKW5wbsc7B4QA60IgOKXx3wN1pqixIghH74QTvG2v0IBv5nwt0IGS34IBKGc5C5CrCqvah1HiUYlpV+WOhk1dgX6PCSryYPyC9pnOrevNMCTkYBJQIjZ3XnVw44PymhFeX5+Xipi1aQNgFRRq0L6rjEV4Ts0/o9Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHb4r/bThsabBsea+VI0KHpNBRapY91f8jJK7Pe0HIysfcKj9qJ6luk81bPd?=
 =?us-ascii?Q?gA0Ge+ZiTz1+vpcqdy5aESnr2tFsxxMsb9cBHBZTdcQNV/B6KOo+LOKT3KMs?=
 =?us-ascii?Q?KYsJ+zOHcfm5PeqtBf9LXU1clzYCHshA5MjsEsAHFuU8oK7NRgiefWt7KGFv?=
 =?us-ascii?Q?cnr+I3BgthArbH7A4YISHXqd78Ri+BLxxs5XIEBlLPHtqmbcoPy96aXrTS1e?=
 =?us-ascii?Q?C7qp3qdwUH+ZCjr/Wj0B+HUVw+oo/LDkRA18hAJmlWx2/HDJ8Tbp/lI7bkEj?=
 =?us-ascii?Q?hVq73SkW2/UIAyR2lafQlAYKpVM0KEO4rKb5GK/+A/gf0GxcnnGlgMiolv55?=
 =?us-ascii?Q?6bMG0pgEiRBHKHRIrjAdus3muVxr+JMq0HnLEJU2u0Olbp9SG+dWfuN0HxhX?=
 =?us-ascii?Q?w27C8DcmDgZmouqEc+X/IBSIs8R3L5VmTIIYLva8mVs/i/1/B4VVbZgt0Ypr?=
 =?us-ascii?Q?ICJaeEsfMMXtT7M4p95q4OLhXtm6Loczquyo8A+7Be05nkdqgsgtQwj0FBAv?=
 =?us-ascii?Q?vMbU95QjLnZRZj0Pk4/8TEAldhD2pB2ut6mH0WoS2PES2fBSuaaQJ5ubFNK0?=
 =?us-ascii?Q?9mIy87lB0OcH8Pzsq3BVpa6Kvejf5suIsK/0h68fQX30CbQPlX6pktwwanUU?=
 =?us-ascii?Q?WPLpE55GvGkiTlFcz1P6p24eJmLGcHBYB0M9ldZPoc7BWAb1tyQLNEmP/rZB?=
 =?us-ascii?Q?Q8BUNGsUrzdnowIBgKCFu2o0fNO3NMDmbNDmihPiqR0fU6Sn8uM+t0Eg4R0P?=
 =?us-ascii?Q?3jJUgsaOrOSzLtWOvqP1h7NhJzwEPHDNxZS0iKIvS28zuXGZyRmW0kplGRN/?=
 =?us-ascii?Q?ojAWh3rC4LrGgYM9JaMJJSjJyqJGKKZhvXB/E2IBMzZKHPCBIr3XJHEfB0kx?=
 =?us-ascii?Q?Va9gKkzqxGNoS0fJyTo1x9cppocQ04poQyRK5ijKKJ2ei8nZ70OtuS8Esb4C?=
 =?us-ascii?Q?Kmgw8xOUbIBBN/V1/v2Dp0zeG0Xc88P9yjq6GHredLb/6ANPWItMPrkTc4c1?=
 =?us-ascii?Q?coLL9nLuDFKTyi+0BG9H1TJQQtNEQKWehaX3zmOSnYhx/EDYGDa6Si2UPJpu?=
 =?us-ascii?Q?LFlv3Wx4aSufpFtPnZRTBYwpubsljMcKwcGD9tU/g8bD4OPxkAaKYPlnEVPf?=
 =?us-ascii?Q?Jk7dy/6jjBWk4oBkHkeqppLw+nws2LxDRx8UA95DuwbEbHu/QMG7uwrznXRH?=
 =?us-ascii?Q?Tzuq1NFePHqX06GxKfxmSC/U7E7fdTeYP25H2Dbhyx2fE0ofrA1uYYxGL1Ic?=
 =?us-ascii?Q?JwBFXhwQF0VjvRpLfetZ2icZcjMKOyvf5YZ/kz6SrLleRrIeeS/liBB4L520?=
 =?us-ascii?Q?b+KOuq3Lz0kZoPK++5XGvsI9Lm5LVMJfSitqsI2UesQh4EAEHYrYBeBG3fRh?=
 =?us-ascii?Q?ZXMevwsxWmWTQWXdxCWJaumNk+Nnvnb/1TS0F/6IsTAnjlC3gRhmWJgjv4AU?=
 =?us-ascii?Q?Nl9K2bhYKVk8JPnHkGnJ8/5w2VDgGWm47wYBV3Om/XfvMIdM/CNBYdIXDDWn?=
 =?us-ascii?Q?52fnN2jXIqV59M0bhRohXrbrtw7coz5ple6jKNDxoODhLfYuz838Wp0+cYcw?=
 =?us-ascii?Q?nHmvuZbZXcbdWQ9Bw61PXSZvxhrv7pc5xHnCXf4Y3d3DkYRan/+eFoVBCeYA?=
 =?us-ascii?Q?OkYNQTq+sipeH2ZpEPuWQgk2wp/1hd2eZHtDQsfQ5eV0dNIJM/+H381oMZPB?=
 =?us-ascii?Q?ynPvWjf6YP/k4UuHPEcYmsTwTjxsVb9y5N2KXxQMwcVlG7PCDSKmmGCyDfqO?=
 =?us-ascii?Q?PRLjp0wZmA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb9281d-cc48-4c1a-2009-08de9a932335
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 02:03:07.7318 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIZlSCrPFmAcES6chqUYIb51vbIYCx2njIhwNhjMNWIayQt6nrbIu7TUtYh1duF1wDM2YV/YSSS+nbKRXCj52Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR03MB7596
X-Mailman-Approved-At: Wed, 15 Apr 2026 06:10:44 +0200
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

From: tzeyeeng <tzeyee.ng@altera.com>

This patch series refactors the MMC/SD device tree configuration for
Agilex5 SOCDK to improve maintainability and correctness.

The first patch reorganizes the configuration by moving board-specific
MMC properties from the common u-boot.dtsi to the board-specific dts
file, keeping only truly common configurations in the shared dtsi.

The second patch addresses a configuration issue where the eMMC device
tree was incorrectly inheriting SD card-specific properties. It removes
the SD UHS speed mode properties (sd-uhs-sdr50, sd-uhs-sdr104) that are
not applicable to eMMC and properly configures the capabilities mask to
enable 8-bit embedded device support.

tzeyeeng (2):
  arm: dts: socfpga: agilex5: Move mmc node differs from base board dtsi
    to dts
  arm: dts: socfpga: Remove SD card properties from Agilex5 eMMC device
    tree

 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi | 1 -
 arch/arm/dts/socfpga_agilex5_socdk.dts         | 6 ++++++
 arch/arm/dts/socfpga_agilex5_socdk_emmc.dts    | 4 +++-
 3 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.43.7

