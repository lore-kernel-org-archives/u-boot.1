Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46314E7BD88
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EB5E83AA9;
	Mon, 16 Feb 2026 11:28:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B7WKqcge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 404AE83DE4; Mon, 16 Feb 2026 11:28:19 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E61AA802C1
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:28:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1gNb30z1ZHHM71bBz24/XSm6WQrSKp6DBvAD9AzeoIKvIiMpc9g3IHG+/av3PP4x+ehSfsl7g18niib7cxgb5924w6QsP2naaejInRQfz/oItwLQ3MaHloW8P8Qju5QZ006jcjDasC+rzVv3WhItijVHL57bnOEQdjljhiyUzV7HJnhtv49htK9FKLCcNfEVkJHyPEtzGvd40lSHDg1gyjn9caXwFM+/BgWGUFI8yFfq3iG09ZkJAoTP9Z9Ba9OgDKmdVyYZMH3HAgQg0rWKvi1TDTLCOJZOT4AWUiuzqWKpvqVE057A1psjTIVr6iiAofZp1HE3GpBFqxYGppASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AX1LoLebCLXL5CDthyFmtBZCEDx616MecjoBz8owmw=;
 b=XUeeEMNeztfP0l8fVaoPI4nerBoMl1zrQSXrKFk46bGZCUOLuRGL8g46Vbfl5R4tNL1UM0lXwHRH1mUS0DEJOdimptOB1eg8OxUseU+pT/n5Jujz4Y7EP/jcDmZgdIXZe4lt1O3uox1Qi3VrB3DLMACBRdTLYND9J0PTIbQGARW6m+3zpZzdUOijAMevLPbc0S2J9CCMC7giPHU06z6BZsqi7ux+wNN37L89S3smvKTg9XZg+6P0wp4+EmOhKuv0qXmLc9Jmy5g0TSnk0OaHj/NhI46lO+CUyHbG0gvPezmYFmI0fiF+46Z6KdDuVSPxhLHLQWqIIlI/TLqKofgBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AX1LoLebCLXL5CDthyFmtBZCEDx616MecjoBz8owmw=;
 b=B7WKqcgez0VGfxoNuwzRkFNU3QsVEDvbLIZ2Kr+5lAJrrI1UQYYxh1idxay+mi49KzzjMH0s3IQ2Db3jtyhXn6TDtKPI2mgNEHwrbHb6AyrhAklQCGV4fDepayH8qKehLAyVdrJoVbkiEm4aedPdPyavDdM5ouOyQECHfFD0B6k=
Received: from CH2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:610:4f::18)
 by IA1PR10MB7198.namprd10.prod.outlook.com (2603:10b6:208:3f3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:28:14 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::20) by CH2PR18CA0008.outlook.office365.com
 (2603:10b6:610:4f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:28:14 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:13 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:13 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:28:13 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHh1147835;
 Mon, 16 Feb 2026 04:28:09 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 08/10] configs: j742s2_evm_r5_defconfig: Disable PCIe boot
 configs
Date: Mon, 16 Feb 2026 15:58:36 +0530
Message-ID: <20260216102858.2745657-9-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA1PR10MB7198:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d52f419-9796-4f08-f81e-08de6d461771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pC9eN5pamL9fvpAbNAiMEc4iEWuo1zNxl9RCDmbItLOX3iWo8H8ds7FLjqM5?=
 =?us-ascii?Q?/o+Cyrg8Fznf87/b/1qbdn4fbX0WHAJBkES/nD0a5PaYdovqx2erAxAckaG7?=
 =?us-ascii?Q?Puar1FdxClXzTAyyZCpmHvQEEWkK95xODzgHc5sjfarEBwgX5p1EjwUa62B6?=
 =?us-ascii?Q?l0MoEdXG4TxjQHrsjNf0BZg33puDSLdbuu6hXaLbzi+5sRSXFiPczccqfDq3?=
 =?us-ascii?Q?i0VKNKeHP2mLAkryPHAH137GxN5dfpFltieBlv/faXIK5U9zAEOQVuhPjYJE?=
 =?us-ascii?Q?AvinAfKo5u9vkbwEoRCUwTBe5QYJ0vD1O600c8HJX9kGWYAiRgkHV86+m83C?=
 =?us-ascii?Q?vL+w4AE2p2CxKLxSHMeD35sB0FzPJvnNcXXhTIJ8vjMLMV+760GJIhyMM2Sf?=
 =?us-ascii?Q?QdrolBgYyN9ypITbzBrzSrn6sfOW+ZAOmW/+q2toxLMgIXpj72nffjuCK+FZ?=
 =?us-ascii?Q?ol8/lKXYXbcTGXv1h9tECWd5uRVn4oLqPm86U8Mm1kvgWDxYZ2euDLBb/E3a?=
 =?us-ascii?Q?EvFX6bfMnKcXsCogbtuifxsDRi30/VSZziSNvQf9byQrQRmzgtGBrW6D9l7Z?=
 =?us-ascii?Q?kgmfVyBcomCufCTArqWssPkj81P0KRVRWtdjdgs9PbFPq+bu5ak8yAdXrOgg?=
 =?us-ascii?Q?e8/21jJIJukDoJKx7yZl+K3b4X4YKCA1meYePlxOjTd5y5SUNWvqLBa9RDIX?=
 =?us-ascii?Q?LSZjPheFbMPICP07F2wlLw1gyiZKd0UUFljv5+C4IYrA5+73gY6R2i+VcbDV?=
 =?us-ascii?Q?vEu1lPWt+ret9DUsXUORxr/MBJlP1bAJ06V5ES94AzicwA/W40eJktpLEVaK?=
 =?us-ascii?Q?+cqaGqKM0k9uaHcr1HUG/hzaao6LjhIgYkHIODfpnUGVOFSa7omi1ilGY/0p?=
 =?us-ascii?Q?IPhfmIGGcxUJSsnQS/RaxWiLvPRpCFh29+j/lIUr2DOcpbv9M8ZXe6spr9sL?=
 =?us-ascii?Q?qdZEerNqwyiDfADMj6ANq1R10/AWPHYB2MAmxJHsrqpIl0oc863td8oXzpKW?=
 =?us-ascii?Q?4uoXpOucdaBA9ukHFWUNCSj/ma9SxPJkEMRJAHLXmLBnfi/f5LEe7Dwt+DVL?=
 =?us-ascii?Q?s5XBZEBMvTuv3u28MEognDQZ9+oRiSOXNMusXym/tH3/forESxKRXPrpTRD+?=
 =?us-ascii?Q?0xkovz5JsKuOTr/Gy7KP54VE8/XgAbiZ8tXjjrsUiqudD8QCDpZzmDaR2Jqr?=
 =?us-ascii?Q?jH2Kz6bwRgRW9mTJaQKgJxkmYGrCLBU28ly7O6Lc3SDbzDCOj+Oza94iuQ4g?=
 =?us-ascii?Q?EkVVGupvt+yZloTTGzSZfYo2h7caO/wucTWvOkNOlV4Zwv/TAxriNTv4tfrA?=
 =?us-ascii?Q?Hgby/G+WmfI4NGB6nRs2uDtqVKwIcXW0onhDMmMGVveNpkwuiOvRUSrPyqYy?=
 =?us-ascii?Q?tcrrAQlxKmxn3Z1HB7kN/w9oNEkXcjv0N+EPRMa30fOb3d8rF0igUrbcaeN4?=
 =?us-ascii?Q?SzFxOV0WP/ArJwNAUxP6LLpb1GFErW6igqwJAfsYqThS/GAz4vPYrMdxEehD?=
 =?us-ascii?Q?B9uN0XnpD4Xu3NTkNKpu2t9Vk0lT75RxcijaVEKueoCMn9TZjXYGiN3ivCbG?=
 =?us-ascii?Q?2xRn0Ui1wXn+DJx+TaVgD4TcUzEFLxFc0XoqjjXFGOTYziWoKJZZXO7g6QMs?=
 =?us-ascii?Q?kJAg/TemNvNj5WnjbRp79Qr2hAioRyZ8xxWAB1KD0iFCotJhXhq8yDllaSk8?=
 =?us-ascii?Q?jTEd3w=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 49/BoCJzWxQD0VHColqGdFPkZln+9EMTgqbJ+Y/XFRfD5s08RE2AsWTEA20lrblN9L/OH3rVb/sY+OG1aGF4dmuub65e84ADjjaBjejmsB1jvUqNlj9EqNIjDlhfPip0OEFsVUG8o7b8Tf5J4ILMQ0LcBYUG0SouGqH1xZZfzqFhnHG7Auw2T0XC477t1WomzJiG7BMkp0dpl0PujOOdCzqGwS9OnhNXiTrSMr226eMwOTCDSn8S18W3Y13+P8ovtcaI9WwKAxcrnPZZfo2t8jFwfrpQBULhbKmgrsTOqofQmQE48FX5XELL67M495s6RPgZAPjdZQe/0FhTiUfMku7Qwb0RiXeS4shNGZE9tyrQk9kCZIhYhbAs1vWKEMrM+yJ7VqaiOB101z1k+epMM78up0/oioTkwkEiwPOFLdgFsaY5UQ3GKEy8vWQ54ne6
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:28:14.0660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d52f419-9796-4f08-f81e-08de6d461771
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7198
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

From: Hrushikesh Salunke <h-salunke@ti.com>

Although the J742S2 EVM supports PCIe boot in Hardware, since it is not
enabled yet in Software, disable PCIe boot related configurations that are
not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/j742s2_evm_r5_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/j742s2_evm_r5_defconfig b/configs/j742s2_evm_r5_defconfig
index 2be6318df76..036954b4085 100644
--- a/configs/j742s2_evm_r5_defconfig
+++ b/configs/j742s2_evm_r5_defconfig
@@ -5,5 +5,11 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J742S2_R5_EVM=y
 
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
+CONFIG_MULTIPLEXER=n
+CONFIG_SPL_MUX_MMIO=n
+CONFIG_SPL_PHY=n
+
 CONFIG_DEFAULT_DEVICE_TREE="k3-j742s2-r5-evm"
 CONFIG_SPL_OF_LIST="k3-j742s2-r5-evm"
-- 
2.51.1

