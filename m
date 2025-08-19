Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262CBCA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:18:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66808802C1;
	Tue, 19 Aug 2025 06:17:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="uMIWAlni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB72F80422; Tue, 19 Aug 2025 06:17:57 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA5E8006D
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:17:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+TeF9DX78JX54flWzeO0Uc+jk/bgmvGtavhhwbG3AGgP9GuaW7FvWOVv6tD2DJ8OMNWL2PpjLeyZQh1TPXUeYnP/Qjtb/PzYF6+bU10t3c69G1m8Dt/zE2UxcN5aDmxQ6lK5TZzuV+n9KvaBPVCWLDmCB3cMlZji4xQETSVkWVch2pnY/xV6tTftsJAYqHc9kmMI+yKuUYA4+52h/Koe4JPinf0jG9yrNuSKjQ/0nr063wmlK+9WAHurQfpgQaoAnFlhUtn9B/BTiIIHiwZk78K+iJ/9WK9aBJ1G18rPsU33o2YhEWnGjyg8swfD9k0bEyatOVgL3Ix9Y14imrJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qL6nparLb8FLGr/QoYPv+fXhjkbOeYvbrtkYh8AJuA=;
 b=JIHL2PvpaQBzmLOjVsMmNDG2yuzaB4jrrZRPb2xG5DJg6s2Mr2dqLplvoTb3SgG0sFF/ugXYOTyMK0Xe9b+WVEygjnzuIrjPQbbQX0tFhb7LTQCrJ8PxvffrgQiJL1vlrw0H87GMSIQaEA1Z7+E8/Bw2pQXaHCZYYTp9XwxD9R8+kI/eZi1lhchPcSXjlAkoHLrn8RQZQmlSqLzcRV2C5MtYhs3NdZWSAnUGIdVnZ+QqkGSRBTDK3hGc/2JzmbsrxEK6ez+uhFxQ3pzruAqD+nDYWjtvQAEB/LzvaZe7xoeGujz0Hr6rQJyKZ8kahIgwvdJjeuQB3yKGDQ+Ebv+/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qL6nparLb8FLGr/QoYPv+fXhjkbOeYvbrtkYh8AJuA=;
 b=uMIWAlnig11+28G6hTV/RcR9vBNlBub8Kp5/RHwyCi21TZgzKkvd+XOXi4n6Td5uPRx8EBLjfXIlqUi9Spe0a463tNZXHuYcG5byVTQ198iFpEPiVl58jQWcVvv+EpQW9kgcrmxtyaslmFTRaHEjF/QW53x6RtQO7sDuXz+dCBoF7NCxRjLycjm51nycTYrrlH4kg/V2fzgOTSTL9qlEKcIqgYtI9tjMDugB1IIW3cxOWErTPdasZawOBelOcZMgmMBQ8JiqoD8S7+MYZI75T+poaJYfR6KcFfG//AQC4PBMaz2CpQ4i4Ylt8nz6BlntcVoomlSv4fxqJ5iMhJ/puA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by MW4PR03MB6948.namprd03.prod.outlook.com (2603:10b6:303:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 04:17:53 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:17:52 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arch: arm: dts: stratix10: Add NAND IP to base dtsi
Date: Mon, 18 Aug 2025 21:17:44 -0700
Message-Id: <20250819041744.23537-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0333.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::8) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|MW4PR03MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6113ed69-dc70-4002-9e33-08ddded75d74
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?D1vZkqBN9/TqtRjEeZEe+as2lsJyB95vpnfTE6FP/XJeoFFbUNaJb8tvrdNd?=
 =?us-ascii?Q?tuulY3lkj4bgNwzKfxlGJJUK7vDencRB7x2bg+4EfmDhdYVoJAepc4I5msMa?=
 =?us-ascii?Q?jbN3+2+DQmlmcNXO8BqjtevZD0b+jkcdpOk1ApLaRSoGvHt9+B/GI4d8R6bE?=
 =?us-ascii?Q?BqKZTLO6eN6pUKQWbBPSakzQ0e3Q34W/5G9xfCazprlsaFRrNwdQYxej6txf?=
 =?us-ascii?Q?9ynn1pfyaPv32EDGFchKn41k82S8w20KfSNEZIoTWVRasWPAbFzDfzCqa/dm?=
 =?us-ascii?Q?uBZfLPe39WXn8ZuQJAzvbsX+0eW1NSjQUjjEkoGUHtvyKiLxNO65zscJif2A?=
 =?us-ascii?Q?erXh5yEbTVGoYket8xXK5cAh9H9I1Kpyjcq2lO4t3fGIrfkjYtrVNpgU16x5?=
 =?us-ascii?Q?H92PKd9X40wpScwFf2HXSiaT6JkWrmAGUueCCjoqRB3FjPFVwfIGzPzAO8TG?=
 =?us-ascii?Q?ssbYvdVkP9fBkSlhlQn1DJALAK/HafJpWMCkx2HAShgHiVpKN7uXpzQlF5bG?=
 =?us-ascii?Q?Vw6PIdbYjXc8JYtwcOS8x/ZBaUp4uwtEDLImZ2BKAfOUwPOmjxndjj0sBC/u?=
 =?us-ascii?Q?lOnAaVmTQeMG2kjGGQsUIMT/cDW3bPHiknMTUWtHjLU/r9ibFR1N4MJoIC2j?=
 =?us-ascii?Q?Cd5YSHnRjqFmE9pQ6E2zbRUmuon20zl3nK2s0z5QNirCV8KF2+FQbrmkCv8j?=
 =?us-ascii?Q?JCtw072c4uB6wHPls2x4fVXN3g5xA4CsKhGEsHW5Afol9dJ3AQyOkr75g7FU?=
 =?us-ascii?Q?v+Mk3iMFLs9rbmrM6owFVH5E7g4v0MRRDWoPVg6KB8f9avmfdkzv8R/jK3w+?=
 =?us-ascii?Q?6TtL4Afn0webE90jtIDNSY06QfHVoxeG5B1mBp8HH+qb2amA6g0GdKOv3T2/?=
 =?us-ascii?Q?KzUeZpAyXj+2m1lsj8wdGE+cSfY1xC27rurBcJhnKJ6F1kIczTrM1nfeDCkd?=
 =?us-ascii?Q?ApnE871RwWRjm2SJNrFJDnHo89ZfwrPtYjG2evPqVMzW/b8EOGnjbVBvrW7n?=
 =?us-ascii?Q?2aAhVwCksD71MrAky/O644jOQmt49muaWgYRjJxQ5Yk/V/IGAtBYiCCAAnvr?=
 =?us-ascii?Q?UbGTJLSXC41FRzap+wdw0ZEBeY0ZhI6TTBx3lKtirW2o/HkxEIjZrZLAeUZ1?=
 =?us-ascii?Q?ijH1up3gGoAXQ013+W5vZ4UDGh8v4G2MGu6oYIZrw3Y/kpVYeN3nn2n6cPOC?=
 =?us-ascii?Q?V+fz1+hfHiH0h166JjNVPn8ha+0AdfEOC9+w9v5cAjivGrjZrpltiY7Iapcm?=
 =?us-ascii?Q?TLRPt6ZkeFnMRJ4jDz6es38zJZTcSF5ldltEP8iGVicPEhhzGc5YMn2EXdJk?=
 =?us-ascii?Q?ILy11Cxr2YKiraN7ZkWVus0rwwdO/GIIYpP6TIgusQuKBFVz/F9ikVKLKfyY?=
 =?us-ascii?Q?WTUmp6du6oLnTjPKXVQrEohMP1UZvLrcITfG/8T1v3MdoojHzji6aMK2r5Tw?=
 =?us-ascii?Q?IQ+WZ/ADeFE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BoOvHfJl2IrGBsoF1Hhv4q8jUgz4woLGSD2a0OBgZRKlu98azHxrMKl7I6pY?=
 =?us-ascii?Q?qFnBuHElnF+u9ev29Mqeiy9B1/qY0MlO70kIxREo56cR+nH5j5x9hpp971TE?=
 =?us-ascii?Q?GbJYlFiFtYzbC7Qh7oLNGeSAISR83gowLagvvaYJ17KSVKBH4WEnS63rPzDi?=
 =?us-ascii?Q?szIH87ddEzcFspVVQp5osjWjN4A+/U1iaJGFPlMPNRsBzhRoGI5goBmA3vzc?=
 =?us-ascii?Q?xu+ToApVi4zSZ7iqJABrCPvteHBUI31GCLwob4CRC0HAC8Q/fpSm2P+BCmiW?=
 =?us-ascii?Q?if6bdRHBEj6Mqtx5zBV8RKJZdjWWCgHXFwy5UpU3hg55Mbys+q0xrLYm5+d9?=
 =?us-ascii?Q?FhDMQpbRKv4zmeEKxRLfSyMPQea9+sP0aua3tj2ifSAlWXKlZ/+Rkxu6FNK3?=
 =?us-ascii?Q?ueActlYOh3vjxalr3lRjoIXjEPD7P7Dke0I+OwJDz5mgIbcXM6kxvSo8cevd?=
 =?us-ascii?Q?WczRfdoOMOtL5EgqIiTNVnjMnCgHt5be8uhr8dpy82hWul3sxeoXJtkqcfdR?=
 =?us-ascii?Q?G+56gpAUUa8uuvMUl1la41JQQrf1nzTc+jiCTZ2fRV2z6brvAKmsvCpFgTvX?=
 =?us-ascii?Q?c2qNCMdRT7Jyg3S1LLVv2SWMskKTpHtwmkVE2G3L21HU2lowE+GdZQekCxC6?=
 =?us-ascii?Q?OEvdlYmJ9PfZbEy5mQphM7Ux2ToJZKPTt5pwzQGex7oRhiJlLxoYmr2QOzeT?=
 =?us-ascii?Q?V1AXUpExJOnMsLFVNBqaRjkwOrgas2HqrieDbANNKtGDfctc+p5nGjxTGMq+?=
 =?us-ascii?Q?GPhRWoCttn18hg2n7JrWSItN5fMBvqlHJ4W3likdlbWWtStwBznPW77pMqtm?=
 =?us-ascii?Q?0Ol0IqdB560BlWz8Yt1NBBbMA+vSnZDc8oCGlfYMrCdwOMFiMiC95uynUdWZ?=
 =?us-ascii?Q?ZcUFsVvgJc0FZjP1gWHtHmTIvOkfcA4iJ42iYdUXyrnFjaey+qkg6vDEBvfs?=
 =?us-ascii?Q?BbHlVQep0eGXF4uJqMHXZOeQMCj2PkA1PYKNFd1tXdh2AFbzTq4DbhwnlVhJ?=
 =?us-ascii?Q?B0jkzQaOXb/spPXaeSG45LeD+XDxIkPkeI5DqdwUs808REsaWKRh+dhYv8BW?=
 =?us-ascii?Q?x5HjqLcmt0yomzUGCqMMicds5fFjdiqCg/Pva8wAUq8t43IVz5ghd9f1etxd?=
 =?us-ascii?Q?Oul9Wyluycqo+9xN4gCkiwnDJ/y0tKX4z1CT18WIUedqKMBAP3ARAEFhK9pg?=
 =?us-ascii?Q?cqesMQ5HI+HHTtlK7jiWTDXp4TRjE8nppIYciDtpUOziwuQjWyCBSIKhoELm?=
 =?us-ascii?Q?qlH/F1rINNLtfF2Ad/qibmbi33I03c1RRT95ThKtrIRmrzjxEZNNxchnzKSP?=
 =?us-ascii?Q?UpYt/NcKeN9A8TOBKlQYXoOsdiANDshCovbTagOhG8q2MANck+kgDTxWVb53?=
 =?us-ascii?Q?KdbK1z4fb3tmZKmvCx56fhpreVvqimZKpaa7q5IOwbw5Qrq0p88+W5bm3+En?=
 =?us-ascii?Q?Y2HdCLfkAGyM3m9O7z23+7TpYi+VhD0d9h97JW3/0xKHYZpokQ24i3gKi0bj?=
 =?us-ascii?Q?D1wrLfUBgGQJRrjlGGvJJanlhtDbp5Y/OMDUo2n9vwdkvyt5pVUddg0PT2Fn?=
 =?us-ascii?Q?jOVxXav0npo4rJudKsAsV+a6qfcgOzfMhhT9/Jysa7b+PxhxnAHgF491p/zc?=
 =?us-ascii?Q?tnl+zOq1lcgoWJq3omPrPKo=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6113ed69-dc70-4002-9e33-08ddded75d74
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:17:52.5807 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UnFFyfx4q5pqAKg6LxZ3+SATmvcio+P+bSZdRsLTgMIAXclZCmsIY027icRhZe0K1sveczzpYZ8zyBGaLQyHShq4ved+CZPoBkjsWgWp+82wXXT5QYXUQm69eOXtzVsA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6948
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

Add NAND node to the base stratix10 dtsi file.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_stratix10.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_stratix10.dtsi b/arch/arm/dts/socfpga_stratix10.dtsi
index eb82d663204..750b43d30c0 100644
--- a/arch/arm/dts/socfpga_stratix10.dtsi
+++ b/arch/arm/dts/socfpga_stratix10.dtsi
@@ -1,6 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 /dts-v1/;
@@ -232,6 +233,18 @@
 			status = "disabled";
 		};
 
+		nand: nand@ffb90000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "altr,socfpga-denali-nand";
+			reg = <0xffb90000 0x10000>,
+			      <0xffb80000 0x1000>;
+			reg-names = "nand_data", "denali_reg";
+			interrupts = <0 97 4>;
+			resets = <&rst NAND_RESET>, <&rst NAND_OCP_RESET>;
+			status = "disabled";
+		};
+
 		ocram: sram@ffe00000 {
 			compatible = "mmio-sram";
 			reg = <0xffe00000 0x100000>;
-- 
2.35.3

