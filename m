Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A07EF55454
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 04:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244A983E7A;
	Wed, 25 Feb 2026 05:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="AXeVTqpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6871583E81; Wed, 25 Feb 2026 04:22:08 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72D1C83E7A
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 04:22:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJIa35Ozxt5HgMtQMbhxgFGKba7WPIpqybTmGSftqYDVnhnhRKdA8rs+h/OwcFUotJHZEr+2tvb7IHqopSyyetqSXLCw0J4/qfBOYnKR7bypLPBz4soYUDw3Rs1Iz0ban9edkJMHx11Q3IGpO4THYy5Ogs2A9jBF7uOciWq3yxBzDdq1aPpAYgAjA9FxMbbSCktaY9WGbAseaCUl2EjnPXq0GHell2EHmeoVzk0pNGe1FGpl7U02k7C5rEq7APC2Fh+XCdWSyzG33Qoxww5CUGbQomc19KcxRyPj+TQD9coyZ1qNi1mRWzFg+7xn2GePZ3KONDsUwdIvh1KQz8qf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L2tK0W8BfYM38OKknPAooPjPiV7S53xNmwWEpw+m1o=;
 b=IosjeGvKNlZRZgrdj8fBFz6QX5E4bx9PHwalmSMstRJXHSDn8MUEk/2Y6hblUodXchupBGxxz7krcA0uFW4nT1XPpH/WqfvWYOhqT2UpaikfefHgR63Znrsuu5kfTe73i4u3xfDFm6I1G5AR3QYQCgE8yVYAe8qm2xSdiGI8wYumpQ7irOCpvwpWD3mGV/2Vf+Tiuy5FAf6v4y5RPFvu74TolmDFbAEQ+MeC/mwICIfOYgi+GnJm/8x79wHF45pQyJMXeYpU2hrCJqSZwoZGSEM/1eFTY1TT8IqqwkQdUZZwXgn06fDpd7CufFawY3eT0vghYDB0kyFPxLzgPMPCAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L2tK0W8BfYM38OKknPAooPjPiV7S53xNmwWEpw+m1o=;
 b=AXeVTqpQmHs8agsbbXGGa1Az34T2HybsGru/yGYIgbKmOoStD9S/NdczbYU6G3R95+9s/cdeCGMtK/SfWGHlgUwjCJE/xHc+ZpvZ1cKM6VeHRkXvRFLALhKIQPupJ0pG7y7LRGG1Vg0zSXgRgUqpfUXA4hisrNaXIWC2+MSihA7ptX2aVqcN6SCsDYSsryH6n2seJQPkakKbVX5G1s4KhQ+fBSoJVVFMuXO0Z6DKKEi/cuIKp9dMLcjGozPQQIVwLGBW2bbnAw142XBSvQjxiyUwQmQAJb2OicLpi+27BvwANrEaobWgG/AX7v9uVJYAE5oIraC097irVCOUDkbG/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by IA1PR03MB8360.namprd03.prod.outlook.com (2603:10b6:208:5ae::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 03:22:04 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9632.010; Wed, 25 Feb 2026
 03:22:04 +0000
From: Boon Khai Ng <boon.khai.ng@altera.com>
To: U-boot Openlist <u-boot@lists.denx.de>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>, Tom Rini <trini@konsulko.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Lok Chen Huei <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v1 2/2] arch: arm: dts: socfpga: Update system manager core
 registers masking bits
Date: Wed, 25 Feb 2026 11:21:49 +0800
Message-ID: <20260225032149.1342-2-boon.khai.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260225032149.1342-1-boon.khai.ng@altera.com>
References: <20260225032149.1342-1-boon.khai.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::42) To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|IA1PR03MB8360:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a900fd-100f-4a3d-b43f-08de741d0bf8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CQMsli4ZErUyuf/AUrXX/PI+U4hL2Wvd81b8T5xONS+cRLeHwMKZp+Vj5Y+8?=
 =?us-ascii?Q?cGgAnou/CodJjAbIbnRupL6vNr4olMhfBy2mSRMZZV93IqOsna+HGvKp7E3U?=
 =?us-ascii?Q?ZkLWpr3ZfphsBfXLuZKP75P/gn6C4hb9R24sdX39Z7jHCuyxIV/pCBpycH00?=
 =?us-ascii?Q?Vly20YURo4xsKaCyE3abJBwEK9EdS4uWR2zt7tM37AdpwmBONLYWKz45y2tn?=
 =?us-ascii?Q?m22Xv8a960dQXDNXlVyUFVmtwp1/Al+GvPEYlot9DSSqfm9yK0XVBsV3B8Uj?=
 =?us-ascii?Q?Rj30HcsnqB+vlEIg0eyqp92wBIsiE5metBJR2mSTxsWfmZ31Pfzki8lJs+jZ?=
 =?us-ascii?Q?SYqV9pbe6EoUfSeoCcl6c8qH5/pWGw0f+t2iyopwnZj9tRzUG3e6gVVByE5z?=
 =?us-ascii?Q?M3Z8nWGFVISr26080s2Q0DYcr0+YUXlrELVtelt1Wnn+pG5VJO+dRK09CSP3?=
 =?us-ascii?Q?Ik124/tu+X6kJob3lIjyRSB2EE7sguPMZOl4J9RA07XgcFD4xymKiPxh0JFM?=
 =?us-ascii?Q?vqahSlf1/q3UhIAh1b7OpLBoQ8MFF4BVI6eEObuDtVW6ISnj22qzCfVpNMoZ?=
 =?us-ascii?Q?T/FXmoCWs149dP07knslnrFsExAhC1z8A0uBebl3T8o69qNyRRrNxflXTrk4?=
 =?us-ascii?Q?/39YRTY3BDosUbA9nG0bvH64Ga8zlp5ucc3/nNdCn4MPXY3x39RdyH5PU1x4?=
 =?us-ascii?Q?BHgi/MIWnBXPOWoIs2/iNX7NjD2fkz2SYKcKdEotKiH+J54l3y4S+am3jZVc?=
 =?us-ascii?Q?dcvnrm8XlAJAaLZJTgEe9qShltrJJV8BMPu2CcOhPs/dzj32s3st2+6qH/Ts?=
 =?us-ascii?Q?xgYPQWqE+ir65FxIgM9qSh0MpwXqVdMZSd0jDDxOz9s+u4/Z9T+BUrKKD375?=
 =?us-ascii?Q?4INn+yHIOfss3ZuDq4pgD+HBPMi1veuJ6LsaWrZAwZkWqlmpYNkWut54umxn?=
 =?us-ascii?Q?FIzdZjwxt3CSGpQgCa3uLxB+XbwwpkmBq543TLITj4hM38P+9B228e4UyiFs?=
 =?us-ascii?Q?NYUgnX0lDw4iOBMUPTvGr/lcwMfMBKbgARMmXztmQHC7LdTCkh30I85hWjMP?=
 =?us-ascii?Q?3y1Iy9y+VVv4meWmEnViHG5emQRBZiTWhr1F9hsyBvJ2M7OtO8xzQ/mUJwCC?=
 =?us-ascii?Q?lpx36qW1eiSBzjvhOIYRGbe+fkHQImwUTXteogaq/jKK44kaBFKZBm6j6Xqr?=
 =?us-ascii?Q?Mm05mRB9AQQfzmp9APXSOMuTIwHN04Ebrhz/eZfgF/OaYQjTMY+NG9f0fBEz?=
 =?us-ascii?Q?PUd9CdD8EGCzZiaF98Qgwj9pHmVDTPGmYuUoVlnw/TDH/qLM86W+gFmDRvCK?=
 =?us-ascii?Q?yn7jdF+BXh9NUSPnUP3r9G6El73wXF5AH/D8wQODC/nGGFOwQQ1hRISYAavP?=
 =?us-ascii?Q?q0iztA8ZXWNOWdi3mfOU+4rS5q0/JcqJo9FgrtaX77J+5ESzzT03Cn1N72nG?=
 =?us-ascii?Q?uaWU7mpWrK8KkElyaR+5dNNq0quASMmOdxZxw/5/Sgjj9NUaaRoMxAR/Qjvi?=
 =?us-ascii?Q?QBMAKDtYIA72xKBUyc0ZbOnUIQY6ljj7bf7jhs/ANDplYPPaufyEunlzgP2a?=
 =?us-ascii?Q?3cWNNXYuHvhimYG+fK4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6hcaa0mRewxm1n4RLV/f5Aft6uottqW96a70GX1QxjFT1+5rpoTlNEbb0jOg?=
 =?us-ascii?Q?w4RPfyz8IuLKYopTkXgoDDgwU1guTkT9b0q894NvoYcMFATzhYoK1ViOrt+Q?=
 =?us-ascii?Q?I/L7YrKPR3aXVscmSR8yzxsfgO0vNrhNL1JWMTJr8ac1oQFbQsSez3TXe8bL?=
 =?us-ascii?Q?A/n96hwplwqkhmjqyKT5NcJhkNOajbXIbotOGCiRIDdxKmFFkylH2fsc7ody?=
 =?us-ascii?Q?eGeQsewiqvvODTr6+lXcIDPyqjeKkB6mn+0sFxtpUe1oinwwN7a6OcYQmyXq?=
 =?us-ascii?Q?SfGjsEYHu8k2Yl412HzvBCiguFjXPq3meXCKx0+oD9jDRgTyBUaQCq1JZ9AI?=
 =?us-ascii?Q?kD6PTKRXYF5M3ZZB9/oKeu3irX7o9AN3ZwpBEQuOFHW3cMbj0KUrBEqseM48?=
 =?us-ascii?Q?v2wOOj3AGVsKXJGg7fiQ3yzvgg5Xxr8upe84C3riCTu5Un7GKd2TeZpLALDT?=
 =?us-ascii?Q?w/0KP9rBsnHvW+AeAph2BqcweuE38IvNVkBe76tOeo5EETgkxyXvGb2+4Hh5?=
 =?us-ascii?Q?LEJm6zTirbf65jl3FtKRBRoz330b7OxtKZD/eignWSUBzahtukkO72+/4wLH?=
 =?us-ascii?Q?IcdPiOdM4K+ypBj/izQLlbkhhYl2U5LvdKhH25O1R1ABfPcyo3eBx1c7KqhU?=
 =?us-ascii?Q?BHutF6IIennluI/WNKosv0BIcqz/Fj/NWQFjd+0d7WUInKcgqBiFEIkwOaeP?=
 =?us-ascii?Q?ZOUFvQvwFh7UvxSnLJ94PAfKI28mHlDBvtDDRPcPOnMpN95ua+ppEujLd9fy?=
 =?us-ascii?Q?Sh56l4JFjpfZVqj6scVrMn0AJ0BuWczUFr1Xf2rr9K1P+dZg8UIwVaUhurBu?=
 =?us-ascii?Q?5qR43iu06nkUFMS0b00fbW06za+hIQsbGfL7F/S/vdFqYNxtZs5ApyljPhkI?=
 =?us-ascii?Q?3h8lA9rm624eBcHvu+0y92I2mZ2c0DptA/ad8ttJEcsR5tcKIpX8Vj/gXLNe?=
 =?us-ascii?Q?3ujTvIN5qJxNnt6i+uIB5SR9FJRAT2RRmmxRWPJacF3H3no4u9aZHQ0GRjn8?=
 =?us-ascii?Q?VhP3XCgYqGAPlBvcoWn1sNenR5hQfKnaOdo0Fc6CQubZK9THPUO7coDn6FkG?=
 =?us-ascii?Q?3wcFzQrKlTHlJexFV0p+vdKkmbutNULCij21byo2wJJ0zk9bln1+dEKHzRjd?=
 =?us-ascii?Q?/40pqXihwciZC0xV2fo/N8ynMm63ojZNNW45qC0A4B1YnacQ7DIS86KW4dbz?=
 =?us-ascii?Q?EdIbkxPv6NwTzXvYszIWSfGwKIauaWVz40N7FkX5YAcPn+cr/ztmAG1U7dmO?=
 =?us-ascii?Q?/ShQ4jKSs5pvqWVT/RUVLpJE8T2r4acwFxTrTxoE+Sf2KD4d5pH0AAf1UeS8?=
 =?us-ascii?Q?FLfmZc/+6fdYH0wrtxw300Ljf0Xp4l+i4Cz3pTGc5xwBTplHf/qwy6NX6iB+?=
 =?us-ascii?Q?suC46YEa69CKWbLR/OCsp+uUiJ+umO2zO8puZf2twlqCkVqElYKEaAbAAnUo?=
 =?us-ascii?Q?JlZB8fxpMNHjQLL8yYio378xyOgyh+3zC0PHawlNZdPqGfwVu5N4EfAo1Zmy?=
 =?us-ascii?Q?y4WKhzGJ83ncRPb68bB++0z5mZB5HBscVPOplhEbDlt1H04iJkw2YFFy/R7b?=
 =?us-ascii?Q?RtrJ0LvJhFKs/ji37Rq2XDEc2bnZqdyMvIddxIIEpbYt9UXpO3pfvIDUCE3K?=
 =?us-ascii?Q?RFMD7oidZF41VP09GpCNn3lDgQZJnlTy5y4HFjVmXtKEg2t3Gb2yEHr9+OUH?=
 =?us-ascii?Q?Hju3egt0HEJkO9HTUZOvdNTlqGd4tNmsxa579asYNGxjJoa0b3EKqeGBejk1?=
 =?us-ascii?Q?tpLT/3uFuw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a900fd-100f-4a3d-b43f-08de741d0bf8
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 03:22:04.0470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8g5AqiqSb1AewDSdvfQDGzHjdL9wkefQfMmrNxuDAXmJuv4IDXu/5EHx2ZcSoXGbpYb5qVhcfHKIYUiyuAMMDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR03MB8360
X-Mailman-Approved-At: Wed, 25 Feb 2026 05:19:00 +0100
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

Using wide masks may modify unintended bits, which could break the system.

Updating the mask values to only modify intended bits set by the value to
fix this.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
---
 arch/arm/dts/socfpga_soc64_u-boot.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/dts/socfpga_soc64_u-boot.dtsi b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
index a6e0b615717..1506ff15447 100644
--- a/arch/arm/dts/socfpga_soc64_u-boot.dtsi
+++ b/arch/arm/dts/socfpga_soc64_u-boot.dtsi
@@ -143,19 +143,19 @@
 				reg = <0xffd12000 0x00000500>;
 				intel,offset-settings =
 					/* i_sys_mgr_core_emac0 */
-					<0x00000044 0x0a000000 0xffff0103>,
+					<0x00000044 0x0a000000 0x0a000000>,
 					/* i_sys_mgr_core_emac1 */
-					<0x00000048 0x0a000000 0xffff0103>,
+					<0x00000048 0x0a000000 0x0a000000>,
 					/* i_sys_mgr_core_emac2 */
-					<0x0000004c 0x0a000000 0xffff0103>,
+					<0x0000004c 0x0a000000 0x0a000000>,
 					/* i_sys_mgr_core_nand_l3master */
-					<0x00000034 0x00220000 0x007733ff>,
+					<0x00000034 0x00220000 0x00220000>,
 					/* i_sys_mgr_core_sdmmc_l3master */
-					<0x0000002c 0x00000020 0x03ff03ff>,
+					<0x0000002c 0x00000020 0x00000020>,
 					/* i_sys_mgr_core_usb0_l3master */
-					<0x00000038 0x00000200 0x03ff30ff>,
+					<0x00000038 0x00000200 0x00000200>,
 					/* i_sys_mgr_core_usb1_l3master */
-					<0x0000003c 0x00000200 0x03ff30ff>;
+					<0x0000003c 0x00000200 0x00000200>;
 				bootph-all;
 			};
 		};
-- 
2.43.7

