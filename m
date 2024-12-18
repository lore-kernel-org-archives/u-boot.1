Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2F0E77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 11:41:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 662EF8021A;
	Wed, 18 Dec 2024 12:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JI32SCNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039AD80239; Wed, 18 Dec 2024 12:41:04 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58D8680214
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 12:41:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8+fZZ/ZxNk/tng5asJynW2mt78+lkZC+bjeGnRjJhOkuZxn5iYDEud7TsWRAUbGQbdNdSeYeHHRqFOkrrDUbMqTXl6akZfyPIvvydBoAAdCPJr+Zv3WClqaAVli2akUdm7Std3Gvn2l8hTlkES8IXfutjBvbFLJ7oSlES5cij1PazHI8NR+Glwe2Dq0Ed57aJE7G18Pr+s/YFUnlyPxZBP6/1Wfm9NI+RgfI/dgV60AuqxpcpDNPVHC45WpuqspmcnNUWfzFjFurnql2U76qVIHyIPqt/rPRrYDLkubYJmzfCb4Pburh2BKeafnJObLCWUkj66T89JVxpWKp05PmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pcqor2jUx1aqUE6Q3G0TmtiH2Nr7tscOjUkP67sFCAo=;
 b=AOVs9m2v1whCdTBYzkWYaAzY751t0BNYR1EoUwzBJwBFRp2A3Mab9ll+EsxT0fDppHjnrg5di/aWuRlAzJcKnUf4FTNOH5IpNCmaCjDr2PICnNaWxekKZLO4C/A6cxwcC1XrqbFDl6y4XTo9P/7kmT1wZ9gSJx26jf7Ty35hzlncc8Lk4Sbqn67JlKWOPG6ad1TzYOkw28b4J1nmrUFWyxcdm5Wd1I4lMyyC16rzniHhKeazuDxJ0orNWSfg56GQ6B0u4KalH+QpPfDpC3vwApD3rnftE7omiaVuZ+umjVWusvb1HMTwmNzj2gxPszzRAbd2PcCRaP4tOoC9LWXzKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pcqor2jUx1aqUE6Q3G0TmtiH2Nr7tscOjUkP67sFCAo=;
 b=JI32SCNM26ZrtUKG+SMEOWl0yBaLPclxYvJEr3YLWsFOeGiErar8AxjApqnH89hMuNck7OLOhL7nIpQZ5bxB8IPATa4Y5LABWNxMfXf7x+7j7UxV8Xzjtz0rIpqxSPveMigsYBo8Jtue3JjehKI8OpnlQFUL7zrqHW8JCsDPH2U=
Received: from MW4PR04CA0317.namprd04.prod.outlook.com (2603:10b6:303:82::22)
 by CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 11:40:56 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::c7) by MW4PR04CA0317.outlook.office365.com
 (2603:10b6:303:82::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 11:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 11:40:55 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Dec
 2024 05:40:52 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Love Kumar <love.kumar@amd.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, John Vicky Vykuntapu
 <johnvicky.vykuntapu@amd.com>, Shubhangi Shrikrushna Mahalle
 <shubhangi.shrikrushna-mahalle@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] zynqmp: Remove usb init initialization for Kria
Date: Wed, 18 Dec 2024 12:40:44 +0100
Message-ID: <96e9c80aeeed4e9664858bf236476997d17a9914.1734522042.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=KYEsPIFTsqF8QbiADJkKk9xjjgyED5wC5CSeLt+33+8=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSkLXsZGZuqpv/bJj/pd6uu4gJ3gcXKMwt+zHnH930Z3
 7kJTy/974hlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATEVzLMFcoo2vpto2d7AVH
 Ym+/L7yfK3CqZxXD/CBZ6cvH+P0zOivvXIvbc/YUr2RqHQA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc2078a-6f8c-4c94-5378-08dd1f58d5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YTVRyagK4mcbLyhD1yDR44TrKc0vaSmuZmc5rwCbG4MCuAWlLcHY4w0HjCda?=
 =?us-ascii?Q?sIaAxppzVfGgAYzz/F7y/VqEqFhhvGtS8W0m8c1Qi6FSB2i6Dah0dlv6IwpP?=
 =?us-ascii?Q?EXHQBrbiCVaZ4vlat/9qIwJSWgLIp6S2wirFenpSMmPGGzg89GDAb2ODgMQa?=
 =?us-ascii?Q?NR/94KHk4lqlVKjcrSk//QTTTK8Tb8bzFwPH2QcofMxBsDF0I4WQ6eihwi/K?=
 =?us-ascii?Q?jwJGue1/kTDu3ySraVHQ2h7Yp1qaCgQSFksscAjrgD7YKv7nCV+MzXADsus8?=
 =?us-ascii?Q?B4bJzjRZ6dSY7rnj8ax78hsykCv39ZCKeXqyc80lbBJzz16cdn3MIomdssHb?=
 =?us-ascii?Q?WKxcQX9wUfeOCg2PWrO1VxD0CVmye+LHA2fKiiVtb6qk2wIf84ePt3hsRa4l?=
 =?us-ascii?Q?UBBOZjnyH7oTZ7ZVALpYYO10t8VnJ812dk0VwS8qZZtAm8isRd/mNYf2waEK?=
 =?us-ascii?Q?IgLweytDvsm+iHnk/gh9Tc1QzHpxQKNj9Ioz1ClfyF8lTW6e2nOkALebuZ8D?=
 =?us-ascii?Q?zKVzexnXWnUa3GX2NSw2MhiSJIeJ2C8v2JpnGmRTcnyXCihIZZZAV19TgIcp?=
 =?us-ascii?Q?872GXl3voBrC3N46o6X1DKe8wFB1QScZXwhSgJTnWEjT5xTLZ3YvC6y0CzZu?=
 =?us-ascii?Q?TOX9ZCHe4MrKtWOs10EUFlu10BDtNhdohKt6y9skDsJpJU5mBDOvaZSNhPPU?=
 =?us-ascii?Q?johuhCH5lNNQU1wA4S6C+RM8M7+e6bP30snV4CsR9PsZJByPxR32LslH9sRj?=
 =?us-ascii?Q?l9oA7ubLscUCaVr1ksoReZfDh+O85Yc0H3C5MPyZYotKNEFmUr1Voi8gNPIc?=
 =?us-ascii?Q?PI/8VBIPsTd7o4rUZLapPuj/b+DX+4GsXmBkmosBkihyOTVTzH4vFkc59lO1?=
 =?us-ascii?Q?+t9BOwB0GUmZRoai5u44ZgvfF2NHnfoUJ8Ns2UyRKbAbOjMPUz5lrfKVpczB?=
 =?us-ascii?Q?/sg+qtrD6H/EeljL3nX6VO8VMmwSxu6R9xfqLT48cG3aHZSmWIi30v+SeBAe?=
 =?us-ascii?Q?Opauf2qnN5ULL8qDpWdBrjk7GqMVxi+ui1w1OoLlmdMfPk+JMNu2019/gGBa?=
 =?us-ascii?Q?d1EN0M1b77MXR+Hm6JMHOntWPqDVEbG1EQZ2pSUrrQ8XaSZQgPLoIICI4Zi5?=
 =?us-ascii?Q?S7Ej5Ui1SZDGa2P0d3K0vd3UNKsV1mYbMXi+8Ny3/qNtFYAAo/paniNJtups?=
 =?us-ascii?Q?rirgfCNuufYjD25sOQr0tbcf5gInzR54oKjqpHRGYU+j8UcovVkCiTEkPNGb?=
 =?us-ascii?Q?PU1fFPbiR1lI1Jfpw10eEadtBOPh+D3QCBAJDBvL7TvsqXI4FY3va1MbJoqG?=
 =?us-ascii?Q?A+d4O7XcAAFMz3RaouhSjK4QHssDcdzJ8nyX6cuNs/t0b8J6+wpJVikuvfSa?=
 =?us-ascii?Q?WmlD2RVqRuRwd/PwpKjfEnfOGboGixKZGI+8xk51qanHCg31EtPPlrRB5b0t?=
 =?us-ascii?Q?v0UvSyt6N0LkgslLBAPbSB1/pzTFmae2G5/XdpVGGRDYxNrJQJWR16Vo//TD?=
 =?us-ascii?Q?MtE/CWNvh5bi3Nw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 11:40:55.6684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc2078a-6f8c-4c94-5378-08dd1f58d5a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
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

USB hub initialization is done by driver introduced by commit 09f557e106ef
("usb: onboard-hub: Add i2c initialization for usb5744 hub") that's why
there is no need to do initialization via variables.

Reported-by: Love Kumar <love.kumar@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/xilinx/zynqmp/zynqmp_kria.env | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
index ff3a0924de7d..b0c2ac6f2e86 100644
--- a/board/xilinx/zynqmp/zynqmp_kria.env
+++ b/board/xilinx/zynqmp/zynqmp_kria.env
@@ -62,14 +62,8 @@ bootmenu_0=eMMC Boot=run som_mmc_boot
 bootmenu_1=SD Boot=run som_cc_boot
 bootmenu_delay=5
 
-usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
-
-# usb hub init
-kv260_setup=i2c dev 1 && run usb_hub_init
-# usb hub init
-kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
-# usb hub init with enabling PM nodes for ...
-kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
+# Enabling PM nodes for uart0 and can0
+kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
 
 tpm_setup=tpm autostart;
 tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
@@ -79,7 +73,7 @@ tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
 board_setup=\
 rtc dev 0; \
 zynqmp mmio_write 0xFFCA0010 0xfff 0; \
-if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
-if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\
+if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
+if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
 if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
 run tpm_setup
-- 
2.43.0

