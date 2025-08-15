Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC308CA0ED1
	for <u-boot@archiver.kernel.org>; Fri, 15 Aug 2025 03:40:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6E7B83A2D;
	Fri, 15 Aug 2025 05:40:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="mOnbBULr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBC983A43; Fri, 15 Aug 2025 05:40:47 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::603])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BAD683A28
 for <u-boot@lists.denx.de>; Fri, 15 Aug 2025 05:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOHk8zFPFgVpPa/+xPFw9sH4oJ8ZS3RAWYxWlupCAMSvbAEZ+hn5Km7z0vAd/rFdrcG9gjMglYWTJo9VQZMV44Mvo8hXTWIw7uKscF1jDmpl1TX/v4vHl8nnveAMrmoUmKLfV/nPDpNcCd+pacCwxmwvT78AoGJXRe8dGjoj1YDbZ53zQ5s5DoFnOugrO1dRmVPLjn+faSYAvwnrry3jY/zG9CvGxgQYByhv8E6xeBOxUbfhQI1jX6ihlJS4RdFStGqtDh7DHfxGB1T+QnEjm/rdVFaH2Ck+d3CTNtRMqmiwY2fps7q1bwaGVuRZkzSCUABsSyWDMBMBF0wvEYLN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+qD4m7JPvp3fSEY80AGzlQFpeFOY+nTQmfsrrQQWGw=;
 b=PCSSVwsCrhj5Oq74dODYKMYf5H4fZfPs5LeW0X4PCq8FmDEsJTCUMVfzVRkgE0YEk/tknfKDTef+spHSJXonYM9b6XfA25MOILXtQOaH/2EpUnmq6rRo5gmzI3ggaDNYb+1avjYZG5OvdT44GnX+wjCkYPxn/0CBlMn1oSdrkz97CDs4sECyInY9ndK05L7sPwanqEF1jFA01LVxvTnh5HfZ/JtgU6FfaBYHbBwP6OYNCltlqM4ztiyry+OKfMT/AKdjHsy3xPWkOQhAypVjTgMFIdt+GmZm65EaR4m2w1zvbPJCP9R5zfr/NHH47I88gzytJhKOH4caI/dnJtZFlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+qD4m7JPvp3fSEY80AGzlQFpeFOY+nTQmfsrrQQWGw=;
 b=mOnbBULrDdp/B7Jm0W8g2pi7RjHwTtd+r9+2UIwEogJpLs3z1p/+HhTBCasIvnfMEmWIMxtJBy37mMxGqrkinzgO4Ij0fVl0qq0D25UOPJl6KoOIOjS5ye4JJ7u8Eqdy8WDwOqda3aEqfB+yZMBsY+m2Lb/zpoIhfT+6vSq2m/oc6ad+C0hfA2u9PxHi2Ym8I6fce8XhfOdDMAsqL1PrV8LZhVu4KI8HK/TV64T/z+WzDpgHQ4XvJFsW3bKLauAC6rFuSfrffgNzCIZmLP5Cw1MAk/tSGJa0CDAvh6jmKrncQhHbMaPmSTG4C/MEvsy4hj6siKppW11S607FjY+OOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by MN6PR03MB7695.namprd03.prod.outlook.com (2603:10b6:208:4f4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Fri, 15 Aug
 2025 03:40:42 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:40:41 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1] configs: agilex5: Increase watchdog timeout
Date: Thu, 14 Aug 2025 20:40:22 -0700
Message-Id: <20250815034022.11243-1-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0058.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::33) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|MN6PR03MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 00615111-dbf1-4b86-a72f-08dddbad8221
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jhr9lPnJH9qAlXYy5evqBmzHWEo2HemFFsEJ8Rbq52uuobXZiHByt1A5exTP?=
 =?us-ascii?Q?2vAbVTckdIhVrmxz1OS+HYyWyZ+kZl6Gw0oyXNMCeOmuAtP3nrFmnv+Bp5Kc?=
 =?us-ascii?Q?wa+mMZ2Ng3xBUv484W+TRMn4GGt0rx2Mx/hVxi8g4jsDJCBpyLUpjJUPZ4eN?=
 =?us-ascii?Q?DUOE6hBOBiSPgK66fsQvy3FbXLitramAVjQOSmpZwD0ps1KsLxJHpLjfmRF1?=
 =?us-ascii?Q?UPviz5gzZZfOlQ5psAby7h9ZPlwxqFEzzbQBa9NZ1jsHoLg497F7znV9wqOh?=
 =?us-ascii?Q?CNOGgM/FanhBW5J8EBHxyeVWirzIBrm8RiRivDOJQL8gu6SXxx35J+ePf6Pr?=
 =?us-ascii?Q?3DZNdr2ywmoQK5PTDnB3v9ACFQycdlGhhrleuQSV+st/oDgBZwpUZ5ACc/1/?=
 =?us-ascii?Q?WqdnWO/3SMexO/rLgWteORZsFvdoHMbhrBFx0qHT/vCAFXeO3iUTEoBbp8A2?=
 =?us-ascii?Q?4chmOH+NA2sYW+pwT1SXTgJq8oGZwZeJuGh4mmE+FIq+hjphr6pOEDg5B79K?=
 =?us-ascii?Q?HCGIpou3KUhBTvwLOttr6AiFnlMf2oqStIA+l4CAllsc3m/AL+tYgFBIws3J?=
 =?us-ascii?Q?okeRFVJ+9WdDT0c0MmwATY7N2JAnGeqTprFoDwzBmwy2WsWL+vKZ7k0fK54x?=
 =?us-ascii?Q?qRzXNStcwwRPftnMUsSX0hunbo2ec0191qZDennIctZhaI0Czb9ikpBWauZQ?=
 =?us-ascii?Q?IK7Vgcr0EZn03UuIu73ryIvFULW1OG1q8cG5UK2SPjfv4clrLKV1hfhyu/dS?=
 =?us-ascii?Q?Y4vxQjdqzzyG5+YpcRa8VJm32uRo5687oVhCsofLmuuH+dzuOkSjet9ch2gt?=
 =?us-ascii?Q?lNOT12PRdwtq6jtx7fIbSTS11fqIK7NkxRFpqDRPcR2D583CylkiWxqV88ey?=
 =?us-ascii?Q?K8amFz1VgXwlk40udXmX5A5QzgnsF+/8PctH/XR6A/gNcYc4xsZ4UvMUkWaK?=
 =?us-ascii?Q?YR4EPlOimqpe7FETvTTGkHHZ7RCq7cyyuALFNWwdgcLFiNlvl/hALRb+H2O1?=
 =?us-ascii?Q?J0oKZOhh7v2vpJRTphRDX6vlo32ygwQ4gQoDMJ/XnaqeDjEC+8lLbEBz44sN?=
 =?us-ascii?Q?VJQbrKsfU8gWsUZnsx3sFa7eue1BKh+LKLn0NXzNv7RoOYuRmGCl1+jqF2c4?=
 =?us-ascii?Q?SYtHgTIcYPvOsKqknUEhSPiaoU2+WI4lq1Zg761w6hDm14nRD6H5zQOWYCcv?=
 =?us-ascii?Q?DkanDwhH4SJzVv0/aTaMRMtfUtm9CbiNffNz8Wl+Ag/1yG7Qaim/07ZjyxdK?=
 =?us-ascii?Q?Bwv8pqTY9mTGIGZck95oDckEQR0uG7qiegG7SdFxiXIc2oJ/6JxllK7QFGi2?=
 =?us-ascii?Q?BW7lzo+akRBz09EP864iTRl1e+Dn8eDb6GznJNN6pk/jrARWf/t+nkO90m9h?=
 =?us-ascii?Q?wB1IRHlmUbyq2c3A0r8tQ3N1X+lhR8+WYNftSaeWKtpuKmgLeFidV2DPyI/B?=
 =?us-ascii?Q?Nb5DUsrP1Jc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VbcCzghInB4YAfqiRYKTeX+87kgSEiJ8buHIeS727qodVSVpfEQnlkQG9+Co?=
 =?us-ascii?Q?sV3IFwnQpjbK6zU69UH+VvBjIA/M4PKwbtxjqv1GHUG1EFlUSSCILB6h3xK3?=
 =?us-ascii?Q?1xszFpE02XmuEPv1KNCRzvumLdx+tHXZZ4OD9Pw7La3Wcm9QPbGVSwAwL6if?=
 =?us-ascii?Q?2r4kTCrZE6wVP8sz65SUAlMPYNa6r37hvy07ssKOLFiFUwYBLPRFfebgde/8?=
 =?us-ascii?Q?S/6DavRd0J9JarN37/pv+ptwL442PR9elxM152b0zfWheaI+sFsQ7TKXqqvx?=
 =?us-ascii?Q?VsMvViudEzPubGOp/dFCgCO34qBnIcPjVdy/E65SlxOWlEI/KBjsupBZYDsE?=
 =?us-ascii?Q?a3fG4g8kDzLpMDDXQ0D2FfwvP3lzVgqAks3n+9+kv3U4zJ2g18XFiNwhGH5l?=
 =?us-ascii?Q?AozgtTypzv0hRsGi67S0+q/WwtMK0zBYA+0j7/NIX+e/PJONLmbp9Pilkuj2?=
 =?us-ascii?Q?qd2xBCOPGunP8nzkrFNcHQeutPq7J0XjDRy3vWkg1TGN+4Eo/QgeimUD7bep?=
 =?us-ascii?Q?5bfTpIymJUNgiaQsAe3GCYYogQ8sek31zXMTCF52plrqrbdqDq4DEJrpsfx7?=
 =?us-ascii?Q?0x9YEhQGLOxSaGJ7JZ5AmyuI92XgO1MoeICZeG1gg1LiSRm4LeiKjzVynlxG?=
 =?us-ascii?Q?Qipr+C7UQX5nhGjXZrgeed/n2K9uk+vdONS8v7KtVT+iLO1AK+dbKgadg6Vw?=
 =?us-ascii?Q?X3HyLhbz4tmcYCK5BecZar6x3Wxb+2+vCe7E3EybIKl5x1tAoVs+HVZs0VD3?=
 =?us-ascii?Q?K//wGNdwizQOF2zx3NZEDcTswvs0ED7MCcj0vf2V7IuSv/GWzgIVwgEXmR71?=
 =?us-ascii?Q?0QI8KqeRjA2A6M1c0EdK8Sx542rFCMXED0aeOFwYotrG8vI8kHTYtkyugeFr?=
 =?us-ascii?Q?uVul6w9IH4b4Y1f8wYSg0yp1867vAbWlcWFKGD9VMNne7cY0Iw0bVq0+P+T3?=
 =?us-ascii?Q?2+pzzIMRA7gFYrJDMt74k11nhM67SEMxd9XjNUBiLjj661847cXWwqnfrqnn?=
 =?us-ascii?Q?he4WvU1YMfE9t0UgpgElcKtGCIbNqU6xXS73l5aJqkuUglx8c1dxuzRU4M1H?=
 =?us-ascii?Q?EcVVQDd9JUQNEgN6YQMKH9Z1fYQzs0hKvF661mM/w1czZGzFmAdDmoUWPbq+?=
 =?us-ascii?Q?z78ikE5IYghP2ExyLj/iHhGmiHhfHQ4a4qKmsZ9YeJfByX9ekr9h7cg3u9fk?=
 =?us-ascii?Q?zmmgLQf1Ibu401CM+cQHCrcIGcriv347WgVfBh/SWR6OIoyfSsKWuyyyk7Hh?=
 =?us-ascii?Q?xZGCCIcwfrYUB1C4g+KIXSS2ViXxure0n3g783Ud5ZD5p2sMaFATlds0wrHk?=
 =?us-ascii?Q?vK2a280NxYvcUPsko4DeEezlBeaOlo3bTzPux/kiPXGvZAJx3J/1gouukmY3?=
 =?us-ascii?Q?nvCqFi9Xa3kQ0N3SrnIrCZ93wRHU6IUZSQiQibEPkH2Q0QQ61rMFtZj8PpEW?=
 =?us-ascii?Q?uv3RVi0nZ1rIeG+v0f9kN0yDRIa6X9pylNwEcTh4BSTTkJc1H5vNPS59QHRd?=
 =?us-ascii?Q?Mi7qRw/SVMjJFza4KvrKgyfVHqt05a+YSyHvj8RCa2sm5eduFbnWSqOW7st4?=
 =?us-ascii?Q?6Umbdc9bxhk4buW2n/eg1yLru4fPgKZx3Y7yJTWjNhg6YLxliBZEjYXVIAXQ?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00615111-dbf1-4b86-a72f-08dddbad8221
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:40:41.7540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C2h7yIrwV1mKdh/2WHihCx4BKrOQjnSiwFC4zogJhe+PGfH9X6jcfh+29iafr2J5k0kFToaE1aK7umbzxFMedS85HNnfbe9yOeuLIARLxrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7695
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

Linux kernel will fail to boot due to exceeding timeout trying to
probe I3C device.

Increasing the watchdog timeout 30 seconds will give enough time for
Linux to probe the I3C device and will be able to boot up successfully.

User is expected to fine tune the watchdog timeout for the complete
boot in production.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 configs/socfpga_agilex5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index b373201dbaa..846c18eed27 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -15,6 +15,7 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x9ff00000
 CONFIG_SPL_BSS_MAX_SIZE=0x100000
 CONFIG_SYS_LOAD_ADDR=0x82000000
+CONFIG_WATCHDOG_TIMEOUT_MSECS=30000
 CONFIG_TARGET_SOCFPGA_AGILEX5_SOCDK=y
 CONFIG_IDENT_STRING="socfpga_agilex5"
 CONFIG_SPL_FS_FAT=y
-- 
2.35.3

