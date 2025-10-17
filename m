Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871D6CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 14:38:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0544583837;
	Fri, 17 Oct 2025 16:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="ZF7eFiaA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32B7683700; Fri, 17 Oct 2025 16:38:12 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49C64837E4
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 16:38:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=2385461c55=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HDDOuM030691;
 Fri, 17 Oct 2025 16:38:08 +0200
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013035.outbound.protection.outlook.com [52.101.72.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49u0ap6pbs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 16:38:07 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGd0Mj+7F5vxMylgOILtk+LgJwMTC7xscxr6Opv+OeyffYS47Tx6gOdFKg63fxyXsSBXKoyNfbvExJMRHH+gTDZZ4y8uvKYcqrYCT/fvnH8rXuLsdHd2vxmPi6wzVYqalwqYeaFFNZx3JI0mHx/EqqlwOrW+ZHKTy8ju6q4OOFWo2qaUfPjNy6poIMYOVDvJ3+BTYV0x/QjOXOrtFcixEnMIKudHFphBV81TPw+t9Kgs3viM+qeHcs306tsx1g5Z0aeeCTqT2kAPQV2z6Xv13jY24t6dlrY9WxxfO87kcJkgw8WYbzWfv6ylVYQy4t3w6/xv0xHc1ad3MnpGvpt+oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCCWultZJiv5mlhiTg+kgarBK2EdXH89TUS3NglILYQ=;
 b=ygiDoRDd+EgzZzIVquG9sLsGpQWkRf1nSZ8RhwKe9kV9UcNU7CJNMJnOPXgTqpp2YJQFhoN9sLP4T34f7MblZ5MAMJBJdU1JKbD9N1/Q91HS/UH23V4AnpWr6QG5QNpYJvOmtWC7IWDuN61JPZRV7oPb2/XLCeNs+lS9vfvSkHRhDViuReHKvHeavKDRl27uTmVb9Lm/VALzmGWJnAwZS8ih1vZUCVmshwW5B7pflhHXB/LoLgTqzFoqiaJkA0E6+Is4eQGv9wIvj5n4XJu11Pon8Va9mrq1MIfy5wLZDUmoOQA8glgmpqdSgCzZY3o3avHB8RTVvD9h/IYc4dkLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.40) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCCWultZJiv5mlhiTg+kgarBK2EdXH89TUS3NglILYQ=;
 b=ZF7eFiaA2P1wuN++hwXbH/i8/HJI/J3dL9m5G/xJwGk53L2uNqbNYp0GDf1vmhi/Dfu4sIadXxntsI4Mq3wEXqZAZFaEL9sZa/UfBJehecJ+NK69efwLFO0WxYyuZOg15mcfNM3W5saEXBz53XtEaK71h8DiT4L6xDsExTSdopOpoQ4TqQ2kphSsY5IY7wMN89On707ij9FQFy95uOKoJKZGVE8GOPKoCt8ErePKf/Z4E0ROyT9ZCR8MuOjkpPwRSkCtaZtCPMDOCTos9xZrHFs9Vqkvi/bLrCuskIK1+OEJmBorJN1e0zYPlh5otfka+CH7wY3DaVZhdQlqRBuOiA==
Received: from DB9PR06CA0003.eurprd06.prod.outlook.com (2603:10a6:10:1db::8)
 by AM0PR10MB3700.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 14:38:06 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::b8) by DB9PR06CA0003.outlook.office365.com
 (2603:10a6:10:1db::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 14:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.40)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.40 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.40; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.40) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 14:38:05 +0000
Received: from EQNDAG1NODE4.st.com (10.75.129.133) by smtpO365.st.com
 (10.250.44.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 17 Oct
 2025 16:38:09 +0200
Received: from localhost (10.252.15.38) by EQNDAG1NODE4.st.com (10.75.129.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 17 Oct
 2025 16:37:59 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/5] stm32mp2: Update led management for stm32mp2 boards
Date: Fri, 17 Oct 2025 16:37:44 +0200
Message-ID: <20251017143757.202571-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.15.38]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To EQNDAG1NODE4.st.com
 (10.75.129.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|AM0PR10MB3700:EE_
X-MS-Office365-Filtering-Correlation-Id: e0eac8d6-5d24-4839-6e7b-08de0d8ac8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q5hs9iO4JmUG1buETG5UIwJzYF3fNriIV5bFlfmDr1SaHUr+5Ta/u7dFr31L?=
 =?us-ascii?Q?bM8XhPNP9c0GBUsSUUvpalQqVWqkKTarXdXUkgQJvn+HqBlv4TpyeJJ0p19F?=
 =?us-ascii?Q?oNQmEWNOr4Gj5+bnOWqQT8wHsy3gXvth6pCzT/DlajTCuwBp8myRomXSNmm8?=
 =?us-ascii?Q?sUN4b6XMw8u8YGKB94tpemQzyVVs7sS0DPzTL07hpFrKUPqLuezoCAHuXjBQ?=
 =?us-ascii?Q?tbcQY6SVVRIpcckCrVCoehm6iJfhHbd86RITFP4qpYTfn+l9ikzR6KreMnJD?=
 =?us-ascii?Q?bHZJKEGPGzcnQYjxBfzuzzyixrq0MpjjcrrjjM15F7rWpIZJnqetP4m5WDj3?=
 =?us-ascii?Q?XcTBDwHO1oQeYyb5F+rrOhjmCyeY2WQWL9njupRFTg3pTn6IBZPGs/hugrYh?=
 =?us-ascii?Q?uCqoVXf+E6jG/hhiRcttuO2Ss/gZTxaZbimXDFwoT8hNtl1xBWtQ1A0mqXuv?=
 =?us-ascii?Q?AITRxpt55L4gZfR/Jr2SG0u1/yYEqE6XVadfkHngXRVwK+HuGr4kk18r+lx4?=
 =?us-ascii?Q?zpY2wrEbsNbT/onHvdiBEVr2Q+pcoR7Vj/3VZLe8pXpWkc6z8+p8joleC8dm?=
 =?us-ascii?Q?iXWwAckyw8+7+J61PowiZWWCoz6vQI1g7tRV7ZMFKpkaYDu+9IZCF0Y5M/Cz?=
 =?us-ascii?Q?013VlNHEpyXPLE1yqcORgCW54l/CBpR1Qd/Byk42Afm2vaizbnbvHICtN207?=
 =?us-ascii?Q?T73UbR1MaKdUWZcnllCOd1s2Tsrn/PKwxlSqM7e3ucso9v91UDR47IxG6Baq?=
 =?us-ascii?Q?c56m/kvI4o5+RppPFZE+kBlvrwwtXsbRwX0RdASMibHR2fyc6h27hE/KbsVD?=
 =?us-ascii?Q?/hlV1cw48941DCyI2zTX3r2Y5CdPYeLpIAKUrrLmF6JJ8t+BVLtVzrsQNXVU?=
 =?us-ascii?Q?iF7vq6xqoKW+osh/gpLAre6KQt9OFIR/5k5VaF//s6jGi3xBQyjBKoiKiiO8?=
 =?us-ascii?Q?tdIAL+GXfFOceBgZb9lXUIAnxY+pQEzWuj7R5zSQfj0g0CtqDC81Wgr6F813?=
 =?us-ascii?Q?3pf+exSrNncfTNSh2BNblh4cdODBAV01cWoYslu3VgfU0zvNq1LRmSiXeSZQ?=
 =?us-ascii?Q?3aiWzjyNHvmE3pB/iUZC2mFPQc69UB7P99AYAyFpCw/utQ3LQijJpt6xRuL8?=
 =?us-ascii?Q?HdzDsCI8H+5LdiUD1As2rSRerM6HI4g0n2AVKBJzMYsEOo8lEjJYmIby5OiE?=
 =?us-ascii?Q?LNQWLlSOR7kRoYbXccQyEIDzXOndm5MUlEfD3Ek5aCQwoub8rISFjdQUNKnB?=
 =?us-ascii?Q?0W4mD/fVe4VcUOXvPPp3HFv903DoRSaLzLIXVNU5xXe6F29UnJ6B37x76irF?=
 =?us-ascii?Q?Wlc4xwAZsR32KdT+WjD01aBTWnm2FGzzA8vHXwkYAJ0TzmNo1uw7E0XHlBdC?=
 =?us-ascii?Q?VLEOe6hbG/WXXRpScZWskxLYpd+aYaGogzG0UdmoAzhuAfeupGBKT6BWwp8W?=
 =?us-ascii?Q?RqsB2hqpksdq32QzD69WgNJc9X1EJLrrsjMTHzgDAky4w2nG10t2BEMTKXig?=
 =?us-ascii?Q?8WHPiTOVRxQUO4/FD1bZJg/bvPoMdGfeFHw5LsBoCuPFmhMi5yFZ5+oepoiU?=
 =?us-ascii?Q?kV7q59arQxXtkP20LOg=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.40; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:38:05.8557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0eac8d6-5d24-4839-6e7b-08de0d8ac8da
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.40];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3700
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDA5MCBTYWx0ZWRfX/aTTtZJcZhpQ
 5IFVDSlDj9a/EXQUbFK2GwCS+ln+CyEfIfoiekE+oi4hv36T74r2j5Q8/JxaFgmIw9NS8w2pYsS
 HJwPO6ooeoNita9HGStYTCft21/pg64jIB5Q4R9zEsycb5t+Yvc6Vkpms3cnwsk/IRSUCxRuyx8
 OOSZqcjTgROt/u2RAIaSz3BxVpuzDAq38bqD+JL6IB/jiHQ/SbaDWaznJHqhcui5bgkeE+IY8MG
 tJh4X9Z5iP3+MOoNWfJiSCbOuR4UxRLW1pv5QgEEO20UB53P3d/mmRjCijq7qstKFWbEAihj3pm
 Oti0QP5BPEC78y8+X6QWL63XBkKDLgj4GZjaAU3L6p2fWPLxGUzWDUB1HjaS/yaNqO3EYEh1Qzs
 m+9wMtAGR0eZVk9KKyGhF8rFyLd2Ww==
X-Proofpoint-ORIG-GUID: rGor-CPBWoX-c3nvNVsNjZlq31djBAqE
X-Proofpoint-GUID: rGor-CPBWoX-c3nvNVsNjZlq31djBAqE
X-Authority-Analysis: v=2.4 cv=eoPSD4pX c=1 sm=1 tr=0 ts=68f254cf cx=c_pps
 a=sGfeb9PwuAfiW5dbaiAd6A==:117 a=HHWmdgNZ66UcX3Fjl3KRHg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=gt-GhcMM7esA:10 a=x6icFKpwvdMA:10
 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IxEUy3TYSAyVMWOT_lEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160090
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

  - Update LED management for stm32mp2 boards.
  - Enable LED_BOOT flag in stm32mp23/25_defcofnig files.
  - Remove legacy "u-boot,boot-led" property in stm32mp2 DT's boards.

Patrice Chotard (5):
  ARM: dts: Remove u-boot,boot-led from stm32mp257f-ev1-u-boot
  ARM: dts: Remove u-boot,boot-led from stm32mp235f-dk-u-boot
  board: st: Update LED management for stm32mp2
  configs: stm32mp2: Enable LED_BOOT for stm32mp25_defconfig
  configs: stm32mp2: Enable LED_BOOT for stm32mp23_defconfig

 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi  |  1 -
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi |  1 -
 board/st/stm32mp2/stm32mp2.c             | 38 +-----------------------
 configs/stm32mp23_defconfig              |  1 +
 configs/stm32mp25_defconfig              |  1 +
 5 files changed, 3 insertions(+), 39 deletions(-)

-- 
2.43.0

base-commit: f6b80515465bf054eca80f90b383b2e13f979055
branch: upstream_remove_obsolete_LED_property_from_stm32mp2_boards
