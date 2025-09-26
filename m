Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF802CAC5B9
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 12:24:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CCFD830CA;
	Fri, 26 Sep 2025 14:24:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NMEO0aw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2F6F83192; Fri, 26 Sep 2025 14:24:46 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8409082998
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 14:24:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKfW6Fm5KjXElajmKd36y05l9uOXqBOkPVuic62He0MkOIOMsSfhyO9/sgUiZ/TEWedNFz+Bjz0ShqRjC39Ac26BAr7PDCgPiKaF2Cqj+vY5wCWVGEMuzSEtcBwJpheq+dru6skYT10x6zikl/yfLSxMI4kg7rrBshHP0Wyc/6tluA2Hb2wz9y4o3koB8ReRoTj8lCni7cmYeYyA4+PbMoB7XGUBXHBt105P5Lxqq50/UvFj50lreInGMzevfQN3QPBF4jglsaFdGI2ueh3jRQC9BY6D1c8i2RLyep9JjhsJoU6/0Yljncv2kLVZmSHsHBmqrMf6aCbi7uqBvgE2+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSWW9iz8cza7DqO+uch1ESSeEbO6MvRZgv6ZMXNDoSs=;
 b=cFZ9WbfMFMDd9JNoXq96laUf0mGTKdYs1nmS8Dofb3L3NP0PRzNxOfPRHiwitrJaY7uWTR9ReVO6LZPH6WbGrerj3KigHCLM90JBDqbVsLoT54c+uIx5K+HXcA8QXpc62IZAVxcpPL8SrqxpYGh1wg8AXD1bXBvgNB3PYXnr4y3C+pYR2XrV1hh+FM6OxR+oR13UFmKZ/vKyeRPc8WxU+Ji/mEqNpY+4mCQFOhWu6Nx5IzFC1YW4bQZjctOXXlblBGNaOXDbDhDQgVm4mPbxbBUbHBjMBj4ApFAW3z6g1D7UxcXsDawYhLJPZSy5e30yzGnQ4Phh84e/EIGOuulqkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSWW9iz8cza7DqO+uch1ESSeEbO6MvRZgv6ZMXNDoSs=;
 b=NMEO0aw2E+xHrxiP1T/NqFoPxcuSzMg9wY3WCwmKlRZVUJtOwFOt6qLRsfGT24tlO1Znas86GVcsOZO7MSxe38HFEfrletbtGDodb5Qt4H/YPtXbsc2+sa0k6P/lOVqWWpqSrVzzN28B+7Wpc36Qc4a9eD+zzE+HMnIehGoyNTigj5mkh89CzruLiOeBb8+yFzmdfJzEiVkGGcqXEiUP6PL2amsWzxFXZ24tw2sb/gPb1c6tyCXZwTgAiPDSw9HEx0CNuLSEYPMhYN87OSs73FhBwY1AlLVB1U6DElz4c/ZiV0PmySDO7ljIl1ITnb5OSV/y/OYtmnZCtn66wwhASA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AMDPR04MB11581.eurprd04.prod.outlook.com (2603:10a6:20b:71d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 12:24:43 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 12:24:43 +0000
From: Ye Li <ye.li@nxp.com>
To: u-boot@lists.denx.de,
	festevam@gmail.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: [PATCH] imx9: scmi: Add PCIE ECAM and outbound space to MMU
Date: Fri, 26 Sep 2025 20:24:18 +0800
Message-Id: <20250926122418.1429414-1-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::18) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AMDPR04MB11581:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ba50ee-3791-41f1-0ef9-08ddfcf7abcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|42112799006|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IWAExOjM1McN8OoFuUqtbjQncLET69hrojYpOsiaCNIy6cJuRnDh3fRi6xuw?=
 =?us-ascii?Q?9MZ80qNl69x9L0yfuMiLQQ5tRcjgf6tYHaks/NG/Nh1UMBee67hF4St1bIkh?=
 =?us-ascii?Q?agU1V+oHSuOJBvfh/n3pnXo9XamXgKk1nDw/66XROOY3cFfN2e6RfEelLyU6?=
 =?us-ascii?Q?GuuG57z/91CgFZDOdZO192T6/8eXBdx0XPGQv3kq0t6A1D/F5kfmqa5y4b8D?=
 =?us-ascii?Q?kBalOWpFTpjzOUQaGt57WZVTBaPeQa9X0g1r+7F8SGfXIOHSsm1cAcbHXTpi?=
 =?us-ascii?Q?2Cc3D6s6B9AqM3rG7X5vFOHVv40fVEHiYsej8FmB/V3pb6cGjkDSpHC2hqF2?=
 =?us-ascii?Q?fnsO8Znc5rcKvPSV/TDmjMihpUSLdzbwrlQw76P5GZc4jkI6AX8/rW+EhKVl?=
 =?us-ascii?Q?g8+7p6IPQNNVlM2FgG36Zq0QAmWoWGsqC4yxXEMGiEO0pWR6sFHT1IA1TAH8?=
 =?us-ascii?Q?YlgQz7v2xiv/ZXpaasaiVTWJ+a49T7T0HoSqTgJRBZrSeQup0MovQNNiAlgn?=
 =?us-ascii?Q?4jj/gDIK4lag+jFh6AYzHufQ8w0LEJhCYxxgTBLVV3eG/h5uKuH/cVaZVZUU?=
 =?us-ascii?Q?CkByZ0ed7af2TMXSz3MvztPxLcbFTv3UrZ+slq6OzAAuozBVZGkmAalR2YgI?=
 =?us-ascii?Q?nrm71vaGpxSZScRyd03yfI3I+fS/sWfSaGGyOQF4wP7g11+Qr5qWc/FM5Kta?=
 =?us-ascii?Q?MylHBDgx/NQUm8Q7VjRtbngP6E4skiw/9xmPt8UnmMqnQfvyR6nu+6BHE1Tc?=
 =?us-ascii?Q?dtAEMIWKHWqrIlzuK7XIbfq69n9FSLLWNVBTyvuGYSs/HrWDCF8uKv1suqIC?=
 =?us-ascii?Q?O9l7RiEcEqzmO19GHyrLyfR+yPG7lo3RtIDz3qgtpBKbNmWRoY25IsvTGvCu?=
 =?us-ascii?Q?mDSgn2+8auA9f2g0i6TFbjQ3gxzrWZs6BxuYJpgIqDF9AhcoBpnfpBCG443j?=
 =?us-ascii?Q?0YE04S89/s149XHMB2LnL1W5R4ugkuJzr6/F2NxJ3NWqx2oOPtSPeq6Qm2B2?=
 =?us-ascii?Q?R9ilT4LXendzhOgpm2JL1Qox+uDEMs8IdKeRr/HpUhkkU8rseEv+Hd53bwN3?=
 =?us-ascii?Q?ik6wYy7s+1LnZ4UD6KlMNVcqB7E97Ecdp5YHxnl8L67KDItB9j7LrcYYbR9s?=
 =?us-ascii?Q?girx5ERQ7WhoT0s0QdlmGvj0CVzjJUvdflkNQvrCMwcNgID883ai03wJdibq?=
 =?us-ascii?Q?JQxguoDAjTZFITxtXFkF+9U41u+ypwbGvh1XowClT+0ETK/KKBNRB1hkf1b7?=
 =?us-ascii?Q?CLa3OiIeAx3fhP8497A7LWh9tBz3A7dDeXI62sNMWKo5ZakoRukKD6470zAs?=
 =?us-ascii?Q?ScmscklirBOk5FLAmXJjCFZrFg9r9+jQdAMTF7N+EyO8rDlPhEv0g4t2Z/5q?=
 =?us-ascii?Q?9hfA9YzyECEdDlU3B1utS41pJyvMt6afMIuA0KyZoNqM5RN1Jd46krQejK2M?=
 =?us-ascii?Q?L+8wsU2VS3WR/vmHfMP1M+nXxn1TdGB5KWTiejjJD2rYbxJB/1vkfCOJRgnQ?=
 =?us-ascii?Q?PTa6o7FuMD7JgT9YTbtgpjgxMajwba/I/mn1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(42112799006)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uKAkyPxUMFVCQidS2yjzMAhbf6bkn5Lcifc3gURgW46gshEWu0nWjPmqFefw?=
 =?us-ascii?Q?6gQ9SvfrZka2GGRJiFF/RtJJVfwHvJK6okzxzATI9+WmlAXiNCklvJ1PKWpT?=
 =?us-ascii?Q?lUKcKbcuBaUzuTtmepdFYc83BXKAmveqHIMpetLpP0oWducGY94k9CZEyqKy?=
 =?us-ascii?Q?U4K6giWTvMv5n0slCuANbQTWqDfj1SKbfQf0zV0S1SsFPwh4BW+bHqgLNizO?=
 =?us-ascii?Q?zBT55n7GzAtXMIM4oVwNKEVrWhoDZJpABwpVNiMiYnSHGQ119l62/WGSifwv?=
 =?us-ascii?Q?mSazSzvRKBWMn7AzmJfshQcTYijOM0pOQElQWS79ugui+FfRv8JTbkIn9oQo?=
 =?us-ascii?Q?ti6vVq/yScaj1/MsHpOicJ8e1yfngUW9o1HA92HJ8/hmOvhlR1ruBSZIF1Ij?=
 =?us-ascii?Q?s7apf11dP7VE8fJ1Tu0WGsPdUkmHXPMi1u4xCpDPGuLfyozmy4XYvmYDEwQ6?=
 =?us-ascii?Q?KiFD55vbiXJXp41BSh9IWSE/7LUQUXGG8ThDpcM5wp2pQD6P7ukdYs8qpzkq?=
 =?us-ascii?Q?KLvhB85YTi7n2sAaOu6lj0Xl86sfefUWDKGpOlOLN0YFJDeP1TSJ4TCEQuuP?=
 =?us-ascii?Q?ws4AonAi2Qfvbzrw5CJ+7pV2kyqX6rmCIbQc9KuJribDjw9tUj6uv8g07h/p?=
 =?us-ascii?Q?NoC8Uu6KG7xMwvaQezpRVzG0TIDXqfUYg2AHWs3nJcBD396frMzzcAKimPim?=
 =?us-ascii?Q?ycRq1AAuG+PCc04B0FWYJjurJa13jRVSr5SkitV7nsIaYpwZzMfu2RsbCu9s?=
 =?us-ascii?Q?VWdKqQ0wzq/fij9XuGRwW8uPbwZFkwDFDDEUqW4Ww+Kb07EfD2uqnH0+R0cC?=
 =?us-ascii?Q?AxDZhVbKxR1WQh/lthebx91Awv35P248BbMtdEuW8YhcAZ9c6EwLTpQwNrg5?=
 =?us-ascii?Q?PJNBQWSlmpF1mXJh9IpjMM9G+TisdVXDO0T0vm3CIqAs314vsx5v+lj+OmAN?=
 =?us-ascii?Q?VGic0ujrpH+8mLIa5jOWRv1Uy8aTILDqZLgydbVPJce5t6LCrz4ahhFXNPU5?=
 =?us-ascii?Q?ZZ+PltAvyPVCUHvdMnKZf0ZjvP0kLz7OP2FWI3jdj6oBMnxTcira5h0bl7Ke?=
 =?us-ascii?Q?zAg+uwRo+hpdD0JNs/npU8Pc5vbBTdWO9mEN8VFcIEFrfCDTe+q+B76YjQKr?=
 =?us-ascii?Q?aKRJRkAAxWFRBvg9tYo/gOtwlg/L23lK2JgPWHeEKjH7PE7eoCxP6ZD1ehJK?=
 =?us-ascii?Q?ACnLHjJvnmbsOmnV81xrEDOT7UuSo4yEQJNpUVO8W7IPqDJfsaZrbb60F4mB?=
 =?us-ascii?Q?h/+gfitvyo5IOhjs3jm68NsnK9NIiQ3KIvbc/10+nzGIReBtACA9wsCrESOn?=
 =?us-ascii?Q?wd8scPCdAI8NgwKpVxKFwICWRb8ibXnhDsINvGhs0y8bTkg2bm4Eh0pATmvM?=
 =?us-ascii?Q?xMto1z48Af9tdSbyqPqkhmzeie2S5N7qImby1HtLIkDKFMd7u4hArmYwEVTT?=
 =?us-ascii?Q?vtGjJvpAIZaxhPn5XA6ECy2zjZEuIMPTqMjwa4vOrACUd6sMtWC+jSEocAXm?=
 =?us-ascii?Q?TWwiaUkOWX1Dbr9f97cVym4tuuVmR3mKLWP6SB7vvnVK6yiv8q8FojScGLTQ?=
 =?us-ascii?Q?cx0Iu2iRZsbAzCWt9NFw14I9FbmvfDzkxkC6ga0s?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ba50ee-3791-41f1-0ef9-08ddfcf7abcc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 12:24:43.0110 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUF0GgxS58ctZE+upKjGudG1rs60Q7nNQd49D4oyhnBsb+eA3kN4xkZ7zR1jkayM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11581
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

Add PCIE1 and PCIE2 ECAM space and outbound space to MMU pagetable,
so A55 can access them.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index f973652d0cb..aa4702f3b6f 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -254,6 +254,30 @@ static struct mm_region imx9_mem_map[] = {
 			 PTE_BLOCK_OUTER_SHARE
 	}, {
 #endif
+		/* PCIE2 ECAM */
+		.virt = 0x880000000UL,
+		.phys = 0x880000000UL,
+		.size = 0x10000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE1 Outbound */
+		.virt = 0x900000000UL,
+		.phys = 0x900000000UL,
+		.size = 0x100000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		/* PCIE2 Outbound */
+		.virt = 0xA00000000UL,
+		.phys = 0xA00000000UL,
+		.size = 0x100000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
 		/* empty entry to split table entry 5 if needed when TEEs are used */
 		0,
 	}, {
-- 
2.37.1

