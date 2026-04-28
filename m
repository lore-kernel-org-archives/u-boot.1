Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADA4FF885D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E17A84690;
	Tue, 28 Apr 2026 09:38:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tF2m119t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88ED283BC4; Tue, 28 Apr 2026 09:00:43 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6570C83A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 09:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebSS7nAm4+9x05vRw2RRg88N/vKWaV1JX+ChEtP9BTBqaRf5sj6Eb019uRPq497lQJvNbs5TbzzqeyUj6RnXYZsmJR5UIHzueyE/A6qokgPqPB2cc64HF93A9/1co0/2KY1GW9CYLZkQsbHDS6i9nCmrooFQm8XnuwlkKaNX4R5ag9EWSOaedsWx1wnOug2haTspaDPP//n1hcsCP0MkJFvs/4mfrrk3rm0dCxhABhwFIiWMcGn/SxwzKHQpazqVSd9/Qib5dYO/CFjdAro/QDzyUaXIQnBeCsRCbXg9v7qtwhOVyLbihhKUKLUErfe12oL12VadYe+H+rsmwnBigg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=nnQmqZ47hbnO1QAhm+IYD4iEQHTzguCXzhFb4tnY6Ja5Yq2Oo9FT8flNkx0FsgHzUS0ZoeAW/6YrI19a81Wvxdd8XscTQca/YlZe6217DyXpLiHJX7Bdp+DUxLk1E3IpGwCjlYaWx34gDwUeOzcKsom56Mth5R1voPN1Jx2BNZlSEFzCixUkSquWe/nxN7P9SlQ4uju7dBCZ9gTFTKsLeEV1MSeqZQS4715CxqeIVXv8pQmJjRZxzUjJ9l4rFu4BdDSAIrQYIX3pUmGRJ0ZpdlXYB7aS3tYnO1c2MR+73AZte5/CqcgcLxZ/HNqCE0ZuynRrlbif+qqs/+0r1/8hCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gZD2GN3wctLfo2NSx78kUpJVqCnwGmi2r9IWR66gGU=;
 b=tF2m119tOmfiZJjyz82UW6KqkUeCZtLhHdv33fwE0Eshhz42IsYiwq7GeBfSPbgMiP/bc2M85azrzxSIcXk5DVJ1TfKNF/6Z0j4B6pgkyGamZXdJ2iOxJP0VBHaaTTOMO+7XDavqqaJk+GWEA6j+d3nmz5MceWzFGDwzGf2Wb93rEgMGXxo5nhPn6qnOhKVttv6uVHFaUK4ZG6F/M2pL3GP7WAtMU1szRwcldHpn0BQsH739wbGcUY6qzDGFiU9YOywiZpMqTg+CDIhE9UsSfNK/js4WDN7R+pH6ejv1jj5WkaYmefzq4IqnjI0YcvZ9bfd4fWom/lQa5IIfsz9sIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 07:00:38 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 07:00:38 +0000
From: Chen Huei Lok <chen.huei.lok@altera.com>
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: [PATCH v2 2/8] arm: dts: socfpga: n5x: enable DT register settings
 and update GMAC nodes
Date: Tue, 28 Apr 2026 15:00:11 +0800
Message-ID: <20260428070017.16807-3-chen.huei.lok@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260428070017.16807-1-chen.huei.lok@altera.com>
References: <20260428070017.16807-1-chen.huei.lok@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0083.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::24) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|MW5PR03MB6960:EE_
X-MS-Office365-Filtering-Correlation-Id: bd59f3d9-00f8-4028-3e6f-08dea4f3da16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003|55112099003;
X-Microsoft-Antispam-Message-Info: Wm61Wt7VkM8S8LA5NY7HqVkImcm0a1hGRMZP4qbtueFZHwwEV16pUviP+OQou9iLhPRtzE9deAjgcQ6VzJvIzLe+BTurC7MB/0icuO9opst7Nz97j6Q3ebPsk7rc3oXQWF9J4XVvSbQSU7W5WZaLp22n1yA8asRoV12goT+hFzgEnpXfi+Bxw7s7l0CjVosIR/VH5Yvc3rPS0w9g3kf93POmVpoR+3vRFYVeEXgG8JhXP7NME00hpAZ/EXSLGSYLk0Mj5eZmoIYda59GGwrbgVqa3z/2GqKS8sLywJ0EUQRK8XZIvjX49o+mez2QmjOCVNDAhu22Ce5hkBqy+TDtClISYLcyaOAcCfyZZdOZHeB5G6GHSXd4U4kYdL6s7LHUBnBqqQy1dORvTTVw+T78Vl8fWiD96ZqfwqA7zCYUQR3rslHRvG8mk8C/UnTfsMKnTj+Kwc8tJ4ucR9VAGTYT1WDnbsnb4cai1C3PCdlVCg9WrQixagDd5hGmK6qyGMc3eyqbI6gcLBD52jhcaOGAhE/aMe9nFFJAxYa6Ac8Z49WffBN+P64tRfkaP7GHJ9R1F71u9V3k0tWWerhZQzXPOkrp3PbMTuGQdnhbq7ffSRZuy8uYdSj7VEailCxtsrocEj4hlEIHrg80WPFEPDoB/XJJpbSlIJKi01ZaKdDS1eobe4N4ZqjW+bpc3oMVfWd8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sjgroOEASqueHngbUag2op2rIMDhLH5Pz1QSGaPT9gUt2TsiCVd/1SD/hZFr?=
 =?us-ascii?Q?mHGAqZcW/VKcbUaoCbGa3kwgayCCZ210jzMjLEaGTiw6fef23PV2we6Lhzmx?=
 =?us-ascii?Q?TRiwDhFZ3WtT/qo7JsrGaL91l45GA1whaiP/xJCj5a5W07plGDMQ/xu5IuH8?=
 =?us-ascii?Q?smkIIkzCW+cWG95GfTfRMZvCDBDmu8fc/oaJSM/bONAtNHJJ1UrvWq7icMtQ?=
 =?us-ascii?Q?Ko2fsqbnpg3vs4drA0jV1yLlshTF5ZvSAbRc43tHAeoviFLmThJruRA3WEWc?=
 =?us-ascii?Q?0bV1n9AOJzFyYorYE1M+GNJBaJaCriOYei9FgihwZGYkf7qETffvG/mHtwi0?=
 =?us-ascii?Q?tg2UXuvzY1z0wLf7lEqAyYcFAmn+MNpBFdeRNHZrQL4yHdAny8HuKMReRIYL?=
 =?us-ascii?Q?M8bj0PHpe2CIVsNBplkekpBvo+AWr3rFE1A9PXIGtKVeg9QT8vcORJf7FXOi?=
 =?us-ascii?Q?hUqz/uxxUSwKei/hdRCGXQhXKedaiuvdKMn0h46MMqff0noVpZVRxGLvFNG4?=
 =?us-ascii?Q?N698b0RbR+CI5/jywJCpbw3bnN3KW7SKCHjSpFA08J9X65IN4wIzFp8OKxYJ?=
 =?us-ascii?Q?ygO0cwLXXuKa6YGMEwvbUoXBCRW+TVo4kpDOnuOtBB20zmija2D605cqxkBz?=
 =?us-ascii?Q?9vnndP9yqpNEmeeMU0HB9/mJ/mSIe9uNnUIs528PYJ5oe+kT/GwE0X/azh1l?=
 =?us-ascii?Q?DjClqUC7/r7kCIn0itf/zeypaBzMtDFskHxvfcihN5mq5H+aU6WYslsS5u4s?=
 =?us-ascii?Q?dxWZV3VCfV9tfpzxrGER0kv/Axl5wOY28GzAoHOjDyfhh0a/R+3NjZuHON24?=
 =?us-ascii?Q?GKjBk8sCB3wMmdcZg6cwMQl9dHrxrHcTTkhBW5/1m1lUEiF9aIGD5ttDSA67?=
 =?us-ascii?Q?hxH2YbB2vEHYkw2zUWe+71iKJBc4FCVURgVG3iRjt6e/BiXU/CEgvfS/xiB/?=
 =?us-ascii?Q?QBJbnsOpZgitKiANLBT2eWEx8IxYiGEyyU2KOf670KygGhAh1pVZqciDjEOJ?=
 =?us-ascii?Q?Vl1jy0j3e/s6KQ5sbHH1ebcGP1CAXYANyHbkuujMOFSTtP0396buQnJ4r+AA?=
 =?us-ascii?Q?Brz5s2+Boh5DmVwPw+uBRJOTA7flphq02M5cL+EsV0ec+x8A+uCG/Kmxq2+y?=
 =?us-ascii?Q?ThbPZDuV33RlbyQhEosf8mqOgLFQClPewE9sEVe3Kg+0DwqXnab1wBHZBhSx?=
 =?us-ascii?Q?kMrAcNFf3A0q07/iAtq+U7/b0drsOXJ6reF1RYa1G9OC/JC0FP+XQk5YhDpJ?=
 =?us-ascii?Q?AtU9886Gmh4ro9FET7dKCQlLnj5MlkoQ2+YdhCk6i2zT80gOQWwFKGZMPBLU?=
 =?us-ascii?Q?pIiARus2ZiEls5WPW3O702yaU5zB0aad+sfgYlctnRUEa1na+rPsyltNrkXT?=
 =?us-ascii?Q?EMAsifCEG+B+lvBbRjAAtJRFtPfbb9GwpKqVQpuGNr3C41as2h76bAicTOu2?=
 =?us-ascii?Q?OzJFAFW/FudiM5Y3TdWv6LZY7RmcJ/0vmINPHVNPcvLzESl+laXwYRWa+AAN?=
 =?us-ascii?Q?b+jCGcyPPg97tODR/cy5Nhjx4fyO+K6feXsS2loDGU8yjQCqFTkRiuNQuSbn?=
 =?us-ascii?Q?tgTo99y5olBw8MFBAOGFpVzwN2fYI5N+Dbcf+l8GM96/7RMLMKDzJPRK6q76?=
 =?us-ascii?Q?qsPBFtilgD8H2By841+b1uXUPWGiKjdD6O3f75OcYnAO6pYW5smztFLkfYUY?=
 =?us-ascii?Q?/6QFrToG3654oVj3x2uWa42iyisVS1UhA8rmYQIdRFV0q5kSbLgGndoAh8g+?=
 =?us-ascii?Q?iDwJ54Qe/sNe5WmbWtglvYQJtGGb7Y8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd59f3d9-00f8-4028-3e6f-08dea4f3da16
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 07:00:37.9406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QZJKPFBbhPUJ8HwGz5J22ertaEuhcqTrefrvFhv2SRcSjFKPsa+qFoX0mMYd5gfacDrAYC5GOQHSYihOVlqdjmH1RxAiZ8B8OJ/8V3+irg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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

Enable register settings in the N5X U-Boot device tree by adding
firewall configuration nodes under the L3 interconnect firewall.
These settings disable OCRAM security at the CCU and relax MPFE
firewall restrictions required during early boot.

Update the GMAC nodes to include proper compatible,
reset-names, and clock-names properties, explicitly setting
their status.

Remove the clocks property from the QSPI node in
socfpga_n5x_socdk-u-boot.dtsi. The QSPI controller clock is obtained
via cm_get_qspi_controller_clk_hz(), so the device tree clock
reference is unnecessary.

Additionally, include socfpga_soc64_u-boot.dtsi and rename the
soc node to soc@0 in socfpga_n5x-u-boot.dtsi to align with
the common SoCFPGA DT layout.

Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
---
 arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 38 +++++++++++++++++++++-
 arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi |  5 +++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/socfpga_n5x-u-boot.dtsi b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
index e27a64651e1..dbfd2abfd59 100644
--- a/arch/arm/dts/socfpga_n5x-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x-u-boot.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2020-2021 Intel Corporation <www.intel.com>
  */
 
+#include "socfpga_soc64_u-boot.dtsi"
 #include "socfpga_soc64_fit-u-boot.dtsi"
 #include <dt-bindings/clock/n5x-clock.h>
 
@@ -15,7 +16,7 @@
 		bootph-all;
 	};
 
-	soc {
+	soc@0 {
 		bootph-all;
 
 		ccu: cache-controller@f7000000 {
@@ -46,17 +47,29 @@
 };
 
 &gmac0 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	clocks = <&clkmgr N5X_EMAC0_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac1 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x48 0>;
 	clocks = <&clkmgr N5X_EMAC1_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &gmac2 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.74a", "snps,dwmac";
+	reset-names = "stmmaceth", "stmmaceth-ocp";
 	altr,sysmgr-syscon = <&sysmgr 0x4c 0>;
 	clocks = <&clkmgr N5X_EMAC2_CLK>;
+	clock-names = "stmmaceth";
+	status = "disabled";
 };
 
 &i2c0 {
@@ -132,6 +145,29 @@
 	clocks = <&clkmgr N5X_L4_MAIN_CLK>;
 };
 
+&socfpga_l3interconnect_firewall {
+	ocram-firewall@f7100200 {
+		reg = <0xf7100200 0x00000014>;
+		intel,offset-settings =
+			/* Disable ocram security at CCU for non secure access */
+			<0x00000004 0x8000ffff 0xe007ffff>,
+			<0x00000008 0x8000ffff 0xe007ffff>,
+			<0x0000000c 0x8000ffff 0xe007ffff>,
+			<0x00000010 0x8000ffff 0xe007ffff>;
+		bootph-all;
+	};
+
+	mpfe-firewall@f8020000 {
+		reg = <0xf8020000 0x0000001c>;
+		intel,offset-settings =
+			/* Disable MPFE firewall for SMMU */
+			<0x00000000 0x00010101 0x00010101>,
+			/* Disable MPFE firewall for HMC adapter */
+			<0x00000004 0x00000001 0x00010101>;
+		bootph-all;
+	};
+};
+
 &sysmgr {
 	compatible = "altr,sys-mgr", "syscon";
 	bootph-all;
diff --git a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
index 840537c9d0b..1f7e31bcae3 100644
--- a/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi
@@ -44,6 +44,10 @@
 	bootph-all;
 };
 
+&gmac0 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -55,6 +59,7 @@
 };
 
 &qspi {
+	/delete-property/ clocks;
 	status = "okay";
 };
 
-- 
2.43.7

