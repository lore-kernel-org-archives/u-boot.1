Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36D5EC54F30
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 20:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 083B283666;
	Sat, 24 May 2025 22:38:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="rSEyqWbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3F0B83689; Sat, 24 May 2025 22:38:03 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C899383043
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 22:38:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o73eEgy0XdUgA0W7/dL/jnbL40kli0eCAl20phliqA3t74JJBS0wI3ZcrlEzrIRrF0OABbMRBOobArV5kOL9PIT0IiQwokMKqr3D4PUHuy0hntnaeKeKujPdj5RsHmLWQVRhiRGSDmgFJicDr2iSzizWovZxms3gDzvWdJ2zlK7yk9QPH5QVdJV+pMM4P27UnwxDemQDNH5YTRKGvojxv6jy+u3n1VZGN14/pzX2Z+S+lU2PbaJsiGjL+JeFgMIWd+er28CfCah9TIm46mYJUyMo4Gy9XrJAQHkbzsrq+EDlh/Jgmm+iG6vq/dRD+vKbRYXAi3cPUha6di185ex10w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExAAA2wPMZlmMQRBY2/M8QcTWt1APE5dOZa8L294TlM=;
 b=hRpO5DirbY2bglRUo/UDpucrjPS6Hmd4Fz8YYPn2XM6gHkpksI7yXwExia9bll08dZN5aPQ0qB9+Wac5Cv5kkVuZMwV4NBTpL7HrHybOzq9P4G13mbOv2N6q4uHCFV2L0vasKSvDTjDG0ujBji9bj2TKD6iUykScnHfBlTJqM7FZpLVHWtv1e4oJROR7Pd92NvNFRumRDksjH7HwTwLtGKt/xyGUlwuzoOYyXQE7B5QpK2h+/KTetGfXwDM+qHP8qjgoKimXYcBRumzTdJw1x+7iVbHRQwJkrjoFpt1ewWELOGUYEb1J1Eyt/fZ8NiZLtiBaA7zCaM/eR6NP8NzLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExAAA2wPMZlmMQRBY2/M8QcTWt1APE5dOZa8L294TlM=;
 b=rSEyqWbdXuLZCyxVSIo6QcIYptwaOw92l5QBE6KbHDxKgKWKPE6T9vIEHkk0CEcJmwLCTV/9PJCrAAJyJHpyV1YaU3rWn5pVb3M/psJ+RIvxYAdF4FCu2NpQUF97LBagldatREy8ssbiYfhy0smAMRVJ2V8FU6yS9EjLel47POuVeU3Xza+jrODoUUTA96D0vmi8YTt6Cc+U9t9vynY+2BMsT95e6mNSqeHSIobOnKL9fnOB/OkLEBbWtyCsVurvA29aczCyX2Bji+SzFX79P6oFpPw4CXDue557bwQTTwqXha/h+MAiwrfk8Gnt8I3m+DflFbI/lgk4bx4spqOaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from BYAPR03MB4646.namprd03.prod.outlook.com (2603:10b6:a03:133::26)
 by SA1PR03MB7100.namprd03.prod.outlook.com (2603:10b6:806:339::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Sat, 24 May
 2025 20:37:59 +0000
Received: from BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce]) by BYAPR03MB4646.namprd03.prod.outlook.com
 ([fe80::8919:e2df:10df:51ce%4]) with mapi id 15.20.8722.027; Sat, 24 May 2025
 20:37:59 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v2 4/5] arch: arm: dts: Correct alias name for Altera SoCs
Date: Sat, 24 May 2025 13:37:36 -0700
Message-Id: <20250524203737.20541-5-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
References: <20250524203737.20541-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0148.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::33) To BYAPR03MB4646.namprd03.prod.outlook.com
 (2603:10b6:a03:133::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB4646:EE_|SA1PR03MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c21134-a2fa-4367-d3f7-08dd9b02def8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?th1rNkW4ve7qaL5+sO8Dq9x0+1IUxeXBXC6CliAEsjDpVQufh33op1VAqemU?=
 =?us-ascii?Q?J9JiAT4lOOO0JmbUYMOMrAzQL9eBR0irJAizz18Wc39PJuJzZTpPlfS2Qe9K?=
 =?us-ascii?Q?9E74pd8dW+EX+5hzqLLys/ELBY1vsTept5w19OnOG9xeKpgLknA9/d+SKc0T?=
 =?us-ascii?Q?G9PJyMfn+yB4N9fzO6pbdk3g3hX9sAKb1nXRrXqo3YhuwcXDsfUebkohcGFO?=
 =?us-ascii?Q?3YVaeRdAsBegO+I+I6N9/E9oK9vz8FbsmOliOI4tZOVHc4Gcg4y6d1vIvDaj?=
 =?us-ascii?Q?4/RJS28bsUcpi9Sin0TEEvDlBYorq+IBnx1jw63mdPIjeUpFsIn4YUc6N0Vo?=
 =?us-ascii?Q?s0Uc0taVndxzF/a59TJbU2eTFBDO/cAFRqZye6bJ6dUKJlhnEe/axmfSURJt?=
 =?us-ascii?Q?ezWxNYXvnTJufE+IOftqPda18mBt9Xu+C2Wnhhgzbs7bNIzitTcsQVvM46WF?=
 =?us-ascii?Q?GcLp0P9r5ywhMHoIKudRZmS3KmMUE+TWbzl185F1VU64VnIgDZAYWVk4lqxi?=
 =?us-ascii?Q?gx4HKyUsSNu4tZokZKQzAG/FDK9pAREJ+GQNefR+DBPVhwvMlGLbbqL4oTdp?=
 =?us-ascii?Q?f65Bmx2884DbDHx8c8v/pSXeAKmMtH/KdlIEVhVxvKD6QGXcYu++2YJ8BGL0?=
 =?us-ascii?Q?IPRdhtpQi6BEd4LPohgzARcA1nnIcGZ1PAqYQRzZ+HsLMrvAWQ/tEFvkiA3m?=
 =?us-ascii?Q?WPKyY66HleQ2vaePOOipbwiXbb827fyJ0ySKjuT0UJlhiTFE66PSJdrED/3d?=
 =?us-ascii?Q?NsrCG3h3zEC9gODkaUpujap5z50bs6hWgMM7IfZIiQ1epk7H/NmuOvAm3AHy?=
 =?us-ascii?Q?kjqVPWXaCDvAhGFOUQhtrgbsTgbUBrT6SNBLZxnXRXo+GQViNpBQYsISKDKn?=
 =?us-ascii?Q?gdCsJZVFw8T0RFskBVXhESLkB7irO041g0dgW6GkWYtzpD4P+HR/H4lwxHUK?=
 =?us-ascii?Q?6cRRWbr+vCY+V8zitQ3CumzllkonuhlRHh2K0SJLy7YTjlRiYkjaz4W2kurF?=
 =?us-ascii?Q?/KI6VYTIJIhhso9EfhW6JlT+4CT67Zxhidt3DkYNr+Vlyvcr6ZHcFutmTq1q?=
 =?us-ascii?Q?mR8X1Popl0ehKQYBZ85YoZjzPSSR/2p5zjGXSi5sg0JBm3QYpbzLk36I1WiC?=
 =?us-ascii?Q?3j+CbR51kw8Yw+vB/RBcInAMqFgmCf0LMKZQWMQ6szh0Bx4WkaXQ0KQxzSyB?=
 =?us-ascii?Q?d02U3ThCw6Fc9L/W5oRpdZIPhUfz/j//+LPtI9cwOzW58XrpsuIWA+3fevxX?=
 =?us-ascii?Q?8MHWKu7LE1ydGMlr3zIexNXYl4VUPvNkxEAFKVzrutq+2RCUKB9mN35aM+H7?=
 =?us-ascii?Q?4Nw10+f1CmpfG6RPgwJPkTRYDf8qxwf3xll8t9cH8tNvfMX0Mo7JZXV/Be/L?=
 =?us-ascii?Q?X3+BShQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR03MB4646.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GLbV2zFQDNXIVRTO8H5EdAaeUF7vZKwi3gC1XyzeXtXmwpO74b4d8GyqI58/?=
 =?us-ascii?Q?028fGfLbP35naK4ejikxI6bZmnw7GSFIakkNx7XsAstkDsfrAJGvpzSebexw?=
 =?us-ascii?Q?l/nHT83Nb94k6s7k1eJdcTr6oHgHnCdYnn9YdU5fQ5vU60F3a0zQ3jGmLbL2?=
 =?us-ascii?Q?5DDgAJm0W98KSs0wnCgz6ScOCiukDiPrMRQdTH7f4KCX6z2ilnqeX6jo5dFc?=
 =?us-ascii?Q?a+Z93hXWoRNS1LvDiAai7I4GnZyNiSTWvzEaekQBufDvHoniAko7jQXhuB+0?=
 =?us-ascii?Q?MhtPh9DNI8iPX6nZx5XzruIdEngxKIh1pyxUDOym11OoV19XIt6y317Z4Z6P?=
 =?us-ascii?Q?x8ra/XlHyXQTTUZLooQEJNp/eBMlGdB5QQwTtE9z9FIY8l4M7xKwwMzTjzSG?=
 =?us-ascii?Q?AsnP3/Q62PuIV1bBkOT9JwhEr077gaAK4MsM0LEHOuVKTJhfMkcIVH+8Fsw1?=
 =?us-ascii?Q?pPWE1W7iMBNtkmFu9sLlsLnak7dcroX83tfA+lDj8UIVNfkJqeHnsqDV44QX?=
 =?us-ascii?Q?ln32C0N85/vuRd0fkY+84Tzf+FcnfL6UnROIYNbEzGHI9CZ5m1JnjiGokTBe?=
 =?us-ascii?Q?yavq+GsVi0Deos+ubfR7f0V+5SkBA9j2oXGV/LNVAlHp78PbAsiwhIx4B/ks?=
 =?us-ascii?Q?Uy+ZgU5VTVybpJE++CM1MnL/iy+P+VpAeTAwLDm7ZPVAZUc28G32RQntwjP5?=
 =?us-ascii?Q?scmkAOnd3pqmWe6ZdWAdtDHVCxJJ56c1oOTpCggdXGUJiCBNVt+diGxijfhF?=
 =?us-ascii?Q?ViOHcvJyJCQpPkdBXUgSfqzdAU0tXTz7eirecJynqHlpkADlr8RIhvlGuhli?=
 =?us-ascii?Q?gmL6+TucLRpenuEcafPUQH75UHFaCgHnCp2vtDam/MsKkSGRlhaad/X+BcZG?=
 =?us-ascii?Q?7Jjiusv0z+poC+vQFNtkgmlj220yJpQKSWRrKKEipp5aJ3XSy9aGEtyI6P8v?=
 =?us-ascii?Q?OSGk/+f/8MYYHedf0votqk74yLy1iyD8Z/eA9xjc6/jJk4u5kY6M0AqifvBQ?=
 =?us-ascii?Q?ev6eVnX+1BZlBOAlHpXFtL0yKoG8x1H7Vc0vKiGj6QsouCi4SoeclukueL91?=
 =?us-ascii?Q?xLtVFoAPAArGzyhJspG0tKFJ0haOC7uamRkFRXYPA6K9hqNPxrrrO3xVm/Mm?=
 =?us-ascii?Q?1RDk3Nm63kRsHSnGxr+2K75W9WvoT40ZmRuhLlzSyvN0icsLd07/Q/lwtGXv?=
 =?us-ascii?Q?zHMKzjFKyZGkFZL8075+VJ6hNL+Q3EfPnYF440J5Po++hx64BiuTWOiTWCPL?=
 =?us-ascii?Q?cmoPdxJulfOsgb4/M0f6Z7X266yMJ8kU/auDICkJu0bpsOm2r6JVqFAZLTkv?=
 =?us-ascii?Q?1rg5D8FuN8Tun+1jFfBdOFJqP2QwatP01s6kySplPJyUvviPKuq2ctZ+bS9y?=
 =?us-ascii?Q?6FzOtfeem0IT31eIqfByd6wyhENA4lTpV8l/ZKN3j34TY3yRPqxdKOfq4Fil?=
 =?us-ascii?Q?6ePqhMSc4hBsNV3hIPPynfrOxZFAzTenDf8X3ya7H40S3KOyssgpMTkcmMUX?=
 =?us-ascii?Q?NanpjFzF6Dy0JdXiaSH5WWIil466b7lbmCftvBfm7cwL0JQ+bFDzY9TN2Dvh?=
 =?us-ascii?Q?Y/CfkqOYs088vadLGOpBweuLrkaho2uJPMhRiVWtfxyV9e8JV+6BlbZtFfQ1?=
 =?us-ascii?Q?iXPa2QkDMFaTXmx0nDhFm18=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c21134-a2fa-4367-d3f7-08dd9b02def8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4646.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 20:37:59.4792 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoRwqHPbAlK30/GzDvSlXxHd0APfLR7h2YhcIEh+LdE0fa4dGrWw/PAMg+DKNcFzq/LmWylBrd4Hb9H9FFA+U2cbH2WtQ7hZHNBIHoP93JZafpWF9m4NIHlF+sMWQPdM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7100
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

Alias name for freeze_controller is corrected in all Altera SoC FPGA
dts files. The '_' character is corrected to '-' as per device tree
schema standard.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi   | 2 +-
 arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi    | 3 ++-
 arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index 8d7dc0945ab..329dbd25dca 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -11,7 +11,7 @@
 /{
 	aliases {
 		spi0 = &qspi;
-		freeze_br0 = &freeze_controller;
+		freeze-br0 = &freeze_controller;
 	};
 
 	soc {
diff --git a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
index 63df28e8364..51356a3fd41 100644
--- a/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex_socdk-u-boot.dtsi
@@ -3,6 +3,7 @@
  * U-Boot additions
  *
  * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_agilex-u-boot.dtsi"
@@ -11,7 +12,7 @@
 	aliases {
 		spi0 = &qspi;
 		i2c0 = &i2c1;
-		freeze_br0 = &freeze_controller;
+		freeze-br0 = &freeze_controller;
 	};
 
 	soc {
diff --git a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
index ef0df769762..a5b52ba33e4 100644
--- a/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_stratix10_socdk-u-boot.dtsi
@@ -3,6 +3,7 @@
  * U-Boot additions
  *
  * Copyright (C) 2019-2022 Intel Corporation <www.intel.com>
+ * Copyright (C) 2025 Altera Corporation <www.altera.com>
  */
 
 #include "socfpga_stratix10-u-boot.dtsi"
@@ -10,7 +11,7 @@
 /{
 	aliases {
 		spi0 = &qspi;
-		freeze_br0 = &freeze_controller;
+		freeze-br0 = &freeze_controller;
 	};
 
 	soc {
-- 
2.35.3

